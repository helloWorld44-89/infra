.#!/usr/bin/env bash
# Deploy all 5 hermes-* SSH keys to Pi-hole hosts (pisrv01, pisrv02)
# Fill in the variables below, then run: bash deploy-pi-ssh-keys.sh

set -euo pipefail

# ===== FILL THESE IN =====
SSH_USER="root"           # your current SSH username on the Pi-hole boxes
SSH_PASS="Baseball44"           # password for SSH_USER
HOST_IPS=("192.168.5.5" "192.168.5.6")      # e.g. ("192.168.5.XX" "192.168.5.YY")
# =========================

KEYS_DIR="$HOME/.ssh"
KEYS=(
  "hermes-infra.pub"
  "hermes-security.pub"
  "hermes-monitoring.pub"
  "hermes-documentation.pub"
  "hermes-coding.pub"
)

if [[ -z "$SSH_USER" || -z "$SSH_PASS" || -z "${HOST_IPS[0]}" || -z "${HOST_IPS[1]}" ]]; then
  echo "ERROR: Fill in SSH_USER, SSH_PASS, and HOST_IPS in the script before running."
  exit 1
fi

if ! command -v sshpass >/dev/null; then
  echo "Installing sshpass..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

for HOST in "${HOST_IPS[@]}"; do
  echo "=== Deploying keys to $SSH_USER@$HOST ==="

  # Copy each public key via ssh-copy-id (uses sshpass for password)
  for KEY in "${KEYS[@]}"; do
    KEY_PATH="$KEYS_DIR/$KEY"
    if [[ ! -f "$KEY_PATH" ]]; then
      echo "  Missing $KEY_PATH — skipping"
      continue
    fi
    echo "  Adding $KEY..."
    sshpass -p "$SSH_PASS" ssh-copy-id -o StrictHostKeyChecking=no -i "$KEY_PATH" "$SSH_USER@$HOST"
  done

  # Create hermes-* users and sudoers on the remote host (run once per host)
  echo "  Creating hermes-* users and sudoers..."
  sshpass -p "$SSH_PASS" ssh -o StrictHostKeyChecking=no "$SSH_USER@$HOST" bash -s <<'REMOTE_EOF'
set -euo pipefail

# Public keys (must match the ones in deploy-hermes-agents.yml)
declare -A PUBKEYS=(
  [hermes-infra]="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKfQefd8YPiP938Un/aseJwCSuppifsbmVv2djk/A6Fm hermes-infra"
  [hermes-security]="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIlReiyhrhKHi41witTK7LUrmJOQX5z1WD3M3vgIf92h hermes-security"
  [hermes-monitoring]="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGRhk/H73wf7kvDL/x5xce2IYO1uHqKXih/y1pEMQtA6 hermes-monitoring"
  [hermes-documentation]="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8g3CSpSoiTlkGIxTGRBXLWcdLxrBr/FbqGOg1IhuN5 hermes-documentation"
  [hermes-coding]="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwbHvBKiKDD8eiWmro3b7pWaq+B6rUubZ1AnmZwi5j9 hermes-coding"
)

declare -A SUDO_CMDS=(
  [hermes-infra]="ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/systemctl, /usr/bin/kubectl, /usr/bin/helm, /usr/bin/ansible-playbook, /usr/sbin/reboot, /usr/bin/journalctl"
  [hermes-security]="ALL=(ALL) NOPASSWD: /usr/bin/journalctl, /bin/cat, /usr/bin/tail, /usr/bin/last, /usr/sbin/ausearch, /usr/sbin/aureport"
  [hermes-monitoring]="ALL=(ALL) NOPASSWD: /usr/bin/docker ps, /usr/bin/docker stats, /usr/bin/free, /usr/bin/df, /usr/bin/top -bn1, /usr/sbin/iotop -bn1"
  [hermes-documentation]="ALL=(ALL) NOPASSWD: /usr/bin/kubectl get, /usr/bin/kubectl describe, /usr/bin/kubectl top"
  [hermes-coding]="ALL=(ALL) NOPASSWD: /usr/local/bin/*, /usr/bin/docker exec, /usr/bin/kubectl apply, /usr/bin/kubectl delete, /usr/bin/helm upgrade, /usr/bin/helm install"
)

for USER in "${!PUBKEYS[@]}"; do
  # Create user if missing
  if ! id "$USER" &>/dev/null; then
    useradd -m -s /bin/bash "$USER"
    echo "Created user $USER"
  fi

  # .ssh dir + authorized_keys
  mkdir -p "/home/$USER/.ssh"
  chmod 700 "/home/$USER/.ssh"
  echo "${PUBKEYS[$USER]}" >> "/home/$USER/.ssh/authorized_keys"
  chmod 600 "/home/$USER/.ssh/authorized_keys"
  chown -R "$USER:$USER" "/home/$USER/.ssh"

  # sudoers drop-in
  echo "$USER ${SUDO_CMDS[$USER]}" > "/etc/sudoers.d/hermes-$USER"
  chmod 440 "/etc/sudoers.d/hermes-$USER"
  visudo -cf "/etc/sudoers.d/hermes-$USER" >/dev/null

  echo "  Configured $USER"
done

# Harden SSH (key-only) — safe to run multiple times
cat > /etc/ssh/sshd_config.d/99-hermes-agent.conf <<'SSH_EOF'
PasswordAuthentication no
PubkeyAuthentication yes
ChallengeResponseAuthentication no
SSH_EOF
systemctl restart ssh
echo "  SSH hardened + restarted"
REMOTE_EOF

  echo "=== Done: $HOST ==="
done

echo "All hosts complete. Test with: ssh -i ~/.ssh/hermes-infra hermes-infra@<pi-ip>"

# Homelab Infrastructure

Personal homelab managed entirely as code across a 3-node Proxmox cluster. Terraform provisions virtual machines; Ansible configures every host from base OS through application deployment.

## Architecture

![Infrastructure Diagram](docs/infrastructure.drawio)
> Open `docs/infrastructure.drawio` in [draw.io](https://app.diagrams.net) to view the interactive diagram.

---

## Stack

| Layer | Technology |
|---|---|
| Hypervisor | Proxmox VE 8.x (3-node cluster) |
| VM Provisioning | Terraform — `bpg/proxmox` provider |
| Configuration Management | Ansible — playbooks + roles |
| Container Orchestration | K3s (lightweight Kubernetes) |
| Container Runtime | Docker + Compose |
| Secrets Management | HashiCorp Vault (Raft storage) |
| Monitoring | Prometheus · Grafana · AlertManager · cAdvisor · node\_exporter |
| DNS | Pi-hole (redundant pair) |
| Persistent Storage | NFS (ConderNAS) — K8s PVCs, backups, media |
| Network Controller | TP-Link Omada |

---

## Repository Structure

```
infra/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── inventory.ini          # All hosts and groups
│   ├── playbooks/
│   │   ├── k8s-master.yml         # K3s bootstrap: master init, worker join, NFS provisioner
│   │   ├── dockerHosts.yml        # Docker host setup + monitoring agents + SMB/NFS mounts
│   │   ├── proxmox.yml            # Proxmox node config: node_exporter, firewall
│   │   ├── prodVault.yml          # Vault install, Raft init, unseal automation
│   │   ├── prodDeb.yml            # Debian monitoring server
│   │   ├── deploy-dev.yml         # Dev environment deployment
│   │   └── templates/
│   │       ├── docker-compose.yml.j2   # Prometheus + Grafana + AlertManager stack
│   │       └── alert-rules.yml         # CPU, memory, disk, instance-down alerts
│   └── roles/
│       ├── common/                # apt cache, base packages
│       ├── docker/                # Docker CE install + daemon config
│       ├── cockpit/               # Web-based server console
│       ├── backups/               # NFS backup mount + templated cron script
│       ├── qemu/                  # QEMU guest agent
│       └── updates/               # Unattended upgrades
└── terraform/
    ├── modules/
    │   ├── ubuntuVM/              # Reusable Ubuntu cloud-image VM (cloud-init, virtio, vlan)
    │   ├── dockerDev-vm/
    │   ├── dockerProd-vm/
    │   └── monitoringServer/
    └── deployments/
        ├── kubernetes/            # K3s master + 3 worker nodes
        ├── dockerDev/             # Dev Docker host
        ├── dockerProd/            # Production Docker hosts
        ├── vault/                 # Vault VM with separate data disk
        ├── Monitoring/            # Monitoring server
        └── keyshift/              # Keyshift app VM
```

---

## Host Inventory

| Hostname | IP | Role |
|---|---|---|
| Balerion | 192.168.5.10 | Proxmox VE node |
| Smaug | 192.168.5.12 | Proxmox VE node |
| toothless | 192.168.5.11 | Proxmox VE node |
| k8s-master | 192.168.5.65 | K3s control plane |
| k8s-node01 | 192.168.5.60 | K3s worker |
| k8s-node02 | 192.168.5.61 | K3s worker |
| k8s-node03 | 192.168.5.62 | K3s worker |
| prod-ubsrv-01 | 192.168.5.40 | Docker production |
| prod-ubsrv-02 | 192.168.5.43 | Docker production |
| prod-ubsrv-03 | 192.168.5.42 | Docker production |
| prod-debsrv | 192.168.5.48 | Monitoring server |
| dev-ubsrv-01 | 192.168.5.45 | Docker dev |
| prod-vault | 192.168.5.35 | HashiCorp Vault |
| pisrv01/02 | 192.168.5.5/6 | Pi-hole DNS (redundant) |
| ConderNAS | 192.168.5.18 | NFS server |
| omada | 192.168.5.233 | Network controller |
| winsrv02 | 192.168.5.26 | Windows Server |

---

## Prerequisites

**Terraform**
```bash
terraform >= 1.5
# Provider: bpg/proxmox ~> 0.66
```

**Ansible**
```bash
ansible >= 2.14
ansible-galaxy collection install -r ansible/requirements.yml
```

Required collections (`ansible/requirements.yml`):
- `community.general`
- `ansible.posix`
- `community.docker`

---

## Usage

### Provision VMs with Terraform

```bash
cd terraform/deployments/<deployment>
terraform init
terraform plan -var-file=../../terraform.tfvars
terraform apply
```

Deployments available: `kubernetes`, `dockerDev`, `dockerProd`, `vault`, `Monitoring`, `keyshift`

### Configure hosts with Ansible

All playbooks run from the `ansible/` directory:

```bash
cd ansible/

# Bootstrap the full K3s cluster (master + workers + NFS provisioner)
# node_token and master_ip are auto-derived and written to group_vars on first run
ansible-playbook playbooks/k8s-master.yml

# Configure Docker production and dev hosts
ansible-playbook playbooks/dockerHosts.yml

# Configure Proxmox nodes (node_exporter, firewall rules)
ansible-playbook playbooks/proxmox.yml

# Install and initialise HashiCorp Vault
ansible-playbook playbooks/prodVault.yml
```

---

## Design Notes

**K3s token bootstrap** — On the first run of `k8s-master.yml`, K3s generates its own join token. The playbook reads it via `slurp`, sets it as a host fact, and writes it to `inventory/group_vars/kubernetes/k3s_vars.yml` on the controller (mode 0600, gitignored). Worker nodes pull the token from master `hostvars` during the same run; subsequent runs load it from group_vars automatically.

**NFS persistent storage** — The `nfs-subdir-external-provisioner` runs inside K3s and mounts the ConderNAS share. Every PVC results in a subdirectory under `/mnt/nfs_share`. The NFS StorageClass is set as default so workloads get persistent storage without explicit `storageClassName`.

**Vault Raft backend** — Vault uses the integrated Raft storage engine on a dedicated virtio1 data disk (separate from the OS disk). `mlock` is enabled via the `CAP_IPC_LOCK` capability to prevent secrets from being swapped to disk. Init keys are written to `/root/vault-init.json` (mode 0600) and should be moved off the server immediately.

**Modular Terraform** — All VMs are provisioned from a single `ubuntuVM` module using Ubuntu Noble cloud images via `proxmox_virtual_environment_download_file`. The module supports an optional `data_disk_size` variable for VMs that need a second virtio disk (Vault uses this).

**Monitoring coverage** — Every host runs `node_exporter` (port 9100). Docker hosts additionally run `cAdvisor` for container metrics. The Prometheus stack on `prod-debsrv` scrapes all targets and fires alerts for instance down, CPU > 85%, memory > 90%, and disk < 15% remaining.

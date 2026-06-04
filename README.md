# Homelab Infrastructure

Personal homelab managed entirely as code — a 3-node Proxmox cluster provisioned by Terraform
and configured by Ansible with no manual steps after the initial Proxmox install. Kubernetes
workloads and Docker application configs live in separate repos; this repo owns the layer beneath:
VM lifecycle, host configuration, secrets, and observability.

![Terraform](https://img.shields.io/badge/Terraform-1.5+-7B42BC?logo=terraform)
![Ansible](https://img.shields.io/badge/Ansible-2.14+-EE0000?logo=ansible)
![K3s](https://img.shields.io/badge/K3s-Kubernetes-326CE5?logo=kubernetes)
![Vault](https://img.shields.io/badge/HashiCorp-Vault-000000?logo=vault)

---

## What This Demonstrates

| Practice | Implementation |
|---|---|
| Infrastructure as Code | Modular Terraform provisions all VMs from a single reusable `ubuntuVM` module |
| Configuration Management | Idempotent Ansible roles applied across dev, prod, and infra host groups |
| Secrets Management | HashiCorp Vault with Raft storage, `mlock` enabled, data disk isolated from OS disk |
| Container Orchestration | K3s cluster (1 master + 3 workers) bootstrapped and joined via Ansible |
| Observability | Prometheus · Grafana · AlertManager · node_exporter · cAdvisor · Grafana Alloy |
| Alerting | Grafana alert rules firing to a project ticketing system via webhook |
| Security Hygiene | Vault keys gitignored, tfstate backups gitignored, token files mode 0600 |

---

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
| Monitoring | Prometheus · Grafana · AlertManager · cAdvisor · node_exporter |
| Log Aggregation | Grafana Alloy |
| DNS | Pi-hole (redundant pair) |
| Persistent Storage | NFS (ConderNAS) — K8s PVCs, backups, media |
| Network Controller | TP-Link Omada |

---

## Repository Structure

```
infra/
├── ansible/
│   ├── inventory/
│   │   └── inventory.ini              # All hosts and groups
│   ├── playbooks/
│   │   ├── k8s-master.yml             # K3s bootstrap: master init, worker join, NFS provisioner
│   │   ├── dockerHosts.yml            # Docker host setup + monitoring agents + SMB/NFS mounts
│   │   ├── proxmox.yml                # Proxmox node config: node_exporter, firewall
│   │   ├── prodVault.yml              # Vault install, Raft init, unseal automation
│   │   └── templates/
│   │       ├── docker-compose.yml.j2  # Prometheus + Grafana + AlertManager stack
│   │       └── alert-rules.yml        # CPU, memory, disk, instance-down alerts
│   └── roles/
│       ├── common/                    # apt cache, base packages
│       ├── docker/                    # Docker CE install + daemon config
│       ├── backups/                   # NFS backup mount + templated cron script
│       ├── qemu/                      # QEMU guest agent
│       └── updates/                   # Unattended upgrades
└── terraform/
    ├── modules/
    │   └── ubuntuVM/                  # Reusable Ubuntu cloud-image VM (cloud-init, virtio, vlan)
    └── deployments/
        ├── kubernetes/                # K3s master + 3 worker nodes
        ├── dockerProd/                # Production Docker hosts
        ├── dockerDev/                 # Dev Docker host
        ├── vault/                     # Vault VM with separate data disk
        └── monitoring/                # Monitoring server
```

---

## Engineering Decisions

**Modular Terraform** — All VMs are provisioned from a single `ubuntuVM` module using Ubuntu
Noble cloud images via `proxmox_virtual_environment_download_file`. The module exposes an optional
`data_disk_size` variable; Vault uses this to keep its Raft data on a separate virtio1 disk,
isolating the OS disk entirely.

**K3s token bootstrap** — On first run of `k8s-master.yml`, K3s generates its join token. The
playbook reads it via `slurp`, writes it to `inventory/group_vars/kubernetes/k3s_vars.yml` on the
controller (mode 0600, gitignored), and passes it to workers via `hostvars` in the same run.
Subsequent runs load from group_vars automatically — no manual token distribution.

**Vault Raft backend** — Vault uses the integrated Raft storage engine on a dedicated virtio1
data disk. `mlock` is enabled via `CAP_IPC_LOCK` to prevent secrets from being paged to disk.
Init keys are written to `/root/vault-init.json` (mode 0600) and should be moved off-host
immediately after initialisation.

**NFS persistent storage** — `nfs-subdir-external-provisioner` runs inside K3s and mounts the
ConderNAS share. Every PVC creates a subdirectory under `/mnt/nfs_share`. The NFS StorageClass
is the cluster default so workloads get persistence without an explicit `storageClassName`.

**Monitoring coverage** — Every host runs `node_exporter` (port 9100). Docker hosts add
`cAdvisor` for container metrics. Grafana Alloy ships logs from all hosts. Alerts fire for
instance down, CPU > 85%, memory > 90%, and disk < 15% remaining.

---

## Usage

### Provision VMs with Terraform

```bash
cd terraform/deployments/<deployment>
terraform init
terraform plan -var-file=../../terraform.tfvars
terraform apply
```

Deployments: `kubernetes`, `dockerDev`, `dockerProd`, `vault`, `monitoring`

### Configure hosts with Ansible

```bash
cd ansible/

# Bootstrap K3s cluster (master + workers + NFS provisioner)
ansible-playbook playbooks/k8s-master.yml

# Configure Docker hosts (Docker CE, monitoring agents, mounts)
ansible-playbook playbooks/dockerHosts.yml

# Configure Proxmox nodes (node_exporter, firewall rules)
ansible-playbook playbooks/proxmox.yml

# Install and initialise HashiCorp Vault
ansible-playbook playbooks/prodVault.yml
```

### Prerequisites

```bash
terraform >= 1.5   # bpg/proxmox provider ~> 0.66
ansible >= 2.14
ansible-galaxy collection install -r ansible/requirements.yml
# Collections: community.general, ansible.posix, community.docker
```

---

## Host Inventory

| Hostname | Role |
|---|---|
| Balerion / Smaug / toothless | Proxmox VE nodes (3-node cluster) |
| k8s-master | K3s control plane |
| k8s-node01/02/03 | K3s workers |
| prod-ubsrv-01/02/03 | Docker production hosts |
| prod-debsrv | Monitoring server (Prometheus stack) |
| dev-ubsrv-01 | Docker dev host |
| prod-vault | HashiCorp Vault |
| pisrv01/02 | Pi-hole DNS (redundant pair) |
| ConderNAS | NFS server |

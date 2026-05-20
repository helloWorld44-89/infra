# Infra Documentation

This directory documents the homelab infrastructure managed via Terraform and Ansible.

## Structure

```
docs/
├── network/       — VLANs, subnets, firewall rules, DNS
├── hardware/      — Proxmox nodes, specs, disk layout
├── ansible/       — Playbook conventions, inventory, secrets
├── proxmox/       — VM templates, resource pools, storage
└── backup/        — Backup strategies, schedules, restore procedures
```

Each doc follows this frontmatter:

```yaml
---
title: <descriptive title>
date: <YYYY-MM-DD>
author: Hermes Docs Agent
tags: [tag1, tag2]
---
```

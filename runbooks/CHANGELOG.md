# Changelog

## 2026-10-17
- [proxmox] Diagnosed Corosync self-fencing root cause: single shared 1GbE NIC per node caused heartbeat token loss under load -> watchdog hard-resets -> cascading k3s alert storms (NodeDown, PrometheusJobMissing, CoreDNS/Prometheus churn)
- [proxmox] Added USB Gigabit NICs (ASIX AX88179) to all 3 nodes (Balerion/toothless/Smaug), configured dedicated non-routed subnet 192.168.6.0/24
- [proxmox] Added second Corosync ring (ring1_addr) in corosync.conf, verified connected on all nodes via `corosync-cfgtool -s`
- [docs] Added docs/network/corosync-redundancy.md documenting topology, limitation (same-switch, not yet physically isolated), and monitoring follow-up
- [monitoring] Fixed Grafana alert webhook workflow: webhook-spawned agent runs had no terminal tool access (silent default toolset), fixed via platform_toolsets.webhook config; switched approval flow from interactive Telegram question (undeliverable from a one-shot webhook run) to Kanban task creation + short notification
- [monitoring] Fixed global model.default pointing at an unreliable free-tier OpenRouter model, which caused multi-minute timeouts on every webhook/cron-spawned agent run

## 2026-05-20
- [docs] Initialized doc directory skeleton across infra and infra-k8s repos
- [infra] Set up deploy SSH keys for automated doc commits
- [orchestrator] Docs ticketing now handled by orchestrator summary cron :25/:55
- [monitoring] Added docs escalation path for new alert rules/dashboards
- [monitoring] Grafana webhook configured → Plane tickets on alert
- [coding] SOUL.md rewritten with gated project workflow (Architecture → Plan → Build → Docs)
- [coding] Claude Code CLI authenticated with Pro subscription
- [infra] Created helloWorld44-89/homelab-scripts repo
- [infra] GITHUB_PAT configured in coding profile

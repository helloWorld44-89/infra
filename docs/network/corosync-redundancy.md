---
title: Corosync Redundant Ring (Proxmox cluster)
date: 2026-10-17
author: Hermes Docs Agent
tags: [proxmox, corosync, ha, networking, incident]
---

# Corosync Redundant Ring

## Background / root cause

All 3 Proxmox nodes (Balerion `192.168.5.10`, toothless `192.168.5.11`, Smaug
`192.168.5.12`) originally had exactly one NIC each (onboard Intel
I219-LM/V, gigabit-only — no 2.5GbE, no second port). That single NIC carried
everything: Corosync heartbeat, VM traffic, NFS, and backups.

Under load, Corosync's heartbeat token was occasionally delayed/lost
(2.7–3.6s gaps observed in `journalctl -u corosync`). The failure chain:

```
token loss -> node drops from quorum -> HA lock renewal fails
  -> watchdog not petted -> hard reset
  -> surviving nodes fence + migrate its VMs -> node rejoins ~2min later
```

This was the root cause of a recurring k3s alert storm (NodeDown,
PrometheusJobMissing, ContainerCrashLoop, CoreDNS/Prometheus pod churn) —
not application-level crash loops. Confirmed via identical
`pve-ha-crm`/`pve-ha-lrm`/`corosync` log signatures across all 3 nodes
within a 24h window.

## Fix: dedicated second Corosync link (2026-10-17)

Added a USB Gigabit Ethernet adapter (ASIX AX88179 chipset) to each node,
on the **same physical switch** as the existing LAN (no separate switch
available at the time — see "Known limitation" below).

| Node | Primary NIC / IP (link 0) | New USB NIC / IP (link 1) |
|---|---|---|
| Balerion (.10) | onboard, `192.168.5.10` | `enx607d0947c4d3`, `192.168.6.10` |
| toothless (.11) | onboard, `192.168.5.11` | `enxa0cec8b7fca5`, `192.168.6.11` |
| Smaug (.12) | onboard, `192.168.5.12` | `enxa0cec8b7f53a`, `192.168.6.12` |

New subnet `192.168.6.0/24` is **not routed** — no default gateway
configured on the new interfaces. Corosync traffic only ever needs
node-to-node reachability, never a route out, so this is intentional and
doesn't require any VLAN or router config.

`corosync.conf` (`/etc/pve/corosync.conf`, cluster-replicated via pmxcfs)
now carries a `ring1_addr` per node pointing at the `192.168.6.x` address,
with `config_version` bumped. Verified live on all 3 nodes via
`corosync-cfgtool -s` — both `link 0` (`.5.x`) and `link 1` (`.6.x`) show
`connected` to every peer.

## Known limitation

Both links currently share the same physical switch. This does **not**
protect against a switch-level outage, but it does eliminate the actual
observed failure mode: token loss caused by contention/driver queueing on
a single busy NIC. The new ring uses a fully separate NIC and USB/ASIX
driver path from the onboard Intel NIC, so congestion on one no longer
affects the other.

If/when a second switch (or direct node-to-node cross-connect) becomes
available, re-cable the `192.168.6.x` links to it for true physical
redundancy — no further corosync.conf changes would be needed, only the
physical recabling.

## Verification / monitoring

Watch Grafana for `NodeDown` / Corosync-flap alerts over the following
days. If they stop recurring, the fix is confirmed. If they continue,
next step is tuning the Corosync `token` timeout in `corosync.conf`
(no Proxmox UI control for this — file edit only, see
`runbooks/CHANGELOG.md` and the `homelab` Hermes skill for the general
diagnosis).

# homelab

GitOps Configuration and documentation of my homelab, powered by Kubernetes

## Current Kubernetes Services

### Infrastructure

- KubeVIP (Loadbalancer) v1.0.1
- FluxCD (GitOps) v2.5.1
- Traefik (IngressRoute) v3.3.5
- Traefik (CRDs) v1.6.0
- Tailscale (Operator) v1.82.0
- Cert-Manager (Certificates) v1.17.1

## Applications

- Podinfo (Testing App) v6.8.0 (auto-updated via Helm)
- Ntfy (Notification Service) v2.14.0
- Commafeed (RSS Feed Reader) v5.11.1
- Actual Budget (Budgeting App) v23.4.2

## Current Docker Services (To Be Migrated)

The following services are currently running in Docker and planned for migration to Kubernetes:

### Infrastructure Management

- Netbox (Network Infrastructure Management) [netboxcommunity/netbox:v4.2-3.2.0]
- Netbootxyz (Network Boot Server) [ghcr.io/netbootxyz/netbootxyz:0.7.5-nbxyz4]
- ZNC (IRC Bouncer) [znc:1.9.1]

### Automation

- Watchtower (Container monitoring and auto-updating) [containrrr/watchtower:latest]
- N8N (Workflow automation) [n8n-io/n8n:1.85.4]

### Media Management

- PinchFlat (Self-hosted YouTube downloader) [ghcr.io/kiersanegilin/pinchflat:latest]
- Audiobookshelf (Audiobook server) [ghcr.io/advplyr/audiobookshelf:2.20.0]
- StreamDL (Streaming Media Downloader) [dangeroustech/streamdl:{client,server}_unstable]

### Communal Services

- Recipes Web Application [vabene1111/recipes:1.5]

## External Services/Hardware

- TrueNAS (Storage) [1 x RAIDZ2 | 8 wide | 7.28 TiB - 41.26 TiB Usable]
- Proxmox (Virtualization) [1 x Minisforum NAB6]
- Ubiquiti (Networking) [1 x UCG Ultra | 1 x U6 Lite | 1 x U6 Pro | 1 x AC Lite]

## Storage

The cluster uses **TrueNAS NFS** as the default storage class for persistent volumes. This provides centralized, network-attached storage that persists across pod restarts and node failures.

### How It Works

- **Storage Class**: `nfs-truenas` (default)
- **Provisioner**: NFS Subdir External Provisioner dynamically creates persistent volumes
- **Backend**: TrueNAS NFS share at `/mnt/tank/k8s-homelab`
- **Benefits**:
  - Pods can move between nodes without data loss
  - Centralized storage on TrueNAS with RAIDZ2 protection
  - Supports both `ReadWriteOnce` and `ReadWriteMany` access modes
  - Automatic volume provisioning for PVCs

When a PersistentVolumeClaim (PVC) is created without specifying a storage class, it automatically uses `nfs-truenas`. The provisioner creates a unique subdirectory on the TrueNAS NFS share for each PVC, ensuring data isolation between applications.

## NFS Storage Maintenance

Several applications use persistent storage backed by TrueNAS NFS. When TrueNAS needs to be rebooted or undergo maintenance, pods using NFS volumes may hang or become unresponsive. Use the maintenance script to gracefully handle these situations.

### Before TrueNAS Maintenance/Reboot

Scale down all pods using NFS storage:

```bash
./scripts/nfs-maintenance.sh pre
```

This will:

- Find all PVCs using the `nfs-truenas` storage class
- Scale down all deployments using those PVCs to 0 replicas
- Ensure no pods are accessing NFS when TrueNAS goes down

### After TrueNAS Maintenance/Reboot

Once TrueNAS is back online, scale pods back up:

```bash
./scripts/nfs-maintenance.sh post
```

This will:

- Find all deployments that were scaled down
- Scale them back up to their original replica counts
- Show the status of pods using NFS storage

### Check NFS Pod Status

To check the current status of pods using NFS storage:

```bash
./scripts/nfs-maintenance.sh check
```

### What Happens During NFS Outages

- **Brief outages (< 1 min)**: Pods may hang but usually reconnect automatically
- **Medium outages (1-5 min)**: Some pods may need manual restart
- **Long outages (> 5 min)**: Pods will likely need to be restarted

The NFS mount options are configured with `hard` mounts and retry settings to prevent data corruption, but pods may hang during outages. Always use the maintenance script for planned TrueNAS maintenance.

## To Be Added

- WorkLenz [https://github.com/worklenz/worklenz]

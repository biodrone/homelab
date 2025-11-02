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

### Infrastructure
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

## To Be Added
- WorkLenz [https://github.com/worklenz/worklenz]

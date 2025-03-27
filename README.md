# homelab
GitOps Configuration and documentation of my homelab, powered by Kubernetes

## Current Kubernetes Services

### Infrastructure
- KubeVIP (Loadbalancer) v0.8.9
- FluxCD (GitOps) v2.5.1

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

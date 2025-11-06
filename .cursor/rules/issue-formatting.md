# Homelab GitOps Repository Rules

## Issue Formatting

### Title Format

- **Do NOT use conventional commit prefixes** (e.g., `feat(inf):`, `fix(app):`) in issue titles
- Use clean, descriptive titles: `External Secrets Operator`, `HashiCorp Vault`, `StreamDL`
- Titles should be concise and self-explanatory

### Labels

Issues must be labeled with:

1. **Type Label** (required):
   - `feat` - New feature or enhancement
   - `fix` - Bug fix
   - `docs` - Documentation changes

2. **Scope Label** (required, matches Flux kustomization structure):
   - `infra-controllers` - Infrastructure controllers and operators (matches `infrastructure/controllers/`)
   - `infra-configs` - Infrastructure configuration (matches `infrastructure/configs/`)
   - `apps` - Applications (matches `apps/`)
   - `deps` - Dependencies and tooling
   - `meta` - Meta/workflow improvements

### Examples

✅ **Correct:**

- Title: `External Secrets Operator`
- Labels: `feat`, `infra-controllers`

- Title: `delegate certain zones to pihole dns`
- Labels: `fix`, `infra-configs`

- Title: `StreamDL`
- Labels: `feat`, `apps`

❌ **Incorrect:**

- Title: `feat(inf): External Secrets Operator` (has conventional commit prefix)
- Title: `External Secrets Operator` with no labels (missing type and scope)

## Repository Structure

This repository follows FluxCD GitOps patterns:

- `infrastructure/controllers/` - Infrastructure controllers and operators
- `infrastructure/configs/` - Infrastructure configuration
- `apps/base/` - Base application configurations
- `apps/homelab/` - Environment-specific application overlays
- `clusters/homelab/` - Cluster-specific Flux kustomizations

## Conventional Commits

When creating commits (not issues), use conventional commit format:

- `feat(scope): description`
- `fix(scope): description`
- `docs(scope): description`

Scopes should match the directory structure (e.g., `inf`, `app`, `deps`, `meta`).

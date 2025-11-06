# Branch Naming Convention

## Format

Branches should include both the issue number and a descriptive name to make it easy to identify the purpose at a glance.

**Format**: `biodrone/issue<number>-<short-description>`

### Components

- **Prefix**: `biodrone/` - Identifies the branch owner/namespace
- **Issue Number**: `issue<number>` - Links to the GitHub issue (e.g., `issue27`)
- **Description**: `<short-description>` - Brief, kebab-case description of what the branch is for

### Examples

✅ **Correct:**

- `biodrone/issue27-vault` - Working on HashiCorp Vault (issue #27)
- `biodrone/issue23-recipes` - Working on recipes app (issue #23)
- `biodrone/issue6-cloudnative-pg` - Working on CloudNative-PG (issue #6)

❌ **Incorrect:**

- `biodrone/issue27` - Missing descriptive name
- `biodrone/vault` - Missing issue number
- `biodrone/issue-27-vault` - Uses dash in issue number (should be `issue27`)
- `biodrone/issue27_hashicorp_vault` - Uses underscores instead of hyphens

## Best Practices

- **Use hyphens**: Separate words with hyphens (`-`) for better readability
- **Be descriptive but concise**: Include enough detail to convey purpose without being overly long
- **Use kebab-case**: All lowercase with hyphens (e.g., `hashicorp-vault`, not `HashiCorpVault`)
- **Match issue title**: The description should relate to the issue title, but can be shortened/abbreviated

## Workflow

1. Check the issue number: `gh issue list` or view the issue on GitHub
2. Create branch: `git checkout -b biodrone/issue<number>-<description>`
3. Work on the branch and commit changes
4. Push and create PR: `git push -u origin biodrone/issue<number>-<description>`

## Rationale

This naming convention provides:

- **Traceability**: Issue number links branch to GitHub issue
- **Clarity**: Descriptive name makes purpose immediately obvious
- **Organization**: Consistent format makes branches easy to scan and manage
- **Context**: Team members can quickly understand what each branch is for without checking the issue

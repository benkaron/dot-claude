---
name: using-linear
description: Work with Linear issues including creating, updating, and converting tasks to issues. Use when working with Linear, creating Linear issues, updating ticket status, or managing Linear workflow.
argument-hint: "[create|update|list] [options]"
---

# Using Linear

Manage Linear issues and development workflow.

## Quick Operations

```bash
# List your issues
linear-cli issue list --mine

# Create issue
linear-cli issue create --title "Title" --description "Details"

# Update status
linear-cli issue update TEAM-123 --status "In Progress"

# View issue
linear-cli issue show TEAM-123
```

## Workflow Integration

**Start work:**
```bash
# View and update issue
linear-cli issue show TEAM-123
linear-cli issue update TEAM-123 --status "In Progress"

# Create branch
git checkout -b feat/TEAM-123-description
```

**Finish work:**
```bash
# Link in PR
gh pr create --title "feat: [TEAM-123] Title" --body "Implements TEAM-123"

# Mark done
linear-cli issue update TEAM-123 --status "Done"
```

## Bulk Operations

```bash
# Convert tasks to issues
for task in "${tasks[@]}"; do
  linear-cli issue create --title "$task" --estimate 3
done

# Update multiple issues
linear-cli issue list --team TEAM --status Todo | \
  xargs -I {} linear-cli issue update {} --priority High
```

## Branch/Commit Integration

**Branch naming:** `feat/TEAM-123-description`
**Commits:** `feat: [TEAM-123] Add feature`
**PR titles:** `feat: [TEAM-123] Feature title`

See REFERENCE.md for templates, bulk operations, and team workflow patterns.
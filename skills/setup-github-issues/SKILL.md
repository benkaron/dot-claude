---
name: setup-github-issues
description: Set up GitHub issues for a project including labels, milestones, templates, and initial issues. Use when initializing project issues, creating issue structure, or setting up GitHub project management.
argument-hint: "[repository]"
---

# Setup GitHub Issues

Initialize comprehensive issue tracking for a project.

## Quick Setup

Run setup script:

```bash
~/.claude/skills/setup-github-issues/setup.sh
```

Or manual setup:

### 1. Labels

```bash
# Remove defaults, create structure
~/.claude/skills/setup-github-issues/create-labels.sh
```

Creates:
- **Type:** feature, bug, chore, docs, refactor
- **Priority:** critical, high, medium, low
- **Status:** blocked, in-progress, review-needed, ready
- **Effort:** XS, S, M, L, XL
- **Area:** frontend, backend, database, infrastructure

### 2. Milestones

```bash
gh api repos/{owner}/{repo}/milestones --method POST \
  --field title="Sprint 1" \
  --field due_on="2024-01-15T00:00:00Z"
```

### 3. Issue Templates

```bash
mkdir -p .github/ISSUE_TEMPLATE
# Creates bug_report.md, feature_request.md, task.md
~/.claude/skills/setup-github-issues/create-templates.sh
```

### 4. Initial Issues

```bash
# Setup issues
gh issue create --title "Set up CI/CD" --label "type: chore,priority: high"
gh issue create --title "Write documentation" --label "type: docs,priority: medium"
```

## Management

```bash
# Bulk operations
gh issue list --label "type: feature" | xargs gh issue edit --milestone "v1.0"

# Queries
gh issue list --label "priority: high" --assignee ""
gh issue list --label "status: blocked"
```

See REFERENCE.md for complete label structure, templates, automation, and best practices.

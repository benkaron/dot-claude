---
name: using-git
description: Work with git branches, create feature branches, switch work to feature branches, and manage branch workflows. Use when creating branches, switching branches, moving work, or managing git workflow.
argument-hint: "[create|switch|squash|rebase] [branch-name]"
---

# Using Git

Quick git operations and branch management.

## Create Feature Branch

```bash
git checkout -b feature/description
```

For GitHub issue:
```bash
gh issue view 42 --json title
git checkout -b fix/issue-42-brief-description
```

## Move Work to Feature Branch

If on main/master with changes:
```bash
git stash push -m "Moving to feature"
git checkout -b feature/name
git stash pop
```

## Squash Commits

```bash
git reset --soft HEAD~3
git commit -m "feat: consolidated message"
```

That's it. The `--soft` keeps changes staged.

## Rebase on Main

```bash
git fetch origin main
git rebase main
git push --force-with-lease
```

## Quick Recovery

```bash
git reflog                    # Find lost work
git reset --hard commit-hash  # Restore state
git rebase --abort           # Cancel rebase
```

## Safety First

- **Never force push shared branches**
- **Create backup**: `git branch backup-$(date +%s)`
- **Check status first**: `git status`

See REFERENCE.md for detailed workflows, commands, and troubleshooting.
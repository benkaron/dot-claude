---
name: cleaning-commit-history
description: Reorganize and clean up messy commit history on a feature branch into logical, reviewable commits. Use when cleaning up commits, preparing a branch for review, separating formatting from logic changes, fixing broken intermediate states, or squashing WIP commits.
argument-hint: "[branch-name]"
---

# Cleaning Commit History

Transform messy commits into logical, reviewable history.

## Safety First

```bash
# Create backup
git branch backup-$(date +%s)
```

## Simple Squash (Most Common)

```bash
# Squash last N commits
git reset --soft HEAD~3
git commit -m "feat: implement user authentication

- Add login/logout functionality  
- Include session management
- Add password validation"
```

That's it. The `--soft` keeps all changes staged.

## Interactive Rebase (Complex Cases)

```bash
# Rebase last 5 commits
git rebase -i HEAD~5

# Commands:
# pick = keep commit
# squash = combine with previous  
# reword = change message
# drop = remove commit
```

## Reorganization Priorities

1. **Generated files** → separate commits
2. **Formatting only** → isolated commits  
3. **Refactoring** → separate from features
4. **Features + tests** → together
5. **Fix broken builds** → ensure each commit works

## When Things Go Wrong

```bash
git rebase --abort     # Cancel rebase
git reset --hard backup-$(date +%s)  # Restore backup
```

See REFERENCE.md for complex reorganization patterns, interactive rebase guide, and recovery procedures.
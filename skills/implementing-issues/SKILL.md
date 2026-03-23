---
name: implementing-issues
description: Implement a GitHub or Linear issue end-to-end with TDD, branch management, and PR creation. Use when implementing an issue, working on a ticket, starting a feature from an issue, or building from issue requirements.
argument-hint: "<issue number, #number, or TEAM-ID>"
---

# Implementing Issues

End-to-end issue implementation with TDD and proper workflow.

## Quick Start

```bash
# GitHub issue
gh issue view 42 && git checkout -b feat/issue-42-description

# Linear issue  
linear-cli issue show TEAM-123 && git checkout -b feat/TEAM-123-description
```

## TDD Workflow

1. **Read requirements:** Understand issue, acceptance criteria
2. **Write failing test:** Test the desired behavior first
3. **Implement minimal code:** Make test pass
4. **Refactor:** Clean up while keeping tests green
5. **Repeat:** For each requirement

```bash
# Write test
touch tests/test_feature.py
# Test fails initially - good!
pytest tests/test_feature.py

# Implement
# Tests pass - good!
pytest
```

## Create PR

```bash
# Commit work
git add . && git commit -m "feat: implement feature

Resolves #42

- Added feature X
- Updated component Y
- Tests included"

# Push and create PR
git push -u origin HEAD
gh pr create --title "feat: implement feature" --assignee @me
```

## Branch Naming

- **GitHub:** `feat/issue-42-description`, `fix/issue-42-bug`
- **Linear:** `feat/TEAM-123-description`  
- **Types:** feat, fix, chore, docs, refactor

See REFERENCE.md for TDD patterns, testing strategies, and issue workflow examples.
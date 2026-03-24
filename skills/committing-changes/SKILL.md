---
name: committing-changes
description: Stage, validate, and commit changes with a clear message, optionally pushing to remote and monitoring CI. Use when committing code, creating a commit, pushing changes, or doing a commit-and-push workflow.
argument-hint: "[--push] [message hint]"
---

# Committing Changes

Auto-stage, validate, and commit changes. Pass `--push` to also push and monitor CI.

## Workflow

### 1. Check Branch Safety

Read `./CLAUDE.md` for branch protection and push policies. If on a protected branch without permission, suggest a feature branch.

### 2. Run Validation

Auto-detect project type (`pyproject.toml`, `package.json`, `Cargo.toml`, `go.mod`, `Makefile`) and run:
- Format → lint → typecheck
- Stop on failure

**Python:**

```bash
black . || ruff format .
ruff check . || flake8 .
mypy . || echo "Skipping type checking"
```

**JavaScript/TypeScript:**

```bash
npm run format || npm run prettier || echo "No formatter"
npm run lint || echo "No linter"
npm run typecheck || npm run tsc || echo "No type checking"
```

**Makefile:**

```bash
make validate || make format lint || echo "No validation target"
```

### 3. Review Changes

```bash
git status --short
git diff --stat
```

### 4. Craft Commit Message

Use **conventional commits** format when appropriate:

- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation changes
- `style`: formatting, no code change
- `refactor`: code restructuring
- `test`: adding tests
- `chore`: maintenance tasks

Analyze diff and recent history (`git log --oneline -5`) for context.

### 5. Stage and Commit

```bash
# Stage specific files (avoid git add -A unless intentional)
git add <specific-files>

# Commit with message
git commit -m "$(cat <<'EOF'
<commit message>
EOF
)"
```

Handle pre-commit hook failures:

```bash
# If pre-commit hooks modify files:
git add -u  # Stage the hook's changes
git commit -m "<same message>"  # Retry commit
```

### 6. Push (if --push provided)

```bash
git push -u origin HEAD
```

### 7. Monitor CI (if --push provided)

```bash
if [ -d .github/workflows ] && [ -f ~/.claude/skills/ci-monitor/ci-monitor.py ]; then
    branch=$(git branch --show-current)
    uv run ~/.claude/skills/ci-monitor/ci-monitor.py --branch "$branch" &
    echo "CI monitor running in background"
fi
```

## Error Recovery

```bash
# View what went wrong
git status
git diff --cached

# Reset if needed
git reset HEAD~1  # Undo last commit, keep changes
git reset --hard HEAD~1  # Undo last commit, discard changes

# Force push only if absolutely necessary
git push --force-with-lease  # Safer than --force
```

## Best Practices

1. **Review changes** before committing with `git diff`
2. **Write clear messages** that explain why, not just what
3. **Keep commits focused** — one logical change per commit
4. **Run validation** before pushing to catch issues early
5. **Never commit secrets** — use .gitignore and environment variables
6. **Respect branch protection** — use feature branches for development

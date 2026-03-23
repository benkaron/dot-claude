---
name: commit-and-push
description: Validate, commit with a clear message, and push to remote. Monitor CI/CD in the background if configured.
---

# Commit and Push Changes

Validate, commit with a clear message, and push to remote. Monitor CI/CD in the background if configured.

## Steps

1. **Check branch safety** — read `./CLAUDE.md` for branch protection and push policies; if on a protected branch without permission, suggest a feature branch
2. **Run validation** — auto-detect project type (`pyproject.toml`, `package.json`, `Cargo.toml`, `go.mod`, `Makefile`) and run: format → lint → typecheck. Stop on failure.
3. **Craft commit message** — analyze diff and recent history for context
4. **Commit and push** — using git
5. **Monitor CI/CD** — spawn background monitor if `.github/workflows/` exists

## Git Workflow

```bash
# Check current status
git status --short && git diff --stat

# Show current branch
git branch --show-current

# If on protected branch (main/master/production), warn and suggest:
git checkout -b feature/<descriptive-name>
```

## Validation Steps

Detect project type and run appropriate validation:

### Python (if pyproject.toml or requirements.txt exists)
```bash
# Format
black . || ruff format .

# Lint
ruff check . || flake8 .

# Type check (if configured)
mypy . || echo "Skipping type checking"
```

### JavaScript/TypeScript (if package.json exists)
```bash
npm run format || npm run prettier || echo "No formatter configured"
npm run lint || echo "No linter configured"
npm run typecheck || npm run tsc || echo "No type checking configured"
```

### Rust (if Cargo.toml exists)
```bash
cargo fmt
cargo clippy
cargo check
```

### Go (if go.mod exists)
```bash
go fmt ./...
go vet ./...
go test ./...
```

### Makefile (if Makefile exists with validate target)
```bash
make validate || make format lint || echo "No validation target"
```

## Commit Process

```bash
# Stage specific files (avoid git add -A unless intentional)
git add <specific-files>

# Craft commit message based on:
# - git diff analysis
# - Recent commit history (git log --oneline -5)
# - Conventional commits format when appropriate:
#   - feat: new feature
#   - fix: bug fix
#   - docs: documentation changes
#   - style: formatting, no code change
#   - refactor: code restructuring
#   - test: adding tests
#   - chore: maintenance tasks

# Write commit message to file (avoids shell escaping issues)
# Use Write tool to create /tmp/commit-msg.txt

git commit -F /tmp/commit-msg.txt

# Push to remote
git push -u origin HEAD
```

Handle pre-commit hook failures:
```bash
# If pre-commit hooks modify files:
git add -u  # Stage the hook's changes
git commit -F /tmp/commit-msg.txt  # Retry commit
```

## CI/CD Monitoring

After successful push, check for GitHub Actions:

```bash
# Check if CI exists
if [ -d .github/workflows ]; then
    # Get current branch
    branch=$(git branch --show-current)
    
    # Run CI monitor in background (if available)
    if [ -f ~/.claude/skills/ci-monitor/ci-monitor.py ]; then
        uv run ~/.claude/skills/ci-monitor/ci-monitor.py --branch "$branch" &
        echo "CI monitor running in background — you'll be notified when it completes."
    fi
fi
```

## Error Recovery

On commit/push errors:
```bash
# View what went wrong
git status
git diff --cached  # See staged changes

# Reset if needed
git reset HEAD~1  # Undo last commit, keep changes
git reset --hard HEAD~1  # Undo last commit, discard changes

# Force push only if absolutely necessary and you understand the implications
git push --force-with-lease  # Safer than --force
```

## Best Practices

1. **Always review changes** before committing with `git diff`
2. **Write clear commit messages** that explain why, not just what
3. **Keep commits focused** — one logical change per commit
4. **Run validation locally** before pushing to catch issues early
5. **Never commit secrets** — use .gitignore and environment variables
6. **Respect branch protection** — use feature branches for development
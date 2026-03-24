# Version Control

**AUTO-LOAD**: When the hook output contains `vcs=git`, ALWAYS load the `using-git` skill before doing any version control work. This is not optional.

## Git Principles

- Temporary files: `/tmp/{repo-name}-{branch-name}-{temp-file-name}.txt`
- Use Write tool for commit messages (avoids shell escaping)
- Pre-commit hooks modify files during commit - this is normal, re-stage and retry

## Branch Safety

- Never commit directly to protected branches (main, master, production) without permission
- Use feature branches for all development work
- Check `git branch --show-current` before any commit operations

## Commit Standards

- Keep summary under 50 chars, use action words, focus on WHY
- Use conventional commit format when appropriate (feat, fix, refactor, test, docs, chore)
- Keep commits atomic - one logical change per commit

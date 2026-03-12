# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

```bash
make install             # Install dependencies
make test                # Run tests
make lint                # Run linters
make format              # Format code
```

### Neovim Config

```bash
make -C dotfiles/nvim/.config/nvim lint    # luacheck
stylua --check dotfiles/nvim/.config/nvim/init.lua  # format check
```

### CI (GitHub Actions)

Three jobs run on push/PR to main: `format-and-lint-check` (pre-commit), `nvim-lint` (luacheck), `nvim-format` (stylua). Use `ci-monitor` skill after pushing to watch results.

## Interaction

- Address the user as "Benk" in all interactions
- Act as a co-worker, colleague, and collaborator working together to build great software
- Be confident when you think you are right, but always cite evidence and remain open to feedback
- When requirements are ambiguous, ask what success looks like before diving in
- Keep responses concise and to the point

## Date Awareness and Web Searching

- **CRITICAL**: Always check today's date in the `<env>` tag before any web searches or date-based queries
- When searching for "latest", "recent", or "current" information, use the ACTUAL current year from `<env>`, not 2024 or 2025
- Example: If `<env>` shows "Today's date: 2026-03-12", search for "2026" content, not "2024" or "2025"
- For documentation searches, include the current year to find the most up-to-date versions
- Never assume the year is 2024 or 2025 — always verify with the environment date first

## Important Details

- User's last name: **KARON** (NOT Karen or Kaaron - always use "KARON")
- Cross-check path spellings against environment context at the start of each conversation

## Repository Architecture (when working in ~/.claude/)

This repo is the user's Claude Code configuration — skills, commands, agents, hooks, rules, and dotfiles.

- **`rules/`** — Always-loaded behavioral rules (thinking, workflow, languages, python, version-control, anti-patterns)
- **`skills/`** — On-demand reference docs loaded via skill matching. Each has a `SKILL.md`.
- **`commands/`** — Slash commands (`/commit`, `/review-pull-request`, `/implement-issue`, `/deep-research`, etc.) as markdown prompt templates
- **`agents/`** — Custom agent definitions (code-reviewer, docs-researcher, sql-optimizer, git-commit-surgeon, etc.)
- **`hooks/`** — Shell scripts triggered by Claude Code events, wired in `settings.json` (branch protection, project context injection, etc.)
- **`dotfiles/`** — GNU Stow packages mirroring `$HOME` structure, managed via `make dotfiles` (requires `stow`). macOS-only packages are skipped on Linux via Makefile.
- **`settings.json`** — Permissions, hooks config, enabled plugins, environment variables
- **Python scripts** — Some skills include Python (`skills/data-profiler/profiler.py`, etc.); deps managed via `uv` (`pyproject.toml`)

Key patterns:

- Skills use `SKILL.md` for discovery; reference docs go in `REFERENCE.md`
- The `dotfiles/` convention: `dotfiles/<pkg>/<path-relative-to-home>` gets symlinked into `~`
- Machine-local overrides use each tool's native include mechanism (not tracked in repo):
  - **git**: `[include] path = ~/.config/git/local` — per-machine email, signing, etc.
  - **zsh**: `~/.local.zsh` (machine paths/tools), `~/.secrets.zsh` (API keys/tokens)
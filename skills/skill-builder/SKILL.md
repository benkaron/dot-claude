---
name: skill-builder
description: Create and validate Claude Code skills with proper structure and effective descriptions. Use when building custom skills, testing skill discovery, improving existing skills, or auditing skill quality.
---

# Skill Builder

Build focused, discoverable skills based on patterns from production usage.

## SKILL.md Structure

```markdown
---
name: skill-name
description: What it does. Use when <trigger1>, <trigger2>, or <trigger3>.
argument-hint: "<arg description>"    # optional — shown in slash command help
context: fork                         # optional — isolates heavy skills
allowed-tools: Bash                   # optional — restricts available tools
---

# Skill Name

One-line summary of what this provides.

## Workflow (or ## Quick Start)

Numbered steps with concrete commands.
```

## YAML Fields

| Field | Required | Max | Purpose |
| --- | --- | --- | --- |
| `name` | Yes | 64 chars | Skill identifier |
| `description` | Yes | 1024 chars | Discovery + trigger matching |
| `argument-hint` | No | — | Shows what args the skill accepts |
| `context` | No | — | `fork` runs in isolated context |
| `allowed-tools` | No | — | Comma-separated tool restrictions |
| `disable-model-invocation` | No | — | `true` for reference-only skills |

## Description Formula

**Pattern**: `<What it does>. Use when <triggers>. Also <auto-load context>. Do NOT use for <exclusions>.`

### Good — specific triggers, negative boundaries

```yaml
description: >-
  Monitor GitHub Actions CI runs in real time. Use when the user has
  pushed code and wants to watch the build, check CI status, or wait
  for a workflow run. Also use after any git push command. Do NOT use
  for writing CI workflow YAML or debugging CI configuration.
```

### Good — exhaustive triggers for hard-to-match skills

```yaml
description: >-
  Search past Claude Code conversation history. ALWAYS load when the
  user mentions past sessions, previous conversations, or prior work.
  Trigger phrases: "have I done this before", "how did I fix",
  "what command did I run", "last time we", "find that session".
  Do NOT use for searching the current codebase or the web.
```

### Bad — vague, no triggers, no boundaries

```yaml
description: Helps with GitHub stuff
```

## Key Patterns from Real Skills

### Workflow skills — numbered steps with commands

```markdown
## Workflow

1. **Detect VCS** — jj or git
2. **Check branch safety** — read CLAUDE.md for permissions
3. **Run validation** — format -> lint -> typecheck
4. **Craft message** — conventional commits format
5. **Commit** — use Write tool for message files
```

### Multi-mode skills — one skill, multiple entry points

```markdown
## Modes

### spec-to-requirements
**Trigger**: "extract requirements", references to `spec.md`
Analyze spec and produce structured requirements.md.

### requirements-to-tasks
**Trigger**: "break into tasks", references to `requirements.md`
Convert requirements into implementable tasks.
```

### Tool skills — concrete command reference

```markdown
## Quick Start

\`\`\`bash
uv run ~/.claude/skills/my-tool/tool.py --help
\`\`\`
```

## Common Mistakes

1. **No negative triggers** — without "Do NOT use for X", skills match too broadly
2. **Abstract principles instead of commands** — skills should provide actionable steps
3. **Duplicate skills** — consolidate overlapping skills into one
4. **Missing `argument-hint`** — slash commands feel incomplete without it
5. **Overloaded skills** — if it does 5 unrelated things, split it

## Creating a New Skill

```bash
mkdir -p skills/my-skill
# Create SKILL.md with frontmatter + content
# Optionally create REFERENCE.md for deep details
```

## Validation

```bash
# Check all descriptions have triggers
grep "^description:" skills/*/SKILL.md

# Check for duplicate capabilities
grep "^name:" skills/*/SKILL.md | sort

# Verify YAML frontmatter
head -5 skills/*/SKILL.md
```

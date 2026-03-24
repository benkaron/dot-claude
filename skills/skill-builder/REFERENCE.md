# Skill Builder Reference

## Progressive Disclosure

```text
skills/
└── skill-name/
    ├── SKILL.md       # Discovery + core content (required, loaded first)
    └── REFERENCE.md   # Deep details (optional, loaded on demand)
```

Keep SKILL.md under ~100 lines. Move command references, troubleshooting, and edge cases to REFERENCE.md.

## Description Writing Checklist

- [ ] States what the skill does (action verb)
- [ ] Includes 3-5 trigger phrases with "Use when"
- [ ] Adds negative triggers ("Do NOT use for") if the skill could match too broadly
- [ ] Under 1024 characters
- [ ] Includes auto-load context if applicable ("Also auto-loads when...")

## When to Use Each YAML Field

### `argument-hint`

Use when the skill is invoked as a slash command and benefits from showing expected input:

```yaml
argument-hint: "<issue number, #number, or TEAM-ID>"
argument-hint: "<PR number or URL>"
argument-hint: "[--push] [message hint]"
```

### `context: fork`

Use for skills that do heavy work (validation, builds, large searches) to avoid polluting the main conversation context:

```yaml
context: fork
```

### `allowed-tools`

Use when a skill should only access specific tools (security, focus):

```yaml
allowed-tools: Bash
allowed-tools: Bash, Read, Grep
```

### `disable-model-invocation`

Use for reference-only skills that shouldn't trigger Claude to act:

```yaml
disable-model-invocation: true
```

## Deciding What Entity Type to Create

| Need | Best Entity | Alternative |
| --- | --- | --- |
| Auto-detected on-demand capability | Skill | Rule if always-on |
| Pre/post action automation | Hook | Nothing else does this |
| Always-on behavioral guidance | CLAUDE.md or Rule | Skill if occasional |
| Heavy isolated workflow | Skill with `context: fork` | Regular skill |
| External API integration | MCP Server | Bash calls if simple |

## Migrating to Skills

### From separate skills → multi-mode skill

If you have 3+ skills that share a pipeline (e.g., spec → requirements → tasks → issues), consolidate into one multi-mode skill with mode sections and distinct triggers per mode.

### From rules → skills

Move content to skills when it's only needed occasionally, not on every prompt. Rules are always loaded and cost context on every turn.

### From commands → skills

Commands are one-shot prompts. Skills provide richer context, can auto-load, and support progressive disclosure via REFERENCE.md.

## Quality Metrics

- **Discoverability**: Does it trigger on natural language?
- **Precision**: Does it avoid false matches?
- **Actionability**: Does it provide concrete steps?
- **Completeness**: Can the user finish the task without leaving the skill?
- **Maintenance**: Is it easy to update when tools change?

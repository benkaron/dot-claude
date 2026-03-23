# Maintaining Claude Code - Reference

Detailed examples and troubleshooting for Claude Code configuration.

## Entity Type Comparison

### CLAUDE.md

**Purpose**: Global behavioral guidelines read every session

**Best for**:

- Interaction style and preferences
- Workflow patterns
- Language-specific conventions
- Anti-patterns to avoid

**When to split into rules**:

- File exceeds 150 lines
- Different sections have different owners
- Rules apply to specific file paths

### .claude/rules/

**Purpose**: Modular, path-scoped rules

**Best for**:

- Large projects with many guidelines
- Path-specific rules (e.g., API files vs UI files)
- Team-shared conventions

**Path scoping**:

```yaml
---
paths: src/api/**/*.ts
---
# API Rules
- All endpoints must validate input
```

### Skills

**Purpose**: Auto-detected capabilities Claude uses when relevant

**Description formula**:

```text
<What it does>. Use when <trigger1>, <trigger2>, or <trigger3>.
```

### Commands

**Purpose**: User-invoked workflows via /command

**When to use command vs skill**:

- Command: User should explicitly choose when to run
- Skill: Claude should auto-detect and use

### Hooks

**Purpose**: Automated scripts at specific events

**Events**:

- PreToolUse: Before any tool runs
- PostToolUse: After tool completes
- Stop: When Claude finishes
- UserPromptSubmit: When user sends a prompt

**Exit codes**:

- 0: Success, continue
- 2: Block action, show error
- Other: Non-blocking warning

### Agents

**Purpose**: Specialized task personas with isolated context

**Best for**:

- Complex multi-step workflows
- Tasks needing specific tool sets
- Different model requirements (haiku for speed, opus for complexity)

## Troubleshooting

### Skill Not Being Discovered

1. Check YAML syntax - must have `---` on line 1
2. Verify description includes trigger words
3. Test with exact phrases from description
4. Check for competing skills with similar descriptions

### CLAUDE.md Growing Stale

Avoid including:

- Specific version numbers
- Completion percentages
- Date-specific information
- Dependency lists that change often

Include:

- Patterns and principles
- Tool preferences
- Workflow guidelines
- Anti-patterns

### Hook Not Running

1. Verify file is executable (`chmod +x`)
2. Check timeout setting (default 60s)
3. Test script manually first
4. Check exit codes (0 for success)

## Validation Checklists

### Skill Checklist

- [ ] Valid YAML frontmatter
- [ ] Description under 1024 chars
- [ ] Includes 3-5 trigger phrases
- [ ] Not duplicating another skill
- [ ] References only one level deep

### Command Checklist

- [ ] Clear purpose in filename
- [ ] Uses $ARGUMENTS if parameterized
- [ ] Not duplicating a skill
- [ ] User should explicitly invoke

---
name: deep-research
description: Conduct thorough research on a technical topic using documentation, code analysis, and web resources. Use when researching implementation approaches, understanding technologies, or investigating best practices.
argument-hint: "<topic or question>"
---

# Deep Research

Comprehensive technical research using multiple sources.

## Research Flow

1. **Define scope:** What question needs answering? What decisions depend on this?

1. **Search codebase:**

```bash
rg -i "keyword" --type-add 'code:*.{py,js,ts,rs,go}' -t code
fd README | xargs rg -i "topic"
```

1. **Check documentation:**

```bash
cat docs/*.md | grep -i "topic"
cat package.json | jq '.dependencies'  # Check current deps
```

1. **Research external sources:**
- Official framework docs
- GitHub repositories with similar implementations
- Recent blog posts (check dates!)
- Stack Overflow solutions

1. **Synthesize findings:**

```markdown
# Research: <Topic>

## Question
<What we're trying to answer>

## Key Findings
1. **Current approach:** <description> (Location: `path/file.py`)
2. **Industry standard:** <approach> (Used by: <projects>)
3. **Recommended:** <approach> (Why: <rationale>)

## Evidence & Sources
- `file.py:123` - Current implementation
- [Documentation](url) - Key insight
- [Blog Post](url) - Recent best practices

## Decision
<Recommended approach with rationale>
```

## Quick Commands

```bash
# Search similar projects
gh search repos "topic language:python stars:>100"

# Check dependencies
npm list | grep topic
pip list | grep topic
```

See REFERENCE.md for research templates, source evaluation criteria, and documentation techniques.

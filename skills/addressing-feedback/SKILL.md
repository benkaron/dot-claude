---
name: addressing-feedback
description: Address code review feedback, implement requested changes, and respond to reviewer comments. Use when handling PR feedback, addressing review comments, or implementing reviewer suggestions.
argument-hint: "[PR# or feedback-source]"
---

# Addressing Feedback

Systematically handle code review feedback.

## Quick Workflow

1. **Gather feedback:**
```bash
gh pr view <number> --comments
gh pr diff <number>
```

2. **Categorize:**
- 🚨 **Blocking** - Must fix
- ⚠️ **Important** - Should fix  
- 💡 **Suggestions** - Consider
- 💭 **Discussion** - Clarify

3. **Implement & respond:**
```bash
# Fix and commit
git add . && git commit -m "fix: address review - specific issue"

# Respond
gh pr comment <number> --body "Addressed all feedback:
- ✅ Fixed security issue
- ✅ Added error handling
- ❓ Question about performance - see above"
```

4. **Request re-review:**
```bash
gh pr review <number> --request
```

## Response Templates

**Acknowledging:** `✅ Fixed in commit abc123`

**Explaining:** `💭 I chose X because: [reasons]. Open to alternatives.`

**Deferring:** `📝 Good idea. Created issue #123 for follow-up.`

## Common Fixes

```bash
# Code complexity
radon cc file.py  # Measure, then refactor

# DRY violations  
rg -A5 -B5 "pattern"  # Find duplicates, extract shared code

# Test coverage
pytest --cov  # Check coverage, add missing tests
```

See REFERENCE.md for detailed response strategies, tracking templates, and automation scripts.
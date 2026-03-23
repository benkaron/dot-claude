---
name: reviewing-pull-requests
description: Review a pull request against issue requirements and coding best practices, then submit structured feedback. Use when reviewing a PR, checking a pull request, doing code review, or providing PR feedback.
argument-hint: "<PR number or URL>"
---

# Reviewing Pull Requests

Review pull requests against issue requirements and good coding practices.

## Workflow

### 1. Read the Pull Request

```bash
# View PR with full details
gh pr view <number> --json title,body,author,commits,files,comments,reviews

# Get diff and file changes
gh pr diff <number>
```

### 2. Find Related Issue

```bash
# View related GitHub issue
gh issue view <number> --json title,body,labels,assignees
```

### 3. Ensure Latest Code Context

```bash
# Pull latest changes
git fetch origin
git checkout pr/<number> || gh pr checkout <number>
```

### 4. Review Project Documentation

Check `CLAUDE.md`, `docs/`, `spec.md`, `requirements.md` for standards and patterns.

### 5. Analyze Implementation Quality

**Architecture Consistency:**
- Follows established patterns from codebase
- Single Responsibility Principle
- DRY compliance

**Code Organization:**
- Clear module boundaries
- Appropriate abstraction levels
- No obvious bottlenecks

### 6. Verify Test Coverage

```bash
# Run tests
npm test || pytest || cargo test || go test ./... || make test

# Check coverage if available
npm run coverage || pytest --cov || cargo tarpaulin
```

Ensure:
- All new functionality has tests
- Edge cases covered
- Integration tests present

### 7. Check Style Compliance

```bash
# Run linters
npm run lint || ruff check || cargo clippy || golangci-lint run
```

### 8. Assess Scope Adherence

Verify:
- No scope creep beyond original ticket
- Minimal necessary changes
- Clean commit history

### 9. Determine Review Action

Check if self-authored:
```bash
gh pr view <number> --json author -q '.author.login'
```

- Self-authored → comment only
- External → formal review (approve/request-changes/comment)

### 10. Submit Structured Feedback

```bash
# Submit review
gh pr review <number> --approve --body "Review comments"
gh pr review <number> --request-changes --body "Issues found"
gh pr review <number> --comment --body "Feedback"
```

## Review Framework

### Requirements Alignment
✓ All acceptance criteria met  
✓ Edge cases handled  
✓ Error handling robust

### Code Quality
✓ Consistent architecture  
✓ Clear documentation  
✓ Performance considered

### Testing
✓ Comprehensive test coverage  
✓ Failure modes tested  
✓ Integration verified

### Security
✓ Input validation present  
✓ No credentials exposed  
✓ Dependencies reviewed

## Feedback Template

```markdown
## Review Summary

**Requirements Coverage:** ✅ All acceptance criteria met
**Code Quality:** ⚠️ Minor improvements suggested  
**Testing:** ✅ Comprehensive coverage
**Documentation:** ✅ Clear and complete

## Detailed Feedback

### Strengths
- [Specific positive points]

### Suggestions
- [Actionable improvements]

### Required Changes (if any)
- [Blocking issues]

## Recommendation
[APPROVE | REQUEST_CHANGES | COMMENT]
```
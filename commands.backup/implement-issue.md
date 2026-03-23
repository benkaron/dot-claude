# Implement Issue

Issue: $ARGUMENTS

## Task

I'll work through this issue carefully and figure out the best workflow.

I will:

1. **Check current git status** and ensure we're not on main/master/dev
2. **Create feature branch** with proper naming convention based on issue details
3. **Read and understand issue requirements** using `gh` CLI
4. **Review project context** - check `CLAUDE.md`, `spec.md`, `requirements.md` for standards
5. **Follow TDD approach** - write complete tests first
6. **Implement minimal code** to pass tests
7. **Refactor incrementally** while maintaining test coverage
8. **Document key architectural decisions** in code comments
9. **Clean up history** - squash/curate commits before pushing
10. **Push with upstream tracking** and create pull request
11. **Write complete PR description** with test plan
12. **Keep PR open** for review and iterate based on feedback

## Branch Safety Protocol

**Pre-Implementation Checks:**

- Verify current branch with `git branch --show-current`
- If on protected branch (main/master/dev), create feature branch immediately
- Check for uncommitted changes and stash if necessary
- Fetch latest changes from origin

**Branch Naming Conventions:**

- `feature/issue-{number}-{short-description}`
- `fix/issue-{number}-{description}`

## Command Reference

```bash
# Check current branch
git branch --show-current

# View issue details with full context
gh issue view <number> --json title,body,labels,assignees,milestone

# Create feature branch
git checkout -b "feature/issue-<number>-<description>"

# Push with upstream tracking
git push -u origin HEAD

# Create PR linking to issue
gh pr create --title "[Issue #<number>] Title" --body "Closes #<number>"

# Search related issues
gh issue list --search "in:title <keyword>" --json number,title,labels
```

## Pull Request Structure

- **Title**: `[Issue #<number>] Short description of the change`
- **Body**: Detailed explanation with acceptance criteria checklist
- **Labels**: Auto-applied based on issue labels
- **Linked Issues**: `Closes #<number>` reference

## Implementation Quality Standards

**Test-Driven Development:**

- Write failing tests first that capture acceptance criteria
- Implement minimal code to make tests pass
- Refactor while maintaining green tests

**Code Quality:**

- Follow project's established patterns from `CLAUDE.md`
- Add meaningful comments for complex logic
- Ensure all edge cases are tested
- Update documentation if public APIs change

**Branch Management:**

- Keep commits atomic and well-described
- Squash related commits before final push

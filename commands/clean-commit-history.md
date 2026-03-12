# Clean Commit History

Clean up a messy feature branch into a logical commit history that's easy to review and debug.

Usage: `/clean-commit-history [branch-name]`

## Task

I'll launch the git-commit-surgeon agent to analyze your feature branch and rebuild a clean commit history that separates concerns and creates atomic, reviewable commits.

I will:

1. **Create safety backup branch** to preserve original work (`${CURRENT_BRANCH}-backup`)
2. **Launch git-commit-surgeon agent** with specialized commit reorganization expertise
3. **Analyze current commit history** and identify improvement opportunities
4. **Create commit plan** showing proposed reorganization structure
5. **Execute commit surgery** following best practices for maintainability
6. **Validate results** ensuring no work is lost and all commits build/test

## When to Use This Command

### Perfect Use Cases

- **Mixed concerns**: Commits that combine formatting with logic changes
- **WIP commits**: Series of "fix", "temp", "wip" commits cluttering history
- **Broken intermediate states**: Commits that don't build or pass tests
- **Review preparation**: Making branch ready for clean code review
- **Atomic commit violations**: Large commits mixing multiple unrelated changes

## Safety Features

- **Automatic backup creation**: Original work preserved in `${CURRENT_BRANCH}-backup`
- **Validation checks**: Ensures no code changes are lost during reorganization
- **Build verification**: Each new commit is verified to build and pass tests
- **Recovery instructions**: Clear guidance on restoring from backup if needed

## Commit Reorganization Principles

The surgeon follows these strict priorities:

1. **Generated/Vendored/Lockfiles** -> isolated to dedicated commits
2. **Pure renames/moves** -> separated from content changes
3. **Formatting-only changes** -> isolated sweep commits
4. **Refactors without behavior change** -> separate from logic
5. **Feature/Logic changes** -> grouped by cohesive functionality
6. **Tests** -> co-located with their corresponding logic changes

## Recovery Process

If you need to restore the original history:

```bash
# Switch back to backup
git reset --hard ${CURRENT_BRANCH}-backup

# Delete surgery attempt (optional)
git branch -D ${CURRENT_BRANCH}

# Rename backup to original
git branch -m ${CURRENT_BRANCH}-backup ${CURRENT_BRANCH}
```

# Switch to Feature Branch

Move current work from main/master/dev to a proper feature branch, preserving all uncommitted changes.

Usage: `/switch-to-feature [branch-name-or-description]`

## Task

I'll safely move your current work to a feature branch without losing any changes.

I will:

1. **Check current branch and status** - verify we're on a protected branch with changes
2. **Stash any uncommitted changes** to preserve work-in-progress
3. **Create new feature branch** with proper naming convention
4. **Apply stashed changes** to the new branch
5. **Verify all changes transferred** successfully
6. **Provide next steps** for continuing work

## Safety Protocol

### Pre-flight Checks

- Only runs when on protected branches (`main`, `master`, `dev`)
- Confirms there are uncommitted changes to move
- Checks for any merge conflicts or git issues
- Warns about untracked files that might not transfer

### Change Preservation

- Uses `git stash` to safely preserve all uncommitted changes
- Includes both staged and unstaged changes

## Command Reference

```bash
# Stash changes with message
git stash push -m "switch-to-feature: Moving work"

# Create new feature branch
git checkout -b "feature/description"

# Apply stashed changes
git stash pop
```

## Next Steps

After successful switch:

- Continue development on the feature branch
- Use `/commit-and-push` when ready to share work
- Consider `/implement-issue <number>` if this relates to a GitHub issue

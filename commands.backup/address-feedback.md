# Address Pull Request Feedback

Pull Request: $ARGUMENTS

## Task

I'll understand the feedback context and figure out the best approach for addressing pull request feedback.

I will:

1. **Read the pull request** to understand the changes and context
2. **Find related issue** for acceptance criteria and requirements
3. **Review project documentation** (`CLAUDE.md`) for context
4. **Ensure correct branch state** - pull latest changes and verify working directory
5. **Analyze feedback systematically** - categorize comments by type (blocking, suggestions, nitpicks)
6. **Create focused implementation plan** - address feedback efficiently without scope creep
7. **Make targeted changes** - resolve feedback while maintaining code quality
8. **Test changes thoroughly** - ensure fixes don't break existing functionality
9. **Update PR with explanations** - document changes made and reasoning

## Command Reference

```bash
# View PR with full details
gh pr view <number> --json title,body,author,commits,files,comments,reviews

# Get formal reviews with review comments
gh pr view <number> --json reviews

# Get inline code comments
gh api repos/<owner>/<repo>/pulls/<number>/comments

# View related GitHub issue
gh issue view <number> --json title,body,labels
```

## Safety Protocol

- **Branch Protection**: Check current branch and avoid direct commits to main/master
- **Change Scope**: Address only feedback-related issues, document unrelated findings
- **Test Coverage**: Ensure changes don't break existing functionality
- **Documentation**: Update relevant docs if changes affect public APIs

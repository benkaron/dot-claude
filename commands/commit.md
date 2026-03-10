---
name: commit
description: Create a well-structured git commit
---

Please create a git commit following these steps:

1. Run `git status` to see current changes
2. Run `git diff` to review the changes
3. Stage appropriate files with `git add`
4. Create a commit with a clear, concise message that:
   - Starts with a verb (add, fix, update, refactor, etc.)
   - Explains the "why" not just the "what"
   - Is under 72 characters for the first line
5. Run `git log -1` to confirm the commit was created
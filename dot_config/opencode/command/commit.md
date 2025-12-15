---
description: Create meaningful commits for current branch modifications
model: anthropic/claude-haiku-4-5
---

Create meaningful commits for the current branch modifications.

Here is the current git status:
!`git status`

Here are the staged changes:
!`git diff --cached`

Here are the unstaged changes:
!`git diff`

Analyze these changes and create well-structured, atomic commits with clear and descriptive commit messages following conventional commit format (feat:, fix:, docs:, refactor:, test:, chore:, etc.).

If there are multiple logical changes, suggest splitting them into separate commits. Stage and commit the changes accordingly.

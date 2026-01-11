---
description: Create a GitHub pull request for the current branch
model: anthropic/claude-haiku-4-5
---

Create a GitHub pull request for the current branch.

Here is the current branch:
!`git branch --show-current`

Here is the default base branch:
!`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main"`

Here is the remote tracking status:
!`git status -sb`

Here are the commits on this branch not yet merged:
!`git log $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")..HEAD --oneline 2>/dev/null || echo "Could not determine commits"`

Here is the diff stat from the base branch:
!`git diff --stat $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")...HEAD 2>/dev/null || echo "Could not determine diff"`

Analyze these changes and create a pull request with:
1. A clear, descriptive title
2. A comprehensive description summarizing the changes

IMPORTANT: Do NOT include a "Files Created" or "Files Modified" section in the PR description. Focus only on the summary and context of the changes.

If the branch is not pushed to remote yet, push it first with `git push -u origin <branch>`.

Use `gh pr create` to create the pull request.

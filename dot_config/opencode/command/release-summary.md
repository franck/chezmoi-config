---
description: Generate a French summary of the latest Product release PR for non-technical people
---

You are helping me generate a summary of the latest product release for non-technical stakeholders.

### Step 1: Find Recent Pull Requests

Fetch the last 10 merged pull requests from this repository:

```bash
gh pr list --state merged --limit 10 --json number,title,body,mergedAt,author --jq '.[] | {number, title, body, merged: .mergedAt, author: .author.login}'
```

### Step 2: Identify the Product Release PR

From the list above, find the most recent PR that contains "Product release" in its title (case-insensitive).

If no matching PR is found, inform the user and stop.

### Step 3: Get Full PR Details

For the identified PR, retrieve:
1. Full PR description: `gh pr view <PR_NUMBER> --json body,title,mergedAt,url`
2. Files changed: `gh pr diff <PR_NUMBER> --name-only`
3. Commits included: `gh pr view <PR_NUMBER> --json commits --jq '.commits[].messageHeadline'`

### Step 4: Generate French Summary

Create a summary in French that:
- Is written for non-technical people (avoid technical jargon completely)
- Uses simple, clear language that anyone can understand
- Highlights what changed from a user's perspective (not developer perspective)
- Focuses on the impact and benefits for end users

Group changes into these categories (only include sections that have content):

- **Nouvelles fonctionnalités** (New features) - New capabilities users can now use
- **Améliorations** (Improvements) - Enhancements to existing features
- **Corrections de bugs** (Bug fixes) - Problems that have been fixed
- **Autres changements** (Other changes) - Anything else noteworthy

Format the summary as:

```markdown
# Résumé de la mise à jour - [Date in French format, e.g., "15 décembre 2025"]

### Nouvelles fonctionnalités
- [Feature 1 - explain what users can now do]
- [Feature 2]

### Améliorations
- [Improvement 1 - explain how this makes things better for users]

### Corrections
- [Fix 1 - explain what problem was resolved]

---
*Source: PR #[number] - [PR URL]*
```

Present the summary and ask if I want to:
1. Save it to a file (suggest `release-summary-[date].md`)
2. Make adjustments to the content
3. Translate specific sections differently

---
description: Check and fix RuboCop issues in the codebase
---

You are helping me fix RuboCop linting issues. Follow this workflow:

### Step 1: Run RuboCop to identify issues

First, run RuboCop to see all current issues:

!`bundle exec rubocop`

### Step 2: Analyze the issues

Review the RuboCop output and categorize the issues:

- **Auto-correctable**: Issues that can be safely auto-fixed
- **Manual fixes needed**: Issues requiring code changes that need human judgment
- **False positives**: Issues that might need to be disabled or configured

### Step 3: Auto-fix safe issues

Run RuboCop with auto-correct for safe fixes:

```bash
bundle exec rubocop -a
```

This will fix issues that are safe to auto-correct (formatting, style, etc.).

### Step 4: Handle remaining issues

For issues that weren't auto-fixed:

1. Read the relevant files to understand the context
2. Apply appropriate fixes following Ruby best practices
3. If an issue seems like a false positive, explain why and suggest a rubocop:disable comment if appropriate

### Step 5: Verify fixes

After making changes, run RuboCop again to confirm all issues are resolved:

```bash
bundle exec rubocop
```

### Guidelines

- Prefer fixing issues over disabling cops
- When fixing, maintain the original intent and functionality of the code
- Group related fixes together for cleaner commits
- Explain any non-obvious fixes you make
- If a cop seems misconfigured for the project, suggest .rubocop.yml changes instead of inline disables

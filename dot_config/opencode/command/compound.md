---
description: Analyze conversation to compound learnings into ai-rules
---

## Prerequisites

!`test -f AGENTS.md && echo "AGENTS.md: EXISTS" || echo "AGENTS.md: MISSING - run /init first"`

!`ls ai-rules/*.md 2>/dev/null || echo "ai-rules/: NOT FOUND (will be created)"`

If AGENTS.md is MISSING, stop and ask the user to create one first.

---

## Task

Analyze this conversation to identify learnings that should improve the project's ai-rules. Focus on:

1. **Questions you asked** that better rules would have answered
2. **Corrections** the human made to your code or approach
3. **Patterns** that emerged and should be documented
4. **Anti-patterns** that caused problems

---

## Output

For each learning:

### Learning: [title]

- **Category**: Question Avoided | Correction | New Pattern | Anti-Pattern
- **Target File**: `ai-rules/[file].md` (use `general.md` if unsure)
- **Proposed Rule**: [exact text to add]
- **Rationale**: [one sentence]

---

## Apply Changes

After proposing, read only the target files you need to modify, then apply the changes.

If `ai-rules/` doesn't exist, create it with `general.md`.

Start minimal - add to `general.md` first. Only create new files when a category has 3+ rules.

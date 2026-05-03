---
description: Safely review and record chezmoi-managed dotfile updates
---

Help me manage my chezmoi updates safely, especially when template files may be involved.

Start by gathering context:

```bash
chezmoi status
chezmoi diff
```

For every modified target file shown by `chezmoi status`, resolve its source path:

```bash
chezmoi source-path <target-file>
```

Classify each changed file as one of:

- Plain source file: source path does not end with `.tmpl`
- Template source file: source path ends with `.tmpl`
- Unmanaged or ambiguous: `chezmoi source-path` fails or the mapping is unclear

Important safety rules:

- Do not blindly run `chezmoi add` on files backed by `.tmpl` sources.
- For template-backed files, inspect the template source and update the template logic directly.
- Preserve template directives, conditionals, variables, comments, and platform-specific logic.
- Do not replace a template with a rendered concrete file unless I explicitly ask for that.
- For plain source files, prefer `chezmoi add --dry-run --verbose <files>` before applying.
- If multiple unrelated changes exist, group them logically and explain what each group contains.
- If there are secrets, credentials, tokens, private keys, or machine-specific values, stop and ask before adding anything.
- If a source path is unmanaged or ambiguous, stop and explain the issue.

Workflow:

1. Show a concise summary of all changed files from `chezmoi status`.
2. Show which files are plain and which are template-backed.
3. Review `chezmoi diff` and summarize the user-facing meaning of the changes.
4. For plain files, propose the exact `chezmoi add --dry-run --verbose ...` command.
5. Run the dry-run before the real add.
6. Only run the real `chezmoi add` after the dry-run confirms the expected source files will be updated.
7. For template-backed files, edit the `.tmpl` source directly and verify the rendered result with `chezmoi diff`.
8. Finish by running:

```bash
chezmoi status
chezmoi diff
```

Report whether the chezmoi working state is clean.

If chezmoi automatically creates a git commit or pushes to a remote as part of my setup, mention the commit hash and remote push result.

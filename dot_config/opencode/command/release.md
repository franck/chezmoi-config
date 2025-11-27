---
description: Bump gem version and create release
---

Bump the gem version to $1. Follow these steps:

1. Find the version file (typically `lib/*/version.rb` or `lib/version.rb`) and update the VERSION constant to $1
2. Find the gemspec file (*.gemspec) to know the gem name
3. Update `CHANGELOG.md` if it exists:
   - Add a new section for version $1 with today's date
   - Move any unreleased items under the new version
   - Document changes since the last release (check git log for commits since the last tag)
   - Update the release links at the bottom of the file if they exist
4. Commit with message "Bump version to $1"
5. Build the gem using the gemspec file found in step 2
6. Tag the release with `git tag v$1`

Report what was done and remind the user to:
- `git push && git push --tags`
- `gem push <gem-name>-$1.gem` (if publishing to RubyGems)

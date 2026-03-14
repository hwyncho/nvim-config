---
name: update-issue
description: Update the GitHub issue linked to the current branch based on commit history and project conventions.
allowed-tools: Bash, Read, Grep, Glob
---

# Update Issue Skill

Update the GitHub issue associated with the current branch. Analyze commit history and compose an appropriate issue title and body following the project conventions.

## Steps

1. Read the "Issues" section of `CONTRIBUTING.md` to understand the issue writing rules.
2. Identify the issue number from the current branch name (e.g., `issue/85` → `#85`). If the branch name does not follow the `issue/{number}` pattern, ask the user for the issue number. If there is no linked issue, inform the user that this skill requires an existing issue and stop.
3. Run `gh issue view <number>` to check the current issue state and label.
4. Determine the appropriate issue template from `.github/ISSUE_TEMPLATE/` based on the label (`feature`, `enhancement`, `bug`).
5. Run `gh issue list --state closed --limit 5 --json number,title,body` to reference recent closed issues for style.
6. Run `git log dev..<current-branch> --format="%H %s"` to list all commits in the branch.
7. For each commit, run `git diff-tree --no-commit-id --name-only -r <hash>` to identify changed files.
8. Analyze the commits and compose an issue title and body:
   - Title: Korean, clearly describes the purpose.
   - Body: Korean, follows the matched template structure, with checkboxes marked as completed (`[x]`).
9. Run `gh issue edit <number> --title "<title>" --body "<body>"` to update the issue.

## Issue Rules

The format, templates, and writing rules for issues are defined in the "Issues" section of [`CONTRIBUTING.md`](../../../CONTRIBUTING.md).

## Important Notes

- The issue title must be in Korean.
- The issue body must be in Korean.
- Use the template that matches the issue's existing label (`feature`, `enhancement`, `bug`). If no label is set, infer the appropriate template from the commit content.
- Mark all completed work items with `[x]` checkboxes.
- List all affected files under the "영향받는 파일" section.
- Pass the body via a HEREDOC to preserve formatting.
- If there is no linked issue, inform the user and stop without making changes.

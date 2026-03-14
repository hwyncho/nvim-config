---
name: create-pr
description: Create a GitHub pull request from the current branch, following the project conventions. Usage: /create-pr [base-branch]
allowed-tools: Bash, Read, Grep, Glob
---

# Create PR Skill

Create a GitHub pull request from the current branch. Analyze commit history and compose an appropriate PR title and body following the project conventions.

## Arguments

- `base-branch` (optional): The target branch for the PR. If not provided, defaults to the repository's default branch (detected via `gh repo view --json defaultBranchRef`).

## Steps

1. Determine the base branch:
   - If the user provided an argument (e.g., `/create-pr dev`), use that as the base branch.
   - If no argument is provided, detect the default branch via `gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'`.
2. Read the "Pull Requests" section of `CONTRIBUTING.md` to understand the PR writing rules.
3. Identify the issue number from the current branch name (e.g., `issue/85` → `#85`). If the branch name does not follow the `issue/{number}` pattern, ask the user for the issue number. The user may answer that there is no linked issue.
4. Run `git log <base-branch>..<current-branch> --format="%H %s"` to list all commits in the branch.
5. Run `git diff <base-branch>..<current-branch> --stat` to see the overall change summary.
6. Run `gh pr list --state closed --limit 5 --json number,title,body` to reference recent closed PRs for style.
7. Check if the branch is up to date with the remote (`git status -sb`). If not pushed, run `git push origin <branch>`.
8. Determine the appropriate TYPE from the commits (e.g., `feat`, `enhance`, `fix`, `docs`).
9. Compose the PR title and body:
   - With issue: Title format `#<ISSUE_NUMBER> [<TYPE>] <Summary>`, body Issue section uses `Closes #<number>`.
   - Without issue: Title format `[<TYPE>] <Summary>`, body Issue section uses `없음`.
   - Title: English.
   - Body: Korean, follows the template structure from `CONTRIBUTING.md` (Issue, Changes, Why we need this, Test Plan).
10. Run `gh pr create --base <base-branch> --head <branch> --title "<title>" --body "<body>"` to create the PR.

## PR Rules

The format, TYPE, and writing rules for pull requests are defined in the "Pull Requests" section of [`CONTRIBUTING.md`](../../../CONTRIBUTING.md).

## Important Notes

- The PR title must be in English.
  - With issue: `#<ISSUE_NUMBER> [<TYPE>] <Summary>`
  - Without issue: `[<TYPE>] <Summary>`
- The PR body must be in Korean.
- The body must include the sections: Issue, Changes, Why we need this, Test Plan.
- Use `Closes #<number>` in the Issue section to auto-close the linked issue on merge. If there is no linked issue, write `없음`.
- Pass the body via a HEREDOC to preserve formatting.
- If there are uncommitted or unstaged changes, warn the user before proceeding.
- If a PR already exists for the branch, inform the user instead of creating a duplicate.

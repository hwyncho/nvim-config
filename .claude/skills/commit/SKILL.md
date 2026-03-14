---
name: commit
description: Review staged changes and create a commit with a message following the project conventions.
allowed-tools: Bash, Read, Grep, Glob
---

# Commit Skill

Review the currently staged changes and create a commit with an appropriate message following the project conventions.

## Steps

1. Read the "Commit Messages" section of `CONTRIBUTING.md` to understand the commit message rules.
2. Run `git diff --cached` to review the staged changes.
3. Run `git log --oneline -10` to reference recent commit message style.
4. Analyze the changes and compose a commit message following the rules in `CONTRIBUTING.md`.
5. Execute the commit.

## Commit Message Rules

The format, TYPE, and writing rules for commit messages are defined in the "Commit Messages" section of [`CONTRIBUTING.md`](../../../CONTRIBUTING.md).

## Important Notes

- Do NOT include a `Co-Authored-By` trailer.
- Only inspect staged changes; ignore unstaged and untracked files.
- Warn the user if staged files contain secrets (`.env`, credentials, etc.).
- If there are no staged changes, do not commit and inform the user.
- Pass the commit message via a HEREDOC.

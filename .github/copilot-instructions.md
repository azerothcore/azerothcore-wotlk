# Copilot instructions for AzerothCore

Project conventions live in `AGENTS.md`, which routes to the task-scoped guides in `.agents/docs/`. Follow those.
For pull request review, `.agents/docs/code-review.md` defines what counts as a finding and how to report it.

## Review output

- No overview paragraph, no "Changes" bullet list, no per-file table. The diff is on the same page.
- Findings belong in inline comments on the offending lines, not in the review body.
- When there are no findings, post only a single line saying so. No summary, no file list.

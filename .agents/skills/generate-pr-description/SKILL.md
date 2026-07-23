---
name: generate-pr-description
description: Generate the PR title and description from the current branch changes, following the repo's PR template.
metadata:
  version: "1.0"
---

# Generate PR description

Produce a copy-pasteable PR title and body for the current changes, based on the repo's
`pull_request_template.md`. Output text only — never create the PR, push, or run any
state-changing git command.

If a `use-conversational-language` skill is available, invoke it and follow it when writing the
prose. If not available, fetch it from its [remote source](https://github.com/eai-org/agent-toolkit/blob/main/skills/use-conversational-language/SKILL.md).

## Gather the changes

"The changes" is the union of:

- committed branch work: `git diff <master-ref>...HEAD`, where `<master-ref>` is `origin/master` —
  or `upstream/master` when the checkout is a fork with an `upstream` remote;
- staged and unstaged changes;
- the branch's commit messages (context only).

If all three are empty, say so and stop.

## Facts, never assumptions

Only two sources may fill the description: the diff and facts stated in the conversation. Never
present anything else as fact — no assumed testing, sources, issue links, or TODOs. A section
without backing facts stays empty/unchecked, silently: an empty section is correct, a guessed one
is wrong.

Ask the user only when unsure about substance — what the change does, which scope the title should
carry, contradictory information. Missing fill-in facts are never a reason to ask.

## Title

`type(Scope/Subscope): short description` — imperative, max 50 chars. Types: `feat`, `fix`,
`refactor`, `style`, `docs`, `test`, `chore`; scopes: `Core`, `Scripts`, `DB`. Copy subscope naming
from recent commits touching the same areas (`git log --oneline -- <paths>`).

## Body

Fill in `pull_request_template.md` (repo root):

- Strip the instructional `<!-- -->` comments; keep the "How to Test AzerothCore PRs" footer
  intact.
- Describe what the changes do and why.
- "Changes Proposed" checkboxes, from diff paths: `src/server/scripts/` → Scripts; `data/sql/` →
  Database; other `src/` → Core.
- AI disclosure checkbox: always tick it; name the agent/model running this skill and state
  whether AI produced the changes themselves or only this description, per the conversation.
- Issues Addressed, SOURCE, Tests Performed, How to Test, Known Issues/TODO: stated facts only
  (see above).

## Output

Print exactly:

~~~
TITLE: <title>

PR DESCRIPTION:
```markdown
<body>
```
~~~

# Self-review rules

Project-specific rules for
[/self-review](https://github.com/eai-org/agent-toolkit/blob/main/skills/self-review/SKILL.md).
Add here rules about reviewing AzerothCore PRs before they are submitted. Generic improvements
to the review process itself belong to the skill, not here. The [code-review.md](code-review.md)
rules apply on top.

## Pinned review

The report is pasted into the PR, so the review must be pinned to a commit: uncommitted changes
(except local-only tweaks) block the run, and fixes from a round are committed before the next one.

## Regression risk

Automated test coverage is near zero, so this review is the main safety net against regressions.
Every change gets the full review; go deeper the farther it can reach:

- Shared core C++ (`src/server/game/`, `src/common/`, widely-included headers): one fix can
  break unrelated features — examine how the changed code is used elsewhere, not just the
  change itself.
- Content scripts (`src/server/scripts/`) and modules: impact is mostly contained — worst case
  is usually the one boss, spell, or module touched.
- SQL: beyond the usual review, watch for the classic side effect — a DELETE/UPDATE whose
  WHERE clause catches rows it shouldn't.

## Upstream attribution

Any changed code, mechanism, or data mirrored from another core must carry that upstream commit's
author via `--author` (extras as `Co-authored-by`) with the template's cherry-pick box checked; a
missing credit is a finding.

## In-game testing

PRs are expected to be tested in-game, which the reviewer cannot do. Never guess what the
author already tested — ask them, and record the answer in the report. Then tell them what
else to test — especially side effects they might not expect: a fix for X that also reaches Y
means testing Y too. When the author's tested scenario matches the change's main path, probe
the branches it doesn't take — regressions hide there. Invite them to ask questions if
anything is unclear.

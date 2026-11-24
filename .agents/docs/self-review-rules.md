# Self-review rules

Project-specific rules for
[/self-review](https://github.com/eai-org/agent-toolkit/blob/main/skills/self-review/SKILL.md).
Add here rules about reviewing, opening and updating AzerothCore PRs. Generic improvements to
the review process itself belong to the skill, not here. The [code-review.md](code-review.md)
rules apply on top.

## Pinned review

The report is pasted into the PR, so the review must be pinned to a commit: uncommitted changes
(except local-only tweaks) block the run, and fixes from a round are committed before the next one.

## Pushing

- Once a PR has review comments, add commits; never amend, rebase, squash or force-push: that
  orphans inline review threads, and the squash merge makes tidying pointless. Fix a stale commit
  body in the PR description instead. Force-push only when a maintainer asks or agrees.
- Draft PRs get no build or codestyle CI: core builds (pch, nopch and the e2e run they trigger),
  modules build, codestyle, SQL codestyle and Dashboard CI all skip drafts. Mark the PR ready for
  review before asking for review or merge; that starts the core builds, plus the modules build and
  codestyle checks whose paths the diff touches. Dashboard CI waits for the next push. Windows,
  macOS, tools and Docker builds need the `run-build` label and start only on a push or on adding
  the label once the PR is ready.

## PR description

- Fill every section of `pull_request_template.md`: area boxes, AI disclosure naming the tools and
  models, the issue link when an issue exists. Test results, the Tests Performed boxes and the
  agentic-engineering box come only from the author: ask, never fill them in, and keep the boxes
  consistent with what the report records. An AI-assisted PR also needs this report posted on it. A
  missing section or report is a finding.
- Check title and description against the current diff before asking for review, and after every
  push that makes them wrong: reviewers check the code against the description. Drop files, APIs or
  approaches that are gone; fix stale How to Test steps and `Closes` links. Name every change a
  player or reviewer could miss, side effects included (removed SAI rows, dropped calls, changed
  chances or timings), with its reason, including reasons so far given only in a review thread.
- Check the change against every item and complaint in each linked issue, again after rework that
  changes what the PR does, and fix missing in-scope items. `Closes #N` only when nothing in the
  issue remains; otherwise `Refs #N` with the remainder listed in the description.

## Claims and evidence

Author-side counterpart of code-review.md's "never take a claim as fact": every claim in the
description, commit messages and code comments is verified or labeled a hypothesis.

- Root cause and mechanism: traced through current engine code.
- "Reproduces/crashes on master": a repro or crashlog from unmodified master.
- Upstream parity or provenance ("as TrinityCore does", "lost in the port"): the current upstream
  source and its commit history, not an old diff.
- Retail behavior ("leftover spawn", "not on retail", timings): sniffs or another named source.

Conflicting sources are stated, never silently resolved.

- Bot review comments (CodeRabbit, Copilot) are unverified claims: check each against the code,
  current master and the data (world DB, DBC, the rows the change replaces) before applying it;
  never adopt a bot's value or mechanic without a source. Resolve a bot thread only with a code
  change or a reply saying why it doesn't apply.

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
- Generic SmartAI action or target, flag, check or formula: query the world DB (`smart_scripts`,
  templates), DBC data and scripts for every existing user the change reaches. Fix or retarget
  those that would change wrongly in the same PR, or narrow the change to the smallest class that
  needs it (creatures, not units; ownerless traps, not all traps; faction bits, not
  `IsHostileTo`). The description gives the rough count of affected users; How to Test names a
  few concrete ids outside the original target.
- Root cause in a shared data property (a DBC attribute or value, a spell category, a spell
  several creatures cast): query the other entries sharing it and list each in the PR as fixed
  here, unaffected or out of scope (and why), or left for a follow-up. Fix extras only when the
  same change covers them and they can be tested.
- Fixing a regression, or reverting or reordering an earlier fix: diff the offending commit and
  list everything it dropped or changed beyond the headline symptom; restore each, or record in
  the report why it stays out. Ask the author to retest in-game the scenario the earlier PR was
  merged for.

## Attribution

Missing credit is a finding:

- Code, mechanism or data mirrored from another core: credited per AGENTS.md, the template's
  cherry-pick box ticked, and each upstream commit (repo + hash or link) listed under SOURCE. Credit
  the code's author, not a fork that carried it.
- Code, SQL or data someone else wrote and the PR takes in (a reviewer's commit or patch,
  sniff-derived SQL posted in a comment), even adapted: `Co-authored-by` on that commit. Taking up
  only their idea or review suggestion needs no credit.
- Credit missing once pushed, even an upstream `--author`: never rewrite history; add a follow-up
  commit with one `Co-authored-by: Name <email>` trailer per author, which the squash merge keeps.
  Only that plain form registers, never a markdown link or @mention.

## In-game testing

PRs are expected to be tested in-game, which the reviewer cannot do. Never guess what the
author already tested — ask them, and record the answer in the report. Then tell them what
else to test — especially side effects they might not expect: a fix for X that also reaches Y
means testing Y too. When the author's tested scenario matches the change's main path, probe
the branches it doesn't take — regressions hide there. Invite them to ask questions if
anything is unclear.

- Saved or reloaded state read or applied differently (instance lockouts and saved respawns,
  character data sent at login, config values): ask for a test on state predating the update (a
  lockout made before it, an old value still in a live `worldserver.conf`, which a `.dist` change
  doesn't rewrite), and again after a relog or `.reload`, not only on fresh state. An old value
  that now changes behavior is a finding.
- Results from before a mechanism change no longer count: ask to retest the affected scenarios.
- An applied bot fix that changes runtime behavior needs a retest through its natural in-game
  trigger, not a GM command or helper that bypasses that path.

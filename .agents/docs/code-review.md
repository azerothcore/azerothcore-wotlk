# Code review

Reviewing a changeset or PR, your own before submission or a contributor's. The core docs each changed
file routes to, plus every `systems/` doc whose Read-also trigger the diff matches, apply as a checklist to
every changed line, not as background reading.

## Posting

- A posted review carries findings only: no summary, no praise. Nothing to report means one line saying so.
- Label `To Be Merged` only on a merge-ready PR, approved or not; remove `Ready to be Reviewed` in the
  same step.
- A finding names what is wrong, why it matters and the fix, on the offending line. Findings are bugs,
  crashes, lifetime and memory errors, data-integrity problems, injection, and violations of a rule
  written in AGENTS.md or `.agents/docs/`; taste no rule covers is not a finding.

## What to check

- Codestyle on every changed line, even when style is not the change's subject. Run both linters and
  report violations as findings: `python apps/codestyle/codestyle-cpp.py` and
  `python apps/codestyle/codestyle-sql.py`.
- Title and description follow `.git_commit_template.txt`: the title says what the change does, in the
  imperative (`Correct X loot`); the symptom goes in the description.
- Prefer data over code: when a C++ or script change is also achievable through world DB data (SmartAI,
  conditions, templates), flag the DB-only alternative (see `cpp-scripts.md`).
- Never take a claim as fact, the PR description's or a comment's. Verify game-data claims
  (spell/creature/quest ids, mechanics) against the world DB, DBC data or cited sources; verify "fixed
  in the latest push" against the current diff.
- When a change touches control flow (early returns, new branches, removed guards), trace the states it
  can leave behind (null, empty, fall-through) into every consumer, including unchanged lines the new
  flow now reaches, and verify what runs when an acquire/attack/GetX call leaves a null result, not just
  what enables it.
- Check the change is still needed against current `master`: the surrounding code may have moved, or
  another change may have landed the same fix.

## Existing PR discussion

Walk every discussion item one by one, bot reviews included: what was raised, whether it was answered,
and whether it still applies to the current head. Never skip one because it looks resolved, old or
minor; this overrides any read-comments-lightly default of the reviewing skill. `gh pr view` misses
review bodies and inline threads; pull all three:

```
gh api repos/azerothcore/azerothcore-wotlk/issues/<N>/comments --paginate  # conversation comments
gh api repos/azerothcore/azerothcore-wotlk/pulls/<N>/reviews --paginate    # review verdicts + bodies
gh api repos/azerothcore/azerothcore-wotlk/pulls/<N>/comments --paginate   # inline comments
```

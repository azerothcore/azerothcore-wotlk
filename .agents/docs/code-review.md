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
  imperative (`Correct X loot`); the symptom goes in the description. The title becomes the squash
  commit subject; its scope names where the fix lives, first segment capitalized (`DB`, `Core`, `Scripts`;
  never `db/`):
  - `DB/<Area>` for SQL-only changes (`DB/Creature`, `DB/Spell`, `DB/Command` for command help);
    `DB/Base` only for `data/sql/base`.
  - `Core/<System>` for core C++ (outside `src/server/scripts`).
  - `Scripts/<Area>` for `src/server/scripts`.
  - Mixed C++ and SQL takes the scope of the code carrying the fix. Re-check the scope whenever the fix
    moves (e.g. from SAI to C++).
- A change the PR's subject does not need (a rename, cleanup, build or link tweak, a new module hook, a CI
  change, unsourced data, an extra content fix riding along) is a finding: move it to its own PR or drop
  it. A rename PR carries only the mechanical change. Generic changes the subject depends on to work are in
  scope, and so are changes another rule in these docs requires.
- Prefer data over code: when a C++ or script change is also achievable through world DB data (SmartAI,
  conditions, templates), flag the DB-only alternative (see `cpp-scripts.md`).
- Never take a claim as fact, the PR description's or a comment's. Verify game-data claims
  (spell/creature/quest ids, mechanics) against the world DB, DBC data or cited sources; verify "fixed
  in the latest push" against the current diff.
- Every ticked SOURCE box links its evidence (sniff, video, live research, public source) for each claimed
  blizzlike value or behavior; whoever changes that value next needs its origin.
- Never attach or paste a raw parsed sniff dump, or a large excerpt, into a description, comment or
  report: it carries the sniffer's character, account and realm identifiers. Quote only the values the
  change relies on (coordinates, spell ids, a CreateObject or waypoint row).
- When a change touches control flow (early returns, new branches, removed guards), trace the states it
  can leave behind (null, empty, fall-through) into every consumer, including unchanged lines the new
  flow now reaches, and verify what runs when an acquire/attack/GetX call leaves a null result, not just
  what enables it.
- Check the change is still needed against current `master`: the surrounding code may have moved, or
  another change may have landed the same fix.
- Check overlap with open PRs too: the same linked issue, functions or files, or persisted state (e.g.
  fields appended to an instance save string). Each is a finding naming the other PR, the collision (same
  fix, merge conflict, incompatible save format) and which PR should keep the shared change.

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

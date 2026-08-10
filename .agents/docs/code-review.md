# Code review

Reviewing a changeset or PR, your own before submission or a contributor's. The task-scoped docs
(`cpp-guidelines.md`, `sql-guidelines.md`, `cpp-scripts.md`) apply as a checklist to every changed
line, not as background reading.

- A posted review carries findings only: no summary, no praise. Nothing to report means one line
  saying so.
- A finding names what is wrong, why it matters and the fix, on the offending line. Findings are
  bugs, crashes, lifetime and memory errors, data-integrity problems, injection, and violations of
  a rule written down in AGENTS.md or `.agents/docs/`; taste no rule covers is not a finding.
- Review codestyle on every changed line, even when style is not the change's subject. Run both
  linters and report violations as findings: `python apps/codestyle/codestyle-cpp.py` and
  `python apps/codestyle/codestyle-sql.py`.
- Title and description follow the [commit message guidelines](https://www.azerothcore.org/wiki/commit-message-guidelines).
- Prefer data over code: when a C++ or script change is also achievable through world DB data
  (SmartAI, conditions, templates), flag the DB-only alternative (see `cpp-scripts.md`).
- Never take a claim as fact, neither the PR description's nor a comment's. Verify game-data
  claims (spell/creature/quest ids, mechanics) against the world DB, DBC data, or cited sources;
  verify "fixed in the latest push" against the current diff.
- Check the change is still needed against current `master`: the surrounding code may have moved,
  or another change may have landed the same fix.
- On an existing PR, walk every discussion item one by one: what was raised, whether it was
  answered, and whether it still applies to the current head. Never skip one because it looks
  resolved, old, or minor; this walk overrides any read-comments-lightly default of the reviewing
  skill. `gh pr view` misses review bodies and inline threads; pull all three:

  ```
  gh api repos/azerothcore/azerothcore-wotlk/issues/<N>/comments --paginate  # conversation comments
  gh api repos/azerothcore/azerothcore-wotlk/pulls/<N>/reviews --paginate    # review verdicts + bodies
  gh api repos/azerothcore/azerothcore-wotlk/pulls/<N>/comments --paginate   # inline comments
  ```

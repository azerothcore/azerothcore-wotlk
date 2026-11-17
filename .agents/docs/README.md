# .agents/docs

Task-scoped agent guidance, split so an agent reads only the docs whose trigger matches its task. Keep every doc
compact and agent-agnostic.

## Taxonomy

- Core docs — root, kebab-case (`build.md`, `cpp-guidelines.md`, `sql-guidelines.md`, …), routed from AGENTS.md's
  "Read also". Only rules nearly every change in that language or area needs.
  `<lang>-<topic>.md` is reserved for language-scoped specializations (e.g. `cpp-scripts.md`).
- Topic docs — `systems/`, plain kebab-case topic names (e.g. `smartai.md`), routed from the "Read also" list
  ending each core doc that serves them, or from AGENTS.md's when no core doc does. Rules only some changes need;
  aim for ~20-60 lines each.

## Triggers

- Routing bullets read `<trigger> → <doc>`.
- A trigger must be checkable from the task itself: file paths/globs (`src/server/game/Spells/**`), SQL table
  names (`smart_scripts`, `*_loot_template`), script base classes (`SpellScript`, `InstanceScript`). Never vague
  ("when working on combat").

## Placing new guidance

- The most specific applicable doc wins; each rule lives in exactly one doc.
- Generic language lesson → the core language doc (e.g. generic C++ → `cpp-guidelines.md`).
- Rule only some changes need → the matching topic doc; create it if missing.
- Extend an existing doc before creating a new one.
- A new doc REQUIRES its routing bullet in the same change: core doc → AGENTS.md's "Read also"; topic
  doc → the "Read also" list of each core doc that serves it (AGENTS.md's when none does).

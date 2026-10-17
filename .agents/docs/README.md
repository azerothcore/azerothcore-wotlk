# .agents/docs

Task-scoped agent guidance, routed from AGENTS.md's "Mandatory reading per task". Keep every doc
compact and agent-agnostic.

## Taxonomy

- Root — task-type docs (`build.md`, `cpp-guidelines.md`, `sql-guidelines.md`, …), kebab-case.
  `<lang>-<topic>.md` is reserved for language-scoped specializations (e.g. `cpp-scripts.md`).
- `systems/` — cross-language subsystem docs, plain kebab-case subsystem names
  (e.g. `battleground.md`).

## Placing new guidance

- The most specific applicable doc wins.
- Generic language lesson → the language doc (e.g. generic C++ → `cpp-guidelines.md`).
- Subsystem-specific lesson → `systems/<subsystem>.md`; create it if missing.
- Extend an existing doc before creating a new one.
- A new doc REQUIRES adding its routing bullet to AGENTS.md's "Mandatory reading per task" in the
  same change.

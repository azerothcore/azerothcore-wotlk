# Core changes

Engine C++ under `src/` outside `src/server/scripts/` and `src/test/`.

## Where to fix

- Before choosing where to fix a core bug, check who else reaches it: other callers, opcodes (e.g. both pet-cast
  opcodes) or react states, other creatures or spells sharing the spell or data. When the shared mechanism is wrong
  (range check, parser, cooldown reporting, spell attribute), fix it there, or fix the existing send rather than adding
  a parallel one.
- While the correct generic behavior is unknown, a scoped correction (e.g. `SpellInfoCorrections`) covering every
  affected entry is acceptable.
- A change (movement, AI, spells, combat, factions) gating on a broad property (combat reach, `IsHostileTo`/faction
  masks, attack type, spell family, target type): first list the templates, spawns or spells matching it in the world
  DB or DBC, then narrow the condition to the intended cases. Wide on purpose → say so in the PR with a source. Never
  swap a correct generic fix for a per-content hack to narrow it.
- New code with existing siblings (other cases of the same switch, e.g. SmartAI actions; other sends of the same
  packet; other hooks of the same kind; the core class it parallels) matches them in discriminator, argument values,
  target narrowing (e.g. `ToCreature()` for movement actions), guards and hook registration. Explain deliberate
  differences; raise siblings that look wrong rather than copying them.

## Optional features

An optional (non-retail-default) feature ships behind a real switch defaulting to off (usually a `CONFIG_*` plus a
documented `worldserver.conf.dist` key), never a stub returning a constant. Gate every behaviour change on it, small
ones in shared paths (packet handlers, map or visibility code) included. Switched off, the server behaves exactly as
before, with no per-tick work and no feature state.

## Runtime state and DB rows

- **Runtime-growing maps/sets** (an entry per account, session or disconnect): the removal path must not depend on the
  key showing up again. Erase a read-once entry when read, and sweep stale entries on a timer, like the `_disconnects`
  and `_offlineSessions` cleanup in `WorldSessionMgr::UpdateSessions`. Fill the map only while its reading feature is
  enabled.
- **DB rows in step with memory**: write a one-time guard or dedupe row only after the guarded action succeeded (check
  e.g. `StoreNewItemInBestSlots`'s return first). A new setter for a persisted field also saves it, through the gate the
  class's other writes use (e.g. `ArenaTeam`'s `CanSaveToDB` check in `SaveToDB`). Never let a placeholder or sentinel
  guid reach `SaveToDB`. Remove an entry from a watch or cleanup list (e.g. `m_itemSoulboundTradeable`) only after its
  flags and DB rows are cleared; while its state is undecided, keep it and retry next tick.

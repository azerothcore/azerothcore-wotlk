# Retail evidence

## Sources

- Retail values (timings, repeat intervals, summon lifetimes, probabilities, counts, caps, spawn sets, spawn positions
  and orientation, faction, waypoints, text triggers, who casts what on whom, cast order, facing) come from parsed
  sniffs: WotLK first (WotLK Classic 3.4.x included), else TBC, Cata Classic or retail where that content is unchanged.
  Use the median/range over several captures. Split by mode, entry or add type exactly where the sniffs differ and
  nowhere else (no 10/25 split or uniform value they don't show).
- No sniff → another core's data, with upstream credit. Check upstream cores (TrinityCore, cMaNGOS) against sniffs
  where they exist, and recompute a ported or adapted formula's numbers. Keep behaviour that matches TrinityCore unless
  evidence shows retail differs.
- Videos and guides are weaker than sniffs: cross-check them against each other and TrinityCore.
- A spell id missing from Wowhead is inconclusive: check the world DB's `spell_dbc` table (server-side spells) before
  concluding a sniffed id doesn't exist.
- Cite a source for every value presented as retail: a sniff, TrinityCore, or a video whose timestamps you re-checked.
  With none, including a reasoned fix to unsniffed data, flag it in the PR as a guess, never as retail or
  sniff-backed, so reviewers know a sniff is still needed.

## Mechanism

Reproduce the mechanism the sniff shows (spell chain, cast sequence), not a workaround that only hides the symptom:
delayed turns, fallback targets, hand-tuned timers, a triggered flag used just to skip a failing check.

A fault in a core mechanism other entries share (range check, parser, cooldown reporting, spell attribute) is fixed
in core, never masked with per-entry SQL, conditions or scripts: "prefer data over code" is for content, not core
defects.

## Coordinates

Coordinates (`creature`, `gameobject`, SAI/script summon and move targets, `areatrigger_teleport`): sniffed or upstream
sniff-backed values whenever they exist. Without them, anchor to world objects (move to the closest gameobject or
creature at contact distance); hand-picked or in-game-estimated coordinates are a last resort, flagged in the PR.

- Copy position, orientation and gameobject rotation unrounded: rounded quaternions can fail startup validation.
- Sniffed `creature` rows also take `CreateObject` and `VerifiedBuild` from the sniff (`gameobject` has no
  `CreateObject`).
- The PR says where the coordinates came from.

## Unit flags and stand state

- `unit_flags`, `unit_flags2`, `dynamicflags` and stand state (template or spawn columns, SAI set/remove-flag actions,
  C++ `SetUnitFlag*`/`RemoveUnitFlag*`/`ReplaceAllUnitFlags*`/`SetDynamicFlag`/`SetStandState`): set or clear only with
  sniff or upstream evidence (the same flag in another script is none). A sniff showing the flag absent → get the
  behaviour another way (e.g. a creature that must not start attacks: On Respawn Set ReactState Passive instead of
  `IMMUNE_TO_NPC`). Leave flags unrelated to the fix untouched.
- AC-only fields (`flags_extra`, `AIName`) can't be sniffed and are out of sniff scope. Change `flags_extra` only when
  the fix needs it, and say why.

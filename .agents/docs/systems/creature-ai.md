# Creature AI

C++ creature AI: `ScriptedAI`/`BossAI` scripts and the AI bases in `src/server/game/AI/`.

## Helpers

- Timed actions: `EventMap` (event id → delay; simple) or `TaskScheduler` (lambdas, repeats, cancellation), both
  `CreatureAI` members; never hand-rolled tick counters.
- Casts: prefer the `DoCast` helpers (`DoCastSelf`, `DoCastVictim`, `DoCastAOE`, …) over `me->CastSpell`, which stays
  for positional casts or custom `CastSpellExtraArgs`.

## Trigger and helper NPCs

- Trigger NPCs (`creature_template.flags_extra` 0x80) have no threat list: `SelectTarget` / `AddThreat` /
  `UpdateVictim` chains on them silently do nothing.
- A never-evading helper NPC left on a boss's threatened-by list stalls the boss's evade/reset forever; make such
  helpers `IMMUNE_TO_NPC`, with the evidence `retail-evidence.md` requires for unit flags.

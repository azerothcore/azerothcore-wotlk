# Creature AI

C++ AI: `ScriptedAI`/`BossAI`/`GameObjectAI` scripts and the AI bases in `src/server/game/AI/`.

Fix one creature in its own script, never in a shared base AI (`VehicleAI`, …) every other user inherits: melee added
to `VehicleAI` would make every drivable cannon and catapult swing.

## Helpers

- Timed actions: prefer `TaskScheduler` (`scheduler`, lambdas) over the legacy `EventMap` (`events`), both
  `CreatureAI` members; unconditional simple sequences (e.g. RP lines) can be lambdas on
  `me->m_Events.AddEventAtOffset`. Never hand-rolled tick counters.
- Casts: prefer the `DoCast` helpers (`DoCastSelf`, `DoCastVictim`, `DoCastAOE`, …) over `me->CastSpell`, which stays
  for positional casts or custom `CastSpellExtraArgs`.
- Caster kept at range: `AttackStartCaster(who, <hard-coded dist>)`, not a distance computed from `SpellInfo`.
- Difficulty in a raid-only `ScriptedAI`: `Is25ManRaid()`, not `me->GetMap()->Is25ManRaid()`. It skips the raid
  check, so in a heroic dungeon it returns true: keep the map call in scripts that also run in dungeons.

## Trigger and helper NPCs

- Trigger NPCs (`creature_template.flags_extra` 0x80) have no threat list: `SelectTarget` / `AddThreat` /
  `UpdateVictim` chains on them silently do nothing.
- A never-evading helper NPC left on a boss's threatened-by list stalls the boss's evade/reset forever; make such
  helpers `IMMUNE_TO_NPC`, with the evidence `retail-evidence.md` requires for unit flags.

## Lifecycle

- `Reset()` runs from `InitializeAI`, on the first update after spawn, on every respawn (from `Creature::Respawn` and
  again from the default `JustRespawned()`, which temp summons skip) and on every evade (`EnterEvadeMode`). So:
  - Cancel combat timers there: a `ScriptedAI` with an empty or missing `Reset()`, or an override skipping
    `_Reset()`, keeps the `scheduler`/`events` work queued in `JustEngagedWith` through an evade, and re-aggro
    doubles it.
  - Clear script state flags there.
  - Never do one-time work there: no staging/activation sequences (resume from persisted state, see
    `instance-scripts.md`). A blanket `m_Events.KillAllEvents()`/`CancelAll()` there also kills anything queued at
    spawn. Arm a DB spawn's per-spawn work in a `JustRespawned()` override after calling `Reset()`.
- When a run ends early (`JustDied`, quest/escort NPCs killed mid-event included; a wipe or evade; just before
  scheduling an outro), cancel what it started that the base helpers don't clear: `scheduler` and `events` in a plain
  `ScriptedAI`; `me->m_Events` (`BossAI::_JustDied` leaves it alone), cleared before queuing the outro on it. At every
  cancel site, also reset each in-progress or latch flag whose reset depended on a cancelled timer, or the next
  attempt does nothing or a late ability fires during the outro.
- Logic that must run on every death (encounter or boss notifications) belongs in `JustDied` (guarded when needed,
  e.g. against feign death), not only in `DamageTaken`: that fires only from `Unit::DealDamage`, so deaths through
  `Unit::Kill` (GM `.die` in its default mode, `KillSelf()`) skip it.

## Holding at 1 HP

Clamp in `DamageTaken` (`if (damage >= me->GetHealth()) damage = me->GetHealth() - 1;`) or call
`SetInvincibility(true)` (`ScriptedAI`/`BossAI`); never zero the damage and `SetHealth(1)`. `SetInvincibility` works
only if a `DamageTaken` override calls `ScriptedAI::DamageTaken` (`BossAI`'s does).

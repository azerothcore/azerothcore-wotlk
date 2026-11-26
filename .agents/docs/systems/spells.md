# Spells and summons

## SpellInfoCorrections

`SpellInfoCorrections.cpp` overrides DBC spell data, and most of its entries are hacks. For any
change to it:

- Needing a correction is a sign the motivating claim may be wrong: re-verify the claim (issue,
  comment) against sniffs or DBC data before overriding.
- Compare with what the file mostly corrects: attributes, targets, radii, effects. Timing overrides
  (duration, amplitude) are rare and maintainers flag them; they need source evidence.
- Prefer a DB-side fix (e.g. a `conditions` entry) giving the same behavior. Never repurpose an effect (e.g. stun
  aura to snare). Keep a justified override minimal, ready to defend each added attribute in the PR.
- When a spell shared by several casters misbehaves from its own data, fix the root-cause field here once (e.g.
  `SpellLevel` for `SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL`), not with a per-caster script or by clearing the
  attribute.

## Spell scripts and data

- A `SpellScript`/`AuraScript` without a matching `spell_script_names` row is inert: ship the binding SQL update in
  the same change as the C++ registration.
- Drop one guid from a target list with `targets.remove_if(Acore::ObjectGUIDCheck(guid, true))`.
- A random summon point landing inside geometry: an `OnDestinationTargetSelect` Z-fix taking the height from above
  (`GetMapHeight(x, y, casterZ + margin)`), not pathfinding retries (e.g. `spell_xt002_recharge_robot`).

## Summons

- When a `spell_dbc`/DBC spell already encodes a mechanic (summoning a GO or creature at a position, the summon's
  entry and duration, a script-effect cast back to the caster), cast it and react in hooks (`JustSummoned`,
  `SpellHit`); never summon directly or copy its entries, placement or durations into C++.
- A summon from a spell with no usable duration (`GetDuration() <= 0`: no duration index, or index 21 = -1) never
  expires: give it `DespawnOrUnsummon(<lifetime>)` with a sniffed or otherwise sourced lifetime, never a guess, in
  `JustSummoned` or in the summon's AI where its lifetime starts (e.g. after a mine detonates). Encounter cleanup
  (`SummonList` despawn on reset or finish) doesn't replace it; use that cleanup only where the sniff shows retail
  removing the summons (e.g. on wipe). `BossAI` does so by default (`JustSummoned` adds every summon to `summons`,
  which `_Reset`/`_JustDied` despawn): keep those retail lets expire after a kill out of
  `BossAI::JustSummoned`/`summons`.
- A creature's `SummonGameObject` with the default `GO_SUMMON_TIMED_OR_CORPSE_DESPAWN` and a slot-summon spell
  (`SPELL_EFFECT_SUMMON_OBJECT_SLOT*`) tie the gameobject to the caster, which deletes it on despawn or leaving the
  world; a wild summon (`SPELL_EFFECT_SUMMON_OBJECT_WILD`) doesn't. Summon loot chests and other gameobjects that must
  outlive the boss through the map (`me->GetMap()->SummonGameObject(...)`, preferred) or at least with
  `GO_SUMMON_TIMED_DESPAWN`, even when a slot-summon spell encodes them. The map call spawns in `PHASEMASK_NORMAL`: in
  a phased encounter, set the phase on the returned object.

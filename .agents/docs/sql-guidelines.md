# SQL guidelines

## Adding SQL updates

1. `cd data/sql/updates/pending_db_world/` (or `pending_db_auth` / `pending_db_characters`).
2. `./create_sql.sh` generates an empty `rev_<timestamp>.sql` to write into.
3. Conventions (linted): every `INSERT` preceded by a matching `DELETE` (idempotency); spawn `DELETE` and `UPDATE`
   (`creature`, `gameobject`) target that table alone (no join, comma list or schema qualifier) and filter on both `id`
   and `guid` with `=`/`IN`/`BETWEEN`, never `OR`; no double semicolons; no multiple blank lines; InnoDB engine.

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-sql.py` (compares to origin/master).
When a local world DB is available, also import the file into it: CI's worldserver dry-run fails on a file the updater
can't apply.

## Not linted

- Never `REPLACE INTO`; write `DELETE` + `INSERT`. Never `UPDATE` a primary-key column onto a key some DBs may already
  hold (hand hotfixes, rows copied from TrinityCore): the duplicate key aborts the import and worldserver won't start.
  `DELETE` both the old and the target key, then `INSERT`.
- `INSERT` in Keira3 output format: explicit backticked column list (all columns for `smart_scripts`), `VALUES` ending
  that line, one row per line.
- Column names per the current schema: base files can be stale, so check later `ALTER`s in `data/sql/updates/` (e.g.
  `creature.id` is `id1` in base; there is no `Entry`). An `UPDATE` meant for one row names every primary-key column
  (e.g. `spell_target_position`: `ID` and `EffectIndex`). Watch for a trailing comma in `IN (...)`.
- Check the current data (base plus merged updates) and the code reading it first. Drop an `UPDATE` setting the value
  already present; data the core never reads (e.g. `gossip_menu_option_locale` `OptionText` for an option with an
  `OptionBroadcastTextID`, `BoxText` with a `BoxBroadcastTextID`: each is read only if its broadcast text is missing);
  `DELETE`s or `UPDATE`s of guids that don't exist (the idempotency `DELETE` before an `INSERT` excepted); respawn
  conditions (`SourceTypeOrReferenceId` 29) for entries with no spawns; condition rows already present verbatim.
- Deleting, moving or renumbering rows also fixes their dependents in the same update: SmartEvent `conditions`;
  `creature_text_locale` rows of moved or removed `creature_text` groups; `waypoint_data` paths no longer referenced
  from SQL or C++.
- Flag columns (`flags_extra`, `unit_flags`, `unit_flags2`, `npcflag`, `dynamicflags`, …): set bits with `x` = `x` | N,
  clear with `x` = `x` & ~N, keeping the row's other bits, sniffed values included. Assign an absolute value only when
  the whole field is the intended data, e.g. a deliberate template reset such as `npcflag` = 0. A `creature` spawn's
  `npcflag`, `unit_flags` or `dynamicflags` of 0 means the template's value: compute a spawn edit from that effective
  value; writing 0 there restores inheritance, it never clears. A comment naming the bits spells them as the
  defines header does (`UNIT_FLAG_SWIMMING` in `UnitDefines.h`). Typos and invented names ship with the
  comment, so read it back before committing.
- New `creature`/`gameobject` guids: prefer free gaps (Keira3's unused-guid finder, or a gap query over base, merged
  updates and `pending_db_world`) over appending past the max, and confirm each is unused: the idempotency `DELETE` on
  `guid` and `id` leaves a different entry on that guid, so the import fails on a duplicate `PRIMARY` key.
- Sniff-backed changes stamp `VerifiedBuild` (the sniff's client build) on every row the sniff validated, including
  rows the fix doesn't otherwise touch. Rows written from non-sniff sources (videos, estimates, hand-made waypoints,
  community or machine translations, memory) get `VerifiedBuild` 0, or omit it on `INSERT`. Replacing a stamped row's
  sniff-validated content (positions, path, spell list, locale text) with non-sniff data resets its stamp to 0.
- A fix to a creature, spell or quest reaches every variant, even when only one showed the bug: each
  `difficulty_entry_*` template, the per-difficulty spell ids (10/25-man, normal/heroic: conditions,
  `spell_script_names`, SpellInfo corrections), the other faction's quest. Per-variant values still follow the sniffs;
  `flags_extra` must match across variants: the engine reads the base or the difficulty entry depending on call site.
  A `conditions` row matches the base `creature_template` entry: `Creature::InitEntry` keeps the base entry in
  every difficulty, so one row covers the `difficulty_entry_*` variants.

## The three databases

- `acore_auth` — accounts, realm list, IP/account bans, session keys. Shared across all realms.
- `acore_characters` — per-character state: characters, inventory, in-progress quests, mail, guilds, arena teams,
  achievements. One per realm.
- `acore_world` — static game content: creature/gameobject/item/quest templates, spawn lists, loot tables, SmartAI
  scripts, gossip, conditions. Read-mostly; rebuilt from SQL.

## Read also

- `smart_scripts`, SmartEvent `conditions` (`SourceTypeOrReferenceId` 22), or an `AIName` → `systems/smartai.md`,
  the "Scope of a fix" section of `cpp-scripts.md` and "Trigger and helper NPCs" in `systems/creature-ai.md`
- A creature summon in an instance map (any SAI summon action or cast of a summon spell, `creature_summon_groups`) →
  `systems/instance-scripts.md`
- `creature_template`, `creature_template_model`, `*_template_addon`, `gameobject_template`, `quest_template`,
  `creature_immunities`, `*_loot_template` → `systems/templates.md`
- `waypoint_data`, `waypoints`, `script_waypoint`, `path_id`/`MovementType`/`wander_distance` columns of
  `creature`/`creature_addon`/`creature_template_addon`/`creature_template`, `creature_template_movement`,
  `creature_movement_override`, `creature_template.speed_*`, or SAI movement and root/fly/hover actions
  (53, 60, 69, 103, 113, 204, 207, 232, 233, `RANDOM_MOVE`) → `systems/movement.md`
- `spell_script_names` → `systems/spells.md`
- `waypoint_data` → `systems/waypoints.md`
- Porting rows from TrinityCore/cMaNGOS/tbc-db, or deleting `smart_scripts`/clearing `AIName` for a C++ script →
  `systems/ports-and-rewrites.md`

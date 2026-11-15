# SQL guidelines

## Adding SQL updates

1. `cd data/sql/updates/pending_db_world/` (or `pending_db_auth` / `pending_db_characters`).
2. `./create_sql.sh` generates an empty `rev_<timestamp>.sql` to write into.
3. Conventions (linted): every `INSERT` preceded by a matching `DELETE` (idempotency); spawn `DELETE` and `UPDATE`
   (`creature`, `gameobject`) target that table alone (no join, comma list or schema qualifier) and filter on both `id`
   and `guid` with `=`/`IN`/`BETWEEN`, never `OR`; no double semicolons; no multiple blank lines; InnoDB engine.

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-sql.py` (compares to origin/master).

## Not linted

- Sniff-backed changes stamp `VerifiedBuild` (the sniff's client build) on every row the sniff validated, including
  rows the fix doesn't otherwise touch.
- Set `flags_extra` on every `difficulty_entry_*` template, not only the base entry: whether the engine reads the base
  or the difficulty entry varies by call site.

## The three databases

- `acore_auth` — accounts, realm list, IP/account bans, session keys. Shared across all realms.
- `acore_characters` — per-character state: characters, inventory, in-progress quests, mail, guilds, arena teams,
  achievements. One per realm.
- `acore_world` — static game content: creature/gameobject/item/quest templates, spawn lists, loot tables, SmartAI
  scripts, gossip, conditions. Read-mostly; rebuilt from SQL.

## Read also

- `smart_scripts` or an `AIName` → `systems/smartai.md`, and the "Scope of a fix" section of `cpp-scripts.md`
- SmartAI on a trigger NPC (`flags_extra` 0x80) or a helper NPC that never evades → "Trigger and helper NPCs" in
  `systems/creature-ai.md`
- A summon (SAI 12 or 107, `creature_summon_groups`) in an instance map → "ObjectData slots" in
  `systems/instance-scripts.md`
- `creature_template`, `creature_template_model`, `creature_immunities` → `systems/templates.md`
- `spell_script_names` → `systems/spells-and-summons.md`
- Adding/changing a retail value (spell ids, `unit_flags`/`unit_flags2`/`dynamicflags` incl. SAI set/remove-flag
  actions) → `systems/retail-evidence.md`

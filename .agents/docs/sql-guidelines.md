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

## The three databases

- `acore_auth` — accounts, realm list, IP/account bans, session keys. Shared across all realms.
- `acore_characters` — per-character state: characters, inventory, in-progress quests, mail, guilds, arena teams,
  achievements. One per realm.
- `acore_world` — static game content: creature/gameobject/item/quest templates, spawn lists, loot tables, SmartAI
  scripts, gossip, conditions. Read-mostly; rebuilt from SQL.

## Read also

- `smart_scripts` or an `AIName` → `systems/smartai.md`, the "Scope of a fix" section of `cpp-scripts.md` and
  "Trigger and helper NPCs" in `systems/creature-ai.md`
- A creature summon in an instance map (any SAI summon action or cast of a summon spell, `creature_summon_groups`) →
  `systems/instance-scripts.md`
- `creature_template`, `creature_template_model`, `creature_immunities` → `systems/templates.md`
- `spell_script_names` → `systems/spells.md`
- `waypoint_data` → `systems/waypoints.md`

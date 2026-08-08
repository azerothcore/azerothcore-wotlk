# SQL guidelines

## Adding SQL updates

1. `cd data/sql/updates/pending_db_world/` (or `pending_db_auth` / `pending_db_characters`).
2. `./create_sql.sh` generates an empty `rev_<timestamp>.sql` to write into.
3. Conventions (linted): every `INSERT` preceded by a matching `DELETE` (idempotency); no double semicolons; no multiple blank lines; InnoDB engine.

Run the linter before claiming a change is done: `python apps/codestyle/codestyle-sql.py` (compares to origin/master).

## Data conventions

- `smart_scripts` edits always rewrite the full `entryorguid` block (`DELETE` + `INSERT` of every row) — never a partial `UPDATE`, not even for a comment-only fix.
- `creature_immunities`: immunity sets are single-reference. Before minting a new id, check whether an existing set already matches; to extend a creature's immunities, create a superset instead of editing a shared set. Negative ids are curated — don't allocate them.

## The three databases

- `acore_auth` — accounts, realm list, IP/account bans, session keys. Shared across all realms.
- `acore_characters` — per-character state: characters, inventory, in-progress quests, mail, guilds, arena teams, achievements. One per realm.
- `acore_world` — static game content: creature/gameobject/item/quest templates, spawn lists, loot tables, SmartAI scripts, gossip, conditions. Read-mostly; rebuilt from SQL.

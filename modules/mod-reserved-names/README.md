# mod-reserved-names

Blocks character creation when the requested name is reserved for a **different** account. The account that owns the reservation may always claim their name.

## What it does

When a player attempts to create a character:

1. The module reads the requested name from the `CMSG_CHAR_CREATE` packet.
2. It queries `acore_auth.reserved_character_names` for that name.
3. If no reservation exists → creation is allowed normally.
4. If the reservation belongs to the requesting account → creation is allowed (the rightful owner).
5. If the reservation belongs to a **different** account → creation is rejected with `CHAR_CREATE_DISABLED` and a warning is logged.

## Where the reservation table lives

`acore_auth.reserved_character_names`

The table lives in `acore_auth` (not `acore_characters`) so it survives a full wipe of `acore_characters`. The module creates the table automatically on worldserver startup.

## How to populate reservations before wipe

Run this query while **both** databases are still intact — before wiping `acore_characters`.

Only characters that reached **level 60 or higher** are reserved:

```sql
INSERT INTO acore_auth.reserved_character_names (
  name,
  account_id,
  original_guid,
  race,
  class,
  gender
)
SELECT
  name,
  account,
  guid,
  race,
  class,
  gender
FROM acore_characters.characters
WHERE level >= 60
ON DUPLICATE KEY UPDATE
  account_id    = VALUES(account_id),
  original_guid = VALUES(original_guid),
  race          = VALUES(race),
  class         = VALUES(class),
  gender        = VALUES(gender);
```

Characters below level 60 are not inserted and their names are not reserved.

## Configuration

Copy `conf/mod_reserved_names.conf.dist` to your server's `conf/` directory (or wherever AzerothCore loads `.conf` files from) and adjust as needed.

| Key | Default | Description |
|-----|---------|-------------|
| `ReservedNames.Enable` | `1` | Master switch. Set to `0` to disable all checks. |
| `ReservedNames.DeleteReservationOnSuccessfulClaim` | `0` | When `1`, the reservation row is deleted after the rightful owner claims the name. When `0`, the row is kept for audit. |

For launch, keep `DeleteReservationOnSuccessfulClaim = 0` to retain the full audit trail.

## How to test

1. Apply the SQL above (or insert a manual reservation):
   ```sql
   INSERT INTO acore_auth.reserved_character_names (name, account_id)
   VALUES ('Arthas', 1);
   ```
2. Log in as **account 2** (not account 1) and try to create a character named `Arthas`.
   - Expected: creation is rejected.
   - Check worldserver log for: `[ReservedNames] Account 2 attempted to create character with name 'Arthas', which is reserved for account 1. Creation denied.`
3. Log in as **account 1** and create a character named `Arthas`.
   - Expected: creation succeeds.
   - Check worldserver log for: `[ReservedNames] Account 1 successfully claimed reserved name 'Arthas'.`
4. Verify that unreserved names create normally for any account.

## Notes

- Name comparison is case-insensitive because `normalizePlayerName` (the same function the core uses) is applied before the lookup.
- The module uses `LoginDatabase` (i.e., `acore_auth`) for all reservation queries. No changes to `acore_characters`.
- If `CanPacketReceive` fires but `CanAccountCreateCharacter` is never reached (name rejected earlier for being invalid/in-use), the pending-name entry for that account is simply overwritten on the next attempt.

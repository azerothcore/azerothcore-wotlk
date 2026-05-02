# mod-nostrum-hardcore

Optional Hardcore and Self-Found Hardcore system for NostrumWoW (AzerothCore 3.3.5a).

Players can opt into Hardcore on a **fresh character** using dot commands. Hardcore is a permanent-death challenge. Self-Found adds additional restrictions that prevent all player-to-player item/gold exchanges.

---

## What the module does

- Adds `.hardcore` dot commands for players and GMs.
- Tracks all active and fallen Hardcore characters in a separate DB.
- Applies a cosmetic buff and title (configurable) to active Hardcore characters.
- Re-applies the buff and title on login if missing.
- Announces opt-ins, deaths, and level milestones to all online players.
- Fallen characters remain connected as **permanent ghosts**. Resurrection is blocked.
- Automatically adds confirmed Hardcore characters to the **Deathwalkers** guild.
- Provides a leaderboard via `.hardcore leaderboard`.
- Tracks Self-Found eligibility flags before and after opt-in.

---

## Hardcore vs Self-Found Hardcore

| Feature                | Hardcore       | Self-Found     |
|------------------------|---------------|----------------|
| Death permanent        | Yes           | Yes            |
| Fallen = permanent ghost | Yes         | Yes            |
| Trading allowed        | Yes           | **No**         |
| Player mail allowed    | Yes           | **No**         |
| Auction House allowed  | Yes (buy+sell)| **No** (buy blocked; see limitations) |
| PvP optional           | Yes           | Yes            |
| Cosmetic buff          | Configurable  | Configurable   |
| Cosmetic title         | Configurable  | Configurable   |
| Auto-joined to guild   | Deathwalkers  | Deathwalkers   |

---

## Player commands

| Command | Description |
|---------|-------------|
| `.hardcore enable` | Start the Hardcore opt-in confirmation flow |
| `.hardcore selffound` | Start the Self-Found opt-in confirmation flow |
| `.hardcore confirm` | Confirm and activate Hardcore (60-second window) |
| `.hardcore status` | Show your current Hardcore status and stats |
| `.hardcore rules` | Display the full Hardcore ruleset |
| `.hardcore leaderboard` | Show the top Hardcore characters |

### Eligibility to opt in

Both modes require:
- Character is level 1 with **exactly 0 XP**.
- Character has 0 deaths.
- Character has less than 10 minutes `/played` (configurable).
- Character is not already Hardcore.

Self-Found additionally requires:
- Character has not initiated a trade with another player.
- Character has not sent player mail.
- Character has not received player mail.
- Character has not interacted with the Auction House.

---

## GM commands

Requires `SEC_GAMEMASTER` or higher.

| Command | Description |
|---------|-------------|
| `.hardcore info <player>` | Show detailed Hardcore status for a character |
| `.hardcore revive <player>` | Restore a fallen character to Active status (intended for bug deaths only) |
| `.hardcore remove <player>` | Remove Hardcore status from a character (emergency; SEC_ADMINISTRATOR) |

`.hardcore revive` is the **only** intended way to restore a fallen Hardcore character. It bypasses the resurrection block intentionally.

---

## PvP behavior

- PvP is **optional**. The module does not force PvP flag on Hardcore characters.
- Use the normal **in-game PvP toggle** (right-click your character portrait) to enable or disable PvP.
- If a Hardcore character **is PvP-flagged** and dies in World PvP, the death counts.
- Deaths in **Battlegrounds** and **Arenas** always count (these are voluntary PvP activities).
- **Duel deaths do not count.** In standard WoW 3.3.5a, duels bring the loser to 1 HP — they do not result in actual death.

---

## Fallen characters — permanent ghosts

When a Hardcore character dies:

1. They are marked **Fallen** in the database.
2. Their Hardcore buff and title are removed.
3. A global death announcement is broadcast.
4. The character stays **connected** — they are not kicked.
5. The character remains in **ghost state** permanently.
6. **Resurrection is blocked** — spirit healer, corpse reclaim, spells, and GM workarounds are all blocked. Only `.hardcore revive` can restore them.

On login, a fallen character:
- Enters the world normally as a ghost.
- Sees the message: *"This Hardcore character has fallen. You may remain as a ghost, but resurrection is permanently disabled."*
- Cannot be revived through any normal game action.

Fallen characters are **not removed** from the Deathwalkers guild.

---

## Deathwalkers guild

When a character confirms Hardcore, they are automatically added to the **Deathwalkers** guild.

- If the guild does not exist, it is created automatically with the first Hardcore joiner as guild leader.
- Guild MOTD is set to: *"Welcome to Deathwalkers. One life. No excuses. Help each other survive."*
- If the character is already in a guild, they receive a message and are not moved automatically.
- On login, guildless active Hardcore characters are re-added if possible.
- Fallen characters remain in the guild and are not removed automatically.

Guild behavior is configurable — see `Hardcore.AutoGuild.*` options.

---

## Config options

See `conf/mod_nostrum_hardcore.conf.dist` for the full list. Key options:

| Option | Default | Description |
|--------|---------|-------------|
| `Hardcore.Enable` | 1 | Master switch |
| `Hardcore.MaxPlayedSecondsToEnable` | 600 | Max played seconds to opt in |
| `Hardcore.FallenStayGhost` | 1 | Fallen characters stay as permanent ghosts (not kicked) |
| `Hardcore.BlockFallenResurrection` | 1 | Block all resurrection for fallen characters |
| `Hardcore.SoulOfIronSpellId` | 0 | Spell ID for HC buff (0 = disabled) |
| `Hardcore.SelfFoundSoulOfIronSpellId` | 0 | Spell ID for SF buff (0 = disabled) |
| `Hardcore.TitleId` | 0 | Title ID for Regular Hardcore (0 = disabled) |
| `Hardcore.SelfFoundTitleId` | 0 | Title ID for Self-Found Hardcore (0 = disabled) |
| `Hardcore.MilestoneLevels` | 10,20,40,60,70,80 | Levels that trigger announcements |
| `Hardcore.SelfFound.BlockTrade` | 1 | Block trading for Self-Found |
| `Hardcore.SelfFound.BlockAuctionHouse` | 1 | Block AH bidding for Self-Found |
| `Hardcore.SelfFound.BlockPlayerMail` | 1 | Block player mail for Self-Found |
| `Hardcore.AutoGuild.Enable` | 1 | Auto-add to Hardcore guild on confirm |
| `Hardcore.AutoGuild.Name` | Deathwalkers | Guild name (created if missing) |
| `Hardcore.AutoGuild.MOTD` | *(see conf)* | MOTD set when the guild is created |

### How to configure cosmetic spell IDs

1. Create a custom spell in the `spell_dbc` override table or via a DBC edit tool.
   - The spell must be a passive aura with **no stat bonuses, no combat effects, no XP or gold**.
   - Recommended: use a visual-only aura or a permanent dummy spell.
2. Note the spell ID.
3. Set `Hardcore.SoulOfIronSpellId` and/or `Hardcore.SelfFoundSoulOfIronSpellId` in the config.
4. If the spell ID is `0`, the buff system is skipped silently.

### How to configure cosmetic title IDs

1. Find a valid title ID in `CharTitles.dbc` or the `char_titles` table.
2. Set `Hardcore.TitleId` and/or `Hardcore.SelfFoundTitleId` in the config.
3. If the title ID is `0` or invalid, the title system is skipped and a warning is logged.

---

## SQL installation

The module creates its tables automatically at server startup via `CREATE TABLE IF NOT EXISTS`.
No manual SQL import is required.

Tables created:
- `mod_nostrum_hardcore` — main HC character records
- `mod_nostrum_hardcore_flags` — eligibility tracking flags for all characters
- `mod_nostrum_hardcore_milestones` — announced level milestone records

The SQL file at `data/sql/db-characters/base/mod_nostrum_hardcore.sql` is provided for reference and manual imports.

---

## Build and install

The module follows AzerothCore's standard module convention. No `CMakeLists.txt` is required in the module directory; the parent `modules/CMakeLists.txt` handles discovery.

1. Place the module in your `modules/` directory:
   ```
   modules/mod-nostrum-hardcore/
   ```
2. Configure and build normally:
   ```bash
   cmake .. -DMODULES=static
   make -j$(nproc)
   make install
   ```
3. Copy `conf/mod_nostrum_hardcore.conf.dist` to your config directory and rename to `mod_nostrum_hardcore.conf`.
4. Start the worldserver. Tables are created automatically.

---

## Known limitations

### AH listing cannot be blocked from module hooks

AzerothCore's module API provides `OnAuctionAdd` (fires **after** the auction is created) but no pre-creation hook. This means:
- **Bidding (buying) on the AH is blocked** for Self-Found characters via `CanPlaceAuctionBid`.
- **Listing (selling) on the AH cannot be cleanly blocked** at the module level. The module flags the character as having used the AH, preventing future Self-Found opt-in, but cannot cancel an existing listing.

### Mail cannot be undelivered from the sender's log

The mail hook `OnBeforeMailDraftSendMailTo` prevents delivery to Self-Found characters, but the mail item may still appear in the sender's sent log depending on client/server behaviour.

### Death hook architecture

Deaths are detected via three hooks that fire in order:
1. `OnPlayerKilledByCreature` — marks creature deaths, stores killer name.
2. `OnPlayerPVPKill` — marks PvP deaths, checks PvP flag / BG / arena.
3. `OnPlayerJustDied` — handles any remaining deaths as environmental.

Deaths not covered by hooks 1 or 2 are treated as environmental. GM-triggered deaths may be counted as environmental. Use `.hardcore revive` after any unintended test deaths.

### Resurrection blocking coverage

Two hooks block revival for fallen characters:
- `OnPlayerCanRepopAtGraveyard` — blocks spirit healer and graveyard respawn.
- `OnPlayerCanResurrect` — blocks spell-based and generic resurrection.

If a resurrection path is added to AzerothCore that does not call either hook, it may not be blocked. The `.hardcore revive` GM command intentionally bypasses both hooks by updating the DB status directly.

---

## Death rules summary

| Situation | Counts? |
|-----------|---------|
| Killed by a creature | Yes |
| Killed by an NPC | Yes |
| Fall damage | Yes |
| Drowning | Yes |
| Lava / fire | Yes |
| Fatigue | Yes |
| Battleground death | Yes |
| Arena death | Yes |
| World PvP (while PvP-flagged) | Yes |
| World PvP (while NOT PvP-flagged) | No |
| Duel loss | No (duels bring to 1 HP, not death) |

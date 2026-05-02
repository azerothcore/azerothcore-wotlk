# mod-nostrum-hardcore

Optional Hardcore and Self-Found Hardcore system for NostrumWoW (AzerothCore 3.3.5a).

Players can opt into Hardcore on a **fresh character** using dot commands. Hardcore is a permanent-death challenge. Self-Found adds additional restrictions that prevent all player-to-player item/gold exchanges.

---

## What the module does

- Adds `.hardcore` dot commands for players and GMs.
- Tracks all active and fallen Hardcore characters in a separate DB.
- Applies a cosmetic buff (configurable spell ID) to active Hardcore characters.
- Re-applies the buff on login if it is missing.
- Announces opt-ins, deaths, and level milestones to all online players.
- Locks fallen characters out of the world (kick on login).
- Provides a leaderboard via `.hardcore leaderboard`.
- Tracks Self-Found eligibility flags before and after opt-in.

---

## Hardcore vs Self-Found Hardcore

| Feature                | Hardcore       | Self-Found     |
|------------------------|---------------|----------------|
| Death permanent        | Yes           | Yes            |
| Trading allowed        | Yes           | **No**         |
| Player mail allowed    | Yes           | **No**         |
| Auction House allowed  | Yes (buy+sell)| **No** (buy blocked; see limitations) |
| PvP optional           | Yes           | Yes            |
| Cosmetic buff          | Soul of Iron  | Soul of Iron: Self-Found |

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
| `.hardcore pvp on` | Enable PvP flagging (PvP deaths then count) |
| `.hardcore pvp off` | Request PvP flag removal (subject to normal PvP timer) |

### Eligibility to opt in

Both modes require:
- Character is level 1.
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
| `.hardcore revive <player>` | Restore a fallen character to Active status (bug deaths only) |
| `.hardcore remove <player>` | Remove Hardcore status from a character (emergency; SEC_ADMINISTRATOR) |

---

## PvP behavior

- PvP is **optional**. The module does not force PvP flag on Hardcore characters.
- If a Hardcore character **is PvP-enabled/flagged** and dies in World PvP, the death counts.
- Deaths in **Battlegrounds** and **Arenas** always count (these are voluntary PvP activities).
- **Duel deaths do not count.** In standard WoW 3.3.5a, duels bring the loser to 1 HP — they do not result in actual death. The module adds an exemption in case of edge cases.
- Use `.hardcore pvp on` / `.hardcore pvp off` to toggle PvP flag.
- PvP disable follows the normal WoW PvP timer and cannot be used while in combat.

---

## Config options

See `conf/mod_nostrum_hardcore.conf.dist` for the full list. Key options:

| Option | Default | Description |
|--------|---------|-------------|
| `Hardcore.Enable` | 1 | Master switch |
| `Hardcore.MaxPlayedSecondsToEnable` | 600 | Max played seconds to opt in |
| `Hardcore.SoulOfIronSpellId` | 0 | Spell ID for HC buff (0 = disabled) |
| `Hardcore.SelfFoundSoulOfIronSpellId` | 0 | Spell ID for SF buff (0 = disabled) |
| `Hardcore.KickOnDeath` | 1 | Kick player immediately on HC death |
| `Hardcore.KickFallenOnLogin` | 1 | Block fallen characters from logging in |
| `Hardcore.MilestoneLevels` | 10,20,40,60,70,80 | Levels that trigger announcements |
| `Hardcore.SelfFound.BlockTrade` | 1 | Block trading for Self-Found |
| `Hardcore.SelfFound.BlockAuctionHouse` | 1 | Block AH bidding for Self-Found |
| `Hardcore.SelfFound.BlockPlayerMail` | 1 | Block player mail for Self-Found |

### How to configure cosmetic spell IDs

1. Create a custom spell in the `spell_dbc` override table or via a DBC edit tool.
   - The spell must be a passive aura with **no stat bonuses, no combat effects, no XP or gold**.
   - Recommended: use a visual-only aura or a permanent dummy spell.
2. Note the spell ID.
3. Set `Hardcore.SoulOfIronSpellId` and/or `Hardcore.SelfFoundSoulOfIronSpellId` in the config.
4. If the spell ID is `0`, the buff system is skipped silently. All other module features work normally.

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

Workaround: A future core patch could add a pre-auction-create hook. Until then, this is a documented limitation.

### Mail cannot be undelivered from the sender's log

The mail hook `OnBeforeMailDraftSendMailTo` prevents delivery to Self-Found characters, but the mail item may still appear in the sender's sent log depending on client/server behaviour.

### Kick delay is informational

The `Hardcore.KickDelaySeconds` config value is stored but not enforced as an actual delay. The kick happens as soon as the death message packet is sent. The player will see the message briefly before being kicked.

### Death hook architecture

Deaths are detected via three hooks that fire in order:
1. `OnPlayerKilledByCreature` — marks creature deaths, stores killer name.
2. `OnPlayerPVPKill` — marks PvP deaths, checks PvP flag / BG / arena.
3. `OnPlayerJustDied` — handles any remaining deaths as environmental.

This means deaths not covered by hooks 1 or 2 are treated as environmental. GM-triggered deaths (which don't go through creature or PvP kill paths) may be counted as environmental. If this is a concern, GMs should use `.hardcore revive` after any test deaths.

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

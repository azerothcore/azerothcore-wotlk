# NOSTRUM

## 1. Vision & Philosophy

NostrumWoW is a custom World of Warcraft 3.3.5a server built on AzerothCore. It is not a funserver and not a fully custom experience. It is a curated, progression-phased server designed to deliver a meaningful and community-driven WoW experience with selective quality-of-life improvements.

**Design principles:**

- **Blizzlike at the core.** The base game is preserved. Classes, combat, quests, dungeons, and raids behave as they did in 3.3.5a. No custom gear, no pay-to-win, no shortcuts that undermine the game.
- **Selective quality of life.** Improvements are allowed only where they reduce unnecessary friction without trivializing gameplay. Examples: starter bag, milestone gold rewards, early dual spec access, global chat channel.
- **Progression phasing.** The server advances through content phases with enforced level caps, giving each phase a distinct identity and allowing the community to experience content together.
- **Optional hardcore.** Players may voluntarily enter a hardcore or self-found mode. These are strictly opt-in and add high-stakes gameplay on top of the normal experience. They are not mandatory and do not affect other players.
- **Community-first design.** Systems are designed to encourage player interaction: cross-faction communication, shared chat channels, cross-faction dungeon finder, and community guilds for hardcore players.

---

## 2. Core Features Overview

| System | Status | Description |
|--------|--------|-------------|
| Progression phases | Active | Level cap enforced per phase (Phase 1: cap 19, phases 0–7 defined) |
| Hardcore mode | Active | Permanent death on opt-in characters |
| Self-Found Hardcore | Active | Hardcore variant with trade/AH/mail restrictions |
| Cross-faction RDF | Active | Requires `AllowTwoSide.Interaction.Group = 1` |
| Cross-faction BGs | Active | Mixed-faction BG teams via mod-cfbg |
| Cross-faction chat | Active | Shared `/world` channel and general communication |
| World channel | Active | Auto-join global channel on login |
| Starter bag | Active | One-time 12-slot bag granted on first login |
| Level-up gold rewards | Active | Gold mailed at levels 10, 20, 30 … 80 |
| BG XP rewards | Active | Configurable XP for BG completion with anti-AFK |
| Rate multipliers | Active | Centralized XP, reputation, loot, and money rates |
| Dual spec at 19 | Active | Dual specialization available from level 19 |
| New player guide NPC | Active | Faction-specific guide NPC in all starting zones |

---

## 3. Hardcore System

### Overview

Hardcore mode is an opt-in system. Any eligible player may choose to play as Hardcore or Self-Found Hardcore. Death is permanent — a fallen character remains in the world as a permanent ghost with resurrection disabled.

### Eligibility Requirements

A character must meet all of the following to opt in:
- Level 1
- Zero deaths
- Played time under the configured threshold (default: 10 minutes)

### Enabling Hardcore

Players use dot commands in-game:

```
.hardcore enable       — begin Hardcore mode
.hardcore selffound    — begin Self-Found Hardcore mode
.hardcore confirm      — confirm the selected mode (required within 60 seconds)
.hardcore status       — view current Hardcore status
.hardcore rules        — display the ruleset
.hardcore leaderboard  — show top active Hardcore characters by level
```

### Death Rules

The following death types count as permanent death:

| Type | Counts |
|------|--------|
| Creature kill | Yes |
| Environmental (fall, drown, lava, fatigue) | Yes |
| Battleground | Yes |
| Arena | Yes |
| World PvP (while PvP-flagged) | Yes |
| Duel loss | **No** |

### Death Behavior

- On death, the character's status is set to `Fallen`.
- The character remains online as a permanent ghost.
- Resurrection via spirit healer, spells, or items is blocked.
- GM revival is available via `.hardcore revive <player>`.

### Cosmetic Rewards (Configurable)

- **Aura/buff spell ID** applied on login (config: `Nostrum.Hardcore.SoulOfIronSpellId`, default: 0/disabled).
- **Title ID** assigned on opt-in (config: `Nostrum.Hardcore.TitleId`, default: 0/disabled).
- Separate spell and title IDs for Self-Found (`SelfFoundSoulOfIronSpellId`, `SelfFoundTitleId`).

### Chat Prefix

Active Hardcore characters have their chat messages prefixed:
- `[HC]` for Hardcore
- `[SF]` for Self-Found Hardcore

The prefix is prepended to the message text in all chat types (say, yell, party, raid, guild, whisper, channel).

### Self-Found Hardcore

Self-Found is a stricter variant of Hardcore. In addition to permanent death, the following restrictions apply:

| Feature | Restriction |
|---------|-------------|
| Direct trading | Blocked (both initiating and receiving) |
| Player-to-player mail | Blocked (both sending and receiving) |
| Auction House | Blocked (browsing and posting) |

These restrictions are enforced at the module level before the core processes the action.

### Auto-Guild: Deathwalkers

Hardcore characters are automatically invited to the `Deathwalkers` guild on opt-in if:
- Auto-guild is enabled (`Nostrum.Hardcore.AutoGuild.Enable`, default: 1)
- The guild exists and is cross-faction (`AllowTwoSide.Interaction.Guild = 1` required)

The guild name and MOTD are configurable.

### Announcements

- **Opt-in:** Broadcasted server-wide.
- **Death:** Broadcasted server-wide with character name, level, killer name, zone, and played time.
- **Level milestones:** Broadcasted server-wide at configurable levels (default: 10, 20, 30, 40, 50, 60).

### GM Commands

| Command | Access | Description |
|---------|--------|-------------|
| `.hardcore info <player>` | Gamemaster | View HC data for a character |
| `.hardcore revive <player>` | Gamemaster | Restore a fallen character |
| `.hardcore remove <player>` | Administrator | Remove HC status entirely |

---

## 4. Custom Systems & Modules

### mod-nostrum-progression

Enforces a server-wide level cap and content locks per progression phase. All gates are driven by a single `Nostrum.ActivePhase` value (0–7); no other config changes are needed when advancing phases.

**Level cap enforcement:**
- On login and on level-up, characters above the cap are reduced to the cap level.
- XP is zeroed out when the player is at or above the cap.
- GMs with security level ≥ 2 bypass all restrictions by default.
- A login announcement informs players of the current phase name and level cap.

**Content locks (all default on):**
- **Instances** — players cannot enter dungeon or raid portals that require a later phase. Portal entry and teleport-in are both blocked.
- **Login teleport** — if a player logs in inside a locked instance, they are moved to their homebind.
- **Battlegrounds** — queue registration and port-in are blocked for BGs that require a later phase.
- **LFG / Dungeon Finder** — queuing is blocked if any selected dungeon resolves to a locked map.

Phase 0 (Beta) bypasses all content locks entirely.

Key config:
```
Nostrum.ActivePhase                              = 1
Nostrum.Progression.GmBypass                    = 1
Nostrum.Progression.LockInstances               = 1
Nostrum.Progression.TeleportOutOfLockedMapsOnLogin = 1
Nostrum.Progression.LockBattlegrounds           = 1
Nostrum.Progression.LockLFG                     = 1
```

---

### mod-nostrum-rates

Centralizes all gameplay rate multipliers. Intended to be the single authority on rates — worldserver.conf rate settings should be set to 1.0 when this module is active.

Rates are **phase-driven**: a single `NostrumRates.ActivePhase` value (0–7) controls the entire XP scaling model. No manual bracket editing is needed when advancing phases.

**Phase table:**

| Phase | Level Range | Content |
|-------|------------|---------|
| 0 | — | Beta (flat `BetaRate` multiplier, default 3×) |
| 1 | 1–19 | Vanilla low |
| 2 | 19–29 | |
| 3 | 29–39 | |
| 4 | 39–49 | |
| 5 | 49–60 | Vanilla endgame |
| 6 | 60–70 | TBC |
| 7 | 70–80 | WotLK — DK creation unlocked |

**XP rate rules:**
- Active phase bracket → `CurrentPhaseRate` (default 1×, blizzlike)
- Previous phase brackets → `CatchUpRate` (default 2×, catch-up)
- Phase 0 → `BetaRate` flat everywhere (default 3×)
- Boundary levels (19, 29, etc.) resolve to the higher-numbered bracket

**Death Knight lock:** DK character creation is blocked while `ActivePhase < 7`. Controlled by `NostrumRates.BlockDKBeforePhase7`.

Controlled rate categories:
- **XP:** Kill, quest, exploration (all phase-scaled); battleground (flat, handled by mod-nostrum-bg-xp)
- **Reputation:** Kill and quest sources
- **Profession skill:** Gathering and crafting separately
- **Loot:** Creature, skinning, fishing, mining/herbalism, disenchanting, prospecting, milling
- **Money:** Creature gold loot
- **PvP:** Honor and arena points

Note: BG XP bypasses phase scaling intentionally (handled by mod-nostrum-bg-xp).

---

### mod-nostrum-bg-xp

Provides XP rewards for battleground completion with anti-AFK enforcement.

**XP calculation:**
```
XP = XPForLevel(level) × CompletionPercent × BracketMult × WinMult
```

- Win multiplier: 1.0 (default)
- Loss multiplier: 0.35 (default)
- Daily first win: 2.0× bonus applied on top

**Anti-AFK:** Players who do not meet minimum participation thresholds (damage dealt, healing done, or killing blows) receive reduced or no XP.

**Level range:** Applies between levels 10 and 79. Level 80 players receive no BG XP.

Per-BG type multipliers are configurable (WSG, AB, AV, EOTS, SOTA, IOC). Default completion percent is 3.5% of the player's level XP per BG.

---

### mod-nostrum-hardcore

See Section 3 for full documentation. Module files:
- `src/HardcoreManager.cpp` / `HardcoreManager.h` — core state machine, DB, eligibility
- `src/mod_nostrum_hardcore.cpp` — script hooks (player, world, AH, mail, misc, commands)

---

### mod-nostrum-crossfaction

Centralizes all cross-faction policy. Handles communication, grouping, economy, and startup validation for systems that require core config or external modules.

**Implemented via hooks:**
- World channel auto-join on login with configurable min speak level and cooldown
- Block manual cross-faction group invites (when `ManualGroups.Enable = 0`)
- Block cross-faction direct trades (when `Trading.Enable = 0`)

**Validated at startup (requires core config):**

| Feature | Required core config |
|---------|---------------------|
| Cross-faction chat | `AllowTwoSide.Interaction.Chat = 1` |
| Cross-faction channels | `AllowTwoSide.Interaction.Channel = 1` |
| Cross-faction /who | `AllowTwoSide.WhoList = 1` |
| Cross-faction AH | `AllowTwoSide.Interaction.Auction = 1` |
| Cross-faction RDF | `AllowTwoSide.Interaction.Group = 1` |
| Cross-faction guilds | `AllowTwoSide.Interaction.Guild = 1` |

**Cross-faction RDF mechanism:** When `AllowTwoSide.Interaction.Group = 1`, `LFGMgr::SetTeam()` normalizes all players to the same team, placing them in a shared LFG queue. No core patch required.

**Cross-faction BGs:** Handled by mod-cfbg. This module holds config flags and validates at startup.

---

### mod-cfbg

Third-party AzerothCore module. Enables mixed-faction battleground teams.

- Players temporarily change faction visually while inside a BG; original faction is preserved outside.
- Team assignment is based on team size and optionally average item level.
- Supports Wintergrasp cross-faction queueing.
- Optional race morphing to match assigned BG team.

Key config:
```
CFBG.Enable              = 1
CFBG.Battlefield.Enable  = 1
CFBG.BalancedTeams       = 1
```

Requires `Battleground.InvitationType = 0` in worldserver.conf.

---

### mod-nostrum-guide

Spawns faction-specific New Player Guide NPCs in all starting zones with interactive gossip menus explaining server rules, progression, and features.

| Faction | NPC | Entry | Starting Zones |
|---------|-----|-------|----------------|
| Alliance | Loremaster Caedric | 900001 | Northshire, Coldridge Valley, Shadowglen, Ammen Vale |
| Horde | Elder Gromak | 900002 | Valley of Trials, Deathknell, Camp Narache, Sunstrider Isle |

A visual cue gameobject (entry 149410) is spawned at each NPC location.

---

### mod-nostrum-starter

Grants a one-time starter reward to fresh level-1 characters on first login.

- Awards one **Nostrum Starter Bag** (custom item entry 900100, 12 slots).
- The bag is unsellable: `SellPrice = 0`, `ITEM_FLAG_NO_SELL_PRICE` set, and a module hook blocks vendor sales.
- Reward is tracked per character GUID in `nostrum_starter_rewards` (characters DB).
- If inventory is full at the time of login, the reward is marked as given and not retried.

---

### mod-nostrum-instant-mail

Removes the mail delivery delay for all player-to-player mail (any sender to any recipient). Mail is delivered immediately instead of the default 1-hour delay. COD mail, Auction House mail, GM mail, and system mail keep their default delivery behaviour.

---

### mod-level-rewards

Sends gold via system mail at level milestones (every 10 levels from 10 to 80).

Default gold amounts:

| Level | Gold |
|-------|------|
| 10 | 1g |
| 20 | 3g |
| 30 | 8g |
| 40 | 15g |
| 50 | 30g |
| 60 | 50g |
| 70 | 80g |
| 80 | 100g |

Mail subject and body support the `{level}` placeholder.

---

### mod-dual-spec-19

Lowers the minimum level required to purchase dual specialization from 50 to 19 (configurable). Updates the trainer gossip option cost in the database on startup and config reload.

```
DualSpec19.MinLevel = 19
DualSpec19.Cost     = 10000  (copper, 1 gold)
```

---

## 5. World & Social Design

### World Channel (`/world`)

All players are automatically joined to the `world` custom channel on login. The channel:
- Persists until the player manually leaves (`/leave world`) — re-joined on next login
- Requires `AllowTwoSide.Interaction.Channel = 1` for cross-faction visibility
- Has a configurable minimum speak level (default: 5) and message cooldown (default: 3 seconds)
- Displays using native WoW channel formatting: `[1. world] Player: message`

### Cross-Faction Communication

With the appropriate core config flags set:
- Alliance and Horde players share the `/world` channel
- `/say`, `/yell`, and custom channels are cross-faction
- `/who` shows players of both factions
- The auction house is shared

### Grouping

| Group type | Cross-faction |
|------------|---------------|
| Manual group invite | No (blocked by crossfaction module) |
| Dungeon Finder (RDF) | Yes |
| Battlegrounds | Yes (via mod-cfbg) |

### Guilds

Normal cross-faction guilds are disabled by default. The `Deathwalkers` guild is a system-managed exception for Hardcore players and accepts both factions when `AllowTwoSide.Interaction.Guild = 1`.

---

## 6. Progression Model

### Current State: Phase 1

- Level cap: **19** (enforced by `mod-nostrum-progression`)
- Active XP rate: **1×** blizzlike (enforced by `mod-nostrum-rates`, `ActivePhase = 1`)
- Players at cap receive no XP
- GMs are exempt from the cap

### Phases

The server advances through 8 phases. Each phase raises the level cap and introduces a new bracket at 1× rate; previous brackets shift to 2× catch-up rate.

| Phase | Level Range | Content | XP |
|-------|------------|---------|-----|
| 0 | — | Beta | 3× flat (all brackets) |
| 1 | 1–19 | Vanilla low | 1× (current) |
| 2 | 19–29 | | 1–18: 2×  •  19–29: 1× |
| 3 | 29–39 | | 1–28: 2×  •  29–39: 1× |
| 4 | 39–49 | | 1–38: 2×  •  39–49: 1× |
| 5 | 49–60 | Vanilla endgame | 1–48: 2×  •  49–60: 1× |
| 6 | 60–70 | TBC | 1–59: 2×  •  60–70: 1× |
| 7 | 70–80 | WotLK | 1–69: 2×  •  70–80: 1× |

**Advancing a phase** requires one conf change + `.reload config`:
1. `Nostrum.ActivePhase` → new phase number (read by both `mod-nostrum-progression` and `mod-nostrum-rates`)

### Leveling

- Dual spec available from level 19 at 1 gold
- Gold rewards mailed at each 10-level milestone
- BG XP enabled from level 10 with anti-AFK enforcement

`worldserver.conf` rate values must be set to 1.0 for `mod-nostrum-rates` to be the sole authority.

### Dungeon and Raid Access

Dungeon and raid entry is locked by `mod-nostrum-progression` based on the active phase. Portal entry, teleport-in, Dungeon Finder queues, and battleground queues are all blocked for content that requires a later phase. The lock table is hardcoded in C++ (see `kInstanceUnlockPhase` and `kBattlegroundUnlockPhase`). Phase 0 (Beta) disables all locks.

### Class and Race Restrictions

- **Death Knights** are locked until Phase 7 (WotLK). DK creation returns error code to the client when `ActivePhase < 7`.
- All other classes and races available as in standard 3.3.5a.

---

## 7. Technical Architecture

### Base

AzerothCore WoTLK 3.3.5a, compiled with `SCRIPTS=static MODULES=static`.

### Module Structure

All custom modules are in `modules/`. Each module is a self-contained directory with:
- `CMakeLists.txt`
- `src/` — C++ source
- `conf/` — `.conf.dist` configuration template
- `data/sql/` — database SQL (world and/or characters)

Custom module naming convention: `mod-nostrum-*` for server-specific modules.

### Databases

| Database | Purpose |
|----------|---------|
| `acore_auth` | Accounts, realm list, bans |
| `acore_world` | Game content: creatures, items, quests, loot, spells |
| `acore_characters` | Character data, inventories, progress, module state |

Module-specific tables (characters DB unless noted):

| Table | Module | DB |
|-------|--------|----|
| `nostrum_starter_rewards` | mod-nostrum-starter | characters |
| `mod_nostrum_hardcore` | mod-nostrum-hardcore | characters |
| `mod_nostrum_hardcore_flags` | mod-nostrum-hardcore | characters |
| `mod_nostrum_hardcore_milestones` | mod-nostrum-hardcore | characters |
| `character_bg_xp_daily` | mod-nostrum-bg-xp | characters |

Custom world DB entries:

| Entry | Type | Description |
|-------|------|-------------|
| 900100 | `item_template` | Nostrum Starter Bag |
| 900001 | `creature_template` | Loremaster Caedric (Alliance guide) |
| 900002 | `creature_template` | Elder Gromak (Horde guide) |
| 9000001–9000008 | `creature` / `gameobject` | Guide NPC spawns and visual cues |

### Deployment

Dockerized via `docker-compose.yml`. The worldserver image is built via GitHub Actions (`.github/workflows/build-worldserver.yml`) on push to `master`/`main` and pushed to Docker Hub as `dockerdan247/nostrum-worldserver`.

Module conf files are volume-mounted from `./conf/modules/` on the host into `/azerothcore/env/dist/etc/modules/` in the container.

---

## 8. Configuration Reference

### Cross-Faction (`mod_nostrum_crossfaction.conf`)

| Key | Default | Description |
|-----|---------|-------------|
| `NostrumCrossFaction.Enable` | 1 | Master switch |
| `NostrumCrossFaction.WorldChannel.Enable` | 1 | Auto-join world channel on login |
| `NostrumCrossFaction.WorldChannel.Name` | `world` | Channel name |
| `NostrumCrossFaction.WorldChannel.MinSpeakLevel` | 5 | Min level to speak |
| `NostrumCrossFaction.WorldChannel.MessageCooldownSeconds` | 3 | Speak cooldown |
| `NostrumCrossFaction.ManualGroups.Enable` | 0 | Allow manual cross-faction groups |
| `NostrumCrossFaction.DungeonGroups.Enable` | 1 | Allow RDF cross-faction groups |
| `NostrumCrossFaction.Trading.Enable` | 0 | Allow cross-faction direct trade |
| `NostrumCrossFaction.Mail.Enable` | 0 | Allow cross-faction mail |
| `NostrumCrossFaction.AuctionHouse.Enable` | 1 | Allow cross-faction AH |
| `NostrumCrossFaction.Guilds.Enable` | 0 | Allow cross-faction guilds |
| `NostrumCrossFaction.Battlegrounds.Enable` | 1 | Enable CFBG (requires mod-cfbg) |

### Hardcore (`mod_nostrum_hardcore.conf`)

| Key | Default | Description |
|-----|---------|-------------|
| `Nostrum.Hardcore.Enable` | 1 | Master switch |
| `Nostrum.Hardcore.MaxPlayedSecondsToEnable` | 600 | Max played time to opt in |
| `Nostrum.Hardcore.FallenStayGhost` | 1 | Fallen characters remain as ghosts |
| `Nostrum.Hardcore.BlockFallenResurrection` | 1 | Block resurrection for fallen |
| `Nostrum.Hardcore.SoulOfIronSpellId` | 0 | Cosmetic aura (0 = disabled) |
| `Nostrum.Hardcore.TitleId` | 0 | Title on opt-in (0 = disabled) |
| `Nostrum.Hardcore.AnnounceDeaths` | 1 | Broadcast death server-wide |
| `Nostrum.Hardcore.AutoGuild.Enable` | 1 | Auto-join Deathwalkers guild |
| `Nostrum.Hardcore.SelfFound.BlockTrade` | 1 | Block trading for SF characters |
| `Nostrum.Hardcore.SelfFound.BlockAuctionHouse` | 1 | Block AH for SF characters |
| `Nostrum.Hardcore.SelfFound.BlockPlayerMail` | 1 | Block mail for SF characters |

### Progression (`mod_nostrum_progression.conf`)

| Key | Default | Description |
|-----|---------|-------------|
| `Nostrum.Progression.Enable` | 1 | Master switch |
| `Nostrum.ActivePhase` | 1 | Active phase 0–7; controls level cap, content locks, and XP rates |
| `Nostrum.Progression.GmBypass` | 1 | GMs bypass the level cap and all content locks |
| `Nostrum.Progression.LoginAnnouncement` | 1 | Show phase name and cap on login |
| `Nostrum.Progression.LockInstances` | 1 | Block dungeon/raid entry for locked phases |
| `Nostrum.Progression.TeleportOutOfLockedMapsOnLogin` | 1 | Move players to homebind if logged inside a locked instance |
| `Nostrum.Progression.LockBattlegrounds` | 1 | Block BG queue and port-in for locked phases |
| `Nostrum.Progression.LockLFG` | 1 | Block Dungeon Finder queues for locked phases |
| `Nostrum.Progression.Debug` | 0 | Verbose logging for all lock checks |

### Rates (`nostrum_rates.conf`)

| Key | Default | Description |
|-----|---------|-------------|
| `Nostrum.ActivePhase` | 1 | Active phase (0–7). Shared with mod-nostrum-progression; controls XP brackets and DK lock |
| `NostrumRates.XP.BetaRate` | 3.0 | Phase 0 flat XP multiplier |
| `NostrumRates.XP.CurrentPhaseRate` | 1.0 | XP for the active phase's level bracket |
| `NostrumRates.XP.CatchUpRate` | 2.0 | XP for previous phase brackets (catch-up) |
| `NostrumRates.XP.Battleground` | 1.0 | BG XP (not phase-scaled) |
| `NostrumRates.BlockDKBeforePhase7` | 1 | Block DK creation while phase < 7 |
| `NostrumRates.Reputation.Kill` | 1.0 | Kill reputation multiplier |
| `NostrumRates.Reputation.Quest` | 1.0 | Quest reputation multiplier |

---

## 9. Design Principles

**What the server allows:**
- Opt-in Hardcore and Self-Found Hardcore with permanent death
- Cross-faction communication, dungeon finder, and battlegrounds
- Accelerated leveling (3× default, reduces at higher levels)
- Early dual spec at level 19
- Battleground XP with anti-AFK enforcement
- Starter bag and milestone gold to reduce new player friction

**What the server avoids:**
- Custom gear or items that trivialize content
- Pay-to-win mechanics
- Funserver features (custom classes, broken rates, instant max level)
- Forced cross-faction grouping in the open world
- Shortcuts that remove the need to engage with the game's economy and social systems

**What kind of experience it aims to create:**
- A server where the base game is meaningful and the community progresses together through content phases
- Hardcore mode as a high-stakes optional layer, not a barrier to entry
- A social environment where Alliance and Horde share communication and group content while maintaining distinct open-world faction identities

---

## 10. Future Considerations

The following are partially scaffolded or implied by current architecture:

- **Progression phases beyond Phase 1.** The progression module supports arbitrary level caps and phase names. Future phases would raise the cap and unlock additional content.
- **Hardcore cosmetics.** `SoulOfIronSpellId` and `TitleId` config fields exist but are disabled. Enabling them requires unused spell/title IDs from the 3.3.5a client or a custom client patch.
- **Cross-faction guild enforcement.** `SystemGuilds.AllowedNames` is documented in config but not enforced by a hook. A `GuildScript` hook could restrict cross-faction membership to the allowed list only, rather than relying on `AllowTwoSide.Interaction.Guild = 1` globally.
- **Starter module extensions.** The source notes the module is designed to be extended with starter gold, learned spells, flight paths, and additional welcome features.

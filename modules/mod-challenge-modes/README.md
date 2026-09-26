# Challenge Modes

Modos desafío para AzerothCore 3.3.5a, basados en el módulo de ZhengPeiRu21. El original no arrancaba los hooks en el core actual (faltaba la lista de hooks), dependía de `EnablePlayerSettings` y mandaba el gossip con un `npc_text` / menú sin texto → el cliente pintaba **???**.

Este módulo usa el **mismo NPC y el mismo gossip**, con textos reales en `npc_text` + opciones escritas en C++ (inglés y español).

---

Challenge modes for AzerothCore 3.3.5a. Activate per-character at the **Keeper of Challenges** (entry `190012`) in each starting area, or at the optional Shrine of Challenge gameobject (`254605`).

## Rules

- **One mode per character.** After a challenge is accepted, Enable options disappear and a second mode is rejected.
- Challenges can only be enabled at **level 1** (or **55** for Death Knights). They cannot be turned off, except by a configured `DisableLevel`.
- The realm **announces** when a player accepts a mode, when a Hardcore / Iron Man character dies, and when someone completes a run at `RewardLevel` (default 80). Toggle with `ChallengeModes.Announce`.
- Progress is stored in `character_challenge_modes` (created on boot). `EnablePlayerSettings` is **not** required.

| Mode | Title (id) | Rule |
| --- | --- | --- |
| Hardcore | the Undying (142) | One life. Death (mob, player or spirit release) leaves you a ghost forever. The realm announces your fall. |
| Semi-Hardcore | of the Nightfall (140) | You may die, but each death destroys worn equipment and all carried gold. |
| Self-Crafted | the Supreme (85) | Only items you crafted yourself (item creator must be this character). |
| Item Quality | Jenkins (143) | Poor / Common gear only. |
| Slow XP | the Patient (172) | 0.5× experience from kills, quests and exploration. |
| Very Slow XP | the Explorer (78) | 0.25× experience. |
| Quest XP Only | Loremaster (125) | Experience from quests only. |
| Iron Man / Hombre de Hierro | the Insane (145) | No resurrect, **no talent points** (blocked at calculation and learn), rare gear, potions/flasks, enchants or groups. Death is announced. |

Accepting a mode **grants and equips** that title (stock 3.3.5 `CharTitles.dbc` ids, so the nameplate shows it without a client patch). Change or disable with `<Mode>.RewardTitle` (`0` = no title). Gossip **Info** prints the title plus a longer bilingual explanation.

## Per-mode rates

Each mode can scale gains in `challenge_modes.conf` (`1` = normal, `0` = none, `2` = double):

| Key | What it scales |
| --- | --- |
| `XPMultiplier` | Experience (kills, quests, exploration, battlegrounds) |
| `GoldRate` | Gold gained (loot, quests, vendor sales). Spending and trades stay 1:1. |
| `HonorRate` | Honor from PvP, quests and battlegrounds |
| `ReputationRate` | Reputation from kills and quests |

Example: `Hardcore.GoldRate = 0.5` and `Hardcore.XPMultiplier = 1.25`.

## Level 80 rewards

Configure completion rewards per mode in `challenge_modes.conf`. When the character reaches `RewardLevel` (default **80**) they receive any of:

| Key | What it grants |
| --- | --- |
| `RewardItem` / `RewardItemCount` | Item mailed to the player |
| `RewardTitle` | `CharTitles.dbc` id (also granted and worn when the mode is accepted) |
| `RewardGold` | Copper (10000 = 1 gold) |
| `RewardHonor` | Honor points |
| `RewardAchievement` | Achievement id |
| `RewardTalents` | Extra talent points |

Set an id/amount to `0` to skip that reward. The old `TitleRewards` / `ItemRewards` / `TalentRewards` / `AchievementReward` maps (`"60 143, 80 145"`) still work for extra levels.

Example:

```ini
Hardcore.RewardLevel = 80
Hardcore.RewardTitle = 42
Hardcore.RewardItem = 49426
Hardcore.RewardItemCount = 5
Hardcore.RewardGold = 1000000
Hardcore.RewardHonor = 2000
```

## Install

1. Place this folder in `azerothcore-wotlk/modules/mod-challenge-modes`.
2. Import `data/sql/world/challenge_modes.sql`.
3. Merge `conf/challenge_modes.conf.dist` into `worldserver.conf`.
4. Rebuild and restart worldserver.
5. If the keeper is not in the starting zone: `.npc add 190012`.

The shrine gameobject is still registered (`gobject_challenge_modes`) so an existing `254605` shrine keeps working. `.gobject add 254605` if you want the idol as well.

## First-login picker

On **every login** of a **level 1** character (or **55** Death Knight) that has not locked a challenge, the module opens a mode picker:

- If the **ChallengeModes** addon is installed (`addon/ChallengeModes/` → `Interface/AddOns/ChallengeModes`), a window lists every mode with icon, title and a short teaser. Selecting a card opens a **detail page** with the full rules, the honorific, and Accept. **Back** returns to the list.
- Without the addon, the same choice appears as a gossip menu (icons + short text). **Info** prints the long description in chat.
- The window is sent again after the client finishes entering the world, so it is not missed on login.
- One challenge only. Closing the window without picking a challenge opens it again on the next level-1 login.
- `.challenge pick` reopens it while the character can still choose.

Copy the folder `modules/mod-challenge-modes/addon/ChallengeModes` into the client `Interface/AddOns/` directory. `AddonChannel.Enabled` must stay on (default).

## Play

Talk to the keeper. The greeting and every option are real strings (no `???`). Hardcore and Iron Man ask for confirmation. Accepting a mode broadcasts to the realm. The keeper also offers **Normal mode** if you have not chosen yet.

`.challenge` / `.challenge status` lists the mode on your character and the full description.

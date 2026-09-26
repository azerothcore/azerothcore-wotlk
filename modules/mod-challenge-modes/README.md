# Challenge Modes

Modos desafío para AzerothCore 3.3.5a, basados en el módulo de ZhengPeiRu21. El original no arrancaba los hooks en el core actual (faltaba la lista de hooks), dependía de `EnablePlayerSettings` y mandaba el gossip con un `npc_text` / menú sin texto → el cliente pintaba **???**.

Este módulo usa el **mismo NPC y el mismo gossip**, con textos reales en `npc_text` + opciones escritas en C++ (inglés y español).

---

Challenge modes for AzerothCore 3.3.5a. Activate per-character at the **Keeper of Challenges** (entry `190012`) in each starting area, or at the optional Shrine of Challenge gameobject (`254605`).

| Mode | Rule |
| --- | --- |
| Hardcore | Death is permanent. You stay a ghost and cannot resurrect. |
| Semi-Hardcore | Death destroys worn equipment and all carried gold. |
| Self-Crafted | Only items you crafted yourself. |
| Item Quality | Poor / Common gear only. |
| Slow XP | 0.5× experience. |
| Very Slow XP | 0.25× experience. |
| Quest XP Only | Experience from quests only. |
| Iron Man | No resurrect, talent points, rare gear, potions/flasks, enchants or groups. |

Challenges can only be enabled at **level 1** (or **55** for Death Knights). They cannot be turned off, except by a configured `DisableLevel`. Conflicting pairs: Hardcore / Semi-Hardcore, Slow XP / Very Slow XP, Self-Crafted / Iron Man.

Progress is stored in `character_challenge_modes` (created on boot). `EnablePlayerSettings` is **not** required.

## Install

1. Place this folder in `azerothcore-wotlk/modules/mod-challenge-modes`.
2. Import `data/sql/world/challenge_modes.sql`.
3. Merge `conf/challenge_modes.conf.dist` into `worldserver.conf`.
4. Rebuild and restart worldserver.
5. If the keeper is not in the starting zone: `.npc add 190012`.

The shrine gameobject is still registered (`gobject_challenge_modes`) so an existing `254605` shrine keeps working. `.gobject add 254605` if you want the idol as well.

## First-login picker

On the first login of a **level 1** character (or **55** Death Knight), the module opens a mode picker:

- If the **ChallengeModes** addon is installed (`addon/ChallengeModes/` → `Interface/AddOns/ChallengeModes`), a Blizzard-style window shows an icon and a short explanation for each mode, plus **Normal**.
- Without the addon, the same choice appears as a gossip menu (icons + short text).
- One choice only. Closing the window without picking opens it again on the next login.
- `.challenge pick` reopens it while the character can still choose.

Copy the folder `modules/mod-challenge-modes/addon/ChallengeModes` into the client `Interface/AddOns/` directory. `AddonChannel.Enabled` must stay on (default).

## Play

Talk to the keeper. The greeting and every option are real strings (no `???`). Hardcore and Iron Man ask for confirmation. The keeper also offers **Normal mode** if you have not chosen yet.

`.challenge` / `.challenge status` lists the modes on your character.

Rewards (titles, extra talent points, items by mail, achievements) are optional and configured per mode as `level id` pairs, for example `Hardcore.TitleRewards = "60 143, 80 145"`.

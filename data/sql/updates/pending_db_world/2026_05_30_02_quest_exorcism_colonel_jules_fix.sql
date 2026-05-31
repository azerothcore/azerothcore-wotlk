-- DB update 2026_05_23_00 -> 2026_05_30_02
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/638
-- Quest "The Exorcism of Colonel Jules" (10935) — 5 SAI/movement bugs

-- -------------------------------------------------------------------------
-- Bug 1: Barada's "start exorcism" gossip menu can be triggered while the
--        event is already running, potentially starting a second parallel
--        event. Adding NOT_REPEATABLE (flag 0x001) prevents re-triggering
--        until Barada resets (evade → OnReset clears runOnce).
-- -------------------------------------------------------------------------
-- Anchorite Barada (entry 22431), id=3: ON_GOSSIP_SELECT → event_flags 512 → 513
UPDATE `smart_scripts` SET `event_flags` = 513 -- was 512 (WHILE_CHARMED); add NOT_REPEATABLE (0x001)
    WHERE `entryorguid` = 22431 AND `source_type` = 0 AND `id` = 3;

-- -------------------------------------------------------------------------
-- Bug 2: Colonel Jules (entry 22432) uses swimming animation when floating.
--        creature_template_movement has Swim=1, causing the swim anim to
--        play instead of the hover/fly anim. Setting Swim=0 fixes this.
-- -------------------------------------------------------------------------
UPDATE `creature_template_movement` SET `Swim` = 0 -- was 1 (caused swim animation while hovering)
    WHERE `CreatureId` = 22432;

-- -------------------------------------------------------------------------
-- Bug 3: After the player subdues Jules (gossip click → kill credit),
--        Jules evades back to his bed after only 5 000 ms — far too fast.
--        Increasing to 30 000 ms (30 s) gives a visible ending before he
--        returns to his starting position.
-- -------------------------------------------------------------------------
-- Script9 2243201 id=0: Evade delay 5 000 → 30 000 ms
UPDATE `smart_scripts` SET `event_param1` = 30000, -- was 5000
    `event_param2` = 30000 -- was 5000
    WHERE `entryorguid` = 2243201 AND `source_type` = 9 AND `id` = 0;

-- -------------------------------------------------------------------------
-- Bug 4: Barada stops kneeling (UNIT_FIELD_BYTES_1 cleared) 5 seconds
--        before the player can even click Jules to end the event, making
--        the exorcist appear to snap out of his ritual pose prematurely.
--        Adding a 10 000 ms delay before REMOVE_UNIT_FIELD_BYTES_1 keeps
--        Barada kneeling until after Jules is available for interaction.
-- -------------------------------------------------------------------------
-- Script9 2243100 id=25: REMOVE_UNIT_FIELD_BYTES_1 delay 0 → 10 000 ms
UPDATE `smart_scripts` SET `event_param1` = 10000, -- was 0
    `event_param2` = 10000 -- was 0
    WHERE `entryorguid` = 2243100 AND `source_type` = 9 AND `id` = 25;

-- -------------------------------------------------------------------------
-- Bug 5: "Darkness Released" ghost (entry 22507) spawns too frequently and
--        accumulates to lethal numbers, making it impossible to keep the
--        Draenei alive.
--
-- The SUMMON_CREATURE event on Colonel Jules (entry 22432, id=7) has:
--   repeat timer   : 3 000–8 000 ms  (avg ~5.5 s)
--   summon type    : 2 = TIMED_OR_CORPSE_DESPAWN (may fail to despawn if
--                    ghost is in combat with Barada or the player)
--   ghost despawn  : 60 000 ms (60 s)
--
-- At steady state this produces ~11 ghosts simultaneously, each casting a
-- damage spell every 3–8 s — the Draenei dies within seconds once ghosts
-- accumulate, making the quest unkillable without extraordinary healing.
--
-- Fix: slow spawn rate to 35–50 s, change summon type to TIMED_DESPAWN (3)
-- so ghosts always despawn regardless of combat state, and shorten lifespan
-- to 30 s. This keeps at most 1–2 ghosts active at any given moment,
-- matching the intended difficulty of a solo TBC quest.
-- -------------------------------------------------------------------------
-- Colonel Jules (entry 22432), id=7: SUMMON_CREATURE "Darkness Released"
--   event_param3 (repeat min): 3 000  → 35 000 ms
--   event_param4 (repeat max): 8 000  → 50 000 ms
--   action_param2 (summon type): 2   → 3 (TIMED_DESPAWN, guaranteed)
--   action_param3 (despawn)  : 60 000 → 30 000 ms
UPDATE `smart_scripts` SET `event_param3` = 35000, -- was 3000 (repeat min)
    `event_param4` = 50000, -- was 8000 (repeat max)
    `action_param2` = 3, -- was 2 (TIMED_OR_CORPSE_DESPAWN → TIMED_DESPAWN, guaranteed)
    `action_param3` = 30000 -- was 60000 (ghost despawn time)
    WHERE `entryorguid` = 22432 AND `source_type` = 0 AND `id` = 7;

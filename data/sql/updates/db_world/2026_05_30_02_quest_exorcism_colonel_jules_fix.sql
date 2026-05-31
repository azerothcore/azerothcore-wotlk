-- DB update 2026_05_23_00 -> 2026_05_30_02
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/638
-- Quest "The Exorcism of Colonel Jules" (10935) — 4 SAI/movement bugs

-- -------------------------------------------------------------------------
-- Bug 1: Barada's "start exorcism" gossip menu can be triggered while the
--        event is already running, potentially starting a second parallel
--        event. Adding NOT_REPEATABLE (flag 0x001) prevents re-triggering
--        until Barada resets (evade → OnReset clears runOnce).
-- -------------------------------------------------------------------------
-- Anchorite Barada (entry 22431), id=3: ON_GOSSIP_SELECT → event_flags 512 → 513
UPDATE `smart_scripts`
    SET `event_flags` = 513                 -- was 512 (WHILE_CHARMED); add NOT_REPEATABLE (0x001)
    WHERE `entryorguid` = 22431 AND `source_type` = 0 AND `id` = 3;

-- -------------------------------------------------------------------------
-- Bug 2: Colonel Jules (entry 22432) uses swimming animation when floating.
--        creature_template_movement has Swim=1, causing the swim anim to
--        play instead of the hover/fly anim. Setting Swim=0 fixes this.
-- -------------------------------------------------------------------------
UPDATE `creature_template_movement`
    SET `Swim` = 0                          -- was 1 (caused swim animation while hovering)
    WHERE `CreatureId` = 22432;

-- -------------------------------------------------------------------------
-- Bug 3: After the player subdues Jules (gossip click → kill credit),
--        Jules evades back to his bed after only 5 000 ms — far too fast.
--        Increasing to 30 000 ms (30 s) gives a visible ending before he
--        returns to his starting position.
-- -------------------------------------------------------------------------
-- Script9 2243201 id=0: Evade delay 5 000 → 30 000 ms
UPDATE `smart_scripts`
    SET `event_param1` = 30000,             -- was 5000
        `event_param2` = 30000              -- was 5000
    WHERE `entryorguid` = 2243201 AND `source_type` = 9 AND `id` = 0;

-- -------------------------------------------------------------------------
-- Bug 4: Barada stops kneeling (UNIT_FIELD_BYTES_1 cleared) 5 seconds
--        before the player can even click Jules to end the event, making
--        the exorcist appear to snap out of his ritual pose prematurely.
--        Adding a 10 000 ms delay before REMOVE_UNIT_FIELD_BYTES_1 keeps
--        Barada kneeling until after Jules is available for interaction.
-- -------------------------------------------------------------------------
-- Script9 2243100 id=25: REMOVE_UNIT_FIELD_BYTES_1 delay 0 → 10 000 ms
UPDATE `smart_scripts`
    SET `event_param1` = 10000,             -- was 0
        `event_param2` = 10000              -- was 0
    WHERE `entryorguid` = 2243100 AND `source_type` = 9 AND `id` = 25;

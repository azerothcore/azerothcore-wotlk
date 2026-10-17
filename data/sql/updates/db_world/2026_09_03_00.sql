-- DB update 2026_09_02_00 -> 2026_09_03_00
-- Durnholde Rifleman: restore Scatter Shot in both normal and heroic Old Hillsbrad.
-- Target 6 selects a random hostile player other than the top-threat target, and
-- the 15-yard limit matches Scatter Shot's maximum range. If no eligible non-tank
-- player is in range, SmartAI safely skips the cast instead of targeting the tank.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17820) AND (`source_type` = 0) AND (`id` = 5) AND (`link` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17820, 0, 5, 0, 0, 0, 100, 6, 7000, 11000, 7000, 11000, 0, 0, 11, 23601, 1, 0, 0, 0, 0, 6, 15, 1, 0, 0, 0, 0, 0, 0, 'Durnholde Rifleman - In Combat - Cast Scatter Shot on Random Non-Tank Player (Dungeon)');

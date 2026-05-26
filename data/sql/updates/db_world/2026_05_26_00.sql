-- DB update 2026_05_25_00 -> 2026_05_26_00
--
-- Change Target CREATURE_DISTANCE to CLOSEST_FRIENDLY
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23960) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23960, 0, 1, 0, 0, 0, 100, 2, 5000, 7000, 14000, 17000, 0, 0, 11, 42740, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Runecaster - In Combat - Cast \'Njord`s Rune of Protection\' (Normal Dungeon)'),
(23960, 0, 2, 0, 0, 0, 100, 4, 5000, 7000, 14000, 17000, 0, 0, 11, 59616, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Dragonflayer Runecaster - In Combat - Cast \'Njord`s Rune of Protection\' (Heroic Dungeon)');

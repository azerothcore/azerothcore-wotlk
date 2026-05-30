-- DB update 2026_01_22_01 -> 2026_01_22_02
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28581 AND `source_type` = 0 AND `id` IN (0, 1, 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28581, 0, 0, 0, 0, 0, 100, 2, 0, 9000, 11000, 14000, 0, 0, 11, 52778, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormforged Tactician - In Combat - Cast \'Welding Beam\' (Normal Dungeon)'),
(28581, 0, 1, 0, 0, 0, 100, 4, 0, 9000, 11000, 14000, 0, 0, 11, 59166, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormforged Tactician - In Combat - Cast \'Welding Beam\' (Heroic Dungeon)'),
(28581, 0, 2, 0, 2, 0, 100, 6, 0, 70, 15000, 27000, 0, 0, 11, 59085, 32, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Stormforged Tactician - Between 0-70% Health - Cast \'Arc Weld\' (Dungeon)');

-- DB update 2025_10_21_00 -> 2025_10_24_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29335) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29335, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 6000, 8000, 0, 0, 11, 54290, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Webspinner - In Combat - Cast \'Web Shot\' (Normal Dungeon)'),
(29335, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 6000, 8000, 0, 0, 11, 59362, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Webspinner - In Combat - Cast \'Web Shot\' (Heroic Dungeon)'),
(29335, 0, 2, 0, 0, 0, 100, 6, 5000, 12000, 16000, 21000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Webspinner - In Combat - Cast \'Web Wrap\' (Dungeon)');

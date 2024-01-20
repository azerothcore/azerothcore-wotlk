-- DB update 2023_07_11_01 -> 2023_07_11_02
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20757);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20757, 0, 0, 0, 0, 0, 100, 0, 3000, 4800, 12000, 16000, 0, 11, 33245, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - In Combat - Cast \'Ice Barrier\''),
(20757, 0, 1, 0, 9, 0, 100, 0, 0, 10, 5000, 11000, 1, 11, 17145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - Within 0-10 Range - Cast \'Blast Wave\''),
(20757, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3400, 4800, 0, 11, 15242, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - In Combat - Cast \'Fireball\'');

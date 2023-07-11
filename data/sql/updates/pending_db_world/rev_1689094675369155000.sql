--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20757 AND `source_type` = 0 AND `id` IN (0, 1, 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20757, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 33245, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - On Aggro - Cast \'Ice Barrier\' (No Repeat)'),
(20757, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 11, 17145, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - Between 20-80% Health - Cast \'Blast Wave\' (No Repeat)'),
(20757, 0, 2, 0, 0, 0, 100, 0, 2500, 3000, 7500, 8000, 0, 11, 15242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fingrom - In Combat - Cast \'Fireball\'');

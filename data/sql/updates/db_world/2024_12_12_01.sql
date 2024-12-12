-- DB update 2024_12_12_00 -> 2024_12_12_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23580);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23580, 0, 0, 1, 2, 0, 100, 1, 30, 30, 0, 0, 0, 0, 11, 43274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 30-30% Health - Cast \'Dismount Bear\' (No Repeat)'),
(23580, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-19% Health - Set Flag Standstate Stand Up (No Repeat)'),
(23580, 0, 2, 3, 61, 0, 100, 3, 0, 0, 0, 0, 0, 0, 11, 40743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(23580, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 30-30% Health - Dismount'),
(23580, 0, 4, 0, 0, 0, 100, 2, 0, 0, 12000, 12000, 0, 0, 11, 43273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - In Combat - Cast \'Cleave\' (No Repeat)'),
(23580, 0, 5, 0, 0, 0, 100, 2, 5000, 5000, 20000, 20000, 0, 0, 11, 42496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - In Combat - Cast \'Furious Roar\' (No Repeat)');

-- DB update 2024_09_11_00 -> 2024_09_11_01
-- Missing spell (Cleave) for Bladespire Brute
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19995) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19995, 0, 0, 0, 0, 0, 100, 0, 7000, 12000, 8000, 30000, 0, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bladespire Brute - In Combat - Cast Cleave');

-- Missing spell (Knockdown) for Bloodmaul Mauler
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19993) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19993, 0, 4, 0, 0, 0, 100, 0, 15000, 30000, 30000, 60000, 0, 0, 11, 37592, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Mauler - In Combat - Cast Knockdown');

-- Missing spell (Knockdown) for Bloodmaul Taskmaster
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22160) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22160, 0, 5, 0, 0, 0, 100, 0, 20000, 50000, 60000, 90000, 0, 0, 11, 37592, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodmaul Taskmaster - In Combat - Cast Knockdown');

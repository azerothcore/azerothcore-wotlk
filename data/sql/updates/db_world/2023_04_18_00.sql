-- DB update 2023_04_17_02 -> 2023_04_18_00
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21694) AND (`source_type` = 0) AND (`id` IN (2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21694, 0, 2, 0, 0, 0, 100, 0, 7000, 9500, 12000, 15000, 0, 11, 40340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast \'Trample\''),
(21694, 0, 3, 4, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Between 0-20% Health - Cast \'Enrage\' (No Repeat)'),
(21694, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Between 0-20% Health - Say Line 0 (No Repeat)');

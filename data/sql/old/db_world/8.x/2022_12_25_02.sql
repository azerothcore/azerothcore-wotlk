-- DB update 2022_12_25_01 -> 2022_12_25_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17000) AND (`source_type` = 0) AND (`id` IN (7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17000, 0, 7, 0, 0, 0, 100, 0, 9000, 12000, 27000, 31000, 0, 11, 21068, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - In Combat - Cast \'Corruption\''),
(17000, 0, 8, 0, 0, 0, 100, 0, 17000, 25000, 17000, 25000, 0, 11, 22678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - In Combat - Cast \'Fear\'');

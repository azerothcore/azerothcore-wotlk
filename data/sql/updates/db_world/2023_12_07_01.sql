-- DB update 2023_12_07_00 -> 2023_12_07_01
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21875 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21875, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 142, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Leotheras - Just Summoned - Set health 15%'),
(21875, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 0, 0, 11, 37674, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Leotheras - In Combat - Cast Chaos Blast'),
(21875, 0, 2, 0, 60, 0, 100, 1, 8000, 8000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Leotheras - On Update - Talk');

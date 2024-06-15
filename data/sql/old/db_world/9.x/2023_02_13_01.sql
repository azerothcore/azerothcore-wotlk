-- DB update 2023_02_13_00 -> 2023_02_13_01
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 197;

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 19700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19700, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshal McBride - Timed Actionlist - Salute'),
(19700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshal McBride - Timed Actionlist - Talk "You are dismissed"');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 197);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(197, 0, 0, 1, 19, 0, 100, 0, 54, 0, 0, 0, 0, 11, 6245, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshal McBride - On Quest \'Report to Goldshire\' Taken - Cast Force Target Salute (6245)'),
(197, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 19700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshal McBride - On Quest \'Report to Goldshire\' Taken - After 2 seconds salute back and say line');

-- DB update 2023_10_08_05 -> 2023_10_08_06
-- Pamela's Doll
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10926;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10926);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1092600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10926, 0, 0, 0, 20, 0, 100, 0, 5149, 0, 0, 0, 0, 0, 80, 1092600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pamela Redpath - On Quest \'Pamela\'s Doll\' Finished - Run Script'),
(1092600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pamela Redpath - Actionlist - Say Line 4'),
(1092600, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Pamela Redpath - Actionlist - Say Line 5');

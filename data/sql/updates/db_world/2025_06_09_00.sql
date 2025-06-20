-- DB update 2025_06_08_06 -> 2025_06_09_00
-- Leaping Hatchling
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 35387;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 35387);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(35387, 0, 0, 0, 1, 0, 100, 0, 23000, 28000, 23000, 28000, 0, 0, 80, 3538700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leaping Hatchling - Out of Combat - Run Script');
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3538700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3538700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leaping Hatchling - Actionlist - Stop Follow'),
(3538700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leaping Hatchling - Actionlist - Start Random Movement'),
(3538700, 9, 2, 0, 0, 0, 100, 0, 3000, 4500, 0, 0, 0, 0, 11, 67427, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Leaping Hatchling - Actionlist - Cast \'Leaping Hatchling Jump\''),
(3538700, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 29, 1, 90, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Leaping Hatchling - Actionlist - Start Follow Owner Or Summoner');

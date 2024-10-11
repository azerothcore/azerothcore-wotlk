-- DB update 2023_04_04_05 -> 2023_04_04_06
-- ID 7879 (Quintis Jonespyre)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7879;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 7879;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7879, 0, 0, 0, 20, 0, 100, 0, 4129, 0, 0, 0, 0, 80, 787900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quintis Jonespyre - On Quest \'The Knife Revealed\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE `entryorguid`=787900 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(787900, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quintis Jonespyre - Actionlist - Say Line 0'),
(787900, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 11, 15050, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quintis Jonespyre - Actionlist - Cast \'Psychometry\''),
(787900, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Quintis Jonespyre - Actionlist - Say Line 1');

-- DB update 2024_01_01_00 -> 2024_01_01_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17683;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17683 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17683, 0, 0, 0, 0, 0, 100, 0, 22650, 46000, 24260, 65400, 0, 0, 11, 744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zarakh - In Combat - Cast \'Poison\''),
(17683, 0, 1, 0, 0, 0, 100, 0, 1600, 19790, 17720, 40430, 0, 0, 11, 745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zarakh - In Combat - Cast \'Web\'');

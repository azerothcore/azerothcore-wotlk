-- DB update 2023_12_03_01 -> 2023_12_03_02
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17494;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17494 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17494, 0, 0, 0, 0, 0, 100, 0, 6470, 8620, 3240, 35910, 0, 0, 11, 20791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - In Combat - Cast \'Shadow Bolt\''),
(17494, 0, 1, 0, 0, 0, 100, 0, 11300, 11300, 12950, 37520, 0, 0, 11, 11962, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - In Combat - Cast \'Immolate\''),
(17494, 0, 2, 0, 0, 0, 100, 0, 3230, 30750, 19410, 45930, 0, 0, 11, 21068, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - In Combat - Cast \'Corruption\''),
(17494, 0, 3, 0, 0, 0, 100, 0, 4850, 30740, 12950, 75790, 0, 0, 11, 17227, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - In Combat - Cast \'Curse of Weakness\'');

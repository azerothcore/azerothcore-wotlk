-- DB update 2023_03_30_05 -> 2023_03_30_06
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20405);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20405, 0, 0, 1, 25, 0, 100, 512, 0, 0, 0, 0, 0, 75, 35150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Reset - Add Aura \'Nether Charge Passive\''),
(20405, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 11, 37670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Reset - Cast \'Nether Charge Timer\''),
(20405, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Reset - Set Reactstate Passive'),
(20405, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 89, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Reset - Start Random Movement'),
(20405, 0, 4, 0, 60, 0, 100, 513, 8500, 8500, 0, 0, 0, 80, 2040500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Update - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2040500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040500, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - Actionlist - Stop Random Movement'),
(2040500, 9, 1, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 11, 35151, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - Actionlist - Cast \'Nether Charge Pulse\''),
(2040500, 9, 2, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 11, 35151, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - Actionlist - Cast \'Nether Charge Pulse\''),
(2040500, 9, 3, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 11, 35151, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - Actionlist - Cast \'Nether Charge Pulse\'');

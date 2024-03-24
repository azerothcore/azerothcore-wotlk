-- DB update 2024_02_08_02 -> 2024_02_12_00
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20045;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20045 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20045, 0, 0, 0, 0, 0, 100, 0, 11900, 11900, 19300, 19300, 0, 0, 11, 37135, 128, 0, 0, 0, 0, 17, 0, 2000, 5, 0, 0, 0, 0, 0, 'Nether Scryer - In Combat - Cast \'Domination\''),
(20045, 0, 1, 0, 0, 0, 100, 0, 12400, 14900, 9800, 9800, 0, 0, 11, 37126, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Scryer - In Combat - Cast \'Arcane Blast\'');

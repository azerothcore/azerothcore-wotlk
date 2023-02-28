UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20477;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20477);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20477, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 6000, 6000, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terrorclaw - In Combat - Cast \'Cleave\' (Phase 1) (No Repeat)'),
(20477, 0, 1, 0, 2, 0, 100, 1, 0, 40, 0, 0, 0, 11, 34259, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terrorclaw - Between 0-40% Health - Cast \'Fear\' (No Repeat)');

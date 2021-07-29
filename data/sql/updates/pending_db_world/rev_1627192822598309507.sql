INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627192822598309507');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7156;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7156 AND `source_type` = 0 AND `id` IN (0, 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7156, 0, 0, 0, 0, 0, 100, 1, 0, 0, 5000, 5000, 0, 11, 13583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Den Watcher - In Combat - Cast \'Curse of the Deadwood\' (No Repeat)'),
(7156, 0, 1, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 39, 20, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Deadwood Den Watcher - Between 0-50% Health - Call For Help (No Repeat)');


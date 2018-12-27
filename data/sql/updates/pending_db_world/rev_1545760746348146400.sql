INSERT INTO version_db_world (`sql_rev`) VALUES ('1545760746348146400');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = 131076, `flags_extra` = 0 WHERE `entry` = 2667;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2667;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2667, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 3000, 3000, 11, 3826, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 'Ward of Laze - In Combat - Cast \'Ward of Laze Passive\'');


INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636812374856286400');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10742;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10742) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10742, 0, 0, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 0, 11, 16637, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackhand Dragon Handler - In Combat - Cast \'Mend Dragon\' (timers not verified)');

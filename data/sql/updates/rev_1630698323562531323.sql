INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630698323562531323');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8612;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8612) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(8612, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 5307, 3, 0, 0, 0, 0, 0, 0, 'On Reset - Despawn Target');

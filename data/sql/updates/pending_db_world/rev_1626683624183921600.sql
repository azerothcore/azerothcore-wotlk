INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626683624183921600');

--Changed the param WP_START run from 1 to 0 so he walks when the quest starts.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 1379;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1379) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1379, 0, 0, 0, 19, 0, 100, 0, 309, 0, 0, 0, 0, 53, 0, 1379, 0, 309, 10000, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');


INSERT INTO `version_db_world` (`sql_rev`) VALUES 

/* Eskhandar Combat Script
*/

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14306;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14306) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14306, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 11, 3252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Eskhandar - In Combat - Cast \'Shred\''),
(14306, 0, 1, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 11, 8355, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Eskhandar - In Combat - Cast \'Exploit Weakness\'');

/* Eskhandar Ghostly Aura
*/

DELETE FROM `creature_template_addon` WHERE (`entry` = 14306);
INSERT INTO `creature_template_addon` (`entry`, `visibilityDistanceType`, `auras`) VALUES ('14306', '0', '22650');

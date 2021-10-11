INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633953386512414400');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10040;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10040) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10040, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Gorishi Hive Guard - On Just Summoned - Start Attacking');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10041;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10041);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10041, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 24000, 24000, 0, 11, 8137, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorishi Hive Queen - In Combat - Cast \'Silithid Pox\''),
(10041, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 15000, 15000, 0, 11, 7992, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Gorishi Hive Queen - In Combat - Cast \'Slowing Poison\''),
(10041, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Gorishi Hive Queen - On Just Summoned - Start Attacking');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626358725875698500');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (2569, 2570);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2569) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2570) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2569, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 100, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Mauler - Just Summoned - Attack Start'),
(2570, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Shaman - Just Summoned - Attack Start');


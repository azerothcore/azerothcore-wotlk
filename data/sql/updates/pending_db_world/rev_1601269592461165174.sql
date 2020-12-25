INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601269592461165174');

/* Horde */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(24657, 11431);

DELETE FROM `creature_questender` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(24657, 11431);

/* Alliance */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(23486, 11117);

DELETE FROM `creature_questender` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(23486, 11117);

/* fix for Wolpertinger Net */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23487;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23487) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23487, 0, 0, 1, 8, 0, 100, 0, 41621, 0, 0, 0, 0, 56, 32906, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Add item on spell cast');

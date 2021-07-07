INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625511611223853500');

-- It was set to waypoint movement
UPDATE `creature_template` SET `MovementType` = 0 WHERE (`entry` = 16916);

-- It was set to random movement
UPDATE `creature` SET `MovementType` = 0 WHERE (`id` = 16916) AND (`guid` IN (58691));

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590769251197902700');

-- Change maraudon portal faction to 0 (usable by both factions)
UPDATE `gameobject_template_addon` SET `faction` = 0 WHERE `entry` = 178404;
DELETE FROM `gameobject` WHERE `guid` = 265127 AND `id` = 178404;

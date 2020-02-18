INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582041321256109939');

UPDATE `gameobject_template_addon` SET `flags` = `flags` | 4 WHERE `entry` IN (SELECT `entry` FROM `gameobject_template` WHERE `type` = 2 AND `data3` = 0);

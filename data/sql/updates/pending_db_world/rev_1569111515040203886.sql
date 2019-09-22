INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1569111515040203886');

DELETE FROM `gameobject_template_addon` WHERE `entry` = 192081;
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`) VALUES
(192081, 35, 4, 0, 0);

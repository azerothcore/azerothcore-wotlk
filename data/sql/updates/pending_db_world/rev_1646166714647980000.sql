INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646166714647980000');

DELETE FROM `creature_addon` WHERE `guid`=10299;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (10299, 102990);

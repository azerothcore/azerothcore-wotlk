INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618148212632025000');

DELETE FROM `creature` WHERE (`id` = 1787) AND (`guid` IN (52542));

DELETE FROM `creature_addon` WHERE  `guid`=52542;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637104117879476300');

UPDATE `creature_formations` SET `groupAI` = `groupAI`|0x004 WHERE `leaderGUID` = 137971;

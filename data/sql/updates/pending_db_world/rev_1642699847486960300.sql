INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642699847486960300');

UPDATE `creature_formations` SET `groupAI` = `groupAI`|1 WHERE `leaderGUID` = 54579;

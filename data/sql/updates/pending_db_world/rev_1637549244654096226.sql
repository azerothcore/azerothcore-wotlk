INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637549244654096226');

UPDATE `creature_formations` SET `groupAI` = `groupAI`|4 WHERE `leaderGUID` = 202212;

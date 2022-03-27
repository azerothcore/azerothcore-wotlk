INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647566741929769300');

SET @LEADERGUID := 84648;
DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID, 84639, 84650);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84639, 0, 0, 3),
(@LEADERGUID, 84650, 0, 0, 3);

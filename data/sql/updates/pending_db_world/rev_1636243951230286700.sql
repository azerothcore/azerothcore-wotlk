INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636243951230286700');

DELETE FROM `creature_formations` WHERE `leaderGUID` = 137971;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(137971, 137971, 0, 0, 515, 0, 0),
(137971, 90976, 0, 0, 515, 0, 0),
(137971, 90975, 0, 0, 515, 0, 0);

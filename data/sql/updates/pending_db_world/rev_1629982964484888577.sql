INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629982964484888577');

-- Groups Den Mother and her cubs in a formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 37523;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(37523, 37523, 20, 0, 3, 0, 0),
(37523, 37569, 20, 0, 3, 0, 0),
(37523, 37566, 20, 0, 3, 0, 0),
(37523, 37568, 20, 0, 3, 0, 0);


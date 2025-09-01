-- DB update 2023_06_01_03 -> 2023_06_01_04
-- Sul'lithuz Abomination and Sandfury Guardian creature formations
DELETE FROM `creature_formations` WHERE `memberGUID` IN (81527, 81565, 37998, 37999, 38000, 38001);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(81527, 81527, 0, 0, 3, 0, 0),
(81527, 81565, 0, 0, 3, 0, 0),
(37998, 37998, 0, 0, 3, 0, 0),
(37998, 37999, 0, 0, 3, 0, 0),
(37998, 38000, 0, 0, 3, 0, 0),
(37998, 38001, 0, 0, 3, 0, 0);

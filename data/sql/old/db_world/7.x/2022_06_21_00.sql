-- DB update 2022_06_19_00 -> 2022_06_21_00
--
DELETE FROM `creature_formations` WHERE `leaderGUID` = 49310;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(49310, 49310, 0, 0, 27, 0, 0),
(49310, 49311, 0, 0, 27, 0, 0),
(49310, 49312, 0, 0, 27, 0, 0);

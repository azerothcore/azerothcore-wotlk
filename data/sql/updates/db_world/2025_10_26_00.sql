-- DB update 2025_10_25_01 -> 2025_10_26_00
--
DELETE FROM `creature_formations` WHERE `leaderGUID` = 126740 OR `memberGUID` = 126740;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(126740, 126740, 0, 0, 3, 0, 0),
(126740, 126741, 0, 0, 3, 0, 0);

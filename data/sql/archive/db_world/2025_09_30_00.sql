-- DB update 2025_09_29_00 -> 2025_09_30_00
DELETE FROM `creature_formations` WHERE (`leaderGUID` = 127046);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(127046, 127046, 0, 0, 1, 0, 0),
(127046, 127080, 0, 0, 1, 0, 0),
(127046, 127081, 0, 0, 1, 0, 0);

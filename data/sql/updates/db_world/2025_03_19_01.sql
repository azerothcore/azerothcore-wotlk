-- DB update 2025_03_19_00 -> 2025_03_19_01

-- Add creature formation for the last pack before Kalecgos
DELETE FROM `creature_formations` WHERE `leaderGUID` = 54834;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(54834, 54834, 0, 0, 3, 0, 0),
(54834, 43654, 0, 0, 3, 0, 0),
(54834, 42573, 0, 0, 3, 0, 0),
(54834, 42574, 0, 0, 3, 0, 0),
(54834, 54817, 0, 0, 3, 0, 0),
(54834, 42656, 0, 0, 3, 0, 0);

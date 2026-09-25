-- DB update 2025_03_22_00 -> 2025_03_22_01

-- Pack after Eredar Twins
DELETE FROM `creature_formations` WHERE `leaderGUID` = 47607;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(47607, 47607, 0, 0, 3, 0, 0),
(47607, 47313, 0, 0, 3, 0, 0),
(47607, 47471, 0, 0, 3, 0, 0),
(47607, 47768, 0, 0, 3, 0, 0),
(47607, 47608, 0, 0, 3, 0, 0),
(47607, 47769, 0, 0, 3, 0, 0);

-- Pack before M'uru
DELETE FROM `creature_formations` WHERE `leaderGUID` = 47470;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(47470, 47470, 0, 0, 3, 0, 0),
(47470, 47475, 0, 0, 3, 0, 0),
(47470, 47578, 0, 0, 3, 0, 0),
(47470, 47875, 0, 0, 3, 0, 0),
(47470, 47897, 0, 0, 3, 0, 0),
(47470, 47884, 0, 0, 3, 0, 0);

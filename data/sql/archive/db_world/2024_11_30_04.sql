-- DB update 2024_11_30_03 -> 2024_11_30_04
--
DELETE FROM `creature_formations` WHERE `leaderGUID` = 89358;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(89358, 89358, 0, 0, 27),
(89358, 12923, 0, 0, 27),
(89358, 12924, 0, 0, 27),
(89358, 9252, 0, 0, 27),
(89358, 4915, 0, 0, 27),
(89358, 12922, 0, 0, 27),
(89358, 12404, 0, 0, 27),
(89358, 11906, 0, 0, 27),
(89358, 10560, 0, 0, 27);

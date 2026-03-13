-- DB update 2024_11_04_04 -> 2024_11_04_05
DELETE FROM `creature_formations` WHERE `leaderGUID` = 41817;

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(41817, 41817, 0, 0, 515),
(41817, 42661, 1.0, 0.0, 515),
(41817, 54838, 1.0, 1.57, 515),
(41817, 42595, 1.0, 3.14, 515),
(41817, 43739, 1.0, 4.71, 515);

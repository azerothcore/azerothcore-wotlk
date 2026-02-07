-- DB update 2024_11_04_07 -> 2024_11_04_08
DELETE FROM `creature_formations` WHERE `leaderGUID` = 42587;

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(42587, 42587, 0, 0, 515),
(42587, 54824, 1.0, 0.0, 515),
(42587, 42640, 1.0, 1.57, 515),
(42587, 54829, 1.0, 3.14, 515),
(42587, 42659, 1.0, 4.71, 515),
(42587, 42586, 1.0, 6.28, 515);

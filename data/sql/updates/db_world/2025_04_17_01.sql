-- DB update 2025_04_17_00 -> 2025_04_17_01

-- Add Creature Formations
DELETE FROM `creature_formations` WHERE `leaderGUID` = 54835;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(54835, 54835, 0, 0, 3, 0, 0),
(54835, 42660, 0, 0, 3, 0, 0),
(54835, 42591, 0, 0, 3, 0, 0),
(54835, 42592, 0, 0, 3, 0, 0),
(54835, 54825, 0, 0, 3, 0, 0),
(54835, 42657, 0, 0, 3, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 42582;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(42582, 42582, 0, 0, 3, 0, 0),
(42582, 42894, 0, 0, 3, 0, 0),
(42582, 54832, 0, 0, 3, 0, 0),
(42582, 42647, 0, 0, 3, 0, 0),
(42582, 43439, 0, 0, 3, 0, 0),
(42582, 54820, 0, 0, 3, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 42585;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(42585, 42585, 0, 0, 3, 0, 0),
(42585, 42870, 0, 0, 3, 0, 0),
(42585, 42584, 0, 0, 3, 0, 0),
(42585, 54830, 0, 0, 3, 0, 0),
(42585, 54827, 0, 0, 3, 0, 0),
(42585, 42644, 0, 0, 3, 0, 0);

-- DB update 2025_02_26_01 -> 2025_02_26_02

-- Remove old formation (it will be changed with 48372)
DELETE FROM `creature_formations` WHERE `leaderGUID` = 41817;

-- Add formations for all elf packs with a Scout as a leader
DELETE FROM `creature_formations` WHERE `leaderGUID` = 48372;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48372, 48372, 0, 0, 3, 0, 0),
(48372, 41817, 0, 0, 3, 0, 0),
(48372, 43739, 0, 0, 3, 0, 0),
(48372, 54826, 0, 0, 3, 0, 0),
(48372, 42595, 0, 0, 3, 0, 0),
(48372, 54838, 0, 0, 3, 0, 0),
(48372, 42661, 0, 0, 3, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 48160;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48160, 48160, 0, 0, 3, 0, 0),
(48160, 54816, 0, 0, 3, 0, 0),
(48160, 54837, 0, 0, 3, 0, 0),
(48160, 54858, 0, 0, 3, 0, 0),
(48160, 43661, 0, 0, 3, 0, 0),
(48160, 42589, 0, 0, 3, 0, 0),
(48160, 54988, 0, 0, 3, 0, 0),
(48160, 56686, 0, 0, 3, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 48162;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48162, 48162, 0, 0, 3, 0, 0),
(48162, 42594, 0, 0, 3, 0, 0),
(48162, 43655, 0, 0, 3, 0, 0),
(48162, 54818, 0, 0, 3, 0, 0),
(48162, 54836, 0, 0, 3, 0, 0),
(48162, 42590, 0, 0, 3, 0, 0),
(48162, 42658, 0, 0, 3, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 48360;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(48360, 48360, 0, 0, 3, 0, 0),
(48360, 42593, 0, 0, 3, 0, 0),
(48360, 43440, 0, 0, 3, 0, 0),
(48360, 54833, 0, 0, 3, 0, 0),
(48360, 42655, 0, 0, 3, 0, 0),
(48360, 43738, 0, 0, 3, 0, 0),
(48360, 54819, 0, 0, 3, 0, 0);

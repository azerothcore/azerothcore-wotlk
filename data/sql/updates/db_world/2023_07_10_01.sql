-- DB update 2023_07_10_00 -> 2023_07_10_01
--
DELETE FROM `creature_formations` WHERE `memberGUID` IN (90978, 90979, 90980, 90981, 90982);
INSERT INTO `creature_formations` (`memberGUID`, `leaderGUID`, `groupAI`) VALUES
(90978, 90978, 3),
(90979, 90978, 3),
(90980, 90978, 3),
(90981, 90978, 3),
(90982, 90978, 3);

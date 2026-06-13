-- DB update 2024_06_15_01 -> 2024_06_15_02
--
DELETE FROM `creature_formations` WHERE `leaderGUID` = 148062;

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` = 22878;

DELETE FROM `creature_formations` WHERE `leaderGUID` = 148063;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(148063, 148063, 0, 0, 11),
(148063, 148064, 0, 0, 11);

-- DB update 2025_10_04_06 -> 2025_10_06_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -127203);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 127203;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(127203, 127203, 0, 0, 3, 0, 0),
(127203, 127201, 0, 0, 3, 0, 0),
(127203, 127202, 0, 0, 3, 0, 0);

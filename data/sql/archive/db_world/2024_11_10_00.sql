-- DB update 2024_11_09_03 -> 2024_11_10_00
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 24858;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Flight`) VALUES
(24858, 1, 1);

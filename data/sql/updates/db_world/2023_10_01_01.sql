-- DB update 2023_10_01_00 -> 2023_10_01_01
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 17265;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Rooted`) VALUES
(17265, 1, 1);

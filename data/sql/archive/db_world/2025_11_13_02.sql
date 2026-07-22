-- DB update 2025_11_13_01 -> 2025_11_13_02
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 27821;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Flight`) VALUES
(27821, 1, 1);

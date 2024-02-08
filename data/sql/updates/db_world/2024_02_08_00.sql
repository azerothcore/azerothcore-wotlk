-- DB update 2024_02_06_00 -> 2024_02_08_00
--
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 24224;
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`, `Rooted`) VALUES
(24224, 1, 1);

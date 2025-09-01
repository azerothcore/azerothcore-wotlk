-- DB update 2023_06_02_06 -> 2023_06_02_07
DELETE FROM `creature_template_movement` WHERE `creatureId` = 20687;
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`, `Rooted`) VALUES
(20687, 1, 1);

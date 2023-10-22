-- DB update 2023_03_17_00 -> 2023_03_19_00
-- [1] MovementFlags: 1536 (DisableGravity, Root)
DELETE FROM `creature_template_movement` WHERE `creatureId` = 20343;
INSERT INTO `creature_template_movement` (`CreatureId`, `Flight`, `Rooted`) VALUES
(20343, 1, 1);

-- DB update 2023_03_05_01 -> 2023_03_05_02
-- Infected Kodo Beast - add missing ability, Stampede.
DELETE FROM `creature_template_spell` WHERE `CreatureID`=25596;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(25596, 0, 45876, 12340),
(25596, 1, 45877, 12340);

-- Column Ornament - disable gravity, previously falling to the ground.
UPDATE `creature_template_movement` SET `Flight` = 1 WHERE `CreatureId` = 29754;

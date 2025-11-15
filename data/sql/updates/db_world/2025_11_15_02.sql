-- DB update 2025_11_15_01 -> 2025_11_15_02
--
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 35415);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(35415, 0, 68068, 0),
(35415, 1, 67442, 0);

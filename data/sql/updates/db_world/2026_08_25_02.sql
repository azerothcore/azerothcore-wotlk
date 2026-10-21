-- DB update 2026_08_25_01 -> 2026_08_25_02
--
-- Matches 25man chopper abilities to that of 10man entry 33062
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 34045 AND `Index` = 4);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(34045, 4, 67372, 0);

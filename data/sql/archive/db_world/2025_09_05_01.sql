-- DB update 2025_09_05_00 -> 2025_09_05_01
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 21750 AND `Index` IN (2, 3);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(21750, 2, 37463, 0),
(21750, 3, 37469, 0);

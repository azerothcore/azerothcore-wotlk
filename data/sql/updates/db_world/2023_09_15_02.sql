-- DB update 2023_09_15_01 -> 2023_09_15_02
--
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 21750 AND `Index` = 2;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(21750, 2, 37469, 0);

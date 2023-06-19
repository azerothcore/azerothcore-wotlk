-- DB update 2023_05_24_00 -> 2023_05_24_01
--
DELETE FROM `creature_template_spell` WHERE `CreatureID`=18847 AND `Index`=2 AND `Spell`=33096;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES (18847, 2, 33096, 0);


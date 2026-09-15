-- DB update 2026_08_27_11 -> 2026_08_28_00
-- Ulduar: Salvaged Chopper action bar layout, sniff-verified.
-- Grab Pyrite (67372) sits at position 4, position 5 is empty, First Aid (64660) at position 6.
DELETE FROM `creature_template_spell` WHERE `CreatureID` IN (33062, 34045) AND `Index` IN (3, 4, 5);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(33062, 3, 67372, 69497),
(33062, 5, 64660, 69497),
(34045, 3, 67372, 69497),
(34045, 5, 64660, 69497);

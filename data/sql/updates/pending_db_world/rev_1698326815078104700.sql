-- Fire Nova Totem VII - Cast Fire Nova (Rank 7)
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 15483);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(15483, 0, 25537, 42328);

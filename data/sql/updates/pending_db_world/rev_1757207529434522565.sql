-- Add Blink spell to Beryl Sorcerer
DELETE FROM `creature_template_spell` WHERE `CreatureID`=25316 AND `Index`=0;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES (25316, 0, 50648, 0);

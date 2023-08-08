-- Quest Vile Like Fire (13071)
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 30564;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES (30564, 6, 57403, 12340);

-- fixed because the kites are stuck in the ground
UPDATE `creature_template_movement` SET `Flight`=2 WHERE  `CreatureId`=30272;
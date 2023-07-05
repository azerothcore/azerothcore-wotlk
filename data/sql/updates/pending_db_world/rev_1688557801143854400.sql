-- Vile Like Fire! (13071)
-- fix Njorndar Proto-Drake vehicle unable to fly
INSERT INTO `acore_world`.`creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES (30564, 6, 57403, 12340);

-- fix Njorndar Proto-Drake display status on the ground
UPDATE `acore_world`.`creature_template_movement` SET `Flight`=2 WHERE  `CreatureId`=30272;

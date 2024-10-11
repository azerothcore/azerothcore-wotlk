-- DB update 2023_08_14_04 -> 2023_08_19_00
-- Vile Like Fire! (13071)
-- fix Njorndar Proto-Drake vehicle unable to fly
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 30564;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30564, 0, 57493, 12340),
(30564, 2, 7769, 12340),
(30564, 6, 57403, 12340);
-- fix Njorndar Proto-Drake display status on the ground
UPDATE `creature_template_movement` SET `Flight`=2 WHERE  `CreatureId`=30272;

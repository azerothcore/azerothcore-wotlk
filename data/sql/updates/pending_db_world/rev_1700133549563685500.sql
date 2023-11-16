-- Fear Fiend
UPDATE `creature_template_addon` SET `auras` = '35408' WHERE `entry` = 22204;

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 22204;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(22204, 0, 36248, 0),
(22204, 1, 34259, 0);

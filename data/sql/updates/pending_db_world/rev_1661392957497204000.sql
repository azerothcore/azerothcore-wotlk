--
UPDATE `creature_template` SET `DamageModifier` = 11.85, `ArmorModifier` = 1.3 WHERE (`entry` = 15355);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15355) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15355, 2, 135, 0),
(15355, 3, 135, 0),
(15355, 4, 135, 0),
(15355, 5, 135, 0),
(15355, 6, 135, 0);

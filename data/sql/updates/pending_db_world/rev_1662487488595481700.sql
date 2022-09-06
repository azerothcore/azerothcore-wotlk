-- I forgot these
UPDATE `creature_template` SET `DamageModifier` = 1.05, `ArmorModifier` = 1.1 WHERE (`entry` = 15316);
UPDATE `creature_template` SET `ArmorModifier` = 1.1 WHERE (`entry` = 15317);
UPDATE `creature_template` SET `DamageModifier` = 20, `ArmorModifier` = 1.15 WHERE (`entry` = 15246);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15316) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15316, 2, 75, 0),
(15316, 3, 75, 0),
(15316, 4, 75, 0),
(15316, 5, 75, 0),
(15316, 6, 75, 0),
(15317, 2, 75, 0),
(15317, 3, 75, 0),
(15317, 4, 75, 0),
(15317, 5, 75, 0),
(15317, 6, 75, 0),
(15246, 2, 75, 0),
(15246, 3, 75, 0),
(15246, 4, 75, 0),
(15246, 5, 75, 0),
(15246, 6, 75, 0);

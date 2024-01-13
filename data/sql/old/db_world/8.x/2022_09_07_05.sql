-- DB update 2022_09_07_04 -> 2022_09_07_05
-- I forgot these
UPDATE `creature_template` SET `DamageModifier` = 1.05, `ArmorModifier` = 1.1 WHERE (`entry` = 15316);
UPDATE `creature_template` SET `ArmorModifier` = 1.1 WHERE (`entry` = 15317);
UPDATE `creature_template` SET `DamageModifier` = 20, `ArmorModifier` = 1.15 WHERE (`entry` = 15246);
UPDATE `creature_template` SET `DamageModifier` = 3, `ArmorModifier` = 1.15 WHERE (`entry` = 15537);
UPDATE `creature_template` SET `DamageModifier` = 9.75, `ArmorModifier` = 1.15 WHERE (`entry` = 15538);

DELETE FROM `creature_template_resistance` WHERE `CreatureID` IN (15316,15317,15246,15537,15538);
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
(15246, 6, 75, 0),
(15537, 2, 75, 0),
(15537, 3, 75, 0),
(15537, 4, 75, 0),
(15537, 5, 75, 0),
(15537, 6, 75, 0),
(15538, 2, 115, 0),
(15538, 3, 115, 0),
(15538, 4, 115, 0),
(15538, 5, 115, 0),
(15538, 6, 115, 0);

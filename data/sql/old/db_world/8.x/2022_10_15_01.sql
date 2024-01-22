-- DB update 2022_10_15_00 -> 2022_10_15_01
-- Shade of Taerar
UPDATE `creature_template` SET `DamageModifier` = 12.65, `ArmorModifier` = 1.05 WHERE (`entry` = 15302);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15302) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15302, 2, 15, 0),
(15302, 3, 15, 0),
(15302, 4, 15, 0),
(15302, 5, 15, 0),
(15302, 6, 15, 0);

-- Taerar
UPDATE `creature_template` SET `DamageModifier` = 12.65, `ArmorModifier` = 1.3 WHERE (`entry` = 14890);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 14890) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(14890, 2, 126, 0),
(14890, 3, 126, 0),
(14890, 4, 126, 0),
(14890, 5, 126, 0),
(14890, 6, 126, 0);

-- Emeriss
UPDATE `creature_template` SET `DamageModifier` = 10.3, `ArmorModifier` = 1.3 WHERE (`entry` = 14889);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 14889) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(14889, 2, 126, 0),
(14889, 3, 126, 0),
(14889, 4, 126, 0),
(14889, 5, 126, 0),
(14889, 6, 126, 0);

-- Lethon
UPDATE `creature_template` SET `DamageModifier` = 19.55, `ArmorModifier` = 1.3 WHERE (`entry` = 14888);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 14888) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(14888, 2, 126, 0),
(14888, 3, 126, 0),
(14888, 4, 126, 0),
(14888, 5, 126, 0),
(14888, 6, 126, 0);

-- Ysondre
UPDATE `creature_template` SET `DamageModifier` = 12.55, `ArmorModifier` = 1.3 WHERE (`entry` = 14887);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 14887) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(14887, 2, 126, 0),
(14887, 3, 126, 0),
(14887, 4, 126, 0),
(14887, 5, 126, 0),
(14887, 6, 126, 0);

-- Demented Druid Spirit
UPDATE `creature_template` SET `DamageModifier` = 3.55, `BaseAttackTime` = 1410, `RangeAttackTime` = 1551, `ArmorModifier` = 0.35 WHERE (`entry` = 15260);

-- Azuregos
UPDATE `creature_template` SET `DamageModifier` = 20.45, `ArmorModifier` = 1.3 WHERE (`entry` = 6109);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 6109) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(6109, 2, 126, 0),
(6109, 3, 126, 0),
(6109, 4, 300, 0),
(6109, 5, 126, 0),
(6109, 6, 300, 0);

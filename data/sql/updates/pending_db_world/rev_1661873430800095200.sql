-- Gurubashi Axe Thrower (11350)
UPDATE `creature_template` SET `DamageModifier` = 4.05, `ArmorModifier` = 1.1 WHERE (`entry` = 11350);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 11350) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(11350, 2, 15, 0),
(11350, 3, 15, 0),
(11350, 4, 15, 0),
(11350, 5, 15, 0),
(11350, 6, 15, 0);

-- Hakkari Priest (11830)
UPDATE `creature_template` SET `DamageModifier` = 5.05, `ArmorModifier` = 1.1 WHERE (`entry` = 11830);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 11830) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(11830, 2, 15, 0),
(11830, 3, 15, 0),
(11830, 4, 15, 0),
(11830, 5, 15, 0),
(11830, 6, 15, 0);

-- Razzashi Serpent (11371)
UPDATE `creature_template` SET `DamageModifier` = 4, `ArmorModifier` = 1.1 WHERE (`entry` = 11371);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 11371) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(11371, 2, 15, 0),
(11371, 3, 15, 0),
(11371, 4, 15, 0),
(11371, 5, 15, 0),
(11371, 6, 15, 0);

-- Razzashi Adder (11372)
UPDATE `creature_template` SET `DamageModifier` = 4.2, `ArmorModifier` = 1.1 WHERE (`entry` = 11372);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 11372) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(11372, 2, 15, 0),
(11372, 3, 15, 0),
(11372, 4, 15, 0),
(11372, 5, 15, 0),
(11372, 6, 15, 0);

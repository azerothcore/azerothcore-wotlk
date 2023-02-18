-- DB update 2022_09_08_00 -> 2022_09_08_01
-- Remove gold drops from a summoned creature before I forget again
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE (`entry` = 15538);
-- Anubisath Guardian (15355)
UPDATE `creature_template` SET `DamageModifier` = 11.85, `ArmorModifier` = 1.3 WHERE (`entry` = 15355);
-- Flesh Hunter (15335)
UPDATE `creature_template` SET `DamageModifier` = 15.95, `ArmorModifier` = 1.2 WHERE (`entry` = 15335);
-- Qiraji Gladiator (15324)
UPDATE `creature_template` SET `DamageModifier` = 24.7, `ArmorModifier` = 1.35 WHERE (`entry` = 15324);
-- Hive'Zara Wasp (15325) & Hive'Zara Stinger (15327)
UPDATE `creature_template` SET `DamageModifier` = 12.6, `ArmorModifier` = 1.15 WHERE `entry` IN (15325, 15327);
-- Hive'Zara Swarmer (15546)
UPDATE `creature_template` SET `DamageModifier` = 1.1, `ArmorModifier` = 1.1 WHERE (`entry` = 15546);
-- Hive'Zara Hornet (15934)
UPDATE `creature_template` SET `speed_walk` = 2.4, `speed_run` = 2.14286, `DamageModifier` = 10, `ArmorModifier` = 1.15 WHERE (`entry` = 15934);
-- Hive'Zara Soldier (15320)
UPDATE `creature_template` SET `DamageModifier` = 20.3, `ArmorModifier` = 1.15 WHERE (`entry` = 15320);
-- Hive'Zara Sandstalker (15323)
UPDATE `creature_template` SET `DamageModifier` = 6.5, `ArmorModifier` = 1.15 WHERE (`entry` = 15323);
-- Hive'Zara Collector (15319)
UPDATE `creature_template` SET `DamageModifier` = 12.3, `ArmorModifier` = 1.1 WHERE (`entry` = 15319);
-- Hive'Zara Tail Lasher (15336)
UPDATE `creature_template` SET `DamageModifier` = 12.1, `ArmorModifier` = 1.15 WHERE (`entry` = 15336);
-- Hive'Zara Drone (15318)
UPDATE `creature_template` SET `DamageModifier` = 7.9, `ArmorModifier` = 1.1 WHERE (`entry` = 15318);
-- Shrieker Scarab (15461)
UPDATE `creature_template` SET `DamageModifier` = 2.9, `ArmorModifier` = 1.1 WHERE (`entry` = 15461);
-- Spitting Scarab (15462)
UPDATE `creature_template` SET `DamageModifier` = 4.15, `ArmorModifier` = 1.2 WHERE (`entry` = 15462);
-- Obsidian Destroyer (15338)
UPDATE `creature_template` SET `DamageModifier` = 4.95, `ArmorModifier` = 1.65 WHERE (`entry` = 15338);
-- Qiraji Warrior (15387)
UPDATE `creature_template` SET `DamageModifier` = 6.1, `ArmorModifier` = 1.15 WHERE (`entry` = 15387);
-- Swarmguard Needler (15344)
UPDATE `creature_template` SET `DamageModifier` = 12.1, `ArmorModifier` = 1.2 WHERE (`entry` = 15344);
-- Hive'Zara Hatchling (15521)
UPDATE `creature_template` SET `DamageModifier` = 12.3, `ArmorModifier` = 1.1 WHERE (`entry` = 15521);
-- Mana Fiend (15527)
UPDATE `creature_template` SET `dmgschool` = 6, `DamageModifier` = 8.5, `ArmorModifier` = 1.1 WHERE (`entry` = 15527);
-- Anubisath Warrior (15537)
UPDATE `creature_template` SET `DamageModifier` = 3, `ArmorModifier` = 1.15 WHERE (`entry` = 15537);
-- Anubisath Swarmguard (15538)
UPDATE `creature_template` SET `DamageModifier` = 9.75, `ArmorModifier` = 1.15 WHERE (`entry` = 15538);
-- Captain Qeez (15391)
UPDATE `creature_template` SET `DamageModifier` = 11.65, `ArmorModifier` = 1.2 WHERE (`entry` = 15391);
-- Captain Tuubid (15392)
UPDATE `creature_template` SET `DamageModifier` = 14.9, `ArmorModifier` = 1.3 WHERE (`entry` = 15392);
-- Captain Drenn (15389), Captain Xurrem (15390), Major Yeggeth (15386), Colonel Zerran (15385), Major Pakkon (15388)
UPDATE `creature_template` SET `DamageModifier` = 11.65, `ArmorModifier` = 1.3 WHERE `entry` IN (15389, 15390, 15386, 15385, 15388);
-- Qiraji Swarmguard (15343)
UPDATE `creature_template` SET `DamageModifier` = 17.65, `ArmorModifier` = 1.35 WHERE (`entry` = 15343);
-- Kurinnaxx (15348)
UPDATE `creature_template` SET `detection_range` = 50, `DamageModifier` = 18.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15348);
-- General Rajaxx (15341)
UPDATE `creature_template` SET `DamageModifier` = 15.3, `ArmorModifier` = 1.3 WHERE (`entry` = 15341);
-- Buru the Gorger (15370)
UPDATE `creature_template` SET `DamageModifier` = 7.35, `ArmorModifier` = 1.3 WHERE (`entry` = 15370);
-- Ayamiss the Hunter (15369)
UPDATE `creature_template` SET `DamageModifier` = 11.75, `ArmorModifier` = 1.3 WHERE (`entry` = 15369);
-- Moam (15340)
UPDATE `creature_template` SET `DamageModifier` = 10.25, `ArmorModifier` = 1.8 WHERE (`entry` = 15340);
-- Ossirian the Unscarred (15339)
UPDATE `creature_template` SET `detection_range` = 30, `DamageModifier` = 33.35, `ArmorModifier` = 1.3 WHERE (`entry` = 15339);
-- Vile Scarab (15168)
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE (`entry` = 15168);
-- Silicate Feeder (15333)
UPDATE `creature_template` SET `DamageModifier` = 5.05 WHERE (`entry` = 15333);
-- Resistances
DELETE FROM `creature_template_resistance` WHERE `CreatureID` IN (15339,15340,15369,15370,15341,15348,15343,15388,15385,15386,15390,15389,15392,15391,15538,15537,15344,15338,15336,15323,15320,15934,15327,15325,15324,15335,15355);
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15339, 6, 1000, 0),
(15340, 2, 155, 0),
(15340, 3, 155, 0),
(15340, 4, 155, 0),
(15340, 5, 155, 0),
(15340, 6, 155, 0),
(15369, 2, 135, 0),
(15369, 3, 135, 0),
(15369, 4, 135, 0),
(15369, 5, 135, 0),
(15369, 6, 135, 0),
(15370, 2, 135, 0),
(15370, 3, 135, 0),
(15370, 4, 135, 0),
(15370, 5, 135, 0),
(15370, 6, 135, 0),
(15341, 2, 135, 0),
(15341, 3, 135, 0),
(15341, 4, 135, 0),
(15341, 5, 135, 0),
(15341, 6, 135, 0),
(15348, 2, 115, 0),
(15348, 3, 115, 0),
(15348, 4, 115, 0),
(15348, 5, 115, 0),
(15348, 6, 115, 0),
(15343, 2, 135, 0),
(15343, 3, 135, 0),
(15343, 4, 135, 0),
(15343, 5, 135, 0),
(15343, 6, 135, 0),
(15388, 2, 115, 0),
(15388, 3, 115, 0),
(15388, 4, 115, 0),
(15388, 5, 115, 0),
(15388, 6, 115, 0),
(15385, 2, 135, 0),
(15385, 3, 135, 0),
(15385, 4, 135, 0),
(15385, 5, 135, 0),
(15385, 6, 135, 0),
(15386, 2, 135, 0),
(15386, 3, 135, 0),
(15386, 4, 135, 0),
(15386, 5, 135, 0),
(15386, 6, 135, 0),
(15390, 2, 115, 0),
(15390, 3, 115, 0),
(15390, 4, 115, 0),
(15390, 5, 115, 0),
(15390, 6, 115, 0),
(15389, 2, 115, 0),
(15389, 3, 115, 0),
(15389, 4, 115, 0),
(15389, 5, 115, 0),
(15389, 6, 115, 0),
(15392, 2, 115, 0),
(15392, 3, 115, 0),
(15392, 4, 115, 0),
(15392, 5, 115, 0),
(15392, 6, 115, 0),
(15391, 2, 115, 0),
(15391, 3, 115, 0),
(15391, 4, 115, 0),
(15391, 5, 115, 0),
(15391, 6, 155, 0),
(15538, 2, 115, 0),
(15538, 3, 115, 0),
(15538, 4, 115, 0),
(15538, 5, 115, 0),
(15538, 6, 115, 0),
(15537, 2, 75, 0),
(15537, 3, 75, 0),
(15537, 4, 75, 0),
(15537, 5, 75, 0),
(15537, 6, 75, 0),
(15344, 2, 95, 0),
(15344, 3, 95, 0),
(15344, 4, 95, 0),
(15344, 5, 95, 0),
(15344, 6, 95, 0),
(15338, 2, 135, 0),
(15338, 3, 135, 0),
(15338, 4, 135, 0),
(15338, 5, 135, 0),
(15338, 6, 135, 0),
(15336, 2, 5, 0),
(15336, 3, 5, 0),
(15336, 4, 5, 0),
(15336, 5, 5, 0),
(15336, 6, 5, 0),
(15323, 2, 5, 0),
(15323, 3, 5, 0),
(15323, 4, 5, 0),
(15323, 5, 5, 0),
(15323, 6, 5, 0),
(15320, 2, 5, 0),
(15320, 3, 5, 0),
(15320, 4, 5, 0),
(15320, 5, 5, 0),
(15320, 6, 5, 0),
(15934, 2, 5, 0),
(15934, 3, 5, 0),
(15934, 4, 5, 0),
(15934, 5, 5, 0),
(15934, 6, 5, 0),
(15327, 2, 5, 0),
(15327, 3, 5, 0),
(15327, 4, 5, 0),
(15327, 5, 5, 0),
(15327, 6, 5, 0),
(15325, 2, 5, 0),
(15325, 3, 5, 0),
(15325, 4, 5, 0),
(15325, 5, 5, 0),
(15325, 6, 5, 0),
(15324, 2, 115, 0),
(15324, 3, 115, 0),
(15324, 4, 115, 0),
(15324, 5, 115, 0),
(15324, 6, 115, 0),
(15335, 2, 135, 0),
(15335, 3, 135, 0),
(15335, 4, 135, 0),
(15335, 5, 135, 0),
(15335, 6, 135, 0),
(15355, 2, 135, 0),
(15355, 3, 135, 0),
(15355, 4, 135, 0),
(15355, 5, 135, 0),
(15355, 6, 135, 0);

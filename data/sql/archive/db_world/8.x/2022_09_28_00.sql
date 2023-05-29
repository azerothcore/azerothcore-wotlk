-- DB update 2022_09_26_00 -> 2022_09_28_00
-- Ossirian
UPDATE `creature_template` SET `detection_range` = 37 WHERE (`entry` = 15339);
-- Qiraji Gladiator
UPDATE `creature_template` SET `detection_range` = 38.75 WHERE (`entry` = 15324);
-- Qiraji Swarmguard
UPDATE `creature_template` SET `detection_range` = 34.125 WHERE (`entry` = 15343);
-- Hive'Zara Stinger & Wasp
UPDATE `creature_template` SET `detection_range` = 28.75 WHERE (`entry` IN (15327, 15325));
-- Obsidian Destroyer
UPDATE `creature_template` SET `detection_range` = 36.5 WHERE (`entry` = 15338);
-- Anubisath Guardian
UPDATE `creature_template` SET `detection_range` = 35.25 WHERE (`entry` = 15355);
-- Ayamiss
UPDATE `creature_template` SET `detection_range` = 34.5 WHERE (`entry` = 15369);
-- Hive'Zara Sandstalker & Soldier
UPDATE `creature_template` SET `detection_range` = 28.75 WHERE (`entry` IN (15323, 15320));

-- DB update 2022_10_07_03 -> 2022_10_07_04
UPDATE `creature_template` SET `detection_range` = 37.5 WHERE (`entry` IN (15262, 15312));
UPDATE `creature_template` SET `detection_range` = 38.5 WHERE (`entry` = 15263);
UPDATE `creature_template` SET `detection_range` = 15 WHERE (`entry` = 15300);
UPDATE `creature_template` SET `detection_range` = 35 WHERE (`entry` IN (15240, 15230, 15264, 15311));
UPDATE `creature_template` SET `detection_range` = 40 WHERE (`entry` IN (15235, 15236, 15249, 15509, 15277, 15229, 15544, 15543, 15511, 15233, 15247, 15275, 15276, 15252, 15246, 15250, 15299));

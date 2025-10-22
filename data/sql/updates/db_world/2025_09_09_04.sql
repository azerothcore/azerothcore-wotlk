-- DB update 2025_09_09_03 -> 2025_09_09_04
UPDATE `creature_template_addon` SET `auras` = '19818 34623' WHERE `entry` = 18733;
UPDATE `creature_addon` SET `visibilityDistanceType` = 5, `auras` = '19818 34623' WHERE `guid` IN (67001, 203341);

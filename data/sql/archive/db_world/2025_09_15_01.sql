-- DB update 2025_09_15_00 -> 2025_09_15_01
-- Walk/run speed, faction, attack speeds, and model info all verified against 45772.
UPDATE `creature_addon` SET `visibilityDistanceType` = 5 WHERE `guid` IN (118177, 118191);
UPDATE `creature_template_addon` SET `auras` = '44385' WHERE `entry` = 24812;

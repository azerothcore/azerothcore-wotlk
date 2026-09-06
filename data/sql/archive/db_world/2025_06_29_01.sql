-- DB update 2025_06_29_00 -> 2025_06_29_01
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 WHERE `entry` = 23741;

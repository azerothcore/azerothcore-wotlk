-- DB update 2025_09_12_04 -> 2025_09_12_05
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10928 AND `source_type` = 0;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 10928;

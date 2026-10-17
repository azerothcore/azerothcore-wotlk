-- DB update 2025_11_15_13 -> 2025_11_15_14
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27598 AND `source_type` = 0;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 27598;

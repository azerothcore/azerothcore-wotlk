-- DB update 2023_07_26_03 -> 2023_07_26_04
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 12298;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12298) AND (`source_type` = 0);

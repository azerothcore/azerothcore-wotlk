-- DB update 2025_09_09_04 -> 2025_09_09_05
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 29978;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29984) AND (`source_type` = 0) AND (`id` = 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29978) AND (`source_type` = 0);

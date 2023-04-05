-- DB update 2023_04_05_00 -> 2023_04_05_01
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 22930;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22930) AND (`source_type` = 0);


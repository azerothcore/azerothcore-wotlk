-- DB update 2024_06_09_01 -> 2024_06_09_02
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 18145;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18145) AND (`source_type` = 0);

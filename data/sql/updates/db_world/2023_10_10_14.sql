-- DB update 2023_10_10_13 -> 2023_10_10_14
-- Zeppelin Power Core
UPDATE `creature_template_addon` SET `auras` = '42491' WHERE (`entry` = 23832);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 23832;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23832) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2383200) AND (`source_type` = 9);

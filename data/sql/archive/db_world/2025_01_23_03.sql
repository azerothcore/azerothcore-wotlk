-- DB update 2025_01_23_02 -> 2025_01_23_03
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 24777;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24777) AND (`source_type` = 0);
UPDATE `creature_addon` SET `auras` = '44537' WHERE `guid` IN (96944, 96945, 96946);

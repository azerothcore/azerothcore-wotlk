-- DB update 2023_05_12_00 -> 2023_05_12_01
--
UPDATE `creature_template` SET `ScriptName` = 'boss_tavarok', `AIName` = '' WHERE `entry` = 18343;
UPDATE `creature_template` SET `ScriptName` = 'boss_darkweaver_syth', `AIName` = '' WHERE `entry` = 18472;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18343, 18472, 1847200) AND (`source_type` = 0 OR `source_type` = 9);

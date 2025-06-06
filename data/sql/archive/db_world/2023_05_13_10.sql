-- DB update 2023_05_13_09 -> 2023_05_13_10
--
UPDATE `creature_template` SET `ScriptName` = 'boss_swamplord_muselek', `AIName`= '' WHERE `entry` = 17826;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17826 AND `source_type` = 0;

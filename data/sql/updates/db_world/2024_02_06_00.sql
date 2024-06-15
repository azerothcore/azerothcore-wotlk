-- DB update 2024_02_05_04 -> 2024_02_06_00
--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tainted_elemental' WHERE `entry` = 22009;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 22009 AND `source_type` = 0;

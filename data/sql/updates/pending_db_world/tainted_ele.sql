--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tainted_elemental' WHERE `entry` = 22009;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 22009 AND `source_type` = 0;

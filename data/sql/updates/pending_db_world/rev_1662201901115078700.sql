--
UPDATE `creature_template` SET `AiName`='', `ScriptName`='npc_obsidian_warder' WHERE `entry`=15311;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15311 AND `source_type`=0;

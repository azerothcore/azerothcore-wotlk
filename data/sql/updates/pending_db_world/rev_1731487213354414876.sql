UPDATE `creature_template` SET `ScriptName` = 'npc_dawnblade_marksman', `AIName` = '' WHERE `entry` = 24979;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 24979 AND `source_type` = 0;

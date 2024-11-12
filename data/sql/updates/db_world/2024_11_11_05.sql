-- Clear existing scripts for the NPC to avoid conflicts
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24999;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_irespeaker' WHERE (`entry` = '24999');


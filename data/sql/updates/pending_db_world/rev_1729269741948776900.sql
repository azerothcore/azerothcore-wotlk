-- Remove SmartAI sql for NPC Jenny (25969)
DELETE FROM `smart_scripts`
WHERE `entryorguid` = 25969;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_jenny' WHERE (`entry` = 25969);

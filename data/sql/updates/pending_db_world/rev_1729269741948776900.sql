-- Remove SmartAI sql for NPC Jenny (25969)
DELETE FROM `smart_scripts` 
WHERE `entryorguid` = 25969;
-- Update creature template for NPC Jenny (25969)
UPDATE `creature_template` 
SET `speed_run` = 1, `speed_walk` = 0.8, `speed_swim` = 0.6, `AIName` = "", `ScriptName` = "npc_jenny"
WHERE `entry` = 25969;
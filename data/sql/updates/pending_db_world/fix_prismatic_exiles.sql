-- Remove SmartAI and add script name
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_prismatic_exile' WHERE `entry` = 2887;

-- delete old smartscript
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2887) AND (`source_type` = 0);

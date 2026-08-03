-- DB update 2025_04_13_04 -> 2025_04_14_00
-- Remove SmartAI from dark fiend to ScriptedAI (c++)
UPDATE `creature_template` SET
  `AIName` = '',
  `ScriptName` = 'npc_dark_fiend'
WHERE `entry` = 25744;

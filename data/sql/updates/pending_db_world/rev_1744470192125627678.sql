-- Remove SmartAI from dark fiend to ScriptedAI (c++)
UPDATE `creature_template` SET
  `AIName` = '',
  `ScriptName` = 'npc_dark_fiend'
WHERE `entry` = 25744;

-- ============================================================
-- [QUEST] Battle at Valhalas: Fallen Heroes (Quest ID: 13214)
-- Fix: Assign ScriptName to the 6 Fallen Heroes so they use
--      npc_valhalas_fallen_hero AI (linked aggro + grouped evade)
--
-- NPC entries:
--   31191 - Jhadras
--   31192 - Masud
--   31193 - Geness Half-Soul
--   31194 - Talla
--   31195 - Eldreth
--   31196 - Rith
--
-- Issue: AC #24277
-- ============================================================

UPDATE `creature_template` SET `ScriptName` = 'npc_valhalas_fallen_hero' WHERE `entry` IN (31191, 31192, 31193, 31194, 31195, 31196);

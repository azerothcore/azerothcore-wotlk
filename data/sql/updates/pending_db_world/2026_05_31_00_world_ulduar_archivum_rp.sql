-- DB update 2026_05_31_00 by GuillermoVT
-- Fix: Archivum RP (Brann Bronzebeard) does not trigger after Iron Council defeat
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/25464
--
-- Root cause: The SmartAI OOC event on Brann Bronzebeard (entry 33235) that triggers
-- his own SetData(1,1) has the NOT_REPEATABLE flag set (event_flags = 513 = 0x001 + 0x200).
-- This means if the OOC event fired once and the instance saves as DONE, on server restart
-- Brann respawns invisible and the SAI event cannot fire again.
--
-- The primary fix is in instance_ulduar.cpp (SetBossState and OnCreatureCreate), which
-- directly calls Brann->AI()->SetData(1, 1) when BOSS_ASSEMBLY reaches DONE state.
-- This SQL removes the NOT_REPEATABLE flag from the SAI OOC event as a defensive measure,
-- restoring the flag to WHILE_CHARMED only (0x200 = 512).

UPDATE `smart_scripts` SET `event_flags` = 512
WHERE `entryorguid` = 33235
  AND `source_type` = 0
  AND `id` = 12
  AND `event_type` = 1
  AND `event_flags` = 513;

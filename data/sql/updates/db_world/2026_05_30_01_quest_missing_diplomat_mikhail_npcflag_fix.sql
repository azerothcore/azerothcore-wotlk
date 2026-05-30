-- DB update 2026_05_30_00 -> 2026_05_30_01
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/25920
-- Quest "The Missing Diplomat" - Part 11 (quest 1249)
--
-- Root cause:
--   Mikhail (entry 4963) uses SMART_ACTION_SET_NPC_FLAG (action 81) which
--   OVERWRITES all npcflags. When the player accepts quest 1249, script id=1
--   fires and sets npcflag=1 (GOSSIP only), destroying the QUESTGIVER(2) flag.
--   There is no handler for quest abandonment in SmartAI, so if the player
--   abandons quest 1249 before completing it, Mikhail permanently loses the
--   QUESTGIVER flag for that session (until he respawns in 300s).
--   While stuck in this state, Mikhail cannot re-offer the quest, leaving the
--   player unable to progress the chain.
--
-- Fix 1 - Mikhail id=0 (ON_RESPAWN):
--   Set npcflag=3 (GOSSIP=1 + QUESTGIVER=2) instead of 2 (QUESTGIVER only).
--   This matches creature_template.npcflag=3 for entry 4963.
--
-- Fix 2 - Mikhail id=1 (ON_QUEST_ACCEPTED 1249):
--   Change SMART_ACTION_SET_NPC_FLAG (81, overwrites) to
--   SMART_ACTION_ADD_NPC_FLAG (82, additive) for the GOSSIP flag.
--   This adds GOSSIP without removing QUESTGIVER.
--   Result: while quest 1249 is active, Mikhail has both flags (npcflag=3).
--   If the player abandons the quest, Mikhail still shows QUESTGIVER and can
--   re-offer the quest immediately without waiting for respawn.
--
-- Fix 3 - Action list 496300 id=1 (fires after Tapoke is subdued / quest done):
--   Set npcflag=3 (GOSSIP + QUESTGIVER) instead of 2 (QUESTGIVER only),
--   to be consistent with the creature_template default and Fix 1.

-- ============================================================
-- Fix 1: Mikhail ON_RESPAWN - restore both GOSSIP + QUESTGIVER
-- ============================================================
UPDATE `smart_scripts`
SET
    `action_param1` = 3,
    `comment` = 'Mikhail - On Respawn - Set Npc Flag Gossip + Questgiver'
WHERE `entryorguid` = 4963
  AND `source_type` = 0
  AND `id` = 0;

-- ============================================================
-- Fix 2: Mikhail ON_QUEST_ACCEPTED(1249) - ADD GOSSIP flag,
--        do NOT overwrite (keeps QUESTGIVER intact)
-- ============================================================
UPDATE `smart_scripts`
SET
    `action_type`   = 82,   -- SMART_ACTION_ADD_NPC_FLAG (was 81 = SET, destructive)
    `comment`       = 'Mikhail - On Quest ''The Missing Diplomat (Part 11)'' Taken - Add Npc Flag Gossip'
WHERE `entryorguid` = 4963
  AND `source_type` = 0
  AND `id` = 1;

-- ============================================================
-- Fix 3: Action list 496300 id=1 (post-quest-complete) -
--        restore GOSSIP + QUESTGIVER, not just QUESTGIVER
-- ============================================================
UPDATE `smart_scripts`
SET
    `action_param1` = 3,
    `comment`       = 'Mikhail - On Script - Set Npc Flag Gossip + Questgiver'
WHERE `entryorguid` = 496300
  AND `source_type` = 9
  AND `id` = 1;

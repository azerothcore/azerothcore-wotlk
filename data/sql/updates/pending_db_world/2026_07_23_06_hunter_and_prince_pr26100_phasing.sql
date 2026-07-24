-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/1942
-- Quest "The Hunter and the Prince" (Alliance 13400 / Horde 13361)
--
-- Root cause 1 (Phasing): Matthias Lehner (entry 32497) summons Illidan (entry 31395)
-- via SmartAI LINKED action, but never applies a phaseMask change to the player.
-- Illidan sets his own phaseMask to 4 on AI_INIT, so the player must be in phaseMask 5
-- (bits 1 + 4) to see him. Without this the player cannot interact with Illidan and
-- the quest cannot be completed.
--
-- Root cause 2 (No cleanup): No REWARD_QUEST handler exists to restore the player's
-- phaseMask to 1 after the quest is turned in, and there is no SmartAI event at all
-- for "player abandoned the quest" (abandoning doesn't involve any NPC), so that path
-- needs a different mechanism.
--
-- Fix for Matthias Lehner (entry 32497), source_type 0 (CREATURE), pure SmartAI/DB,
-- no core changes required:
--   id 0  On Quest Accept (Horde  13361)  -> SET_INGAME_PHASE_MASK(5) on INVOKER, link to id 2
--   id 1  On Quest Accept (Alliance 13400) -> SET_INGAME_PHASE_MASK(5) on INVOKER, link to id 2
--   id 2  LINKED -> SUMMON_GAMEOBJECT 194023 at spawn coords, 50 s, link to id 3
--   id 3  LINKED -> SUMMON_CREATURE 31395 at spawn coords, TIMED_DESPAWN 60 000 ms
--   id 4  On Quest Reward (Alliance 13400) -> SET_INGAME_PHASE_MASK(1) on INVOKER (restore)
--   id 5  On Quest Reward (Horde  13361)  -> SET_INGAME_PHASE_MASK(1) on INVOKER (restore)
--   id 6  Out-of-combat pulse, every 5s, targeting nearby players -> SET_INGAME_PHASE_MASK(1).
--         Gated by conditions (see below) so it only ever acts on a player who is stuck
--         in phase 4 without the quest active anymore - i.e. they abandoned it. This
--         covers the abandon case without a dedicated "on quest abandon" SmartAI event,
--         which doesn't exist for creature-sourced scripts.

-- 1. Remove current (broken) scripts for Matthias Lehner
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32497 AND `source_type` = 0;
-- 2. Insert corrected scripts for Matthias Lehner (source_type 0)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- id 0: Quest Accept Horde (13361) -> phase player to 5, then chain
(32497, 0, 0, 2, 19, 0, 100, 512, 13361, 0, 0, 0, 0, 0, 44, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Accept (Horde 13361) - Set InGame Phase Mask 5 on Invoker'),
-- id 1: Quest Accept Alliance (13400) -> phase player to 5, then chain
(32497, 0, 1, 2, 19, 0, 100, 512, 13400, 0, 0, 0, 0, 0, 44, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Accept (Alliance 13400) - Set InGame Phase Mask 5 on Invoker'),
-- id 2: LINKED -> Summon GO 194023 (portal/circle), 50 s, chain to id 3
(32497, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 194023, 50, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6335.5, 2347.8, 477.23, 3.4, 'Matthias Lehner - Linked - Summon GO 194023'),
-- id 3: LINKED -> Summon Creature 31395 (Illidan), TIMED_DESPAWN 60 000 ms, no further link
(32497, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 12, 31395, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 6314.5, 2342.8, 479.4, 0.22, 'Matthias Lehner - Linked - Summon Creature Illidan Stormrage (31395) for 60s'),
-- id 4: Quest Reward Alliance (13400) -> restore phase to 1
(32497, 0, 4, 0, 20, 0, 100, 512, 13400, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Reward (Alliance 13400) - Restore InGame Phase Mask 1 on Invoker'),
-- id 5: Quest Reward Horde (13361) -> restore phase to 1
(32497, 0, 5, 0, 20, 0, 100, 512, 13361, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Reward (Horde 13361) - Restore InGame Phase Mask 1 on Invoker'),
-- id 6: OOC pulse every 5s -> restore phase 1 on nearby players (gated by conditions below)
(32497, 0, 6, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 17, 50, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - OOC Pulse - Restore Phase Mask 1 for players who abandoned the quest');

-- 3. Conditions for id 6: only fire on a player who has phase 4 set AND does not currently
-- have either quest variant active (i.e. they abandoned it - if they still have it, one of
-- the two negative QUESTTAKEN checks fails and nothing happens).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 0 AND `SourceEntry` = 32497 AND `SourceId` = 6;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 0, 32497, 6, 0, 26, 1, 4, 0, 0, 0, 0, 0, '', 'Player currently has phase 4 (Illidan phase)'),
(22, 0, 32497, 6, 0, 9, 1, 13400, 0, 0, 1, 0, 0, '', 'Player does NOT have quest 13400 active'),
(22, 0, 32497, 6, 0, 9, 1, 13361, 0, 0, 1, 0, 0, '', 'Player does NOT have quest 13361 active');

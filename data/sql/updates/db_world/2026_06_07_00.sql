-- DB update 2026_06_05_00 -> 2026_06_07_00
--
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/26050
-- Sanctified Retribution / Swift Retribution should only apply their bonus
-- when the Paladin has an active aura.
--
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63531, 'spell_pal_sanctified_retribution_aura');

-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/1942
-- Quest "The Hunter and the Prince" (Alliance 13400 / Horde 13361)
--
-- Root cause 1 (Phasing): Matthias Lehner (entry 32497) summons Illidan (entry 31395)
-- via SmartAI LINKED action, but never applies a phaseMask change to the player.
-- Illidan sets his own phaseMask to 4 on AI_INIT, so the player must be in phaseMask 5
-- (bits 1 + 4) to see him. Without this the player cannot interact with Illidan and
-- the quest cannot be completed.
--
-- Root cause 2 (No cleanup): No REWARD_QUEST or QUEST_FAIL handler exists to restore
-- the player's phaseMask to 1 after the quest is finished or abandoned.
--
-- Fix for Matthias Lehner (entry 32497), source_type 0 (CREATURE):
--   id 0  On Quest Accept (Horde  13361) -> SET_INGAME_PHASE_MASK(5) on INVOKER, link to id 2
--   id 1  On Quest Accept (Alliance 13400) -> SET_INGAME_PHASE_MASK(5) on INVOKER, link to id 2
--   id 2  LINKED -> SUMMON_GAMEOBJECT 194023 at spawn coords, 50 s, link to id 3
--   id 3  LINKED -> SUMMON_CREATURE 31395 at spawn coords, TIMED_DESPAWN 60 000 ms
--   id 4  On Quest Reward (Alliance 13400) -> SET_INGAME_PHASE_MASK(1) on INVOKER (restore)
--   id 5  On Quest Reward (Horde  13361)  -> SET_INGAME_PHASE_MASK(1) on INVOKER (restore)
--
-- Fix via Quest SmartAI (source_type 5) for both quest IDs:
--   entryorguid = questId, event SMART_EVENT_QUEST_FAIL(51)
--   -> SET_INGAME_PHASE_MASK(1) on INVOKER (restore phase on quest fail/abandon)

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
(32497, 0, 5, 0, 20, 0, 100, 512, 13361, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Matthias Lehner - On Quest Reward (Horde 13361) - Restore InGame Phase Mask 1 on Invoker');

-- 3. Quest SmartAI (source_type 5): restore phase on quest fail/abandon
-- SMART_EVENT_QUEST_FAIL = 51, target_type 7 = SMART_TARGET_ACTION_INVOKER (the player)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (13400, 13361) AND `source_type` = 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Alliance quest fail/abandon -> restore phase to 1
(13400, 5, 0, 0, 51, 0, 100, 512, 0, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 13400 (Alliance) - On Quest Fail/Abandon - Restore InGame Phase Mask 1 on Player'),
-- Horde quest fail/abandon -> restore phase to 1
(13361, 5, 0, 0, 51, 0, 100, 512, 0, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest 13361 (Horde) - On Quest Fail/Abandon - Restore InGame Phase Mask 1 on Player');

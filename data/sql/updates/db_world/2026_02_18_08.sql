-- DB update 2026_02_18_07 -> 2026_02_18_08
-- Fix Slaves to Saronite RP scripting (Issue #24157)
-- https://github.com/azerothcore/azerothcore-wotlk/issues/24157
--
-- This PR was created with AI assistance (Windsurf/Cascade).
--
-- Current behavior:
-- - Script 3139700: Slave runs to freedom (working correctly)
-- - Script 3139701: Slave yells and attacks (yelling is wrong per blizzlike)
--
-- Blizzlike behavior per 2009 video evidence (https://www.youtube.com/watch?v=QeW_q-24Z28):
-- 1. Slave silently runs to freedom
-- 2. Slave emotes "goes into a frenzy!" and becomes hostile (NO yelling)
-- 3. Slave yells one of their quotes and runs to pit to jump (NEW)
--
-- Changes:
-- 1. Gossip: cast 5429 on player; NpcFlags/EmoteState reset on respawn (template)
-- 2. Add third random outcome (pit-jumping with yell); three pit waypoints per sniffs
-- 3. Fix hostile behavior to use emote instead of yell
-- 4. Fix /say messages language from Orcish to Universal
-- 5. Add unknown voice whispers in Saronite Mines (spell_area 27769, area 4514)
-- 6. Freedom path and pit coordinates from in-game research (Gultask)
-- 7. Workaround (Gultask): run random script on gossip first, then cast 5429 on link;
--    pit outcome sets phase 1 and UPDATE (event 60) picks random pit (no actionlist overlap).

-- ============================================================================
-- 1. Gossip: Run random script first, then cast 5429 on link (fixes actionlist overlap).
--    MovementInform (event 34, pointId 1/2/3): jump then despawn 4000ms.
--    MovementInform pointId 4: freedom reached, despawn instant.
--    UPDATE phase 1: run random pit (3139703/4/5) so 1/3 chance without nested actionlist.
-- ============================================================================
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31397);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31397, 0, 0, 1, 62, 0, 100, 512, 10137, 0, 0, 0, 0, 0, 87, 3139700, 3139701, 3139702, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Gossip Option Selected - Run Random Script'),
(31397, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 5429, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Link - Cast 5429 on Player'),
(31397, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 14000, 14000, 0, 0, 11, 3148, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - IC - Cast Head Crack'),
(31397, 0, 3, 0, 1, 0, 15, 0, 10000, 30000, 50000, 70000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - OOC - Say text2'),
(31397, 0, 4, 5, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 97, 15, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 6966.75, 2067.58, 482.553, 0, 'Saronite Mine Slave - On Reached Pit 1 - Jump To Pos'),
(31397, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Reached Pit 1 - Despawn In 4000 ms'),
(31397, 0, 6, 7, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 97, 15, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 6904.17, 2026.23, 482.964, 0, 'Saronite Mine Slave - On Reached Pit 2 - Jump To Pos'),
(31397, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Reached Pit 2 - Despawn In 4000 ms'),
(31397, 0, 8, 9, 34, 0, 100, 0, 8, 3, 0, 0, 0, 0, 97, 15, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 6911.13, 1969.18, 488.24, 0, 'Saronite Mine Slave - On Reached Pit 3 - Jump To Pos'),
(31397, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Reached Pit 3 - Despawn In 4000 ms'),
(31397, 0, 10, 0, 60, 1, 100, 0, 1200, 1200, 0, 0, 0, 0, 87, 3139703, 3139704, 3139705, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Update Phase 1 - Run to Random Pit'),
(31397, 0, 11, 0, 34, 0, 100, 0, 8, 4, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - On Reached Freedom - Despawn Instant');

-- ============================================================================
-- 2a. Freedom path: move to PointId 4 (7026.46, 1877.16, 533.62); MovementInform 4 despawns (31397 id 11).
-- ============================================================================
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3139700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3139700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - Actionlist - Close Gossip'),
(3139700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - Actionlist - Remove Npc Flags Gossip'),
(3139700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 31866, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Mine Slave - Actionlist - Quest Credit Slaves to Saronite'),
(3139700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 4, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 7026.46, 1877.16, 533.627, 0, 'Saronite Mine Slave - Actionlist - Move To Freedom PointId 4');

-- ============================================================================
-- 2b. Pit outcome: yell, set phase 1 (no quest credit; UPDATE event 60 on 31397 runs random pit).
-- ============================================================================
DELETE FROM `smart_scripts` WHERE `entryorguid`=3139702 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3139702,9,0,0,0,0,100,0,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Close Gossip'),
(3139702,9,1,0,0,0,100,0,0,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Remove NPC Flag'),
(3139702,9,2,0,0,0,100,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Yell (GroupID 0)'),
(3139702,9,3,0,0,0,100,0,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Set Run On'),
(3139702,9,4,0,0,0,100,0,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Set Event Phase 1');

-- Pit scripts: only Move to Pos with PointId; MovementInform on 31397 handles jump + despawn
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3139703,3139704,3139705) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3139703,9,0,0,0,0,100,0,0,0,0,0,0,0,69,1,0,0,0,0,0,8,0,0,0,0,6966.371,2050.5237,519.42505,0,'Pit 1 - Move to pos PointId 1'),
(3139704,9,0,0,0,0,100,0,0,0,0,0,0,0,69,2,0,0,0,0,0,8,0,0,0,0,6915.9272,2025.5466,518.6113,0,'Pit 2 - Move to pos PointId 2'),
(3139705,9,0,0,0,0,100,0,0,0,0,0,0,0,69,3,0,0,0,0,0,8,0,0,0,0,6921.0854,1972.6857,523.33716,0,'Pit 3 - Move to pos PointId 3');

-- ============================================================================
-- 3. Fix hostile behavior: emote "goes into a frenzy!" instead of yelling
-- ============================================================================

-- Add emote text (Type 16 = CHAT_MSG_MONSTER_EMOTE)
DELETE FROM `creature_text` WHERE `CreatureID`=31397 AND `GroupID`=2;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(31397,2,0,'%s goes into a frenzy!',16,0,100,0,0,0,36719,0,'Saronite Mine Slave - Frenzy Emote');

-- Update hostile script to use emote (GroupID 2) instead of yell (GroupID 0)
DELETE FROM `smart_scripts` WHERE `entryorguid`=3139701 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3139701,9,0,0,0,0,100,0,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Close Gossip'),
(3139701,9,1,0,0,0,100,0,0,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Set Faction Hostile'),
(3139701,9,2,0,0,0,100,0,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Emote (GroupID 2 - frenzy)'),
(3139701,9,3,0,0,0,100,0,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Attack'),
(3139701,9,4,0,0,0,100,0,0,0,0,0,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Cast Enrage');

-- ============================================================================
-- 4. Fix /say messages language from Orcish (1) to Universal (0)
-- ============================================================================
UPDATE `creature_text` SET `Language`=0 WHERE `CreatureID`=31397 AND `GroupID`=1;

-- ============================================================================
-- 5. Unknown voice whispers in Saronite Mines (same as Whisper Gulch)
-- ============================================================================
DELETE FROM `spell_area` WHERE `spell` = 27769 AND `area` = 4514;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`,`quest_start_status`,`quest_end_status`) VALUES
(27769,4514,0,0,0,0,2,1,64,11);

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
-- 1. Add third random outcome (pit-jumping with yell)
-- 2. Fix hostile behavior to use emote instead of yell
-- 3. Fix /say messages language from Orcish to Universal
-- 4. Add unknown voice whispers in Saronite Mines (spell_area for 27769 in Icecrown)

-- ============================================================================
-- 1. Add third behavior: Slave yells and runs to pit to jump
-- ============================================================================

-- Update gossip script to include third random outcome
UPDATE `smart_scripts` SET `action_param3`=3139702
WHERE `entryorguid`=31397 AND `source_type`=0 AND `id`=0 AND `event_type`=62;

-- Add new action list for pit-jumping behavior (script 3139702)
-- Slave yells, gives quest credit, then runs to pit and jumps
DELETE FROM `smart_scripts` WHERE `entryorguid`=3139702 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3139702,9,0,0,0,0,100,0,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Close Gossip'),
(3139702,9,1,0,0,0,100,0,0,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Remove NPC Flag'),
(3139702,9,2,0,0,0,100,0,0,0,0,0,0,0,33,31866,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Quest Credit'),
(3139702,9,3,0,0,0,100,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Yell (GroupID 0)'),
(3139702,9,4,0,0,0,100,0,500,500,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Set Run On'),
(3139702,9,5,0,0,0,100,0,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,6931,2014,519,0,'Saronite Mine Slave - On Script - Move to Pit Edge'),
(3139702,9,6,0,0,0,100,0,4000,4000,0,0,0,0,97,15,15,0,0,0,0,8,0,0,0,0,6940,2020,450,0,'Saronite Mine Slave - On Script - Jump Into Pit'),
(3139702,9,7,0,0,0,100,0,3000,3000,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Despawn');

-- ============================================================================
-- 2. Fix hostile behavior: emote "goes into a frenzy!" instead of yelling
-- ============================================================================

-- Add emote text (Type 16 = CHAT_MSG_MONSTER_EMOTE)
DELETE FROM `creature_text` WHERE `CreatureID`=31397 AND `GroupID`=2;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(31397,2,0,'%s goes into a frenzy!',16,0,100,0,0,0,36719,0,'Saronite Mine Slave - Frenzy Emote');

-- Update hostile script to use emote (GroupID 2) instead of yell (GroupID 0)
-- Preserves original structure: close gossip, set faction, emote, attack, enrage
DELETE FROM `smart_scripts` WHERE `entryorguid`=3139701 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3139701,9,0,0,0,0,100,0,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Close Gossip'),
(3139701,9,1,0,0,0,100,0,0,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Set Faction Hostile'),
(3139701,9,2,0,0,0,100,0,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Emote (GroupID 2 - frenzy)'),
(3139701,9,3,0,0,0,100,0,0,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Attack'),
(3139701,9,4,0,0,0,100,0,0,0,0,0,0,0,11,8599,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Saronite Mine Slave - On Script - Cast Enrage');

-- ============================================================================
-- 3. Fix /say messages language from Orcish (1) to Universal (0)
-- ============================================================================
-- This makes the random ambient /say messages readable by both factions
UPDATE `creature_text` SET `Language`=0 WHERE `CreatureID`=31397 AND `GroupID`=1;

-- ============================================================================
-- 4. Unknown voice whispers in Saronite Mines (same as Whisper Gulch)
-- ============================================================================
-- Spell 27769 applies an aura that periodically casts 29072 on the player.
-- NPC 29881 "An Unknown Voice" (already present in the mine at 6964,1979) reacts
-- to spell 29072 and says a random whisper line. Adding spell_area so players
-- in Icecrown (zone 210) get the aura; the mine is in this zone.
-- Same mechanic as Whisper Gulch (27769 in area 4071).
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`,`quest_start_status`,`quest_end_status`) VALUES
(27769,210,0,0,0,0,2,1,64,11);

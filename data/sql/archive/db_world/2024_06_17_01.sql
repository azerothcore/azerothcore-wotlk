-- DB update 2024_06_17_00 -> 2024_06_17_01
SET @OGUID := 1267; -- 21 free guids required
SET @CGUID := 12529; -- 21 free guids required

SET @NPC := @CGUID+10;
SET @PATH := @NPC * 10;

UPDATE `creature_template` SET `difficulty_entry_1` = 0 WHERE `entry` IN (25740, 25755, 25756, 25865);
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 0x00000040, `mechanic_immune_mask` = `mechanic_immune_mask` | 0x02000000 WHERE `entry` = 25740; -- Ahune
UPDATE `creature_template_model` SET `CreatureDisplayID` = 23344 WHERE `CreatureID` = 25740 AND `Idx` = 0; -- ToDo: replace entries with sniffed shtuff.
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `unit_flags` = `unit_flags` | 0x00000004 | 0x00000100 | 131072 | 33554432, `flags_extra` = `flags_extra` | 0x40000000, `ScriptName` = 'npc_frozen_core' WHERE `entry` = 25865; -- Frozen Core (might be interruptable)
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ahune_bunny' WHERE `entry` = 25745;
UPDATE `creature_template` SET `ScriptName` = 'npc_earthen_ring_flamecaller' WHERE `entry` = 25754;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 0x02000000, `MovementType` = 2 WHERE `entry` IN (25964, 25965, 25966); -- Shaman Beam Bunnies
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x00000080, `ScriptName` = 'npc_ahune_ice_spear_bunny' WHERE `entry` = 25985; -- Ahune Ice Spear Bunny
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x00000002 | 0x00000080 WHERE `entry` = 26239;

UPDATE `creature_model_info` SET `BoundingRadius` = 7.1468, `CombatReach` = 22 WHERE `DisplayID` = 23447;

UPDATE `gameobject_template` SET `ScriptName` = 'go_ahune_ice_spear' WHERE `entry` = 188077; -- Ice Spear

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 26190;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(26190, 1, 1, 1, 0, 0, 0, NULL);

DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_ahune_synch_health',
'spell_ice_spear_control_aura',
'spell_slippery_floor_periodic',
'spell_summon_ice_spear_delayer',
'spell_summoning_rhyme_aura',
'spell_ahune_spanky_hands',
'spell_ahune_minion_despawner',
'spell_ice_spear_target_picker',
'spell_ice_bombardment_dest_picker');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46430, 'spell_ahune_synch_health'),
(46371, 'spell_ice_spear_control_aura'),
(46320, 'spell_slippery_floor_periodic'),
(46878, 'spell_summon_ice_spear_delayer'),
(45926, 'spell_summoning_rhyme_aura'),
(46146, 'spell_ahune_spanky_hands'),
(46843, 'spell_ahune_minion_despawner'),
(46372, 'spell_ice_spear_target_picker'),
(46398, 'spell_ice_bombardment_dest_picker');

UPDATE `creature_text` SET `comment` = 'Ahune Bunny - EMOTE_EARTHEN_ASSAULT' WHERE `CreatureID` = 25745 AND `id` = 0; -- Missing space before hyphen

DELETE FROM `creature_template_addon` WHERE `entry` IN (25740, 25754, 25755, 25865, 25952, 25985);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `visibilityDistanceType`, `auras`) VALUES
(25740, 0, 0, 9, 1, 3, 61976),
(25754, 0, 0, 1, 1, 3, ''),
(25755, 0, 0, 0, 0, 3, 46542),
(25865, 0, 0, 0, 0, 0, '46810 61976'),
(25952, 0, 0, 0, 0, 3, 46314),
(25985, 0, 0, 0, 0, 0, '75498 46878');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (45930, 45941, 46236, 46396, 46398, 46593, 46603, 46735, 46809, 46843);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 45930, 0, 1, 31, 0, 3, 25971, 0, 0, 0, 0, '', "Spell 'Ahune - Summoning Rhyme Spell, make bonfire' can hit 'Shaman Bonfire Bunny 000'"),
(13, 1, 45930, 0, 2, 31, 0, 3, 25972, 0, 0, 0, 0, '', "Spell 'Ahune - Summoning Rhyme Spell, make bonfire' can hit 'Shaman Bonfire Bunny 001'"),
(13, 1, 45930, 0, 3, 31, 0, 3, 25973, 0, 0, 0, 0, '', "Spell 'Ahune - Summoning Rhyme Spell, make bonfire' can hit 'Shaman Bonfire Bunny 002'"),
(13, 1, 45941, 0, 0, 31, 0, 3, 25746, 0, 0, 0, 0, '', "Spell 'Summon Ahune's Loot Missile' can hit '[PH] Ahune Loot Loc Bunny'"),
(13, 1, 46236, 0, 1, 31, 0, 3, 25971, 0, 0, 0, 0, '', "Spell 'Close opening Visual' can hit 'Shaman Bonfire Bunny 000'"),
(13, 1, 46236, 0, 2, 31, 0, 3, 25972, 0, 0, 0, 0, '', "Spell 'Close opening Visual' can hit 'Shaman Bonfire Bunny 001'"),
(13, 1, 46236, 0, 3, 31, 0, 3, 25973, 0, 0, 0, 0, '', "Spell 'Close opening Visual' can hit 'Shaman Bonfire Bunny 002'"),
(13, 1, 46396, 0, 0, 31, 0, 3, 25972, 0, 0, 0, 0, '', "Spell 'Ice Bombardment' can hit 'Shaman Bonfire Bunny'"),
(13, 1, 46398, 0, 0, 31, 0, 3, 25972, 0, 0, 0, 0, '', "Spell 'Ice Bombardment Dest Picker' can hit 'Shaman Bonfire Bunny'"),
(13, 1, 46593, 0, 0, 31, 0, 3, 26120, 0, 0, 0, 0, '', "Spell 'Wisp Flight Missile and Beam' can hit 'Wisp Dest Bunny'"),
(13, 1, 46603, 0, 0, 31, 0, 3, 26121, 0, 0, 0, 0, '', "Spell 'Force Wisp Flight Missile' can  hit 'Wisp Source Bunny'"),
(13, 1, 46735, 0, 0, 31, 0, 3, 26190, 0, 0, 0, 0, '', "Spell 'Spank - Force Bunny To Knock You To' can hit '[PH] Spank Target Bunny'"),
(13, 1, 46809, 0, 0, 31, 0, 3, 26239, 0, 0, 0, 0, '', "Spell 'Make Ahune's Ghost Burst' can hit 'Ghost of Ahune"),
(13, 1, 46843, 0, 3, 31, 0, 3, 25755, 0, 0, 0, 0, '', "Spell 'Minion Despawner' can hit 'Ahunite Hailstone'"),
(13, 1, 46843, 0, 1, 31, 0, 3, 25756, 0, 0, 0, 0, '', "Spell 'Minion Despawner' can hit 'Ahunite Coldwave'"),
(13, 1, 46843, 0, 2, 31, 0, 3, 25757, 0, 0, 0, 0, '', "Spell 'Minion Despawner' can hit 'Ahunite Frostwind'");

DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` IN (46314, 46422, 46593, 46603);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 46314, 64, 0, 0, 'Disable LOS for spell Ahune - Slippery Floor Ambient'),
(0, 46422, 64, 0, 0, 'Disable LOS for spell Shamans Look for Opening'),
(0, 46593, 64, 0, 0, 'Disable LOS for spell Whisp Flight Missile and Beam'),
(0, 46603, 64, 0, 0, 'Disable LOS for spell Force Whisp to Flight');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-45964, 45964);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-45964, -46333, 0, ''),
(45964, 46333, 0, '');

-- Skar'this the Summoner
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 40446;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 40446 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(40446,0,0,0,1,0,100,1,0,0,0,0,11,75427,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skar\'this the Summoner - OOC - Cast \'Frost Channelling\''),
(40446,0,1,0,4,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Skar\'this the Summoner - On aggro - Say'),
(40446,0,2,0,0,0,100,0,5000,5000,15000,15000,11,55909,1,0,0,0,0,2,0,0,0,0,0,0,0,'Skar\'this the Summoner - IC - Cast Crashing Wave'),
(40446,0,3,0,0,0,100,0,10000,10000,20000,20000,11,11831,1,0,0,0,0,2,0,0,0,0,0,0,0,'Skar\'this the Summoner - IC - Cast Frost Nova'),
(40446,0,4,0,0,0,100,0,7000,7000,9000,9000,11,15043,0,0,0,0,0,2,0,0,0,0,0,0,0,'Skar\'this the Summoner - IC - Cast Frostbolt');

-- Summon Loot Bunny SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25746;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25746 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25746,0,0,0,8,0,100,0,45941,0,0,0,11,46891,0,0,0,0,0,1,0,0,0,0,0,0,0,'[PH] Ahune Loot Loc Bunny - On SpellHit - Cast \'Summon Loot\'');

-- [PH] Spank Target Bunny SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26190;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26190 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26190,0,0,0,8,0,100,0,46735,0,0,0,11,46734,0,0,0,0,0,7,0,0,0,0,0,0,0,'[PH] Spank Target Bunny - On SpellHit \'Spank - Force Bunny To Knock You To\' - Cast \'Knock To\'');

-- Ghost of Ahune
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26239;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26239 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2623900 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26239,0,0,0,25,0,100,0,0,0,0,0,3,0,11686,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - On Reset - Morph to Model 11686'),
(26239,0,1,0,8,0,100,0,46809,0,4000,4000,80,2623900,2,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - On SpellHit \'Make Ahune\'s Ghost Burst\' - Call Timed ActionList'),
(2623900,9,0,0,0,0,100,0,0,0,0,0,3,0,23707,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - Timed ActionList - Morph to Model 23707'),
(2623900,9,1,0,0,0,100,0,0,0,0,0,11,46786,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - Timed ActionList - Cast \'Ahune\'s Ghost Disguise\''),
(2623900,9,2,0,0,0,100,0,2400,2400,0,0,47,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - Timed ActionList - Set Visibility Off'),
(2623900,9,3,0,0,0,100,0,500,500,0,0,3,0,11686,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - Timed ActionList - Morph to Model 11686'),
(2623900,9,4,0,0,0,100,0,0,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ghost of Ahune - Timed ActionList - Set Visibility On');

-- Wisp Source Bunny SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26121;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26121 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26121,0,0,1,8,0,100,0,46603,0,0,0,11,46593,0,0,0,0,0,11,26120,100,0,0,0,0,0,'Wisp Source Bunny - On SpellHit \'Force Wisp Flight Missile\' - Cast \'Wisp Flight Missile and Beam\''),
(26121,0,1,0,61,0,100,0,0,0,0,0,41,9000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wisp Source Bunny - On SpellHit \'Force Wisp Flight Missile\' - Despawn in 9s');

-- Wisp Dest Bunny SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26120;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 26120 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26120,0,0,0,8,0,100,0,46593,0,0,0,41,9000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Wisp Dest Bunny - On SpellHit \'Wisp Flight Missile and Beam\' - Despawn in 9s');

-- Shaman Beam Bunny SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (25971, 25972, 25973);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (25971, 25972, 25973) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25971,0,0,0,8,0,100,0,45930,0,0,0,11,46339,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shaman Beam Bunny 000 - On SpellHit - Cast \'Bonfire Disguise\''),
(25972,0,0,0,8,0,100,0,45930,0,0,0,11,46339,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shaman Beam Bunny 001 - On SpellHit - Cast \'Bonfire Disguise\''),
(25973,0,0,0,8,0,100,0,45930,0,0,0,11,46339,0,0,0,0,0,1,0,0,0,0,0,0,0,'Shaman Beam Bunny 002 - On SpellHit - Cast \'Bonfire Disguise\'');

-- Ahunite Hailstone SAI
-- UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25755; -- has SAI, replace script only
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25755 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25755,0,0,0,0,0,100,0,6000,8000,6000,8000,11,2676,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ahunite Hailstone - In Combat - Cast \'Pulverize\'');

-- Ahunite Coldwave SAI
-- UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25756; -- has SAI, replace script only
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25756 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25756,0,0,0,0,0,100,0,5000,7000,6000,8000,11,46406,0,0,0,0,0,2,0,0,0,0,0,0,0,'Ahunite Coldwave - In Combat - Cast \'Bitter Blast\'');

-- Ahunite Frostwind SAI
-- UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25757; -- has SAI, replace script only
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25757 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25757,0,0,0,54,0,100,0,0,0,0,0,11,12550,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ahunite Frostwind - On Just Summoned - Cast \'Lightning Shield\''),
(25757,0,1,0,0,0,100,0,2000,2000,5000,7000,11,46568,0,0,0,0,0,18,120,0,0,0,0,0,0,'Ahunite Frostwind - In Combat - Cast \'Wind Buffet\'');

-- Clean up spawns
DELETE FROM `creature` WHERE `guid` IN (202734, 202735, 202736, 202737, 245704, 245800, 245801, 245810, 245811, 245812) AND `id1` IN (25697, 25754, 25710, 28015, 25971, 25972, 25973);
DELETE FROM `game_event_creature` WHERE `guid` IN (202734, 202735, 202736, 202737, 245704, 245800, 245801, 245810, 245811, 245812);
-- Ensure free GUIDs
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20 AND `id1` IN (25697, 25710, 25745, 25746, 25754, 25952, 25961, 25964, 25965, 25966, 5971, 25972, 25973, 26120, 26121, 26190, 26230, 40446);
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-245801, -245800) AND `source_type` = 0;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
-- (@CGUID+0, 16592, 547, 0, 0, 3, 1, 0, -114.745880126953125, -117.226593017578125, -2.44469881057739257, 1.169368624687194824, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
-- (@CGUID+0, 16592, 547, 0, 0, 3, 1, 0, -89.8604965209960937, -113.449333190917968, -2.3303837776184082, 2.617989301681518554, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+0 , 25697, 547, 0, 0, 3, 1, 0, -92.4571914672851562, -110.664161682128906, -2.86675882339477539, 2.408554315567016601, 7200, 0, 0, 4781, 0, 0, 0, 0, 0, 50172),
(@CGUID+1 , 25710, 547, 0, 0, 3, 1, 0, 131.4105682373046875, -120.632652282714843, -1.50722658634185791, 4.206243515014648437, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+2 , 25745, 547, 0, 0, 3, 1, 0, -96.6414566040039062, -230.886444091796875, 4.78095865249633789, 1.413716673851013183, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+3 , 25746, 547, 0, 0, 3, 1, 0, -96.8722991943359375, -212.84246826171875, -1.14914166927337646, 4.15388345718383789, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+4 , 25754, 547, 0, 0, 3, 1, 0, -112.209869384765625, -120.209037780761718, -2.65799570083618164, 5.183627605438232421, 7200, 0, 0, 10282, 0, 0, 0, 0, 0, 50172),
(@CGUID+5 , 25754, 547, 0, 0, 3, 1, 0, -110.19451904296875, -116.621482849121093, -3.25569367408752441, 0.104719758033752441, 7200, 0, 0, 10635, 0, 0, 0, 0, 0, 50172),
(@CGUID+6 , 25754, 547, 0, 0, 3, 1, 0, -93.1847915649414062, -115.92059326171875, -2.69253182411193847, 3.804817676544189453, 7200, 0, 0, 9940, 0, 0, 0, 0, 0, 50172),
(@CGUID+7 , 25952, 547, 0, 0, 3, 1, 0, -69.8390121459960937, -162.473968505859375, -2.30364584922790527, 2.513274192810058593, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+8 , 25961, 547, 0, 0, 3, 1, 0, -109.223983764648437, -120.052108764648437, -2.98242378234863281, 5.113814830780029296, 7200, 0, 0, 484, 0, 0, 0, 0, 0, 50172),
(@CGUID+9 , 25961, 547, 0, 0, 3, 1, 0, -92.689605712890625, -119.627853393554687, -2.27035880088806152, 4.223696708679199218, 7200, 0, 0, 484, 0, 0, 0, 0, 0, 50172),
(@CGUID+10, 25964, 547, 0, 0, 3, 1, 0, -90.0021133422851562, -224.928543090820312, -1.378753662109375, 4.571401596069335937, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+11, 25965, 547, 0, 0, 3, 1, 0, -97.396270751953125, -223.76104736328125, -1.49489867687225341, 5.32932901382446289, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+12, 25966, 547, 0, 0, 3, 1, 0, -104.356178283691406, -223.356185913085937, -1.46137666702270507, 5.672232627868652343, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+13, 25971, 547, 0, 0, 3, 1, 0, -143.17193603515625, -147.680130004882812, -3.16113066673278808, 4.852015495300292968, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+14, 25972, 547, 0, 0, 3, 1, 0, -134.30364990234375, -145.780303955078125, -1.70331764221191406, 4.677482128143310546, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+15, 25973, 547, 0, 0, 3, 1, 0, -125.035713195800781, -144.20654296875, -1.91659557819366455, 4.991641521453857421, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+16, 26120, 547, 0, 0, 3, 1, 0, -98.102935791015625, -230.786407470703125, -10.8084640502929687, 1.448623299598693847, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+17, 26121, 547, 0, 0, 3, 1, 0, -69.8120498657226562, -162.49542236328125, -2.30450677871704101, 1.710422635078430175, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+18, 26190, 547, 0, 0, 3, 1, 0, -95.335723876953125, -207.483352661132812, 16.28742027282714843, 4.904375076293945312, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50172),
(@CGUID+19, 26230, 547, 0, 0, 3, 1, 0, -98.8607406616210937, -233.752609252929687, 8.372927665710449218, 2.757620096206665039, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 50172),
(@CGUID+20, 40446, 547, 0, 0, 3, 1, 0, -76.9917221069335937, -157.080520629882812, -2.10638880729675292, 5.637413501739501953, 7200, 0, 0, 50400, 0, 0, 0, 0, 0, 50172);

INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(1, @CGUID+0),
(1, @CGUID+1),
(1, @CGUID+2),
(1, @CGUID+3),
(1, @CGUID+4),
(1, @CGUID+5),
(1, @CGUID+6),
(1, @CGUID+7),
(1, @CGUID+8),
(1, @CGUID+9),
(1, @CGUID+10),
(1, @CGUID+11),
(1, @CGUID+12),
(1, @CGUID+13),
(1, @CGUID+14),
(1, @CGUID+15),
(1, @CGUID+16),
(1, @CGUID+17),
(1, @CGUID+18),
(1, @CGUID+19),
(1, @CGUID+20);

-- Clean up spawns
DELETE FROM `gameobject` WHERE `guid` IN (87, 88, 11207, 11208, 11209, 11210, 11211, 11212, 11213, 11214, 11215, 11216, 11217, 220100, 220101, 220102, 220103, 220104, 220105, 220106, 220111, 220112) AND `id` IN (181371, 187882, 188067, 188072, 188073, 188142, 195000);
DELETE FROM `game_event_gameobject` WHERE `guid` IN (87, 88, 11207, 11208, 11209, 11210, 11211, 11212, 11213, 11214, 11215, 11216, 11217, 220100, 220101, 220102, 220103, 220104, 220105, 220106, 220111, 220112);
-- Ensure free GUIDs
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+20 AND `id` IN (187882, 188067, 188072, 188073, 188142, 195000);
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+20;
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+20;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- (@OGUID+0 , 181290, 547, 0, 0, 3, 1, -114.745880126953125, -117.226593017578125, -2.52803206443786621, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 7200, 255, 1, 50172),
-- (@OGUID+0 , 181290, 547, 0, 0, 3, 1, -89.8604965209960937, -113.449333190917968, -2.41371703147888183, 2.617989301681518554, 0, 0, 0.965925216674804687, 0.258821308612823486, 7200, 255, 1, 50172),
-- (@OGUID+0 , 181376, 547, 0, 0, 3, 1, -114.745880126953125, -117.226593017578125, -2.52803206443786621, 1.169368624687194824, 0, 0, 0.551936149597167968, 0.833886384963989257, 7200, 255, 1, 50172),
-- (@OGUID+0 , 181376, 547, 0, 0, 3, 1, -89.8604965209960937, -113.449333190917968, -2.41371703147888183, 2.617989301681518554, 0, 0, 0.965925216674804687, 0.258821308612823486, 7200, 255, 1, 50172),
(@OGUID+0 , 187882, 547, 0, 0, 3, 1, -69.9045486450195312, -162.244949340820312, -2.366563081741333, 2.426007747650146484, 0, 0, 0.936672210693359375, 0.350207358598709106, 7200, 255, 1, 50172),
(@OGUID+1 , 188067, 547, 0, 0, 3, 1, -115.598533630371093, -162.772384643554687, -1.92402505874633789, 5.724681377410888671, 0, 0, -0.27563667297363281, 0.961261868476867675, 7200, 255, 1, 50172),
(@OGUID+2 , 188067, 547, 0, 0, 3, 1, -83.5252761840820312, -172.18060302734375, -3.81652188301086425, 0.017452461645007133, 0, 0, 0.008726119995117187, 0.999961912631988525, 7200, 255, 1, 50172),
(@OGUID+3 , 188067, 547, 0, 0, 3, 1, -79.397003173828125, -219.702499389648437, -4.04289197921752929, 4.084071159362792968, 0, 0, -0.8910064697265625, 0.453990638256072998, 7200, 255, 1, 50172),
(@OGUID+4 , 188067, 547, 0, 0, 3, 1, -75.2318267822265625, -217.329315185546875, -3.0727999210357666, 5.794494152069091796, 0, 0, -0.24192142486572265, 0.970295846462249755, 7200, 255, 1, 50172),
(@OGUID+5 , 188067, 547, 0, 0, 3, 1, -75.9513931274414062, -182.77099609375, -4.88201713562011718, 5.131268978118896484, 0, 0, -0.54463863372802734, 0.838670849800109863, 7200, 255, 1, 50172),
(@OGUID+6 , 188067, 547, 0, 0, 3, 1, -71.8962478637695312, -145.49737548828125, -1.55181300640106201, 4.328419685363769531, 0, 0, -0.82903671264648437, 0.559194147586822509, 7200, 255, 1, 50172),
(@OGUID+7 , 188067, 547, 0, 0, 3, 1, -49.2725067138671875, -168.985946655273437, -1.89881098270416259, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 7200, 255, 1, 50172),
(@OGUID+8 , 188072, 547, 0, 0, 3, 1, -71.824859619140625, -164.474990844726562, -3.96298193931579589, 5.35816192626953125, 0, 0, -0.446197509765625, 0.894934535026550292, 7200, 255, 1, 50172),
(@OGUID+9 , 188072, 547, 0, 0, 3, 1, -71.4891510009765625, -160.731643676757812, -4.18568992614746093, 5.864306926727294921, 0, 0, -0.20791149139404296, 0.978147625923156738, 7200, 255, 1, 50172),
(@OGUID+10, 188072, 547, 0, 0, 3, 1, -69.2083663940429687, -160.345046997070312, -4.25643014907836914, 1.85004889965057373, 0, 0, 0.798635482788085937, 0.60181504487991333, 7200, 255, 1, 50172),
(@OGUID+11, 188072, 547, 0, 0, 3, 1, -69.2177276611328125, -163.490951538085937, -2.04477310180664062, 2.967041015625, 0, 0, 0.996193885803222656, 0.087165042757987976, 7200, 255, 1, 50172),
(@OGUID+12, 188073, 547, 0, 0, 3, 1, -114.957443237304687, -117.301666259765625, -2.71000003814697265, 2.007128477096557617, 0, 0, 0.84339141845703125, 0.537299633026123046, 7200, 255, 1, 50172),
(@OGUID+13, 188073, 547, 0, 0, 3, 1, -89.7520523071289062, -113.500236511230468, -2.70944190025329589, 0.453785061836242675, 0, 0, 0.224950790405273437, 0.974370121955871582, 7200, 255, 1, 50172),
(@OGUID+14, 188142, 547, 0, 0, 3, 1, -118.919563293457031, -204.802276611328125, -1.50416100025177001, 1.919861555099487304, 0, 0, 0.819151878356933593, 0.573576688766479492, 7200, 255, 1, 50172),
(@OGUID+15, 188142, 547, 0, 0, 3, 1, -117.385650634765625, -165.964920043945312, -2.01864600181579589, 0.558503925800323486, 0, 0, 0.275636672973632812, 0.961261868476867675, 7200, 255, 1, 50172),
(@OGUID+16, 188142, 547, 0, 0, 3, 1, -103.713432312011718, -245.504074096679687, -1.37788105010986328, 4.991643905639648437, 0, 0, -0.60181427001953125, 0.798636078834533691, 7200, 255, 1, 50172),
(@OGUID+17, 188142, 547, 0, 0, 3, 1, -75.4278411865234375, -221.159988403320312, -2.88294100761413574, 0.488691210746765136, 0, 0, 0.241921424865722656, 0.970295846462249755, 7200, 255, 1, 50172),
(@OGUID+18, 188142, 547, 0, 0, 3, 1, -74.6595916748046875, -243.812469482421875, -2.73599910736083984, 2.216565132141113281, 0, 0, 0.894933700561523437, 0.44619917869567871, 7200, 255, 1, 50172),
(@OGUID+19, 188142, 547, 0, 0, 3, 1, -72.753143310546875, -185.154693603515625, -4.93059301376342773, 0.15707901120185852, 0, 0, 0.078458786010742187, 0.996917366981506347, 7200, 255, 1, 50172),
(@OGUID+20, 195000, 547, 0, 0, 3, 1, -98.0260238647460937, -230.428787231445312, -7.61181306838989257, 0, 0, 0, 0, 1, 7200, 255, 1, 50172);

INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(1, @OGUID+0),
(1, @OGUID+1),
(1, @OGUID+2),
(1, @OGUID+3),
(1, @OGUID+4),
(1, @OGUID+5),
(1, @OGUID+6),
(1, @OGUID+7),
(1, @OGUID+8),
(1, @OGUID+9),
(1, @OGUID+10),
(1, @OGUID+11),
(1, @OGUID+12),
(1, @OGUID+13),
(1, @OGUID+14),
(1, @OGUID+15),
(1, @OGUID+16),
(1, @OGUID+17),
(1, @OGUID+18),
(1, @OGUID+19),
(1, @OGUID+20);

DELETE FROM `creature_addon` WHERE `guid` IN (@NPC,@NPC+1,@NPC+2);
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES
(@NPC,@PATH),
(@NPC+1,@PATH+10),
(@NPC+2,@PATH+20);

DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+10,@PATH+20);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-107.1537,-233.7247,27.1834,0,0,0,100,0),
(@PATH,2,-109.4618,-232.0907,25.12787,0,0,0,100,0),
(@PATH,3,-109.4792,-229.4328,20.98899,0,0,0,100,0),
(@PATH,4,-105.9522,-226.8887,17.26674,0,0,0,100,0),
(@PATH,5,-101.0044,-224.8914,16.04452,0,0,0,100,0),
(@PATH,6,-96.82773,-225.9608,15.73896,0,0,0,100,0),
(@PATH,7,-92.59879,-227.0505,15.54452,0,0,0,100,0),
(@PATH,8,-90.07465,-229.0938,16.58224,0,0,0,100,0),
(@PATH,9,-88.24558,-231.7715,22.47455,0,0,0,100,0),
(@PATH,10,-91.0969,-232.6422,24.65563,0,0,0,100,0),
(@PATH,11,-97.20647,-234.4709,28.46118,0,0,0,100,0),
(@PATH,12,-101.5825,-234.9054,29.35008,0,0,0,100,0),

(@PATH+10,1,-109.4618,-232.0907,25.12787,0,0,0,100,0),
(@PATH+10,2,-109.4792,-229.4328,20.98899,0,0,0,100,0),
(@PATH+10,3,-105.9522,-226.8887,17.26674,0,0,0,100,0),
(@PATH+10,4,-101.0044,-224.8914,16.04452,0,0,0,100,0),
(@PATH+10,5,-96.82773,-225.9608,15.73896,0,0,0,100,0),
(@PATH+10,6,-92.59879,-227.0505,15.54452,0,0,0,100,0),
(@PATH+10,7,-90.07465,-229.0938,16.58224,0,0,0,100,0),
(@PATH+10,8,-88.24558,-231.7715,22.47455,0,0,0,100,0),
(@PATH+10,9,-91.0969,-232.6422,24.65563,0,0,0,100,0),
(@PATH+10,10,-97.20647,-234.4709,28.46118,0,0,0,100,0),
(@PATH+10,11,-101.5825,-234.9054,29.35008,0,0,0,100,0),
(@PATH+10,12,-107.1537,-233.7247,27.1834,0,0,0,100,0),

(@PATH+20,1,-97.20647,-234.4709,28.46118,0,0,0,100,0),
(@PATH+20,2,-101.5825,-234.9054,29.35008,0,0,0,100,0),
(@PATH+20,3,-107.1537,-233.7247,27.1834,0,0,0,100,0),
(@PATH+20,4,-109.4618,-232.0907,25.12787,0,0,0,100,0),
(@PATH+20,5,-109.4792,-229.4328,20.98899,0,0,0,100,0),
(@PATH+20,6,-105.9522,-226.8887,17.26674,0,0,0,100,0),
(@PATH+20,7,-101.0044,-224.8914,16.04452,0,0,0,100,0),
(@PATH+20,8,-96.82773,-225.9608,15.73896,0,0,0,100,0),
(@PATH+20,9,-92.59879,-227.0505,15.54452,0,0,0,100,0),
(@PATH+20,10,-90.07465,-229.0938,16.58224,0,0,0,100,0),
(@PATH+20,11,-88.24558,-231.7715,22.47455,0,0,0,100,0),
(@PATH+20,12,-91.0969,-232.6422,24.65563,0,0,0,100,0);

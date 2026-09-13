-- DB update 2026_08_20_08 -> 2026_08_20_09
--
-- Hodir's Spear chains: casting dropped the caster's own `Quest Invisibility 2` (54503), so it
-- could no longer detect the equally invisible anchor and `Spear Chain Beam` (56379) applied no
-- aura. Cast it with SMARTCAST_TRIGGERED (0x2) + TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS (0x100).
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-142407, -142408);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(-142407,0,0,0,60,0,100,0,0,1,20000,20000,0,0,11,56379,2,256,0,0,0,10,142409,30246,0,0,0,0,0,0,'Dun Niffelem Spear Chain Bunny (Phase 2) - On Update - Cast Spear Chain Beam'),
(-142408,0,0,0,60,0,100,0,0,1,20000,20000,0,0,11,56379,2,256,0,0,0,10,142410,30246,0,0,0,0,0,0,'Dun Niffelem Spear Chain Bunny (Phase 2) - On Update - Cast Spear Chain Beam');

-- A per-spawn `creature_addon` row shadows `creature_template_addon` entirely, which dropped
-- entry 30246's visibilityDistanceType 4 (Gigantic) and made the chains render only up close.
DELETE FROM `creature_addon` WHERE `guid` IN (142407, 142408, 142409, 142410);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(142407,0,0,0,0,0,4,'54503'),
(142408,0,0,0,0,0,4,'54503'),
(142409,0,0,0,0,0,4,'54503'),
(142410,0,0,0,0,0,4,'54503');

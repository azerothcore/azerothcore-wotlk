--
SET @CANNIBAL_ENTRY:= 15662;
SET @PATH:= @CANNIBAL_ENTRY * 10;
SET @CANNIBAL_N:= 40483;
SET @CANNIBAL_E:= 40484;
SET @CANNIBAL_S:= 40485;
SET @CANNIBAL_W:= 40486;
SET @RANGER_ID:= 15938;
SET @RANGER_JAELA:= 15416; 

DELETE FROM `creature_template` WHERE (`entry` = @CANNIBAL_ENTRY);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(@CANNIBAL_ENTRY, 0, 0, 0, 0, 0, 646, 0, 0, 0, 'Rotlimb Cannibal', NULL, NULL, 0, 6, 7, 0, 16, 0, 0.777776, 0.85714, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 256, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 15655, 15655, 0, 0, 0, 5, 12, 'SmartAI', 1, 1, 3, 1, 1, 1, 0, 100, 1, 8388624, 0, 0, '', 12340);

DELETE FROM `creature` WHERE `guid` in (@CANNIBAL_N, @CANNIBAL_E, @CANNIBAL_S, @CANNIBAL_W);
INSERT INTO `creature`
(`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(@CANNIBAL_N, @CANNIBAL_ENTRY, 0, 0, 530, 0, 0, 1, 1, 0, 9132.73, -6992.1, 9.97888, 0.877851, 300, 0.0, 0, 137, 0, 2, 0, 0, 0, '', 0),
(@CANNIBAL_E, @CANNIBAL_ENTRY, 0, 0, 530, 0, 0, 1, 1, 0, 9130.10, -6998.59, 10.3267, 0.865284, 30, 0.0, 0, 120, 0, 0, 0, 0, 0, '', 0),
(@CANNIBAL_S, @CANNIBAL_ENTRY, 0, 0, 530, 0, 0, 1, 1, 0, 9125.78, -6998.9, 10.4178, 0.842508, 30, 0.0, 0, 137, 0, 0, 0, 0, 0, '', 0),
(@CANNIBAL_W, @CANNIBAL_ENTRY, 0, 0, 530, 0, 0, 1, 1, 0, 9128.29, -6993.02, 10.3157, 0.897486, 30, 0.0, 0, 137, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_text` WHERE `CreatureID`=@RANGER_JAELA;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@RANGER_JAELA, 0, 0, "Slay them!  Don't let the Scourge scum defile our city!", 14, 0, 100, 0, 0, 0, 12861, 0, "Ranger Jaela"),
(@RANGER_JAELA, 1, 0, "The enemy approaches from the south.  Ready your weapons!", 14, 0, 100, 0, 0, 0, 12862, 0, "Ranger Jaela"),
(@RANGER_JAELA, 1, 1, "The undead are approaching.  Attack!", 14, 0, 100, 0, 0, 0, 12863, 0, "Ranger Jaela");

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data`
(`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(@PATH, 1, 9139.89, -6984.13, 8.89487, NULL, 0, 1, 0, 100, 0),
(@PATH, 2, 9179.08, -6940.46, 5.09185, NULL, 0, 1, 0, 100, 0),
(@PATH, 3, 9201.97, -6937.07, 5.05504, NULL, 0, 1, 0, 100, 0),
(@PATH, 4, 9221.32, -6960.13, 5.51527, NULL, 0, 1, 0, 100, 0),
(@PATH, 5, 9248.47, -6960.84, 4.40437, NULL, 0, 1, 0, 100, 0),
(@PATH, 6, 9257.97, -6971.09, 3.89826, NULL, 0, 1, 0, 100, 0),
(@PATH, 7, 9318.23, -6964.18, 10.383, NULL, 0, 1, 0, 100, 0),
(@PATH, 8, 9348.03, -6965.33, 15.791, NULL, 0, 1, 0, 100, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CANNIBAL_N;
INSERT INTO `creature_formations`
(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
VALUES
(@CANNIBAL_N, @CANNIBAL_N, 0.0, 0.0, 2, 0, 0),
(@CANNIBAL_N, @CANNIBAL_E, 3.0, 45, 515, 0, 0),
(@CANNIBAL_N, @CANNIBAL_S, 6.0, 0, 515, 0, 0),
(@CANNIBAL_N, @CANNIBAL_W, 3.0, 315, 515, 0, 0);

DELETE FROM `creature_addon` WHERE `guid` IN (@CANNIBAL_N, @CANNIBAL_E, @CANNIBAL_S, @CANNIBAL_W);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES
(@CANNIBAL_N, @PATH, 0, 0, 0, 0, 0, ''),
(@CANNIBAL_E, 0, 0, 0, 0, 0, 0, ''),
(@CANNIBAL_S, 0, 0, 0, 0, 0, 0, ''),
(@CANNIBAL_W, 0, 0, 0, 0, 0, 0, '');

-- Update Cast flag to 64
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15416) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15416, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 20811, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ranger Jaela - On Aggro - Cast \'Fireball\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-@CANNIBAL_N, -@CANNIBAL_E, -@CANNIBAL_S, -@CANNIBAL_W));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-@CANNIBAL_N, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - In Combat - Remove Flags Immune To Players (No Repeat)'),
(-@CANNIBAL_N, 0, 1, 0, 75, 0, 100, 0, 0, 15938, 20, 1200, 0, 49, 0, 0, 0, 0, 0, 0, 10, 0, 15938, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Start Attacking'),
(-@CANNIBAL_N, 0, 3, 4, 1, 0, 100, 0, 1000, 1000, 2000, 2000, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - Out of Combat - Set Visibility On'),
(-@CANNIBAL_N, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 40484, 15662, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - Out of Combat - Set Data 1 1'),
(-@CANNIBAL_N, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 40485, 15662, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - Out of Combat - Set Data 1 1'),
(-@CANNIBAL_N, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 40486, 15662, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - Out of Combat - Set Data 1 1'),
(-@CANNIBAL_N, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Respawn - Set Visibility On'),
(-@CANNIBAL_N, 0, 8, 9, 75, 0, 100, 1, 0, 15416, 70, 1500, 0, 1, 1, 0, 0, 0, 0, 0, 19, 15416, 90, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Say Line 1 (No Repeat)'),
(-@CANNIBAL_N, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Create Timed Event (No Repeat)'),
(-@CANNIBAL_N, 0, 10, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 15416, 90, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Timed Event 1 Triggered - Say Line 0'),
(-@CANNIBAL_E, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - In Combat - Remove Flags Immune To Players (No Repeat)'),
(-@CANNIBAL_E, 0, 1, 0, 75, 0, 100, 0, 0, @RANGER_ID, 20, 1200, NULL, 49, 0, 0, 0, 0, 0, 0, 10, 0, @RANGER_ID, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Start Attacking'),
(-@CANNIBAL_E, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Spawn - Set Invisible"),
(-@CANNIBAL_E, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Data 1 1 Set - Set Visible"),
(-@CANNIBAL_S, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - In Combat - Remove Flags Immune To Players (No Repeat)'),
(-@CANNIBAL_S, 0, 1, 0, 75, 0, 100, 0, 0, @RANGER_ID, 20, 1200, NULL, 49, 0, 0, 0, 0, 0, 0, 10, 0, @RANGER_ID, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Start Attacking'),
(-@CANNIBAL_S, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Spawn - Set Invisible"),
(-@CANNIBAL_S, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Data 1 1 Set - Set Visible"),
(-@CANNIBAL_W, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - In Combat - Remove Flags Immune To Players (No Repeat)'),
(-@CANNIBAL_W, 0, 1, 0, 75, 0, 100, 0, 0, @RANGER_ID, 20, 1200, NULL, 49, 0, 0, 0, 0, 0, 0, 10, 0, @RANGER_ID, 0, 0, 0, 0, 0, 0, 'Rotlimb Cannibal - On Distance To Creature - Start Attacking'),
(-@CANNIBAL_W, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Spawn - Set Invisible"),
(-@CANNIBAL_W, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Rotlimb Cannibal - On Data 1 1 Set - Set Visible");

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612452141389407700');

-- Dire Maul start
-- Corrected Spawn Position & Gave him MovementType id 2 (Waypoint id: 247709)
DELETE FROM `creature` WHERE `guid`=247709;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (247709, 11441, 429, 0, 0, 1, 1, 0, 1, 307.35, -9.58133, -3.88598, 4.65288, 86400, 0, 247709, 13920, 0, 2, 0, 0, 0, '', 0);

-- Deleting mobs from pack 1 (they are not suppose to be there)
DELETE FROM `creature` WHERE `guid` IN (247726, 247753, 247711);

-- Inserting missing mob in pack 1 (this one is suppose to be here)
DELETE FROM `creature` WHERE `guid`=3110360;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (3110360, 13036, 429, 0, 0, 1, 1, 0, 0, 293.428, 22.3743, -3.91569, 1.70123, 300, 0, 0, 3998, 0, 0, 0, 0, 0, '', 0);

-- Proper Waypoint from Pack 1 to pack 2
DELETE FROM `waypoint_data` WHERE `id`=247709;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(247709, 1, 307.348, -8.82784, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 2, 307.135, -19.3257, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 3, 306.856, -40.3236, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 4, 306.801, -50.8234, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 5, 306.668, -61.3225, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 6, 296.353, -74.4781, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 7, 304.261, -75.5452, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 8, 304.863, -74.159, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 9, 308.368, -59.6182, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 10, 308.427, -49.1197, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 11, 307.801, -28.1291, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 12, 307.76, -7.13253, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 13, 307.88, 3.36644, -3.88598, 0, 0, 0, 0, 100, 0),
(247709, 14, 306.84, 21.4017, -3.90275, 0, 0, 0, 0, 100, 0),
(247709, 15, 299.038, 29.605, -3.93202, 0, 0, 0, 0, 100, 0),
(247709, 16, 299.038, 29.605, -3.93202, 0, 0, 0, 0, 100, 0),
(247709, 17, 303.228, 15.3181, -3.88825, 0, 0, 0, 0, 100, 0),
(247709, 18, 306.771, -5.34127, -3.88637, 0, 0, 0, 0, 100, 0);

-- Spawned 3110361 in correct location and gave npc MovementType 2 (waypoint: 3110361)
DELETE FROM `creature` WHERE `guid`=3110361;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (3110361, 11441, 429, 0, 0, 1, 1, 0, 1, 309.653, 43.6358, -3.92352, 1.56378, 300, 0, 3110361, 14355, 0, 2, 0, 0, 0, '', 0);

-- Decreased Guard Slip'kik's speed by 55%
DELETE FROM `creature_template` WHERE `entry`=14323;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (14323, 0, 0, 0, 0, 0, 11561, 0, 0, 0, 'Guard Slip\kik', NULL, NULL, 5733, 59, 59, 0, 45, 1, 1.95, 1.14286, 1, 1, 652, 789, 0, 248, 1.19, 1175, 1292, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 70, 103, 25, 7, 0, 14323, 0, 0, 0, 0, 0, 0, 0, 0, 15580, 17307, 20691, 0, 0, 0, 0, 0, 0, 0, 1117, 1464, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 53, 1, 0, 0, 0, '', 12340);

-- Proper Waypoint from pack 1
DELETE FROM `waypoint_data` WHERE `id`=3110361;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(3110361, 1, 309.697, 49.7887, -3.94447, 0, 0, 0, 0, 100, 0),
(3110361, 2, 309.697, 49.7887, -3.94447, 0, 0, 0, 0, 100, 0),
(3110361, 3, 309.894, 60.2868, -3.96293, 0, 0, 0, 0, 100, 0),
(3110361, 4, 309.675, 81.2801, -3.965, 0, 0, 0, 0, 100, 0),
(3110361, 5, 309.131, 104.134, -3.88782, 0, 0, 0, 0, 100, 0),
(3110361, 6, 309.131, 104.134, -3.88782, 0, 0, 0, 0, 100, 0),
(3110361, 7, 310.605, 83.1921, -3.95282, 0, 0, 0, 0, 100, 0),
(3110361, 8, 310.935, 62.1949, -3.94964, 0, 0, 0, 0, 100, 0),
(3110361, 9, 310.25, 41.2154, -3.91403, 0, 0, 0, 0, 100, 0),
(3110361, 10, 308.85, 12.7074, -3.8862, 0, 0, 0, 0, 100, 0),
(3110361, 11, 308.85, 12.7074, -3.8862, 0, 0, 0, 0, 100, 0),
(3110361, 12, 309.45, 41.4261, -3.91537, 0, 0, 0, 0, 100, 0);

-- Netherwalker is not suppose to grant XP when killed. As this is very abusable
DELETE FROM `creature_template` WHERE `entry`=14389;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (14389, 0, 0, 0, 0, 0, 14428, 0, 0, 0, 'Netherwalker', NULL, NULL, 0, 60, 60, 0, 45, 0, 1.76, 1.14286, 1, 1, 104, 138, 0, 252, 7.5, 1183, 1301, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 72, 106, 26, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 3, 2, 1, 0, 121, 1, 0, 0, 64, '', 12340);

-- Captain Kromcrush's Guards should despawn relatively quickly if the fight ends. They now despawn after 10 seconds after fight has ended.
SET @ENTRY := 11450;
DELETE FROM smart_scripts WHERE entryOrGuid = 11450 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Talk 0 to invoker"),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 8000, 12000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Every 8 - 12 seconds (5 - 7s initially)  - Self: Cast spell 15284 on Victim"),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 14000, 21000, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Every 14 - 21 seconds (8 - 12s initially)  - Self: Cast spell 13737 on Victim"),
(@ENTRY, 0, 3, 0, 0, 0, 100, 0, 1000, 4000, 14000, 21000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Every 14 - 21 seconds (1 - 4s initially)  - Self: Cast spell 16145 on Victim"),
(@ENTRY, 0, 4, 0, 1, 0, 100, 0, 4000, 15000, 20000, 40000, 10, 1, 11, 25, 6, 21, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Every 20 - 40 seconds (4 - 15s initially)  - None: Play random emote: 1, 11, 25, 6, 21, "),
(@ENTRY, 0, 5, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On evade - None: Despawn in 10 s"),
(@ENTRY, 0, 6, 0, 1, 0, 100, 0, 10000, 20000, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Time between 10 - 20 seconds  - None: Despawn in 10 s");


DELETE FROM conditions WHERE SourceTypeOrReferenceId = 22 AND SourceEntry = 11450 AND SourceId = 0;

-- Delete old Slip'Kik Spawn and Waypoints
DELETE FROM `creature` WHERE `guid`=248080;
DELETE FROM `waypoint_data` WHERE `id`=248080;
DELETE FROM `creature_addon` WHERE `guid`=248080;

-- Respawned Slip'Kik and gave him proper waypoints
DELETE FROM `creature_addon` WHERE `guid`=3110363;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES (3110363, 3110363, 0, 0, 4097, 0, 0, NULL);

DELETE FROM `creature` WHERE `guid`=3110363;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (3110363, 14323, 429, 0, 0, 1, 1, 0, 1, 547.356, 528.29, -25.4016, 0.706978, 300, 0, 0, 23688, 0, 2, 0, 0, 0, '', 0);

DELETE FROM `waypoint_data` WHERE `id`=3110363;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(3110363, 1, 551.187, 529.113, -25.4017, 0, 0, 0, 0, 100, 3121141),
(3110363, 2, 574.414, 563.76, -25.4004, 0, 0, 0, 0, 100, 3121143),
(3110363, 3, 573.598, 587.188, -25.4019, 0, 0, 0, 0, 100, 3121145),
(3110363, 4, 528.011, 592.039, -25.4019, 0, 0, 0, 0, 100, 3121147),
(3110363, 5, 520.793, 605.958, -25.4019, 0, 0, 0, 0, 100, 3121149),
(3110363, 6, 487.163, 606.545, -25.4047, 0, 0, 0, 0, 100, 3121151),
(3110363, 7, 478.159, 595.938, -25.4044, 0, 0, 0, 0, 100, 3121153),
(3110363, 8, 477.63, 579.462, -25.4037, 0, 0, 0, 0, 100, 3121155),
(3110363, 9, 505.943, 574.562, -25.4037, 0, 0, 0, 0, 100, 3121157),
(3110363, 10, 477.384, 579.474, -25.4037, 0, 0, 0, 0, 100, 3121159),
(3110363, 11, 478.77, 594.022, -25.4051, 0, 0, 0, 0, 100, 3121161),
(3110363, 12, 479.477, 598.624, -25.4043, 0, 0, 0, 0, 100, 3121163),
(3110363, 13, 487.075, 605.247, -25.4043, 0, 0, 0, 0, 100, 3121165),
(3110363, 14, 509.917, 605.998, -25.4042, 0, 0, 0, 0, 100, 3121167),
(3110363, 15, 522.375, 606.025, -25.4041, 0, 0, 0, 0, 100, 3121169),
(3110363, 16, 535.967, 587.218, -25.4041, 0, 0, 0, 0, 100, 3121171),
(3110363, 17, 574.659, 586.232, -25.4041, 0, 0, 0, 0, 100, 3121173),
(3110363, 18, 573.588, 562.721, -25.4004, 0, 0, 0, 0, 100, 3121175),
(3110363, 19, 558.422, 549.764, -25.4004, 0, 0, 0, 0, 100, 3121177),
(3110363, 20, 548.623, 525.998, -25.4018, 0, 0, 0, 0, 100, 3121179);

-- Gordok's Spirits are not suppose to be attack-able. 
DELETE FROM `creature_template` WHERE `entry`=11446;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (11446, 0, 0, 0, 0, 0, 13093, 13130, 0, 13132, 'Gordok Spirit', NULL, NULL, 0, 60, 60, 0, 45, 0, 1.76, 1.14286, 1, 1, 104, 138, 0, 252, 5, 1175, 1292, 1, 196612, 2048, 0, 0, 0, 0, 0, 0, 72, 106, 26, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 1, 3, 1, 0.000001, 1, 1, 0, 0, 1, 8388624, 0, 1074003970, '', 12340);

-- Wandering Eye of Kilrogg should summon Netherwalkers and Despawn.
SET @ENTRY := 14386;
DELETE FROM smart_scripts WHERE entryOrGuid = 14386 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Talk 0 to invoker"),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - None: Set unit movement flags to 0"),
(@ENTRY, 0, 2, 0, 4, 0, 100, 0, 1000, 2000, 0, 0, 11, 22876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Cast spell 22876 on Self"),
(@ENTRY, 0, 3, 0, 17, 0, 100, 0, 14389, 0, 0, 0, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On summoned unit Netherwalker (14389)  - None: Despawn in 0.1 s");


DELETE FROM conditions WHERE SourceTypeOrReferenceId = 22 AND SourceEntry = 14386 AND SourceId = 0;

-- Dire Maul North end

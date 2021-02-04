-- Dire Maul start

-- Decreased Guard Slip'kik's speed by 55%
UPDATE creature_template SET `speed_walk`= 1.76 WHERE entry = 14323;

-- Gordok's Spirits are not suppose to be attack-able / But they still should be in order to trigger the Smart_Scripts 
UPDATE creature_template SET `unit_flags`= 131076 WHERE entry = 11446;

-- Netherwalker is not suppose to grant XP when killed. As this is very abusable
UPDATE creature_template SET `flags_extra`= 64 WHERE entry = 14389;

-- Deleting mobs from pack 1 (they are not suppose to be there)
DELETE FROM `creature` WHERE `guid` IN (247711);

-- Inserting missing mob in pack 1 (this one is suppose to be here)
DELETE FROM `creature` WHERE `guid`=247726;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES 
(247726, 13036, 429, 0, 0, 1, 1, 0, 0, 293.428,  22.3743, -3.91569, 1.70123, 86400, 0, 0, 3998, 0, 0, 0, 0, 0, '');

-- Corrected Spawn Position & Gave him MovementType id 2 (Waypoint id: 247709)
UPDATE creature SET `position_x`= 307.35, `position_y`= -9.58133, `position_z`= -3.88598, `orientation`= 4.65288, `MovementType`= 2 WHERE guid = 247709;

DELETE FROM `creature_addon` WHERE `guid`=247709;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(247709, 2477090, 0, 0, 0, 0, NULL);

-- Proper Waypoint from Pack 1 to pack 2
DELETE FROM `waypoint_data` WHERE `id`=2477090;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(2477090, 1, 307.348, -8.82784, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 2, 307.135, -19.3257, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 3, 306.856, -40.3236, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 4, 306.801, -50.8234, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 5, 306.668, -61.3225, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 6, 296.353, -74.4781, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 7, 304.261, -75.5452, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 8, 304.863, -74.159, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 9, 308.368, -59.6182, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 10, 308.427, -49.1197, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 11, 307.801, -28.1291, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 12, 307.76, -7.13253, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 13, 307.88, 3.36644, -3.88598, 0, 0, 0, 0, 100, 0),
(2477090, 14, 306.84, 21.4017, -3.90275, 0, 0, 0, 0, 100, 0),
(2477090, 15, 299.038, 29.605, -3.93202, 0, 0, 0, 0, 100, 0),
(2477090, 16, 299.038, 29.605, -3.93202, 0, 0, 0, 0, 100, 0),
(2477090, 17, 303.228, 15.3181, -3.88825, 0, 0, 0, 0, 100, 0),
(2477090, 18, 306.771, -5.34127, -3.88637, 0, 0, 0, 0, 100, 0);

-- Spawned 3110361 in correct location and gave npc MovementType 2 (waypoint: 3110361)
DELETE FROM `creature` WHERE `guid`=247753;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES 
(247753, 11441, 429, 0, 0, 1, 1, 0, 1, 309.653, 43.6358, -3.92352, 1.56378, 86400, 0, 0, 14355, 0, 2, 0, 0, 0, '');

DELETE FROM `creature_addon` WHERE `guid`=247753;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(247753, 2477530, 0, 0, 0, 0, NULL);

-- Proper Waypoint from pack 1
DELETE FROM `waypoint_data` WHERE `id`=2477530;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(2477530, 1, 309.697, 49.7887, -3.94447, 0, 0, 0, 0, 100, 0),
(2477530, 2, 309.697, 49.7887, -3.94447, 0, 0, 0, 0, 100, 0),
(2477530, 3, 309.894, 60.2868, -3.96293, 0, 0, 0, 0, 100, 0),
(2477530, 4, 309.675, 81.2801, -3.965, 0, 0, 0, 0, 100, 0),
(2477530, 5, 309.131, 104.134, -3.88782, 0, 0, 0, 0, 100, 0),
(2477530, 6, 309.131, 104.134, -3.88782, 0, 0, 0, 0, 100, 0),
(2477530, 7, 310.605, 83.1921, -3.95282, 0, 0, 0, 0, 100, 0),
(2477530, 8, 310.935, 62.1949, -3.94964, 0, 0, 0, 0, 100, 0),
(2477530, 9, 310.25, 41.2154, -3.91403, 0, 0, 0, 0, 100, 0),
(2477530, 10, 308.85, 12.7074, -3.8862, 0, 0, 0, 0, 100, 0),
(2477530, 11, 308.85, 12.7074, -3.8862, 0, 0, 0, 0, 100, 0),
(2477530, 12, 309.45, 41.4261, -3.91537, 0, 0, 0, 0, 100, 0);

-- Delete old Slip'Kik Spawn and Waypoints
-- Respawned Slip'Kik and gave him proper waypoints
DELETE FROM `creature_addon` WHERE `guid`=248080;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(248080, 2480800, 0, 0, 4097, 0, NULL);

DELETE FROM `creature` WHERE `guid`=248080;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES 
(248080, 14323, 429, 0, 0, 1, 1, 0, 1, 547.356, 528.29, -25.4016, 0.706978, 86400, 0, 0, 23688, 0, 2, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id`=2480800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(2480800, 1, 551.187, 529.113, -25.4017, 0, 0, 0, 0, 100, 0),
(2480800, 2, 574.414, 563.76, -25.4004, 0, 0, 0, 0, 100, 0),
(2480800, 3, 573.598, 587.188, -25.4019, 0, 0, 0, 0, 100, 0),
(2480800, 4, 528.011, 592.039, -25.4019, 0, 0, 0, 0, 100, 0),
(2480800, 5, 520.793, 605.958, -25.4019, 0, 0, 0, 0, 100, 0),
(2480800, 6, 487.163, 606.545, -25.4047, 0, 0, 0, 0, 100, 0),
(2480800, 7, 478.159, 595.938, -25.4044, 0, 0, 0, 0, 100, 0),
(2480800, 8, 477.63, 579.462, -25.4037, 0, 0, 0, 0, 100, 0),
(2480800, 9, 505.943, 574.562, -25.4037, 0, 0, 0, 0, 100, 0),
(2480800, 10, 477.384, 579.474, -25.4037, 0, 0, 0, 0, 100, 0),
(2480800, 11, 478.77, 594.022, -25.4051, 0, 0, 0, 0, 100, 0),
(2480800, 12, 479.477, 598.624, -25.4043, 0, 0, 0, 0, 100, 0),
(2480800, 13, 487.075, 605.247, -25.4043, 0, 0, 0, 0, 100, 0),
(2480800, 14, 509.917, 605.998, -25.4042, 0, 0, 0, 0, 100, 0),
(2480800, 15, 522.375, 606.025, -25.4041, 0, 0, 0, 0, 100, 0),
(2480800, 16, 535.967, 587.218, -25.4041, 0, 0, 0, 0, 100, 0),
(2480800, 17, 574.659, 586.232, -25.4041, 0, 0, 0, 0, 100, 0),
(2480800, 18, 573.588, 562.721, -25.4004, 0, 0, 0, 0, 100, 0),
(2480800, 19, 558.422, 549.764, -25.4004, 0, 0, 0, 0, 100, 0),
(2480800, 20, 548.623, 525.998, -25.4018, 0, 0, 0, 0, 100, 0);

DELETE FROM conditions WHERE SourceTypeOrReferenceId = 22 AND SourceEntry = 14386 AND SourceId = 0;
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 22 AND SourceEntry = 11450 AND SourceId = 0;
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 22 AND SourceEntry = 11446 AND SourceId = 0;

-- Wandering Eye of Kilrogg should summon Netherwalkers and Despawn.
SET @ENTRY := 14386;
DELETE FROM smart_scripts WHERE entryOrGuid = 14386 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Talk 0 to invoker"),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 204, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - None: Set unit movement flags to 0"),
(@ENTRY, 0, 2, 0, 4, 0, 100, 0, 1000, 2000, 0, 0, 11, 22876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Cast spell 22876 on Self"),
(@ENTRY, 0, 3, 0, 17, 0, 100, 0, 14389, 0, 0, 0, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On summoned unit Netherwalker (14389)  - None: Despawn in 0.1 s");

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

-- Gordok Spirit is also suppose to do a knockback mechanic if player is 5 Yards or closer. (This is limited to when the player attacks the Ogre but still works better than what it used to. Creature also evades after casting the spell)
SET @ENTRY := 11446;
DELETE FROM smart_scripts WHERE entryOrGuid = 11446 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 11, 22893, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Cast spell 22893 on Victim"),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On link - None: Evade"),
(@ENTRY, 0, 2, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Talk 0 to invoker"),
(@ENTRY, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On reset (e.g. after reaching home) - None: Set invincibility to 0 HP");

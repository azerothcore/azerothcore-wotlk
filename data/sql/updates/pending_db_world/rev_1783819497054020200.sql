-- -------------------------------------------
-- Acherus: The Ebon Hold (Eastern Plaguelands, map 0)
-- Ebon Hold Re-haul Part 1: Training Room (Upper Floor)
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Corpulous (Entry 29205, GUID 125759)
-- Spawn, home anchor, waypoints
UPDATE `creature` SET `position_x`= 2438.5864, `position_y`= -5554.151, `position_z`= 420.79996, `orientation`= 3.9704, `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 125759;

DELETE FROM `creature_addon` WHERE `guid`= 125759;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125759, 1257590, 0, 0, 0, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1257590;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1257590, 1, 2438.5864, -5554.151, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 2, 2417.4072, -5577.2603, 420.76572, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 3, 2418.5613, -5602.91, 420.8, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 4, 2430.862, -5626.988, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 5, 2462.9768, -5636.701, 420.6738, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 6, 2484.44, -5626.886, 420.42795, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 7, 2500.5364, -5595.214, 420.70547, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 8, 2492.1143, -5571.9556, 420.5543, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257590, 9, 2468.1182, -5553.14, 420.66876, NULL, 0, 0, 0, 0, 0, 100, 0);
-- Knight of the Ebon Blade (Entry 29202, GUIDs 125750-751)
-- Patrol pair
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 125750;

DELETE FROM `creature_addon` WHERE `guid`= 125750;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125750, 1257500, 25280, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1257500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1257500, 1, 2433.57, -5553.8066, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 2, 2420.6594, -5566.9326, 420.63525, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 3, 2413.44, -5584.155, 420.79105, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 4, 2413.6936, -5602.8584, 420.8, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 5, 2420.8923, -5620.4087, 420.9104, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 6, 2433.7537, -5633.345, 420.73993, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 7, 2450.98, -5640.4243, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 8, 2469.9941, -5640.2007, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 9, 2487.1394, -5633.4414, 420.70834, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 10, 2500.1155, -5620.1206, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 11, 2507.2742, -5602.695, 420.84003, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 12, 2507.081, -5584.0166, 420.79993, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 13, 2500.0461, -5566.8726, 420.79993, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 14, 2486.89, -5553.5205, 420.79996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 15, 2469.6587, -5546.532, 420.6999, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257500, 16, 2450.987, -5546.5557, 420.70724, NULL, 0, 0, 0, 0, 0, 100, 0);
-- Follower 125751 (formation: follows 125750)
DELETE FROM `creature_formations` WHERE `leaderGUID`= 125750 OR `memberGUID` IN (125750, 125751);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(125750, 125750, 0, 0, 7, 0, 0),
(125750, 125751, 3, 90, 519, 0, 0);
-- Knight of the Ebon Blade (Entry 29202, GUID 125754)
-- Idle, no wander
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 125754;
-- Risen Drudge (Entry 29212, dead decorative corpses)
-- Make the dead-posed drudges (StandState 7) untargettable: NOT_SELECTABLE (0x2000000) | template flags (32784) = 33587216
UPDATE `creature` SET `unit_flags`= 33587216 WHERE `guid` IN (125766, 125768, 125770, 125771, 125773, 125774, 125775, 125776, 125779, 125780, 125781, 125784, 125786, 125788, 125789, 125790, 125792, 125793, 125794, 125795, 125796, 125797, 125799, 125800, 125801, 125803, 125804, 125805, 125807, 125808, 125809, 125810);
-- Risen Drudge (Entry 29212) - remove 2 AC-only spawns absent from the retail sniff
DELETE FROM `creature_addon` WHERE `guid` IN (125767, 125806);
DELETE FROM `creature` WHERE `guid` IN (125767, 125806);
-- Knight of the Ebon Blade (Entry 29202)
-- Sheath weapons
DELETE FROM `creature_addon` WHERE `guid` IN (125651, 125718, 125737, 125742, 125744, 125745, 125748, 125752, 125754, 125755);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125651, 0, 0, 0, 0, 0, 0, NULL),
(125718, 0, 0, 0, 0, 0, 0, NULL),
(125737, 0, 0, 0, 0, 0, 0, NULL),
(125742, 0, 0, 0, 0, 0, 0, NULL),
(125744, 0, 0, 0, 0, 0, 0, NULL),
(125745, 0, 0, 0, 0, 0, 0, NULL),
(125748, 0, 0, 0, 0, 0, 0, NULL),
(125752, 0, 0, 0, 0, 0, 0, NULL),
(125754, 0, 0, 0, 0, 0, 0, NULL),
(125755, 0, 0, 0, 0, 0, 0, NULL);
-- Knight of the Ebon Blade (Entry 29202) - hidden in the rafters (Z~444)
DELETE FROM `creature_addon` WHERE `guid` IN (125714, 125716, 125721, 125732, 125734, 125735, 125739, 125740);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125714, 0, 0, 0, 0, 0, 0, NULL),
(125716, 0, 0, 0, 0, 0, 0, NULL),
(125721, 0, 0, 0, 0, 0, 0, NULL),
(125732, 0, 0, 0, 0, 0, 0, NULL),
(125734, 0, 0, 0, 0, 0, 0, NULL),
(125735, 0, 0, 0, 0, 0, 0, NULL),
(125739, 0, 0, 0, 0, 0, 0, NULL),
(125740, 0, 0, 0, 0, 0, 0, NULL);
-- Vigilant Gargoyle (Entry 29239) - all 8 (Training Room airspace)
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`= 29239;

UPDATE `creature` SET `position_x`= 2434.2053, `position_y`= -5662.7285, `position_z`= 445.16962, `orientation`= 1.17073, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125826;
UPDATE `creature` SET `position_x`= 2386.5322, `position_y`= -5591.9404, `position_z`= 445.1513, `orientation`= 6.21624, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125827;
UPDATE `creature` SET `position_x`= 2391.4082, `position_y`= -5567.293, `position_z`= 444.41574, `orientation`= 5.88485, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125828;
UPDATE `creature` SET `position_x`= 2483.3416, `position_y`= -5565.2993, `position_z`= 465.3641, `orientation`= 5.16390, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125829;
UPDATE `creature` SET `position_x`= 2451.695, `position_y`= -5646.18, `position_z`= 434.86523, `orientation`= 2.34530, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125830;
UPDATE `creature` SET `position_x`= 2430.0688, `position_y`= -5548.5366, `position_z`= 444.9371, `orientation`= 5.23599, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125831;
UPDATE `creature` SET `position_x`= 2458.673, `position_y`= -5667.2334, `position_z`= 445.40192, `orientation`= 1.52346, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125832;
UPDATE `creature` SET `position_x`= 2488.3079, `position_y`= -5584.386, `position_z`= 481.03842, `orientation`= 2.61030, `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125833;

DELETE FROM `creature_addon` WHERE `guid` IN (125826, 125827, 125828, 125829, 125830, 125831, 125832, 125833);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125826, 1258260, 0, 9, 1, 444, 0, NULL),
(125827, 1258270, 0, 9, 1, 444, 0, NULL),
(125828, 1258280, 0, 9, 1, 444, 0, NULL),
(125829, 1258290, 0, 0, 1, 444, 0, NULL),
(125830, 1258300, 0, 0, 1, 444, 0, NULL),
(125831, 1258310, 0, 9, 1, 444, 0, NULL),
(125832, 1258320, 0, 9, 1, 444, 0, NULL),
(125833, 1258330, 0, 0, 1, 444, 0, NULL);
-- Flight paths: patrollers
DELETE FROM `waypoint_data` WHERE `id` IN (1258260, 1258270, 1258280, 1258290, 1258300, 1258310, 1258320, 1258330);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1258260, 1, 2434.21, -5662.73, 445.17, 1.17073, 5, 65000, 0, 2, 0, 100, 0),
(1258260, 2, 2437.7, -5653.26, 447.963, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258260, 3, 2449.12, -5599.83, 455.546, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258260, 4, 2463.19, -5545.83, 455.546, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258260, 5, 2462.16, -5519.81, 445.019, 4.71029, 5, 90000, 0, 2, 0, 100, 0),
(1258260, 6, 2461.56, -5528.22, 448.031, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258260, 7, 2456.53, -5572.52, 454.475, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258260, 8, 2441, -5638.43, 454.475, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 1, 2386.53, -5591.94, 445.151, 6.21624, 5, 100000, 0, 2, 0, 100, 0),
(1258270, 2, 2396.07, -5594.14, 447.163, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 3, 2436.67, -5610.5, 451.023, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 4, 2473.23, -5633.96, 451.023, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 5, 2490.76, -5638.42, 445.051, 2.17773, 5, 70000, 0, 2, 0, 100, 0),
(1258270, 6, 2482.04, -5634.05, 447.43, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 7, 2437.04, -5610.4, 455.235, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258270, 8, 2406.09, -5597.51, 451.596, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 1, 2391.41, -5567.29, 444.416, 5.88485, 5, 82000, 0, 2, 0, 100, 0),
(1258280, 2, 2398.94, -5570.2, 446.666, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 3, 2440.29, -5586.84, 449.832, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 4, 2505.82, -5612.69, 449.832, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 5, 2529.11, -5619.67, 445.193, 2.81575, 5, 108000, 0, 2, 0, 100, 0),
(1258280, 6, 2523.4, -5615.98, 445.721, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 7, 2457.17, -5592.02, 452.471, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258280, 8, 2417.3, -5576.37, 452.471, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258290, 1, 2483.34, -5565.3, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 2, 2496.26, -5592, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 3, 2487.79, -5622.76, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 4, 2454.34, -5633.35, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 5, 2425.15, -5610.25, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 6, 2428.72, -5575.9, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258290, 7, 2455.77, -5556.59, 465.364, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 1, 2451.7, -5646.18, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 2, 2439.38, -5633.58, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 3, 2435.8, -5612.65, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 4, 2415.5, -5592.08, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 5, 2420.02, -5564.28, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 6, 2442.14, -5561.77, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 7, 2455.83, -5546.95, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 8, 2473.27, -5540.89, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 9, 2485.81, -5558.36, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 10, 2486.56, -5585.89, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 11, 2512.01, -5598.65, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 12, 2498.43, -5621.79, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 13, 2473.17, -5621.09, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258300, 14, 2464.31, -5642.48, 434.865, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258310, 1, 2430.07, -5548.54, 444.937, 5.23599, 5, 95000, 0, 3, 0, 100, 0),
(1258310, 2, 2440.2, -5553.77, 447.152, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258310, 3, 2479.28, -5579.33, 458.901, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258310, 4, 2508.33, -5596.56, 458.901, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258310, 5, 2534.25, -5595.29, 445.207, 3.49066, 5, 60000, 0, 3, 0, 100, 0),
(1258310, 6, 2531.36, -5596.21, 447.298, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258310, 7, 2486.9, -5597.17, 448.131, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258310, 8, 2441.01, -5584.44, 448.52, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258320, 1, 2458.67, -5667.23, 445.402, 1.52346, 5, 75000, 0, 2, 0, 100, 0),
(1258320, 2, 2461.16, -5656.92, 448.499, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258320, 3, 2478.7, -5619.14, 450.054, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258320, 4, 2495.67, -5585.25, 450.054, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258320, 5, 2504.88, -5563.37, 444.887, 3.80665, 5, 105000, 0, 2, 0, 100, 0),
(1258320, 6, 2499.79, -5572.24, 447.68, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258320, 7, 2471.41, -5619.1, 454.346, NULL, 5, 0, 0, 3, 0, 100, 0),
(1258330, 1, 2488.31, -5584.39, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 2, 2454.49, -5564.5, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 3, 2435.28, -5578, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 4, 2431.28, -5602.2, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 5, 2446.33, -5619.11, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 6, 2468.88, -5620.94, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0),
(1258330, 7, 2486.97, -5604.07, 481.038, NULL, 5, 0, 1, 0, 0, 100, 0);

-- SmartAI (5 patrollers)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-125826, -125827, -125828, -125831, -125832) AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-125826, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch A: SUBMERGED (idle)'),
(-125826, 0, 1, 0, 108, 0, 100, 0, 2, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff A: STAND (flap)'),
(-125826, 0, 2, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch B: SUBMERGED (idle)'),
(-125826, 0, 3, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff B: STAND (flap)'),
(-125827, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch A: SUBMERGED (idle)'),
(-125827, 0, 1, 0, 108, 0, 100, 0, 2, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff A: STAND (flap)'),
(-125827, 0, 2, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch B: SUBMERGED (idle)'),
(-125827, 0, 3, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff B: STAND (flap)'),
(-125828, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch A: SUBMERGED (idle)'),
(-125828, 0, 1, 0, 108, 0, 100, 0, 2, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff A: STAND (flap)'),
(-125828, 0, 2, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch B: SUBMERGED (idle)'),
(-125828, 0, 3, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff B: STAND (flap)'),
(-125831, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch A: SUBMERGED (idle)'),
(-125831, 0, 1, 0, 108, 0, 100, 0, 2, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff A: STAND (flap)'),
(-125831, 0, 2, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch B: SUBMERGED (idle)'),
(-125831, 0, 3, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff B: STAND (flap)'),
(-125832, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch A: SUBMERGED (idle)'),
(-125832, 0, 1, 0, 108, 0, 100, 0, 2, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff A: STAND (flap)'),
(-125832, 0, 2, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - perch B: SUBMERGED (idle)'),
(-125832, 0, 3, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle - takeoff B: STAND (flap)');

-- Faction correction for vendors
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry` IN (28500, 29203, 29205, 29207, 29208);

-- Master Siegesmith Corvus (Entry 28500, GUID 125869)
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`= 28500;
UPDATE `creature` SET `MovementType`= 2, `wander_distance`= 0 WHERE `guid`= 125869;

DELETE FROM `creature_addon` WHERE `guid`= 125869;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125869, 1258690, 0, 0, 0, 173, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1258690;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1258690, 1, 2435.5186, -5638.2393, 420.64365, NULL, 0, 10000, 0, 0, 0, 100, 0),
(1258690, 2, 2431.862, -5645.493, 420.64664, NULL, 0, 10000, 0, 0, 0, 100, 0),
(1258690, 3, 2451.4836, -5657.5786, 420.64786, NULL, 0, 10000, 0, 0, 0, 100, 0),
(1258690, 4, 2466.9465, -5656.067, 420.64813, NULL, 0, 10000, 0, 0, 0, 100, 0),
(1258690, 5, 2472.0898, -5647.986, 420.6463, NULL, 0, 10000, 0, 0, 0, 100, 0),
(1258690, 6, 2449.722, -5646.9004, 420.64453, NULL, 0, 10000, 0, 0, 0, 100, 0);

DELETE FROM `creature_text` WHERE `CreatureID`= 28500;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28500, 0, 0, 'First, he gives away all of my precious Saronite, then he demands I begin crafting Runeblades of even greater power! Pah!', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus'),
(28500, 0, 1, 'Fix my armor, Corvus! My blade is rusty, Corvus! ... when will these damned mortals ever learn to care for themselves?', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus'),
(28500, 0, 2, 'I may not have any mindless servants, but at least I can see a quality blade made from time to time.', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus'),
(28500, 0, 3, 'There is work to be done here, but do you see anyone jumping to help me? No! Wretches, all of them!', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus'),
(28500, 0, 4, 'These Death Knights truly know no honor. First, they take my greatest arms and armor, crafted with care, forged with the Lich King''s blessing. Then they wander off to who knows where and come back dressed like Goblins, mumbling something about pawning off their armor for a few coppers! Pathetic!', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus'),
(28500, 0, 5, 'What is this nonsense about the Light? I have weapons and armor to make!', 12, 0, 100, 11, 0, 0, 0, 0, 'Master Siegesmith Corvus');

DELETE FROM `smart_scripts` WHERE `entryorguid`= 28500 AND `source_type`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28500, 0, 0, 0, 1, 0, 100, 0, 360000, 480000, 360000, 480000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Corvus - ambient line at random ~7min');


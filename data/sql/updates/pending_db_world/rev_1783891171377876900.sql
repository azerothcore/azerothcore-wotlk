-- -------------------------------------------
-- Acherus: The Ebon Hold (Eastern Plaguelands, map 0)
-- Ebon Hold Re-haul Part 2: Command Center (Bottom Floor)
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Faction corrections
-- Siouxsie the Banshee (Entry 27928)
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry`= 27928;
-- Squire Edwards (Entry 28486)
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry`= 28486;
-- Coldwraith (Entry 28488)
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry`= 28488;
-- Disciple of Frost (Entry 28490)
UPDATE `creature_template` SET `faction`= 2082 WHERE `entry`= 28490;
-- Lord Thorval (Entry 29196)
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry`= 29196;
-- Knight of the Ebon Blade (Entry 31094) (part of the DK questline, is phased, but here nonetheless)
UPDATE `creature_template` SET `faction`= 2050 WHERE `entry`= 31094;
-- Knight of the Ebon Blade (Entry 29202) - Command Center floor - weapon sheathing
DELETE FROM `creature_addon` WHERE `guid` IN (125719, 125727, 125730, 125733, 125738, 125743, 125749, 125753);
+INSERT INTO `creature_addon` (
+    `guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`
+) VALUES
(125719, 0, 0, 0, 0, 0, 0, NULL),
(125727, 0, 0, 0, 0, 0, 0, NULL),
(125730, 0, 0, 0, 0, 0, 0, NULL),
(125733, 0, 0, 0, 0, 0, 0, NULL),
(125738, 0, 0, 0, 0, 0, 0, NULL),
(125743, 0, 0, 0, 0, 0, 0, NULL),
(125749, 0, 0, 0, 0, 0, 0, NULL),
(125753, 0, 0, 0, 0, 0, 0, NULL);
-- Knight of the Ebon Blade (Entry 29202, GUIDs 125728-729) - Command Center OUTER ring patrol
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 125728;
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 125729;

DELETE FROM `creature_addon` WHERE `guid`= 125728;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125728, 1257280, 25280, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1257280;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1257280, 1, 2453.019, -5659.009, 376.963, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 2, 2436.503, -5654.292, 377.010, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 3, 2421.870, -5646.072, 377.085, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 4, 2409.462, -5633.826, 377.061, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 5, 2401.033, -5619.471, 377.059, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 6, 2396.028, -5602.503, 377.042, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 7, 2395.134, -5584.744, 377.032, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 8, 2400.252, -5568.880, 377.175, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 9, 2408.467, -5554.637, 377.087, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 10, 2422.047, -5542.582, 377.077, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 11, 2436.357, -5533.727, 377.048, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 12, 2453.023, -5528.724, 377.021, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 13, 2470.619, -5528.724, 376.969, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 14, 2486.896, -5534.060, 377.074, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 15, 2500.929, -5542.755, 377.070, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 16, 2511.579, -5556.004, 377.029, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 17, 2520.007, -5569.621, 377.088, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 18, 2525.179, -5586.072, 377.027, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 19, 2525.346, -5603.292, 376.955, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 20, 2521.025, -5618.274, 377.021, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 21, 2512.638, -5633.113, 377.022, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 22, 2500.469, -5644.090, 377.130, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 23, 2485.997, -5652.299, 377.080, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257280, 24, 2470.307, -5658.005, 377.048, NULL, 0, 0, 0, 0, 0, 100, 0);
-- Follower 125729
DELETE FROM `creature_formations` WHERE `leaderGUID`= 125728 OR `memberGUID` IN (125728, 125729);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(125728, 125728, 0, 0, 7, 0, 0),
(125728, 125729, 3, 270, 519, 0, 0);
-- Knight of the Ebon Blade (Entry 29202, GUID 125746) - Command Center INNER ring patrol
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 125746;

DELETE FROM `creature_addon` WHERE `guid`= 125746;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(125746, 1257460, 25280, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1257460;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1257460, 1, 2476.547, -5569.105, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 2, 2465.888, -5564.635, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 3, 2454.430, -5564.898, 366.996, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 4, 2439.936, -5573.309, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 5, 2431.440, -5587.982, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 6, 2431.727, -5599.489, 367.319, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 7, 2436.017, -5610.170, 367.033, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 8, 2442.707, -5616.534, 367.034, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 9, 2446.977, -5619.203, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 10, 2456.497, -5622.578, 366.988, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 11, 2465.452, -5622.340, 367.009, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 12, 2468.838, -5621.344, 367.016, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 13, 2476.673, -5618.066, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 14, 2482.256, -5612.358, 366.987, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 15, 2489.440, -5599.080, 367.042, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 16, 2488.702, -5586.393, 367.230, NULL, 0, 0, 0, 0, 0, 100, 0),
(1257460, 17, 2485.971, -5579.744, 367.045, NULL, 0, 0, 0, 0, 0, 100, 0);

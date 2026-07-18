-- --------------------------------------------------------------------------------------------
-- Acherus: The Ebon Hold (Eastern Plaguelands, map 0)
-- Ebon Hold Re-haul Part 4: Knight of the Ebon Blade Fliers
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Knight of the Ebon Blade (Entry 29202, GUIDs 125724 and 125726)
-- Set SAI for 29202; set 'CanFly' flags due to AzerothCore limitation (can't set per-guid)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `flags_extra` = `flags_extra` |512 WHERE `entry` = 29202;
-- Flight waypoints for 125724
DELETE FROM `waypoint_data` WHERE `id` = 1257240;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`, `velocity`, `smoothTransition`) VALUES
(1257240, 1, 2329.3564, -5658.356, 388.62885, NULL, 7400, 3, 0, 100, 0, 2.5, 0),
(1257240, 2, 2319.1614, -5657.183, 386.93494, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 3, 2307.284, -5650.997, 386.93494, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 4, 2301.35, -5635.033, 380.87967, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 5, 2322.1697, -5569.3086, 350.82324, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 6, 2338.373, -5510.7095, 352.2416, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 7, 2361.3696, -5470.4307, 352.76913, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 8, 2446.082, -5442.422, 350.90756, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 9, 2515.6255, -5450.3584, 356.76846, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 10, 2588.6985, -5507.009, 359.1858, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 11, 2503.0312, -5580.3525, 332.79803, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 12, 2374.0864, -5671.5815, 340.68686, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 13, 2320.237, -5695.78, 343.4362, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257240, 14, 2332.0254, -5686.1157, 350.9917, NULL, 2700, 3, 0, 100, 0, 11.2, 1),
(1257240, 15, 2333.1387, -5680.5825, 390.14697, NULL, 0, 3, 0, 100, 0, 8, 0),
(1257240, 16, 2323.3472, -5656.067, 383.39368, 6.248, 2000, 3, 0, 100, 0, 8, 0),
(1257240, 17, 2323.633, -5656.0771, 382.39368, 6.248, 0, 2, 0, 100, 0, 2.5, 0);
-- Takeoff/landing/orientation correction for 125724
DELETE FROM `smart_scripts` WHERE `entryorguid` = -125724 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-125724, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - On Respawn - Set Fly Off (grounded)'),
(-125724, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 121600, 121600, 0, 60, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - OOC timer (~121.6s cadence) - Set Fly On (gravity disabled)'),
(-125724, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - linked - Timed event (0.5s) before pathing'),
(-125724, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 232, 1257240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - timed event - Start flight path'),
(-125724, 0, 4, 5, 109, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - Path Ended - Set Fly Off (land)'),
(-125724, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 2, 1500, 1500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125724 - linked - Timed event (1.5s) so land settles before facing'),
(-125724, 0, 6, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.248, 'Flyer 125724 - timed event - Face spawn orientation (instant, explicit angle - home pos is mutated in flight)');
-- Flight waypoints for 125726
DELETE FROM `waypoint_data` WHERE `id` = 1257260;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`, `velocity`, `smoothTransition`) VALUES
(1257260, 1, 2329.3564, -5658.356, 388.62885, NULL, 7400, 3, 0, 100, 0, 2.5, 0),
(1257260, 2, 2319.1614, -5657.183, 386.93494, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 3, 2307.284, -5650.997, 386.93494, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 4, 2301.35, -5635.033, 380.87967, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 5, 2322.1697, -5569.3086, 350.82324, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 6, 2338.373, -5510.7095, 352.2416, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 7, 2361.3696, -5470.4307, 352.76913, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 8, 2446.082, -5442.422, 350.90756, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 9, 2515.6255, -5450.3584, 356.76846, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 10, 2588.6985, -5507.009, 359.1858, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 11, 2503.0312, -5580.3525, 332.79803, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 12, 2374.0864, -5671.5815, 340.68686, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 13, 2320.237, -5695.78, 343.4362, NULL, 0, 3, 0, 100, 0, 11.2, 1),
(1257260, 14, 2332.0254, -5686.1157, 350.9917, NULL, 2700, 3, 0, 100, 0, 11.2, 1),
(1257260, 15, 2333.1387, -5680.5825, 390.14697, NULL, 0, 3, 0, 100, 0, 8, 0),
(1257260, 16, 2325.7349, -5663.413, 383.39368, 0.384, 2000, 3, 0, 100, 0, 8, 0),
(1257260, 17, 2326.0001, -5663.3059, 382.39368, 0.384, 0, 2, 0, 100, 0, 2.5, 0);
-- Takeoff/landing/orientation correction for 125726
DELETE FROM `smart_scripts` WHERE `entryorguid` = -125726 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-125726, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - On Respawn - Set Fly Off (grounded)'),
(-125726, 0, 1, 2, 1, 0, 100, 0, 65750, 65750, 121600, 121600, 0, 60, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - OOC timer (~121.6s cadence, +60.75s offset) - Set Fly On (gravity disabled)'),
(-125726, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - linked - Timed event (0.5s) before pathing'),
(-125726, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 232, 1257260, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - timed event - Start flight path'),
(-125726, 0, 4, 5, 109, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - Path Ended - Set Fly Off (land)'),
(-125726, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 2, 1500, 1500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Flyer 125726 - linked - Timed event (1.5s) so land settles before facing'),
(-125726, 0, 6, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.384, 'Flyer 125726 - timed event - Face spawn orientation (instant, explicit angle - home pos is mutated in flight)');

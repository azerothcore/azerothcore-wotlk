-- --------------------------------------------------------------------------------------------
-- Sholazar Basin (Northrend, map 571)
-- The Avalanche sub-Zone Improvements Part 1: Bythius the Flesh-Shaper, Cerberon and Glonn
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Bythius the Flesh-Shaper (Entry 28212, GUID 100735)
-- Patrol leader
UPDATE `creature` SET `position_x`= 6093.8193, `position_y`= 3697.6428, `position_z`= 121.3801, `orientation`= 1.6121, `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 100735;

DELETE FROM `creature_addon` WHERE `guid`= 100735;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(100735, 1007350, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id`= 1007350;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1007350, 1, 6093.8193, 3697.6428, 121.3801, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 2, 6092.3813, 3732.4739, 111.712875, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 3, 6104.4736, 3761.4934, 99.21134, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 4, 6126.7734, 3784.2405, 98.07227, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 5, 6154.6465, 3809.3542, 97.78479, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 6, 6162.4736, 3834.5305, 96.1805, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 7, 6166.2695, 3868.0396, 90.56232, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 8, 6181.818, 3892.109, 88.32843, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 9, 6166.2695, 3868.0396, 90.56232, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 10, 6162.4736, 3834.5305, 96.1805, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 11, 6154.6465, 3809.3542, 97.78479, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 12, 6126.7734, 3784.2405, 98.07227, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 13, 6104.4736, 3761.4934, 99.21134, NULL, 0, 0, 0, 0, 0, 100, 0),
(1007350, 14, 6092.3813, 3732.4739, 111.712875, NULL, 0, 0, 0, 0, 0, 100, 0);
-- Cerberon (Entry 28207, GUID 100431)
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 100431;
-- Glonn (Entry 28211, GUID 100704)
UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 100704;
-- Hound pack formation (leader 100735, hounds flank on opposite sides)
DELETE FROM `creature_formations` WHERE `leaderGUID`= 100735 OR `memberGUID` IN (100735, 100431, 100704);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(100735, 100735, 0, 0, 7, 0, 0),
(100735, 100431, 15, 165, 519, 1, 8),
(100735, 100704, 15, 205, 519, 1, 8);

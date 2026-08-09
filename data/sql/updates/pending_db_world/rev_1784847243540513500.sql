-- --------------------------------------------------------------------------------------------
-- Sholazar Basin (Northrend, map 571)
-- The Avalanche sub-Zone Improvements Part 1: Bythius the Flesh-Shaper, Cerberon and Glonn
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Bythius the Flesh-Shaper (Entry 28212, GUID 100735)
-- Patrol leader
UPDATE `creature` SET `position_x`= 6093.8193, `position_y`= 3697.6428, `position_z`= 121.3801, `orientation`= 1.6121, `wander_distance`= 0, `MovementType`= 2 WHERE `guid`= 100735 AND `id`= 28212;

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
-- Spawns in formation, 15 yd behind Bythius at 165 degrees
UPDATE `creature` SET `position_x`= 6090.5401, `position_y`= 3683.0056, `position_z`= 126.22, `orientation`= 1.6121, `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 100431 AND `id`= 28207;
-- Glonn (Entry 28211, GUID 100704)
-- Spawns in formation, 15 yd behind Bythius at 205 degrees
UPDATE `creature` SET `position_x`= 6100.7147, `position_y`= 3684.3212, `position_z`= 127.55, `orientation`= 1.6121, `wander_distance`= 0, `MovementType`= 0 WHERE `guid`= 100704 AND `id`= 28211;
-- Plague-dog pack formation (leader 100735, plague-dogs flank on opposite sides)
-- point_1/point_2 mirror the follow angle so each hound keeps to the same side of the trail
-- on the return leg. They are matched against the waypoint Bythius is moving TOWARD, so they
-- name the leg after each reversal: 2 = leaving waypoint 1 (south end), 9 = leaving waypoint 8 (north end)
DELETE FROM `creature_formations` WHERE `leaderGUID`= 100735 OR `memberGUID` IN (100735, 100431, 100704);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
    (100735, 100735, 0, 0, 7, 0, 0),
    (100735, 100431, 15, 165, 519, 2, 9),
    (100735, 100704, 15, 205, 519, 2, 9);
-- Remove Bythius SAI that spawns another set of plague-dogs
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`= 28212;

DELETE FROM `smart_scripts` WHERE (`entryorguid`= 28212) AND (`source_type`= 0) AND (`id` IN (0, 1));

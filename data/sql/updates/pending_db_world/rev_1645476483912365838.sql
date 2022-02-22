INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645476483912365838');

-- Smolderthorn Berserker guid 43101
-- adjust npc to use waypoints
UPDATE `creature` SET `MovementType`='2' WHERE  `guid`=43101;

-- link guid to waypoint
DELETE FROM `creature_addon` WHERE `guid`=43101;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES 
(43101, 926800, 0, 0, 0, 0, 3, NULL);

-- waypoints are transferred to waypoint_data
DELETE FROM `waypoint_data` WHERE `id`=926800;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(926800, 0, -53.6383, -442.827, 78.2854, 0, 0, 0, 0, 100, 0),
(926800, 1, -53.2897, -405.473, 77.7616, 0, 0, 0, 0, 100, 0),
(926800, 2, -52.7996, -389.966, 77.7702, 0, 0, 0, 0, 100, 0);

-- delete troublesome smart scripts
DELETE FROM `smart_scripts` WHERE  `entryorguid`=-43101;

-- delete exsisting waypoints
DELETE FROM `waypoints` WHERE `entry`=926800;

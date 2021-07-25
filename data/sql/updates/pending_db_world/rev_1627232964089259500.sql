INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627232964089259500');


-- Delete previous spawns to have two spawns (38089 and 134366)
DELETE FROM `creature` WHERE (`id` = 8299) AND (`guid` IN (134367, 134368, 134369, 134370, 134371, 134372, 134373, 134374, 134375, 134376, 134377, 134378, 134379));
DELETE FROM `pool_creature` WHERE (`guid` IN (134367, 134368, 134369, 134370, 134371, 134372, 134373, 134374, 134375, 134376, 134377, 134378, 134379));

-- Set the Creature Spiteflayer a patrol route movement and reduced movement speed
UPDATE `creature_template` SET `MovementType` = 2, `speed_walk` = 1 WHERE (`entry` = 8299);
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 8299) AND (`guid` IN (38089, 134366));

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` IN (38089, 134366));

-- Add new routes to those 2 spawns
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(38089, 380890, 0, 0, 0, 0, 0, NULL),
(134366, 1343660, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE (`id` IN (380890, 1343660));

-- Added patrolling around the ruined towers and on Serpent Coil

-- Waypoint route 1 (GUID: 38089)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(380890,1,-11518.40,-3204.284,8.26,0,0,0,0,100,0),
(380890,2,-11437.358,-3310.323,7.945,0,0,0,0,100,0),
(380890,3,-11311.348,-3370.686,7.628,0,0,0,0,100,0),
(380890,4,-11216.27,-3341.978,5.003,0,0,0,0,100,0),
(380890,5,-11193.522,-3292.800,9.222,0,0,0,0,100,0),
(380890,6,-11199.982,-3201.657,8.01,0,5000,0,0,100,0),
(380890,7,-11193.522,-3292.800,9.222,0,0,0,0,100,0),
(380890,8,-11216.27,-3341.978,5.003,0,0,0,0,100,0),
(380890,9,-11311.348,-3370.686,7.628,0,0,0,0,100,0),
(380890,10,-11437.358,-3310.323,7.945,0,0,0,0,100,0),
(380890,11,-11518.40,-3204.284,8.26,0,0,0,0,100,0);

-- Waypoint route 2 (GUID: 134366)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1343660,1,-11539.215,-3334.62,14.56,0,0,0,0,100,0),
(1343660,2,-11434.73,-3319.644,8.44,0,0,0,0,100,0),
(1343660,3,-11361.722,-3345.695,7.586,0,0,0,0,100,0),
(1343660,4,-11333.39,-3373.223,7.699,0,0,0,0,100,0),
(1343660,5,-11294.761,-3359.196,8.647,0,5000,0,0,100,0),
(1343660,6,-11333.39,-3373.223,7.699,0,0,0,0,100,0),
(1343660,7,-11361.722,-3345.695,7.586,0,0,0,0,100,0),
(1343660,8,-11434.73,-3319.644,8.44,0,0,0,0,100,0),
(1343660,9,-11539.215,-3334.62,14.56,0,5000,0,0,100,0);


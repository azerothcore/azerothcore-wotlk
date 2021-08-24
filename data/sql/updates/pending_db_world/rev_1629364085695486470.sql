INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629364085695486470');

-- Set the Creature Murgurgula (17475) a patrol route movement
UPDATE `creature` SET `MovementType` = 2  WHERE (`id` = 17475) AND (`guid` = 62989);
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 17475);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 62989);

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(62989, 629890, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE `id` = 629890;

INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- Waypoint route 1 (GUID: 62989)
(629890,1,-3372.92,-11914.38,3.722759,0,0,0,0,100,0),
(629890,2,-3356.65,-11894.77,2.057151,0,0,0,0,100,0),
(629890,3, -3329.170,-11886.7,1.389057 ,0,0,0,0,100,0),
(629890,4,-3232.49,-11893.62,1.211532,0,0,0,0,100,0),
(629890,5,-3202.05,-11893.4,1.543104,0,0,0,0,100,0),
(629890,6,-3129.76,-11929.60,2.551130,0,0,0,0,100,0),
(629890,7,-3202.05,-11893.4,1.543104,0,0,0,0,100,0),
(629890,8,-3232.49,-11893.62,1.211532,0,0,0,0,100,0),
(629890,9, -3329.170,-11886.7,1.389057 ,0,0,0,0,100,0),
(629890,10,-3356.65,-11894.77,2.057151,0,0,0,0,100,0),
(629890,11,-3372.92,-11914.38,3.722759,0,0,0,0,100,0);

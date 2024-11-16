-- DB update 2023_12_03_06 -> 2023_12_03_07
-- add a time to script_waypoint
DELETE FROM `script_waypoint` WHERE `entry`=17077 AND `pointid` IN (50, 51, 52, 53);
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(17077, 50, 519.146, 3886.7, 190.128, 8000, 'RYGA_MOVEMENT_TO_WOLF'),
(17077, 51, 519.146, 3886.7, 190.128, 13000, 'RYGA_TIME_MOVEMENT_TO_WOLF'),
(17077, 52, 519.146, 3886.7, 190.128, 5000, 'RYGA_TIME_RETURN_SPAWN'),
(17077, 53, 519.146, 3886.7, 190.128, 50000, 'DESPAWN_WOLF');

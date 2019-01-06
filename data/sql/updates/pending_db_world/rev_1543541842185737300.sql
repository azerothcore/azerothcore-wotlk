INSERT INTO version_db_world (`sql_rev`) VALUES ('1543541842185737300');

DELETE FROM `script_waypoint` WHERE `entry` = 35491 AND `pointid` IN (11,12);
INSERT INTO `script_waypoint` VALUES (35491, 11, 753.757, 634.502, 411.579, 1000, '');
INSERT INTO `script_waypoint` VALUES (35491, 12, 753.757, 634.502, 411.579, 0, '');

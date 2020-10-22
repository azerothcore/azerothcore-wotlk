INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603401587698987500');

-- Ulduar Colossus bridge pathing fix --
UPDATE `waypoint_data` SET `point`='3' WHERE  `id`=1374780 AND `point`=2;
REPLACE INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`)  VALUES ('1374780', '1', '70.8102', '-170.786', '410.66');
REPLACE INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`)  VALUES ('1374780', '2', '70.8102', '-223.244', '418.91');
REPLACE INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`)  VALUES ('1374780', '3', '70.8102', '-263.742', '413.36');
REPLACE INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`)  VALUES ('1374780', '4', '70.8102', '-223.244', '418.91');

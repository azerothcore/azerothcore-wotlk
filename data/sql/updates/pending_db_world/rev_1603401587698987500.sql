INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1603401587698987500');

-- Ulduar Colossus bridge pathing fix --
DELETE FROM `waypoint_data` WHERE `id` = '1374780';
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`)  VALUES 
('1374780', '1', '71.3266', '-170.786', '410.72'),
('1374780', '2', '71.3266', '-212.300', '418.99'),
('1374780', '3', '71.3266', '-232.054', '418.99'),
('1374780', '4', '71.3266', '-263.742', '413.42'),
('1374780', '5', '71.3266', '-232.054', '418.99'),
('1374780', '6', '71.3266', '-212.300', '418.99');

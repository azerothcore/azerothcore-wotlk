INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571215774635756412');

-- Chilltusk: Remove usage of spell "First Aid" during waypoint movement
UPDATE `waypoint_data` SET `action` = 0 WHERE `id` = 1074120;
DELETE FROM `waypoint_scripts` WHERE `id` IN (1046,1047);

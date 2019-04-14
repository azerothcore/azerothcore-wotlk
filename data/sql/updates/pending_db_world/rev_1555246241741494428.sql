INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555246241741494428');

DELETE FROM `waypoint_scripts` WHERE `id` IN (8014900,8025100);
UPDATE `waypoint_data` SET `action` = 0 WHERE `action` IN (8014900,8025100);

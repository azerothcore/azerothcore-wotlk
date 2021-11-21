INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637516999973651100');

DELETE FROM `acore_string` WHERE `entry` = 1516;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(1516, 'Quest ID %u does not exist');

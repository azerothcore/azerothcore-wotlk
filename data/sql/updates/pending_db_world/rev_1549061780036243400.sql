INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549061780036243400');

DELETE FROM `trinity_string` WHERE `entry` = 5072;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(5072, 'You can\'t spy yourself.');
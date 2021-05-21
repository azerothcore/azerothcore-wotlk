INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621635365470149700');

DELETE FROM `acore_string` WHERE `entry` = 892;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (892, 'LFG tesing set to: %s');

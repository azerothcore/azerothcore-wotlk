INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623112710636791400');

DELETE FROM `acore_string` WHERE `entry`=6617;
INSERT INTO `acore_string` VALUES ('6617', 'No acore_string for id: %i found.', null, null, 'Es wurde kein acore_string mit der id: %i gefunden.', null, null, null, null, null);

DELETE FROM `command` WHERE `name`='string';
INSERT INTO `command` VALUES ('string', '2', 'Syntax: .string #id [#locale]');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641155240423609800');

-- Adjust ".gm list" to security 3 as default
UPDATE `command` SET `security`='3' WHERE  `name`='gm list';

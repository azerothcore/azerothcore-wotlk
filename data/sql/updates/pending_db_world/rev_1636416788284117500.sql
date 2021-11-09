INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636416788284117500');

DELETE FROM `command` WHERE `name`='debug dummy';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug dummy',3,'Syntax: .debug dummy <???>

Catch-all debug command. Does nothing by default. If you want it to do things for testing, add the things to its script in cs_debug.cpp.');

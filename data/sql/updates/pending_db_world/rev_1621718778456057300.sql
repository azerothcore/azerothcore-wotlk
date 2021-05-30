INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621718778456057300');

DELETE FROM `command` WHERE `name` = 'server debug';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('server debug', 3, 'Syntax: .server debug\r\nShows detailed information about the server setup, useful when reporting a bug.');

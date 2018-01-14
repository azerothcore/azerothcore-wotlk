INSERT INTO version_db_world (`sql_rev`) VALUES ('1515920217003409800');

DELETE FROM `command` WHERE `name` = 'guild info';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('guild info', 2, 'Shows information about the target''s guild or a given Guild Id or Name.');

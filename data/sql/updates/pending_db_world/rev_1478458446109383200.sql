INSERT INTO version_db_world(`sql_rev`) VALUES ('1478458446109383200');

DELETE FROM `command` WHERE `name` = 'reload broadcast_text';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload broadcast_text', 3, 'Syntax: .reload broadcast_text\r\n\r\nReload broadcast_text table.');

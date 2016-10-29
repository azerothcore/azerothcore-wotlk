INSERT INTO version_db_world(`sql_rev`) VALUES ('1477683243N');

DELETE FROM `command` WHERE `name` = 'reload battleground_template';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload battleground_template', 3, 'Syntax: .reload battleground_template\r\nReload Battleground Templates.');

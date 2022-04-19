INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644531208243387100');

DELETE FROM `command` WHERE `name`='reload mail_server_template';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload mail_server_template', 3, 'Syntax: .reload mail_server_template\nReload server_mail_template table.');

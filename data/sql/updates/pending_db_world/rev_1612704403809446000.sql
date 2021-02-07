INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612704403809446000');

UPDATE `command` SET `security` = 1 WHERE `name` = 'gm';
UPDATE `command` SET `security` = 2 WHERE `name` IN ('gm list', 'gm visible');
UPDATE `command` SET `security` = 3 WHERE `name` IN ('cometome', 'wpgps');

INSERT IGNORE INTO  `command` (`name`, `security`, `help`) VALUES
('bank', 2, 'Syntax: .bank Show your bank inventory.'),
('debug Mod32Value', 3, 'Syntax: .debug Mod32Value #field #value Add #value to field #field of your character.'),


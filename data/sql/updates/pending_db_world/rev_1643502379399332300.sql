INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643502379399332300');

DELETE FROM `command` WHERE `name` = 'go quest';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('go quest', 1, 'Syntax: .go quest <starter/ender> <quest>.\nTeleports you to the quest starter/ender creature or object.');

DELETE FROM `acore_string` WHERE `entry` = 5082;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_deDE`) VALUES
(5082, 'Incorrect syntax. Specify either \'starter\' or \'ender\'.', 'Falsche syntax. Entweder \'starter\' oder \'ender\' angeben.');

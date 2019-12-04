INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575409612123583009');

DELETE FROM `command` WHERE `name` IN ('player learn','player unlearn');
INSERT INTO `command` (`name`, `security`, `help`)
VALUES
('player learn',2,'Syntax: .player learn #playername #spell.'),
('player unlearn',2,'Syntax: .player unlearn #playername #spell.');

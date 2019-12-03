INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575409612123583009');

DELETE FROM `command` WHERE `name` IN ('playerlearnspell','playerunlearnspell');
INSERT INTO `command` (`name`, `security`, `help`)
VALUES
('playerlearnspell',2,'Syntax: .playerlearnspell #playername #spell.'),
('playerunlearnspell',2,'Syntax: .playerunlearnspell #playername #spell.');

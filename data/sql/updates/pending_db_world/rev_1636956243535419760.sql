INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636956243535419760');

DELETE FROM `command` WHERE `name` = 'character rename';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('character rename', 2, 'Syntax: .character rename [$name] [reserveName] [$newName]\r\n\r\nMark selected in game or by $name in command character for rename at next login.\r\n\r\nIf [reserveName] is 1 then the player\'s current name is added to the list of reserved names.\r\nIf [newName] then the player will be forced rename.');

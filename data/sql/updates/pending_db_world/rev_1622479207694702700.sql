INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622479207694702700');

UPDATE `command` SET `help` = 'Syntax: .character rename [$name] [reserveName]\r\n\r\nMark the character (selected in-game or with the $name argument) for rename at next login.\r\n\r\nIf [reserveName] is 1 then the player''s current name is added to the list of reserved names.' WHERE `command`.`name` = 'character rename';

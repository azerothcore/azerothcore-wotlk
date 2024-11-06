-- DB update 2023_12_02_00 -> 2023_12_03_00
--
DELETE FROM `command` WHERE `name`='go creature name';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('go creature name', 1, 'Syntax: .go creature name #name\r\nTeleports you to the first spawn for the given creature name.\r\n*If* more than one creature is found, then you are teleported to the first that is found inside the database.');

UPDATE `command` SET `help` = 'Syntax: .go creature id #creature_entry\r\nTeleports you to the given creature entry.\r\n*If* more than one creature is found, then you are teleported to the first that is found inside the database.' WHERE `name` = 'go creature id';

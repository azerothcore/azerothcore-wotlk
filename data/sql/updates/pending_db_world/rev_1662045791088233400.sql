--
DELETE FROM `command` WHERE `name` = 'go creature id';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('go creature id', 1, 'Syntax: .go creature id #creature_entry\nTeleports you to the given creature entry.');

DELETE FROM `command` WHERE `name` IN ('chat', 'chata', 'chath');

INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('chata', 1, 'Syntax: .chata $text - To speak as a GM only to Alliance'),
('chath', 1, 'Syntax: .chath $text - To speak as a GM only to Horde'),
('chat', 0, 'Syntax: .chat $text\n.chat on To show World Chat\n.chat off To hide World Chat');

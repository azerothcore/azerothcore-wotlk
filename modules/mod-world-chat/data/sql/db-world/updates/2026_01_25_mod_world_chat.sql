UPDATE `command`
SET command.help = 'Syntax: .chat [$text]'
WHERE command.name = 'chat';

UPDATE `command`
SET command.help = 'Syntax: .chata [$text] - To speak to Alliance'
WHERE command.name = 'chata';

UPDATE `command`
SET command.help = 'Syntax: .chath [$text] - To speak to Horde'
WHERE command.name = 'chath';

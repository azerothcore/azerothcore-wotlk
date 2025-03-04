--
DELETE FROM `command` WHERE `name`='go creature script';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('go creature script', 1, 'Syntax: .go creature script #scriptName Teleports you to the given creature with the assinged scriptName.');

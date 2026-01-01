DELETE FROM `command` WHERE `name` IN ('list auras id', 'list auras name', 'account remove country', 'debug mapdata', 'debug visibilitydata', 'event info');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('list auras id', 1, 'Syntax: .list auras id\n\nLists all active auras on the selected unit by spell ID.'),
('list auras name', 1, 'Syntax: .list auras name\n\nLists all active auras on the selected unit by spell name.'),
('account remove country', 3, 'Syntax: .account remove country <account>\n\nRemoves the country information associated with the specified account.'),
('debug mapdata', 3, 'Syntax: .debug mapdata\n\nDisplays debug information about the current map.'),
('debug visibilitydata', 3, 'Syntax: .debug visibilitydata\n\nDisplays debug information related to object visibility around the player.'),
('event info', 2, 'Syntax: .event info [event_id]\n\nDisplays information about game events.');

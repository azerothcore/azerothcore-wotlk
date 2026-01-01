DELETE FROM `command` WHERE `name` IN ('instance stats', 'cheat status','gm spectator','gm on','gm off','debug unitstate');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('instance stats', 1, 'Syntax: .instance stats\n\nShows statistics about instances.'),
('cheat status', 2, 'Syntax: .cheat status\n\nShows the cheats you currently have enabled.'),
('gm spectator', 2, 'Syntax: .gm spectator on|off\n\nRequires .gm on. Allows the GM character to follow members of the opposite faction. You may need to change zones for the effect to apply.'),
('gm on', 1, 'Syntax: .gm on\n\nTurns on GM flag.'),
('gm off', 1, 'Syntax: .gm off\n\nTurns off GM flag.'),
('debug unitstate', 3, 'Syntax: .debug unitstate [#unitstate]\n\nSets the unit state for the selected unit or displays current unit and react state.');

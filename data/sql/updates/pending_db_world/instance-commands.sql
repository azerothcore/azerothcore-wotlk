DELETE FROM `command` WHERE `name` IN
(
  'instance stats',
  'cheat status',
  'gm spectator',
  'gm on',
  'gm off',
  'debug unitstate'
);

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('instance stats', 1,
'Syntax: .instance stats\r\n\r\nShows statistics about instances.'),
('cheat status', 2,
'Syntax: .cheat status\r\n\r\nShows the cheats you currently have enabled.'),
('gm spectator', 2,
'Syntax: .gm spectator on|off\r\n\r\nRequires .gm on. Allows the GM character to follow members of the opposite faction. You may need to change zones for the effect to apply.'),
('gm on', 1,
'Syntax: .gm on\r\n\r\nTurns on GM flag.'),
('gm off', 1,
'Syntax: .gm off\r\n\r\nTurns off GM flag.'),
('debug unitstate', 3,
'Syntax: .debug unitstate [#unitstate]\r\n\r\nSets the unit state for the selected unit or displays current unit and react state.');

--
DELETE FROM `command` WHERE `name` LIKE 'pooltools%';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('pooltools', 3, 'Syntax: .pooltools [subcommand]\nTools for creating herb/mining pools from live spawns.'),
('pooltools start', 3, 'Syntax: .pooltools start [Description]\nStarts a new pooling session with the specified description.'),
('pooltools def', 3, 'Syntax: .pooltools def [EntryID] [Chance] [EntryID] [Chance]...\nDefines which IDs of detected groups along with their chances.'),
('pooltools add', 3, 'Syntax: .pooltools add [Radius]\nSearches for nodes defined in your template within 5 yards or the defined radius and adds to the current session.'),
('pooltools remove', 3, 'Syntax: .pooltools remove\nRemoves the last group added via .pooltools add'),
('pooltools end', 3, 'Syntax: .pooltools end [Filename]\nGenerates the SQL.'),
('pooltools clear', 3, 'Syntax: .pooltools clear\nClears the current session from memory.');

-- DB update 2025_12_28_00 -> 2025_12_29_00
--
DELETE FROM `command` WHERE `name` LIKE 'pooltools%';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('pooltools', 3, 'Syntax: .pooltools $subcommand\nTools for creating gameobject pools ingame.\nTo use pooltools, uncomment Appender.Dev and Logger.sql.dev in the worldserver config.'),
('pooltools start', 3, 'Syntax: .pooltools start #description\nStarts a pooling session with the specified description.'),
('pooltools def', 3, 'Syntax: .pooltools def #GameobjectID #Chance #GameobjectID #Chance (...)\nDefines the Gameobject entries to be detected along with their associated chances.'),
('pooltools add', 3, 'Syntax: .pooltools add [radius]\nAdds nearby gameobjects to the pooling session. Default radius is 5y.'),
('pooltools remove', 3, 'Syntax: .pooltools remove\nRemoves the last group from the pooling session.'),
('pooltools end', 3, 'Syntax: .pooltools end\nLogs the current pooling session and clears it.'),
('pooltools clear', 3, 'Syntax: .pooltools clear\nClears the current pooling session.');

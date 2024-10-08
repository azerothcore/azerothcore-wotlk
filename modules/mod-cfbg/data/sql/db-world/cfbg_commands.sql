DELETE FROM `command` WHERE `name` IN ('cfbg', 'cfbg race');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('cfbg', 0, 'Crossfaction battleground module commands.'),
('cfbg race', 0, 'Morphs your character to the selected race once you join a battleground.\nBy default, the following races are available: human, dwarf, gnome, draenei ("broken ones"), orc, bloodelf, troll, tauren.');

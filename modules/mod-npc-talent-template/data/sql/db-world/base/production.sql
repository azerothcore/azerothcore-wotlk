-- COMMAND
DELETE FROM `command` WHERE `name`='templatenpc reload';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('templatenpc reload', 3, 'Syntax: .templatenpc reload\nType .templatenpc reload to reload Template NPC database changes');

-- DB update 2026_05_31_00 -> 2026_05_31_01
--
-- Update `command` help text for .bf subcommands: #battleid is now optional
-- and defaults to 1 (Wintergrasp) when omitted.

DELETE FROM `command` WHERE `name` IN ('bf start', 'bf stop', 'bf switch', 'bf enable', 'bf timer', 'bf queue');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('bf start',  3, 'Syntax: .bf start [#battleid]\r\n#battleid is optional and defaults to 1 (Wintergrasp).'),
('bf stop',   3, 'Syntax: .bf stop [#battleid]\r\n#battleid is optional and defaults to 1 (Wintergrasp).'),
('bf switch', 3, 'Syntax: .bf switch [#battleid]\r\n#battleid is optional and defaults to 1 (Wintergrasp).'),
('bf enable', 3, 'Syntax: .bf enable [#battleid]\r\n#battleid is optional and defaults to 1 (Wintergrasp).'),
('bf timer',  3, 'Syntax: .bf timer [#battleid] #timer\r\n#battleid is optional and defaults to 1 (Wintergrasp).\r\n#timer: use a timestring like "1h15m30s".'),
('bf queue',  2, 'Syntax: .bf queue [#battleid]\r\nDisplays all players currently in queue, invited, or actively in war for the specified battlefield.\r\n#battleid is optional and defaults to 1 (Wintergrasp).');

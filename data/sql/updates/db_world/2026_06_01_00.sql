DELETE FROM `command` WHERE `name` = 'bf diagnostics';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('bf diagnostics', 3, 'Syntax: .bf diagnostics #battleid [on|off]\r\nShows or toggles diagnostic tracing for the specified battlefield.\r\n#battleid: the battle ID (1 for Wintergrasp).');

DELETE FROM `command` WHERE `name` IN ('bf diagnostics', 'bf diagnostics dump');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('bf diagnostics', 3, 'Syntax: .bf diagnostics #battleid [on|off]\r\nShows or toggles diagnostic tracing for the specified battlefield.\r\n#battleid: the battle ID (1 for Wintergrasp).'),
('bf diagnostics dump', 3, 'Syntax: .bf diagnostics dump #battleid\r\nClones the battlefield diagnostic buffer on the world thread and writes it asynchronously to LogsDir/diagnostics.\r\n#battleid: the battle ID (1 for Wintergrasp).');

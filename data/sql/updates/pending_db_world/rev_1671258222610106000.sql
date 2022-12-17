--
DELETE FROM `command` WHERE `name` IN ('bandelay', 'bandelay account', 'bandelay ip', 'kickdelay');
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('bandelay', 2, 'Syntax: .bandelay $subcommand\nType .bandelay to see the list of possible subcommands or .help bandelay $subcommand to see info on subcommands'),
('bandelay account', 2, 'Syntax: .bandelay account $Name $bantime $reason $min_time $max_time\r\nBan account kick player.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\".'),
('bandelay ip', 2, 'Syntax: .bandelay ip $Ip $bantime $reason $min_time $max_time\r\nBan IP.\r\n$bantime: negative value leads to permban, otherwise use a timestring like \"4d20h3s\".'),
('kickdelay', 2, 'Syntax: .kickdelay [$charactername] [$reason] [$min_time] [$max_time]\r\n\r\nKick the given character with delay name from the world with or without reason. If no character name is provided then the selected player (except for yourself) will be kicked. If no reason is provided, default is \"No Reason\".');
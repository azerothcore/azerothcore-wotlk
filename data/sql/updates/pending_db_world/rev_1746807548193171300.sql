--
DELETE FROM `command` WHERE `name`IN('debug boundary');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('debug boundary', 3, 'Syntax: .debug boundary [#fill] #duration\r\n\r\nFlood fills the targeted unit\'s movement boundary and marks the edge of said boundary with debug creatures.\nSpecify \'fill\' as first parameter to fill the entire area with debug creatures.');

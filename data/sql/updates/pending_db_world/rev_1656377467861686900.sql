--
DELETE FROM `command` WHERE `name` = 'debug play visual';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('debug play visual', 3, 'Syntax: .debug play visual #visualid\r\nPlay spell visual with #visualid.\n#visualid refers to the ID from SpellVisualKit.dbc');
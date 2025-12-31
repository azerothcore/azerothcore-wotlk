DELETE FROM `command` WHERE `name` IN
(
  'worldstate sunsreach counter',
  'worldstate sunsreach gatecounter',
  'worldstate sunsreach status'
);

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('worldstate sunsreach counter', 3,
'Syntax: .worldstate sunsreach counter <index> <value>\r\n\r\nSets a Suns Reach worldstate counter and displays current Suns Reach status.'),
('worldstate sunsreach gatecounter', 3,
'Syntax: .worldstate sunsreach gatecounter <index> <value>\r\n\r\nSets a Sunwell gate progression counter and displays current Suns Reach gate status.'),
('worldstate sunsreach status', 3,
'Syntax: .worldstate sunsreach status\r\n\r\nDisplays current Suns Reach and Sunwell gate progression status.');

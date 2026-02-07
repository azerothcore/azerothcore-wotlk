-- DB update 2026_02_06_09 -> 2026_02_07_05
DELETE FROM `command` WHERE `name` IN ('reload creature', 'reload gameobject');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload creature', 3, 'Syntax: .reload creature\nReload creature table.'),
('reload gameobject', 3, 'Syntax: .reload gameobject\nReload gameobject table.');

-- DB update 2025_05_30_06 -> 2025_05_30_07
--
DELETE FROM `command` WHERE `name` = 'group revive';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('group revive', 2, 'Syntax: .group revive\r\n\r\nRevives all players in your group.');

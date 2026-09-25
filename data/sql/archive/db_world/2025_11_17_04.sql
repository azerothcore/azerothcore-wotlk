-- DB update 2025_11_17_03 -> 2025_11_17_04
--
DELETE FROM `acore_string` WHERE `entry` IN (5088, 5089);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5088, 'Quest: {} ({}) \nStatus: {}'),
(5089, 'Quest can\'t be taken!');

DELETE FROM `command` WHERE `name` = 'quest status';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('quest status', 2, 'Syntax: .quest status $id [$name]. Displays the selected player\'s status for the specified quest.');

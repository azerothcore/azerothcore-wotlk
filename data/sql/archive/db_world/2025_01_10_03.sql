-- DB update 2025_01_10_02 -> 2025_01_10_03
--
DELETE FROM `acore_string` WHERE `entry` IN (5086, 5087);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5086, 'No doors found within range ({} yards).'),
(5087, 'Door {} (Entry: {}) opened!');

DELETE FROM `command` WHERE `name` = 'opendoor';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('opendoor', 1, 'Syntax: .opendoor [$range]\nOpens the nearest door within the range provided (default 5.0yd)');

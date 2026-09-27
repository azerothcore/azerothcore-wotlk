--
DELETE FROM `acore_string` WHERE `entry` BETWEEN 11023 AND 11031;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(11023, 'Character peak: {} (lifetime: {}).'),
(11024, 'Previous session ended with {} after {}.'),
(11025, 'Previous session ran {}.'),
(11026, 'Previous session ended unexpectedly after {}. Last seen alive {}.'),
(11027, 'Previous session ended unexpectedly during {} after {}. Last seen alive {}.'),
(11028, '|- Reason: {}'),
(11029, 'a shutdown'),
(11030, 'a restart'),
(11031, 'an error shutdown');

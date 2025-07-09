-- DB update 2025_06_29_03 -> 2025_06_30_00
--
DELETE FROM `acore_string` WHERE `entry` IN (6617, 6618);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(6617, 'GM Spectator is ON'),
(6618, 'GM Spectator is OFF');

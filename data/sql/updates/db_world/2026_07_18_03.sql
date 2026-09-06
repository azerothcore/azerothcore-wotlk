-- DB update 2026_07_18_02 -> 2026_07_18_03
DELETE FROM `command` WHERE `name`='group invites';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('group invites', 2, 'Syntax: .group invites on|off\r\nEnable/disable accepting group invites.');

-- acore_string entries for .groupinvites command.
DELETE FROM `acore_string` WHERE `entry` IN (35462, 35463, 35464);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35462, 'Accepting Group Invites: {}'),
(35463, 'Accepting Group Invites: ON'),
(35464, 'Accepting Group Invites: OFF');

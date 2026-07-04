DELETE FROM `command` WHERE `name`='group invites';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('group invites', 2, 'Syntax: .group invites on|off\r\nEnable/disable accepting group invites.');

-- acore_string entries for .groupinvites command.
DELETE FROM `acore_string` WHERE `entry` IN (35455, 35456, 35457);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35455, 'Accepting Group Invites: {}'),
(35456, 'Accepting Group Invites: ON'),
(35457, 'Accepting Group Invites: OFF');

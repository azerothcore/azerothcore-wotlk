--
DELETE FROM `command` WHERE `name` = 'gobject respawn';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('gobject respawn', 1, 'Syntax: .gobject respawn #guid./nRespawns the target gameobject.');

DELETE FROM `acore_string` WHERE `entry` = 5085;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5085, 'Object %s (entry :%u guid: %u) respawned!');

ALTER TABLE `gameobject_addon` ADD COLUMN `scale` FLOAT NOT NULL DEFAULT 0 AFTER `invisibilityValue`;

DELETE FROM `command` WHERE `name` = 'gobject set scale';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('gobject set scale', 2, 'Syntax: .gobject set scale #guid #scale\nSets the scale (0.1 to 10) of the gameobject spawn #guid, stores it in `gameobject_addon` and respawns the object at its new size.');

DELETE FROM `acore_string` WHERE `entry` = 35483;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35483, 'Game Object |cffffffff|Hgameobject:{}|h[{}]|h|r (GUID: {}) scaled to {}');

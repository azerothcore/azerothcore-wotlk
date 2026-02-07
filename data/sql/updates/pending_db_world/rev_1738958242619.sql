--
DELETE FROM `command` WHERE `name` IN ('reload creature', 'reload gameobject', 'npc load', 'gobject load');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc load', 3, 'Syntax: .npc load #spawnId\nLoad a creature spawn from the database into the world by its GUID.'),
('gobject load', 3, 'Syntax: .gobject load #spawnId\nLoad a gameobject spawn from the database into the world by its GUID.');

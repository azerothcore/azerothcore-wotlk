-- DB update 2026_02_08_00 -> 2026_02_08_01
--
DELETE FROM `command` WHERE `name` IN ('npc load', 'gobject load');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc load', 3, 'Syntax: .npc load #spawnId\nLoad a creature spawn from the database into the world by its GUID.'),
('gobject load', 3, 'Syntax: .gobject load #spawnId\nLoad a gameobject spawn from the database into the world by its GUID.');

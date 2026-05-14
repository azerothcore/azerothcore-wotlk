-- DB update 2026_05_09_00 -> 2026_05_14_00
--
-- RBAC permissions for `respawn creature guid`, `respawn gameobject guid`,
-- `respawn creature entry`, and `respawn gameobject entry` commands (Console::Yes/No, security level 3 - GM)
--
DELETE FROM `rbac_permissions` WHERE `id` IN (916, 917, 918, 919);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(916, 'Command: respawn creature guid'),
(917, 'Command: respawn gameobject guid'),
(918, 'Command: respawn creature entry'),
(919, 'Command: respawn gameobject entry');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` IN (916, 917, 918, 919);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 916),
(197, 917),
(197, 918),
(197, 919);

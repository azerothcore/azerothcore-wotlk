-- DB update 2026_05_01_00 -> 2026_05_03_00
-- RBAC permissions for .pet list (sec 1+, Mod role 198) and .pet delete (sec 3+, Admin role 196).
DELETE FROM `rbac_permissions` WHERE `id` IN (914, 915);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(914, 'Command: pet list'),
(915, 'Command: pet delete');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` IN (914, 915);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(198, 914),
(196, 915);

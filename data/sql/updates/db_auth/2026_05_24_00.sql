-- DB update 2026_05_17_00 -> 2026_05_24_00
-- RBAC permission for .pet rename (sec 3+, Admin role 196).
DELETE FROM `rbac_permissions` WHERE `id` = 922;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(922, 'Command: pet rename');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 922;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 922);

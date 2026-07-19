-- DB update 2026_07_18_00 -> 2026_07_18_01
DELETE FROM `rbac_permissions` WHERE `id` = 940;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(940, 'Command: group invites');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 940;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 940);

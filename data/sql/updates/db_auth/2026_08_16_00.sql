-- DB update 2026_07_22_00 -> 2026_08_16_00
DELETE FROM `rbac_permissions` WHERE `id` = 945;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(945, 'Command: account info');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 945;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 945);

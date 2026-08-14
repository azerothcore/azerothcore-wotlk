DELETE FROM `rbac_permissions` WHERE `id` = 945;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(945, 'Command: account info');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 945;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 945);

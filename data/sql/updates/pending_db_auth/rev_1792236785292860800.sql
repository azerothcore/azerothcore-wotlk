DELETE FROM `rbac_permissions` WHERE `id` = 946;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(946, 'Command: gobject set scale');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 946;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 946);

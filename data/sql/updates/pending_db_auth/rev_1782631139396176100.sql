DELETE FROM `rbac_permissions` WHERE `id` = 926;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(926, 'Command: group invites');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 926;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 926);

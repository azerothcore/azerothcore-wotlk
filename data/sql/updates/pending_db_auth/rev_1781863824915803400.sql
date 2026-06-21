DELETE FROM `rbac_permissions` WHERE `id` IN (926, 927, 928, 929);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(926, 'Command: account flag'),
(927, 'Command: account flag list'),
(928, 'Command: account flag add'),
(929, 'Command: account flag remove');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` IN (926, 927, 928, 929);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 926),
(197, 927),
(196, 928),
(196, 929);

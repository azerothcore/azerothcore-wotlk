DELETE FROM `rbac_permissions` WHERE `id` IN (941, 942, 943, 944);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(941, 'Command: account flag'),
(942, 'Command: account flag list'),
(943, 'Command: account flag add'),
(944, 'Command: account flag remove');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` IN (941, 942, 943, 944);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 941),
(197, 942),
(196, 943),
(196, 944);

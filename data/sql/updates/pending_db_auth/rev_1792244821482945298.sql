-- RBAC permissions for the voice chat commands (previously SEC_ADMINISTRATOR).
DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 946 AND 949;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(946, 'Command: voicechat disconnect'),
(947, 'Command: voicechat disable'),
(948, 'Command: voicechat enable'),
(949, 'Command: voicechat stats');

-- Link each command permission to its role: 196 = Administrator role.
DELETE FROM `rbac_linked_permissions` WHERE `id` = 196 AND `linkedId` BETWEEN 946 AND 949;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 946),
(196, 947),
(196, 948),
(196, 949);

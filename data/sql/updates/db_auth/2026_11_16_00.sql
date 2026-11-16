-- DB update 2026_10_15_00 -> 2026_11_16_00
DELETE FROM `rbac_permissions` WHERE `id` = 946;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(946, 'Command: instance bind');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 946;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 946);

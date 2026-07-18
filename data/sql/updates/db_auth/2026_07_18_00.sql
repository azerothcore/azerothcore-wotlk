-- DB update 2026_07_15_00 -> 2026_07_18_00
--
DELETE FROM `rbac_permissions` WHERE `id` = 939;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(939, 'Command: server set security');

DELETE FROM `rbac_linked_permissions` WHERE `id` = 196 AND `linkedId` = 939;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 939);

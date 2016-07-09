DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 1004;
DELETE FROM `rbac_permissions`  WHERE `id` = 1004;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES (1004,'PVP Custom Commands');
INSERT INTO `rbac_linked_permissions` (`id`,`linkedId`) VALUES (195,1004);

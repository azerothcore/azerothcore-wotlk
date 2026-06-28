-- Issue #18038: RBAC permission for .npc showloot (sec 2+, GM role 197).
DELETE FROM `rbac_permissions` WHERE `id` = 865;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(865, 'Command: npc showloot');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 865;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 865);

--
-- RBAC permission for .reload spell_gameobject_faction (sec 3+, Admin role 196).
DELETE FROM `rbac_permissions` WHERE `id` = 923;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(923, 'Command: reload spell_gameobject_faction');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 923;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 923);

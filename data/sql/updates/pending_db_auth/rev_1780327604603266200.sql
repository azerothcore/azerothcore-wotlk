--
DELETE FROM `rbac_permissions` WHERE `id` IN (923, 924, 925);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(923, 'Command: filteredwords list'),
(924, 'Command: filteredwords add'),
(925, 'Command: filteredwords remove');

DELETE FROM `rbac_linked_permissions` WHERE `id` = 197 AND `linkedId` IN (923, 924, 925);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 923),
(197, 924),
(197, 925);

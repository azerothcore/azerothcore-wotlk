-- DB update 2026_11_16_00 -> 2026_11_22_00
DELETE FROM `rbac_permissions` WHERE `id` = 54;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(54, 'Summon non-GM players into instances');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 54;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(192, 54);

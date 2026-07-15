-- RBAC permissions for core commands migrated off deprecated GM security levels.
DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 926 AND 938;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(926, 'Command: autobroadcast list'),
(927, 'Command: autobroadcast add'),
(928, 'Command: autobroadcast locale'),
(929, 'Command: autobroadcast remove'),
(930, 'Command: mail list'),
(931, 'Command: mail return'),
(932, 'Command: npc load'),
(933, 'Command: pool info'),
(934, 'Command: pool lookup'),
(935, 'Command: spellinfo attributes'),
(936, 'Command: spellinfo effects'),
(937, 'Command: spellinfo targets'),
(938, 'Command: spellinfo all');

-- Link each command permission to its role: 196 = Administrator role, 197 = Gamemaster role.
DELETE FROM `rbac_linked_permissions` WHERE `linkedId` BETWEEN 926 AND 938;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(197, 926),
(196, 927),
(196, 928),
(196, 929),
(197, 930),
(197, 931),
(196, 932),
(197, 933),
(197, 934),
(197, 935),
(197, 936),
(197, 937),
(197, 938);

--
-- RBAC permissions for spell gameobject faction commands.
-- 923: .reload spell_gameobject_faction           (Admin, role 196)
-- 924: .spell gobject faction add                 (Admin, role 196)
-- 925: .spell gobject faction remove              (Admin, role 196)
-- 926: .spell gobject faction list                (Moderator, role 198)
-- 927: .spell gobject faction update              (Admin, role 196)
DELETE FROM `rbac_permissions` WHERE `id` IN (923, 924, 925, 926, 927);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(923, 'Command: reload spell_gameobject_faction'),
(924, 'Command: spell gobject faction add'),
(925, 'Command: spell gobject faction remove'),
(926, 'Command: spell gobject faction list'),
(927, 'Command: spell gobject faction update');

DELETE FROM `rbac_linked_permissions` WHERE `id` = 196 AND `linkedId` IN (923, 924, 925, 927);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 923),
(196, 924),
(196, 925),
(196, 927);

DELETE FROM `rbac_linked_permissions` WHERE `id` = 198 AND `linkedId` = 926;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(198, 926);

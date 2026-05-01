-- DB update 2026_05_01_00 -> 2026_05_01_01
-- RBAC command help strings
DELETE FROM `acore_string` WHERE `entry` BETWEEN 83 AND 86;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(83, 'Syntax: .rbac account list $account\nList granted, denied, and inherited permissions for the account.'),
(84, 'Syntax: .rbac account grant $account $permissionId [$realmId]\nGrant a permission to the account. Optional realmId (-1 = all realms).'),
(85, 'Syntax: .rbac account deny $account $permissionId [$realmId]\nDeny a permission for the account. Optional realmId (-1 = all realms).'),
(86, 'Syntax: .rbac account revoke $account $permissionId [$realmId]\nRevoke a previously granted or denied permission. Optional realmId (-1 = all realms).');

-- Update inherited permissions header to include sec level name
DELETE FROM `acore_string` WHERE `entry` = 67;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(67, 'Account {} ({}) inherited permissions by sec level {} ({}):');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625800134455204000');

DELETE FROM `command` WHERE `name` LIKE '%rbac%';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('rbac list', 4, 'Syntax: rbac list [$id]\n\nView list of all permissions. If $id is given will show only info for that permission.'),
('rbac account revoke', 4, 'Syntax: rbac account revoke [$account] #id\n\nRemove a permission from an account\n\nNote: Removes the permission from granted or denied permissions'),
('rbac account deny', 4, 'Syntax: rbac account deny [$account] #id [#realmId]\n\nDeny a permission to selected player or given account.\n\n#reamID may be -1 for all realms.'),
('rbac account grant', 4, 'Syntax: rbac account grant [$account] #id [#realmId]\n\nGrant a permission to selected player or given account.\n\n#reamID may be -1 for all realms.'),
('rbac account list', 4, 'Syntax: rbac account list [$account]\n\nView permissions of selected player or given account\nNote: Only those that affect current realm'),
('reload rbac', 3, 'Syntax: .reload rbac\nReload rbac system.'),
('rbac', 3, 'Syntax: bf $subcommand\n Type .rbac to see a list of possible subcommands\n or .help bf $subcommand to see info on the subcommand.'),
('rbac account', 3, 'Syntax: rbac account $subcommand\n Type .rbac account to see a list of possible subcommands\n or .help rbac account $subcommand to see info on the subcommand.');

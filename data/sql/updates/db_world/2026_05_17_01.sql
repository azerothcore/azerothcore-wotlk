-- DB update 2026_05_17_00 -> 2026_05_17_01
DELETE FROM `command` WHERE `name` IN ('debug combat','debug threatinfo','pdump copy','pet delete','pet list','rbac list','reload rbac');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug combat',3,'Syntax: .debug combat\nLists PvP and PvE combat references of the selected unit (or self).'),
('debug threatinfo',3,'Syntax: .debug threatinfo\nDisplays various debug information about the target''s threat state, modifiers, redirects and similar.'),
('pdump copy',3,'Syntax: .pdump copy $playerNameOrGUID $account [$newname] [$newguid]\nCopy character with name/guid $playerNameOrGUID into character list of $account with $newname, with first free or $newguid guid.'),
('pet delete',3,'Syntax: .pet delete $playerNameOrGUID #petNumber\nDeletes the pet with the given pet number belonging to the specified player.'),
('pet list',1,'Syntax: .pet list $playerNameOrGUID\nLists all pets owned by the specified player (id, entry, level, slot, name, type).'),
('rbac list',3,'Syntax: .rbac list [#id]\nView list of all permissions. If #id is given will show only info for that permission.'),
('reload rbac',3,'Syntax: .reload rbac\nReload rbac system.');

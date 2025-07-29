--
DELETE FROM `command` WHERE `name` = 'account flag';
DELETE FROM `command` WHERE `name` = 'account flag add';
DELETE FROM `command` WHERE `name` = 'account flag remove';
DELETE FROM `command` WHERE `name` = 'account flag list';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('account flag', 4, 'Syntax: .account flag'),
('account flag add', 4, 'Syntax: .account flag add #flag [$player_name/#GUID]\nAdd an account flag to the specified player, target or self.'),
('account flag remove', 4, 'Syntax: .account flag remove #flag [$player_name/#GUID]\nRemove an account flag from the specified player, target or self.'),
('account flag list', 4, 'Syntax: .account flag list [$player_name/#GUID]\nList all account flags on the specified player, target or self.');

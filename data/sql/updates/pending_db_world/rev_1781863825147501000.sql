DELETE FROM `command` WHERE `name` IN ('account flag', 'account flag list', 'account flag add', 'account flag remove');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('account flag', 2, 'Syntax: .account flag $subcommand\nType .account flag to see the list of possible subcommands or .help account flag $subcommand to see info on subcommands.'),
('account flag list', 2, 'Syntax: .account flag list [$account]\nLists every AccountFlag currently set on $account. Defaults to your own account when no argument is given.'),
('account flag add', 3, 'Syntax: .account flag add $account $flag\nSets an AccountFlag on $account. $flag is a symbolic name in either its full form (e.g. ACCOUNT_FLAG_TRIAL) or short form (e.g. TRIAL). ACCOUNT_FLAG_GM is managed automatically and cannot be changed manually.'),
('account flag remove', 3, 'Syntax: .account flag remove $account $flag\nClears an AccountFlag on $account. $flag is a symbolic name in either its full form (e.g. ACCOUNT_FLAG_TRIAL) or short form (e.g. TRIAL). ACCOUNT_FLAG_GM is managed automatically and cannot be changed manually.');

DELETE FROM `acore_string` WHERE `entry` IN (35455, 35456, 35457, 35458, 35459, 35460);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35455, 'Account flags set on {} ({}):'),
(35456, 'Account {} ({}) has no flags set.'),
(35457, 'Unknown account flag: {}. Use a symbolic name (e.g. ACCOUNT_FLAG_TRIAL or TRIAL).'),
(35458, 'ACCOUNT_FLAG_GM is managed automatically and cannot be changed manually.'),
(35459, 'Added {} to account {} ({}).'),
(35460, 'Removed {} from account {} ({}).');

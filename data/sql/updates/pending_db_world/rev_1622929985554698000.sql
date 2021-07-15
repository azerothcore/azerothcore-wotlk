INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622929985554698000');

DELETE FROM `acore_string` WHERE `entry` BETWEEN 1500 AND 1515;
DELETE FROM `acore_string` WHERE `entry` IN (6, 7, 8, 191, 192, 193, 194, 195, 196);
INSERT INTO `acore_string` (`entry`,`content_default`) VALUES
(  6, 'Command \'%.*s\' does not exist'),
(  7, 'Subcommand \'%.*s%c%.*s\' is ambiguous:'),
(  8, 'Possible subcommands:'),
(191, '|- %.*s'),
(192, '|- %.*s ...'),
(193, 'Subcommand \'%.*s%c%.*s\' does not exist.'),
(194, 'Command \'%.*s\' is ambiguous:'),
(195, '### USAGE: .%.*s ...'),
(196, 'There is no detailed usage information associated with \'%.*s\'.
This should never occur for stock WarheadCore commands - if it does, report this as a bug.
If this is a custom command, use `acore_string` to specify it. Look at cs_achievement.cpp for example usage.'),
(1500, 'Either:'),
(1501, 'Or:    '),
(1502, 'Value \'%.*s\' is not valid for type %s.'),
(1503, 'Invalid UTF-8 sequences found in string.'),
(1504, 'Provided link has invalid link data.'),
(1505, 'Account \'%.*s\' does not exist.'),
(1506, 'Account ID %u does not exist.'),
(1507, '%s does not exist.'),
(1508, 'Character \'%.*s\' does not exist.'),
(1509, '\'%.*s\' is not a valid character name.'),
(1510, 'Achievement ID %u does not exist.'),
(1511, 'Teleport location %u does not exist.'),
(1512, 'Teleport location \'%.*s\' does not exist.'),
(1513, 'Item ID %u does not exist.'),
(1514, 'Spell ID %u does not exist.'),
(1515, 'Expected \'%.*s\', got \'%.*s\' instead.');
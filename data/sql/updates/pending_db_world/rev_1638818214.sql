INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638818214');

-- Command: Move ".itemmove" to ".item move"
UPDATE `command` SET `name`='item move' WHERE `name`='itemmove';

-- Add new command: ".item restore"
DELETE FROM `command` WHERE `name` = 'item restore';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore', '2', 'Syntax: .item restore [#recoveryItemId] [#playername]\r\n\r\nRestore an disposed item for the specified player. Get recoveryId from ".item restore list" command.');

-- Add new command: ".item restore list"
DELETE FROM `command` WHERE `name` = 'item restore list';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore list', '2', 'Syntax: .item restore list [#playername]\r\n\r\nSee restorable items for the specified player.');

-- Add new string: "LANG_COMMAND_DISABLED"
DELETE FROM `acore_string` WHERE `entry` = 5070;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (5070, 'The command is disabled by config');

-- Add new string: "LANG_ITEM_RESTORE_LIST"
DELETE FROM `acore_string` WHERE `entry` = 197;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (197, 'Recover id: %u | Item: %s (%u) | Count: %u');

-- Add new string: "LANG_ITEM_RESTORE_LIST_EMPTY"
DELETE FROM `acore_string` WHERE `entry` = 198;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (198, 'Player has no recoverable items');

-- Add new string: "LANG_ITEM_RESTORE_MISSING"
DELETE FROM `acore_string` WHERE `entry` = 199;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (199, 'Player has no recoverable item with id %u');

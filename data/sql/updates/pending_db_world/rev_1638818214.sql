INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638818214');

-- Command: Move ".itemmove" to ".item move"
UPDATE `command` SET `name`='item move' WHERE `name`='itemmove';

-- Add new command: ".item restore"
DELETE FROM `command` WHERE `name` = 'item restore';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore', '2', 'Syntax: .item restore #itemID/[#itemName]/#itemLink [#playername]\r\n\r\nRestore an disposed item for the specified player.');

-- Add new command: ".item restore list"
DELETE FROM `command` WHERE `name` = 'item restore list';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore list', '2', 'Syntax: .item restore list [#playername]\r\n\r\nSee restorable items for the specified player.');

-- Add new string: "LANG_COMMAND_DISABLED"
DELETE FROM `acore_string` WHERE `entry` = 5070;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (5070, 'The command is disabled by config');

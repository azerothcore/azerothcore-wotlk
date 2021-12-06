INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638818214');

-- Command: Move ".itemmove" to ".item move"
UPDATE `command` SET `name`='item move' WHERE `name`='itemmove';

-- Add new command: ".item restore"
DELETE FROM `command` WHERE `name` = 'item restore';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore', '2', 'Syntax: .item restore #itemID/[#itemName]/#itemLink [#playername]\r\n\r\nRestore an disposed item for the specified player.');

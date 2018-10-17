INSERT INTO version_db_world (`sql_rev`) VALUES ('1537827596332623300');
DELETE FROM `command` WHERE `name`='go gobject';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('go gobject', 1, 'Syntax: .go object #gameobject_guid\r\nTeleport your character to gameobject with guid #gameobject_guid');
DELETE FROM `command` WHERE `name`='list gobject';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('list gobject', 1, 'Syntax: .list object #gameobject_id [#max_count]\r\n\r\nOutput gameobjects with gameobject id #gameobject_id found in world. Output gameobject guids and coordinates sorted by distance from character. Will be output maximum #max_count gameobject. If #max_count not provided use 10 as default value.');
DELETE FROM `command` WHERE `name`='lookup gobject';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('lookup gobject', 1, 'Syntax: .lookup object $objname\r\n\r\nLooks up an gameobject by $objname, and returns all matches with their Gameobject ID\'s.');

-- Add deprecated notice
UPDATE `command` SET `help` = '[DEPRECATED]: use ".go gobject" instead.\r\nSyntax: .go object #object_guid\r\nTeleport your character to gameobject with guid #object_guid'
WHERE `name` = 'go object' COLLATE utf8mb4_bin;

UPDATE `command` SET `help` = '[DEPRECATED]: use ".lookup gobject" instead.\r\nSyntax: .go object #object_guid\r\nTeleport your character to gameobject with guid #object_guid'
WHERE `name` = 'lookup object' COLLATE utf8mb4_bin;

UPDATE `command` SET `help` = '[DEPRECATED]: use ".list gobject" instead.\r\nSyntax: .go object #object_guid\r\nTeleport your character to gameobject with guid #object_guid'
WHERE `name` = 'list object' COLLATE utf8mb4_bin;

--
DELETE FROM `command` WHERE `name` IN ("go gameobject", "go gameobject id");
INSERT INTO `command` (`name`, `security`, `help`) VALUES
("go gameobject", 1, "Syntax: .go gameobject $gameobject.guid\r\nTeleports you to the gameobject using `guid` value of `gameobject` table."),
("go gameobject id", 1, "Syntax: .go gameobject id $gameobject_template.entry \r\nTeleports you to a gameobject using the `entry` value of `gameobject_template` table. \r\nIn the case of multiple objects of the same `entry(id)` existing in the world, you will be teleported to the lowest `guid` object.");

UPDATE `command` SET `help` = "Syntax: .go creature $creature.guid \r\nTeleports you to the creature using `guid` value of `creature` table." WHERE `name` LIKE "go creature";
UPDATE `command` SET `help` = "Syntax: .go creature id $creature_template.entry \r\nTeleports you to a creature using the `entry` value of `creature_template` table. \r\nIn the case of multiple creature of the same `entry(id1)` existing in the world, you will be teleported to the lowest `guid` creature." WHERE `name` LIKE "go creature id";
UPDATE `command` SET `help` = "Syntax: .go creature name $creature_template.name \r\nTeleports you to a creature using the `name` value of `creature_template` table. \r\nIn the case of multiple creature of the same `name` existing in the world, you will be teleported to the lowest `guid` creature.\r\nWhen running the command for names with spaces don't break the string, example: .go creature name Ruby Scalebane" WHERE `name` LIKE "go creature name";
UPDATE `command` SET `help` = "Syntax: .group revive $characterName \r\nRevives all group members of the given character or self if not provided." WHERE `name` LIKE "group revive";

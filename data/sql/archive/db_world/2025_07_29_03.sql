-- DB update 2025_07_29_02 -> 2025_07_29_03
--
DELETE FROM `command` WHERE `name` = "go gameobject";
INSERT INTO `command` (`name`, `security`, `help`) VALUES
("go gameobject", 1, "Syntax: .go gameobject $gameobject.guid\r\nTeleports you to the gameobject using `guid` value of `gameobject` table.");

UPDATE `command` SET `help` = "Syntax: .go creature $creature.guid \r\nTeleports you to the creature using `guid` value of `creature` table." WHERE `name` LIKE "go creature";
UPDATE `command` SET `help` = "Syntax: .go creature name $creature_template.name \r\nTeleports you to a creature using the `name` value of `creature_template` table. \r\nIn the case of multiple creature of the same `name` existing in the world, you will be teleported to the lowest `guid` creature.\r\nWhen running the command for names with spaces don't break the string, example: .go creature name Ruby Scalebane" WHERE `name` LIKE "go creature name";
UPDATE `command` SET `help` = "Syntax: .group revive $characterName \r\nRevives all group members of the given character or self if not provided." WHERE `name` LIKE "group revive";

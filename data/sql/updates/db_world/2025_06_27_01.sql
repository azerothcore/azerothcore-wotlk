-- DB update 2025_06_27_00 -> 2025_06_27_01
--
DELETE FROM `acore_string` WHERE `entry` = 288;
INSERT INTO `acore_string` (`entry`,`content_default`) VALUES (288,'Cannot go to spawn {} as only {} exist');

UPDATE `command` SET `help`='Syntax: .go creature id #creature_entry [#spawn] Teleports you to first (if no #spawn provided) spawn the given creature entry. ' WHERE `name` = 'go creature id';

DELETE FROM `command` WHERE `name` = 'go gameobject id';
INSERT INTO `command` VALUES('go gameobject id',1,'Syntax: .go gameobject id #gameobject_entry [#spawn] Teleports you to first (if no #spawn provided) spawn the given gameobject entry.');

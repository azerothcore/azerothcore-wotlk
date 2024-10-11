-- DB update 2022_07_20_02 -> 2022_07_20_03
--
DELETE FROM `command` WHERE `name` = 'npc guid';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('npc guid', 1, 'Syntax: .npc guid\r\n\r\nDisplays GUID, faction, NPC flags, Entry ID, Model ID for selected creature.');

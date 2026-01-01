-- DB update 2025_12_31_01 -> 2026_01_01_00
--
DELETE FROM `acore_string` WHERE `entry` = 603;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(603, 'Do Action performed on [GUID: {}, entry: {}, name: {}] Action: {}');

DELETE FROM `command` WHERE `name` = 'npc do';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc do', 3, 'Syntax: .npc do $action\nRequests the NPC to perform DoAction with the specified ActionID. Used for testing scripts.');

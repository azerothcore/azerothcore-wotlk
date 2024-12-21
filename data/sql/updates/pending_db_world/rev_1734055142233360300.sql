--
DELETE FROM `command` where `name` = 'reload game_event_npc_vendor';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('reload game_event_npc_vendor', 3, 'Syntax: .reload game_event_npc_vendor\r Reload game_event_npc_vendor table.');

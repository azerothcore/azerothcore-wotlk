-- DB update 2026_01_01_02 -> 2026_01_01_03
DELETE FROM `command` WHERE `name` IN ('list auras id', 'list auras name', 'account remove country', 'debug mapdata', 'debug visibilitydata', 'event info');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('list auras id', 1, 'Syntax: .list auras id\n\nLists all active auras on the selected unit by spell ID.'),
('list auras name', 1, 'Syntax: .list auras name\n\nLists all active auras on the selected unit by spell name.'),
('account remove country', 3, 'Syntax: .account remove country <account>\n\nRemoves the country information associated with the specified account.'),
('debug mapdata', 3, 'Syntax: .debug mapdata\n\nDisplays debug information about the current map.'),
('debug visibilitydata', 3, 'Syntax: .debug visibilitydata\n\nDisplays debug information related to object visibility around the player.'),
('event info', 2, 'Syntax: .event info [event_id]\n\nDisplays information about game events.');

DELETE FROM `command` WHERE `name` IN ('instance stats', 'cheat status','gm spectator','gm on','gm off','debug unitstate');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('instance stats', 1, 'Syntax: .instance stats\n\nShows statistics about instances.'),
('cheat status', 2, 'Syntax: .cheat status\n\nShows the cheats you currently have enabled.'),
('gm spectator', 2, 'Syntax: .gm spectator on|off\n\nRequires .gm on. Allows the GM character to follow members of the opposite faction. You may need to change zones for the effect to apply.'),
('gm on', 1, 'Syntax: .gm on\n\nTurns on GM flag.'),
('gm off', 1, 'Syntax: .gm off\n\nTurns off GM flag.'),
('debug unitstate', 3, 'Syntax: .debug unitstate [#unitstate]\n\nSets the unit state for the selected unit or displays current unit and react state.');


DELETE FROM `command` WHERE `name` IN ('reload reputation_spillover_template','reload reputation_reward_rate','reload quest_offer_reward_locale','reload quest_request_item_locale','reload antidos_opcode_policies','reload areatrigger','reload profanity_name','reload warden_action');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload reputation_spillover_template', 3,'Syntax: .reload reputation_spillover_template\n\nReloads reputation_spillover_template table.'),
('reload reputation_reward_rate', 3,'Syntax: .reload reputation_reward_rate\n\nReloads reputation_reward_rate table.'),
('reload quest_offer_reward_locale', 3,'Syntax: .reload quest_offer_reward_locale\n\nReloads quest_offer_reward_locale table.'),
('reload quest_request_item_locale', 3,'Syntax: .reload quest_request_item_locale\n\nReloads quest_request_item_locale table.'),
('reload antidos_opcode_policies', 3,'Syntax: .reload antidos_opcode_policies\n\nReloads antidos_opcode_policies table.'),
('reload areatrigger', 3,'Syntax: .reload areatrigger\n\nReloads areatrigger table.'),
('reload profanity_name', 3,'Syntax: .reload profanity_name\n\nReloads profanity_name table.'),
('reload warden_action', 3,'Syntax: .reload warden_action\n\nReloads warden_action table.');

DELETE FROM `command` WHERE `name` IN('worldstate sunsreach counter','worldstate sunsreach gatecounter','worldstate sunsreach status');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('worldstate sunsreach counter', 3, 'Syntax: .worldstate sunsreach counter <index> <value>\n\nSets a Suns Reach worldstate counter and displays current Suns Reach status.'),
('worldstate sunsreach gatecounter', 3, 'Syntax: .worldstate sunsreach gatecounter <index> <value>\n\nSets a Sunwell gate progression counter and displays current Suns Reach gate status.'),
('worldstate sunsreach status', 3, 'Syntax: .worldstate sunsreach status\n\nDisplays current Suns Reach and Sunwell gate progression status.');

UPDATE `command` SET `security` = 3
WHERE `name` IN ('account set email', 'account set gmlevel', 'account set password');

UPDATE `command` SET `security` = 2
WHERE `name` IN
('bm', 'cache info', 'cache refresh', 'gobject respawn', 'guild rename','npc guid', 'npc info', 'npc move', 'opendoor', 'teleport');

UPDATE `command` SET `security` = 1
WHERE `name` = 'commentator';

UPDATE `command` SET `security` = 3
WHERE `name` IN
('debug hostile', 'debug play cinematic', 'debug play movie','debug play sound');

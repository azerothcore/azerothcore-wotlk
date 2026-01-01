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

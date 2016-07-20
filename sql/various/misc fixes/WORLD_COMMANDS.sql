INSERT INTO command VALUES
('commands', 0, ''),
('dismount', 0, ''),
('help', 0, ''),
('server info', 0, ''),
('server motd', 0, ''),
('spect', 0, ''),
('spect leave', 0, ''),
('spect reset', 0, ''),
('spect spectate', 0, ''),
('spect version', 0, ''),
('spect watch', 0, '')
ON DUPLICATE KEY UPDATE security=0;

UPDATE command SET security=2 WHERE security AND security<2;
INSERT INTO command VALUES
('gm', 1, ''),
('gm visible', 1, ''),
('gm fly', 1, ''),
('go', 1, ''),
('go xyz', 1, ''),
('gps', 1, ''),
('appear', 1, ''),
('modify', 1, ''),
('modify speed', 1, ''),
('modify speed all', 1, ''),
('tele', 1, ''),
('skirmish', 1, '')
ON DUPLICATE KEY UPDATE security=1;

INSERT INTO command VALUES
('list creature', 4, ''),
('list item', 4, ''),
('list object', 4, ''),
('pdump load', 4, ''),
('pdump write', 4, ''),
('pdump', 4, ''),
('reload all quest', 4, ''),
('reload all npc', 4, ''),
('reload all loot', 4, ''),
('reload all item', 4, ''),
('reload all locales', 4, ''),
('reload all gossips', 4, ''),
('reload all', 4, ''),
('reset all', 4, ''),
('reset achievements', 4, ''),
('reset level', 4, ''),
('reset spells', 4, ''),
('reset stats', 4, ''),
('server exit', 4, ''),
('server idlerestart', 4, ''),
('server idleshutdown', 4, ''),
('server set loglevel', 4, ''),
('achievement add', 4, ''),
('server togglequerylog', 4, ''),
('debug send', 4, ''),
('debug send buyerror', 4, ''),
('debug send channelnotify', 4, ''),
('debug send chatmmessage', 4, ''),
('debug send equiperror', 4, ''),
('debug send largepacket', 4, ''),
('debug send opcode', 4, ''),
('debug send qpartymsg', 4, ''),
('debug send qinvalidmsg', 4, ''),
('debug send sellerror', 4, ''),
('debug send setphaseshift', 4, ''),
('debug send spellfail', 4, ''),
('learn', 4, ''),
('learn all', 4, ''),
('learn all my', 4, ''),
('learn all my talents', 4, ''),
('learn all my spells', 4, ''),
('learn all my pettalents', 4, ''),
('learn all my class', 4, ''),
('learn all gm', 4, ''),
('learn all default', 4, ''),
('learn all crafts', 4, ''),
('learn all recipes', 4, ''),
('pet learn', 4, ''),
('unlearn', 4, ''),
('aura', 4, ''),
('gobject add', 4, ''),
('gobject add temp', 4, ''),
('npc add move', 4, ''),
('npc add item', 4, ''),
('npc add formation', 4, ''),
('npc add', 4, ''),
('npc add temp', 4, ''),
('wp add', 4, ''),
('npc set phase', 4, ''),
('npc set movetype', 4, ''),
('npc set model', 4, ''),
('npc set link', 4, ''),
('npc move', 4, ''),
('npc set flag', 4, ''),
('npc set factionid', 4, ''),
('npc set level', 4, ''),
('npc delete', 4, ''),
('npc delete item', 4, ''),
('npc set spawndist', 4, ''),
('npc set spawntime', 4, ''),
('npc set allowmove', 4, ''),
('npc set entry', 4, ''),
('npc set data', 4, ''),
('debug arena', 4, ''),
('debug bg', 4, ''),
('flusharenapoints', 4, ''),
('linkgrave', 4, ''),
('wpgps', 4, ''),
('possess', 4, ''),
('server set closed', 4, ''),
('server set motd', 4, ''),
('event start', 4, ''),
('event stop', 4, ''),
('gobject move', 4, ''),
('gobject set phase', 4, ''),
('gobject turn', 4, ''),
('honor update', 4, ''),
('morph', 4, ''),
('pet create', 4, ''),
('character changefaction', 4, ''),
('character changerace', 4, ''),
('character customize', 4, ''),
('modify faction', 4, ''),
('cometome', 4, ''),
('saveall', 4, ''),
('save', 4, ''),
('banlist', 4, ''),
('banlist account', 4, ''),
('banlist character', 4, ''),
('banlist ip', 4, ''),
('ban playeraccount', 4, ''),
('unban playeraccount', 4, ''),
('debug areatriggers', 4, ''),
('debug Mod32Value', 4, ''),
('debug setvalue', 4, ''),
('debug setbit', 4, ''),
('debug setaurastate', 4, ''),
('debug spawnvehicle', 4, ''),
('debug setvid', 4, ''),
('debug update', 4, ''),
('honor', 4, ''),
('honor add', 4, ''),
('honor add kill', 4, ''),
('modify honor', 4, ''),
('modify arenapoints', 4, ''),
('modify spell', 4, ''),
('modify gender', 4, ''),
('send items', 4, ''),
('send money', 4, ''),
('bf', 4, ''),
('bf start', 4, ''),
('bf stop', 4, ''),
('bf enable', 4, ''),
('bf switch', 4, ''),
('bf timer', 4, ''),
('lfg', 4, ''),
('lfg player', 4, ''),
('lfg group', 4, ''),
('lfg queue', 4, ''),
('lfg clean', 4, ''),
('lfg options', 4, ''),
('playall', 4, '')
ON DUPLICATE KEY UPDATE security=4;


INSERT INTO command VALUES
('guild invite', 3, ''),
('guild rank', 3, ''),

('quest add', 3, ''),

('server restart', 3, ''),
('server restart cancel', 3, ''),
('server shutdown', 3, ''),
('server shutdown cancel', 3, ''),

('reset honor', 3, ''),
('modify money', 3, ''),
('modify talentpoints', 3, '')
ON DUPLICATE KEY UPDATE security=3;


INSERT INTO command VALUES
('recall', 2, ''),
('summon', 2, ''),

('npc follow', 2, ''),
('npc follow stop', 2, ''),

('ban', 2, ''),
('ban account', 2, ''),
('ban character', 2, ''),
('ban ip', 2, ''),
('baninfo', 2, ''),
('baninfo account', 2, ''),
('baninfo character', 2, ''),
('baninfo ip', 2, ''),
('unban', 2, ''),
('unban account', 2, ''),
('unban character', 2, ''),
('unban ip', 2, ''),

('instance', 2, ''),
('instance unbind', 2, ''),
('modify phase', 2, ''),

('achievement', 2, ''),
('achievement checkall', 2, ''),

('quest', 2, ''),
('quest remove', 2, ''),
('quest complete', 2, ''),
('lookup', 2, ''),
('lookup player', 2, ''),
('lookup player account', 2, ''),
('lookup player email', 2, ''),
('lookup player ip', 2, ''),
('lookup quest', 2, ''),
('lookup title', 2, ''),
('lookup faction', 2, ''),
('lookup item', 2, ''),
('lookup skill', 2, ''),
('lookup spell', 2, ''),
('lookup spell id', 2, ''),

('die', 2, ''),
('unaura', 2, ''),
('reset talents', 2, ''),
('ticket delete', 2, ''),
('freeze', 2, ''),
('unfreeze', 2, ''),
('kick', 2, ''),
('revive', 2, ''),
('additem', 2, ''),
('unstuck', 2, ''),

('list', 2, ''),
('list auras', 2, '')
ON DUPLICATE KEY UPDATE security=2;

DELETE FROM command WHERE name LIKE 'account%';
DELETE FROM command WHERE name LIKE 'cheat%';
DELETE FROM command WHERE name LIKE 'disable%';
DELETE FROM command WHERE name LIKE 'mmap%';
DELETE FROM command WHERE name LIKE 'deserter%';
DELETE FROM command WHERE name LIKE 'arena%';
DELETE FROM command WHERE name LIKE 'rbac%' OR name LIKE '%rbac';
DELETE FROM command WHERE name LIKE 'character deleted%';
DELETE FROM command WHERE name LIKE 'listfreeze%';
DELETE FROM command WHERE name LIKE 'channel%';
DELETE FROM command WHERE name IN('gm ingame', 'guild rename', 'reload gameobject_involvedrelation', 'reload creature_summon_groups', 'list mail', 'reload spell_learn_spell', 'server plimit', 'character erase');

-- Trinity Strings for mute
UPDATE trinity_string SET content_default="%s has disabled %s's chat for %u minutes, effective at the player's next login. Reason: %s." WHERE entry=283 AND content_default="You have disabled %s's chat for %u minutes, effective at the player's next login. Reason: %s.";
UPDATE trinity_string SET content_default="%s has disabled %s's chat for %u minutes. Reason: %s." WHERE entry=301 AND content_default="You have disabled %s's chat for %u minutes. Reason: %s.";

-- Trinity String for .baninfo
UPDATE trinity_string SET content_default="Ban Date: %s Bantime: %s Still active: %s  Reason: %s Set by: %s" WHERE entry=418 AND content_default="Ban Date: %u Bantime: %s Still active: %s  Reason: %s Set by: %s";
UPDATE trinity_string SET content_default="There is no such character. Remember that the names are cAsE SeNSITivE!" WHERE entry=414 AND content_default="There is no such character.";

-- Trinity String for npc info (one of many)
UPDATE `trinity_string` SET `content_default`=
'Unit Flags: %u.
Unit Flags 2: %u.
Dynamic Flags: %u.
Faction Template: %u.' WHERE `entry`=542;

-- Trinity String .pinfo
REPLACE INTO trinity_string(entry, content_default) VALUES(548, 'Player%s %s (guid: %u) Account: %s (id: %u) Email: %s GMLevel: %u Last IP: %s Last login: %s Latency: %ums'); 
REPLACE INTO trinity_string(entry, content_default) VALUES(549, 'Race: %s Class: %s Played time: %s Level: %u Money: %ug%us%uc'); 
REPLACE INTO trinity_string(entry, content_default) VALUES(550, 'Mute time remaining: %s, By: %s, Reason: %s'); 
REPLACE INTO trinity_string(entry, content_default) VALUES(453, 'Ban time remaining: %s, Banned by: %s, Reason: %s'); 
REPLACE INTO trinity_string(entry, content_default) VALUES(714, 'Map: %s, Area: %s, Zone: %s, Phase: %u'); 
REPLACE INTO trinity_string(entry, content_default) VALUES(716, 'Map: %s, Area: %s');

-- Trinity String for BG Queue Announcer
REPLACE INTO `trinity_string` VALUES (711, 'Queue status for %s (Lvl: %u to %u)\nQueued alliances: %u (Need at least %u more)\nQueued hordes: %u (Need at least %u more)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
REPLACE INTO `trinity_string` VALUES (712, 'Queue status for %s (Lvl: %u to %u)\nQueued alliances: %u + random queue (Need at least %u)\nQueued hordes: %u + random queue (Need at least %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
REPLACE INTO `trinity_string` VALUES (713, 'Queue status for %s (Lvl: %u to %u)\nQueued alliances: %u + specific queue\nQueued hordes: %u + specific queue', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

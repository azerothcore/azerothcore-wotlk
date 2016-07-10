-- BRD
-- Shadowforge Flame Keeper (9956), make them attackable
UPDATE creature_template SET faction=14, unit_flags=0, flags_extra=0 WHERE entry=9956;
-- Blackhand Elite <Blackhand Legion> (10317)
-- Blackhand Assassin <Blackhand Legion> (10318)
UPDATE creature_template SET unit_flags=unit_flags&~(0x100) WHERE entry IN(10317, 10318);
-- Ribbly Screwspigot (9543)
REPLACE INTO npc_text VALUES(2643, "Hello! You\'re just the person I was looking for. Take a seat and listen,  because I have a plan that will make us both rich!", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO gossip_menu VALUES(1970, 2643);
REPLACE INTO gossip_menu_option VALUES(1970, 0, 0, "You\'re good for nothing, Ribbly. It\'s time to pay for your wickedness!", 1, 1, 0, 0, 0, 0, '');
REPLACE INTO creature_text VALUES(9543, 0, 0, 'No! Get away from me! Help!!', 12, 0, 100, 0, 0, 0, 0, 'Ribbly Screwspigot');
UPDATE creature_template SET npcflag=1, gossip_menu_id=1970, AIName='SmartAI', ScriptName='' WHERE entry=9543;
DELETE FROM smart_scripts WHERE entryorguid=9543 AND source_type=0;
INSERT INTO smart_scripts VALUES (9543, 0, 0, 1, 62, 0, 100, 0, 1970, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Set Faction');
INSERT INTO smart_scripts VALUES (9543, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 11, 10043, 30, 0, 0, 0, 0, 0, 'On Gossip Select - Set Faction');
INSERT INTO smart_scripts VALUES (9543, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Talk');
INSERT INTO smart_scripts VALUES (9543, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Attack Start');
INSERT INTO smart_scripts VALUES (9543, 0, 4, 0, 0, 0, 100, 0, 3000, 3000, 10000, 10000, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');
INSERT INTO smart_scripts VALUES (9543, 0, 5, 0, 0, 0, 100, 0, 1000, 1000, 5000, 5000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');
REPLACE INTO creature_template_addon VALUES(10043, 0, 0, 0, 4097, 0, '13299');
UPDATE creature_template SET npcflag=1, AIName='SmartAI', ScriptName='' WHERE entry=10043;
DELETE FROM smart_scripts WHERE entryorguid=10043 AND source_type=0;
INSERT INTO smart_scripts VALUES (10043, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 15692, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');
INSERT INTO smart_scripts VALUES (10043, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 5000, 5000, 11, 15581, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');

-- Watchman Doomgrip
REPLACE INTO gameobject_loot_template VALUES (11104, 11309, -100, 1, 0, 1, 1);
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(174554, 174559, 174555, 174556, 174557, 174558, 174560, 174561, 174562, 174563, 174564, 174566);
DELETE FROM smart_scripts WHERE entryorguid IN(174554, 174559, 174555, 174556, 174557, 174558, 174560, 174561, 174562, 174563, 174564, 174566) AND source_type=1;
INSERT INTO smart_scripts SELECT entry, 1, 0, 0, 8, 0, 100, 0, 13478, 0, 0, 0, 34, 30, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Set Instance Data' FROM gameobject_template WHERE entry IN(174554, 174559, 174555, 174556, 174557, 174558, 174560, 174561, 174562, 174563, 174564, 174566);
INSERT INTO smart_scripts SELECT entry, 1, 1, 0, 64, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 20, 160836, 5, 0, 0, 0, 0, 0, 'On Gossip Hello - Set GO Flags' FROM gameobject_template WHERE entry IN(174554, 174559, 174555, 174556, 174557, 174558, 174560, 174561, 174562, 174563, 174564, 174566);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=9476;
DELETE FROM smart_scripts WHERE entryorguid=9476 AND source_type=0;
INSERT INTO smart_scripts VALUES (9476, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 6000, 8000, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');
INSERT INTO smart_scripts VALUES (9476, 0, 1, 0, 2, 0, 100, 0, 0, 60, 30000, 30000, 11, 15504, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on self');
INSERT INTO smart_scripts VALUES (9476, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 14, 43137, 161495, 0, 0, 0, 0, 0, 'On Death - Set GO Flags');
INSERT INTO smart_scripts VALUES (9476, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 43094, 174553, 0, 0, 0, 0, 0, 'On Death - Set GO State');


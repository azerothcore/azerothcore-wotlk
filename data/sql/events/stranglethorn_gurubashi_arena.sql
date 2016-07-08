
-- Remove all unneeded stuff
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM game_event_creature WHERE eventEntry=16);
DELETE FROM creature WHERE guid IN(SELECT guid FROM game_event_creature WHERE eventEntry=16);
DELETE FROM game_event_creature WHERE eventEntry=16;

DELETE FROM gameobject WHERE guid IN(SELECT guid FROM game_event_gameobject WHERE eventEntry=16);
DELETE FROM game_event_gameobject WHERE eventEntry=16;

DELETE FROM gameobject WHERE id=179697;

DELETE FROM creature_text WHERE entry=14508;
INSERT INTO creature_text VALUES(14508, 0, 0, "Arrr, Me Hearties! I be havin' some extra Treasure that I be givin' away at the Gurubashi Arena! All ye need do to collect it is open the chest I leave on the arena floor!", 14, 0, 100, 0, 0, 0, 0, "Short John Mithril");
INSERT INTO creature_text VALUES(14508, 1, 0, "Let the Bloodletting Begin!", 14, 0, 100, 0, 0, 0, 0, "Short John Mithril");
UPDATE creature_template SET AIName='', ScriptName='npc_short_john_mirthil' WHERE entry=14508;
DELETE FROM smart_scripts WHERE entryorguid=14508 AND source_type=0;

DELETE FROM waypoint_data WHERE id=14508;
INSERT INTO waypoint_data VALUES (14508, 1, -13190.6, 326.298, 33.2433, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 2, -13192.2, 322.297, 33.2433, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 3, -13214.7, 323.686, 33.2418, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 4, -13236.7, 313.128, 33.2275, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 5, -13248.6, 299.971, 33.2406, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 6, -13254.3, 285.562, 33.2409, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 7, -13255.6, 265.067, 33.2416, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 8, -13245.4, 240.784, 33.2321, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 9, -13236.8, 231.815, 33.2404, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 10, -13233.1, 237.74, 33.3355, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 11, -13235.4, 240.703, 33.355, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 12, -13237.8, 244.583, 29.1785, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 13, -13240.6, 248.903, 29.1932, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 14, -13244.4, 257.667, 21.8578, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 15, -13242.6, 259.956, 21.8578, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (14508, 16, -13205.4, 276.026, 21.8578, 0, 0, 0, 0, 100, 0);

-- Opening effect? 24391

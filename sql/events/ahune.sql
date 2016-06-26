
-- This only adds Ahune and related gameobjects/npcs to The Slave Pens (547) and does NOT modify or remove any other midsummer fire festival features !!!

UPDATE quest_template SET Flags = Flags|1024, SpecialFlags = SpecialFlags|2, RequiredItemId1=0, RequiredItemCount1=0 WHERE Id=11691;

-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Ice Stone (187882)
-- GO with gossip, starts the whole event, ends the quest Summon Ahune (11691)
DELETE FROM game_event_gameobject WHERE guid IN( SELECT guid FROM gameobject WHERE map=547 AND id IN( SELECT entry FROM gameobject_template WHERE name='Ice Stone' ) );
DELETE FROM gameobject WHERE map=547 AND id IN( SELECT entry FROM gameobject_template WHERE name='Ice Stone' );
REPLACE INTO `gameobject` VALUES (220100, 187882, 547, 3, 1, -69.8564, -160.171, -2.14926, 4.34429, 0, 0, 0.824573, -0.565756, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(1, 220100);
REPLACE INTO `gameobject_template` VALUES (187882, 2, 7666, 'Ice Stone', '', '', '', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 8498, 0, 11389, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_ahune_ice_stone', 12340);
REPLACE INTO gossip_menu VALUES(11389, 15864);
REPLACE INTO `npc_text` VALUES (15864, 'This shard of ice echoes the deep, cracking rumble of invading glaciers.  Its cold turns your thoughts to a lifeless, endless winter.', '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 12340);

-- Ice Block, Big (188142)
DELETE FROM game_event_gameobject WHERE guid IN( SELECT guid FROM gameobject WHERE id IN(188142) AND map=547 );
DELETE FROM gameobject WHERE id IN(188142) AND map=547;
REPLACE INTO `gameobject` VALUES (220101, 188142, 547, 3, 1, -74.4, -243.278, -3.44864, 6.24435, 0, 0, 0.0194145, -0.999812, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220102, 188142, 547, 3, 1, -103.8, -245.022, -1.38009, 5.94198, 0, 0, 0.169777, -0.985483, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220103, 188142, 547, 3, 1, -75.7, -221.039, -2.8907, 6.2797, 0, 0, 0.00174061, -0.999999, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220104, 188142, 547, 3, 1, -119, -204.702, -1.505, 0.749238, 0, 0, 0.365918, 0.930647, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220105, 188142, 547, 3, 1, -72.0313, -185.713, -3.10467, 0.102854, 0, 0, 0.0514044, 0.998678, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220106, 188142, 547, 3, 1, -117.9, -167.091, -1.42756, 4.99807, 0, 0, 0.599246, -0.800565, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220107, 188142, 547, 3, 1, -69.8564, -160.171, -4.14925, 6.00542, 0, 0, 0.138435, -0.990372, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(1, 220101);
REPLACE INTO game_event_gameobject VALUES(1, 220102);
REPLACE INTO game_event_gameobject VALUES(1, 220103);
REPLACE INTO game_event_gameobject VALUES(1, 220104);
REPLACE INTO game_event_gameobject VALUES(1, 220105);
REPLACE INTO game_event_gameobject VALUES(1, 220106);
REPLACE INTO game_event_gameobject VALUES(1, 220107);

-- Ice Block (188067)
DELETE FROM game_event_gameobject WHERE guid IN( SELECT guid FROM gameobject WHERE id IN(188067) AND map=547 );
DELETE FROM gameobject WHERE id IN(188067) AND map=547;
REPLACE INTO `gameobject` VALUES (220111, 188067, 547, 3, 1, -54.45, -170.917, -2.58238, 4.93313, 0, 0, 0.62492, -0.780689, 300, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (220112, 188067, 547, 3, 1, -81.8403, -169.35, -3.52671, 5.12947, 0, 0, 0.545391, -0.838182, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(1, 220111);
REPLACE INTO game_event_gameobject VALUES(1, 220112);

-- Ice Block (181247)
DELETE FROM game_event_gameobject WHERE guid IN( SELECT guid FROM gameobject WHERE id IN(181247) AND map=547 );
DELETE FROM gameobject WHERE id IN(181247) AND map=547;

-- Ice Chest (187892)
REPLACE INTO `gameobject_template` VALUES (187892, 3, 1387, 'Ice Chest', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 1634, 28682, 999999999, 1, 0, 0, 17507, 188187, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
DELETE FROM gameobject_loot_template WHERE entry=28682; 
INSERT INTO gameobject_loot_template VALUES(28682, 35557, 100, 1, 0, 2, 2); 
INSERT INTO gameobject_loot_template VALUES(28682, 54802, 0, 1, 1, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 54803, 0, 1, 1, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 54804, 0, 1, 1, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 54805, 0, 1, 1, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 35723, 12, 1, 0, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 54801, 0, 1, 1, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 35498, 3, 1, 0, 1, 1); 
INSERT INTO gameobject_loot_template VALUES(28682, 35720, 3, 1, 0, 6, 6);

-- Satchel of Chilled God (54536)
DELETE FROM item_loot_template WHERE entry=54536; 
INSERT INTO item_loot_template VALUES (54536, 54806, 1.4, 1, 0, 1, 1); 
INSERT INTO item_loot_template VALUES (54536, 53641, 3, 1, 1, 1, 1); 
INSERT INTO item_loot_template VALUES (54536, 23247, 97, 1, 1, 5, 15); 
INSERT INTO item_loot_template VALUES (54536, 49426, 100, 1, 0, 2, 2); 




-- ###################
-- ### CREATURES
-- ###################

-- Ahune (25740, 26338)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25740, 26338) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25740, 26338) AND map=547 );
DELETE FROM creature WHERE id IN(25740, 26338) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25740, 26338);
REPLACE INTO `creature_template` VALUES (25740, 26338, 0, 0, 0, 0, 11686, 0, 0, 0, 'Ahune', 'The Frost Lord', '', 0, 82, 82, 2, 14, 0, 1.2, 1.14286, 1, 1, 316, 450, 0, 320, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 278, 413, 58, 4, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 40, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0, 'boss_ahune', 12340);
REPLACE INTO `creature_template` VALUES (26338, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Ahune (1)', 'The Frost Lord', '', 0, 82, 82, 2, 14, 0, 1.2, 1.14286, 1, 1, 316, 450, 0, 320, 15, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 278, 413, 58, 4, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 45, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1, '', 12340);
REPLACE INTO `creature_model_info` VALUES (23344, 2, 18, 2, 0);

-- Frozen Core (25865, 26339)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25865, 26339) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25865, 26339) AND map=547 );
DELETE FROM creature WHERE id IN(25865, 26339) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25865, 26339);
REPLACE INTO `creature_template` VALUES (25865, 26339, 0, 0, 0, 0, 23447, 0, 0, 0, 'Frozen Core', '', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 2, 2, 0, 24, 7.5, 2000, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 40, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0, 'npc_ahune_frozen_core', 12340);
REPLACE INTO `creature_template` VALUES (26339, 0, 0, 0, 0, 0, 23447, 0, 0, 0, 'Frozen Core (1)', '', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 2, 2, 0, 24, 13, 2000, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 45, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 1, '', 12340);
REPLACE INTO `creature_model_info` VALUES (23447, 1, 4, 2, 0);

-- Ghost of Ahune (26239)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(26239) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(26239) AND map=547 );
DELETE FROM creature WHERE id IN(26239) AND map=547;
REPLACE INTO creature_template_addon VALUES(26239, 0, 0, 0, 1, 0, "46786");
REPLACE INTO `creature_template` VALUES (26239, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Ghost of Ahune', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, '', 12340); 

-- [PH] Ahune Summon Loc Bunny (25745)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25745) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25745) AND map=547 );
DELETE FROM creature WHERE id IN(25745) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25745);
REPLACE INTO `creature_template` VALUES (25745, 0, 0, 0, 0, 0, 11686, 0, 0, 0, '[PH] Ahune Summon Loc Bunny', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, '', 12340); 

-- drakuru's bunny 05 (28015)
-- npc not used anywhere else, snow effect on the ground
DELETE FROM creature_template_addon WHERE entry=28015;
DELETE FROM creature_addon WHERE guid IN(245800, 245801);
REPLACE INTO `creature_template` VALUES (28015, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Drakuru\'s Bunny 05', '', '', 0, 60, 60, 1, 35, 0, 1, 1.14286, 1, 0, 104, 138, 0, 252, 1, 2000, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 72, 106, 26, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(-245800,-245801) AND source_type=0;
REPLACE INTO `smart_scripts` VALUES (-245800, 0, 0, 0, 1, 0, 100, 1, 0, 0, 180000, 180000, 11, 46314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ahune event frozen ground effect');
REPLACE INTO `smart_scripts` VALUES (-245801, 0, 0, 0, 1, 0, 100, 1, 0, 0, 180000, 180000, 11, 46314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ahune event frozen ground effect');
REPLACE INTO `creature` VALUES (245800, 28015, 547, 3, 1, 11686, 0, -97.3473, -233.139, -1.27587, 4.72914, 300, 0, 0, 4120, 0, 0, 0, 33554432, 0);
REPLACE INTO `creature` VALUES (245801, 28015, 547, 3, 1, 11686, 0, -72.99, -159.073, -2.19389, 5.20431, 300, 0, 0, 4120, 0, 0, 0, 33554432, 0);
REPLACE INTO game_event_creature VALUES(1, 245800);
REPLACE INTO game_event_creature VALUES(1, 245801);

-- Shaman Bonfire Bunny (25971, 25972, 25973)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25971, 25972, 25973) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25971, 25972, 25973) AND map=547 );
DELETE FROM creature WHERE id IN(25971, 25972, 25973) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25971, 25972, 25973);
REPLACE INTO `creature_template` VALUES (25973, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Shaman Bonfire Bunny 002', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 133, 1, 0, 130, '', 12340);
REPLACE INTO `creature_template` VALUES (25972, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Shaman Bonfire Bunny 001', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 133, 1, 0, 130, '', 12340);
REPLACE INTO `creature_template` VALUES (25971, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Shaman Bonfire Bunny 000', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 133, 1, 0, 130, '', 12340);
INSERT INTO `creature` VALUES (245810, 25971, 547, 3, 1, 0, 0, -115.141, -143.317, -2.09467, 4.92772, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (245811, 25972, 547, 3, 1, 0, 0, -120.178, -144.398, -2.23786, 4.92379, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (245812, 25973, 547, 3, 1, 0, 0, -125.277, -145.463, -1.95209, 4.97877, 300, 0, 0, 42, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(1, 245810);
REPLACE INTO game_event_creature VALUES(1, 245811);
REPLACE INTO game_event_creature VALUES(1, 245812);

-- Earthen Ring Totem (25961)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25961) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25961) AND map=547 );
DELETE FROM creature WHERE id IN(25961) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25961);

-- Ahunite Hailstone (25755, 26342)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25755, 26342) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25755, 26342) AND map=547 );
DELETE FROM creature WHERE id IN(25755, 26342) AND map=547;
REPLACE INTO creature_template_addon VALUES(25755, 0, 0, 0, 1, 0, "46542");
REPLACE INTO creature_template_addon VALUES(26342, 0, 0, 0, 1, 0, "46542");
REPLACE INTO `creature_template` VALUES (25755, 26342, 0, 0, 0, 0, 20433, 0, 0, 0, 'Ahunite Hailstone', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 240, 400, 0, 24, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (26342, 0, 0, 0, 0, 0, 20433, 0, 0, 0, 'Ahunite Hailstone (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 240, 400, 0, 24, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 10.33, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid=25755 AND source_type=0;
REPLACE INTO `smart_scripts` VALUES (25755, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 15000, 20000, 11, 742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ahunite Hailstone spell Pulverize');
REPLACE INTO `smart_scripts` VALUES (25755, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'despawn 5 secs after death');

-- Ahunite Coldwave (25756, 26340)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25756, 26340) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25756, 26340) AND map=547 );
DELETE FROM creature WHERE id IN(25756, 26340) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25756, 26340);
REPLACE INTO `creature_template` VALUES (25756, 26340, 0, 0, 0, 0, 23504, 0, 0, 0, 'Ahunite Coldwave', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 120, 200, 0, 24, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (26340, 0, 0, 0, 0, 0, 23504, 0, 0, 0, 'Ahunite Coldwave (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 120, 200, 0, 24, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid=25756 AND source_type=0;
REPLACE INTO `smart_scripts` VALUES (25756, 0, 0, 0, 0, 0, 100, 2, 3000, 7000, 5000, 8000, 11, 46887, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ahunite Coldwave spell Bitter Blast normal');
REPLACE INTO `smart_scripts` VALUES (25756, 0, 1, 0, 0, 0, 100, 4, 3000, 7000, 5000, 8000, 11, 46406, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ahunite Coldwave spell Bitter Blast heroic');
REPLACE INTO `smart_scripts` VALUES (25756, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'despawn 5 secs after death');

-- Ahunite Frostwind (25757, 26341)
DELETE FROM game_event_creature WHERE guid IN( SELECT guid FROM creature WHERE id IN(25757, 26341) AND map=547 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(25757, 26341) AND map=547 );
DELETE FROM creature WHERE id IN(25757, 26341) AND map=547;
DELETE FROM creature_template_addon WHERE entry IN(25757, 26341);
REPLACE INTO `creature_template` VALUES (25757, 26341, 0, 0, 0, 0, 8714, 0, 0, 0, 'Ahunite Frostwind', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 120, 200, 0, 24, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (26341, 0, 0, 0, 0, 0, 8714, 0, 0, 0, 'Ahunite Frostwind (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 120, 200, 0, 24, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid=25757 AND source_type=0;
REPLACE INTO `smart_scripts` VALUES (25757, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 12550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ahunite Frostwind spell Lightning Shield');
REPLACE INTO `smart_scripts` VALUES (25757, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 8000, 12000, 11, 46568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ahunite Frostwind spell Wind Buffet');
REPLACE INTO `smart_scripts` VALUES (25757, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'despawn 5 secs after death');




-- ###################
-- ### SPELLS
-- ###################

-- Wisp Flight Missile and Beam (46593) -- starting beam
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46593;
INSERT INTO `conditions` VALUES (13, 1, 46593, 0, 0, 31, 0, 3, 25745, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 46593, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "Ahune event - Hit trigger");

-- Ahune - Summoning Rhyme Spell, make bonfire (45930)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45930;
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 0, 31, 0, 3, 25971, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 1, 31, 0, 3, 25972, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 2, 31, 0, 3, 25973, 0, 0, 0, 0, "", "Ahune event - Hit trigger");
INSERT INTO `conditions` VALUES (13, 1, 45930, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, "", "Ahune event - Hit trigger");

-- Beam Attack against Ahune 2 (46363) -- rzucane przez totem w ahune
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46363;
INSERT INTO `conditions` VALUES (13, 1, 46363, 0, 0, 31, 0, 3, 25740, 0, 0, 0, 0, "", "Ahune event - trigger hit ahune");
INSERT INTO `conditions` VALUES (13, 1, 46363, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "Ahune event - trigger hit ahune");

-- Summon Ahune's Loot (45939) go id in here

-- Summon Ahune's Loot, Heroic (46622) go id in here

-- Summon Ahune's Bottle (46888) go id in here

-- Summon Ahune's Loot, Bottles (46891) go id in here

-- Summon Ahune's Loot, Heroic, Bottles (46892) go id in here




-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- Ice the Frost Lord (263)
DELETE FROM disables WHERE sourceType=4 AND entry IN(477,11718,5270,8158,8159);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(477,11718,5270,8158,8159);
REPLACE INTO achievement_criteria_data VALUES(477, 0, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11718, 0, 0, 0, "");

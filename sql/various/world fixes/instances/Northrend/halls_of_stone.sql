-- -------------------------------------
-- MAIDEN OF GRIEF
-- -------------------------------------
REPLACE INTO creature_template VALUES (27975, 31384, 0, 0, 0, 0, 26657, 0, 0, 0, 'Maiden of Grief', '', '', 0, 79, 79, 2, 16, 1073741824, 1, 1, 1, 1, 404, 564, 0, 582, 4.8, 2000, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 334, 494, 95, 10, 72, 27975, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 22.5, 6, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_maiden_of_grief', 1);
REPLACE INTO creature_template VALUES (31384, 0, 0, 0, 0, 0, 26657, 0, 0, 0, 'Maiden of Grief (1)', '', '', 0, 82, 82, 2, 16, 1073741824, 1, 1, 1, 1, 488, 642, 0, 782, 9, 2000, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 363, 521, 121, 10, 72, 31384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 32, 6, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 1);


-- -------------------------------------
-- KRYSTALLUS
-- -------------------------------------
REPLACE INTO creature_template VALUES (27977, 31381, 0, 0, 0, 0, 20909, 0, 0, 0, 'Krystallus', '', '', 0, 79, 79, 2, 16, 1073741824, 1, 1, 1, 1, 404, 564, 0, 582, 4.8, 2000, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 334, 494, 95, 5, 584, 27977, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 23.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 650854271, 0+0x200000, 'boss_krystallus', 1);
REPLACE INTO creature_template VALUES (31381, 0, 0, 0, 0, 0, 20909, 0, 0, 0, 'Krystallus (1)', '', '', 0, 82, 82, 2, 16, 1073741824, 1, 1, 1, 1, 488, 642, 0, 782, 9, 2000, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 363, 521, 121, 5, 584, 31381, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 650854271, 1+0x200000, '', 1);

DELETE FROM spell_linked_spell WHERE spell_trigger IN(50810, 61546); 


-- -------------------------------------
-- TRIBUNAL OF AGES
-- -------------------------------------
REPLACE INTO creature_template VALUES (27983, 31876, 0, 0, 0, 0, 25991, 0, 0, 0, 'Dark Rune Protector', '', '', 0, 77, 77, 2, 1965, 0, 1, 1, 1, 1, 422, 586, 0, 708, 4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'dark_rune_protectors', 1);
REPLACE INTO creature_template VALUES (27984, 31877, 0, 0, 0, 0, 25987, 0, 0, 0, 'Dark Rune Stormcaller', '', '', 0, 77, 77, 2, 1965, 0, 1, 1, 1, 0, 422, 524, 0, 708, 3, 2000, 0, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'dark_rune_stormcaller', 1);
REPLACE INTO creature_template VALUES (27985, 31380, 0, 0, 0, 0, 26148, 0, 0, 0, 'Iron Golem Custodian', '', '', 0, 77, 77, 2, 1965, 0, 1, 1, 1, 1, 422, 586, 0, 708, 5, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'iron_golem_custodian', 1);
REPLACE INTO creature_template VALUES (28070, 0, 0, 0, 0, 0, 26353, 0, 0, 0, 'Brann Bronzebeard', '', '', 0, 80, 80, 0, 35, 3, 1, 1, 1, 1, 422, 586, 0, 642, 3, 2000, 0, 1, 32768, 2048, 0, 0, 0, 0, 0, 0, 345, 509, 103, 7, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'brann_bronzebeard', 1);
REPLACE INTO creature_template VALUES (28237, 31875, 0, 0, 0, 0, 11686, 0, 0, 0, 'Dark Matter Target', '', '', 0, 80, 80, 0, 114, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);
REPLACE INTO creature_template VALUES (28265, 31878, 0, 0, 0, 0, 11686, 0, 0, 0, 'Searing Gaze', '', '', 0, 80, 80, 0, 114, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30897, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Marnak', '', '', 0, 80, 80, 2, 114, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554432|4, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30898, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Kaddrak', '', '', 0, 80, 80, 2, 114, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554432|4, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30899, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Abedneum', '', '', 0, 80, 80, 2, 114, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554432|4, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31380, 0, 0, 0, 0, 0, 26148, 0, 0, 0, 'Iron Golem Custodian (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1, 1, 1, 422, 586, 0, 708, 10, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31875, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Dark Matter Target (1)', '', '', 0, 80, 80, 0, 114, 0, 1, 1.14286, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);
REPLACE INTO creature_template VALUES (31876, 0, 0, 0, 0, 0, 25991, 0, 0, 0, 'Dark Rune Protector (1)', '', '', 0, 80, 81, 2, 1965, 0, 1, 1, 1, 1, 422, 586, 0, 708, 8, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31877, 0, 0, 0, 0, 0, 25987, 0, 0, 0, 'Dark Rune Stormcaller (1)', '', '', 0, 80, 81, 2, 1965, 0, 1, 1, 1, 0, 422, 524, 0, 708, 6, 2000, 0, 8, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31878, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Searing Gaze (1)', '', '', 0, 80, 81, 0, 114, 0, 1, 1.14286, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.6875, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);

DELETE FROM spell_script_names WHERE spell_id=51001;
INSERT INTO spell_script_names VALUES(51001, "spell_hos_dark_matter");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=51001;
INSERT INTO conditions VALUES(13, 1, 51001, 0, 0, 31, 0, 3, 28237, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 51001, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

-- Searing gaze
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(51136, 59867);
INSERT INTO conditions VALUES(13, 1, 51136, 0, 0, 31, 0, 3, 30899, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 51136, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 59867, 0, 0, 31, 0, 3, 30899, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 59867, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

-- Remove unneded triggers
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(28234, 28237, 30897, 30898, 30899));
DELETE FROM `creature` WHERE id IN(28234, 28237, 30897, 30898, 30899);
UPDATE creature_template SET ScriptName='' WHERE entry=28234;

REPLACE INTO `gameobject_template` VALUES (190586, 3, 1387, 'Tribunal Chest', '', '', '', 0, 4, 1, '0', '0', '0', 0, 0, 0, 1634, 24661, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 11723);
REPLACE INTO `gameobject_template` VALUES (193996, 3, 1387, 'Tribunal Chest', '', '','' , 0, 4, 1, '0', '0', '0', 0, 0, 0, 1634, 26260, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '','' , 12340);

DELETE FROM script_waypoint WHERE entry=28070;
INSERT INTO script_waypoint VALUES(28070, 1, 1064.1166, 474.8827, 207.7205, 0, '');
INSERT INTO script_waypoint VALUES(28070, 2, 1046.2692, 479.7282, 207.7480, 0, '');
INSERT INTO script_waypoint VALUES(28070, 3, 1023.2681, 457.1940, 207.7195, 0, '');
INSERT INTO script_waypoint VALUES(28070, 4, 999.0955, 433.5120, 207.4123, 0, '');
INSERT INTO script_waypoint VALUES(28070, 5, 984.9246, 406.4542, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 6, 982.3167, 390.5871, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 7, 973.5246, 379.9866, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 8, 946.5971, 383.5330, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 9, 936.0703, 372.5126, 207.4222, 0, '');
INSERT INTO script_waypoint VALUES(28070, 10, 926.0936, 362.0708, 203.7063, 0, '');
INSERT INTO script_waypoint VALUES(28070, 11, 897.0822, 332.6125, 203.7063, 0, '');
INSERT INTO script_waypoint VALUES(28070, 12, 946.5971, 383.5330, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 13, 973.5246, 379.9866, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 14, 982.3167, 390.5871, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 15, 984.9246, 406.4542, 205.9943, 0, '');
INSERT INTO script_waypoint VALUES(28070, 16, 999.0955, 433.5120, 207.4123, 0, '');
INSERT INTO script_waypoint VALUES(28070, 17, 1023.2681, 457.1940, 207.7195, 0, '');
INSERT INTO script_waypoint VALUES(28070, 18, 1046.2692, 479.7282, 207.7480, 0, '');
INSERT INTO script_waypoint VALUES(28070, 19, 1064.1166, 474.8827, 207.7205, 0, '');
INSERT INTO script_waypoint VALUES(28070, 20, 1047.9121, 521.1028, 207.7195, 0, '');
INSERT INTO script_waypoint VALUES(28070, 21, 1048.5737, 622.4920, 207.7195, 0, '');
INSERT INTO script_waypoint VALUES(28070, 22, 1048.8612, 662.8669, 201.6716, 0, '');
INSERT INTO script_waypoint VALUES(28070, 23, 1105.6994, 662.4746, 202.8711, 0, '');
INSERT INTO script_waypoint VALUES(28070, 24, 1121.4381, 662.3660, 196.2350, 0, '');
INSERT INTO script_waypoint VALUES(28070, 25, 1138.5794, 632.4987, 196.2350, 0, '');
INSERT INTO script_waypoint VALUES(28070, 26, 1164.7830, 637.1132, 196.2942, 0, '');
INSERT INTO script_waypoint VALUES(28070, 27, 1200.4025, 665.5217, 196.2418, 3000, '');
INSERT INTO script_waypoint VALUES(28070, 28, 1251.9725, 667.5396, 189.6078, 0, '');
INSERT INTO script_waypoint VALUES(28070, 29, 1307.6169, 667.7174, 189.6078, 0, '');

-- -------------------------------------
-- SJONNIR
-- -------------------------------------
REPLACE INTO creature_template VALUES (27978, 31386, 0, 0, 0, 0, 27483, 0, 0, 0, 'Sjonnir The Ironshaper', '', '', 0, 79, 79, 2, 1965, 0, 1, 1.14286, 1, 1, 404, 564, 0, 582, 5, 1200, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 334, 494, 95, 7, 72, 27978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4647, 7745, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 650854271, 0+0x200000, 'boss_sjonnir', 1);
REPLACE INTO creature_template VALUES (27979, 31390, 0, 0, 0, 0, 6530, 0, 0, 0, 'Forged Iron Trogg', '', '', 0, 79, 79, 2, 1965, 0, 1, 1.14286, 1, 0, 404, 564, 0, 582, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'boss_sjonnir_dwarf', 12340);
REPLACE INTO creature_template VALUES (27981, 31388, 0, 0, 0, 0, 25177, 0, 0, 0, 'Malformed Ooze', '', '', 0, 79, 82, 2, 1965, 0, 1, 1.14286, 1, 0, 422, 586, 0, 646, 2, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.131822, 1, 1, 0, 0, 0, 0, 0, 0, 0, 84, 1, 0, 0, 'boss_sjonnir_malformed_ooze', 1);
REPLACE INTO creature_template VALUES (27982, 31394, 0, 0, 0, 0, 25754, 0, 0, 0, 'Forged Iron Dwarf', '', '', 0, 79, 79, 2, 1965, 0, 1, 1.14286, 1, 1, 422, 586, 0, 646, 4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'boss_sjonnir_dwarf', 1);
REPLACE INTO creature_template VALUES (28165, 31389, 0, 0, 0, 0, 25176, 0, 0, 0, 'Iron Sludge', '', '', 0, 77, 77, 2, 1965, 0, 1, 1.14286, 1, 0, 322, 486, 0, 646, 1.5, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'boss_sjonnir_iron_sludge', 1);
REPLACE INTO creature_template VALUES (31386, 0, 0, 0, 0, 0, 27483, 0, 0, 0, 'Sjonnir The Ironshaper (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 10, 1200, 0, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 363, 521, 121, 7, 72, 31386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9294, 15490, '', 0, 3, 1, 35, 1, 1, 0, 43699, 0, 0, 0, 0, 0, 121, 1, 650854271, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (31388, 0, 0, 0, 0, 0, 25177, 0, 0, 0, 'Malformed Ooze (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1.14286, 1, 0, 422, 586, 0, 646, 4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.131822, 1, 1, 0, 0, 0, 0, 0, 0, 0, 84, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31389, 0, 0, 0, 0, 0, 25176, 0, 0, 0, 'Iron Sludge (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1.14286, 1, 0, 322, 486, 0, 646, 3, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31390, 0, 0, 0, 0, 0, 6530, 0, 0, 0, 'Forged Iron Trogg (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1.14286, 1, 0, 488, 642, 0, 782, 8, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31394, 0, 0, 0, 0, 0, 25754, 0, 0, 0, 'Forged Iron Dwarf (1)', '', '', 0, 82, 82, 2, 1965, 0, 1, 1.14286, 1, 1, 422, 586, 0, 646, 8, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);

-- Remove shield aura from addon auras
UPDATE creature_addon SET auras=NULL WHERE guid=126792;

-- -------------------------------------
-- ACHIEVEMENTS
-- -------------------------------------
-- Halls of Stone (485)
DELETE FROM disables WHERE sourceType=4 AND entry IN(215, 216, 217, 6935);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(215, 216, 217, 6935);
INSERT INTO achievement_criteria_data VALUES(215, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(216, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(217, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6935, 12, 0, 0, "");

-- Heroic: Halls of Stone (496)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6856, 6857, 6858, 6936);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6856, 6857, 6858, 6936);
INSERT INTO achievement_criteria_data VALUES(6856, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6857, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6858, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6936, 12, 1, 0, "");

-- Good Grief (1866)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7143);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7143);
INSERT INTO achievement_criteria_data VALUES(7143, 12, 1, 0, "");

-- Brann Spankin' New (2154)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7590);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7590);
INSERT INTO achievement_criteria_data VALUES(7590, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7590, 18, 0, 0, "");

-- Abuse the Ooze (2155)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7593);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7593);
INSERT INTO achievement_criteria_data VALUES(7593, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7593, 18, 0, 0, "");


-- ###################
-- ### GAMEOBJECTS
-- ###################

-- delete chests
DELETE FROM gameobject WHERE `map`=649 AND id IN(195631, 195632, 195633, 195635, 195665, 195666, 195667, 195668, 195669, 195670, 195671, 195672);

-- North Portcullis (195650)
REPLACE INTO gameobject_template VALUES(195650, 0, 411, "North Portcullis", "", "", "", 1375, 0, 3.27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195650 AND map=649;
INSERT INTO gameobject VALUES(151178, 195650, 649, 15, 65535, 624.688, 139.327, 395.23, 3.14159, 0, 0, 0, 0, 120, 0, 0, 0);

-- South Portcullis (195649)
REPLACE INTO gameobject_template VALUES(195649, 0, 411, "South Portcullis", "", "", "", 1375, 0, 3.27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195649 AND map=649;
INSERT INTO gameobject VALUES(151177, 195649, 649, 15, 65535, 502.359, 139.327, 395.23, 3.14159, 0, 0, 0, 0, 120, 0, 1, 0);

-- East Portcullis (195648)
REPLACE INTO gameobject_template VALUES(195648, 0, 411, "East Portcullis", "", "", "", 1375, 0, 3.27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195648 AND map=649;
INSERT INTO gameobject VALUES(151176, 195648, 649, 15, 35535, 563.495, 78.1971, 395.23, 1.57079, 0, 0, 0, 0, 120, 0, 1, 0);

-- Main Gate (195647)
REPLACE INTO gameobject_template VALUES(195647, 0, 9044, "Main Gate", "", "", "", 1375, 0, 1.48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195647 AND map=649;
INSERT INTO gameobject VALUES(151183, 195647, 649, 15, 65535, 563.547, 198.741, 395.157, 1.57079, 0, 0, 0, 0, 120, 0, 1, 0);

-- Web Door (195485)
REPLACE INTO gameobject_template VALUES(195485, 0, 9047, "Web Door", "", "", "", 1375, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195485 AND map=649;
INSERT INTO gameobject VALUES(151192, 195485, 649, 15, 65535, 661.598, 144.728, 141.923, 0, 0, 0, 0, 0, 120, 0, 0, 0);

-- Argent Coliseum Floor (195527)
REPLACE INTO gameobject_template VALUES(195527, 33, 9059, "Argent Coliseum Floor", "", "", "", 0, 0, 1, 0, 0, 0, 0, 0, 0, 10000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63, 0, 0, 0, 0, 0, "", "", 12340);
DELETE FROM gameobject WHERE id=195527 AND map=649;
INSERT INTO gameobject VALUES(151175, 195527, 649, 15, 65535, 563.535, 177.309, 398.572, 1.5708, 0, 0, 0, 0, 120, 0, 1, 0);




-- ###################
-- ### NPCS
-- ###################

-- Barrett Ramsey (34816)
DELETE FROM creature_template_addon WHERE entry IN(34816);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34816) AND `map`=649 );
DELETE FROM creature WHERE id=34816 AND map=649;
INSERT INTO creature VALUES(202957, 34816, 649, 15, 65535, 0, 0, 559.172, 90.5816, 395.273, 5.06145, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34816, 0, 0, 0, 0, 0, 29888, 0, 0, 0, "Barrett Ramsey", "Argent Coliseum Master", "", 0, 80, 80, 2, 35, 1, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "npc_announcer_toc10", 12340);

-- Highlord Tirion Fordring (34996)
DELETE FROM creature_template_addon WHERE entry IN(34996);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34996) AND `map`=649 );
DELETE FROM creature WHERE id=34996 AND map=649;
INSERT INTO creature VALUES(202956, 34996, 649, 15, 65535, 0, 1, 563.691, 79.1615, 418.298, 1.58825, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34996, 0, 0, 0, 0, 0, 29588, 0, 0, 0, "Highlord Tirion Fordring", "", "", 0, 83, 83, 2, 2070, 0, 1, 1.14286, 1, 1, 496, 674, 0, 783, 7.5, 2000, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- Garrosh Hellscream (34995)
DELETE FROM creature_template_addon WHERE entry IN(34995);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34995) AND `map`=649 );
DELETE FROM creature WHERE id=34995 AND map=649;
INSERT INTO creature VALUES(202955, 34995, 649, 15, 65535, 0, 0, 503.927, 141.74, 418.301, 6.24828, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34995, 0, 0, 0, 0, 0, 29592, 0, 0, 0, "Garrosh Hellscream", "Overlord of the Warsong Offensive", "", 0, 83, 83, 2, 35, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 100, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- King Varian Wrynn (34990)
DELETE FROM creature_template_addon WHERE entry IN(34990);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34990) AND `map`=649 );
DELETE FROM creature WHERE id=34990 AND map=649;
INSERT INTO creature VALUES(202952, 34990, 649, 15, 65535, 0, 0, 624.135, 140.84, 418.296, 3.15905, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34990, 0, 0, 0, 0, 0, 29589, 0, 0, 0, "King Varian Wrynn", "King of Stormwind", "", 0, 83, 83, 2, 35, 0, 1, 0.992063, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 600, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- Thrall (34994)
DELETE FROM creature_template_addon WHERE entry IN(34994);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34994) AND `map`=649 );
DELETE FROM creature WHERE id=34994 AND map=649;
INSERT INTO creature VALUES(202954, 34994, 649, 15, 65535, 0, 0, 503.252, 137.226, 418.297, 0.0523599, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34994, 0, 0, 0, 0, 0, 29591, 0, 0, 0, "Thrall", "Warchief", "", 0, 83, 83, 2, 35, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 568.343, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- Lady Jaina Proudmoore (34992)
DELETE FROM creature_template_addon WHERE entry IN(34992);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34992) AND `map`=649 );
DELETE FROM creature WHERE id=34992 AND map=649;
INSERT INTO creature VALUES(202953, 34992, 649, 15, 65535, 0, 0, 624.352, 137.653, 418.294, 3.10669, 120, 0, 0, 1, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES(34992, 0, 0, 0, 0, 0, 30866, 0, 0, 0, "Lady Jaina Proudmoore", "Ruler of Theramore", "", 0, 75, 75, 2, 35, 0, 1, 1, 1, 3, 289, 421, 0, 175, 35, 2000, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 271, 403, 45, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 529.505, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- Wilfred Fizzlebang (35458)
DELETE FROM creature_template_addon WHERE entry IN(35458);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(35458) AND `map`=649 );
DELETE FROM creature WHERE id=35458 AND map=649;
REPLACE INTO creature_template VALUES(35458, 0, 0, 0, 0, 0, 29814, 0, 0, 0, "Wilfred Fizzlebang", "", "", 0, 80, 80, 2, 1770, 0, 1.5, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 0, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 9.92064, 10.211, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, "", 12340);

-- Lich King (35877)
REPLACE INTO creature_template VALUES(35877, 0, 0, 0, 0, 0, 25337, 0, 0, 0, "The Lich King", "", "", 0, 83, 83, 2, 974, 0, 2.0, 1.14286, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 2, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 6, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 2000, 500, 1, 0, 0, 0, 0, 0, 0, 0, 169, 1, 0, 0, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(35877);

-- Argent Mage (36097)
REPLACE INTO `creature_template` VALUES (36097, 0, 0, 0, 0, 0, 29984, 0, 0, 0, 'Argent Mage', '', '', 0, 80, 80, 2, 2070, 0, 1, 1.14286, 1, 0, 346, 499, 0, 287, 1, 0, 0, 8, 512, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(36097);

-- Val'kyr Twins Bullet Stalker Light(34720), Val'kyr Twins Bullet Stalker Dark (34704)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34720, 34704) AND `map`=649 );
DELETE FROM creature WHERE id IN(34720, 34704) AND map=649;

-- Optimization
UPDATE creature_template SET AIName="NullCreatureAI" WHERE entry IN(34970,34868,34995,34996,34994,34908,34974,34887,34975,34966,34977,34871,34856,34870,34992,34990,34906,34910,34909,34869,34900,34979,34859,34861,34904,34905,34860,34857,34902,34901,34883,34903,34858,34816);




-- ###################
-- ### Achievements
-- ###################

-- Upper Back Pain (10)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11779,11802);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11779,11802);
REPLACE INTO achievement_criteria_data VALUES(11779, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11779, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11802, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11802, 18, 0, 0, "");

-- Upper Back Pain (25)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11780,11801);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11780,11801);
REPLACE INTO achievement_criteria_data VALUES(11780, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11780, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11801, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11801, 18, 0, 0, "");

-- Not One, But Two Jormungars (10)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12280,12281);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12280,12281);
REPLACE INTO achievement_criteria_data VALUES(12280, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12281, 12, 2, 0, "");

-- Not One, But Two Jormungars (25)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12278,12279);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12278,12279);
REPLACE INTO achievement_criteria_data VALUES(12278, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12279, 12, 3, 0, "");

-- Faction Champions
DELETE FROM disables WHERE sourceType=4 AND entry IN(11686, 11681, 11691, 11678, 12236, 12238, 12237, 12239);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11686, 11681, 11691, 11678, 12236, 12238, 12237, 12239);
REPLACE INTO achievement_criteria_data VALUES(11686, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11681, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11691, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11678, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12236, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12238, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12237, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12239, 12, 3, 0, "");

-- Three Sixty Pain Spike (10)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11838,11861);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11838,11861);
REPLACE INTO achievement_criteria_data VALUES(11838, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11838, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11861, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11861, 18, 0, 0, "");

-- Three Sixty Pain Spike (25)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11839,11862);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11839,11862);
REPLACE INTO achievement_criteria_data VALUES(11839, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11839, 18, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11862, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11862, 18, 0, 0, "");

-- Resilience Will Fix It (10)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11803,11804);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11803,11804);
REPLACE INTO achievement_criteria_data VALUES(11803, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11804, 12, 2, 0, "");

-- Resilience Will Fix It (25)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11799,11800);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11799,11800);
REPLACE INTO achievement_criteria_data VALUES(11799, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11800, 12, 3, 0, "");

-- Salt and Pepper (10)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11778,12258);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11778,12258);
REPLACE INTO achievement_criteria_data VALUES(11778, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12258, 12, 2, 0, "");

-- Salt and Pepper (25)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11818,11860);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11818,11860);
REPLACE INTO achievement_criteria_data VALUES(11818, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11860, 12, 3, 0, "");

-- The Traitor King (10) (3800)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12116);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12116);
REPLACE INTO achievement_criteria_data VALUES(12116, 0, 0, 0, "");

-- The Traitor King (25) (3816)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12198);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12198);
REPLACE INTO achievement_criteria_data VALUES(12198, 0, 0, 0, "");

-- Call of the Crusade (10) (3917)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11684,11685,11686,11687,11688);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11684,11685,11689,11687,11688);
REPLACE INTO achievement_criteria_data VALUES(11684, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11685, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11686, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11687, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11688, 12, 0, 0, "");

-- Call of the Crusade (25) (3916)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11679,11680,11681,11682,11683);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11679,11680,11681,11682,11683);
REPLACE INTO achievement_criteria_data VALUES(11679, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11680, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11681, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11682, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11683, 12, 1, 0, "");

-- Call of the Grand Crusade (10) (3918)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11689,11690,11691,11692,11693);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11689,11690,11691,11692,11693);
REPLACE INTO achievement_criteria_data VALUES(11689, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11690, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11691, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11692, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11693, 12, 2, 0, "");

-- Call of the Grand Crusade (25) (3812)
DELETE FROM disables WHERE sourceType=4 AND entry IN(11542,11546,11678,11547,11549);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11542,11546,11678,11547,11549);
REPLACE INTO achievement_criteria_data VALUES(11542, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11546, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11678, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11547, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(11549, 12, 3, 0, "");

-- A Tribute to Skill (10) (3808)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12344,12345,12346);
INSERT INTO disables VALUES(4, 12345, 0, "", "", "");
INSERT INTO disables VALUES(4, 12346, 0, "", "", "");
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12344,12345,12346);
REPLACE INTO achievement_criteria_data VALUES(12344, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12344, 18, 0, 0, "");

-- A Tribute to Skill (25) (3817)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12338,12339,12340);
INSERT INTO disables VALUES(4, 12339, 0, "", "", "");
INSERT INTO disables VALUES(4, 12340, 0, "", "", "");
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12338,12339,12340);
REPLACE INTO achievement_criteria_data VALUES(12338, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12338, 18, 0, 0, "");

-- A Tribute to Mad Skill (10) (3809)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12347,12348);
INSERT INTO disables VALUES(4, 12348, 0, "", "", "");
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12347,12348);
REPLACE INTO achievement_criteria_data VALUES(12347, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12347, 18, 0, 0, "");

-- A Tribute to Mad Skill (25) (3818)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12341,12342);
INSERT INTO disables VALUES(4, 12342, 0, "", "", "");
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12341,12342);
REPLACE INTO achievement_criteria_data VALUES(12341, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12341, 18, 0, 0, "");

-- A Tribute to Insanity (10) (3810)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12349);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12349);
REPLACE INTO achievement_criteria_data VALUES(12349, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12349, 18, 0, 0, "");

-- A Tribute to Insanity (25) (3819)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12343);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12343);
REPLACE INTO achievement_criteria_data VALUES(12343, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12343, 18, 0, 0, "");

-- A Tribute to Immortality (25 ALLIANCE) (4156)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12359);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12359);
REPLACE INTO achievement_criteria_data VALUES(12359, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12359, 18, 0, 0, "");

-- A Tribute to Immortality (25 HORDE) (4079)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12358);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12358);
REPLACE INTO achievement_criteria_data VALUES(12358, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12358, 18, 0, 0, "");

-- Realm First! Grand Crusader (25) (4078)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12350);
-- REPLACE INTO disables VALUES(4, 12350, 0, "", "", "");
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12350);
REPLACE INTO achievement_criteria_data VALUES(12350, 12, 3, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12350, 18, 0, 0, "");

-- A Tribute to Dedicated Insanity (10) (4080)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12360);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12360);
REPLACE INTO achievement_criteria_data VALUES(12360, 12, 2, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12360, 18, 0, 0, "");

-- HEROIC AVAILABLE AFTER COMPLETING NORMAL DIFFICULTY:
UPDATE access_requirement SET level_min=80, completed_achievement=0 WHERE mapId=649 AND difficulty=0;
UPDATE access_requirement SET level_min=80, completed_achievement=0 WHERE mapId=649 AND difficulty=1;
UPDATE access_requirement SET level_min=80, completed_achievement=3917 WHERE mapId=649 AND difficulty=2;
UPDATE access_requirement SET level_min=80, completed_achievement=3916 WHERE mapId=649 AND difficulty=3;




-- ###################
-- ### Gormok the Impaler
-- ###################

-- Gormok (34796, 35438, 35439, 35440)
REPLACE INTO creature_template VALUES(34796, 35438, 35439, 35440, 0, 0, 29614, 0, 0, 0, "Gormok the Impaler", "", "", 0, 83, 83, 2, 16, 0, 4.8, 1.71429, 1, 3, 750, 1050, 0, 805, 35, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 442, 0, 0, "", 0, 3, 1, 160, 5, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 650854267, 9+0x200000, "boss_gormok", 12340);
REPLACE INTO creature_template VALUES(35438, 0, 0, 0, 0, 0, 29614, 0, 0, 0, "Gormok the Impaler (1)", "", "", 0, 83, 83, 2, 16, 0, 4.8, 1.71429, 1, 3, 750, 1050, 0, 805, 60, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 442, 0, 0, "", 0, 3, 1, 640, 5, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 650854267, 9+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35439, 0, 0, 0, 0, 0, 29614, 0, 0, 0, "Gormok the Impaler (2)", "", "", 0, 83, 83, 2, 16, 0, 4.8, 1.71429, 1, 3, 750, 1050, 0, 805, 45, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 442, 0, 0, "", 0, 3, 1, 200, 5, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 650854271, 9+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35440, 0, 0, 0, 0, 0, 29614, 0, 0, 0, "Gormok the Impaler (3)", "", "", 0, 83, 83, 2, 16, 0, 4.8, 1.71429, 1, 3, 750, 1050, 0, 805, 75, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 442, 0, 0, "", 0, 3, 1, 850, 5, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 650854271, 9+0x200000, "", 12340);
REPLACE INTO creature_model_info VALUES(29614, 1.085, 6.5, 2, 0);
DELETE FROM creature_template_addon WHERE entry IN(34796, 35438, 35439, 35440);

-- Gormok: veh 442, Snobold: veh 496
REPLACE INTO vehicle_template_accessory VALUES(34796, 34800, 0, 0, "Gormok Snobold", 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(34796, 34800, 1, 0, "Gormok Snobold", 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(34796, 34800, 2, 0, "Gormok Snobold", 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(34796, 34800, 3, 0, "Gormok Snobold", 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry=34796;
INSERT INTO npc_spellclick_spells VALUES(34796, 67830, 1, 0);

-- Snobold Vassal (34800, 35441, 35442, 35443)
REPLACE INTO creature_template VALUES(34800, 35441, 35442, 35443, 0, 0, 27172, 0, 0, 0, "Snobold Vassal", "", "", 0, 78, 78, 2, 14, 0, 1, 1.19048, 1, 1, 387, 543, 0, 528, 7.5, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "npc_snobold_vassal", 12340);
REPLACE INTO creature_template VALUES(35441, 0, 0, 0, 0, 0, 27172, 0, 0, 0, "Snobold Vassal (1)", "", "", 0, 78, 78, 2, 14, 0, 1, 1.19048, 1, 1, 387, 543, 0, 528, 13, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 40, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35442, 0, 0, 0, 0, 0, 27172, 0, 0, 0, "Snobold Vassal (2)", "", "", 0, 78, 78, 2, 14, 0, 1, 1.19048, 1, 1, 387, 543, 0, 528, 13, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 14, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35443, 0, 0, 0, 0, 0, 27172, 0, 0, 0, "Snobold Vassal (3)", "", "", 0, 78, 78, 2, 14, 0, 1, 1.19048, 1, 1, 387, 543, 0, 528, 20, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 60, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34800, 35441, 35442, 35443);

-- npc Fire Bomb (34854)
REPLACE INTO creature_template VALUES(34854, 0, 0, 0, 0, 0, 11686, 0, 0, 0, "Fire Bomb", "", "", 0, 80, 80, 2, 14, 0, 1, 1.14286, 1.5, 3, 1, 1, 0, 1, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 1028, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34854);

-- spell Fire Bomb (66313, 66318)
-- additional ids: 66317, 66320, 67472, 67473, 67475, 66319
DELETE FROM spell_script_names WHERE spell_id IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319);
DELETE FROM spell_scripts WHERE id IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319) OR spell_effect IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319);
DELETE FROM spelldifficulty_dbc WHERE spellid0 IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319) OR spellid1 IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319) OR spellid2 IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319) or spellid3 IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319);
DELETE FROM spell_dbc WHERE Id IN(66313, 66318, -66313, -66318, 66317, 66320, 67472, 67473, 67475, -66317, -66320, -67472, -67473, -67475, 66319, -66319);

-- rising anger
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=66636;
INSERT INTO conditions VALUES(13, 1, 66636, 0, 0, 31, 0, 3, 34796, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 66636, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");

-- Portal to Dalaran
REPLACE INTO spell_target_position VALUES(68328, 0, 571, 5807.81, 587.977, 660.939, 1.663);




-- ###################
-- ### Dreadscale & Acidmaw
-- ###################

-- creature_model_info
REPLACE INTO creature_model_info VALUES(24564, 1.24, 6.5, 2, 0);
REPLACE INTO creature_model_info VALUES(26935, 1.24, 6.5, 2, 0);
REPLACE INTO creature_model_info VALUES(29815, 1.24, 6.5, 2, 0);
REPLACE INTO creature_model_info VALUES(29816, 1.24, 6.5, 2, 0);
REPLACE INTO creature_model_info VALUES(24417, 10, 15, 0, 0);


-- Dreadscale (34799, 35514, 35515, 35516)
REPLACE INTO creature_template VALUES(34799, 35514, 35515, 35516, 0, 0, 24564, 0, 0, 0, "Dreadscale", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 35, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 90, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "boss_dreadscale", 12340);
REPLACE INTO creature_template VALUES(35514, 0, 0, 0, 0, 0, 24564, 0, 0, 0, "Dreadscale (1)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 60, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 360, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35515, 0, 0, 0, 0, 0, 24564, 0, 0, 0, "Dreadscale (2)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 45, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 120, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35516, 0, 0, 0, 0, 0, 24564, 0, 0, 0, "Dreadscale (3)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 75, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 480, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34799, 35514, 35515, 35516);

-- Acidmaw (35144, 35511, 35512, 35513)
REPLACE INTO creature_template VALUES(35144, 35511, 35512, 35513, 0, 0, 29815, 0, 0, 0, "Acidmaw", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 35, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 90, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "boss_acidmaw", 12340);
REPLACE INTO creature_template VALUES(35511, 0, 0, 0, 0, 0, 29815, 0, 0, 0, "Acidmaw (1)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 60, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 360, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35512, 0, 0, 0, 0, 0, 29815, 0, 0, 0, "Acidmaw (2)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 45, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 120, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35513, 0, 0, 0, 0, 0, 29815, 0, 0, 0, "Acidmaw (3)", "", "", 0, 83, 83, 2, 1711, 0, 4.8, 1.35, 1, 3, 750, 1050, 0, 805, 75, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 480, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(35144, 35511, 35512, 35513);

-- npc Slime Pool (35176)
REPLACE INTO creature_template VALUES(35176, 0, 0, 0, 0, 0, 11686, 0, 0, 0, "Slime Pool", "", "", 0, 80, 80, 0, 14, 0, 0.004, 0.001429, 1, 0, 2, 2, 0, 24, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, "", 12340);

-- Burning Bile remove Paralytic Toxin
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66870,67621,67622,67623);
REPLACE INTO spell_linked_spell VALUES(66870, -66823, 1, "Burning Bile remove Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67621, -67618, 1, "Burning Bile remove Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67622, -67619, 1, "Burning Bile remove Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67623, -67620, 1, "Burning Bile remove Paralytic Toxin");

-- Burning Spray apply Burning Bile
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66902,67627,67628,67629);
REPLACE INTO spell_linked_spell VALUES(66902, 66869, 1, "Burning Spray apply Burning Bile");
REPLACE INTO spell_linked_spell VALUES(67627, 66869, 1, "Burning Spray apply Burning Bile");
REPLACE INTO spell_linked_spell VALUES(67628, 66869, 1, "Burning Spray apply Burning Bile");
REPLACE INTO spell_linked_spell VALUES(67629, 66869, 1, "Burning Spray apply Burning Bile");

-- Paralytic Spray apply Paralytic Toxin
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66901,67615,67616,67617);
REPLACE INTO spell_linked_spell VALUES(66901, 66823, 1, "Paralytic Spray apply Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67615, 67618, 1, "Paralytic Spray apply Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67616, 67619, 1, "Paralytic Spray apply Paralytic Toxin");
REPLACE INTO spell_linked_spell VALUES(67617, 67620, 1, "Paralytic Spray apply Paralytic Toxin");




-- ###################
-- ### Icehowl
-- ###################

-- Icehowl (34797, 35447, 35448, 35449)
REPLACE INTO creature_template VALUES(34797, 35447, 35448, 35449, 0, 0, 21601, 0, 0, 0, "Icehowl", "", "", 0, 83, 83, 2, 14, 0, 3.2, 2.28571, 1, 3, 750, 1050, 0, 805, 35, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 108, 34797, 0, 34797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890457, 890457, "", 0, 3, 1, 250, 1, 1, 0, 0, 0, 0, 0, 0, 0, 204, 1, 650854271, 1+0x200000, "boss_icehowl", 12340);
REPLACE INTO creature_template VALUES(35447, 0, 0, 0, 0, 0, 21601, 0, 0, 0, "Icehowl (1)", "", "", 0, 83, 83, 2, 14, 0, 3.2, 2.28571, 1, 3, 750, 1050, 0, 805, 60, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 108, 35447, 0, 34797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890457, 890457, "", 0, 3, 1, 950, 1, 1, 0, 0, 0, 0, 0, 0, 0, 204, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35448, 0, 0, 0, 0, 0, 21601, 0, 0, 0, "Icehowl (2)", "", "", 0, 83, 83, 2, 14, 0, 3.2, 2.28571, 1, 3, 750, 1050, 0, 805, 45, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 108, 35448, 0, 34797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890457, 890457, "", 0, 3, 1, 300, 1, 1, 0, 0, 0, 0, 0, 0, 0, 204, 1, 650854271, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35449, 0, 0, 0, 0, 0, 21601, 0, 0, 0, "Icehowl (3)", "", "", 0, 83, 83, 2, 14, 0, 3.2, 2.28571, 1, 3, 750, 1050, 0, 805, 75, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 108, 35449, 0, 34797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890457, 890457, "", 0, 3, 1, 1300, 1, 1, 0, 0, 0, 0, 0, 0, 0, 204, 1, 650854271, 1+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34797, 35447, 35448, 35449);
REPLACE INTO creature_model_info VALUES(21601, 3, 12, 2, 0);

-- spells
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66683,-66683,67660,-67660,67661,-67661,67662,-67662);




-- ###################
-- ### Jaraxxus
-- ###################

-- Jaraxxus (34780, 35216, 35268, 35269)
REPLACE INTO creature_template VALUES(34780, 35216, 35268, 35269, 0, 0, 29615, 0, 0, 0, "Lord Jaraxxus", "", "", 0, 83, 83, 2, 14, 0, 2.8, 1.42857, 1, 3, 750, 1050, 0, 783, 35, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 3, 76, 34780, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 628444, 628444, "", 0, 3, 1, 300, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, "boss_jaraxxus", 12340);
REPLACE INTO creature_template VALUES(35216, 0, 0, 0, 0, 0, 29615, 0, 0, 0, "Lord Jaraxxus (1)", "", "", 0, 83, 83, 2, 14, 0, 2.8, 1.42857, 1, 3, 750, 1050, 0, 783, 70, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 3, 76, 35216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 628444, 628444, "", 0, 3, 1, 1450, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35268, 0, 0, 0, 0, 0, 29615, 0, 0, 0, "Lord Jaraxxus (2)", "", "", 0, 83, 83, 2, 14, 0, 2.8, 1.42857, 1, 3, 750, 1050, 0, 783, 50, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 3, 76, 35268, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 628444, 628444, "", 0, 3, 1, 380, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35269, 0, 0, 0, 0, 0, 29615, 0, 0, 0, "Lord Jaraxxus (3)", "", "", 0, 83, 83, 2, 14, 0, 2.8, 1.42857, 1, 3, 750, 1050, 0, 783, 85, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 3, 76, 35269, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 628444, 628444, "", 0, 3, 1, 1900, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34780, 35216, 35268, 35269);

-- Legion Flame (34784)
REPLACE INTO creature_template VALUES(34784, 0, 0, 0, 0, 0, 11686, 0, 0, 0, "Legion Flame", "", "", 0, 82, 82, 0, 14, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1049600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
REPLACE INTO creature_template_addon VALUES(34784, 0, 0, 0, 1, 0, "66201");

-- Infernal Volcano (34813, 35265, 35266, 35267);
REPLACE INTO creature_template VALUES(34813, 35265, 35266, 35267, 0, 0, 29441, 0, 0, 0, "Infernal Volcano", "", "", 0, 80, 80, 2, 14, 0, 1, 1.28968, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35265, 0, 0, 0, 0, 0, 29441, 0, 0, 0, "Infernal Volcano (1)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.28968, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35266, 0, 0, 0, 0, 0, 29441, 0, 0, 0, "Infernal Volcano (2)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.28968, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35267, 0, 0, 0, 0, 0, 29441, 0, 0, 0, "Infernal Volcano (3)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.28968, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 64, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template_addon VALUES(34813, 0, 0, 0, 1, 0, "66252");
REPLACE INTO creature_template_addon VALUES(35265, 0, 0, 0, 1, 0, "67067");
REPLACE INTO creature_template_addon VALUES(35266, 0, 0, 0, 1, 0, "67068");
REPLACE INTO creature_template_addon VALUES(35267, 0, 0, 0, 1, 0, "67069");

-- Felflame Infernal (34815, 35262, 35263, 35264)
REPLACE INTO creature_template VALUES(34815, 35262, 35263, 35264, 0, 0, 10906, 0, 0, 0, "Felflame Infernal", "", "", 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650852223, 0+0x200000, "npc_fel_infernal", 12340);
REPLACE INTO creature_template VALUES(35262, 0, 0, 0, 0, 0, 10906, 0, 0, 0, "Felflame Infernal (1)", "", "", 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650852223, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35263, 0, 0, 0, 0, 0, 10906, 0, 0, 0, "Felflame Infernal (2)", "", "", 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 10, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35264, 0, 0, 0, 0, 0, 10906, 0, 0, 0, "Felflame Infernal (3)", "", "", 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 18, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 23, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34815, 35262, 35263, 35264);

-- Nether Portal (34825, 35278, 35279, 35280)
REPLACE INTO creature_template VALUES(34825, 35278, 35279, 35280, 0, 0, 30039, 0, 0, 0, "Nether Portal", "", "", 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35278, 0, 0, 0, 0, 0, 30039, 0, 0, 0, "Nether Portal (1)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 33685508, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35279, 0, 0, 0, 0, 0, 30039, 0, 0, 0, "Nether Portal (2)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35280, 0, 0, 0, 0, 0, 30039, 0, 0, 0, "Nether Portal (3)", "", "", 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 64, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template_addon VALUES(34825, 0, 0, 0, 1, 0, "66263");
REPLACE INTO creature_template_addon VALUES(35278, 0, 0, 0, 1, 0, "67103");
REPLACE INTO creature_template_addon VALUES(35279, 0, 0, 0, 1, 0, "67104");
REPLACE INTO creature_template_addon VALUES(35280, 0, 0, 0, 1, 0, "67105");

-- Mistress of Pain (34826, 35270, 35271, 35272)
REPLACE INTO creature_template VALUES(34826, 35270, 35271, 35272, 0, 0, 29442, 0, 0, 0, "Mistress of Pain", "", "", 0, 82, 82, 2, 14, 0, 2.8, 2, 1, 1, 488, 642, 0, 782, 7.5, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 446, 0, 0, "", 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 186, 1, 650854271, 0+0x200000, "npc_mistress_of_pain", 12340);
REPLACE INTO creature_template VALUES(35270, 0, 0, 0, 0, 0, 29442, 0, 0, 0, "Mistress of Pain (1)", "", "", 0, 82, 82, 2, 14, 0, 2.8, 2, 1, 1, 488, 642, 0, 782, 13, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 446, 0, 0, "", 0, 3, 1, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 186, 1, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35271, 0, 0, 0, 0, 0, 29442, 0, 0, 0, "Mistress of Pain (2)", "", "", 0, 82, 82, 2, 14, 0, 2.8, 2, 1, 1, 488, 642, 0, 782, 10, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 446, 0, 0, "", 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 186, 1, 650854271, 0+0x200000, "", 12340);
REPLACE INTO creature_template VALUES(35272, 0, 0, 0, 0, 0, 29442, 0, 0, 0, "Mistress of Pain (3)", "", "", 0, 82, 82, 2, 14, 0, 2.8, 2, 1, 1, 488, 642, 0, 782, 18, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 446, 0, 0, "", 0, 3, 1, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 186, 1, 650854271, 0+0x200000, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(34826, 35270, 35271, 35272);

-- Purple Ground Rune Argent Raid (35651)
REPLACE INTO creature_template VALUES(35651, 0, 0, 0, 0, 0, 22862, 0, 0, 0, "Purple Ground Rune Argent Raid", "", "", 0, 80, 80, 2, 35, 0, 1.2, 1, 2, 0, 422, 586, 0, 642, 1, 0, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "NullCreatureAI", 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, "", 12340);
DELETE FROM creature_template_addon WHERE entry IN(35651);

-- spells
DELETE FROM spell_script_names WHERE spell_id IN(66334, 67905, 67906, 67907, -66334, -67905, -67906, -67907);
DELETE FROM spell_scripts WHERE id IN(66334, 67905, 67906, 67907, -66334, -67905, -67906, -67907);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66334, 67905, 67906, 67907, -66334, -67905, -67906, -67907) OR spell_effect IN(66334, 67905, 67906, 67907, -66334, -67905, -67906, -67907);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66334, 67905, 67906, 67907);
INSERT INTO spell_script_names VALUES(66334, 'spell_toc25_mistress_kiss'),(67905, 'spell_toc25_mistress_kiss'),(67906, 'spell_toc25_mistress_kiss'),(67907, 'spell_toc25_mistress_kiss');

DELETE FROM spell_linked_spell WHERE spell_trigger IN(66336, 67076, 67077, 67078);
-- REPLACE INTO spell_linked_spell VALUES(66336, 66334, 1, "Mistress' Kiss");
-- REPLACE INTO spell_linked_spell VALUES(67076, 66334, 1, "Mistress' Kiss");
-- REPLACE INTO spell_linked_spell VALUES(67077, 66334, 1, "Mistress' Kiss");
-- REPLACE INTO spell_linked_spell VALUES(67078, 66334, 1, "Mistress' Kiss");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=66287;
INSERT INTO conditions VALUES(13, 1, 66287, 0, 0, 31, 0, 3, 34826, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 66287, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");
REPLACE INTO disables VALUES(0, 66326, 7, "", "", ""),(0, 66327, 7, "", "", "");




-- ###################
-- ### Faction Champions
-- ###################

-- death knight (melee)
REPLACE INTO creature_template VALUES(34458, 35692, 35693, 35694, 0, 0, 29782, 0, 0, 0, "Gorgrim Shadowcleave", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_dk", 12340);
REPLACE INTO creature_template VALUES(34461, 35743, 35744, 35745, 0, 0, 29765, 0, 0, 0, "Tyrius Duskblade", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_dk", 12340);
REPLACE INTO creature_template VALUES(35692, 0, 0, 0, 0, 0, 29782, 0, 0, 0, "Gorgrim Shadowcleave (1)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35693, 0, 0, 0, 0, 0, 29782, 0, 0, 0, "Gorgrim Shadowcleave (2)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35694, 0, 0, 0, 0, 0, 29782, 0, 0, 0, "Gorgrim Shadowcleave (3)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35743, 0, 0, 0, 0, 0, 29765, 0, 0, 0, "Tyrius Duskblade (1)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35744, 0, 0, 0, 0, 0, 29765, 0, 0, 0, "Tyrius Duskblade (2)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35745, 0, 0, 0, 0, 0, 29765, 0, 0, 0, "Tyrius Duskblade (3)", "Death Knight", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- druid ballance (ranged)
REPLACE INTO creature_template VALUES(34451, 35671, 35672, 35673, 0, 0, 29781, 0, 0, 0, "Birana Stormhoof", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_boomkin", 12340);
REPLACE INTO creature_template VALUES(34460, 35702, 35703, 35704, 0, 0, 29764, 0, 0, 0, "Kavina Grovesong", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_boomkin", 12340);
REPLACE INTO creature_template VALUES(35671, 0, 0, 0, 0, 0, 29781, 0, 0, 0, "Birana Stormhoof (1)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35672, 0, 0, 0, 0, 0, 29781, 0, 0, 0, "Birana Stormhoof (2)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35673, 0, 0, 0, 0, 0, 29781, 0, 0, 0, "Birana Stormhoof (3)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35702, 0, 0, 0, 0, 0, 29764, 0, 0, 0, "Kavina Grovesong (1)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35703, 0, 0, 0, 0, 0, 29764, 0, 0, 0, "Kavina Grovesong (2)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35704, 0, 0, 0, 0, 0, 29764, 0, 0, 0, "Kavina Grovesong (3)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- druid restoration (healer)
REPLACE INTO creature_template VALUES(34459, 35686, 35687, 35688, 0, 0, 29780, 0, 0, 0, "Erin Misthoof", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_druid", 12340);
REPLACE INTO creature_template VALUES(34469, 35714, 35715, 35716, 0, 0, 29780, 0, 0, 0, "Melador Valestrider", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_druid", 12340);
REPLACE INTO creature_template VALUES(35686, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Erin Misthoof (1)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35687, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Erin Misthoof (2)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35688, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Erin Misthoof (3)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35714, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Melador Valestrider (1)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35715, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Melador Valestrider (2)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35716, 0, 0, 0, 0, 0, 29780, 0, 0, 0, "Melador Valestrider (3)", "Druid", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- hunter (ranged)
REPLACE INTO creature_template VALUES(34448, 35724, 35725, 35726, 0, 0, 29786, 0, 0, 0, "Ruj'kah", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 8, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_hunter", 12340);
REPLACE INTO creature_template VALUES(34467, 35662, 35663, 35664, 0, 0, 29770, 0, 0, 0, "Alyssia Moonstalker", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 8, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_hunter", 12340);
REPLACE INTO creature_template VALUES(35662, 0, 0, 0, 0, 0, 29770, 0, 0, 0, "Alyssia Moonstalker (1)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35663, 0, 0, 0, 0, 0, 29770, 0, 0, 0, "Alyssia Moonstalker (2)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35664, 0, 0, 0, 0, 0, 29770, 0, 0, 0, "Alyssia Moonstalker (3)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 18, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35724, 0, 0, 0, 0, 0, 29786, 0, 0, 0, "Ruj'kah (1)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35725, 0, 0, 0, 0, 0, 29786, 0, 0, 0, "Ruj'kah (2)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35726, 0, 0, 0, 0, 0, 29786, 0, 0, 0, "Ruj'kah (3)", "Hunter", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 18, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 496, 674, 783, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- mage (ranged)
REPLACE INTO creature_template VALUES(34449, 35689, 35690, 35691, 0, 0, 29787, 0, 0, 0, "Ginselle Blightslinger", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_mage", 12340);
REPLACE INTO creature_template VALUES(34468, 35721, 35722, 35723, 0, 0, 29772, 0, 0, 0, "Noozle Whizzlestick", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_mage", 12340);
REPLACE INTO creature_template VALUES(35689, 0, 0, 0, 0, 0, 29787, 0, 0, 0, "Ginselle Blightslinger (1)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35690, 0, 0, 0, 0, 0, 29787, 0, 0, 0, "Ginselle Blightslinger (2)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35691, 0, 0, 0, 0, 0, 29787, 0, 0, 0, "Ginselle Blightslinger (3)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35721, 0, 0, 0, 0, 0, 29772, 0, 0, 0, "Noozle Whizzlestick (1)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35722, 0, 0, 0, 0, 0, 29772, 0, 0, 0, "Noozle Whizzlestick (2)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35723, 0, 0, 0, 0, 0, 29772, 0, 0, 0, "Noozle Whizzlestick (3)", "Mage", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- holy paladin (healer)
REPLACE INTO creature_template VALUES(34445, 35705, 35706, 35707, 0, 0, 29785, 0, 0, 0, "Liandra Suncaller", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_paladin", 12340);
REPLACE INTO creature_template VALUES(34465, 35746, 35747, 35748, 0, 0, 29769, 0, 0, 0, "Velanaa", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_paladin", 12340);
REPLACE INTO creature_template VALUES(35705, 0, 0, 0, 0, 0, 29785, 0, 0, 0, "Liandra Suncaller (1)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35706, 0, 0, 0, 0, 0, 29785, 0, 0, 0, "Liandra Suncaller (2)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35707, 0, 0, 0, 0, 0, 29785, 0, 0, 0, "Liandra Suncaller (3)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35746, 0, 0, 0, 0, 0, 29769, 0, 0, 0, "Velanaa (1)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35747, 0, 0, 0, 0, 0, 29769, 0, 0, 0, "Velanaa (2)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35748, 0, 0, 0, 0, 0, 29769, 0, 0, 0, "Velanaa (3)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- retribution paladin (melee)
REPLACE INTO creature_template VALUES(34456, 35708, 35709, 35710, 0, 0, 29789, 0, 0, 0, "Malithas Brightblade", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_retro_paladin", 12340);
REPLACE INTO creature_template VALUES(34471, 35668, 35669, 35670, 0, 0, 29774, 0, 0, 0, "Baelnor Lightbearer", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_retro_paladin", 12340);
REPLACE INTO creature_template VALUES(35668, 0, 0, 0, 0, 0, 29774, 0, 0, 0, "Baelnor Lightbearer (1)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35669, 0, 0, 0, 0, 0, 29774, 0, 0, 0, "Baelnor Lightbearer (2)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35670, 0, 0, 0, 0, 0, 29774, 0, 0, 0, "Baelnor Lightbearer (3)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35708, 0, 0, 0, 0, 0, 29789, 0, 0, 0, "Malithas Brightblade (1)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35709, 0, 0, 0, 0, 0, 29789, 0, 0, 0, "Malithas Brightblade (2)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35710, 0, 0, 0, 0, 0, 29789, 0, 0, 0, "Malithas Brightblade (3)", "Paladin", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- discipline priest (healer)
REPLACE INTO creature_template VALUES(34447, 35683, 35684, 35685, 0, 0, 29783, 0, 0, 0, "Caiphus the Stern", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_priest", 12340);
REPLACE INTO creature_template VALUES(34466, 35665, 35666, 35667, 0, 0, 29767, 0, 0, 0, "Anthar Forgemender", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_priest", 12340);
REPLACE INTO creature_template VALUES(35665, 0, 0, 0, 0, 0, 29767, 0, 0, 0, "Anthar Forgemender (1)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35666, 0, 0, 0, 0, 0, 29767, 0, 0, 0, "Anthar Forgemender (2)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35667, 0, 0, 0, 0, 0, 29767, 0, 0, 0, "Anthar Forgemender (3)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35683, 0, 0, 0, 0, 0, 29783, 0, 0, 0, "Caiphus the Stern (1)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35684, 0, 0, 0, 0, 0, 29783, 0, 0, 0, "Caiphus the Stern (2)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35685, 0, 0, 0, 0, 0, 29783, 0, 0, 0, "Caiphus the Stern (3)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- shadow priest (ranged)
REPLACE INTO creature_template VALUES(34441, 34442, 34443, 35749, 0, 0, 29791, 0, 0, 0, "Vivienne Blackwhisper", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_shadow_priest", 12340);
REPLACE INTO creature_template VALUES(34442, 0, 0, 0, 0, 0, 29791, 0, 0, 0, "Vivienne Blackwhisper (1)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(34443, 0, 0, 0, 0, 0, 29791, 0, 0, 0, "Vivienne Blackwhisper (2)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(34473, 35674, 35675, 35676, 0, 0, 29778, 0, 0, 0, "Brienna Nightfell", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_shadow_priest", 12340);
REPLACE INTO creature_template VALUES(35674, 0, 0, 0, 0, 0, 29778, 0, 0, 0, "Brienna Nightfell (1)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35675, 0, 0, 0, 0, 0, 29778, 0, 0, 0, "Brienna Nightfell (2)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35676, 0, 0, 0, 0, 0, 29778, 0, 0, 0, "Brienna Nightfell (3)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35749, 0, 0, 0, 0, 0, 29791, 0, 0, 0, "Vivienne Blackwhisper (3)", "Priest", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- rogue (melee)
REPLACE INTO creature_template VALUES(34454, 35711, 35712, 35713, 0, 0, 29790, 0, 0, 0, "Maz'dinah", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 5, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_rogue", 12340);
REPLACE INTO creature_template VALUES(34472, 35699, 35700, 35701, 0, 0, 29776, 0, 0, 0, "Irieth Shadowstep", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 5, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_rogue", 12340);
REPLACE INTO creature_template VALUES(35699, 0, 0, 0, 0, 0, 29776, 0, 0, 0, "Irieth Shadowstep (1)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 10, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35700, 0, 0, 0, 0, 0, 29776, 0, 0, 0, "Irieth Shadowstep (2)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 7, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35701, 0, 0, 0, 0, 0, 29776, 0, 0, 0, "Irieth Shadowstep (3)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 13, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35711, 0, 0, 0, 0, 0, 29790, 0, 0, 0, "Maz'dinah (1)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 10, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35712, 0, 0, 0, 0, 0, 29790, 0, 0, 0, "Maz'dinah (2)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 7, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35713, 0, 0, 0, 0, 0, 29790, 0, 0, 0, "Maz'dinah (3)", "Rogue", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 388, 583, 0, 400, 13, 1300, 0, 4, 2, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- enhancement shaman (melee)
REPLACE INTO creature_template VALUES(34455, 35680, 35681, 35682, 0, 0, 29784, 0, 0, 0, "Broln Stouthorn", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_enh_shaman", 12340);
REPLACE INTO creature_template VALUES(34463, 35734, 35735, 35736, 0, 0, 29768, 0, 0, 0, "Shaabad", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_enh_shaman", 12340);
REPLACE INTO creature_template VALUES(35680, 0, 0, 0, 0, 0, 29784, 0, 0, 0, "Broln Stouthorn (1)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35681, 0, 0, 0, 0, 0, 29784, 0, 0, 0, "Broln Stouthorn (2)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35682, 0, 0, 0, 0, 0, 29784, 0, 0, 0, "Broln Stouthorn (3)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35734, 0, 0, 0, 0, 0, 29768, 0, 0, 0, "Shaabad (1)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 15, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35735, 0, 0, 0, 0, 0, 29768, 0, 0, 0, "Shaabad (2)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35736, 0, 0, 0, 0, 0, 29768, 0, 0, 0, "Shaabad (3)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- restoration shaman (healer)
REPLACE INTO creature_template VALUES(34444, 35740, 35741, 35742, 0, 0, 29788, 0, 0, 0, "Thrakgar", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_shaman", 12340);
REPLACE INTO creature_template VALUES(34470, 35728, 35729, 35730, 0, 0, 29773, 0, 0, 0, "Saamul", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 5, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_shaman", 12340);
REPLACE INTO creature_template VALUES(35728, 0, 0, 0, 0, 0, 29773, 0, 0, 0, "Saamul (1)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35729, 0, 0, 0, 0, 0, 29773, 0, 0, 0, "Saamul (2)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35730, 0, 0, 0, 0, 0, 29773, 0, 0, 0, "Saamul (3)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35740, 0, 0, 0, 0, 0, 29788, 0, 0, 0, "Thrakgar (1)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 10, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35741, 0, 0, 0, 0, 0, 29788, 0, 0, 0, "Thrakgar (2)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 7, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 150, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35742, 0, 0, 0, 0, 0, 29788, 0, 0, 0, "Thrakgar (3)", "Shaman", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 13, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 250, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- warlock (ranged)
REPLACE INTO creature_template VALUES(34450, 35695, 35696, 35697, 0, 0, 29792, 0, 0, 0, "Harkzog", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_warlock", 12340);
REPLACE INTO creature_template VALUES(34474, 35731, 35732, 35733, 0, 0, 29777, 0, 0, 0, "Serissa Grimdabbler", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 5, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_warlock", 12340);
REPLACE INTO creature_template VALUES(35695, 0, 0, 0, 0, 0, 29792, 0, 0, 0, "Harkzog (1)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35696, 0, 0, 0, 0, 0, 29792, 0, 0, 0, "Harkzog (2)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35697, 0, 0, 0, 0, 0, 29792, 0, 0, 0, "Harkzog (3)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35731, 0, 0, 0, 0, 0, 29777, 0, 0, 0, "Serissa Grimdabbler (1)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 10, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35732, 0, 0, 0, 0, 0, 29777, 0, 0, 0, "Serissa Grimdabbler (2)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 7, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 72, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35733, 0, 0, 0, 0, 0, 29777, 0, 0, 0, "Serissa Grimdabbler (3)", "Warlock", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 370, 531, 0, 343, 13, 0, 0, 8, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 542, 84, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- warrior (melee)
REPLACE INTO creature_template VALUES(34453, 35718, 35719, 35720, 0, 0, 29793, 0, 0, 0, "Narrhok Steelbreaker", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 7, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_warrior", 12340);
REPLACE INTO creature_template VALUES(34475, 35737, 35738, 35739, 0, 0, 29779, 0, 0, 0, "Shocuul", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 7, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_warrior", 12340);
REPLACE INTO creature_template VALUES(35718, 0, 0, 0, 0, 0, 29793, 0, 0, 0, "Narrhok Steelbreaker (1)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 15, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35719, 0, 0, 0, 0, 0, 29793, 0, 0, 0, "Narrhok Steelbreaker (2)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 10, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35720, 0, 0, 0, 0, 0, 29793, 0, 0, 0, "Narrhok Steelbreaker (3)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 20, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35737, 0, 0, 0, 0, 0, 29779, 0, 0, 0, "Shocuul (1)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 15, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 192, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35738, 0, 0, 0, 0, 0, 29779, 0, 0, 0, "Shocuul (2)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 10, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 48, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35739, 0, 0, 0, 0, 0, 29779, 0, 0, 0, "Shocuul (3)", "Warrior", "", 0, 83, 83, 2, 16, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 20, 0, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 256, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- felhunter (pet)
REPLACE INTO creature_template VALUES(35465, 36301, 36302, 36303, 0, 0, 1913, 0, 0, 0, "Zhaagrym", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 417, 582, 0, 608, 1, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 10, 10, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 1, 1048577, "npc_toc_pet_warlock", 12340);
REPLACE INTO creature_template VALUES(36301, 0, 0, 0, 0, 0, 1913, 0, 0, 0, "Zhaagrym (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 417, 582, 0, 608, 4, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 35, 10, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(36303, 0, 0, 0, 0, 0, 1913, 0, 0, 0, "Zhaagrym (3)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 417, 582, 0, 608, 5, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 55, 10, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(36302, 0, 0, 0, 0, 0, 1913, 0, 0, 0, "Zhaagrym (2)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 417, 582, 0, 608, 2, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 15, 10, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 1, 1048833, "", 12340);

-- cat (pet)
REPLACE INTO creature_template VALUES(35610, 35774, 35775, 35776, 0, 0, 2031, 0, 0, 0, "Cat", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 0, 2048, 8, 2, 0, 0, 0, 0, 345, 509, 103, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "npc_toc_pet_hunter", 12340);
REPLACE INTO creature_template VALUES(35774, 0, 0, 0, 0, 0, 2031, 0, 0, 0, "Cat (1)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 4, 0, 0, 1, 0, 2048, 8, 2, 0, 0, 0, 0, 345, 509, 103, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(35775, 0, 0, 0, 0, 0, 2031, 0, 0, 0, "Cat (2)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 2, 0, 0, 1, 0, 2048, 8, 2, 0, 0, 0, 0, 345, 509, 103, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(35776, 0, 0, 0, 0, 0, 2031, 0, 0, 0, "Cat (3)", "", "", 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 5, 0, 0, 1, 0, 2048, 8, 2, 0, 0, 0, 0, 345, 509, 103, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 55, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);

-- treant (druid summon)
REPLACE INTO creature_template VALUES(36070, 36473, 36474, 36475, 0, 0, 18922, 0, 0, 0, "Treant", "", "", 0, 80, 80, 0, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(36473, 0, 0, 0, 0, 0, 18922, 0, 0, 0, "Treant (1)", "", "", 0, 80, 80, 0, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 4, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048577, "", 12340);
REPLACE INTO creature_template VALUES(36474, 0, 0, 0, 0, 0, 18922, 0, 0, 0, "Treant (2)", "", "", 0, 80, 80, 0, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 2, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 2.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);
REPLACE INTO creature_template VALUES(36475, 0, 0, 0, 0, 0, 18922, 0, 0, 0, "Treant (3)", "", "", 0, 80, 80, 0, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 5, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1048833, "", 12340);


-- creature_template_addon
REPLACE INTO creature_template_addon VALUES(34467, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35662, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35663, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35664, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34466, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35665, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35666, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35667, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34471, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35668, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35669, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35670, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(34451, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35671, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35672, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35673, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34473, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(35674, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(35675, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(35676, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(34455, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35680, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35681, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35682, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34447, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35683, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35684, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35685, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34459, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35686, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35687, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35688, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34449, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35689, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35690, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35691, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34458, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35692, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35693, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35694, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34450, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35695, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35696, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35697, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34472, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35699, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35700, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35701, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34460, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35702, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35703, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35704, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34445, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35705, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35706, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35707, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34456, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35708, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35709, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(35710, 0, 0, 0, 0, 0, "68595 66004");
REPLACE INTO creature_template_addon VALUES(34454, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35711, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35712, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35713, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34469, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35714, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35715, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35716, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34453, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35718, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35719, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35720, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34468, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35721, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35722, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35723, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34448, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35724, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35725, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35726, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34470, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35728, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35729, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35730, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34474, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35731, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35732, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35733, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34463, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35734, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35735, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35736, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34475, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35737, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35738, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35739, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34444, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35740, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35741, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35742, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34461, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35743, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35744, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35745, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34465, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35746, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35747, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(35748, 0, 0, 0, 0, 0, "68595");
REPLACE INTO creature_template_addon VALUES(34441, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(34442, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(34443, 0, 0, 0, 0, 0, "68595 16592");
REPLACE INTO creature_template_addon VALUES(35749, 0, 0, 0, 0, 0, "68595 16592");

-- SPELLS
-- hunter wyvern sting
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65877,-65877);
REPLACE INTO spell_linked_spell VALUES(-65877, 65878, 0, "");

-- TC Script remove, no spawn in creature table
UPDATE creature_template SET ScriptName='' WHERE ScriptName='boss_toc_champion_controller' AND entry=34781;
DELETE FROM spell_script_names WHERE ScriptName IN('spell_toc_bloodlust', 'spell_toc_heroism') AND spell_id IN(65980, 65983);
DELETE FROM spell_script_names WHERE ScriptName IN('spell_faction_champion_death_grip') AND spell_id IN(66017, 68753, 68754, 68755);




-- ###################
-- ### Twin Valkyr
-- ###################

-- Lightbane (34497, 35350, 35351, 35352)
REPLACE INTO `creature_template` VALUES (34497, 35350, 35351, 35352, 0, 0, 29240, 0, 0, 0, 'Fjola Lightbane', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 34497, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 686120, 686120, '', 0, 3, 6, 435, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, 'boss_fjola', 12340);
REPLACE INTO `creature_template` VALUES (35350, 0, 0, 0, 0, 0, 29240, 0, 0, 0, 'Fjola Lightbane (1)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 40, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 686120, 686120, '', 0, 3, 6, 2000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35351, 0, 0, 0, 0, 0, 29240, 0, 0, 0, 'Fjola Lightbane (2)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 25, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 686120, 686120, '', 0, 3, 6, 600, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35352, 0, 0, 0, 0, 0, 29240, 0, 0, 0, 'Fjola Lightbane (3)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 45, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35352, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 686120, 686120, '', 0, 3, 6, 2800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34497, 35350, 35351, 35352);
REPLACE INTO creature_template_addon VALUES(34497, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35350, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35351, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35352, 0, 0, 50331648, 1, 0, '');

-- Darkbane (34496, 35347, 35348, 35349)
REPLACE INTO `creature_template` VALUES (34496, 35347, 35348, 35349, 0, 0, 29267, 0, 0, 0, 'Eydis Darkbane', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 20, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 34496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 676573, 676573, '', 0, 3, 6, 435, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, 'boss_eydis', 12340);
REPLACE INTO `creature_template` VALUES (35347, 0, 0, 0, 0, 0, 29267, 0, 0, 0, 'Eydis Darkbane (1)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 40, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35347, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 676573, 676573, '', 0, 3, 6, 2000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35348, 0, 0, 0, 0, 0, 29267, 0, 0, 0, 'Eydis Darkbane (2)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 25, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35348, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 676573, 676573, '', 0, 3, 6, 600, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35349, 0, 0, 0, 0, 0, 29267, 0, 0, 0, 'Eydis Darkbane (3)', '', '', 0, 83, 83, 2, 16, 0, 2, 1.5, 1, 3, 496, 674, 0, 783, 45, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 108, 35349, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 676573, 676573, '', 0, 3, 6, 2800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34496, 35347, 35348, 35349);
REPLACE INTO creature_template_addon VALUES(34496, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35347, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35348, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(35349, 0, 0, 50331648, 1, 0, '');

-- Dark Essence (34567), Light Essence (34568)
REPLACE INTO `creature_template` VALUES (34567, 0, 0, 0, 0, 0, 29270, 0, 0, 0, 'Dark Essence', '', '', 0, 83, 83, 2, 35, 1, 1, 1.14286, 1, 3, 1, 1, 0, 0, 1, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 10, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 3, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_essence_of_twin', 12340);
REPLACE INTO `creature_template` VALUES (34568, 0, 0, 0, 0, 0, 29286, 0, 0, 0, 'Light Essence', '', '', 0, 83, 83, 2, 35, 1, 1, 1.14286, 1, 3, 1, 1, 0, 0, 1, 0, 0, 2, 2, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 10, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 3, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_essence_of_twin', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34567,34568);

-- Concentrated Darkness (34628), Concentrated Light (34630)
REPLACE INTO `creature_template` VALUES (34628, 0, 0, 0, 0, 0, 29308, 0, 0, 0, 'Concentrated Darkness', '', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 106, 1, 0, 0, 'npc_concentrated_ball', 12340);
REPLACE INTO `creature_template` VALUES (34630, 0, 0, 0, 0, 0, 29352, 0, 0, 0, 'Concentrated Light', '', '', 0, 82, 82, 2, 14, 0, 1, 1.14286, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 106, 1, 0, 0, 'npc_concentrated_ball', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34628,34630);

-- SPELLS
DELETE FROM spell_script_names WHERE spell_id IN(65686,67222,67223,67224,65684,67176,67177,67178);
REPLACE INTO spell_script_names VALUES(65686, "spell_valkyr_essence"),(67222, "spell_valkyr_essence"),(67223, "spell_valkyr_essence"),(67224, "spell_valkyr_essence"),(65684, "spell_valkyr_essence"),(67176, "spell_valkyr_essence"),(67177, "spell_valkyr_essence"),(67178, "spell_valkyr_essence");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65875,67303,67304,67305,65876,67306,67307,67308);

DELETE FROM spell_script_names WHERE spell_id IN(65950,67296,67297,67298,66001,67281,67282,67283);
REPLACE INTO spell_script_names VALUES(65950, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67296, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67297, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67298, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(66001, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67281, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67282, "spell_valkyr_touch");
REPLACE INTO spell_script_names VALUES(67283, "spell_valkyr_touch");

-- custom spell - ball periodic dummy
REPLACE INTO `spell_dbc` VALUES (100101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 21, 1, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twin Val\'kyr - Ball periodic dummy');
REPLACE INTO spell_script_names VALUES(100101, "spell_valkyr_ball_periodic_dummy");

-- TC Script remove, no spawn in creature table
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_bullet_controller' AND entry=34743;
DELETE FROM spell_script_names WHERE ScriptName='spell_power_of_the_twins' AND spell_id IN(65879, 65916, 67244, 67245, 67246, 67248, 67249, 67250);
DELETE FROM spell_script_names WHERE ScriptName='spell_powering_up' AND spell_id IN(67590, 67602, 67603, 67604);




-- ###################
-- ### Anub'arak
-- ###################

-- Anub'arak (34564, 34566, 35615, 35616)
REPLACE INTO `creature_template` VALUES (34564, 34566, 35615, 35616, 0, 0, 29268, 0, 0, 0, 'Anub\'arak', '', '', 0, 83, 83, 2, 14, 0, 1, 1.3, 1, 3, 1200, 1300, 0, 805, 50, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 34564, 0, 70214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 569703, 569703, '', 0, 3, 1, 300, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 650854271, 1+0x200000, 'boss_anubarak_trial', 12340);
REPLACE INTO `creature_template` VALUES (34566, 0, 0, 0, 0, 0, 29268, 0, 0, 0, 'Anub\'arak (1)', '', '', 0, 83, 83, 2, 14, 0, 1, 1.3, 1, 3, 1200, 1300, 0, 805, 75, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 34566, 0, 70214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 569703, 569703, '', 0, 3, 1, 1500, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35615, 0, 0, 0, 0, 0, 29268, 0, 0, 0, 'Anub\'arak (2)', '', '', 0, 83, 83, 2, 14, 0, 1, 1.3, 1, 3, 1200, 1300, 0, 805, 60, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 35615, 0, 70214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 569703, 569703, '', 0, 3, 1, 390, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 650854271, 1+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (35616, 0, 0, 0, 0, 0, 29268, 0, 0, 0, 'Anub\'arak (3)', '', '', 0, 83, 83, 2, 14, 0, 1, 1.3, 1, 3, 1200, 1300, 0, 805, 90, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 35616, 0, 70214, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 569703, 569703, '', 0, 3, 1, 1950, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 650854271, 1+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34564, 34566, 35615, 35616);
REPLACE INTO creature_model_info VALUES(29268, 1.5, 10, 2, 0);

-- Swarm Scarab (34605, 34650, 35658, 35659)
REPLACE INTO `creature_template` VALUES (34605, 34650, 35658, 35659, 0, 0, 15464, 0, 0, 0, 'Swarm Scarab', '', '', 0, 78, 80, 2, 16, 0, 1, 0.9, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 91, 1, 549520145, 0, 'npc_swarm_scarab', 12340);
REPLACE INTO `creature_template` VALUES (34650, 0, 0, 0, 0, 0, 15464, 0, 0, 0, 'Swarm Scarab (1)', '', '', 0, 78, 80, 2, 16, 0, 1, 0.9, 1, 0, 422, 586, 0, 0, 3, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 9, 1, 1, 0, 0, 0, 0, 0, 0, 0, 91, 1, 549520145, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (35658, 0, 0, 0, 0, 0, 15464, 0, 0, 0, 'Swarm Scarab (2)', '', '', 0, 78, 80, 2, 16, 0, 1, 0.9, 1, 0, 422, 586, 0, 0, 2, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.95, 1, 1, 0, 0, 0, 0, 0, 0, 0, 701, 1, 549520145, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (35659, 0, 0, 0, 0, 0, 15464, 0, 0, 0, 'Swarm Scarab (3)', '', '', 0, 78, 80, 2, 16, 0, 1, 0.9, 1, 0, 422, 586, 0, 0, 4, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 11.7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 701, 1, 549520145, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34605, 34650, 35658, 35659);

-- Nerubian Burrow (34862)
REPLACE INTO `creature_template` VALUES (34862, 0, 0, 0, 0, 0, 28549, 0, 0, 0, 'Nerubian Burrow', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1.65, 0, 2, 2, 0, 24, 1, 0, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template_addon VALUES(34862, 0, 0, 0, 1, 0, "66969");

-- Frost Sphere (34606, 34649, 3460602, 3460603);
REPLACE INTO `creature_template` VALUES (34606, 34649, 3460602, 3460603, 0, 0, 25144, 0, 0, 0, 'Frost Sphere', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.238095, 1, 1, 0, 0, 0, 0, 0, 0, 0, 721, 0, 0, 0, 'npc_frost_sphere', 12340);
REPLACE INTO `creature_template` VALUES (34649, 0, 0, 0, 0, 0, 25144, 0, 0, 0, 'Frost Sphere (1)', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.714286, 1, 1, 0, 0, 0, 0, 0, 0, 0, 721, 0, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (3460602, 0, 0, 0, 0, 0, 25144, 0, 0, 0, 'Frost Sphere (2)', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.238095, 1, 1, 0, 0, 0, 0, 0, 0, 0, 721, 0, 0, 0, '', 1);
REPLACE INTO `creature_template` VALUES (3460603, 0, 0, 0, 0, 0, 25144, 0, 0, 0, 'Frost Sphere (3)', '', '', 0, 79, 80, 2, 1925, 0, 1, 1.14286, 1, 0, 422, 586, 0, 0, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 8, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 0.238095, 1, 1, 0, 0, 0, 0, 0, 0, 0, 721, 0, 0, 0, '', 1);
DELETE FROM creature_template_addon WHERE entry IN(34606, 34649, 3460602, 3460603);

-- Nerubian Burrower (34607, 34648, 35655, 35656)
REPLACE INTO `creature_template` VALUES (34607, 34648, 35655, 35656, 0, 0, 29325, 0, 0, 0, 'Nerubian Burrower', '', '', 0, 78, 78, 2, 16, 0, 1, 1.14286, 1, 1, 387, 543, 0, 0, 12, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16.2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 549520145, 0, 'npc_nerubian_burrower', 12340);
REPLACE INTO `creature_template` VALUES (34648, 0, 0, 0, 0, 0, 29325, 0, 0, 0, 'Nerubian Burrower (1)', '', '', 0, 78, 78, 2, 16, 0, 1, 1.14286, 1, 1, 387, 543, 0, 0, 24, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 48.6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 549520145, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (35655, 0, 0, 0, 0, 0, 29325, 0, 0, 0, 'Nerubian Burrower (2)', '', '', 0, 78, 78, 2, 16, 0, 1, 1.14286, 1, 1, 387, 543, 0, 0, 16, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 18, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 549520145, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (35656, 0, 0, 0, 0, 0, 29325, 0, 0, 0, 'Nerubian Burrower (3)', '', '', 0, 78, 78, 2, 16, 0, 1, 1.14286, 1, 1, 387, 543, 0, 0, 32, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 324, 480, 88, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 54, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 549520145, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34607, 34648, 35655, 35656);

-- Anub'arak Spike (34660)
REPLACE INTO `creature_template` VALUES (34660, 0, 0, 0, 0, 0, 17612, 0, 0, 0, 'Anub\'arak', '', '', 0, 83, 83, 2, 16, 0, 1, 0.5, 1, 3, 1, 1, 0, 1, 1, 0, 0, 1, 33587200, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 1036, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 650854271, 0+0x200000, 'npc_anubarak_spike', 12340);
DELETE FROM creature_template_addon WHERE entry IN(34660);

-- SPELLS:
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66332,67755,67756,67757);
INSERT INTO `conditions` VALUES (13, 1, 66332, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67755, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67756, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67757, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 66332, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67755, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67756, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');
INSERT INTO `conditions` VALUES (13, 1, 67757, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Nerubian Burrowers');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66339);
-- INSERT INTO `conditions` VALUES (13, 1, 66339, 0, 0, 31, 0, 3, 34862, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Scarab');
-- INSERT INTO `conditions` VALUES (13, 1, 66339, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak summon Scarab');

DELETE FROM spell_script_names WHERE spell_id IN(66118,67630,68646,68647,66240, 65920,65922,65923);
REPLACE INTO spell_script_names VALUES(66118, "spell_gen_leeching_swarm");
REPLACE INTO spell_script_names VALUES(67630, "spell_gen_leeching_swarm");
REPLACE INTO spell_script_names VALUES(68646, "spell_gen_leeching_swarm");
REPLACE INTO spell_script_names VALUES(68647, "spell_gen_leeching_swarm");
REPLACE INTO spell_script_names VALUES(66240, "spell_gen_leeching_swarm_dmg");


REPLACE INTO spell_script_names VALUES(65920, "spell_pursuing_spikes");
REPLACE INTO spell_script_names VALUES(65922, "spell_pursuing_spikes");
REPLACE INTO spell_script_names VALUES(65923, "spell_pursuing_spikes");

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66129);
INSERT INTO `conditions` VALUES (13, 3, 66129, 0, 0, 31, 0, 3, 34607, 0, 0, 0, 0, '', 'Target for Nerubian Burrower\'s Spider Frenzy');
INSERT INTO `conditions` VALUES (13, 3, 66129, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Nerubian Burrower\'s Spider Frenzy');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66170);
INSERT INTO `conditions` VALUES (13, 3, 66170, 0, 0, 31, 0, 3, 34660, 0, 0, 0, 0, '', 'Target for Anub\'arak to teleport to Spike');
INSERT INTO `conditions` VALUES (13, 3, 66170, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak to teleport to Spike');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(66181);
INSERT INTO `conditions` VALUES (13, 1, 66181, 0, 0, 31, 0, 3, 34606, 0, 0, 0, 0, '', 'Target for Anub\'arak Impale Fail');
INSERT INTO `conditions` VALUES (13, 1, 66181, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target for Anub\'arak Impale Fail');

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_impale' AND spell_id=65919;




-- ###################
-- ### LOOT corrections
-- ###################

-- icehowl
UPDATE creature_loot_template SET maxcount=3 WHERE entry=35447 AND mincountOrRef IN(-34320,-34327);
UPDATE creature_loot_template SET maxcount=3 WHERE entry=35449 AND mincountOrRef IN(-34334,-34341);

-- jaraxxus
UPDATE creature_loot_template SET maxcount=3 WHERE entry=35216 AND mincountOrRef IN(-34321,-34328);
UPDATE creature_loot_template SET maxcount=3 WHERE entry=35269 AND mincountOrRef IN(-34335,-34342);
-- [item] Dual-Blade Butcher (47446)
DELETE FROM creature_loot_template WHERE item IN(47446, 47285);
DELETE FROM reference_loot_template WHERE item IN(47446, 47285);
DELETE FROM gameobject_loot_template WHERE item IN(47446, 47285);
REPLACE INTO reference_loot_template VALUES(34332, 47285, 0, 1, 1, 1, 1);
REPLACE INTO reference_loot_template VALUES(34346, 47446, 0, 1, 1, 1, 1);

-- champions' cache
UPDATE gameobject_loot_template SET maxcount=3 WHERE entry=27503 AND mincountOrRef IN(-34325,-34332);
UPDATE gameobject_loot_template SET maxcount=3 WHERE entry=27356 AND mincountOrRef IN(-34339,-34346);
UPDATE gameobject_template SET flags=0, ScriptName="go_toc_champions_cache" WHERE entry IN(195631,195632,195633,195635);

-- Argent Crusade Tribute Chest - just for sure set flags to 0
UPDATE gameobject_template SET flags=0 WHERE entry IN(195671,195672,195670,195669,195668,195667,195666,195665);

-- fjola
UPDATE creature_loot_template SET maxcount=2 WHERE entry=35350 AND mincountOrRef IN(-34322,-34329);
UPDATE creature_loot_template SET maxcount=2 WHERE entry=35352 AND mincountOrRef IN(-34336,-34343);

-- patterns, plans, etc.
UPDATE creature_loot_template SET ChanceOrQuestChance=15 WHERE mincountOrRef IN(-34326,-34333,-34312,-34319,-34340,-34347);
UPDATE gameobject_loot_template SET ChanceOrQuestChance=15 WHERE mincountOrRef IN(-34326,-34333,-34312,-34319,-34340,-34347);



-- ###################
-- ### TEXTS
-- ###################

-- fixups
DELETE FROM creature_text WHERE entry IN(35144, 34799);
REPLACE INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(35144, 0, 0, 'Upon seeing its companion perish, %s becomes enraged!', 41, 0, 100, 0, 0, 0, 'Acidmaw to Beasts Controller - Enrage'),
(34799, 0, 0, 'Upon seeing its companion perish, %s becomes enraged!', 41, 0, 100, 0, 0, 0, 'Dreadscale to Beasts Controller - Enrage'),
(35144, 1, 0, '%s buries itself in the earth!', 41, 0, 100, 0, 0, 0, 'Acidmaw to Beasts Controller - Submerge'),
(34799, 1, 0, '%s buries itself in the earth!', 41, 0, 100, 0, 0, 0, 'Dreadscale to Beasts Controller - Submerge'),
(35144, 2, 0, '%s getting out of the ground!', 41, 0, 100, 0, 0, 0, 'Acidmaw to Beasts Controller - Emerge'),
(34799, 2, 0, '%s getting out of the ground!', 41, 0, 100, 0, 0, 0, 'Dreadscale to Beasts Controller - Emerge'),
(34496, 1, 0, 'Let the light consume you!', 14, 0, 100, 0, 0, 16279, 'Eydis Darkbane to Fjola Lightbane - Light Vortex'),
(34496, 2, 0, 'Let the dark consume you!', 14, 0, 100, 0, 0, 16278, 'Eydis Darkbane to Fjola Lightbane - Dark Vortex'),
(34497, 1, 0, 'Let the light consume you!', 14, 0, 100, 0, 0, 16279, 'Fjola Lightbane to Fjola Lightbane - Light Vortex'),
(34497, 2, 0, 'Let the dark consume you!', 14, 0, 100, 0, 0, 16278, 'Fjola Lightbane to Fjola Lightbane - Dark Vortex');
DELETE FROM creature_text WHERE entry IN(34496, 34497) AND groupid IN(6, 9);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(34496, 6, 0, 'You have been measured and found wanting.', 14, 0, 100, 0, 0, 16276, 'Eydis Darkbane - Killing a player'),
(34496, 9, 0, 'UNWORTHY!', 14, 0, 100, 0, 0, 16276, 'Eydis Darkbane - Killing a player'),
(34497, 6, 0, 'You have been measured and found wanting.', 14, 0, 100, 0, 0, 16276, 'Fjola Lightbane - Killing a player'),
(34497, 9, 0, 'UNWORTHY!', 14, 0, 100, 0, 0, 16276, 'Fjola Lightbane - Killing a player');
DELETE FROM creature_text WHERE entry IN(36095) OR (entry=34996 AND groupid IN(17,18));
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(34996, 17, 0, 'Champions, you''re alive! Not only have you defeated every challenge of the Trial of the Crusader, but also thwarted Arthas'' plans! Your skill and cunning will prove to be a powerful weapon against the Scourge. Well done! Allow one of the Crusade''s mages to transport you to the surface!', 14, 0, 100, 5, 0, 0, 'Highlord Tirion Fordring'),
(34996, 18, 0, 'Let me hand you the chests as a reward, and let its contents will serve you faithfully in the campaign against Arthas in the heart of the Icecrown Citadel!', 14, 0, 100, 0, 0, 0, 'Highlord Tirion Fordring');

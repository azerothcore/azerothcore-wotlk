-- Disable Map
DELETE FROM disables WHERE sourceType=2 AND entry=533;
DELETE FROM gameobject WHERE id IN(181575, 181576, 181577, 181578);
INSERT INTO gameobject VALUES (NULL, 181577, 533, 3, 2, 2909, -4025.02, 273.475, 3.14159, 0, 0, 1, 0, 180, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 181575, 533, 3, 2, 3506.49, -3916.63, 297.202, 2.19599, 0, 0, 0.890296, 0.455383, 180, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 181578, 533, 3, 2, 2504.5, -2934.66, 241.278, 5.43577, 0, 0, 0.411143, -0.911571, 180, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 181576, 533, 3, 2, 3507.95, -2900.4, 302.459, 0.369949, 0, 0, 0.183921, 0.982941, 180, 0, 1, 0);
UPDATE gameobject_template SET flags=6553632 WHERE entry IN(181575, 181576, 181577, 181578);
REPLACE INTO spell_target_position VALUES(28444, 0, 533, 3038.98, -3434.47, 298.22, 0);

-- fix frostwyrm area trigger
UPDATE gameobject_template SET data3=0 WHERE entry=202278;
DELETE FROM gameobject WHERE id=202278;
INSERT INTO gameobject VALUES(NULL, 202278, 533, 3, 1, 3498.3, -5349.49, 144.968, 1.36891, 0, 0, 0.632249, 0.774765, 300, 0, 1, 0);
REPLACE INTO spell_target_position VALUES(72617, 0, 533, 3038.98, -3434.47, 298.22, 0);
REPLACE INTO areatrigger_teleport VALUES(4156, "Naxxramas (to frostwyrm lair)", 533, 3500.87, -5339.03, 145, 1.34);

-- ------------------------------
-- BOSSES
-- ------------------------------
-- Patchwerk
UPDATE creature_text SET text="%s goes into a berserker rage!" WHERE entry=16028 and groupid=3;
REPLACE INTO creature_template VALUES (16028, 29324, 0, 0, 0, 0, 16174, 0, 0, 0, 'Patchwerk', '', '', 0, 83, 83, 2, 21, 0, 2, 1.14286, 1, 3, 509, 683, 0, 805, 35, 1200, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 16028, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 28131, 32309, 0, 0, 0, 0, 0, 0, 0, 1305000, 1595000, '', 0, 3, 1, 310, 2, 1, 0, 0, 0, 0, 0, 0, 0, 169, 1, 617299839, 1+0x200000, 'boss_patchwerk', 12340);
REPLACE INTO creature_template VALUES (29324, 0, 0, 0, 0, 0, 16174, 0, 0, 0, 'Patchwerk (1)', '', '', 0, 83, 83, 2, 21, 0, 2, 1.14286, 1, 3, 509, 683, 0, 805, 70, 1200, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29324, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2610000, 3190000, '', 0, 3, 1, 935, 2, 1, 0, 0, 0, 0, 0, 0, 0, 169, 1, 617299839, 1+0x200000, '', 12340);


-- Grobbulus
REPLACE INTO creature_template VALUES (15931, 29373, 0, 0, 0, 0, 16035, 0, 0, 0, 'Grobbulus', '', '', 0, 83, 83, 2, 21, 0, 1.5, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15931, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1283823, 1569117, '', 0, 3, 1, 210, 2, 1, 0, 0, 0, 0, 0, 0, 0, 166, 1, 617299839, 1+0x200000, 'boss_grobbulus', 12340);
REPLACE INTO creature_template VALUES (29373, 0, 0, 0, 0, 0, 16035, 0, 0, 0, 'Grobbulus (1)', '', '', 0, 83, 83, 2, 21, 0, 1.5, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29373, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2567646, 3138234, '', 0, 3, 1, 685, 2, 1, 0, 0, 0, 0, 0, 0, 0, 166, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16363, 29379, 0, 0, 0, 0, 11686, 0, 0, 0, 'Grobbulus Cloud', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 'boss_grobbulus_poison_cloud', 12340);
REPLACE INTO creature_template VALUES (29379, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Grobbulus Cloud (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16290, 29388, 0, 0, 0, 0, 12349, 0, 0, 0, 'Fallout Slime', '', '', 0, 80, 80, 2, 14, 0, 1.5, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 1150, 1265, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29388, 0, 0, 0, 0, 0, 12349, 0, 0, 0, 'Fallout Slime (1)', '', '', 0, 80, 80, 2, 14, 0, 1.5, 1.14286, 1, 1, 422, 586, 0, 642, 13, 1150, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 15, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template_addon VALUES(16290, 0, 0, 0, 1, 0, "28156"); -- Fallout Slime
REPLACE INTO creature_template_addon VALUES(29388, 0, 0, 0, 1, 0, "54367");
REPLACE INTO creature_template_addon VALUES(16363, 0, 0, 0, 1, 0, ""); -- Poison Cloud
REPLACE INTO creature_template_addon VALUES(29379, 0, 0, 0, 1, 0, "");
DELETE FROM smart_scripts WHERE entryorguid IN(16290) AND source_type=0;
INSERT INTO smart_scripts VALUES(16290, 0, 0, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-28169);
INSERT INTO spell_linked_spell VALUES(-28169, 28206, 0, "Mutating Injection - Mutagen Explosion");
INSERT INTO spell_linked_spell VALUES(-28169, 28240, 0, "Mutating Injection - Poison Cloud");
DELETE FROM spell_script_names WHERE spell_id IN(28241, 54363);
INSERT INTO spell_script_names VALUES(28241, "spell_grobbulus_poison");
INSERT INTO spell_script_names VALUES(54363, "spell_grobbulus_poison");
REPLACE INTO spell_target_position VALUES(28280, 0, 533, 3128.96, -3312.96, 293.25, 0.0);
-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_grobbulus_poison_cloud' AND spell_id IN(28158, 54362);
DELETE FROM spell_script_names WHERE ScriptName='spell_grobbulus_mutating_injection' AND spell_id=28169;
	


-- Gluth
REPLACE INTO creature_template VALUES (15932, 29417, 0, 0, 0, 0, 16064, 0, 0, 0, 'Gluth', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 1600, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15932, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1260000, 1540000, '', 0, 3, 1, 200, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_gluth', 12340);
REPLACE INTO creature_template VALUES (29417, 0, 0, 0, 0, 0, 16064, 0, 0, 0, 'Gluth (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 1600, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29417, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2520000, 3080000, '', 0, 3, 1, 605, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16360, 30303, 0, 0, 0, 0, 10976, 10975, 5432, 5265, 'Zombie Chow', '', '', 0, 80, 80, 2, 89, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 1, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 40, 3, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30303, 0, 0, 0, 0, 0, 10976, 10975, 5432, 5265, 'Zombie Chow (1)', '', '', 0, 80, 80, 2, 89, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 1, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 80, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=28404;
INSERT INTO conditions VALUES(13, 1, 28404, 0, 0, 31, 0, 3, 16360, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28404, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(28374, 54426);
INSERT INTO conditions VALUES(13, 1, 28374, 0, 0, 31, 0, 3, 16360, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28374, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28374, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28374, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 54426, 0, 0, 31, 0, 3, 16360, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 54426, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 54426, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 54426, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
REPLACE INTO creature_template_addon VALUES(16360, 0, 0, 0, 1, 0, "29307");
REPLACE INTO creature_template_addon VALUES(30303, 0, 0, 0, 1, 0, "29307");
DELETE FROM spell_script_names WHERE spell_id IN(28374, 54426);
INSERT INTO spell_script_names VALUES(28374, "spell_gluth_decimate");
INSERT INTO spell_script_names VALUES(54426, "spell_gluth_decimate");
DELETE FROM smart_scripts WHERE entryorguid IN(16360) AND source_type=0;
INSERT INTO smart_scripts VALUES(16360, 0, 0, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
REPLACE INTO spell_proc_event VALUES(29307, 0, 0, 0, 0, 0, 4, 65536+2+1, 0, 100, 0);

-- Noth
REPLACE INTO creature_template VALUES (15954, 29615, 0, 0, 0, 0, 16590, 0, 0, 0, 'Noth the Plaguebringer', '', '', 0, 83, 83, 2, 21, 0, 1, 1.71429, 1, 3, 496, 674, 0, 783, 35, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 15954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1265652, 1546909, '', 0, 3, 1, 200, 30, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_noth', 12340);
REPLACE INTO creature_template VALUES (29615, 0, 0, 0, 0, 0, 16590, 0, 0, 0, 'Noth the Plaguebringer (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.71429, 1, 3, 496, 674, 0, 783, 70, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 29615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2531304, 3093818, '', 0, 3, 1, 605, 30, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16984, 29632, 0, 0, 0, 0, 28022, 0, 0, 0, 'Plagued Warrior', '', '', 0, 81, 81, 2, 21, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29632, 0, 0, 0, 0, 0, 28022, 0, 0, 0, 'Plagued Warrior (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16983, 29633, 0, 0, 0, 0, 28021, 0, 0, 0, 'Plagued Champion', '', '', 0, 81, 81, 2, 21, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29633, 0, 0, 0, 0, 0, 28021, 0, 0, 0, 'Plagued Champion (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16981, 29634, 0, 0, 0, 0, 27107, 0, 0, 0, 'Plagued Guardian', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 7.5, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 5, 18, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29634, 0, 0, 0, 0, 0, 27107, 0, 0, 0, 'Plagued Guardian (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 13, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 8, 18, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO spell_target_position VALUES(29216, 0, 533, 2631.37, -3529.68, 274.04, 0);
DELETE FROM smart_scripts WHERE entryorguid IN(16984, 16983, 16981) AND source_type=0;
-- Plagued Warrior
INSERT INTO smart_scripts VALUES(16984, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 7000, 9000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16984, 0, 1, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
-- Plagued Champion
INSERT INTO smart_scripts VALUES(16983, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 9000, 11000, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16983, 0, 1, 0, 0, 0, 100, 2, 5000, 8000, 13000, 15000, 11, 30138, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16983, 0, 2, 0, 0, 0, 100, 4, 5000, 8000, 13000, 15000, 11, 54889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16983, 0, 3, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
-- Plagued Guardian
INSERT INTO smart_scripts VALUES(16981, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 8000, 11000, 11, 54890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16981, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 8000, 11000, 11, 54891, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16981, 0, 2, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");


-- Heigan
REPLACE INTO creature_template VALUES (15936, 29701, 0, 0, 0, 0, 16309, 0, 0, 0, 'Heigan the Unclean', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1280454, 1565000, '', 0, 3, 1, 220, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_heigan', 12340);
REPLACE INTO creature_template VALUES (29701, 0, 0, 0, 0, 0, 16309, 0, 0, 0, 'Heigan the Unclean (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2560908, 3130000, '', 0, 3, 1, 665, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_heigan_eruption' AND spell_id=29371;


-- Loatheb
REPLACE INTO creature_template VALUES (16011, 29718, 0, 0, 0, 0, 16110, 0, 0, 0, 'Loatheb', NULL, NULL, 0, 83, 83, 2, 21, 0, 0.8, 1.14286, 1, 3, 509, 683, 0, 805, 35, 1250, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 16011, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1292142, 1579285, '', 0, 3, 1, 480, 2, 1, 0, 0, 0, 0, 0, 0, 0, 180, 1, 617299839, 1+0x200000, 'boss_loatheb', 12340);
REPLACE INTO creature_template VALUES (29718, 0, 0, 0, 0, 0, 16110, 0, 0, 0, 'Loatheb (1)', '', '', 0, 83, 83, 2, 21, 0, 0.8, 1.14286, 1, 3, 509, 683, 0, 805, 70, 1250, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29718, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2584284, 3158570, '', 0, 3, 1, 1450, 2, 1, 0, 0, 0, 0, 0, 0, 0, 180, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16286, 30068, 0, 0, 0, 0, 16111, 0, 0, 0, 'Spore', '', '', 0, 80, 80, 2, 21, 0, 0.4, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 0.1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30068, 0, 0, 0, 0, 0, 16111, 0, 0, 0, 'Spore (1)', '', '', 0, 80, 80, 2, 21, 0, 0.4, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(16286) AND source_type=0;
INSERT INTO smart_scripts VALUES(16286, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 29232, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Death");
INSERT INTO smart_scripts VALUES(16286, 0, 1, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-29865, -55053);
INSERT INTO spell_linked_spell VALUES(-29865, 55594, 0, "Deathbloom");
INSERT INTO spell_linked_spell VALUES(-55053, 55601, 0, "Deathbloom (H)");


-- Anub'Rekhan
REPLACE INTO creature_template VALUES (15956, 29249, 0, 0, 0, 0, 15931, 0, 0, 0, 'Anub\'Rekhan', '', NULL, 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15956, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1125000, 1375000, '', 0, 3, 1, 160, 2, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, 'boss_anubrekhan', 12340);
REPLACE INTO creature_template VALUES (29249, 0, 0, 0, 0, 0, 15931, 0, 0, 0, 'Anub\'Rekhan (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29249, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2250000, 2750000, '', 0, 3, 1, 485, 2, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16573, 29256, 0, 0, 0, 0, 14698, 0, 0, 0, 'Crypt Guard', '', NULL, 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 18, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29256, 0, 0, 0, 0, 0, 14698, 0, 0, 0, 'Crypt Guard (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1150, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 40, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16698, 29267, 0, 0, 0, 0, 27943, 0, 0, 0, 'Corpse Scarab', '', NULL, 0, 80, 80, 2, 21, 0, 0.833332, 1.14286, 1, 0, 422, 586, 0, 642, 1, 1000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29267, 0, 0, 0, 0, 0, 27943, 0, 0, 0, 'Corpse Scarab (1)', '', '', 0, 80, 80, 2, 21, 0, 0.833332, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(16573, 16698) AND source_type=0;
INSERT INTO smart_scripts VALUES(16573, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 7000, 9000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16573, 0, 1, 0, 0, 0, 100, 2, 500, 500, 5000, 7000, 11, 28969, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16573, 0, 2, 0, 0, 0, 100, 4, 500, 500, 5000, 7000, 11, 56098, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16573, 0, 3, 0, 2, 1, 100, 0, 0, 30, 120000, 120000, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16573, 0, 4, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
INSERT INTO smart_scripts VALUES(16698, 0, 0, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");


-- Grand Widow Faerlina
REPLACE INTO creature_template VALUES (15953, 29268, 0, 0, 0, 0, 15940, 0, 0, 0, 'Grand Widow Faerlina', '', NULL, 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 76, 15953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1172787, 1954645, '', 0, 3, 1, 160, 20, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_faerlina', 12340);
REPLACE INTO creature_template VALUES (29268, 0, 0, 0, 0, 0, 15940, 0, 0, 0, 'Grand Widow Faerlina (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 70, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 76, 29268, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2345574, 3909290, '', 0, 3, 1, 485, 20, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16506, 29274, 0, 0, 0, 0, 16603, 16604, 0, 0, 'Naxxramas Worshipper', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 16506, 0, 0, 0, 0, 0, 0, 0, 0, 54095, 28732, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 10, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 65536+1, 0, '', 12340); -- immune to mind control
REPLACE INTO creature_template VALUES (29274, 0, 0, 0, 0, 0, 16603, 16604, 0, 0, 'Naxxramas Worshipper (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 16506, 0, 0, 0, 0, 0, 0, 0, 0, 54096, 28732, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 10, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 65536+1, 0, '', 12340);
REPLACE INTO creature_template VALUES (16505, 29273, 0, 0, 0, 0, 16605, 16606, 0, 0, 'Naxxramas Follower', '', NULL, 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 16, 10, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 65536, 0, '', 12340);
REPLACE INTO creature_template VALUES (29273, 0, 0, 0, 0, 0, 16605, 16606, 0, 0, 'Naxxramas Follower (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1150, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 40, 10, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 65536, 0, '', 12340);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(28732);
INSERT INTO conditions VALUES(13, 1, 28732, 0, 0, 31, 0, 3, 15953, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28732, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM smart_scripts WHERE entryorguid IN(16506, 16505) AND source_type=0;
UPDATE creature_template SET skinloot=29724 WHERE entry=29724;
-- Naxxramas Worshipper
INSERT INTO smart_scripts VALUES(16506, 0, 0, 0, 0, 0, 100, 2, 4000, 5000, 7000, 9000, 11, 54095, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16506, 0, 1, 0, 0, 0, 100, 4, 4000, 5000, 7000, 9000, 11, 54096, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16506, 0, 2, 0, 6, 0, 100, 2, 0, 0, 0, 0, 11, 28732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Death");
INSERT INTO smart_scripts VALUES(16506, 0, 3, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
-- Naxxramas Follower
INSERT INTO smart_scripts VALUES(16505, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 16000, 21000, 11, 56107, 0, 0, 0, 0, 0, 17, 7, 40, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16505, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 11000, 15000, 11, 54093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16505, 0, 2, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");
DELETE FROM linked_respawn WHERE linkedGuid=127800;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(16505, 16506));
DELETE FROM creature WHERE id IN(16505, 16506);


-- Maexxna
REPLACE INTO creature_template VALUES (15952, 29278, 0, 0, 0, 0, 15928, 0, 0, 0, 'Maexxna', '', NULL, 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 15952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1274062, 1557187, '', 0, 3, 1, 180, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_maexxna', 12340);
REPLACE INTO creature_template VALUES (29278, 0, 0, 0, 0, 0, 15928, 0, 0, 0, 'Maexxna (1)', '', '', 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 70, 1800, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 1, 76, 29278, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2548124, 3114374, '', 0, 3, 1, 545, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (17055, 29279, 0, 0, 0, 0, 13111, 0, 0, 0, 'Maexxna Spiderling', NULL, NULL, 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 0.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29279, 0, 0, 0, 0, 0, 13111, 0, 0, 0, 'Maexxna Spiderling (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28776, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16486, 30183, 0, 0, 0, 0, 16213, 0, 0, 0, 'Web Wrap', NULL, NULL, 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'boss_maexxna_webwrap', 12340);
REPLACE INTO creature_template VALUES (30183, 0, 0, 0, 0, 0, 16213, 0, 0, 0, 'Web Wrap (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28622, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(17055) AND source_type=0;
-- Maexxna Spiderling
INSERT INTO smart_scripts VALUES(17055, 0, 0, 0, 0, 0, 100, 2, 6000, 9000, 6000, 9000, 11, 54121, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(17055, 0, 1, 0, 0, 0, 100, 4, 6000, 9000, 6000, 9000, 11, 28776, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(17055, 0, 2, 0, 5, 0, 100, 0, 0, 0, 1, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Immortal Achievement - player Kill");


-- Thaddius
REPLACE INTO creature_template VALUES (15928, 29448, 0, 0, 0, 0, 16137, 0, 0, 0, 'Thaddius', '', NULL, 0, 83, 83, 2, 21, 0, 1, 1.68, 1, 3, 509, 683, 0, 805, 17, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15928, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1513636, 1850000, '', 0, 3, 1, 275, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, 'boss_thaddius', 1);
REPLACE INTO creature_template VALUES (29448, 0, 0, 0, 0, 0, 16137, 0, 0, 0, 'Thaddius (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.68, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29448, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3027272, 3700000, '', 0, 3, 1, 2180, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (15929, 29446, 0, 0, 0, 0, 15297, 0, 0, 0, 'Stalagg', '', NULL, 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 60, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, 'boss_thaddius_summon', 12340);
REPLACE INTO creature_template VALUES (29446, 0, 0, 0, 0, 0, 15297, 0, 0, 0, 'Stalagg (1)', '', '', 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 150, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (15930, 29447, 0, 0, 0, 0, 15297, 0, 0, 0, 'Feugen', '', NULL, 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 60, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, 'boss_thaddius_summon', 12340);
REPLACE INTO creature_template VALUES (29447, 0, 0, 0, 0, 0, 15297, 0, 0, 0, 'Feugen (1)', '', '', 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 150, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16218, 0, 0, 0, 0, 0, 13069, 0, 0, 0, 'Tesla Coil', '', NULL, 0, 80, 80, 2, 14, 0, 1.125, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 1, 4, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM gameobject WHERE id=181477;
INSERT INTO gameobject VALUES(NULL, 181477, 533, 3, 1, 3487.04, -2911.68, 318.75, 0, 0, 0, 0, 0, 25, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 181477, 533, 3, 1, 3527.34, -2951.56, 318.75, 0, 0, 0, 0, 0, 25, 0, 1, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(28096, 28111);
INSERT INTO conditions VALUES(13, 1, 28096, 0, 0, 31, 0, 3, 15929, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28111, 0, 0, 31, 0, 3, 15930, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28096, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 28111, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
REPLACE INTO creature_template_addon VALUES(15928, 0, 0, 0, 1, 0, "");
REPLACE INTO creature_template_addon VALUES(29448, 0, 0, 0, 1, 0, "");
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE map=533 AND id IN(15929, 15930));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=533 AND id IN(15929, 15930));
DELETE FROM creature WHERE map=533 AND id IN(15929, 15930);
DELETE FROM spell_script_names WHERE spell_id IN(28062, 28085, 28089);
INSERT INTO spell_script_names VALUES(28062, "spell_thaddius_pos_neg_charge");
INSERT INTO spell_script_names VALUES(28085, "spell_thaddius_pos_neg_charge");
INSERT INTO spell_script_names VALUES(28089, "spell_thaddius_polarity_shift");



-- Instructor Razuvious
REPLACE INTO creature_template VALUES (29912, 0, 0, 0, 0, 0, 26620, 0, 0, 0, 'Obedience Crystal', '', 'Interact', 0, 80, 80, 2, 35, 16777216, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16803, 29941, 0, 0, 0, 0, 16539, 0, 0, 0, 'Death Knight Understudy', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61696, 29060, 29061, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 2, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 0, 0, 'boss_razuvious_minion', 12340);
REPLACE INTO creature_template VALUES (29941, 0, 0, 0, 0, 0, 16539, 0, 0, 0, 'Death Knight Understudy (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61696, 29060, 29061, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 2, 1, 0, 22708, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16061, 29940, 0, 0, 0, 0, 16582, 0, 0, 0, 'Instructor Razuvious', '', NULL, 0, 83, 83, 2, 21, 0, 1.6, 1.14286, 1, 3, 509, 683, 0, 805, 35, 3500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 16061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1253602, 1532181, '', 0, 3, 1, 240, 2, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 617299839, 1+0x200000, 'boss_razuvious', 12340);
REPLACE INTO creature_template VALUES (29940, 0, 0, 0, 0, 0, 16582, 0, 0, 0, 'Instructor Razuvious (1)', '', '', 0, 83, 83, 2, 21, 0, 1.6, 1.14286, 1, 3, 509, 683, 0, 805, 70, 3500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29940, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2507204, 3064362, '', 0, 3, 1, 725, 2, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=16803);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=16803);
DELETE FROM creature WHERE id=16803;
REPLACE INTO creature_template_addon VALUES(16803, 0, 0, 0, 1, 36, "");
REPLACE INTO creature_template_addon VALUES(29941, 0, 0, 0, 1, 36, "");
DELETE FROM smart_scripts WHERE entryorguid IN(16803) AND source_type=0;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(55479);
INSERT INTO conditions VALUES(13, 3, 55479, 0, 0, 31, 0, 3, 16803, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 55479, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(29125);
INSERT INTO conditions VALUES(13, 1, 29125, 0, 0, 31, 0, 3, 16803, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 29125, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

DELETE FROM smart_scripts WHERE entryorguid=16803 AND source_type=0;

-- Gothik the Harvester
REPLACE INTO creature_template VALUES (16060, 29955, 0, 0, 0, 0, 16279, 0, 0, 0, 'Gothik the Harvester', '', NULL, 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 16060, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 733851, 896929, '', 0, 3, 1, 60, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, 'boss_gothik', 12340);
REPLACE INTO creature_template VALUES (29955, 0, 0, 0, 0, 0, 16279, 0, 0, 0, 'Gothik the Harvester (1)', '', '', 0, 83, 83, 2, 14, 0, 1, 1.14286, 1, 3, 496, 674, 0, 783, 70, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 29955, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1467702, 1793858, '', 0, 3, 1, 180, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16127, 30264, 0, 0, 0, 0, 3942, 0, 0, 0, 'Spectral Trainee', '', NULL, 0, 80, 80, 2, 21, 0, 1.11111, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27989, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 3, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (30264, 0, 0, 0, 0, 0, 3942, 0, 0, 0, 'Spectral Trainee (1)', '', '', 0, 81, 81, 2, 21, 0, 1.11111, 1.14286, 1, 1, 425, 602, 0, 670, 13, 1150, 0, 2, 32768, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 3, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16149, 29989, 0, 0, 0, 0, 26681, 0, 0, 0, 'Spectral Horse', '', NULL, 0, 81, 81, 2, 21, 0, 1.6, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 141, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29989, 0, 0, 0, 0, 0, 26681, 0, 0, 0, 'Spectral Horse (1)', '', '', 0, 81, 81, 2, 21, 0, 1.6, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 141, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16124, 29987, 0, 0, 0, 0, 16608, 0, 0, 0, 'Unrelenting Trainee', NULL, NULL, 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 1800, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55604, 0, 0, 0, 0, 0, 0, 27892, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29987, 0, 0, 0, 0, 0, 16608, 0, 0, 0, 'Unrelenting Trainee (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55645, 0, 0, 0, 0, 0, 0, 27892, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16125, 29985, 0, 0, 0, 0, 16612, 0, 0, 0, 'Unrelenting Death Knight', NULL, NULL, 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27825, 0, 0, 0, 0, 0, 0, 27928, 0, 0, 0, 0, '', 0, 3, 1, 2.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29985, 0, 0, 0, 0, 0, 16612, 0, 0, 0, 'Unrelenting Death Knight (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27825, 0, 0, 0, 0, 0, 0, 27928, 0, 0, 0, 0, '', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16126, 29986, 0, 0, 0, 0, 26571, 0, 0, 0, 'Unrelenting Rider', NULL, NULL, 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 2120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27831, 55606, 0, 0, 0, 0, 0, 27935, 0, 0, 0, 0, '', 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29986, 0, 0, 0, 0, 0, 26571, 0, 0, 0, 'Unrelenting Rider (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 463, 640, 0, 726, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 2120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55638, 55608, 0, 0, 0, 0, 0, 27935, 0, 0, 0, 0, '', 0, 3, 1, 10, 5, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16148, 29990, 0, 0, 0, 0, 26683, 0, 0, 0, 'Spectral Death Knight', NULL, NULL, 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56408, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2.5, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29990, 0, 0, 0, 0, 0, 26683, 0, 0, 0, 'Spectral Death Knight (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56408, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16150, 29988, 0, 0, 0, 0, 26682, 0, 0, 0, 'Spectral Rider', NULL, NULL, 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27994, 55648, 55606, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, 'npc_boss_gothik_minion', 12340);
REPLACE INTO creature_template VALUES (29988, 0, 0, 0, 0, 0, 26682, 0, 0, 0, 'Spectral Rider (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55646, 27995, 55608, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(27892, 27928, 27935);
INSERT INTO conditions VALUES(13, 1, 27892, 0, 0, 31, 0, 3, 16060, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 27928, 0, 0, 31, 0, 3, 16060, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 27935, 0, 0, 31, 0, 3, 16060, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 27892, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 27928, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 27935, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');


-- Four Horseman
REPLACE INTO creature_template VALUES (16063, 30602, 0, 0, 0, 0, 16154, 0, 0, 0, 'Sir Zeliek', NULL, NULL, 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 56, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_four_horsemen', 12340);
REPLACE INTO creature_template VALUES (30602, 0, 0, 0, 0, 0, 16154, 0, 0, 0, 'Sir Zeliek (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 170, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16064, 30603, 0, 0, 0, 0, 16155, 0, 0, 0, 'Thane Korth\'azz', '', NULL, 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49555, 64718, '', 0, 3, 1, 56, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_four_horsemen', 12340);
REPLACE INTO creature_template VALUES (30603, 0, 0, 0, 0, 0, 16155, 0, 0, 0, 'Thane Korth\'azz (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 99110, 129436, '', 0, 3, 1, 170, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16065, 30601, 0, 0, 0, 0, 16153, 0, 0, 0, 'Lady Blaumeux', '', NULL, 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 56, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_four_horsemen', 12340);
REPLACE INTO creature_template VALUES (30601, 0, 0, 0, 0, 0, 16153, 0, 0, 0, 'Lady Blaumeux (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 170, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (30549, 30600, 0, 0, 0, 0, 10729, 0, 0, 0, 'Baron Rivendare', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 35, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 56, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, 'boss_four_horsemen', 12340);
REPLACE INTO creature_template VALUES (30600, 0, 0, 0, 0, 0, 10729, 0, 0, 0, 'Baron Rivendare (1)', '', '', 0, 83, 83, 2, 21, 0, 1, 1.14286, 1, 3, 509, 683, 0, 805, 70, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 170, 2, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM gameobject WHERE id IN(181366, 193426);
UPDATE gameobject_template SET flags=0 WHERE entry IN(181366, 193426);


-- Sapphiron
REPLACE INTO creature_template VALUES (15989, 29991, 0, 0, 0, 0, 16033, 0, 0, 0, 'Sapphiron', '', NULL, 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 35, 1800, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 15989, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 246755, 322238, '', 0, 3, 1, 300, 2, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 617299839, 1+0x200000, 'boss_sapphiron', 12340);
REPLACE INTO creature_template VALUES (29991, 0, 0, 0, 0, 0, 16033, 0, 0, 0, 'Sapphiron (1)', '', '', 0, 83, 83, 2, 21, 0, 1.68, 1.14286, 1, 3, 509, 683, 0, 805, 70, 1800, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 76, 29991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 493510, 644476, '', 0, 3, 1, 935, 2, 1, 0, 0, 0, 0, 0, 0, 0, 188, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_template VALUES (16474, 30000, 0, 0, 0, 0, 11686, 0, 0, 0, 'Blizzard', '', NULL, 0, 1, 1, 0, 35, 0, 1.125, 1.14286, 1, 3, 2, 2, 0, 24, 35, 3000, 1900, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 100, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 0, 128, 'trigger_periodic', 12340);
REPLACE INTO creature_template VALUES (30000, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Blizzard (1)', '', '', 0, 1, 1, 0, 35, 0, 1.125, 1.14286, 1, 3, 2, 2, 0, 24, 1, 3000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55699, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 0, 128, '', 12340);
DELETE FROM spell_script_names WHERE spell_id IN(28524);
INSERT INTO spell_script_names VALUES(28524, "spell_sapphiron_frost_explosion");
UPDATE gameobject SET state=1 WHERE id=181225;


-- Kel'Thuzad
DELETE FROM areatrigger_scripts WHERE ScriptName='at_kelthuzad_center' AND entry=4112;
REPLACE INTO creature_template VALUES (16427, 30015, 0, 0, 0, 0, 7869, 0, 0, 0, 'Soldier of the Frozen Wastes', '', NULL, 0, 80, 80, 2, 21, 0, 0.25, 0.285715, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.126984, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, 'boss_kelthuzad_minion', 12340);
REPLACE INTO creature_template VALUES (30015, 0, 0, 0, 0, 0, 7869, 0, 0, 0, 'Soldier of the Frozen Wastes (1)', '', '', 0, 80, 80, 2, 21, 0, 0.25, 0.285715, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.349206, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16428, 30048, 0, 0, 0, 0, 12818, 0, 0, 0, 'Unstoppable Abomination', '', NULL, 0, 80, 80, 2, 21, 0, 0.7, 0.800002, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, 'boss_kelthuzad_minion', 12340);
REPLACE INTO creature_template VALUES (30048, 0, 0, 0, 0, 0, 12818, 0, 0, 0, 'Unstoppable Abomination (1)', '', '', 0, 80, 80, 2, 21, 0, 0.7, 0.800002, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16429, 30018, 0, 0, 0, 0, 16178, 0, 0, 0, 'Soul Weaver', '', NULL, 0, 80, 80, 2, 21, 0, 0.1, 0.114286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28459, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, 'boss_kelthuzad_minion', 12340);
REPLACE INTO creature_template VALUES (30018, 0, 0, 0, 0, 0, 16178, 0, 0, 0, 'Soul Weaver (1)', '', '', 0, 80, 80, 2, 21, 0, 0.1, 0.114286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 64, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template_addon VALUES(16427, 0, 0, 0, 1, 0, "28458");
REPLACE INTO creature_template_addon VALUES(30015, 0, 0, 0, 1, 0, "55713");
REPLACE INTO creature_template_addon VALUES(16429, 0, 0, 0, 1, 0, "28460");
REPLACE INTO creature_template_addon VALUES(30018, 0, 0, 0, 1, 0, "55717");
REPLACE INTO spell_proc_event VALUES(28460, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5000);
REPLACE INTO spell_proc_event VALUES(55717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5000);
REPLACE INTO creature_template VALUES (16980, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'The Lich King', '', NULL, 0, 60, 60, 0, 114, 0, 1, 1.14286, 1, 0, 104, 138, 0, 252, 1, 1400, 1900, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 72, 106, 26, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);
REPLACE INTO creature_template VALUES (15990, 30061, 0, 0, 0, 0, 15945, 0, 0, 0, 'Kel\'Thuzad', '', NULL, 0, 83, 83, 2, 21, 0, 1.1, 1.14286, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 15990, 0, 0, 0, 0, 0, 200, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1002755, 1457838, '', 0, 3, 1, 375, 600, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, 'boss_kelthuzad', 12340);
REPLACE INTO creature_template VALUES (30061, 0, 0, 0, 0, 0, 15945, 0, 0, 0, 'Kel\'Thuzad (1)', '', '', 0, 83, 83, 2, 21, 0, 1.1, 1.14286, 1, 3, 496, 674, 0, 783, 70, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 6, 76, 30061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2005510, 2915676, '', 0, 3, 1, 1050, 600, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id=16980 );
DELETE FROM creature WHERE id=16980;
INSERT INTO creature VALUES (NULL, 16980, 533, 3, 1, 0, 0, 3749.68, -5114.06, 142.115, 2.93215, 604800, 0, 0, 1, 0, 0, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(27808);
INSERT INTO spell_script_names VALUES(27808, "spell_kelthuzad_frost_blast");
REPLACE INTO creature_template VALUES (16129, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 'Shadow Fissure', NULL, NULL, 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 5500, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27812, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 128, 'trigger_periodic', 12340);
REPLACE INTO creature_template VALUES (16441, 30057, 0, 0, 0, 0, 16586, 0, 0, 0, 'Guardian of Icecrown', NULL, NULL, 0, 80, 80, 2, 21, 0, 1.25, 1.42858, 1, 1, 422, 586, 0, 642, 7.5, 1250, 1650, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 200, 1, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 8388624, 0, 'boss_kelthuzad_minion', 12340);
REPLACE INTO creature_template VALUES (30057, 0, 0, 0, 0, 0, 16586, 0, 0, 0, 'Guardian of Icecrown (1)', '', '', 0, 80, 80, 2, 21, 0, 1.25, 1.42858, 1, 1, 422, 586, 0, 642, 13, 1250, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 500, 1, 1, 0, 0, 0, 0, 0, 0, 0, 174, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_model_info VALUES(16586, 1, 3, 2, 0);
-- MISC
REPLACE INTO creature_template VALUES (16998, 0, 0, 0, 0, 0, 16622, 0, 0, 0, 'Mr. Bigglesworth', '', '', 0, 5, 5, 0, 32, 0, 1, 1.14286, 1, 0, 5, 7, 0, 32, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 3, 4, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, '', 12340);
-- Texts
REPLACE INTO creature_text VALUES(20350, 0, 0, 'No!!! A curse upon you, interlopers! The armies of the Lich King will hunt you down. You will not escape your fate...', 14, 0, 100, 0, 0, 14484, 0, 'kelthuzad SAY_CAT_DIED');
REPLACE INTO creature_text VALUES(16980, 0, 0, 'It is good that you serve me so faithfully. Soon, all will serve the Lich King and in the end, you shall be rewarded...so long as you do not falter.', 14, 0, 100, 0, 0, 8881, 0, 'kelthuzad SAY_SAPP_DIALOG2_LICH');
REPLACE INTO creature_text VALUES(16980, 1, 0, 'Your security measures have failed! See to this interruption immediately!', 14, 0, 100, 0, 0, 8882, 0, 'kelthuzad SAY_SAPP_DIALOG4_LICH');

DELETE FROM smart_scripts WHERE entryorguid IN(16427, 16441, 16429) AND source_type=0;
-- 25man drops 2 tokens
DELETE FROM creature_loot_template WHERE entry=30061;
DELETE FROM reference_loot_template WHERE entry=34133;
INSERT INTO creature_loot_template VALUES (30061, 1, 100, 1, 0, -34136, 3);
INSERT INTO creature_loot_template VALUES (30061, 2, 100, 1, 1, -34133, 2);
INSERT INTO creature_loot_template VALUES (30061, 45912, 0.1, 1, 0, 1, 1);
INSERT INTO creature_loot_template VALUES (30061, 47241, 100, 1, 0, 2, 2);
INSERT INTO reference_loot_template VALUES (34133, 40631, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34133, 40632, 0, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (34133, 40633, 0, 1, 1, 1, 1);


-- ------------------------------
-- Trash AI
-- ------------------------------
-- No AI
REPLACE INTO creature_template VALUES (15977, 29229, 0, 0, 0, 0, 959, 0, 0, 0, 'Poisonous Skitterer', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29229, 0, 0, 0, 0, 0, 959, 0, 0, 0, 'Poisonous Skitterer (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16056, 29612, 0, 0, 0, 0, 15978, 0, 0, 0, 'Diseased Maggot', '', '', 0, 80, 80, 2, 16, 0, 0.8, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29612, 0, 0, 0, 0, 0, 15978, 0, 0, 0, 'Diseased Maggot (1)', '', '', 0, 80, 80, 2, 16, 0, 0.8, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16057, 31542, 0, 0, 0, 0, 15554, 0, 0, 0, 'Rotting Maggot', '', '', 0, 80, 80, 2, 16, 0, 0.8, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2500, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31542, 0, 0, 0, 0, 0, 15554, 0, 0, 0, 'Rotting Maggot (1)', '', '', 0, 80, 80, 2, 16, 0, 0.8, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2500, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, '', 12340);

-- AI
REPLACE INTO creature_template VALUES (15974, 29242, 0, 0, 0, 0, 15937, 0, 0, 0, 'Dread Creeper', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13153, 0, 0, 0, 'SmartAI', 0, 1, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29242, 0, 0, 0, 0, 0, 15937, 0, 0, 0, 'Dread Creeper (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13153, 0, 0, 0, '', 0, 1, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (15975, 29241, 0, 0, 0, 0, 15938, 0, 0, 0, 'Carrion Spinner', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13151, 0, 0, 0, 'SmartAI', 0, 1, 1, 7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29241, 0, 0, 0, 0, 0, 15938, 0, 0, 0, 'Carrion Spinner (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13151, 0, 0, 0, '', 0, 1, 1, 18, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (15976, 29243, 0, 0, 0, 0, 15939, 0, 0, 0, 'Venom Stalker', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13150, 0, 0, 0, 'SmartAI', 0, 1, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29243, 0, 0, 0, 0, 0, 15939, 0, 0, 0, 'Venom Stalker (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 3, 0, 0, 0, 0, 353, 512, 112, 1, 73, 100006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13150, 0, 0, 0, '', 0, 1, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (15978, 30389, 0, 0, 0, 0, 15941, 0, 0, 0, 'Crypt Reaver', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1200, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 18, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30389, 0, 0, 0, 0, 0, 15941, 0, 0, 0, 'Crypt Reaver (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1200, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 45, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (15979, 29286, 0, 0, 0, 0, 15942, 0, 0, 0, 'Tomb Horror', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 1, 3, 1, 14, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29286, 0, 0, 0, 0, 0, 15942, 0, 0, 0, 'Tomb Horror (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (15980, 29247, 0, 0, 0, 0, 16594, 16595, 16596, 16597, 'Naxxramas Cultist', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5714, 9524, 'SmartAI', 0, 3, 1, 2, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29247, 0, 0, 0, 0, 0, 16594, 16595, 16596, 16597, 'Naxxramas Cultist (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11428, 19048, '', 0, 3, 1, 5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (15981, 29248, 0, 0, 0, 0, 16598, 16599, 16600, 16601, 'Naxxramas Acolyte', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5725, 9541, 'SmartAI', 0, 3, 1, 2, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29248, 0, 0, 0, 0, 0, 16598, 16599, 16600, 16601, 'Naxxramas Acolyte (1)', '', '', 0, 81, 81, 2, 312, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 7, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11450, 19082, '', 0, 3, 1, 5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16017, 29347, 0, 0, 0, 0, 9760, 0, 0, 0, 'Patchwork Golem', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3798, 11953, 'SmartAI', 0, 3, 1, 11, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29347, 0, 0, 0, 0, 0, 9760, 0, 0, 0, 'Patchwork Golem (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7596, 9930, '', 0, 3, 1, 30, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16018, 29353, 0, 0, 0, 0, 15958, 0, 0, 0, 'Bile Retcher', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4776, 6241, 'SmartAI', 0, 3, 1, 13.5, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29353, 0, 0, 0, 0, 0, 15958, 0, 0, 0, 'Bile Retcher (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9552, 12482, '', 0, 3, 1, 24, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16020, 29362, 0, 0, 0, 0, 16063, 0, 0, 0, 'Mad Scientist', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 7.5, 2000, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2226, 10859, 'SmartAI', 0, 3, 1, 6, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29362, 0, 0, 0, 0, 0, 16063, 0, 0, 0, 'Mad Scientist (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4452, 5822, '', 0, 3, 1, 15, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16021, 29359, 0, 0, 0, 0, 16175, 0, 0, 0, 'Living Monstrosity', '', '', 0, 82, 82, 2, 21, 0, 0.8, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2015, 11331, 'SmartAI', 0, 3, 1, 14, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29359, 0, 0, 0, 0, 0, 16175, 0, 0, 0, 'Living Monstrosity (1)', '', '', 0, 82, 82, 2, 21, 0, 0.8, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4030, 5272, '', 0, 3, 1, 35, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16385, 29360, 0, 0, 0, 0, 4590, 0, 0, 0, 'Lightning Totem', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 0, 488, 642, 0, 782, 1, 2000, 0, 1, 4, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 1, 3, 1, 0.2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29360, 0, 0, 0, 0, 0, 4590, 0, 0, 0, 'Lightning Totem (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 0, 488, 642, 0, 782, 1, 1318, 0, 1, 4, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16022, 29363, 0, 0, 0, 0, 836, 0, 0, 0, 'Surgical Assistant', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1842, 3527, 'SmartAI', 0, 3, 1, 2.5, 5, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29363, 0, 0, 0, 0, 0, 836, 0, 0, 0, 'Surgical Assistant (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3684, 4820, '', 0, 3, 1, 7, 5, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16024, 29355, 0, 0, 0, 0, 12349, 0, 0, 0, 'Embalming Slime', '', '', 0, 80, 80, 2, 21, 0, 1.2, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.6, 2, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29355, 0, 0, 0, 0, 0, 12349, 0, 0, 0, 'Embalming Slime (1)', '', '', 0, 80, 80, 2, 21, 0, 1.2, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 2, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16025, 29371, 0, 0, 0, 0, 24484, 0, 0, 0, 'Stitched Giant', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6479, 8466, 'SmartAI', 0, 3, 1, 16, 2, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29371, 0, 0, 0, 0, 0, 24484, 0, 0, 0, 'Stitched Giant (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12958, 16932, '', 0, 3, 1, 40, 2, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16029, 29356, 0, 0, 0, 0, 15962, 0, 0, 0, 'Sludge Belcher', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8523, 8523, 'SmartAI', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29356, 0, 0, 0, 0, 0, 15962, 0, 0, 0, 'Sludge Belcher (1)', '', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17046, 17046, '', 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16034, 29609, 0, 0, 0, 0, 23136, 0, 0, 0, 'Plague Beast', '', '', 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29609, 0, 0, 0, 0, 0, 23136, 0, 0, 0, 'Plague Beast (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 15, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16036, 29608, 0, 0, 0, 0, 7896, 0, 0, 0, 'Frenzied Bat', '', '', 0, 80, 80, 2, 16, 0, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29608, 0, 0, 0, 0, 0, 7896, 0, 0, 0, 'Frenzied Bat (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.42857, 1, 1, 422, 586, 0, 642, 13, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16037, 29603, 0, 0, 0, 0, 1954, 0, 0, 0, 'Plagued Bat', '', '', 0, 80, 80, 2, 16, 0, 1, 1.42857, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29603, 0, 0, 0, 0, 0, 1954, 0, 0, 0, 'Plagued Bat (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.42857, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16067, 29852, 0, 0, 0, 0, 26539, 26540, 26541, 0, 'Deathcharger Steed', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29852, 0, 0, 0, 0, 0, 26539, 26540, 26541, 0, 'Deathcharger Steed (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16145, 29824, 0, 0, 0, 0, 26546, 26781, 26549, 26550, 'Death Knight Captain', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4138, 5409, 'SmartAI', 0, 3, 1, 12, 2, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29824, 0, 0, 0, 0, 0, 26546, 26781, 26549, 26550, 'Death Knight Captain (1)', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8276, 10818, '', 0, 3, 1, 30, 2, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16146, 29823, 0, 0, 0, 0, 16508, 26542, 26543, 26544, 'Death Knight', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3373, 4410, 'SmartAI', 0, 3, 1, 10, 2, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29823, 0, 0, 0, 0, 0, 16508, 26542, 26543, 26544, 'Death Knight (1)', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6746, 8820, '', 0, 3, 1, 24, 2, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16154, 29831, 0, 0, 0, 0, 16927, 0, 0, 0, 'Risen Squire', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1163, 1524, 'SmartAI', 0, 3, 1, 4, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29831, 0, 0, 0, 0, 0, 16927, 0, 0, 0, 'Risen Squire (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2326, 3048, '', 0, 3, 1, 10, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16156, 29833, 0, 0, 0, 0, 26569, 26555, 0, 0, 'Dark Touched Warrior', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29833, 0, 0, 0, 0, 0, 26569, 26555, 0, 0, 'Dark Touched Warrior (1)', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16163, 29842, 0, 0, 0, 0, 26571, 0, 0, 0, 'Death Knight Cavalier', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 7.5, 1500, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 2120, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4776, 6241, 'SmartAI', 0, 3, 1, 12, 5, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29842, 0, 0, 0, 0, 0, 26571, 0, 0, 0, 'Death Knight Cavalier (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 1500, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 2120, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9552, 12482, '', 0, 3, 1, 30, 5, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16164, 29825, 0, 0, 0, 0, 10553, 0, 0, 0, 'Shade of Naxxramas', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2481, 3244, 'SmartAI', 0, 3, 1, 7, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29825, 0, 0, 0, 0, 0, 10553, 0, 0, 0, 'Shade of Naxxramas (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4962, 6488, '', 0, 3, 1, 18, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16165, 29828, 0, 0, 0, 0, 27105, 0, 0, 0, 'Necro Knight', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 7.5, 2000, 0, 8, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1801, 2356, 'SmartAI', 0, 3, 1, 7, 18, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29828, 0, 0, 0, 0, 0, 27105, 0, 0, 0, 'Necro Knight (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 351, 509, 0, 304, 13, 2000, 0, 8, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 503, 74, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3602, 4712, '', 0, 3, 1, 18, 18, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16167, 29835, 0, 0, 0, 0, 21305, 0, 0, 0, 'Bony Construct', '', '', 0, 81, 81, 2, 233, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1673, 2190, 'SmartAI', 0, 3, 1, 5, 3, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29835, 0, 0, 0, 0, 0, 21305, 0, 0, 0, 'Bony Construct (1)', '', '', 0, 81, 81, 2, 233, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3346, 4380, '', 0, 3, 1, 12, 3, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16168, 29576, 0, 0, 0, 0, 14710, 0, 0, 0, 'Stoneskin Gargoyle', '', '', 0, 81, 81, 2, 233, 0, 2, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11151, 14566, 'SmartAI', 0, 3, 1, 26, 10, 1, 0, 0, 0, 0, 0, 0, 0, 135, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29576, 0, 0, 0, 0, 0, 14710, 0, 0, 0, 'Stoneskin Gargoyle (1)', '', '', 0, 81, 81, 2, 233, 0, 2, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22302, 29132, '', 0, 3, 1, 75, 10, 1, 0, 0, 0, 0, 0, 0, 0, 135, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16193, 29837, 0, 0, 0, 0, 26563, 0, 0, 0, 'Skeletal Smith', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2226, 2911, 'SmartAI', 0, 3, 1, 5, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29837, 0, 0, 0, 0, 0, 26563, 0, 0, 0, 'Skeletal Smith (1)', '', '', 0, 81, 81, 2, 21, 0, 1.28, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4452, 5822, '', 0, 3, 1, 12, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 148, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16194, 29898, 0, 0, 0, 0, 24722, 0, 0, 0, 'Unholy Axe', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4776, 6241, 'SmartAI', 0, 3, 1, 14, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29898, 0, 0, 0, 0, 0, 24722, 0, 0, 0, 'Unholy Axe (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9552, 12482, '', 0, 3, 1, 35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16215, 29899, 0, 0, 0, 0, 24723, 0, 0, 0, 'Unholy Staff', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3883, 5076, 'SmartAI', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29899, 0, 0, 0, 0, 0, 24723, 0, 0, 0, 'Unholy Staff (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7766, 10152, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16216, 29900, 0, 0, 0, 0, 24724, 0, 0, 0, 'Unholy Swords', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4138, 5409, 'SmartAI', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29900, 0, 0, 0, 0, 0, 24724, 0, 0, 0, 'Unholy Swords (1)', '', '', 0, 81, 81, 2, 21, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8276, 10818, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16236, 29613, 0, 0, 0, 0, 15788, 0, 0, 0, 'Eye Stalk', '', '', 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1000, 0, 1, 4, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29613, 0, 0, 0, 0, 0, 15788, 0, 0, 0, 'Eye Stalk (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1000, 0, 1, 4, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16243, 29575, 0, 0, 0, 0, 11140, 0, 0, 0, 'Plague Slime', '', '', 0, 81, 81, 2, 14, 0, 0.8, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1800, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6051, 7906, 'SmartAI', 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 70, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29575, 0, 0, 0, 0, 0, 11140, 0, 0, 0, 'Plague Slime (1)', '', '', 0, 81, 81, 2, 14, 0, 0.8, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1800, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12102, 15812, '', 0, 3, 1, 40, 1, 1, 0, 0, 0, 0, 0, 0, 0, 70, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16244, 29574, 0, 0, 0, 0, 26329, 0, 0, 0, 'Infectious Ghoul', '', '', 0, 81, 81, 2, 21, 0, 0.8, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4631, 8832, 'SmartAI', 0, 3, 1, 12, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (29574, 0, 0, 0, 0, 0, 26329, 0, 0, 0, 'Infectious Ghoul (1)', '', '', 0, 81, 81, 2, 21, 0, 0.8, 1.14286, 1, 1, 464, 604, 0, 708, 13, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16297, 29601, 0, 0, 0, 0, 16895, 0, 0, 0, 'Mutated Grub', '', '', 0, 81, 81, 2, 16, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (29601, 0, 0, 0, 0, 0, 16895, 0, 0, 0, 'Mutated Grub (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 10, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (16447, 30097, 0, 0, 0, 0, 24998, 0, 0, 0, 'Plagued Ghoul', '', '', 0, 81, 81, 2, 21, 0, 0.8, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4011, 5242, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30097, 0, 0, 0, 0, 0, 24998, 0, 0, 0, 'Plagued Ghoul (1)', '', '', 0, 81, 81, 2, 21, 0, 0.8, 1.42857, 1, 1, 464, 604, 0, 708, 13, 1500, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8022, 10484, '', 0, 3, 1, 20, 1, 1, 0, 42108, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30071, 30075, 0, 0, 0, 0, 26746, 0, 0, 0, 'Stitched Colossus', '', '', 0, 82, 82, 2, 21, 0, 1.6, 1.14286, 1, 1, 488, 642, 0, 782, 7.5, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 20, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 167, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30075, 0, 0, 0, 0, 0, 26746, 0, 0, 0, 'Stitched Colossus (1)', '', '', 0, 82, 82, 2, 21, 0, 1.6, 1.14286, 1, 1, 488, 642, 0, 782, 13, 2500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 72, 100005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 50, 2, 1, 0, 42108, 0, 0, 0, 0, 0, 167, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30085, 30087, 0, 0, 0, 0, 19329, 0, 0, 0, 'Vigilant Shade', '', '', 0, 81, 81, 2, 21, 0, 1.6, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 10, 10, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (30087, 0, 0, 0, 0, 0, 19329, 0, 0, 0, 'Vigilant Shade (1)', '', '', 0, 81, 81, 2, 21, 0, 1.6, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 10, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (16400, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Toxic Tunnel', '', '', 0, 80, 80, 2, 114, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33816578, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);

DELETE FROM smart_scripts WHERE entryorguid       IN(15974, 15975, 15976, 15978, 15979, 15980, 15981, 16017, 16018, 16020, 16021, 16385, 16022, 16024,
16025, 16029, 16034, 16036, 16037, 16067, 16145, 16146, 16154, 16156, 16163, 16164, 16165, 16167, 16168, 16193, 16194, 16215, 16216, 16236, 16243, 16244,
16297, 16447, 16803, 30071, 30085, 16400) AND source_type=0;
-- Dread Creeper
INSERT INTO smart_scripts VALUES(15974, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 8000, 11000, 11, 53803, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15974, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 8000, 11000, 11, 28440, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Carrion Spinner
INSERT INTO smart_scripts VALUES(15975, 0, 0, 0, 0, 0, 100, 2, 5000, 8000, 14000, 18000, 11, 30043, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15975, 0, 1, 0, 0, 0, 100, 4, 5000, 8000, 14000, 18000, 11, 56032, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15975, 0, 2, 0, 0, 0, 100, 0, 9000, 16000, 18000, 21000, 11, 28434, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Venom Stalker
INSERT INTO smart_scripts VALUES(15976, 0, 0, 0, 4, 0, 100, 2, 0, 0, 0, 0, 11, 28431, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15976, 0, 1, 0, 4, 0, 100, 4, 0, 0, 0, 0, 11, 53809, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Crypt Reaver
INSERT INTO smart_scripts VALUES(15978, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 9000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15978, 0, 1, 0, 2, 1, 100, 0, 0, 30, 120000, 120000, 11, 56625, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Tomb Horror
INSERT INTO smart_scripts VALUES(15979, 0, 0, 0, 0, 0, 100, 2, 3000, 7000, 12000, 16000, 11, 54311, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15979, 0, 1, 0, 0, 0, 100, 4, 3000, 7000, 12000, 16000, 11, 54316, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15979, 0, 2, 0, 0, 0, 100, 2, 15000, 17000, 28000, 35000, 11, 54313, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15979, 0, 3, 0, 0, 0, 100, 4, 15000, 17000, 28000, 35000, 11, 54317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Naxxramas Cultist
INSERT INTO smart_scripts VALUES(15980, 0, 0, 0, 0, 0, 100, 2, 4000, 7000, 14000, 17000, 11, 53850, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15980, 0, 1, 0, 0, 0, 100, 4, 4000, 7000, 14000, 17000, 11, 53851, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Naxxramas Acolyte
INSERT INTO smart_scripts VALUES(15981, 0, 0, 0, 0, 0, 100, 2, 9000, 13000, 14000, 17000, 11, 56063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15981, 0, 1, 0, 0, 0, 100, 4, 9000, 13000, 14000, 17000, 11, 56067, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15981, 0, 2, 0, 0, 0, 100, 2, 4000, 8000, 13000, 15000, 11, 56064, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(15981, 0, 3, 0, 0, 0, 100, 4, 4000, 8000, 13000, 15000, 11, 56065, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Patchwork Golem
REPLACE INTO creature_template_addon VALUES(16017, 0, 0, 0, 4097, 0, "27793");
REPLACE INTO creature_template_addon VALUES(29347, 0, 0, 0, 4097, 0, "27793");
INSERT INTO smart_scripts VALUES(16017, 0, 0, 0, 0, 0, 100, 2, 5000, 10000, 14000, 19000, 11, 27758, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16017, 0, 1, 0, 0, 0, 100, 4, 5000, 10000, 14000, 19000, 11, 56427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16017, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 14000, 15000, 11, 27794, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16017, 0, 3, 0, 12, 1, 100, 2, 0, 20, 35000, 35000, 11, 56426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16017, 0, 4, 0, 12, 1, 100, 4, 0, 20, 35000, 35000, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Bile Retcher
INSERT INTO smart_scripts VALUES(16018, 0, 0, 0, 0, 0, 100, 2, 4000, 7000, 15000, 20000, 11, 27807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16018, 0, 1, 0, 0, 0, 100, 4, 4000, 7000, 15000, 20000, 11, 54326, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Mad Scientist
INSERT INTO smart_scripts VALUES(16020, 0, 0, 0, 0, 0, 100, 2, 7000, 10000, 10000, 13000, 11, 28301, 0, 0, 0, 0, 0, 5, 40, 0, 1, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16020, 0, 1, 0, 0, 0, 100, 4, 7000, 10000, 10000, 13000, 11, 54338, 0, 0, 0, 0, 0, 5, 40, 0, 1, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16020, 0, 2, 0, 0, 0, 100, 2, 15000, 18000, 15000, 18000, 11, 28306, 0, 0, 0, 0, 0, 19, 16021, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16020, 0, 3, 0, 0, 0, 100, 4, 15000, 18000, 15000, 18000, 11, 54337, 0, 0, 0, 0, 0, 19, 16021, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Living Monstrosity
INSERT INTO smart_scripts VALUES(16021, 0, 0, 0, 0, 0, 100, 2, 7000, 12000, 18000, 20000, 11, 28293, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16021, 0, 1, 0, 0, 0, 100, 4, 7000, 12000, 18000, 20000, 11, 54334, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16021, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 22000, 25000, 11, 28294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Lightning Totem, Living Monsterostity trigger
INSERT INTO smart_scripts VALUES(16385, 0, 0, 0, 0, 0, 100, 2, 1000, 3000, 4000, 4000, 11, 28297, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16385, 0, 1, 0, 0, 0, 100, 4, 1000, 3000, 4000, 4000, 11, 54333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Surgical Assistant
INSERT INTO smart_scripts VALUES(16022, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 8000, 12000, 11, 28310, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16022, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 8000, 12000, 11, 54339, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Embalming Slime
INSERT INTO smart_scripts VALUES(16024, 0, 0, 0, 60, 0, 100, 0, 2000, 2000, 2000, 2000, 11, 28322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Stitched Giant
INSERT INTO smart_scripts VALUES(16025, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 18000, 20000, 11, 28405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16025, 0, 1, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 54356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Sludge Belcher
REPLACE INTO creature_template_addon VALUES(16029, 0, 0, 0, 4097, 0, "28362");
REPLACE INTO creature_template_addon VALUES(29356, 0, 0, 0, 4097, 0, "28362");
INSERT INTO smart_scripts VALUES(16029, 0, 0, 0, 0, 0, 100, 2, 5000, 6000, 7000, 11000, 11, 27891, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16029, 0, 1, 0, 0, 0, 100, 4, 5000, 6000, 7000, 11000, 11, 54331, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Plague Beast
INSERT INTO smart_scripts VALUES(16034, 0, 0, 0, 0, 0, 100, 2, 10000, 12000, 20000, 25000, 11, 54780, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16034, 0, 1, 0, 0, 0, 100, 4, 10000, 12000, 20000, 25000, 11, 56538, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Frenzied Bat
INSERT INTO smart_scripts VALUES(16036, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 11000, 17000, 11, 54781, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Plauged Bat
INSERT INTO smart_scripts VALUES(16037, 0, 0, 0, 0, 0, 100, 2, 1000, 1000, 11000, 11000, 11, 30113, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16037, 0, 1, 0, 0, 0, 100, 4, 1000, 1000, 11000, 11000, 11, 54772, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Deathcharger Steed
INSERT INTO smart_scripts VALUES(16067, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 55317, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Death Knight Captain
INSERT INTO smart_scripts VALUES(16145, 0, 0, 0, 0, 0, 100, 2, 2000, 7000, 8000, 14000, 11, 55255, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16145, 0, 1, 0, 0, 0, 100, 4, 2000, 7000, 8000, 14000, 11, 55321, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16145, 0, 2, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 55222, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16145, 0, 3, 0, 0, 1, 100, 0, 4000, 8000, 0, 0, 11, 28353, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Death Knight
INSERT INTO smart_scripts VALUES(16146, 0, 0, 0, 0, 0, 100, 2, 2000, 3000, 12000, 16000, 11, 55209, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16146, 0, 1, 0, 0, 0, 100, 4, 2000, 3000, 12000, 16000, 11, 55320, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16146, 0, 2, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 55212, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16146, 0, 3, 0, 14, 0, 100, 0, 5000, 8000, 14000, 19000, 11, 55213, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Risen Squire
INSERT INTO smart_scripts VALUES(16154, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 45000, 50000, 11, 55318, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Dark Touched Warrior
INSERT INTO smart_scripts VALUES(16156, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 18000, 19000, 11, 55266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Death Knight Cavalier
INSERT INTO smart_scripts VALUES(16163, 0, 0, 0, 0, 0, 100, 2, 4000, 6000, 16000, 19000, 11, 55315, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16163, 0, 1, 0, 0, 0, 100, 4, 4000, 6000, 16000, 19000, 11, 55336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16163, 0, 2, 0, 0, 0, 100, 2, 1000, 2000, 5000, 8000, 11, 55313, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16163, 0, 3, 0, 0, 0, 100, 4, 1000, 2000, 5000, 8000, 11, 55331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16163, 0, 4, 0, 0, 0, 100, 2, 0, 0, 10000, 12000, 11, 55314, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16163, 0, 5, 0, 0, 0, 100, 4, 0, 0, 10000, 12000, 11, 55334, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Shade of Naxxramas
INSERT INTO smart_scripts VALUES(16164, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 11000, 15000, 11, 28407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16164, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 11000, 15000, 11, 55323, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Necro Knight
INSERT INTO smart_scripts VALUES(16165, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 14000, 15000, 11, 30092, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16165, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 14000, 15000, 11, 30094, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16165, 0, 2, 0, 0, 0, 100, 0, 9000, 10000, 14000, 15000, 11, 30095, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Bony Construct
INSERT INTO smart_scripts VALUES(16167, 0, 0, 0, 0, 0, 100, 2, 9000, 15000, 20000, 30000, 11, 55319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16167, 0, 1, 0, 0, 0, 100, 4, 9000, 15000, 20000, 30000, 11, 55324, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Stoneskin Gargoyle
INSERT INTO smart_scripts VALUES(16168, 0, 0, 0, 0, 0, 100, 2, 1000, 1000, 2000, 3000, 11, 29325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16168, 0, 1, 0, 0, 0, 100, 4, 1000, 1000, 2000, 3000, 11, 54714, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16168, 0, 2, 0, 2, 1, 100, 2, 0, 30, 0, 0, 11, 28995, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16168, 0, 3, 0, 2, 1, 100, 4, 0, 30, 0, 0, 11, 54722, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Skeletal Smith
INSERT INTO smart_scripts VALUES(16193, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 10000, 13000, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16193, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 6000, 8000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Unholy Axe
INSERT INTO smart_scripts VALUES(16194, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 10000, 13000, 11, 55463, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16194, 0, 1, 0, 0, 0, 100, 0, 6000, 13000, 20000, 20000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Unholy Staff
INSERT INTO smart_scripts VALUES(16215, 0, 0, 0, 0, 0, 100, 2, 6000, 8000, 16000, 20000, 11, 28450, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16215, 0, 1, 0, 0, 0, 100, 4, 6000, 8000, 16000, 20000, 11, 55467, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16215, 0, 2, 0, 0, 0, 100, 0, 6000, 10000, 11000, 15000, 11, 29849, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16215, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 20000, 23000, 11, 29848, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Unholy Swords
INSERT INTO smart_scripts VALUES(16216, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 10000, 15000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16216, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 20000, 22000, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Eye Stalk
INSERT INTO smart_scripts VALUES(16236, 0, 0, 0, 0, 0, 100, 2, 5000, 7000, 14000, 17000, 11, 29407, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16236, 0, 1, 0, 0, 0, 100, 4, 5000, 7000, 14000, 17000, 11, 54805, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Plague Slime
INSERT INTO smart_scripts VALUES(16243, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 3, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16243, 0, 1, 0, 0, 1, 100, 1, 1000, 1000, 0, 0, 11, 28987, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16243, 0, 2, 0, 0, 2, 100, 1, 1000, 1000, 0, 0, 11, 28988, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16243, 0, 3, 0, 0, 4, 100, 1, 1000, 1000, 0, 0, 11, 28989, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16243, 0, 4, 0, 0, 8, 100, 1, 1000, 1000, 0, 0, 11, 28990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Infectious Ghoul
INSERT INTO smart_scripts VALUES(16244, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 9000, 12000, 11, 29915, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16244, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 9000, 12000, 11, 54709, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16244, 0, 2, 0, 0, 0, 100, 2, 8000, 14000, 19000, 24000, 11, 54703, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16244, 0, 3, 0, 0, 0, 100, 4, 8000, 14000, 19000, 24000, 11, 54708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16244, 0, 4, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 54701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Mutated Grub
INSERT INTO smart_scripts VALUES(16297, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 6000, 8000, 11, 30109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(16297, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 6000, 8000, 11, 54769, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Plagued Ghoul
INSERT INTO smart_scripts VALUES(16447, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 13000, 16000, 11, 55876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Stitched Colossus
INSERT INTO smart_scripts VALUES(30071, 0, 0, 0, 0, 0, 100, 2, 6000, 12000, 15000, 22000, 11, 55821, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(30071, 0, 1, 0, 0, 0, 100, 4, 6000, 12000, 15000, 22000, 11, 55826, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(30071, 0, 2, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 54356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Vigilant Shade
INSERT INTO smart_scripts VALUES(30085, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 55848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(30085, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 55848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(30085, 0, 2, 0, 0, 0, 100, 2, 3000, 4000, 10000, 12000, 11, 55850, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
INSERT INTO smart_scripts VALUES(30085, 0, 3, 0, 0, 0, 100, 4, 3000, 4000, 10000, 12000, 11, 55851, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell IC");
-- Toxic Tunnel
REPLACE INTO creature_template_addon VALUES(16400, 0, 0, 0, 1, 0, "28370");
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=16400;

-- Remove Triggers
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE map=533 AND id IN(16137, 16082, 15384));
DELETE FROM creature WHERE map=533 AND id IN(16137, 16082, 15384);
UPDATE creature_template SET flags_extra=130 WHERE entry=16137;

-- Frogger
INSERT INTO creature VALUES (NULL, 16082, 533, 3, 1, 0, 0, 3128.59, -3118.81, 293.346, 4.76754, 300, 0, 0, 17010, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 16082, 533, 3, 1, 0, 0, 3154.25, -3125.7, 293.43, 4.47694, 300, 0, 0, 17010, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 16082, 533, 3, 1, 0, 0, 3175.42, -3134.86, 293.34, 4.284, 300, 0, 0, 17010, 0, 0, 0, 0, 0);
REPLACE INTO creature_template VALUES (16082, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Naxxramas Trigger', NULL, NULL, 0, 80, 80, 2, 974, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, 'boss_naxxramas_misc', 12340);
REPLACE INTO creature_template VALUES (16027, 0, 0, 0, 0, 0, 12349, 0, 0, 0, 'Living Poison', '', NULL, 0, 81, 81, 2, 974, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7.5, 2500, 0, 1, 33554496, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 9, 2, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 8388624, 0, 'boss_naxxramas_misc', 12340);
REPLACE INTO creature_template VALUES (16998, 0, 0, 0, 0, 0, 16622, 0, 0, 0, 'Mr. Bigglesworth', '', '', 0, 5, 5, 0, 32, 0, 1, 1.14286, 1, 0, 5, 7, 0, 32, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 3, 4, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 'boss_naxxramas_misc', 12340);

-- ACHIEVEMENTS
-- And They Would All Go Down Together (10 player) (2176)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7600);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7600);
INSERT INTO achievement_criteria_data VALUES(7600, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7600, 18, 0, 0, "");

-- And They Would All Go Down Together (25 player) (2177)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7601);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7601);
INSERT INTO achievement_criteria_data VALUES(7601, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7601, 18, 0, 0, "");

-- Arachnophobia (10 player) (1858)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7128);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7128);
INSERT INTO achievement_criteria_data VALUES(7128, 12, 0, 0, "");

-- Arachnophobia (25 player) (1859)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7129);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7129);
INSERT INTO achievement_criteria_data VALUES(7129, 12, 1, 0, "");

-- Just Can't Get Enough (10 player) (2184)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7614);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7614);
INSERT INTO achievement_criteria_data VALUES(7614, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7614, 18, 0, 0, "");

-- Just Can't Get Enough (25 player) (2185)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7615);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7615);
INSERT INTO achievement_criteria_data VALUES(7615, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7615, 18, 0, 0, "");

-- Kel'Thuzad's Defeat (10 player) (574)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(381);
DELETE FROM disables WHERE sourceType=4 AND entry IN(381);
INSERT INTO achievement_criteria_data VALUES(381, 12, 0, 0, "");

-- Kel'Thuzad's Defeat (25 player) (575)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(382);
DELETE FROM disables WHERE sourceType=4 AND entry IN(382);
INSERT INTO achievement_criteria_data VALUES(382, 12, 1, 0, "");

-- Make Quick Werk Of Him (10 player) (1856)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7126);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7126);
INSERT INTO achievement_criteria_data VALUES(7126, 12, 0, 0, "");

-- Make Quick Werk Of Him (25 player) (1857)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7127);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7127);
INSERT INTO achievement_criteria_data VALUES(7127, 12, 1, 0, "");

-- Momma Said Knock You Out (10 player) (1997)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7265);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7265);
INSERT INTO achievement_criteria_data VALUES(7265, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7265, 18, 0, 0, "");

-- Momma Said Knock You Out (25 player) (2140)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7549);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7549);
INSERT INTO achievement_criteria_data VALUES(7549, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7549, 18, 0, 0, "");

-- Realm First! Conqueror of Naxxramas (1402)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5227);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5227);
INSERT INTO achievement_criteria_data VALUES(5227, 12, 1, 0, "");

-- Sapphiron's Demise (10 player) (572)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(379);
DELETE FROM disables WHERE sourceType=4 AND entry IN(379);
INSERT INTO achievement_criteria_data VALUES(379, 12, 0, 0, "");

-- Sapphiron's Demise (25 player) (573)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3847);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3847);
INSERT INTO achievement_criteria_data VALUES(3847, 12, 1, 0, "");

-- Shocking! (10 player) (2178)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7604);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7604);
INSERT INTO achievement_criteria_data VALUES(7604, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7604, 18, 0, 0, "");

-- Shocking! (25 player) (2179)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7605);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7605);
INSERT INTO achievement_criteria_data VALUES(7605, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7605, 18, 0, 0, "");

-- Spore Loser (10 player) (2182)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7612);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7612);
INSERT INTO achievement_criteria_data VALUES(7612, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7612, 18, 0, 0, "");

-- Spore Loser (25 player) (2183)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7613);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7613);
INSERT INTO achievement_criteria_data VALUES(7613, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7613, 18, 0, 0, "");

-- Subtraction (10 player) (2180)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7608);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7608);
INSERT INTO achievement_criteria_data VALUES(7608, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7608, 18, 0, 0, "");

-- Subtraction (25 player) (2181)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7609);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7609);
INSERT INTO achievement_criteria_data VALUES(7609, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7609, 18, 0, 0, "");

-- The Arachnid Quarter (10 player) (562)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(351, 352, 353);
DELETE FROM disables WHERE sourceType=4 AND entry IN(351, 352, 353);
INSERT INTO achievement_criteria_data VALUES(351, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(352, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(353, 12, 0, 0, "");

-- The Arachnid Quarter (25 player) (563)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3834, 3835, 3836);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3834, 3835, 3836);
INSERT INTO achievement_criteria_data VALUES(3834, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3835, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3836, 12, 1, 0, "");

-- The Construct Quarter (10 player) (564)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(357, 358, 359, 360);
DELETE FROM disables WHERE sourceType=4 AND entry IN(357, 358, 359, 360);
INSERT INTO achievement_criteria_data VALUES(357, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(358, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(359, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(360, 12, 0, 0, "");

-- The Construct Quarter (25 player) (565)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3837, 3838, 3839, 3840);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3837, 3838, 3839, 3840);
INSERT INTO achievement_criteria_data VALUES(3837, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3838, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3839, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3840, 12, 1, 0, "");

-- The Dedicated Few (10 player) (578)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6802, 7146, 7147, 7148, 7149, 7150, 7151, 7152, 7153, 7154, 7155, 7156, 7157, 7158);
DELETE FROM disables WHERE sourceType=4 AND entry IN(6802, 7146, 7147, 7148, 7149, 7150, 7151, 7152, 7153, 7154, 7155, 7156, 7157, 7158);
INSERT INTO achievement_criteria_data VALUES(6802, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7146, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7147, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7148, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7149, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7150, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7151, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7152, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7153, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7154, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7155, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7156, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7157, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7158, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(6802, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7146, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7147, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7148, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7149, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7150, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7151, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7152, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7153, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7154, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7155, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7156, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7157, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7158, 18, 0, 0, "");

-- The Dedicated Few (25 player) (579)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7159, 7160, 7161, 7162, 7163, 7164, 7165, 7166, 7167, 7168, 7169, 7170, 7171, 7172);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7159, 7160, 7161, 7162, 7163, 7164, 7165, 7166, 7167, 7168, 7169, 7170, 7171, 7172);
INSERT INTO achievement_criteria_data VALUES(7159, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7160, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7161, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7162, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7163, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7164, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7165, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7166, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7167, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7168, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7169, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7170, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7171, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7172, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7159, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7160, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7161, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7162, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7163, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7164, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7165, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7166, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7167, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7168, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7169, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7170, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7171, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7172, 18, 0, 0, "");

-- The Fall of Naxxramas (10 player) (576)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(383, 384, 385, 386, 387, 388);
DELETE FROM disables WHERE sourceType=4 AND entry IN(383, 384, 385, 386, 387, 388);

-- The Fall of Naxxramas (25 player) (577)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(389, 390, 391, 392, 393, 394);
DELETE FROM disables WHERE sourceType=4 AND entry IN(389, 390, 391, 392, 393, 394);

-- The Hundred Club (10 player) (2146)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7567);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7567);
INSERT INTO achievement_criteria_data VALUES(7567, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7567, 18, 0, 0, "");

-- The Hundred Club (25 player) (2147)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7568);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7568);
INSERT INTO achievement_criteria_data VALUES(7568, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7568, 18, 0, 0, "");

-- The Military Quarter (10 player) (568)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(372, 373, 7192);
DELETE FROM disables WHERE sourceType=4 AND entry IN(372, 373, 7192);
INSERT INTO achievement_criteria_data VALUES(372, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(373, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7192, 12, 0, 0, "");

-- The Military Quarter (25 player) (569)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3844, 3845, 7193);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3844, 3845, 7193);
INSERT INTO achievement_criteria_data VALUES(3844, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3845, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7193, 12, 1, 0, "");

-- The Plague Quarter (10 player) (566)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(365, 366, 367);
DELETE FROM disables WHERE sourceType=4 AND entry IN(365, 366, 367);
INSERT INTO achievement_criteria_data VALUES(365, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(366, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(367, 12, 0, 0, "");

-- The Plague Quarter (25 player) (567)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3841, 3842, 3843);
DELETE FROM disables WHERE sourceType=4 AND entry IN(3841, 3842, 3843);
INSERT INTO achievement_criteria_data VALUES(3841, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3842, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(3843, 12, 1, 0, "");

-- The Safety Dance (10 player) (1996)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7264);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7264);
INSERT INTO achievement_criteria_data VALUES(7264, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7264, 18, 0, 0, "");

-- The Safety Dance (25 player) (2139)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7548);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7548);
INSERT INTO achievement_criteria_data VALUES(7548, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7548, 18, 0, 0, "");

-- The Undying (2187)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7617, 13237, 13238, 13239, 13240);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7617, 13237, 13238, 13239, 13240);
INSERT INTO achievement_criteria_data VALUES(7617, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13237, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13238, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13239, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13240, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7617, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13237, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13238, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13239, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13240, 18, 0, 0, "");

-- The Immortal (2186)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7616, 13233, 13234, 13235, 13236);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7616, 13233, 13234, 13235, 13236);
INSERT INTO achievement_criteria_data VALUES(7616, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(13233, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(13234, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(13235, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(13236, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7616, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13233, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13234, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13235, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(13236, 18, 0, 0, "");

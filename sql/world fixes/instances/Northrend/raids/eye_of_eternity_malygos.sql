-- vortex animation
-- platform "fly up" animation

UPDATE `instance_template` SET `script`="instance_eye_of_eternity" WHERE `map`=616;

-- ###################
-- ### GAMEOBJECTS
-- ###################

DELETE FROM `gameobject` WHERE map=616;

-- Nexus Raid Platform (193070)
REPLACE INTO `gameobject_template` VALUES (193070, 33, 8387, 'Nexus Raid Platform', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 8387, 0, 0, 0, 0, 0, 8386, 1, 0, 0, 0, 0, 1000000, 0, 50, 0, 0, 0, 0, 1, '', '', 12340);
REPLACE INTO `gameobject` VALUES (NULL, 193070, 616, 3, 1, 754.346, 1300.87, 256.249, 3.14159, 0, '0', '0', '1', 180, 0, 1, 0);

-- Alexstrasza's Gift (193905,193967)
REPLACE INTO `gameobject_template` VALUES (193905, 3, 8513, 'Alexstrasza\'s Gift', '', '', '', 0, 0, 15, '0', '0', '0', 0, 0, 0, 1818, 26094, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '',11723);
REPLACE INTO `gameobject_template` VALUES (193967, 3, 8513, 'Alexstrasza\'s Gift', '', '', '', 0, 0, 15, '0', '0', '0', 0, 0, 0, 1818, 26097, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '',11159);
DELETE FROM gameobject WHERE id IN(193905,193967);

-- Heart of Magic (194158, 194159)
UPDATE gameobject_template SET flags=4 WHERE entry IN(194158, 194159);

-- The Focusing Iris (193958,193960)
REPLACE INTO `gameobject_template` VALUES (193958, 10, 7800, 'The Focusing Iris', '', '', '', 0, 0, 5, '0', '0', '0', 0, 0, 0, 1817, 0, 20711, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_the_focusing_iris',11723);
REPLACE INTO `gameobject_template` VALUES (193960, 10, 7800, 'The Focusing Iris', '', '', '', 0, 0, 5, '0', '0', '0', 0, 0, 0, 1816, 0, 20711, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_the_focusing_iris',11159);
REPLACE INTO `gameobject` VALUES (NULL, 193958, 616, 1, 1, 754.346, 1301.27, 266.254, 3.14159, 0, '0', '0', '0', 180, 0, 1, 0);
REPLACE INTO `gameobject` VALUES (NULL, 193960, 616, 2, 1, 754.346, 1301.27, 266.254, 3.14159, 0, '0', '0', '0', 180, 0, 1, 0);

-- Exit Portal (193908)
REPLACE INTO `gameobject` VALUES (NULL, 193908, 616, 3, 1, 724.684, 1332.92, 267.234, -0.802851, 0, '0', '0', '1', 180, 0, 1, 0);




-- ###################
-- ### NPCS
-- ###################

-- World Trigger (Large AOI) (22517)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22517) and `map`=616 );
DELETE FROM creature WHERE id IN(22517) and `map`=616;
INSERT INTO `creature` VALUES (NULL, 22517, 616, 3, 1, 16925, 0, 754.395, 1301.27, 266.254, 1.0821, 3600, 0, 0, 4120, 0, 0, 0, 0, 0);

-- Alexstrasza's Gift (32448)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32448) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(32448);
DELETE FROM creature WHERE id IN(32448) and `map`=616;
UPDATE creature_template SET flags_extra=130 WHERE entry=32448;

-- Portal (Malygos) (30118)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30118) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30118);
DELETE FROM creature WHERE id IN(30118) and `map`=616;
REPLACE INTO `creature_template` VALUES (30118, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Portal (Malygos)', '', '', 0, 80, 80, 2, 35, 0, 1, 1, 2, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554948, 2048, 0, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);

-- Alexstrasza the Life-Binder (32295)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32295) and `map`=616 );
REPLACE INTO creature_template_addon VALUES(32295, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature WHERE id IN(32295) and `map`=616;
REPLACE INTO `creature_template` VALUES (32295, 0, 0, 0, 0, 0, 27569, 0, 0, 0, 'Alexstrasza the Life-Binder', 'Queen of the Dragons', '', 0, 83, 83, 0, 35, 0, 1, 2.85714, 1, 3, 543, 684, 0, 678, 35, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 10000, 1000, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1, 'npc_alexstrasza', 11723);
DELETE FROM smart_scripts WHERE entryorguid=32295 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3229500 AND source_type=9;


-- ###################
-- ### SPELLS
-- ###################

-- Arcane Barrage (56397)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(56397, -56397, 63934, -63934) OR spell_effect IN(56397, -56397, 63934, -63934);
REPLACE INTO spell_linked_spell VALUES(56397, 63934, 1, "Arcane Barrage - Arcane Barrage");
DELETE FROM spell_script_names WHERE spell_id IN(56397, -56397, 63934, -63934);

-- Arcane Overload (56430)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(56429, 56430, 56431, 56432, 56435, 56438, -56429, -56430, -56431, -56432, -56435, -56438) OR spell_effect IN(56429, 56430, 56431, 56432, 56435, 56438, -56429, -56430, -56431, -56432, -56435, -56438);
DELETE FROM spell_script_names WHERE spell_id IN(56429, 56430, 56431, 56432, 56435, 56438, -56429, -56430, -56431, -56432, -56435, -56438);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(56429);

-- Surge of Power (56505)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(56505, -56505) OR spell_effect IN(56505, -56505);
DELETE FROM spell_script_names WHERE spell_id IN(56505, -56505);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(56505);
INSERT INTO conditions VALUES(13, 1, 56505, 0, 0, 31, 0, 3, 30334, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 56505, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");

-- Destroy Platform Event (59099)
-- Destroy Platform Boom Visual (59084)
DELETE FROM event_scripts WHERE id=20158;
DELETE FROM spell_linked_spell WHERE spell_trigger IN(59099, -59099, 59084, -59084) OR spell_effect IN(59099, -59099, 59084, -59084);
DELETE FROM spell_script_names WHERE spell_id IN(59099, -59099, 59084, -59084);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(59099,59084);

-- Surge of Power (57407, 60936) (Phase 3!)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(57407, -57407, 60936, -60936) OR spell_effect IN(57407, -57407, 60936, -60936);
DELETE FROM spell_script_names WHERE spell_id IN(57407, -57407, 60936, -60936);
INSERT INTO spell_script_names VALUES(57407, "spell_eoe_ph3_surge_of_power"),(60936, "spell_eoe_ph3_surge_of_power");

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_vortex_dummy' AND spell_id=56105;
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_vortex_visual' AND spell_id=55873;
DELETE FROM spell_script_names WHERE ScriptName='spell_wyrmrest_skytalon_summon_red_dragon_buddy' AND spell_id=56070;
DELETE FROM spell_script_names WHERE ScriptName='spell_wyrmrest_skytalon_ride_red_dragon_buddy_trigger' AND spell_id=56072;
DELETE FROM spell_script_names WHERE ScriptName='spell_wyrmrest_skytalon_summon_red_dragon_buddy' AND spell_id=56070;
DELETE FROM spell_script_names WHERE ScriptName='spell_wyrmrest_skytalon_summon_red_dragon_buddy' AND spell_id=56070;
DELETE FROM spell_script_names WHERE ScriptName='spell_alexstrasza_gift_beam_visual' AND spell_id=61023;
DELETE FROM spell_script_names WHERE ScriptName='spell_alexstrasza_gift_beam' AND spell_id=61028;
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_arcane_storm' AND spell_id IN(57459, 61693, 61694);
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_destroy_platform_channel' AND spell_id=58842;
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_portal_beam' AND spell_id=56046;
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_random_portal' AND spell_id=56047;
DELETE FROM spell_script_names WHERE ScriptName='spell_malygos_surge_of_power_warning_selector_25' AND spell_id=60939;
DELETE FROM spell_script_names WHERE ScriptName='spell_nexus_lord_align_disk_aggro' AND spell_id=61210;	
	
-- TC, remove unused condition Alexstrasza - Gift
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(61028);

	


-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- A Poke In The Eye (10 player) (1869)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7174);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7174);
INSERT INTO achievement_criteria_data VALUES(7174, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7174, 18, 0, 0, "");

-- A Poke In The Eye (25 player) (1870)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7175);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7175);
INSERT INTO achievement_criteria_data VALUES(7175, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7175, 18, 0, 0, "");

-- Denyin' the Scion (10 player) (2148)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7573);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7573);
INSERT INTO achievement_criteria_data VALUES(7573, 1, 30249, 0, "");
INSERT INTO achievement_criteria_data VALUES(7573, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7573, 18, 0, 0, "");

-- Denyin' the Scion (25 player) (2149)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7574);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7574);
INSERT INTO achievement_criteria_data VALUES(7574, 1, 30249, 0, "");
INSERT INTO achievement_criteria_data VALUES(7574, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7574, 18, 0, 0, "");

-- Realm First! Magic Seeker (1400)
DELETE FROM disables WHERE sourceType=4 AND entry IN(5223);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5223);
INSERT INTO achievement_criteria_data VALUES(5223, 12, 1, 0, "");

-- The Spellweaver's Downfall (10 player) (622)
DELETE FROM disables WHERE sourceType=4 AND entry IN(520);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(520);
INSERT INTO achievement_criteria_data VALUES(520, 12, 0, 0, "");

-- The Spellweaver's Downfall (25 player) (623)
DELETE FROM disables WHERE sourceType=4 AND entry IN(521);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(521);
INSERT INTO achievement_criteria_data VALUES(521, 12, 1, 0, "");

-- You Don't Have An Eternity (10 player) (1874)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7182);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7182);
INSERT INTO achievement_criteria_data VALUES(7182, 12, 0, 0, "");

-- You Don't Have An Eternity (25 player) (1875)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7183);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7183);
INSERT INTO achievement_criteria_data VALUES(7183, 12, 1, 0, "");




-- ###################
-- ### MALYGOS
-- ###################

-- Malygos (28859, 31734)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(28859, 31734) and `map`=616 );
REPLACE INTO creature_template_addon VALUES(28859, 0, 0, 50331648, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(31734, 0, 0, 50331648, 1, 0, '');
UPDATE creature SET spawndist=0, MovementType=7 WHERE id=28859;
REPLACE INTO `creature_template` VALUES (28859, 31734, 0, 0, 0, 0, 26752, 0, 0, 0, 'Malygos', '', '', 0, 83, 83, 2, 14, 0, 2, 2, 1, 3, 496, 674, 0, 783, 25, 2000, 0, 2, 131074, 2048, 0, 0, 0, 0, 0, 0, 365, 529, 98, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 500, 50, 1, 0, 44650, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, 'boss_malygos', 1);
REPLACE INTO `creature_template` VALUES (31734, 0, 0, 0, 0, 0, 26752, 0, 0, 0, 'Malygos', '', '', 0, 83, 83, 2, 14, 0, 2, 2, 1, 3, 509, 683, 0, 805, 50, 2000, 0, 2, 131074, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1400, 50, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, '', 1);

-- Power Spark (30084, 32187)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30084, 32187) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30084, 32187);
DELETE FROM creature WHERE id IN(30084, 32187) and `map`=616;
REPLACE INTO `creature_template` VALUES (30084, 32187, 0, 0, 0, 0, 26753, 0, 0, 0, 'Power Spark', '', '', 0, 79, 79, 2, 14, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 334, 494, 95, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650838847, 0+0x200000, 'npc_power_spark', 11723);
REPLACE INTO `creature_template` VALUES (32187, 0, 0, 0, 0, 0, 26753, 0, 0, 0, 'Power Spark (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 650838847, 0+0x200000, '', 1);

-- Vortex (30090)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30090) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30090);
DELETE FROM creature WHERE id IN(30090) and `map`=616;
REPLACE INTO `creature_template` VALUES (30090, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Vortex', '', '', 0, 80, 80, 2, 35, 0, 9, 9, 1, 0, 0, 0, 0, 0, 0, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 345, 509, 153, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 174, 0, 0, '', 0, 4, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 1, 0, 0, 'npc_vortex_ride', 1);

-- Nexus Lord (30245, 31750)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30245, 31750) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30245, 31750);
DELETE FROM creature WHERE id IN(30245, 31750) and `map`=616;
REPLACE INTO `creature_template` VALUES (30245, 31750, 0, 0, 0, 0, 24316, 24317, 24318, 24319, 'Nexus Lord', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 17, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617291903, 0+0x200000, 'npc_nexus_lord', 11723);
REPLACE INTO `creature_template` VALUES (31750, 0, 0, 0, 0, 0, 24316, 24318, 24317, 24319, 'Nexus Lord (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 35, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 45, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617291903, 0+0x200000, '', 1);

-- Scion of Eternity (30249, 31751)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30249, 31751) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30249, 31751);
DELETE FROM creature WHERE id IN(30249, 31751) and `map`=616;
REPLACE INTO `creature_template` VALUES (30249, 31751, 0, 0, 0, 0, 24316, 24317, 24318, 24319, 'Scion of Eternity', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 2000, 0, 8, 131072, 2048, 8, 0, 0, 0, 0, 0, 306, 454, 64, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617291903, 0+0x200000, 'npc_scion_of_eternity', 11723);
REPLACE INTO `creature_template` VALUES (31751, 0, 0, 0, 0, 0, 24316, 24318, 24317, 24319, 'Scion of Eternity (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 0, 0, 0, 0, 1, 2000, 0, 8, 131072, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617291903, 0+0x200000, '', 1);

-- Hover Disk (30248, 31749)
DELETE FROM vehicle_template_accessory WHERE entry IN(30248, 31749);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30248, 31749) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30248, 31749);
DELETE FROM creature WHERE id IN(30248, 31749) and `map`=616;
REPLACE INTO `creature_template` VALUES (30248, 31749, 0, 0, 0, 0, 26876, 0, 0, 0, 'Hover Disk', '', 'vehichleCursor', 0, 80, 80, 2, 35, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_hover_disk', 11723);
REPLACE INTO `creature_template` VALUES (31749, 0, 0, 0, 0, 0, 26876, 0, 0, 0, 'Hover Disk (1)', '', 'vehichleCursor', 0, 80, 80, 2, 35, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
-- Xinef: Unused
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_melee_hover_disk' AND entry=30234;

-- Arcane Overload (30282)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30282) and `map`=616 );
REPLACE INTO creature_template_addon VALUES(30282, 0, 0, 0, 1, 0, "56431 56432");
DELETE FROM creature WHERE id IN(30282) and `map`=616;
REPLACE INTO `creature_template` VALUES (30282, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Arcane Overload', '', '', 0, 80, 80, 2, 14, 0, 1, 1, 6, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 11723);

-- Surge of Power (30334)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30334) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30334);
DELETE FROM creature WHERE id IN(30334) and `map`=616;
REPLACE INTO `creature_template` VALUES (30334, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Surge of Power', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 7.5, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);

-- Wyrmrest Skytalon (30161, 31752)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30161, 31752) and `map`=616 );
DELETE FROM creature_template_addon WHERE entry IN(30161, 31752);
DELETE FROM creature WHERE id IN(30161, 31752) and `map`=616;
REPLACE INTO `creature_template` VALUES (30161, 31752, 0, 0, 0, 0, 25835, 0, 0, 0, 'Wyrmrest Skytalon', '', '', 0, 80, 80, 2, 35, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 4, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56091, 56092, 57090, 57143, 57108, 57092, 57403, 0, 0, 220, 0, 0, '', 0, 5, 1, 7.93651, 1, 1, 0, 0, 0, 0, 0, 0, 0, 231, 1, 0, 0, 'npc_eoe_wyrmrest_skytalon', 11723);
REPLACE INTO `creature_template` VALUES (31752, 0, 0, 0, 0, 0, 25835, 0, 0, 0, 'Wyrmrest Skytalon (1)', '', '', 0, 80, 80, 2, 35, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 4, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56091, 56092, 57090, 57143, 57108, 57092, 57403, 0, 0, 220, 0, 0, '', 0, 5, 1, 7.93651, 1, 1, 0, 0, 0, 0, 0, 0, 0, 231, 1, 0, 0, '', 1);

-- Static Field (30592)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30592) and `map`=616 );
REPLACE INTO creature_template_addon VALUES(30592, 0, 0, 0, 1, 0, "57428");
DELETE FROM creature WHERE id IN(30592) and `map`=616;
REPLACE INTO `creature_template` VALUES (30592, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Static Field', '', '', 0, 80, 80, 2, 14, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 11723);

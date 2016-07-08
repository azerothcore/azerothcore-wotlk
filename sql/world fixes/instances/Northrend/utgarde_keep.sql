-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Disable Fires LOS (186691, 186692, 186693)
REPLACE INTO disables VALUES(7, 186691, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186692, 0, '', '', '');
REPLACE INTO disables VALUES(7, 186693, 0, '', '', '');





-- ###################
-- ### NPCS
-- ###################

-- Zul'Aman Exterior InvisMan (23746)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(23746) AND `map`=574 );
DELETE FROM creature WHERE id=23746 AND map=574;

-- World Trigger (22515)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22515) AND `map`=574 );
DELETE FROM creature WHERE id=22515 AND map=574;

-- Dragonflayer Forge Master (24079,31659)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24079,31659) AND `map`=574 );
REPLACE INTO creature_template_addon VALUES(24079, 0, 0, 0, 1, 416, "");
REPLACE INTO creature_template_addon VALUES(31659, 0, 0, 0, 1, 416, "");

-- Enslaved Proto-Drake (24083,31669)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24083,31669) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(24083,31669);
DELETE FROM creature WHERE id IN(24083,31669) AND `map`=574 AND (position_x<300 OR position_x>420 OR position_y<60 OR position_y>270 OR position_z<20 OR position_z>60); 
UPDATE creature_template SET VehicleId=108 WHERE entry IN(24083,31669);
DELETE FROM vehicle_accessory WHERE guid IN(SELECT guid FROM creature WHERE id IN(24083,31669) AND `map`=574 );
DELETE FROM vehicle_template_accessory WHERE entry IN(24083,31669);
INSERT INTO vehicle_template_accessory VALUES(24083, 24082, 0, 0, "Proto-Drake Handler", 6, 120000);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(24083,31669);
INSERT INTO npc_spellclick_spells VALUES(24083, 46598, 1, 0);
INSERT INTO `creature` VALUES (NULL, 24083, 574, 3, 1, 0, 0, 206.713, -189.298, 200.024, 0.677681, 3600, 0, 0, 71856, 0, 0, 0, 33600, 0);

-- Proto-Drake Handler (24082,31675)
DELETE FROM linked_respawn WHERE guid IN( SELECT guid FROM creature WHERE id IN(24082,31675) AND `map`=574 );
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24082,31675) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(24082,31675);
DELETE FROM creature WHERE id IN(24082,31675) AND map=574;
INSERT INTO `creature` VALUES (NULL, 24082, 574, 3, 1, 0, 1, 344.983, 157.278, 30.8423, 5.65487, 3600, 0, 0, 35928, 3155, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 24082, 574, 3, 1, 0, 1, 393.243, 149.484, 30.8612, 1.0821, 3600, 0, 0, 35928, 3155, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 24082, 574, 3, 1, 0, 1, 377.682, 183.172, 30.8612, 2.68781, 3600, 0, 0, 35928, 3155, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 24082, 574, 3, 1, 0, 1, 342.115, 202.497, 30.8997, 1.95477, 3600, 0, 0, 35928, 3155, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 24082, 574, 3, 1, 0, 1, 327.887, 205.659, 30.9036, 0.680678, 3600, 0, 0, 35928, 3155, 0, 0, 0, 0);

-- Proto-Drake Rider (24849,31676)
DELETE FROM creature_template_addon WHERE entry IN(24849,31676);
-- everything is done correctly in creature_addon in tdb (paths, hover/flying flags, mountid, auras)
-- REPLACE INTO creature_template_addon VALUES(24849, 0, 22657, 50331648, 1, 0, "54775");
-- REPLACE INTO creature_template_addon VALUES(31676, 0, 22657, 50331648, 1, 0, "54775");

-- Dark Ranger Marrah (24137)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24137) AND `map`=574 );
DELETE FROM creature WHERE id IN(24137) AND map=574;
INSERT INTO `creature` VALUES (NULL, 24137, 574, 3, 1, 0, 1, 180.156, -77.6579, 14.1739, 3.46037, 300, 0, 0, 4399, 0, 0, 0, 0, 0);

-- formations before Keleseth
DELETE FROM creature_formations WHERE leaderGUID IN ( SELECT guid FROM creature WHERE position_x BETWEEN 197 AND 223 AND position_y BETWEEN 184 AND 245 AND position_z BETWEEN 35 AND 45 AND `map`=574 );
SET @frguid = 0;
INSERT INTO creature_formations SELECT @frguid := MIN(guid), MIN(guid), 0, 0, 5, 0, 0 FROM creature WHERE position_x BETWEEN 197 AND 223 AND position_y BETWEEN 184 AND 245 AND position_z BETWEEN 35 AND 45 AND `map`=574 LIMIT 1;
INSERT INTO creature_formations SELECT @frguid, guid, 0, 0, 5, 0, 0 FROM creature WHERE guid<>@frguid AND position_x BETWEEN 197 AND 223 AND position_y BETWEEN 184 AND 245 AND position_z BETWEEN 35 AND 45 AND `map`=574;

-- Enslaved Proto-Drake mini event
REPLACE INTO areatrigger_scripts VALUES(4838, 'SmartTrigger');
REPLACE INTO `smart_scripts` VALUES (4838, 2, 0, 0, 46, 0, 100, 0, 4838, 0, 0, 0, 34, 50, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger in Utgarde Keep near Ingvar - On trigger - Set data in instance');





-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- Utgarde Keep (477)
DELETE FROM disables WHERE sourceType=4 AND entry IN(189,190,191,192);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(189,190,191,192);
REPLACE INTO achievement_criteria_data VALUES(189, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(190, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(191, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(192, 12, 0, 0, "");

-- Heroic: Utgarde Keep (489)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3701,3702,3703,3704);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3701,3702,3703,3704);
REPLACE INTO achievement_criteria_data VALUES(3701, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(3702, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(3703, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(3704, 12, 1, 0, "");

-- On The Rocks (1919)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7231);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7231);
REPLACE INTO achievement_criteria_data VALUES(7231, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7231, 18, 0, 0, "");




-- ###################
-- ### Prince Keleseth
-- ###################

-- Prince Keleseth (23953,30748)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(23953,30748) AND `map`=574 );
REPLACE INTO `creature_template` VALUES (23953, 30748, 0, 0, 0, 0, 25338, 0, 0, 0, 'Prince Keleseth', 'The San\'layn', '', 0, 72, 72, 2, 1885, 0, 1.2, 1.42857, 1, 1, 304, 436, 0, 296, 7.5, 2400, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 268, 399, 40, 6, 72, 23953, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 15, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 0+0x200000, 'boss_keleseth', 12340);
REPLACE INTO `creature_template` VALUES (30748, 0, 0, 0, 0, 0, 25338, 0, 0, 0, 'Prince Keleseth (1)', 'The San\'layn', '', 0, 81, 81, 2, 1885, 0, 1.2, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 64, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 6, 72, 30748, 0, 0, 0, 0, 0, 0, 0, 0, 59389, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 32, 20, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(23953,23953);

-- Frost Tomb (23965,31672)
REPLACE INTO `creature_template` VALUES (23965, 31672, 0, 0, 0, 0, 25865, 0, 0, 0, 'Frost Tomb', '', '', 0, 70, 70, 2, 14, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2400, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.214715, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'npc_frost_tomb', 12340);
REPLACE INTO `creature_template` VALUES (31672, 0, 0, 0, 0, 0, 25865, 0, 0, 0, 'Frost Tomb (1)', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 131076, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.268394, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(23965,31672);

-- Vrykul Skeleton (23970,31635)
REPLACE INTO `creature_template` VALUES (23970, 31635, 0, 0, 0, 0, 27651, 0, 0, 0, 'Vrykul Skeleton', '', '', 0, 70, 70, 2, 14, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2400, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.278334, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 8388624, 64, 'npc_vrykul_skeleton', 12340);
REPLACE INTO `creature_template` VALUES (31635, 0, 0, 0, 0, 0, 27651, 0, 0, 0, 'Vrykul Skeleton (1)', '', '', 0, 80, 81, 2, 14, 0, 1, 1.14286, 1, 0, 464, 604, 0, 708, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59386, 59397, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.347917, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 8388624, 64, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(23970,31635);

-- spells
DELETE FROM spell_script_names WHERE spell_id IN(42672, -42672, 48400); -- (48400, TC script)
INSERT INTO spell_script_names VALUES(42672, "spell_frost_tomb");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=59386;
INSERT INTO conditions VALUES(13, 1, 59386, 0, 0, 31, 0, 3, 23953, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 59386, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");





-- ###################
-- ### Dalronn and Skarvald
-- ###################

-- Dalronn (24201,31656)
REPLACE INTO `creature_template` VALUES (24201, 31656, 0, 0, 0, 0, 26349, 0, 0, 0, 'Dalronn the Controller', '', '', 0, 72, 72, 2, 1885, 0, 1, 1.42857, 1, 1, 304, 436, 0, 296, 7.5, 2400, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 268, 399, 40, 7, 72, 24201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4019, 6699, '', 0, 3, 1, 10, 12, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, 'boss_dalronn_the_controller', 12340);
REPLACE INTO `creature_template` VALUES (31656, 0, 0, 0, 0, 0, 26349, 0, 0, 0, 'Dalronn the Controller (1)', '', '', 0, 81, 81, 2, 1885, 0, 1, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 72, 31656, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8038, 13398, '', 0, 3, 1, 16, 12, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24201,31656) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(24201,31656);

-- Dalronn Ghost (27389,31657)
REPLACE INTO `creature_template` VALUES (27389, 31657, 0, 0, 0, 0, 26350, 0, 0, 0, 'Dalronn the Controller', '', '', 0, 72, 72, 2, 1885, 0, 1, 1.42857, 1, 1, 304, 436, 0, 296, 7.5, 2400, 0, 2, 33554432, 2048, 8, 0, 0, 0, 0, 0, 268, 399, 40, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 12, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, 'boss_dalronn_the_controller', 12340);
REPLACE INTO `creature_template` VALUES (31657, 0, 0, 0, 0, 0, 26350, 0, 0, 0, 'Dalronn the Controller (1)', '', '', 0, 81, 81, 2, 1885, 0, 1, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 33554432, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16, 12, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(27389,31657) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(27389,31657);

-- Skarvald (24200,31679)
REPLACE INTO `creature_template` VALUES (24200, 31679, 0, 0, 0, 0, 22194, 0, 0, 0, 'Skarvald the Constructor', '', '', 0, 72, 72, 2, 1885, 0, 1.2, 1.42857, 1, 1, 307, 438, 0, 314, 7.5, 2400, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 270, 401, 53, 7, 72, 24200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4052, 6754, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 0+0x200000, 'boss_skarvald_the_constructor', 12340);
REPLACE INTO `creature_template` VALUES (31679, 0, 0, 0, 0, 0, 22194, 0, 0, 0, 'Skarvald the Constructor (1)', '', '', 0, 80, 80, 2, 1885, 0, 1.2, 1.42857, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 31679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8104, 13508, '', 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24200,31679) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(24200,31679);

-- Skarvald Ghost (27390,31680)
REPLACE INTO `creature_template` VALUES (27390, 31680, 0, 0, 0, 0, 24605, 0, 0, 0, 'Skarvald the Constructor', '', '', 0, 72, 72, 2, 1885, 0, 1, 1.14286, 1, 1, 307, 438, 0, 314, 7.5, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 270, 401, 53, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 0+0x200000, 'boss_skarvald_the_constructor', 12340);
REPLACE INTO `creature_template` VALUES (31680, 0, 0, 0, 0, 0, 24605, 0, 0, 0, 'Skarvald the Constructor (1)', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 147, 1, 617299839, 0+0x200000, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(27390,31680) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(27390,31680);

-- Skeletal Minion (28878,31183)
REPLACE INTO `creature_template` VALUES (28878, 31183, 0, 0, 0, 0, 5231, 0, 0, 0, 'Skeletal Minion', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 64, '', 12340);
REPLACE INTO `creature_template` VALUES (31183, 0, 0, 0, 0, 0, 5231, 0, 0, 0, 'Skeletal Minion (1)', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.75, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 64, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(28878,31183) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(28878,31183);




-- ###################
-- ### Ingvar the Plunderer
-- ###################

-- Ingvar the Plunderer (23954,31673)
REPLACE INTO `creature_template` VALUES (23954, 31673, 0, 0, 0, 0, 21953, 0, 0, 0, 'Ingvar the Plunderer', '', '', 0, 72, 72, 2, 1885, 0, 1.2, 1.42857, 1.2, 1, 307, 438, 0, 314, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 270, 401, 53, 7, 8, 23954, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4056, 6760, '', 0, 3, 1, 12.5, 1, 1, 0, 33330, 0, 0, 0, 0, 0, 147, 1, 617299839, 0+0x200000, 'boss_ingvar_the_plunderer', 12340);
REPLACE INTO `creature_template` VALUES (31673, 0, 0, 0, 0, 0, 21953, 0, 0, 0, 'Ingvar the Plunderer (1)', '', '', 0, 81, 81, 2, 1885, 0, 1.2, 1.42857, 1.2, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 7, 8, 31673, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8112, 13520, '', 0, 3, 1, 19, 1, 1, 0, 33330, 43662, 0, 0, 0, 0, 147, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(23954,31673) AND `map`=574 );
DELETE FROM creature_template_addon WHERE entry IN(23954,31673);

-- Ingvar the Plunderer (UNDEAD) (23980,31674)
REPLACE INTO `creature_template` VALUES (23980, 31674, 0, 0, 0, 0, 26351, 0, 0, 0, 'Ingvar the Plunderer', '', '', 0, 72, 72, 2, 1885, 0, 1, 1.14286, 1, 1, 307, 438, 0, 314, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 270, 401, 53, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12.5, 1, 1, 0, 33330, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, '', 12340);
REPLACE INTO `creature_template` VALUES (31674, 0, 0, 0, 0, 0, 26351, 0, 0, 0, 'Ingvar the Plunderer (1)', '', '', 0, 81, 81, 2, 1885, 0, 1, 1.14286, 1, 1, 464, 604, 0, 314, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 19, 1, 1, 0, 33330, 43662, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(23980,31674);

-- Annhylde the Caller (24068,31655)
REPLACE INTO `creature_template` VALUES (24068, 31655, 0, 0, 0, 0, 24991, 0, 0, 0, 'Annhylde the Caller', '', '', 0, 72, 72, 2, 1885, 0, 0.8, 0.5, 1, 1, 307, 438, 0, 314, 7.5, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 270, 401, 53, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 48, 1, 80428891, 2, '', 12340);
REPLACE INTO `creature_template` VALUES (31655, 0, 0, 0, 0, 0, 24991, 0, 0, 0, 'Annhylde the Caller (1)', '', '', 0, 80, 81, 2, 1885, 0, 0.8, 0.5, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 48, 1, 80428891, 2, '', 12340);
REPLACE INTO creature_template_addon VALUES(24068, 0, 0, 50331648, 1, 0, ''),(31655, 0, 0, 50331648, 1, 0, '');

-- Ingvar Throw Dummy (23997,31835)
REPLACE INTO `creature_template` VALUES (23997, 31835, 0, 0, 0, 0, 16946, 0, 0, 0, 'Ingvar Throw Dummy', '', '', 0, 70, 70, 2, 14, 0, 8, 2.85714, 1, 0, 252, 357, 0, 304, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 231, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31835, 0, 0, 0, 0, 0, 16946, 0, 0, 0, 'Ingvar Throw Dummy (1)', '', '', 0, 82, 82, 2, 14, 0, 8, 2.85714, 1, 0, 488, 642, 0, 782, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 265, 1, 0, 0, '', 12340);
REPLACE INTO creature_template_addon VALUES(23997, 0, 0, 0, 1, 0, "42750");
REPLACE INTO creature_template_addon VALUES(31835, 0, 0, 0, 1, 0, "59719");

-- spells
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42857;
INSERT INTO conditions VALUES(13, 1, 42857, 0, 0, 31, 0, 3, 23954, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 42857, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, "", "");

-- texts
REPLACE INTO creature_text VALUES (23954, 6, 0, '%s roars!', 41, 0, 100, 0, 0, 0, 0, 'ingvar EMOTE_ROAR');
REPLACE INTO creature_text VALUES (24068, 0, 0, 'Ingvar! You have been judged and found worthy! Arise and slaughter in the Lich King\'s name!', 14, 0, 100, 0, 0, 0, 0, 'ingvar YELL_ANNHYLDE_1');
REPLACE INTO creature_text VALUES (24068, 1, 0, 'Ingvar! Your pathetic failure will serve as a warning to all... you are damned! Arise and carry out the master\'s will!', 14, 0, 100, 0, 0, 13754, 0, 'ingvar YELL_ANNHYLDE_2');

-- DF reward fix
REPLACE INTO instance_encounters VALUES(575, 0, 23954, 202, "Ingvar the Plunderer");
REPLACE INTO instance_encounters VALUES(576, 0, 23954, 242, "Ingvar the Plunderer");

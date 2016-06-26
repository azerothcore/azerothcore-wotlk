DELETE FROM disables WHERE sourceType=2 AND entry IN(668);
-- INSERT INTO disables VALUES(2, 668, 3, "", "", "");
REPLACE INTO `access_requirement` VALUES (668, 0, 78, 0, 180, 0, 0, 24710, 24712, 0, NULL, "Halls of Reflection (Entrance)");
REPLACE INTO `access_requirement` VALUES (668, 1, 80, 0, 219, 0, 0, 24710, 24712, 0, NULL, "Halls of Reflection (Entrance)");



-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Ice Wall (201385)
UPDATE gameobject_template SET flags=48 WHERE entry=201385;
DELETE FROM gameobject WHERE id=201385 AND map=668;

-- The Captain's Chest
UPDATE gameobject_template SET flags=0 WHERE entry IN(201710,202336);

-- Gunship Stairs (202211) (horde)
-- Gunship Stairs (201709) (alliance)
DELETE FROM gameobject WHERE id IN(202211, 201709) AND map=668;

-- Cave In (201596)

-- The Skybreaker (201598) -- map 712 -- copy some npcs from original in icecrown (map 623)
-- copy Skybreaker Deckhand (30351), Skybreaker Marine (30352), Skybreaker Cannoneer (30380), Skybreaker Engineer (30394), Skybreaker Shield-Mage (30867)
UPDATE gameobject_template SET flags=40 WHERE entry=201598;
DELETE FROM gameobject WHERE map=712;
DELETE FROM creature WHERE map=712;
INSERT INTO `gameobject` VALUES (NULL, 201710, 712, 1, 1, -14.99, 11.43, 20.41, 1.46, 0, 0, 0.386597, 0.922249, 86400, 0, 1, 0);
INSERT INTO `gameobject` VALUES (NULL, 202336, 712, 2, 1, -14.99, 11.43, 20.41, 1.46, 0, 0, 0.386597, 0.922249, 86400, 0, 1, 0);
INSERT INTO `gameobject` VALUES (NULL, 195682, 712, 3, 1, -3.86, 11.99, 20.44, 1.68, 0, 0, 0.514372, 0.857567, 86400, 0, 1, 0);
INSERT INTO `creature` VALUES (247300, 30344, 712, 3, 1, 0, 1, -9.51, 9.77, 20.43, 1.52, 300, 0, 0, 21368, 0, 0, 0, 0, 0);
SET @myguid = 247300;
INSERT INTO creature SELECT @myguid := @myguid+1, id, 712, 3, 1, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags FROM creature WHERE map=623 AND id IN(30351,30352,30380,30394,30867);


-- Orgrim's Hammer (201599) -- map 713 -- copy some npcs from original in icecrown (map 622)
-- copy Orgrim's Hammer Gunner (30752), Orgrim's Hammer Engineer (30753), Orgrim's Hammer Crew (30754), Kor'kron Reaver (30755), Orgrim's Hammer Shadow-Warder (30866), Warsong Cannon (31243)
UPDATE gameobject_template SET flags=40 WHERE entry=201599;
DELETE FROM gameobject WHERE map=713;
DELETE FROM creature WHERE map=713;
INSERT INTO `gameobject` VALUES (NULL, 201710, 713, 1, 1, 7.43, 19.12, 34.78, 1.14, 0, 0, 0.376252, 0.926518, 86400, 0, 1, 0);
INSERT INTO `gameobject` VALUES (NULL, 202336, 713, 2, 1, 7.43, 19.12, 34.78, 1.14, 0, 0, 0.376252, 0.926518, 86400, 0, 1, 0);
INSERT INTO `gameobject` VALUES (NULL, 195682, 713, 3, 1, 22.28, 20.47, 35.53, 1.88, 0, 0, 0.70357, 0.710626, 86400, 0, 1, 0);
INSERT INTO `creature` VALUES (247400, 30824, 713, 3, 1, 0, 1, 14.81, 16.84, 34.97, 1.55, 300, 0, 0, 21368, 0, 0, 0, 0, 0);
SET @myguid = 247400;
INSERT INTO creature SELECT @myguid := @myguid+1, id, 713, 3, 1, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags FROM creature WHERE map=622 AND id IN(30752,30753,30754,30755,30866,31243);



-- ###################
-- ### NPCS
-- ###################

-- Imprisoned Soul (37906)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37906) AND `map`=668 );
DELETE FROM creature WHERE id IN(37906) AND `map`=668;
UPDATE creature_template SET flags_extra=130 WHERE entry=37906;

-- Frostmourne Altar Bunny (Quel'Delar) (37704)
UPDATE creature_template SET modelid1=17612, modelid2=0, faction=114, unit_flags=33554432, AIName='NullCreatureAI', InhabitType=4, ScriptName='', flags_extra=0 WHERE entry=37704;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37704) AND `map`=668 );
DELETE FROM creature WHERE id IN(37704) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37704, 668, 3, 1, 17612, 0, 5309.26, 2006.39, 718.047, 3.97935, 86400, 0, 0, 12600, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES(37704, 0, 0, 50331648, 1, 0, '');

-- Dark Ranger Loralen (37779,37797)
-- Archmage Elandra (37774,37809)
-- template changes in FoS sql file
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37779, 37774) AND `map`=668 );
DELETE FROM creature WHERE id IN(37779, 37774) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37779, 668, 3, 1, 30687, 1, 5232.69, 1931.52, 707.778, 0.820305, 86400, 0, 0, 75600, 0, 0, 0, 0, 0);

-- Uther the Lightbringer (37225)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37225) AND `map`=668 );
DELETE FROM creature WHERE id IN(37225) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37225, 668, 3, 1, 30821, 1, 5307.81, 2003.17, 709.424, 4.53786, 86400, 0, 0, 315000, 59910, 0, 0, 0, 0);
UPDATE creature_template SET dmg_multiplier=13, speed_run=1.14, unit_flags=33600, AIName='', ScriptName='' WHERE entry=37225;

-- Lady Sylvanas Windrunner (37223)
-- Lady Jaina Proudmoore (37221)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37221, 37223) AND `map`=668 );
DELETE FROM creature WHERE id IN(37221, 37223) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37223, 668, 3, 1, 28213, 1, 5236.67, 1929.91, 707.778, 0.837758, 86400, 0, 0, 6972500, 85160, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=83, maxlevel=83, faction=35, npcflag=2, speed_walk=0.888888, speed_run=0.99206, rank=3, unit_flags=33600, unit_flags2=2048, AIName='', ScriptName='npc_hor_leader' WHERE entry IN(37221, 37223);

-- The Lich King (37226) -- for the intro
UPDATE creature_template SET speed_walk=2, speed_run=1.4, AIName='', ScriptName='' WHERE entry=37226;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37226) AND `map`=668 );
DELETE FROM creature WHERE id IN(37226) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37226, 668, 3, 1, 30721, 0, 5362.46, 2062.69, 707.778, 3.94444, 86400, 0, 0, 27890000, 0, 0, 0, 0, 0);
DELETE FROM creature_equip_template WHERE entry=37226;
INSERT INTO creature_equip_template VALUES(37226, 1, 49706, 0, 0, 0);

-- Falric (38112, 38599)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38112, 38599) AND `map`=668 );
DELETE FROM creature WHERE id IN(38112, 38599) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38112, 668, 3, 1, 0, 1, 5284.161133, 2030.691650, 709.319336, 5.489386, 86400, 0, 0, 377468, 0, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, speed_walk=1.2, speed_run=1.42857, mindmg=12698, maxdmg=14586, attackpower=1, dmg_multiplier=1.1, baseattacktime=1800, unit_flags=832, AIName='', mechanic_immune_mask=617299839, ScriptName='boss_falric', flags_extra=0+0x200000 WHERE entry=38112;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, speed_walk=1.2, speed_run=1.42857, mindmg=18985, maxdmg=21794, attackpower=1, dmg_multiplier=1.1, baseattacktime=1800, unit_flags=832, AIName='', mechanic_immune_mask=617299839, ScriptName='', flags_extra=1+0x200000 WHERE entry=38599;

-- Marwyn (38113, 38603)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38113, 38603) AND `map`=668 );
DELETE FROM creature WHERE id IN(38113, 38603) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38113, 668, 3, 1, 0, 1, 5335.330078, 1982.376221, 709.319580, 2.339942, 86400, 0, 0, 539240, 0, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, speed_walk=1.2, speed_run=1.42857, mindmg=12698, maxdmg=14586, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=832, AIName='', mechanic_immune_mask=617299839, ScriptName='boss_marwyn', flags_extra=0+0x200000 WHERE entry=38113;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, speed_walk=1.2, speed_run=1.42857, mindmg=18985, maxdmg=21794, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=832, AIName='', mechanic_immune_mask=617299839, ScriptName='', flags_extra=1+0x200000 WHERE entry=38603;

-- Shadowy Mercenary (38177, 38564)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38177, 38564) AND `map`=668 );
DELETE FROM creature WHERE id IN(38177, 38564) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5302.25, 1972.41, 707.778, 1.37881, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5311.03, 1972.23, 707.778, 1.64061, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5277.36, 1993.23, 707.778, 0.401426, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5318.7, 2036.11, 707.778, 4.2237, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5335.72, 1996.86, 707.778, 2.74017, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38177, 668, 3, 1, 0, 1, 5299.43, 1979.01, 707.778, 1.23918, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=3352, maxdmg=4570, attackpower=1, dmg_multiplier=1.0, baseattacktime=1200, unit_flags=33555264, AIName='', ScriptName='npc_shadowy_mercenary' WHERE entry=38177;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=5029, maxdmg=6856, attackpower=1, dmg_multiplier=1.0, baseattacktime=1200, unit_flags=33555264, AIName='', ScriptName='' WHERE entry=38564;

-- Spectral Footman (38173, 38525)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38173, 38525) AND `map`=668 );
DELETE FROM creature WHERE id IN(38173, 38525) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5306.06, 2037, 707.778, 4.81711, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5344.15, 2007.17, 707.778, 3.15905, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5337.83, 2010.06, 707.778, 3.22886, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5343.29, 1999.38, 707.778, 2.9147, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5340.84, 1992.46, 707.778, 2.75762, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5325.07, 1977.6, 707.778, 2.07694, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5336.6, 2017.28, 707.778, 3.47321, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5313.82, 1978.15, 707.778, 1.74533, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5280.63, 2012.16, 707.778, 6.05629, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38173, 668, 3, 1, 0, 1, 5322.96, 2040.29, 707.778, 4.34587, 86400, 0, 0, 132300, 0, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=4855, maxdmg=6619, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='npc_spectral_footman' WHERE entry=38173;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=7283, maxdmg=9929, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='' WHERE entry=38525;

-- Tortured Rifleman (38176, 38544)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38176, 38544) AND `map`=668 );
DELETE FROM creature WHERE id IN(38176, 38544) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5343.47, 2015.95, 707.778, 3.49066, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5337.86, 2003.4, 707.778, 2.98451, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5319.16, 1974, 707.778, 1.91986, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5299.25, 2036, 707.778, 5.02655, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5295.64, 1973.76, 707.778, 1.18682, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38176, 668, 3, 1, 0, 1, 5282.9, 2019.6, 707.778, 5.88176, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=4028, maxdmg=5423, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='npc_tortured_rifleman' WHERE entry=38176;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=6014, maxdmg=8187, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='' WHERE entry=38544;

-- Ghostly Priest (38175, 38563)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38175, 38563) AND `map`=668 );
DELETE FROM creature WHERE id IN(38175, 38563) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5277.74, 2016.88, 707.778, 5.96903, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5295.88, 2040.34, 707.778, 5.07891, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5320.37, 1980.13, 707.778, 2.00713, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5280.51, 1997.84, 707.778, 0.296706, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5302.45, 2042.22, 707.778, 4.90438, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38175, 668, 3, 1, 0, 1, 5306.57, 1977.47, 707.778, 1.50098, 86400, 0, 0, 132300, 19970, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=4028, maxdmg=5423, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='npc_ghostly_priest' WHERE entry=38175;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=6014, maxdmg=8187, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='' WHERE entry=38563;

-- Phantom Mage (38172, 38524)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38172, 38524) AND `map`=668 );
DELETE FROM creature WHERE id IN(38172, 38524) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5312.75, 2037.12, 707.778, 4.59022, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5309.58, 2042.67, 707.778, 4.69494, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5275.08, 2008.72, 707.778, 6.21337, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5279.65, 2004.66, 707.778, 0.069813, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5275.48, 2001.14, 707.778, 0.174533, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 38172, 668, 3, 1, 0, 0, 5316.7, 2041.55, 707.778, 4.50295, 86400, 0, 0, 132300, 39940, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=4135, maxdmg=5629, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='npc_phantom_mage' WHERE entry=38172;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=6176, maxdmg=8407, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=33555264, AIName='', ScriptName='' WHERE entry=38524;

-- Phantom Hallucination (38567, 38568)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38567, 38568) AND `map`=668 );
DELETE FROM creature WHERE id IN(38567, 38568) AND `map`=668;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=4135, maxdmg=5629, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=0, AIName='', ScriptName='npc_phantom_hallucination' WHERE entry=38567;
UPDATE creature_template SET speed_walk=1, speed_run=1.28571, mindmg=6176, maxdmg=8407, attackpower=1, dmg_multiplier=1.0, baseattacktime=0, unit_flags=0, AIName='', ScriptName='' WHERE entry=38568;

-- Frostsworn General (36723, 37720)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36723, 37720) AND `map`=668 );
DELETE FROM creature WHERE id IN(36723, 37720) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 36723, 668, 3, 1, 0, 1, 5413.92, 2116.5, 707.695, 3.95015, 86400, 0, 0, 441000, 0, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=16, speed_walk=1, speed_run=1.28, mindmg=11595, maxdmg=13081, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=64, AIName='', mechanic_immune_mask=617299839, ScriptName='boss_frostsworn_general', flags_extra=0+0x200000 WHERE entry=36723;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=16, speed_walk=1, speed_run=1.28, mindmg=16450, maxdmg=19700, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=64, AIName='', mechanic_immune_mask=617299839, ScriptName='', flags_extra=1+0x200000 WHERE entry=37720;

-- Spiritual Reflection (37068, 37721), (37107, 37722)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37068, 37721, 37107, 37722) AND `map`=668 );
DELETE FROM creature WHERE id IN(37068, 37721, 37107, 37722) AND `map`=668;
UPDATE creature_template SET difficulty_entry_1=0 WHERE entry IN(37068, 37721, 37107, 37722);
UPDATE creature_template SET difficulty_entry_1=37721, exp=2, minlevel=80, maxlevel=80, faction=16, speed_walk=1, speed_run=1.14286, mindmg=1734, maxdmg=2364, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=33024, InhabitType=7, AIName='', mechanic_immune_mask=0, ScriptName='npc_hor_spiritual_reflection', flags_extra=0 WHERE entry=37068;
UPDATE creature_template SET exp=2, minlevel=80, maxlevel=80, faction=16, speed_walk=1, speed_run=1.14286, mindmg=2601, maxdmg=3546, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=33024, InhabitType=7, AIName='', mechanic_immune_mask=0, ScriptName='', flags_extra=0 WHERE entry=37721;
INSERT INTO `creature` VALUES (NULL, 37068, 668, 3, 1, 0, 0, 5377.687500, 2115.718262, 716.400000, 0.000000, 86400, 0, 0, 100800, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37068, 668, 3, 1, 0, 0, 5450.000488, 2116.960938, 716.400000, 3.140000, 86400, 0, 0, 100800, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37068, 668, 3, 1, 0, 0, 5412.994141, 2152.547852, 716.400000, 4.710000, 86400, 0, 0, 100800, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37068, 668, 3, 1, 0, 0, 5414.404297, 2080.310059, 716.400000, 1.570000, 86400, 0, 0, 100800, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37068, 668, 3, 1, 0, 0, 5382.038574, 2134.820068, 716.400000, 5.750000, 86400, 0, 0, 100800, 0, 0, 0, 0, 0);

-- The Lich King (36954)
UPDATE creature_template SET difficulty_entry_1=0, speed_walk=2, speed_run=0.86, unit_flags=0, AIName='', RegenHealth=0, ScriptName='npc_hor_lich_king', mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=36954;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36954) AND `map`=668 );
DELETE FROM creature WHERE id IN(36954) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 36954, 668, 3, 1, 0, 1, 5553.07, 2261.91, 733.011, 4.23995, 86400, 0, 0, 27890000, 0, 0, 0, 0, 0);

-- Lady Sylvanas Windrunner (37554)
UPDATE creature_template SET speed_walk=0.888888, speed_run=0.99206, unit_flags=0, AIName='', RegenHealth=0, ScriptName='npc_hor_leader_second' WHERE entry=37554;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37554) AND `map`=668 );
DELETE FROM creature WHERE id IN(37554) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37554, 668, 3, 1, 0, 1, 5551.277, 2257.195, 733.011, 1.22009, 86400, 0, 0, 5040000, 881400, 0, 0, 0, 0);
REPLACE INTO `areatrigger_scripts` VALUES(5605, 'at_hor_shadow_throne');

-- Lady Jaina Proudmoore (36955)
UPDATE creature_template SET speed_walk=0.888888, speed_run=0.99206, unit_flags=0, AIName='', RegenHealth=0, ScriptName='npc_hor_leader_second' WHERE entry=36955;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36955) AND `map`=668 );
DELETE FROM creature WHERE id IN(36955) AND `map`=668;

-- Ice Wall Target (37014)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=16925, modelid2=0, unit_flags=33555200, AIName='NullCreatureAI', ScriptName='', flags_extra=128 WHERE entry=37014;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37014) AND `map`=668 );
DELETE FROM creature WHERE id IN(37014) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 37014, 668, 3, 1, 0, 0, 5550.62, 2079.75, 731.715, 4.32146, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37014, 668, 3, 1, 0, 0, 5504.2, 1974.7, 737.318, 4.04659, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37014, 668, 3, 1, 0, 0, 5445.09, 1881.48, 752.654, 4.13302, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 37014, 668, 3, 1, 0, 0, 5321.39, 1758.07, 770.419, 3.70108, 86400, 0, 0, 1, 0, 0, 0, 0, 0);

-- Raging Ghoul (36940, 37550)
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=578, maxdmg=788, attackpower=1, dmg_multiplier=1.2, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='npc_hor_raging_ghoul', mechanic_immune_mask=8388624 WHERE entry=36940;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=809, maxdmg=1103, attackpower=1, dmg_multiplier=1.2, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=8388624 WHERE entry=37550;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36940, 37550) AND `map`=668 );
DELETE FROM creature WHERE id IN(36940, 37550) AND `map`=668;
DELETE FROM smart_scripts WHERE entryorguid IN(36940, 37550) AND source_type=0;

-- Risen Witch Doctor (36941, 37551)
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=4315, maxdmg=5629, attackpower=1, dmg_multiplier=1.2, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='npc_hor_risen_witch_doctor', mechanic_immune_mask=8388624 WHERE entry=36941;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=6176, maxdmg=8407, attackpower=1, dmg_multiplier=1.2, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=8388624 WHERE entry=37551;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36941, 37551) AND `map`=668 );
DELETE FROM creature WHERE id IN(36941, 37551) AND `map`=668;
DELETE FROM smart_scripts WHERE entryorguid IN(36941, 37551) AND source_type=0;

-- Lumbering Abomination (37069, 37549)
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=9653, maxdmg=13160, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='npc_hor_lumbering_abomination', mechanic_immune_mask=8388624 WHERE entry=37069;
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=1771, speed_walk=2, speed_run=1.42857, mindmg=14450, maxdmg=19700, attackpower=1, dmg_multiplier=1.1, baseattacktime=2000, unit_flags=0, AIName='', ScriptName='', mechanic_immune_mask=8388624 WHERE entry=37549;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37069, 37549) AND `map`=668 );
DELETE FROM creature WHERE id IN(37069, 37549) AND `map`=668;
DELETE FROM smart_scripts WHERE entryorguid IN(37069, 37549) AND source_type=0;

-- Cave In Dummy (32200)
UPDATE creature_template SET modelid1=11686, modelid2=0, faction=35, unit_flags=768+33554432, InhabitType=4, AIName='NullCreatureAI', flags_extra=0 WHERE entry=32200; 
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32200) AND `map`=668 );
DELETE FROM creature WHERE id IN(32200) AND `map`=668;
INSERT INTO `creature` VALUES (NULL, 32200, 668, 3, 1, 0, 0, 5274.607910, 1691.748535, 793.158447, 0.000000, 86400, 0, 0, 1, 0, 0, 0, 0, 0);



-- ###################
-- ### SPELLS
-- ###################

-- Shared Suffering (72368, 72369)
-- additional ids: 72373
DELETE FROM spell_script_names WHERE spell_id IN(72368, 72369, 72373, -72368, -72369, -72373);
DELETE FROM spell_scripts WHERE id IN(72368, 72369, 72373, -72368, -72369, -72373);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(72368, 72369, 72373, -72368, -72369, -72373) OR spell_effect IN(72368, 72369, 72373, -72368, -72369, -72373);
INSERT INTO spell_script_names VALUES(72368, "spell_hor_shared_suffering");
INSERT INTO spell_script_names VALUES(72369, "spell_hor_shared_suffering");

-- Halls of Reflection Clone (69828)
DELETE FROM spell_script_names WHERE spell_id=69828;

-- Ice Prison (69708)
DELETE FROM spell_script_names WHERE spell_id IN(69708, -69708);
DELETE FROM spell_scripts WHERE id IN(69708, -69708);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69708, -69708) OR spell_effect IN(69708, -69708);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=69708;
INSERT INTO `conditions` VALUES (13, 3, 69708, 0, 0, 31, 0, 3, 36954, 0, 0, 0, 0, '', 'Ice Prison (Halls of Reflection)');

-- Dark Binding (70194)
DELETE FROM spell_script_names WHERE spell_id IN(70194, -70194);
DELETE FROM spell_scripts WHERE id IN(70194, -70194);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70194, -70194) OR spell_effect IN(70194, -70194);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=70194;
INSERT INTO `conditions` VALUES (13, 3, 70194, 0, 0, 31, 0, 3, 36954, 0, 0, 0, 0, '', 'Dark Binding (Halls of Reflection)');

-- Destroy Wall (69784) (Jaina)
DELETE FROM spell_script_names WHERE spell_id IN(69784, -69784);
DELETE FROM spell_scripts WHERE id IN(69784, -69784);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69784, -69784) OR spell_effect IN(69784, -69784);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=69784;
INSERT INTO `conditions` VALUES (13, 1, 69784, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Destroy Wall (Halls of Reflection)');

-- Destroy Wall (70224) (Sylvanas)
-- additional ids: 70225
DELETE FROM spell_script_names WHERE spell_id IN(70224, -70224, 70225, -70225);
DELETE FROM spell_scripts WHERE id IN(70224, -70224, 70225, -70225);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70224, -70224, 70225, -70225) OR spell_effect IN(70224, -70224, 70225, -70225);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70224, 70225);
INSERT INTO `conditions` VALUES (13, 1, 70224, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Destroy Wall (Halls of Reflection)');
INSERT INTO `conditions` VALUES (13, 1, 70225, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Destroy Wall (Halls of Reflection)');

-- Summon Ice Wall (69768)
-- additional ids: 69767
DELETE FROM spell_script_names WHERE spell_id IN(69768, -69768, 69767, -69767);
DELETE FROM spell_scripts WHERE id IN(69768, -69768, 69767, -69767);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69768, -69768, 69767, -69767) OR spell_effect IN(69768, -69768, 69767, -69767);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69768, 69767);
-- INSERT INTO `conditions` VALUES (13, 1, 69768, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Summon Ice Wall (Halls of Reflection)');
-- INSERT INTO `conditions` VALUES (13, 5, 69767, 0, 0, 31, 0, 3, 37014, 0, 0, 0, 0, '', 'Summon Ice Wall (Halls of Reflection)');

-- Gunship Cannon Fire (70017)
-- additional ids: 70021, 70246
DELETE FROM spell_script_names WHERE spell_id IN(70017, -70017, 70021, 70246, -70021, -70246);
DELETE FROM spell_scripts WHERE id IN(70017, -70017, 70021, 70246, -70021, -70246);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70017, -70017, 70021, 70246, -70021, -70246) OR spell_effect IN(70017, -70017, 70021, 70246, -70021, -70246);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70017, 70021, 70246);
INSERT INTO `conditions` VALUES (13, 1, 70021, 0, 0, 31, 0, 3, 32200, 0, 0, 0, 0, '', 'Gunship Cannon Fire (Halls of Reflection)');
INSERT INTO `conditions` VALUES (13, 1, 70246, 0, 0, 31, 0, 3, 32200, 0, 0, 0, 0, '', 'Gunship Cannon Fire (Halls of Reflection)');
INSERT INTO spell_script_names VALUES(70017, "spell_hor_gunship_cannon_fire");

-- Achievement Check (72830)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(72830);
INSERT INTO `conditions` VALUES (13, 1, 72830, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Achievement Check (Halls of Reflection)');



-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- The Halls of Reflection (4518)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12742, 12990, 12743);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12742, 12990, 12743);
REPLACE INTO achievement_criteria_data VALUES(12742, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12990, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12743, 12, 0, 0, "");

-- Heroic: The Halls of Reflection (4521)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12750, 12991, 12751);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12750, 12991, 12751);
REPLACE INTO achievement_criteria_data VALUES(12750, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12991, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12751, 12, 1, 0, "");

-- We're Not Retreating; We're Advancing in a Different Direction. (4526)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12756);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12756);
REPLACE INTO achievement_criteria_data VALUES(12756, 12, 1, 0, "");



-- ###################
-- ### TEXTS
-- ###################

-- insert into creature_text select 37225, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%UTHER%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37223, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%SAY_SYLVANAS_INTRO%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37221, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%SAY_JAINA_INTRO%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37226, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%LK_INTRO%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 38112, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%Falric SAY%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 38113, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%Marwyn SAY%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 36723, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%SAY_FROSTSWORN_GENERAL%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 36954, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%LK - %' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37554, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%SYLVANAS - %' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 36955, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%JAINA - %' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37182, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%Transport_ally%' and type<=3 and (entry between -1668128 and -1668001);
-- insert into creature_text select 37833, ABS(entry+1668000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where comment like '%Transport_horda%' and type<=3 and (entry between -1668128 and -1668001);
DELETE FROM creature_text WHERE entry IN(37182, 37833);
DELETE FROM creature_text WHERE entry IN(37225, 37223, 37221, 37226, 38112, 38113, 36723, 36954, 37554, 36955, 30344, 30824); -- uther, sylv 1, jaina 1, lk intro, falric, marwyn, frostsworn general, lk boss, sylv, jaina, bartlett, blackstar
INSERT INTO creature_text VALUES (36723, 98, 0, 'You are not worthy to face the Lich King!', 14, 0, 100, 0, 0, 16921, 0, 'SAY_FROSTSWORN_GENERAL_AGGRO');
INSERT INTO creature_text VALUES (36723, 99, 0, 'Master, I have failed...', 14, 0, 100, 0, 0, 16922, 0, 'SAY_FROSTSWORN_GENERAL_DEATH');
INSERT INTO creature_text VALUES (36954, 100, 0, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 14, 0, 100, 0, 0, 17213, 0, 'LK -  AGGRO HORDE');
INSERT INTO creature_text VALUES (36954, 101, 0, 'Your allies have arrived, Jaina, just as you promised. Your will all become powerful agents of the Scourge.', 14, 0, 100, 0, 0, 17212, 0, 'LK -  AGGRO ALLY');
INSERT INTO creature_text VALUES (36954, 104, 0, 'There is no escape!', 14, 0, 100, 0, 0, 17217, 0, 'LK -  IceWall_1');
INSERT INTO creature_text VALUES (36954, 105, 0, 'Succumb to the chill of the grave.', 14, 0, 100, 0, 0, 17218, 0, 'LK -  IiceWALL_2');
INSERT INTO creature_text VALUES (36954, 106, 0, 'Another dead end.', 14, 0, 100, 0, 0, 17219, 0, 'LK -  IiceWALL_3');
INSERT INTO creature_text VALUES (36954, 107, 0, 'How long can you fight it?', 14, 0, 100, 0, 0, 17220, 0, 'LK -  IiceWALL_4');
INSERT INTO creature_text VALUES (36954, 108, 0, 'Death\'s cold embrace awaits.', 14, 0, 100, 0, 0, 17221, 0, 'LK -  IiceWALL_1_summon');
INSERT INTO creature_text VALUES (36954, 115, 0, 'Nowhere to run... You\'re mine now!', 14, 0, 100, 0, 0, 17223, 0, 'LK -  KILING SILVANAS');
INSERT INTO creature_text VALUES (36955, 103, 0, 'He is too powerful. We must leave this place at once! My magic can hold him in place for only a short time. Come quickly heroes!', 14, 0, 100, 0, 0, 16606, 0, 'JAINA -  Leave the place');
INSERT INTO creature_text VALUES (36955, 119, 0, 'I will destroy this barrier. You must hold the undead back!', 14, 0, 100, 0, 0, 16607, 0, 'JAINA -  IceWALL_1');
INSERT INTO creature_text VALUES (36955, 120, 0, 'Another ice wall! Keep the undead from interrupting my incantations so that I may bring this wall down.', 14, 0, 100, 0, 0, 16608, 0, 'JAINA -  IceWALL_2');
INSERT INTO creature_text VALUES (36955, 121, 0, 'He\'s toying with us! I\'ll show him what happens to ice when it meets fire.', 14, 0, 100, 0, 0, 16609, 0, 'JAINA -  IceWALL_3');
INSERT INTO creature_text VALUES (36955, 122, 0, 'Your barriers can\'t hold us back much longer, monster! I will shatter them all! ', 14, 0, 100, 0, 0, 16610, 0, 'JAINA -  IceWALL_4');
INSERT INTO creature_text VALUES (36955, 123, 0, 'There\'s an opening up ahead. GO NOW!', 14, 0, 100, 0, 0, 16645, 0, 'JAINA -  IceWALL_4_broken_after');
INSERT INTO creature_text VALUES (36955, 124, 0, 'It... It\'s a dead end. We have no choice but to fight. Steal yourselves, heroes, for this is our last stand!', 14, 0, 100, 0, 0, 16647, 0, 'JAINA -  Sem Saida');
INSERT INTO creature_text VALUES (36955, 127, 0, 'Forgive me heroes, I should have listened to Uther. I ... I had to see for myself, to look into his eyes one last time ... I am sorry.', 14, 0, 100, 0, 0, 16648, 0, 'JAINA -  FINAL');
INSERT INTO creature_text VALUES (36955, 128, 0, 'We now know what must be done. I will deliver this news to King Varian and Highlord Fordring.', 14, 0, 100, 0, 0, 16649, 0, 'JAINA -  FINAL 2');
INSERT INTO creature_text VALUES (30344, 125, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16721, 0, 'Transport_ally -  FIRE!');
INSERT INTO creature_text VALUES (30344, 126, 0, 'Quickly, climb adoard! We mustn\'t tarry here! There\'s no telling when this whole mountainside will collapse.', 14, 0, 100, 0, 0, 16722, 0, 'Transport_ally -  ONBOARD');
INSERT INTO creature_text VALUES (37221, 1, 0, 'The chill of this place... Brr... I can feel my blood freezing.', 14, 0, 100, 0, 0, 16631, 0, 'Jaina SAY_JAINA_INTRO_1');
INSERT INTO creature_text VALUES (37221, 2, 0, 'What is that? Up ahead! Could it be... ? Heroes at my side!', 14, 0, 100, 0, 0, 16632, 0, 'Jaina SAY_JAINA_INTRO_2');
INSERT INTO creature_text VALUES (37221, 3, 0, 'Frostmourne! The blade that destroyed our kingdom...', 14, 0, 100, 0, 0, 16633, 0, 'Jaina SAY_JAINA_INTRO_3');
INSERT INTO creature_text VALUES (37221, 4, 0, 'Stand back! Touch that blade and your soul will be scarred for all eternity! I must attempt to commune with the spirits locked away within Frostmourne. Give me space, back up please!', 14, 0, 100, 0, 0, 16634, 0, 'Jaina SAY_JAINA_INTRO_4');
INSERT INTO creature_text VALUES (37221, 6, 0, 'Uther! Dear Uther! ... I... I\'m so sorry.', 12, 0, 100, 0, 0, 16635, 0, 'Jaina SAY_JAINA_INTRO_5');
INSERT INTO creature_text VALUES (37221, 8, 0, 'Arthas is here? Maybe I...', 12, 0, 100, 0, 0, 16636, 0, 'Jaina SAY_JAINA_INTRO_6');
INSERT INTO creature_text VALUES (37221, 10, 0, 'But Uther, if there\'s any hope of reaching Arthas. I... I must try.', 12, 0, 100, 0, 0, 16637, 0, 'Jaina SAY_JAINA_INTRO_7');
INSERT INTO creature_text VALUES (37221, 12, 0, 'Tell me how, Uther? How do I destroy my prince? My...', 12, 0, 100, 0, 0, 16638, 0, 'Jaina SAY_JAINA_INTRO_8');
INSERT INTO creature_text VALUES (37221, 14, 0, 'You\'re right, Uther. Forgive me. I... I don\'t know what got a hold of me. We will deliver this information to the King and the knights that battle the Scourge within Icecrown Citadel.', 12, 0, 100, 0, 0, 16639, 0, 'Jaina SAY_JAINA_INTRO_9');
INSERT INTO creature_text VALUES (37221, 17, 0, 'Who could bear such a burden?', 12, 0, 100, 0, 0, 16640, 0, 'Jaina SAY_JAINA_INTRO_10');
INSERT INTO creature_text VALUES (37221, 19, 0, 'Then maybe there is still hope...', 12, 0, 100, 0, 0, 16641, 0, 'Jaina SAY_JAINA_INTRO_11');
INSERT INTO creature_text VALUES (37221, 42, 0, 'You won\'t deny me this Arthas! I must know! I must find out!', 14, 0, 100, 0, 0, 16642, 0, 'Jaina SAY_JAINA_INTRO_END');
INSERT INTO creature_text VALUES (37223, 21, 0, 'I... I don\'t believe it! Frostmourne stands before us, unguarded! Just as the Gnome claimed. Come, heroes!', 14, 0, 100, 0, 0, 17049, 0, 'Sylvanas SAY_SYLVANAS_INTRO_1');
INSERT INTO creature_text VALUES (37223, 22, 0, 'Standing this close to the blade that ended my life... The pain... It is renewed.', 14, 0, 100, 0, 0, 17050, 0, 'Sylvanas SAY_SYLVANAS_INTRO_2');
INSERT INTO creature_text VALUES (37223, 23, 0, 'I dare not touch it. Stand back! Stand back as I attempt to commune with the blade! Perhaps our salvation lies within...', 14, 0, 100, 0, 0, 17051, 0, 'Sylvanas SAY_SYLVANAS_INTRO_3');
INSERT INTO creature_text VALUES (37223, 25, 0, 'Uther...Uther the Lightbringer. How...', 12, 0, 100, 0, 0, 17052, 0, 'Sylvanas SAY_SYLVANAS_INTRO_4');
INSERT INTO creature_text VALUES (37223, 27, 0, 'The Lich King is here? Then my destiny shall be fulfilled today!', 12, 0, 100, 0, 0, 17053, 0, 'Sylvanas SAY_SYLVANAS_INTRO_5');
INSERT INTO creature_text VALUES (37223, 29, 0, 'There must be a way... ', 12, 0, 100, 0, 0, 17054, 0, 'Sylvanas SAY_SYLVANAS_INTRO_6');
INSERT INTO creature_text VALUES (37223, 31, 0, 'Who could bear such a burden?', 12, 0, 100, 0, 0, 17055, 0, 'Sylvanas SAY_SYLVANAS_INTRO_7');
INSERT INTO creature_text VALUES (37223, 34, 0, 'The Frozen Throne...', 12, 0, 100, 0, 0, 17056, 0, 'Sylvanas SAY_SYLVANAS_INTRO_8');
INSERT INTO creature_text VALUES (37223, 43, 0, 'You will not escape me that easily, Arthas! I will have my vengeance!', 14, 0, 100, 0, 0, 17057, 0, 'Sylvanas SAY_SYLVANAS_INTRO_END');
INSERT INTO creature_text VALUES (37225, 5, 0, 'Jaina! Could it truly be you?', 14, 0, 100, 0, 0, 16666, 0, 'Uther SAY_UTHER_INTRO_A2_1');
INSERT INTO creature_text VALUES (37225, 7, 0, 'Jaina you haven\'t much time. The Lich King sees what the sword sees. He will be here shortly!', 12, 0, 100, 0, 0, 16667, 0, 'Uther SAY_UTHER_INTRO_A2_2');
INSERT INTO creature_text VALUES (37225, 9, 0, 'No, girl. Arthas is not here. Arthas is merely a presence within the Lich King\'s mind. A dwindling presence...', 12, 0, 100, 0, 0, 16668, 0, 'Uther SAY_UTHER_INTRO_A2_3');
INSERT INTO creature_text VALUES (37225, 11, 0, 'Jaina, listen to me. You must destroy the Lich King. You cannot reason with him. He will kill you and your allies and raise you all as powerful soldiers of the Scourge.', 12, 0, 100, 0, 0, 16669, 0, 'Uther SAY_UTHER_INTRO_A2_4');
INSERT INTO creature_text VALUES (37225, 13, 0, 'Snap out of it, girl. You must destroy the Lich King at the place where he merged with Ner\'zhul - atop the spire, at the Frozen Throne. It is the only way.', 12, 0, 100, 0, 0, 16670, 0, 'Uther SAY_UTHER_INTRO_A2_5');
INSERT INTO creature_text VALUES (37225, 15, 0, 'There is... something else that you should know about the Lich King. Control over the Scourge must never be lost. Even if you were to strike down the Lich King, another would have to take his place. For without the control of its master, the Scourge would run rampant across the world - destroying all living things.', 12, 0, 100, 0, 0, 16671, 0, 'Uther SAY_UTHER_INTRO_A2_6');
INSERT INTO creature_text VALUES (37225, 16, 0, 'A grand sacrifice by a noble soul...', 12, 0, 100, 0, 0, 16672, 0, 'Uther SAY_UTHER_INTRO_A2_7');
INSERT INTO creature_text VALUES (37225, 18, 0, 'I do not know, Jaina. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 12, 0, 100, 0, 0, 16673, 0, 'Uther SAY_UTHER_INTRO_A2_8');
INSERT INTO creature_text VALUES (37225, 20, 0, 'No, Jaina! Aargh! He... He is coming! You... You must...', 12, 0, 100, 0, 0, 16674, 0, 'Uther SAY_UTHER_INTRO_A2_9');
INSERT INTO creature_text VALUES (37225, 24, 0, 'Careful, girl. I\'ve heard talk of that cursed blade saving us before. Look around you and see what has been born of Frostmourne.', 12, 0, 100, 0, 0, 16659, 0, 'Uther SAY_UTHER_INTRO_H2_1');
INSERT INTO creature_text VALUES (37225, 26, 0, 'You haven\'t much time. The Lich King sees what the sword sees. He will be here shortly.', 12, 0, 100, 0, 0, 16660, 0, 'Uther SAY_UTHER_INTRO_H2_2');
INSERT INTO creature_text VALUES (37225, 28, 0, 'You cannot defeat the Lich King. Not here. You would be a fool to try. He will kill those who follow you and raise them as powerful servants of the Scourge. But for you, Sylvanas, his reward for you would be worse than the last.', 12, 0, 100, 0, 0, 16661, 0, 'Uther SAY_UTHER_INTRO_H2_3');
INSERT INTO creature_text VALUES (37225, 30, 0, 'Perhaps, but know this: there must always be a Lich King. Even if you were to strike down Arthas, another would have to take his place, for without the control of the Lich King, the Scourge would wash over this world like locusts, destroying all that they touched.', 12, 0, 100, 0, 0, 16662, 0, 'Uther SAY_UTHER_INTRO_H2_4');
INSERT INTO creature_text VALUES (37225, 32, 0, 'I do not know, Banshee Queen. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 12, 0, 100, 0, 0, 16663, 0, 'Uther SAY_UTHER_INTRO_H2_5');
INSERT INTO creature_text VALUES (37225, 33, 0, 'Alas, the only way to defeat the Lich King is to destroy him at the place he was created.', 12, 0, 100, 0, 0, 16664, 0, 'Uther SAY_UTHER_INTRO_H2_6');
INSERT INTO creature_text VALUES (37225, 35, 0, 'I... Aargh... He... He is coming... You... You must...', 12, 0, 100, 0, 0, 16665, 0, 'Uther SAY_UTHER_INTRO_H2_7');
INSERT INTO creature_text VALUES (37226, 36, 0, 'SILENCE, PALADIN!', 14, 0, 100, 0, 0, 17225, 0, 'Lich King SAY_LK_INTRO_1');
INSERT INTO creature_text VALUES (37226, 37, 0, 'So you wish to commune with the dead? You shall have your wish.', 14, 0, 100, 0, 0, 17226, 0, 'Lich King SAY_LK_INTRO_2');
INSERT INTO creature_text VALUES (37226, 38, 0, 'Falric. Marwyn. Bring their corpses to my chamber when you are through.', 14, 0, 100, 0, 0, 17227, 0, 'Lich King SAY_LK_INTRO_3');
INSERT INTO creature_text VALUES (37554, 102, 0, 'He\'s... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do that. I can hold him in place while we flee.', 14, 0, 100, 0, 0, 17058, 0, 'SYLVANAS -  Leave the place');
INSERT INTO creature_text VALUES (37554, 109, 0, 'No wall can hold the Banshee Queen. Keep the undead at bay, heroes. I will tear this barrier down!', 14, 0, 100, 0, 0, 17029, 0, 'SYLVANAS -  IceWALL_1');
INSERT INTO creature_text VALUES (37554, 110, 0, 'Another barrier? Stand strong champions. I will bring the wall down.', 14, 0, 100, 0, 0, 17030, 0, 'SYLVANAS -  IceWALL_2');
INSERT INTO creature_text VALUES (37554, 111, 0, 'I grow tired of these games, Arthas! Your wall can\'t stop me!', 14, 0, 100, 0, 0, 17031, 0, 'SYLVANAS -  IceWALL_3');
INSERT INTO creature_text VALUES (37554, 112, 0, 'You wan\'t impede our escape. Fend! Keep the undead of me while I bring this barrier down.', 14, 0, 100, 0, 0, 17032, 0, 'SYLVANAS -  IceWALL_4');
INSERT INTO creature_text VALUES (37554, 113, 0, 'There\'s an opening up ahead. GO NOW!', 14, 0, 100, 0, 0, 17059, 0, 'SYLVANAS -  IceWALL_4_broken_after');
INSERT INTO creature_text VALUES (37554, 114, 0, 'BLASTED DEAD END! So this is how it ends. Propare yourselves, heroes, for today we make our final stand!', 14, 0, 100, 0, 0, 17061, 0, 'SYLVANAS -  Sem Saida');
INSERT INTO creature_text VALUES (37554, 118, 0, 'We are safe... for now. His strength has increased ten-fold since our last battle. It will take a mighty army to destroy the Lich King. An army greater then even the Horde can route.', 14, 0, 100, 0, 0, 17062, 0, 'SYLVANAS -  FINAL');
INSERT INTO creature_text VALUES (30824, 116, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16732, 0, 'Transport_horda -  FIRE!');
INSERT INTO creature_text VALUES (30824, 117, 0, 'Get on board, now! This whole mountainside could collapse at any moment.', 14, 0, 100, 0, 0, 16733, 0, 'Transport_horda -  ONBOARD');
INSERT INTO creature_text VALUES (38112, 39, 0, 'As you wish, my lord.', 14, 0, 100, 0, 0, 16717, 0, 'Falric SAY_FALRIC_INTRO_1');
INSERT INTO creature_text VALUES (38112, 41, 0, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 14, 0, 100, 0, 0, 16714, 0, 'Falric SAY_FALRIC_INTRO_2');
INSERT INTO creature_text VALUES (38112, 50, 0, 'Men, women and children... None were spared the master\'s wrath. Your death will be no different.', 14, 0, 100, 0, 0, 16710, 0, 'Falric SAY_AGGRO');
INSERT INTO creature_text VALUES (38112, 51, 0, 'Sniveling maggot!', 14, 0, 100, 0, 0, 16711, 0, 'Falric SAY_SLAY_1');
INSERT INTO creature_text VALUES (38112, 52, 0, 'The children of Stratholme fought with more ferocity!', 14, 0, 100, 0, 0, 16712, 0, 'Falric SAY_SLAY_2');
INSERT INTO creature_text VALUES (38112, 53, 0, 'Marwyn, finish them...', 14, 0, 100, 0, 0, 16713, 0, 'Falric SAY_DEATH');
INSERT INTO creature_text VALUES (38112, 54, 0, 'Despair... so delicious...', 14, 0, 100, 0, 0, 16715, 0, 'Falric SAY_IMPENDING_DESPAIR');
INSERT INTO creature_text VALUES (38112, 55, 0, 'Fear... so exhilarating...', 14, 0, 100, 0, 0, 16716, 0, 'Falric SAY_DEFILING_HORROR');
INSERT INTO creature_text VALUES (38113, 40, 0, 'As you wish, my lord.', 14, 0, 100, 0, 0, 16741, 0, 'Marwyn SAY_MARWYN_INTRO_1');
INSERT INTO creature_text VALUES (38113, 60, 0, 'Death is all that you will find here!', 14, 0, 100, 0, 0, 16734, 0, 'Marwyn SAY_AGGRO');
INSERT INTO creature_text VALUES (38113, 61, 0, 'I saw the same look in his eyes when he died. Terenas could hardly believe it. Hahahaha!', 14, 0, 100, 0, 0, 16735, 0, 'Marwyn SAY_SLAY_1');
INSERT INTO creature_text VALUES (38113, 62, 0, 'Choke on your suffering!', 14, 0, 100, 0, 0, 16736, 0, 'Marwyn SAY_SLAY_2');
INSERT INTO creature_text VALUES (38113, 63, 0, 'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.', 14, 0, 100, 0, 0, 16737, 0, 'Marwyn SAY_DEATH');
INSERT INTO creature_text VALUES (38113, 64, 0, 'Your flesh has decayed before your very eyes!', 14, 0, 100, 0, 0, 16739, 0, 'Marwyn SAY_CORRUPTED_FLESH_1');
INSERT INTO creature_text VALUES (38113, 65, 0, 'Waste away into nothingness!', 14, 0, 100, 0, 0, 16740, 0, 'Marwyn SAY_CORRUPTED_FLESH_2');
INSERT INTO creature_text VALUES (37225, 200, 0, 'Halt! Do not carry that blade any further!', 14, 0, 100, 5, 0, 16675, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 201, 0, 'Quel\'Delar leaps to life in the presence of Frostmourne!', 41, 0, 100, 0, 0, 0, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 202, 0, 'Do you realise what you have done?', 14, 0, 100, 5, 0, 16676, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 203, 0, 'Quel\'Delar prepares to attack!', 41, 0, 100, 0, 0, 0, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 204, 0, 'You have forged this blade from saronite, the very blood of an old god! The power of the Lich King calls to this weapon!', 12, 0, 100, 1, 0, 16677, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 205, 0, 'Each moment you tarry here Quel\'Delar drinks in the evil of this place!', 12, 0, 100, 1, 0, 16678, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 206, 0, 'There is only one way to cleanse this sword, make haste for the sunwell, and emerse the blade in its waters!', 12, 0, 100, 1, 0, 16679, 0, 'Uther Quel\'Delar');
INSERT INTO creature_text VALUES (37225, 207, 0, 'I can resist Frostmourne\'s call no more.', 12, 0, 100, 1, 0, 16680, 0, 'Uther Quel\'Delar');

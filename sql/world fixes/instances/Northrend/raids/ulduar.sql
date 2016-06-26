DELETE FROM disables WHERE sourceType=2 AND entry IN(603);
-- INSERT INTO disables VALUES(2, 603, 3, '', '', '');

-- TODO: BRANN scene after archivum data disc quest (http://old.wowhead.com/quest=13604#comments:id=738265)
-- TODO: http://www.youtube.com/watch?v=ZmJHcJVUlkY



-- ###################
-- ### GAMEOBJECTS
-- ###################

-- fix spawnMask of herbs, etc.
UPDATE gameobject SET spawnMask=3, spawntimesecs=2700 WHERE map=603 AND id IN(191019,190176,190171,190170,189973);

-- Pure Saronite Deposit (195036)
DELETE FROM gameobject WHERE id IN(195036) AND map=603;
INSERT INTO gameobject VALUES(NULL,195036,603,3,1,1886.94,55.3576,342.37,0,0,0,0,1,24*3600,255,1, 0);
UPDATE gameobject_template SET ScriptName='go_ulduar_pure_saronite_deposit', AIName='' WHERE entry=195036;

-- Mimiron Tram
UPDATE gameobject_template SET flags=32, data2=3000, ScriptName='go_call_tram' WHERE entry IN (194914, 194912, 194437, 194438); 
DELETE FROM gameobject WHERE id IN(194437, 194438); 
INSERT INTO gameobject VALUES (NULL, 194437, 603, 3, 1, 2306.87, 274.237, 424.288, 1.52255, 0, 0, 0.689847, 0.723956, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 194438, 603, 3, 1, 2306.99, 2589.35, 424.382, 4.71676, 0, 0, 0.705559, -0.708651, 300, 0, 1, 0); 
REPLACE INTO gameobject_template VALUES (194438, 1, 8504, 'Activate Tram', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_call_tram', 11159); 
REPLACE INTO gameobject_template VALUES (194437, 1, 8504, 'Activate Tram', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_call_tram', 12340);

-- Portal to Dalaran
UPDATE gameobject SET id=195682 WHERE id=194481 AND map=603;

-- ###################
-- ### GENERAL NPCS (MAINLY TRASH)
-- ###################

-- XB-488 Disposalbot (34273, 34274)
UPDATE creature_template SET mindmg=1701, maxdmg=2319, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34273;
UPDATE creature_template SET mindmg=1342, maxdmg=1829, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34274;
DELETE FROM smart_scripts WHERE entryorguid IN(34273, 34274) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34273, 0, 0, 0, 0, 0, 100, 2, 5000, 10000, 8000, 12000, 11, 65080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cut Scrap Metal 10');
INSERT INTO `smart_scripts` VALUES (34273, 0, 1, 0, 0, 0, 100, 4, 5000, 10000, 8000, 12000, 11, 65104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cut Scrap Metal 25');
INSERT INTO `smart_scripts` VALUES (34273, 0, 2, 0, 2, 0, 100, 1, 0, 25, 0, 0, 11, 65084, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Self Destruct');

-- XD-175 Compactobot (34271, 34272)
UPDATE creature_template SET mindmg=2039, maxdmg=2780, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34271;
UPDATE creature_template SET mindmg=1645, maxdmg=2242, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34272;
DELETE FROM smart_scripts WHERE entryorguid IN(34271, 34272) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34271, 0, 0, 0, 0, 0, 100, 2, 500, 500, 10000, 20000, 11, 65073, 0, 0, 0, 0, 0, 17, 12, 38, 1, 0, 0, 0, 0, 'Trash Compactor 10');
INSERT INTO `smart_scripts` VALUES (34271, 0, 1, 0, 0, 0, 100, 4, 500, 500, 10000, 20000, 11, 65106, 0, 0, 0, 0, 0, 17, 12, 38, 1, 0, 0, 0, 0, 'Trash Compactor 25');

-- XR-949 Salvagebot (34269, 34270)
UPDATE creature_template SET mindmg=1701, maxdmg=2319, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34269;
UPDATE creature_template SET mindmg=1342, maxdmg=1829, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34270;
DELETE FROM smart_scripts WHERE entryorguid IN(34269, 34270) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34269, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 20000, 11, 65099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deploy Salvage Saws');

-- Salvagebot Sawblade (34288, 34291)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='', RegenHealth=0 WHERE entry=34288;
UPDATE creature_template SET AIName='', ScriptName='', RegenHealth=0 WHERE entry=34291;
DELETE FROM smart_scripts WHERE entryorguid IN(34288, 34291) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(34288, 0, 0, 0, 1, 0, '65090 65087');
REPLACE INTO creature_template_addon VALUES(34291, 0, 0, 0, 1, 0, '65103 65087');

-- Parts Recovery Technician (34267, 34268)
UPDATE creature_template SET mindmg=1701, maxdmg=2319, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34267;
UPDATE creature_template SET mindmg=1342, maxdmg=1829, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34268;
DELETE FROM smart_scripts WHERE entryorguid IN(34267, 34268) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34267, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 8000, 12000, 11, 65071, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechano Kick');
INSERT INTO `smart_scripts` VALUES (34267, 0, 1, 0, 14, 0, 100, 0, 50000, 29, 15000, 15000, 11, 65070, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Defense Matrix');

-- Runeforged Sentry (34234, 34235)
UPDATE creature_template SET mindmg=2745, maxdmg=3743, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34234;
UPDATE creature_template SET mindmg=2220, maxdmg=3026, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34235;
DELETE FROM smart_scripts WHERE entryorguid IN(34234, 34235) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34234, 0, 0, 0, 0, 0, 100, 2, 10000, 15000, 15000, 25000, 11, 64847, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Runed Flame Jets 10');
INSERT INTO `smart_scripts` VALUES (34234, 0, 1, 0, 0, 0, 100, 4, 10000, 15000, 15000, 25000, 11, 64988, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Runed Flame Jets 25');
INSERT INTO `smart_scripts` VALUES (34234, 0, 2, 0, 0, 0, 100, 2, 5000, 10000, 5000, 10000, 11, 64870, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lava Burst 10');
INSERT INTO `smart_scripts` VALUES (34234, 0, 3, 0, 0, 0, 100, 4, 5000, 10000, 5000, 10000, 11, 64991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lava Burst 25');
INSERT INTO `smart_scripts` VALUES (34234, 0, 4, 0, 0, 0, 100, 2, 5000, 10000, 5000, 10000, 11, 64852, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Flaming Rune 10');
INSERT INTO `smart_scripts` VALUES (34234, 0, 5, 0, 0, 0, 100, 4, 5000, 10000, 5000, 10000, 11, 64990, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Flaming Rune 25');

-- Lightning Charged Iron Dwarf (34199, 34237)
UPDATE creature_template SET mindmg=2914, maxdmg=3973, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34199;
UPDATE creature_template SET mindmg=2354, maxdmg=3209, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34237;
DELETE FROM smart_scripts WHERE entryorguid IN(34199, 34237) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34199, 0, 0, 0, 0, 0, 100, 2, 1000, 1000, 15000, 15000, 11, 64889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lightning Charged 10');
INSERT INTO `smart_scripts` VALUES (34199, 0, 1, 0, 0, 0, 100, 4, 1000, 1000, 15000, 15000, 11, 64975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lightning Charged 25');

-- Iron Mender (34198, 34236)
UPDATE creature_template SET mindmg=2914, maxdmg=3973, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34198;
UPDATE creature_template SET mindmg=2354, maxdmg=3209, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34236;
DELETE FROM smart_scripts WHERE entryorguid IN(34198, 34236) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34198, 0, 0, 0, 0, 0, 100, 2, 5000, 10000, 10000, 20000, 11, 64918, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Electro Shock 10');
INSERT INTO `smart_scripts` VALUES (34198, 0, 1, 0, 0, 0, 100, 4, 5000, 10000, 10000, 20000, 11, 64971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Electro Shock 25');
INSERT INTO `smart_scripts` VALUES (34198, 0, 2, 0, 0, 0, 100, 2, 8000, 12000, 10000, 15000, 11, 64903, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Fuse Lightning 10');
INSERT INTO `smart_scripts` VALUES (34198, 0, 3, 0, 0, 0, 100, 4, 8000, 12000, 10000, 15000, 11, 64970, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Fuse Lightning 25');
INSERT INTO `smart_scripts` VALUES (34198, 0, 4, 0, 14, 0, 100, 2, 100000, 19, 15000, 20000, 11, 64897, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fuse Metal 10');
INSERT INTO `smart_scripts` VALUES (34198, 0, 5, 0, 14, 0, 100, 4, 200000, 19, 15000, 20000, 11, 64968, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fuse Metal 25');

-- Chamber Overseer (34197, 34226)
UPDATE creature_template SET mindmg=4380, maxdmg=5972, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34197;
UPDATE creature_template SET mindmg=3535, maxdmg=4820, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34226;
DELETE FROM smart_scripts WHERE entryorguid IN(34197, 34226) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34197, 0, 0, 0, 0, 0, 100, 2, 500, 500, 15000, 15000, 11, 64820, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devastating Leap 10');
INSERT INTO `smart_scripts` VALUES (34197, 0, 1, 0, 0, 0, 100, 4, 500, 500, 15000, 15000, 11, 64943, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devastating Leap 25');
INSERT INTO `smart_scripts` VALUES (34197, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 12000, 18000, 11, 64783, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Displacement Device');
INSERT INTO `smart_scripts` VALUES (34197, 0, 3, 0, 0, 0, 100, 2, 10000, 20000, 10000, 20000, 11, 64825, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Staggering Roar 10');
INSERT INTO `smart_scripts` VALUES (34197, 0, 4, 0, 0, 0, 100, 4, 10000, 20000, 10000, 20000, 11, 64944, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Staggering Roar 25');

-- Displacement Device (34203, 34227)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='', HoverHeight=5 WHERE entry=34203;
UPDATE creature_template SET AIName='', ScriptName='', HoverHeight=5 WHERE entry=34227;
DELETE FROM smart_scripts WHERE entryorguid IN(34203, 34227) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(34203, 0, 0, 50331648, 1, 0, '64793');
REPLACE INTO creature_template_addon VALUES(34227, 0, 0, 50331648, 1, 0, '64941');

-- Rune Etched Sentry (34196, 34245)
UPDATE creature_template SET mindmg=3803, maxdmg=5184, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34196;
UPDATE creature_template SET mindmg=3071, maxdmg=4187, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34245;
DELETE FROM smart_scripts WHERE entryorguid IN(34196, 34245) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34196, 0, 0, 0, 0, 0, 100, 2, 10000, 15000, 15000, 25000, 11, 64847, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Runed Flame Jets 10');
INSERT INTO `smart_scripts` VALUES (34196, 0, 1, 0, 0, 0, 100, 4, 10000, 15000, 15000, 25000, 11, 64988, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Runed Flame Jets 25');
INSERT INTO `smart_scripts` VALUES (34196, 0, 2, 0, 0, 0, 100, 2, 5000, 10000, 5000, 10000, 11, 64870, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lava Burst 10');
INSERT INTO `smart_scripts` VALUES (34196, 0, 3, 0, 0, 0, 100, 4, 5000, 10000, 5000, 10000, 11, 64991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lava Burst 25');
INSERT INTO `smart_scripts` VALUES (34196, 0, 4, 0, 0, 0, 100, 2, 5000, 10000, 5000, 10000, 11, 64852, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Flaming Rune 10');
INSERT INTO `smart_scripts` VALUES (34196, 0, 5, 0, 0, 0, 100, 4, 5000, 10000, 5000, 10000, 11, 64990, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Flaming Rune 25');

-- Clockwork Sapper (34193, 34220)
UPDATE creature_template SET mindmg=1701, maxdmg=2319, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34193;
UPDATE creature_template SET mindmg=1373, maxdmg=1873, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34220;
DELETE FROM smart_scripts WHERE entryorguid IN(34193, 34220) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34193, 0, 0, 0, 33, 0, 100, 2, 0, 1000000, 8000, 8000, 11, 64740, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Energy Sap 10');
INSERT INTO `smart_scripts` VALUES (34193, 0, 1, 0, 33, 0, 100, 4, 0, 1000000, 8000, 8000, 11, 64876, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Energy Sap 25');

-- Boomer XP-500 (34192, 34216)
UPDATE creature_template SET mindmg=1, maxdmg=1, attackpower=1, dmg_multiplier=1, AIName='SmartAI', ScriptName='' WHERE entry=34192;
UPDATE creature_template SET mindmg=1, maxdmg=1, attackpower=1, dmg_multiplier=1, AIName='', ScriptName='' WHERE entry=34216;
DELETE FROM smart_scripts WHERE entryorguid IN(34192, 34216) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(34192, 34216);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34192, 34216) AND `map`=603 );
INSERT INTO `smart_scripts` VALUES (34192, 0, 0, 1, 33, 0, 100, 1, 0, 1000000, 0, 0, 11, 63801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot');
INSERT INTO `smart_scripts` VALUES (34192, 0, 1, 0, 61, 0, 100, 0, 0, 1000000, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - linked death');

DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34192, 34216) AND `map`=603 AND SQRT( POW(position_x-2744.0, 2) + POW(position_y-2569.0, 2) ) < 150.0 );
DELETE FROM creature WHERE id IN(34192, 34216) AND `map`=603 AND SQRT( POW(position_x-2744.0, 2) + POW(position_y-2569.0, 2) ) < 150.0;
SET @pathid = 3419200;
SET @addval = 0;
DELETE FROM waypoint_data WHERE id >= @pathid AND id <= @pathid+19;
INSERT INTO `waypoint_data` VALUES (@pathid, 1, 2629.64, 2616.51, 372.361, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 2, 2654.94, 2654.57, 372.361, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 3, 2695.35, 2681.16, 372.204, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 4, 2741.47, 2690.39, 372.23, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 5, 2787.98, 2680.79, 372.133, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 6, 2826.61, 2654.66, 372.016, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 7, 2821.69, 2649.68, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 8, 2785.94, 2673.87, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 9, 2740.61, 2683.08, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 10, 2699.38, 2674.72, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 11, 2661.15, 2649.92, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 12, 2635.76, 2612.39, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 13, 2628.57, 2569.26, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 14, 2636.18, 2525.54, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 15, 2660.93, 2488.81, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 16, 2697.08, 2464.68, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 17, 2740.74, 2455.44, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 18, 2783.89, 2463.77, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 19, 2821.8, 2488.53, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 20, 2816.81, 2493.43, 372.293, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 21, 2782.55, 2470.39, 372.234, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 22, 2740.45, 2460.89, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 23, 2699.58, 2470.49, 372.176, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 24, 2665.73, 2493.91, 372.361, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 25, 2641.88, 2528.08, 372.083, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 26, 2635.42, 2569.58, 372.119, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 27, 2641.33, 2610.13, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 28, 2665.17, 2645.48, 372.052, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 29, 2699.96, 2668.64, 372.079, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 30, 2741.21, 2676.91, 372.082, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 31, 2782.39, 2668.78, 372.062, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 32, 2817.05, 2645.46, 372.131, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 33, 2824.61, 2651.82, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 34, 2786.6, 2676.5, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 35, 2741.81, 2685.92, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 36, 2695.92, 2677.58, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 37, 2659.35, 2652.44, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 38, 2633.26, 2613.82, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 39, 2624.58, 2569.48, 371.979, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@pathid, 40, 2620.08, 2568.92, 372.361, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO waypoint_data SELECT id+1, IF(point <= 2, point+40-2, point-2), position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid FROM waypoint_data WHERE id=@pathid+@addval; SET @addval := @addval+1;
INSERT INTO creature SELECT NULL, 34192, 603, 3, 1, 0, 0, position_x, position_y, position_z, orientation, 900, 0, 0, 1, 0, 2, 0, 0, 0 FROM waypoint_data WHERE id >= 3419200 AND id <= 3419219 AND point=40 ORDER BY point ASC;
SET @pathid := @pathid-1;
INSERT INTO creature_addon SELECT guid, (@pathid := @pathid+1), 0, 0, 1, 0, '' FROM creature WHERE id IN(34192, 34216) AND `map`=603 AND SQRT( POW(position_x-2744.0, 2) + POW(position_y-2569.0, 2) ) < 150.0 ORDER BY guid ASC;

-- Trash (34191, 34217)
UPDATE creature_template SET mindmg=792, maxdmg=1080, attackpower=642, dmg_multiplier=7, AIName='', ScriptName='' WHERE entry=34191;
UPDATE creature_template SET mindmg=609, maxdmg=830, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34217;
DELETE FROM smart_scripts WHERE entryorguid IN(34191, 34217) AND source_type=0;

-- Hardened Iron Golem (34190, 34229)
UPDATE creature_template SET mindmg=2719, maxdmg=3707, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34190;
UPDATE creature_template SET mindmg=2196, maxdmg=2994, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34229;
DELETE FROM smart_scripts WHERE entryorguid IN(34190, 34229) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34190, 0, 0, 0, 0, 0, 100, 2, 3000, 5000, 5000, 5000, 11, 64874, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rune Punch 10');
INSERT INTO `smart_scripts` VALUES (34190, 0, 1, 0, 0, 0, 100, 4, 3000, 5000, 5000, 5000, 11, 64967, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rune Punch 25');
INSERT INTO `smart_scripts` VALUES (34190, 0, 2, 0, 33, 0, 100, 0, 0, 1000000, 20000, 20000, 11, 64877, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Harden Fists');

-- Clockwork Mechanic (34184, 34219)
UPDATE creature_template SET mindmg=792, maxdmg=1080, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='', unit_flags=64 WHERE entry=34184;
UPDATE creature_template SET mindmg=600, maxdmg=900, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='', unit_flags=64 WHERE entry=34219;
DELETE FROM smart_scripts WHERE entryorguid IN(34184, 34219) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34184, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 60000, 60000, 11, 64966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ice Turret');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34184, 34219) AND `map`=603 );
DELETE FROM creature WHERE id IN(34184, 34219) AND `map`=603;

-- Ice Turret (34224)
UPDATE creature_template SET difficulty_entry_1=0, AIName='NullCreatureAI', ScriptName='', RegenHealth=0 WHERE entry=34224;
DELETE FROM smart_scripts WHERE entryorguid IN(34224) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(34224, 0, 0, 0, 1, 0, '64920');

-- Arachnopod Destroyer (34183, 34214)
UPDATE creature_template SET npcflag=0, unit_flags=64, mindmg=2262, maxdmg=3084, attackpower=642, dmg_multiplier=2, VehicleId=399, `type`=10, spell1=64717, spell2=64776, spell3=64779, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, RegenHealth=1, AIName='', ScriptName='npc_ulduar_arachnopod_destroyer' WHERE entry=34183;
UPDATE creature_template SET npcflag=0, unit_flags=64, mindmg=1827, maxdmg=2491, attackpower=642, dmg_multiplier=4, VehicleId=399, `type`=10, spell1=65241, spell2=65240, spell3=64779, spell4=0, spell5=0, spell6=0, spell7=0, spell8=0, RegenHealth=1, AIName='', ScriptName='' WHERE entry=34214;
UPDATE creature SET npcflag=0, unit_flags=0, dynamicflags=0 WHERE id IN(34183, 34214);
DELETE FROM smart_scripts WHERE entryorguid IN(34183, 34214) AND source_type=0;
DELETE FROM creature_addon WHERE guid IN(137561, 137562, 137563);
DELETE FROM creature WHERE guid IN(137561, 137562, 137563);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(34183, 34214);
INSERT INTO npc_spellclick_spells VALUES(34183, 46598, 1, 0),(34214, 46598, 1, 0);
REPLACE INTO spell_script_names VALUES(64770, 'spell_ulduar_arachnopod_damaged');

-- Mechagnome Battletank (34164, 34165)
UPDATE creature_template SET mindmg=2832, maxdmg=3858, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34164;
UPDATE creature_template SET mindmg=2256, maxdmg=3073, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34165;
DELETE FROM smart_scripts WHERE entryorguid IN(34164, 34165) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34164, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 15000, 25000, 11, 64692, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Flame Cannon');
INSERT INTO `smart_scripts` VALUES (34164, 0, 1, 0, 0, 0, 100, 0, 500, 500, 15000, 25000, 11, 64953, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jump Attack');

-- Snow Mound (8) (34151), Snow Mound (6) (34150), Snow Mound (4) (34146)
UPDATE creature_template SET AIName='', ScriptName='npc_ulduar_snow_mound' WHERE entry IN(34151, 34150, 34146);
DELETE FROM smart_scripts WHERE entryorguid IN(34151, 34150, 34146) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(34151, 34150, 34146);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34151, 34150, 34146) AND `map`=603 );

-- Expedition Engineer (34145) - just a friendly npc right before flame leviathan

-- Mercenary (34144) - just a friendly npc right before flame leviathan

-- Winter Jormungar (34137, 34140)
UPDATE creature_template SET mindmg=814, maxdmg=1110, attackpower=642, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34137;
UPDATE creature_template SET mindmg=623, maxdmg=849, attackpower=642, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34140;
DELETE FROM smart_scripts WHERE entryorguid IN(34137, 34140) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34137, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 11, 64638, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Acidic Bite');
-- delete spawns, spawned by snow mound
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34137, 34140) AND `map`=603 );
DELETE FROM creature WHERE id IN(34137, 34140) AND `map`=603;

-- Winter Rumbler (34135, 34142)
UPDATE creature_template SET mindmg=2148, maxdmg=2935, attackpower=670, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34135;
UPDATE creature_template SET mindmg=1842, maxdmg=2517, attackpower=670, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34142;
DELETE FROM smart_scripts WHERE entryorguid IN(34135, 34142) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34135, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 8000, 10000, 11, 64645, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cone of Cold 10');
INSERT INTO `smart_scripts` VALUES (34135, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 8000, 10000, 11, 64655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cone of Cold 25');
INSERT INTO `smart_scripts` VALUES (34135, 0, 2, 0, 0, 0, 100, 2, 3000, 8000, 10000, 15000, 11, 64647, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Snow Blindness 10');
INSERT INTO `smart_scripts` VALUES (34135, 0, 3, 0, 0, 0, 100, 4, 3000, 8000, 10000, 15000, 11, 64654, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Snow Blindness 25');

-- Winter Revenant (34134, 34141)
UPDATE creature_template SET mindmg=2737, maxdmg=3739, attackpower=670, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34134;
UPDATE creature_template SET mindmg=2035, maxdmg=2780, attackpower=670, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34141;
DELETE FROM smart_scripts WHERE entryorguid IN(34134, 34141) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34134, 0, 0, 0, 0, 0, 100, 2, 4000, 6000, 10000, 15000, 11, 64642, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blizzard 10');
INSERT INTO `smart_scripts` VALUES (34134, 0, 1, 0, 0, 0, 100, 4, 4000, 6000, 10000, 15000, 11, 64653, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blizzard 25');
INSERT INTO `smart_scripts` VALUES (34134, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 11, 64643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Whirling Strike');
REPLACE INTO creature_template_addon VALUES(34134, 0, 0, 0, 1, 0, '64644'),(34141, 0, 0, 0, 1, 0, '64644');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34134, 34141) AND `map`=603 );

-- Champion of Hodir (34133, 34139)
UPDATE creature_template SET mindmg=4949, maxdmg=6747, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34133;
UPDATE creature_template SET mindmg=4086, maxdmg=5570, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34139;
DELETE FROM smart_scripts WHERE entryorguid IN(34133, 34139) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34133, 0, 0, 0, 0, 0, 100, 2, 6000, 10000, 15000, 20000, 11, 64639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stomp 10');
INSERT INTO `smart_scripts` VALUES (34133, 0, 1, 0, 0, 0, 100, 4, 6000, 10000, 15000, 20000, 11, 64652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stomp 25');
INSERT INTO `smart_scripts` VALUES (34133, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 15000, 25000, 11, 64649, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Freezing Breath');
 
-- Magma Rager (34086, 34201)
UPDATE creature_template SET mindmg=2947, maxdmg=4023, attackpower=726, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34086;
UPDATE creature_template SET mindmg=2378, maxdmg=3247, attackpower=726, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34201;
DELETE FROM smart_scripts WHERE entryorguid IN(34086, 34201) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34086, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 6000, 11, 64773, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fire Blast');
INSERT INTO `smart_scripts` VALUES (34086, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 64746, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Superheated Winds');

-- Superheated Winds (34194)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, modelid3=0, modelid4=0, mindmg=1, maxdmg=1, attackpower=1, dmg_multiplier=1, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=34194;
DELETE FROM smart_scripts WHERE entryorguid IN(34194) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34194, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'passive');
INSERT INTO `smart_scripts` VALUES (34194, 0, 1, 0, 1, 0, 100, 1, 500, 500, 0, 0, 89, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'move randomly');
REPLACE INTO creature_template_addon VALUES(34194, 0, 0, 0, 1, 0, '64724');

-- Forge Construct (34085, 34186)
UPDATE creature_template SET mindmg=3341, maxdmg=4555, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=34085;
UPDATE creature_template SET mindmg=2703, maxdmg=3685, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34186;
DELETE FROM smart_scripts WHERE entryorguid IN(34085, 34186) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34085, 0, 0, 0, 0, 0, 100, 2, 3000, 5000, 8000, 10000, 11, 64720, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flame Emission 10');
INSERT INTO `smart_scripts` VALUES (34085, 0, 1, 0, 0, 0, 100, 4, 3000, 5000, 8000, 10000, 11, 64721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flame Emission 25');
INSERT INTO `smart_scripts` VALUES (34085, 0, 2, 0, 0, 0, 100, 0, 500, 500, 60000, 60000, 11, 64719, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charge');

-- Molten Colossus (34069, 34185)
UPDATE creature_template SET mindmg=3323, maxdmg=4530, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34069;
UPDATE creature_template SET mindmg=2684, maxdmg=3659, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=34185;
DELETE FROM smart_scripts WHERE entryorguid IN(34069, 34185) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34069, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 12000, 20000, 11, 64697, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Earthquake');
INSERT INTO `smart_scripts` VALUES (34069, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 6000, 10000, 11, 64698, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pyroblast');

-- Enslaved Fire Elemental (33838)
UPDATE creature_template SET difficulty_entry_1=0, mindmg=1000, maxdmg=2000, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33838;
DELETE FROM smart_scripts WHERE entryorguid IN(33838) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33838, 0, 0, 0, 0, 0, 100, 0, 500, 500, 30000, 30000, 11, 63778, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire Shield');
INSERT INTO `smart_scripts` VALUES (33838, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 8000, 12000, 11, 38064, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blast Wave');
UPDATE creature SET spawntimesecs=604800 WHERE id=33838;

-- Twilight Shadowblade (33824, 33831)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33824;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33831;
DELETE FROM smart_scripts WHERE entryorguid IN(33824, 33831) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33824, 0, 0, 0, 67, 0, 100, 0, 3000, 3000, 0, 0, 11, 63754, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Backstab');
INSERT INTO `smart_scripts` VALUES (33824, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 16000, 11, 63753, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fan of Knives');

-- Twilight Slayer (33823, 33832)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33823;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33832;
DELETE FROM smart_scripts WHERE entryorguid IN(33823, 33832) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33823, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 20000, 30000, 11, 63784, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bladestorm');
INSERT INTO `smart_scripts` VALUES (33823, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 10000, 16000, 11, 35054, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mortal Strike');

-- Twilight Guardian (33822, 33828)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33822;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33828;
DELETE FROM smart_scripts WHERE entryorguid IN(33822, 33828) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33822, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 10000, 15000, 11, 52719, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Concussion Blow');
INSERT INTO `smart_scripts` VALUES (33822, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 10000, 15000, 11, 62317, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devastate');
INSERT INTO `smart_scripts` VALUES (33822, 0, 2, 0, 0, 0, 100, 0, 3000, 8000, 10000, 15000, 11, 63757, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thunderclap');

-- Twilight Pyromancer (33820, 33830)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33820;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33830;
DELETE FROM smart_scripts WHERE entryorguid IN(33820, 33830) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33820, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 11, 64663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Burst');
INSERT INTO `smart_scripts` VALUES (33820, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 3500, 11, 63789, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO `smart_scripts` VALUES (33820, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 63775, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Flamestrike');

-- Twilight Frost Mage (33819, 33829)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33819;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33829;
DELETE FROM smart_scripts WHERE entryorguid IN(33819, 33829) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33819, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 11, 64663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Burst');
INSERT INTO `smart_scripts` VALUES (33819, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 10000, 15000, 11, 63758, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Bolt Volley');
INSERT INTO `smart_scripts` VALUES (33819, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 10000, 20000, 11, 63912, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Nova');
INSERT INTO `smart_scripts` VALUES (33819, 0, 3, 0, 0, 0, 100, 0, 1000, 2000, 3000, 3500, 11, 63913, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Frostbolt');

-- Twilight Adherent (33818, 33827)
UPDATE creature_template SET mindmg=2741, maxdmg=3742, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33818;
UPDATE creature_template SET mindmg=2218, maxdmg=3028, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33827;
DELETE FROM smart_scripts WHERE entryorguid IN(33818, 33827) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33818, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 11, 64663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Burst');
INSERT INTO `smart_scripts` VALUES (33818, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 15000, 20000, 11, 13704, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Psychic Scream');
INSERT INTO `smart_scripts` VALUES (33818, 0, 2, 0, 14, 0, 100, 2, 70000, 39, 10000, 10000, 11, 63760, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Greater Heal 10');
INSERT INTO `smart_scripts` VALUES (33818, 0, 3, 0, 14, 0, 100, 4, 150000, 39, 10000, 10000, 11, 61965, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Greater Heal 25');

-- Ulduar Shield Bunny (33779)
UPDATE creature_template SET flags_extra=130 WHERE entry=33779;

-- Slain Iron Dwarf (33775)

-- Slain Iron Vrykul (33774)

-- Faceless Horror (33772, 33773)
UPDATE creature_template SET mindmg=4123, maxdmg=5621, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=33772;
UPDATE creature_template SET mindmg=3330, maxdmg=4540, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=33773;
DELETE FROM smart_scripts WHERE entryorguid IN(33772, 33773) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33772, 0, 0, 0, 0, 0, 100, 0, 500, 500, 30000, 30000, 11, 49576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death Grip');
INSERT INTO `smart_scripts` VALUES (33772, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 7000, 12000, 11, 63722, 0, 0, 0, 0, 0, 17, 12, 65, 1, 0, 0, 0, 0, 'Shadow Crash');
INSERT INTO `smart_scripts` VALUES (33772, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Wave');
INSERT INTO `smart_scripts` VALUES (33772, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Void Wave');
DELETE FROM creature_template_addon WHERE entry IN(33772, 33773);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33772, 33773) AND `map`=603 );

-- Storm Tempered Keeper (33722, 33723)
-- Storm Tempered Keeper (33699, 33700)
UPDATE creature_template SET speed_walk=3.2, speed_run=2, mindmg=4000, maxdmg=5500, attackpower=782, dmg_multiplier=7, AIName='', ScriptName='npc_ulduar_storm_tempered_keeper', mechanic_immune_mask=650854271 WHERE entry=33722;
UPDATE creature_template SET speed_walk=3.2, speed_run=2, mindmg=4000, maxdmg=5500, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=33723;
DELETE FROM smart_scripts WHERE entryorguid IN(33722, 33723) AND source_type=0;
UPDATE creature_template SET speed_walk=3.2, speed_run=2, mindmg=4000, maxdmg=5500, attackpower=782, dmg_multiplier=7, AIName='', ScriptName='npc_ulduar_storm_tempered_keeper', mechanic_immune_mask=650854271 WHERE entry=33699;
UPDATE creature_template SET speed_walk=3.2, speed_run=2, mindmg=4000, maxdmg=5500, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=650854271 WHERE entry=33700;
DELETE FROM smart_scripts WHERE entryorguid IN(33699, 33700) AND source_type=0;
DELETE FROM creature_formations WHERE leaderGUID IN(136763,136764,136765,136766,136783,136784,136785,136786);
INSERT INTO `creature_formations` VALUES (136763, 136763, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136763, 136783, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136764, 136764, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136764, 136784, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136765, 136765, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136765, 136785, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136766, 136766, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136766, 136786, 0, 0, 5, 0, 0);

-- Charged Sphere (33715, 33756)
UPDATE creature_template SET speed_walk=1, speed_run=0.6, AIName='NullCreatureAI', ScriptName='', RegenHealth=0, mechanic_immune_mask=650854271 WHERE entry=33715;
UPDATE creature_template SET speed_walk=1, speed_run=0.6, AIName='', ScriptName='', RegenHealth=0, mechanic_immune_mask=650854271 WHERE entry=33756;
DELETE FROM smart_scripts WHERE entryorguid IN(33715, 33756) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(33715, 0, 0, 0, 1, 0, '63537'),(33756, 0, 0, 0, 1, 0, '63537');

-- Lore Keeper Projection Unit (33721)

-- High Explorer Dellorah (33701)

-- Archmage Rhydian (33696)

-- Lore Keeper of Norgannon (33686)

-- Kirin Tor Mage (33672)
UPDATE creature SET position_x=-813.209, position_y=-203.945, position_z=492.843, orientation=0 WHERE guid=136552 AND id=33672;
UPDATE creature SET position_x=-813.209, position_y=-198.945, position_z=492.843, orientation=0 WHERE guid=136553 AND id=33672;

-- Demolisher Engineer Blastwrench (33669)

-- Kirin Tor Battle-Mage (33662)
UPDATE creature SET position_x=-813.209, position_y=-201.445, position_z=492.843, orientation=0 WHERE guid=136523 AND id=33662;

-- Weslex Quickwrench (33629)

-- Hired Demolitionist (33627)

-- Hired Engineer (33626)

-- Archmage Pentarus (33624)

-- Goran Steelbreaker (33622)

-- Earthen Stoneshaper (33620)

-- Brann Bronzebeard (33579)

-- Guardian of Life (33528, 33733)
UPDATE creature_template SET mindmg=3540, maxdmg=4826, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33528;
UPDATE creature_template SET mindmg=2861, maxdmg=3901, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33733;
DELETE FROM smart_scripts WHERE entryorguid IN(33528, 33733) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33528, 0, 0, 0, 0, 0, 100, 2, 4000, 6000, 8000, 12000, 11, 63226, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Poison Breath 10');
INSERT INTO `smart_scripts` VALUES (33528, 0, 1, 0, 0, 0, 100, 4, 4000, 6000, 8000, 12000, 11, 63551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Poison Breath 25');

-- Nature's Blade (33527, 33741)
UPDATE creature_template SET mindmg=2355, maxdmg=3218, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33527;
UPDATE creature_template SET mindmg=1902, maxdmg=2599, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33741;
DELETE FROM smart_scripts WHERE entryorguid IN(33527, 33741) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33527, 0, 0, 0, 0, 0, 100, 2, 4000, 6000, 8000, 12000, 11, 63247, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Living Tsunami 10');
INSERT INTO `smart_scripts` VALUES (33527, 0, 1, 0, 0, 0, 100, 4, 4000, 6000, 8000, 12000, 11, 63568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Living Tsunami 25');

-- Ironroot Lasher (33526, 33734)
UPDATE creature_template SET mindmg=1774, maxdmg=2427, attackpower=708, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33526;
UPDATE creature_template SET mindmg=1398, maxdmg=1906, attackpower=708, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33734;
DELETE FROM smart_scripts WHERE entryorguid IN(33526, 33734) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33526, 0, 0, 0, 16, 0, 100, 2, 63240, 39, 3000, 3000, 11, 63240, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ironroot Thorns 10');
INSERT INTO `smart_scripts` VALUES (33526, 0, 1, 0, 16, 0, 100, 4, 63553, 39, 3000, 3000, 11, 63553, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ironroot Thorns 25');

-- Mangrove Ent (33525, 33735)
UPDATE creature_template SET mindmg=1774, maxdmg=2427, attackpower=708, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33525;
UPDATE creature_template SET mindmg=1398, maxdmg=1906, attackpower=708, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33735;
DELETE FROM smart_scripts WHERE entryorguid IN(33525, 33735) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33525, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 25000, 35000, 11, 63272, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Hurricane');
INSERT INTO `smart_scripts` VALUES (33525, 0, 1, 0, 14, 0, 100, 2, 20000, 39, 4000, 4000, 11, 63242, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nourish 10');
INSERT INTO `smart_scripts` VALUES (33525, 0, 2, 0, 14, 0, 100, 4, 40000, 39, 4000, 4000, 11, 63556, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nourish 25');
INSERT INTO `smart_scripts` VALUES (33525, 0, 3, 0, 14, 0, 100, 2, 50000, 19, 15000, 20000, 11, 63241, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tranquility 10');
INSERT INTO `smart_scripts` VALUES (33525, 0, 4, 0, 14, 0, 100, 4, 100000, 19, 15000, 20000, 11, 63554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tranquility 25');

-- Forest Swarmer (33431, 33731)
UPDATE creature_template SET mindmg=1182, maxdmg=1612, attackpower=708, dmg_multiplier=3, AIName='SmartAI', ScriptName='' WHERE entry=33431;
UPDATE creature_template SET mindmg=955, maxdmg=1302, attackpower=708, dmg_multiplier=6, AIName='', ScriptName='' WHERE entry=33731;
DELETE FROM smart_scripts WHERE entryorguid IN(33431, 33731) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33431, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 15000, 20000, 11, 63059, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pollinate');

-- Guardian Lasher (33430, 33732)
UPDATE creature_template SET mindmg=1774, maxdmg=2427, attackpower=708, dmg_multiplier=5, AIName='SmartAI', ScriptName='' WHERE entry=33430;
UPDATE creature_template SET mindmg=1398, maxdmg=1906, attackpower=708, dmg_multiplier=10, AIName='', ScriptName='' WHERE entry=33732;
DELETE FROM smart_scripts WHERE entryorguid IN(33430, 33732) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33430, 0, 0, 0, 0, 0, 100, 2, 3000, 5000, 8000, 10000, 11, 63047, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Guardian\'s Lash 10');
INSERT INTO `smart_scripts` VALUES (33430, 0, 1, 0, 0, 0, 100, 4, 3000, 5000, 8000, 10000, 11, 63550, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Guardian\'s Lash 25');
REPLACE INTO creature_template_addon VALUES(33430, 0, 0, 0, 1, 0, '63007'),(33732, 0, 0, 0, 1, 0, '63007');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33430, 33732) AND `map`=603 );

-- Misguided Nymph (33355, 33737)
UPDATE creature_template SET mindmg=2355, maxdmg=3218, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33355;
UPDATE creature_template SET mindmg=1902, maxdmg=2599, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33737;
DELETE FROM smart_scripts WHERE entryorguid IN(33355, 33737) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33355, 0, 0, 0, 0, 0, 100, 2, 3000, 5000, 8000, 12000, 11, 63111, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Frost Spear 10');
INSERT INTO `smart_scripts` VALUES (33355, 0, 1, 0, 0, 0, 100, 4, 3000, 5000, 8000, 12000, 11, 63562, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Frost Spear 25');
INSERT INTO `smart_scripts` VALUES (33355, 0, 2, 0, 14, 0, 100, 2, 40000, 44, 10000, 10000, 11, 63082, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bind Life 10');
INSERT INTO `smart_scripts` VALUES (33355, 0, 3, 0, 14, 0, 100, 4, 60000, 44, 10000, 10000, 11, 63559, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bind Life 25');
INSERT INTO `smart_scripts` VALUES (33355, 0, 4, 0, 0, 0, 100, 2, 500, 500, 45000, 45000, 11, 63136, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winter\'s Embrace 10');
INSERT INTO `smart_scripts` VALUES (33355, 0, 5, 0, 0, 0, 100, 4, 500, 500, 45000, 45000, 11, 63564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Winter\'s Embrace 25');

-- Corrupted Servitor (33354, 33729)
UPDATE creature_template SET mindmg=2944, maxdmg=4022, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33354;
UPDATE creature_template SET mindmg=2348, maxdmg=3207, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33729;
DELETE FROM smart_scripts WHERE entryorguid IN(33354, 33729) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33354, 0, 0, 0, 0, 0, 100, 2, 3000, 5000, 8000, 10000, 11, 63169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Petrify Joints 10');
INSERT INTO `smart_scripts` VALUES (33354, 0, 1, 0, 0, 0, 100, 4, 3000, 5000, 8000, 10000, 11, 63549, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Petrify Joints 25');
INSERT INTO `smart_scripts` VALUES (33354, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 8000, 12000, 11, 63149, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Violent Earth');

-- Ulduar Colossus (33237, 34105)
UPDATE creature_template SET mindmg=3393, maxdmg=4626, attackpower=782, dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=33237;
UPDATE creature_template SET mindmg=2743, maxdmg=3740, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34105;
DELETE FROM smart_scripts WHERE entryorguid IN(33237, 34105) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33237, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 20000, 11, 62625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ground Slam');

-- Steelforged Defender (33236, 34113)
UPDATE creature_template SET mindmg=537, maxdmg=731, attackpower=608, dmg_multiplier=1, AIName='SmartAI', ScriptName='' WHERE entry=33236;
UPDATE creature_template SET mindmg=537, maxdmg=731, attackpower=608, dmg_multiplier=2, AIName='', ScriptName='' WHERE entry=34113;
DELETE FROM smart_scripts WHERE entryorguid IN(33236, 34113) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (33236, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 10000, 12000, 11, 62845, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hamstring');
INSERT INTO `smart_scripts` VALUES (33236, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 57780, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lightning Bolt');
INSERT INTO `smart_scripts` VALUES (33236, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 5000, 6000, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunder Armor');
INSERT INTO `smart_scripts` VALUES (33236, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 700, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dwarfageddon Achievement');

-- Dark Rune Ravager (33755, 33758)
UPDATE creature_template SET mindmg=3438, maxdmg=4688, attackpower=782, dmg_multiplier=7, AIName='', ScriptName='' WHERE entry=33755;
UPDATE creature_template SET mindmg=2736, maxdmg=3731, attackpower=782, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=33758;
DELETE FROM smart_scripts WHERE entryorguid IN(33755, 33758) AND source_type=0;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33755, 33758) AND `map`=603 );
REPLACE INTO creature_template_addon VALUES(33755, 0, 0, 0, 1, 0, '63616'),(33758, 0, 0, 0, 1, 0, '63616');

-- Dark Rune Thunderer (33754, 33757)
UPDATE creature_template SET mindmg=1000, maxdmg=1500, attackpower=782, dmg_multiplier=7, dmgschool=3, AIName='', ScriptName='' WHERE entry=33754;
UPDATE creature_template SET mindmg=800, maxdmg=1200, attackpower=782, dmg_multiplier=13, dmgschool=3, AIName='', ScriptName='' WHERE entry=33757;
DELETE FROM smart_scripts WHERE entryorguid IN(33754, 33757) AND source_type=0;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33754, 33757) AND `map`=603 );
REPLACE INTO creature_template_addon VALUES(33754, 0, 0, 0, 1, 0, '63610'),(33757, 0, 0, 0, 1, 0, '63610');

-- Invisible Stalker (All Phases) (32780)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32780) AND `map`=603 );
DELETE FROM creature WHERE id IN(32780) AND `map`=603;

-- Invisible Stalker (Float, Uninteractible, LargeAOI) (30298)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30298) AND `map`=603 );
DELETE FROM creature WHERE id IN(30298) AND `map`=603;

-- World Trigger (Large AOI) (22517)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22517) AND `map`=603 );
DELETE FROM creature WHERE id IN(22517) AND `map`=603;

-- World Trigger (22515)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(22515) AND `map`=603 );
DELETE FROM creature WHERE id IN(22515) AND `map`=603;

-- World Trigger (Not Immune PC) (21252)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(21252) AND `map`=603 );
DELETE FROM creature WHERE id IN(21252) AND `map`=603;

-- GENERAL RULE: humanoids immune to mind control
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|1 WHERE type=7 AND entry IN( SELECT DISTINCT id FROM creature WHERE map=603 );
UPDATE creature_template ct1 LEFT JOIN creature_template ct2 ON ct1.difficulty_entry_1=ct2.entry SET ct2.mechanic_immune_mask=ct2.mechanic_immune_mask|1 WHERE ct2.entry IS NOT NULL AND ct1.type=7 AND ct1.entry IN( SELECT DISTINCT id FROM creature WHERE map=603 );




-- ###################
-- ### FORMATIONS
-- ###################

-- XT002 right side
DELETE FROM creature_formations WHERE memberGUID IN(137486, 137489, 137493, 137487, 137495);
DELETE FROM creature_formations WHERE leaderGUID IN(137486, 137489, 137493, 137487, 137495);
INSERT INTO `creature_formations` VALUES (137486, 137486, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137486, 137489, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137486, 137493, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137486, 137487, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137486, 137495, 0, 0, 5, 0, 0);

-- XT002 left side
DELETE FROM creature_formations WHERE memberGUID IN(137488, 137494, 137492, 137485);
DELETE FROM creature_formations WHERE leaderGUID IN(137488, 137494, 137492, 137485);
INSERT INTO `creature_formations` VALUES (137488, 137488, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137488, 137494, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137488, 137492, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (137488, 137485, 0, 0, 5, 0, 0);

-- Molten Colossus (before Ignis)
DELETE FROM creature_formations WHERE memberGUID IN(136057, 136058);
DELETE FROM creature_formations WHERE leaderGUID IN(136057, 136058);
INSERT INTO `creature_formations` VALUES (136057, 136057, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (136057, 136058, 0, 0, 5, 0, 0);



-- ###################
-- ### GENERAL SPELLS
-- ###################

-- Energy Sap (64740, 64876, 64747, 64863)
DELETE FROM spell_script_names WHERE spell_id IN(64740, 64876, 64747, 64863, -64740, -64876, -64747, -64863);
DELETE FROM spell_scripts WHERE id IN(64740, 64876, 64747, 64863, -64740, -64876, -64747, -64863);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64740, 64876, 64747, 64863, -64740, -64876, -64747, -64863) OR spell_effect IN(64740, 64876, 64747, 64863, -64740, -64876, -64747, -64863);
INSERT INTO spell_script_names VALUES(64740, 'spell_ulduar_energy_sap'),(64876, 'spell_ulduar_energy_sap');

-- Supercharged (63528)
DELETE FROM spell_script_names WHERE spell_id IN(63528, -63528);
DELETE FROM spell_scripts WHERE id IN(63528, -63528);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63528, -63528) OR spell_effect IN(63528, -63528);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63528);
INSERT INTO `conditions` VALUES (13, 3, 63528, 0, 0, 31, 0, 3, 33722, 0, 0, 0, 0, '', 'Storm Tempered Keeper - Supercharged');
INSERT INTO `conditions` VALUES (13, 3, 63528, 0, 1, 31, 0, 3, 33699, 0, 0, 0, 0, '', 'Storm Tempered Keeper - Supercharged');

-- Pollinate (63059)
DELETE FROM spell_script_names WHERE spell_id IN(63059, -63059);
DELETE FROM spell_scripts WHERE id IN(63059, -63059);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63059, -63059) OR spell_effect IN(63059, -63059);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63059);
INSERT INTO `conditions` VALUES (13, 7, 63059, 0, 0, 31, 0, 3, 33430, 0, 0, 0, 0, '', 'Pollinate - Forest Swarmer');
INSERT INTO `conditions` VALUES (13, 7, 63059, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Pollinate - Forest Swarmer');

-- Freya Dummy Green (63295)
-- Freya Dummy Yellow (63292)
-- Freya Dummy Blue (63294)
DELETE FROM spell_script_names WHERE spell_id IN(63295, 63292, 63294, -63295, -63292, -63294);
DELETE FROM spell_scripts WHERE id IN(63295, 63292, 63294, -63295, -63292, -63294);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63295, 63292, 63294, -63295, -63292, -63294) OR spell_effect IN(63295, 63292, 63294, -63295, -63292, -63294);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63295, 63292, 63294);
INSERT INTO `conditions` VALUES (13, 3, 63295, 0, 0, 31, 0, 3, 33856, 0, 0, 0, 0, '', 'Mimiron - Freya Dummy Green');
INSERT INTO `conditions` VALUES (13, 3, 63295, 0, 1, 31, 0, 3, 33366, 0, 0, 0, 0, '', 'Freya Ward - Freya Dummy Green');
INSERT INTO `conditions` VALUES (13, 3, 63292, 0, 0, 31, 0, 3, 33856, 0, 0, 0, 0, '', 'Mimiron - Freya Dummy Yellow');
INSERT INTO `conditions` VALUES (13, 3, 63292, 0, 1, 31, 0, 3, 33369, 0, 0, 0, 0, '', 'Mimiron Inferno - Freya Dummy Yellow');
INSERT INTO `conditions` VALUES (13, 3, 63294, 0, 0, 31, 0, 3, 33856, 0, 0, 0, 0, '', 'Mimiron - Freya Dummy Blue');
INSERT INTO `conditions` VALUES (13, 3, 63294, 0, 1, 31, 0, 3, 33364, 0, 0, 0, 0, '', 'Thorim Hammer - Freya Dummy Blue');
INSERT INTO `conditions` VALUES (13, 3, 63294, 0, 2, 31, 0, 3, 33108, 0, 0, 0, 0, '', 'Hodirs Fury - Freya Dummy Blue');

-- Aggregation Pheromones (63007, 63006)
DELETE FROM spell_script_names WHERE spell_id IN(63007, 63006, -63007, -63006);
DELETE FROM spell_scripts WHERE id IN(63007, 63006, -63007, -63006);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63007, 63006, -63007, -63006) OR spell_effect IN(63007, 63006, -63007, -63006);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63007, 63006);
INSERT INTO `conditions` VALUES (13, 7, 63006, 0, 0, 31, 0, 3, 33430, 0, 1, 0, 0, '', 'Guardian Lasher - Aggregation Pheromones');

-- Teleport Spells, we use gameobject script
DELETE FROM spell_target_position WHERE id IN(64014, 64024, 64025, 64028, 64029, 64030, 64031, 64032, 65042);



-- ###################
-- ### FLAME LEVIATHAN
-- ###################

-- Pursue (62374)
DELETE FROM spell_script_names WHERE spell_id IN (62374);
INSERT INTO spell_script_names VALUES(62374, 'spell_pursue');

-- Systems Shutdown (62475)
DELETE FROM spell_script_names WHERE spell_id IN (62475);
INSERT INTO spell_script_names VALUES(62475, 'spell_systems_shutdown');

-- Throw Passenger (62324)
DELETE FROM spell_script_names WHERE spell_id IN (62324);
INSERT INTO spell_script_names VALUES(62324, 'spell_vehicle_throw_passenger');

-- Load Into Catapult (64414)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64414);
INSERT INTO conditions VALUES (13, 1, 64414, 0, 0, 31, 0, 3, 33109, 0, 0, 0, 0, '', 'Demolisher');
DELETE FROM spell_script_names WHERE spell_id IN (64414);
INSERT INTO spell_script_names VALUES(64414, 'spell_load_into_catapult');

-- Auto Repair (62705)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62705);
INSERT INTO conditions VALUES (13, 7, 62705, 0, 0, 31, 0, 3, 33060, 0, 0, 0, 0, '', 'Siege Engine');
INSERT INTO conditions VALUES (13, 7, 62705, 0, 1, 31, 0, 3, 33062, 0, 0, 0, 0, '', 'Chopper');
INSERT INTO conditions VALUES (13, 7, 62705, 0, 2, 31, 0, 3, 33109, 0, 0, 0, 0, '', 'Demolisher');
DELETE FROM spell_script_names WHERE spell_id IN (62705);
INSERT INTO spell_script_names VALUES(62705, 'spell_auto_repair');

-- Tar Blaze (62292)
DELETE FROM spell_script_names WHERE spell_id IN (62292);
INSERT INTO spell_script_names VALUES(62292, 'spell_tar_blaze');

-- Grab Pyrite (62482)
DELETE FROM spell_script_names WHERE spell_id IN (62482);
INSERT INTO spell_script_names VALUES(62482, 'spell_vehicle_grab_pyrite');

-- Flames (65045)
-- Flames (65044)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65044, 65045, -65044, -65045);
INSERT INTO spell_linked_spell VALUES(65044, -62297, 1, "Flames remove ice");
INSERT INTO spell_linked_spell VALUES(65045, -62297, 1, "Flames remove ice");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65044, 65045);
INSERT INTO conditions VALUES (13, 1, 65044, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Any Npc');
INSERT INTO conditions VALUES (13, 1, 65044, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Any Player');
INSERT INTO conditions VALUES (13, 2, 65044, 0, 0, 31, 0, 3, 33090, 0, 0, 0, 0, '', 'Tar');
INSERT INTO conditions VALUES (13, 1, 65045, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Any Npc');
INSERT INTO conditions VALUES (13, 1, 65045, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Any Player');
INSERT INTO conditions VALUES (13, 2, 65045, 0, 0, 31, 0, 3, 33090, 0, 0, 0, 0, '', 'Tar');

-- Anit-Air Rocket (62363)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62363);
INSERT INTO conditions VALUES (13, 2, 62363, 0, 0, 31, 0, 3, 1817, 0, 0, 0, 0, '', 'Diseased wolf (used to skip effect)');

-- Overload Circuit (62399)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62399);
INSERT INTO conditions VALUES (13, 3, 62399, 0, 0, 31, 0, 3, 33113, 0, 0, 0, 0, '', 'Flame Leviathan');
DELETE FROM spell_script_names WHERE spell_id IN (62399);
INSERT INTO spell_script_names VALUES(62399, 'spell_vehicle_circuit_overload');

-- Oribtal Supports
DELETE FROM spell_script_names WHERE spell_id IN (64482, 65075, 65076, 65077);
INSERT INTO spell_script_names VALUES(64482, 'spell_orbital_supports');
INSERT INTO spell_script_names VALUES(65075, 'spell_orbital_supports');
INSERT INTO spell_script_names VALUES(65076, 'spell_orbital_supports');
INSERT INTO spell_script_names VALUES(65077, 'spell_orbital_supports');

-- Thorim's Hammer (62911)
-- Thorim's Hammer (62912)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62911);
INSERT INTO conditions VALUES (13, 1, 62911, 0, 0, 31, 0, 3, 33364, 0, 0, 0, 0, '', 'Thorims Hammer trigger');
DELETE FROM spell_script_names WHERE spell_id IN (62912);
INSERT INTO spell_script_names VALUES(62912, 'spell_thorims_hammer');

-- Freya's Ward (62906)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62906);
INSERT INTO conditions VALUES (13, 1, 62906, 0, 0, 31, 0, 3, 33366, 0, 0, 0, 0, '', 'Freyas Ward trigger');

-- Mimiron's Inferno (62909)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62909);
INSERT INTO conditions VALUES (13, 1, 62909, 0, 0, 31, 0, 3, 33369, 0, 0, 0, 0, '', 'Mimirons Inferno trigger');

-- Hodir's Fury (62533)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62533);
INSERT INTO conditions VALUES (13, 1, 62533, 0, 0, 31, 0, 3, 33108, 0, 0, 0, 0, '', 'Hodirs Fury trigger');

-- Shield Generator (64677)
DELETE FROM spell_script_names WHERE spell_id IN (64677);
INSERT INTO spell_script_names VALUES(64677, 'spell_shield_generator');

-- Pyrite remove (62474)
DELETE FROM spell_linked_spell WHERE spell_trigger=62490;
INSERT INTO spell_linked_spell VALUES(62490, 62474, 0, 'Remove pyrite');

-- Ride Vehicle (62309), used by demolisher
DELETE FROM spell_script_names WHERE spell_id IN (62309);
INSERT INTO spell_script_names VALUES(62309, 'spell_demolisher_ride_vehicle');


-- Flame Leviathan (33113, 34003)
REPLACE INTO creature_model_info VALUES(28875, 1.125, 15, 2, 0);
DELETE FROM vehicle_template_accessory WHERE entry IN(33113);
REPLACE INTO vehicle_template_accessory VALUES(33113, 33114, 0, 1, 'Flame Leviathan Seat', 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(33113, 33114, 1, 1, 'Flame Leviathan Seat', 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(33113, 33114, 2, 1, 'Flame Leviathan Seat', 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(33113, 33114, 3, 1, 'Flame Leviathan Seat', 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(33113, 33139, 7, 1, 'Flame Leviathan Cannon', 6, 30000);
UPDATE creature_template SET speed_walk=1.2, speed_run=0.71429, mindmg=5483, maxdmg=7475, attackpower=805, dmg_multiplier=7, baseattacktime=2000, vehicleId=340, mingold=1690736, maxgold=1690736, mechanic_immune_mask=650854271, AIName='', flags_extra=256+1+0x200000, ScriptName='boss_flame_leviathan' WHERE entry=33113;
UPDATE creature_template SET speed_walk=1.2, speed_run=0.71429, mindmg=4389, maxdmg=5983, attackpower=805, dmg_multiplier=13, baseattacktime=2000, vehicleId=340, mingold=1690736, maxgold=1690736, mechanic_immune_mask=650854271, AIName='', flags_extra=256+1+0x200000, ScriptName='' WHERE entry=34003;

-- Flame Leviathan Turret (33139, 34111)
UPDATE creature_template SET unit_flags=33554432+2, AIName='NullCreatureAI', ScriptName='' WHERE entry=33139;
UPDATE creature_template SET unit_flags=33554432+2, AIName='', ScriptName='' WHERE entry=34111;

-- Flame Leviathan Seat (33114)
UPDATE creature_template SET modelid1=11686, modelid2=0, AIName='', ScriptName='boss_flame_leviathan_seat' WHERE entry=33114;
REPLACE INTO vehicle_template_accessory VALUES(33114, 33142, 1, 1, 'leviathan seat defense turret', 6, 30000);
REPLACE INTO vehicle_template_accessory VALUES(33114, 33143, 2, 1, 'leviathan seat overload device', 6, 30000);

-- Leviathan Defense Turret (33142)
UPDATE creature_template SET unit_flags=33554432+256+512, unit_flags=0, RegenHealth=0, faction=1965, AIName='', ScriptName='boss_flame_leviathan_defense_turret' WHERE entry=33142;

-- Overload Control Device (33143)
UPDATE creature_template SET npcflag=16777216, unit_flags=33554432, modelid1=28469, modelid2=0, modelid3=0, AIName='', ScriptName='boss_flame_leviathan_overload_device' WHERE entry=33143;

-- Lore Keeper of Norgannon (33686)
UPDATE creature_template SET AIName='', ScriptName='npc_lore_keeper_of_norgannon_ulduar' WHERE entry=33686;

-- Brann Bronzebeard (33579)
UPDATE creature_template SET AIName='', ScriptName='npc_brann_ulduar' WHERE entry=33579;

-- Bronzebeard Radio (34054)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=34054);
DELETE FROM creature WHERE id=34054;
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, -508.898, -32.9631, 409.802, 3.28074, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, -81.9207, 111.432, 434.406, 4.59629, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, -221.475, -271.087, 369.465, 4.25072, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, 73.8978, -29.3306, 409.814, 3.13546, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, 68.7679, -325.026, 410.818, 4.6984, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34054, 603, 3, 1, 11686, 0, 174.442, 345.679, 412.872, 6.28098, 300, 0, 0, 75600, 0, 0, 0, 0, 0);
UPDATE creature_template SET modelid1=11686, unit_flags=33554432, AIName='', ScriptName='npc_brann_radio' WHERE entry=34054;

-- Storm Beacon (x, many entries)
UPDATE gameobject_template SET AIName='', ScriptName='go_ulduar_tower' WHERE type=33 AND displayId=8593;

-- Wrecked Siege Engine (33063)
-- Wrecked Demolisher (33059)
UPDATE creature_template SET unit_flags2=1 WHERE entry=33059;
UPDATE creature_template SET unit_flags2=2049 WHERE entry=33063;

-- Ulduar Gauntlet Generator (33571)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33571 AND position_x>128);
DELETE FROM creature WHERE id=33571 AND position_x>128;
UPDATE creature SET spawntimesecs=86400 WHERE id=33571;
UPDATE creature_template SET AIName='', ScriptName='npc_storm_beacon_spawn' WHERE entry=33571;

-- Steelforged Defender (33572, 34247)
UPDATE creature SET spawntimesecs=86400 WHERE id=33236;
UPDATE creature_template SET mindmg=537, maxdmg=731, attackpower=608, dmg_multiplier=1, AIName='SmartAI', ScriptName='' WHERE entry=33572;
UPDATE creature_template SET mindmg=537, maxdmg=731, attackpower=608, dmg_multiplier=2, AIName='', ScriptName='' WHERE entry=34247;
DELETE FROM smart_scripts WHERE entryorguid IN(33572, 34247) AND source_type=0;
-- INSERT INTO smart_scripts VALUES (33572, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 10000, 12000, 11, 62845, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hamstring');
INSERT INTO smart_scripts VALUES (33572, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 57780, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lightning Bolt');
INSERT INTO smart_scripts VALUES (33572, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 5000, 6000, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunder Armor');
INSERT INTO smart_scripts VALUES (33572, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 700, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dwarfageddon Achievement');

-- Earthen Stoneshaper (33620)
UPDATE creature_template SET unit_flags=33587970, AIName="NullCreatureAI" WHERE entry=33620;

-- Salvaged Siege Turret (33067)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33067);
DELETE FROM creature WHERE id=33067;
UPDATE creature_template SET unit_flags=16386, mechanic_immune_mask=67109888 WHERE entry=33067;

-- Salvaged Siege Engine (33060)
UPDATE creature_template SET mechanic_immune_mask=67109888 WHERE entry=33060;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33060));
DELETE FROM creature WHERE id IN(33060);

-- Salvaged Demolisher Mechanic Seat (33167)
REPLACE INTO npc_spellclick_spells VALUES(33167, 65031, 1, 0);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33167);
DELETE FROM creature WHERE id=33167;
UPDATE creature_template SET modelid1=29168, modelid2=0, Health_mod=50, unit_flags=33554432+2, unit_flags2=0, mechanic_immune_mask=67109888 WHERE entry=33167;

-- Salvaged Chopper (33062, 34045)
UPDATE creature_template SET mechanic_immune_mask=67109888 WHERE entry=33062;
UPDATE creature_template SET spell1=62974, spell2=62286, spell3=62299, spell4=64660, mechanic_immune_mask=67109888 WHERE entry=34045;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33062));
DELETE FROM creature WHERE id IN(33062);

-- Salvaged Demolisher (33109)
DELETE FROM vehicle_template_accessory WHERE entry=33109;
INSERT INTO vehicle_template_accessory VALUES(33109, 33167, 1, 1, 'Salvaged Demolisher', 6, 30000);
INSERT INTO vehicle_template_accessory VALUES(33109, 33620, 2, 1, 'Earthen Stoneshaper', 6, 30000);
UPDATE creature_template SET unit_flags2=0, mechanic_immune_mask=67109888 WHERE entry=33109;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33109));
DELETE FROM creature WHERE id IN(33109);

-- Lightning Door (194905)
DELETE FROM gameobject WHERE id IN(194905);
INSERT INTO gameobject VALUES (NULL, 194905, 603, 3, 1, 401.308, -13.8236, 409.524, 3.14159, 0, 0, 0, 1, 180, 255, 1, 0);

-- Trash Before Flame Leviathan (34144, 34145, 32780, 33377, 34286)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34144, 34145, 32780, 33377, 34286) AND position_x > 100 AND position_x < 450);
DELETE FROM creature WHERE id IN(34144, 34145, 32780, 33377, 34286) AND position_x > 100 AND position_x < 450;

-- Change Safe containers with Mechanolifts (33214)
-- Safety Container (33218)
UPDATE creature_template SET unit_flags=33554432+2, modelid1=28782, modelid2=0, AIName='', ScriptName='boss_flame_leviathan_safety_container' WHERE entry=33218;
UPDATE creature_template SET AIName='', ScriptName='npc_mechanolift' WHERE entry=33214;
UPDATE creature SET id=33214, modelid=0 WHERE id=33218;
UPDATE creature SET modelid=0 WHERE id=33214;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33214);
UPDATE creature SET spawndist=0, spawntimesecs=60, MovementType=0 WHERE id=33214;
DELETE FROM waypoint_data WHERE id >= 3000000 AND id <= 3000011;
INSERT INTO waypoint_data VALUES (3000000, 6, 435.837, -32.7026, 474.795, 0, 0, 0, 0, 100, 0),(3000000, 5, 380.857, -17.1562, 462.434, 0, 0, 0, 0, 100, 0),(3000000, 4, 352.593, -52.5269, 466.908, 0, 0, 0, 0, 100, 0),(3000000, 3, 315.941, -111.812, 472.977, 0, 0, 0, 0, 100, 0),(3000000, 2, 309.365, -179.063, 472.701, 0, 0, 0, 0, 100, 0),(3000000, 1, 438.186, -182.096, 458.909, 0, 0, 0, 0, 100, 0),(3000001, 7, 209.368, -120.28, 461.253, 0, 0, 0, 0, 100, 0),
(3000001, 6, 188.806, -44.3367, 467.675, 0, 0, 0, 0, 100, 0),(3000001, 1, 190.434, -75.0749, 458.999, 0, 0, 0, 0, 100, 0),(3000001, 4, 100.18, -147.682, 465.067, 0, 0, 0, 0, 100, 0),(3000001, 3, 114.743, -193.488, 465.815, 0, 0, 0, 0, 100, 0),(3000001, 2, 168.787, -194.707, 459.46, 0, 0, 0, 0, 100, 0),(3000001, 5, 133.411, -44.3845, 463.346, 0, 0, 0, 0, 100, 0),(3000002, 1, 262.223, 52.6938, 467.965, 0, 0, 0, 0, 100, 0),
(3000002, 2, 352.412, 71.4091, 467.977, 0, 0, 0, 0, 100, 0),(3000002, 3, 386.308, 67.703, 483.199, 0, 0, 0, 0, 100, 0),(3000002, 4, 359.591, 160.133, 467.741, 0, 0, 0, 0, 100, 0),(3000002, 5, 292.857, 123.865, 469.435, 0, 0, 0, 0, 100, 0),(3000002, 7, 119.211, -11.2325, 462.725, 0, 0, 0, 0, 100, 0),(3000002, 6, 162.358, -7.35092, 465.222, 0, 0, 0, 0, 100, 0),(3000002, 8, 120.14, 16.7521, 462.725, 0, 0, 0, 0, 100, 0),
(3000003, 1, 353.185, -52.9882, 468.924, 0, 0, 0, 0, 100, 0),(3000003, 2, 421.258, -5.06753, 475.078, 0, 0, 0, 0, 100, 0),(3000003, 3, 434.312, -181.615, 456.249, 0, 0, 0, 0, 100, 0),(3000003, 4, 365.765, -188.087, 485.068, 0, 0, 0, 0, 100, 0),(3000003, 5, 307.829, -124.665, 474.297, 0, 0, 0, 0, 100, 0),(3000004, 5, 97.3314, -163.484, 468.105, 0, 0, 0, 0, 100, 0),(3000004, 4, 117.861, -192.851, 471.293, 0, 0, 0, 0, 100, 0),
(3000004, 3, 167.176, -192.7, 458.299, 0, 0, 0, 0, 100, 0),(3000004, 2, 177.431, -62.0815, 458.353, 0, 0, 0, 0, 100, 0),(3000004, 1, 111.637, -50.9356, 469.008, 0, 0, 0, 0, 100, 0),(3000005, 7, 271.856, 52.8627, 468.595, 0, 0, 0, 0, 100, 0),(3000005, 6, 325.237, 141.982, 466.152, 0, 0, 0, 0, 100, 0),(3000005, 1, 199.58, -0.090208, 483.712, 0, 0, 0, 0, 100, 0),(3000005, 2, 108.069, -22.9753, 465.01, 0, 0, 0, 0, 100, 0),
(3000005, 3, 134.818, 34.1543, 468.297, 0, 0, 0, 0, 100, 0),(3000005, 4, 359.298, 76.9651, 478.104, 0, 0, 0, 0, 100, 0),(3000005, 5, 369.548, 141.978, 485.373, 0, 0, 0, 0, 100, 0),(3000006, 5, 347.892, -197.063, 471.291, 0, 0, 0, 0, 100, 0),(3000006, 4, 433.291, -175.11, 450.13, 0, 0, 0, 0, 100, 0),(3000006, 3, 436.96, -19.5668, 483.526, 0, 0, 0, 0, 100, 0),(3000006, 2, 368.296, -30.1429, 468.999, 0, 0, 0, 0, 100, 0),
(3000006, 1, 311.925, -189.324, 476.183, 0, 0, 0, 0, 100, 0),(3000007, 6, 165.252, -47.5813, 460.287, 0, 0, 0, 0, 100, 0),(3000007, 5, 135.867, -41.4607, 462.447, 0, 0, 0, 0, 100, 0),(3000007, 4, 107.794, -121.597, 471.643, 0, 0, 0, 0, 100, 0),(3000007, 3, 102.686, -202.671, 480.898, 0, 0, 0, 0, 100, 0),(3000007, 2, 153.781, -205.013, 464.604, 0, 0, 0, 0, 100, 0),(3000007, 1, 195.618, -131.226, 454.327, 0, 0, 0, 0, 100, 0),
(3000008, 7, 275.574, 57.0993, 458.944, 0, 0, 0, 0, 100, 0),(3000008, 6, 126.269, 14.202, 463.52, 0, 0, 0, 0, 100, 0),(3000008, 5, 116.266, -10.1214, 476.31, 0, 0, 0, 0, 100, 0),(3000008, 4, 175.469, -13.3443, 458.16, 0, 0, 0, 0, 100, 0),(3000008, 3, 330.107, 132.512, 469.691, 0, 0, 0, 0, 100, 0),(3000008, 2, 366.353, 136.739, 467.514, 0, 0, 0, 0, 100, 0),(3000008, 1, 382.068, 80.3032, 478.921, 0, 0, 0, 0, 100, 0),
(3000009, 6, 439.857, -22.9372, 475.943, 0, 0, 0, 0, 100, 0),(3000009, 5, 375.228, -30.1368, 479.225, 0, 0, 0, 0, 100, 0),(3000009, 4, 320.989, -124.66, 475.473, 0, 0, 0, 0, 100, 0),(3000009, 3, 331.726, -183.652, 474.516, 0, 0, 0, 0, 100, 0),(3000009, 2, 438.586, -189.097, 452.426, 0, 0, 0, 0, 100, 0),(3000009, 1, 439.296, -103.702, 452.426, 0, 0, 0, 0, 100, 0),(3000010, 6, 179.497, -52.1641, 465.409, 0, 0, 0, 0, 100, 0),
(3000010, 5, 132.631, -39.8061, 455.354, 0, 0, 0, 0, 100, 0),(3000010, 4, 106.08, -134.022, 465.942, 0, 0, 0, 0, 100, 0),(3000010, 3, 111.962, -197.598, 466.572, 0, 0, 0, 0, 100, 0),(3000010, 2, 171.528, -196.181, 458.215, 0, 0, 0, 0, 100, 0),(3000010, 1, 180.012, -106.13, 457.12, 0, 0, 0, 0, 100, 0),(3000011, 6, 116.441, -20.8694, 457.1, 0, 0, 0, 0, 100, 0),(3000011, 5, 150.811, -23.6075, 457.131, 0, 0, 0, 0, 100, 0),
(3000011, 4, 317.597, 134.312, 471.264, 0, 0, 0, 0, 100, 0),(3000011, 3, 372.945, 133.147, 485.531, 0, 0, 0, 0, 100, 0),(3000011, 2, 370.645, 80.0614, 470.662, 0, 0, 0, 0, 100, 0),(3000011, 1, 202.754, 36.5194, 462.412, 0, 0, 0, 0, 100, 0),(3000011, 7, 124.115, 25.7365, 459.273, 0, 0, 0, 0, 100, 0);
REPLACE INTO creature_model_info VALUES(28830, 0.5, 1.5, 2, 0); -- model size
DELETE FROM vehicle_template_accessory WHERE entry=33214;
INSERT INTO vehicle_template_accessory VALUES(33214, 33218, 1, 0, "Mechanolift 304-A", 6, 30000);

-- Liquid Pyrite (33189)
UPDATE creature_template SET modelid1=28783, modelid2=0, AIName='SmartAI', ScriptName='' WHERE entry=33189;
DELETE FROM smart_scripts WHERE entryorguid IN(33189) AND source_type=0;
INSERT INTO smart_scripts VALUES (33189,0,0,1,8,0,100,0,67390,0,0,0,28,62494,0,0,0,0,0,1,0,0,0,0,0,0,0,'Pyrite - On hit by spell Ride Vehicle - Remove auras from Liquid Pyrite');
INSERT INTO smart_scripts VALUES (33189,0,1,0,61,0,100,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Pyrite - Linked with previous event - Despawn in 15 sec');

-- Pool of Tar (33090)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33090));
DELETE FROM creature WHERE id IN(33090);
REPLACE INTO creature_template_addon VALUES(33090, 0, 0, 0, 1, 0, '62288');
UPDATE creature_template SET AIName='', ScriptName='npc_pool_of_tar' WHERE entry=33090;

-- Ulduar Gauntlet Generator (small radius) (34159)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=34159);
DELETE FROM creature WHERE id=34159;

-- Thorim\'s Hammer Targetting Reticle (33364)
-- Thorim\'s Hammer (33365)
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=2, unit_flags=33554432+2+4, flags_extra=130, AIName='', ScriptName='npc_thorims_hammer' WHERE entry=33364;
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=1, unit_flags=33554432+2, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=33365;

-- Freya's Ward Targetting Reticle (33366)
-- Freya's Ward (33367)
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=2, unit_flags=33554432+2+4, flags_extra=130, AIName='', ScriptName='NullCreatureAI' WHERE entry=33366;
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=1, unit_flags=33554432+2, InhabitType=4, flags_extra=130, AIName='', ScriptName='npc_freya_ward' WHERE entry=33367;

-- Writhing Lasher (33387, 34277)
UPDATE creature_template SET mindmg=2000, maxdmg=2500, attackpower=1, dmg_multiplier=1, unit_flags=unit_flags|131072, baseattacktime=2000, faction=16, speed_run=2.57143, AIName='SmartAI', ScriptName='' WHERE entry=33387;
UPDATE creature_template SET mindmg=4000, maxdmg=5000, attackpower=1, dmg_multiplier=1, unit_flags=unit_flags|131072, baseattacktime=2000, faction=16, speed_run=2.57143, AIName='', ScriptName='' WHERE entry=34277;
DELETE FROM smart_scripts WHERE entryorguid IN(33387, 34277) AND source_type=0;
INSERT INTO smart_scripts VALUES (33387, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 11, 65062, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lash');

-- Ward of Life (34275, 34276)
UPDATE creature_template SET mindmg=6000, maxdmg=8000, attackpower=1, dmg_multiplier=1, unit_flags=unit_flags|131072, baseattacktime=2000, faction=16, speed_run=2.57143, AIName='SmartAI', ScriptName='' WHERE entry=34275;
UPDATE creature_template SET mindmg=24000, maxdmg=30000, attackpower=1, dmg_multiplier=1, unit_flags=unit_flags|131072, baseattacktime=2000, faction=16, speed_run=2.57143, AIName='', ScriptName='' WHERE entry=34276;
DELETE FROM smart_scripts WHERE entryorguid IN(34275, 34276) AND source_type=0;
INSERT INTO smart_scripts VALUES (34275, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 11, 65062, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lash');

-- Mimiron\'s Inferno Targetting Reticle(33369)
-- Mimiron\'s Inferno (33370)
DELETE FROM script_waypoint WHERE entry IN(33369, 33370);
INSERT INTO script_waypoint VALUES(33369, 1, 331.674, -68.6878, 409.804, 0, 0);
INSERT INTO script_waypoint VALUES(33369, 2, 274.578, -92.1829, 409.804, 0, 0);
INSERT INTO script_waypoint VALUES(33369, 3, 226.433, -66.6652, 409.793, 0, 0);
INSERT INTO script_waypoint VALUES(33369, 4, 206.092, -34.7447, 409.801, 0, 0);
INSERT INTO script_waypoint VALUES(33369, 5, 240.208, 1.10346, 409.802, 0, 0);
INSERT INTO script_waypoint VALUES(33369, 6, 337.199, 11.7051, 409.802, 0, 0);
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=2, unit_flags=33554432+2, flags_extra=130, AIName='', ScriptName='npc_mimirons_inferno' WHERE entry=33369;
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=1, unit_flags=33554432+2, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=33370;

-- Hodir's Fury Targetting Reticle (33108)
-- Hodir's Fury (33212)
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=1.5, unit_flags=33554432+2, flags_extra=130, AIName='', ScriptName='npc_hodirs_fury' WHERE entry=33108;
UPDATE creature_template SET modelid1=11686, modelid2=0, minlevel=80, maxlevel=80, scale=1, unit_flags=33554432+2, InhabitType=4, flags_extra=130, AIName='NullCreatureAi', ScriptName='' WHERE entry=33212;




-- ###################
-- ### IGNIS THE FURNACE MASTER
-- ###################

-- Ignis the Furnace Master (33118, 33190)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=5483, maxdmg=7475, attackpower=805, dmg_multiplier=7, baseattacktime=1500, VehicleId=342, AIName='', ScriptName='boss_ignis', flags_extra=1+0x200000, mechanic_immune_mask=650854271 WHERE entry=33118;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=4428, maxdmg=6037, attackpower=805, dmg_multiplier=13, baseattacktime=1500, AIName='', ScriptName='', flags_extra=1+0x200000, mechanic_immune_mask=650854271 WHERE entry=33190;
UPDATE creature_model_info SET combat_reach=8 WHERE modelid=29185;

-- Iron Construct (33121, 33191)
UPDATE creature_template SET speed_run=1.28571, mindmg=1403, maxdmg=1913, attackpower=642, dmg_multiplier=7, unit_flags=33554432, AIName='', ScriptName='npc_ulduar_iron_construct', flags_extra=2+0x200000, mechanic_immune_mask=650854271 WHERE entry=33121;
UPDATE creature_template SET speed_run=1.28571, mindmg=1138, maxdmg=1551, attackpower=642, dmg_multiplier=13, unit_flags=33554432, AIName='', ScriptName='', flags_extra=2+0x200000, mechanic_immune_mask=650854271 WHERE entry=33191;
DELETE FROM smart_scripts WHERE entryorguid IN(33121, 33191) AND source_type=0;
REPLACE creature_template_addon VALUES(33121, 0, 0, 0, 1, 0, ''),(33191, 0, 0, 0, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33121, 33191) AND `map`=603 );

-- Scorched Ground (33123)
REPLACE INTO `creature_template` VALUES (33123, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Scorched Ground', NULL, NULL, 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);

-- spell Activate Construct (62488, 63850)
DELETE FROM spell_script_names WHERE spell_id IN(62488, 63850, -62488, -63850);
DELETE FROM spell_scripts WHERE id IN(62488, 63850, -62488, -63850);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62488, 63850, -62488, -63850) OR spell_effect IN(62488, 63850, -62488, -63850);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62488);
INSERT INTO `conditions` VALUES (13, 1, 62488, 0, 0, 31, 0, 3, 33121, 0, 0, 0, 0, '', 'Activate Construct');
INSERT INTO `conditions` VALUES (13, 1, 62488, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Activate Construct');
INSERT INTO `conditions` VALUES (13, 1, 62488, 0, 0, 1, 0, 38757, 0, 0, 0, 0, 0, '', 'Activate Construct');

-- spell Scorch (62546, 62553, 63474, 63473)
DELETE FROM spell_script_names WHERE spell_id IN(62546, 62553, 63474, 63473, -62546, -62553, -63474, -63473);
DELETE FROM spell_scripts WHERE id IN(62546, 62553, 63474, 63473, -62546, -62553, -63474, -63473);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62546, 62553, 63474, 63473, -62546, -62553, -63474, -63473) OR spell_effect IN(62546, 62553, 63474, 63473, -62546, -62553, -63474, -63473);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62546, 62553, 63474, 63473);
INSERT INTO spell_script_names VALUES(62546, 'spell_ignis_scorch'),(63474, 'spell_ignis_scorch');

-- spell Scorch / Heat (62548, 63476, 62549, 63475, 62343, 65667) -- ground spells
DELETE FROM spell_script_names WHERE spell_id IN(62548, 63476, 62549, 63475, 62343, 65667, -62548, -63476, -62549, -63475, -62343, -65667);
DELETE FROM spell_scripts WHERE id IN(62548, 63476, 62549, 63475, 62343, 65667, -62548, -63476, -62549, -63475, -62343, -65667);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62548, 63476, 62549, 63475, 62343, 65667, -62548, -63476, -62549, -63475, -62343, -65667) OR spell_effect IN(62548, 63476, 62549, 63475, 62343, 65667, -62548, -63476, -62549, -63475, -62343, -65667);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62548, 63476, 62549, 63475, 62343, 65667);
INSERT INTO `conditions` VALUES (13, 1, 62343, 0, 0, 31, 0, 3, 33121, 0, 0, 0, 0, '', 'Heat to Iron Construct');
INSERT INTO `conditions` VALUES (13, 1, 62343, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Heat to Iron Construct');
INSERT INTO `conditions` VALUES (13, 1, 62343, 0, 0, 1, 0, 38757, 0, 0, 1, 0, 0, '', 'Heat to Iron Construct');

-- spell Grab (62707, 62708, 62712, 62711)
DELETE FROM spell_script_names WHERE spell_id IN(62707, 62708, 62712, 62711, -62707, -62708, -62712, -62711);
DELETE FROM spell_scripts WHERE id IN(62707, 62708, 62712, 62711, -62707, -62708, -62712, -62711);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62707, 62708, 62712, 62711, -62707, -62708, -62712, -62711) OR spell_effect IN(62707, 62708, 62712, 62711, -62707, -62708, -62712, -62711);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62707, 62708, 62712, 62711);
INSERT INTO spell_script_names VALUES(62707, 'spell_ignis_grab_initial');
INSERT INTO `conditions` VALUES (13, 1, 62708, 0, 0, 31, 0, 3, 33118, 0, 0, 0, 0, '', 'Grab (Ignis the Furnace Master)');
INSERT INTO `conditions` VALUES (13, 1, 62708, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Grab (Ignis the Furnace Master)');
INSERT INTO `conditions` VALUES (13, 1, 62711, 0, 0, 31, 0, 3, 33118, 0, 0, 0, 0, '', 'Grab (Ignis the Furnace Master)');
INSERT INTO `conditions` VALUES (13, 1, 62711, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Grab (Ignis the Furnace Master)');

-- spell Slag Pot (62717, 65722, 63477, 65723)
DELETE FROM spell_script_names WHERE spell_id IN(62717, 65722, 63477, 65723, -62717, -65722, -63477, -65723);
DELETE FROM spell_scripts WHERE id IN(62717, 65722, 63477, 65723, -62717, -65722, -63477, -65723);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62717, 65722, 63477, 65723, -62717, -65722, -63477, -65723) OR spell_effect IN(62717, 65722, 63477, 65723, -62717, -65722, -63477, -65723);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62717, 65722, 63477, 65723);
INSERT INTO spell_script_names VALUES(62717, 'spell_ignis_slag_pot'),(63477, 'spell_ignis_slag_pot');

-- World Trigger (22515)
INSERT INTO `creature` VALUES (NULL, 22515, 603, 3, 1, 16925, 0, 526.771, 277.796, 360.802, 0, 180, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 22515, 603, 3, 1, 16925, 0, 646.771, 277.796, 360.802, 0, 180, 0, 0, 4120, 0, 0, 0, 0, 0);

-- TC, remove some unused script
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_scorch_ground' AND entry=33221;



-- ###################
-- ### RAZORSCALE
-- ###################

-- Razorscale (33186, 33724)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=5483, maxdmg=7475, attackpower=805, dmg_multiplier=7, baseattacktime=2000, unit_flags=32768+512+256, VehicleId=0, AIName='', MovementType=0, InhabitType=3, HoverHeight=1, ScriptName='boss_razorscale', flags_extra=1+0x200000, mechanic_immune_mask=650854271 WHERE entry=33186;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=4389, maxdmg=5983, attackpower=805, dmg_multiplier=13, baseattacktime=2000, unit_flags=32768+512+256, AIName='', MovementType=0, InhabitType=3, HoverHeight=1, ScriptName='', flags_extra=1+0x200000, mechanic_immune_mask=650854271 WHERE entry=33724;
REPLACE INTO creature_template_addon VALUES(33186, 1376110, 0, 50331648, 1, 0, ''),(33724, 1376110, 0, 50331648, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33186, 33724) AND `map`=603 );
UPDATE creature SET position_x=588, position_y=-178, position_z=490, orientation=1.6, MovementType=2 WHERE id=33186;
UPDATE creature_model_info SET bounding_radius=1.5, combat_reach=15 WHERE modelid=28787;
DELETE FROM waypoint_data WHERE id=1376110;
INSERT INTO waypoint_data VALUES (1376110, 1, 557.405, -226.27, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 2, 553.961, -245.751, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 3, 553.842, -259.717, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 4, 557.918, -283.843, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 5, 563.329, -298.023, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 6, 570.578, -309.987, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 7, 584.528, -327.109, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 8, 604.781, -340.894, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 9, 626.663, -344.172, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 10, 649.291, -338.63, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 11, 670.584, -329.016, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 12, 687.285, -312.797, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 13, 700.593, -290.842, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 14, 707.624, -269.877, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 15, 708.113, -248.884, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 16, 704.759, -229.372, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 17, 695.29, -213.26, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 18, 680.557, -198.329, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 19, 664.481, -188.863, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 20, 640.859, -182.553, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 21, 616.472, -180.288, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 22, 588.751, -183.788, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 23, 564.317, -191.504, 491.622, 0, 0, 0, 0, 100, 0),(1376110, 24, 568.326, -209.674, 491.622, 0, 0, 0, 0, 100, 0);

-- Expedition Commander (33210, 34254)
UPDATE creature_template SET npcflag=1, unit_flags=131078+512+256, AIName='', ScriptName='npc_ulduar_expedition_commander' WHERE entry=33210;
UPDATE creature_template SET npcflag=1, unit_flags=131078+512+256, AIName='', ScriptName='' WHERE entry=34254;
DELETE FROM smart_scripts WHERE entryorguid IN(33210, 34254) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33210, 34254);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33210, 34254) AND `map`=603 );
REPLACE INTO npc_text VALUES (40100, 'Welcome, champions! All of our attempts at grounding her have failed. We could use a hand in bringing her down with these harpoon guns.', 'Welcome, champions! All of our attempts at grounding her have failed. We could use a hand in bringing her down with these harpoon guns.', 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=33210;
INSERT INTO creature_text VALUES (33210, 0, 0, 'Welcome, champions! All of our attempts at grounding her have failed. We could use a hand in bring her down with these harpoon guns.', 12, 0, 100, 0, 0, 15647, 0, 'Expedition Commander SAY_COMMANDER_INTRO');
INSERT INTO creature_text VALUES (33210, 1, 0, 'Move quickly! She won''t remain grounded for long!', 14, 0, 100, 0, 0, 15648, 0, 'Expedition Commander SAY_COMMANDER_GROUND');
INSERT INTO creature_text VALUES (33210, 2, 0, 'Be on the lookout! Mole machines will be surfacing soon with those nasty Iron dwarves aboard!', 14, 0, 100, 0, 0, 0, 0, 'Expedition Commander SAY_COMMANDER_AGGRO');

-- Expedition Engineer (33287, 34256)
UPDATE creature_template SET speed_walk=2.5, speed_run=1.14, unit_flags=131074+512+256, AIName='', ScriptName='npc_ulduar_expedition_engineer', flags_extra=2 WHERE entry=33287;
UPDATE creature_template SET speed_walk=2.5, speed_run=1.14, unit_flags=131074+512+256, AIName='', ScriptName='', flags_extra=2 WHERE entry=34256;
DELETE FROM smart_scripts WHERE entryorguid IN(33287, 34256) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33287, 34256);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33287, 34256) AND `map`=603 );

-- Expedition Defender (33816, 34255)
UPDATE creature_template SET unit_flags=131078, AIName='NullCreatureAI', ScriptName='' WHERE entry=33816;
UPDATE creature_template SET unit_flags=131078, AIName='', ScriptName='' WHERE entry=34255;
DELETE FROM smart_scripts WHERE entryorguid IN(33816, 34255) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(33816, 0, 0, 0, 1, 333, ''),(34255, 0, 0, 0, 1, 333, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33816, 34255) AND `map`=603 );

-- Expedition Trapper (33259, 34257)
UPDATE creature_template SET unit_flags=131078, AIName='NullCreatureAI', ScriptName='' WHERE entry=33259;
UPDATE creature_template SET unit_flags=131078, AIName='', ScriptName='' WHERE entry=34257;
DELETE FROM smart_scripts WHERE entryorguid IN(33259, 34257) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(33259, 0, 0, 0, 1, 333, ''),(34257, 0, 0, 0, 1, 333, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33259, 34257) AND `map`=603 );

-- Razorscale Controller (33233)
UPDATE creature_template SET flags_extra=130, ScriptName='' WHERE entry=33233;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33233) AND `map`=603 );
DELETE FROM creature WHERE id IN(33233) AND `map`=603;

-- Harpoon Gun (194519, 194541, 194542, 194543)
REPLACE INTO gameobject_template VALUES (194519, 10, 8245, 'Harpoon Gun', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 1635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_ulduar_working_harpoon', 0);
REPLACE INTO gameobject_template VALUES (194541, 10, 8245, 'Harpoon Gun', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 1635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_ulduar_working_harpoon', 0);
REPLACE INTO gameobject_template VALUES (194542, 10, 8245, 'Harpoon Gun', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 1635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_ulduar_working_harpoon', 0);
REPLACE INTO gameobject_template VALUES (194543, 10, 8245, 'Harpoon Gun', '', '', '', 0, 32, 1, 0, 0, 0, 0, 0, 0, 1635, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_ulduar_working_harpoon', 0);
DELETE FROM event_scripts WHERE id=20964;

-- Ulduar Raid - Razorscale - Broken Harpoon (194565)
REPLACE INTO gameobject_template VALUES (194565, 10, 8631, 'Ulduar Raid - Razorscale - Broken Harpoon', '', '', '', 0, 48, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0);
DELETE FROM gameobject WHERE id=194565;
INSERT INTO gameobject VALUES(NULL, 194565, 603, 3, 1, 571.947, -136.012, 391.517, 2.28638, 0, 0, 0, 1, 600, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 194565, 603, 3, 1, 589.923, -133.622, 391.897, -2.9845, 0, 0, 0, 1, 600, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 194565, 603, 2, 1, 581, -134.7, 391.5, 4.7, 0, 0, 0, 1, 600, 255, 1, 0);
INSERT INTO gameobject VALUES(NULL, 194565, 603, 2, 1, 600, -136, 391.5, 4.7, 0, 0, 0, 1, 600, 255, 1, 0);

-- Razorscale Harpoon Fire State (33282)
UPDATE creature_template SET modelid1=169, modelid2=11686, unit_flags=33554436, flags_extra=130, AIName='', ScriptName='npc_ulduar_harpoonfirestate', flags_extra=2 WHERE entry=33282;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33282) AND `map`=603 );
DELETE FROM creature WHERE id IN(33282) AND `map`=603;
INSERT INTO creature VALUES(NULL, 33282, 603, 3, 3, 0, 0, 571.947, -136.012, 391.517, 5.06733, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(NULL, 33282, 603, 3, 3, 0, 0, 589.923, -133.622, 391.897, 5.06733, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(NULL, 33282, 603, 2, 3, 0, 0, 581, -134.7, 391.5, 5.06733, 300, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(NULL, 33282, 603, 2, 3, 0, 0, 600, -136, 391.5, 5.06733, 300, 0, 0, 12600, 0, 0, 0, 0, 0);

-- Stormforged Mole Machine (195305)
REPLACE INTO gameobject_template VALUES (195305, 1, 7510, 'Stormforged Mole Machine', 'Point', '', '', 0, 0, 0.6, 0, 0, 0, 0, 0, 0, 1, 95, 8000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0);

-- Razorscale Devouring Flame Stalker (34188, 34189)
UPDATE creature_template SET modelid1=169, modelid2=11686, unit_flags=33554432+4, AIName='NullCreatureAI', ScriptName='', flags_extra=130 WHERE entry=34188;
UPDATE creature_template SET modelid1=169, modelid2=11686, unit_flags=33554432+4, AIName='', ScriptName='', flags_extra=130 WHERE entry=34189;
DELETE FROM smart_scripts WHERE entryorguid IN(34188, 34189) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(34188, 0, 0, 0, 1, 0, '64709'),(34189, 0, 0, 0, 1, 0, '64734');

-- Dark Rune Sentinel (33846, 33852)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=2262, maxdmg=3084, attackpower=624, dmg_multiplier=5, AIName='', ScriptName='npc_ulduar_dark_rune_sentinel', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33846;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=1827, maxdmg=2491, attackpower=624, dmg_multiplier=10, AIName='', ScriptName='', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33852;
DELETE FROM smart_scripts WHERE entryorguid IN(33846, 33852) AND source_type=0;

-- Dark Rune Guardian (33388, 33850)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=2262, maxdmg=3084, attackpower=624, dmg_multiplier=2.5, AIName='', ScriptName='npc_ulduar_dark_rune_guardian', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33388;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=1827, maxdmg=2491, attackpower=624, dmg_multiplier=5, AIName='', ScriptName='', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33850;
DELETE FROM smart_scripts WHERE entryorguid IN(33388, 33850) AND source_type=0;

-- Dark Rune Watcher (33453, 33851)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=1700, maxdmg=2312, attackpower=287, dmg_multiplier=4, AIName='', ScriptName='npc_ulduar_dark_rune_watcher', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33453;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=1343, maxdmg=1828, attackpower=287, dmg_multiplier=7, AIName='', ScriptName='', flags_extra=0+0x200000, mechanic_immune_mask=617299839 WHERE entry=33851;
DELETE FROM smart_scripts WHERE entryorguid IN(33453, 33851) AND source_type=0;

-- spell Harpoon Shot (62505, 49679, 49682, 49683, 49684)
DELETE FROM spell_script_names WHERE spell_id IN(62505, 49679, 49682, 49683, 49684, -62505, -49679, -49682, -49683, -49684);
DELETE FROM spell_scripts WHERE id IN(62505, 49679, 49682, 49683, 49684, -62505, -49679, -49682, -49683, -49684);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62505, 49679, 49682, 49683, 49684, -62505, -49679, -49682, -49683, -49684) OR spell_effect IN(62505, 49679, 49682, 49683, 49684, -62505, -49679, -49682, -49683, -49684);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62505, 49679, 49682, 49683, 49684) AND ElseGroup=0;
INSERT INTO `conditions` VALUES (13, 1, 62505, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Harpoon Trigger - Razorscale');
INSERT INTO `conditions` VALUES (13, 1, 49679, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Harpoon Trigger - Razorscale');
INSERT INTO `conditions` VALUES (13, 1, 49682, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Harpoon Trigger - Razorscale');
INSERT INTO `conditions` VALUES (13, 1, 49683, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Harpoon Trigger - Razorscale');
INSERT INTO `conditions` VALUES (13, 1, 49684, 0, 0, 31, 0, 3, 33186, 0, 0, 0, 0, '', 'Harpoon Trigger - Razorscale');

-- spell Flame Breath (63317, 64021)
DELETE FROM spell_script_names WHERE spell_id IN(63317, 64021, -63317, -64021);
DELETE FROM spell_scripts WHERE id IN(63317, 64021, -63317, -64021);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63317, 64021, -63317, -64021) OR spell_effect IN(63317, 64021, -63317, -64021);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63317, 64021);
INSERT INTO `conditions` VALUES (13, 3, 63317, 0, 0, 31, 0, 3, 33388, 0, 0, 0, 0, '', 'Flame Breath - Dark Rune Guardian');
INSERT INTO `conditions` VALUES (13, 3, 63317, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Flame Breath - Players');
INSERT INTO `conditions` VALUES (13, 3, 64021, 0, 0, 31, 0, 3, 33388, 0, 0, 0, 0, '', 'Flame Breath - Dark Rune Guardian');
INSERT INTO `conditions` VALUES (13, 3, 64021, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Flame Breath - Players');

-- spell Fuse Armor (64821, 64771, 64774)
DELETE FROM spell_script_names WHERE spell_id IN(64821, 64771, 64774, -64821, -64771, -64774);
DELETE FROM spell_scripts WHERE id IN(64821, 64771, 64774, -64821, -64771, -64774);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64821, 64771, 64774, -64821, -64771, -64774) OR spell_effect IN(64821, 64771, 64774, -64821, -64771, -64774);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64821, 64771, 64774);

-- TC, remove some unused script
UPDATE creature_template SET ScriptName='' WHERE ScriptName='npc_mole_machine_trigger' AND entry=33245;
DELETE FROM spell_script_names WHERE ScriptName='spell_razorscale_devouring_flame' AND spell_id=63308;


-- ###################
-- ### XT-002 DECONSTRUCTOR
-- ###################
DELETE FROM waypoint_data WHERE id=1360540;
INSERT INTO waypoint_data VALUES (1360540, 1, 886, -12, 409.61, 0, 0, 0, 1360540, 100, 0),(1360540, 2, 882.301, -6.0571, 409.696, 0, 0, 0, 0, 100, 0),(1360540, 3, 880.469, -2.48102, 409.672, 0, 0, 0, 0, 100, 0),(1360540, 4, 878.951, 2.99208, 409.743, 0, 0, 0, 0, 100, 0),(1360540, 5, 878.021, 9.92695, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 6, 878.026, 16.9198, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 7, 879.128, 23.3453, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 8, 881.392, 29.962, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 9, 884.406, 36.2775, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 10, 885.976, 39.4054, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 11, 889.117, 45.6612, 409.466, 0, 0, 0, 0, 100, 0),(1360540, 12, 892.528, 52.455, 409.789, 0, 0, 0, 0, 100, 0),(1360540, 13, 892.528, 52.455, 409.789, 0, 10000, 0, 0, 100, 0),(1360540, 14, 888.227, 46.9321, 409.678, 0, 0, 0, 0, 100, 0),(1360540, 15, 883.926, 41.4093, 409.761, 0, 0, 0, 0, 100, 0),(1360540, 16, 881.776, 38.6479, 409.803, 0, 0, 0, 0, 100, 0),
(1360540, 17, 877.651, 32.9953, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 18, 874.352, 27.0137, 409.746, 0, 0, 0, 0, 100, 0),(1360540, 19, 871.819, 20.4899, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 20, 870.181, 14.3928, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 21, 869.496, 7.43019, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 22, 869.429, 0.431764, 409.775, 0, 0, 0, 0, 100, 0),(1360540, 23, 869.62, -6.56557, 409.778, 0, 0, 0, 0, 100, 0),(1360540, 24, 869.758, -17.0646, 409.758, 0, 0, 0, 0, 100, 0),(1360540, 25, 869.827, -24.0643, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 26, 869.895, -31.064, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 27, 870.138, -38.0567, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 28, 870.87, -43.4873, 409.547, 0, 0, 0, 0, 100, 0),(1360540, 29, 873.139, -49.9758, 409.801, 0, 0, 0, 0, 100, 0),
(1360540, 30, 876.169, -55.7767, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 31, 880.209, -61.4922, 409.746, 0, 0, 0, 0, 100, 0),(1360540, 32, 884.487, -67.032, 409.433, 0, 0, 0, 0, 100, 0),(1360540, 33, 886.681, -69.7592, 409.759, 0, 0, 0, 0, 100, 0),(1360540, 34, 889.945, -73.8173, 409.803, 0, 0, 0, 0, 100, 0),(1360540, 35, 889.945, -73.8173, 409.803, 0, 10000, 0, 0, 100, 0),(1360540, 36, 886.928, -67.5011, 409.772, 0, 0, 0, 0, 100, 0),(1360540, 37, 884.15, -61.0813, 409.779, 0, 0, 0, 0, 100, 0),(1360540, 38, 882.272, -54.3456, 409.802, 0, 0, 0, 0, 100, 0),(1360540, 39, 881.223, -47.4286, 409.802, 0, 0, 0, 0, 100, 0),(1360540, 40, 880.83, -40.4413, 409.778, 0, 0, 0, 0, 100, 0),(1360540, 41, 880.798, -36.9421, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 42, 881.447, -29.9804, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 43, 882.644, -23.0835, 409.804, 0, 0, 0, 0, 100, 0),(1360540, 44, 884.475, -16.3332, 409.802, 0, 0, 0, 0, 100, 0),(1360540, 45, 886.234, -12.8022, 409.653, 0, 0, 0, 0, 100, 0),(1360540, 46, 886, -12, 409.61, 3.14159, 30000, 0, 1360541, 100, 0);
DELETE FROM waypoint_scripts WHERE id IN(1360540, 1360541);
INSERT INTO waypoint_scripts VALUES (1360540, 0, 1, 468, 1, 0, 0, 0, 0, 0, 5);
INSERT INTO waypoint_scripts VALUES (1360541, 0, 1, 401, 0, 0, 0, 0, 0, 0, 6);

-- XT-002 (33293, 33885)
UPDATE creature_template SET speed_walk=2.8, speed_run=1.71429, mindmg=5483, maxdmg=7475, attackpower=805, dmg_multiplier=7, baseattacktime=1800, mingold=1724850, maxgold=1724850, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_xt002' WHERE entry=33293;
UPDATE creature_template SET speed_walk=2.8, speed_run=1.71429, mindmg=4389, maxdmg=5983, attackpower=805, dmg_multiplier=13, baseattacktime=1800, mingold=1724850, maxgold=1724850, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33885;
UPDATE creature_model_info SET combat_reach=10 WHERE modelid=28611;
DELETE FROM vehicle_template_accessory WHERE entry=33293;

-- XT Heart (33329, 33995)
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_xt002_heart' WHERE entry=33329;
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33995;

-- Void Zone Trigger (34001)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=34001;

-- Life Spark (34004)
UPDATE creature_template SET mindmg=8000, maxdmg=10000, dmg_multiplier=1, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_xt002_life_spark' WHERE entry=34004;

-- XT-Toy Pile (33337)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33337);
DELETE FROM creature WHERE id=33337;
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=33337;

-- XS-013 Scrapbot (33343, 33887)
UPDATE creature_template SET speed_walk=1.2, speed_run=0.42857, AIName='', ScriptName='npc_xt002_scrapbot' WHERE entry=33343;
UPDATE creature_template SET speed_walk=1.2, speed_run=0.42857, AIName='', ScriptName='' WHERE entry=33887;

-- XM-024 Pummeller (33344, 33888)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1701, maxdmg=2319, attackpower=625, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_xt002_pummeller' WHERE entry=33344;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1342, maxdmg=1830, attackpower=625, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33888;

-- XE-321 Boombot (33346, 33886)
UPDATE creature_template SET speed_walk=1.2, speed_run=0.42857, mindmg=15000, maxdmg=17000, dmg_multiplier=1, mechanic_immune_mask=583744347, AIName='', ScriptName='npc_xt002_boombot' WHERE entry=33346;
UPDATE creature_template SET speed_walk=1.2, speed_run=0.42857, mindmg=15000, maxdmg=17000, dmg_multiplier=1.5, mechanic_immune_mask=583744347 WHERE entry=33886;

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62826);
INSERT INTO conditions VALUES (13, 4, 62826, 0, 0, 31, 0, 3, 33337, 0, 0, 0, 0, '', 'Energy Orb - Pile Trigger');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62834);
INSERT INTO conditions VALUES (13, 1, 62834, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Boom - Attack players');
INSERT INTO conditions VALUES (13, 1, 62834, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Boom - Attack npcs');

DELETE FROM spell_script_names WHERE spell_id IN(62775, 63024, 64234, 63025, 64233, 63018, 65121);
INSERT INTO spell_script_names VALUES (62775, 'spell_xt002_tympanic_tantrum');
INSERT INTO spell_script_names VALUES (63024, 'spell_xt002_gravity_bomb_aura');
INSERT INTO spell_script_names VALUES (64234, 'spell_xt002_gravity_bomb_aura');
INSERT INTO spell_script_names VALUES (63025, 'spell_xt002_gravity_bomb_damage');
INSERT INTO spell_script_names VALUES (64233, 'spell_xt002_gravity_bomb_damage');
INSERT INTO spell_script_names VALUES (63018, 'spell_xt002_searing_light_spawn_life_spark');
INSERT INTO spell_script_names VALUES (65121, 'spell_xt002_searing_light_spawn_life_spark');

-- TC, Remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName IN('spell_xt002_submerged', 'spell_xt002_stand', 'spell_xt002_heart_overload_periodic');


-- ###################
-- ### ASSEMBLY OF IRON
-- ###################

-- Archivum Doors (194556)
UPDATE gameobject SET state=1 WHERE id=194556;

-- Stormcaller Brundir (32857, 33694)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=3912, maxdmg=5339, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mingold=1717186, maxgold=1717186, mechanic_immune_mask=617297759, flags_extra=1+0x200000, AIName='', ScriptName='boss_stormcaller_brundir' WHERE entry=32857;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=3118, maxdmg=4255, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mingold=1717186, maxgold=1717186, mechanic_immune_mask=617297759, flags_extra=1+0x200000 WHERE entry=33694;

-- Steelbreaker (32867, 33693)
UPDATE creature_template SET speed_walk=0.888888, speed_run=1.5873, mindmg=3634, maxdmg=4954, attackpower=805, dmg_multiplier=7, baseattacktime=1500, mingold=1717186, maxgold=1717186, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_steelbreaker' WHERE entry=32867;
UPDATE creature_template SET speed_walk=0.888888, speed_run=1.5873, mindmg=5152, maxdmg=7024, attackpower=805, dmg_multiplier=11, baseattacktime=1500, mingold=1717186, maxgold=1717186, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33693;
UPDATE creature_model_info SET combat_reach=8 WHERE modelid=28344;

-- Runemaster Molgeim (32927, 33692)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.28571, mindmg=3912, maxdmg=5339, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mingold=1717186, maxgold=1717186, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_runemaster_molgeim' WHERE entry=32927;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.28571, mindmg=3118, maxdmg=4255, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mingold=1717186, maxgold=1717186, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33692;
UPDATE creature_model_info SET combat_reach=5 WHERE modelid=28381;

-- Lightning Elemental (32958)
UPDATE creature_template SET unit_flags= 0, AIName='', ScriptName='npc_assembly_lightning' WHERE entry=32958;

-- Rune of Summoning (33051)
UPDATE creature_template SET unit_flags=33554432+262144+2, AIName='NullCreatureAI', ScriptName='', flags_extra=2 WHERE entry=33051;
REPLACE INTO creature_template_addon VALUES(33051, 0, 0, 0, 0, 0, '62019');

-- Rune of Power (33705)
UPDATE creature_template SET unit_flags=33554432+262144+2, AIName='NullCreatureAI', ScriptName='', flags_extra=2 WHERE entry=33705;
REPLACE INTO creature_template_addon VALUES(33705, 0, 0, 0, 0, 0, '61974');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(61920);
INSERT INTO conditions VALUES (13, 7, 61920, 0, 0, 31, 0, 3, 32867, 0, 0, 0, 0, '', 'Supercharge - target others');
INSERT INTO conditions VALUES (13, 7, 61920, 0, 1, 31, 0, 3, 32927, 0, 0, 0, 0, '', 'Supercharge - target others');
INSERT INTO conditions VALUES (13, 7, 61920, 0, 2, 31, 0, 3, 32857, 0, 0, 0, 0, '', 'Supercharge - target others');
INSERT INTO conditions VALUES (13, 7, 61920, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Super Charge - target others');
INSERT INTO conditions VALUES (13, 7, 61920, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Super Charge - target others');
INSERT INTO conditions VALUES (13, 7, 61920, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Super Charge - target others');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64320);
INSERT INTO conditions VALUES (13, 1, 64320, 0, 0, 31, 0, 3, 33705, 0, 1, 0, 0, '', 'Rune of Power - target npcs');
INSERT INTO conditions VALUES (13, 1, 64320, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Rune of Power - target players');

DELETE FROM spell_script_names WHERE spell_id IN(62274, 63489, 61889, 62019);
INSERT INTO spell_script_names VALUES (62274, 'spell_shield_of_runes');
INSERT INTO spell_script_names VALUES (63489, 'spell_shield_of_runes');
INSERT INTO spell_script_names VALUES (61889, 'spell_assembly_meltdown');
INSERT INTO spell_script_names VALUES (62019, 'spell_assembly_rune_of_summoning');

-- SPELL Rune of Power (61975), used out of combat
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61975;
INSERT INTO conditions VALUES (13, 1, 61975, 0, 0, 31, 0, 3, 32867, 0, 0, 0, 0, '', 'Target Steelbreaker');

-- SPELL Lightning Channel Pre-fight Visual (61942), used out of combat
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61942;
INSERT INTO conditions VALUES (13, 1, 61942, 0, 0, 31, 0, 3, 32867, 0, 0, 0, 0, '', 'Target Steelbreaker');

-- High Voltage
DELETE FROM spelldifficulty_dbc WHERE spellid0=61890 OR spellid1=63498;
DELETE FROM spelldifficulty_dbc WHERE spellid0=61980;



-- ###################
-- ### KOLOGARN
-- ###################

DELETE FROM creature_text WHERE entry=32930;
INSERT INTO creature_text VALUES (32930, 0, 0, 'None shall pass!', 14, 0, 100, 0, 0, 15586, 0, 'Kologarn SAY_AGGRO');
INSERT INTO creature_text VALUES (32930, 1, 0, 'KOL-THARISH!', 14, 0, 100, 0, 0, 15587, 0, 'Kologarn SAY_SLAY_1');
INSERT INTO creature_text VALUES (32930, 1, 1, 'YOU FAIL!', 14, 0, 100, 0, 0, 15588, 0, 'Kologarn SAY_SLAY_2');
INSERT INTO creature_text VALUES (32930, 2, 0, 'Just a scratch!', 14, 0, 100, 0, 0, 15589, 0, 'Kologarn SAY_LEFT_ARM_GONE');
INSERT INTO creature_text VALUES (32930, 3, 0, 'Only a flesh wound!', 14, 0, 100, 0, 0, 15590, 0, 'Kologarn SAY_RIGHT_ARM_GONE');
INSERT INTO creature_text VALUES (32930, 4, 0, 'OBLIVION!', 14, 0, 100, 0, 0, 15591, 0, 'Kologarn SAY_SHOCKWAVE');
INSERT INTO creature_text VALUES (32930, 5, 0, 'I will squeeze the life from you!', 14, 0, 100, 0, 0, 15592, 0, 'Kologarn SAY_GRAB_PLAYER');
INSERT INTO creature_text VALUES (32930, 6, 0, 'Master, they come....', 14, 0, 100, 0, 0, 15593, 0, 'Kologarn SAY_DEATH');
INSERT INTO creature_text VALUES (32930, 7, 0, 'I am invincible!', 14, 0, 100, 0, 0, 15594, 0, 'Kologarn SAY_BERSERK');
INSERT INTO creature_text VALUES (32930, 8, 0, 'Kologarn casts Stone Grip!', 41, 0, 100, 0, 0, 0, 0, 'Kologarn EMOTE_STONE_GRIP');
INSERT INTO creature_text VALUES (32930, 9, 0, 'Kologarn focuses his eyes on you!', 41, 0, 100, 0, 0, 0, 0, 'Kologarn EMOTE_EYES');

UPDATE creature_model_info SET combat_reach = 22 WHERE modelid IN (28821, 28822, 28638);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34297, 32933, 32934, 33661, 33632, 33802, 33809, 33742));
DELETE FROM creature WHERE id IN(34297, 32933, 32934, 33661, 33632, 33802, 33809, 33742);
INSERT INTO creature VALUES(NULL, 33661, 603, 3, 1, 11686, 0, 1770.7, -61.6, 448.81, 1.584, 180, 0, 0, 26066, 0, 0, 0, 0, 0);

DELETE FROM conditions WHERE SourceEntry IN(63766, 63983, 63352, 63676, 62056, 63985, 64224, 64225, 63979, 63629) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 3, 63766, 0, 0, 31, 0, 3, 33661, 0, 0, 0, 0, '', ''),(13, 3, 63983, 0, 0, 31, 0, 3, 33661, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 63352, 0, 0, 31, 0, 3, 33632, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 63676, 0, 0, 31, 0, 3, 32930, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 63629, 0, 0, 31, 0, 3, 32930, 0, 0, 0, 0, '', ''),(13, 1, 63979, 0, 0, 31, 0, 3, 32930, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 62056, 0, 0, 31, 0, 3, 32934, 0, 0, 0, 0, '', ''),(13, 1, 63985, 0, 0, 31, 0, 3, 32934, 0, 0, 0, 0, '', '');

-- Kologarn
REPLACE INTO npc_spellclick_spells VALUES(32930, 65343, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry=32930;
UPDATE creature_template SET mindmg=7185, maxdmg=9796, attackpower=805, dmg_multiplier=7, baseattacktime=2000, vehicleId=328, unit_flags=4, InhabitType=3, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_kologarn' WHERE entry IN(32930);
UPDATE creature_template SET mindmg=4805, maxdmg=6551, attackpower=805, dmg_multiplier=13, baseattacktime=2000, vehicleId=328, unit_flags=4, InhabitType=3, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry IN(33909);

-- Left Arm
UPDATE creature_template SET InhabitType=3, mechanic_immune_mask=650854271, flags_extra=0+0x200000+0x40000, AIName='', ScriptName='boss_kologarn_arms' WHERE entry IN(32933);
UPDATE creature_template SET InhabitType=3, mechanic_immune_mask=650854271, flags_extra=0+0x200000+0x40000 WHERE entry IN(33910);

-- Right Arm
UPDATE creature_template SET InhabitType=3, mechanic_immune_mask=650854271, flags_extra=0+0x200000+0x40000, AIName='', ScriptName='boss_kologarn_arms' WHERE entry IN(32934);
UPDATE creature_template SET InhabitType=3, mechanic_immune_mask=650854271, flags_extra=0+0x200000+0x40000 WHERE entry IN(33911);

-- Eyebeams
UPDATE creature_template SET InhabitType=3, flags_extra=0, modelid1=11686, modelid2=0, unit_flags=33685504, AIName='', ScriptName='boss_kologarn_eyebeam' WHERE entry IN(33632, 33802);
UPDATE creature_template SET InhabitType=3, flags_extra=0, modelid1=11686, modelid2=0, unit_flags=33685504, AIName='', ScriptName='' WHERE entry IN(33906, 33907);

-- Rubble
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(33768);
DELETE FROM smart_scripts WHERE entryorguid IN(33768, 33908) AND source_type=0;
INSERT INTO smart_scripts VALUES (33768, 0, 0, 0, 60, 0, 100, 2, 4000, 7000, 8000, 14000, 11, 63818, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Rubble attack');
INSERT INTO smart_scripts VALUES (33768, 0, 1, 0, 60, 0, 100, 4, 4000, 7000, 8000, 14000, 11, 63978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Rubble attack');

DELETE FROM spell_script_names WHERE spell_id IN(62166,63981,63633,65594,62056,63985,64224,64225,64702,63720,64004,63342,63716,64005);
INSERT INTO spell_script_names VALUES (62166, 'spell_ulduar_stone_grip_cast_target');
INSERT INTO spell_script_names VALUES (63981, 'spell_ulduar_stone_grip_cast_target');
INSERT INTO spell_script_names VALUES (62056, 'spell_ulduar_stone_grip');
INSERT INTO spell_script_names VALUES (63985, 'spell_ulduar_stone_grip');
INSERT INTO spell_script_names VALUES (64702, 'spell_ulduar_squeezed_lifeless');
INSERT INTO spell_script_names VALUES (63716, 'spell_kologarn_stone_shout');
INSERT INTO spell_script_names VALUES (64005, 'spell_kologarn_stone_shout');
INSERT INTO spell_script_names VALUES (63720, 'spell_kologarn_stone_shout');
INSERT INTO spell_script_names VALUES (64004, 'spell_kologarn_stone_shout');

-- Armsweep Stalker Kologarn (33661)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=33661;

-- delete Cache of Living Stone, spawned manually
DELETE FROM gameobject WHERE id IN(195046,195047);



-- ###################
-- ### AURIAYA
-- ###################

-- Spell: Strength of the Pack (64381)
DELETE FROM spell_script_names WHERE spell_id=64381;
DELETE FROM conditions WHERE SourceEntry IN(64449, 64381) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64449, 0, 0, 31, 0, 3, 34096, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 64381, 0, 0, 31, 0, 3, 34014, 0, 0, 0, 0, '', '');

-- Auriaya (33515, 34175)
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=5552, maxdmg=7577, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mingold=1366181, maxgold=1366181, mechanic_immune_mask=617299839, flags_extra=1+0x200000, AIName='', ScriptName='boss_auriaya' WHERE entry=33515;
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=4301, maxdmg=5868, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mingold=1366181, maxgold=1366181, mechanic_immune_mask=617299839, flags_extra=1+0x200000 WHERE entry=34175;
UPDATE creature_model_info SET combat_reach=6 WHERE modelid=28651;

-- Sanctum Sentry (34014, 34166)
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id IN(34014));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34014));
DELETE FROM creature WHERE id IN(34014);
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=2760, maxdmg=3762, attackpower=805, dmg_multiplier=7, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_auriaya_sanctum_sentry' WHERE entry=34014;
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=1614, maxdmg=2201, attackpower=805, dmg_multiplier=13, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=34166;

-- Feral Defender (34035, 34171)
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id IN(34035));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34035));
DELETE FROM creature WHERE id IN(34035);
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=900, maxdmg=1200, attackpower=1, dmg_multiplier=1, dmgschool=5, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_auriaya_feral_defender' WHERE entry=34035;
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=2500, maxdmg=3000, attackpower=1, dmg_multiplier=1, dmgschool=5, baseattacktime=1500, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=34171;

-- Swarming Guardian (34034, 34169)
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=600, maxdmg=818, attackpower=702, dmg_multiplier=1, baseattacktime=1500, AIName='', ScriptName='' WHERE entry=34034;
UPDATE creature_template SET speed_walk=1.66667, speed_run=1.14286, mindmg=600, maxdmg=818, attackpower=702, dmg_multiplier=1.5, baseattacktime=1500, AIName='' WHERE entry=34169;

-- Auriaya Seeping Essence Stalker (34098, 34174)
-- Auriaya Feral Defender Stalker (34096)
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id IN(34096));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34096));
DELETE FROM creature WHERE id IN(34096);
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128, ScriptName='' WHERE entry=34096;
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', flags_extra=128, ScriptName='' WHERE entry=34098;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128 WHERE entry=34174;
REPLACE INTO creature_template_addon VALUES(34098, 0, 0, 0, 0, 0, '64458');
REPLACE INTO creature_template_addon VALUES(34174, 0, 0, 0, 0, 0, '64676');
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 2035.43, -74.8985, 411.356, 4.46578, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 2057.19, -24.6387, 421.531, 3.64112, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 2036.14, 21.2396, 411.359, 6.13475, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1940.24, -90.7078, 411.357, 2.65151, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1905.12, -46.6376, 417.759, 2.23133, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1907.56, -0.803589, 417.734, 1.06501, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1990.83, 49.5323, 417.724, 6.13475, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1940.04, 43.3955, 411.353, 6.13475, 300, 0, 0, 39099, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 34096, 603, 3, 1, 0, 0, 1992.16, -99.9681, 417.724, 3.07563, 300, 0, 0, 39099, 0, 0, 0, 0, 0);



-- ###################
-- ### FREYA
-- ###################

-- Strengthened Iron Roots Summon Effect (65158)
DELETE FROM spell_script_names WHERE ScriptName='spell_freya_iron_roots' AND spell_id IN(65158, 65160);

-- Attuned to Nature x Dose Reduction (62521) (62524) (62525)
DELETE FROM spell_script_names WHERE ScriptName='spell_freya_attuned_to_nature_dose_reduction' AND spell_id IN(62521, 62524, 62525);

-- Unstable Energy (62217)
-- Unstable Energy (62922)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62217, 62922, -62217, -62922);
INSERT INTO spell_linked_spell VALUES(62217, -62243, 1, "Remove unstable sun beam");
INSERT INTO spell_linked_spell VALUES(62922, -62243, 1, "Remove unstable sun beam");

-- Brightleaf's Essence (62968)
-- Ironbranch's Essence (62713)
DELETE FROM spell_script_names WHERE spell_id IN(62968, 62713);
DELETE FROM conditions WHERE SourceEntry IN(62968, 62713) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62968, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Freya');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 1, 31, 0, 3, 32916, 0, 0, 0, 0, '', 'Snaplasher');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 2, 31, 0, 3, 32919, 0, 0, 0, 0, '', 'Storm Lasher');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 3, 31, 0, 3, 33202, 0, 0, 0, 0, '', 'Ancient Water Spirit');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 4, 31, 0, 3, 33203, 0, 0, 0, 0, '', 'Ancient Conservator');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 5, 31, 0, 3, 32918, 0, 0, 0, 0, '', 'Detonating Lasher');
INSERT INTO conditions VALUES(13, 1, 62968, 0, 6, 31, 0, 3, 33228, 0, 0, 0, 0, '', 'Enaors Gift');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Freya');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 1, 31, 0, 3, 32916, 0, 0, 0, 0, '', 'Snaplasher');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 2, 31, 0, 3, 32919, 0, 0, 0, 0, '', 'Storm Lasher');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 3, 31, 0, 3, 33202, 0, 0, 0, 0, '', 'Ancient Water Spirit');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 4, 31, 0, 3, 33203, 0, 0, 0, 0, '', 'Ancient Conservator');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 5, 31, 0, 3, 32918, 0, 0, 0, 0, '', 'Detonating Lasher');
INSERT INTO conditions VALUES(13, 1, 62713, 0, 6, 31, 0, 3, 33228, 0, 0, 0, 0, '', 'Enaors Gift');

-- Hardened Bark
REPLACE INTO spell_proc_event VALUES(62337, 0, 0, 0, 0, 0, 8+32, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES(62933, 0, 0, 0, 0, 0, 8+32, 0, 0, 0, 0);

DELETE FROM conditions WHERE SourceEntry IN(62386, 62387, 62385, 62483, 62484, 62485) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 5, 62386, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Stonebark essence');
INSERT INTO conditions VALUES(13, 3, 62387, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Ironbranch essence');
INSERT INTO conditions VALUES(13, 3, 62385, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Brightleaf essence');
INSERT INTO conditions VALUES(13, 1, 62483, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Stonebark essence BASE');
INSERT INTO conditions VALUES(13, 1, 62484, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Ironbranch essence BASE');
INSERT INTO conditions VALUES(13, 1, 62485, 0, 0, 31, 0, 3, 32906, 0, 0, 0, 0, '', 'Brightleaf essence BASE');

-- Freya (32906, 33360)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=6261, maxdmg=8544, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_freya' WHERE entry=32906;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=5060, maxdmg=5366, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33360;

-- Elder Ironbranch (32913, 33392)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=4701, maxdmg=6409, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_freya_elder_ironbranch' WHERE entry=32913;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=3799, maxdmg=5180, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33392;

-- Elder Stonebark (32914, 33393)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=4701, maxdmg=6409, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_freya_elder_stonebark' WHERE entry=32914;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=3799, maxdmg=5180, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33393;

-- Elder Brightleaf (32915, 33391)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=4701, maxdmg=6409, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_freya_elder_brightleaf' WHERE entry=32915;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=3799, maxdmg=5180, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33391;

-- Snaplasher (32916, 33400)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1774, maxdmg=2419, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=617298715, AIName='', ScriptName='boss_freya_summons' WHERE entry=32916;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1398, maxdmg=1906, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=617298715 WHERE entry=33400;

-- Storm Lasher (32919, 33401)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1774, maxdmg=2419, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=617299803, AIName='', ScriptName='boss_freya_summons' WHERE entry=32919;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1398, maxdmg=1906, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=617299803 WHERE entry=33401;

-- Ancient Water Spirit (33202, 33398)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=2359, maxdmg=3223, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=617297755, AIName='', ScriptName='boss_freya_summons' WHERE entry=33202;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1902, maxdmg=2599, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=617297755 WHERE entry=33398;

-- Ancient Conservator (33203, 33376)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=2948, maxdmg=4019, attackpower=805, dmg_multiplier=7, baseattacktime=2000, mechanic_immune_mask=650853979, AIName='', ScriptName='boss_freya_summons' WHERE entry=33203;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=2386, maxdmg=3253, attackpower=805, dmg_multiplier=13, baseattacktime=2000, mechanic_immune_mask=650853979 WHERE entry=33376;

-- Detonating Lasher (32918, 33399)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1000, maxdmg=1400, attackpower=1, dmg_multiplier=1, dmgschool=2, baseattacktime=2000, mechanic_immune_mask=617299803, AIName='', ScriptName='boss_freya_summons' WHERE entry=32918;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=1600, maxdmg=2000, attackpower=1, dmg_multiplier=1, dmgschool=2, baseattacktime=2000, mechanic_immune_mask=617299803 WHERE entry=33399;

-- Iron Roots (33088, 33396)
-- Strengthened Iron Roots (33168, 33397)
UPDATE creature_template SET faction=16, AIName='', ScriptName='boss_freya_iron_root' WHERE entry IN(33088, 33168);
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry IN(33396, 33397);

-- Healthy Spore (33215)
UPDATE creature_template SET unit_flags=33554432+512, AIName='', ScriptName='boss_freya_healthy_spore' WHERE entry=33215;

-- Eonar's Gift (33228, 33385)
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='boss_freya_lifebinder' WHERE entry=33228;
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='' WHERE entry=33385;

-- Nature Bomb (34129)
UPDATE creature_template SET modelid1=23258, modelid2=0, AIName='', ScriptName='boss_freya_nature_bomb' WHERE entry=34129;

-- Unstable Sun Beam (33050)
-- Sun Beam (33170)
UPDATE creature_template SET modelid1=23258, modelid2=0, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(33050, 33170);

-- Channel Stalker Freya (33575)
-- Achievement Trigger Freya (33406)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33575, 33406));
DELETE FROM creature WHERE id IN(33575, 33406);
UPDATE creature_template SET flags_extra=130 WHERE entry IN(33575, 33406);

-- delete Freya's Gift, spawned manually
DELETE FROM gameobject WHERE id IN(194328,194324,194327,194325,194331,194326,194329,194330);



-- ###################
-- ### HODIR
-- ###################

-- delete Cache of Winter, spawned manually
DELETE FROM gameobject WHERE id IN(194307,194308);

-- delete Rare Cache of Winter, spawned manually
DELETE FROM gameobject WHERE id IN(194200,194201);

-- Hodir (32845, 32846)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=5878, maxdmg=8014, attackpower=805, dmg_multiplier=7, baseattacktime=2000, AIName='', ScriptName='boss_hodir', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=32845;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, mindmg=6499, maxdmg=8861, attackpower=805, dmg_multiplier=13, baseattacktime=2000, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=32846;
DELETE FROM creature_template_addon WHERE entry IN(32845, 32846);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32845, 32846) AND `map`=603 );
UPDATE creature_model_info SET combat_reach=5 WHERE modelid=28743;

-- Flash Freeze (32938, 33353) (for npcs)
UPDATE creature_template SET modelid1=25865, modelid2=0, unit_flags=131076, AIName='', ScriptName='npc_ulduar_flash_freeze', mechanic_immune_mask=650870655, flags_extra=0+0x200000 WHERE entry=32938;
UPDATE creature_template SET modelid1=25865, modelid2=0, unit_flags=131076, AIName='', ScriptName='', mechanic_immune_mask=650870655, flags_extra=0+0x200000 WHERE entry=33353;
DELETE FROM smart_scripts WHERE entryorguid IN(32938, 33353) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(32938, 33353);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32938, 33353) AND `map`=603 );
DELETE FROM creature WHERE id IN(32938) AND `map`=603;

-- Flash Freeze (32926, 33352) (for players)
UPDATE creature_template SET modelid1=25865, modelid2=0, unit_flags=131076, AIName='', ScriptName='npc_ulduar_flash_freeze', mechanic_immune_mask=650870655, flags_extra=0+0x200000 WHERE entry=32926;
UPDATE creature_template SET modelid1=25865, modelid2=0, unit_flags=131076, AIName='', ScriptName='', mechanic_immune_mask=650870655, flags_extra=0+0x200000 WHERE entry=33352;
DELETE FROM smart_scripts WHERE entryorguid IN(32926, 33352) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(32926, 33352);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32926, 33352) AND `map`=603 );
DELETE FROM creature WHERE id IN(32926, 33352) AND `map`=603;

-- Icicle (33169)
UPDATE creature_template SET modelid1=28470, modelid2=0, unit_flags=33587200, AIName='', ScriptName='npc_ulduar_icicle' WHERE entry=33169;
DELETE FROM smart_scripts WHERE entryorguid IN(33169) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33169);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33169) AND `map`=603 );
DELETE FROM creature WHERE id IN(33169) AND `map`=603;

-- Snowpacked Icicle (33173)
UPDATE creature_template SET modelid1=28470, modelid2=0, unit_flags=33587200, AIName='', ScriptName='npc_ulduar_icicle' WHERE entry=33173;
DELETE FROM smart_scripts WHERE entryorguid IN(33173) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33173);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33173) AND `map`=603 );
DELETE FROM creature WHERE id IN(33173) AND `map`=603;

-- Snowpacked Icicle Target (33174)
UPDATE creature_template SET modelid1=15880, modelid2=0, unit_flags=33554434, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=33174;
DELETE FROM smart_scripts WHERE entryorguid IN(33174) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(33174, 0, 0, 0, 1, 0, "65705");
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33174) AND `map`=603 );
DELETE FROM creature WHERE id IN(33174) AND `map`=603;

-- Toasty Fire (33342)
UPDATE creature_template SET modelid1=15880, modelid2=0, faction=1665, unit_flags=33554432, flags_extra=130, AIName='', ScriptName='npc_ulduar_toasty_fire' WHERE entry=33342;
DELETE FROM smart_scripts WHERE entryorguid IN(33342) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33342);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33342) AND `map`=603 );
DELETE FROM creature WHERE id IN(33342) AND `map`=603;

-- spell Biting Cold (62038, 62039, 62188)
DELETE FROM spell_script_names WHERE spell_id IN(62038, 62039, 62188, -62038, -62039, -62188);
DELETE FROM spell_scripts WHERE id IN(62038, 62039, 62188, -62038, -62039, -62188);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62038, 62039, 62188, -62038, -62039, -62188) OR spell_effect IN(62038, 62039, 62188, -62038, -62039, -62188);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62038, 62039, 62188);
INSERT INTO spell_script_names VALUES(62038, 'spell_hodir_biting_cold_main_aura');
INSERT INTO spell_script_names VALUES(62039, 'spell_hodir_biting_cold_player_aura');

-- spell Icicle (62227, 63545, 62236, 62457, 62453)
DELETE FROM spell_script_names WHERE spell_id IN(62227, 63545, -62227, -63545, 62236, 62457, 62453, -62236, -62457, -62453);
DELETE FROM spell_scripts WHERE id IN(62227, 63545, -62227, -63545, 62236, 62457, 62453, -62236, -62457, -62453);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62227, 63545, -62227, -63545, 62236, 62457, 62453, -62236, -62457, -62453) OR spell_effect IN(62227, 63545, -62227, -63545, 62236, 62457, 62453, -62236, -62457, -62453);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62227, 63545, 62236, 62457, 62453);
INSERT INTO spell_script_names VALUES(63545, 'spell_hodir_periodic_icicle');
INSERT INTO `conditions` VALUES (13, 1, 62457, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 1, 62457, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 2, 62457, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 2, 62457, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 4, 62457, 0, 0, 31, 0, 3, 33342, 0, 0, 0, 0, '', 'Hodir - Icicle');

-- spell Icicle (62462, 62460, 65370, 62463)
DELETE FROM spell_script_names WHERE spell_id IN(62462, 62460, 65370, 62463, -62462, -62460, -65370, -62463);
DELETE FROM spell_scripts WHERE id IN(62462, 62460, 65370, 62463, -62462, -62460, -65370, -62463);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62462, 62460, 65370, 62463, -62462, -62460, -65370, -62463) OR spell_effect IN(62462, 62460, 65370, 62463, -62462, -62460, -65370, -62463);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62462, 62460, 65370, 62463);
INSERT INTO `conditions` VALUES (13, 1, 65370, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 1, 65370, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 2, 65370, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 2, 65370, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Icicle');
INSERT INTO `conditions` VALUES (13, 4, 65370, 0, 0, 31, 0, 3, 33342, 0, 0, 0, 0, '', 'Hodir - Icicle');

-- spell Freeze (62469)
DELETE FROM spell_script_names WHERE spell_id IN(62469, -62469);
DELETE FROM spell_scripts WHERE id IN(62469, -62469);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62469, -62469) OR spell_effect IN(62469, -62469);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62469);
INSERT INTO `conditions` VALUES (13, 1, 62469, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Freeze');
INSERT INTO `conditions` VALUES (13, 1, 62469, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Freeze');
INSERT INTO `conditions` VALUES (13, 2, 62469, 0, 0, 1, 0, 61969, 0, 0, 1, 0, 0, '', 'Hodir - Freeze');
INSERT INTO `conditions` VALUES (13, 2, 62469, 0, 0, 1, 0, 61990, 0, 0, 1, 0, 0, '', 'Hodir - Freeze');
INSERT INTO `conditions` VALUES (13, 2, 62469, 0, 0, 1, 0, 62821, 0, 0, 1, 0, 0, '', 'Hodir - Freeze');

-- spell Safe Area (65705, 62464)
DELETE FROM spell_script_names WHERE spell_id IN(65705, 62464, -65705, -62464);
DELETE FROM spell_scripts WHERE id IN(65705, 62464, -65705, -62464);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65705, 62464, -65705, -62464) OR spell_effect IN(65705, 62464, -65705, -62464);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65705, 62464);
INSERT INTO `conditions` VALUES (13, 1, 62464, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Hodir - Safe Area');

-- spell Flash Freeze (61968, 62148, 62226)
DELETE FROM event_scripts WHERE id=20896;
DELETE FROM spell_script_names WHERE spell_id IN(61968, 62148, 62226, -61968, -62148, -62226);
DELETE FROM spell_scripts WHERE id IN(61968, 62148, 62226, -61968, -62148, -62226);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(61968, 62148, 62226, -61968, -62148, -62226) OR spell_effect IN(61968, 62148, 62226, -61968, -62148, -62226);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(61968, 62148, 62226);
INSERT INTO spell_linked_spell VALUES(61968, 62148, 0, 'Hodir - Flash Freeze');
INSERT INTO spell_script_names VALUES(61968, 'spell_hodir_flash_freeze');

-- spell Flash Freeze (61969, 61990)
DELETE FROM spell_script_names WHERE spell_id IN(61969, 61990, -61969, -61990);
DELETE FROM spell_scripts WHERE id IN(61969, 61990, -61969, -61990);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(61969, 61990, -61969, -61990) OR spell_effect IN(61969, 61990, -61969, -61990);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(61969, 61990);

-- Field Medic Penny (32897)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_priest' WHERE entry=32897;
-- Ellie Nightfeather (32901)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_druid' WHERE entry=32901;
-- Elementalist Avuun (32900)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_shaman' WHERE entry=32900;
-- Missy Flamecuffs (32893)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_mage' WHERE entry=32893;
-- Field Medic Jessi (33326)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_priest' WHERE entry=33326;
-- Elementalist Mahfuun (33328)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_shaman' WHERE entry=33328;
-- Eivi Nightfeather (33325)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_druid' WHERE entry=33325;
-- Sissy Flamecuffs (33327)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_mage' WHERE entry=33327;
-- Battle-Priest Eliza (32948)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_priest' WHERE entry=32948;
-- Spiritwalker Yona (32950)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_shaman' WHERE entry=32950;
-- Tor Greycloud (32941)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_druid' WHERE entry=32941;
-- Veesha Blazeweaver (32946)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_mage' WHERE entry=32946;
-- Battle-Priest Gina (33330)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_priest' WHERE entry=33330;
-- Spiritwalker Tara (33332)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_shaman' WHERE entry=33332;
-- Kar Greycloud (33333)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_druid' WHERE entry=33333;
-- Amira Blazeweaver (33331)
UPDATE creature_template SET minlevel=80, maxlevel=80, `exp`=2, faction=1665, speed_walk=1.14286, speed_run=1.14286, unit_flags=131072+32768, AIName='', RegenHealth=0, ScriptName='npc_ulduar_hodir_mage' WHERE entry=33331;
-- delete possible shit
DELETE FROM smart_scripts WHERE entryorguid IN(32897,32901,32900,32893,33326,33325,33328,33327,32948,32941,32950,32946,33330,33333,33332,33331) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(32897,32901,32900,32893,33326,33325,33328,33327,32948,32941,32950,32946,33330,33333,33332,33331);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32897,32901,32900,32893,33326,33325,33328,33327,32948,32941,32950,32946,33330,33333,33332,33331) AND `map`=603 );
DELETE FROM creature WHERE id IN(32897,32901,32900,32893,33326,33325,33328,33327,32948,32941,32950,32946,33330,33333,33332,33331) AND `map`=603;

-- spell Dispel Magic (63499)
DELETE FROM spell_script_names WHERE spell_id IN(63499, -63499);
DELETE FROM spell_scripts WHERE id IN(63499, -63499);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63499, -63499) OR spell_effect IN(63499, -63499);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63499);
INSERT INTO `conditions` VALUES (13, 1, 63499, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Hodir - Dispel Magic');
INSERT INTO `conditions` VALUES (13, 1, 63499, 0, 0, 1, 0, 62469, 0, 0, 0, 0, 0, '', 'Hodir - Dispel Magic');

-- spell Great Heal (62809)
DELETE FROM spell_script_names WHERE spell_id IN(62809, -62809);
DELETE FROM spell_scripts WHERE id IN(62809, -62809);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62809, -62809) OR spell_effect IN(62809, -62809);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62809);
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 0, 31, 0, 3, 32897, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 1, 31, 0, 3, 32901, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 2, 31, 0, 3, 32900, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 3, 31, 0, 3, 32893, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 4, 31, 0, 3, 33326, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 5, 31, 0, 3, 33325, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 6, 31, 0, 3, 33328, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 6, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 7, 31, 0, 3, 33327, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 7, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 8, 31, 0, 3, 32948, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 8, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 9, 31, 0, 3, 32941, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 9, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 10, 31, 0, 3, 32950, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 10, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 11, 31, 0, 3, 32946, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 11, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 12, 31, 0, 3, 33330, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 12, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 13, 31, 0, 3, 33333, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 13, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 14, 31, 0, 3, 33332, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 14, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 15, 31, 0, 3, 33331, 0, 0, 0, 0, '', 'Hodir - Great Heal');
INSERT INTO `conditions` VALUES (13, 1, 62809, 0, 15, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hodir - Great Heal');

-- spell Storm Cloud, Storm Power (65123, 65133, 63711, 65134)
DELETE FROM spell_script_names WHERE spell_id IN(65123, 65133, 63711, 65134, -65123, -65133, -63711, -65134);
DELETE FROM spell_scripts WHERE id IN(65123, 65133, 63711, 65134, -65123, -65133, -63711, -65134);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65123, 65133, 63711, 65134, -65123, -65133, -63711, -65134) OR spell_effect IN(65123, 65133, 63711, 65134, -65123, -65133, -63711, -65134);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65123, 65133, 63711, 65134);
INSERT INTO spell_script_names VALUES(65123, 'spell_hodir_storm_cloud'),(65133, 'spell_hodir_storm_cloud');
INSERT INTO spell_script_names VALUES(63711, 'spell_hodir_storm_power'),(65134, 'spell_hodir_storm_power');
INSERT INTO `conditions` VALUES (13, 3, 63711, 0, 0, 1, 0, 63711, 0, 0, 1, 0, 0, '', 'Hodir - Storm Cloud, Storm Power');
INSERT INTO `conditions` VALUES (13, 3, 65134, 0, 0, 1, 0, 65134, 0, 0, 1, 0, 0, '', 'Hodir - Storm Cloud, Storm Power');

-- for Achievement Staying Buffed All Winter
-- Toasty Fire (62821)
-- Starlight (62807)
-- Storm Power (63711, 65134) -- done above
DELETE FROM spell_script_names WHERE spell_id IN(62821, -62821, 62807, -62807);
INSERT INTO spell_script_names VALUES(62821, 'spell_hodir_toasty_fire'),(62807, 'spell_hodir_starlight');



-- ###################
-- ### MIMIRON
-- ###################

-- delete Cache of Innovation, spawned manually
DELETE FROM gameobject WHERE id IN(194956,194789,194957,194958);
UPDATE gameobject_template SET faction=0, flags=0, size=1.5 WHERE entry IN(194956, 194789, 194957, 194958);


-- Mimiron (33350)
UPDATE creature_template SET unit_flags=0, AIName='', ScriptName='boss_mimiron' WHERE entry=33350;
DELETE FROM smart_scripts WHERE entryorguid IN(33350) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33350);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33350) AND `map`=603 );

-- Computer (34143)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=34143;
DELETE FROM creature_template_addon WHERE entry IN(34143);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34143) AND `map`=603 );
DELETE FROM creature WHERE id IN(34143) AND `map`=603;
DELETE FROM creature_text WHERE entry=34143;
INSERT INTO `creature_text` VALUES (34143, 0, 0, 'Self-destruct sequence initiated.', 14, 0, 100, 0, 0, 15413, 0, '');
INSERT INTO `creature_text` VALUES (34143, 1, 0, 'Self-destruct sequence terminated. Overide code A905.', 14, 0, 100, 0, 0, 15414, 0, '');
INSERT INTO `creature_text` VALUES (34143, 2, 0, 'This area will self-destruct in ten minutes.', 14, 0, 100, 0, 0, 15415, 0, '');
INSERT INTO `creature_text` VALUES (34143, 3, 0, 'This area will self-destruct in nine minutes.', 14, 0, 100, 0, 0, 15416, 0, '');
INSERT INTO `creature_text` VALUES (34143, 4, 0, 'This area will self-destruct in eight minutes.', 14, 0, 100, 0, 0, 15417, 0, '');
INSERT INTO `creature_text` VALUES (34143, 5, 0, 'This area will self-destruct in seven minutes.', 14, 0, 100, 0, 0, 15418, 0, '');
INSERT INTO `creature_text` VALUES (34143, 6, 0, 'This area will self-destruct in six minutes.', 14, 0, 100, 0, 0, 15419, 0, '');
INSERT INTO `creature_text` VALUES (34143, 7, 0, 'This area will self-destruct in five minutes.', 14, 0, 100, 0, 0, 15420, 0, '');
INSERT INTO `creature_text` VALUES (34143, 8, 0, 'This area will self-destruct in four minutes.', 14, 0, 100, 0, 0, 15421, 0, '');
INSERT INTO `creature_text` VALUES (34143, 9, 0, 'This area will self-destruct in three minutes.', 14, 0, 100, 0, 0, 15422, 0, '');
INSERT INTO `creature_text` VALUES (34143, 10, 0, 'This area will self-destruct in two minutes.', 14, 0, 100, 0, 0, 15423, 0, '');
INSERT INTO `creature_text` VALUES (34143, 11, 0, 'This area will self-destruct in one minute.', 14, 0, 100, 0, 0, 15424, 0, '');
INSERT INTO `creature_text` VALUES (34143, 12, 0, 'Self-destruct sequence finalized. Have a nice day.', 14, 0, 100, 0, 0, 15425, 0, '');

-- Mimiron DB Target (33576)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, AIName='NullCreatureAI', ScriptName='' WHERE entry=33576;
REPLACE INTO creature_template_addon VALUES(33576, 0, 0, 0, 1, 0, "64610");
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33576) AND `map`=603 );
DELETE FROM creature WHERE id IN(33576) AND `map`=603;

-- Leviathan Mk II (34071) -- the cannon
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34071) AND `map`=603 );
DELETE FROM creature WHERE id IN(34071) AND `map`=603;
DELETE FROM creature_template_addon WHERE entry IN(34071);
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=34071;

-- Leviathan Mk II (33432, 34106) -- the vehicle
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=300, speed_run=1.28571, mindmg=5483, maxdmg=7475, attackpower=802, dmg_multiplier=7, unit_flags=33554432, VehicleId=370, AIName='', ScriptName='npc_ulduar_leviathan_mkii', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33432;
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=1200, speed_run=1.28571, mindmg=4389, maxdmg=5983, attackpower=802, dmg_multiplier=13, unit_flags=33554432, VehicleId=370, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=34106;
DELETE FROM smart_scripts WHERE entryorguid IN(33432, 34106) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33432, 34106);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33432, 34106) AND `map`=603 );
UPDATE creature_model_info SET bounding_radius=0, combat_reach=8.0 WHERE modelid=28831;
DELETE FROM vehicle_template_accessory WHERE entry IN(33432, 34106);
DELETE FROM vehicle_accessory WHERE guid IN( SELECT guid FROM creature WHERE id IN(33432, 34106) AND `map`=603 );
REPLACE INTO vehicle_template_accessory VALUES(33432, 34071, 3, 0, 'Mimiron Leviathan Mk II', 8, 0),(34106, 34071, 3, 0, 'Mimiron Leviathan Mk II', 8, 0);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(33432, 34106);
INSERT INTO npc_spellclick_spells VALUES(33432, 67830, 1, 1),(34106, 67830, 1, 1);

-- VX-001 (33651, 34108)
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=300, unit_flags=33554432+4, VehicleId=371, AIName='', ScriptName='npc_ulduar_vx001', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33651;
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=1200, unit_flags=33554432+4, VehicleId=371, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=34108;
DELETE FROM smart_scripts WHERE entryorguid IN(33651, 34108) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33651, 34108);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33651, 34108) AND `map`=603 );
UPDATE creature_model_info SET bounding_radius=0, combat_reach=8.0 WHERE modelid=28841;
DELETE FROM vehicle_template_accessory WHERE entry IN(33651, 34108);
-- REPLACE INTO vehicle_template_accessory VALUES(33651, 34050, 6, 0, 'Mimiron VX-001 rocket', 8, 0),(33651, 34050, 5, 0, 'Mimiron VX-001 rocket', 8, 0);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(33651, 34108);
INSERT INTO npc_spellclick_spells VALUES(33651, 67830, 1, 1),(34108, 67830, 1, 1);

-- Aerial Command Unit (33670, 34109)
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=200, unit_flags=33554432+4, VehicleId=373, AIName='', ScriptName='npc_ulduar_aerial_command_unit', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=33670;
UPDATE creature_template SET exp=0, minlevel=83, maxlevel=83, Health_mod=800, unit_flags=33554432+4, VehicleId=373, AIName='', ScriptName='', mechanic_immune_mask=650854271, flags_extra=1+0x200000 WHERE entry=34109;
DELETE FROM smart_scripts WHERE entryorguid IN(33670, 34109) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33670, 34109);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33670, 34109) AND `map`=603 );
DELETE FROM vehicle_template_accessory WHERE entry IN(33670, 34109);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(33670, 34109);
INSERT INTO npc_spellclick_spells VALUES(33670, 67830, 1, 1),(34109, 67830, 1, 1);

-- Rocket (Mimiron Visual) (34050)
UPDATE creature_template SET difficulty_entry_1=0, speed_run=0.2, speed_walk = 0.2, unit_flags=33554432, AIName='', InhabitType=1, ScriptName='npc_ulduar_mimiron_rocket' WHERE entry=34050;
DELETE FROM smart_scripts WHERE entryorguid IN(34050) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(34050, 0, 0, 0, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34050) AND `map`=603 );

-- Proximity Mine (34362)
UPDATE creature_template SET difficulty_entry_1=0, unit_flags=2, AIName='', ScriptName='npc_ulduar_proximity_mine' WHERE entry=34362;
DELETE FROM smart_scripts WHERE entryorguid IN(34362) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(34362);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34362) AND `map`=603 );

-- Rocket Strike (34047)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, unit_flags=33554432, AIName='', ScriptName='npc_ulduar_rocket_strike_trigger' WHERE entry=34047;
DELETE FROM smart_scripts WHERE entryorguid IN(34047) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(34047);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34047) AND `map`=603 );

-- Magnetic Core (34068)
UPDATE creature_template SET difficulty_entry_1=0, unit_flags=33554432, AIName='', ScriptName='npc_ulduar_magnetic_core' WHERE entry=34068;
DELETE FROM smart_scripts WHERE entryorguid IN(34068) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(34068);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34068) AND `map`=603 );

-- Bomb Bot (33836, 34218)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1, maxdmg=1, attackpower=1, dmg_multiplier=1, AIName='SmartAI', ScriptName='', mechanic_immune_mask=617284383 WHERE entry=33836;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=1, maxdmg=1, attackpower=1, dmg_multiplier=1, AIName='', ScriptName='', mechanic_immune_mask=617284383 WHERE entry=34218;
DELETE FROM creature_template_addon WHERE entry IN(33836, 34218);
DELETE FROM smart_scripts WHERE entryorguid IN(33836, 34218) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (33836, 0, 0, 0, 1, 0, 100, 1, 1500, 1500, 60000, 60000, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - DoZoneInCombat');
INSERT INTO `smart_scripts` VALUES (33836, 0, 1, 2, 33, 0, 100, 1, 0, 1000000, 0, 0, 11, 63801, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot');
INSERT INTO `smart_scripts` VALUES (33836, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 45, 0, 12, 0, 0, 0, 0, 19, 33350, 200, 0, 0, 0, 0, 0, 'Bomb Bot');
INSERT INTO `smart_scripts` VALUES (33836, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bomb Bot - linked death');

-- Bot Summon Trigger (33856)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, unit_flags=33555200, AIName='', ScriptName='npc_ulduar_bot_summon_trigger', flags_extra=0 WHERE entry=33856;
DELETE FROM smart_scripts WHERE entryorguid IN(33856) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33856);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33856) AND `map`=603 );
DELETE FROM creature WHERE id IN(33856) AND `map`=603;

-- Junk Bot (33855, 34114)
UPDATE creature_template SET difficulty_entry_1=34114, faction=16, speed_walk=1, speed_run=1.14286, mindmg=1048, maxdmg=1429, attackpower=624, dmg_multiplier=7, AIName='', ScriptName='' WHERE entry=33855;
UPDATE creature_template SET faction=16, speed_walk=1, speed_run=1.14286, mindmg=849, maxdmg=1157, attackpower=624, dmg_multiplier=13, AIName='', ScriptName='' WHERE entry=34114;
DELETE FROM smart_scripts WHERE entryorguid IN(33855, 34114) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33855, 34114);

-- Assault Bot (34057, 34115)
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=3071, maxdmg=4187, attackpower=624, dmg_multiplier=7, AIName='SmartAI', ScriptName='', mechanic_immune_mask=617299839 WHERE entry=34057;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, mindmg=2480, maxdmg=3382, attackpower=624, dmg_multiplier=13, AIName='', ScriptName='', mechanic_immune_mask=617299839 WHERE entry=34115;
DELETE FROM creature_template_addon WHERE entry IN(34057, 34115);
DELETE FROM smart_scripts WHERE entryorguid IN(34057, 34115) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34057, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 16000, 20000, 11, 64668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magnetic Field');

-- spell Rocket Strike (64064, 63041, 63036, 63681, 64402, 65034)
DELETE FROM spell_script_names WHERE spell_id IN(64064, 63041, 63036, 63681, 64402, 65034, -64064, -63041, -63036, -63681, -64402, -65034);
DELETE FROM spell_scripts WHERE id IN(64064, 63041, 63036, 63681, 64402, 65034, -64064, -63041, -63036, -63681, -64402, -65034);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64064, 63041, 63036, 63681, 64402, 65034, -64064, -63041, -63036, -63681, -64402, -65034) OR spell_effect IN(64064, 63041, 63036, 63681, 64402, 65034, -64064, -63041, -63036, -63681, -64402, -65034);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64064, 63041, 63036, 63681, 64402, 65034);
-- first effect hits pets (22,15), second players (22,7), third hits special npcs for achievement (22,7)
INSERT INTO `conditions` VALUES (13, 2, 63041, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mimiron - Rocket Strike');
INSERT INTO `conditions` VALUES (13, 4, 63041, 0, 0, 31, 0, 3, 34057, 0, 0, 0, 0, '', 'Mimiron - Rocket Strike');
INSERT INTO `conditions` VALUES (13, 4, 63041, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Mimiron - Rocket Strike');

-- spell Rapid Burst (63382, 63387, 64019, 64531, 64532, 64840, 64841)
DELETE FROM spell_script_names WHERE spell_id IN(63382, 63387, 64019, 64531, 64532, 64840, 64841, -63382, -63387, -64019, -64531, -64532, -64840, -64841);
DELETE FROM spell_scripts WHERE id IN(63382, 63387, 64019, 64531, 64532, 64840, 64841, -63382, -63387, -64019, -64531, -64532, -64840, -64841);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63382, 63387, 64019, 64531, 64532, 64840, 64841, -63382, -63387, -64019, -64531, -64532, -64840, -64841) OR spell_effect IN(63382, 63387, 64019, 64531, 64532, 64840, 64841, -63382, -63387, -64019, -64531, -64532, -64840, -64841);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63382, 63387, 64019, 64531, 64532, 64840, 64841);
INSERT INTO spell_script_names VALUES(63382, 'spell_mimiron_rapid_burst');

-- spell Spinning Up (P3Wx2 Laser Barrage) (63414, 63274, 66490, 63293, 63300)
DELETE FROM spell_script_names WHERE spell_id IN(63414, 63274, 66490, 63293, 63300, -63414, -63274, -66490, -63293, -63300);
DELETE FROM spell_scripts WHERE id IN(63414, 63274, 66490, 63293, 63300, -63414, -63274, -66490, -63293, -63300);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63414, 63274, 66490, 63293, 63300, -63414, -63274, -66490, -63293, -63300) OR spell_effect IN(63414, 63274, 66490, 63293, 63300, -63414, -63274, -66490, -63293, -63300);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63414, 63274, 66490, 63293, 63300);
INSERT INTO `conditions` VALUES (13, 1, 63414, 0, 0, 31, 0, 3, 33651, 0, 0, 0, 0, '', 'Mimiron - P3Wx2 Laser Barrage');
INSERT INTO `conditions` VALUES (13, 2, 63414, 0, 0, 31, 0, 3, 33432, 0, 0, 0, 0, '', 'Mimiron - P3Wx2 Laser Barrage');
INSERT INTO `conditions` VALUES (13, 1, 63274, 0, 0, 31, 0, 3, 33651, 0, 0, 0, 0, '', 'Mimiron - P3Wx2 Laser Barrage');
INSERT INTO spell_script_names VALUES(63274, 'spell_mimiron_p3wx2_laser_barrage');

-- spell Magnetic Core (64444, 64436, 64438)
DELETE FROM spell_script_names WHERE spell_id IN(64444, 64436, 64438, -64444, -64436, -64438);
DELETE FROM spell_scripts WHERE id IN(64444, 64436, 64438, -64444, -64436, -64438);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64444, 64436, 64438, -64444, -64436, -64438) OR spell_effect IN(64444, 64436, 64438, -64444, -64436, -64438);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64444, 64436, 64438);
INSERT INTO `conditions` VALUES (13, 2, 64436, 0, 0, 31, 0, 3, 33670, 0, 0, 0, 0, '', 'Mimiron - Magnetic Core');

-- Flames (Initial) (34363)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, unit_flags=33554944, AIName='', ScriptName='npc_ulduar_flames_initial' WHERE entry=34363;
DELETE FROM creature_template_addon WHERE entry IN(34363);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34363) AND `map`=603 );
DELETE FROM creature WHERE id IN(34363) AND `map`=603;

-- Flames (Spread) (34121)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, unit_flags=33554944, AIName='', ScriptName='npc_ulduar_flames_spread' WHERE entry=34121;
DELETE FROM creature_template_addon WHERE entry IN(34121);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34121) AND `map`=603 );
DELETE FROM creature WHERE id IN(34121) AND `map`=603;

-- spell Flame Suppressant (64570, 65224, 65192, 64626, 65333, 64619)
DELETE FROM spell_script_names WHERE spell_id IN(64570, -64570, 65224, -65224, 65192, -65192, 64626, 65333, 64619, -64626, -65333, -64619);
DELETE FROM spell_scripts WHERE id IN(64570, -64570, 65224, -65224, 65192, -65192, 64626, 65333, 64619, -64626, -65333, -64619);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64570, -64570, 65224, -65224, 65192, -65192, 64626, 65333, 64619, -64626, -65333, -64619) OR spell_effect IN(64570, -64570, 65224, -65224, 65192, -65192, 64626, 65333, 64619, -64626, -65333, -64619);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64570, 65224, 65192, 64626, 65333, 64619);
INSERT INTO `conditions` VALUES (13, 2, 64570, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');
INSERT INTO `conditions` VALUES (13, 1, 65224, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');
INSERT INTO `conditions` VALUES (13, 1, 65192, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');
INSERT INTO `conditions` VALUES (13, 4, 64626, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');
INSERT INTO `conditions` VALUES (13, 4, 65333, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');
INSERT INTO `conditions` VALUES (13, 1, 64619, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Flame Supression');

-- spell Frost Bomb (64623, 64624, 64625, 64627, 64626, 65333)
DELETE FROM spell_script_names WHERE spell_id IN(64623, 64624, 64625, 64627, 64626, 65333, -64623, -64624, -64625, -64627, -64626, -65333);
DELETE FROM spell_scripts WHERE id IN(64623, 64624, 64625, 64627, 64626, 65333, -64623, -64624, -64625, -64627, -64626, -65333);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(64623, 64624, 64625, 64627, 64626, 65333, -64623, -64624, -64625, -64627, -64626, -65333) OR spell_effect IN(64623, 64624, 64625, 64627, 64626, 65333, -64623, -64624, -64625, -64627, -64626, -65333);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(64623, 64624, 64625, 64627, 64626, 65333);
INSERT INTO `conditions` VALUES (13, 1, 64623, 0, 0, 31, 0, 3, 34121, 0, 0, 0, 0, '', 'Mimiron - Frost Bomb');
INSERT INTO `conditions` VALUES (13, 1, 64623, 0, 0, 1, 0, 64561, 0, 0, 0, 0, 0, '', 'Mimiron - Frost Bomb');

-- npc Frost Bomb (34149)
UPDATE creature_template SET difficulty_entry_1=0, modelid1=11686, modelid2=0, faction=16, unit_flags=33554432, AIName='SmartAI', ScriptName='', flags_extra=2 WHERE entry=34149;
DELETE FROM creature_template_addon WHERE entry=34149;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34149) AND `map`=603 );
DELETE FROM creature WHERE id IN(34149) AND `map`=603;
DELETE FROM smart_scripts WHERE entryorguid IN(34149) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (34149, 0, 0, 1, 60, 0, 100, 1, 10000, 10000, 60000, 60000, 28, 64624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');
INSERT INTO `smart_scripts` VALUES (34149, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 41, 2500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');
INSERT INTO `smart_scripts` VALUES (34149, 0, 2, 0, 60, 0, 100, 3, 10000, 10000, 60000, 60000, 11, 64626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');
INSERT INTO `smart_scripts` VALUES (34149, 0, 3, 0, 60, 0, 100, 5, 10000, 10000, 60000, 60000, 11, 65333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');
INSERT INTO `smart_scripts` VALUES (34149, 0, 4, 0, 37, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');
INSERT INTO `smart_scripts` VALUES (34149, 0, 5, 0, 37, 0, 100, 1, 0, 0, 0, 0, 11, 64624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mimiron - Frost Bomb');

-- Emergency Fire Bot (34147, 34148)
UPDATE creature_template SET difficulty_entry_1=34148, faction=16, speed_walk=1, speed_run=1.14, unit_flags=0, AIName='', ScriptName='npc_ulduar_emergency_fire_bot', RegenHealth=0, mechanic_immune_mask=650854011 WHERE entry=34147;
UPDATE creature_template SET faction=16, speed_walk=2, speed_run=2, unit_flags=0, AIName='', ScriptName='', RegenHealth=0, mechanic_immune_mask=650854011 WHERE entry=34148;
DELETE FROM creature_template_addon WHERE entry IN(34147, 34148);
REPLACE INTO creature_template_addon VALUES(34148, 0, 0, 0, 1, 0, "64616");
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(34147, 34148) AND `map`=603 );
DELETE FROM creature WHERE id IN(34147, 34148) AND `map`=603;
DELETE FROM smart_scripts WHERE entryorguid IN(34147, 34148) AND source_type=0;

-- DO NOT PUSH THIS BUTTON! (194739)
REPLACE INTO `gameobject_template` VALUES (194739, 0, 8675, 'DO NOT PUSH THIS BUTTON!', '', '', '', 0, 32, 8.7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 'go_ulduar_do_not_push_this_button', 0);

-- spell Not-So-Friendly Fire (65040)
DELETE FROM spell_script_names WHERE spell_id IN(65040, -65040);
DELETE FROM spell_scripts WHERE id IN(65040, -65040);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65040, -65040) OR spell_effect IN(65040, -65040);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65040);
INSERT INTO `conditions` VALUES (13, 1, 65040, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mimiron - Not-So-Friendly Fire');

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_ulduar_proximity_mines' AND spell_id=63027;



-- ###################
-- ### THORIM
-- ###################

DELETE FROM conditions WHERE SourceEntry IN(62042) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 7, 62042, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Stormhammer');
DELETE FROM spell_linked_spell WHERE spell_trigger=62042;
INSERT INTO spell_linked_spell VALUES(62042, 62470, 1, 'Thorim - Stormhammer');
DELETE FROM conditions WHERE SourceEntry IN(62016) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62016, 0, 0, 31, 0, 3, 33378, 0, 0, 0, 0, '', 'Charge Orb');
DELETE FROM conditions WHERE SourceEntry IN(62942) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 7, 62942, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Runic Fortification');
INSERT INTO conditions VALUES(13, 7, 62942, 0, 0, 34, 0, 1, 248, 0, 0, 0, 0, '', 'Runic Fortification');
DELETE FROM conditions WHERE SourceEntry IN(62603, 62577) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62603, 0, 0, 31, 0, 3, 32879, 0, 0, 0, 0, '', 'Sif - Blizzard 25');
INSERT INTO conditions VALUES(13, 1, 62577, 0, 0, 31, 0, 3, 32879, 0, 0, 0, 0, '', 'Sif - Blizzard 10');
DELETE FROM conditions WHERE SourceEntry IN(64098) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64098, 0, 0, 31, 0, 3, 32865, 0, 0, 0, 0, '', 'Lightning Pilar P2 trigger');
DELETE FROM conditions WHERE SourceEntry IN(62976) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62976, 0, 0, 31, 0, 3, 32892, 0, 0, 0, 0, '', 'Lightning Pilar P2 Original');
DELETE FROM conditions WHERE SourceEntry IN(63238) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 63238, 0, 0, 31, 0, 3, 32892, 0, 0, 0, 0, '', 'Lightning Pilar P1');
DELETE FROM conditions WHERE SourceEntry IN(62466) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 4, 62466, 0, 0, 31, 0, 3, 32780, 0, 0, 0, 0, '', 'Lightning Charge - dummy hit trigger');
DELETE FROM conditions WHERE SourceEntry IN(62565) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 3, 62565, 0, 0, 31, 0, 3, 32865, 0, 0, 0, 0, '', 'Touch of Dominion');
DELETE FROM conditions WHERE SourceEntry IN(62278) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62278, 0, 0, 31, 0, 3, 32865, 0, 0, 0, 0, '', 'Lightning Orb Charger');

-- SPELL Berserk (62560)
DELETE FROM conditions WHERE SourceEntry IN(62560) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 7, 62560, 0, 0, 31, 0, 3, 32872, 0, 0, 0, 0, '', 'Target Runic Colossus');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 1, 31, 0, 3, 32873, 0, 0, 0, 0, '', 'Target Ancient Rune Giant');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 2, 31, 0, 3, 32874, 0, 0, 0, 0, '', 'Target Iron Ring Guard');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 3, 31, 0, 3, 32875, 0, 0, 0, 0, '', 'Target Iron Honor Guard');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 4, 31, 0, 3, 32876, 0, 0, 0, 0, '', 'Target Dark Rune Champion');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 5, 31, 0, 3, 32877, 0, 0, 0, 0, '', 'Target Dark Rune Warbringer');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 6, 31, 0, 3, 32878, 0, 0, 0, 0, '', 'Target Dark Rune Evoker');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 7, 31, 0, 3, 32904, 0, 0, 0, 0, '', 'Target Dark Rune Commoner');
INSERT INTO conditions VALUES(13, 7, 62560, 0, 8, 31, 0, 3, 33110, 0, 0, 0, 0, '', 'Target Dark Rune Acolyte');


DELETE FROM spell_script_names WHERE spell_id IN(62976);
INSERT INTO spell_script_names VALUES (62976, 'spell_thorim_lightning_pillar_P2');

DELETE FROM spell_script_names WHERE spell_id IN(62331, 62418);
INSERT INTO spell_script_names VALUES (62331, 'spell_thorim_trash_impale');
INSERT INTO spell_script_names VALUES (62418, 'spell_thorim_trash_impale');

-- Thorim Event Bunny (used as a pillar) (32892)
-- Thunder Orb (33378)
UPDATE creature_template SET modelid1=16925, modelid2=0, AIName='', ScriptName='boss_thorim_pillar' WHERE entry IN(33378, 32892);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33378, 32892));
DELETE FROM creature WHERE id IN(33378, 32892);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2105.04, -292.56, 433.3, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2105.04, -292.56, 420, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2092.95, -263, 433.3, 5.49779, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2092.95, -263, 420, 6.26573, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2104.94, -233.44, 433.3, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2104.94, -233.44, 420, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2124.3, -222.6, 433.3, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2124.3, -222.6, 420, 6.26573, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2145.5, -222.62, 433.3, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2145.5, -222.62, 420, 2.35619, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2164.2, -233.47, 433.3, 3.90954, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2164.2, -233.47, 420, 4.45059, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33378, 603, 3, 1, 11686, 0, 2164.55, -293, 433.3, 4.97419, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32892, 603, 3, 1, 11686, 0, 2164.55, -293, 420, 0.785398, 604800, 0, 0, 12600, 0, 0, 0, 0, 0);

-- Lever (194264)
UPDATE gameobject_template SET ScriptName='go_thorim_lever' WHERE entry=194264;

-- delete Cache of Storms, spawned manually
DELETE FROM gameobject WHERE id IN(194315,194312,194313,194314);
UPDATE gameobject_template SET faction=0, flags=0, size=3 WHERE entry IN(194315,194312,194313,194314);
UPDATE gameobject_template SET questItem1=0 WHERE entry=194314;
UPDATE gameobject_template SET questItem1=45817 WHERE entry=194315;


-- Thorim (32865, 33147)
UPDATE creature_template SET speed_walk=2.5, speed_run=1.9286, mindmg=12500, maxdmg=15000, attackpower=1, dmg_multiplier=1, unit_flags=0, baseattacktime=1500, mechanic_immune_mask=617299839, flags_extra=1+0x200000, ScriptName='boss_thorim' WHERE entry=32865;
UPDATE creature_template SET speed_walk=2.5, speed_run=1.9286, mindmg=25000, maxdmg=30000, attackpower=1, dmg_multiplier=1, unit_flags=0, baseattacktime=1500, mechanic_immune_mask=617299839, flags_extra=1+0x200000 WHERE entry=33147;

-- Sif (33196, 33234)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33196));
DELETE FROM creature WHERE id IN(33196);
UPDATE creature_template SET faction=14, ScriptName='boss_thorim_sif' WHERE entry=33196;
UPDATE creature_template SET faction=14 WHERE entry=33234;

-- Dark Rune Acolyte (32886, 33159)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32886));
DELETE FROM creature WHERE id IN(32886);
UPDATE creature_template SET faction=1692, mindmg=2000, maxdmg=2800, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_start_npcs' WHERE entry=32886;
UPDATE creature_template SET faction=1692, mindmg=2000, maxdmg=2800, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33159;

-- Captured Mercenary Soldier (32883, 33152, 32885, 33153)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32883, 32885));
DELETE FROM creature WHERE id IN(32883, 32885);
UPDATE creature_template SET mindmg=800, maxdmg=1100, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_start_npcs' WHERE entry IN(32883, 32885);
UPDATE creature_template SET mindmg=800, maxdmg=1100, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(33152, 33153);

-- Captured Mercenary Captain (32907, 33151, 32908, 33150)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32907, 32908));
DELETE FROM creature WHERE id IN(32907, 32908);
UPDATE creature_template SET mindmg=800, maxdmg=1100, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_start_npcs' WHERE entry IN(32907, 32908);
UPDATE creature_template SET mindmg=800, maxdmg=1100, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(33151, 33150);

-- Jormungar Behemoth (32882, 33154)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32882));
DELETE FROM creature WHERE id IN(32882);
UPDATE creature_template SET mindmg=4121, maxdmg=5621, attackpower=742, dmg_multiplier=7, faction=14, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_start_npcs' WHERE entry=32882;
UPDATE creature_template SET mindmg=3330, maxdmg=4540, attackpower=742, dmg_multiplier=13, faction=14, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33154;

-- Iron Honor Guard (32875, 33163)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32875));
DELETE FROM creature WHERE id IN(32875);
UPDATE creature_template SET mindmg=1774, maxdmg=2422, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_gauntlet_npcs' WHERE entry=32875;
UPDATE creature_template SET mindmg=1774, maxdmg=2422, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33163;

-- Iron Ring Guard (32874, 33162)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32874));
DELETE FROM creature WHERE id IN(32874);
UPDATE creature_template SET mindmg=2200, maxdmg=3000, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_gauntlet_npcs' WHERE entry=32874;
UPDATE creature_template SET mindmg=2200, maxdmg=3000, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33162;

-- Dark Rune Acolyte (33110, 33161)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33110));
DELETE FROM creature WHERE id IN(33110);
UPDATE creature_template SET mindmg=2000, maxdmg=2800, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=0, ScriptName='boss_thorim_gauntlet_npcs' WHERE entry=33110;
UPDATE creature_template SET mindmg=2000, maxdmg=2800, attackpower=742, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33161;

-- Runic Colossus (32872, 33149)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32872));
DELETE FROM creature WHERE id IN(32872);
UPDATE creature_template SET mindmg=4121, maxdmg=5621, attackpower=742, dmg_multiplier=7, unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_runic_colossus' WHERE entry=32872;
UPDATE creature_template SET mindmg=3330, maxdmg=4540, attackpower=742, dmg_multiplier=13, unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33149;

-- Ancient Rune Giant (32873, 33148)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32873));
DELETE FROM creature WHERE id IN(32873);
UPDATE creature_template SET mindmg=1279, maxdmg=1744, attackpower=742, dmg_multiplier=7, unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_ancient_rune_giant' WHERE entry=32873;
UPDATE creature_template SET mindmg=1444, maxdmg=1970, attackpower=742, dmg_multiplier=13, unit_flags=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33148;

-- Dark Rune Warbringer (32877, 33155)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32877));
DELETE FROM creature WHERE id IN(32877);
UPDATE creature_template SET spell1=62320, spell2=62322, mindmg=3435, maxdmg=4688, attackpower=742, dmg_multiplier=4, mechanic_immune_mask=650854270, flags_extra=0+0x200000, ScriptName='boss_thorim_arena_npcs' WHERE entry=32877;
UPDATE creature_template SET spell1=62320, spell2=62322, mindmg=2734, maxdmg=3732, attackpower=742, dmg_multiplier=8, mechanic_immune_mask=650854270, flags_extra=0+0x200000 WHERE entry=33155;

-- Dark Rune Evoker (32878, 33156)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32878));
DELETE FROM creature WHERE id IN(32878);
UPDATE creature_template SET mindmg=2056, maxdmg=2806, attackpower=742, dmg_multiplier=7, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_arena_npcs' WHERE entry=32878;
UPDATE creature_template SET mindmg=1627, maxdmg=2221, attackpower=742, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33156;

-- Dark Rune Commoner (32904, 33157)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32904));
DELETE FROM creature WHERE id IN(32904);
UPDATE creature_template SET mindmg=578, maxdmg=788, attackpower=742, dmg_multiplier=1, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_arena_npcs' WHERE entry=32904;
UPDATE creature_template SET mindmg=578, maxdmg=788, attackpower=742, dmg_multiplier=1.5, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33157;

-- Dark Rune Champion (32876, 33158)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32876));
DELETE FROM creature WHERE id IN(32876);
UPDATE creature_template SET mindmg=2745, maxdmg=3743, attackpower=742, dmg_multiplier=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000, ScriptName='boss_thorim_arena_npcs' WHERE entry=32876;
UPDATE creature_template SET mindmg=2220, maxdmg=3026, attackpower=742, dmg_multiplier=8, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33158;

-- Thorim Golem Left Hand Bunny (33141)
-- Thorim Golem Right Hand Bunny (33140)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33141, 33140));
DELETE FROM creature WHERE id IN(33141, 33140);
UPDATE creature_template SET modelid1=16925, modelid2=0, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(33141, 33140);

-- Dark Rune Warbringer (32925)
-- Dark Rune Evoker (32924)
-- Dark Rune Commoner (32923)
-- Dark Rune Champion (32922)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry IN(32922, 32923, 32924, 32925);

-- Thorim Trap Bunny (33725)
-- Thorim Trap Bunny (33054)
UPDATE creature_template SET AIName='', ScriptName='boss_thorim_trap' WHERE entry IN(33725, 33054);

-- Thorim Controller (32879)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(32879));
DELETE FROM creature WHERE id IN(32879);
UPDATE creature_template SET AIName='', ScriptName='boss_thorim_sif_blizzard' WHERE entry IN(32879);

-- Lightning Orb (33138)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33138));
DELETE FROM creature WHERE id IN(33138);
UPDATE creature_template SET speed_run=4, InhabitType=4, AIName='', ScriptName='boss_thorim_lightning_orb' WHERE entry IN(33138);

-- Invisible Stalker (All Phases) (32780)
INSERT INTO creature VALUES (135983, 32780, 603, 3, 1, 11686, 0, 2114.32, -294.719, 420.229, 1.06465, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135984, 32780, 603, 3, 1, 11686, 0, 2112.35, -290.933, 420.229, 0.977384, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135985, 32780, 603, 3, 1, 11686, 0, 2109.51, -288.595, 420.229, 0.872665, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135986, 32780, 603, 3, 1, 11686, 0, 2103.63, -284.751, 420.229, 0.698132, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135987, 32780, 603, 3, 1, 11686, 0, 2098.97, -281.276, 420.229, 0.575959, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135988, 32780, 603, 3, 1, 11686, 0, 2095.24, -276.875, 420.229, 0.436332, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135989, 32780, 603, 3, 1, 11686, 0, 2093.46, -272.266, 420.229, 0.331613, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135990, 32780, 603, 3, 1, 11686, 0, 2094.18, -267.787, 420.229, 0.226893, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135991, 32780, 603, 3, 1, 11686, 0, 2096.46, -265.11, 420.229, 0.174533, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135992, 32780, 603, 3, 1, 11686, 0, 2096.1, -259.742, 420.229, 0.034907, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135993, 32780, 603, 3, 1, 11686, 0, 2093.62, -257.098, 420.229, 6.23082, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135994, 32780, 603, 3, 1, 11686, 0, 2093.77, -253.55, 420.229, 6.14356, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135995, 32780, 603, 3, 1, 11686, 0, 2094.54, -250.609, 420.229, 6.07375, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135996, 32780, 603, 3, 1, 11686, 0, 2095.87, -247.617, 420.229, 5.98648, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135997, 32780, 603, 3, 1, 11686, 0, 2096.49, -244.888, 420.229, 5.93412, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135998, 32780, 603, 3, 1, 11686, 0, 2098.19, -242.309, 420.229, 5.84685, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (135999, 32780, 603, 3, 1, 11686, 0, 2100.34, -239.746, 420.229, 5.77704, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136000, 32780, 603, 3, 1, 11686, 0, 2104.84, -238.582, 420.229, 5.67232, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136001, 32780, 603, 3, 1, 11686, 0, 2108.71, -237.192, 420.23, 5.58505, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136002, 32780, 603, 3, 1, 11686, 0, 2110.59, -234.974, 421.543, 5.49779, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136003, 32780, 603, 3, 1, 11686, 0, 2109.6, -229.969, 420.23, 5.42797, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136004, 32780, 603, 3, 1, 11686, 0, 2112.29, -228.544, 420.23, 5.34071, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136005, 32780, 603, 3, 1, 11686, 0, 2114.07, -226.523, 420.23, 5.2709, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136006, 32780, 603, 3, 1, 11686, 0, 2119.43, -225.214, 420.23, 5.13127, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136007, 32780, 603, 3, 1, 11686, 0, 2117.03, -226.16, 420.23, 5.20108, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136008, 32780, 603, 3, 1, 11686, 0, 2122.89, -227.533, 420.23, 5.06145, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136009, 32780, 603, 3, 1, 11686, 0, 2126.03, -227.955, 420.23, 4.97419, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136010, 32780, 603, 3, 1, 11686, 0, 2128.16, -225.033, 420.23, 4.90438, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136011, 32780, 603, 3, 1, 11686, 0, 2130.72, -221.698, 420.23, 4.81711, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136012, 32780, 603, 3, 1, 11686, 0, 2134.53, -221.81, 420.23, 4.71239, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136013, 32780, 603, 3, 1, 11686, 0, 2138.82, -222.189, 420.23, 4.59022, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136014, 32780, 603, 3, 1, 11686, 0, 2141.24, -225.294, 420.23, 4.5204, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136015, 32780, 603, 3, 1, 11686, 0, 2143.47, -227.865, 420.23, 4.43314, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136016, 32780, 603, 3, 1, 11686, 0, 2147.7, -227.183, 420.23, 4.31096, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136017, 32780, 603, 3, 1, 11686, 0, 2150.92, -225.809, 420.23, 4.24115, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136018, 32780, 603, 3, 1, 11686, 0, 2154.06, -226.385, 420.23, 4.17134, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136019, 32780, 603, 3, 1, 11686, 0, 2158.64, -229.606, 420.23, 4.01426, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136020, 32780, 603, 3, 1, 11686, 0, 2159.64, -234.009, 420.23, 3.90954, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136021, 32780, 603, 3, 1, 11686, 0, 2160.81, -237.448, 420.23, 3.82227, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136022, 32780, 603, 3, 1, 11686, 0, 2165.12, -238.593, 420.229, 3.71755, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136023, 32780, 603, 3, 1, 11686, 0, 2167.86, -238.358, 420.229, 3.68265, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136024, 32780, 603, 3, 1, 11686, 0, 2170.45, -241.641, 420.229, 3.57792, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136025, 32780, 603, 3, 1, 11686, 0, 2171.82, -244.906, 420.229, 3.49066, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136026, 32780, 603, 3, 1, 11686, 0, 2173.47, -248.761, 420.229, 3.38594, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136027, 32780, 603, 3, 1, 11686, 0, 2174.24, -253.025, 420.229, 3.28122, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136028, 32780, 603, 3, 1, 11686, 0, 2174.03, -274.158, 420.229, 2.77507, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136029, 32780, 603, 3, 1, 11686, 0, 2173.18, -277.563, 420.229, 2.68781, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136030, 32780, 603, 3, 1, 11686, 0, 2171.87, -281.402, 420.229, 2.60054, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136031, 32780, 603, 3, 1, 11686, 0, 2170.11, -284.57, 420.229, 2.51327, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136032, 32780, 603, 3, 1, 11686, 0, 2167.86, -287.628, 420.229, 2.42601, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136033, 32780, 603, 3, 1, 11686, 0, 2164.05, -287.587, 420.229, 2.37365, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136034, 32780, 603, 3, 1, 11686, 0, 2160.24, -288.635, 420.229, 2.28638, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136035, 32780, 603, 3, 1, 11686, 0, 2159.76, -293.55, 420.229, 2.19912, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136036, 32780, 603, 3, 1, 11686, 0, 2154.4, -294.622, 420.229, 2.07694, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136037, 32780, 603, 3, 1, 11686, 0, 2149.19, -291.613, 419.408, 1.98968, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136038, 32780, 603, 3, 1, 11686, 0, 2120.5, -291.858, 419.506, 1.16937, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136039, 32780, 603, 3, 1, 11686, 0, 2125.19, -290.218, 419.511, 1.29154, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136040, 32780, 603, 3, 1, 11686, 0, 2170.63, -259.069, 419.358, 3.14159, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136041, 32780, 603, 3, 1, 11686, 0, 2170.84, -262.182, 419.361, 3.05433, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136042, 32780, 603, 3, 1, 11686, 0, 2171.08, -266.057, 419.371, 2.94961, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136043, 32780, 603, 3, 1, 11686, 0, 2171.05, -268.252, 419.392, 2.89725, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136044, 32780, 603, 3, 1, 11686, 0, 2143.09, -290.015, 419.61, 1.8326, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136045, 32780, 603, 3, 1, 11686, 0, 2137.48, -289.132, 419.561, 1.67552, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136046, 32780, 603, 3, 1, 11686, 0, 2128.14, -289.645, 419.491, 1.36136, 180, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (136047, 32780, 603, 3, 1, 11686, 0, 2132.68, -289.045, 419.791, 1.51844, 180, 0, 0, 42, 0, 0, 0, 0, 0);



-- ###################
-- ### GENERAL VEZAX
-- ###################

-- General Vezax (33271, 33449)
UPDATE creature_template SET speed_walk=3.2, speed_run=2.28571, mindmg=7369, maxdmg=10046, attackpower=805, dmg_multiplier=7, baseattacktime=1500, AIName='', ScriptName='boss_vezax', mechanic_immune_mask=617299839, flags_extra=257+0x200000 WHERE entry=33271;
UPDATE creature_template SET speed_walk=3.2, speed_run=2.28571, mindmg=5954, maxdmg=8118, attackpower=805, dmg_multiplier=7, baseattacktime=1500, AIName='', ScriptName='', mechanic_immune_mask=617299839, flags_extra=257+0x200000 WHERE entry=33449;
DELETE FROM smart_scripts WHERE entryorguid IN(33271, 33449) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33271, 33449);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33271, 33449) AND `map`=603 );
UPDATE creature_model_info SET bounding_radius=0, combat_reach=8.0 WHERE modelid=28548;

-- Saronite Vapors (33488, 33789)
UPDATE creature_template SET AIName='', RegenHealth=0, ScriptName='npc_ulduar_saronite_vapors' WHERE entry=33488;
UPDATE creature_template SET AIName='', RegenHealth=0, ScriptName='' WHERE entry=33789;
DELETE FROM smart_scripts WHERE entryorguid IN(33488, 33789) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33488, 33789);

-- Vezax Bunny (33500)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33500));
DELETE FROM creature WHERE id IN(33500);

-- Saronite Animus (33524, 34152)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=5895, maxdmg=8006, attackpower=805, dmg_multiplier=7, baseattacktime=2000, AIName='', ScriptName='npc_ulduar_saronite_animus', mechanic_immune_mask=617299839, flags_extra=256+0x200000 WHERE entry=33524;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.14286, mindmg=4763, maxdmg=6494, attackpower=805, dmg_multiplier=7, baseattacktime=2000, AIName='', ScriptName='', mechanic_immune_mask=617299839, flags_extra=256+0x200000 WHERE entry=34152;
DELETE FROM smart_scripts WHERE entryorguid IN(33524, 34152) AND source_type=0;
DELETE FROM creature_template_addon WHERE entry IN(33524, 34152);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(33524, 34152) AND `map`=603 );
UPDATE creature_model_info SET bounding_radius=0, combat_reach=8.0 WHERE modelid=28992;

-- spell Aura of Despair (62692, 64848, 68415, 64646)
DELETE FROM spell_script_names WHERE spell_id IN(62692, 64848, 68415, 64646, -62692, -64848, -68415, -64646);
DELETE FROM spell_scripts WHERE id IN(62692, 64848, 68415, 64646, -62692, -64848, -68415, -64646);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62692, 64848, 68415, 64646, -62692, -64848, -68415, -64646) OR spell_effect IN(62692, 64848, 68415, 64646, -62692, -64848, -68415, -64646);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62692, 64848, 68415, 64646);
INSERT INTO spell_script_names VALUES(62692, 'spell_aura_of_despair');

-- spell Shadow Crash (62660, 62659, 63277, 65269)
DELETE FROM spell_script_names WHERE spell_id IN(62660, 62659, 63277, 65269, -62660, -62659, -63277, -65269);
DELETE FROM spell_scripts WHERE id IN(62660, 62659, 63277, 65269, -62660, -62659, -63277, -65269);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62660, 62659, 63277, 65269, -62660, -62659, -63277, -65269) OR spell_effect IN(62660, 62659, 63277, 65269, -62660, -62659, -63277, -65269);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(62660, 62659, 63277, 65269);
INSERT INTO spell_linked_spell VALUES(63277, 65269, 2, 'General Vezax - Shadow Crash');
INSERT INTO spell_linked_spell VALUES(-63277, -65269, 0, 'General Vezax - Shadow Crash');

-- spell Mark of the Faceless (63276, 63278)
DELETE FROM spell_script_names WHERE spell_id IN(63276, 63278, -63276, -63278);
DELETE FROM spell_scripts WHERE id IN(63276, 63278, -63276, -63278);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63276, 63278, -63276, -63278) OR spell_effect IN(63276, 63278, -63276, -63278);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63276, 63278);
INSERT INTO spell_script_names VALUES(63276, 'spell_mark_of_the_faceless_periodic');
INSERT INTO spell_script_names VALUES(63278, 'spell_mark_of_the_faceless_drainhealth');

-- spell Saronite Vapors (63323, 63322, 63338, 63337)
DELETE FROM spell_script_names WHERE spell_id IN(63323, 63322, 63338, 63337, -63323, -63322, -63338, -63337);
DELETE FROM spell_scripts WHERE id IN(63323, 63322, 63338, 63337, -63323, -63322, -63338, -63337);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63323, 63322, 63338, 63337, -63323, -63322, -63338, -63337) OR spell_effect IN(63323, 63322, 63338, 63337, -63323, -63322, -63338, -63337);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(63323, 63322, 63338, 63337);
INSERT INTO `conditions` VALUES (13, 1, 63322, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'General Vezax - Saronite Vapors');
INSERT INTO spell_script_names VALUES(63322, 'spell_saronite_vapors_dummy'),(63338, 'spell_saronite_vapors_damage');



-- ###################
-- ### YOGG-SARON
-- ###################

-- In the Maws of the Old God (64184) -- Used by Unbound Fragments of Val'anyr
DELETE FROM conditions WHERE SourceEntry IN(64184) AND SourceTypeOrReferenceId IN(13,17);
INSERT INTO conditions VALUES(13, 1, 64184, 0, 0, 31, 0, 3, 33288, 0, 0, 0, 0, '', 'Shadow Nova');
DELETE FROM spell_script_names WHERE spell_id IN(64184);
INSERT INTO spell_script_names VALUES (64184, 'spell_yogg_saron_in_the_maws_of_the_old_god');

-- SANITY HANDLING
DELETE FROM spell_script_names WHERE spell_id IN(63795, 65301, 63830, 63881, 63803, 64168, 64164, 64059) AND ScriptName='spell_yogg_saron_sanity_reduce';
INSERT INTO spell_script_names VALUES (63795, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (65301, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (63830, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (63881, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (63803, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (64168, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (64164, 'spell_yogg_saron_sanity_reduce');
INSERT INTO spell_script_names VALUES (64059, 'spell_yogg_saron_sanity_reduce');


-- Insane Periodic (64555)
DELETE FROM spell_script_names WHERE spell_id IN(64555);
INSERT INTO spell_script_names VALUES (64555, 'spell_yogg_saron_insane_periodic_trigger');

-- Insane (63120)
DELETE FROM spell_script_names WHERE spell_id IN(63120) AND ScriptName='spell_yogg_saron_insane';
INSERT INTO spell_script_names VALUES (63120, 'spell_yogg_saron_insane');

-- Sanity Well (64169)
DELETE FROM spell_script_names WHERE spell_id IN(64169);
INSERT INTO spell_script_names VALUES (64169, 'spell_yogg_saron_sanity_well');

-- Shadow Nova (62714, 65209)
DELETE FROM conditions WHERE SourceEntry IN(62714, 65209) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 2, 62714, 0, 0, 31, 0, 3, 33134, 0, 0, 0, 0, '', 'Shadow Nova');
INSERT INTO conditions VALUES(13, 2, 65209, 0, 0, 31, 0, 3, 33134, 0, 0, 0, 0, '', 'Shadow Nova');

-- Malady of the Mind (63830, 63881)
DELETE FROM spell_script_names WHERE spell_id IN(63830, 63881) AND ScriptName='spell_yogg_saron_malady_of_the_mind';
INSERT INTO spell_script_names VALUES (63830, 'spell_yogg_saron_malady_of_the_mind');
INSERT INTO spell_script_names VALUES (63881, 'spell_yogg_saron_malady_of_the_mind');

-- Malady and psychosis range
DELETE FROM conditions WHERE SourceEntry IN(63830, 63795, 65301) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 7, 63830, 0, 0, 35, 0, 1, 85, 2, 0, 0, 0, '', 'Malady of the Mind, spell ignore los :| check distance');
INSERT INTO conditions VALUES(13, 3, 63795, 0, 0, 35, 0, 1, 85, 2, 0, 0, 0, '', 'Psychosis, spell ignore los :| check distance');
INSERT INTO conditions VALUES(13, 3, 65301, 0, 0, 35, 0, 1, 85, 2, 0, 0, 0, '', 'Psychosis, spell ignore los :| check distance');

-- Brain Link (63802)
DELETE FROM spell_script_names WHERE spell_id IN(63802);
INSERT INTO spell_script_names VALUES (63802, 'spell_yogg_saron_brain_link');

-- Destabilization Matrix (65206)
DELETE FROM spell_script_names WHERE spell_id IN(65206);
INSERT INTO spell_script_names VALUES (65206, 'spell_yogg_saron_destabilization_matrix');
DELETE FROM conditions WHERE SourceEntry IN(65206) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 65206, 0, 0, 31, 0, 3, 33985, 0, 0, 0, 0, '', 'Destabilization Matrix');

-- Titanic Storm (64172)
DELETE FROM spell_script_names WHERE spell_id IN(64172);
INSERT INTO spell_script_names VALUES (64172, 'spell_yogg_saron_titanic_storm');
DELETE FROM conditions WHERE SourceEntry IN(64172) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64172, 0, 0, 31, 0, 3, 33988, 0, 0, 0, 0, '', 'Titanic Storm');

-- Shattered Illusion (64173)
DELETE FROM conditions WHERE SourceEntry IN(64173) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64173, 0, 0, 31, 0, 3, 33966, 0, 0, 0, 0, '', 'Shattered Illusion - Crusher tentacle');
INSERT INTO conditions VALUES(13, 1, 64173, 0, 1, 31, 0, 3, 33983, 0, 0, 0, 0, '', 'Shattered Illusion - Constrictor tentacle');
INSERT INTO conditions VALUES(13, 1, 64173, 0, 2, 31, 0, 3, 33985, 0, 0, 0, 0, '', 'Shattered Illusion - Corruptor tentacle');
INSERT INTO conditions VALUES(13, 1, 64173, 0, 3, 31, 0, 3, 33134, 0, 0, 0, 0, '', 'Shattered Illusion - Sara');
INSERT INTO conditions VALUES(13, 1, 64173, 0, 4, 31, 0, 3, 33288, 0, 0, 0, 0, '', 'Shattered Illusion - Yogg-Saron');

-- Cancel Illusion Room Aura (63993)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(63993);
INSERT INTO spell_linked_spell VALUES(63993, -63988, 1, "Cancel Illusion Room Aura - remove aura");
INSERT INTO spell_linked_spell VALUES(63993, 63992, 1, "Cancel Illusion Room Aura - teleport back");
REPLACE INTO spell_target_position VALUES(63992, 0, 603, 1924.69, -25.39, 328.5, 0);

-- Lunatic Gaze (64164, 64168)
DELETE FROM spell_script_names WHERE spell_id IN(64164, 64168) AND ScriptName="spell_yogg_saron_lunatic_gaze";
INSERT INTO spell_script_names VALUES(64164, "spell_yogg_saron_lunatic_gaze");
INSERT INTO spell_script_names VALUES(64168, "spell_yogg_saron_lunatic_gaze");

-- Hodir's Protective Gaze (64174)
DELETE FROM spell_script_names WHERE spell_id=64174;
INSERT INTO spell_script_names VALUES(64174, "spell_yogg_saron_protective_gaze");

-- Empowered (64161)
DELETE FROM spell_script_names WHERE spell_id=64161;
INSERT INTO spell_script_names VALUES(64161, "spell_yogg_saron_empowered");

-- Death Ray Warning Visual (63882)
-- Death Ray Damage Visual (63886)
DELETE FROM conditions WHERE SourceEntry IN(63882, 63886) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 63882, 0, 0, 31, 0, 3, 33134, 0, 0, 0, 0, '', 'Death Ray Warning Visual');
INSERT INTO conditions VALUES(13, 1, 63886, 0, 0, 31, 0, 3, 33134, 0, 0, 0, 0, '', 'Death Ray Damage Visual');

-- Deathgrasp (63037)
DELETE FROM conditions WHERE SourceEntry IN(63037) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 63037, 0, 0, 31, 0, 3, 33442, 0, 0, 0, 0, '', 'Deathgrasp');

-- Shadow Beacon (64465)
DELETE FROM conditions WHERE SourceEntry IN(64465, 64466) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64465, 0, 0, 31, 0, 3, 33988, 0, 0, 0, 0, '', 'Shadow Beacon');
INSERT INTO conditions VALUES(13, 1, 64466, 0, 0, 31, 0, 3, 33988, 0, 0, 0, 0, '', 'Shadow Beacon');

-- Empowering Shadows (64467)
DELETE FROM spell_script_names WHERE spell_id=64467;
INSERT INTO spell_script_names VALUES(64467, "spell_yogg_saron_empowering_shadows");

-- Teleport to Chamber Illusion (63997)
-- Teleport to Icecrown Illusion (63998)
-- Teleport to Stormwind Illusion (63999)
REPLACE INTO spell_target_position VALUES(63997, 0, 603, 2048.63, -25.5, 239.72, 0);
REPLACE INTO spell_target_position VALUES(63998, 0, 603, 1950.11, -79.284, 240, 4.2);
REPLACE INTO spell_target_position VALUES(63989, 0, 603, 1954.06, 21.66, 239.71, 2.1);


-- Gossip Keepers
-- Hodir (33213), Freya (33241), Thorim (33242), Mimiron (33244)
UPDATE creature_template SET npcflag=1, faction=35, flags_extra=2, AIName='', ScriptName='npc_ulduar_keeper_gossip' WHERE entry IN(33213, 33241, 33242, 33244);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33213, 33241, 33242, 33244));
DELETE FROM creature WHERE id IN(33213, 33241, 33242, 33244);
INSERT INTO creature VALUES (NULL, 33213, 603, 3, 1, 0, 0, 1939.13, -90.8332, 411.356, 1.00123, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33241, 603, 3, 1, 0, 0, 1939.32, 42.165, 411.357, 5.17955, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33242, 603, 3, 1, 0, 0, 2036.59, -73.8499, 411.355, 2.34819, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 33244, 603, 3, 1, 0, 0, 2036.81, 25.6646, 411.359, 3.74227, 300, 0, 0, 14433075, 0, 0, 0, 0, 0);

-- Encounter npcs, Freya (33410), Hodir (33411), Mimiron (33412), Thorim (33413)
UPDATE creature_template SET unit_flags=33554432+256+512, faction=35, flags_extra=2, AIName='', ScriptName='boss_yoggsaron_keeper' WHERE entry IN(33410, 33411, 33412, 33413);
REPLACE INTO creature_template_addon VALUES(33410, 0, 0, 0, 1, 0, "62647 62670");
REPLACE INTO creature_template_addon VALUES(33411, 0, 0, 0, 1, 0, "62647 62650 64174");
REPLACE INTO creature_template_addon VALUES(33412, 0, 0, 0, 1, 0, "62647 62671");
REPLACE INTO creature_template_addon VALUES(33413, 0, 0, 0, 1, 0, "62647 62702");

-- Sanity Well (33991)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33991);
DELETE FROM creature WHERE id=33991;
UPDATE creature_template SET modelid1=11686, modelid2=0, scale=0.5, unit_flags=33554432, flags_extra=128, AIName='NullCreatureAI', ScriptName='' WHERE entry=33991;
REPLACE INTO creature_template_addon VALUES(33991, 0, 0, 0, 1, 0, "63288 64169");

-- Ominous Cloud (33292)
DELETE FROM creature_text WHERE entry=33292;
INSERT INTO creature_text VALUES (33292, 0, 0, '%s begins to boil upon touching $N!', 16, 0, 100, 0, 0, 0, 0, 'Ominous Cloud - Touch emote');
UPDATE creature_template SET modelid1=11686, modelid2=0, AIName='', ScriptName='boss_yoggsaron_cloud' WHERE entry=33292;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33292);
DELETE FROM creature WHERE id=33292;

-- Sara (33134, 34332)
UPDATE creature_template SET faction=16, unit_flags=2, AIName='', ScriptName='boss_yoggsaron_sara' WHERE entry=33134;
UPDATE creature_template SET faction=16, unit_flags=2 WHERE entry=34332;
REPLACE INTO creature VALUES (62016, 33134, 603, 3, 1, 29117, 0, 1980.28, -25.5868, 329.397, 3.12414, 604800, 0, 0, 199999, 212900, 0, 0, 0, 0);

-- Guardian of Yogg-Saron (33136, 33968)
UPDATE creature_template SET difficulty_entry_1=33968, minlevel=82, maxlevel=82, faction=16, speed_walk=1.6, speed_run=1.71429, mindmg=2745, maxdmg=3743, attackpower=805, dmg_multiplier=6, baseattacktime=2000, AIName='', ScriptName='boss_yoggsaron_guardian_of_ys' WHERE entry=33136;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, speed_walk=1.6, speed_run=1.71429, mindmg=2220, maxdmg=3026, attackpower=805, dmg_multiplier=11, baseattacktime=2000, AIName='', ScriptName='' WHERE entry=33968;
DELETE FROM smart_scripts WHERE entryorguid IN(33136) AND source_type=0;

-- Yogg-Saron (33288, 33955)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33288));
DELETE FROM creature WHERE id IN(33288);
REPLACE INTO creature_model_info VALUES(28817, 0, 30, 2, 0); -- yogg-saron
UPDATE creature_template SET faction=16, mingold=2128378, maxgold=2128378, mechanic_immune_mask=650854271, flags_extra=1+0x200000, RegenHealth=0, AIName='', ScriptName='boss_yoggsaron' WHERE entry=33288;
UPDATE creature_template SET faction=16, mingold=2128378, maxgold=2128378, mechanic_immune_mask=650854271, flags_extra=1+0x200000, RegenHealth=0 WHERE entry=33955;

-- Brain of Yogg-Saron (33890, 33954)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33890));
DELETE FROM creature WHERE id IN(33890);
REPLACE INTO creature_model_info VALUES(28951, 0, 30, 2, 0); -- brain
UPDATE creature_template SET difficulty_entry_1=33954, faction=16, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_brain' WHERE entry=33890;
UPDATE creature_template SET faction=16, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33954;

-- Voice of Yogg-Saron (33280)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33280));
DELETE FROM creature WHERE id IN(33280);
UPDATE creature_template SET faction=16, modelid1=11686, modelid2=0, unit_flags=33554432, flags_extra=130, AIName='', ScriptName='boss_yoggsaron_voice' WHERE entry=33280;

-- Descend Into Madness (34072)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(34072));
DELETE FROM creature WHERE id IN(34072);
UPDATE creature_template SET npcflag=1, modelid1=29074, modelid2=0, unit_flags=2, AIName='NullCreatureAI', ScriptName='boss_yoggsaron_descend_portal' WHERE entry=34072;

-- Death Orb (33882)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33882));
DELETE FROM creature WHERE id IN(33882);
UPDATE creature_template SET faction=16, modelid1=11686, modelid2=0, unit_flags=33554432, AIName='', ScriptName='boss_yoggsaron_death_orb' WHERE entry=33882;

-- Crusher Tentacle (33966, 33967)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33966));
DELETE FROM creature WHERE id IN(33966);
REPLACE INTO creature_model_info VALUES(28814, 0, 8, 2, 0);  -- crusher tentacle
UPDATE creature_template SET difficulty_entry_1=33967, minlevel=82, maxlevel=82, mindmg=3000, maxdmg=3500, attackpower=1, dmg_multiplier=10, baseattacktime=2000, faction=16, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_crusher_tentacle' WHERE entry=33966;
UPDATE creature_template SET minlevel=82, maxlevel=82, mindmg=3000, maxdmg=3500, attackpower=1, dmg_multiplier=15, baseattacktime=2000, faction=16, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33967;

-- Constrictor Tentacle (33983, 33984)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33983));
DELETE FROM creature WHERE id IN(33983);
UPDATE creature_template SET difficulty_entry_1=33984, minlevel=82, maxlevel=82, faction=16, vehicleId=385, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_constrictor_tentacle' WHERE entry=33983;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, vehicleId=385, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33984;

-- Corruptor Tentacle (33985, 33986)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33985));
DELETE FROM creature WHERE id IN(33985);
UPDATE creature_template SET difficulty_entry_1=33986, minlevel=82, maxlevel=82, faction=16, mechanic_immune_mask=617299839, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_corruptor_tentacle' WHERE entry=33985;
UPDATE creature_template SET minlevel=82, maxlevel=82, faction=16, mechanic_immune_mask=617299839, flags_extra=0+0x200000 WHERE entry=33986;

-- Laughing Skull (33990)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33990));
DELETE FROM creature WHERE id IN(33990);
REPLACE INTO creature_template_addon VALUES(33990, 0, 0, 0, 1, 0, "64167");
UPDATE creature_template SET modelid1=15880, modelid2=0, faction=14, unit_flags=33554432, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=128+0x200000, AIName='NullCreatureAI', ScriptName='' WHERE entry=33990;

-- Influence Tentacle (33943, 33959)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33943));
DELETE FROM creature WHERE id IN(33943);
UPDATE creature_template SET difficulty_entry_1=33959, faction=16, minlevel=82, maxlevel=82, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_influence_tentacle' WHERE entry=33943;
UPDATE creature_template SET faction=16, minlevel=82, maxlevel=82, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry=33959;

-- Consorts (33716, 33717, 33718, 33719, 33720), Chamber Illusion
-- Deathsworn Zealot (33567)
-- Suit of Armor (33433)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33716, 33717, 33718, 33719, 33720, 33567, 33433));
DELETE FROM creature WHERE id IN(33716, 33717, 33718, 33719, 33720, 33567, 33433);
UPDATE creature_template SET faction=31, minlevel=82, maxlevel=82, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='' WHERE entry IN(33716, 33717, 33718, 33719, 33720, 33567, 33433);

-- King Llane (33437)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33437));
DELETE FROM creature WHERE id IN(33437);
UPDATE creature_template SET minlevel=83, maxlevel=83, AIName='', ScriptName='boss_yoggsaron_llane' WHERE entry=33437;

-- The Lich King (33441)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33441));
DELETE FROM creature WHERE id IN(33441);
UPDATE creature_template SET minlevel=83, maxlevel=83, AIName='', ScriptName='boss_yoggsaron_lich_king' WHERE entry=33441;

-- Neltharion (33523)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33523));
DELETE FROM creature WHERE id IN(33523);
UPDATE creature_template SET minlevel=83, maxlevel=83, AIName='', ScriptName='boss_yoggsaron_neltharion' WHERE entry=33523;

-- Immortal Guardian (33988, 33989)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33988));
DELETE FROM creature WHERE id IN(33988);
UPDATE creature_template SET difficulty_entry_1=33989, speed_walk=1.6, speed_run=1.71429, mindmg=400, maxdmg=430, attackpower=1, dmg_multiplier=7, baseattacktime=2000, faction=16, minlevel=82, maxlevel=82, mechanic_immune_mask=617299839, flags_extra=0+0x200000, AIName='', ScriptName='boss_yoggsaron_immortal_guardian' WHERE entry=33988;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.71429, mindmg=485, maxdmg=515, attackpower=1, dmg_multiplier=13, baseattacktime=2000, faction=16, minlevel=82, maxlevel=82, mechanic_immune_mask=617299839, flags_extra=0+0x200000 WHERE entry=33989;
UPDATE creature_template SET ScriptName='' WHERE entry=36064;

-- Immolated Champion (33442)
-- Turned Champion (33962)
-- Malygos (33535)
-- Alextrasza (33536)
-- Ysera (33495)
-- Garona (33436)
-- Yogg-Saron (33552) speaches?
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry IN(33552, 33962, 33442, 33535, 33536, 33495, 33436);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(33552, 33962, 33442, 33535, 33536, 33495, 33436));
DELETE FROM creature WHERE id IN(33552, 33962, 33442, 33535, 33536, 33495);

-- Flee to the Surface (194625), portal in brain chamber
DELETE FROM gameobject WHERE id=194625;
INSERT INTO gameobject VALUES (NULL, 194625, 603, 3, 1, 2000.65, 5.7939, 243.411, 0.855124, 0, 0, 0.414653, 0.909979, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 194625, 603, 3, 1, 1943.06, -23.5098, 244.228, 3.14063, 0, 0, 1, 0.000479654, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 194625, 603, 3, 1, 1998.42, -59.8531, 244.331, 5.75993, 0, 0, 0.258651, -0.965971, 300, 0, 1, 0);

-- The Dragon Soul (194462), used in dragons vision
DELETE FROM gameobject WHERE id=194462;
INSERT INTO gameobject VALUES (NULL, 194462, 603, 3, 1, 2104.57, -25.2984, 242.648, 6.25409, 0, 0, 0, 0, 10, 0, 1, 0);

-- TC Script removal
DELETE FROM spell_script_names WHERE ScriptName IN('spell_yogg_saron_squeeze', 'spell_yogg_saron_shattered_illusion', 'spell_yogg_saron_lunge', 'spell_yogg_saron_shadow_beacon',
'spell_yogg_saron_empowering_shadows_range_check', 'spell_yogg_saron_sanity', 'spell_yogg_saron_revealed_tentacle', 'spell_yogg_saron_psychosis', 'spell_yogg_saron_nondescript',
'spell_yogg_saron_match_health', 'spell_yogg_saron_keeper_aura', 'spell_yogg_saron_induce_madness', 'spell_yogg_saron_hate_to_zero', 'spell_yogg_saron_diminsh_power',
'spell_yogg_saron_death_ray_warning_visual', 'spell_yogg_saron_constrictor_tentacle', 'spell_yogg_saron_cancel_illusion_room_aura', 'spell_yogg_saron_brain_link_damage', 'spell_yogg_saron_boil_ominously');


-- ###################
-- ### ALGALON THE OBSERVER
-- ###################

-- ----------------------------
-- Quests, Pre fight stuff
-- ----------------------------
-- Sigil quests
DELETE FROM conditions WHERE SourceEntry IN (45788, 45815, 45784, 45817, 45814, 45786, 45787, 45816) AND SourceTypeOrReferenceId=4;

-- The Celestial Planetarium (13607)
-- Heroic: The Celestial Planetarium (13816)
UPDATE quest_template SET SpecialFlags=2 WHERE Id IN(13607, 13816);
DELETE FROM areatrigger_involvedrelation WHERE Id=5401;
REPLACE INTO areatrigger_scripts VALUES(5401, "at_celestial_planetarium_enterance");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry`= 33235 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 13, 33235, 0, 0, 13, 1, 4, 3, 0, 0, 0, 0, '', 'Execute SAI only if Assembly of Iron Done');

-- ----------------------------
-- Fight stuff
-- ----------------------------
-- Reorigination (64996)
DELETE FROM conditions WHERE SourceEntry IN(64996) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 64996, 0, 0, 31, 0, 3, 34246, 0, 0, 0, 0, '', 'Algalon the Observer - Reorigination on Azeroth');

-- Phase Punch (64412)
DELETE FROM spell_script_names WHERE spell_id=64412;
INSERT INTO spell_script_names VALUES (64412, 'spell_algalon_phase_punch');

-- Collapse (62018)
DELETE FROM spell_script_names WHERE spell_id=62018;
INSERT INTO spell_script_names VALUES (62018, 'spell_algalon_collapse');

-- Trigger 3 Adds (62266)
DELETE FROM conditions WHERE SourceEntry IN(62266) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62266, 0, 0, 31, 0, 3, 33052, 0, 0, 0, 0, '', 'Algalon the Observer - target Living Constellation');
DELETE FROM spell_script_names WHERE spell_id=62266;
INSERT INTO spell_script_names VALUES (62266, 'spell_algalon_trigger_3_adds');

-- Arcane Barrage (64599, 64607)
DELETE FROM spell_script_names WHERE spell_id IN(64599, 64607);

-- Constellation Phase Effect (65509)
DELETE FROM conditions WHERE SourceEntry IN(65509) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 65509, 0, 0, 31, 0, 3, 33052, 0, 0, 0, 0, '', 'Black Hole - target Living Constellation');

-- Black Hole Credit (65312)
DELETE FROM conditions WHERE SourceEntry IN(65312) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 65312, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Black Hole - target players');

-- Cosmic Smash (x)
DELETE FROM spell_script_names WHERE spell_id IN(62295, 62311, 64596); -- 3 on purpose
INSERT INTO spell_script_names VALUES (62311, 'spell_algalon_cosmic_smash_damage');
INSERT INTO spell_script_names VALUES (64596, 'spell_algalon_cosmic_smash_damage');
DELETE FROM conditions WHERE SourceEntry IN(62304, 64597) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 62304, 0, 0, 31, 0, 3, 33104, 0, 0, 0, 0, '', 'Cosmic Smash - target trigger');
INSERT INTO conditions VALUES(13, 1, 64597, 0, 0, 31, 0, 3, 33104, 0, 0, 0, 0, '', 'Cosmic Smash - target trigger');

-- Big Bang (64443, 64584)
DELETE FROM spell_script_names WHERE spell_id IN(64443, 64584);
INSERT INTO spell_script_names VALUES (64443, 'spell_algalon_big_bang');
INSERT INTO spell_script_names VALUES (64584, 'spell_algalon_big_bang');

-- Spell Remove Phase (64445)
DELETE FROM spell_script_names WHERE spell_id IN(64445);
INSERT INTO spell_script_names VALUES (64445, 'spell_algalon_remove_phase');

-- Supermassive Fail (65311)
DELETE FROM spell_script_names WHERE spell_id IN(65311);
INSERT INTO spell_script_names VALUES (65311, 'spell_algalon_supermassive_fail');

-- Black Hole (62168)
-- Worm Hole (65250)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(62168, 65250, 64417);
INSERT INTO spell_linked_spell VALUES(62168, 62169, 1, 'Black Hole (Algalon)');
INSERT INTO spell_linked_spell VALUES(65250, 62169, 1, 'Worm Hole (Algalon)');
INSERT INTO spell_linked_spell VALUES(64417, 62169, 1, 'Phase Punch (Algalon)');


-- Brann Bronzebeard (34064)
UPDATE creature_template SET minlevel=80, maxlevel=80, faction=35, unit_flags=33536, AIName='', ScriptName='npc_brann_bronzebeard_algalon' WHERE entry=34064;

-- Algalon the Observer (32871, 33070)
UPDATE creature_model_info SET bounding_radius=0.93, combat_reach=9, gender=0 WHERE modelid=28641; -- Algalon the Observer
UPDATE creature_template SET mindmg=8620, maxdmg=11752, attackpower=805, dmg_multiplier=5, speed_walk=4, speed_run=2.14286, exp=2, minlevel=83, maxlevel=83, faction=190, unit_flags=33024, BaseAttackTime=1000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='boss_algalon_the_observer' WHERE entry=32871;
UPDATE creature_template SET mindmg=6965, maxdmg=9495, attackpower=805, dmg_multiplier=10, speed_walk=4, speed_run=2.14286, exp=2, minlevel=83, maxlevel=83, faction=190, unit_flags=33024, BaseAttackTime=1000, mechanic_immune_mask=650854271, flags_extra=1+0x200000, AIName='', ScriptName='' WHERE entry=33070;

-- Azeroth (34246)
UPDATE creature_model_info SET bounding_radius=0.02, combat_reach=0.2, gender=2 WHERE modelid=29133; -- Azeroth
UPDATE creature_template SET faction=190, exp=2, minlevel=83, maxlevel=83, unit_flags=33554432, speed_run=1, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=34246;

-- Collapsing Star (32955, 34215)
UPDATE creature_model_info SET bounding_radius=1, combat_reach=1, gender=2 WHERE modelid=28988; -- Collapsing Star
UPDATE creature_template SET faction=14, speed_run=1, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='npc_collapsing_star' WHERE entry=32955;
UPDATE creature_template SET faction=14, speed_run=1, RegenHealth=0, mechanic_immune_mask=650854271, flags_extra=0+0x200000, AIName='', ScriptName='' WHERE entry=34215;

-- Black Hole (32953, 34296)
UPDATE creature_model_info SET bounding_radius=1, combat_reach=0.1, gender=2 WHERE modelid=28460; -- Black Hole
UPDATE creature_template SET difficulty_entry_1=34296, faction=14, exp=2, minlevel=80, maxlevel=80, unit_flags=33554432, speed_run=1,InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=32953; 
UPDATE creature_template SET faction=14, exp=2, minlevel=80, maxlevel=80, unit_flags=33554432, speed_run=1, InhabitType=4, AIName='', ScriptName='' WHERE entry=34296; 

-- Algalon Void Zone Visual Stalker (34100)
UPDATE creature_template SET faction=14, unit_flags=33554432, AIName='NullCreatureAI' WHERE entry=34100;

-- Algalon Stalker (33086)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=33086);
DELETE FROM creature WHERE id=33086;

-- Living Constellation (33052, 33116)
UPDATE creature_model_info SET bounding_radius=0.62, combat_reach=0, gender=2 WHERE modelid=28741; -- Living Constellation
UPDATE creature_template SET faction=14, unit_flags=33587200, speed_run=1, InhabitType=4, mechanic_immune_mask=650854239, AIName='', ScriptName='npc_living_constellation' WHERE entry=33052; 
UPDATE creature_template SET faction=14, unit_flags=33587200, speed_run=1, InhabitType=4, mechanic_immune_mask=650854239, AIName='', ScriptName='' WHERE entry=33116; 

-- Algalon Stalker Asteroid Target 01 (33104)
-- Algalon Stalker Asteroid Target 02 (33105) (34131)
REPLACE INTO creature_template_addon VALUES(33104, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(33105, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(34131, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET faction=14, exp=2, minlevel=80, maxlevel=80, unit_flags=33554432, InhabitType=4, flags_extra=128, AIName='NullCreatureAI', ScriptName='' WHERE entry=33104;
UPDATE creature_template SET faction=14, exp=2, minlevel=80, maxlevel=80, unit_flags=33554432, InhabitType=4, flags_extra=128, AIName='NullCreatureAI', ScriptName='' WHERE entry=33105;
UPDATE creature_template SET faction=14, exp=2, minlevel=80, maxlevel=80, unit_flags=33554432, InhabitType=4, flags_extra=128, AIName='', ScriptName='' WHERE entry=34131;

-- Worm Hole (34099)
UPDATE creature_template SET faction=14, unit_flags=33554432, speed_run=1, InhabitType=4, AIName='', ScriptName='npc_algalon_worm_hole' WHERE entry=34099;

-- Dark Matter (33089, 34221)
DELETE FROM creature WHERE guid IN (41781,41783,41790,41811,41812,41814,41819,41820,41821,41822,41823,41875);
INSERT INTO creature VALUES
(41812,33089,603,3,16,0,0,1622.451,-321.1563,417.6188,4.677482,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41814,33089,603,3,16,0,0,1649.438,-319.8127,418.3941,1.082104,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41819,33089,603,3,16,0,0,1615.060,-291.6816,417.7796,3.490659,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41820,33089,603,3,16,0,0,1647.005,-288.6790,417.3955,3.490659,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41821,33089,603,3,16,0,0,1622.451,-321.1563,417.6188,4.677482,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41822,33089,603,3,16,0,0,1649.438,-319.8127,418.3941,1.082104,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41823,33089,603,3,16,0,0,1615.060,-291.6816,417.7796,3.490659,10,20,0,1,0,1,0,0,0), -- Dark Matter
(41875,33089,603,3,16,0,0,1647.005,-288.6790,417.3955,3.490659,10,20,0,1,0,1,0,0,0); -- Dark Matter
UPDATE creature_template SET mindmg=1800, maxdmg=2400, attackpower=805, dmg_multiplier=3, faction=14, minlevel=81, maxlevel=81, unit_flags=32768, speed_walk=4, speed_run=1.42857, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(33089);
UPDATE creature_template SET mindmg=1800, maxdmg=2400, attackpower=805, dmg_multiplier=5, faction=14, minlevel=81, maxlevel=81, unit_flags=32768, speed_walk=4, speed_run=1.42857, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(34221);

-- Unleashed Dark Matter (34097, 34222)
UPDATE creature_template SET mindmg=1800, maxdmg=2400, attackpower=805, dmg_multiplier=3, faction=14, minlevel=81, maxlevel=81, unit_flags=32768, speed_walk=4, speed_run=1.42857, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(34097);
UPDATE creature_template SET mindmg=1800, maxdmg=2400, attackpower=805, dmg_multiplier=5, faction=14, minlevel=81, maxlevel=81, unit_flags=32768, speed_walk=4, speed_run=1.42857, InhabitType=4, mechanic_immune_mask=650854271, flags_extra=0+0x200000 WHERE entry IN(34222);

-- Celestial Planetarium Access (194628, 194752)
UPDATE gameobject_template SET ScriptName='go_celestial_planetarium_access' WHERE entry IN(194628, 194752); 

DELETE FROM creature_text WHERE entry IN (32871,34064);
INSERT INTO creature_text (entry,groupid,id,text,type,sound,emote,comment) VALUES
(34064,0,0,'We did it, lads! We got here before Algalon''s arrival. Maybe we can rig the systems to interfere with his analysis--',14,15824,0,'Brann Bronzebeard - SAY_BRANN_ALGALON_INTRO_1'),
(34064,1,0,'I''ll head back to the Archivum and see if I can jam his signal. I might be able to buy us some time while you take care of him.',12,15825,0,'Brann Bronzebeard - SAY_BRANN_ALGALON_INTRO_2'),
(34064,2,0,'I know just the place. Will you be all right?',14,15823,6,'Brann Bronzebeard - SAY_BRANN_ALGALON_OUTRO'),
(32871,0,0,'Translocation complete. Commencing planetary analysis of Azeroth.',12,15405,0,'Algalon the Observer - SAY_ALGALON_INTRO_1'),
(32871,1,0,'Stand back, mortals. I''m not here to fight you.',12,15406,0,'Algalon the Observer - SAY_ALGALON_INTRO_2'),
(32871,2,0,'It is in the universe''s best interest to re-originate this planet should my analysis find systemic corruption. Do not interfere.',12,15407,0,'Algalon the Observer - SAY_ALGALON_INTRO_3'),
(32871,3,0,'Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer''s message regardless of outcome.',14,15386,0,'Algalon the Observer - SAY_ALGALON_START_TIMER'),
(32871,4,0,'See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.',14,15390,1,'Algalon the Observer - SAY_ALGALON_AGGRO'),
(32871,5,0,'The stars come to my aid!',14,15392,0,'Algalon the Observer - SAY_ALGALON_COLLAPSING_STAR'),
(32871,6,0,'%s begins to Summon Collapsing Stars!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_COLLAPSING_STAR'),
(32871,7,0,'Witness the fury of the cosmos!',14,15396,0,'Algalon the Observer - SAY_ALGALONG_BIG_BANG'),
(32871,8,0,'%s begins to cast Big Bang!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_BIG_BANG'),
(32871,9,0,'You are out of time.',14,15394,0,'Algalon the Observer - SAY_ALGALON_ASCEND'),
(32871,10,0,'%s begins to cast Cosmic Smash!',41,0,0,'Algalon the Observer - EMOTE_ALGALON_COSMIC_SMASH'),
(32871,11,0,'Behold the tools of creation!',14,15397,0,'Algalon the Observer - SAY_ALGALON_PHASE_TWO'),
(32871,12,0,'I have seen worlds bathed in the Makers'' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?',14,15393,1,'Algalon the Observer - SAY_ALGALON_OUTRO_1'),
(32871,13,0,'Perhaps it is your imperfections... that which grants you free will... that allows you to persevere against all cosmically calculated odds. You prevail where the Titan''s own perfect creations have failed.',14,15401,1,'Algalon the Observer - SAY_ALGALON_OUTRO_2'),
(32871,14,0,'I''ve rearranged the reply code - your planet will be spared. I cannot be certain of my own calculations anymore.',14,15402,1,'Algalon the Observer - SAY_ALGALON_OUTRO_3'),
(32871,15,0,'I lack the strength to transmit the signal. You must... hurry... find a place of power... close to the skies.',14,15403,1,'Algalon the Observer - SAY_ALGALON_OUTRO_4'),
(32871,16,0,'Do not worry about my fate, Bronzen. If the signal is not transmitted in time, re-origination will proceed regardless. Save... your world...',14,15404,1,'Algalon the Observer - SAY_ALGALON_OUTRO_5'),
(32871,17,0,'Analysis complete. There is partial corruption in the planet''s life-support systems as well as complete corruption in most of the planet''s defense mechanisms.',12,15398,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_1'),
(32871,18,0,'Begin uplink: Reply Code: ''Omega''. Planetary re-origination requested.',12,15399,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_2'),
(32871,19,0,'Farewell, mortals. Your bravery is admirable, for such flawed creatures.',12,15400,0,'Algalon the Observer - SAY_ALGALON_DESPAWN_3'),
(32871,20,0,'Loss of life unavoidable.',14,15387,0,'Algalon the Observer - SAY_ALGALON_KILL'),
(32871,20,1,'I do what I must.',14,15388,0,'Algalon the Observer - SAY_ALGALON_KILL');

-- Misc fixes
DELETE FROM spelldifficulty_dbc WHERE id IN(3262, 3263, 3264, 3265, 3266, 3267);
INSERT INTO spelldifficulty_dbc VALUES (3262, 64395, 64592, 0, 0);
INSERT INTO spelldifficulty_dbc VALUES (3263, 64599, 64607, 0, 0);
INSERT INTO spelldifficulty_dbc VALUES (3264, 64443, 64584, 0, 0);
INSERT INTO spelldifficulty_dbc VALUES (3265, 64122, 65108, 0, 0);
INSERT INTO spelldifficulty_dbc VALUES (3266, 62301, 64598, 0, 0);
INSERT INTO spelldifficulty_dbc VALUES (3267, 62304, 64597, 0, 0);
UPDATE instance_encounters SET creditType=1, creditEntry=65184 WHERE entry IN (757, 771); -- Algalon the Observer


-- delete Gift of the Observer, spawned manually
DELETE FROM gameobject WHERE id IN(194821,194822);




-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- XT-002 Deconstructor
-- Nerf Engineering (10 player) (2931)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10074);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10074);
INSERT INTO achievement_criteria_data VALUES(10074, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10074, 11, 0, 0, 'achievement_xt002_nerf_engineering');

-- Nerf Engineering (25 player) (2932)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10075);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10075);
INSERT INTO achievement_criteria_data VALUES(10075, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10075, 11, 0, 0, 'achievement_xt002_nerf_engineering');

-- Nerf Gravity Bombs (10 player) (2934)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10077);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10077);
INSERT INTO achievement_criteria_data VALUES(10077, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10077, 11, 0, 0, 'achievement_xt002_nerf_gravity_bombs');

-- Nerf Gravity Bombs (25 player) (2936)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10079);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10079);
INSERT INTO achievement_criteria_data VALUES(10079, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10079, 11, 0, 0, 'achievement_xt002_nerf_gravity_bombs');

-- Must Deconstruct Faster (10 player) (2937)
-- Must Deconstruct Faster (25 player) (2938)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10080, 10081);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10080, 10081);
INSERT INTO achievement_criteria_data VALUES(10080, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10081, 12, 1, 0, '');

-- Heartbreaker (10 player) (3058)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10221);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10221);
INSERT INTO achievement_criteria_data VALUES(10221, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10221, 7, 65737, 1, '');

-- Heartbreaker (25 player) (3059)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10220);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10220);
INSERT INTO achievement_criteria_data VALUES(10220, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10220, 7, 64193, 1, '');

-- Nerf Scrapbots (10 player) (2933)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10401);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10401);
INSERT INTO achievement_criteria_data VALUES(10401, 12, 0, 0, '');

-- Nerf Scrapbots (25 player) (2935)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10402);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10402);
INSERT INTO achievement_criteria_data VALUES(10402, 12, 1, 0, '');

-- Assembly Of Iron
-- But I'm On Your Side (10 player) (2945)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10088, 10418, 10419);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10088, 10418, 10419);
INSERT INTO achievement_criteria_data VALUES(10088, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10088, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10088, 11, 0, 0, 'achievement_but_im_on_your_side');
INSERT INTO achievement_criteria_data VALUES(10418, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10418, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10418, 11, 0, 0, 'achievement_but_im_on_your_side');
INSERT INTO achievement_criteria_data VALUES(10419, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10419, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10419, 11, 0, 0, 'achievement_but_im_on_your_side');

-- But I'm On Your Side (25 player) (2946)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10089, 10420, 10421);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10089, 10420, 10421);
INSERT INTO achievement_criteria_data VALUES(10089, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10089, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10089, 11, 0, 0, 'achievement_but_im_on_your_side');
INSERT INTO achievement_criteria_data VALUES(10420, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10420, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10420, 11, 0, 0, 'achievement_but_im_on_your_side');
INSERT INTO achievement_criteria_data VALUES(10421, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10421, 5, 58501, 0, '');
INSERT INTO achievement_criteria_data VALUES(10421, 11, 0, 0, 'achievement_but_im_on_your_side');

-- I Choose You, Runemaster Molgeim (10 player) (2939)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10082);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10082);
INSERT INTO achievement_criteria_data VALUES(10082, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10082, 11, 0, 0, 'achievement_assembly_runemaster');

-- I Choose You, Runemaster Molgeim (25 player) (2942)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10085);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10085);
INSERT INTO achievement_criteria_data VALUES(10085, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10085, 11, 0, 0, 'achievement_assembly_runemaster');

-- I Choose You, Stormcaller Brundir (10 player) (2940)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10083);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10083);
INSERT INTO achievement_criteria_data VALUES(10083, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10083, 11, 0, 0, 'achievement_assembly_stormcaller');

-- I Choose You, Stormcaller Brundir (25 player) (2943)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10086);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10086);
INSERT INTO achievement_criteria_data VALUES(10086, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10086, 11, 0, 0, 'achievement_assembly_stormcaller');

-- I Choose You, Steelbreaker (10 player) (2941)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10084);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10084);
INSERT INTO achievement_criteria_data VALUES(10084, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10084, 11, 0, 0, 'achievement_assembly_steelbreaker');

-- I Choose You, Steelbreaker (25 player) (2944)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10087);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10087);
INSERT INTO achievement_criteria_data VALUES(10087, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10087, 11, 0, 0, 'achievement_assembly_steelbreaker');

-- Can't Do That While Stunned (10 player) (2947)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10090, 10422, 10423);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10090, 10422, 10423);
INSERT INTO achievement_criteria_data VALUES(10090, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10090, 11, 0, 0, 'achievement_cant_do_that_while_stunned');
INSERT INTO achievement_criteria_data VALUES(10422, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10422, 11, 0, 0, 'achievement_cant_do_that_while_stunned');
INSERT INTO achievement_criteria_data VALUES(10423, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10423, 11, 0, 0, 'achievement_cant_do_that_while_stunned');

-- Can't Do That While Stunned (25 player) (2948)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10091, 10424, 10425);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10091, 10424, 10425);
INSERT INTO achievement_criteria_data VALUES(10091, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10091, 11, 0, 0, 'achievement_cant_do_that_while_stunned');
INSERT INTO achievement_criteria_data VALUES(10424, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10424, 11, 0, 0, 'achievement_cant_do_that_while_stunned');
INSERT INTO achievement_criteria_data VALUES(10425, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10425, 11, 0, 0, 'achievement_cant_do_that_while_stunned');

-- Kologarn
-- Disarmed (10 player) (2953)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10284);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10284);
INSERT INTO achievement_criteria_data VALUES(10284, 12, 0, 0, '');

-- Disarmed (25 player) (2954)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10722);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10722);
INSERT INTO achievement_criteria_data VALUES(10722, 12, 1, 0, '');

-- If Looks Could Kill (10 player) (2955)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10286);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10286);
INSERT INTO achievement_criteria_data VALUES(10286, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10286, 11, 0, 0, 'achievement_kologarn_looks_could_kill');

-- If Looks Could Kill (25 player) (2956)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10099);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10099);
INSERT INTO achievement_criteria_data VALUES(10099, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10099, 11, 0, 0, 'achievement_kologarn_looks_could_kill');

-- Rubble and Roll (10 player) (2959)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10290);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10290);
INSERT INTO achievement_criteria_data VALUES(10290, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10290, 11, 0, 0, 'achievement_kologarn_rubble_and_roll');

-- Rubble and Roll (25 player) (2960)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10133);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10133);
INSERT INTO achievement_criteria_data VALUES(10133, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10133, 11, 0, 0, 'achievement_kologarn_rubble_and_roll');

-- With Open Arms (10 player) (2951)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10285);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10285);
INSERT INTO achievement_criteria_data VALUES(10285, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10285, 11, 0, 0, 'achievement_kologarn_with_open_arms');

-- With Open Arms (25 player) (2952)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10095);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10095);
INSERT INTO achievement_criteria_data VALUES(10095, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10095, 11, 0, 0, 'achievement_kologarn_with_open_arms');

-- Ignis the Furnace Master
-- Hot Pocket (10 player) (2927)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10430);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10430);
INSERT INTO achievement_criteria_data VALUES(10430, 12, 0, 0, '');

-- Hot Pocket (25 player) (2928)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10431);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10431);
INSERT INTO achievement_criteria_data VALUES(10431, 12, 1, 0, '');

-- Shattered (10 player) (2925)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10068);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10068);
INSERT INTO achievement_criteria_data VALUES(10068, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10068, 11, 0, 0, 'achievement_ignis_shattered');

-- Shattered (25 player) (2926)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10069);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10069);
INSERT INTO achievement_criteria_data VALUES(10069, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10069, 11, 0, 0, 'achievement_ignis_shattered');

-- Stokin' the Furnace (10 player) (2930)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10073);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10073);
INSERT INTO achievement_criteria_data VALUES(10073, 12, 0, 0, '');

-- Stokin' the Furnace (25 player) (2929)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10072);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10072);
INSERT INTO achievement_criteria_data VALUES(10072, 12, 1, 0, '');

-- Auriaya
-- Crazy Cat Lady (10 player) (3006)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10400);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10400);
INSERT INTO achievement_criteria_data VALUES(10400, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10400, 11, 0, 0, 'achievement_auriaya_crazy_cat_lady');

-- Crazy Cat Lady (25 player) (3007)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10184);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10184);
INSERT INTO achievement_criteria_data VALUES(10184, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10184, 11, 0, 0, 'achievement_auriaya_crazy_cat_lady');

-- Nine Lives (10 player) (3076)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10399);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10399);
INSERT INTO achievement_criteria_data VALUES(10399, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10399, 11, 0, 0, 'achievement_auriaya_nine_lives');

-- Nine Lives (25 player) (3077)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10243);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10243);
INSERT INTO achievement_criteria_data VALUES(10243, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10243, 11, 0, 0, 'achievement_auriaya_nine_lives');

-- Thorim
-- Don't Stand in the Lightning (10 player) (2971)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10305);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10305);
INSERT INTO achievement_criteria_data VALUES(10305, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10305, 11, 0, 0, 'achievement_thorim_stand_in_the_lightning');

-- Don't Stand in the Lightning (25 player) (2972)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10309);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10309);
INSERT INTO achievement_criteria_data VALUES(10309, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10309, 11, 0, 0, 'achievement_thorim_stand_in_the_lightning');

-- I'll Take You All On (10 player) (2973)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10303, 10287, 10288);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10303, 10287, 10288);
INSERT INTO achievement_criteria_data VALUES(10303, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10287, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10288, 12, 0, 0, '');

-- I'll Take You All On (25 player) (2974)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10310, 10311, 10312);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10310, 10311, 10312);
INSERT INTO achievement_criteria_data VALUES(10310, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10311, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10312, 12, 1, 0, '');

-- Lose Your Illusion (10 player) (3176)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10440);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10440);
INSERT INTO achievement_criteria_data VALUES(10440, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10440, 11, 0, 0, 'achievement_thorim_lose_your_illusion');

-- Lose Your Illusion (25 player) (3183)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10457);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10457);
INSERT INTO achievement_criteria_data VALUES(10457, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10457, 11, 0, 0, 'achievement_thorim_lose_your_illusion');

-- Siffed (10 player) (2977)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10289);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10289);
INSERT INTO achievement_criteria_data VALUES(10289, 12, 0, 0, '');

-- Siffed (25 player) (2978)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10314);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10314);
INSERT INTO achievement_criteria_data VALUES(10314, 12, 1, 0, '');

-- Who Needs Bloodlust? (10 player) (2975)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10304);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10304);
INSERT INTO achievement_criteria_data VALUES(10304, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10304, 5, 62320, 0, '');

-- Who Needs Bloodlust? (25 player) (2976)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10313);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10313);
INSERT INTO achievement_criteria_data VALUES(10313, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10313, 5, 62320, 0, '');

-- Razorscale
-- A Quick Shave (10 player) (2919)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10062);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10062);
INSERT INTO achievement_criteria_data VALUES(10062, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10062, 11, 0, 0, 'achievement_quick_shave');

-- A Quick Shave (25 player) (2921)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10063);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10063);
INSERT INTO achievement_criteria_data VALUES(10063, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10063, 11, 0, 0, 'achievement_quick_shave');

-- Iron Dwarf, Medium Rare (10 player) (2923)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10066);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10066);
INSERT INTO achievement_criteria_data VALUES(10066, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10066, 11, 0, 0, 'achievement_iron_dwarf_medium_rare');

-- Iron Dwarf, Medium Rare (25 player) (2924)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10067);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10067);
INSERT INTO achievement_criteria_data VALUES(10067, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10067, 11, 0, 0, 'achievement_iron_dwarf_medium_rare');

-- Freya
-- Getting Back to Nature (10 player) (2982)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10445);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10445);
INSERT INTO achievement_criteria_data VALUES(10445, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10445, 11, 0, 0, 'achievement_freya_getting_back_to_nature');

-- Getting Back to Nature (25 player) (2983)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10758);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10758);
INSERT INTO achievement_criteria_data VALUES(10758, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10758, 11, 0, 0, 'achievement_freya_getting_back_to_nature');

-- Knock on Wood (10 player) (3177)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10447);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10447);
INSERT INTO achievement_criteria_data VALUES(10447, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10447, 11, 0, 0, 'achievement_freya_knock_on_wood');

-- Knock on Wood (25 player) (3185)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10459);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10459);
INSERT INTO achievement_criteria_data VALUES(10459, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10459, 11, 0, 0, 'achievement_freya_knock_on_wood');

-- Knock, Knock on Wood (10 player) (3178)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10448);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10448);
INSERT INTO achievement_criteria_data VALUES(10448, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10448, 11, 0, 0, 'achievement_freya_knock_knock_on_wood');

-- Knock, Knock on Wood (25 player) (3186)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10460);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10460);
INSERT INTO achievement_criteria_data VALUES(10460, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10460, 11, 0, 0, 'achievement_freya_knock_knock_on_wood');

-- Knock, Knock, Knock on Wood (10 player) (3179)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10449);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10449);
INSERT INTO achievement_criteria_data VALUES(10449, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10449, 11, 0, 0, 'achievement_freya_knock_knock_knock_on_wood');

-- Knock, Knock, Knock on Wood (25 player) (3187)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10461);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10461);
INSERT INTO achievement_criteria_data VALUES(10461, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10461, 11, 0, 0, 'achievement_freya_knock_knock_knock_on_wood');

-- Con-speed-atory (10 player) (2980)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10446);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10446);
INSERT INTO achievement_criteria_data VALUES(10446, 12, 0, 0, '');

-- Con-speed-atory (25 player) (2981)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10882);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10882);
INSERT INTO achievement_criteria_data VALUES(10882, 12, 1, 0, '');

-- Lumberjacked (10 player) (2979)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10720);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10720);
INSERT INTO achievement_criteria_data VALUES(10720, 12, 0, 0, '');

-- Lumberjacked (25 player) (3118)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10721);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10721);
INSERT INTO achievement_criteria_data VALUES(10721, 12, 1, 0, '');

-- Deforestation (10 player) (2985)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10396, 10397);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10396, 10397);
INSERT INTO achievement_criteria_data VALUES(10396, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10397, 12, 0, 0, '');

-- Deforestation (25 player) (2984)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10394, 10395);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10394, 10395);
INSERT INTO achievement_criteria_data VALUES(10394, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10395, 12, 1, 0, '');

-- Yogg-Saron
-- They're Coming Out of the Walls (10 player) (3014)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10293);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10293);
INSERT INTO achievement_criteria_data VALUES(10293, 12, 0, 0, '');

-- They're Coming Out of the Walls (25 player) (3017)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10294);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10294);
INSERT INTO achievement_criteria_data VALUES(10294, 12, 1, 0, '');

-- He's Not Getting Any Older (10 player) (3012)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10292);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10292);
INSERT INTO achievement_criteria_data VALUES(10292, 12, 0, 0, '');

-- He's Not Getting Any Older (25 player) (3013)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10291);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10291);
INSERT INTO achievement_criteria_data VALUES(10291, 12, 1, 0, '');

-- Drive Me Crazy (10 player) (3008)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10185);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10185);
INSERT INTO achievement_criteria_data VALUES(10185, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10185, 11, 0, 0, 'achievement_yogg_saron_drive_me_crazy');

-- Drive Me Crazy (25 player) (3010)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10296);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10296);
INSERT INTO achievement_criteria_data VALUES(10296, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10296, 11, 0, 0, 'achievement_yogg_saron_drive_me_crazy');

-- Three Lights in the Darkness (10 player) (3157)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10410);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10410);
INSERT INTO achievement_criteria_data VALUES(10410, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10410, 11, 0, 0, 'achievement_yogg_saron_three_lights_in_the_darkness');

-- Three Lights in the Darkness (25 player) (3161)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10414);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10414);
INSERT INTO achievement_criteria_data VALUES(10414, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10414, 11, 0, 0, 'achievement_yogg_saron_three_lights_in_the_darkness');

-- Two Lights in the Darkness (10 player) (3141)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10388);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10388);
INSERT INTO achievement_criteria_data VALUES(10388, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10388, 11, 0, 0, 'achievement_yogg_saron_two_lights_in_the_darkness');

-- Two Lights in the Darkness (25 player) (3162)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10415);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10415);
INSERT INTO achievement_criteria_data VALUES(10415, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10415, 11, 0, 0, 'achievement_yogg_saron_two_lights_in_the_darkness');

-- One Light in the Darkness (10 player) (3158)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10409);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10409);
INSERT INTO achievement_criteria_data VALUES(10409, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10409, 11, 0, 0, 'achievement_yogg_saron_one_light_in_the_darkness');

-- One Light in the Darkness (25 player) (3163)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10416);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10416);
INSERT INTO achievement_criteria_data VALUES(10416, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10416, 11, 0, 0, 'achievement_yogg_saron_one_light_in_the_darkness');

-- Alone in the Darkness (10 player) (3159)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10412);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10412);
INSERT INTO achievement_criteria_data VALUES(10412, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10412, 11, 0, 0, 'achievement_yogg_saron_alone_in_the_darkness');

-- Alone in the Darkness (25 player) (3164)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10417);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10417);
INSERT INTO achievement_criteria_data VALUES(10417, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10417, 11, 0, 0, 'achievement_yogg_saron_alone_in_the_darkness');

-- In His House He Waits Dreaming (10 player) (3015)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10324, 10325, 10326);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10324, 10325, 10326);
INSERT INTO achievement_criteria_data VALUES(10324, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10324, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_stormwind');
INSERT INTO achievement_criteria_data VALUES(10325, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10325, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_chamber');
INSERT INTO achievement_criteria_data VALUES(10326, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10326, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_icecrown');

-- In His House He Waits Dreaming (25 player) (3016)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10321, 10322, 10323);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10321, 10322, 10323);
INSERT INTO achievement_criteria_data VALUES(10321, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10321, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_stormwind');
INSERT INTO achievement_criteria_data VALUES(10322, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10322, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_chamber');
INSERT INTO achievement_criteria_data VALUES(10323, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10323, 11, 0, 0, 'achievement_yogg_saron_he_waits_dreaming_icecrown');

-- Kiss and Make Up (10 player) (3009)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10187);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10187);
INSERT INTO achievement_criteria_data VALUES(10187, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10187, 11, 0, 0, 'achievement_yogg_saron_kiss_and_make_up');

-- Kiss and Make Up (25 player) (3011)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10189);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10189);
INSERT INTO achievement_criteria_data VALUES(10189, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10189, 11, 0, 0, 'achievement_yogg_saron_kiss_and_make_up');

-- Realm First! Death's Demise (25 player) (3117)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10279);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10279);
INSERT INTO achievement_criteria_data VALUES(10279, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10279, 11, 0, 0, 'achievement_yogg_saron_alone_in_the_darkness');

-- Hodir
-- Cheese the Freeze (10 player) (2961)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10259);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10259);
INSERT INTO achievement_criteria_data VALUES(10259, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10259, 11, 0, 0, 'achievement_cheese_the_freeze');

-- Cheese the Freeze (25 player) (2962)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10261);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10261);
INSERT INTO achievement_criteria_data VALUES(10261, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10261, 11, 0, 0, 'achievement_cheese_the_freeze');

-- Getting Cold in Here (10 player) (2967)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10247);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10247);
INSERT INTO achievement_criteria_data VALUES(10247, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10247, 11, 0, 0, 'achievement_getting_cold_in_here');

-- Getting Cold in Here (25 player) (2968)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10248);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10248);
INSERT INTO achievement_criteria_data VALUES(10248, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10248, 11, 0, 0, 'achievement_getting_cold_in_here');

-- I Could Say That This Cache Was Rare (10 player) (3182)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10452);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10452);
INSERT INTO achievement_criteria_data VALUES(10452, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10452, 11, 0, 0, 'achievement_i_could_say_that_this_cache_was_rare');

-- I Could Say That This Cache Was Rare (25 player) (3184)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10458);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10458);
INSERT INTO achievement_criteria_data VALUES(10458, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10458, 11, 0, 0, 'achievement_i_could_say_that_this_cache_was_rare');

-- I Have the Coolest Friends (10 player) (2963)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10258);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10258);
INSERT INTO achievement_criteria_data VALUES(10258, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10258, 11, 0, 0, 'achievement_i_have_the_coolest_friends');

-- I Have the Coolest Friends (25 player) (2965)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10260);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10260);
INSERT INTO achievement_criteria_data VALUES(10260, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10260, 11, 0, 0, 'achievement_i_have_the_coolest_friends');

-- Staying Buffed All Winter (10 player) (2969)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10223, 10240, 10241);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10223, 10240, 10241);
INSERT INTO achievement_criteria_data VALUES(10223, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10223, 11, 0, 0, 'achievement_staying_buffed_all_winter_10');
INSERT INTO achievement_criteria_data VALUES(10240, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10240, 11, 0, 0, 'achievement_staying_buffed_all_winter_10');
INSERT INTO achievement_criteria_data VALUES(10241, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10241, 11, 0, 0, 'achievement_staying_buffed_all_winter_10');

-- Staying Buffed All Winter (25 player) (2970)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10229, 10238, 10239);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10229, 10238, 10239);
INSERT INTO achievement_criteria_data VALUES(10229, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10229, 11, 0, 0, 'achievement_staying_buffed_all_winter_25');
INSERT INTO achievement_criteria_data VALUES(10238, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10238, 11, 0, 0, 'achievement_staying_buffed_all_winter_25');
INSERT INTO achievement_criteria_data VALUES(10239, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10239, 11, 0, 0, 'achievement_staying_buffed_all_winter_25');

-- Mimiron
-- Firefighter (10 player) (3180)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10450);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10450);
INSERT INTO achievement_criteria_data VALUES(10450, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10450, 11, 0, 0, 'achievement_mimiron_firefighter');

-- Firefighter (25 player) (3189)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10463);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10463);
INSERT INTO achievement_criteria_data VALUES(10463, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10463, 11, 0, 0, 'achievement_mimiron_firefighter');

-- Not-So-Friendly Fire (10 player) (3138)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10406);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10406);
INSERT INTO achievement_criteria_data VALUES(10406, 12, 0, 0, '');

-- Not-So-Friendly Fire (25 player) (2995)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10405);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10405);
INSERT INTO achievement_criteria_data VALUES(10405, 12, 1, 0, '');

-- Set Up Us the Bomb (10 player) (2989)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10543, 10544, 10545);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10543, 10544, 10545);
INSERT INTO achievement_criteria_data VALUES(10543, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10543, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_11');
INSERT INTO achievement_criteria_data VALUES(10544, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10544, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_13');
INSERT INTO achievement_criteria_data VALUES(10545, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10545, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_12');

-- Set Up Us the Bomb (25 player) (3237)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10546, 10547, 10548);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10546, 10547, 10548);
INSERT INTO achievement_criteria_data VALUES(10546, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10546, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_11');
INSERT INTO achievement_criteria_data VALUES(10547, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10547, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_13');
INSERT INTO achievement_criteria_data VALUES(10548, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10548, 11, 0, 0, 'achievement_mimiron_set_up_us_the_bomb_12');

-- General Vezax
-- I Love the Smell of Saronite in the Morning (10 player) (3181)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10451);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10451);
INSERT INTO achievement_criteria_data VALUES(10451, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10451, 11, 0, 0, 'achievement_smell_saronite');

-- I Love the Smell of Saronite in the Morning (25 player) (3188)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10462);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10462);
INSERT INTO achievement_criteria_data VALUES(10462, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10462, 11, 0, 0, 'achievement_smell_saronite');

-- Shadowdodger (10 player) (2996)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10173);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10173);
INSERT INTO achievement_criteria_data VALUES(10173, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10173, 11, 0, 0, 'achievement_shadowdodger');

-- Shadowdodger (25 player) (2997)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10306);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10306);
INSERT INTO achievement_criteria_data VALUES(10306, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10306, 11, 0, 0, 'achievement_shadowdodger');

-- Flame Leviathan
-- Orbital Bombardment (10 player) (2913)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10056);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10056);
INSERT INTO achievement_criteria_data VALUES(10056, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10056, 11, 0, 0, 'achievement_flame_leviathan_orbital_bombardment');

-- Orbital Bombardment (25 player) (2918)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10061);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10061);
INSERT INTO achievement_criteria_data VALUES(10061, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10061, 11, 0, 0, 'achievement_flame_leviathan_orbital_bombardment');

-- Orbital Devastation (10 player) (2914)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10057);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10057);
INSERT INTO achievement_criteria_data VALUES(10057, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10057, 11, 0, 0, 'achievement_flame_leviathan_orbital_devastation');

-- Orbital Devastation (25 player) (2916)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10059);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10059);
INSERT INTO achievement_criteria_data VALUES(10059, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10059, 11, 0, 0, 'achievement_flame_leviathan_orbital_devastation');

-- Nuked from Orbit (10 player) (2915)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10058);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10058);
INSERT INTO achievement_criteria_data VALUES(10058, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10058, 11, 0, 0, 'achievement_flame_leviathan_nuked_from_orbit');

-- Nuked from Orbit (25 player) (2917)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10060);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10060);
INSERT INTO achievement_criteria_data VALUES(10060, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10060, 11, 0, 0, 'achievement_flame_leviathan_nuked_from_orbit');

-- Orbit-uary (10 player) (3056)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10218);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10218);
INSERT INTO achievement_criteria_data VALUES(10218, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10218, 11, 0, 0, 'achievement_flame_leviathan_orbituary');

-- Orbit-uary (25 player) (3057)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10219);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10219);
INSERT INTO achievement_criteria_data VALUES(10219, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10219, 11, 0, 0, 'achievement_flame_leviathan_orbituary');

-- Shutout (10 player) (2911)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10054);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10054);
INSERT INTO achievement_criteria_data VALUES(10054, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10054, 11, 0, 0, 'achievement_flame_leviathan_shutout');

-- Shutout (25 player) (2912)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10055);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10055);
INSERT INTO achievement_criteria_data VALUES(10055, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10055, 11, 0, 0, 'achievement_flame_leviathan_shutout');

-- Take Out Those Turrets (10 player) (2909)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10619);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10619);
INSERT INTO achievement_criteria_data VALUES(10619, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10619, 1, 33142, 0, '');

-- Take Out Those Turrets (25 player) (2910)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10620);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10620);
INSERT INTO achievement_criteria_data VALUES(10620, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10620, 1, 33142, 0, '');

-- Three Car Garage (10 player) (2907)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10046, 10047, 10048);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10046, 10047, 10048);
INSERT INTO achievement_criteria_data VALUES(10046, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10046, 11, 0, 0, 'achievement_flame_leviathan_garage_chopper');
INSERT INTO achievement_criteria_data VALUES(10047, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10047, 11, 0, 0, 'achievement_flame_leviathan_garage_siege_engine');
INSERT INTO achievement_criteria_data VALUES(10048, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10048, 11, 0, 0, 'achievement_flame_leviathan_garage_demolisher');

-- Three Car Garage (25 player) (2908)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10049, 10050, 10051);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10049, 10050, 10051);
INSERT INTO achievement_criteria_data VALUES(10049, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10049, 11, 0, 0, 'achievement_flame_leviathan_garage_chopper');
INSERT INTO achievement_criteria_data VALUES(10050, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10050, 11, 0, 0, 'achievement_flame_leviathan_garage_siege_engine');
INSERT INTO achievement_criteria_data VALUES(10051, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10051, 11, 0, 0, 'achievement_flame_leviathan_garage_demolisher');

-- Unbroken (10 player) (2905)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10044);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10044);
INSERT INTO achievement_criteria_data VALUES(10044, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10044, 11, 0, 0, 'achievement_flame_leviathan_unbroken');

-- Unbroken (25 player) (2906)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10045);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10045);
INSERT INTO achievement_criteria_data VALUES(10045, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10045, 11, 0, 0, 'achievement_flame_leviathan_unbroken');

-- Algalon
-- Observed (10 player) (3036)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10567);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10567);
INSERT INTO achievement_criteria_data VALUES(10567, 12, 0, 0, '');

-- Observed (25 player) (3037)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10569);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10569);
INSERT INTO achievement_criteria_data VALUES(10569, 12, 1, 0, '');

-- Realm First! Celestial Defender (3259)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10698);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10698);
INSERT INTO achievement_criteria_data VALUES(10698, 12, 1, 0, '');

-- Supermassive (10 player) (3003)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10780, 10781);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10780, 10781);
INSERT INTO achievement_criteria_data VALUES(10780, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10781, 12, 0, 0, '');

-- Supermassive (25 player) (3002)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10782, 10783);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10782, 10783);
INSERT INTO achievement_criteria_data VALUES(10782, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10783, 12, 1, 0, '');

-- He Feeds On Your Tears (10 player) (3004)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10568);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10568);
INSERT INTO achievement_criteria_data VALUES(10568, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10568, 11, 0, 0, 'achievement_algalon_he_feeds_on_your_tears');

-- He Feeds On Your Tears (25 player) (3005)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10570);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10570);
INSERT INTO achievement_criteria_data VALUES(10570, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10570, 11, 0, 0, 'achievement_algalon_he_feeds_on_your_tears');

-- Herald of the Titans (3316)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10678);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10678);
INSERT INTO achievement_criteria_data VALUES(10678, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10678, 11, 0, 0, 'achievement_algalon_herald_of_the_titans');

-- Shared
-- And I'll Form the Head! (4626)
DELETE FROM disables WHERE sourceType=4 AND entry IN(13009);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(13009); -- this is not used in this type

-- Champion of Ulduar (10 player) (2903)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10042,10342,10340,10341,10598,10348,10351,10439,10403,10582,10347,10349,10350);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10042,10342,10340,10341,10598,10348,10351,10439,10403,10582,10347,10349,10350);
INSERT INTO achievement_criteria_data VALUES(10042, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10042, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10342, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10342, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10340, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10340, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10341, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10341, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10598, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10598, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10348, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10348, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10351, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10351, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10439, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10439, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10403, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10403, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10582, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10582, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10347, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10347, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10349, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10349, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10350, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10350, 18, 0, 0, '');

-- Conqueror of Ulduar (25 player) (2904)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10352,10355,10353,10354,10599,10357,10363,10719,10404,10583,10361,10362,10364);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10352,10355,10353,10354,10599,10357,10363,10719,10404,10583,10361,10362,10364);
INSERT INTO achievement_criteria_data VALUES(10352, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10352, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10355, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10355, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10353, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10353, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10354, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10354, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10599, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10599, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10357, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10357, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10363, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10363, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10719, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10719, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10404, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10404, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10583, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10583, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10361, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10361, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10362, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10362, 18, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10364, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10364, 18, 0, 0, '');

-- The Antechamber of Ulduar (10 player) (2888)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10578,10008,10010);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10578,10008,10010);
INSERT INTO achievement_criteria_data VALUES(10578, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10008, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10010, 12, 0, 0, '');

-- The Antechamber of Ulduar (25 player) (2889)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10579,10016,10018);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10579,10016,10018);
INSERT INTO achievement_criteria_data VALUES(10579, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10016, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10018, 12, 1, 0, '');

-- The Descent into Madness (10 player) (2892)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10023, 10024);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10023, 10024);
INSERT INTO achievement_criteria_data VALUES(10023, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10024, 12, 0, 0, '');

-- The Descent into Madness (25 player) (2893)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10025, 10026);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10025, 10026);
INSERT INTO achievement_criteria_data VALUES(10025, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10026, 12, 1, 0, '');

-- The Keepers of Ulduar (10 player) (2890)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10408, 10438, 10444, 10014);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10408, 10438, 10444, 10014);
INSERT INTO achievement_criteria_data VALUES(10408, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10438, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10444, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10014, 12, 0, 0, '');

-- The Keepers of Ulduar (25 player) (2891)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10453, 10454, 10455, 10456);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10453, 10454, 10455, 10456);
INSERT INTO achievement_criteria_data VALUES(10453, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10454, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10455, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10456, 12, 1, 0, '');

-- The Secrets of Ulduar (10 player) (2894)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10027, 10028, 10029, 10030);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10027, 10028, 10029, 10030);

-- The Secrets of Ulduar (25 player) (2895)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10031, 10032, 10033, 10034);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10031, 10032, 10033, 10034);

-- The Siege of Ulduar (10 player) (2886)
DELETE FROM disables WHERE sourceType=4 AND entry IN(9999, 10000, 10001, 10002);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(9999, 10000, 10001, 10002);
INSERT INTO achievement_criteria_data VALUES(9999, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10000, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10001, 12, 0, 0, '');
INSERT INTO achievement_criteria_data VALUES(10002, 12, 0, 0, '');

-- The Siege of Ulduar (25 player) (2887)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10003, 10004, 10005, 10006);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10003, 10004, 10005, 10006);
INSERT INTO achievement_criteria_data VALUES(10003, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10004, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10005, 12, 1, 0, '');
INSERT INTO achievement_criteria_data VALUES(10006, 12, 1, 0, '');

-- Val'anyr, Hammer of Ancient Kings (3142)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10838);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10838);

-- Dwarfageddon (10 player) (3097)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10858);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10858);
INSERT INTO achievement_criteria_data VALUES(10858, 12, 0, 0, '');

-- Dwarfageddon (25 player) (3098)
DELETE FROM disables WHERE sourceType=4 AND entry IN(10860);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(10860);
INSERT INTO achievement_criteria_data VALUES(10860, 12, 1, 0, '');

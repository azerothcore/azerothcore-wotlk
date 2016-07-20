DELETE FROM disables WHERE sourceType=2 AND entry IN(658);
REPLACE INTO `access_requirement` VALUES (658, 0, 78, 0, 180, 0, 0, 24499, 24511, 0, NULL, 'Pit of Saron (Entrance)');
REPLACE INTO `access_requirement` VALUES (658, 1, 80, 0, 200, 0, 0, 24499, 24511, 0, NULL, 'Pit of Saron (Entrance)');



-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Ball and chain (201969)
REPLACE INTO `gameobject_template` VALUES (201969, 10, 181, 'Ball and chain', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 86, 0, 0, 1, 0, 1, 0, 0, 0, 0, 71291, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
UPDATE gameobject SET spawntimesecs=86400 WHERE id=201969 AND `map`=658;
DELETE FROM smart_scripts WHERE entryorguid IN(201969) AND source_type=1;

-- Halls of Reflection Portcullis (201848)
REPLACE INTO `gameobject_template` VALUES (201848, 0, 9174, 'Halls of Reflection Portcullis', '', '', '', 0, 16, 1, 0, 0, 0, 0, 0, 0, 0, 920, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

-- Ice Wall (201885)
UPDATE gameobject SET state=1 WHERE id=201885;



-- ###################
-- ### NPCS
-- ###################

-- Scourgelord Tyrannus (36794) - for events
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36794) and `map`=658 );
REPLACE INTO creature_template_addon VALUES(36794, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature WHERE id IN(36794) AND `map`=658;
INSERT INTO `creature` VALUES (201851, 36794, 658, 3, 1, 0, 0, 522.35, 226.427, 548.0, 3.14, 86400, 0, 0, 107848, 4169, 0, 0, 0, 0);
REPLACE INTO `creature_template` VALUES (36794, 0, 0, 0, 0, 0, 27982, 0, 0, 0, 'Scourgelord Tyrannus', '', '', 0, 82, 82, 2, 21, 0, 3, 3, 1, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 551, 0, 0, '', 0, 4, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, 'npc_pos_tyrannus_events', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36794) AND source_type=0;
REPLACE INTO areatrigger_scripts VALUES(5578, 'SmartTrigger'), (5579, 'SmartTrigger'), (5580, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid IN(5578, 5579, 5580) AND source_type=2;
INSERT INTO `smart_scripts` VALUES (5578, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 201851, 36794, 0, 0, 0, 0, 0, 'on area trigger - setdata for npc Tyrannus');
INSERT INTO `smart_scripts` VALUES (5579, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 201851, 36794, 0, 0, 0, 0, 0, 'on area trigger - setdata for npc Tyrannus');
INSERT INTO `smart_scripts` VALUES (5580, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, 201851, 36794, 0, 0, 0, 0, 0, 'on area trigger - setdata for npc Tyrannus');

-- Scourgelord Tyrannus (36795) - custom, for texts/voices
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36795) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36795);
DELETE FROM creature WHERE id IN(36795) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36795, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Scourgelord Tyrannus', '', '', 0, 82, 82, 2, 35, 0, 2, 1.5873, 1, 1, 463, 640, 0, 726, 7.5, 2000, 0, 2, 832, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 551, 0, 0, 'NullCreatureAI', 0, 4, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36795) AND source_type=0;

-- Deathwhisper Necrolyte (36788, 37609)
DELETE FROM creature_template_addon WHERE entry IN(36788, 37609);
UPDATE creature SET modelid=0, unit_flags=0 WHERE id IN(36788, 37609) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36788, 37609, 0, 0, 0, 0, 22196, 0, 0, 0, 'Deathwhisper Necrolyte', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_deathwhisper_necrolyte', 12340);
REPLACE INTO `creature_template` VALUES (37609, 0, 0, 0, 0, 0, 22196, 0, 0, 0, 'Deathwhisper Necrolyte (1)', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36788, 37609) AND source_type=0;

-- Skeletal Slave (36881, 37656)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36881, 37656) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36881, 37656);
REPLACE INTO `creature_template` VALUES (36881, 37656, 0, 0, 0, 0, 9785, 0, 0, 0, 'Skeletal Slave', '', '', 0, 80, 80, 0, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37656, 0, 0, 0, 0, 0, 9785, 0, 0, 0, 'Skeletal Slave (1)', '', '', 0, 80, 80, 0, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36881, 37656) AND source_type=0;

-- Lady Sylvanas Windrunner (36990) (first)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36990) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36990);
DELETE FROM creature WHERE id IN(36990) AND `map`=658;
INSERT INTO `creature` VALUES (NULL, 36990, 658, 3, 1, 0, 1, 424.46, 212.16, 528.8, 0.0, 86400, 0, 0, 6972500, 85160, 0, 0, 0, 0);
REPLACE INTO `creature_template` VALUES (36990, 0, 0, 0, 0, 0, 28213, 0, 0, 0, 'Lady Sylvanas Windrunner', 'Banshee Queen', '', 0, 83, 83, 2, 1770, 2, 0.888888, 0.99206, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 33088, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 500, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_leader', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36990) AND source_type=0;

-- Lady Sylvanas Windrunner (38189) (second)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38189) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(38189);
DELETE FROM creature WHERE id IN(38189) AND `map`=658;
REPLACE INTO `creature_template` VALUES (38189, 0, 0, 0, 0, 0, 28213, 0, 0, 0, 'Lady Sylvanas Windrunner', 'Banshee Queen', '', 0, 83, 83, 2, 1770, 2, 0.888888, 0.99206, 1, 3, 496, 674, 0, 783, 35, 2000, 0, 2, 33088, 2048, 8, 0, 0, 0, 0, 0, 365, 529, 98, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 500, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_leader_second', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(38189) AND source_type=0;

-- Lady Jaina Proudmoore (36993) (first)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36993) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36993);
DELETE FROM creature WHERE id IN(36993) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36993, 0, 0, 0, 0, 0, 30867, 0, 0, 0, 'Lady Jaina Proudmoore', '', '', 0, 83, 83, 2, 1770, 2, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 0, 0, 8, 33088, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 500, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_leader', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36993) AND source_type=0;

-- Lady Jaina Proudmoore (38188) (second)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(38188) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(38188);
DELETE FROM creature WHERE id IN(38188) AND `map`=658;
REPLACE INTO `creature_template` VALUES (38188, 0, 0, 0, 0, 0, 30867, 0, 0, 0, 'Lady Jaina Proudmoore', '', '', 0, 83, 83, 2, 1770, 2, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 0, 0, 8, 33088, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 500, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_leader_second', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(38188) AND source_type=0;

-- Dark Ranger Kalira (37583,37608)
-- in file "icc_the_forge_of_souls.sql"
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37583,37608) and `map`=658 );
DELETE FROM creature WHERE id IN(37583,37608) AND `map`=658;

-- Dark Ranger Loralen (37779,37797)
-- in file "icc_the_forge_of_souls.sql"
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37779,37797) and `map`=658 );
DELETE FROM creature WHERE id IN(37779,37797) AND `map`=658;

-- Archmage Elandra (37774,37809)
-- in file "icc_the_forge_of_souls.sql"
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37774,37809) and `map`=658 );
DELETE FROM creature WHERE id IN(37774,37809) AND `map`=658;

-- Archmage Koreln (37582,37628)
-- in file "icc_the_forge_of_souls.sql"
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37582,37628) and `map`=658 );
DELETE FROM creature WHERE id IN(37582,37628) AND `map`=658;

-- Coliseum Champion (37584,37624,37587,37625,37588,37623,37496,37604,37497,37603)
-- in file "icc_the_forge_of_souls.sql"
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37584,37624,37587,37625,37588,37623,37496,37604,37497,37603) and `map`=658 );
DELETE FROM creature WHERE id IN(37584,37624,37587,37625,37588,37623,37496,37604,37497,37603) AND `map`=658;

-- Corrupted Champion (36796, 37657)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36796, 37657) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36796, 37657);
DELETE FROM creature WHERE id IN(36796, 37657) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36796, 37657, 0, 0, 0, 0, 9785, 0, 0, 0, 'Corrupted Champion', '', '', 0, 80, 80, 0, 1771, 0, 1, 1, 1, 0, 300, 400, 0, 300, 1, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37657, 0, 0, 0, 0, 0, 9785, 0, 0, 0, 'Corrupted Champion (1)', '', '', 0, 80, 80, 0, 1771, 0, 1, 1, 1, 0, 300, 400, 0, 300, 2, 0, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36796, 37657) AND source_type=0;

-- Alliance Slave (36764, 37645, 36765, 37646, 36766, 37647, 36767, 37648)
REPLACE INTO `creature_template` VALUES (36764, 37645, 0, 0, 0, 0, 30368, 30369, 30370, 30371, 'Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37645, 0, 0, 0, 0, 0, 30368, 30369, 30370, 30371, 'Alliance Slave (1)', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36765, 37646, 0, 0, 0, 0, 30372, 30373, 0, 0, 'Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.42857, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 256, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37646, 0, 0, 0, 0, 0, 30372, 30373, 0, 0, 'Alliance Slave (1)', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 256, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36766, 37647, 0, 0, 0, 0, 30374, 30375, 0, 0, 'Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37647, 0, 0, 0, 0, 0, 30374, 30375, 0, 0, 'Alliance Slave (1)', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36767, 37648, 0, 0, 0, 0, 30376, 30377, 30379, 30378, 'Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 0, 0, 8, 256, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37648, 0, 0, 0, 0, 0, 30376, 30377, 30379, 30378, 'Alliance Slave (1)', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 0, 0, 8, 256, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36764, 37645, 36765, 37646, 36766, 37647, 36767, 37648) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36764, 37645, 36765, 37646, 36766, 37647, 36767, 37648);
UPDATE creature SET modelid=0, equipment_id=1, spawntimesecs=86400, spawndist=0, npcflag=0, unit_flags=0, dynamicflags=0 WHERE id IN(36764, 37645, 36765, 37646, 36766, 37647, 36767, 37648) AND `map`=658;
REPLACE INTO creature_template_addon VALUES(36764, 0, 0, 0, 1, 233, ""),(37645, 0, 0, 0, 1, 233, ""),(36765, 0, 0, 0, 1, 233, ""),(37646, 0, 0, 0, 1, 233, ""),(36766, 0, 0, 0, 1, 233, ""),(37647, 0, 0, 0, 1, 233, ""),(36767, 0, 0, 0, 1, 233, ""),(37648, 0, 0, 0, 1, 233, "");
DELETE FROM smart_scripts WHERE entryorguid IN(36764, 36765, 36766, 36767) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(3676400, 3676500, 3676600, 3676700) AND source_type=9;

-- Horde Slave (36770, 37649, 36771, 37650, 36772, 37651, 36773, 37652)
REPLACE INTO `creature_template` VALUES (36770, 37649, 0, 0, 0, 0, 30380, 30381, 30382, 30383, 'Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37649, 0, 0, 0, 0, 0, 30380, 30381, 30382, 30383, 'Horde Slave (1)', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36771, 37650, 0, 0, 0, 0, 30384, 30385, 0, 0, 'Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 256, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37650, 0, 0, 0, 0, 0, 30384, 30385, 0, 0, 'Horde Slave (1)', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 256, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36772, 37651, 0, 0, 0, 0, 30386, 30387, 0, 0, 'Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37651, 0, 0, 0, 0, 0, 30386, 30387, 0, 0, 'Horde Slave (1)', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 256, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (36773, 37652, 0, 0, 0, 0, 30388, 30389, 30390, 30391, 'Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 256, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37652, 0, 0, 0, 0, 0, 30388, 30389, 30390, 30391, 'Horde Slave (1)', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 256, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36770, 37649, 36771, 37650, 36772, 37651, 36773, 37652) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36770, 37649, 36771, 37650, 36772, 37651, 36773, 37652);
UPDATE creature SET modelid=0, equipment_id=1, spawntimesecs=86400, spawndist=0, npcflag=0, unit_flags=0, dynamicflags=0 WHERE id IN(36770, 37649, 36771, 37650, 36772, 37651, 36773, 37652) AND `map`=658;
REPLACE INTO creature_template_addon VALUES(36770, 0, 0, 0, 1, 233, ""),(37649, 0, 0, 0, 1, 233, ""),(36771, 0, 0, 0, 1, 233, ""),(37650, 0, 0, 0, 1, 233, ""),(36772, 0, 0, 0, 1, 233, ""),(37651, 0, 0, 0, 1, 233, ""),(36773, 0, 0, 0, 1, 233, ""),(37652, 0, 0, 0, 1, 233, "");
DELETE FROM smart_scripts WHERE entryorguid IN(36770, 36771, 36772, 36773) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(3677000, 3677100, 3677200, 3677300) AND source_type=9;

-- Martin Victus (37591, 37606) (first)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37591, 37606) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37591, 37606);
DELETE FROM creature WHERE id IN(37591, 37606) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37591, 37606, 0, 0, 0, 0, 30696, 0, 0, 0, 'Martin Victus', '', '', 0, 80, 80, 2, 35, 2, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_after_first_boss', 12340);
REPLACE INTO `creature_template` VALUES (37606, 0, 0, 0, 0, 0, 30696, 0, 0, 0, 'Martin Victus (1)', '', '', 0, 80, 80, 2, 35, 2, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 0, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37591, 37606) AND source_type=0;

-- Gorkun Ironskull (37592, 37607) (first)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37592, 37607) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37592, 37607);
DELETE FROM creature WHERE id IN(37592, 37607) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37592, 37607, 0, 0, 0, 0, 30697, 0, 0, 0, 'Gorkun Ironskull', '', '', 0, 80, 80, 2, 714, 2, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_after_first_boss', 12340);
REPLACE INTO `creature_template` VALUES (37607, 0, 0, 0, 0, 0, 30697, 0, 0, 0, 'Gorkun Ironskull (1)', '', '', 0, 80, 80, 2, 714, 2, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 0, 0, 1, 320, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37592, 37607) AND source_type=0;

-- ELM General Purpose Bunny (23837)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(23837) and `map`=658 );
DELETE FROM creature WHERE id IN(23837) AND `map`=658;

-- ELM General Purpose Bunny Large (24110)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(24110) and `map`=658 );
DELETE FROM creature WHERE id IN(24110) AND `map`=658;

-- Pit of Saron Front Formation Bunny (37222)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37222) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37222);
DELETE FROM creature WHERE id IN(37222) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37222, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Pit of Saron Front Formation Bunny', '', '', 0, 80, 80, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37222) AND source_type=0;

-- Collapsing Icicle (36847)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36847) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36847);
DELETE FROM creature WHERE id IN(36847) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36847, 0, 0, 0, 0, 0, 28470, 0, 0, 0, 'Collapsing Icicle', '', '', 0, 80, 80, 0, 16, 0, 1, 0.99206, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33587716, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 'npc_pos_collapsing_icicle', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36847) AND source_type=0;
-- INSERT INTO `smart_scripts` VALUES (36847, 0, 0, 1, 1, 0, 100, 0, 2500, 2500, 10000, 10000, 11, 69428, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'visual');
-- INSERT INTO `smart_scripts` VALUES (36847, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 69426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'falling');
-- INSERT INTO `smart_scripts` VALUES (36847, 0, 2, 0, 1, 0, 100, 0, 7000, 7000, 10000, 10000, 3, 0, 11686, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'visual');
-- INSERT INTO `smart_scripts` VALUES (36847, 0, 3, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'react state passive');

-- Invisible Stalker (36848)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36848) );
DELETE FROM creature_template_addon WHERE entry IN(36848);
DELETE FROM creature WHERE id IN(36848);
REPLACE INTO `creature_template` VALUES (36848, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Invisible Stalker', '', '', 0, 1, 1, 0, 35, 0, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 0, 0, 1, 33554688, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, 'npc_pos_icicle_trigger', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36848) AND source_type=0;
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1069.45, -62.9611, 633.487, 5.62209, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1067.64, 83.5788, 631.246, 1.75793, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 957.65, -104.435, 594.986, 5.84201, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1071.36, 71.4207, 631.02, 0.905772, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1063.58, 61.5467, 632.006, 2.0014, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1071.73, 49.6449, 630.645, 1.83254, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1069.97, 35.4211, 629.795, 3.41119, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1081.9, 27.8284, 630.615, 1.65583, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1072.59, 16.2381, 634.224, 1.84432, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1077.48, 2.70322, 634.39, 0.956822, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1068.65, -9.91327, 633.787, 0.16357, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1075.39, -21.0343, 632.921, 1.25135, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1060.44, -26.7372, 634.149, 2.97922, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1069.47, -39.8899, 633.694, 1.25527, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1059.5, -53.0283, 633.732, 1.49482, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1060.01, -71.2702, 633.754, 1.29847, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1039.38, -103.634, 629.478, 1.88359, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1045.06, -116.863, 628.813, 0.359921, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1031.18, -120.585, 626.813, 0.568052, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1025.79, -133.448, 624.741, 0.0653972, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 1011.79, -133.339, 621.58, 6.16794, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 999.664, -137.534, 616.744, 5.48072, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 999.291, -125.691, 614.914, 0.363851, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 986.026, -130.328, 608.756, 5.09195, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 981.524, -123.391, 604.768, 4.98592, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 970.905, -125.074, 600.073, 4.38509, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 969.434, -113.96, 597.206, 6.22685, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (NULL, 36848, 658, 3, 1, 0, 0, 954.362, -117.255, 595.956, 0.1675, 300, 0, 0, 42, 0, 0, 0, 0, 0);

-- Martin Victus (37580, 37614) (second)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37580, 37614) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37580, 37614);
DELETE FROM creature WHERE id IN(37580, 37614) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37580, 37614, 0, 0, 0, 0, 30672, 0, 0, 0, 'Martin Victus', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 578, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_martin_or_gorkun_second', 12340);
REPLACE INTO `creature_template` VALUES (37614, 0, 0, 0, 0, 0, 30672, 0, 0, 0, 'Martin Victus (1)', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 0, 0, 1, 578, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37580, 37614) AND source_type=0;

-- Gorkun Ironskull (37581, 37618) (second)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37581, 37618) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37581, 37618);
DELETE FROM creature WHERE id IN(37581, 37618) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37581, 37618, 0, 0, 0, 0, 30683, 0, 0, 0, 'Gorkun Ironskull', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 578, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_martin_or_gorkun_second', 12340);
REPLACE INTO `creature_template` VALUES (37618, 0, 0, 0, 0, 0, 30683, 0, 0, 0, 'Gorkun Ironskull (1)', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 0, 0, 1, 578, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37581, 37618) AND source_type=0;

-- Freed Horde Slave (37577, 37578, 37579)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37577, 37578, 37579) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37577, 37578, 37579);
DELETE FROM creature WHERE id IN(37577, 37578, 37579) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37577, 0, 0, 0, 0, 0, 30673, 30674, 30675, 30676, 'Freed Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_freed_slave', 12340);
REPLACE INTO `creature_template` VALUES (37578, 0, 0, 0, 0, 0, 30681, 30682, 0, 0, 'Freed Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_freed_slave', 12340);
REPLACE INTO `creature_template` VALUES (37579, 0, 0, 0, 0, 0, 30680, 30679, 30678, 30677, 'Freed Horde Slave', '', '', 0, 80, 80, 2, 714, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_freed_slave', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37577, 37578, 37579) AND source_type=0;
INSERT INTO smart_scripts VALUES (37577, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37577, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 8000, 10000, 11, 59992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cleave');
INSERT INTO smart_scripts VALUES (37577, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 4000, 5000, 11, 69566, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Heroic Strike');
INSERT INTO smart_scripts VALUES (37577, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 15000, 30000, 11, 69565, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shield Block');
INSERT INTO smart_scripts VALUES (37578, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37578, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 5000, 7000, 11, 70425, 0, 0, 0, 0, 0, 19, 37577, 0, 0, 0, 0, 0, 0, 'Chain Heal');
INSERT INTO smart_scripts VALUES (37579, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37579, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 11, 70421, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blizzard');
INSERT INTO smart_scripts VALUES (37579, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 4000, 4000, 11, 69570, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO smart_scripts VALUES (37579, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 69571, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Nova');

-- Freed Alliance Slave (37572, 37575, 37576)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37572, 37575, 37576) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37572, 37575, 37576);
DELETE FROM creature WHERE id IN(37572, 37575, 37576) AND `map`=658;
REPLACE INTO `creature_template` VALUES (37572, 0, 0, 0, 0, 0, 30669, 30668, 30670, 30671, 'Freed Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59992, 69565, 69566, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_freed_slave', 12340);
REPLACE INTO `creature_template` VALUES (37575, 0, 0, 0, 0, 0, 30662, 30663, 0, 0, 'Freed Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70425, 69569, 70517, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 10, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, 'npc_pos_freed_slave', 12340);
REPLACE INTO `creature_template` VALUES (37576, 0, 0, 0, 0, 0, 30667, 30666, 30665, 30664, 'Freed Alliance Slave', '', '', 0, 80, 80, 2, 534, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 0, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70421, 69571, 69570, 46604, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_pos_freed_slave', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37572, 37575, 37576) AND source_type=0;
INSERT INTO smart_scripts VALUES (37572, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37572, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 8000, 10000, 11, 59992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cleave');
INSERT INTO smart_scripts VALUES (37572, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 4000, 5000, 11, 69566, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Heroic Strike');
INSERT INTO smart_scripts VALUES (37572, 0, 3, 0, 0, 0, 100, 0, 2000, 8000, 15000, 30000, 11, 69565, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shield Block');
INSERT INTO smart_scripts VALUES (37575, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37575, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 5000, 7000, 11, 70425, 0, 0, 0, 0, 0, 19, 37577, 0, 0, 0, 0, 0, 0, 'Chain Heal');
INSERT INTO smart_scripts VALUES (37576, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - set invincible hp level');
INSERT INTO smart_scripts VALUES (37576, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 25000, 11, 70421, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blizzard');
INSERT INTO smart_scripts VALUES (37576, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 4000, 4000, 11, 69570, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO smart_scripts VALUES (37576, 0, 3, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 69571, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Nova');

-- Overlord Drakuru (28717)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(28717) and `map`=658 );
DELETE FROM creature WHERE id IN(28717) AND `map`=658;

-- Invisible Stalker (All Phases) (32780)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(32780) and `map`=658 );
DELETE FROM creature WHERE id IN(32780) AND `map`=658;

-- Wrathbone Laborer (36830, 37638)
DELETE FROM creature_template_addon WHERE entry IN(36830, 37638);
REPLACE INTO `creature_template` VALUES (36830, 37638, 0, 0, 0, 0, 30364, 30365, 30365, 0, 'Wrathbone Laborer', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 13, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37638, 0, 0, 0, 0, 0, 30364, 30365, 30365, 0, 'Wrathbone Laborer (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 21, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36830, 37638) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36830, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 10000, 15000, 11, 70302, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Blinding Dirt');
INSERT INTO `smart_scripts` VALUES (36830, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 7000, 9000, 11, 70278, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Puncture Wound');
INSERT INTO `smart_scripts` VALUES (36830, 0, 2, 0, 0, 0, 100, 0, 8000, 9000, 8000, 9000, 11, 69572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shovelled!');
INSERT INTO `smart_scripts` VALUES (36830, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 17, 38, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'reset - add emote state');
INSERT INTO `smart_scripts` VALUES (36830, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'combat - remove emote state');

-- Ymirjar Deathbringer (36892, 37641)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36892, 37641) and `map`=658 );
DELETE FROM creature WHERE id IN(36892, 37641) and `map`=658;
DELETE FROM creature_template_addon WHERE entry IN(36892, 37641);
REPLACE INTO `creature_template` VALUES (36892, 37641, 0, 0, 0, 0, 27547, 0, 0, 0, 'Ymirjar Deathbringer', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.42857, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 36892, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 10, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37641, 0, 0, 0, 0, 0, 27547, 0, 0, 0, 'Ymirjar Deathbringer (1)', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 13, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36892, 37641) AND source_type=0;
INSERT INTO smart_scripts VALUES (36892, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 3000, 4000, 11, 69528, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Empowered Shadow Bolt');
INSERT INTO smart_scripts VALUES (36892, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO smart_scripts VALUES (36892, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On death - set data for tyrannus');

-- Ymirjar Wrathbringer (36840, 37644)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36840, 37644) and `map`=658 );
DELETE FROM creature WHERE id IN(36840, 37644) and `map`=658;
DELETE FROM creature_template_addon WHERE entry IN(36840, 37644);
REPLACE INTO `creature_template` VALUES (36840, 37644, 0, 0, 0, 0, 26614, 25244, 0, 0, 'Ymirjar Wrathbringer', '', '', 0, 80, 80, 2, 21, 0, 1, 1.07143, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 36840, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37644, 0, 0, 0, 0, 0, 26614, 25244, 0, 0, 'Ymirjar Wrathbringer (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 9.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36840, 37644) AND source_type=0;
INSERT INTO smart_scripts VALUES (36840, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Cast Emerge");
INSERT INTO smart_scripts VALUES (36840, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On AI Init - Set React State Passive");
INSERT INTO smart_scripts VALUES (36840, 0, 2, 0, 60, 0, 100, 257, 3500, 3500, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Set React State Aggressive");
INSERT INTO smart_scripts VALUES (36840, 0, 3, 0, 0, 0, 100, 0, 2000, 7000, 8000, 15000, 11, 69603, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Blight');
INSERT INTO smart_scripts VALUES (36840, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO smart_scripts VALUES (36840, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On death - set data for tyrannus');
REPLACE INTO creature_template_addon VALUES(36840, 0, 0, 0, 1, 333, ""),(37644, 0, 0, 0, 1, 333, "");

-- Ymirjar Flamebearer (36893, 37642)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36893, 37642) and `map`=658 );
DELETE FROM creature WHERE id IN(36893, 37642) and `map`=658;
DELETE FROM creature_template_addon WHERE entry IN(36893, 37642);
REPLACE INTO `creature_template` VALUES (36893, 37642, 0, 0, 0, 0, 27009, 26122, 0, 0, 'Ymirjar Flamebearer', '', '', 0, 80, 80, 2, 21, 0, 2.8, 1.42857, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 36893, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 8, 1, 0, 0, 0, 0, 0, 0, 0, 154, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37642, 0, 0, 0, 0, 0, 27009, 26122, 0, 0, 'Ymirjar Flamebearer (1)', '', '', 0, 80, 80, 2, 21, 0, 2.8, 1.42857, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 9.5, 8, 1, 0, 0, 0, 0, 0, 0, 0, 154, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36893, 37642) AND source_type=0;
INSERT INTO smart_scripts VALUES (36893, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 50142, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Cast Emerge");
INSERT INTO smart_scripts VALUES (36893, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On AI Init - Set React State Passive");
INSERT INTO smart_scripts VALUES (36893, 0, 2, 0, 60, 0, 100, 257, 3500, 3500, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Set React State Aggressive");
INSERT INTO smart_scripts VALUES (36893, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 4000, 5000, 11, 69583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fireball');
INSERT INTO smart_scripts VALUES (36893, 0, 4, 0, 0, 0, 100, 0, 15000, 15000, 45000, 45000, 11, 69586, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire');
INSERT INTO smart_scripts VALUES (36893, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO smart_scripts VALUES (36893, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On death - set data for tyrannus');
REPLACE INTO creature_template_addon VALUES(36893, 0, 0, 0, 1, 333, ""),(37642, 0, 0, 0, 1, 333, "");

-- Fallen Warrior (36841, 37612)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36841, 37612) and `map`=658 );
DELETE FROM creature WHERE `map`=658 AND id IN(36841, 37612) AND position_z < 600;
DELETE FROM creature_template_addon WHERE entry IN(36841, 37612);
REPLACE INTO `creature_template` VALUES (36841, 37612, 0, 0, 0, 0, 30350, 0, 0, 0, 'Fallen Warrior', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37612, 0, 0, 0, 0, 0, 30350, 0, 0, 0, 'Fallen Warrior (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 7.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36841, 37612) AND source_type=0;
INSERT INTO smart_scripts VALUES (36841, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 7000, 8000, 11, 69579, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcing Slice');
INSERT INTO smart_scripts VALUES (36841, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 11, 61044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Demoralizing Shout');
INSERT INTO smart_scripts VALUES (36841, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 8000, 15000, 11, 69580, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shield Block');
INSERT INTO smart_scripts VALUES (36841, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO smart_scripts VALUES (36841, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On death - set data for tyrannus');
REPLACE INTO creature_template_addon VALUES(36841, 0, 0, 0, 1, 333, ""),(37612, 0, 0, 0, 1, 333, "");

-- Wrathbone Coldwraith (36842, 37637)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36842, 37637) and `map`=658 );
DELETE FROM creature WHERE id IN(36842, 37637) and `map`=658;
DELETE FROM creature_template_addon WHERE entry IN(36842, 37637);
REPLACE INTO `creature_template` VALUES (36842, 37637, 0, 0, 0, 0, 26919, 0, 0, 0, 'Wrathbone Coldwraith', '', '', 0, 80, 80, 2, 21, 0, 1, 0.99206, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37637, 0, 0, 0, 0, 0, 26919, 0, 0, 0, 'Wrathbone Coldwraith (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10.5, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36842, 37637) AND source_type=0;
INSERT INTO smart_scripts VALUES (36842, 0, 0, 0, 0, 0, 100, 0, 500, 2000, 3500, 3500, 11, 69573, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostbolt');
INSERT INTO smart_scripts VALUES (36842, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 13000, 15000, 11, 69574, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Freezing Circle');
INSERT INTO smart_scripts VALUES (36842, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On aggro - call for help');
INSERT INTO smart_scripts VALUES (36842, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On death - set data for tyrannus');
REPLACE INTO creature_template_addon VALUES(36842, 0, 0, 0, 1, 333, ""),(37637, 0, 0, 0, 1, 333, "");

-- Wrathbone Skeleton (36877, 37640)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36877, 37640) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36877, 37640);
REPLACE INTO `creature_template` VALUES (36877, 37640, 0, 0, 0, 0, 30363, 0, 0, 0, 'Wrathbone Skeleton', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37640, 0, 0, 0, 0, 0, 30363, 0, 0, 0, 'Wrathbone Skeleton (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36877, 37640) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(36877, 0, 0, 0, 1, 333, ""),(37640, 0, 0, 0, 1, 333, "");

-- Plagueborn Horror (36879, 37635)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36879, 37635) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36879, 37635);
REPLACE INTO `creature_template` VALUES (36879, 37635, 0, 0, 0, 0, 23681, 0, 0, 0, 'Plagueborn Horror', '', '', 0, 80, 80, 2, 16, 0, 1, 1.28968, 1, 1, 422, 586, 0, 642, 7.5, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 104, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37635, 0, 0, 0, 0, 0, 23681, 0, 0, 0, 'Plagueborn Horror (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.28968, 1, 1, 422, 586, 0, 642, 13, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 104, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36879, 37635) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36879, 0, 0, 0, 2, 0, 100, 0, 1, 15, 10000, 10000, 11, 69582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Bomb');
INSERT INTO `smart_scripts` VALUES (36879, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 69581, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pustulant Flesh');
INSERT INTO `smart_scripts` VALUES (36879, 0, 2, 0, 0, 0, 100, 0, 8000, 8000, 8000, 8000, 11, 70274, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Toxic Waste');

-- Iceborn Proto-Drake (36891, 37626)
DELETE FROM creature_template_addon WHERE entry IN(36891, 37626);
REPLACE INTO `creature_template` VALUES (36891, 37626, 0, 0, 0, 0, 26742, 0, 0, 0, 'Iceborn Proto-Drake', '', '', 0, 80, 80, 2, 21, 0, 1.44444, 1.5873, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 0, 36891, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 560, 0, 0, 'SmartAI', 0, 3, 1, 13, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37626, 0, 0, 0, 0, 0, 26742, 0, 0, 0, 'Iceborn Proto-Drake (1)', '', '', 0, 80, 80, 2, 21, 0, 1.44444, 1.5873, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 0, 37626, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 560, 0, 0, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36891, 37626) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36891, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove Passenger on Enter Combat');
INSERT INTO `smart_scripts` VALUES (36891, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 10000, 10000, 11, 69527, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frost Breath');
DELETE FROM vehicle_accessory WHERE guid IN( SELECT guid FROM creature WHERE id IN(36891, 37626) and `map`=658 );
REPLACE INTO `vehicle_template_accessory` VALUES (36891, 31260, 0, 0, 'Ymirjar Skycaller on Drake', 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry=36891;
INSERT INTO `npc_spellclick_spells` VALUES (36891, 46598, 1, 0);

-- Ymirjar Skycaller (31260, 37643)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(31260, 37643) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(31260, 37643);
REPLACE INTO `creature_template` VALUES (31260, 37643, 0, 0, 0, 0, 25837, 0, 0, 0, 'Ymirjar Skycaller', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.42857, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 31260, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37643, 0, 0, 0, 0, 0, 25837, 0, 0, 0, 'Ymirjar Skycaller (1)', '', '', 0, 80, 80, 2, 1885, 0, 1, 1.42857, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(31260, 37643) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (31260, 0, 0, 0, 2, 0, 100, 1, 1, 50, 20000, 20000, 11, 70291, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Frostblade');
INSERT INTO `smart_scripts` VALUES (31260, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 8000, 8000, 11, 70292, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Glacial Strike');

-- Frostblade (37670)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37670) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry=37670;
DELETE FROM creature WHERE id IN(37670) and `map`=658;
REPLACE INTO `creature_template` VALUES (37670, 0, 0, 0, 0, 0, 16946, 0, 0, 0, 'Frostblade', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 33587200, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 1096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 7, 1, 28, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37670) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37670, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'reset - set react passive');
INSERT INTO `smart_scripts` VALUES (37670, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 70306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'timer 0ms - cast periodic dmg aura');
INSERT INTO `smart_scripts` VALUES (37670, 0, 2, 0, 60, 0, 100, 1, 8500, 8500, 0, 0, 97, 50, 3, 1, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'timer 8500ms - jump to summoner');
INSERT INTO `smart_scripts` VALUES (37670, 0, 3, 4, 60, 0, 100, 1, 10000, 10000, 0, 0, 28, 70291, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'timer 10000ms - remove auras from spell (disarm)');
INSERT INTO `smart_scripts` VALUES (37670, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'linked - despawn self after 1ms');

-- Stonespine Gargoyle (36896, 37636)
DELETE FROM creature_template_addon WHERE entry IN(36896, 37636);
REPLACE INTO `creature_template` VALUES (36896, 37636, 0, 0, 0, 0, 30403, 0, 0, 0, 'Stonespine Gargoyle', '', '', 0, 80, 80, 2, 21, 0, 2.7, 1.14286, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 576, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 562, 0, 0, 'SmartAI', 0, 4, 1, 12.6, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37636, 0, 0, 0, 0, 0, 30403, 0, 0, 0, 'Stonespine Gargoyle (1)', '', '', 0, 80, 80, 2, 21, 0, 2.7, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 576, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 8, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 562, 0, 0, '', 0, 4, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36896, 37636) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36896, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 4000, 5000, 11, 69520, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gargoyle Strike');
INSERT INTO `smart_scripts` VALUES (36896, 0, 1, 0, 2, 0, 100, 1, 1, 15, 100000, 100000, 11, 69575, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stoneform');
INSERT INTO `smart_scripts` VALUES (36896, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'reset - set react defensive');
DELETE FROM creature WHERE guid IN(201824, 201825) AND id=36896;
INSERT INTO creature VALUES(201824, 36896, 658, 3, 1, 30403, 0, 672.0, 49.0, 511.0, 0.89, 86400, 0, 0, 158760, 0, 2, 0, 0, 0);
REPLACE INTO creature_addon VALUES(201824, 2018240, 0, 0, 1, 0, '');
DELETE FROM waypoint_data WHERE id=2018240;
INSERT INTO `waypoint_data` VALUES (2018240, 1, 686.288, 63.1534, 505.612, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 2, 708.409, 81.4316, 495.236, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 3, 728.2, 80.7629, 503.626, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 4, 754.318, 73.7257, 519.748, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 5, 773.152, 54.356, 520.586, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 6, 772.101, 26.8021, 532.122, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 7, 757.452, 1.7166, 532.274, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 8, 726.012, -29.8133, 498.132, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 9, 703.238, -35.7948, 511.111, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 10, 675.245, -19.3284, 521.725, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (2018240, 11, 665.266, 8.25133, 521.571, 0, 0, 1, 0, 100, 0);

-- Wrathbone Siegesmith (36907, 37639)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36907, 37639) and `map`=658 );
UPDATE creature SET MovementType=0 WHERE id IN(36907, 37639);
DELETE FROM creature_template_addon WHERE entry IN(36907, 37639);
REPLACE INTO `creature_template` VALUES (36907, 37639, 0, 0, 0, 0, 30401, 0, 0, 0, 'Wrathbone Siegesmith', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37639, 0, 0, 0, 0, 0, 30401, 0, 0, 0, 'Wrathbone Siegesmith (1)', '', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 1, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36907, 37639) AND source_type=0;
REPLACE INTO creature_template_addon VALUES(36907, 0, 0, 0, 1, 233, ""),(37639, 0, 0, 0, 1, 233, "");

-- Eye of the Lich King (36913)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36913) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36913);
REPLACE INTO `creature_template` VALUES (36913, 0, 0, 0, 0, 0, 30405, 0, 0, 0, 'Eye of the Lich King', '', '', 0, 80, 80, 0, 14, 0, 1.6, 0.57143, 1, 1, 2, 2, 0, 24, 7.5, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 801, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid=36913 AND source_type=0;
INSERT INTO smart_scripts VALUES
(36913, 0, 0, 0, 1, 0, 100, 6, 60000, 300000, 300000, 600000, 1, 0, 0, 0, 0, 0, 0, 21, 400, 0, 0, 0, 0, 0, 0, 'Eye of the Lich King - Out of Combat - Set Orientation Closest Player'),
(36913, 0, 1, 0, 1, 0, 100, 6, 0, 0, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 21, 150, 0, 0, 0, 0, 0, 0, 'Eye of the Lich King - Out of Combat - Whisper Closest Player'),
(36913, 0, 2, 0, 11, 0, 100, 6, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Lich King - On Spawn Set unit flags Immune to NPC & Immune to PC'),
(36913, 0, 3, 0, 11, 0, 100, 6, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Lich King - On Spawn Set - Set React Passive');
DELETE FROM creature_text WHERE entry=36913;
INSERT INTO creature_text VALUES 
(36913, 0, 0, 'Cry out in torment... Let your pain overcome your might...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 1, 'Release yourself from the chains of life...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 2, 'The Lich King is unstoppable...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 3, 'The Master''s will remains inviolate...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 4, 'You cannot escape the Master''s Wrath...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 5, 'Death consumes you...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking'),
(36913, 0, 6, 'Give in... to the cold embrace of death...', 15, 0, 14.2857, 0, 0, 0, 0, 'Eye of the Lichking');

-- Hungering Ghoul (37711, 38249)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37711, 38249) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37711, 38249);
REPLACE INTO `creature_template` VALUES (37711, 38249, 0, 0, 0, 0, 24992, 24995, 24994, 0, 'Hungering Ghoul', '', '', 0, 80, 80, 2, 21, 0, 0.8, 0.99206, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (38249, 0, 0, 0, 0, 0, 24992, 24995, 24994, 0, 'Hungering Ghoul (1)', '', '', 0, 80, 80, 2, 21, 0, 0.8, 0.99206, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 32768, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37711, 38249) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37711, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 11, 70393, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Devour Flesh');

-- Deathwhisper Shadowcaster (37712, 38025)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37712, 38025) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37712, 38025);
REPLACE INTO `creature_template` VALUES (37712, 38025, 0, 0, 0, 0, 30848, 30849, 0, 0, 'Deathwhisper Shadowcaster', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (38025, 0, 0, 0, 0, 0, 30848, 30849, 0, 0, 'Deathwhisper Shadowcaster (1)', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37712, 38025) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37712, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 4000, 4000, 11, 70386, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');

-- Deathwhisper Torturer (37713, 38026)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37713, 38026) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37713, 38026);
REPLACE INTO `creature_template` VALUES (37713, 38026, 0, 0, 0, 0, 30851, 30850, 0, 0, 'Deathwhisper Torturer', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (38026, 0, 0, 0, 0, 0, 30851, 30850, 0, 0, 'Deathwhisper Torturer (1)', 'Cult of the Damned', '', 0, 80, 80, 2, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32832, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 7, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37713, 38026) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37713, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 70392, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Black Brand');
INSERT INTO `smart_scripts` VALUES (37713, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 10000, 14000, 11, 70391, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Curse of Agony');

-- Wrathbone Sorcerer (37728, 37731)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37728, 37731) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(37728, 37731);
REPLACE INTO `creature_template` VALUES (37728, 37731, 0, 0, 0, 0, 30363, 0, 0, 0, 'Wrathbone Sorcerer', '', '', 0, 80, 80, 2, 1771, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 2000, 0, 8, 32768, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 2, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37731, 0, 0, 0, 0, 0, 30363, 0, 0, 0, 'Wrathbone Sorcerer (1)', '', '', 0, 80, 80, 2, 1771, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 32768, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37728, 37731) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (37728, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5000, 6000, 11, 75330, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow Bolt');

-- Sindragosa (37755)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(37755) and `map`=658 );
REPLACE INTO creature_template_addon VALUES(37755, 0, 0, 50331648, 1, 0, '');
DELETE FROM creature WHERE id=37755 AND map=568;
REPLACE INTO `creature_template` VALUES (37755, 0, 0, 0, 0, 0, 30362, 0, 0, 0, 'Sindragosa', 'Queen of the Frostbrood', '', 0, 83, 83, 2, 2102, 0, 2.5, 2.5, 1, 3, 509, 683, 0, 805, 35, 0, 0, 1, 768, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 6, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 261, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(37755) AND source_type=0;

-- Frost Bomb (70521)
DELETE FROM spell_script_names WHERE spell_id IN(70521, -70521);
DELETE FROM spell_scripts WHERE id IN(70521, -70521);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70521, -70521) OR spell_effect IN(70521, -70521);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70521, -70521);
INSERT INTO `conditions` VALUES (13, 3, 70521, 0, 0, 31, 0, 3, 37580, 0, 0, 0, 0, '', 'Frost Bomb - target Martin Victus');
INSERT INTO `conditions` VALUES (13, 3, 70521, 0, 1, 31, 0, 3, 37581, 0, 0, 0, 0, '', 'Frost Bomb - target Gorkun Ironskull');



-- ###################
-- ### SCENKA ZABICIA UWOLNIONYCH WIEZNIOW
-- ###################

-- delete wrong trash spawned there:
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE guid IN(202018) AND id=36788 );
DELETE FROM creature WHERE guid IN(202018) AND id=36788;
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE guid IN(201840,201909,202022,202050,202141,202222) AND id=36881 );
DELETE FROM creature WHERE guid IN(201840,201909,202022,202050,202141,202222) AND id=36881;

-- Rescued Horde Slave (36889, 37654)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=36889 );
DELETE FROM creature WHERE id=36889;
UPDATE creature_template SET difficulty_entry_1=0, unit_flags=32768, AIName='SmartAI', ScriptName='' WHERE entry=36889;
DELETE FROM creature_text WHERE entry=36889;
INSERT INTO creature_text VALUES (36889, 0, 0, 'This way... We\'re about to mount an assault on the Scourgelord\'s location!', 14, 0, 100, 0, 0, 17153, 0, '');
INSERT INTO creature VALUES(202279, 36889, 658, 3, 1, 30386, 0, 772.277, -35.75, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202280, 36889, 658, 3, 1, 30387, 0, 773.77, -37.68, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202283, 36889, 658, 3, 1, 30383, 0, 770.49, -33.46, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202284, 36889, 658, 3, 1, 30381, 0, 768.86, -31.36, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
DELETE FROM smart_scripts WHERE (entryorguid=36889 AND source_type=0) OR (entryorguid IN(-202279, -202280, -202283, -202284) AND source_type=0) OR (entryorguid=36889*100 AND source_type=9);
INSERT INTO `smart_scripts` VALUES (-202280, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 240, 0, 0, 0, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202280, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202283, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 180, 0, 0, 0, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202283, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202284, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 120, 0, 0, 0, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202284, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for self');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202280, 36889, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc2');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202283, 36889, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc3');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202284, 36889, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc4');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202279, 0, 5, 0, 38, 0, 100, 1, 1234, 1, 0, 0, 80, 36889*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set data - start timed');
-- timed start
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'remove cheer emote - self');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202280, 36889, 0, 0, 0, 0, 0, 'remove cheer emote - npc1');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202283, 36889, 0, 0, 0, 0, 0, 'remove cheer emote - npc2');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202284, 36889, 0, 0, 0, 0, 0, 'remove cheer emote - npc3');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'talk - self');
-- run
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 821.90, 0.37, 509.61, 0.71, 'run to point');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202280, 36889, 0, 0, 0, 0, 0, 'set data - npc1 (for following)');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202283, 36889, 0, 0, 0, 0, 0, 'set data - npc2 (for following)');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202284, 36889, 0, 0, 0, 0, 0, 'set data - npc3 (for following)');
-- jump
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202276, 36886, 0, 813.63, 10.90, 509.77, 5.36, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202184, 36886, 0, 807.95, -2.24, 509.68, 0.05, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 201976, 36886, 0, 828.43, -9.14, 509.50, 2.30, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202083, 36886, 0, 832.27, 3.13, 509.85, 3.48, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 201815, 36886, 0, 827.13, 14.07, 510.0, 4.22, 'geist ambusher - jump to pos');
-- set our home pos
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set home pos - self');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202280, 36889, 0, 0, 0, 0, 0, 'set home pos - npc1');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202283, 36889, 0, 0, 0, 0, 0, 'set home pos - npc2');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202284, 36889, 0, 0, 0, 0, 0, 'set home pos - npc3');
-- attack
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 18, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 2, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 201815, 36886, 0, 10, 202280, 36889, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 23, 0, 0, 0, 100, 0, 500, 500, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 3, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202184, 36886, 0, 10, 202283, 36889, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 28, 0, 0, 0, 100, 0, 400, 400, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 4, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 31, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 32, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 201976, 36886, 0, 10, 202284, 36889, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 33, 0, 0, 0, 100, 0, 300, 300, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 34, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 35, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 5, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 36, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 37, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202083, 36886, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 38, 0, 0, 0, 100, 0, 200, 200, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 39, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 40, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 1, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 41, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36889*100, 9, 42, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202276, 36886, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'geist ambusher - attack');

-- Rescued Alliance Slave (36888, 37653)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=36888 );
DELETE FROM creature WHERE id=36888;
UPDATE creature_template SET difficulty_entry_1=0, unit_flags=32768, AIName='SmartAI', ScriptName='' WHERE entry=36888;
DELETE FROM creature_text WHERE entry=36888;
INSERT INTO creature_text VALUES (36888, 0, 0, 'This way... We\'re about to mount an assault on the Scourgelord\'s location!', 14, 0, 100, 0, 0, 17153, 0, '');
INSERT INTO creature VALUES(202285, 36888, 658, 3, 1, 30368, 0, 772.277, -35.75, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202286, 36888, 658, 3, 1, 30369, 0, 773.77, -37.68, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202287, 36888, 658, 3, 1, 30370, 0, 770.49, -33.46, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(202288, 36888, 658, 3, 1, 30374, 0, 768.86, -31.36, 508.36, 3.91, 86400, 0, 0, 1, 0, 0, 0, 0, 0);
DELETE FROM smart_scripts WHERE (entryorguid=36888 AND source_type=0) OR (entryorguid IN(-202285, -202286, -202287, -202288) AND source_type=0) OR (entryorguid=36888*100 AND source_type=9);
INSERT INTO `smart_scripts` VALUES (-202286, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 240, 0, 0, 0, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202286, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202287, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 180, 0, 0, 0, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202287, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202288, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 29, 0, 120, 0, 0, 0, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'set data - follow');
INSERT INTO `smart_scripts` VALUES (-202288, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for self');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202286, 36888, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc2');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202287, 36888, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc3');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 17, 4, 0, 0, 0, 0, 0, 10, 202288, 36888, 0, 0, 0, 0, 0, 'update ooc - cheer emote state for npc4');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on reset - react defensive');
INSERT INTO `smart_scripts` VALUES (-202285, 0, 5, 0, 38, 0, 100, 1, 1234, 1, 0, 0, 80, 36888*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set data - start timed');
-- timed start
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'remove cheer emote - self');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202286, 36888, 0, 0, 0, 0, 0, 'remove cheer emote - npc1');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202287, 36888, 0, 0, 0, 0, 0, 'remove cheer emote - npc2');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 202288, 36888, 0, 0, 0, 0, 0, 'remove cheer emote - npc3');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'talk - self');
-- run
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 821.90, 0.37, 509.61, 0.71, 'run to point');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202286, 36888, 0, 0, 0, 0, 0, 'set data - npc1 (for following)');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202287, 36888, 0, 0, 0, 0, 0, 'set data - npc2 (for following)');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 202288, 36888, 0, 0, 0, 0, 0, 'set data - npc3 (for following)');
-- jump
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202276, 36886, 0, 813.63, 10.90, 509.77, 5.36, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202184, 36886, 0, 807.95, -2.24, 509.68, 0.05, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 201976, 36886, 0, 828.43, -9.14, 509.50, 2.30, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 202083, 36886, 0, 832.27, 3.13, 509.85, 3.48, 'geist ambusher - jump to pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 30, 6, 0, 0, 0, 0, 10, 201815, 36886, 0, 827.13, 14.07, 510.0, 4.22, 'geist ambusher - jump to pos');
-- set our home pos
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set home pos - self');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202286, 36888, 0, 0, 0, 0, 0, 'set home pos - npc1');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202287, 36888, 0, 0, 0, 0, 0, 'set home pos - npc2');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202288, 36888, 0, 0, 0, 0, 0, 'set home pos - npc3');
-- attack
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 18, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 7, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 201815, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 201815, 36886, 0, 10, 202286, 36888, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 23, 0, 0, 0, 100, 0, 500, 500, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 8, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202184, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202184, 36886, 0, 10, 202287, 36888, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 28, 0, 0, 0, 100, 0, 400, 400, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 29, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 9, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 31, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 201976, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 32, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 201976, 36886, 0, 10, 202288, 36888, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 33, 0, 0, 0, 100, 0, 300, 300, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 34, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 35, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 10, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 36, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202083, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 37, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202083, 36886, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'geist ambusher - attack');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 38, 0, 0, 0, 100, 0, 200, 200, 0, 0, 101, 0, 0, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set home pos');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 39, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - set aggressive');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 40, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 6, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'geist ambusher - att start');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 41, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 202276, 36886, 0, 0, 0, 0, 0, 'taunt geist ambusher');
INSERT INTO `smart_scripts` VALUES (36888*100, 9, 42, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 69504, 2, 10, 202276, 36886, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'geist ambusher - attack');

-- Geist Ambusher (36886, 37622)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36886, 37622) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36886, 37622);
REPLACE INTO `creature_template` VALUES (36886, 37622, 0, 0, 0, 0, 26577, 0, 0, 0, 'Geist Ambusher', '', '', 0, 80, 80, 2, 1771, 0, 2, 1.42857, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 36886, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 8388624, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (37622, 0, 0, 0, 0, 0, 26577, 0, 0, 0, 'Geist Ambusher (1)', '', '', 0, 80, 80, 2, 1771, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 6, 0, 100001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 8388624, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36886, 37622) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (36886, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'ai init - set react state passive');
INSERT INTO `smart_scripts` VALUES (36886, 0, 1, 0, 34, 0, 100, 1, 16, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'movement inform (jumped) - set facing to');
INSERT INTO `smart_scripts` VALUES (36886, 0, 2, 0, 34, 0, 100, 1, 16, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'movement inform (jumped) - set facing to');

INSERT INTO `smart_scripts` VALUES (36886, 0, 3, 0, 38, 0, 100, 1, 1234, 1, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202276, 36889, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 4, 0, 38, 0, 100, 1, 1234, 2, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 201815, 36889, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 5, 0, 38, 0, 100, 1, 1234, 3, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202184, 36889, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 6, 0, 38, 0, 100, 1, 1234, 4, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 201976, 36889, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 7, 0, 38, 0, 100, 1, 1234, 5, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202083, 36889, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 8, 0, 38, 0, 100, 1, 1234, 6, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202276, 36888, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 9, 0, 38, 0, 100, 1, 1234, 7, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 201815, 36888, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 10, 0, 38, 0, 100, 1, 1234, 8, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202184, 36888, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 11, 0, 38, 0, 100, 1, 1234, 9, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 201976, 36888, 0, 0, 0, 0, 0, 'on set data - attack start');
INSERT INTO `smart_scripts` VALUES (36886, 0, 12, 0, 38, 0, 100, 1, 1234, 10, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 202083, 36888, 0, 0, 0, 0, 0, 'on set data - attack start');

-- area trigger
REPLACE INTO areatrigger_scripts VALUES(5589, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid IN(5589) AND source_type=2;
INSERT INTO `smart_scripts` VALUES (5589, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 1, 0, 0, 0, 0, 10, 202279, 36889, 0, 0, 0, 0, 0, 'on area trigger - setdata for npc by guid (horde)');
INSERT INTO `smart_scripts` VALUES (5589, 2, 1, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1234, 1, 0, 0, 0, 0, 10, 202285, 36888, 0, 0, 0, 0, 0, 'on area trigger - setdata for npc by guid (horde)');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5589;
INSERT INTO conditions VALUES (22, 1, 5589, 2, 0, 29, 0, 36889, 50, 0, 0, 0, 0, '', 'Requires alive npc near');
INSERT INTO conditions VALUES (22, 2, 5589, 2, 0, 29, 0, 36888, 50, 0, 0, 0, 0, '', 'Requires alive npc near');



-- ###################
-- ### SPELLS
-- ###################

-- Necromantic Power (69753)
DELETE FROM spell_script_names WHERE spell_id IN(69753,-69753);
DELETE FROM spell_scripts WHERE id IN(69753,-69753);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69753,-69753) OR spell_effect IN(69753,-69753);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=69753;
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 0, 31, 0, 3, 37584, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 1, 31, 0, 3, 37587, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 2, 31, 0, 3, 37588, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 3, 31, 0, 3, 37496, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 4, 31, 0, 3, 37497, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 5, 31, 0, 3, 36477, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');
INSERT INTO `conditions` VALUES (13, 1, 69753, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Tyrannus - Necromantic Power');

-- Raise Dead (69350)
DELETE FROM spell_script_names WHERE spell_id IN(69350,-69350);
DELETE FROM spell_scripts WHERE id IN(69350,-69350);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69350,-69350) OR spell_effect IN(69350,-69350);

-- Empowered Blizzard (70132, 70131, 70130)
DELETE FROM spell_script_names WHERE spell_id IN(70132, -70132, 70131, -70131, 70130, -70130);
DELETE FROM spell_scripts WHERE id IN(70132, -70132, 70131, -70131, 70130, -70130);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70132, -70132, 70131, -70131, 70130, -70130) OR spell_effect IN(70132, -70132, 70131, -70131, 70130, -70130);
INSERT INTO spell_script_names VALUES(70132, "spell_pos_empowered_blizzard");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=70130;
INSERT INTO `conditions` VALUES (13, 1, 70130, 0, 0, 31, 0, 3, 36796, 0, 0, 0, 0, '', 'Empowered Blizzard (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 70130, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Empowered Blizzard (Pit of Saron)');

-- Ice Lance Volley (70464)
DELETE FROM spell_script_names WHERE spell_id IN(70464, -70464);
DELETE FROM spell_scripts WHERE id IN(70464, -70464);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70464, -70464) OR spell_effect IN(70464, -70464);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=70464;
INSERT INTO `conditions` VALUES (13, 1, 70464, 0, 0, 31, 0, 3, 36796, 0, 0, 0, 0, '', 'Ice Lance Volley (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 70464, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Ice Lance Volley (Pit of Saron)');

-- Multi-Shot (70513)
-- Shriek of the Highborne (59514)
DELETE FROM spell_script_names WHERE spell_id IN(70513, -70513, 59514, -59514);
DELETE FROM spell_scripts WHERE id IN(70513, -70513, 59514, -59514);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70513, -70513, 59514, -59514) OR spell_effect IN(70513, -70513, 59514, -59514);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70513, 59514);
INSERT INTO `conditions` VALUES (13, 1, 70513, 0, 0, 31, 0, 3, 36796, 0, 0, 0, 0, '', 'Multi-Shot (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 70513, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Multi-Shot (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 59514, 0, 0, 31, 0, 3, 36796, 0, 0, 0, 0, '', 'Shriek of the Highborne (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 59514, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Shriek of the Highborne (Pit of Saron)');

-- Forcecaster Slave Trigger (71291), Slave Trigger Closest (71281)
DELETE FROM spell_script_names WHERE spell_id IN(71281, -71281, 71291, -71291);
DELETE FROM spell_scripts WHERE id IN(71281, -71281, 71291, -71291);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(71281, -71281, 71291, -71291) OR spell_effect IN(71281, -71281, 71291, -71291);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(71281);
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 0, 31, 0, 3, 36764, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 1, 31, 0, 3, 36765, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 2, 31, 0, 3, 36766, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 3, 31, 0, 3, 36767, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 4, 31, 0, 3, 36770, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 5, 31, 0, 3, 36771, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 6, 31, 0, 3, 36772, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 7, 31, 0, 3, 36773, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 6, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 71281, 0, 7, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Slave Trigger Closest (Pit of Saron)');
INSERT INTO spell_script_names VALUES(71281, "spell_pos_slave_trigger_closest");

-- Frost Nova (68198)
DELETE FROM spell_script_names WHERE spell_id IN(68198, -68198);
DELETE FROM spell_scripts WHERE id IN(68198, -68198);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68198, -68198) OR spell_effect IN(68198, -68198);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68198);
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 0, 31, 0, 3, 37577, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 1, 31, 0, 3, 37578, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 2, 31, 0, 3, 37579, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 3, 31, 0, 3, 37572, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 4, 31, 0, 3, 37575, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 5, 31, 0, 3, 37576, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 6, 31, 0, 3, 37580, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 7, 31, 0, 3, 37581, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 6, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 68198, 0, 7, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Rimefang Frost Nova (Pit of Saron)');
INSERT INTO spell_script_names VALUES(68198, "spell_pos_rimefang_frost_nova");

-- Jaina's Call (70525, 70623)
-- Call of Sylvanas (70639, 70638)
DELETE FROM spell_script_names WHERE spell_id IN(70525, -70525, 70639, -70639, 70623, -70623, 70638, -70638);
DELETE FROM spell_scripts WHERE id IN(70525, -70525, 70639, -70639, 70623, -70623, 70638, -70638);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70525, -70525, 70639, -70639, 70623, -70623, 70638, -70638) OR spell_effect IN(70525, -70525, 70639, -70639, 70623, -70623, 70638, -70638);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70525, 70639, 70623, 70638);
INSERT INTO `conditions` VALUES (13, 4, 70525, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Teleport Players (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 4, 70639, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Teleport Players (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 70623, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Teleport Players (Pit of Saron)');
INSERT INTO `conditions` VALUES (13, 1, 70638, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Teleport Players (Pit of Saron)');

-- Blight (69603, 70285, 69604, 70286)
DELETE FROM spell_script_names WHERE spell_id IN(69603, 70285, 69604, 70286, -69603, -70285, -69604, -70286);
DELETE FROM spell_scripts WHERE id IN(69603, 70285, 69604, 70286, -69603, -70285, -69604, -70286);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69603, 70285, 69604, 70286, -69603, -70285, -69604, -70286) OR spell_effect IN(69603, 70285, 69604, 70286, -69603, -70285, -69604, -70286);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69603, 70285, 69604, 70286);
INSERT INTO spell_script_names VALUES(69603, "spell_pos_blight");
INSERT INTO spell_script_names VALUES(70285, "spell_pos_blight");
INSERT INTO spell_script_names VALUES(69604, "spell_pos_blight");
INSERT INTO spell_script_names VALUES(70286, "spell_pos_blight");

-- Shield Block (69580)
REPLACE INTO spell_proc_event VALUES(69580, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0);

-- Freezing Circle (69574, 61572)
-- Summon Frostbite (34778)
-- Freezing Circle (34779) (dmg)
-- Frost Ring (34740, 34746)
DELETE FROM spell_script_names WHERE spell_id IN(69574, 61572, 34778, 34779, 34740, 34746, -69574, -61572, -34778, -34779, -34740, -34746);
DELETE FROM spell_scripts WHERE id IN(69574, 61572, 34778, 34779, 34740, 34746, -69574, -61572, -34778, -34779, -34740, -34746);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69574, 61572, 34778, 34779, 34740, 34746, -69574, -61572, -34778, -34779, -34740, -34746) OR spell_effect IN(69574, 61572, 34778, 34779, 34740, 34746, -69574, -61572, -34778, -34779, -34740, -34746);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69574, 61572, 34778, 34779, 34740, 34746);
-- npc Frostbite Invisible Stalker (20061)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(20061) );
DELETE FROM creature_template_addon WHERE entry IN(20061);
DELETE FROM creature WHERE id IN(20061);
REPLACE INTO `creature_template` VALUES (20061, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Frostbite Invisible Stalker', NULL, NULL, 0, 80, 80, 1, 974, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 262, 389, 48, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, 'npc_frostbite_invisible_stalker', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(20061) AND source_type=0;

-- Glacial Strike (70292)
DELETE FROM spell_script_names WHERE spell_id IN(70292, -70292);
DELETE FROM spell_scripts WHERE id IN(70292, -70292);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70292, -70292) OR spell_effect IN(70292, -70292);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70292);
INSERT INTO spell_script_names VALUES(70292, "spell_pos_glacial_strike");



-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- The Pit of Saron (4517)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12740,12741,12744);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12740,12741,12744);
REPLACE INTO achievement_criteria_data VALUES(12740, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12741, 12, 0, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12744, 12, 0, 0, "");

-- Heroic: The Pit of Saron (4520)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12747,12748,12749);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12747,12748,12749);
REPLACE INTO achievement_criteria_data VALUES(12747, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12748, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12749, 12, 1, 0, "");

-- Doesn't Go to Eleven (4524)
DELETE FROM disables WHERE sourceType=4 AND entry IN(12993);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12993);
REPLACE INTO achievement_criteria_data VALUES(12993, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(12993, 18, 0, 0, "");

-- Don't Look Up (4525) spell 72845
DELETE FROM disables WHERE sourceType=4 AND entry IN(12994);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(12994);
REPLACE INTO achievement_criteria_data VALUES(12994, 12, 1, 0, "");



-- ###################
-- ### FORGEMASTER GARFROST
-- ###################

-- Forgemaster Garfrost (36494, 37613)
DELETE FROM creature_template_addon WHERE entry IN(36494, 37613);
REPLACE INTO `creature_template` VALUES (36494, 37613, 0, 0, 0, 0, 30843, 0, 0, 0, 'Forgemaster Garfrost', '', '', 0, 82, 82, 2, 2102, 0, 1, 1.42857, 1, 1, 822, 986, 0, 782, 9, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 104, 36494, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 37, 30, 1, 0, 49723, 0, 0, 0, 0, 0, 144, 1, 617299839, 0+0x200000, 'boss_garfrost', 12340);
REPLACE INTO `creature_template` VALUES (37613, 0, 0, 0, 0, 0, 30843, 0, 0, 0, 'Forgemaster Garfrost (1)', '', '', 0, 82, 82, 2, 2102, 0, 1, 1.42857, 1, 1, 822, 986, 0, 782, 16, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 104, 37613, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 48, 30, 1, 0, 49723, 0, 0, 0, 0, 0, 144, 1, 617299839, 1+0x200000, '', 12340);
REPLACE INTO creature_equip_template VALUES(36494, 1, 49346, 0, 0, 18019);

-- Forgemaster Putridus Invisible Stalker (36495)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36495) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36495);
DELETE FROM creature WHERE id=36495 AND map=658;

-- Permafrost (70326, 68786, 70336)
DELETE FROM spell_script_names WHERE spell_id IN(70326, 68786, 70336, -70326, -68786, -70336);
DELETE FROM spell_scripts WHERE id IN(70326, 68786, 70336, -70326, -68786, -70336);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(70326, 68786, 70336, -70326, -68786, -70336) OR spell_effect IN(70326, 68786, 70336, -70326, -68786, -70336);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(70326, 68786, 70336);
INSERT INTO spell_script_names VALUES(68786, "spell_garfrost_permafrost");
INSERT INTO spell_script_names VALUES(70336, "spell_garfrost_permafrost");

-- Throw Saronite (68788, 68789, 70851)
DELETE FROM spell_script_names WHERE spell_id IN(68788, 68789, 70851, -68788, -68789, -70851);
DELETE FROM spell_scripts WHERE id IN(68788, 68789, 70851, -68788, -68789, -70851);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68788, 68789, 70851, -68788, -68789, -70851) OR spell_effect IN(68788, 68789, 70851, -68788, -68789, -70851);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68788, 68789, 70851);
INSERT INTO `conditions` VALUES (13, 4, 68788, 0, 0, 31, 0, 5, 196485, 0, 0, 0, 0, '', 'Throw Saronite activate Saronite Rock');

-- Saronite Rock (196485)
REPLACE INTO `gameobject_template` VALUES (196485, 0, 9491, 'Saronite Rock', '', '', '', 0, 16, 5, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);



-- ###################
-- ### KRICK AND ICK
-- ###################

-- Ick (36476, 37627)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36476, 37627) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36476, 37627);
REPLACE INTO `creature_template` VALUES (36476, 37627, 0, 0, 0, 0, 30347, 0, 0, 0, 'Ick', 'Krick\'s Minion', '', 0, 82, 82, 2, 21, 0, 1, 1.28968, 1, 1, 822, 986, 0, 782, 9, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 104, 36476, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 522, 0, 0, '', 0, 3, 1, 44.5466, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 0+0x200000, 'boss_ick', 12340);
REPLACE INTO `creature_template` VALUES (37627, 0, 0, 0, 0, 0, 30347, 0, 0, 0, 'Ick (1)', 'Krick\'s Minion', '', 0, 82, 82, 2, 21, 0, 1, 1.14286, 1, 1, 822, 986, 0, 782, 16, 1500, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 6, 104, 37627, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 522, 0, 0, '', 0, 3, 1, 67, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36476, 37627) AND source_type=0;

-- Krick (36477, 37629)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36477, 37629) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36477, 37629);
DELETE FROM creature WHERE id IN(36477, 37629) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36477, 37629, 0, 0, 0, 0, 30331, 0, 0, 0, 'Krick', '', '', 0, 80, 80, 0, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 7.5, 1500, 0, 8, 33554496, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 6, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 0+0x200000, 'boss_krick', 12340);
REPLACE INTO `creature_template` VALUES (37629, 0, 0, 0, 0, 0, 30331, 0, 0, 0, 'Krick (1)', '', '', 0, 80, 80, 0, 21, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 1500, 0, 8, 33554496, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 6, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 16, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36477, 37629) AND source_type=0;

-- stuff
REPLACE INTO vehicle_template_accessory VALUES(36476, 36477, 0, 0, 'Krick and Ick', 6, 30000);

-- Pursuit (68987, 69029, 70850)
DELETE FROM spell_script_names WHERE spell_id IN(68987, 69029, 70850, -68987, -69029, -70850);
DELETE FROM spell_scripts WHERE id IN(68987, 69029, 70850, -68987, -69029, -70850);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(68987, 69029, 70850, -68987, -69029, -70850) OR spell_effect IN(68987, 69029, 70850, -68987, -69029, -70850);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(68987, 69029, 70850);

-- Explosive Barrage (69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851)
DELETE FROM spell_script_names WHERE spell_id IN(69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851, -69012, -69263, -69015, -69017, -69020, -69019, -70433, -44851);
DELETE FROM spell_scripts WHERE id IN(69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851, -69012, -69263, -69015, -69017, -69020, -69019, -70433, -44851);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851, -69012, -69263, -69015, -69017, -69020, -69019, -70433, -44851) OR spell_effect IN(69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851, -69012, -69263, -69015, -69017, -69020, -69019, -70433, -44851);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69012, 69263, 69015, 69017, 69020, 69019, 70433, 44851);
INSERT INTO spell_script_names VALUES(69012, "spell_krick_explosive_barrage");
INSERT INTO spell_script_names VALUES(69020, "spell_exploding_orb_auto_grow");

-- Exploding Orb (36610)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36610) and `map`=658 );
REPLACE INTO creature_template_addon VALUES(36610, 0, 0, 0, 1, 0, "69017 69020");
DELETE FROM creature WHERE id IN(36610) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36610, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Exploding Orb', '', '', 0, 80, 80, 2, 14, 0, 1, 1.14286, 1.1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36610) AND source_type=0;



-- ###################
-- ### SCOURGELORD TYRANNUS
-- ###################

REPLACE INTO `areatrigger_scripts` VALUES(5633, 'at_tyrannus_event_starter');

-- Scourgelord Tyrannus (36658,36938)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36658,36938) and `map`=658 );
DELETE FROM creature_template_addon WHERE entry IN(36658,36938);
DELETE FROM creature WHERE id IN(36658,36938) AND `map`=658;
REPLACE INTO `creature_template` VALUES (36658, 36938, 0, 0, 0, 0, 30277, 0, 0, 0, 'Scourgelord Tyrannus', '', '', 0, 82, 82, 2, 14, 0, 2.5, 1.50714, 1, 1, 900, 1000, 0, 300, 12, 2000, 0, 1, 832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 0, 36658, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 48.5, 20, 1, 0, 0, 0, 0, 0, 0, 0, 179, 1, 617299839, 0+0x200000, 'boss_tyrannus', 12340);
REPLACE INTO `creature_template` VALUES (36938, 0, 0, 0, 0, 0, 30277, 0, 0, 0, 'Scourgelord Tyrannus (1)', '', '', 0, 82, 82, 2, 14, 0, 2.5, 1.50714, 1, 1, 900, 1000, 0, 300, 19, 2000, 0, 1, 832, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 0, 36938, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 80, 20, 1, 0, 0, 0, 0, 0, 0, 0, 179, 1, 617299839, 1+0x200000, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36658,36938) AND source_type=0;

-- Rimefang (36661)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(36661) and `map`=658 );
REPLACE INTO creature_template_addon VALUES(36661, 0, 0, 50331648, 1, 0, '');
REPLACE INTO `creature_template` VALUES (36661, 0, 0, 0, 0, 0, 27982, 0, 0, 0, 'Rimefang', '', '', 0, 82, 82, 2, 21, 0, 2, 1.5873, 1, 1, 1, 1, 0, 1, 1, 2000, 0, 2, 66, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 6, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 535, 0, 0, 'NullCreatureAI', 0, 4, 9, 240, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(36661) AND source_type=0;
DELETE FROM vehicle_accessory WHERE guid IN( SELECT guid FROM creature WHERE id IN(36661) and `map`=658 );
REPLACE INTO `vehicle_template_accessory` VALUES (36661, 36658, 0, 0, 'Scourgelord Tyrannus and Rimefang', 6, 30000);
DELETE FROM npc_spellclick_spells WHERE npc_entry=36661;
INSERT INTO `npc_spellclick_spells` VALUES (36661, 46598, 1, 0);

-- Overlord's Brand (69172, 69190, 69189)
DELETE FROM spell_script_names WHERE spell_id IN(69172, 69190, 69189, -69172, -69190, -69189);
DELETE FROM spell_scripts WHERE id IN(69172, 69190, 69189, -69172, -69190, -69189);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(69172, 69190, 69189, -69172, -69190, -69189) OR spell_effect IN(69172, 69190, 69189, -69172, -69190, -69189);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(69172, 69190, 69189);
DELETE FROM spell_proc_event WHERE entry IN(69172,69173);
REPLACE INTO spell_proc_event VALUES(69172, 0, 0, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0, 65539, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES(69173, 0, 0, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0, 65539, 0, 0, 0);
INSERT INTO spell_linked_spell VALUES(69172, 69173, 0, "Overlord\'s Brand");

-- TC, remove some unused scripts
DELETE FROM spell_script_names WHERE ScriptName='spell_tyrannus_mark_of_rimefang' AND spell_id=69275;



-- ###################
-- ### TEXTS
-- ###################

-- insert into creature_text select 36794, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658001, -1658004, -1658005, -1658008, -1658042, -1658044, -1658047));
-- insert into creature_text select 36990, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658003, -1658007, -1658011, -1658013, -1658037, -1658040, -1658046));
-- insert into creature_text select 36795, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658020, -1658048, -1658049));
-- insert into creature_text select 37592, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658021));
-- insert into creature_text select 36477, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658035, -1658038, -1658041, -1658043) or entry between -1658032 and -1658024);
-- insert into creature_text select 36476, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658033));
-- insert into creature_text select 36658, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658050, -1658052, -1658060) or entry between -1658058 and -1658053);
-- insert into creature_text select 37581, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658051, -1658061, -1658062));
-- insert into creature_text select 38189, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658064, -1658067));
-- insert into creature_text select 36494, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658022, -1658023) or entry between -1658019 and -1658014);
-- insert into creature_text select 36661, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658059));
-- insert into creature_text select 36993, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658002, -1658006, -1658009, -1658010, -1658012, -1658036, -1658039, -1658045));
-- insert into creature_text select 37591, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658021));
-- insert into creature_text select 37580, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658069, -1658068, -1658062));
-- insert into creature_text select 38188, ABS(entry+1658000), 0, content_default, IF(type=0,12,IF(type=1,14,IF(type=2,16,IF(type=3,41,0)))), language, 100, emote, 0, sound, comment from script_texts where type<=3 and (entry IN(-1658063, -1658065, -1658066));
DELETE FROM creature_text WHERE entry IN(36794, 36990, 36795, 37592, 36477, 36476, 36658, 37581, 38189, 36494, 36661, 36993, 37591, 37580, 38188); -- first tyrannus, first sylvanas, custom tyrannus, gorkun first, krick, ick, proper tyrannus, gorkun second, sylvanas second, garfrost, rimefang, jaina first, martin first, martin second, jaina second
INSERT INTO creature_text VALUES (36794, 1, 0, 'Intruders have entered the masters domain. Signal the alarms!', 14, 0, 100, 0, 0, 16747, 0, 'tyrannus SAY_TYRANNUS_INTRO_1');
INSERT INTO creature_text VALUES (36993, 2, 0, 'Heroes of the Alliance, attack!', 14, 0, 100, 0, 0, 16626, 0, 'jaina SAY_JAINA_INTRO_1');
INSERT INTO creature_text VALUES (36990, 3, 0, 'Soldiers of the Horde, attack!', 14, 0, 100, 0, 0, 17045, 0, 'sylvanas SAY_SYLVANAS_INTRO_1');
INSERT INTO creature_text VALUES (36794, 4, 0, 'Hrmph, fodder. Not even fit to labor in the quarry. Relish these final moments for soon you will be nothing more than mindless undead.', 14, 0, 100, 0, 0, 16748, 0, 'tyrannus SAY_TYRANNUS_INTRO_2');
INSERT INTO creature_text VALUES (36794, 5, 0, 'Your last waking memory will be of agonizing pain.', 14, 0, 100, 0, 0, 16749, 0, 'tyrannus SAY_TYRANNUS_INTRO_3');
INSERT INTO creature_text VALUES (36993, 6, 0, 'No! You monster!', 14, 0, 100, 0, 0, 16627, 0, 'jaina SAY_JAINA_INTRO_2');
INSERT INTO creature_text VALUES (36990, 7, 0, 'Pathetic weaklings!', 14, 0, 100, 0, 0, 17046, 0, 'sylvanas SAY_SYLVANAS_INTRO_2');
INSERT INTO creature_text VALUES (36794, 8, 0, 'Minions, destroy these interlopers!', 14, 0, 100, 0, 0, 16751, 0, 'tyrannus SAY_TYRANNUS_INTRO_4');
INSERT INTO creature_text VALUES (36993, 9, 0, 'I do what I must. Please forgive me, noble soldiers.', 14, 0, 100, 0, 0, 16628, 0, 'jaina SAY_JAINA_INTRO_3');
INSERT INTO creature_text VALUES (36993, 10, 0, 'You will have to make your way across this quarry on your own.', 12, 0, 100, 0, 0, 16629, 0, 'jaina SAY_JAINA_INTRO_4');
INSERT INTO creature_text VALUES (36990, 11, 0, 'You will have to battle your way through this cesspit on your own.', 12, 0, 100, 0, 0, 17047, 0, 'sylvanas SAY_SYLVANAS_INTRO_3');
INSERT INTO creature_text VALUES (36993, 12, 0, 'Free any Alliance slaves that you come across. We will most certainly need their assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 12, 0, 100, 0, 0, 16630, 0, 'jaina SAY_JAINA_INTRO_5');
INSERT INTO creature_text VALUES (36990, 13, 0, 'Free any Horde slaves that you come across. We will most certainly need their assistance in battling Tyrannus. I will gather reinforcements and join you on the other side of the quarry.', 12, 0, 100, 0, 0, 17048, 0, 'sylvanas SAY_SYLVANAS_INTRO_4');
INSERT INTO creature_text VALUES (36494, 14, 0, 'Tiny creatures under feet, you bring Garfrost something good to eat!', 14, 0, 100, 0, 0, 16912, 0, 'garfrost SAY_AGGRO');
INSERT INTO creature_text VALUES (36494, 15, 0, 'Will save for snack. For later.', 14, 0, 100, 0, 0, 16913, 0, 'garfrost SAY_SLAY_1');
INSERT INTO creature_text VALUES (36494, 16, 0, 'That one maybe not so good to eat now. Stupid Garfrost! BAD! BAD!', 14, 0, 100, 0, 0, 16914, 0, 'garfrost SAY_BOULDER_HIT');
INSERT INTO creature_text VALUES (36494, 17, 0, 'Garfrost hope giant underpants clean. Save boss great shame. For later.', 14, 0, 100, 0, 0, 16915, 0, 'garfrost SAY_DEATH');
INSERT INTO creature_text VALUES (36494, 18, 0, 'Axe too weak. Garfrost make better and CRUSH YOU!', 14, 0, 100, 0, 0, 16916, 0, 'garfrost SAY_FORGE_1');
INSERT INTO creature_text VALUES (36494, 19, 0, 'Garfrost tired of puny mortals. Now your bones will freeze!', 14, 0, 100, 0, 0, 16917, 0, 'garfrost SAY_FORGE_2');
INSERT INTO creature_text VALUES (36795, 20, 0, 'Another shall take his place. You waste your time.', 14, 0, 100, 0, 0, 16752, 0, 'tyrannus SAY_TYRANNUS_GARFROST');
INSERT INTO creature_text VALUES (37591, 21, 0, 'The forgemaster is dead! Get geared up men, we have a Scourgelord to kill.', 14, 0, 100, 0, 0, 0, 0, 'victus_or_ironskull SAY_GENERAL_GARFROST');
INSERT INTO creature_text VALUES (37592, 21, 0, 'The forgemaster is dead! Get geared up men, we have a Scourgelord to kill.', 14, 0, 100, 0, 0, 0, 0, 'victus_or_ironskull SAY_GENERAL_GARFROST');
INSERT INTO creature_text VALUES (36494, 23, 0, '%s casts Deep Freeze at $N.', 41, 0, 100, 0, 0, 0, 0, 'garfrost EMOTE_DEEP_FREEZE');
INSERT INTO creature_text VALUES (36477, 24, 0, 'Our work must not be interrupted! Ick! Take care of them!', 14, 0, 100, 0, 0, 16926, 0, 'krick SAY_AGGRO');
INSERT INTO creature_text VALUES (36477, 25, 0, 'Ooh...We could probably use these parts!', 14, 0, 100, 0, 0, 16927, 0, 'krick SAY_SLAY_1');
INSERT INTO creature_text VALUES (36477, 26, 0, 'Arms and legs are in short supply...Thanks for your contribution!', 14, 0, 100, 0, 0, 16928, 0, 'krick SAY_SLAY_2');
INSERT INTO creature_text VALUES (36477, 27, 0, 'Enough moving around! Hold still while I blow them all up!', 14, 0, 100, 0, 0, 16929, 0, 'krick SAY_ORDER_STOP');
INSERT INTO creature_text VALUES (36477, 28, 0, 'Quickly! Poison them all while they\'re still close!', 14, 0, 100, 0, 0, 16930, 0, 'krick SAY_ORDER_BLOW');
INSERT INTO creature_text VALUES (36477, 29, 0, 'No! That one! That one! Get that one!', 14, 0, 100, 0, 0, 16931, 0, 'krick SAY_TARGET_1');
INSERT INTO creature_text VALUES (36477, 30, 0, 'I\'ve changed my mind...go get that one instead!', 14, 0, 100, 0, 0, 16932, 0, 'krick SAY_TARGET_2');
INSERT INTO creature_text VALUES (36477, 31, 0, 'What are you attacking him for? The dangerous one is over there,fool!', 14, 0, 100, 0, 0, 16933, 0, 'krick SAY_TARGET_3');
INSERT INTO creature_text VALUES (36477, 32, 0, '%s begins rapidly conjuring explosive mines!', 41, 0, 100, 0, 0, 0, 0, 'krick EMOTE_KRICK_MINES');
INSERT INTO creature_text VALUES (36476, 33, 0, '%s begins to unleash a toxic poison cloud!', 41, 0, 100, 0, 0, 0, 0, 'ick EMOTE_ICK_POISON');
INSERT INTO creature_text VALUES (36477, 35, 0, 'Wait! Stop! Don\'t kill me, please! I\'ll tell you everything!', 14, 0, 100, 0, 0, 16934, 0, 'krick SAY_OUTRO_1');
INSERT INTO creature_text VALUES (36993, 36, 0, 'I\'m not so naive as to believe your appeal for clemency, but I will listen.', 14, 0, 100, 0, 0, 16611, 0, 'jaina SAY_JAINA_KRICK_1');
INSERT INTO creature_text VALUES (36990, 37, 0, 'Why should the Banshee Queen spare your miserable life?', 14, 0, 100, 0, 0, 17033, 0, 'sylvanas SAY_SYLVANAS_KRICK_1');
INSERT INTO creature_text VALUES (36477, 38, 0, 'What you seek is in the master\'s lair, but you must destroy Tyrannus to gain entry. Within the Halls of Reflection you will find Frostmourne. It... it holds the truth.', 14, 0, 100, 0, 0, 16935, 0, 'krick SAY_OUTRO_2');
INSERT INTO creature_text VALUES (36993, 39, 0, 'Frostmourne lies unguarded? Impossible!', 14, 0, 100, 0, 0, 16612, 0, 'jaina SAY_JAINA_KRICK_2');
INSERT INTO creature_text VALUES (36990, 40, 0, 'Frostmourne? The Lich King is never without his blade! If you are lying to me...', 14, 0, 100, 0, 0, 17034, 0, 'sylvanas SAY_SYLVANAS_KRICK_2');
INSERT INTO creature_text VALUES (36477, 41, 0, 'I swear it is true! Please, don\'t kill me!!', 14, 0, 100, 0, 0, 16936, 0, 'krick SAY_OUTRO_3');
INSERT INTO creature_text VALUES (36794, 42, 0, 'Worthless gnat! Death is all that awaits you!', 14, 0, 100, 0, 0, 16753, 0, 'tyrannus SAY_TYRANNUS_KRICK_1');
INSERT INTO creature_text VALUES (36477, 43, 0, 'Urg... no!!', 14, 0, 100, 0, 0, 16937, 0, 'krick SAY_OUTRO_4');
INSERT INTO creature_text VALUES (36794, 44, 0, 'Do not think that I shall permit you entry into my master\'s sanctum so easily. Pursue me if you dare.', 14, 0, 100, 0, 0, 16754, 0, 'tyrannus SAY_TYRANNUS_KRICK_2');
INSERT INTO creature_text VALUES (36993, 45, 0, 'What a cruel end. Come, heroes. We must see if the gnome\'s story is true. If we can separate Arthas from Frostmourne, we might have a chance at stopping him.', 14, 0, 100, 0, 0, 16613, 0, 'jaina SAY_JAINA_KRICK_3');
INSERT INTO creature_text VALUES (36990, 46, 0, 'A fitting end for a traitor. Come, we must free the slaves and see what is within the Lich King\'s chamber for ourselves.', 14, 0, 100, 0, 0, 17035, 0, 'sylvanas SAY_SYLVANAS_KRICK_3');
INSERT INTO creature_text VALUES (36794, 47, 0, 'Your pursuit shall be in vain, intruders, for the Lich King has placed an army of undead at my command! Behold!', 14, 0, 100, 0, 0, 16755, 0, 'tyrannus SAY_TYRANNUS_AMBUSH_1');
INSERT INTO creature_text VALUES (36794, 48, 0, 'Persistent whelps! You will not reach the entrance of my lord\'s lair! Soldiers, destroy them!', 14, 0, 100, 0, 0, 16756, 0, 'tyrannus SAY_TYRANNUS_AMBUSH_2');
INSERT INTO creature_text VALUES (36795, 49, 0, 'Rimefang! Trap them within the tunnel! Bury them alive!', 14, 0, 100, 0, 0, 16757, 0, 'tyrannus SAY_TYRANNUS_TRAP_TUNNEL');
INSERT INTO creature_text VALUES (36658, 50, 0, 'At last, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.', 14, 0, 100, 0, 0, 16758, 0, 'tyrannus SAY_PREFIGHT_1');
INSERT INTO creature_text VALUES (37581, 51, 0, 'Heroes! We will hold off the undead as long as we can, even to our dying breath. Deal with the Scourgelord!', 14, 0, 100, 0, 0, 17150, 0, 'victus_or_ironskull SAY_GENERAL_HORDE_TRASH');
INSERT INTO creature_text VALUES (36658, 52, 0, 'Ha, such an amusing gesture from the rabble. When I have finished with you, my master\'s blade will feast upon your souls. Die!', 14, 0, 100, 0, 0, 16759, 0, 'tyrannus SAY_PREFIGHT_2');
INSERT INTO creature_text VALUES (36658, 53, 0, 'I shall not fail The Lich King! Come and meet your end!', 14, 0, 100, 0, 0, 16760, 0, 'tyrannus SAY_AGGRO');
INSERT INTO creature_text VALUES (36658, 54, 0, 'Such a shameful display...', 14, 0, 100, 0, 0, 16761, 0, 'tyrannus SAY_SLAY_1');
INSERT INTO creature_text VALUES (36658, 55, 0, 'Perhaps you should have stayed in the mountains!', 14, 0, 100, 0, 0, 16762, 0, 'tyrannus SAY_SLAY_2');
INSERT INTO creature_text VALUES (36658, 56, 0, 'Impossible! Rimefang...Warn...', 14, 0, 100, 0, 0, 16763, 0, 'tyrannus SAY_DEATH');
INSERT INTO creature_text VALUES (36658, 57, 0, 'Rimefang, destroy this fool!', 14, 0, 100, 0, 0, 16764, 0, 'tyrannus SAY_MARK');
INSERT INTO creature_text VALUES (36658, 58, 0, 'Power... overwhelming!', 14, 0, 100, 0, 0, 16765, 0, 'tyrannus SAY_SMASH');
INSERT INTO creature_text VALUES (36661, 59, 0, 'The frostwyrm %s gazes at $N and readies an icy attack!', 41, 0, 100, 0, 0, 0, 0, 'rimefang EMOTE_RIMEFANG_ICEBOLT');
INSERT INTO creature_text VALUES (36658, 60, 0, '%s roars and swells with dark might!', 41, 0, 100, 0, 0, 0, 0, 'tyrannus EMOTE_SMASH');
INSERT INTO creature_text VALUES (37581, 61, 0, 'Brave champions, we owe you our lives, our freedom... Though it be a tiny gesture in the face of this enormous debt, I pledge that from this day forth, all will know of your deeds, and the blazing path of light you cut through the shadow of this dark citadel.', 14, 0, 100, 0, 0, 17151, 0, 'victus_or_ironskull SAY_GENERAL_HORDE_OUTRO_1');
INSERT INTO creature_text VALUES (37581, 62, 0, 'This day will stand as a testament not only to your valor, but to the fact that no foe, not even the Lich King himself, can stand when Alliance and Horde set aside their differences and ---', 14, 0, 100, 0, 0, 0, 0, 'victus_or_ironskull SAY_GENERAL_OUTRO_2');
INSERT INTO creature_text VALUES (37580, 62, 0, 'This day will stand as a testament not only to your valor, but to the fact that no foe, not even the Lich King himself, can stand when Alliance and Horde set aside their differences and ---', 14, 0, 100, 0, 0, 0, 0, 'victus_or_ironskull SAY_GENERAL_OUTRO_2');
INSERT INTO creature_text VALUES (38188, 63, 0, 'Heroes, to me!', 14, 0, 100, 0, 0, 16614, 0, 'jaina SAY_JAINA_OUTRO_1');
INSERT INTO creature_text VALUES (38189, 64, 0, 'Take cover behind me! Quickly!', 14, 0, 100, 0, 0, 17037, 0, 'sylvanas SAY_SYLVANAS_OUTRO_1');
INSERT INTO creature_text VALUES (38188, 65, 0, 'The Frost Queen is gone. We must keep moving - our objective is near.', 12, 0, 100, 0, 0, 16615, 0, 'jaina SAY_JAINA_OUTRO_2');
INSERT INTO creature_text VALUES (38188, 66, 0, 'I... I could not save them... Damn you, Arthas! DAMN YOU!', 12, 0, 100, 0, 0, 16616, 0, 'jaina SAY_JAINA_OUTRO_3');
INSERT INTO creature_text VALUES (38189, 67, 0, 'I thought he\'d never shut up. At last, Sindragosa silenced that long-winded fool. To the Halls of Reflection, champions! Our objective is near... I can sense it.', 12, 0, 100, 0, 0, 17036, 0, 'sylvanas SAY_SYLVANAS_OUTRO_2');
INSERT INTO creature_text VALUES (37580, 68, 0, 'Brave champions, we owe you our lives, our freedom... Though it be a tiny gesture in the face of this enormous debt, I pledge that from this day forth, all will know of your deeds, and the blazing path of light you cut through the shadow of this dark citadel.', 14, 0, 100, 0, 0, 17149, 0, 'victus_or_ironskull SAY_GENERAL_ALLIANCE_OUTRO_1');
INSERT INTO creature_text VALUES (37580, 69, 0, 'Heroes! We will hold off the undead as long as we can, even to our dying breath. Deal with the Scourgelord!', 14, 0, 100, 0, 0, 17148, 0, 'victus_or_ironskull SAY_GENERAL_ALLIANCE_TRASH');



-- ###################
-- ### WAYPOINTS
-- ###################

DELETE FROM waypoint_data WHERE id >= 3000200 AND id <=3000218;
INSERT INTO `waypoint_data` VALUES (3000200, 1, 688.69, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000200, 2, 654.64, -171.82, 526.69, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000201, 1, 690.49, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000201, 2, 656.083, -173.20, 526.69, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000202, 1, 692.29, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000202, 2, 657.19, -174.225, 526.69, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000203, 1, 694.09, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000203, 2, 686.711, -234.476, 526.716, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000204, 1, 695.89, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000204, 2, 688.21, -232.994, 526.716, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000205, 1, 697.69, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000205, 2, 689.71, -231.524, 526.716, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000206, 1, 699.49, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000206, 2, 717.736, -206.418, 527.16, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000207, 1, 701.29, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000207, 2, 719.143, -205.124, 527.157, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000208, 1, 703.0, -150.56, 528.053, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000208, 2, 720.60, -203.783, 527.141, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000210, 1, 824.69, 198.78, 552.32, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000210, 2, 828.43, 127.89, 530.42, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000211, 1, 812.58, 82.58, 509.416, 0, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000211, 2, 829.73, 35.59, 510.0603, 0, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000211, 3, 816.56, -10.14, 509.485, 0, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000211, 4, 823.2, -4.4497, 509.49, 0, 0, 0, 0, 100, 0);

INSERT INTO `waypoint_data` VALUES (3000216, 1, 1057.74, 114.203, 628.268, 0, 2500, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 2, 1047.25, 146.918, 628.156, 0, 10000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 3, 1044.04, 169.597, 628.156, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 4, 1047.48, 183.935, 628.156, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 5, 1075.27, 216.137, 628.269, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 6, 1082.22, 219.584, 629.962, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000216, 7, 1092.59, 231.506, 631.956, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 1, 1057.74, 114.203, 628.268, 0, 2500, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 2, 1047.25, 146.918, 628.156, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 3, 1044.04, 169.597, 628.156, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 4, 1047.48, 183.935, 628.156, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 5, 1075.27, 216.137, 628.269, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 6, 1082.22, 219.584, 629.962, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000217, 7, 1092.59, 231.506, 631.956, 0, 0, 1, 0, 100, 0);

INSERT INTO `waypoint_data` VALUES (3000218, 1, 999.907, 193.44, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 2, 975.345, 195.05, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 3, 959.69, 183.18, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 4, 953.16, 165.52, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 5, 962.53, 139.20, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 6, 983.34, 129.14, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 7, 1020.67, 137.96, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 8, 1030.54, 166.73, 659.56, 0, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (3000218, 9, 1023.95, 188.93, 659.56, 0, 0, 1, 0, 100, 0);



-- ###################
-- ### FORMATIONS
-- ###################

DELETE FROM creature_formations WHERE memberGUID IN( select guid from creature where map=658 );
DELETE FROM creature_formations WHERE leaderGUID IN(201888, 202103, 202041, 201994, 202063, 201970, 202231, 202211, 202273, 202112, 202216, 201992, 202018, 201887, 202056, 202128, 201982, 202015, 202068, 202045, 201939, 202212, 202248);
INSERT INTO `creature_formations` VALUES (202041, 202041, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202041, 202233, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202041, 202038, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201994, 201994, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201994, 202028, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201994, 202000, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201994, 201957, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202063, 202063, 0, 0, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202063, 202199, 3, 135, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202063, 202122, 3, 180, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202063, 201820, 3, 225, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (201970, 201970, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201970, 202152, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201970, 201921, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201970, 201900, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 202231, 0, 0, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 201960, 3, 90, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 202203, 3, 135, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 202125, 3, 180, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 202282, 3, 225, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202231, 202099, 3, 270, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202211, 202211, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202211, 202071, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202211, 202204, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202211, 202030, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202216, 202216, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202216, 201980, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202216, 202107, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202216, 202232, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201982, 201982, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201982, 202174, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201939, 201876, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201939, 201926, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201939, 201939, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201939, 202158, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 201927, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 202159, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 201992, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 202072, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 201855, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 202238, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (201992, 202027, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202015, 202015, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202015, 202085, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202015, 202257, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202045, 202045, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202045, 202265, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202068, 201871, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202068, 202068, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 202103, 0, 0, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 201819, 3, 90, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 201934, 3, 126, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 201954, 3, 162, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 202098, 3, 198, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 202121, 3, 234, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202103, 202196, 3, 270, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 201806, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 201949, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 202079, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 202112, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 202182, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 201797, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202112, 201884, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202212, 202105, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202212, 202132, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202212, 202200, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202212, 202212, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202248, 202163, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202248, 202165, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202248, 202246, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202248, 202248, 0, 0, 5, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 202273, 0, 0, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 201845, 3, 90, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 201914, 3, 126, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 201988, 3, 162, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 202054, 3, 198, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 202145, 3, 234, 2, 0, 0);
INSERT INTO `creature_formations` VALUES (202273, 202227, 3, 270, 2, 0, 0);

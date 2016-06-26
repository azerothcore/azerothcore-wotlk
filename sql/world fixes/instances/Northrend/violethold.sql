DELETE FROM disables WHERE sourceType=2 AND entry IN(608);

-- ###################
-- ### GAMEOBJECTS
-- ###################

-- Activation Crystal (193611)
REPLACE INTO `gameobject_template` VALUES (193611, 0, 8527, 'Activation Crystal', '', 'Activating Defenses', '', 0, 48, 1, 0, 0, 0, 0, 0, 0, 0, 86, 0, 0, 32492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_vh_activation_crystal', 12340);

-- Intro Activation Crystal (193615)
REPLACE INTO `gameobject_template` VALUES (193615, 0, 8527, 'Intro Activation Crystal', '', 'Activating Defenses', '', 0, 48, 1, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0, 32492, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

-- enterance door and lever:
UPDATE gameobject_template SET AIName='', ScriptName='go_violet_hold_gate_lever' WHERE entry=193020;
DELETE FROM smart_scripts WHERE entryorguid = 193020 AND source_type=1;



-- ###################
-- ### NPCS
-- ###################

-- Defense System (30837) 57887
REPLACE INTO `creature_template_addon` VALUES (30837, 0, 0, 0, 1, 0, "57887");
REPLACE INTO `creature_template` VALUES (30837, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Defense System', '', '', 0, 83, 83, 2, 1718, 0, 1, 1.14286, 2, 1, 1, 1, 0, 1, 1, 2000, 0, 1, 33554438, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid=30837 AND source_type=0;
REPLACE INTO `smart_scripts` VALUES (30837, 0, 0, 0, 1, 0, 100, 0, 2000, 2000, 1000, 1000, 11, 57930, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Periodically cast Arcane Lightning');
REPLACE INTO `smart_scripts` VALUES (30837, 0, 1, 0, 1, 0, 100, 0, 6000, 6000, 10000, 10000, 11, 57912, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Periodically cast Arcane Lightning');

-- Lieutenant Sinclari (30658)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30658) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(30658);
REPLACE INTO `creature_template` VALUES (30658, 0, 0, 0, 0, 0, 27214, 0, 0, 0, 'Lieutenant Sinclari', '', '', 1623, 80, 80, 2, 35, 1, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 576, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_vh_sinclari', 12340);

-- Violet Hold Guard (30659,31505)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30659,31505) and `map`=608 );
REPLACE INTO `creature_template_addon` VALUES (30659, 0, 0, 0, 1, 333, NULL);
REPLACE INTO `creature_template_addon` VALUES (31505, 0, 0, 0, 1, 333, NULL);
REPLACE INTO `creature_template` VALUES (30659, 31505, 0, 0, 0, 0, 27215, 27216, 27217, 0, 'Violet Hold Guard', '', '', 0, 75, 75, 2, 1718, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 4.6, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31505, 0, 0, 0, 0, 0, 27215, 27216, 27217, 0, 'Violet Hold Guard (1)', '', '', 0, 80, 80, 2, 1718, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 13, 2000, 0, 1, 64, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);

-- Teleportation Portal (31011)
DELETE FROM creature_template_addon WHERE entry IN(31011);
REPLACE INTO `creature_template` VALUES (31011, 0, 0, 0, 0, 0, 27393, 0, 0, 0, 'Teleportation Portal (Intro)', '', '', 0, 75, 75, 2, 35, 0, 1, 1.14286, 1, 1, 1, 1, 0, 1, 1, 2000, 0, 1, 33555200, 2048+32768, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_vh_teleportation_portal', 12340);

-- Defense Dummy Target (30857)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30857) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(30857);
REPLACE INTO `creature_template` VALUES (30857, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Defense Dummy Target', '', '', 0, 75, 75, 2, 35, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 130, '', 12340);
DELETE FROM creature WHERE id IN(30857) and `map`=608;
INSERT INTO `creature` VALUES (102385, 30857, 608, 3, 1, 11686, 0, 1895.93, 835.542, 38.6466, 3.7765, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102413, 30857, 608, 3, 1, 11686, 0, 1942.85, 812.676, 52.4026, 1.5377, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102465, 30857, 608, 3, 1, 11686, 0, 1876.5, 782.456, 38.9272, 2.81455, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102468, 30857, 608, 3, 1, 11686, 0, 1891.98, 752.688, 47.6668, 0.204083, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102486, 30857, 608, 3, 1, 11686, 0, 1881.36, 809.781, 38.53, 6.19563, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102598, 30857, 608, 3, 1, 11686, 0, 1852.57, 848.215, 43.3335, 0.434143, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102753, 30857, 608, 3, 1, 11686, 0, 1916.23, 850.416, 47.1447, 5.93601, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102896, 30857, 608, 3, 1, 11686, 0, 1840.36, 813.598, 44.1575, 5.86559, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102897, 30857, 608, 3, 1, 11686, 0, 1858.38, 766.677, 38.6528, 1.36797, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102898, 30857, 608, 3, 1, 11686, 0, 1929.48, 831.058, 45.51, 1.49259, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102899, 30857, 608, 3, 1, 11686, 0, 1858.19, 825.697, 38.6467, 5.19835, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (102900, 30857, 608, 3, 1, 11686, 0, 1907.28, 802.305, 38.6457, 4.32879, 3600, 0, 0, 10635, 0, 0, 0, 0, 0);

-- Prison Door Seal (30896)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(30896) and `map`=608 );
REPLACE INTO `creature_template_addon` VALUES (30896, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM creature WHERE id IN(30896) and `map`=608;
INSERT INTO `creature` VALUES (102910, 30896, 608, 3, 1, 11686, 0, 1823.72, 803.856, 48.9341, 0, 3600, 5, 0, 10635, 0, 1, 0, 0, 0);
REPLACE INTO `creature_template` VALUES (30896, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Prison Door Seal', '', '', 0, 75, 75, 2, 35, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 33555200, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 5, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 164, 1, 0, 130, '', 12340);


-- Portal Guardian (30660, 31501)
DELETE FROM creature_template_addon WHERE entry IN(30660, 31501);
REPLACE INTO `creature_template` VALUES (30660, 31501, 0, 0, 0, 0, 27474, 0, 0, 0, 'Portal Guardian', '', '', 0, 76, 76, 2, 1720, 0, 1, 1.14286, 1, 1, 356, 503, 0, 432, 7.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 305, 452, 74, 2, 72, 30660, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6644, 6644, 'SmartAI', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31501, 0, 0, 0, 0, 0, 27474, 0, 0, 0, 'Portal Guardian (1)', '', '', 0, 81, 81, 2, 1720, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 31501, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6644, 6644, '', 0, 3, 1, 12.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(30660, 31501) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (30660, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 6000, 9000, 11, 58504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Agonizing Strike');
INSERT INTO `smart_scripts` VALUES (30660, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 9000, 11000, 11, 58508, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Side Swipe');

-- Portal Keeper (30695, 31503)
DELETE FROM creature_template_addon WHERE entry IN(30695, 31503);
REPLACE INTO `creature_template` VALUES (30695, 31503, 0, 0, 0, 0, 27473, 0, 0, 0, 'Portal Keeper', '', '', 0, 76, 76, 2, 1720, 0, 1, 1.14286, 1, 1, 352, 499, 0, 408, 7.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 302, 449, 57, 2, 72, 30695, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6659, 6659, 'SmartAI', 0, 3, 1, 12, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31503, 0, 0, 0, 0, 0, 27473, 0, 0, 0, 'Portal Keeper (1)', '', '', 0, 81, 81, 2, 1720, 0, 1, 1.14286, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 31503, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6659, 6659, '', 0, 3, 1, 12.5, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM smart_scripts WHERE entryorguid IN(30695, 31503) AND source_type=0;
INSERT INTO `smart_scripts` VALUES (30695, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 6000, 8000, 11, 58531, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Missiles (Normal)');
INSERT INTO `smart_scripts` VALUES (30695, 0, 1, 0, 0, 0, 100, 4, 6000, 8000, 6000, 8000, 11, 61593, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Missiles (Heroic)');
INSERT INTO `smart_scripts` VALUES (30695, 0, 2, 0, 0, 0, 100, 2, 13000, 19000, 13000, 19000, 11, 58532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostbolt Volley (Normal)');
INSERT INTO `smart_scripts` VALUES (30695, 0, 3, 0, 0, 0, 100, 4, 13000, 19000, 13000, 19000, 11, 61594, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frostbolt Volley (Heroic)');
INSERT INTO `smart_scripts` VALUES (30695, 0, 4, 0, 0, 0, 100, 4, 6000, 9000, 9000, 14000, 11, 58534, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deep Freeze');

-- Azure Invader (30661, 31487) (30961, 31488)
DELETE FROM creature_template_addon WHERE entry IN(30661, 31487);
REPLACE INTO `creature_template` VALUES (30661, 31487, 0, 0, 0, 0, 25226, 0, 0, 0, 'Azure Invader', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 1.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_invader', 12340);
REPLACE INTO `creature_template` VALUES (31487, 0, 0, 0, 0, 0, 25226, 0, 0, 0, 'Azure Invader (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(30961, 31488);
REPLACE INTO `creature_template` VALUES (30961, 31488, 0, 0, 0, 0, 25226, 0, 0, 0, 'Azure Invader', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 1.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_invader', 12340);
REPLACE INTO `creature_template` VALUES (31488, 0, 0, 0, 0, 0, 25226, 0, 0, 0, 'Azure Invader (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Spellbreaker (30662, 31494) (30962, 31495)
DELETE FROM creature_template_addon WHERE entry IN(30662, 31494);
REPLACE INTO `creature_template` VALUES (30662, 31494, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Spellbreaker', '', '', 0, 75, 75, 2, 16, 0, 1, 1.14286, 1, 1, 339, 481, 0, 370, 1.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_spellbreaker', 12340);
REPLACE INTO `creature_template` VALUES (31494, 0, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Spellbreaker (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 4, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(30962, 31495);
REPLACE INTO `creature_template` VALUES (30962, 31495, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Spellbreaker', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 339, 481, 0, 370, 1.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_spellbreaker', 12340);
REPLACE INTO `creature_template` VALUES (31495, 0, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Spellbreaker (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 4, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Binder (30663, 31483) (30918, 31484)
DELETE FROM creature_template_addon WHERE entry IN(30663, 31483);
REPLACE INTO `creature_template` VALUES (30663, 31483, 0, 0, 0, 0, 25247, 0, 0, 0, 'Azure Binder', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 289, 421, 0, 175, 1.5, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 271, 403, 45, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_binder', 12340);
REPLACE INTO `creature_template` VALUES (31483, 0, 0, 0, 0, 0, 25247, 0, 0, 0, 'Azure Binder (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 4, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(30918, 31484);
REPLACE INTO `creature_template` VALUES (30918, 31484, 0, 0, 0, 0, 25247, 0, 0, 0, 'Azure Binder', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 289, 421, 0, 175, 1.5, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 271, 403, 45, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.8, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_binder', 12340);
REPLACE INTO `creature_template` VALUES (31484, 0, 0, 0, 0, 0, 25247, 0, 0, 0, 'Azure Binder (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 4, 2000, 0, 8, 0, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Mage Slayer (30664, 31497) (30963, 31498)
DELETE FROM creature_template_addon WHERE entry IN(30664, 31497);
REPLACE INTO `creature_template` VALUES (30664, 31497, 0, 0, 0, 0, 24910, 0, 0, 0, 'Azure Mage Slayer', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 1.5, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_mage_slayer', 12340);
REPLACE INTO `creature_template` VALUES (31497, 0, 0, 0, 0, 0, 24910, 0, 0, 0, 'Azure Mage Slayer (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);
DELETE FROM creature_template_addon WHERE entry IN(30963, 31498);
REPLACE INTO `creature_template` VALUES (30963, 31498, 0, 0, 0, 0, 24910, 0, 0, 0, 'Azure Mage Slayer', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 339, 481, 0, 370, 1.5, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_mage_slayer', 12340);
REPLACE INTO `creature_template` VALUES (31498, 0, 0, 0, 0, 0, 24910, 0, 0, 0, 'Azure Mage Slayer (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 4, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Captain (30666, 31486)
DELETE FROM creature_template_addon WHERE entry IN(30666, 31486);
REPLACE INTO `creature_template` VALUES (30666, 31486, 0, 0, 0, 0, 14356, 0, 0, 0, 'Azure Captain', '', '', 0, 75, 75, 2, 16, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 3, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 2, 8, 30666, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6663, 6663, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_captain', 12340);
REPLACE INTO `creature_template` VALUES (31486, 0, 0, 0, 0, 0, 14356, 0, 0, 0, 'Azure Captain (1)', '', '', 0, 81, 81, 2, 16, 0, 1, 1.14286, 1, 1, 464, 604, 0, 708, 7, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 8, 31486, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6663, 6663, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Sorceror (30667, 31493)
DELETE FROM creature_template_addon WHERE entry IN(30667, 31493);
REPLACE INTO `creature_template` VALUES (30667, 31493, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Sorceror', '', '', 0, 75, 75, 2, 16, 0, 1, 1.14286, 1, 1, 339, 481, 0, 370, 4, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 293, 436, 53, 2, 8, 30667, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6668, 6668, '', 0, 3, 1, 4, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_sorceror', 12340);
REPLACE INTO `creature_template` VALUES (31493, 0, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Sorceror (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 8, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 2, 8, 31493, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6668, 6668, '', 0, 3, 1, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Raider (30668, 31490)
DELETE FROM creature_template_addon WHERE entry IN(30668, 31490);
REPLACE INTO `creature_template` VALUES (30668, 31490, 0, 0, 0, 0, 27219, 0, 0, 0, 'Azure Raider', '', '', 0, 75, 75, 2, 16, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 2, 8, 30668, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6648, 6648, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_raider', 12340);
REPLACE INTO `creature_template` VALUES (31490, 0, 0, 0, 0, 0, 27219, 0, 0, 0, 'Azure Raider (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 8, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 31490, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6648, 6648, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Stalker (32191, 32192)
DELETE FROM creature_template_addon WHERE entry IN(32191, 32192);
REPLACE INTO `creature_template` VALUES (32191, 32192, 0, 0, 0, 0, 27220, 0, 0, 0, 'Azure Stalker', '', '', 0, 75, 75, 2, 16, 0, 1, 1.14286, 1, 1, 342, 485, 0, 392, 4, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 295, 438, 68, 2, 8, 32191, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6666, 6666, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_azure_stalker', 12340);
REPLACE INTO `creature_template` VALUES (32192, 0, 0, 0, 0, 0, 27220, 0, 0, 0, 'Azure Stalker (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 422, 586, 0, 642, 8, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 2, 8, 32192, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6666, 6666, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Azure Saboteur (31079, 31492)
REPLACE INTO `creature_template_addon` VALUES (31079, 0, 0, 0, 1, 0, "45775");
REPLACE INTO `creature_template_addon` VALUES (31492, 0, 0, 0, 1, 0, "45775");
REPLACE INTO `creature_template` VALUES (31079, 31492, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Saboteur', '', '', 0, 75, 75, 2, 1720, 0, 1, 1.14286, 1, 1, 289, 421, 0, 175, 7.5, 2000, 0, 8, 131586, 2048, 8, 0, 0, 0, 0, 0, 271, 403, 45, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_azure_saboteur', 12340);
REPLACE INTO `creature_template` VALUES (31492, 0, 0, 0, 0, 0, 25250, 0, 0, 0, 'Azure Saboteur (1)', '', '', 0, 80, 80, 2, 1720, 0, 1, 1.14286, 1, 1, 346, 499, 0, 287, 13, 2000, 0, 8, 131586, 2048, 8, 0, 0, 0, 0, 0, 315, 468, 69, 2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);



-- ###################
-- ### SPELLS
-- ###################

-- Arcane Lightning (57912)
-- Arcane Lightning (57930)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(57912, 57930);
-- portals' trash:
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 0, 31, 0, 3, 30857, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 1, 31, 0, 3, 30660, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 2, 31, 0, 3, 30695, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 3, 31, 0, 3, 30661, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 4, 31, 0, 3, 30961, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 5, 31, 0, 3, 30662, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 6, 31, 0, 3, 30962, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 7, 31, 0, 3, 30663, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 8, 31, 0, 3, 30918, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 9, 31, 0, 3, 30664, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 10, 31, 0, 3, 30963, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 11, 31, 0, 3, 30666, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 12, 31, 0, 3, 30667, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 13, 31, 0, 3, 30668, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 14, 31, 0, 3, 32191, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 6, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 7, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 8, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 9, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 10, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 11, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 12, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 13, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 14, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);

REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 0, 31, 0, 3, 30857, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 1, 31, 0, 3, 30660, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 2, 31, 0, 3, 30695, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 3, 31, 0, 3, 30661, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 4, 31, 0, 3, 30961, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 5, 31, 0, 3, 30662, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 6, 31, 0, 3, 30962, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 7, 31, 0, 3, 30663, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 8, 31, 0, 3, 30918, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 9, 31, 0, 3, 30664, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 10, 31, 0, 3, 30963, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 11, 31, 0, 3, 30666, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 12, 31, 0, 3, 30667, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 13, 31, 0, 3, 30668, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 14, 31, 0, 3, 32191, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 3, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 4, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 5, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 6, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 7, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 8, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 9, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 10, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 11, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 12, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 13, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 14, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
-- bosses and their minions/trash:
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 15, 31, 0, 3, 29266, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 16, 31, 0, 3, 29312, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 17, 31, 0, 3, 29313, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 18, 31, 0, 3, 29321, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 19, 31, 0, 3, 29314, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 20, 31, 0, 3, 29315, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 21, 31, 0, 3, 29395, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 22, 31, 0, 3, 29316, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 23, 31, 0, 3, 31134, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 15, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 16, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 17, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 18, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 19, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 20, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 21, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 22, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57912, 0, 23, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);

REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 15, 31, 0, 3, 29266, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 16, 31, 0, 3, 29312, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 17, 31, 0, 3, 29313, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 18, 31, 0, 3, 29321, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 19, 31, 0, 3, 29314, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 20, 31, 0, 3, 29315, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 21, 31, 0, 3, 29395, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 22, 31, 0, 3, 29316, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 23, 31, 0, 3, 31134, 1, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 15, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 16, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 17, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 18, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 19, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 20, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 21, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 22, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 1, 57930, 0, 23, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);


-- Destroy Door Seal (58040)
DELETE FROM spell_script_names WHERE spell_id IN(58040,-58040);
REPLACE INTO spell_script_names VALUES(58040, "spell_destroy_door_seal");




-- ###################
-- ### ACHIEVEMENTS
-- ###################

-- Defenseless (1816)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6803);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6803);
REPLACE INTO achievement_criteria_data VALUES(6803, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(6803, 18, 0, 0, "");

-- A Void Dance (2153)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7587);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7587);
REPLACE INTO achievement_criteria_data VALUES(7587, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7587, 18, 0, 0, "");

-- Dehydration (2041)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7320);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7320);
REPLACE INTO achievement_criteria_data VALUES(7320, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7320, 18, 0, 0, "");

-- Lockdown! (1865)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7137,7138,7139,7140,7141,7142);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7137,7138,7139,7140,7141,7142);
REPLACE INTO achievement_criteria_data VALUES(7137, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7138, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7139, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7140, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7141, 12, 1, 0, "");
REPLACE INTO achievement_criteria_data VALUES(7142, 12, 1, 0, "");

-- The Violet Hold (483)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3582);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3582);
REPLACE INTO achievement_criteria_data VALUES(3582, 12, 0, 0, "");

-- Heroic: The Violet Hold (494)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6855);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6855);
REPLACE INTO achievement_criteria_data VALUES(6855, 12, 1, 0, "");




-- ###################
-- ### MORAGG
-- ###################

-- Moragg (29316, 31510)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29316, 31510) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29316, 31510);
REPLACE INTO `creature_template` VALUES (29316, 31510, 0, 0, 0, 0, 20590, 0, 0, 0, 'Moragg', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 478, 7.5, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 3, 72, 29316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6687, 6687, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_moragg', 12340);
REPLACE INTO `creature_template` VALUES (31510, 0, 0, 0, 0, 0, 20590, 0, 0, 0, 'Moragg (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 782, 13, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 31510, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6687, 6687, '', 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 12340);

-- spell Optic Link (54396)
DELETE FROM spell_script_names WHERE spell_id IN(54396,-54396);
REPLACE INTO spell_script_names VALUES(54396, "spell_optic_link");




-- ###################
-- ### EREKEM
-- ###################

-- Erekem (29315, 31507)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29315, 31507) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29315, 31507);
REPLACE INTO `creature_template` VALUES (29315, 31507, 0, 0, 0, 0, 27488, 0, 0, 0, 'Erekem', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 452, 8, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 311, 463, 62, 7, 72, 29315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4895, 8159, '', 0, 3, 1, 12, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 617299839, 0+0x200000, 'boss_erekem', 12340);
REPLACE INTO `creature_template` VALUES (31507, 0, 0, 0, 0, 0, 27488, 0, 0, 0, 'Erekem (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 726, 15, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 7, 72, 31507, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9790, 16318, '', 0, 3, 1, 32, 20, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 617299839, 1+0x200000, '', 12340);

-- Erekem Guard (29395, 31513)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29395, 31513) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29395, 31513);
REPLACE INTO `creature_template` VALUES (29395, 31513, 0, 0, 0, 0, 18628, 0, 0, 0, 'Erekem Guard', '', '', 0, 76, 76, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 432, 3, 2000, 0, 1, 512, 2048, 8, 0, 0, 0, 0, 0, 305, 452, 74, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, 'npc_erekem_guard', 12340);
REPLACE INTO `creature_template` VALUES (31513, 0, 0, 0, 0, 0, 18628, 0, 0, 0, 'Erekem Guard (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 642, 6, 2000, 0, 1, 512, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 7, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);




-- ###################
-- ### ICHORON
-- ###################

-- Ichoron (29313, 31508)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29313, 31508) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29313, 31508);
REPLACE INTO `creature_template` VALUES (29313, 31508, 0, 0, 0, 0, 27487, 0, 0, 0, 'Ichoron', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 452, 8, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 311, 463, 62, 4, 72, 29313, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6635, 6635, '', 0, 3, 1, 20, 18.7, 1, 0, 42107, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_ichoron', 12340);
REPLACE INTO `creature_template` VALUES (31508, 0, 0, 0, 0, 0, 27487, 0, 0, 0, 'Ichoron (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 726, 15, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 4, 72, 31508, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6635, 6635, '', 0, 3, 1, 32, 18.7, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 12340);

-- Ichor Globule (29321, 31515)
DELETE FROM creature_template_addon WHERE entry IN(29321, 31515);
REPLACE INTO `creature_template` VALUES (29321, 31515, 0, 0, 0, 0, 17200, 0, 0, 0, 'Ichor Globule', '', '', 0, 76, 76, 2, 16, 0, 1, 1.14286, 1, 1, 352, 499, 0, 408, 1, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 302, 449, 57, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.181802, 1, 1, 0, 0, 0, 0, 0, 0, 0, 84, 0, 0, 0, 'npc_ichor_globule', 12340);
REPLACE INTO `creature_template` VALUES (31515, 0, 0, 0, 0, 0, 17200, 0, 0, 0, 'Ichor Globule (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 1, 2000, 0, 2, 0, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.227253, 1, 1, 0, 0, 0, 0, 0, 0, 0, 84, 0, 0, 0, '', 12340);

-- Ichoron Summon Target (29326)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29326) and `map`=608 );
DELETE FROM creature WHERE id IN(29326);
UPDATE creature_template SET flags_extra=130 WHERE entry=29326;




-- ###################
-- ### LAVANTHOR
-- ###################

-- Lavanthor (29312, 31509)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29312, 31509) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29312, 31509);
REPLACE INTO `creature_template` VALUES (29312, 31509, 0, 0, 0, 0, 10193, 0, 0, 0, 'Lavanthor', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 478, 8, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 1, 72, 29312, 0, 70213, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6666, 6666, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_lavanthor', 12340);
REPLACE INTO `creature_template` VALUES (31509, 0, 0, 0, 0, 0, 10193, 0, 0, 0, 'Lavanthor (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 782, 15, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 1, 72, 31509, 0, 70213, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6666, 6666, '', 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 12340);




-- ###################
-- ### XEVOZZ
-- ###################

-- Xevozz (29266, 31511)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29266, 31511) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29266, 31511);
REPLACE INTO `creature_template` VALUES (29266, 31511, 0, 0, 0, 0, 27486, 0, 0, 0, 'Xevozz', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 478, 8, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 7, 72, 29266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5031, 8385, '', 0, 3, 1, 20, 10, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_xevozz', 12340);
REPLACE INTO `creature_template` VALUES (31511, 0, 0, 0, 0, 0, 27486, 0, 0, 0, 'Xevozz (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 782, 15, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 7, 72, 31511, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10062, 16770, '', 0, 3, 1, 32, 10, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 12340);

-- Ethereal Sphere (29271, 31514) ----- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! DAMAGING AURA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
REPLACE INTO creature_template_addon VALUES(29271, 0, 0, 0, 1, 0, "54141 54207");
REPLACE INTO creature_template_addon VALUES(31514, 0, 0, 0, 1, 0, "54141 59476");
REPLACE INTO `creature_template` VALUES (29271, 31514, 0, 0, 0, 0, 28073, 0, 0, 0, 'Ethereal Sphere', '', '', 0, 77, 77, 2, 16, 0, 1, 0.5, 1, 1, 1, 1, 0, 1, 1, 2000, 0, 1, 131072, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31514, 0, 0, 0, 0, 0, 28073, 0, 0, 0, 'Ethereal Sphere (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 0.5, 1, 1, 1, 1, 0, 1, 1, 2000, 0, 1, 131072, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, '', 12340);

-- spell Arcane Power (54160, 59474)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(54160, 59474);
REPLACE INTO `conditions` VALUES (13, 7, 54160, 0, 0, 31, 0, 3, 29266, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 7, 54160, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 7, 59474, 0, 0, 31, 0, 3, 29266, 0, 0, 0, 0, '', NULL);
REPLACE INTO `conditions` VALUES (13, 7, 59474, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', NULL);

-- spell Summon Ethereal Sphere (54102, 54137, 54138);
REPLACE INTO spell_target_position VALUES(54102, 0, 608, 1886.34, 810.20, 38.43, 1.59);
REPLACE INTO spell_target_position VALUES(54137, 0, 608, 1886.08, 828.56, 38.65, 0.1);
REPLACE INTO spell_target_position VALUES(54138, 0, 608, 1888.27, 783.9, 38.65, 1.2);




-- ###################
-- ### ZURAMAT
-- ###################

-- Zuramat the Obliterator (29314, 31512)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id IN(29314, 31512) and `map`=608 );
DELETE FROM creature_template_addon WHERE entry IN(29314, 31512);
REPLACE INTO `creature_template` VALUES (29314, 31512, 0, 0, 0, 0, 27855, 0, 0, 0, 'Zuramat the Obliterator', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 478, 8, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 3, 72, 29314, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6662, 6662, '', 0, 3, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 0+0x200000, 'boss_zuramat', 12340);
REPLACE INTO `creature_template` VALUES (31512, 0, 0, 0, 0, 0, 27855, 0, 0, 0, 'Zuramat the Obliterator (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 782, 15, 2000, 0, 1, 514, 2048, 8, 0, 0, 0, 0, 0, 363, 521, 121, 3, 72, 31512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6662, 6662, '', 0, 3, 1, 32, 1, 1, 0, 0, 0, 0, 0, 0, 0, 167, 1, 650854271, 1+0x200000, '', 12340);

-- Void Sentry (29364, 31518)
DELETE FROM creature_template_addon WHERE entry IN(29364, 31518);
REPLACE INTO `creature_template` VALUES (29364, 31518, 0, 0, 0, 0, 26208, 0, 0, 0, 'Void Sentry', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.043941, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'npc_vh_void_sentry', 12340);
REPLACE INTO `creature_template` VALUES (31518, 0, 0, 0, 0, 0, 26208, 0, 0, 0, 'Void Sentry (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 1, 1, 0, 1, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 1, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.15873, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 12340);

-- Void Sentry (BALL) (29365, 31519)
REPLACE INTO creature_template_addon VALUES(29365, 0, 0, 0, 1, 0, "54342");
REPLACE INTO creature_template_addon VALUES(31519, 0, 0, 0, 1, 0, "59747");
REPLACE INTO `creature_template` VALUES (29365, 31519, 0, 0, 0, 0, 23767, 0, 0, 0, 'Void Sentry', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 0, 371, 522, 0, 478, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);
REPLACE INTO `creature_template` VALUES (31519, 0, 0, 0, 0, 0, 23767, 0, 0, 0, 'Void Sentry (1)', '', '', 0, 80, 80, 2, 16, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 3, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);

-- spell Void Shifted (54343)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(54343, -54343, 54361, -54361, 59743, -59743);
INSERT INTO spell_linked_spell VALUES(-54361, 54343, 0, "");
INSERT INTO spell_linked_spell VALUES(-59743, 54343, 0, "");




-- ###################
-- ### CYANIGOSA
-- ###################

-- Cyanigosa (31134, 31506)
DELETE FROM creature_template_addon WHERE entry IN(31134, 31506);
REPLACE INTO `creature_template` VALUES (31134, 31506, 0, 0, 0, 0, 27508, 0, 0, 0, 'Cyanigosa', '', '', 0, 77, 77, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 452, 10, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 311, 463, 62, 2, 72, 31134, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6691, 6691, '', 0, 3, 1, 25, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 650854271, 0+0x200000, 'boss_cyanigosa', 12340);
REPLACE INTO `creature_template` VALUES (31506, 0, 0, 0, 0, 0, 27508, 0, 0, 0, 'Cyanigosa (1)', '', '', 0, 82, 82, 2, 16, 0, 1, 1.14286, 1, 1, 450, 550, 0, 726, 18, 2000, 0, 2, 514, 2048, 8, 0, 0, 0, 0, 0, 360, 520, 91, 2, 72, 31506, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6691, 6691, '', 0, 3, 1, 37.5, 10, 1, 0, 43823, 0, 0, 0, 0, 0, 0, 1, 650854271, 1+0x200000, '', 12340);

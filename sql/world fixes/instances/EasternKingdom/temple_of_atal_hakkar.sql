
UPDATE creature SET spawntimesecs=86400 WHERE map=109 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=109 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- Spawn of Hakkar (5708)
REPLACE INTO creature_addon VALUES (33621, 336210, 0, 0, 4097, 0, '');
REPLACE INTO creature_addon VALUES (34520, 345200, 0, 0, 4097, 0, '');
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid IN(33621, 34520);
DELETE FROM waypoint_data WHERE id IN(336210, 345200);
INSERT INTO waypoint_data VALUES (336210, 1, -536.665, 29.3442, -148.802, 0, 0, 1, 0, 100, 0),(336210, 2, -544.473, 37.9502, -148.802, 0, 0, 1, 0, 100, 0),(336210, 3, -552.281, 46.5561, -148.802, 0, 0, 1, 0, 100, 0),(336210, 4, -555.884, 60.012, -148.802, 0, 0, 1, 0, 100, 0),(336210, 5, -561.874, 82.6116, -148.802, 0, 0, 1, 0, 100, 0),(336210, 6, -565.935, 99.6341, -148.802, 0, 0, 1, 0, 100, 0),(336210, 7, -561.094, 116.451, -148.802, 0, 0, 1, 0, 100, 0),(336210, 8, -561.094, 116.451, -148.802, 0, 0, 1, 0, 100, 0),(336210, 9, -547.66, 149.369, -148.727, 0, 0, 1, 0, 100, 0),(336210, 10, -537.914, 161.02, -148.76, 0, 0, 1, 0, 100, 0),(336210, 11, -517.614, 180.304, -148.802, 0, 0, 1, 0, 100, 0),(336210, 12, -505.439, 184.507, -148.802, 0, 0, 1, 0, 100, 0),(336210, 13, -479.221, 190.063, -148.802, 0, 0, 1, 0, 100, 0),(336210, 14, -466.789, 193.151, -148.826, 0, 0, 1, 0, 100, 0),(336210, 15, -450.823, 189.492, -148.843, 0, 0, 1, 0, 100, 0),(336210, 16, -438.529, 185.891, -148.853, 0, 0, 1, 0, 100, 0),(336210, 17, -423.421, 179.746, -148.824, 0, 0, 1, 0, 100, 0),
(336210, 18, -413.68, 175.829, -148.802, 0, 0, 1, 0, 100, 0),(336210, 19, -405.127, 167.962, -148.802, 0, 0, 1, 0, 100, 0),(336210, 20, -389.897, 151.824, -148.802, 0, 0, 1, 0, 100, 0),(336210, 21, -384.916, 146.906, -148.802, 0, 0, 1, 0, 100, 0),(336210, 22, -379.572, 131.422, -148.802, 0, 0, 1, 0, 100, 0),(336210, 23, -373.53, 112.482, -148.802, 0, 0, 1, 0, 100, 0),(336210, 24, -370.542, 99.9538, -148.802, 0, 0, 1, 0, 100, 0),(336210, 25, -369.676, 94.1379, -148.802, 0, 0, 1, 0, 100, 0),(336210, 26, -372.481, 80.4218, -148.802, 0, 0, 1, 0, 100, 0),(336210, 27, -378.448, 60.2874, -148.802, 0, 0, 1, 0, 100, 0),(336210, 28, -382.426, 46.8645, -148.802, 0, 0, 1, 0, 100, 0),(336210, 29, -391.785, 39.8591, -148.802, 0, 0, 1, 0, 100, 0),(336210, 30, -402.853, 26.304, -148.802, 0, 0, 1, 0, 100, 0),(336210, 31, -416.243, 13.2642, -148.802, 0, 0, 1, 0, 100, 0),(336210, 32, -432.498, 6.78171, -148.802, 0, 0, 1, 0, 100, 0),(336210, 33, -447.952, 1.56867, -148.802, 0, 0, 1, 0, 100, 0),(336210, 34, -467.528, -1.89777, -148.802, 0, 0, 1, 0, 100, 0),
(336210, 35, -490.316, 3.31944, -148.802, 0, 0, 1, 0, 100, 0),(336210, 36, -505.122, 6.71271, -148.75, 0, 0, 1, 0, 100, 0),(336210, 37, -518.361, 11.2668, -148.802, 0, 0, 1, 0, 100, 0),(336210, 38, -526.441, 17.9714, -148.802, 0, 0, 1, 0, 100, 0),(345200, 1, -375.804, 73.8393, -148.802, 0, 0, 1, 0, 100, 0),(345200, 2, -379.572, 57.9706, -148.802, 0, 0, 1, 0, 100, 0),(345200, 3, -382.18, 47.872, -148.802, 0, 0, 1, 0, 100, 0),(345200, 4, -392.86, 40.534, -148.802, 0, 0, 1, 0, 100, 0),(345200, 5, -396.675, 33.2865, -148.802, 0, 0, 1, 0, 100, 0),(345200, 6, -405.934, 22.7862, -148.802, 0, 0, 1, 0, 100, 0),(345200, 7, -418.755, 10.8754, -148.759, 0, 0, 1, 0, 100, 0),(345200, 8, -435.406, 5.49174, -148.802, 0, 0, 1, 0, 100, 0),(345200, 9, -453.402, 0.444612, -148.802, 0, 0, 1, 0, 100, 0),(345200, 10, -467.158, -2.15878, -148.802, 0, 0, 1, 0, 100, 0),(345200, 11, -480.937, 0.317751, -148.802, 0, 0, 1, 0, 100, 0),(345200, 12, -493.477, 2.93365, -148.802, 0, 0, 1, 0, 100, 0),(345200, 13, -508.107, 7.02061, -148.733, 0, 0, 1, 0, 100, 0),
(345200, 14, -518.993, 13.7724, -148.802, 0, 0, 1, 0, 100, 0),(345200, 15, -528.819, 21.9908, -148.802, 0, 0, 1, 0, 100, 0),(345200, 16, -541.417, 34.1381, -148.802, 0, 0, 1, 0, 100, 0),(345200, 17, -551.494, 43.856, -148.802, 0, 0, 1, 0, 100, 0),(345200, 18, -555.531, 56.0134, -148.802, 0, 0, 1, 0, 100, 0),(345200, 19, -559.502, 71.8326, -148.802, 0, 0, 1, 0, 100, 0),(345200, 20, -563.801, 87.6383, -148.802, 0, 0, 1, 0, 100, 0),(345200, 21, -565.783, 96.7349, -148.802, 0, 0, 1, 0, 100, 0),(345200, 22, -562.412, 113.907, -148.802, 0, 0, 1, 0, 100, 0),(345200, 23, -556.981, 131.717, -148.802, 0, 0, 1, 0, 100, 0),(345200, 24, -552.197, 142.384, -148.708, 0, 0, 1, 0, 100, 0),(345200, 25, -545.688, 152.094, -148.741, 0, 0, 1, 0, 100, 0),(345200, 26, -528.811, 166.502, -148.708, 0, 0, 1, 0, 100, 0),(345200, 27, -515.339, 182.61, -148.802, 0, 0, 1, 0, 100, 0),(345200, 28, -502.035, 186.969, -148.802, 0, 0, 1, 0, 100, 0),(345200, 29, -488.126, 188.563, -148.802, 0, 0, 1, 0, 100, 0),(345200, 30, -470.957, 191.952, -148.802, 0, 0, 1, 0, 100, 0),
(345200, 31, -462.777, 192.358, -148.873, 0, 0, 1, 0, 100, 0),(345200, 32, -449.195, 188.963, -148.843, 0, 0, 1, 0, 100, 0),(345200, 33, -435.613, 185.568, -148.861, 0, 0, 1, 0, 100, 0),(345200, 34, -422.257, 181.61, -148.838, 0, 0, 1, 0, 100, 0),(345200, 35, -414.764, 175.967, -148.802, 0, 0, 1, 0, 100, 0),(345200, 36, -402.158, 165.508, -148.802, 0, 0, 1, 0, 100, 0),(345200, 37, -390.858, 155.357, -148.802, 0, 0, 1, 0, 100, 0),(345200, 38, -385.521, 149.238, -148.802, 0, 0, 1, 0, 100, 0),(345200, 39, -380.797, 136.058, -148.802, 0, 0, 1, 0, 100, 0),(345200, 40, -374.415, 116.052, -148.802, 0, 0, 1, 0, 100, 0),(345200, 41, -370.004, 102.765, -148.802, 0, 0, 1, 0, 100, 0);


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Unliving Atal'ai (5267)
DELETE FROM creature_text WHERE entry=5267;
INSERT INTO creature_text VALUES (5267, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Unliving Atal''ai');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5267;
DELETE FROM smart_scripts WHERE entryorguid=5267 AND source_type=0;
INSERT INTO smart_scripts VALUES (5267, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal''ai - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (5267, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal''ai - Between 0-30% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (5267, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal''ai - Between 0-30% Health - Say Line 0');

-- Atal'ai Witch Doctor (5259)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5259;
DELETE FROM smart_scripts WHERE entryorguid=5259 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=-34524 AND source_type=0;
INSERT INTO smart_scripts VALUES (5259, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3500, 5000, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (5259, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 10000, 18000, 11, 12058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (5259, 0, 2, 0, 0, 0, 100, 0, 10000, 13000, 19000, 28000, 11, 11641, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - In Combat - Cast Hex');
INSERT INTO smart_scripts VALUES (5259, 0, 3, 0, 14, 0, 100, 0, 1800, 30, 10000, 15000, 11, 11986, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (5259, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (5259, 0, 5, 0, 1, 0, 100, 0, 1000, 3000, 5000, 10000, 11, 32992, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Witch Doctor - Out of Combat - Cast Ice Cast Visual'); -- ZOMG! WRONG
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5259;
INSERT INTO conditions VALUES(22, 6, 5259, 0, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Run action if npc is in phase');

-- Deep Lurker (8384)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8384;
DELETE FROM smart_scripts WHERE entryorguid=8384 AND source_type=0;
INSERT INTO smart_scripts VALUES (8384, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 9000, 15000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deep Lurker - In Combat - Cast Trample');

-- Slime Maggot (8311)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8311;
DELETE FROM smart_scripts WHERE entryorguid=8311 AND source_type=0;

-- Spawn of Hakkar (5708)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5708;
DELETE FROM smart_scripts WHERE entryorguid=5708 AND source_type=0;
INSERT INTO smart_scripts VALUES (5708, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 9000, 15000, 11, 12280, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Spawn of Hakkar - In Combat - Cast Acid of Hakkar');

-- Murk Worm (5226)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5226;
DELETE FROM smart_scripts WHERE entryorguid=5226 AND source_type=0;
INSERT INTO smart_scripts VALUES (5226, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murk Worm - On Reset - Cast Slowing Poison');

-- Saturated Ooze (5228)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5228;
DELETE FROM smart_scripts WHERE entryorguid=5228 AND source_type=0;
INSERT INTO smart_scripts VALUES (5228, 0, 0, 0, 0, 0, 100, 0, 5000, 19000, 28000, 36000, 11, 12018, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Saturated Ooze - In Combat - Cast Summon Oozelin');

-- Oozeling (8257)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=8257);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8257);
DELETE FROM creature WHERE id=8257;
DELETE FROM creature_loot_template WHERE entry=8257;
UPDATE creature_template SET lootid=0, AIName='', ScriptName='' WHERE entry=8257;
DELETE FROM smart_scripts WHERE entryorguid=8257 AND source_type=0;

-- Atal'ai Slave (8318)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8318;
DELETE FROM smart_scripts WHERE entryorguid=8318 AND source_type=0;

-- Atal'ai Warrior (5713)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5713;
DELETE FROM smart_scripts WHERE entryorguid=5713 AND source_type=0;
INSERT INTO smart_scripts VALUES (5713, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 6000, 9000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Warrior - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (5713, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 12000, 18000, 11, 13445, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Warrior - In Combat - Cast Rend');

-- Atal'ai Corpse Eater (5270)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5270;
DELETE FROM smart_scripts WHERE entryorguid=5270 AND source_type=0;
-- INSERT INTO smart_scripts VALUES (5270, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 69, 1, 0, 1, 0, 0, 0, 11, 0, 15, 2, 0, 0, 0, 0, 'Atal''ai Corpse Eater - Health Between 0-30% - Move To Pos');
INSERT INTO smart_scripts VALUES (5270, 0, 1, 0, 34, 0, 100, 1, 8, 1, 0, 0, 11, 12134, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Corpse Eater - Movement Inform - Cast Atal''ai Corpse Eat');

-- Nightmare Wanderer (5283)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5283;
DELETE FROM smart_scripts WHERE entryorguid=5283 AND source_type=0;
INSERT INTO smart_scripts VALUES (5283, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 6000, 9000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Wanderer - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (5283, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 18000, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Wanderer - In Combat - Cast Pierce Armor');

-- Nightmare Wyrmkin (5280)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5280;
DELETE FROM smart_scripts WHERE entryorguid=5280 AND source_type=0;
INSERT INTO smart_scripts VALUES (5280, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 15653, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Wyrmkin - In Combat - Cast Acid Spit');
INSERT INTO smart_scripts VALUES (5280, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 18000, 11, 12098, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Nightmare Wyrmkin - In Combat - Cast Sleep');

-- Nightmare Scalebane (5277)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5277;
DELETE FROM smart_scripts WHERE entryorguid=5277 AND source_type=0;
INSERT INTO smart_scripts VALUES (5277, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Scalebane - On Reset - Cast Improved Blocking III');

-- Nightmare Whelp (8319)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8319;
DELETE FROM smart_scripts WHERE entryorguid=8319 AND source_type=0;

-- Mummified Atal'ai (5263)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5263;
DELETE FROM smart_scripts WHERE entryorguid=5263 AND source_type=0;
INSERT INTO smart_scripts VALUES (5263, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 7000, 11000, 11, 16186, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mummified Atal''ai - In Combat - Cast Fevered Plague');

-- Atal'ai Deathwalker (5271)
UPDATE creature_template SET unit_flags=unit_flags|0x100, AIName='SmartAI', ScriptName='' WHERE entry=5271;
DELETE FROM smart_scripts WHERE entryorguid=5271 AND source_type=0;
INSERT INTO smart_scripts VALUES (5271, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 8000, 11000, 11, 11639, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Atal''ai Deathwalker - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (5271, 0, 1, 0, 0, 0, 100, 0, 4000, 12000, 12000, 18000, 11, 12096, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Atal''ai Deathwalker - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (5271, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 12095, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Deathwalker - On Death - Cast Summon Atal''ai Deathwalker''s Spirit');
INSERT INTO smart_scripts VALUES (5271, 0, 3, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 0x100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Deathwalker - Out of Combat - Remove Unit Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5271;
INSERT INTO conditions VALUES(22, 4, 5271, 0, 0, 13, 1, 11, 6, 0, 0, 0, 0, '', 'Run action if GetData(11) == 6');

-- Atal'ai Deathwalker's Spirit (8317)
REPLACE INTO creature_template_addon VALUES (8317, 0, 0, 0, 0, 0, '7743 7940 7941 7942 34182 34184 34310 39804 34311');
UPDATE creature_template SET speed_walk=1, speed_run=0.4, AIName='SmartAI', ScriptName='' WHERE entry=8317;
DELETE FROM smart_scripts WHERE entryorguid=8317 AND source_type=0;
INSERT INTO smart_scripts VALUES (8317, 0, 0, 0, 1, 0, 100, 0, 0, 0, 2000, 2000, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Deathwalker''s Spirit - Out of Combat - Set In Combat With Zone');

-- Atal'ai High Priest (5273)
UPDATE creature_template SET unit_flags=unit_flags|0x100, AIName='SmartAI', ScriptName='' WHERE entry=5273;
DELETE FROM smart_scripts WHERE entryorguid=5273 AND source_type=0;
INSERT INTO smart_scripts VALUES (5273, 0, 0, 0, 14, 0, 100, 0, 1000, 40, 7500, 14100, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (5273, 0, 1, 0, 14, 0, 100, 0, 2000, 40, 4000, 6000, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (5273, 0, 2, 0, 0, 0, 100, 0, 0, 3000, 4000, 6000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (5273, 0, 3, 0, 0, 0, 100, 0, 5000, 15000, 25000, 35000, 11, 12040, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (5273, 0, 4, 0, 0, 0, 100, 0, 5000, 15000, 25000, 45000, 11, 12151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - In Combat - Cast Summon Atal''ai Skeleton');
INSERT INTO smart_scripts VALUES (5273, 0, 5, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 0x100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai High Priest - Out of Combat - Remove Unit Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5273;
INSERT INTO conditions VALUES(22, 6, 5273, 0, 0, 13, 1, 11, 6, 0, 0, 0, 0, '', 'Run action if GetData(11) == 6');

-- Atal'ai Priest (5269)
UPDATE creature_template SET unit_flags=unit_flags|0x100, AIName='SmartAI', ScriptName='' WHERE entry=5269;
DELETE FROM smart_scripts WHERE entryorguid=5269 AND source_type=0;
INSERT INTO smart_scripts VALUES (5269, 0, 0, 0, 14, 0, 100, 0, 1000, 40, 4000, 6000, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Priest - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (5269, 0, 1, 0, 0, 0, 100, 0, 0, 3000, 3000, 5000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Priest - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (5269, 0, 2, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 0x100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Priest - Out of Combat - Remove Unit Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5269;
INSERT INTO conditions VALUES(22, 3, 5269, 0, 0, 13, 1, 11, 6, 0, 0, 0, 0, '', 'Run action if GetData(11) == 6');

-- Hakkari Frostwing (5291)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5291;
DELETE FROM smart_scripts WHERE entryorguid=5291 AND source_type=0;
INSERT INTO smart_scripts VALUES (5291, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 8000, 16000, 11, 5708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Frostwing - In Combat - Cast Swoop');
INSERT INTO smart_scripts VALUES (5291, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 13000, 21000, 11, 8398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Frostwing - In Combat - Cast Frostbolt Volley');
INSERT INTO smart_scripts VALUES (5291, 0, 2, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Frostwing - In Combat - Cast Frost Nova');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Atal'alarion (8580)
REPLACE INTO creature_addon VALUES (34521, 345210, 0, 0, 4097, 0, '');
UPDATE creature SET phaseMask=2, spawndist=0, MovementType=2 WHERE guid=34521;
DELETE FROM waypoint_data WHERE id=345210;
INSERT INTO waypoint_data VALUES (345210, 1, -467.388, 91.0198, -189.73, 0, 0, 0, 0, 100, 0),(345210, 2, -467.459, 82.8301, -189.73, 0, 0, 0, 0, 100, 0),(345210, 3, -467.835, 73.4576, -189.73, 0, 0, 0, 0, 100, 0),(345210, 4, -467.761, 62.9579, -189.73, 0, 0, 0, 0, 100, 0),(345210, 5, -463.099, 69.6916, -189.73, 0, 0, 0, 0, 100, 0),(345210, 6, -458.797, 76.578, -189.73, 0, 0, 0, 0, 100, 0),(345210, 7, -455.602, 85.3226, -189.73, 0, 0, 0, 0, 100, 0),
(345210, 8, -454.246, 94.5334, -189.73, 0, 0, 0, 0, 100, 0),(345210, 9, -454.856, 105.016, -189.73, 0, 0, 0, 0, 100, 0),(345210, 10, -456.279, 114.287, -189.73, 0, 0, 0, 0, 100, 0),(345210, 11, -459.944, 124.127, -189.73, 0, 0, 0, 0, 100, 0),(345210, 12, -468.106, 132.496, -189.73, 0, 0, 0, 0, 100, 0),(345210, 13, -468.133, 126.686, -189.73, 0, 0, 0, 0, 100, 0),(345210, 14, -468.183, 116.186, -189.73, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_text WHERE entry=8580;
INSERT INTO creature_text VALUES (8580, 0, 0, 'My banishment is ended. Let the blood flow.', 14, 14, 100, 0, 0, 5859, 3, 'Atal''alarion');
INSERT INTO creature_text VALUES (8580, 1, 0, 'I''ll feast on your bones!', 14, 14, 100, 0, 0, 5860, 3, 'Atal''alarion');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8580;
DELETE FROM smart_scripts WHERE entryorguid=8580 AND source_type=0;
INSERT INTO smart_scripts VALUES (8580, 0, 1, 2, 60, 0, 100, 257, 0, 0, 3000, 3000, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - On Update - Set Ingame Phase Mask');
INSERT INTO smart_scripts VALUES (8580, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (8580, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (8580, 0, 4, 0, 0, 0, 100, 0, 3000, 8000, 11000, 14000, 11, 12887, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - In Combat - Cast Sweeping Slam');
INSERT INTO smart_scripts VALUES (8580, 0, 5, 0, 0, 0, 100, 0, 10000, 12000, 15000, 15000, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - In Combat - Cast Ground Tremor');
INSERT INTO smart_scripts VALUES (8580, 0, 6, 7, 6, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 20, 148838, 100, 0, 0, 0, 0, 0, 'Atal''alarion - On Death - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (8580, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''alarion - On Death - Set Instance Data 0 to 3');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=8580;
INSERT INTO conditions VALUES(22, 2, 8580, 0, 0, 13, 1, 10, 6, 0, 0, 0, 0, '', 'Run action if GetData(10) == 6');

-- Gasher (5713)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5713;
DELETE FROM smart_scripts WHERE entryorguid=5713 AND source_type=0;
INSERT INTO smart_scripts VALUES (5713, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 6000, 9000, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gasher - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (5713, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gasher - On Death - Set Instance Data 11');

-- Zolo (5712)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5712;
DELETE FROM smart_scripts WHERE entryorguid=5712 AND source_type=0;
INSERT INTO smart_scripts VALUES (5712, 0, 0, 0, 0, 0, 100, 0, 6500, 6500, 9500, 12400, 11, 12058, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zolo - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (5712, 0, 1, 0, 0, 0, 100, 0, 10000, 12000, 25000, 35000, 11, 12506, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zolo - In Combat - Cast Atal''ai Skeleton Totem');
INSERT INTO smart_scripts VALUES (5712, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zolo - On Death - Set Instance Data 11');

-- Atal'ai Skeleton (8324)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8324;
DELETE FROM smart_scripts WHERE entryorguid=8324 AND source_type=0;

-- Hukku (5715)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5715;
DELETE FROM smart_scripts WHERE entryorguid=5715 AND source_type=0;
INSERT INTO smart_scripts VALUES (5715, 0, 0, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 11, 12790, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hukku - In Combat - Cast Hukku''s Guardians');
INSERT INTO smart_scripts VALUES (5715, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3500, 4500, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hukku - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (5715, 0, 2, 0, 0, 0, 100, 0, 10000, 12000, 13500, 19000, 11, 14887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hukku - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (5715, 0, 3, 0, 0, 0, 100, 0, 17000, 20000, 20000, 29000, 11, 12279, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Hukku - In Combat - Cast Curse of Blood');
INSERT INTO smart_scripts VALUES (5715, 0, 4, 5, 25, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 8656, 100, 0, 0, 0, 0, 0, 'Hukku - On Reset - Despawn');
INSERT INTO smart_scripts VALUES (5715, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 8657, 100, 0, 0, 0, 0, 0, 'Hukku - On Reset - Despawn');
INSERT INTO smart_scripts VALUES (5715, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 8658, 100, 0, 0, 0, 0, 0, 'Hukku - On Reset - Despawn');
INSERT INTO smart_scripts VALUES (5715, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hukku - On Death - Set Instance Data 11');

-- Hukku's Voidwalker (8656)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8656;
DELETE FROM smart_scripts WHERE entryorguid=8656 AND source_type=0;
INSERT INTO smart_scripts VALUES (8656, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Hukku''s Voidwalker - Out of Combat - Attack Start');

-- Hukku's Succubus (8657)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8657;
DELETE FROM smart_scripts WHERE entryorguid=8657 AND source_type=0;
INSERT INTO smart_scripts VALUES (8657, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 13000, 11, 21987, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hukku''s Succubus - In Combat - Cast Lash of Pain');
INSERT INTO smart_scripts VALUES (8657, 0, 1, 0, 0, 0, 100, 0, 7000, 13000, 20000, 33000, 11, 6358, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Hukku''s Succubus - In Combat - Cast Seduction');
INSERT INTO smart_scripts VALUES (8657, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Hukku''s Succubus - Out of Combat - Attack Start');

-- Hukku's Imp (8658)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8658;
DELETE FROM smart_scripts WHERE entryorguid=8658 AND source_type=0;
INSERT INTO smart_scripts VALUES (8658, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 3000, 11, 11762, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hukku''s Imp - In Combat - Cast Firebolt');
INSERT INTO smart_scripts VALUES (8658, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Hukku''s Imp - Out of Combat - Attack Start');

-- Loro (5714)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5714;
DELETE FROM smart_scripts WHERE entryorguid=5714 AND source_type=0;
INSERT INTO smart_scripts VALUES (5714, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3418, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Loro - On Reset - Cast Improved Blocking');
INSERT INTO smart_scripts VALUES (5714, 0, 1, 0, 13, 0, 100, 0, 8000, 8000, 0, 0, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Loro - Victim Casting - Cast Shield Slam');
INSERT INTO smart_scripts VALUES (5714, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Loro - On Death - Set Instance Data 11');

-- Mijan (5717)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5717;
DELETE FROM smart_scripts WHERE entryorguid=5717 AND source_type=0;
INSERT INTO smart_scripts VALUES (5717, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 40000, 40000, 11, 8148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mijan - In Combat - Cast Thorns Aura');
INSERT INTO smart_scripts VALUES (5717, 0, 1, 0, 14, 0, 100, 0, 1400, 40, 19500, 28100, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mijan - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (5717, 0, 2, 0, 0, 0, 100, 0, 9500, 18000, 33400, 45600, 11, 11899, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mijan - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (5717, 0, 3, 0, 2, 0, 100, 0, 0, 50, 9000, 12000, 11, 12492, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mijan - Between 0-50% Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (5717, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mijan - On Death - Set Instance Data 11');

-- Zul'Lor (5716)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5716;
DELETE FROM smart_scripts WHERE entryorguid=5716 AND source_type=0;
INSERT INTO smart_scripts VALUES (5716, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 8000, 12000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zul''Lor - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (5716, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 8000, 14000, 11, 12530, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zul''Lor - In Combat - Cast Frailty');
INSERT INTO smart_scripts VALUES (5716, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zul''Lor - On Death - Set Instance Data 11');

-- Jammal'an the Prophet (5710)
DELETE FROM creature_text WHERE entry=5710;
INSERT INTO creature_text VALUES (5710, 0, 0, 'The shield be down! Rise up Atal''ai! Rise up!', 14, 0, 100, 0, 0, 5861, 3, 'Jammal''an the Prophet');
INSERT INTO creature_text VALUES (5710, 1, 0, 'The Soulflayer comes!', 14, 0, 100, 0, 0, 5862, 0, 'Jammal''an the Prophet Aggro');
INSERT INTO creature_text VALUES (5710, 2, 0, '%s laughs.', 16, 0, 100, 0, 0, 5863, 0, 'Jammal''an the Prophet Slay');
INSERT INTO creature_text VALUES (5710, 3, 0, 'Join us!', 14, 0, 100, 0, 0, 5864, 0, 'Jammal''an the Prophet Charm');
INSERT INTO creature_text VALUES (5710, 4, 0, 'Hakkar shall live again!', 14, 0, 100, 0, 0, 5865, 0, 'Jammal''an the Prophet 10% Health');
UPDATE creature_template SET unit_flags=unit_flags|0x100, AIName='SmartAI', ScriptName='' WHERE entry=5710;
DELETE FROM smart_scripts WHERE entryorguid=5710 AND source_type=0;
INSERT INTO smart_scripts VALUES (5710, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 30000, 30000, 11, 8376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - In Combat - Cast Earthgrab Totem');
INSERT INTO smart_scripts VALUES (5710, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 13000, 18000, 11, 12468, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (5710, 0, 2, 0, 14, 0, 100, 0, 2400, 40, 7000, 11000, 11, 12492, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (5710, 0, 3, 4, 0, 0, 100, 0, 12000, 12000, 40000, 40000, 11, 12479, 0, 0, 0, 0, 0, 5, 30, 1, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - In Combat - Cast Hex of Jammal''an');
INSERT INTO smart_scripts VALUES (5710, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - In Combat - Say Line 3');
INSERT INTO smart_scripts VALUES (5710, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (5710, 0, 6, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (5710, 0, 7, 0, 2, 0, 100, 1, 0, 10, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - Between Health 0-10% - Say Line 4');
INSERT INTO smart_scripts VALUES (5710, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (5710, 0, 9, 10, 6, 0, 100, 0, 0, 0, 0, 0, 28, 12479, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Death - Remove Aura');
INSERT INTO smart_scripts VALUES (5710, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 28, 12480, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Death - Remove Aura');
INSERT INTO smart_scripts VALUES (5710, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Death - Set Instance Data 1 to 3');
INSERT INTO smart_scripts VALUES (5710, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 13540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Respawn - Cast Green Channeling');
INSERT INTO smart_scripts VALUES (5710, 0, 13, 0, 21, 0, 100, 0, 0, 0, 0, 0, 11, 13540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - On Reached Home - Cast Green Channeling');
INSERT INTO smart_scripts VALUES (5710, 0, 14, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 0x100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jammal''an the Prophet - Out of Combat - Remove Unit Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5710;
INSERT INTO conditions VALUES(22, 15, 5710, 0, 0, 13, 1, 11, 6, 0, 0, 0, 0, '', 'Run action if GetData(11) == 6');

-- SPELL Hex of Jammal'an (12479)
-- SPELL Hex of Jammal'an (12480)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(12479, -12479, 12480, -12480);
REPLACE INTO spell_linked_spell VALUES(-12480, -12483, 0, 'Hex of Jammal''an - Remove Charm');
DELETE FROM spell_script_names WHERE spell_id IN(12479);
INSERT INTO spell_script_names VALUES(12479, 'spell_temple_of_atal_hakkar_hex_of_jammal_an');

-- Ogom the Wretched (5711)
UPDATE creature_template SET unit_flags=unit_flags|0x100, AIName='SmartAI', ScriptName='' WHERE entry=5711;
DELETE FROM smart_scripts WHERE entryorguid=5711 AND source_type=0;
INSERT INTO smart_scripts VALUES (5711, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ogom the Wretched - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (5711, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 14000, 11, 11639, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ogom the Wretched - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (5711, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 12000, 17000, 11, 12493, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ogom the Wretched - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (5711, 0, 3, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 0x100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ogom the Wretched - Out of Combat - Remove Unit Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5711;
INSERT INTO conditions VALUES(22, 4, 5711, 0, 0, 13, 1, 11, 6, 0, 0, 0, 0, '', 'Run action if GetData(11) == 6');

-- Dreamscythe (5721)
DELETE FROM creature_text WHERE entry=5721;
INSERT INTO creature_text VALUES (5721, 0, 0, 'You know not what you do! We must destroy you for your own good!', 14, 0, 100, 0, 0, 5866, 3, 'Dreamscythe');
INSERT INTO creature_text VALUES (5721, 1, 0, 'Turn back! Do not wake the dreamer!', 14, 0, 100, 0, 0, 0, 3, 'Dreamscythe Aggro');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5721;
DELETE FROM smart_scripts WHERE entryorguid=5721 AND source_type=0;
INSERT INTO smart_scripts VALUES (5721, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 18000, 30000, 11, 12882, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - In Combat - Cast Wing Flap');
INSERT INTO smart_scripts VALUES (5721, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (5721, 0, 2, 3, 60, 0, 100, 257, 0, 0, 3000, 3000, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - On Update - Set Ingame Phase Mask');
INSERT INTO smart_scripts VALUES (5721, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (5721, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (5721, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreamscythe - On Aggro - Call For Help');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5721;
INSERT INTO conditions VALUES(22, 3, 5721, 0, 0, 13, 1, 1, 3, 0, 0, 0, 0, '', 'Run action if GetData(1) == DONE');
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=5721);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=5721);
DELETE FROM creature WHERE id=5721;
INSERT INTO creature VALUES (239020, 5721, 109, 1, 2, 0, 0, -453.45, 137.17, -90.75, 5.72, 86400, 0, 0, 11075, 0, 2, 0, 0, 0);
INSERT INTO creature_addon VALUES (239020, 2390200, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=2390200;
INSERT INTO waypoint_data VALUES (2390200, 1, -437.354, 128.298, -90.7219, 0, 0, 1, 0, 100, 0),(2390200, 2, -429.804, 116.508, -90.7681, 0, 0, 1, 0, 100, 0),(2390200, 3, -424.142, 107.666, -90.731, 0, 0, 1, 0, 100, 0),(2390200, 4, -423.637, 94.866, -90.7276, 0, 0, 1, 0, 100, 0),(2390200, 5, -423.799, 84.4373, -90.7387, 0, 0, 1, 0, 100, 0),(2390200, 6, -429.268, 74.1051, -90.7365, 0, 0, 1, 0, 100, 0),(2390200, 7, -435.058, 63.9499, -90.7328, 0, 0, 1, 0, 100, 0),(2390200, 8, -455.824, 51.9717, -90.7366, 0, 0, 1, 0, 100, 0),(2390200, 9, -477.935, 52.576, -90.7831, 0, 0, 1, 0, 100, 0),(2390200, 10, -497.861, 62.4975, -90.6982, 0, 0, 1, 0, 100, 0),(2390200, 11, -510.496, 84.8415, -90.7229, 0, 0, 1, 0, 100, 0),(2390200, 12, -510.329, 105.84, -90.7365, 0, 0, 1, 0, 100, 0),(2390200, 13, -498.977, 126.104, -90.7514, 0, 0, 1, 0, 100, 0),(2390200, 14, -478.475, 139.351, -90.6741, 0, 0, 1, 0, 100, 0),(2390200, 15, -463.375, 138.582, -90.7328, 0, 0, 1, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=239020;
INSERT INTO creature_formations VALUES (239020, 239020, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (239020, 239021, 11, 270, 0, 0, 0);

-- Weaver (5720)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5720;
DELETE FROM smart_scripts WHERE entryorguid=5720 AND source_type=0;
INSERT INTO smart_scripts VALUES (5720, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 18000, 30000, 11, 12882, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Weaver - In Combat - Cast Wing Flap');
INSERT INTO smart_scripts VALUES (5720, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Weaver - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (5720, 0, 2, 0, 60, 0, 100, 257, 0, 0, 3000, 3000, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weaver - On Update - Set Ingame Phase Mask');
INSERT INTO smart_scripts VALUES (5720, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weaver - On Aggro - Call For Help');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5720;
INSERT INTO conditions VALUES(22, 3, 5720, 0, 0, 13, 1, 1, 3, 0, 0, 0, 0, '', 'Run action if GetData(1) == DONE');
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=5720);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=5720);
DELETE FROM creature WHERE id=5720;
INSERT INTO creature VALUES (239021, 5720, 109, 1, 2, 0, 0, -458.84, 127.70, -91.57, 5.77, 86400, 0, 0, 11075, 0, 2, 0, 0, 0);

-- Hazzas (5722)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5722;
DELETE FROM smart_scripts WHERE entryorguid=5722 AND source_type=0;
INSERT INTO smart_scripts VALUES (5722, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 18000, 30000, 11, 12882, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hazzas - In Combat - Cast Wing Flap');
INSERT INTO smart_scripts VALUES (5722, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hazzas - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (5722, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hazzas - On Aggro - Call For Help');
UPDATE creature SET MovementType=2, spawndist=0 WHERE id=5722;
REPLACE INTO creature_addon VALUES (33658, 336580, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=336580;
INSERT INTO waypoint_data VALUES (336580, 1, -654.486, 80.8887, -90.8321, 0, 0, 1, 0, 100, 0),(336580, 2, -654.402, 70.389, -90.8321, 0, 0, 1, 0, 100, 0),(336580, 3, -654.214, 47.0098, -90.835, 0, 0, 1, 0, 100, 0),(336580, 4, -654.083, 30.7003, -91.0909, 0, 0, 1, 0, 100, 0),(336580, 5, -653.896, 7.39103, -90.8357, 0, 0, 1, 0, 100, 0),(336580, 6, -653.806, 19.0807, -90.8357, 0, 0, 1, 0, 100, 0),(336580, 7, -653.754, 33.0806, -90.8355, 0, 0, 1, 0, 100, 0),(336580, 8, -653.67, 55.2004, -90.8347, 0, 0, 1, 0, 100, 0),(336580, 9, -653.596, 75.0103, -90.8339, 0, 0, 1, 0, 100, 0),(336580, 10, -653.517, 96.0101, -90.8329, 0, 0, 1, 0, 100, 0),(336580, 11, -653.447, 114.7, -90.8315, 0, 0, 1, 0, 100, 0),(336580, 12, -653.403, 126.32, -90.8307, 0, 0, 1, 0, 100, 0),(336580, 13, -653.373, 134.44, -90.8301, 0, 0, 1, 0, 100, 0),(336580, 14, -653.315, 120.44, -90.8301, 0, 0, 1, 0, 100, 0),(336580, 15, -653.258, 106.44, -90.8301, 0, 0, 1, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=33658;
INSERT INTO creature_formations VALUES (33658, 33658, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (33658, 33657, 11, 270, 0, 0, 0);

-- Morphaz (5719)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5719;
DELETE FROM smart_scripts WHERE entryorguid=5719 AND source_type=0;
INSERT INTO smart_scripts VALUES (5719, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 18000, 30000, 11, 12882, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Morphaz - In Combat - Cast Wing Flap');
INSERT INTO smart_scripts VALUES (5719, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Morphaz - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (5719, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Morphaz - On Aggro - Call For Help');

-- Shade of Eranikus (5709)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=5709);
REPLACE INTO creature_template_addon VALUES (5709, 0, 0, 3, 4097, 0, '');
DELETE FROM creature_text WHERE entry=5709;
INSERT INTO creature_text VALUES (5709, 0, 0, 'This evil cannot be allowed to enter this world! Come my children!', 14, 0, 100, 0, 0, 0, 3, 'Shade of Eranikus');
UPDATE creature_template SET unit_flags=unit_flags|768, AIName='SmartAI', ScriptName='' WHERE entry=5709;
DELETE FROM smart_scripts WHERE entryorguid=5709 AND source_type=0;
INSERT INTO smart_scripts VALUES (5709, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Reset - Cast Shade of Eranikus Passive Visual');
INSERT INTO smart_scripts VALUES (5709, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (5709, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (5709, 0, 3, 0, 0, 0, 100, 0, 14000, 20000, 20000, 30000, 11, 11876, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (5709, 0, 4, 0, 0, 0, 100, 0, 7000, 14000, 20000, 26000, 11, 12890, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast Deep Slumber');
INSERT INTO smart_scripts VALUES (5709, 0, 5, 0, 0, 0, 100, 0, 1000, 11000, 8000, 18000, 11, 12884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (5709, 0, 6, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - Out of Combat - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (5709, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 34, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - On Aggro - Set Instance Data 12');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5709;
INSERT INTO conditions VALUES(22, 7, 5709, 0, 0, 13, 1, 1, 3, 0, 0, 0, 0, '', 'Run action if GetData(1) == DONE');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Atal'ai Witch Doctor (5259)
REPLACE INTO creature_addon VALUES (34524, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (33644, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (39784, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (39774, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (39773, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (39761, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (39755, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (34656, 0, 0, 8, 4097, 0, '');
REPLACE INTO creature_addon VALUES (34655, 0, 0, 8, 4097, 0, '');
UPDATE creature SET phaseMask=3, position_x=-402.33, position_y=145.03, position_z=-131.85, orientation=3.08 WHERE id=5259 AND guid=34524;
UPDATE creature SET phaseMask=3, position_x=-370.639, position_y=90.6568, position_z=-131.849, orientation=2.3945 WHERE id=5259 AND guid=33644;
UPDATE creature SET phaseMask=3, position_x=-551.718, position_y=58.2144, position_z=-53.9463, orientation=0.246433 WHERE id=5259 AND guid=34655;
UPDATE creature SET phaseMask=3, position_x=-560.564, position_y=61.5475, position_z=-53.9463, orientation=3.36054 WHERE id=5259 AND guid=34656;
UPDATE creature SET phaseMask=3, position_x=-394.878, position_y=151.322, position_z=-53.9453, orientation=3.92995 WHERE id=5259 AND guid=39755;
UPDATE creature SET phaseMask=3, position_x=-475.056, position_y=187.415, position_z=-53.9463, orientation=4.96275 WHERE id=5259 AND guid=39761;
UPDATE creature SET phaseMask=3, position_x=-556.768, position_y=142.324, position_z=-53.9462, orientation=2.70865 WHERE id=5259 AND guid=39773;
UPDATE creature SET phaseMask=3, position_x=-560.12, position_y=131.074, position_z=-53.9463, orientation=2.905 WHERE id=5259 AND guid=39774;
UPDATE creature SET phaseMask=3, position_x=-480.808, position_y=4.69983, position_z=-53.9463, orientation=1.29494 WHERE id=5259 AND guid=39784;

-- GO Altar of Hakkar (148836)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(148836);
DELETE FROM smart_scripts WHERE entryorguid IN(148836) AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid IN(148836*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (148836, 1, 0, 0, 62, 0, 100, 0, 1288, 0, 0, 0, 80, 148836*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Run Script');
INSERT INTO smart_scripts VALUES (148836*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 105, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - Script9 - Add Gameobject Flag');
INSERT INTO smart_scripts VALUES (148836*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -515.553, 95.2582, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -419.849, 94.4837, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -491.400, 135.970, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -491.491, 53.4818, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -443.855, 136.101, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 50, 148883, 4, 0, 0, 0, 0, 8, 0, 0, 0, -443.417, 53.8312, -148.74, 0, 'Atal''ai Statue - Script9 - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148836*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 106, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - Script9 - Remove Gameobject Flag');
DELETE FROM gossip_menu_option WHERE menu_id=1288;
INSERT INTO gossip_menu_option VALUES (1288, 0, 0, 'How could the altar and the statues be related?', 1, 1, 1302, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1288;
INSERT INTO conditions VALUES(15, 1288, 0, 0, 0, 8, 0, 3446, 0, 0, 0, 0, 0, '', 'Show gossip if quest is rewarded');

-- GO Atal'ai Statue (148830, 148831, 148832, 148833, 148834, 148835)
UPDATE gameobject_template SET faction=0, data3=8000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(148830, 148831, 148832, 148833, 148834, 148835);
DELETE FROM smart_scripts WHERE entryorguid IN(148830, 148831, 148832, 148833, 148834, 148835) AND source_type=1;
INSERT INTO smart_scripts VALUES (148830, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148830, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148830, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148830, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 18949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Atal''ai Poison');
INSERT INTO smart_scripts VALUES (148831, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148831, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148831, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148831, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 18948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Dark Energy');
INSERT INTO smart_scripts VALUES (148832, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148832, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148832, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148832, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 12354, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Flame of Hakkar');
INSERT INTO smart_scripts VALUES (148833, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148833, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148833, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148833, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 18949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Atal''ai Poison');
INSERT INTO smart_scripts VALUES (148834, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148834, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148834, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148834, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 18948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Dark Energy');
INSERT INTO smart_scripts VALUES (148835, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Instance Data 0');
INSERT INTO smart_scripts VALUES (148835, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 148937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (148835, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (148835, 1, 3, 0, 64, 0, 100, 0, 1, 0, 0, 0, 11, 12354, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Atal''ai Statue - On Gossip Hello - Cast Flame of Hakkar');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(148830, 148831, 148832, 148833, 148834, 148835);
INSERT INTO conditions VALUES(22, 1, 148830, 1, 0, 13, 1, 10, 0, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 1, 148831, 1, 0, 13, 1, 10, 1, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 1, 148832, 1, 0, 13, 1, 10, 2, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 1, 148833, 1, 0, 13, 1, 10, 3, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 1, 148834, 1, 0, 13, 1, 10, 4, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 1, 148835, 1, 0, 13, 1, 10, 5, 0, 0, 0, 0, '', 'Run action if instance data is correct');
INSERT INTO conditions VALUES(22, 4, 148830, 1, 0, 13, 1, 10, 0, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');
INSERT INTO conditions VALUES(22, 4, 148831, 1, 0, 13, 1, 10, 1, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');
INSERT INTO conditions VALUES(22, 4, 148832, 1, 0, 13, 1, 10, 2, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');
INSERT INTO conditions VALUES(22, 4, 148833, 1, 0, 13, 1, 10, 3, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');
INSERT INTO conditions VALUES(22, 4, 148834, 1, 0, 13, 1, 10, 4, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');
INSERT INTO conditions VALUES(22, 4, 148835, 1, 0, 13, 1, 10, 5, 0, 1, 0, 0, '', 'Run action if instance data is NOT correct');

-- GO forcefield (149431)
DELETE FROM gameobject WHERE id=149431;
INSERT INTO gameobject VALUES (NULL, 149431, 109, 1, 1, -518.1, -85.545, -91.20, 0.0, 0, 0, 0, 0, 86400, 100, 1, 0);

-- GO DOOR1 (149432)
UPDATE gameobject_template SET flags=48, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=149432;
DELETE FROM smart_scripts WHERE entryorguid=149432 AND source_type=1;
INSERT INTO smart_scripts VALUES (149432, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'DOOR1 - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (149432, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'DOOR1 - On Update - Set Gameobject State');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=149432;
INSERT INTO conditions VALUES(22, 1, 149432, 1, 0, 13, 1, 2, 1, 0, 0, 0, 0, '', 'Run action if GetData(2) == IN_PROGRESS');
INSERT INTO conditions VALUES(22, 2, 149432, 1, 0, 13, 1, 2, 1, 0, 1, 0, 0, '', 'Run action if GetData(2) != IN_PROGRESS');
DELETE FROM gameobject WHERE id=149432;
INSERT INTO gameobject VALUES (NULL, 149432, 109, 1, 1, -518.23, 276.04, -91.20, 0.0, 0, 0, 0, 0, 86400, 100, 1, 0);

-- GO DOOR2 (149433)
UPDATE gameobject_template SET flags=48, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=149433;
DELETE FROM smart_scripts WHERE entryorguid=149433 AND source_type=1;
INSERT INTO smart_scripts VALUES (149433, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'DOOR2 - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (149433, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'DOOR2 - On Update - Set Gameobject State');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=149433;
INSERT INTO conditions VALUES(22, 1, 149433, 1, 0, 13, 1, 2, 1, 0, 0, 0, 0, '', 'Run action if GetData(2) == IN_PROGRESS');
INSERT INTO conditions VALUES(22, 2, 149433, 1, 0, 13, 1, 2, 1, 0, 1, 0, 0, '', 'Run action if GetData(2) != IN_PROGRESS');
DELETE FROM gameobject WHERE id=149433;
INSERT INTO gameobject VALUES (NULL, 149433, 109, 1, 1, -416.012, 275.855, -91.20, 0.0, 0, 0, 0, 0, 86400, 100, 1, 0);

-- Avatar of Hakkar Event
-- SPELL Awaken the Soulflayer (12346)
DELETE FROM spell_script_names WHERE spell_id IN(12346);
INSERT INTO spell_script_names VALUES(12346, 'spell_temple_of_atal_hakkar_awaken_the_soulflayer');

-- Shade of Hakkar (8440)
DELETE FROM creature_text WHERE entry=8440;
INSERT INTO creature_text VALUES (8440, 0, 0, 'I DRAW CLOSER TO THE WORLD!', 14, 0, 100, 0, 0, 5867, 3, 'Shade of Hakkar');
INSERT INTO creature_text VALUES (8440, 1, 0, 'I TASTE THE BLOOD OF LIFE.', 14, 0, 100, 0, 0, 5868, 3, 'Shade of Hakkar');
INSERT INTO creature_text VALUES (8440, 2, 0, 'I AM HERE!', 14, 0, 100, 0, 0, 5869, 3, 'Shade of Hakkar');
INSERT INTO creature_text VALUES (8440, 3, 0, 'HAKKAR LIVES!', 14, 0, 100, 0, 0, 5870, 3, 'Shade of Hakkar');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8440;
DELETE FROM smart_scripts WHERE entryorguid=8440 AND source_type=0;
INSERT INTO smart_scripts VALUES (8440, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -478.976, 262.059, -90.4826, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 1, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -483.196, 272.564, -90.6383, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 2, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -480.776, 282.721, -90.5978, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 3, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -469.55, 290.58, -90.6008, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -458.259, 287.897, -90.5605, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 5, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -450.242, 276.487, -90.5794, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 6, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -453.594, 264.413, -90.5004, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 7, 0, 25, 0, 100, 257, 0, 0, 0, 0, 50, 148998, 0, 0, 0, 0, 0, 8, 0, 0, 0, -464.415, 257.448, -90.5735, 0, 'Shade of Hakkar - On Reset - Summon Gameobject');
INSERT INTO smart_scripts VALUES (8440, 0, 8, 0, 25, 0, 100, 257, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (8440, 0, 9, 10, 77, 0, 100, 0, 2, 25, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Despawn');
INSERT INTO smart_scripts VALUES (8440, 0, 10, 14, 61, 0, 100, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Set Instance Data 2 to NOT_STARTED');
INSERT INTO smart_scripts VALUES (8440, 0, 11, 12, 77, 0, 100, 0, 1, 4, 0, 0, 11, 12639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Cast Summon Hakkar');
INSERT INTO smart_scripts VALUES (8440, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 12, 8443, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Summon Creature');
INSERT INTO smart_scripts VALUES (8440, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Cast Summon Hakkar');
INSERT INTO smart_scripts VALUES (8440, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 148998, 50, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Despawn Gameobjects');
INSERT INTO smart_scripts VALUES (8440, 0, 15, 0, 77, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Say Line 0');
INSERT INTO smart_scripts VALUES (8440, 0, 16, 0, 77, 0, 100, 0, 1, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Say Line 1');
INSERT INTO smart_scripts VALUES (8440, 0, 17, 0, 77, 0, 100, 0, 1, 3, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Say Line 2');
INSERT INTO smart_scripts VALUES (8440, 0, 18, 0, 77, 0, 100, 0, 1, 4, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shade of Hakkar - On Counter Set - Say Line 3');
INSERT INTO smart_scripts VALUES (8440, 0, 19, 0, 60, 0, 100, 0, 15000, 15000, 110000, 110000, 12, 8438, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -434.48, 288.33, -90.82, 3.37, 'Shade of Hakkar - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (8440, 0, 20, 0, 60, 0, 100, 0, 70000, 70000, 110000, 110000, 12, 8438, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -507.36, 265.35, -90.82, 6.13, 'Shade of Hakkar - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (8440, 0, 21, 0, 60, 0, 100, 0, 10000, 10000, 70000, 70000, 12, 8497, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -510.14, 287.44, -90.82, 5.94, 'Shade of Hakkar - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (8440, 0, 22, 0, 60, 0, 100, 0, 45000, 45000, 70000, 70000, 12, 8497, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -421.86, 267.98, -90.82, 3.03, 'Shade of Hakkar - On Update - Summon Creature');

-- Avatar of Hakkar (8443)
DELETE FROM creature_text WHERE entry=8443;
INSERT INTO creature_text VALUES (8443, 0, 0, 'DIE MORTALS!', 14, 0, 100, 0, 0, 5871, 3, 'Avatar of Hakkar');
UPDATE creature_template SET unit_flags=768+33554432, AIName='SmartAI', ScriptName='' WHERE entry=8443;
DELETE FROM smart_scripts WHERE entryorguid=8443 AND source_type=0;
INSERT INTO smart_scripts VALUES (8443, 0, 0, 1, 1, 0, 100, 1, 10000, 10000, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - Out of Combat - Set Instance Data 2 to NOT_STARTED');
INSERT INTO smart_scripts VALUES (8443, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (8443, 0, 2, 3, 1, 0, 100, 257, 3000, 3000, 0, 0, 19, 768+33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - Out of Combat - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (8443, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - Out of Combat - Cast Avatar of Hakkar is summoned');
INSERT INTO smart_scripts VALUES (8443, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (8443, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - On Death - Set Instance Data 2 to DONE');
INSERT INTO smart_scripts VALUES (8443, 0, 6, 0, 25, 0, 100, 257, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - On Reset - Set Active');
INSERT INTO smart_scripts VALUES (8443, 0, 7, 0, 0, 0, 100, 0, 4000, 7000, 11000, 20000, 11, 6607, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - In Combat - Cast Lash');
INSERT INTO smart_scripts VALUES (8443, 0, 8, 0, 0, 0, 100, 0, 6000, 14000, 14000, 22000, 11, 12889, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - In Combat - Cast Curse of Tongues');
INSERT INTO smart_scripts VALUES (8443, 0, 9, 0, 0, 0, 100, 0, 14000, 21000, 25000, 40000, 11, 12888, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - In Combat - Cast Cause Insanity');
INSERT INTO smart_scripts VALUES (8443, 0, 10, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of Hakkar - On Aggro - Say Line 0');

-- Hakkari Minion (8437)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=8437);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8437);
DELETE FROM creature WHERE id=8437;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8437;
DELETE FROM smart_scripts WHERE entryorguid=8437 AND source_type=0;
INSERT INTO smart_scripts VALUES (8437, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 89, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Minion - On Reset - Move Random');

-- Hakkari Bloodkeeper (8438)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=8438);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8438);
DELETE FROM creature WHERE id=8438;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8438;
DELETE FROM smart_scripts WHERE entryorguid=8438 AND source_type=0;
INSERT INTO smart_scripts VALUES (8438, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 7741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Bloodkeeper - On Respawn - Cast Summoned Demon');
INSERT INTO smart_scripts VALUES (8438, 0, 1, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Hakkari Bloodkeeper - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (8438, 0, 2, 0, 0, 0, 100, 0, 0, 2000, 3000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Bloodkeeper - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (8438, 0, 3, 0, 0, 0, 100, 0, 13000, 17000, 11000, 15000, 11, 11671, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Hakkari Bloodkeeper - In Combat - Cast Corruption');

-- Nightmare Suppressor (8497)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=8497);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8497);
DELETE FROM creature WHERE id=8497;
DELETE FROM creature_text WHERE entry=8497;
INSERT INTO creature_text VALUES (8497, 0, 0, 'No!  We cannot allow you to summon Hakkar!', 14, 0, 100, 0, 0, 0, 0, 'Nightmare Suppressor');
INSERT INTO creature_text VALUES (8497, 0, 1, 'You must not summon our god!', 14, 0, 100, 0, 0, 0, 0, 'Nightmare Suppressor');
INSERT INTO creature_text VALUES (8497, 0, 2, 'No! You must not do this!', 14, 0, 100, 0, 0, 0, 0, 'Nightmare Suppressor');
INSERT INTO creature_text VALUES (8497, 0, 3, 'Stop! Infidels!', 14, 0, 100, 0, 0, 0, 0, 'Nightmare Suppressor');
INSERT INTO creature_text VALUES (8497, 0, 4, 'Wha... what''s happening?', 14, 0, 100, 0, 0, 0, 0, 'Nightmare Suppressor');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8497;
DELETE FROM smart_scripts WHERE entryorguid=8497 AND source_type=0;
INSERT INTO smart_scripts VALUES (8497, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 7741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Suppressor - On Respawn - Cast Summoned Demon');
INSERT INTO smart_scripts VALUES (8497, 0, 1, 0, 60, 0, 100, 257, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Suppressor - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (8497, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -451.12, 275.37, -90.55, 0, 'Nightmare Suppressor - Out of Combat - Move To Pos');
INSERT INTO smart_scripts VALUES (8497, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -482.84, 273.66, -90.63, 0, 'Nightmare Suppressor - Out of Combat - Move To Pos');
INSERT INTO smart_scripts VALUES (8497, 0, 4, 0, 1, 0, 100, 1, 4000, 4000, 0, 0, 11, 12623, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Suppressor - Out of Combat - Cast Suppression');
INSERT INTO smart_scripts VALUES (8497, 0, 5, 0, 1, 0, 100, 0, 4000, 4000, 1000, 1000, 63, 2, 1, 0, 0, 0, 0, 19, 8440, 40, 0, 0, 0, 0, 0, 'Nightmare Suppressor - Out of Combat - Set Counter');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=8497;
INSERT INTO conditions VALUES(22, 3, 8497, 0, 0, 30, 1, 149433, 50, 0, 0, 0, 0, '', 'Run action gameobject nearby');
INSERT INTO conditions VALUES(22, 4, 8497, 0, 0, 30, 1, 149432, 50, 0, 0, 0, 0, '', 'Run action gameobject nearby');

-- SPELL Suppression (12623)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=12623;
INSERT INTO conditions VALUES (13, 1, 12623, 0, 0, 31, 0, 3, 8440, 0, 0, 0, 0, '', 'Target Shade of Hakkar');

-- GO Evil God Summoning Circle (148998)
UPDATE gameobject_template SET flags=48, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=148998;
DELETE FROM smart_scripts WHERE entryorguid=148998 AND source_type=1;
INSERT INTO smart_scripts VALUES (148998, 1, 0, 0, 60, 0, 100, 0, 3000, 10000, 25000, 25000, 12, 8437, 4, 25000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Evil God Summoning Circle - On Update - Summon Creature');

-- GO Eternal Flame (148418, 148419, 148420, 148421)
UPDATE gameobject_template SET data3=86400000, flags=32, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(148418, 148419, 148420, 148421);
DELETE FROM smart_scripts WHERE entryorguid IN(148418, 148419, 148420, 148421) AND source_type=1;
INSERT INTO smart_scripts VALUES (148418, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 32, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Reset Gameobject');
INSERT INTO smart_scripts VALUES (148418, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (148418, 1, 2, 0, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 8440, 70, 0, 0, 0, 0, 0, 'Eternal Flame - On Gossip Hello - Set Counter');
INSERT INTO smart_scripts VALUES (148419, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 32, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Reset Gameobject');
INSERT INTO smart_scripts VALUES (148419, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (148419, 1, 2, 0, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 8440, 70, 0, 0, 0, 0, 0, 'Eternal Flame - On Gossip Hello - Set Counter');
INSERT INTO smart_scripts VALUES (148420, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 32, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Reset Gameobject');
INSERT INTO smart_scripts VALUES (148420, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (148420, 1, 2, 0, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 8440, 70, 0, 0, 0, 0, 0, 'Eternal Flame - On Gossip Hello - Set Counter');
INSERT INTO smart_scripts VALUES (148421, 1, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 32, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Reset Gameobject');
INSERT INTO smart_scripts VALUES (148421, 1, 1, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eternal Flame - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (148421, 1, 2, 0, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 8440, 70, 0, 0, 0, 0, 0, 'Eternal Flame - On Gossip Hello - Set Counter');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(148418, 148419, 148420, 148421);
INSERT INTO conditions VALUES(22, 1, 148418, 1, 0, 13, 1, 2, 0, 0, 0, 0, 0, '', 'Run action if GetData(2) == NOT_STARTED');
INSERT INTO conditions VALUES(22, 2, 148418, 1, 0, 13, 1, 2, 3, 0, 0, 0, 0, '', 'Run action if GetData(2) == DONE');
INSERT INTO conditions VALUES(22, 1, 148419, 1, 0, 13, 1, 2, 0, 0, 0, 0, 0, '', 'Run action if GetData(2) == NOT_STARTED');
INSERT INTO conditions VALUES(22, 2, 148419, 1, 0, 13, 1, 2, 3, 0, 0, 0, 0, '', 'Run action if GetData(2) == DONE');
INSERT INTO conditions VALUES(22, 1, 148420, 1, 0, 13, 1, 2, 0, 0, 0, 0, 0, '', 'Run action if GetData(2) == NOT_STARTED');
INSERT INTO conditions VALUES(22, 2, 148420, 1, 0, 13, 1, 2, 3, 0, 0, 0, 0, '', 'Run action if GetData(2) == DONE');
INSERT INTO conditions VALUES(22, 1, 148421, 1, 0, 13, 1, 2, 0, 0, 0, 0, 0, '', 'Run action if GetData(2) == NOT_STARTED');
INSERT INTO conditions VALUES(22, 2, 148421, 1, 0, 13, 1, 2, 3, 0, 0, 0, 0, '', 'Run action if GetData(2) == DONE');

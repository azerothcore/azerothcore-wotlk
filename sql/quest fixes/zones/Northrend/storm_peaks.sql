
-- -------------------------------------------
-- STORM PEAKS
-- -------------------------------------------

-- Slag Covered Metal (41556)
UPDATE conditions SET ConditionTypeOrReference=14, NegativeCondition=1 WHERE SourceEntry=41556 AND SourceTypeOrReferenceId=1;

-- The Drakkensryd (12886)
REPLACE INTO creature_template_addon VALUES (29679, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=29796;
UPDATE creature_template SET speed_run=5, InhabitType=4, AIName='SmartAI' WHERE entry=29679;
DELETE FROM smart_scripts WHERE entryorguid IN(29796, 29679) AND source_type=0;
INSERT INTO smart_scripts VALUES (29796, 0, 0, 0, 19, 0, 100, 0, 12886, 0, 0, 0, 11, 55253, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Cast Spell');
INSERT INTO smart_scripts VALUES (29679, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 53, 1, 29679, 0, 0, 1000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Start WP');
INSERT INTO smart_scripts VALUES (29679, 0, 1, 0, 60, 0, 100, 1, 500, 500, 0, 0, 60, 1, 500, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Fly');
DELETE FROM waypoints WHERE entry=29679;
INSERT INTO waypoints VALUES (29679, 1, 7071.2, -1772.26, 827.542, 'Hyldsmeet Proto-Drake'),(29679, 2, 7042.99, -1757.14, 842.747, 'Hyldsmeet Proto-Drake'),(29679, 3, 7018.42, -1727.55, 873.987, 'Hyldsmeet Proto-Drake'),(29679, 4, 7004.25, -1677.93, 923.391, 'Hyldsmeet Proto-Drake'),(29679, 5, 7042.87, -1581.54, 943.848, 'Hyldsmeet Proto-Drake'),(29679, 6, 7089.01, -1513.21, 999.059, 'Hyldsmeet Proto-Drake'),(29679, 7, 7187.18, -1359.52, 1125.41, 'Hyldsmeet Proto-Drake'),(29679, 8, 7273.46, -1226.56, 1235.73, 'Hyldsmeet Proto-Drake'),(29679, 9, 7366.43, -1041.68, 1394.12, 'Hyldsmeet Proto-Drake'),(29679, 10, 7503.78, -855.742, 1558.88, 'Hyldsmeet Proto-Drake'),(29679, 11, 7668.24, -639.42, 1677.99, 'Hyldsmeet Proto-Drake'),(29679, 12, 7677.31, -568.353, 1717.85, 'Hyldsmeet Proto-Drake'),(29679, 13, 7618.18, -499.276, 1795.46, 'Hyldsmeet Proto-Drake'),
(29679, 14, 7566.79, -450.701, 1859.32, 'Hyldsmeet Proto-Drake'),(29679, 15, 7521.65, -413.662, 1919.56, 'Hyldsmeet Proto-Drake'),(29679, 16, 7430.38, -404.684, 1935.66, 'Hyldsmeet Proto-Drake'),(29679, 17, 7414.28, -471.557, 1935.11, 'Hyldsmeet Proto-Drake'),(29679, 18, 7412.3, -532.338, 1912.76, 'Hyldsmeet Proto-Drake'),(29679, 19, 7426.15, -556.076, 1903.53, 'Hyldsmeet Proto-Drake');
UPDATE creature_template SET InhabitType=4 WHERE entry=29754;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29694;
UPDATE creature_addon SET bytes1=50331648 WHERE guid IN(select guid FROM creature WHERE id=29625);
DELETE FROM smart_scripts WHERE entryorguid=29694 AND source_type=0;
INSERT INTO smart_scripts VALUES (29694, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 5000, 9000, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (29694, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 29800, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Kill Credit');

-- Into the Pit (12997)
-- Back to the Pit (13424)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=30175);
DELETE FROM creature WHERE id=30175;
REPLACE INTO vehicle_template_accessory VALUES(30174, 30175, 0, 1, 'Hyldsmeet Bear Rider', 8, 0);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=30174);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=30174);
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id=30174);
DELETE FROM creature WHERE id=30174;
INSERT INTO creature VALUES (117195, 30174, 571, 1, 1, 26388, 0, 6978.9, -1673.39, 809.881, 5.79553, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117197, 30174, 571, 1, 1, 26388, 0, 6945.16, -1682.83, 810.24, 2.7071, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117198, 30174, 571, 1, 1, 26388, 0, 6941.39, -1681.08, 810.232, 5.84969, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117200, 30174, 571, 1, 1, 26388, 0, 6960.2, -1634.28, 810.406, 4.99098, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117201, 30174, 571, 1, 1, 26388, 0, 6972.75, -1639.46, 810.059, 2.07694, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117202, 30174, 571, 1, 1, 26388, 0, 6922.5, -1638.74, 810.297, 5.28835, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117205, 30174, 571, 1, 1, 26388, 0, 6939.21, -1638.76, 810.814, 4.2586, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (117206, 30174, 571, 1, 1, 26388, 0, 6926.37, -1656.91, 810.348, 0.314159, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
UPDATE creature_template SET faction=2128, AIName='SmartAI', ScriptName='' WHERE entry=30174;
DELETE FROM smart_scripts WHERE entryorguid IN(30174, -117197, -117205) AND source_type=0;
INSERT INTO smart_scripts VALUES (30174, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 12500, 11, 54460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (30174, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 15000, 22500, 11, 15971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Demoralizing Roar');
INSERT INTO smart_scripts VALUES (30174, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 19500, 11, 54458, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Smash');
INSERT INTO smart_scripts VALUES (30174, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-117197, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 12500, 11, 54460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (-117197, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 15000, 22500, 11, 15971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Demoralizing Roar');
INSERT INTO smart_scripts VALUES (-117197, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 19500, 11, 54458, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Smash');
INSERT INTO smart_scripts VALUES (-117197, 0, 3, 4, 1, 0, 100, 0, 1000, 1000, 7000, 7000, 18, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Out of Combat - Set Unit Flag');
INSERT INTO smart_scripts VALUES (-117197, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 117198, 30174, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Out of Combat - Cast Taunt');
INSERT INTO smart_scripts VALUES (-117197, 0, 5, 0, 60, 0, 100, 0, 2000, 2000, 2000, 2000, 19, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - On Update - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (-117197, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-117205, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 12500, 11, 54460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (-117205, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 15000, 22500, 11, 15971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Demoralizing Roar');
INSERT INTO smart_scripts VALUES (-117205, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 19500, 11, 54458, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - In Combat - Cast Smash');
INSERT INTO smart_scripts VALUES (-117205, 0, 3, 4, 1, 0, 100, 0, 1000, 1000, 7000, 7000, 18, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Out of Combat - Set Unit Flag');
INSERT INTO smart_scripts VALUES (-117205, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 28140, 2, 0, 0, 0, 0, 10, 117202, 30174, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Out of Combat - Cast Taunt');
INSERT INTO smart_scripts VALUES (-117205, 0, 5, 0, 60, 0, 100, 0, 2000, 2000, 2000, 2000, 19, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - On Update - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (-117205, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - On Reset - Set React Defensive');

-- Forging the Keystone (13285)
REPLACE INTO creature_text VALUES(31810, 0, 0, "Right. Let's see if we can finish this keystone.", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31810, 1, 0, "The keystone is completed! We've done it!", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31810, 2, 0, "Who knows what secrets await within Ulduar's archives? I'm off to discover them. Thank you again for your help. Without it, I'd still be searching for that key.", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31814, 0, 0, "Welcome, Brann Bronzebeard. I am all that remains of this temple's guardian. ", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31814, 1, 0, "You have proven yourself as an explorer and seeker of knowledge. ", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31814, 2, 0, "You have been a steadfast ally of the Earthen. ", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31814, 3, 0, "You and your companions have proven yourselves in combat and in the pursuit of keystone. ", 12, 0, 100, 0, 0, 0, 0, "");
REPLACE INTO creature_text VALUES(31814, 4, 0, "Your motives are pure. The keystone's parts shall be reunited. Go to Ulduar and learn the answers to your questions, Brann Bronzebeard. ", 12, 0, 100, 0, 0, 0, 0, "");

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(10124);
INSERT INTO conditions VALUES(15, 10124, 0, 0, 0, 9, 0, 13285, 0, 0, 0, 0, 0, '', 'Requires Forging the Keystone quest');
DELETE FROM creature WHERE id=31810;
INSERT INTO creature VALUES (NULL, 31810, 571, 1, 1, 0, 1, 7860.62, -1396.72, 1534.06, 5.98481, 300, 0, 0, 252, 0, 0, 0, 0, 0);
UPDATE creature_template SET npcflag = npcflag | 1, gossip_menu_id=10124, AIName="SmartAI", ScriptName='' WHERE entry=31810;
UPDATE creature_template SET modelid1=26241, modelid2=0 WHERE entry=31814;
DELETE FROM smart_scripts WHERE entryorguid=31810 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=31810*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (31810, 0, 0, 1, 62, 0, 100, 0, 10124, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text 0");
INSERT INTO smart_scripts VALUES (31810, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (31810, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "remove gossip flag");
INSERT INTO smart_scripts VALUES (31810, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 31810*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Run script on gossip select");
INSERT INTO smart_scripts VALUES (31810*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31814, 3, 35000, 0, 0, 0, 8, 0, 0, 0, 7864.7, -1396.3, 1537.2, 2.82, "summon npc");
INSERT INTO smart_scripts VALUES (31810*100, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 31814, 30, 0, 0, 0, 0, 0, "say text 0");
INSERT INTO smart_scripts VALUES (31810*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193590, 37, 0, 0, 0, 0, 8, 0, 0, 0, 7861.16, -1383.97, 1538.4, 5.36, "summon go");
INSERT INTO smart_scripts VALUES (31810*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 31814, 30, 0, 0, 0, 0, 0, "say text 1");
INSERT INTO smart_scripts VALUES (31810*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193591, 33, 0, 0, 0, 0, 8, 0, 0, 0, 7874.9, -1387.9, 1538.4, 3.8, "summon go");
INSERT INTO smart_scripts VALUES (31810*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 11, 31814, 30, 0, 0, 0, 0, 0, "say text 2");
INSERT INTO smart_scripts VALUES (31810*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193592, 29, 0, 0, 0, 0, 8, 0, 0, 0, 7877.06, -1401.3, 1538.4, 3.13, "summon go");
INSERT INTO smart_scripts VALUES (31810*100, 9, 7, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 11, 31814, 30, 0, 0, 0, 0, 0, "say text 3");
INSERT INTO smart_scripts VALUES (31810*100, 9, 8, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193593, 25, 0, 0, 0, 0, 8, 0, 0, 0, 7868.0, -1410.6, 1538.6, 2.1, "summon go");
INSERT INTO smart_scripts VALUES (31810*100, 9, 9, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 11, 31814, 30, 0, 0, 0, 0, 0, "say text 4");
INSERT INTO smart_scripts VALUES (31810*100, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193594, 21, 0, 0, 0, 0, 8, 0, 0, 0, 7856.75, -1406.9, 1538.2, 0.55, "summon go");
INSERT INTO smart_scripts VALUES (31810*100, 9, 11, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text 1");
INSERT INTO smart_scripts VALUES (31810*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 31810, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, "kill monster credit");
INSERT INTO smart_scripts VALUES (31810*100, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text 2");
INSERT INTO smart_scripts VALUES (31810*100, 9, 14, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "add gossip flag");

-- Armor of Darkness (12979)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceGroup=29380 AND SourceEntry=42203;
UPDATE creature_loot_template SET ChanceOrQuestChance=50 WHERE item=42203;

-- Sniffing Out the Perpetrator (12910)
UPDATE creature_template SET faction=16 WHERE entry=29696;
REPLACE INTO npc_spellclick_spells VALUES(29857, 55460, 1, 0); -- summon frostbite
UPDATE creature_template SET minlevel=80, maxlevel=80, spell1=54997, spell2=54996, ScriptName="npc_frosthound", VehicleId=186 WHERE entry=29903;
DELETE FROM script_waypoint WHERE entry=29903;
INSERT INTO script_waypoint VALUES(29903, 0, 7743.28, -1074.97, 923.961, 0, ""),(29903, 1, 7714.78, -1125.33, 920.752, 0, ""),(29903, 2, 7694.41, -1144.21, 924.338, 0, ""),
(29903, 3, 7659.13, -1170.2, 924.061, 0, ""),(29903, 4, 7614.15, -1203.33, 925.42, 0, ""),(29903, 5, 7593.52, -1218.52, 924.65, 0, ""),(29903, 6, 7565.34, -1239.28, 918.562, 0, ""),
(29903, 7, 7531.4, -1264.28, 919.853, 0, ""),(29903, 8, 7518.06, -1291.42, 918.907, 0, ""),(29903, 9, 7500.64, -1326.85, 924.677, 0, ""),(29903, 10, 7464.65, -1336.95, 920.096, 0, ""),
(29903, 11, 7430.95, -1346.4, 915.483, 0, ""),(29903, 12, 7410.53, -1374.67, 916.67, 0, ""),(29903, 13, 7364.39, -1401.71, 911.923, 0, ""),(29903, 14, 7320.99, -1428.94, 913.126, 0, ""),
(29903, 15, 7314.71, -1484.4, 920.411, 0, ""),(29903, 16, 7313.25, -1523.99, 926.481, 0, ""),(29903, 17, 7312.41, -1547.08, 935.417, 0, ""),(29903, 18, 7303.55, -1564.23, 940.497, 0, ""),
(29903, 19, 7305.29, -1574.98, 942.825, 0, "");

-- Sniffing Out the Perpetrator (12855)
UPDATE creature_template SET minlevel=80, maxlevel=80, spell1=54997, spell2=54996, ScriptName="npc_frosthound", VehicleId=186 WHERE entry=29677;
DELETE FROM script_waypoint WHERE entry=29677;
INSERT INTO script_waypoint VALUES (29677, 0, 7165.14, -773.855, 894.895, 0, ""),(29677, 1, 7179.33, -788.763, 903.71, 0, ""),(29677, 2, 7207.97, -808.537, 921.821, 0, ""),
(29677, 3, 7237.43, -838.281, 926.706, 0, ""),(29677, 4, 7282.48, -893.923, 926.156, 0, ""),(29677, 5, 7279.9, -954.933, 918.822, 0, ""),(29677, 6, 7301.17, -996.417, 913.825, 0, ""),
(29677, 7, 7326.73, -1046.25, 910.424, 0, ""),(29677, 8, 7356.4, -1104.11, 908.415, 0, ""),(29677, 9, 7341.25, -1162.81, 914.103, 0, ""),(29677, 10, 7322.87, -1199.92, 917.447, 0, ""),(29677, 11, 7304.91, -1286.09, 904.76, 0, ""),
(29677, 12, 7270.82, -1310.39, 911.863, 0, ""),(29677, 13, 7244.32, -1348.24, 914.177, 0, ""),(29677, 14, 7203.65, -1418.44, 915.462, 0, ""),(29677, 15, 7216.47, -1467.89, 915.533, 0, ""),
(29677, 16, 7235.09, -1514.75, 921.836, 0, ""),(29677, 17, 7262.26, -1532.8, 927.988, 0, ""),(29677, 18, 7287.86, -1552.32, 935.227, 0, ""),(29677, 19, 7305.67, -1574.62, 942.686, 0, "");
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=40971;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=1 AND SourceEntry=40971;
INSERT INTO conditions VALUES (1, 29695, 40971, 0, 0, 9, 0, 12910, 0, 0, 0, 0, 0, '', 'Item 40971, drop only if have quest');
INSERT INTO conditions VALUES (1, 29695, 40971, 0, 1, 9, 0, 12855, 0, 0, 0, 0, 0, '', 'Item 40971, drop only if have quest');
INSERT INTO conditions VALUES (1, 29695, 40971, 0, 2, 28, 0, 12910, 0, 0, 0, 0, 0, '', 'Item 40971, drop only if have quest');
INSERT INTO conditions VALUES (1, 29695, 40971, 0, 3, 28, 0, 12855, 0, 0, 0, 0, 0, '', 'Item 40971, drop only if have quest');

-- Forging a Head (12985)
REPLACE INTO creature_template_addon VALUES(30163, 0, 0, 7, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=56227;
INSERT INTO conditions VALUES (13, 1, 56227, 0, 0, 31, 0, 3, 29914, 0, 0, 0, 0, '', 'Spell 56227 target Dead Iron Giant');
INSERT INTO conditions VALUES (13, 1, 56227, 0, 1, 31, 0, 3, 30163, 0, 0, 0, 0, '', 'Spell 56227 target Dead Iron Giant');
UPDATE creature_template SET unit_flags=537133824, dynamicflags=40, AIName="SmartAI", ScriptName="" WHERE entry IN(29914, 30163);
DELETE FROM smart_scripts WHERE entryorguid IN(29914, 30163) AND source_type=0;
INSERT INTO smart_scripts VALUES (29914, 0, 0, 1, 8, 0, 100, 0, 56227, 0, 0, 0, 12, 30208, 6, 120000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Iron Giant - on spell hit summon, link to despawn');
INSERT INTO smart_scripts VALUES (29914, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Iron Giant - on spell hit despawn');
INSERT INTO smart_scripts VALUES (29914, 0, 2, 0, 37, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'react passive on ai init');
INSERT INTO smart_scripts VALUES (30163, 0, 0, 1, 8, 0, 100, 0, 56227, 0, 0, 0, 12, 30208, 6, 120000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Iron Giant - on spell hit summon, link to despawn');
INSERT INTO smart_scripts VALUES (30163, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dead Iron Giant - on spell hit despawn');
INSERT INTO smart_scripts VALUES (30163, 0, 2, 0, 37, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'react passive on ai init');
DELETE FROM creature_loot_template WHERE entry=30208 AND item=42423;
INSERT INTO creature_loot_template VALUES(30208, 42423, -100, 1, 0, 1, 1);

-- Valkyrion Must Burn (12953)
UPDATE creature_template SET AIName="SmartAI" WHERE entry=30096;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=55896;
INSERT INTO conditions VALUES (13, 6, 55896, 0, 0, 31, 0, 3, 30096, 0, 0, 0, 0, '', 'Spell 55896, requires alive haystack');
INSERT INTO conditions VALUES (13, 6, 55896, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Spell 55896, requires alive haystack');
DELETE FROM smart_scripts WHERE entryorguid=30096 AND source_type=0;
INSERT INTO smart_scripts VALUES (30096, 0, 0, 1, 8, 0, 100, 0, 55896, 0, 0, 0, 33, 30096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'kill credit on spell hit');
INSERT INTO smart_scripts VALUES (30096, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Despawn linked');
UPDATE creature SET curhealth=5342 WHERE id=30066;
UPDATE creature SET spawntimesecs=200 WHERE id=30096;

-- Memories of Stormhoof (13037)
UPDATE creature_template SET npcflag = npcflag | 1, AIName="SmartAI" WHERE entry=30395;
DELETE FROM gossip_menu_option WHERE menu_id=9906;
INSERT INTO gossip_menu_option VALUES(9906, 1, 0, "Tell me more about your memories.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=30395 AND source_type=0;
INSERT INTO smart_scripts VALUES (30395, 0, 0, 1, 62, 0, 100, 0, 9906, 1, 0, 0, 33, 30381, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select kill credit");
INSERT INTO smart_scripts VALUES (30395, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(9906);
INSERT INTO conditions VALUES(15, 9906, 1, 0, 0, 9, 0, 13037, 0, 0, 0, 0, 0, '', 'Must be at quest 13037 to see this option');

-- Data Mining (12927)
-- Data Mining (12860)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=55161;
INSERT INTO conditions VALUES (13, 1, 55161, 0, 0, 31, 0, 3, 29746, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=29746;
DELETE FROM smart_scripts WHERE entryorguid=29746 AND source_type=0;
INSERT INTO smart_scripts VALUES (29746, 0, 0, 1, 8, 0, 100, 0, 59728, 0, 0, 0, 33, 29752, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Kill credit on spell hit");
INSERT INTO smart_scripts VALUES (29746, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Force Despawn on spell hit");

-- The Iron Colossus (13007)
UPDATE creature_template SET spell1=56524, spell2=56513, spell3=56504, unit_flags=4 WHERE entry=30301;
DELETE FROM spell_script_names WHERE spell_id IN(56504, 56508);
INSERT INTO spell_script_names VALUES(56504, 'spell_q13007_iron_colossus');
INSERT INTO spell_script_names VALUES(56508, 'spell_q13007_iron_colossus');

-- Slaves of the Stormforged (12957)
DELETE FROM gossip_menu WHERE entry=9871;
INSERT INTO gossip_menu (entry,text_id) VALUES (9871,13682);
DELETE FROM gossip_menu_option WHERE menu_id=9871;
INSERT INTO gossip_menu_option VALUES(9871,0,0,"I'm not a laborer. I'm here to free you from servitude in the mines.",1,1,0,0,0,0,'');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=29384;
DELETE FROM smart_scripts WHERE entryorguid=29384 AND source_type=0;
INSERT INTO smart_scripts VALUES(29384,0,0,1,62,0,100,1,9871,0,0,0,33,29962,0,0,0,0,0,7,0,0,0,0,0,0,0,'Captive Mechagnome - on gossip select 9871 - Slaves of the Stormforged quest credit');
INSERT INTO smart_scripts VALUES(29384,0,1,2,61,0,100,1,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Captive Mechagnome - on gossip select 9871 - close gossip');
INSERT INTO smart_scripts VALUES(29384,0,2,3,61,0,100,1,0,0,0,0,41,1500,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - on gossip select 9871 - force despawn');
INSERT INTO smart_scripts VALUES(29384,0,3,0,61,0,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Captive Mechagnome - Say text');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9871;
INSERT INTO conditions VALUES(15,9871,0,0,0,9,0,12957,0,0,0,0, 0,'','Show gossip only if Slaves of the Stormforged quest taken');
DELETE FROM creature_text WHERE entry=29384;
INSERT INTO creature_text VALUES(29384,0,0, "Does not compute. Unit malfunctioning. Directive: shut down.",12,0,100,0,0,0, 0, 'Captive Mechagnome');
INSERT INTO creature_text VALUES(29384,0,1, "New directive: leave mine and return to Inventor's Library.",12,0,100,0,0,0, 0, 'Captive Mechagnome');
INSERT INTO creature_text VALUES(29384,0,2, "Free again? Keeper Mimir's work awaits. ",12,0,100,0,0,0, 0, 'Captive Mechagnome');
INSERT INTO creature_text VALUES(29384,0,3, "New directive: assist in the defeat of the iron dwarves.",12,0,100,0,0,0, 0, 'Captive Mechagnome');

-- Norgannon's Shell (12928)
-- Norgannon's Shell (12872)
DELETE FROM event_scripts WHERE id=19410;
INSERT INTO event_scripts VALUES(19410, 2, 10, 29775, 600000, 1, 7991.81, -827.6, 968.263, 2.897);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29775);
DELETE FROM creature WHERE id=29775;
UPDATE creature_template SET AIName="SmartAI", faction=35, unit_flags=0 WHERE entry=29775;
DELETE FROM smart_scripts WHERE entryorguid=29775 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=29775*100 AND source_type=9;
DELETE FROM creature_text WHERE entry IN(29775);
INSERT INTO creature_text VALUES(29775, 0, 0, "Use of the Inventor's Disk detected. Emergency protocol gamma activated.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 1, 0, "Verifying status of Norgannon's shell.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 2, 0, "Norgannon's shell accounted for and secure. It will be available for transfer once user's identity has been verified.", 12, 0, 100, 1, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 3, 0, "Standby to verify identity as Keeper Mimir.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 4, 0, "Identity verification failed. User is not Keeper Mimir.", 12, 0, 100, 25, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 5, 0, "The Inventor's Disk has fallen into the hands of an unauthorized user. Activating defense protocol.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(29775, 6, 0, "Impostor must be dealt with. The Inventor's Disk must be recovered.", 12, 0, 100, 5, 0, 0, 0, '');
INSERT INTO smart_scripts VALUES(29775, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 80, 29775*100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "run timed actionlist");
INSERT INTO smart_scripts VALUES(29775*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 1, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(29775*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set faction');
REPLACE INTO creature_loot_template VALUES(29775, 41258, -100, 1, 0, 1, 1);

-- A Spark of Hope (12956)
UPDATE quest_template SET PrevQuestId=0, RewardFactionValueIdOverride1=2860000 WHERE Id=12956;
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry=12956;
INSERT INTO conditions VALUES (19, 0, 12956, 0, 0, 8, 0, 12922, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (19, 0, 12956, 0, 0, 8, 0, 12915, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12956, 0, 0, 8, 0, 12922, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');
INSERT INTO conditions VALUES (20, 0, 12956, 0, 0, 8, 0, 12915, 0, 0, 0, 0, 0, '', 'Requires quest rewarded');

-- Spy Hunter (12994)
DELETE FROM gameobject WHERE id=193993;
INSERT INTO gameobject VALUES(NULL, 193993, 571, 1, 4, 7161.85, -2229.08, 759.091, 0.838255, 0, 0, 0.406964, 0.913444, 300, 0, 1, 0);
UPDATE creature_template SET unit_flags=512, AIName='SmartAI' WHERE entry=30219;
DELETE FROM smart_scripts WHERE entryorguid IN(30219) AND source_type=0;
INSERT INTO smart_scripts VALUES (30219, 0, 0, 0, 60, 0, 100, 0, 500, 500, 5000, 5000, 89, 80, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Move random on spawn');
INSERT INTO smart_scripts VALUES (30219, 0, 1, 0, 60, 0, 100, 0, 20000, 25000, 20000, 25000, 12, 30222, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'summon infiltrator');

-- Aberrations (12925)
-- pussywizard: this is only exploit fix, so spell from item won't target random gameobject
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=55647;
INSERT INTO conditions VALUES (13, 1, 55647, 0, 0, 31, 0, 5, 191840, 0, 0, 0, 0, '', 'Vial of Frost Oil - target only Plagued Proto-Drake Egg');

-- Raising Hodir's Spear (13001), spawns added in spawns.sql
REPLACE INTO creature_loot_template VALUES(30260, 42542, -20, 1, 0, 1, 1);

-- Polishing the Helm (13006)
REPLACE INTO creature_loot_template VALUES(30325, 42640, -100, 1, 0, 1, 1);

-- Battling the Elements (12967)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(56753);
INSERT INTO spell_linked_spell VALUES(56753, -56750, 0, 'remove snowball aura on cast');
UPDATE creature_template SET faction=834 WHERE entry IN(30120, 30121);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceEntry=55957;
INSERT INTO conditions VALUES (18, 30123, 55957, 0, 0, 9, 0, 12967, 0, 0, 0, 0, 0, '', 'Requires Battling the Elements (12967) to enable spellclick');
DELETE FROM npc_spellclick_spells WHERE npc_entry=30123;
INSERT INTO npc_spellclick_spells VALUES(30123, 55957, 1, 0);
UPDATE creature_template SET npcflag=16777216 WHERE entry=30123;
UPDATE creature_template SET npcflag=0, spell1=56750, spell2=56753 WHERE entry=30124;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(56753);
INSERT INTO conditions VALUES (17, 0, 56753, 0, 0, 31, 1, 3, 30120, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (17, 0, 56753, 0, 1, 31, 1, 3, 30121, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=30120;
DELETE FROM smart_scripts WHERE entryorguid=30120 AND source_type=0;
INSERT INTO smart_scripts VALUES (30120, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 56620, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell IC');
INSERT INTO smart_scripts VALUES (30120, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 33, 30125, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Killmonster credit on kill');
DELETE FROM conditions WHERE SourceEntry IN(30120) AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 2, 30120, 0, 0, 31, 0, 3, 30124, 0, 0, 0, 0, '', 'Only execute SAI if invoker has entry 30124');

-- Hot and Cold (12981)
REPLACE INTO gameobject_queststarter VALUES(192071, 12981);
REPLACE INTO gameobject_questender VALUES(192071, 12981);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=56099;
INSERT INTO conditions VALUES (13, 1, 56099, 0, 0, 31, 0, 3, 30169, 0, 0, 0, 0, '', '');
UPDATE creature_template SET modelid1=19595, modelid2=0, AIName='SmartAI' WHERE entry=30169;
DELETE FROM smart_scripts WHERE entryorguid=30169 AND source_type=0;
INSERT INTO smart_scripts VALUES (30169, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 56073, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'cast spell on respawn');
INSERT INTO smart_scripts VALUES (30169, 0, 1, 2, 8, 0, 100, 0, 56099, 0, 0, 0, 11, 56101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell hit - cast spell');
INSERT INTO smart_scripts VALUES (30169, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 20, 192124, 10, 0, 0, 0, 0, 0, 'Linked - Despawn GO');
INSERT INTO smart_scripts VALUES (30169, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Despawn self');

-- Blowing Hodir's Horn (12977)
REPLACE INTO gameobject_queststarter VALUES(192078, 12977);
REPLACE INTO gameobject_questender VALUES(192078, 12977);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=55983;
INSERT INTO conditions VALUES (17, 0, 55983, 0, 0, 31, 1, 3, 30135, 0, 0, 0, 0, '', 'Requires Restless Warrior');
INSERT INTO conditions VALUES (17, 0, 55983, 0, 1, 31, 1, 3, 30144, 0, 0, 0, 0, '', 'Requires Restless Ghost');
INSERT INTO conditions VALUES (17, 0, 55983, 0, 2, 31, 1, 3, 29974, 0, 0, 0, 0, '', 'Requires Niffelem Forefather');
INSERT INTO conditions VALUES (17, 0, 55983, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Requires Dead Restless Warrior');
INSERT INTO conditions VALUES (17, 0, 55983, 0, 1, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Requires Dead Restless Ghost');
INSERT INTO conditions VALUES (17, 0, 55983, 0, 2, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Requires Dead Niffelem Forefather');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(30135, 30144, 29974);
DELETE FROM smart_scripts WHERE entryorguid IN(30135, 30144, 29974) AND source_type=0;
INSERT INTO smart_scripts VALUES (30135, 0, 0, 1, 8, 0, 100, 0, 55983, 0, 0, 0, 33, 30139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30135, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (30144, 0, 0, 1, 8, 0, 100, 0, 55983, 0, 0, 0, 33, 30139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (30144, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (29974, 0, 0, 1, 8, 0, 100, 0, 55983, 0, 0, 0, 33, 30138, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (29974, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (29974, 0, 2, 0, 0, 0, 100, 0, 1000, 5000, 8000, 13000, 11, 57454, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Ice Spike');

-- Feeding Arngrim (13046)
REPLACE INTO gameobject_queststarter VALUES(192524, 13046);
REPLACE INTO gameobject_questender VALUES(192524, 13046);
UPDATE creature_template SET unit_flags=0, AIName='SmartAI', ScriptName='' WHERE entry IN(30422, 30423);
UPDATE creature_template SET speed_walk=3.5, speed_run=3, AIName='SmartAI', ScriptName='' WHERE entry=30425;
DELETE FROM smart_scripts WHERE entryorguid IN(30422, 30423, 30425) AND source_type=0;
INSERT INTO smart_scripts VALUES (30422, 0, 0, 1, 8, 0, 100, 1, 56727, 0, 0, 0, 36, 30423, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Update Template');
INSERT INTO smart_scripts VALUES (30422, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Phase');
INSERT INTO smart_scripts VALUES (30422, 0, 2, 3, 2, 1, 100, 1, 0, 10, 0, 0, 11, 56732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES (30422, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56731, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES (30425, 0, 0, 0, 60, 0, 100, 1, 1500, 1500, 0, 0, 69, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Update - Move To Pos');
INSERT INTO smart_scripts VALUES (30425, 0, 1, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (30425, 0, 2, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn');
INSERT INTO smart_scripts VALUES (30425, 0, 3, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 5, 53, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Handle Emote');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=56727;
INSERT INTO conditions VALUES (17, 0, 56727, 0, 0, 31, 1, 3, 30422, 0, 0, 0, 0, '', 'Requires Roaming Jormungar');

-- Thrusting Hodir's Spear (13003)
REPLACE INTO gameobject_queststarter VALUES(192079, 13003);
REPLACE INTO gameobject_questender VALUES(192079, 13003);

-- Everfrost (13420)
DELETE FROM pool_gameobject WHERE guid IN(221000, 221001, 221002, 221003, 221004);
INSERT INTO pool_gameobject VALUES(221000, 383, 0, 'Everfrost Chip 0');
INSERT INTO pool_gameobject VALUES(221001, 383, 0, 'Everfrost Chip 1');
INSERT INTO pool_gameobject VALUES(221002, 383, 0, 'Everfrost Chip 2');
INSERT INTO pool_gameobject VALUES(221003, 383, 0, 'Everfrost Chip 3');
INSERT INTO pool_gameobject VALUES(221004, 383, 0, 'Everfrost Chip 4');
DELETE FROM pool_template WHERE description="Everfrost pool";
REPLACE INTO pool_template VALUES(383, 2, "Everfrost pool");
DELETE FROM gameobject WHERE id=193997; -- ensure object is visible in all phases
INSERT INTO gameobject VALUES (221000, 193997, 571, 1, 15, 7338.53, -2323.91, 750.689, 2.51327, 0, 0, 0.951056, 0.309019, 3600, 100, 1, 0);
INSERT INTO gameobject VALUES (221001, 193997, 571, 1, 15, 7558.2, -3285.41, 879.134, 2.63544, 0, 0, 0.968147, 0.250383, 3600, 100, 1, 0);
INSERT INTO gameobject VALUES (221002, 193997, 571, 1, 15, 7472.23, -2477.99, 760.7, -0.087266, 0, 0, -0.0436192, 0.999048, 3600, 100, 1, 0);
INSERT INTO gameobject VALUES (221003, 193997, 571, 1, 15, 7155.12, -2096.03, 764.428, 2.53072, 0, 0, 0, 1, 3600, 100, 1, 0);
INSERT INTO gameobject VALUES (221004, 193997, 571, 1, 15, 7218.2, -2139.83, 863.085, -1.09956, 0, 0, 0, 1, 3600, 100, 1, 0);
DELETE FROM gameobject_loot_template WHERE entry=26782;
INSERT INTO gameobject_loot_template VALUES(26782, 44724, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES(26782, 44725, 20, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES(26782, 44729, 100, 1, 0, 1, 1);

-- Remember Everfrost! (13421)
UPDATE quest_template SET PrevQuestId=13420 WHERE Id=13421;
REPLACE INTO creature_queststarter VALUES(32594, 13421);
REPLACE INTO creature_questender VALUES(32594, 13421);

-- Valduran the Stormborn (12984)
UPDATE creature_template SET faction=1770 WHERE entry IN(29801, 30152);
DELETE FROM creature_text WHERE comment='Valduran the Stormborn Quest';
INSERT INTO creature_text VALUES(29801, 0, 0, 'At last, the tyranny of the stormforged is at its end!', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(29801, 1, 0, 'We\'ve defeated Valduran and we\'ll fell his colossus.', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(30152, 0, 0, 'No more will your minions assail the creatures of stone and their allies.', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(30152, 1, 0, 'I am your doom, Valduran!', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(30152, 2, 0, 'Well fought! The day is ours, but the war goes on!', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(29368, 0, 0, 'How predictable! But then, who would expect a rock to think like anything other than one?', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
INSERT INTO creature_text VALUES(29368, 1, 0, 'If you\'re so eager to fight, I\'ll oblige you. But know that nothing you do here can prevent the completion of the iron colossus!', 12, 0, 100, 0, 0, 0, 0, 'Valduran the Stormborn Quest');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=29368;
UPDATE creature_template SET unit_flags=256, faction=2102, AIName='SmartAI' WHERE entry=29368;
DELETE FROM smart_scripts WHERE entryorguid=29368 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(29368*100, 29368*100+1) AND source_type=9;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=56189;
INSERT INTO conditions VALUES (13, 1, 56189, 0, 0, 31, 0, 3, 29368, 0, 0, 0, 0, '', '');
INSERT INTO smart_scripts VALUES (29368, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set event phase');
INSERT INTO smart_scripts VALUES (29368, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56220, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cast spell');
INSERT INTO smart_scripts VALUES (29368, 0, 2, 3, 8, 1, 100, 0, 56189, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On SpellHit - Remove all auras');
INSERT INTO smart_scripts VALUES (29368, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set event phase');
INSERT INTO smart_scripts VALUES (29368, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 29368*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Run Script');
INSERT INTO smart_scripts VALUES (29368, 0, 5, 0, 0, 0, 100, 0, 2000, 4000, 15000, 17000, 11, 56319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (29368, 0, 6, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 11, 56326, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (29368, 0, 7, 0, 0, 0, 100, 0, 11000, 13000, 25000, 30000, 11, 56322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (29368, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 29801, 30, 0, 0, 0, 0, 0, 'On Death - NPC 29801 Say text 1');
INSERT INTO smart_scripts VALUES (29368, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 'On Death - NPC 30152 Say text 2');
INSERT INTO smart_scripts VALUES (29368, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 29368, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, 'Kill credit for all players');
INSERT INTO smart_scripts VALUES (29368*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 29801, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 7725, 105, 1010.64, 1.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (29368*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30152, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 7734, 113, 1010.64, 3.0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (29368*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 11, 0, 30, 0, 0, 0, 0, 0, 'Script9 - Set npc flag 0 for all creatures in range');
INSERT INTO smart_scripts VALUES (29368*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 29801, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 29801 say text 0');
INSERT INTO smart_scripts VALUES (29368*100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30152 say text 0');
INSERT INTO smart_scripts VALUES (29368*100, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30152, 30, 0, 0, 0, 0, 0, 'Script9 - NPC 30152 say text 1');
INSERT INTO smart_scripts VALUES (29368*100, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 0');
INSERT INTO smart_scripts VALUES (29368*100, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - say text 1');
INSERT INTO smart_scripts VALUES (29368*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 18, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - set unit flag 0');
INSERT INTO smart_scripts VALUES (29368*100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Script9 - Attack start');

-- Destroy The Forges! (12988)
UPDATE creature_template SET AIName='SmartAI', flags_extra=flags_extra|128 WHERE entry IN (30209, 30211, 30212);
DELETE FROM smart_scripts WHERE entryorguid IN (30209, 30211, 30212) AND source_type=0;
INSERT INTO smart_scripts VALUES (30209, 0, 0, 1, 8, 0, 100, 0, 56275, 0, 0, 0, 33, 30209, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "North Lightning Forge - On Spellhit - Quest Credit");
INSERT INTO smart_scripts VALUES (30209, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 65129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "North Lightning Forge - On Spellhit - Cast Explosion");
INSERT INTO smart_scripts VALUES (30209, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "North Lightning Forge - On Spellhit - Cast Explosion");
INSERT INTO smart_scripts VALUES (30211, 0, 0, 1, 8, 0, 100, 0, 56275, 0, 0, 0, 33, 30211, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Central Lightning Forge - On Spellhit - Quest Credit");
INSERT INTO smart_scripts VALUES (30211, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 65129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Central Lightning Forge - On Spellhit - Cast Explosion");
INSERT INTO smart_scripts VALUES (30211, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Central Lightning Forge - On Spellhit - Cast Explosion");
INSERT INTO smart_scripts VALUES (30212, 0, 0, 1, 8, 0, 100, 0, 56275, 0, 0, 0, 33, 30212, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "South Lightning Forge - On Spellhit - Quest Credit");
INSERT INTO smart_scripts VALUES (30212, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 65129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "South Lightning Forge - On Spellhit - Cast Explosion");
INSERT INTO smart_scripts VALUES (30212, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "South Lightning Forge - On Spellhit - Cast Explosion");

-- Fervor of the Frostborn (12874)
DELETE FROM conditions WHERE SourceEntry=56448 AND SourceTypeOrReferenceId IN(17);
INSERT INTO conditions VALUES(17, 0, 56448, 0, 0, 31, 1, 3, 30142, 0, 0, 0, 0, '', 'Hammer, target iron watcher');
DELETE FROM creature_text WHERE entry=30142;
INSERT INTO creature_text VALUES(30142, 0, 0, 'The Iron Watcher reels, reaching to its now useless eyes, and charges blindly.', 41, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30142, 1, 0, 'The Iron Watcher looses its footing under the furious blow.', 41, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
UPDATE creature_model_info SET combat_reach=6 WHERE modelid=26782;
UPDATE creature_template SET AIName='', ScriptName='npc_iron_watcher' WHERE entry=30142;
DELETE FROM smart_scripts WHERE entryorguid=30142 AND source_type=0;
DELETE FROM creature WHERE id=30142;
INSERT INTO creature VALUES(NULL, 30142, 571, 1, 1, 0, 0, 8392.7, -1970.14, 1461.84, 0.0948219, 600, 0, 0, 100800, 0, 0, 0, 0, 0);
DELETE FROM gameobject WHERE id=192243;
INSERT INTO gameobject VALUES(NULL, 192243, 571, 1, 1, 8531.9, -1971.44, 1467.57, -0.837757, 0, 0, -0.406736, 0.913546, 300, 100, 1, 0);
DELETE FROM creature_text WHERE entry=30401;
INSERT INTO creature_text VALUES(30401, 0, 0, "King Stormheart is putting you to the test, eh? He must see something in you to begin with or I doubt he'd put you through such a sacred ritual.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 1, 0, "I know you're new to our kind, so I'll catch you up a bit while we're on our way over.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 2, 0, "Years back, my father and several other frostborn were returning from a trek across Dragonblight. There was a heavy blizzard... far worse than we've ever seen since.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 3, 0, "They crossed a trail of blood-soaked snow and followed it to a dwarf wandering and speaking in a dialect they couldn't make out... and not a dwarf of our kind mind you, but a mountain dwarf - something our kind had not seen before.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 4, 0, "The dwarf seemed lost, having no memory of where he came from, or even of his own name. Not being the kind to leave a dwarven cousin to die in the snow, my father's party took him in and continued back towards Frosthold.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 5, 0, "Not long later, out of nowhere, the snow burst before them and a jormungar the size of Veranus herself came down upon their party... one of them was swallowed whole before they even had time to react.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 6, 0, "My father thought they were all doomed... but behind him, a furious roar rumbled across the snow, and he turned to see the mountain dwarf growing in size, his skin taking on a stone-like texture, and his hands sizzling with lightning.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 7, 0, "The dwarf barreled forward with a sound like rolling thunder and hurled a shining metal hammer, lightning coursing over its surface, directly into the jormungar's throat.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 8, 0, "The jormungar collapsed instantly, its head barely still attached to its convulsing body. My father turned to the dwarf in awe and raised a fist in praise...", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 9, 0, "The stranger having no name of his own, my father deemed \"Yorg\", a name reserved for the champions of legend. Years later, he now stands before us as Yorg Stormheart, King of the Frostborn.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 10, 0, "King Stormheart has trained us well... turned us into even more fearsome warriors than we could have boasted during the time of our war with the Frost Giants.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 11, 0, "And as one of the fiercest tests put upon a warrior of the frostborn, we are made to face a creature far larger than ourselves--giants, dragons, jormungar--as a testament to the fact that size will never be our weakness.", 12, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 12, 0, "This is the test put before you this day. Return to us only once The Iron Watcher is dead, and be revered as a warrior of the frostborn. Velog drops the player off at the end of a broken bridge.", 14, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
INSERT INTO creature_text VALUES(30401, 13, 0, "He is slow from the rust of the ages... be quick on your feet and he will not best you. You have King Stormheart's favor - do not disappoint.", 14, 0, 100, 0, 0, 0, 0, 'Fervor of the Frostborn Quest');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=29732;
DELETE FROM gossip_menu_option WHERE menu_id=9891;
INSERT INTO gossip_menu_option VALUES(9891, 0, 0, 'King Stormheart sent me to be tested as a frostborn would. I am ready for my test, Fjorlin.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9891;
INSERT INTO conditions VALUES(15, 9891, 0, 0, 0, 9, 0, 12874, 0, 0, 0, 0, 0, '', 'Show gossip only if Fervor of the Frostborn quest taken');
DELETE FROM smart_scripts WHERE entryorguid IN (29732) AND source_type=0;
INSERT INTO smart_scripts VALUES (29732, 0, 0, 1, 62, 0, 100, 0, 9891, 0, 0, 0, 12, 30401, 3, 162000, 0, 0, 0, 8, 0, 0, 0, 6606, -277, 986, 3.3, "On gossip select - summon creature");
INSERT INTO smart_scripts VALUES (29732, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Linked - Close gossip");
INSERT INTO smart_scripts VALUES (29732, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56411, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, "Linked - cast spell (forcecast)");
INSERT INTO smart_scripts VALUES (29732, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 85, 56687, 0, 0, 0, 0, 0, 19, 29736, 20, 0, 0, 0, 0, 0, "Linked - invoker cast spell");
DELETE FROM npc_spellclick_spells WHERE npc_entry=29736;
INSERT INTO npc_spellclick_spells VALUES(29736, 67830, 1, 0);
REPLACE INTO creature_template_addon VALUES(29736, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET speed_walk=10, speed_run=5, InhabitType=4, AIName='SmartAI' WHERE entry=29736;
DELETE FROM smart_scripts WHERE entryorguid IN (29736) AND source_type=0;
INSERT INTO smart_scripts VALUES (29736, 0, 0, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 53, 1, 29736, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - start wp");
INSERT INTO smart_scripts VALUES (29736, 0, 1, 16, 27, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "ON passenger boarded - set npcflag to 0");
INSERT INTO smart_scripts VALUES (29736, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - set fly");
INSERT INTO smart_scripts VALUES (29736, 0, 2, 0, 40, 0, 100, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 0 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 3, 0, 40, 0, 100, 0, 7, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 1 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 4, 0, 40, 0, 100, 0, 10, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 2 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 5, 0, 40, 0, 100, 0, 13, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 3 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 6, 0, 40, 0, 100, 0, 15, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 4 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 7, 0, 40, 0, 100, 0, 17, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 5 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 8, 0, 40, 0, 100, 0, 19, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 6 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 9, 0, 40, 0, 100, 0, 22, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 7 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 10, 0, 40, 0, 100, 0, 24, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 8 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 11, 0, 40, 0, 100, 0, 28, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 9 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 12, 0, 40, 0, 100, 0, 30, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 10 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 13, 0, 40, 0, 100, 0, 32, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 11 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 14, 0, 40, 0, 100, 0, 34, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 12 on wp reach');
INSERT INTO smart_scripts VALUES (29736, 0, 15, 0, 40, 0, 100, 0, 36, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 'say text 13 on wp reach');
DELETE FROM waypoints WHERE entry=29736;
INSERT INTO waypoints VALUES (29736, 1, 6603.31, -272.773, 988.054, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 2, 6567.78, -283.843, 983.271, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 3, 6525.8, -320.955, 975.602, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 4, 6494.41, -369.545, 967.738, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 5, 6484.09, -462.986, 954.571, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 6, 6477.74, -565.348, 940.242, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 7, 6504.45, -607.032, 933.271, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 8, 6547.57, -655.802, 922.877, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 9, 6601.81, -686.798, 911.13, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 10, 6693.96, -735.666, 891.467, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 11, 6753.54, -748.784, 879.917, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 12, 6869.93, -747.289, 927.448, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 13, 6955.54, -744.598, 965.127, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 14, 7100.71, -777.982, 977.417, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 15, 7191.97, -814.27, 994.576, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 16, 7293.01, -852.093, 1019.23, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 17, 7413.69, -881.949, 1011.37, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 18, 7532.76, -907.114, 1003.69, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 19, 7611.44, -965.035, 1026.22, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 20, 7645.07, -995.678, 1025.63, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 21, 7719.04, -1046.04, 1025.39, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 22, 7772.62, -1082.52, 1069.61, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 23, 7826.35, -1109.44, 1112.49, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 24, 7896.46, -1126.24, 1150.65, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 25, 7958.42, -1139.5, 1159.25, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 26, 8010, -1165.87, 1155.76, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 27, 8086.81, -1225.61, 1198.79, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 28, 8160.98, -1293.11, 1262.01, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 29, 8277.97, -1399.58, 1290.87, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 30, 8358.14, -1513.07, 1295.16, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 31, 8460.52, -1657.36, 1279.06, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 32, 8495.3, -1730.74, 1286.54, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 33, 8503.7, -1766.98, 1347.95, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 34, 8516.63, -1822.82, 1416.27, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 35, 8521.68, -1899.55, 1492.74, 'Stormcrest eagle, Fervor of the Frostborn');
INSERT INTO waypoints VALUES (29736, 36, 8518.14, -1954.8, 1484.65, 'Stormcrest eagle, Fervor of the Frostborn');

-- The Reckoning (13047)
UPDATE quest_template SET PrevQuestId=13057, NextQuestId=13047, ExclusiveGroup=-13005, NextQuestIdChain=13047 WHERE Id=13005; -- The Earthen Oath
UPDATE quest_template SET PrevQuestId=13057, NextQuestId=13047, ExclusiveGroup=-13005, NextQuestIdChain=13047 WHERE Id=13035; -- Loken's Lackeys

-- Fate of the Titans (12986)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(30313);
INSERT INTO conditions VALUES
(22, 1, 30313, 0, 0, 29, 1, 30315, 30, 0, 0, 0, 0, '', 'NPC 30313 Event 0 - Requires NPC 30315 in 30 yd to run'),
(22, 2, 30313, 0, 0, 29, 1, 30316, 30, 0, 0, 0, 0, '', 'NPC 30313 Event 1 - Requires NPC 30316 in 30 yd to run'),
(22, 3, 30313, 0, 0, 29, 1, 30317, 30, 0, 0, 0, 0, '', 'NPC 30313 Event 2 - Requires NPC 30317 in 30 yd to run'),
(22, 4, 30313, 0, 0, 29, 1, 30318, 30, 0, 0, 0, 0, '', 'NPC 30313 Event 3 - Requires NPC 30318 in 30 yd to run');
UPDATE creature_template SET AIName='SmartAI', InhabitType=4 WHERE entry=30313;
DELETE FROM smart_scripts WHERE entryorguid = 30313 AND source_type = 0;
INSERT INTO smart_scripts VALUES
(30313, 0, 0, 0, 60, 0, 100, 1, 2000, 2000, 2000, 2000, 53, 0, 30315, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Invention) - Start wp'),
(30313, 0, 1, 0, 60, 0, 100, 1, 2000, 2000, 2000, 2000, 53, 0, 30316, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Life) - Start wp'),
(30313, 0, 2, 0, 60, 0, 100, 1, 2000, 2000, 2000, 2000, 53, 0, 30317, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Winter) - Start wp'),
(30313, 0, 3, 0, 60, 0, 100, 1, 2000, 2000, 2000, 2000, 53, 0, 30318, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Order) - Start wp'),
(30313, 0, 4, 5, 40, 0, 100, 0, 2, 30315, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 6, 7, 40, 0, 100, 0, 3, 30315, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 8, 9, 40, 0, 100, 0, 5, 30315, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 10, 11, 40, 0, 100, 0, 6, 30315, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 12, 13, 40, 0, 100, 0, 7, 30315, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 14, 15, 40, 0, 100, 0, 2, 30316, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 16, 17, 40, 0, 100, 0, 3, 30316, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 18, 19, 40, 0, 100, 0, 5, 30316, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 20, 21, 40, 0, 100, 0, 6, 30316, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 22, 23, 40, 0, 100, 0, 7, 30316, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 24, 25, 40, 0, 100, 0, 2, 30317, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 25, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 26, 27, 40, 0, 100, 0, 3, 30317, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 28, 29, 40, 0, 100, 0, 5, 30317, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 29, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 30, 31, 40, 0, 100, 0, 6, 30317, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 31, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 32, 33, 40, 0, 100, 0, 7, 30317, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 33, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 34, 35, 40, 0, 100, 0, 2, 30318, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 35, 0, 61, 0, 100, 0, 2, 30318, 0, 0, 1, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 36, 37, 40, 0, 100, 0, 3, 30318, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 37, 0, 61, 0, 100, 0, 3, 30318, 0, 0, 1, 17, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 38, 39, 40, 0, 100, 0, 5, 30318, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 39, 0, 61, 0, 100, 0, 5, 30318, 0, 0, 1, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 40, 41, 40, 0, 100, 0, 6, 30318, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 41, 0, 61, 0, 100, 0, 6, 30318, 0, 0, 1, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 42, 0, 58, 0, 100, 0, 8, 30315, 0, 0, 11, 56532, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_invention - cast killcredit'),
(30313, 0, 43, 0, 58, 0, 100, 0, 8, 30316, 0, 0, 11, 56534, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_life - cast killcredit'),
(30313, 0, 44, 0, 58, 0, 100, 0, 8, 30317, 0, 0, 11, 56533, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_winter - cast killcredit'),
(30313, 0, 45, 0, 58, 0, 100, 0, 8, 30318, 0, 0, 11, 56535, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_order - cast killcredit');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30315, 30316, 30317, 30318));
DELETE FROM creature WHERE id IN(30315, 30316, 30317, 30318);
INSERT INTO creature VALUES
(NULL, 30315, 571, 1, 1, 11686, 0, 7865.79, -1397.25, 1534.06, 0.331613, 300, 5, 0, 12600, 0, 1, 0, 0, 0),
(NULL, 30316, 571, 1, 1, 11686, 0, 7994.02, -2734.84, 1133.66, 0.331613, 300, 5, 0, 12600, 0, 1, 0, 0, 0),
(NULL, 30317, 571, 1, 1, 11686, 0, 7498.69, -1898.53, 1473.62, 0.331613, 300, 5, 0, 12600, 0, 1, 0, 0, 0),
(NULL, 30318, 571, 1, 1, 11686, 0, 8194.56, -1963.53, 1738.48, 0.331613, 300, 5, 0, 12600, 0, 1, 0, 0, 0);
DELETE FROM waypoints WHERE entry IN(30315, 30316, 30317, 30318);
INSERT INTO waypoints VALUES
(30315, 1, 7864.2, -1397.21, 1538.33, ''),(30315, 2, 7888.6, -1421.11, 1535.86, ''),(30315, 3, 7888.11, -1426.91, 1535.66, ''),(30315, 4, 7857.51, -1363.63, 1537, ''),(30315, 5, 7924.52, -1384.23, 1537.98, ''),
(30315, 6, 7883.53, -1338.13, 1537.35, ''),(30315, 7, 7864.17, -1396.05, 1539.02, ''),(30315, 8, 7864.17, -1396.05, 1543.92, ''),(30317, 1, 7506.22, -1889.43, 1475.11, ''),(30317, 2, 7503.87, -1882.19, 1474.22, ''),
(30317, 3, 7493.96, -1883.6, 1474.96, ''),(30317, 4, 7466.96, -1844.15, 1475.9, ''),(30317, 5, 7466.96, -1844.15, 1479.75, ''),(30317, 6, 7462.91, -1885.65, 1475.85, ''),(30317, 7, 7515.39, -1883.06, 1475.08, ''),
(30317, 8, 7498.72, -1898.71, 1476.34, ''),(30318, 1, 8180.27, -1959.35, 1740.65, ''),(30318, 2, 8185.21, -1965.16, 1740.38, ''),(30318, 3, 8178.21, -1965.28, 1739.39, ''),(30318, 4, 8138.71, -1992.56, 1782.86, ''),
(30318, 5, 8144.53, -1990.98, 1746.96, ''),(30318, 6, 8218.06, -2018.64, 1744.73, ''),(30318, 7, 8248.05, -1939.41, 1744.21, ''),(30318, 8, 8195.3, -1964.75, 1741.42, ''),(30316, 1, 7991.77, -2736.45, 1134.52, ''),
(30316, 2, 7993.06, -2725.04, 1137.29, ''),(30316, 3, 7999.48, -2732.53, 1137.59, ''),(30316, 4, 7934.64, -2746.38, 1145.63, ''),(30316, 5, 7956.57, -2784.53, 1145.02, ''),(30316, 6, 8001.6, -2741.81, 1147.89, ''),
(30316, 7, 8032.4, -2723.34, 1147.58, ''),(30316, 8, 7992.2, -2727.98, 1141.51, '');
DELETE FROM creature_text WHERE entry=30313;
INSERT INTO creature_text VALUES
(30313, 1, 0, 'Temple of Invention analysis commencing.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 2, 0, 'Temple of Invention verified to be in-tact.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 3, 0, 'Mechanical servants appear to have turned against each other. Several attendants have been piled together in an unorganized manner.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 4, 0, 'Remaining mechagnome guardians corrupted by unknown source.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 5, 0, 'Watcher Mimir verified to no longer be present. Analysis complete.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 6, 0, 'Temple of Winter analysis commencing.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 7, 0, 'Temple of Winter verified to be in-tact.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 8, 0, 'Temple guardians verified to be deceased. Sulfurous odor suggests that death resulted from a fire-base entity.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 9, 0, 'Previously established cold weather patterns at the temple have ceased.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 10, 0, 'Watcher Hodir verified to no longer be present. Analysis complete.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 11, 0, 'Temple of Life analysis commencing.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 12, 0, 'Temple of Life verified to be damaged beyond repair.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 13, 0, 'Evidence indicates a significant battle. The opponent of Watcher Freya estimated to be of similar size and strength to Watcher Freya.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 14, 0, 'Temple guardians are no longer present. Plant forms associated with temple are deceased.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 15, 0, 'Watcher Freya verified to no longer be present. Analysis complete.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 16, 0, 'Temple of Order analysis commencing.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 17, 0, 'Temple of Order verified to be in-tact.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 18, 0, 'No indications of struggle are present. No guardians are present.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank'),
(30313, 19, 0, 'Watcher Tyr verified to no longer be present. Analysis complete.', 12, 0, 100, 0, 0, 0, 0, 'Mobile databank');

-- The Lonesome Watcher (12877)
UPDATE creature SET position_z=909.548 WHERE id=30052;
DELETE FROM creature WHERE id=29751;
INSERT INTO creature VALUES (42889, 29751, 571, 1, 1, 26497, 0, 6951.327, 46.35645, 795.0692, 2.670354, 300, 0, 0, 0, 0, 0, 2, 537165888, 8);
REPLACE INTO creature_template_addon VALUES (29751, 0, 0, 3, 1, 0, '51329');
UPDATE creature_template SET faction=14, AIName='SmartAI', InhabitType=1 WHERE entry=29862;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5173 AND SourceId=2;
INSERT INTO conditions VALUES (22, 1, 5173, 2, 0, 29, 0, 29862, 60, 0, 1, 0, 0, '', 'Areatrigger Alow to summon Stormforged Monitor if there isn not any');
INSERT INTO conditions VALUES (22, 1, 5173, 2, 0, 9, 0, 12877, 0, 0, 0, 0, 0, '', 'Areatrigger Alow to summon Stormforged Monitor if player is on quest');
INSERT INTO conditions VALUES (22, 1, 5173, 2, 0, 28, 0, 12877, 0, 0, 1, 0, 0, '', 'Areatrigger Alow to summon Stormforged Monitor if player not complete quest');
DELETE FROM smart_scripts WHERE entryorguid=29862 AND source_type=0;
INSERT INTO smart_scripts VALUES (29862, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 40000, 11, 52701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stormforged Monitor - Update - Cast spell 52701 Aura w randomowych odstepach czasu');
INSERT INTO smart_scripts VALUES (29862, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 8000, 10000, 11, 57580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stormforged Monitor - In Combat - Cast spell 57580');
INSERT INTO smart_scripts VALUES (29862, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 97, 10, 20, 0, 0, 0, 0, 8, 0, 0, 0, 6964.48, 20.6733, 805.851, 4.69, 'Stormforged Monitor - Player with quest on areatrigger - Jump down');
REPLACE INTO areatrigger_scripts VALUES (5173, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=5173 and source_type=2;
INSERT INTO smart_scripts VALUES (5173, 2, 0, 0, 46, 0, 100, 0, 5173, 0, 0, 0, 12, 29862, 6, 60000, 0, 0, 0, 8, 0, 0, 0, 6965, 35, 818.3, 4.6, 'Areatrigger 5173 - On Trigger - Summon npc');

-- Pushed Too Far (12869)
UPDATE quest_template SET SourceSpellId=57049 WHERE Id=12869;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.6, spell1=55958, spell2=55936, InhabitType=5, AIName='', ScriptName='' WHERE entry=30108;
REPLACE INTO creature_template_addon VALUES(30108, 0, 0, 50331648, 0, 0, '55971');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(55958, 55936);
INSERT INTO conditions VALUES (17, 0, 55958, 0, 0, 31, 1, 3, 29753, 0, 0, 0, 0, '', "");
INSERT INTO conditions VALUES (17, 0, 55936, 0, 0, 31, 1, 3, 29753, 0, 0, 0, 0, '', "");
DELETE FROM smart_scripts WHERE entryorguid=30108 AND source_type=0;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=29753;
DELETE FROM smart_scripts WHERE entryorguid=29753 AND source_type=0;
INSERT INTO smart_scripts VALUES (29753, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 7000, 7000, 11, 57833, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell on victim');

-- The Earthen Oath (13005)
UPDATE creature_template SET KillCredit1=30296 WHERE entry=29984;
UPDATE creature_template SET KillCredit1=30297 WHERE entry=29978;

-- Fury of the Frostborn King (12879)
DELETE FROM spell_area WHERE spell=55782;
INSERT INTO spell_area VALUES(55782, 4431, 12879, 12973, 0, 0, 2, 1, 74, 1);
INSERT INTO spell_area VALUES(55782, 4432, 12879, 12973, 0, 0, 2, 1, 74, 1);
INSERT INTO spell_area VALUES(55782, 4473, 12879, 12973, 0, 0, 2, 1, 74, 1);
UPDATE creature_template SET faction=1955 WHERE entry IN(30591, 30060);
UPDATE creature_template SET faction=1802 WHERE entry IN(30182, 30065);
UPDATE creature_template SET faction=2108 WHERE entry IN(30063, 30064);
DELETE FROM creature WHERE id IN(30591, 30082, 30182, 30382, 30060, 30063, 30064, 30065, 30383);
INSERT INTO creature VALUES (NULL, 30060, 571, 1, 2, 0, 0, 7233.45, -1126.26, 940.562, 3.82312, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7297.78, -1126.43, 938.438, 2.3505, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7294, -1127.58, 938.395, 2.43297, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7268.08, -1064.25, 941.133, 4.10979, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7255.3, -1066.41, 941.354, 4.98944, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7271.73, -970.641, 920.127, 0.917146, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7310.03, -1014.95, 913.544, 3.90951, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7340.16, -995.363, 908.223, 0.791482, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7349.47, -931.213, 908.672, 2.0866, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7308.32, -907.349, 920.619, 2.60889, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7289.06, -910.385, 924.593, 2.51465, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30060, 571, 1, 2, 0, 0, 7305.28, -892.449, 923.123, 2.42825, 300, 0, 0, 12175, 0, 0, 0, 0, 0),(NULL, 30063, 571, 1, 2, 0, 0, 7341.45, -925.76, 910.76, 5.48345, 300, 0, 0, 75600, 3994, 0, 0, 0, 0),
(NULL, 30063, 571, 1, 2, 0, 0, 7291.59, -1094.6, 938.791, 3.72494, 300, 0, 0, 75600, 3994, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7399.79, -1420.74, 921.217, 1.42293, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7289.24, -1506.65, 921.183, 0.755346, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7234.75, -1356.87, 914.612, 1.00667, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7287.37, -1243.83, 911.653, 0.103466, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7359.92, -1141.48, 907.736, 4.50562, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7453.69, -1192.02, 906.319, 4.10114, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7543.1, -1313.31, 928.074, 2.24446, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7613.54, -1199.52, 924.217, 3.04557, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7332.15, -1045.8, 908.376, 6.24214, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7371.29, -896.195, 911.316, 3.74065, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7444.78, -855.435, 914.079, 3.62676, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7283.46, -958.663, 918.269, 4.47107, 300, 0, 0, 252000, 0, 0, 0, 0, 0),(NULL, 30064, 571, 1, 2, 0, 0, 7348.06, -993.661, 907.403, 1.79286, 300, 0, 0, 252000, 0, 0, 0, 0, 0),
(NULL, 30065, 571, 1, 2, 0, 0, 7273.4, -887.233, 926.089, 5.4646, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7280.55, -880.537, 926.302, 5.4646, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7278.9, -946.518, 919.526, 5.0719, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7269.34, -959.327, 920.279, 6.23821, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7348.25, -928.295, 909.195, 5.73163, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7345.35, -865.466, 924.236, 5.71593, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7267.51, -899.118, 926.417, 5.64524, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7287.7, -873.746, 926.469, 5.43711, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7342.01, -989.925, 907.648, 5.13474, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7350.08, -988.275, 906.641, 4.05482, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7307.26, -1013.7, 914.134, 3.57965, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7306.63, -1023.18, 914.948, 2.64503, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7296.2, -1120.88, 938.196, 5.34522, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7287.17, -1126.52, 938.569, 5.43947, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7256.88, -1069.43, 940.928, 1.84235, 300, 0, 0, 121750, 0, 0, 0, 0, 0),
(NULL, 30065, 571, 1, 2, 0, 0, 7266.8, -1066.69, 941.047, 1.83842, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7214.81, -1155.26, 935.023, 4.17891, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7196.9, -1146, 940.341, 5.05227, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7213.5, -1135.92, 938.378, 0.461616, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7217.81, -1144.61, 936.456, 0.465543, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7338.96, -1090.7, 907.04, 2.00492, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7332.72, -1091.98, 909.707, 1.63971, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30065, 571, 1, 2, 0, 0, 7313.48, -977.635, 912.903, 1.66327, 300, 0, 0, 121750, 0, 0, 0, 0, 0),(NULL, 30082, 571, 1, 2, 0, 0, 7263.44, -873.846, 925.126, 5.43711, 600, 0, 0, 126000, 0, 0, 0, 0, 0),(NULL, 30182, 571, 1, 2, 0, 0, 7276.77, -885.37, 926.248, 5.42925, 300, 0, 0, 630000, 0, 0, 0, 0, 0),(NULL, 30382, 571, 1, 2, 0, 0, 7524.93, -972.161, 478.667, 5.40885, 600, 0, 0, 75600, 0, 0, 0, 0, 0),(NULL, 30383, 571, 1, 2, 0, 0, 7519.56, -973.8, 467.529, 3.67704, 300, 0, 0, 25200, 0, 0, 0, 0, 0),(NULL, 30591, 571, 1, 2, 0, 0, 7340.43, -1085.1, 906.23, 4.40824, 300, 0, 0, 12175, 3893, 0, 0, 0, 0),(NULL, 30591, 571, 1, 2, 0, 0, 7331.17, -1080.68, 909.473, 4.68706, 300, 0, 0, 12175, 3893, 0, 0, 0, 0),(NULL, 30591, 571, 1, 2, 0, 0, 7313.07, -975.323, 913.812, 4.36112, 300, 0, 0, 12175, 3893, 0, 0, 0, 0);

-- Krolmir, Hammer of Storms (13010)
DELETE FROM creature_text WHERE entry IN(30331, 30390);
INSERT INTO creature_text VALUES(30331, 0, 0, "Hold on, little $r.", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 1, 0, "Thorim! Come, show yourself! ", 14, 0, 100, 5, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 2, 0, "The deeds of your $r servant defy $g his:her; stature, Stormlord. $g His:Her; efforts have succeeded in softening the hearts of my people. ", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 3, 0, "Never have such humble words come from mighty Thorim. I shall deliver your words to Dun Niffelem.", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 4, 0, "The events of that dark day are hereby forgiven by my people. They shall never again be spoken of.", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 5, 0, "To signify our reforged friendship, I have something which belongs to you...", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 6, 0, "As the great explosion filled the region, my father cast a rune at the great hammer that it might not be had by our enemies. It was his final act...", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 7, 0, "We welcome the opportunity to fight by your side, mighty Thorim.", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30331, 8, 0, "I must return to Dun Niffelem. We shall speak again soon, Stormlord.", 12, 0, 100, 0, 0, 0, 0, 'King Jokkum');
INSERT INTO creature_text VALUES(30390, 0, 0, "King Jokkum, you have summoned me?", 12, 0, 100, 0, 0, 0, 0, 'Thorim');
INSERT INTO creature_text VALUES(30390, 1, 0, "Jokkum, son of Arngrim, I have always regretted my actions here. In my grief, I brought great harm to those closest to me.", 12, 0, 100, 0, 0, 0, 0, 'Thorim');
INSERT INTO creature_text VALUES(30390, 2, 0, "I would ask your forgiveness for the suffering I have caused you and your people.", 12, 0, 100, 0, 0, 0, 0, 'Thorim');
INSERT INTO creature_text VALUES(30390, 3, 0, "Krolmir... I thank you Jokkum. I hadn't dared hope it still existed. It shall soon see glorious battle once again!", 12, 0, 100, 0, 0, 0, 0, 'Thorim');
REPLACE INTO npc_spellclick_spells VALUES (30393, 46598, 1, 0);
REPLACE INTO vehicle_template_accessory VALUES (30393, 30390, 0, 0, 'Thorim', 4, 180000);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9900;
INSERT INTO conditions VALUES (15, 9900, 0, 0, 0, 9, 0, 13010, 0, 0, 0, 0, 0, '', 'Requires Quest 13010 active');
REPLACE INTO gossip_menu VALUES(9899, 13749);
DELETE FROM gossip_menu_option WHERE menu_id IN(9900, 9899);
INSERT INTO gossip_menu_option VALUES (9900, 0, 0, "If it please you, King Jokkum, may I know what has become of Krolmir?" , 1, 1, 9899, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9899, 0, 0, "I am ready to be shown the fate of Krolmir.", 1, 1, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(30327, 0, 0, 0, 0, 0, '56644');
REPLACE INTO creature_template_addon VALUES(30393, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET modelid1=11686, modelid2=0, unit_flags=33554432, flags_extra=130 WHERE entry=30327;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(30105, 30331, 30390);
UPDATE creature_template SET speed_run=2 WHERE entry=30331;
UPDATE creature_template SET unit_flags=256+512, InhabitType=4 WHERE entry=30393;
UPDATE creature_template SET npcflag=2 WHERE entry=30390;
DELETE FROM smart_scripts WHERE entryorguid IN(30105, 30331, 30390) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(30331*100, 30390*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (30390, 0, 0, 0, 37, 0, 100, 1, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thorim - On Respawn - Set NPC Flags');
INSERT INTO smart_scripts VALUES (30105, 0, 0, 1, 62, 0, 100, 0, 9899, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (30105, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56541, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Cast');
INSERT INTO smart_scripts VALUES (30331, 0, 0, 1, 60, 0, 100, 1, 500, 500, 0, 0, 53, 1, 30331, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Update - Start WP');
INSERT INTO smart_scripts VALUES (30331, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 86, 56606, 2, 12, 0xFFFFFF, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cross Cast');
INSERT INTO smart_scripts VALUES (30331, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (30331, 0, 3, 4, 40, 0, 100, 0, 30, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove All Auras');
INSERT INTO smart_scripts VALUES (30331, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 30331*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Script9');
INSERT INTO smart_scripts VALUES (30331, 0, 5, 0, 40, 0, 100, 0, 1, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Faction');
INSERT INTO smart_scripts VALUES (30331*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (30331*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 30393, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 7955, -3254.54, 891, 3.14, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (30331*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 130, 0, 0, 0, 0, 0, 0, 19, 30393, 100, 0, 7900, -3254.54, 891.58, 3.14, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (30331*100, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 30390, 100, 0, 0, 0, 0, 0, 'Script9 - Store Target');
INSERT INTO smart_scripts VALUES (30331*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 19, 30393, 100, 0, 0, 0, 0, 0, 'Script9 - Remove Aura');
INSERT INTO smart_scripts VALUES (30331*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 97, 20, 30, 0, 0, 0, 0, 12, 1, 0, 0, 7895, -3254.54, 851.1, 3.14, 'Script9 - Jump To Pos Target');
INSERT INTO smart_scripts VALUES (30331*100, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 130, 0, 0, 0, 0, 0, 0, 19, 30393, 100, 0, 7893, -3413, 891, 4.8, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (30331*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 1');
INSERT INTO smart_scripts VALUES (30331*100, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 11, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 12, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 13, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 14, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 1');
INSERT INTO smart_scripts VALUES (30331*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 16, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 50, 192492, 120, 0, 0, 0, 0, 8, 0, 0, 0, 7880.78, -3268.51, 856.176, 3.14, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (30331*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 30327, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 7879.4, -3267.8, 851.41, 3.14, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (30331*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 19, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 20, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 21, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 22, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (30331*100, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 30327, 0, 0, 0, 0, 0, 18, 70, 0, 0, 0, 0, 0, 0, 'Script9 - Kill Credit');
INSERT INTO smart_scripts VALUES (30331*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (30331*100, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
DELETE FROM waypoints WHERE entry=30331;
INSERT INTO waypoints VALUES (30331, 1, 7349.03, -2833.16, 800.433, 'King Jokkum'),(30331, 2, 7351.01, -2853.08, 800.752, 'King Jokkum'),(30331, 3, 7353.05, -2873.68, 806.838, 'King Jokkum'),(30331, 4, 7354.21, -2885.31, 814.327, 'King Jokkum'),(30331, 5, 7355.82, -2901.55, 820.309, 'King Jokkum'),(30331, 6, 7357.89, -2922.45, 824.014, 'King Jokkum'),(30331, 7, 7359.96, -2943.31, 831.832, 'King Jokkum'),(30331, 8, 7357.76, -2967.97, 842.796, 'King Jokkum'),(30331, 9, 7358.22, -2972.57, 844.499, 'King Jokkum'),(30331, 10, 7360.99, -3000.43, 845.794, 'King Jokkum'),(30331, 11, 7375.28, -3020.37, 843.894, 'King Jokkum'),(30331, 12, 7413.52, -3026.22, 843.36, 'King Jokkum'),(30331, 13, 7447.71, -3037.35, 840.512, 'King Jokkum'),
(30331, 14, 7470.03, -3056.39, 837.455, 'King Jokkum'),(30331, 15, 7498.52, -3080.69, 838.94, 'King Jokkum'),(30331, 16, 7524.46, -3102.81, 841.3, 'King Jokkum'),(30331, 17, 7559.62, -3132.79, 843.581, 'King Jokkum'),(30331, 18, 7585.34, -3154.72, 848.502, 'King Jokkum'),(30331, 19, 7616.95, -3181.68, 851.89, 'King Jokkum'),(30331, 20, 7634.79, -3196.89, 857.684, 'King Jokkum'),(30331, 21, 7658.75, -3199.95, 863.091, 'King Jokkum'),(30331, 22, 7683.63, -3207.91, 867.18, 'King Jokkum'),(30331, 23, 7704.78, -3225.94, 864.689, 'King Jokkum'),(30331, 24, 7738.87, -3228.98, 861.609, 'King Jokkum'),(30331, 25, 7761.33, -3223.75, 864.271, 'King Jokkum'),(30331, 26, 7789.46, -3225.95, 860.885, 'King Jokkum'),
(30331, 27, 7810.3, -3224.93, 858.222, 'King Jokkum'),(30331, 28, 7823.98, -3227.92, 857.631, 'King Jokkum'),(30331, 29, 7841.33, -3239.76, 853.416, 'King Jokkum'),(30331, 30, 7862.19, -3254.54, 850.65, 'King Jokkum');
-- TC
DELETE FROM spell_script_names WHERE ScriptName='spell_veranus_summon' AND spell_id=56650;
DELETE FROM spell_script_names WHERE ScriptName='spell_jokkum_scriptcast' AND spell_id=61319;

-- A Delicate Touch (12820)
-- Overstock (12833)
UPDATE creature_template SET flags_extra=flags_extra|64 WHERE entry IN(29618, 29619);
UPDATE creature_template SET unit_flags=unit_flags|4, AIName='SmartAI' WHERE entry=29475;
DELETE FROM smart_scripts WHERE entryorguid=29475 AND source_type=0;
INSERT INTO smart_scripts VALUES (29475, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Move Idle');
INSERT INTO smart_scripts VALUES (29475, 0, 1, 2, 60, 0, 100, 0, 0, 0, 1000, 1000, 11, 54537, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell Detonation');
INSERT INTO smart_scripts VALUES (29475, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn');
INSERT INTO smart_scripts VALUES (29475, 0, 3, 0, 5, 0, 100, 0, 0, 0, 0, 29618, 33, 29618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Kill - Kill Credit');
INSERT INTO smart_scripts VALUES (29475, 0, 4, 0, 5, 0, 100, 0, 0, 0, 0, 29619, 33, 29618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Kill - Kill Credit');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND sourceEntry=29475;
INSERT INTO conditions VALUES(22, 2, 29475, 0, 0, 29, 1, 29618, 3, 0, 0, 0, 0, "", "Run Action if NPC Near");
INSERT INTO conditions VALUES(22, 2, 29475, 0, 1, 29, 1, 29619, 3, 0, 0, 0, 0, "", "Run Action if NPC Near");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=54537;
INSERT INTO conditions VALUES (13, 1, 54537, 0, 0, 31, 0, 3, 29619, 0, 0, 0, 0, '', 'Target Garm Invader');
INSERT INTO conditions VALUES (13, 1, 54537, 0, 1, 31, 0, 3, 29618, 0, 0, 0, 0, '', 'Target Snowblind Follower');

-- Thrusting Hodir's Spear (13003)
DELETE FROM creature_text WHERE entry=30275;
INSERT INTO creature_text VALUES (30275, 0, 0, "Wild Wyrm swipes at you with his claws!", 41, 0, 100, 0, 0, 0, 0, 'Wild Wyrm');
INSERT INTO creature_text VALUES (30275, 1, 0, "DODGED!", 41, 0, 100, 0, 0, 0, 0, 'Wild Wyrm');
INSERT INTO creature_text VALUES (30275, 2, 0, "FATAL STRIKE MISSED!", 41, 0, 100, 0, 0, 0, 0, 'Wild Wyrm');
INSERT INTO creature_text VALUES (30275, 3, 0, "Wild Wyrm shrieks in pain and twists around, grabbing you with his mouth!", 41, 0, 100, 0, 0, 0, 0, 'Wild Wyrm');
UPDATE creature_template SET unit_flags=0, spell1=60533, spell2=56704, spell3=56690, spell4=60586, spell5=56706, spell6=60587, Armor_mod=0, AIName='', ScriptName='npc_wild_wyrm' WHERE entry=30275;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=56671;
INSERT INTO conditions VALUES (17, 0, 56671, 0, 0, 1, 1, 56673, 0, 0, 1, 12, 0, '', 'Requires No Vehicle aura');
INSERT INTO conditions VALUES (17, 0, 56671, 0, 0, 31, 1, 3, 30275, 0, 0, 12, 0, '', 'Requires Wild Wyrm');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(56673, 60863, 60810, 60713);
INSERT INTO conditions VALUES (13, 1, 56673, 0, 0, 31, 0, 3, 30275, 0, 0, 0, 0, '', 'Target Wild Wyrm');
INSERT INTO conditions VALUES (13, 1, 60863, 0, 0, 31, 0, 3, 30275, 0, 0, 0, 0, '', 'Target Wild Wyrm');
INSERT INTO conditions VALUES (13, 1, 60810, 0, 0, 31, 0, 3, 30275, 0, 0, 0, 0, '', 'Target Wild Wyrm');
INSERT INTO conditions VALUES (13, 1, 60713, 0, 0, 31, 0, 3, 30275, 0, 0, 0, 0, '', 'Target Wild Wyrm');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=21 AND SourceGroup=30275;
INSERT INTO conditions VALUES (21, 30275, 60533, 0, 0, 38, 1, 50, 1, 0, 0, 0, 0, '', 'More than 50% HP');
INSERT INTO conditions VALUES (21, 30275, 56704, 0, 0, 38, 1, 50, 1, 0, 0, 0, 0, '', 'More than 50% HP');
INSERT INTO conditions VALUES (21, 30275, 56690, 0, 0, 38, 1, 50, 1, 0, 0, 0, 0, '', 'More than 50% HP');
INSERT INTO conditions VALUES (21, 30275, 60586, 0, 0, 38, 1, 50, 1, 0, 0, 0, 0, '', 'More than 50% HP');
INSERT INTO conditions VALUES (21, 30275, 56706, 0, 0, 38, 1, 50, 1, 0, 1, 0, 0, '', 'LEQ than 50% HP');
INSERT INTO conditions VALUES (21, 30275, 60587, 0, 0, 38, 1, 50, 1, 0, 1, 0, 0, '', 'LEQ than 50% HP');
DELETE FROM spell_script_names WHERE spell_id=56689;
INSERT INTO spell_script_names VALUES(56689, "spell_q13003_thursting_hodirs_spear");
DELETE FROM spell_script_names WHERE spell_id=60864;
INSERT INTO spell_script_names VALUES(60864, "spell_gen_default_count_pct_from_max_hp");

-- The Brothers Bronzebeard (12973)
DELETE FROM creature WHERE id=30401;
INSERT INTO creature VALUES (NULL, 30401, 571, 1, 1, 0, 1, 6718.64, -258.001, 949.333, 2.85367, 300, 0, 0, 63000, 0, 0, 0, 0, 0);
DELETE FROM creature_questender WHERE quest=12973;
INSERT INTO creature_questender VALUES (30401, 12973);
DELETE FROM spell_area WHERE spell=55783;
INSERT INTO spell_area VALUES(55783, 4431, 12973, 0, 0, 0, 2, 1, 8, 0);
INSERT INTO spell_area VALUES(55783, 4432, 12973, 0, 0, 0, 2, 1, 8, 0);
INSERT INTO spell_area VALUES(55783, 4428, 12973, 0, 0, 0, 2, 1, 8, 0);
-- Quest giver brann
UPDATE quest_template SET NextQuestIdChain=12973 WHERE Id=12880;
UPDATE quest_template SET PrevQuestId=12880 WHERE Id=12973;
DELETE FROM spell_target_position WHERE id IN(56558, 56675);
INSERT INTO spell_target_position VALUES (56558, 0, 571, 7517.25, -975.84, 477.41, 3.34);
INSERT INTO spell_target_position VALUES (56675, 0, 571, 6719.54, -300.165, 992.49, 3.21);
UPDATE creature SET phaseMask=6 WHERE id IN(30382, 30384);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=30382;
UPDATE creature_template SET InhabitType=4 WHERE entry=30383;
UPDATE creature_template SET InhabitType=4, flags_extra=130 WHERE entry=30384;
DELETE FROM smart_scripts WHERE entryorguid=30382 AND source_type=0;
INSERT INTO smart_scripts VALUES (30382, 0, 0, 1, 19, 0, 100, 0, 12973, 0, 0, 0, 11, 56558, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Quest Accept - Cast Spell");
INSERT INTO smart_scripts VALUES (30382, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Quest Accept - Despawn Self");
INSERT INTO smart_scripts VALUES (30382, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 19, 30383, 40, 0, 0, 0, 0, 0, "On Quest Accept - Despawn Target");
-- Flier Brann
UPDATE creature_template SET AIName='NullCreatureAI' WHERE entry=30107;
DELETE FROM creature_text WHERE entry=30107;
INSERT INTO creature_text VALUES (30107, 0, 0, "I can't thank you enough for all of your help in putting together the keystone. Great things will come of this, I assure you.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 1, 0, "Iron dwarves... everywhere.... they're making their way down from the top. They certainly are persistent.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 2, 0, "They're trying to take down the plane! I can't pull up any steeper... you need to keep them off of us!", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 3, 0, "There are more just ahead - keep at it!", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 4, 0, "We're almost out... just a little bit further.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 5, 0, "Barring stray boulders from those giants, we should be clear... it seems a mess from down there though.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 6, 0, "Their numbers are unbelievable... I'm glad to hear King Stormheart came to your aid. I only hear good things of him - I think it's high time we meet.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 7, 0, "Poor Creteus. He was a good keeper... I'm glad he at least got to see his task to completion, I imagine that's all that really mattered to him.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30107, 8, 0, "We're coming up on Frosthold. I would be very appreciative if you would introduce me to King Stormeheart before you go. I believe we are both very much in his debt.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
-- Brann's Flying Machine
DELETE FROM waypoints WHERE entry=30134;
INSERT INTO waypoints VALUES (30134, 1, 7497.65, -980.435, 473.414, 'Branns Flying Machine'),(30134, 2, 7468.51, -1017.32, 479.378, 'Branns Flying Machine'),(30134, 3, 7473.77, -1060.9, 489.051, 'Branns Flying Machine'),(30134, 4, 7525.15, -1085.14, 499.933, 'Branns Flying Machine'),(30134, 5, 7559.02, -1067.42, 508.719, 'Branns Flying Machine'),(30134, 6, 7556.88, -1013.91, 522.408, 'Branns Flying Machine'),(30134, 7, 7534.64, -983.899, 529.489, 'Branns Flying Machine'),(30134, 8, 7490.75, -975.614, 536.767, 'Branns Flying Machine'),(30134, 9, 7458.98, -998.008, 542.015, 'Branns Flying Machine'),(30134, 10, 7454.43, -1046.19, 548.909, 'Branns Flying Machine'),(30134, 11, 7460.07, -1079.98, 554.021, 'Branns Flying Machine'),(30134, 12, 7496.17, -1094.8, 562.659, 'Branns Flying Machine'),(30134, 13, 7537.47, -1084.87, 574.044, 'Branns Flying Machine'),(30134, 14, 7569.92, -1058.31, 581.427, 'Branns Flying Machine'),(30134, 15, 7568.27, -1007.72, 594.344, 'Branns Flying Machine'),(30134, 16, 7534.98, -978.128, 606.208, 'Branns Flying Machine'),(30134, 17, 7481.8, -981.661, 613.507, 'Branns Flying Machine'),(30134, 18, 7445.26, -1035.03, 620.37, 'Branns Flying Machine'),(30134, 19, 7458.75, -1086.83, 630.151, 'Branns Flying Machine'),
(30134, 20, 7512.55, -1094.28, 639.85, 'Branns Flying Machine'),(30134, 21, 7549.81, -1059.38, 650.64, 'Branns Flying Machine'),(30134, 22, 7535.99, -1011.53, 664.341, 'Branns Flying Machine'),(30134, 23, 7491.93, -996.384, 677.549, 'Branns Flying Machine'),(30134, 24, 7444.83, -1034.38, 697.835, 'Branns Flying Machine'),(30134, 25, 7448.86, -1081.22, 714.713, 'Branns Flying Machine'),(30134, 26, 7486.54, -1096.27, 732.199, 'Branns Flying Machine'),(30134, 27, 7532.65, -1085.87, 742.051, 'Branns Flying Machine'),(30134, 28, 7572.81, -1041.37, 744.878, 'Branns Flying Machine'),(30134, 29, 7555.37, -1001.91, 746.373, 'Branns Flying Machine'),(30134, 30, 7529.05, -953.339, 747.291, 'Branns Flying Machine'),(30134, 31, 7488.81, -942.232, 748.586, 'Branns Flying Machine'),(30134, 32, 7453.86, -954.213, 750.528, 'Branns Flying Machine'),(30134, 33, 7422.35, -991.457, 755.353, 'Branns Flying Machine'),(30134, 34, 7422.62, -1037.84, 758.558, 'Branns Flying Machine'),(30134, 35, 7446.35, -1089.45, 770.271, 'Branns Flying Machine'),(30134, 36, 7500.88, -1105.16, 790.084, 'Branns Flying Machine'),(30134, 37, 7543.18, -1089.59, 805.28, 'Branns Flying Machine'),(30134, 38, 7577.29, -1036.76, 828.546, 'Branns Flying Machine'),(30134, 39, 7565.69, -990.835, 844.253, 'Branns Flying Machine'),(30134, 40, 7536.61, -958.824, 853.587, 'Branns Flying Machine'),(30134, 41, 7488.98, -947.886, 866.701, 'Branns Flying Machine'),
(30134, 42, 7441.53, -976.699, 884.027, 'Branns Flying Machine'),(30134, 43, 7412.03, -1020.32, 901.404, 'Branns Flying Machine'),(30134, 44, 7411.37, -1060.42, 909.054, 'Branns Flying Machine'),(30134, 45, 7466.48, -1113.41, 921.955, 'Branns Flying Machine'),(30134, 46, 7512.44, -1134.34, 930.44, 'Branns Flying Machine'),(30134, 47, 7551.88, -1164.28, 947.309, 'Branns Flying Machine'),(30134, 48, 7562.43, -1217.87, 975.279, 'Branns Flying Machine'),(30134, 49, 7549.23, -1261.85, 974.489, 'Branns Flying Machine'),(30134, 50, 7512.54, -1296.45, 975.61, 'Branns Flying Machine'),(30134, 51, 7463.49, -1308.57, 975.33, 'Branns Flying Machine'),(30134, 52, 7414.94, -1271.06, 975.11, 'Branns Flying Machine'),(30134, 53, 7362.76, -1191.58, 975.35, 'Branns Flying Machine'),(30134, 54, 7342.27, -1124.72, 975.84, 'Branns Flying Machine'),(30134, 55, 7315.89, -1023.21, 975.24, 'Branns Flying Machine'),(30134, 56, 7296.11, -956.256, 975.61, 'Branns Flying Machine'),(30134, 57, 7254.16, -862.892, 975.247, 'Branns Flying Machine'),(30134, 58, 7236.03, -832.985, 980.102, 'Branns Flying Machine'),(30134, 59, 7170.3, -754.717, 984.533, 'Branns Flying Machine'),(30134, 60, 7123.3, -700.775, 987.96, 'Branns Flying Machine'),(30134, 61, 7108.32, -646.284, 980.958, 'Branns Flying Machine'),
(30134, 62, 7104.87, -577.719, 979.119, 'Branns Flying Machine'),(30134, 63, 7107.84, -508.532, 989.094, 'Branns Flying Machine'),(30134, 64, 7105.65, -430.88, 1001.47, 'Branns Flying Machine'),(30134, 65, 7069.44, -374.405, 1002.83, 'Branns Flying Machine'),(30134, 66, 7015.51, -335.915, 1001.89, 'Branns Flying Machine'),(30134, 67, 6968.51, -318.774, 1001.69, 'Branns Flying Machine'),(30134, 68, 6899.87, -305.206, 1001.71, 'Branns Flying Machine'),(30134, 69, 6841.93, -298.241, 1003.14, 'Branns Flying Machine'),(30134, 70, 6794.33, -293.982, 1004.08, 'Branns Flying Machine'),(30134, 71, 6764.33, -294.547, 1000.36, 'Branns Flying Machine'),(30134, 72, 6730.7, -295.273, 997.037, 'Branns Flying Machine');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=30134;
INSERT INTO conditions VALUES (18, 30134, 56603, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Only Player Can cast this spell');
INSERT INTO conditions VALUES (18, 30134, 55089, 0, 0, 31, 0, 3, 30136, 0, 0, 0, 0, '', 'Only Npc 30136 Can cast this spell');
INSERT INTO conditions VALUES (18, 30134, 52391, 0, 0, 31, 0, 3, 30107, 0, 0, 0, 0, '', 'Only Npc 30107 Can cast this spell');
DELETE FROM npc_spellclick_spells WHERE npc_entry=30134;
INSERT INTO npc_spellclick_spells VALUES (30134, 56603, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (30134, 55089, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (30134, 52391, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry=30134;
INSERT INTO vehicle_template_accessory VALUES (30134, 30107, 0, 1, 'Brann Bronzebeard', 8, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=30134;
INSERT INTO conditions VALUES (22, 1, 30134, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Only Player Can run this action');
INSERT INTO conditions VALUES (22, 2, 30134, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Only Player Can run this action');
UPDATE creature_template SET npcflag=16777216, speed_run=2.5, InhabitType=4, VehicleId=219, RegenHealth=0, AIName='SmartAI', ScriptName='', flags_extra=2 WHERE entry=30134;
DELETE FROM smart_scripts WHERE entryorguid=30134 AND source_type=0;
INSERT INTO smart_scripts VALUES (30134, 0, 0, 13, 27, 0, 100, 0, 0, 0, 0, 0, 53, 1, 30134, 0, 0, 500, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Passenger Board - Start WP");
INSERT INTO smart_scripts VALUES (30134, 0, 1, 0, 28, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Passenger Remove - Despawn");
INSERT INTO smart_scripts VALUES (30134, 0, 2, 0, 40, 0, 100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 3, 0, 40, 0, 100, 0, 8, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 4, 0, 40, 0, 100, 0, 16, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 5, 0, 40, 0, 100, 0, 22, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 6, 0, 40, 0, 100, 0, 37, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 7, 0, 40, 0, 100, 0, 47, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 8, 0, 40, 0, 100, 0, 53, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 9, 0, 40, 0, 100, 0, 57, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 10, 0, 40, 0, 100, 0, 65, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 19, 30107, 5, 0, 0, 0, 0, 0, "On WP Reached - Talk Target");
INSERT INTO smart_scripts VALUES (30134, 0, 11, 12, 40, 0, 100, 0, 72, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On WP Reached - Remove All Auras");
INSERT INTO smart_scripts VALUES (30134, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56675, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On WP Reached - Cast Spell Summon Brann Bronzebeard");
INSERT INTO smart_scripts VALUES (30134, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Passenger Board - Set Unit Flag");
INSERT INTO smart_scripts VALUES (30134, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Passenger Board - Remove Auto Attack");
INSERT INTO smart_scripts VALUES (30134, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Passenger Board - Set Phase Mask");
-- Stormforged Soldier 30136
REPLACE INTO creature_template_addon VALUES (30493, 0, 0, 7, 0, 0, '');
DELETE FROM creature WHERE id IN(30136, 30502, 30493);
INSERT INTO creature VALUES (NULL, 30136, 571, 1, 4, 0, 1, 7577.96, -1089.04, 595.712, 2.5094, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7588.95, -1075.55, 595.591, 2.52903, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7590.61, -1058.82, 595.224, 2.81178, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7597.35, -1042.56, 595.258, 2.86675, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7592.71, -1028.92, 593.967, 3.11415, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7592.48, -1013.73, 596.307, 3.16128, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7580.19, -984.218, 594.465, 3.83279, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7566.8, -968.037, 596.475, 3.83279, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7553.66, -957.648, 595.392, 3.83279, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7528.07, -944.761, 595.903, 4.91271, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7490.36, -946.306, 595.979, 5.25829, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7451.34, -957.392, 593.941, 5.16404, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7428.01, -992.105, 595.917, 5.77272, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7422.12, -1028.95, 593.946, 0.145337, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7424.41, -1053.53, 593.948, 0.113921, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7435.91, -1090.7, 595.693, 0.915027, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7464.31, -1116.75, 595.558, 1.22561, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7494.48, -1123.3, 595.231, 1.43374, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7485.42, -968.004, 683.069, 4.8895, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
(NULL, 30136, 571, 1, 4, 0, 1, 7467.03, -971.301, 683.584, 5.12119, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7450.23, -985.747, 683.834, 5.40393, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7433.32, -1001.88, 686.65, 5.51781, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7425.26, -1028.32, 692.26, 6.0833, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7416.57, -1048.7, 698.723, 6.16969, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7426.15, -1079.31, 705.743, 0.667974, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7447.33, -1106.22, 715.154, 0.97035, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7467.54, -1120.78, 722.946, 1.24524, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7499.58, -1132.08, 727.9, 1.42981, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7568.86, -1103.6, 727.882, 2.34481, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7580.73, -1077.43, 722.324, 2.66682, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7593.36, -1059.26, 720.879, 2.926, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7596.45, -1038.56, 715.531, 3.00454, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7592.48, -1014.72, 709.058, 3.55039, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7578.22, -1003.47, 702.612, 3.67606, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7568, -977.847, 698.303, 4.06483, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7544.49, -971.66, 690.782, 4.35935, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7513.78, -958.984, 685.534, 4.63817, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7510.35, -943.008, 793.578, 4.85416, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
(NULL, 30136, 571, 1, 4, 0, 1, 7544.21, -941.458, 791.725, 4.49287, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7482.81, -953.955, 792.956, 5.22329, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7451.21, -986.366, 791.475, 5.60814, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7422.94, -1009.92, 794.067, 5.39215, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7422.26, -1039.46, 791.523, 6.03617, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7407.53, -1068.8, 792.261, 6.27572, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7413.84, -1092.65, 792.629, 0.118195, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7422.99, -1112.05, 791.466, 6.14613, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7433.96, -1136.9, 792.086, 0.432353, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7471.21, -932.167, 871.99, 5.1683, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7459.74, -937.793, 872.317, 5.1683, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7430.89, -1122.77, 876.912, 0.675825, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7446.59, -1135.73, 873.659, 0.648336, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7523.03, -1134.86, 912.06, 2.06598, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7537.47, -1139.54, 912.334, 1.86963, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7539.28, -1130.6, 912.21, 1.88141, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7557.85, -1119.71, 912.098, 1.88141, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7589.68, -956.179, 912.519, 4.14336, 300, 0, 0, 5885, 0, 0, 0, 0, 0),
(NULL, 30136, 571, 1, 4, 0, 1, 7582.53, -949.392, 909.829, 4.00592, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7568.01, -947.37, 914.841, 4.07267, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7554.92, -937.633, 909.356, 4.07267, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7517.73, -937.759, 538.641, 4.8931, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7503.1, -941.551, 538.637, 5.10908, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7485.82, -943.184, 538.617, 5.23475, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7469.88, -963.062, 538.675, 5.329, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7442.67, -972.118, 538.613, 5.53712, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7438.33, -989.91, 538.669, 5.58032, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7419.12, -1009.96, 538.636, 5.94553, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7416.45, -1038.02, 538.682, 6.26754, 300, 0, 0, 6088, 0, 0, 0, 0, 0),
(NULL, 30136, 571, 1, 4, 0, 1, 7282.26, -904.971, 926.307, 5.32694, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7274.92, -910.591, 926.671, 5.36621, 300, 0, 0, 5885, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7271.73, -906.427, 927.135, 5.36621, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7275.44, -903.582, 926.956, 5.36621, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7278.30, -907.74, 926.65, 5.4, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30136, 571, 1, 4, 0, 1, 7278.83, -901.031, 927.033, 5.41727, 300, 0, 0, 6088, 0, 0, 0, 0, 0),(NULL, 30493, 571, 1, 4, 0, 0, 7263.75, -873.436, 925.182, 5.49192, 300, 0, 0, 126000, 0, 0, 0, 0, 32),(NULL, 30502, 571, 1, 4, 0, 0, 7570.4, -1228.54, 919.677, 3.20638, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7383.41, -1148.84, 903.591, 4.97745, 300, 0, 0, 50400, 0, 0, 0, 0, 0),
(NULL, 30502, 571, 1, 4, 0, 0, 7450.73, -1257.56, 908.329, 1.02689, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7297, -1114.82, 938.258, 5.92778, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7336.8, -1017.38, 907.688, 2.49166, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7278.25, -984.53, 918.99, 5.55079, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7254.86, -874.686, 924.123, 6.22622, 300, 0, 0, 50400, 0, 0, 0, 0, 0),(NULL, 30502, 571, 1, 4, 0, 0, 7267.49, -863.623, 926.054, 4.49835, 300, 0, 0, 50400, 0, 0, 0, 0, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(56621, 56622);
INSERT INTO conditions VALUES (13, 1, 56621, 0, 0, 31, 0, 3, 30134, 0, 0, 0, 0, '', 'Target Branns Flying Machine');
INSERT INTO conditions VALUES (13, 1, 56622, 0, 0, 31, 0, 3, 30134, 0, 0, 0, 0, '', 'Target Branns Flying Machine');
UPDATE creature_template SET faction=14, flags_extra=64, AIName='', ScriptName='' WHERE entry=30502;
UPDATE creature_template SET faction=14, unit_flags=unit_flags|4, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=30136;
DELETE FROM smart_scripts WHERE entryorguid=30136 AND source_type=0;
INSERT INTO smart_scripts VALUES (30136, 0, 1, 0, 10, 0, 100, 0, 0, 100, 10000, 10000, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On OOC Los - Attack Start");
INSERT INTO smart_scripts VALUES (30136, 0, 2, 0, 0, 0, 100, 1, 0, 500, 0, 0, 11, 56621, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On IC Update - Cast Spell");
INSERT INTO smart_scripts VALUES (30136, 0, 3, 0, 0, 0, 100, 0, 1000, 3000, 2000, 5000, 11, 56622, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On IC Update - Cast Spell");
INSERT INTO smart_scripts VALUES (30136, 0, 4, 0, 0, 0, 20, 1, 2000, 2000, 60000, 60000, 11, 55089, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "On IC Update - Cast Spell");
-- Reunion Brann
DELETE FROM spell_target_position WHERE id IN(56676, 56697);
INSERT INTO spell_target_position VALUES (56676, 0, 571, 6674.60, -300.56, 989.348, 0.0);
INSERT INTO spell_target_position VALUES (56697, 0, 571, 6640.11, -292.62, 979.51, 0.0);
DELETE FROM creature_queststarter WHERE id=30405;
DELETE FROM creature_questender WHERE id=30405;
UPDATE creature_template SET npcflag=0, AIName='SmartAI', ScriptName='' WHERE entry=30405;
DELETE FROM smart_scripts WHERE entryorguid=30405 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=30405*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (30405, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 11, 56676, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Cast Spell");
INSERT INTO smart_scripts VALUES (30405, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 30405*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Start Script");
INSERT INTO smart_scripts VALUES (30405*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Set Walk");
INSERT INTO smart_scripts VALUES (30405*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6692.69, -300.59, 989.4, 0, "Script9 - Move To Pos");
INSERT INTO smart_scripts VALUES (30405*100, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 0");
INSERT INTO smart_scripts VALUES (30405*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 30408, 10, 0, 0, 0, 0, 0, "Script9 - Store Target");
INSERT INTO smart_scripts VALUES (30405*100, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 0");
INSERT INTO smart_scripts VALUES (30405*100, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 1");
INSERT INTO smart_scripts VALUES (30405*100, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 1");
INSERT INTO smart_scripts VALUES (30405*100, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 2");
INSERT INTO smart_scripts VALUES (30405*100, 9, 8, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 3");
INSERT INTO smart_scripts VALUES (30405*100, 9, 9, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 2");
INSERT INTO smart_scripts VALUES (30405*100, 9, 10, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 4");
INSERT INTO smart_scripts VALUES (30405*100, 9, 11, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 5");
INSERT INTO smart_scripts VALUES (30405*100, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 3");
INSERT INTO smart_scripts VALUES (30405*100, 9, 13, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 4");
INSERT INTO smart_scripts VALUES (30405*100, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 56697, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Cast Spell Summon Magni");
INSERT INTO smart_scripts VALUES (30405*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 19, 30411, 100, 0, 0, 0, 0, 0, "Script9 - Store Target");
INSERT INTO smart_scripts VALUES (30405*100, 9, 16, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 0");
INSERT INTO smart_scripts VALUES (30405*100, 9, 17, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 18, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 5");
INSERT INTO smart_scripts VALUES (30405*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Set Orientation");
INSERT INTO smart_scripts VALUES (30405*100, 9, 20, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 1");
INSERT INTO smart_scripts VALUES (30405*100, 9, 21, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 22, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 3, 3, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 25, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 6");
INSERT INTO smart_scripts VALUES (30405*100, 9, 26, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 2");
INSERT INTO smart_scripts VALUES (30405*100, 9, 27, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 7");
INSERT INTO smart_scripts VALUES (30405*100, 9, 28, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 3");
INSERT INTO smart_scripts VALUES (30405*100, 9, 29, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 8");
INSERT INTO smart_scripts VALUES (30405*100, 9, 30, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 9");
INSERT INTO smart_scripts VALUES (30405*100, 9, 31, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 4");
INSERT INTO smart_scripts VALUES (30405*100, 9, 32, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 5");
INSERT INTO smart_scripts VALUES (30405*100, 9, 33, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 10");
INSERT INTO smart_scripts VALUES (30405*100, 9, 34, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 6");
INSERT INTO smart_scripts VALUES (30405*100, 9, 35, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 11, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 11");
INSERT INTO smart_scripts VALUES (30405*100, 9, 36, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 6");
INSERT INTO smart_scripts VALUES (30405*100, 9, 37, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 12, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 12");
INSERT INTO smart_scripts VALUES (30405*100, 9, 38, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 7");
INSERT INTO smart_scripts VALUES (30405*100, 9, 39, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk S 8");
INSERT INTO smart_scripts VALUES (30405*100, 9, 40, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 13, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Talk Y 13");
INSERT INTO smart_scripts VALUES (30405*100, 9, 41, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Y Play Emote");
INSERT INTO smart_scripts VALUES (30405*100, 9, 42, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 45, 4, 4, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "Script9 - Set Data");
INSERT INTO smart_scripts VALUES (30405*100, 9, 43, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - Talk M 7");
INSERT INTO smart_scripts VALUES (30405*100, 9, 44, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 70, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - S Play Emote");
INSERT INTO smart_scripts VALUES (30405*100, 9, 45, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 41, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, "Script9 - M Despawn");
INSERT INTO smart_scripts VALUES (30405*100, 9, 46, 0, 0, 0, 100, 0, 0, 0, 0, 0, 15, 12973, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, "Script9 - Quest Credit");
INSERT INTO smart_scripts VALUES (30405*100, 9, 47, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - S Despawn");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=30408;
UPDATE creature_template SET speed_run=1.8, AIName='SmartAI', ScriptName='' WHERE entry=30411;
DELETE FROM smart_scripts WHERE entryorguid=30408 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=30411 AND source_type=0;
INSERT INTO smart_scripts VALUES (30408, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Set Walk");
INSERT INTO smart_scripts VALUES (30408, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6689.55, -300.58, 989.35, 0, "On Respawn - Set Walk");
INSERT INTO smart_scripts VALUES (30408, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30411, 50, 0, 0, 0, 0, 0, "On Data Set - Set Orientation");
INSERT INTO smart_scripts VALUES (30408, 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30411, 10, 0, 0, 0, 0, 0, "On Data Set - Set Orientation");
INSERT INTO smart_scripts VALUES (30408, 0, 4, 5, 38, 0, 100, 0, 4, 4, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Set Walk");
INSERT INTO smart_scripts VALUES (30408, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Despawn");
INSERT INTO smart_scripts VALUES (30408, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6657.3, -298.03, 987.78, 0, "On Data Set - Move To Pos");
INSERT INTO smart_scripts VALUES (30411, 0, 0, 0, 38, 0, 100, 0, 2, 2, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6691.96, -296.59, 989.16, 0, "On Data Set - Move To Pos");
INSERT INTO smart_scripts VALUES (30411, 0, 1, 0, 38, 0, 100, 0, 3, 3, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30408, 10, 0, 0, 0, 0, 0, "On Data Set - Set Orientation");
INSERT INTO smart_scripts VALUES (30411, 0, 2, 0, 60, 0, 100, 1, 11000, 11000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6663.36, -295.16, 988.0, 0, "On Update - Move To Pos");
DELETE FROM creature_text WHERE entry IN(30405, 30408, 30411);
INSERT INTO creature_text VALUES (30405, 0, 0, "By all the gods... it can't be... Muradin?", 12, 0, 100, 5, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 1, 0, "Come on boy, there's no mistak'n it - it's definately you. Don't ya recognize your younger brother?", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 2, 0, "I can't believe this! You were dead! All accounts said so... what happened, Muradin. How did you get here?", 12, 0, 100, 5, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 3, 0, "Indeed! Magni will be so happy to see you too! He's gotten nothing but bad news for a long time now, but this changes everything!", 12, 0, 100, 5, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 4, 0, "He's here in Northrend, brother, looking for you. A seer in Wintergarde brought word that you were not dead, and he left Ironforge immediately to come find you.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 5, 0, "Speaking of which...", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 6, 0, "That's in the past, Muradin. Regrets won't change anything.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 7, 0, "So be it then. I have to return to my people, brothers. Come back to me in one piece.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30405, 8, 0, "Aye, be safe Muradin. I'd join you, but I'm on top of the most amazing discovery the world has yet seen. I can't abandon it now.", 12, 0, 100, 0, 0, 0, 0, 'Brann Bronzebeard');
INSERT INTO creature_text VALUES (30408, 0, 0, "What's that? You talkin' to me, lad?", 12, 0, 100, 6, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 1, 0, "My brother... yes... I do have brothers...", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 2, 0, "Muradin clutches his head and reels for a moment as the memories rush back to him.", 16, 0, 100, 5, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 3, 0, "...Brann?", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 4, 0, "I... I dunno, Brann. I've been 'ere a long time... all I 'ave of me life before this place are flashes and nightmares.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 5, 0, "It's good te see you though, brother. More than words can say.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 6, 0, "Magn! Forgive me, the memories are comin' back slowly, brother.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 7, 0, "The frostborn have been very good to me. They're strong people.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 8, 0, "Not much, Magni. I've had nightmares of a human... tall... light hair... death black armor. His name rests on the tip of me tongue, but...", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 9, 0, "...Arthas.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 10, 0, "Aye, I know. I watched him turn... I watched him give up all that was right and I didn't lift a hand... I didn't even consider it until it was too late.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 11, 0, "No... no they won't. But I can make this right. I have te. I'm goin' after the boy. I'll make'm answer for everything he's done.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 12, 0, "I'm sure, Magni. I'll see this through, don't ya worry.", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30408, 13, 0, "Go Brann. Bring back an epic tale when we meet again. Farewell for now, brothers...", 12, 0, 100, 0, 0, 0, 0, 'Yorg Stormeheart');
INSERT INTO creature_text VALUES (30411, 0, 0, "Look, Lagnus, I consider you a capable man, but my patience is wearing thin. I know that Muradin is here, can you point me to him or not?", 14, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 1, 0, "Brother! There you are! I can barely believe my eyes... you're alive!", 14, 0, 100, 5, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 2, 0, "It's so good to see you again, Muradin. And what's this I heard about you being a King in your own right now? The Bronzebeards were always destined to greatness.", 12, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 3, 0, "So it seems! And you haven't lost any muscle yourself. Do you remember anything of what happened, Muradin? Fate as turned ill in your absence.", 12, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 4, 0, "Magni nods.", 16, 0, 100, 273, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 5, 0, "He's not the boy of your memories anymore, Muradin. He's become something else entirely.", 12, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 6, 0, "Are you sure Muradin? I just got you back after years of thinking you were dead. I do not want to lose you again.", 12, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');
INSERT INTO creature_text VALUES (30411, 7, 0, "...farewell brother.", 12, 0, 100, 0, 0, 0, 0, 'Magni Bronzebeard');

-- Cold Hearted (12856)
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=30442;
DELETE FROM smart_scripts WHERE entryorguid=30442 AND source_type=0;
UPDATE creature_template SET flags_extra=130, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=29805;
DELETE FROM smart_scripts WHERE entryorguid=29805 AND source_type=0;
INSERT INTO smart_scripts VALUES (29805, 0, 0, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 11, 55244, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Proto Drake Beam Bunny - On Update - Cast Spear Chain Beam');
UPDATE creature_template SET speed_run=2.0 WHERE entry=29709;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29809;
DELETE FROM smart_scripts WHERE entryorguid=29809 AND source_type=0;
INSERT INTO smart_scripts VALUES (29809, 0, 0, 0, 1, 0, 100, 1, 0, 10000, 0, 0, 11, 55291, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Son of Hodir - Out of Combat - Cast Periodic Club Throw');
UPDATE creature SET curhealth=12600 WHERE id=29708;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29708;
DELETE FROM smart_scripts WHERE entryorguid=29708 AND source_type=0;
INSERT INTO smart_scripts VALUES (29708, 0, 0, 0, 73, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Proto-Drake - On Spell Click - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=29708;
INSERT INTO conditions VALUES (22, 1, 29708, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Captive Proto-Drake - Requires invoker to be a player');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=29708;
INSERT INTO conditions VALUES (18, 29708, 55028, 0, 0, 9, 0, 12856, 0, 0, 0, 0, 0, '', 'Required quest active for spellclick');
INSERT INTO conditions VALUES (18, 29708, 46598, 0, 0, 31, 0, 3, 29805, 0, 0, 0, 0, '', 'Require Captive Proto Drake Beam Bunny for spellclick');
DELETE FROM npc_spellclick_spells WHERE npc_entry=29708;
INSERT INTO npc_spellclick_spells VALUES (29708, 55028, 1, 0);
INSERT INTO npc_spellclick_spells VALUES (29708, 46598, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry=29708;
INSERT INTO vehicle_template_accessory VALUES (29708, 29805, 0, 1, 'Captive Proto-Drake', 8, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=55290;
INSERT INTO conditions VALUES (13, 1, 55290, 0, 0, 31, 0, 3, 29709, 0, 0, 0, 0, '', 'Target Freed Proto-Drake');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=55524;
INSERT INTO conditions VALUES (13, 1, 55524, 0, 0, 31, 0, 3, 29709, 0, 0, 0, 0, '', 'Target Freed Proto-Drake');
DELETE FROM spell_script_names WHERE spell_id=54894;
INSERT INTO spell_script_names VALUES(54894, "spell_gen_visual_dummy_stun");

-- Expression of Gratitude (12836)
UPDATE quest_template SET PrevQuestId=0 WHERE Id=12836;

-- Reclaimed Rations (12827)
UPDATE quest_template SET PrevQuestId=12836 WHERE Id=12827;

-- A Flawless Plan (12823)
UPDATE quest_template SET PrevQuestId=12822 WHERE Id=12823;

-- When All Else Fails (12862)
-- When All Else Fails (13060)
UPDATE quest_template SET PrevQuestId=12824 WHERE Id IN(12862, 13060);

-- Changing the Wind's Course (13058)
DELETE FROM smart_scripts WHERE entryorguid=194123 AND source_type=1;
INSERT INTO smart_scripts VALUES (194123, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 45, 0, 2, 0, 0, 0, 0, 19, 30474, 50, 0, 0, 0, 0, 0, 'Horn of Elemental Fury - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (194123, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horn of Elemental Fury - On Gossip Hello - Despawn');
DELETE FROM smart_scripts WHERE entryorguid=30474 AND source_type=0;
INSERT INTO smart_scripts VALUES (30474, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 8000, 11000, 11, 61662, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'North Wind - In Combat - Cast Cyclone');
INSERT INTO smart_scripts VALUES (30474, 0, 1, 0, 0, 0, 100, 0, 1000, 8000, 12000, 16000, 11, 61663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'North Wind - In Combat - Cast Gust of Wind');
INSERT INTO smart_scripts VALUES (30474, 0, 2, 3, 2, 0, 100, 1, 0, 20, 20000, 20000, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Between 0-20% HP - Set Faction');
INSERT INTO smart_scripts VALUES (30474, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Between 0-20% HP - Say line 0');
INSERT INTO smart_scripts VALUES (30474, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46957, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Between 0-20% HP - Cast Cosmetic - Stun (Permanent)');
INSERT INTO smart_scripts VALUES (30474, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Between 0-20% HP - Set Home Position');
INSERT INTO smart_scripts VALUES (30474, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Between 0-20% HP - Stop Health Regeneration');
INSERT INTO smart_scripts VALUES (30474, 0, 7, 8, 52, 0, 100, 0, 0, 30474, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (30474, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 1000, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Say Line 1 Target');
INSERT INTO smart_scripts VALUES (30474, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 56892, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Spellcast Drop Horn of Elemental Fury');
INSERT INTO smart_scripts VALUES (30474, 0, 10, 11, 52, 0, 100, 0, 1, 30388, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 19, 30388, 100, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Remove aura Ride Vehicle Hardcoded');
INSERT INTO smart_scripts VALUES (30474, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Say line 1');
INSERT INTO smart_scripts VALUES (30474, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Text Over - Despawn');
INSERT INTO smart_scripts VALUES (30474, 0, 13, 0, 38, 0, 100, 0, 0, 2, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Data Set - Die');
INSERT INTO smart_scripts VALUES (30474, 0, 14, 16, 7, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Evade - Restore Faction');
INSERT INTO smart_scripts VALUES (30474, 0, 15, 16, 11, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - On Respawn - Restore Faction');
INSERT INTO smart_scripts VALUES (30474, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'North Wind - Linked - Start Health Regeneration');

-- Examples to be Made (12907)
DELETE FROM creature_text WHERE entry=30147;
INSERT INTO creature_text VALUES (30147, 0, 0, 'Get them!', 12, 0, 100, 0, 0, 0, 0, 'Garhal');
REPLACE INTO creature_addon VALUES (118803, 0, 0, 0, 1, 0, '');
REPLACE INTO creature_addon VALUES (118804, 0, 0, 0, 1, 0, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29427;
DELETE FROM smart_scripts WHERE entryorguid IN(30147, -118746, -118747, -118748, -118803, -118804) AND source_type=0;
INSERT INTO smart_scripts VALUES (30147, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 5000, 9000, 11, 50306, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Garhal - In Combat - Cast Thrash Kick');
INSERT INTO smart_scripts VALUES (30147, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Garhal - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (30147, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 11, 29427, 10, 0, 0, 0, 0, 0, 'Garhal - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (30147, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Garhal - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (30147, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 11, 29427, 20, 0, 0, 0, 0, 0, 'Garhal - On Death - Set Data');
INSERT INTO smart_scripts VALUES (-118746, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 11000, 16000, 11, 30931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (-118746, 0, 1, 0, 0, 0, 100, 0, 3000, 5500, 6000, 9000, 11, 46182, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Snap Kick');
INSERT INTO smart_scripts VALUES (-118746, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-118747, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 11000, 16000, 11, 30931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (-118747, 0, 1, 0, 0, 0, 100, 0, 3000, 5500, 6000, 9000, 11, 46182, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Snap Kick');
INSERT INTO smart_scripts VALUES (-118747, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-118748, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 11000, 16000, 11, 30931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (-118748, 0, 1, 0, 0, 0, 100, 0, 3000, 5500, 6000, 9000, 11, 46182, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - In Combat - Cast Snap Kick');
INSERT INTO smart_scripts VALUES (-118748, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hyldnir Overseer - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-118803, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-118803, 0, 1, 0, 38, 0, 100, 0, 1, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 29426, 20, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES (-118803, 0, 2, 3, 38, 0, 100, 0, 2, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Evade');
INSERT INTO smart_scripts VALUES (-118803, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Set Faction');
INSERT INTO smart_scripts VALUES (-118803, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (-118804, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Reset - Set React Defensive');
INSERT INTO smart_scripts VALUES (-118804, 0, 1, 0, 38, 0, 100, 0, 1, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 29426, 20, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES (-118804, 0, 2, 3, 38, 0, 100, 0, 2, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Evade');
INSERT INTO smart_scripts VALUES (-118804, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Set Faction');
INSERT INTO smart_scripts VALUES (-118804, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captive Vrykul - On Data Set - Despawn');

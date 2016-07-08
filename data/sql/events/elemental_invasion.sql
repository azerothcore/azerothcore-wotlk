
-- Cleanup
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id IN(14461, 14460, 14454, 14455, 14457, 14458, 14464, 14462));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(14461, 14460, 14454, 14455, 14457, 14458, 14464, 14462));
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id IN(14461, 14460, 14454, 14455, 14457, 14458, 14464, 14462));
DELETE FROM creature WHERE id IN(14461, 14460, 14454, 14455, 14457, 14458, 14464, 14462);
DELETE FROM gameobject WHERE id IN(179666, 179667, 179665, 179664);

-- Baron Charr (14461)
INSERT INTO creature_addon VALUES (247200, 2472000, 0, 0, 4097, 0, '');
INSERT INTO creature_formations VALUES (247200, 247200, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (247200, 247201, 7, 45, 2, 0, 0);
INSERT INTO creature_formations VALUES (247200, 247202, 7, 135, 2, 0, 0);
INSERT INTO creature_formations VALUES (247200, 247203, 7, 225, 2, 0, 0);
INSERT INTO creature_formations VALUES (247200, 247204, 7, 315, 2, 0, 0);
INSERT INTO creature VALUES (247200, 14461, 1, 1, 1, 0, 0, -6997.41, -1373.95, -269.32, 1.90849, 3*86400, 0, 0, 14355, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (247201, 14460, 1, 1, 1, 0, 0, -6997.41, -1373.95, -269.32, 1.90849, 5*86400, 0, 0, 2614, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247202, 14460, 1, 1, 1, 0, 0, -6997.41, -1373.95, -269.32, 1.90849, 5*86400, 0, 0, 2614, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247203, 14460, 1, 1, 1, 0, 0, -6997.41, -1373.95, -269.32, 1.90849, 5*86400, 0, 0, 2614, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247204, 14460, 1, 1, 1, 0, 0, -6997.41, -1373.95, -269.32, 1.90849, 5*86400, 0, 0, 2614, 0, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=2472000;
INSERT INTO waypoint_data VALUES (2472000, 1, -6999.11, -1358.55, -270.021, 0, 0, 0, 0, 100, 0),(2472000, 2, -7003.22, -1335.53, -270.783, 0, 0, 0, 0, 100, 0),(2472000, 3, -7007.51, -1311.45, -271.273, 0, 0, 0, 0, 100, 0),(2472000, 4, -7012.83, -1288.75, -268.084, 0, 0, 0, 0, 100, 0),(2472000, 5, -7016.54, -1270.43, -269.679, 0, 0, 0, 0, 100, 0),(2472000, 6, -7022.18, -1247.83, -271.085, 0, 0, 0, 0, 100, 0),(2472000, 7, -7025.58, -1228.32, -270.156, 0, 0, 0, 0, 100, 0),(2472000, 8, -7027.61, -1208.54, -270.386, 0, 0, 0, 0, 100, 0),(2472000, 9, -7036.25, -1197.58, -269.042, 0, 0, 0, 0, 100, 0),(2472000, 10, -7047.88, -1181.62, -267.949, 0, 0, 0, 0, 100, 0),(2472000, 11, -7062.23, -1163.26, -267.162, 0, 0, 0, 0, 100, 0),(2472000, 12, -7080.47, -1145.16, -268.569, 0, 0, 0, 0, 100, 0),(2472000, 13, -7096.59, -1126.72, -267.95, 0, 0, 0, 0, 100, 0),(2472000, 14, -7100.79, -1115.88, -266.678, 0, 0, 0, 0, 100, 0),(2472000, 15, -7110.32, -1102.65, -270.179, 0, 0, 0, 0, 100, 0),(2472000, 16, -7123.67, -1093.27, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 17, -7145.41, -1084.86, -272.059, 0, 0, 0, 0, 100, 0),(2472000, 18, -7164.07, -1083.83, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 19, -7188.14, -1087.99, -272.115, 0, 0, 0, 0, 100, 0),(2472000, 20, -7202.02, -1086.79, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 21, -7219.31, -1089.52, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 22, -7241.86, -1095.42, -271.906, 0, 0, 0, 0, 100, 0),(2472000, 23, -7260.84, -1100.9, -269.854, 0, 0, 0, 0, 100, 0),(2472000, 24, -7276.08, -1109.35, -267.855, 0, 0, 0, 0, 100, 0),(2472000, 25, -7294.53, -1125.48, -269.514, 0, 0, 0, 0, 100, 0),(2472000, 26, -7311.23, -1140.09, -269.329, 0, 0, 0, 0, 100, 0),(2472000, 27, -7324.17, -1156.63, -268.45, 0, 0, 0, 0, 100, 0),(2472000, 28, -7334.7, -1176.16, -270.318, 0, 0, 0, 0, 100, 0),(2472000, 29, -7345.38, -1196.82, -268.78, 0, 0, 0, 0, 100, 0),(2472000, 30, -7348.25, -1216.42, -265.408, 0, 0, 0, 0, 100, 0),(2472000, 31, -7363.39, -1232.54, -268.287, 0, 0, 0, 0, 100, 0),(2472000, 32, -7366.13, -1248.62, -271.157, 0, 0, 0, 0, 100, 0),(2472000, 33, -7367.61, -1268.37, -271.197, 0, 0, 0, 0, 100, 0),(2472000, 34, -7367.78, -1289.21, -269.417, 0, 0, 0, 0, 100, 0),(2472000, 35, -7360.25, -1307.58, -265.402, 0, 0, 0, 0, 100, 0),(2472000, 36, -7354.79, -1322.95, -261.729, 0, 0, 0, 0, 100, 0),(2472000, 37, -7347.48, -1329.33, -260.949, 0, 0, 0, 0, 100, 0),(2472000, 38, -7344.24, -1339.31, -264.618, 0, 0, 0, 0, 100, 0),(2472000, 39, -7348.17, -1351.58, -268.716, 0, 0, 0, 0, 100, 0),(2472000, 40, -7353.15, -1367.11, -269.562, 0, 0, 0, 0, 100, 0),(2472000, 41, -7354.79, -1371.5, -272.105, 0, 0, 0, 0, 100, 0),(2472000, 42, -7359.33, -1384.75, -272.105, 0, 0, 0, 0, 100, 0),(2472000, 43, -7365.74, -1403.49, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 44, -7366.64, -1419.85, -272.116, 0, 0, 0, 0, 100, 0),(2472000, 45, -7366.87, -1433.84, -271.897, 0, 0, 0, 0, 100, 0),(2472000, 46, -7379.12, -1449.31, -272.115, 0, 0, 0, 0, 100, 0),(2472000, 47, -7391.14, -1469.28, -272.118, 0, 0, 0, 0, 100, 0),(2472000, 48, -7394.18, -1485.31, -272.104, 0, 0, 0, 0, 100, 0),(2472000, 49, -7394.18, -1504, -271.786, 0, 0, 0, 0, 100, 0),(2472000, 50, -7384.12, -1519.69, -271.425, 0, 0, 0, 0, 100, 0),(2472000, 51, -7376.03, -1529.63, -271.218, 0, 0, 0, 0, 100, 0),(2472000, 52, -7364.17, -1544.08, -271.51, 0, 0, 0, 0, 100, 0),(2472000, 53, -7348.04, -1545.99, -272.362, 0, 0, 0, 0, 100, 0),(2472000, 54, -7323.57, -1544.84, -272.903, 0, 0, 0, 0, 100, 0),(2472000, 55, -7301.47, -1543.8, -274.061, 0, 0, 0, 0, 100, 0),(2472000, 56, -7279.33, -1542.42, -274.2, 0, 0, 0, 0, 100, 0),(2472000, 57, -7256.04, -1540.41, -273.428, 0, 0, 0, 0, 100, 0),(2472000, 58, -7232.74, -1538.39, -273.573, 0, 0, 0, 0, 100, 0),(2472000, 59, -7213.77, -1544.07, -273.216, 0, 0, 0, 0, 100, 0),(2472000, 60, -7194.21, -1551.72, -273.692, 0, 0, 0, 0, 100, 0),(2472000, 61, -7174.95, -1556.11, -271.317, 0, 0, 0, 0, 100, 0),(2472000, 62, -7152.84, -1554.2, -271.585, 0, 0, 0, 0, 100, 0),(2472000, 63, -7128.43, -1552.09, -272.111, 0, 0, 0, 0, 100, 0),(2472000, 64, -7112.74, -1556.52, -272.038, 0, 0, 0, 0, 100, 0),(2472000, 65, -7098.88, -1558.5, -271.985, 0, 0, 0, 0, 100, 0),(2472000, 66, -7078.09, -1561.46, -271.579, 0, 0, 0, 0, 100, 0),(2472000, 67, -7058.48, -1564.26, -271.802, 0, 0, 0, 0, 100, 0),(2472000, 68, -7039.01, -1557.35, -271.181, 0, 0, 0, 0, 100, 0),(2472000, 69, -7020.51, -1554.7, -270.069, 0, 0, 0, 0, 100, 0),(2472000, 70, -7008.79, -1547.03, -269.455, 0, 0, 0, 0, 100, 0),(2472000, 71, -7001.09, -1536.8, -269.278, 0, 0, 0, 0, 100, 0),(2472000, 72, -7000.33, -1524.02, -270.062, 0, 0, 0, 0, 100, 0),(2472000, 73, -7006.28, -1508.83, -268.36, 0, 0, 0, 0, 100, 0),(2472000, 74, -7005.58, -1497.23, -266.614, 0, 0, 0, 0, 100, 0),(2472000, 75, -6995.95, -1485.49, -268.974, 0, 0, 0, 0, 100, 0),(2472000, 76, -6989.49, -1473.06, -271.318, 0, 0, 0, 0, 100, 0),(2472000, 77, -6987.94, -1460.35, -270.445, 0, 0, 0, 0, 100, 0),(2472000, 78, -6990.73, -1440.71, -267.886, 0, 0, 0, 0, 100, 0),(2472000, 79, -6992.86, -1425.74, -265.27, 0, 0, 0, 0, 100, 0),(2472000, 80, -6996.49, -1418.4, -262.819, 0, 0, 0, 0, 100, 0),(2472000, 81, -6995.25, -1407.98, -264.201, 0, 0, 0, 0, 100, 0),(2472000, 82, -6995.62, -1398.67, -265.759, 0, 0, 0, 0, 100, 0),(2472000, 83, -6996.73, -1388.23, -267.499, 0, 0, 0, 0, 100, 0),(2472000, 84, -6997.69, -1380.1, -268.447, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_text WHERE entry=14461;
INSERT INTO creature_text VALUES (14461, 0, 0, 'Hear me, denizens of the Crater! I come to burn this land of its impurity!', 14, 0, 100, 0, 0, 0, 2, 'Baron Charr Spawn');
INSERT INTO creature_text VALUES (14461, 1, 0, 'Where are the so-called heroes of this world? Too frightened to come out and play?', 14, 0, 100, 0, 0, 0, 2, 'Baron Charr OOC');
INSERT INTO creature_text VALUES (14461, 2, 0, 'You have not seen the last of me fools! All will be consumed in the end!', 14, 0, 100, 0, 0, 0, 2, 'Baron Charr Death');
UPDATE creature_template SET unit_class=2, AIName='SmartAI', ScriptName='' WHERE entry=14461;
DELETE FROM smart_scripts WHERE entryorguid=14461 AND source_type=0;
INSERT INTO smart_scripts VALUES (14461, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (14461, 0, 1, 0, 1, 0, 100, 0, 180000, 300000, 180000, 300000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - Out of Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (14461, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (14461, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - On Death - Remove All Gameobjects');
INSERT INTO smart_scripts VALUES (14461, 0, 4, 0, 0, 0, 100, 0, 3000, 6000, 8000, 11000, 11, 15285, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - In Combat - Cast Fireball Volley');
INSERT INTO smart_scripts VALUES (14461, 0, 5, 0, 0, 0, 100, 0, 0, 0, 10000, 16000, 11, 9574, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Charr - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (14461, 0, 10, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247201, 14460, 1, 0, 0, 0, 0, 'Baron Charr - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14461, 0, 11, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247202, 14460, 1, 0, 0, 0, 0, 'Baron Charr - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14461, 0, 12, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247203, 14460, 1, 0, 0, 0, 0, 'Baron Charr - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14461, 0, 13, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247204, 14460, 1, 0, 0, 0, 0, 'Baron Charr - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14461, 0, 14, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7115.23, -1303.52, -186.023, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 15, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7159.79, -1340.77, -184.387, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 16, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7172.53, -1282.03, -184.389, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 17, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7271.34, -1205.2, -241.216, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 18, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7305.77, -1314.89, -240.622, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 19, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7239.31, -1408.76, -232.555, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 20, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7207.49, -1452.04, -231.648, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 21, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7170.79, -1478.02, -265.446, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 22, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7132.25, -1435.83, -265.447, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 23, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7030.19, -1449.66, -262.58, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 24, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7019.3, -1269.13, -269.652, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 25, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7045.36, -1199.41, -267.884, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 26, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7106.72, -1120.15, -266.057, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 27, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7202.57, -1124.08, -266.719, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 28, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7074.14, -1420.95, -234.381, 0, 'Baron Charr - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14461, 0, 29, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179666, 0, 0, 0, 0, 0, 8, 0, 0, 0, -7109.12, -1481.67, -247.611, 0, 'Baron Charr - On Respawn - Summon Gameobject');

-- Blazing Invader (14460)
UPDATE creature_template SET unit_class=2, AIName='SmartAI', ScriptName='' WHERE entry=14460;
DELETE FROM smart_scripts WHERE entryorguid=14460 AND source_type=0;
INSERT INTO smart_scripts VALUES (14460, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 89, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - Is Summoned - Random Move');
INSERT INTO smart_scripts VALUES (14460, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 10000, 16000, 11, 23113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (14460, 0, 2, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - Out of Combat - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=14460;
INSERT INTO conditions VALUES(22, 3, 14460, 0, 0, 29, 1, 14461, 150, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- GO Fire Elemental Rift (179666)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179666;
DELETE FROM smart_scripts WHERE entryorguid=179666 AND source_type=1;
INSERT INTO smart_scripts VALUES (179666, 1, 0, 0, 60, 0, 100, 0, 0, 5000, 90000, 90000, 12, 14460, 4, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Update - Summon Creature');

-- The Windreaver (14454)
INSERT INTO creature_addon VALUES (247205, 2472050, 0, 0, 4097, 0, '');
INSERT INTO creature_formations VALUES (247205, 247205, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (247205, 247206, 7, 45, 2, 0, 0);
INSERT INTO creature_formations VALUES (247205, 247207, 7, 135, 2, 0, 0);
INSERT INTO creature_formations VALUES (247205, 247208, 7, 225, 2, 0, 0);
INSERT INTO creature_formations VALUES (247205, 247209, 7, 315, 2, 0, 0);
INSERT INTO creature VALUES (247205, 14454, 1, 1, 1, 0, 0, -6316.154, 1347.962, 5.207, 1.06, 2.5*86400, 0, 0, 15260, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (247206, 14455, 1, 1, 1, 0, 0, -6316.154, 1347.962, 5.207, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247207, 14455, 1, 1, 1, 0, 0, -6316.154, 1347.962, 5.207, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247208, 14455, 1, 1, 1, 0, 0, -6316.154, 1347.962, 5.207, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247209, 14455, 1, 1, 1, 0, 0, -6316.154, 1347.962, 5.207, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=2472050;
INSERT INTO waypoint_data VALUES (2472050, 1, -6315.81, 1356.37, 5.25458, 0, 0, 0, 0, 100, 0),(2472050, 2, -6302.42, 1374.06, 8.68165, 0, 0, 0, 0, 100, 0),(2472050, 3, -6290.7, 1392.85, 9.76755, 0, 0, 0, 0, 100, 0),(2472050, 4, -6285.7, 1409.55, 9.06444, 0, 0, 0, 0, 100, 0),(2472050, 5, -6285.42, 1423.55, 11.3973, 0, 0, 0, 0, 100, 0),(2472050, 6, -6289.02, 1444.19, 9.88459, 0, 0, 0, 0, 100, 0),(2472050, 7, -6298.88, 1459.99, 6.63575, 0, 0, 0, 0, 100, 0),(2472050, 8, -6307.62, 1482.88, 4.62563, 0, 0, 0, 0, 100, 0),(2472050, 9, -6326.69, 1496.28, 3.20733, 0, 0, 0, 0, 100, 0),(2472050, 10, -6350.8, 1505.08, 5.14763, 0, 0, 0, 0, 100, 0),(2472050, 11, -6373.98, 1502.62, 5.52059, 0, 0, 0, 0, 100, 0),(2472050, 12, -6403.17, 1503.08, 4.19517, 0, 0, 0, 0, 100, 0),(2472050, 13, -6415.98, 1502.83, 4.26121, 0, 0, 0, 0, 100, 0),(2472050, 14, -6434.55, 1502.47, 6.93398, 0, 0, 0, 0, 100, 0),(2472050, 15, -6460.15, 1504.61, 6.75268, 0, 0, 0, 0, 100, 0),(2472050, 16, -6479.9, 1506.04, 6.74363, 0, 0, 0, 0, 100, 0),(2472050, 17, -6505.53, 1504.23, 4.0931, 0, 0, 0, 0, 100, 0),(2472050, 18, -6525.29, 1506.41, 2.15644, 0, 0, 0, 0, 100, 0),(2472050, 19, -6547.33, 1504.5, 3.53133, 0, 0, 0, 0, 100, 0),(2472050, 20, -6557.73, 1503.6, 4.35006, 0, 0, 0, 0, 100, 0),(2472050, 21, -6556.72, 1480.32, 1.1815, 0, 0, 0, 0, 100, 0),(2472050, 22, -6556.86, 1462.82, -0.342604, 0, 0, 0, 0, 100, 0),(2472050, 23, -6556.54, 1439.45, 3.30604, 0, 0, 0, 0, 100, 0),(2472050, 24, -6547.8, 1416.56, 3.37939, 0, 0, 0, 0, 100, 0),(2472050, 25, -6528.03, 1402.08, 3.01431, 0, 0, 0, 0, 100, 0),(2472050, 26, -6506.35, 1397.35, 1.23802, 0, 0, 0, 0, 100, 0),(2472050, 27, -6480.82, 1396.45, 1.71924, 0, 0, 0, 0, 100, 0),(2472050, 28, -6459.15, 1400.85, 1.12839, 0, 0, 0, 0, 100, 0),(2472050, 29, -6444.04, 1399.3, 3.57583, 0, 0, 0, 0, 100, 0),(2472050, 30, -6418.63, 1395.48, 4.18943, 0, 0, 0, 0, 100, 0),(2472050, 31, -6398.9, 1388.26, 4.39496, 0, 0, 0, 0, 100, 0),(2472050, 32, -6377.58, 1374.01, 4.37222, 0, 0, 0, 0, 100, 0),(2472050, 33, -6372.94, 1344.95, 2.82732, 0, 0, 0, 0, 100, 0),(2472050, 34, -6355.21, 1333.7, 3.20116, 0, 0, 0, 0, 100, 0),(2472050, 35, -6343.59, 1335.03, 3.21992, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_text WHERE entry=14454;
INSERT INTO creature_text VALUES (14454, 0, 0, '%s and his invading forces appear amidst a tumultuous conflagration in the northwest of Silithus.', 16, 0, 100, 0, 0, 0, 2, 'The Windreaver Spawn');
INSERT INTO creature_text VALUES (14454, 1, 0, '%s causes a gale to sweep across the land, the sound of his mindless fury coming from the northwest.', 16, 0, 100, 0, 0, 0, 2, 'The Windreaver OOC');
INSERT INTO creature_text VALUES (14454, 2, 0, '%s dissipates into the ether, his howling winds still ringing in your ears.', 16, 0, 100, 0, 0, 0, 2, 'The Windreaver Death');
UPDATE creature_template SET unit_class=8, AIName='SmartAI', ScriptName='' WHERE entry=14454;
DELETE FROM smart_scripts WHERE entryorguid=14454 AND source_type=0;
INSERT INTO smart_scripts VALUES (14454, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (14454, 0, 1, 0, 1, 0, 100, 0, 180000, 300000, 180000, 300000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - Out of Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (14454, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (14454, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - On Death - Remove All Gameobjects');
INSERT INTO smart_scripts VALUES (14454, 0, 4, 0, 0, 0, 100, 0, 3000, 6000, 8000, 11000, 11, 23106, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (14454, 0, 5, 0, 0, 0, 100, 0, 0, 14000, 10000, 16000, 11, 23105, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'The Windreaver - In Combat - Cast Lightning Cloud');
INSERT INTO smart_scripts VALUES (14454, 0, 6, 0, 0, 0, 100, 0, 3000, 11000, 15000, 26000, 11, 23103, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'The Windreaver - In Combat - Cast Enveloping Winds');
INSERT INTO smart_scripts VALUES (14454, 0, 7, 0, 0, 0, 100, 0, 3000, 6000, 8000, 14000, 11, 23104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Windreaver - In Combat - Cast Shock');
INSERT INTO smart_scripts VALUES (14454, 0, 10, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247206, 14455, 1, 0, 0, 0, 0, 'The Windreaver - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14454, 0, 11, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247207, 14455, 1, 0, 0, 0, 0, 'The Windreaver - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14454, 0, 12, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247208, 14455, 1, 0, 0, 0, 0, 'The Windreaver - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14454, 0, 13, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247209, 14455, 1, 0, 0, 0, 0, 'The Windreaver - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14454, 0, 14, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6324.1, 1349.34, 4.39246, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 15, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6265.87, 1332.98, 14.2791, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 16, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6287.71, 1390.8, 9.90502, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 17, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6286.39, 1440.51, 10.2443, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 18, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6308.11, 1497.98, 4.06939, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 19, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6263, 1517.72, 9.75825, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 20, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6309.46, 1535.09, 3.51532, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 21, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6353.25, 1512.41, 4.66918, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 22, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6389.05, 1462.01, 2.95468, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 23, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6405.61, 1415.61, -1.48166, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 24, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6438.17, 1511.42, 6.13047, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 25, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6501.51, 1505.89, 4.09383, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 26, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6556.16, 1444.78, 2.96919, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 27, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6601.16, 1474.43, 4.0009, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 28, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6573.24, 1530.22, 3.10244, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 29, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6636.07, 1504.24, 3.69889, 0, 'The Windreaver - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14454, 0, 30, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179667, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6483.56, 1453.19, 2.10941, 0, 'The Windreaver - On Respawn - Summon Gameobject');

-- Whirling Invader (14455)
UPDATE creature_template SET unit_class=2, AIName='SmartAI', ScriptName='' WHERE entry=14455;
DELETE FROM smart_scripts WHERE entryorguid=14455 AND source_type=0;
INSERT INTO smart_scripts VALUES (14455, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 89, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - Is Summoned - Random Move');
INSERT INTO smart_scripts VALUES (14455, 0, 1, 0, 0, 0, 100, 0, 0, 7000, 8000, 14000, 11, 17207, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (14455, 0, 2, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - Out of Combat - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=14455;
INSERT INTO conditions VALUES(22, 3, 14455, 0, 0, 29, 1, 14454, 150, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- GO Air Elemental Rift (179667)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179667;
DELETE FROM smart_scripts WHERE entryorguid=179667 AND source_type=1;
INSERT INTO smart_scripts VALUES (179667, 1, 0, 0, 60, 0, 100, 0, 0, 5000, 90000, 90000, 12, 14455, 4, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Air Elemental Rift - On Update - Summon Creature');

-- Princess Tempestria (14457)
INSERT INTO creature_addon VALUES (247210, 2472100, 0, 0, 4097, 0, '');
INSERT INTO creature_formations VALUES (247210, 247210, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (247210, 247211, 7, 45, 2, 0, 0);
INSERT INTO creature_formations VALUES (247210, 247212, 7, 135, 2, 0, 0);
INSERT INTO creature_formations VALUES (247210, 247213, 7, 225, 2, 0, 0);
INSERT INTO creature_formations VALUES (247210, 247214, 7, 315, 2, 0, 0);
INSERT INTO creature VALUES (247210, 14457, 1, 1, 1, 0, 0, 6471.87, -4076.27, 658.521, 1.06, 2.3*86400, 0, 0, 15260, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (247211, 14458, 1, 1, 1, 0, 0, 6471.87, -4076.27, 658.521, 1.06, 5*86400, 0, 0, 2699, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247212, 14458, 1, 1, 1, 0, 0, 6471.87, -4076.27, 658.521, 1.06, 5*86400, 0, 0, 2699, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247213, 14458, 1, 1, 1, 0, 0, 6471.87, -4076.27, 658.521, 1.06, 5*86400, 0, 0, 2699, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247214, 14458, 1, 1, 1, 0, 0, 6471.87, -4076.27, 658.521, 1.06, 5*86400, 0, 0, 2699, 0, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=2472100;
INSERT INTO waypoint_data VALUES (2472100, 1, 6471.87, -4076.27, 658.521, 0, 0, 0, 0, 100, 0),(2472100, 2, 6480.27, -4096.81, 658.395, 0, 0, 0, 0, 100, 0),(2472100, 3, 6485.64, -4123.08, 658.468, 0, 0, 0, 0, 100, 0),(2472100, 4, 6489.6, -4142.49, 658.66, 0, 0, 0, 0, 100, 0),(2472100, 5, 6495.05, -4163.99, 658.848, 0, 0, 0, 0, 100, 0),(2472100, 6, 6502.97, -4187.17, 658.851, 0, 0, 0, 0, 100, 0),(2472100, 7, 6517.24, -4199.24, 658.531, 0, 0, 0, 0, 100, 0),(2472100, 8, 6536.3, -4210.51, 658.674, 0, 0, 0, 0, 100, 0),(2472100, 9, 6555.55, -4215.19, 658.547, 0, 0, 0, 0, 100, 0),(2472100, 10, 6575.18, -4213.33, 658.297, 0, 0, 0, 0, 100, 0),(2472100, 11, 6592.88, -4202.17, 658.356, 0, 0, 0, 0, 100, 0),(2472100, 12, 6608.26, -4164.77, 658.508, 0, 0, 0, 0, 100, 0),(2472100, 13, 6611.58, -4146.45, 658.542, 0, 0, 0, 0, 100, 0),(2472100, 14, 6609.06, -4131.47, 658.503, 0, 0, 0, 0, 100, 0),(2472100, 15, 6601.31, -4118.54, 658.313, 0, 0, 0, 0, 100, 0),(2472100, 16, 6589.84, -4103.78, 658.354, 0, 0, 0, 0, 100, 0),(2472100, 17, 6579.42, -4085.56, 658.352, 0, 0, 0, 0, 100, 0),(2472100, 18, 6568.4, -4066.29, 658.284, 0, 0, 0, 0, 100, 0),(2472100, 19, 6564.72, -4051.56, 658.3, 0, 0, 0, 0, 100, 0),(2472100, 20, 6562.44, -4029.54, 658.386, 0, 0, 0, 0, 100, 0),(2472100, 21, 6558.56, -4008.97, 658.322, 0, 0, 0, 0, 100, 0),(2472100, 22, 6550.59, -3994.74, 658.419, 0, 0, 0, 0, 100, 0),(2472100, 23, 6537.42, -3981.49, 658.416, 0, 0, 0, 0, 100, 0),(2472100, 24, 6521.82, -3971.2, 658.304, 0, 0, 0, 0, 100, 0),(2472100, 25, 6505.46, -3970.38, 658.703, 0, 0, 0, 0, 100, 0),(2472100, 26, 6490.15, -3980.98, 658.598, 0, 0, 0, 0, 100, 0),(2472100, 27, 6482.31, -3995.28, 658.319, 0, 0, 0, 0, 100, 0),(2472100, 28, 6474.37, -4012.21, 658.37, 0, 0, 0, 0, 100, 0),(2472100, 29, 6468.58, -4026.25, 658.45, 0, 0, 0, 0, 100, 0),(2472100, 30, 6465.27, -4043.42, 658.474, 0, 0, 0, 0, 100, 0),(2472100, 31, 6466.07, -4055.08, 658.571, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_text WHERE entry=14457;
INSERT INTO creature_text VALUES (14457, 0, 0, 'This frozen land shall suffice for a start.  Come to me, mortals - and I shall give you a quick and painful death.', 14, 0, 100, 0, 0, 0, 2, 'Princess Tempestria Spawn');
INSERT INTO creature_text VALUES (14457, 1, 0, 'If you mortals are all so craven, this will be easier than I thought!', 14, 0, 100, 0, 0, 0, 2, 'Princess Tempestria OOC');
INSERT INTO creature_text VALUES (14457, 2, 0, 'You will all pay dearly when I return from the depths!', 14, 0, 100, 0, 0, 0, 2, 'Princess Tempestria Death');
UPDATE creature_template SET unit_class=8, AIName='SmartAI', ScriptName='' WHERE entry=14457;
DELETE FROM smart_scripts WHERE entryorguid=14457 AND source_type=0;
INSERT INTO smart_scripts VALUES (14457, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (14457, 0, 1, 0, 1, 0, 100, 0, 180000, 300000, 180000, 300000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - Out of Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (14457, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (14457, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - On Death - Remove All Gameobjects');
INSERT INTO smart_scripts VALUES (14457, 0, 4, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 23102, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (14457, 0, 5, 0, 0, 0, 100, 0, 0, 14000, 10000, 16000, 11, 10987, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - In Combat - Cast Geyser');
INSERT INTO smart_scripts VALUES (14457, 0, 6, 0, 0, 0, 100, 0, 3000, 11000, 15000, 26000, 11, 14907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (14457, 0, 7, 0, 0, 0, 100, 0, 3000, 10000, 11000, 17000, 11, 22746, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Princess Tempestria - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (14457, 0, 10, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247211, 14458, 1, 0, 0, 0, 0, 'Princess Tempestria - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14457, 0, 11, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247212, 14458, 1, 0, 0, 0, 0, 'Princess Tempestria - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14457, 0, 12, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247213, 14458, 1, 0, 0, 0, 0, 'Princess Tempestria - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14457, 0, 13, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247214, 14458, 1, 0, 0, 0, 0, 'Princess Tempestria - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14457, 0, 14, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6552.74, -4240.22, 658.296, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 15, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6551.11, -4189.69, 658.464, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 16, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6523.7, -4157.58, 658.34, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 17, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6501.46, -4225.49, 658.688, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 18, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6484.71, -4184.13, 658.819, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 19, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6493.89, -4129.62, 658.518, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 20, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6459.01, -4024.87, 658.297, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 21, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6512.79, -4044.29, 658.327, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 22, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6523.37, -3984.89, 658.372, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 23, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6491.97, -3952.45, 658.993, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 24, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6462.44, -3984.73, 658.286, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 25, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6551.45, -4029.24, 658.576, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 26, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6578.54, -4092.35, 658.371, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 27, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6612.45, -4111.76, 658.332, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 28, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6626.92, -4156.29, 658.411, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 29, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6588.69, -4160.86, 658.566, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 30, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6599.22, -4214.35, 658.342, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14457, 0, 31, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179665, 0, 0, 0, 0, 0, 8, 0, 0, 0, 6559.97, -3943.21, 658.356, 0, 'Princess Tempestria - On Respawn - Summon Gameobject');

-- Watery Invader (14458)
UPDATE creature_template SET unit_class=8, AIName='SmartAI', ScriptName='' WHERE entry=14458;
DELETE FROM smart_scripts WHERE entryorguid=14458 AND source_type=0;
INSERT INTO smart_scripts VALUES (14458, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 89, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - Is Summoned - Random Move');
INSERT INTO smart_scripts VALUES (14458, 0, 1, 0, 0, 0, 100, 0, 0, 7000, 8000, 14000, 11, 19133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (14458, 0, 2, 0, 1, 0, 100, 257, 5000, 5000, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - Out of Combat - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=14458;
INSERT INTO conditions VALUES(22, 3, 14458, 0, 0, 29, 1, 14457, 150, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- GO Water Elemental Rift (179665)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179665;
DELETE FROM smart_scripts WHERE entryorguid=179665 AND source_type=1;
INSERT INTO smart_scripts VALUES (179665, 1, 0, 0, 60, 0, 100, 0, 0, 5000, 90000, 90000, 12, 14458, 4, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Water Elemental Rift - On Update - Summon Creature');

-- Avalanchion (14464)
INSERT INTO creature_addon VALUES (247215, 2472150, 0, 0, 4097, 0, '');
INSERT INTO creature_formations VALUES (247215, 247215, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (247215, 247216, 7, 45, 2, 0, 0);
INSERT INTO creature_formations VALUES (247215, 247217, 7, 135, 2, 0, 0);
INSERT INTO creature_formations VALUES (247215, 247218, 7, 225, 2, 0, 0);
INSERT INTO creature_formations VALUES (247215, 247219, 7, 315, 2, 0, 0);
INSERT INTO creature VALUES (247215, 14464, 1, 1, 1, 0, 0, 4534.96, -7400.33, 88.4305, 1.06, 2.8*86400, 0, 0, 14335, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (247216, 14462, 1, 1, 1, 0, 0, 4534.96, -7400.33, 88.4305, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247217, 14462, 1, 1, 1, 0, 0, 4534.96, -7400.33, 88.4305, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247218, 14462, 1, 1, 1, 0, 0, 4534.96, -7400.33, 88.4305, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247219, 14462, 1, 1, 1, 0, 0, 4534.96, -7400.33, 88.4305, 1.06, 5*86400, 0, 0, 2784, 0, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=2472150;
INSERT INTO waypoint_data VALUES (2472150, 1, 4534.96, -7400.33, 88.4305, 0, 0, 0, 0, 100, 0),(2472150, 2, 4565.56, -7421.5, 89.4375, 0, 0, 0, 0, 100, 0),(2472150, 3, 4583.52, -7432.13, 90.6386, 0, 0, 0, 0, 100, 0),(2472150, 4, 4602.62, -7440.85, 85.6074, 0, 0, 0, 0, 100, 0),(2472150, 5, 4623.12, -7445.44, 82.942, 0, 0, 0, 0, 100, 0),(2472150, 6, 4652.63, -7452.05, 79.6445, 0, 0, 0, 0, 100, 0),(2472150, 7, 4672.85, -7446.95, 77.2518, 0, 0, 0, 0, 100, 0),(2472150, 8, 4695.73, -7442.87, 75.0314, 0, 0, 0, 0, 100, 0),(2472150, 9, 4707.72, -7422.8, 73.5057, 0, 0, 0, 0, 100, 0),(2472150, 10, 4709.83, -7394.74, 73.0452, 0, 0, 0, 0, 100, 0),(2472150, 11, 4712.45, -7359.84, 69.1881, 0, 0, 0, 0, 100, 0),(2472150, 12, 4714.54, -7334.17, 68.2217, 0, 0, 0, 0, 100, 0),(2472150, 13, 4720.41, -7302.08, 65.9683, 0, 0, 0, 0, 100, 0),(2472150, 14, 4732.31, -7276.82, 68.7514, 0, 0, 0, 0, 100, 0),(2472150, 15, 4745.53, -7257.54, 72.3969, 0, 0, 0, 0, 100, 0),(2472150, 16, 4757.41, -7240.23, 75.454, 0, 0, 0, 0, 100, 0),(2472150, 17, 4765.46, -7220.83, 79.0023, 0, 0, 0, 0, 100, 0),(2472150, 18, 4766.49, -7202.23, 81.5804, 0, 0, 0, 0, 100, 0),(2472150, 19, 4763.86, -7181.4, 81.7583, 0, 0, 0, 0, 100, 0),(2472150, 20, 4750.2, -7165.27, 81.8136, 0, 0, 0, 0, 100, 0),(2472150, 21, 4735.13, -7147.46, 84.6125, 0, 0, 0, 0, 100, 0),(2472150, 22, 4719.49, -7130.26, 88.647, 0, 0, 0, 0, 100, 0),(2472150, 23, 4702.1, -7118.63, 90.6803, 0, 0, 0, 0, 100, 0),(2472150, 24, 4683.37, -7117.59, 92.3254, 0, 0, 0, 0, 100, 0),(2472150, 25, 4667.04, -7117.07, 96.8419, 0, 0, 0, 0, 100, 0),(2472150, 26, 4648.59, -7120.44, 100.377, 0, 0, 0, 0, 100, 0),(2472150, 27, 4627.73, -7120.43, 101.51, 0, 0, 0, 0, 100, 0),(2472150, 28, 4609.61, -7116.15, 98.3574, 0, 0, 0, 0, 100, 0),(2472150, 29, 4591.49, -7111.86, 94.905, 0, 0, 0, 0, 100, 0),(2472150, 30, 4575.12, -7112.63, 96.7954, 0, 0, 0, 0, 100, 0),(2472150, 31, 4563.22, -7123.88, 98.8996, 0, 0, 0, 0, 100, 0),(2472150, 32, 4547.99, -7134.59, 101.488, 0, 0, 0, 0, 100, 0),(2472150, 33, 4536.92, -7143.16, 101.549, 0, 0, 0, 0, 100, 0),(2472150, 34, 4523.09, -7155.84, 101.362, 0, 0, 0, 0, 100, 0),(2472150, 35, 4513.15, -7165.69, 101.851, 0, 0, 0, 0, 100, 0),(2472150, 36, 4498.23, -7180.48, 98.7522, 0, 0, 0, 0, 100, 0),(2472150, 37, 4484.91, -7196.71, 96.1799, 0, 0, 0, 0, 100, 0),(2472150, 38, 4472.35, -7207, 96.1632, 0, 0, 0, 0, 100, 0),(2472150, 39, 4459.54, -7220.52, 97.3785, 0, 0, 0, 0, 100, 0),(2472150, 40, 4450.06, -7236.55, 97.7249, 0, 0, 0, 0, 100, 0),(2472150, 41, 4446.16, -7252.46, 95.4364, 0, 0, 0, 0, 100, 0),(2472150, 42, 4448.54, -7273.33, 95.8551, 0, 0, 0, 0, 100, 0),(2472150, 43, 4458.9, -7294.29, 95.7072, 0, 0, 0, 0, 100, 0),(2472150, 44, 4472.01, -7316.46, 93.6741, 0, 0, 0, 0, 100, 0),(2472150, 45, 4476.63, -7334.5, 89.6147, 0, 0, 0, 0, 100, 0),(2472150, 46, 4486.96, -7352.79, 87.6991, 0, 0, 0, 0, 100, 0),(2472150, 47, 4498.82, -7367.14, 87.6533, 0, 0, 0, 0, 100, 0),(2472150, 48, 4512.51, -7383.06, 86.2541, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_text WHERE entry=14464;
INSERT INTO creature_text VALUES (14464, 0, 0, 'Tiny mortals - me HERE! Doom you meet!', 14, 0, 100, 0, 0, 0, 2, 'Avalanchion Spawn');
INSERT INTO creature_text VALUES (14464, 1, 0, 'You be too scared! Me find you!', 14, 0, 100, 0, 0, 0, 2, 'Avalanchion OOC');
INSERT INTO creature_text VALUES (14464, 2, 0, 'What?! You no can beat me! Me will return!', 14, 0, 100, 0, 0, 0, 2, 'Avalanchion Death');
UPDATE creature_template SET unit_class=1, AIName='SmartAI', ScriptName='' WHERE entry=14464;
DELETE FROM smart_scripts WHERE entryorguid=14464 AND source_type=0;
INSERT INTO smart_scripts VALUES (14464, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - On Respawn - Say Line 0');
INSERT INTO smart_scripts VALUES (14464, 0, 1, 0, 1, 0, 100, 0, 180000, 300000, 180000, 300000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - Out of Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (14464, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (14464, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 146, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - On Death - Remove All Gameobjects');
INSERT INTO smart_scripts VALUES (14464, 0, 4, 0, 0, 0, 100, 0, 0, 1000, 3000, 3000, 11, 23392, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - Within Range 5-30 - Cast Boulder');
INSERT INTO smart_scripts VALUES (14464, 0, 5, 0, 0, 0, 100, 0, 0, 8000, 10000, 16000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (14464, 0, 6, 0, 0, 0, 100, 0, 3000, 11000, 15000, 26000, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avalanchion - In Combat - Cast Ground Tremor');
INSERT INTO smart_scripts VALUES (14464, 0, 10, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247216, 14462, 1, 0, 0, 0, 0, 'Avalanchion - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14464, 0, 11, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247217, 14462, 1, 0, 0, 0, 0, 'Avalanchion - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14464, 0, 12, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247218, 14462, 1, 0, 0, 0, 0, 'Avalanchion - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14464, 0, 13, 0, 11, 0, 100, 1, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 10, 247219, 14462, 1, 0, 0, 0, 0, 'Avalanchion - On Respawn - Respawn Target');
INSERT INTO smart_scripts VALUES (14464, 0, 14, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4748.31, -7160.86, 82.3083, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 15, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4786.63, -7135.98, 90.4752, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 16, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4756.69, -7114.65, 89.7484, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 17, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4707.82, -7088.9, 92.0439, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 18, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4669.64, -7128.59, 95.5044, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 19, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4622.24, -7125.71, 103.437, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 20, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4583.15, -7101.45, 95.9793, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 21, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4532.45, -7069.51, 105.254, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 22, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4520.24, -7134.03, 101.638, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 23, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4538.76, -7181.96, 108.442, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 24, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4470.76, -7193.62, 98.87, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 25, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4438.13, -7236.33, 97.9613, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 26, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4464.92, -7272.94, 98.3938, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 27, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4523.81, -7287.35, 100.579, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 28, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4466.47, -7344.25, 88.6556, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 29, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4485.29, -7405.54, 81.6972, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 30, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4539.42, -7376.79, 90.9745, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 31, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4566.54, -7434.58, 89.2819, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 32, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4538.07, -7503.54, 70.4429, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 33, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4610.4, -7478.49, 80.3099, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 34, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4632.75, -7447.73, 81.7821, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 35, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4687.43, -7438.17, 76.1585, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 36, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4705.93, -7528.15, 79.8415, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 37, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4766.07, -7446.41, 88.1181, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 38, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4716.25, -7358.45, 69.2486, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 39, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4714.05, -7295.35, 69.2923, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 40, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4756.13, -7252.54, 73.7236, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 41, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4746, -7197.88, 82.9989, 0, 'Avalanchion - On Respawn - Summon Gameobject');
INSERT INTO smart_scripts VALUES (14464, 0, 42, 0, 11, 0, 100, 1, 0, 0, 0, 0, 50, 179664, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4798.16, -7183.17, 89.342, 0, 'Avalanchion - On Respawn - Summon Gameobject');

-- Thundering Invader (14462)
UPDATE creature_template SET unit_class=1, AIName='SmartAI', ScriptName='' WHERE entry=14462;
DELETE FROM smart_scripts WHERE entryorguid=14462 AND source_type=0;
INSERT INTO smart_scripts VALUES (14462, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 89, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thundering Invader - Is Summoned - Random Move');
INSERT INTO smart_scripts VALUES (14462, 0, 1, 0, 0, 0, 100, 0, 0, 7000, 8000, 14000, 11, 23114, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thundering Invader - In Combat - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (14462, 0, 2, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thundering Invader - Out of Combat - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=14462;
INSERT INTO conditions VALUES(22, 3, 14462, 0, 0, 29, 1, 14464, 150, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- GO Earth Elemental Rift (179664)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179664;
DELETE FROM smart_scripts WHERE entryorguid=179664 AND source_type=1;
INSERT INTO smart_scripts VALUES (179664, 1, 0, 0, 60, 0, 100, 0, 0, 5000, 90000, 90000, 12, 14462, 4, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earth Elemental Rift - On Update - Summon Creature');


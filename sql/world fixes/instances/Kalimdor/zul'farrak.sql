
UPDATE creature SET spawntimesecs=86400 WHERE map=209 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=209 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Sandfury Shadowcaster (5648)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5648;
DELETE FROM smart_scripts WHERE entryorguid=5648 AND source_type=0;
INSERT INTO smart_scripts VALUES (5648, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 18396, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - On Aggro - Cast Dismounting Blast');
INSERT INTO smart_scripts VALUES (5648, 0, 1, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 20798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - Out of Combat - Cast Demon Skin');
INSERT INTO smart_scripts VALUES (5648, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (5648, 0, 3, 0, 0, 0, 100, 0, 4000, 10000, 13000, 24000, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (5648, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - Between 0-15% Health - Flee For Assist');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=5648;
INSERT INTO conditions VALUES (22, 1, 5648, 0, 0, 51, 0, 78, 0, 0, 0, 0, 0, '', 'Requires mount aura type to execute event');

-- Sandfury Blood Drinker (5649)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5649;
DELETE FROM smart_scripts WHERE entryorguid=5649 AND source_type=0;
INSERT INTO smart_scripts VALUES (5649, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 5000, 10000, 11, 11898, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Blood Drinker - In Combat - Cast Blood Leech');
INSERT INTO smart_scripts VALUES (5649, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Blood Drinker - Between 0-15% Health - Flee For Assist');

-- Sandfury Witch Doctor (5650)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=5650;
DELETE FROM smart_scripts WHERE entryorguid=5650 AND source_type=0;
INSERT INTO smart_scripts VALUES (5650, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 11899, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Witch Doctor - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (5650, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 8264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Witch Doctor - In Combat - Cast Lava Spout Totem');
INSERT INTO smart_scripts VALUES (5650, 0, 2, 0, 14, 0, 100, 0, 1500, 40, 8000, 11000, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Witch Doctor - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (5650, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Witch Doctor - Between 0-15% Health - Flee For Assist');

-- Sul'lithuz Sandcrawler (8095)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8095;
DELETE FROM smart_scripts WHERE entryorguid=8095 AND source_type=0;
INSERT INTO smart_scripts VALUES (8095, 0, 0, 0, 0, 0, 100, 0, 2000, 9000, 15000, 22000, 11, 11020, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Sul''lithuz Sandcrawler - In Combat - Cast Petrify');

-- Scarab (7269)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7269;
DELETE FROM smart_scripts WHERE entryorguid=7269 AND source_type=0;
INSERT INTO smart_scripts VALUES (7269, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 15000, 22000, 11, 3256, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Scarab - In Combat - Cast Plague Cloud');

-- Sandfury Soul Eater (7247)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7247;
DELETE FROM smart_scripts WHERE entryorguid=7247 AND source_type=0;
INSERT INTO smart_scripts VALUES (7247, 0, 0, 0, 0, 0, 100, 0, 2000, 7000, 7000, 11000, 11, 11016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Soul Eater - In Combat - Cast Soul Bite');
INSERT INTO smart_scripts VALUES (7247, 0, 1, 0, 14, 0, 100, 0, 1500, 40, 8000, 11000, 11, 7154, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Soul Eater - Friendly Missing Health - Cast Dark Offering');
INSERT INTO smart_scripts VALUES (7247, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Soul Eater - Between 0-15% Health - Flee For Assist');

-- Sandfury Shadowhunter (7246)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7246;
DELETE FROM smart_scripts WHERE entryorguid=7246 AND source_type=0;
INSERT INTO smart_scripts VALUES (7246, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 18396, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowhunter - On Aggro - Cast Dismounting Blast');
INSERT INTO smart_scripts VALUES (7246, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 15547, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowhunter - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (7246, 0, 2, 0, 0, 0, 100, 0, 4000, 10000, 13000, 24000, 11, 11641, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowhunter - In Combat - Cast Hex');
INSERT INTO smart_scripts VALUES (7246, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowhunter - Between 0-15% Health - Flee For Assist');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=7246;
INSERT INTO conditions VALUES (22, 1, 7246, 0, 0, 51, 0, 78, 0, 0, 0, 0, 0, '', 'Requires mount aura type to execute event');

-- Sul'lithuz Abomination (8120)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8120;
DELETE FROM smart_scripts WHERE entryorguid=8120 AND source_type=0;
INSERT INTO smart_scripts VALUES (8120, 0, 0, 0, 0, 0, 100, 0, 2000, 9000, 15000, 22000, 11, 11020, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Sul''lithuz Abomination - In Combat - Cast Petrify');

-- Sandfury Guardian (7268)
REPLACE INTO creature_template_addon VALUES(7268, 0, 0, 0, 4097, 0, '3417 3616');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7268;
DELETE FROM smart_scripts WHERE entryorguid=7268 AND source_type=0;


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- AT (1447)
DELETE FROM areatrigger_scripts WHERE entry=1447;
INSERT INTO areatrigger_scripts VALUES (1447, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=1447 AND source_type=2;
INSERT INTO smart_scripts VALUES (1447, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 81519, 8127, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 1 1');

-- Antu'sul <Overseer of Sul> (8127)
DELETE FROM creature_text WHERE entry=8127;
INSERT INTO creature_text VALUES (8127, 0, 0, 'The children of Sul will protect their master. Rise once more Sul''lithuz!', 14, 0, 100, 0, 0, 0, 0, 'Antu''sul');
INSERT INTO creature_text VALUES (8127, 1, 0, 'Lunch has arrived, my beautiful children. Tear them to pieces!', 14, 0, 100, 0, 0, 0, 0, 'Antu''sul');
INSERT INTO creature_text VALUES (8127, 2, 0, 'Rise and defend your master!', 14, 0, 100, 0, 0, 0, 0, 'Antu''sul');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8127;
DELETE FROM smart_scripts WHERE entryorguid=8127 AND source_type=0;
INSERT INTO smart_scripts VALUES (8127, 0, 0, 0, 0, 0, 75, 0, 5000, 5000, 17000, 17000, 11, 8376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - In Combat - Cast Earthgrab Totem');
INSERT INTO smart_scripts VALUES (8127, 0, 1, 0, 0, 0, 75, 0, 13000, 13000, 17000, 17000, 11, 11899, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (8127, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - On Aggro - Cast Antu''sul''s Minion');
INSERT INTO smart_scripts VALUES (8127, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (8127, 0, 4, 0, 0, 0, 100, 0, 5000, 5000, 12000, 14000, 11, 16006, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (8127, 0, 5, 0, 0, 0, 100, 0, 3000, 3000, 9000, 11000, 11, 15501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - In Combat - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (8127, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Antu''sul - On Data Set 1 1 - Start Attacking');
INSERT INTO smart_scripts VALUES (8127, 0, 7, 8, 2, 0, 100, 1, 0, 75, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - Between 0-75% Health - Cast Antu''sul''s Minion');
INSERT INTO smart_scripts VALUES (8127, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - Between 0-75% Health - Say Line 2');
INSERT INTO smart_scripts VALUES (8127, 0, 9, 10, 2, 0, 100, 1, 0, 25, 0, 0, 11, 11894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - Between 0-25% Health - Cast Antu''sul''s Minion');
INSERT INTO smart_scripts VALUES (8127, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - Between 0-25% Health - Say Line 0');
INSERT INTO smart_scripts VALUES (8127, 0, 11, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 11895, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Antu''sul - Between 0-20% Health - Cast Healing Wave of Antu''sul');

-- Servant of Antu'sul (8156)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8156;
DELETE FROM smart_scripts WHERE entryorguid=8156 AND source_type=0;
INSERT INTO smart_scripts VALUES (8156, 0, 0, 0, 0, 0, 100, 0, 2000, 9000, 15000, 22000, 11, 11020, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Servant of Antu''sul - In Combat - Cast Petrify');

-- Theka the Martyr (7272)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7272;
DELETE FROM smart_scripts WHERE entryorguid=7272 AND source_type=0;
INSERT INTO smart_scripts VALUES (7272, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 8000, 14000, 11, 8600, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Theka the Martyr - In Combat - Cast Fevered Plague');
INSERT INTO smart_scripts VALUES (7272, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 11089, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Theka the Martyr - Between 0-30% Health - Cast Theka Transform');

-- AT (962)
DELETE FROM areatrigger_scripts WHERE entry=962;
INSERT INTO areatrigger_scripts VALUES (962, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=962 AND source_type=2;
INSERT INTO smart_scripts VALUES (962, 2, 0, 0, 46, 0, 100, 0, 0, 0, 0, 0, 2, 37, 0, 0, 0, 0, 0, 10, 81524, 7271, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Faction');

-- Witch Doctor Zum'rah (7271)
DELETE FROM creature_text WHERE entry=7271;
INSERT INTO creature_text VALUES (7271, 0, 0, "Sands consume you!", 14, 0, 100, 0, 0, 5872, 0, 'Witch Doctor Zumrah');
INSERT INTO creature_text VALUES (7271, 1, 0, "Fall!", 14, 0, 100, 0, 0, 5873, 0, 'Witch Doctor Zumrah');
UPDATE creature_template SET faction=35, unit_flags=32832, AIName='SmartAI', ScriptName='' WHERE entry=7271;
DELETE FROM smart_scripts WHERE entryorguid=7271 AND source_type=0;
INSERT INTO smart_scripts VALUES (7271, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - On Reset - Restore faction');
INSERT INTO smart_scripts VALUES (7271, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 12000, 16000, 11, 15245, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - In Combat - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (7271, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 3000, 4000, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - In Combat - Cast Spell Shadow Bolt');
INSERT INTO smart_scripts VALUES (7271, 0, 3, 0, 0, 0, 100, 0, 2000, 5000, 30000, 36000, 11, 11086, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - In Combat - Cast Spell Ward of Zumrah');
INSERT INTO smart_scripts VALUES (7271, 0, 4, 0, 2, 0, 100, 0, 0, 70, 10000, 20000, 11, 12491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - Between Health 0-70% - Cast Spell Healing Wave');
INSERT INTO smart_scripts VALUES (7271, 0, 5, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - On Kill - Say line 1');
INSERT INTO smart_scripts VALUES (7271, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Witch Doctor Zum''rah - On Aggro - Say line 0');

-- Hydromancer Velratha (7795)
DELETE FROM waypoint_data WHERE id=815700;
INSERT INTO waypoint_data VALUES (815700, 1, 1700.79, 1207.33, 9.19393, 0, 0, 0, 0, 100, 0),(815700, 2, 1706.89, 1201.08, 9.13789, 0, 0, 0, 0, 100, 0),(815700, 3, 1706.89, 1201.08, 9.13789, 0, 0, 0, 0, 100, 0),(815700, 4, 1692.87, 1185.46, 9.00613, 0, 0, 0, 0, 100, 0),(815700, 5, 1685.58, 1177.91, 8.89423, 0, 0, 0, 0, 100, 0),(815700, 6, 1670.49, 1163.31, 8.96196, 0, 0, 0, 0, 100, 0),(815700, 7, 1658.95, 1153.1, 9.25423, 0, 0, 0, 0, 100, 0),(815700, 8, 1658.95, 1153.1, 9.25423, 0, 0, 0, 0, 100, 0),(815700, 9, 1644.42, 1160.54, 8.87816, 0, 0, 0, 0, 100, 0),(815700, 10, 1631.59, 1175.91, 8.87691, 0, 0, 0, 0, 100, 0),
(815700, 11, 1629.88, 1187.45, 8.87934, 0, 0, 0, 0, 100, 0),(815700, 12, 1634.53, 1195.98, 8.87689, 0, 0, 0, 0, 100, 0),(815700, 13, 1640.5, 1202.38, 8.87689, 0, 0, 0, 0, 100, 0),(815700, 14, 1656.76, 1215.66, 9.18158, 0, 0, 0, 0, 100, 0),(815700, 15, 1665.16, 1221.96, 8.87988, 0, 0, 0, 0, 100, 0),(815700, 16, 1683, 1229.3, 8.87689, 0, 0, 0, 0, 100, 0),(815700, 17, 1690.29, 1224.66, 8.87689, 0, 0, 0, 0, 100, 0);
UPDATE creature SET MovementType=2 WHERE guid=81570 AND id=7795;
REPLACE INTO creature_addon VALUES(81570, 815700, 0, 0, 4097, 0, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7795;
DELETE FROM smart_scripts WHERE entryorguid=7795 AND source_type=0;
INSERT INTO smart_scripts VALUES (7795, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 10180, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hydromancer Velratha - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (7795, 0, 1, 0, 14, 0, 100, 0, 1000, 30, 8000, 11000, 11, 12491, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Hydromancer Velratha - Friendly Missing Health - Cast Healing Wave');

-- Sandfury Executioner (7274)
DELETE FROM creature_text WHERE entry=7274;
INSERT INTO creature_text VALUES (7274, 0, 0, "Let the executions begin!", 14, 0, 100, 0, 0, 5874, 0, 'Sandfury Executioner');
INSERT INTO creature_text VALUES (7274, 1, 0, "Justice is done!", 14, 0, 100, 0, 0, 5875, 0, 'Sandfury Executioner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7274;
DELETE FROM smart_scripts WHERE entryorguid=7274 AND source_type=0;
INSERT INTO smart_scripts VALUES (7274, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Executioner - On Aggro - Say line 0');
INSERT INTO smart_scripts VALUES (7274, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 7366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Executioner - On Aggro - Cast Berserker Stance');
INSERT INTO smart_scripts VALUES (7274, 0, 2, 0, 0, 0, 100, 0, 3000, 8000, 7000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Executioner - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (7274, 0, 3, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Executioner - On Kill - Say line 1');

-- Ruuzlu (7797)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7797;
DELETE FROM smart_scripts WHERE entryorguid=7797 AND source_type=0;
INSERT INTO smart_scripts VALUES (7797, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ruuzlu - On Aggro - Cast Berserker Stance');
INSERT INTO smart_scripts VALUES (7797, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 7000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuzlu - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (7797, 0, 2, 0, 12, 0, 100, 0, 0, 20, 7000, 11000, 11, 38959, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruuzlu - Target Between Health 0-20% - Cast Execute');

-- Chief Ukorz Sandscalp (7267)
DELETE FROM creature_text WHERE entry=7267;
INSERT INTO creature_text VALUES (7267, 0, 0, "Feel the fury of the sands!", 14, 0, 100, 0, 0, 5879, 0, 'Chief Ukorz Sandscalp');
INSERT INTO creature_text VALUES (7267, 1, 0, "The Sandfury reign supreme!", 14, 0, 100, 0, 0, 5878, 0, 'Chief Ukorz Sandscalp');
INSERT INTO creature_text VALUES (7267, 2, 0, "This desert be mine!", 14, 0, 100, 0, 0, 5876, 0, 'Chief Ukorz Sandscalp');
INSERT INTO creature_text VALUES (7267, 3, 0, "Die outlander!", 14, 0, 100, 0, 0, 5877, 0, 'Chief Ukorz Sandscalp');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7267;
DELETE FROM smart_scripts WHERE entryorguid=7267 AND source_type=0;
INSERT INTO smart_scripts VALUES (7267, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - On Aggro - Say line 2');
INSERT INTO smart_scripts VALUES (7267, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 7366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - On Aggro - Cast Berserker Stance');
INSERT INTO smart_scripts VALUES (7267, 0, 2, 0, 0, 0, 100, 0, 3000, 8000, 7000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (7267, 0, 3, 4, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - Between Health 0-30% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (7267, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - Between Health 0-30% - Say Line 1');
INSERT INTO smart_scripts VALUES (7267, 0, 5, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chief Ukorz Sandscalp - On Kill - Say line 3');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Shallow Grave (128308)
-- GO Shallow Grave (128403)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(128308, 128403);
DELETE FROM smart_scripts WHERE entryorguid IN(128308, 128403) AND source_type=1;
INSERT INTO smart_scripts VALUES(128308, 1, 0, 0, 64, 0, 100, 257, 0, 0, 0, 0, 11, 10247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Cast Summon Zul''Farrak Zombies');
INSERT INTO smart_scripts VALUES(128403, 1, 0, 0, 64, 0, 100, 257, 0, 0, 0, 0, 11, 10247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Cast Summon Zul''Farrak Zombies');

-- Zul'Farrak Zombie (7286)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7286;
DELETE FROM smart_scripts WHERE entryorguid=7286 AND source_type=0;
INSERT INTO smart_scripts VALUES (7286, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 'Zul''Farrak Zombie - On Reset - Attack Start');

-- Zul'Farrak Dead Hero (7276)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7276;
DELETE FROM smart_scripts WHERE entryorguid=7276 AND source_type=0;
INSERT INTO smart_scripts VALUES (7276, 0, 0, 0, 0, 0, 100, 0, 2000, 11000, 14000, 21000, 11, 3427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zul''Farrak Dead Hero - In Combat - Cast Infected Wound');
INSERT INTO smart_scripts VALUES (7276, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 'Zul''Farrak Dead Hero - On Reset - Attack Start');

-- SPELL Summon Zul'Farrak Zombies (10247)
DELETE FROM spell_script_names WHERE spell_id IN(10247);
INSERT INTO spell_script_names VALUES(10247, "spell_zulfarrak_summon_zulfarrak_zombies");

-- Murta Grimgut (7608)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7608;
DELETE FROM smart_scripts WHERE entryorguid=7608 AND source_type=0;
INSERT INTO smart_scripts VALUES (7608, 0, 0, 0, 14, 0, 100, 0, 500, 40, 8000, 11000, 11, 11640, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (7608, 0, 1, 0, 14, 0, 100, 0, 1000, 40, 8000, 11000, 11, 11974, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Friendly Missing Health - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (7608, 0, 2, 0, 14, 0, 100, 0, 1000, 40, 8000, 11000, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (7608, 0, 3, 0, 0, 0, 100, 0, 1000, 2000, 3000, 6000, 11, 9734, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (7608, 0, 4, 0, 34, 0, 100, 1, 8, 1, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murta Grimgut - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7608, 0, 5, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1891.57, 1228.68, 9.69, 4.68, 'Murta Grimgut - On Data Set - Set Home Pos');
INSERT INTO smart_scripts VALUES (7608, 0, 6, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1891.83, 1201.45, 8.87, 4.68, 'Murta Grimgut - On Data Set - Set Home Pos');

-- Oro Eyegouge (7606)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7606;
DELETE FROM smart_scripts WHERE entryorguid=7606 AND source_type=0;
INSERT INTO smart_scripts VALUES (7606, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 5000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (7606, 0, 1, 0, 0, 0, 100, 0, 6000, 11000, 23000, 35000, 11, 11990, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (7606, 0, 2, 0, 0, 0, 100, 0, 13000, 15000, 23000, 35000, 11, 11962, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (7606, 0, 3, 0, 0, 0, 100, 0, 0, 15000, 60000, 60000, 11, 12741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (7606, 0, 4, 0, 34, 0, 100, 1, 8, 1, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oro Eyegouge - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7606, 0, 5, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1897.23, 1228.34, 9.43, 4.68, 'Oro Eyegouge - On Data Set - Set Home Pos');
INSERT INTO smart_scripts VALUES (7606, 0, 6, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1894.50, 1204.40, 8.87, 4.68, 'Oro Eyegouge - On Data Set - Set Home Pos');

-- Raven (7605)
REPLACE INTO creature_template_addon VALUES (7605, 0, 0, 0, 4097, 0, '7276');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7605;
DELETE FROM smart_scripts WHERE entryorguid=7605 AND source_type=0;
INSERT INTO smart_scripts VALUES (7605, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raven - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (7605, 0, 1, 0, 0, 0, 100, 0, 6000, 11000, 23000, 35000, 11, 12540, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Raven - In Combat - Cast Gouge');
INSERT INTO smart_scripts VALUES (7605, 0, 2, 0, 67, 0, 100, 0, 6000, 6000, 0, 0, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Raven - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (7605, 0, 3, 0, 34, 0, 100, 1, 8, 1, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raven - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7605, 0, 4, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1883.68, 1227.95, 9.543, 4.68, 'Raven - On Data Set - Set Home Pos');
INSERT INTO smart_scripts VALUES (7605, 0, 5, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1874.11, 1206.17, 8.87, 4.68, 'Raven - On Data Set - Set Home Pos');

-- Weegli Blastfuse (7607)
DELETE FROM gossip_menu WHERE entry=940;
INSERT INTO gossip_menu VALUES (940, 1511),(940, 1513),(940, 1514);
DELETE FROM gossip_menu_option WHERE menu_id=940;
INSERT INTO gossip_menu_option VALUES (940, 0, 0, 'Will you blow up that door now?', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=940;
INSERT INTO conditions VALUES (14, 940, 1511, 0, 0, 13, 1, 0, 0, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 0');
INSERT INTO conditions VALUES (14, 940, 1513, 0, 0, 13, 1, 0, 1, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 1');
INSERT INTO conditions VALUES (14, 940, 1514, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 3');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=940;
INSERT INTO conditions VALUES (15, 940, 0, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Show Gossip Option if GetData(0) == 3');
DELETE FROM creature_text WHERE entry=7607;
INSERT INTO creature_text VALUES (7607, 0, 0, 'Oh no! Here they come!', 12, 0, 100, 0, 0, 0, 0, 'weegli blastfuse SAY_WEEGLI_OHNO');
INSERT INTO creature_text VALUES (7607, 1, 0, 'Ok, here I go!', 12, 0, 100, 0, 0, 0, 0, 'weegli blastfuse SAY_WEEGLI_OK_I_GO');
INSERT INTO creature_text VALUES (7607, 2, 0, 'I''m out of here!', 12, 0, 100, 0, 0, 0, 0, 'weegli blastfuse');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7607;
DELETE FROM smart_scripts WHERE entryorguid=7607 AND source_type=0;
INSERT INTO smart_scripts VALUES (7607, 0, 0, 0, 0, 0, 100, 0, 6000, 11000, 13000, 25000, 11, 8858, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (7607, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (7607, 0, 2, 0, 0, 0, 100, 0, 6000, 20000, 23000, 45000, 11, 21688, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - In Combat - Cast Goblin Land Mine');
INSERT INTO smart_scripts VALUES (7607, 0, 3, 0, 34, 0, 100, 1, 8, 1, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7607, 0, 4, 5, 62, 0, 100, 257, 940, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Gossip Select - Set NPC Flags');
INSERT INTO smart_scripts VALUES (7607, 0, 5, 7, 61, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - Linked - Say Line 1');
INSERT INTO smart_scripts VALUES (7607, 0, 6, 7, 38, 0, 100, 257, 1, 2, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Data Set - Set NPC Flags');
INSERT INTO smart_scripts VALUES (7607, 0, 7, 0, 61, 0, 100, 257, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1858.57, 1146.35, 14.745, 0, 'Weegli Blastfuse - Linked - Move To Pos');
INSERT INTO smart_scripts VALUES (7607, 0, 8, 0, 34, 0, 100, 257, 8, 2, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (7607, 0, 9, 10, 59, 0, 100, 257, 1, 0, 0, 0, 11, 10772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event - Cast Plant explosives');
INSERT INTO smart_scripts VALUES (7607, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1871.18, 1100.0, 8.88, 0, 'Weegli Blastfuse - On Timed Event - Move To Pos');
INSERT INTO smart_scripts VALUES (7607, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event - Despawn');
INSERT INTO smart_scripts VALUES (7607, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli Blastfuse - On Timed Event - Say Line 2');
INSERT INTO smart_scripts VALUES (7607, 0, 13, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1878.02, 1227.65, 9.485, 4.68, 'Weegli Blastfuse - On Data Set - Set Home Pos');
INSERT INTO smart_scripts VALUES (7607, 0, 14, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1877.52, 1199.63, 8.87, 4.68, 'Weegli Blastfuse - On Data Set - Set Home Pos');

-- GO Troll Cage (141070)
-- GO Troll Cage (141071)
-- GO Troll Cage (141072)
-- GO Troll Cage (141073)
-- GO Troll Cage (141074)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(141070, 141071, 141072, 141073, 141074);
DELETE FROM smart_scripts WHERE entryorguid IN(141070, 141071, 141072, 141073, 141074) AND source_type=1;
INSERT INTO smart_scripts VALUES(141070, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7604, 50, 0, 0, 0, 0, 0, 'Troll Cage - On Gossip Hello - Set Data 1 1');
INSERT INTO smart_scripts VALUES(141071, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7604, 50, 0, 0, 0, 0, 0, 'Troll Cage - On Gossip Hello - Set Data 1 1');
INSERT INTO smart_scripts VALUES(141072, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7604, 50, 0, 0, 0, 0, 0, 'Troll Cage - On Gossip Hello - Set Data 1 1');
INSERT INTO smart_scripts VALUES(141073, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7604, 50, 0, 0, 0, 0, 0, 'Troll Cage - On Gossip Hello - Set Data 1 1');
INSERT INTO smart_scripts VALUES(141074, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7604, 50, 0, 0, 0, 0, 0, 'Troll Cage - On Gossip Hello - Set Data 1 1');

-- SPELL Unlocking (10738)
DELETE FROM event_scripts WHERE id=2609;
DELETE FROM spell_script_names WHERE spell_id IN(10738);
INSERT INTO spell_script_names VALUES(10738, "spell_zulfarrak_unlocking");

-- Sergeant Bly (7604)
DELETE FROM gossip_menu WHERE entry=941;
INSERT INTO gossip_menu VALUES (941, 1515),(941, 1516),(941, 1517);
DELETE FROM gossip_menu_option WHERE menu_id=941;
INSERT INTO gossip_menu_option VALUES (941, 0, 0, 'That''s it! I''m tired of helping you out. It''s time we settled things on the battlefield!', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=941;
INSERT INTO conditions VALUES (14, 941, 1515, 0, 0, 13, 1, 0, 0, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 0');
INSERT INTO conditions VALUES (14, 941, 1516, 0, 0, 13, 1, 0, 1, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 1');
INSERT INTO conditions VALUES (14, 941, 1517, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 3');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=941;
INSERT INTO conditions VALUES (15, 941, 0, 0, 0, 13, 1, 0, 3, 0, 0, 0, 0, '', 'Show Gossip Option if GetData(0) == 3');
DELETE FROM creature_text WHERE entry=7604;
INSERT INTO creature_text VALUES (7604, 0, 0, 'What? How dare you say that to me?!?', 12, 0, 100, 6, 0, 0, 0, 'Sergeant Bly');
INSERT INTO creature_text VALUES (7604, 1, 0, 'After all we''ve been through? Well, I didn''t like you anyway!!', 12, 0, 100, 5, 0, 0, 0, 'Sergeant Bly');
INSERT INTO creature_text VALUES (7604, 2, 0, 'Let''s move forward!', 12, 0, 100, 0, 0, 0, 0, 'Sergeant Bly');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7604;
DELETE FROM smart_scripts WHERE entryorguid=7604 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(7604*100, 7604*100+1, 7604*100+2, 7604*100+3) AND source_type=9;
INSERT INTO smart_scripts VALUES (7604, 0, 0, 0, 38, 0, 100, 257, 1, 1, 0, 0, 80, 7604*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set - Run Script');
INSERT INTO smart_scripts VALUES (7604, 0, 1, 2, 34, 0, 100, 257, 8, 1, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7604, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 7604*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Movement Inform - Run Script');
INSERT INTO smart_scripts VALUES (7604, 0, 3, 0, 0, 0, 100, 0, 3000, 10000, 9000, 15000, 11, 12170, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast Revenge');
INSERT INTO smart_scripts VALUES (7604, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reset - Cast Improved Blocking III');
INSERT INTO smart_scripts VALUES (7604, 0, 5, 0, 0, 0, 100, 0, 3000, 10000, 17000, 27000, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (7604, 0, 6, 0, 77, 0, 100, 257, 1, 2, 0, 0, 80, 7604*100+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Counter Set - Run Script');
INSERT INTO smart_scripts VALUES (7604, 0, 7, 8, 62, 0, 100, 257, 941, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Select - Close Gossip');
INSERT INTO smart_scripts VALUES (7604, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Select - Set Orientation');
INSERT INTO smart_scripts VALUES (7604, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 7604*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Select - Run Script');
INSERT INTO smart_scripts VALUES (7604, 0, 10, 0, 34, 0, 100, 257, 8, 2, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7604, 0, 11, 0, 34, 0, 100, 257, 8, 3, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Movement Inform - Set Home Pos');
INSERT INTO smart_scripts VALUES (7604*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Active');
INSERT INTO smart_scripts VALUES (7604*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 7605, 20, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target');
INSERT INTO smart_scripts VALUES (7604*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 19, 7606, 20, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target');
INSERT INTO smart_scripts VALUES (7604*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 3, 0, 0, 0, 0, 0, 19, 7607, 20, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target');
INSERT INTO smart_scripts VALUES (7604*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 4, 0, 0, 0, 0, 0, 19, 7608, 20, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Store Target');
INSERT INTO smart_scripts VALUES (7604*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (7604*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (7604*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (7604*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (7604*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Walk');
INSERT INTO smart_scripts VALUES (7604*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1884.99, 1263.0, 41.52, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 1882.5, 1263.0, 41.52, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 1886.14, 1266.98, 41.58, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 1890.0, 1263.0, 41.52, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 1888.39, 1268.03, 41.52, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Instance Data 0 to 1');
INSERT INTO smart_scripts VALUES (7604*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100, 9, 23, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 3, 0, 0, 0, 100, 0, 80000, 80000, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 4, 0, 0, 0, 100, 0, 100000, 100000, 0, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1887.92, 1228.179, 9.98, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 1883.68, 1227.95, 9.543, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 1897.23, 1228.34, 9.43, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 1878.02, 1227.65, 9.485, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 1891.57, 1228.68, 9.69, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 2');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1887.92, 1228.179, 9.98, 4.68, 'Sergeant Bly - Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+1, 9, 18, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1883.82, 1200.83, 8.87, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 1874.11, 1206.17, 8.87, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 1894.50, 1204.40, 8.87, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 1877.52, 1199.63, 8.87, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 1891.83, 1201.45, 8.87, 0, 'Sergeant Bly - Script9 - Move Point');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1883.82, 1200.83, 8.87, 4.68, 'Sergeant Bly - Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Instance Data 0 to 3');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 11, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+2, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set NPC Flag');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Run');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Say Line 1');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (7604*100+3, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Set Faction');
DELETE FROM creature_summon_groups WHERE summonerId=7604;
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7789, 1894.64, 1206.29, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1890.08, 1218.68, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8876, 1883.76, 1222.3, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7789, 1874.18, 1221.24, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1892.28, 1225.49, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7788, 1889.94, 1212.21, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1879.02, 1223.06, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7789, 1874.45, 1204.44, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8876, 1898.23, 1217.97, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1882.07, 1225.7, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8877, 1896.46, 1205.62, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1886.97, 1225.86, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1894.72, 1221.91, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1883.5, 1218.25, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7787, 1886.93, 1221.4, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8876, 1889.82, 1222.51, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7788, 1893.07, 1215.26, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7788, 1878.57, 1214.16, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 7788, 1883.74, 1212.35, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8877, 1877, 1207.27, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8877, 1873.63, 1204.65, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8876, 1877.4, 1216.41, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 1, 8877, 1899.63, 1202.52, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7789, 1902.83, 1223.41, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8876, 1889.82, 1222.51, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1883.5, 1218.25, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7788, 1883.74, 1212.35, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8877, 1877, 1207.27, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1890.08, 1218.68, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7789, 1894.64, 1206.29, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8876, 1877.4, 1216.41, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1892.28, 1225.49, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7788, 1893.07, 1215.26, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8877, 1896.46, 1205.62, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7789, 1874.45, 1204.44, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7789, 1874.18, 1221.24, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1879.02, 1223.06, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8876, 1898.23, 1217.97, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1882.07, 1225.7, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8877, 1873.63, 1204.65, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1886.97, 1225.86, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7788, 1878.57, 1214.16, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1894.72, 1221.91, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7787, 1886.93, 1221.4, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8876, 1883.76, 1222.3, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 7788, 1889.94, 1212.21, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 2, 8877, 1899.63, 1202.52, 8.87, 0.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 3, 7788, 1872.82, 1203.66, 8.87, 0.2, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 3, 7787, 1898.18, 1200.00, 8.88, 1.78, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 3, 7787, 1870.57, 1198.00, 8.87, 0.5, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 3, 8876, 1907.39, 1204.74, 8.87, 2.18, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 3, 7788, 1878.03, 1202.31, 8.87, 1.0, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 4, 7275, 1885.40, 1199.52, 8.88, 1.54, 8, 0);
INSERT INTO creature_summon_groups VALUES (7604, 0, 4, 7796, 1883.00, 1199.64, 8.88, 0.0, 8, 0);

-- Sandfury Cretin (7789)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7789;
DELETE FROM smart_scripts WHERE entryorguid=7789 AND source_type=0;
INSERT INTO smart_scripts VALUES (7789, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 1200000, 1200000, 11, 20798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - In Combat - Cast Demon Skin');
INSERT INTO smart_scripts VALUES (7789, 0, 1, 0, 0, 0, 100, 0, 0, 8000, 12000, 20000, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (7789, 0, 2, 0, 1, 0, 100, 257, 8000, 90000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1884.99, 1263.0, 41.52, 0, 'Sandfury Cretin - Out of Combat - Move Point');
INSERT INTO smart_scripts VALUES (7789, 0, 3, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Cretin - Is Summoned By - Move Random');

-- Sandfury Slave (7787)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7787;
DELETE FROM smart_scripts WHERE entryorguid=7787 AND source_type=0;
INSERT INTO smart_scripts VALUES (7787, 0, 0, 0, 1, 0, 100, 257, 8000, 90000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1882.5, 1263.0, 41.52, 0, 'Sandfury Slave - Out of Combat - Move Point');
INSERT INTO smart_scripts VALUES (7787, 0, 1, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Slave - Is Summoned By - Move Random');

-- Sandfury Drudge (7788)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7788;
DELETE FROM smart_scripts WHERE entryorguid=7788 AND source_type=0;
INSERT INTO smart_scripts VALUES (7788, 0, 0, 0, 1, 0, 100, 257, 8000, 90000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1882.5, 1263.0, 41.52, 0, 'Sandfury Drudge - Out of Combat - Move Point');
INSERT INTO smart_scripts VALUES (7788, 0, 1, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Drudge - Is Summoned By - Move Random');

-- Sandfury Zealot (8877)
DELETE FROM creature_text WHERE entry=8877;
INSERT INTO creature_text VALUES (8877, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Sandfury Zealot');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8877;
DELETE FROM smart_scripts WHERE entryorguid=8877 AND source_type=0;
INSERT INTO smart_scripts VALUES (8877, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Between Health 0-30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (8877, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Between Health 0-30% - Say Line 0');
INSERT INTO smart_scripts VALUES (8877, 0, 2, 0, 1, 0, 100, 257, 8000, 90000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1882.5, 1263.0, 41.52, 0, 'Sandfury Zealot - Out of Combat - Move Point');
INSERT INTO smart_scripts VALUES (8877, 0, 3, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Zealot - Is Summoned By - Move Random');

-- Sandfury Acolyte (8876)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8876;
DELETE FROM smart_scripts WHERE entryorguid=8876 AND source_type=0;
INSERT INTO smart_scripts VALUES (8876, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (8876, 0, 1, 0, 0, 0, 100, 0, 4000, 11000, 13000, 24000, 11, 11981, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (8876, 0, 2, 0, 0, 0, 100, 0, 0, 8000, 12000, 20000, 11, 11639, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (8876, 0, 3, 0, 0, 0, 100, 0, 0, 22000, 32000, 50000, 11, 11980, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (8876, 0, 4, 0, 1, 0, 100, 257, 8000, 90000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1884.99, 1263.0, 41.52, 0, 'Sandfury Acolyte - Out of Combat - Move Point');
INSERT INTO smart_scripts VALUES (8876, 0, 5, 0, 54, 0, 100, 257, 0, 90000, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - Is Summoned By - Move Random');
INSERT INTO smart_scripts VALUES (8876, 0, 6, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Acolyte - Between 0-15% Health - Flee For Assist');

-- Shadowpriest Sezz'ziz (7275)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7275;
DELETE FROM smart_scripts WHERE entryorguid=7275 AND source_type=0;
INSERT INTO smart_scripts VALUES (7275, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 15537, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowpriest Sezz''ziz - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (7275, 0, 1, 0, 14, 0, 100, 0, 700, 40, 10000, 15000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowpriest Sezz''ziz - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (7275, 0, 2, 0, 14, 0, 100, 0, 1500, 40, 7000, 10000, 11, 12039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadowpriest Sezz''ziz - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (7275, 0, 3, 0, 0, 0, 100, 0, 0, 16000, 22000, 30000, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowpriest Sezz''ziz - In Combat - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES (7275, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 7604, 100, 0, 0, 0, 0, 0, 'Shadowpriest Sezz''ziz - On Death - Set Counter');

-- Nekrum Gutchewer (7796)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7796;
DELETE FROM smart_scripts WHERE entryorguid=7796 AND source_type=0;
INSERT INTO smart_scripts VALUES (7796, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 19471, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nekrum Gutchewer - On Aggro - Cast Berserker Charge');
INSERT INTO smart_scripts VALUES (7796, 0, 1, 0, 0, 0, 100, 0, 0, 20000, 30000, 60000, 11, 8600, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Nekrum Gutchewer - In Combat - Cast Fevered Plague');
INSERT INTO smart_scripts VALUES (7796, 0, 2, 0, 0, 0, 100, 0, 0, 16000, 12000, 20000, 11, 26141, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nekrum Gutchewer - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (7796, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 7604, 100, 0, 0, 0, 0, 0, 'Nekrum Gutchewer - On Death - Set Counter');

-- GO Weegli's Armed Barrel (141612)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=141612;
DELETE FROM smart_scripts WHERE entryorguid=141612 AND source_type=1;
INSERT INTO smart_scripts VALUES(141612, 1, 0, 1, 60, 0, 100, 257, 7000, 7000, 0, 0, 131, 2, 0, 0, 0, 0, 0, 20, 146084, 30, 0, 0, 0, 0, 0, 'Weegli''s Armed Barrel - On Update - Set GO State');
INSERT INTO smart_scripts VALUES(141612, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Weegli''s Armed Barrel - On Update - Set GO State');

-- SPELL Blow Zul'Farrak Door (11195)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=11195;
INSERT INTO conditions VALUES (13, 1, 11195, 0, 0, 31, 0, 5, 146084, 0, 0, 0, 0, '', 'Blow Zul''Farrak Door - Target End Door');

-- GO Gong of Zul'Farrak (141832)
DELETE FROM event_scripts WHERE id=2488;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=141832;
DELETE FROM smart_scripts WHERE entryorguid=141832 AND source_type=1;
INSERT INTO smart_scripts VALUES(141832, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 12, 7273, 8, 0, 0, 0, 0, 8, 0, 0, 0, 1659.43, 1180.50, 1.05, 0.78, 'Gong of Zul''Farrak - On Gossip Hello - Summon Creature');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=141832;
INSERT INTO conditions VALUES (22, 1, 141832, 1, 0, 13, 1, 1, 0, 0, 0, 0, 0, '', 'Run event if GetData(1) == 0');

-- Gahz'rilla (7273)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7273;
DELETE FROM smart_scripts WHERE entryorguid=7273 AND source_type=0;
INSERT INTO smart_scripts VALUES (7273, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1696.91, 1216.6, 8.88, 0, 'Gahz''rilla - On AI Init - Move To Pos');
INSERT INTO smart_scripts VALUES (7273, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - On AI Init - Set Unit Flags');
INSERT INTO smart_scripts VALUES (7273, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (7273, 0, 3, 0, 0, 0, 100, 0, 3000, 7000, 7000, 13000, 11, 11131, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - In Combat - Cast Icicle');
INSERT INTO smart_scripts VALUES (7273, 0, 4, 0, 0, 0, 100, 0, 0, 16000, 15000, 25000, 11, 11836, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - In Combat - Cast Freeze Solid');
INSERT INTO smart_scripts VALUES (7273, 0, 5, 0, 0, 0, 100, 0, 10000, 16000, 25000, 35000, 11, 11902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - In Combat - Cast Gahz''rilla Slam');
INSERT INTO smart_scripts VALUES (7273, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gahz''rilla - On Death - Set Instance Data 1 to 3');

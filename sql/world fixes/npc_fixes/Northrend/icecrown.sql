
-- Scourge Banner-Bearer (31900)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18405;
DELETE FROM smart_scripts WHERE entryorguid=18405 AND source_type=0;
INSERT INTO smart_scripts VALUES (18405, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 59942, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Banner-Bearer - Out of Combat - Cast Spell Scourge Baner-Bearer');
INSERT INTO smart_scripts VALUES (18405, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 11, 60023, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Banner-Bearer - Out of Combat - Cast Spell Scourge Baner Aura');
INSERT INTO smart_scripts VALUES (18405, 0, 2, 0, 0, 0, 100, 0, 500, 1000, 2000, 2000, 11, 16583, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Banner-Bearer - In Combat - Cast Spell Shadow Shock');
INSERT INTO smart_scripts VALUES (18405, 0, 3, 0, 9, 0, 100, 0, 0, 10, 10000, 15000, 11, 32712, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Banner-Bearer - Within Range 0-10yd - Cast Spell Shadow Nova');

-- Firehawk Mariner Male (Dead) (35083)
-- Kvaldir Berserker (dead) (35080)
-- Kvaldir Harpooner (Dead) (35084)
-- Firehawk Mariner Female (Dead) (35079)
-- Wavecrest Mariner Female (Dead) (35104)
-- Wavecrest Mariner Male (Dead) (35105)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry IN(35083, 35080, 35084, 35079, 35104, 35105);

-- Eidolon Watcher (31110)
DELETE FROM spell_target_position WHERE id=58664;
INSERT INTO spell_target_position VALUES (58664, 1, 571, 8395.06, 2678.31, 657.73, 4.4);
DELETE FROM smart_scripts WHERE entryorguid=31110 AND source_type=0;
INSERT INTO smart_scripts VALUES (31110, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 11, 58548, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eidolon Watcher - On Just Summoned - Cast Ethereal');

-- Lithe Stalker (30895)
DELETE FROM spell_target_position WHERE id=58119;
INSERT INTO spell_target_position VALUES (58119, 1, 571, 6471.59, 2044.12, 571, 5.88);
UPDATE creature_template SET minlevel=80, maxlevel=80, spell1=58282, spell2=58203, spell3=57882, spell4=58283, AIName='SmartAI', ScriptName='' WHERE entry=30895;
DELETE FROM smart_scripts WHERE entryorguid=30895 AND source_type=0;
INSERT INTO smart_scripts VALUES (30895, 0, 0, 0, 27, 0, 100, 1, 0, 0, 0, 0, 85, 58117, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lithe Stalker - Passenger Boarded - Cast Force Scourge Reputation');
INSERT INTO smart_scripts VALUES (30895, 0, 1, 2, 28, 0, 100, 1, 0, 0, 0, 0, 28, 58117, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Lithe Stalker - Passenger Removed - Remove Aura Force Scourge Reputation');

-- Right and Left Camp Attack
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(38493, 38505));
DELETE FROM creature_formations WHERE leaderGUID IN(SELECT guid FROM creature WHERE id IN(38493, 38505));
INSERT INTO creature_formations VALUES (246905, 246905, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246900, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246901, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246902, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246904, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246906, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246905, 246907, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246915, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246910, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246911, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246912, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246913, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (246915, 246914, 0, 0, 5, 0, 0);
DELETE FROM creature WHERE id IN(38493, 38505);
DELETE FROM creature_addon WHERE guid IN(123535, 123528);
DELETE FROM creature WHERE id=31139 AND guid IN(123535, 123528);
INSERT INTO creature VALUES (246900, 38493, 571, 1, 1, 0, 1, 5834.96, 2190.04, 636.042, 5.70036, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246901, 38493, 571, 1, 1, 0, 1, 5831.74, 2177.88, 636.042, 0.646328, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246902, 38493, 571, 1, 1, 0, 1, 5849.19, 2175.6, 636.042, 1.54954, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246903, 38493, 571, 1, 1, 0, 1, 5847.05, 2145.87, 636.042, 6.27764, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246904, 38493, 571, 1, 1, 0, 1, 5838.32, 2201.24, 636.042, 5.67288, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246905, 38493, 571, 1, 1, 0, 1, 5872.86, 2142.04, 636.042, 2.01685, 300, 0, 0, 65165, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (246906, 38505, 571, 1, 1, 0, 1, 5845.64, 2183.07, 636.042, 2.91221, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246907, 38505, 571, 1, 1, 0, 1, 5842.6, 2189.15, 636.042, 4.322, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246910, 38505, 571, 1, 1, 0, 1, 5922.95, 2039.25, 636.041, 1.52037, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246911, 38505, 571, 1, 1, 0, 1, 5908.02, 2033.22, 636.041, 1.69708, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246912, 38505, 571, 1, 1, 0, 1, 5894.38, 2032.71, 636.041, 0.428661, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246913, 38505, 571, 1, 1, 0, 1, 5882.94, 2054.38, 636.041, 1.33187, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246914, 38505, 571, 1, 1, 0, 1, 5905.04, 2055.25, 636.041, 4.88187, 300, 0, 0, 65165, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (246915, 38493, 571, 1, 1, 0, 1, 5910.19, 2068.75, 636.041, 5.33347, 300, 0, 0, 65165, 0, 2, 0, 0, 0);
REPLACE INTO creature_addon VALUES (246904, 0, 29937, 0, 4097, 0, '');
REPLACE INTO creature_addon VALUES (246905, 2469050, 29937, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=2469050;
INSERT INTO waypoint_data VALUES (2469050, 1, 5870.29, 2147.65, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 2, 5867.22, 2155.17, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 3, 5865.35, 2163.15, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 4, 5864.42, 2172.41, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 5, 5865.06, 2179.38, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 6, 5867.25, 2189.65, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 7, 5870.01, 2198.61, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 8, 5874.43, 2205.42, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 9, 5882.62, 2205.31, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 10, 5889.66, 2201.28, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 11, 5893.07, 2195.17, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 12, 5890.64, 2188.6, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 13, 5887.31, 2182.44, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 14, 5881.91, 2174.78, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 15, 5879.15, 2167.14, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 16, 5880.75, 2159.18, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 17, 5882.9, 2155.02, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 18, 5887.01, 2146.66, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 19, 5886.56, 2142.06, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 20, 5884.42, 2136.59, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 21, 5880.85, 2133.55, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 22, 5878.56, 2133.22, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 23, 5875.22, 2134.27, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 24, 5873.69, 2135.99, 636.042, 0, 0, 0, 0, 100, 0),(2469050, 25, 5872.12, 2140.42, 636.042, 0, 0, 0, 0, 100, 0);
REPLACE INTO creature_addon VALUES (246915, 2469150, 29937, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=2469150;
INSERT INTO waypoint_data VALUES (2469150, 1, 5913.05, 2065.04, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 2, 5917.99, 2060.07, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 3, 5925.71, 2054.87, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 4, 5936.31, 2049.94, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 5, 5946.34, 2046.82, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 6, 5954.52, 2046.6, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 7, 5960.7, 2050.03, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 8, 5963.44, 2055.16, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 9, 5963.36, 2059.85, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 10, 5961.52, 2065.36, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 11, 5954.64, 2069.68, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 12, 5946.58, 2070.59, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 13, 5937.28, 2071.07, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 14, 5929.96, 2074.59, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 15, 5923.44, 2081.23, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 16, 5918.98, 2089.4, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 17, 5916.49, 2093.29, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 18, 5913.62, 2095.3, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 19, 5910.21, 2096.08, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 20, 5908.02, 2095.35, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 21, 5905.89, 2094.44, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 22, 5903.17, 2092.24, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 23, 5901.87, 2089.06, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 24, 5901.34, 2085.6, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 25, 5903.01, 2079.96, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 26, 5905.72, 2074.75, 636.041, 0, 0, 0, 0, 100, 0),(2469150, 27, 5909.18, 2070.08, 636.041, 0, 0, 0, 0, 100, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=38493;
DELETE FROM smart_scripts WHERE entryorguid IN(38493, -246904, -246915) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(38493*100, 38493*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (-246904, 0, 0, 0, 60, 0, 100, 0, 180000, 180000, 180000, 180000, 80, 38493*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argent Cruasder - On Update - Run Script');
INSERT INTO smart_scripts VALUES (-246904, 0, 1, 2, 17, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Argent Cruasder - Just Summoned - Move Target To Position');
INSERT INTO smart_scripts VALUES (-246904, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5869.55, 2192.07, 636.05, 0, 'Argent Cruasder - Just Summoned - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5869.55, 2192.07, 636.05, 0, 'Argent Cruasder - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246900, 38493, 1, 5869.55, 2192.07, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246901, 38493, 1, 5867.93, 2186.94, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246902, 38493, 1, 5866.62, 2189.55, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246906, 38505, 1, 5865.35, 2192.05, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246907, 38505, 1, 5864.19, 2194.34, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 10, 246905, 38493, 1, 5871.67, 2187.72, 636.05, 0, 'Argent Cruasder - On Script - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 12, 31139, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5940.53, 2227.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Pustulent Horror');
INSERT INTO smart_scripts VALUES (38493*100, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5940.53, 2227.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5940.53, 2227.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5943.53, 2227.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5937.53, 2227.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5940.53, 2230.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5940.53, 2224.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5943.53, 2230.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5935.53, 2225.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 5941.53, 2222.89, 636.05, 3.58, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (-246915, 0, 0, 0, 60, 0, 100, 0, 180000, 180000, 180000, 180000, 80, 38493*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argent Cruasder - On Update - Run Script');
INSERT INTO smart_scripts VALUES (-246915, 0, 1, 2, 17, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Argent Cruasder - Just Summoned - Set Data');
INSERT INTO smart_scripts VALUES (-246915, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5911.48, 2049.00, 636.05, 0, 'Argent Cruasder - Just Summoned - Move Target To Position');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 12, 31139, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6018.40, 2091.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Pustulent Horror');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6018.40, 2091.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6018.40, 2093.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6015.40, 2092.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6022.40, 2091.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6019.40, 2088.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6017.40, 2094.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6020.40, 2095.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6014.40, 2090.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
INSERT INTO smart_scripts VALUES (38493*100+1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 31147, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 6015.40, 2087.17, 636.05, 3.47, 'Argent Cruasder - On Script - Summon Creature Vicious Geist');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(31139, 31147);
DELETE FROM smart_scripts WHERE entryorguid IN(31139, 31147) AND source_type=0;
INSERT INTO smart_scripts VALUES (31139, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5911.48, 2049.00, 636.05, 0, 'Pustulent Horror - Is Summoned - Set Home Position');
INSERT INTO smart_scripts VALUES (31139, 0, 1, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5869.55, 2192.07, 636.05, 0, 'Pustulent Horror - Is Summoned - Set Home Position');
INSERT INTO smart_scripts VALUES (31147, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5911.48, 2049.00, 636.05, 0, 'Vicious Geist - Is Summoned - Set Home Position');
INSERT INTO smart_scripts VALUES (31147, 0, 1, 0, 38, 0, 100, 0, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5869.55, 2192.07, 636.05, 0, 'Vicious Geist - Is Summoned - Set Home Position');

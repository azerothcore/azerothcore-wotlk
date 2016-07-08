
-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Spitting Cobra (29774, 30941)
UPDATE creature_template SET lootid=29774, pickpocketloot=0, skinloot=70212, AIName='SmartAI', ScriptName='' WHERE entry=29774;
UPDATE creature_template SET lootid=29774, pickpocketloot=0, skinloot=70212, AIName='', ScriptName='' WHERE entry=30941;
DELETE FROM smart_scripts WHERE entryorguid=29774 AND source_type=0;
INSERT INTO smart_scripts VALUES (29774, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 7000, 11000, 11, 55700, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast Venom Spit');
INSERT INTO smart_scripts VALUES (29774, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 7000, 11000, 11, 59019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast Venom Spit');
INSERT INTO smart_scripts VALUES (29774, 0, 2, 0, 0, 0, 100, 2, 2900, 6600, 10000, 12000, 11, 55703, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast Cobra Strike');
INSERT INTO smart_scripts VALUES (29774, 0, 3, 0, 0, 0, 100, 4, 2900, 6600, 10000, 12000, 11, 59020, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast Cobra Strike');

-- Unyielding Constrictor (29768, 30942)
UPDATE creature_template SET lootid=29768, pickpocketloot=0, skinloot=70212, AIName='SmartAI', ScriptName='' WHERE entry=29768;
UPDATE creature_template SET lootid=29768, pickpocketloot=0, skinloot=70212, AIName='', ScriptName='' WHERE entry=30942;
DELETE FROM smart_scripts WHERE entryorguid=29768 AND source_type=0;
INSERT INTO smart_scripts VALUES (29768, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 7000, 11000, 11, 55602, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - In Combat - Cast Vicious Bite');
INSERT INTO smart_scripts VALUES (29768, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 7000, 11000, 11, 59021, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - In Combat - Cast Vicious Bite');
INSERT INTO smart_scripts VALUES (29768, 0, 2, 0, 0, 0, 100, 3, 1000, 1000, 0, 0, 11, 55603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - Out of Combat - Cast Puncturing Strike');
INSERT INTO smart_scripts VALUES (29768, 0, 3, 0, 1, 0, 100, 5, 1000, 1000, 0, 0, 11, 59022, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - Out of Combat - Cast Puncturing Strike');

-- Drakkari Lancer (29819, 30932)
UPDATE creature_template SET lootid=29819, pickpocketloot=29822, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29819;
UPDATE creature_template SET lootid=29819, pickpocketloot=29822, skinloot=0, AIName='', ScriptName='' WHERE entry=30932;
DELETE FROM smart_scripts WHERE entryorguid=29819 AND source_type=0;
INSERT INTO smart_scripts VALUES (29819, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 12000, 18000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (29819, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 17000, 20000, 11, 40546, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast Retaliation');
INSERT INTO smart_scripts VALUES (29819, 0, 2, 0, 0, 0, 100, 2, 1000, 12000, 17000, 20000, 11, 55622, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast Impale');
INSERT INTO smart_scripts VALUES (29819, 0, 3, 0, 0, 0, 100, 4, 1000, 12000, 17000, 20000, 11, 58978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast Impale');

-- Drakkari Fire Weaver (29822, 30927)
UPDATE creature_template SET lootid=29822, pickpocketloot=29822, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29822;
UPDATE creature_template SET lootid=29822, pickpocketloot=29822, skinloot=0, AIName='', ScriptName='' WHERE entry=30927;
DELETE FROM smart_scripts WHERE entryorguid=29822 AND source_type=0;
INSERT INTO smart_scripts VALUES (29822, 0, 0, 0, 0, 0, 100, 2, 4000, 8000, 11000, 17000, 11, 55659, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast Lava Burst');
INSERT INTO smart_scripts VALUES (29822, 0, 1, 0, 0, 0, 100, 4, 4000, 8000, 11000, 17000, 11, 58972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast Lava Burst');
INSERT INTO smart_scripts VALUES (29822, 0, 2, 0, 0, 0, 100, 2, 1000, 6000, 7000, 10000, 11, 55613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (29822, 0, 3, 0, 0, 0, 100, 4, 1000, 6000, 7000, 10000, 11, 58971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (29822, 0, 4, 0, 0, 0, 100, 0, 1000, 15000, 17000, 30000, 11, 61362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast Blast Wave');

-- Drakkari Golem (29832, 30930)
UPDATE creature_template SET lootid=29832, pickpocketloot=0, skinloot=80103, AIName='SmartAI', ScriptName='' WHERE entry=29832;
UPDATE creature_template SET lootid=29832, pickpocketloot=0, skinloot=80103, AIName='', ScriptName='' WHERE entry=30930;
DELETE FROM smart_scripts WHERE entryorguid=29832 AND source_type=0;
INSERT INTO smart_scripts VALUES (29832, 0, 0, 0, 0, 0, 100, 2, 4000, 8000, 11000, 17000, 11, 55635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Thunderclap');
INSERT INTO smart_scripts VALUES (29832, 0, 1, 0, 0, 0, 100, 4, 4000, 8000, 11000, 17000, 11, 58975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Thunderclap');
INSERT INTO smart_scripts VALUES (29832, 0, 2, 0, 0, 0, 100, 2, 1000, 9000, 17000, 20000, 11, 55636, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Shockwave');
INSERT INTO smart_scripts VALUES (29832, 0, 3, 0, 0, 0, 100, 4, 1000, 9000, 17000, 20000, 11, 58977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Shockwave');
INSERT INTO smart_scripts VALUES (29832, 0, 4, 0, 0, 0, 100, 0, 1000, 15000, 17000, 30000, 11, 55633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Body of Stone');

-- Drakkari Earthshaker (29829, 30926)
UPDATE creature_template SET lootid=29829, pickpocketloot=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29829;
UPDATE creature_template SET lootid=29829, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=30926;
DELETE FROM smart_scripts WHERE entryorguid=29829 AND source_type=0;
INSERT INTO smart_scripts VALUES (29829, 0, 0, 0, 0, 0, 100, 2, 4000, 8000, 11000, 17000, 11, 16172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast Head Crack');
INSERT INTO smart_scripts VALUES (29829, 0, 1, 0, 0, 0, 100, 4, 4000, 8000, 11000, 17000, 11, 58969, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast Head Crack');
INSERT INTO smart_scripts VALUES (29829, 0, 2, 0, 0, 0, 100, 0, 1000, 9000, 7000, 11000, 11, 55567, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast Powerful Blow');
INSERT INTO smart_scripts VALUES (29829, 0, 3, 0, 0, 0, 100, 0, 1000, 8000, 10000, 12000, 11, 55563, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast Slam Ground');

-- Drakkari Frenzy (29834, 30928)
UPDATE creature_template SET lootid=29834, pickpocketloot=0, skinloot=0, InhabitType=2, AIName='', ScriptName='' WHERE entry=29834;
UPDATE creature_template SET lootid=29834, pickpocketloot=0, skinloot=0, InhabitType=2, AIName='', ScriptName='' WHERE entry=30928;

-- Drakkari God Hunter (29820, 30929)
UPDATE creature_template SET lootid=29820, pickpocketloot=29820, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29820;
UPDATE creature_template SET lootid=29820, pickpocketloot=29820, skinloot=0, AIName='', ScriptName='' WHERE entry=30929;
DELETE FROM smart_scripts WHERE entryorguid=29820 AND source_type=0;
INSERT INTO smart_scripts VALUES (29820, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2000, 2000, 11, 35946, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (29820, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 2000, 11, 59146, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (29820, 0, 2, 0, 0, 0, 100, 2, 4000, 6000, 8000, 12000, 11, 55624, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast Arcane Shot');
INSERT INTO smart_scripts VALUES (29820, 0, 3, 0, 0, 0, 100, 4, 4000, 6000, 8000, 12000, 11, 58973, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (29820, 0, 4, 0, 4, 0, 50, 0, 0, 0, 0, 0, 11, 55798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - On Aggro - Cast Flare');
INSERT INTO smart_scripts VALUES (29820, 0, 5, 0, 0, 0, 100, 0, 1000, 11000, 20000, 32000, 11, 31567, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast Deterrence');

-- Drakkari Medicine Man (29826, 30933)
UPDATE creature_template SET lootid=29826, pickpocketloot=29820, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29826;
UPDATE creature_template SET lootid=29826, pickpocketloot=29820, skinloot=0, AIName='', ScriptName='' WHERE entry=30933;
DELETE FROM smart_scripts WHERE entryorguid=29826 AND source_type=0;
INSERT INTO smart_scripts VALUES (29826, 0, 0, 0, 16, 0, 100, 2, 55599, 30, 6000, 6000, 11, 55599, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly Missing Buff - Cast Earth Shield');
INSERT INTO smart_scripts VALUES (29826, 0, 1, 0, 16, 0, 100, 4, 58981, 30, 6000, 6000, 11, 58981, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly Missing Buff - Cast Earth Shield');
INSERT INTO smart_scripts VALUES (29826, 0, 2, 0, 14, 0, 100, 2, 15000, 30, 7250, 10000, 11, 55597, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (29826, 0, 3, 0, 14, 0, 100, 4, 15000, 30, 7250, 10000, 11, 58980, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (29826, 0, 4, 0, 15, 0, 100, 0, 30, 10000, 10000, 0, 11, 55598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly CC - Cast Cleanse Magic');

-- Drakkari Inciter (29874, 30931)
UPDATE creature_template SET lootid=29874, pickpocketloot=29874, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29874;
UPDATE creature_template SET lootid=29874, pickpocketloot=29874, skinloot=0, AIName='', ScriptName='' WHERE entry=30931;
DELETE FROM smart_scripts WHERE entryorguid=29874 AND source_type=0;
INSERT INTO smart_scripts VALUES (29874, 0, 0, 0, 0, 0, 100, 2, 2000, 6000, 5000, 6000, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Inciter - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (29874, 0, 1, 0, 0, 0, 100, 4, 2000, 6000, 5000, 6000, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Inciter - In Combat - Cast Strike');

-- Drakkari Raider (29982, 30934)
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29982;
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=30934;
DELETE FROM smart_scripts WHERE entryorguid=29982 AND source_type=0;
INSERT INTO smart_scripts VALUES (29982, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 5000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Raider - In Combat - Cast Cleave');

-- Drakkari Battle Raider (29836, 30925)
UPDATE creature_template SET lootid=29836, pickpocketloot=29836, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29836;
UPDATE creature_template SET lootid=29836, pickpocketloot=29836, skinloot=0, AIName='', ScriptName='' WHERE entry=30925;
DELETE FROM smart_scripts WHERE entryorguid=29836 AND source_type=0;
INSERT INTO smart_scripts VALUES (29836, 0, 0, 0, 0, 0, 100, 2, 0, 1000, 2000, 2000, 11, 55348, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (29836, 0, 1, 0, 0, 0, 100, 4, 0, 1000, 2000, 2000, 11, 58966, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (29836, 0, 2, 0, 0, 0, 100, 2, 0, 10000, 8000, 22000, 11, 55521, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Poisoned Spear');
INSERT INTO smart_scripts VALUES (29836, 0, 3, 0, 0, 0, 100, 4, 0, 10000, 8000, 22000, 11, 58967, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Poisoned Spear');

-- Drakkari Rhino (29931, 30936)
UPDATE creature_template SET VehicleId=209, lootid=29931, pickpocketloot=0, skinloot=70211, AIName='SmartAI', ScriptName='' WHERE entry=29931;
UPDATE creature_template SET VehicleId=209, lootid=29931, pickpocketloot=0, skinloot=70211, AIName='', ScriptName='' WHERE entry=30936;
DELETE FROM smart_scripts WHERE entryorguid=29931 AND source_type=0;
INSERT INTO smart_scripts VALUES (29931, 0, 0, 0, 9, 0, 100, 2, 5, 40, 8000, 8000, 11, 55530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - Within Range 5-40yd - Cast Charge');
INSERT INTO smart_scripts VALUES (29931, 0, 1, 0, 9, 0, 100, 4, 5, 40, 8000, 8000, 11, 58991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - Within Range 5-40yd - Cast Charge');
INSERT INTO smart_scripts VALUES (29931, 0, 2, 0, 0, 0, 100, 2, 0, 10000, 8000, 22000, 11, 55663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Deafening Roar');
INSERT INTO smart_scripts VALUES (29931, 0, 3, 0, 0, 0, 100, 4, 0, 10000, 8000, 22000, 11, 58992, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Deafening Roar');

-- Drakkari Rhino (29838, 30935)
UPDATE creature_template SET VehicleId=201, lootid=29838, pickpocketloot=0, skinloot=70212, AIName='SmartAI', ScriptName='' WHERE entry=29838;
UPDATE creature_template SET VehicleId=201, lootid=29838, pickpocketloot=0, skinloot=70212, AIName='', ScriptName='' WHERE entry=30935;
DELETE FROM smart_scripts WHERE entryorguid=29838 AND source_type=0;
INSERT INTO smart_scripts VALUES (29838, 0, 0, 0, 9, 0, 100, 2, 5, 40, 8000, 8000, 11, 55530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - Within Range 5-40yd - Cast Charge');
INSERT INTO smart_scripts VALUES (29838, 0, 1, 0, 9, 0, 100, 4, 5, 40, 8000, 8000, 11, 58991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - Within Range 5-40yd - Cast Charge');
INSERT INTO smart_scripts VALUES (29838, 0, 2, 0, 0, 0, 100, 2, 0, 10000, 8000, 22000, 11, 55663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Deafening Roar');
INSERT INTO smart_scripts VALUES (29838, 0, 3, 0, 0, 0, 100, 4, 0, 10000, 8000, 22000, 11, 58992, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Raider - In Combat - Cast Deafening Roar');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Slad'ran (29304, 31370)
DELETE FROM creature_text WHERE entry=29304;
INSERT INTO creature_text VALUES (29304, 0, 0, 'Drakkari gonna kill anybody who trassspasss on these landsss!', 14, 0, 100, 0, 0, 14443, 0, 'Slad''ran SAY_AGGRO');
INSERT INTO creature_text VALUES (29304, 1, 0, 'You not breathin''? Good.', 14, 0, 100, 0, 0, 14446, 0, 'Slad''ran SAY_SLAY_1');
INSERT INTO creature_text VALUES (29304, 1, 1, 'You ssscared now?', 14, 0, 100, 0, 0, 14447, 0, 'Slad''ran SAY_SLAY_2');
INSERT INTO creature_text VALUES (29304, 1, 2, 'I eat you next, mon.', 14, 0, 100, 0, 0, 14448, 0, 'Slad''ran SAY_SLAY_3');
INSERT INTO creature_text VALUES (29304, 2, 0, 'I sssee now... Ssscourge wasss not... our greatessst enemy....', 14, 0, 100, 0, 0, 14449, 0, 'Slad''ran SAY_DEATH');
INSERT INTO creature_text VALUES (29304, 3, 0, 'Minionsss of the scale, heed my call!', 14, 0, 100, 0, 0, 14444, 0, 'Slad''ran SAY_SUMMON_SNAKES');
INSERT INTO creature_text VALUES (29304, 4, 0, 'A thousssand fangsss gonna rend your flesh!', 14, 0, 100, 0, 0, 14445, 0, 'Slad''ran SAY_SUMMON_CONSTRICTORS');
INSERT INTO creature_text VALUES (29304, 5, 0, '%s begins to cast Poison Nova!', 41, 0, 100, 0, 0, 0, 0, 'Slad''ran - EMOTE_NOVA');
INSERT INTO creature_text VALUES (29304, 6, 0, 'As %s falls, the altar set into the floor on his balcony begins to glow faintly.', 16, 0, 100, 0, 0, 0, 0, 'Slad''ran - EMOTE_ALTAR');
UPDATE creature_template SET lootid=29304, pickpocketloot=0, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_slad_ran' WHERE entry=29304;
UPDATE creature_template SET lootid=31370, pickpocketloot=0, dmg_multiplier=22, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31370;

-- Slad'ran Summon Target (29682)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=29682;

-- Slad'ran Viper (29680, 30940)
UPDATE creature_template SET lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29680;
UPDATE creature_template SET lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=30940;
DELETE FROM smart_scripts WHERE entryorguid=29680 AND source_type=0;
INSERT INTO smart_scripts VALUES (29680, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 7000, 9000, 11, 54987, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slad''ran Viper - In Combat - Cast Venomous Bite');
INSERT INTO smart_scripts VALUES (29680, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 7000, 9000, 11, 58996, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slad''ran Viper - In Combat - Cast Venomous Bite');

-- Slad'ran Constrictor (29713, 30943)
UPDATE creature_template SET lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29713;
UPDATE creature_template SET lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=30943;
DELETE FROM smart_scripts WHERE entryorguid=29713 AND source_type=0;
INSERT INTO smart_scripts VALUES (29713, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 5000, 5000, 11, 55093, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Slad''ran Constrictor - In Combat - Cast Grip of Slad''ran');

-- Snake Wrap (29742, 32218)
UPDATE creature_template SET unit_flags=131072|4, lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29742;
UPDATE creature_template SET unit_flags=131072|4, lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=32218;
DELETE FROM smart_scripts WHERE entryorguid=29742 AND source_type=0;
INSERT INTO smart_scripts VALUES (29742, 0, 0, 1, 6, 0, 100, 0, 0, 0, 0, 0, 28, 55126, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Snake Wrap - On Death - Remove Aura');
INSERT INTO smart_scripts VALUES (29742, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Snake Wrap - On Death - Despawn');
INSERT INTO smart_scripts VALUES (29742, 0, 2, 0, 60, 0, 100, 257, 0, 0, 0, 0, 45, 29304, 0, 0, 0, 0, 0, 19, 29304, 100, 0, 0, 0, 0, 0, 'Snake Wrap - On Update - Set Data');

-- SPELL Grip of Slad'ran (55093)
DELETE FROM spell_script_names WHERE spell_id IN(55093);
INSERT INTO spell_script_names VALUES(55093, 'spell_sladran_grip_of_sladran');

-- Drakkari Colossus (29307, 31365)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29307);
DELETE FROM creature_loot_template WHERE entry IN(29307, 31365);
DELETE FROM creature_text WHERE entry=29307;
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=80103, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_drakkari_colossus' WHERE entry=29307;
UPDATE creature_template SET lootid=0, pickpocketloot=0, skinloot=80103, dmg_multiplier=22, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31365;

-- Drakkari Elemental (29573, 31367)
DELETE FROM creature_text WHERE entry=29573;
INSERT INTO creature_text VALUES (29573, 0, 0, '%s gathers its mojo and surges forward!', 16, 0, 100, 0, 0, 0, 0, 'Drakkari Elemental SAY_SURGE');
INSERT INTO creature_text VALUES (29573, 1, 0, 'As the last remnants of the %s seep into the ground, the altar set into the floor nearby begins to glow faintly.', 16, 0, 100, 0, 0, 0, 0, 'Drakkari Elemental EMOTE_ALTAR');
UPDATE creature_template SET lootid=29573, pickpocketloot=0, skinloot=0, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_drakkari_elemental' WHERE entry=29573;
UPDATE creature_template SET lootid=31367, pickpocketloot=0, skinloot=0, dmg_multiplier=22, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31367;

-- Living Mojo (29830, 30938)
UPDATE creature_template SET lootid=29830, pickpocketloot=0, skinloot=0, dmg_multiplier=7, mechanic_immune_mask=0, AIName='', ScriptName='npc_living_mojo' WHERE entry=29830;
UPDATE creature_template SET lootid=29830, pickpocketloot=0, skinloot=0, dmg_multiplier=13, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=30938;
DELETE FROM creature_addon WHERE guid IN(127071, 127072, 127073, 127074, 127075);
DELETE FROM linked_respawn WHERE guid IN(127071, 127072, 127073, 127074, 127075);
DELETE FROM creature WHERE guid IN(127071, 127072, 127073, 127074, 127075);

-- SPELL Emerge (54850)
DELETE FROM spell_linked_spell WHERE spell_trigger=54850;
DELETE FROM spell_script_names WHERE spell_id IN(54850);
INSERT INTO spell_script_names VALUES(54850, 'spell_drakkari_colossus_emerge');

-- SPELL Mojo Volley (54847, 59452)
DELETE FROM spell_script_names WHERE spell_id IN(54847, 59452);
INSERT INTO spell_script_names VALUES(54847, 'spell_gen_select_target_count_15_2');
INSERT INTO spell_script_names VALUES(59452, 'spell_gen_select_target_count_15_2');

-- SPELL Surge (54801)
DELETE FROM spell_script_names WHERE spell_id IN(54801);
INSERT INTO spell_script_names VALUES(54801, 'spell_drakkari_colossus_surge');

-- SPELL Merge (54878)
DELETE FROM conditions WHERE SourceEntry IN(54878) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 54878, 0, 0, 31, 0, 3, 29307, 0, 0, 0, 0, '', 'Target Drakkari Colossus');

-- SPELL Face Me (54991)
DELETE FROM conditions WHERE SourceEntry IN(54991) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 54991, 0, 0, 31, 0, 3, 29307, 0, 0, 0, 0, '', 'Target Drakkari Colossus');
DELETE FROM spell_script_names WHERE spell_id IN(54991);
INSERT INTO spell_script_names VALUES(54991, 'spell_drakkari_colossus_face_me');

-- Moorabi (29305, 30530)
DELETE FROM creature_text WHERE entry=29305;
INSERT INTO creature_text VALUES (29305, 0, 0, 'We fought back da Scourge. What chance joo thinkin'' JOO got?', 14, 0, 100, 0, 0, 14721, 0, 'moorabi SAY_AGGRO');
INSERT INTO creature_text VALUES (29305, 1, 0, 'Who gonna stop me? You?', 14, 0, 100, 0, 0, 14726, 0, 'moorabi SAY_SLAY_1');
INSERT INTO creature_text VALUES (29305, 1, 1, 'Not so tough now!!', 14, 0, 100, 0, 0, 14727, 0, 'moorabi SAY_SLAY_2');
INSERT INTO creature_text VALUES (29305, 1, 2, 'I crush you, cockroaches!', 14, 0, 100, 0, 0, 14725, 0, 'moorabi - SAY_SLAY_3');
INSERT INTO creature_text VALUES (29305, 2, 0, 'If our gods can die... den so can we....', 14, 0, 100, 0, 0, 14728, 0, 'moorabi SAY_DEATH');
INSERT INTO creature_text VALUES (29305, 3, 0, 'Get ready for somethin''... much... BIGGAH!' , 14, 0, 100, 0, 0, 14722, 0, 'moorabi SAY_TRANSFORM');
INSERT INTO creature_text VALUES (29305, 4, 0, 'Da ground gonna swallow you up!', 14, 0, 100, 0, 0, 14723, 0, 'moorabi SAY_QUAKE');
INSERT INTO creature_text VALUES (29305, 5, 0, '%s begins to transform!', 41, 0, 100, 0, 0, 0, 0, 'moorabi EMOTE_TRANSFORM');
INSERT INTO creature_text VALUES (29305, 6, 0, '%s transforms into mammoth!', 16, 0, 100, 0, 0, 0, 0, 'moorabi - EMOTE TRANSFORMED');
INSERT INTO creature_text VALUES (29305, 7, 0, 'As %s falls, the altar set into the floor on his balcony begins to glow faintly.', 16, 0, 100, 0, 0, 0, 0, 'moorabi - EMOTE_ALTAR');
UPDATE creature_template SET lootid=29305, pickpocketloot=0, baseattacktime=1000, dmg_multiplier=7, mechanic_immune_mask=617299839, flags_extra=0x200000, AIName='', ScriptName='boss_moorabi' WHERE entry=29305;
UPDATE creature_template SET lootid=30530, pickpocketloot=0, baseattacktime=1000, dmg_multiplier=13, mechanic_immune_mask=617299839, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=30530;

-- Phantom Mammoth (29748)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29748);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=29748);
DELETE FROM creature WHERE id=29748;
UPDATE creature_template SET unit_flags=33587968, faction=35, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=29748;

-- SPELL Mojo Frenzy (55163)
DELETE FROM spell_script_names WHERE spell_id IN(55163);
INSERT INTO spell_script_names VALUES(55163, 'spell_moorabi_mojo_frenzy');

-- SPELL Transformation (55098)
DELETE FROM spell_script_names WHERE spell_id IN(55098);

-- Eck the Ferocious (29932)
DELETE FROM creature_text WHERE entry=29307;
UPDATE creature_template SET lootid=29932, pickpocketloot=0, skinloot=0, dmg_multiplier=22, mechanic_immune_mask=650854271, flags_extra=0x200001, AIName='', ScriptName='boss_eck' WHERE entry=29932;

-- Ruins Dweller (29920, 30939)
DELETE FROM creature_text WHERE entry=29920;
INSERT INTO creature_text VALUES (29920, 0, 0, 'Something stirs in the pool of mojo...', 16, 0, 100, 0, 0, 0, 0, 'Ruins Dweller');
DELETE FROM pickpocketing_loot_template WHERE entry=29920;
UPDATE creature_template SET lootid=29920, pickpocketloot=0, skinloot=0, AIName='SmartAI', ScriptName='' WHERE entry=29920;
UPDATE creature_template SET lootid=29920, pickpocketloot=0, skinloot=0, AIName='', ScriptName='' WHERE entry=30939;
DELETE FROM smart_scripts WHERE entryorguid=29920 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=-127203 AND source_type=0;
INSERT INTO smart_scripts VALUES (29920, 0, 0, 0, 9, 0, 100, 0, 5, 30, 5000, 6000, 11, 55652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - Within Range 5-30yd - Cast Spring');
INSERT INTO smart_scripts VALUES (29920, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 14000, 11, 55643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - In Combat - Cast Regurgitate');
INSERT INTO smart_scripts VALUES (-127203, 0, 0, 0, 9, 0, 100, 0, 5, 30, 5000, 6000, 11, 55652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - Within Range 5-30yd - Cast Spring');
INSERT INTO smart_scripts VALUES (-127203, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 14000, 11, 55643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - In Combat - Cast Regurgitate');
INSERT INTO smart_scripts VALUES (-127203, 0, 2, 3, 6, 0, 100, 257, 0, 0, 0, 0, 34, 29932, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (-127203, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ruins Dweller - On Death - Talk');

-- SPELL Eck Spring (55837)
DELETE FROM spell_target_position WHERE id=55837;
INSERT INTO spell_target_position VALUES (55837, 0, 604, 1642.712, 934.646, 107.205, 0);

-- Gal'darah (29306, 31368)
DELETE FROM creature_text WHERE entry=29306;
INSERT INTO creature_text VALUES (29306, 0, 0, 'I''m gonna spill your guts, mon!', 14, 0, 100, 0, 0, 14430, 0, 'Gal''darah SAY_AGGRO');
INSERT INTO creature_text VALUES (29306, 1, 0, 'What a rush!', 14, 0, 100, 0, 0, 14436, 0, 'Gal''darah SAY_SLAY_1');
INSERT INTO creature_text VALUES (29306, 1, 1, 'Who needs gods when we ARE gods?', 14, 0, 100, 0, 0, 14437, 0, 'Gal''darah SAY_SLAY_2');
INSERT INTO creature_text VALUES (29306, 1, 2, 'I told ya so!', 14, 0, 100, 0, 0, 14438, 0, 'Gal''darah SAY_SLAY_3');
INSERT INTO creature_text VALUES (29306, 2, 0, 'Even the mighty... can fall.', 14, 0, 100, 0, 0, 14439, 0, 'Gal''darah SAY_DEATH');
INSERT INTO creature_text VALUES (29306, 3, 0, 'Gut them! Impale them!', 14, 0, 100, 0, 0, 14433, 0, 'Gal''darah SAY_SUMMON_RHINO_1');
INSERT INTO creature_text VALUES (29306, 3, 1, 'KILL THEM ALL!', 14, 0, 100, 0, 0, 14434, 0, 'Gal''darah SAY_SUMMON_RHINO_2');
INSERT INTO creature_text VALUES (29306, 3, 2, 'Say hello to my BIG friend!', 14, 0, 100, 0, 0, 14435, 0, 'Gal''darah SAY_SUMMON_RHINO_3');
INSERT INTO creature_text VALUES (29306, 4, 0, 'Ain''t gonna be nottin'' left after this!', 14, 0, 100, 0, 0, 14431, 0, 'Gal''darah SAY_TRANSFORM_1');
INSERT INTO creature_text VALUES (29306, 5, 0, 'You wanna see power? I''m gonna show you power!', 14, 0, 100, 0, 0, 14432, 0, 'Gal''darah SAY_TRANSFORM_2');
UPDATE creature_template SET lootid=29306, pickpocketloot=0, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_gal_darah' WHERE entry=29306;
UPDATE creature_template SET lootid=31368, pickpocketloot=0, dmg_multiplier=22, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31368;

-- Gal'darah Rhino (29681)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29681);
DELETE FROM creature WHERE id=29681;
UPDATE creature_template SET unit_flags=33587968, faction=35, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=29681;

-- Rhino Spirit (29791)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29791);
DELETE FROM creature WHERE id=29791;
UPDATE creature_template SET unit_flags=33554432|131072, AIName='NullCreatureAI', ScriptName='' WHERE entry=29791;

-- World Trigger (22517)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=22517;

-- SPELL Heart Beam Visual (54988)
DELETE FROM conditions WHERE SourceEntry IN(54988) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 54988, 0, 0, 31, 0, 3, 22517, 0, 0, 0, 0, '', 'Target Trigger');

-- SPELL Impaling Charge (54956, 59827)
DELETE FROM spell_script_names WHERE spell_id IN(54956, 59827);
INSERT INTO spell_script_names VALUES(54956, 'spell_galdarah_impaling_charge');
INSERT INTO spell_script_names VALUES(59827, 'spell_galdarah_impaling_charge');

-- SPELL Transform (55299)
DELETE FROM spell_script_names WHERE spell_id IN(55299);
INSERT INTO spell_script_names VALUES(55299, 'spell_galdarah_transform');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Arena emotes
REPLACE INTO creature_addon SELECT guid, 0, 0, 0, 4097, 4, '' FROM creature WHERE map=604 AND id IN(29826, 29822, 29819) AND (position_x BETWEEN 1738 AND 1803) AND (position_y BETWEEN 833 AND 871);

-- Altars
UPDATE creature SET phaseMask=phaseMask|2 WHERE id=30298 AND map=604 AND position_z>160;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(192518, 192519, 192520);
DELETE FROM smart_scripts WHERE entryorguid IN(192518, 192519, 192520) AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid IN(19251800, 19251900, 19252000) AND source_type=9;
INSERT INTO smart_scripts VALUES(192518, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 19251800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Altar - On Gossip Hello - Script9");
INSERT INTO smart_scripts VALUES(19251800, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 86, 57071, 2, 19, 30298, 10, 0, 19, 30298, 10, 0, 0, 0, 0, 0, "Script9 - Cross Cast Fire Beam");
INSERT INTO smart_scripts VALUES(19251800, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 34, 192518, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Set Instance Data");
INSERT INTO smart_scripts VALUES(192519, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 19251900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Altar - On Gossip Hello - Script9");
INSERT INTO smart_scripts VALUES(19251900, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 86, 57068, 2, 19, 30298, 10, 0, 19, 30298, 10, 0, 0, 0, 0, 0, "Script9 - Cross Cast Fire Beam");
INSERT INTO smart_scripts VALUES(19251900, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 34, 192519, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Set Instance Data");
INSERT INTO smart_scripts VALUES(192520, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 19252000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Altar - On Gossip Hello - Script9");
INSERT INTO smart_scripts VALUES(19252000, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 86, 57072, 2, 19, 30298, 10, 0, 19, 30298, 10, 0, 0, 0, 0, 0, "Script9 - Cross Cast Fire Beam");
INSERT INTO smart_scripts VALUES(19252000, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 34, 192520, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Set Instance Data");
DELETE FROM conditions WHERE SourceEntry IN(57068, 57071, 57072) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 57068, 0, 0, 31, 0, 3, 30298, 0, 0, 0, 0, '', 'Target trigger');
INSERT INTO conditions VALUES(13, 1, 57068, 0, 0, 26, 0, 2, 0, 0, 0, 0, 0, '', 'Target trigger in phase');
INSERT INTO conditions VALUES(13, 1, 57071, 0, 0, 31, 0, 3, 30298, 0, 0, 0, 0, '', 'Target trigger');
INSERT INTO conditions VALUES(13, 1, 57071, 0, 0, 26, 0, 2, 0, 0, 0, 0, 0, '', 'Target trigger in phase');
INSERT INTO conditions VALUES(13, 1, 57072, 0, 0, 31, 0, 3, 30298, 0, 0, 0, 0, '', 'Target trigger');
INSERT INTO conditions VALUES(13, 1, 57072, 0, 0, 26, 0, 2, 0, 0, 0, 0, 0, '', 'Target trigger in phase');


-- -------------------------------------------
--             ACHIEVEMENTS
-- -------------------------------------------

-- Gundrak (484)
DELETE FROM disables WHERE sourceType=4 AND entry IN(3574, 3575, 3576, 3577);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(3574, 3575, 3576, 3577);
INSERT INTO achievement_criteria_data VALUES(3574, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3575, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3576, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(3577, 12, 0, 0, "");

-- Heroic: Gundrak (495)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6839, 6840, 6841, 6842, 5053);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6839, 6840, 6841, 6842, 5053);
INSERT INTO achievement_criteria_data VALUES(6839, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6840, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6841, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6842, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(5053, 12, 1, 0, "");

-- Snakes. Why''d It Have To Be Snakes? (2058)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7363);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7363);
INSERT INTO achievement_criteria_data VALUES(7363, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7363, 11, 0, 0, "achievement_snakes_whyd_it_have_to_be_snakes");

-- Less-rabi (2040)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7319);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7319);
INSERT INTO achievement_criteria_data VALUES(7319, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7319, 11, 0, 0, "achievement_less_rabi");

-- What the Eck? (1864)
DELETE FROM spell_linked_spell WHERE spell_trigger=55814;
INSERT INTO spell_linked_spell VALUES(55814, 55817, 1, "Trigger Eck Residue for achievement");
DELETE FROM achievement_criteria_data WHERE criteria_id=7136;
DELETE FROM disables WHERE sourceType=4 AND entry IN(7136);
INSERT INTO achievement_criteria_data VALUES(7136, 5, 55817, 0, ""); -- Eck Residue
INSERT INTO achievement_criteria_data VALUES(7136, 12, 1, 0, ""); -- Heroic Difficulty

-- Share The Love (2152)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7583);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7583);
INSERT INTO achievement_criteria_data VALUES(7583, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7583, 11, 0, 0, "achievement_share_the_love");


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Poison Nova (55081, 59842)
DELETE FROM spelldifficulty_dbc WHERE id IN(55081, 59842) OR spellid0 IN(55081, 59842) OR spellid1 IN(55081, 59842) OR spellid2 IN(55081, 59842) OR spellid3 IN(55081, 59842);
INSERT INTO spelldifficulty_dbc VALUES (55081, 55081, 59842, 0, 0);

-- Powerful Bite (48287, 59840)
DELETE FROM spelldifficulty_dbc WHERE id IN(48287, 59840) OR spellid0 IN(48287, 59840) OR spellid1 IN(48287, 59840) OR spellid2 IN(48287, 59840) OR spellid3 IN(48287, 59840);
INSERT INTO spelldifficulty_dbc VALUES (48287, 48287, 59840, 0, 0);

-- Venom Bolt (54970, 59839)
DELETE FROM spelldifficulty_dbc WHERE id IN(54970, 59839) OR spellid0 IN(54970, 59839) OR spellid1 IN(54970, 59839) OR spellid2 IN(54970, 59839) OR spellid3 IN(54970, 59839);
INSERT INTO spelldifficulty_dbc VALUES (54970, 54970, 59839, 0, 0);

-- Mojo Puddle (55627, 58994)
DELETE FROM spelldifficulty_dbc WHERE id IN(55627, 58994) OR spellid0 IN(55627, 58994) OR spellid1 IN(55627, 58994) OR spellid2 IN(55627, 58994) OR spellid3 IN(55627, 58994);
INSERT INTO spelldifficulty_dbc VALUES (55627, 55627, 58994, 0, 0);

-- Mojo Wave (55626, 58993)
DELETE FROM spelldifficulty_dbc WHERE id IN(55626, 58993) OR spellid0 IN(55626, 58993) OR spellid1 IN(55626, 58993) OR spellid2 IN(55626, 58993) OR spellid3 IN(55626, 58993);
INSERT INTO spelldifficulty_dbc VALUES (55626, 55626, 58993, 0, 0);

-- Mojo Volley (54849, 59453)
DELETE FROM spelldifficulty_dbc WHERE id IN(54849, 59453) OR spellid0 IN(54849, 59453) OR spellid1 IN(54849, 59453) OR spellid2 IN(54849, 59453) OR spellid3 IN(54849, 59453);
INSERT INTO spelldifficulty_dbc VALUES (54849, 54849, 59453, 0, 0);

-- Determined Gore (55102, 59444)
DELETE FROM spelldifficulty_dbc WHERE id IN(55102, 59444) OR spellid0 IN(55102, 59444) OR spellid1 IN(55102, 59444) OR spellid2 IN(55102, 59444) OR spellid3 IN(55102, 59444);
INSERT INTO spelldifficulty_dbc VALUES (55102, 55102, 59444, 0, 0);

-- Whirling Slash (55250, 59824)
DELETE FROM spelldifficulty_dbc WHERE id IN(55250, 59824) OR spellid0 IN(55250, 59824) OR spellid1 IN(55250, 59824) OR spellid2 IN(55250, 59824) OR spellid3 IN(55250, 59824);
INSERT INTO spelldifficulty_dbc VALUES (55250, 55250, 59824, 0, 0);

-- Stampede (55220, 59823)
DELETE FROM spelldifficulty_dbc WHERE id IN(55220, 59823) OR spellid0 IN(55220, 59823) OR spellid1 IN(55220, 59823) OR spellid2 IN(55220, 59823) OR spellid3 IN(55220, 59823);
INSERT INTO spelldifficulty_dbc VALUES (55220, 55220, 59823, 0, 0);

-- Puncture (55276, 59826)
DELETE FROM spelldifficulty_dbc WHERE id IN(55276, 59826) OR spellid0 IN(55276, 59826) OR spellid1 IN(55276, 59826) OR spellid2 IN(55276, 59826) OR spellid3 IN(55276, 59826);
INSERT INTO spelldifficulty_dbc VALUES (55276, 55276, 59826, 0, 0);

-- Stomp (55292, 59829)
DELETE FROM spelldifficulty_dbc WHERE id IN(55292, 59829) OR spellid0 IN(55292, 59829) OR spellid1 IN(55292, 59829) OR spellid2 IN(55292, 59829) OR spellid3 IN(55292, 59829);
INSERT INTO spelldifficulty_dbc VALUES (55292, 55292, 59829, 0, 0);

-- Enrage (55285, 59828)
DELETE FROM spelldifficulty_dbc WHERE id IN(55285, 59828) OR spellid0 IN(55285, 59828) OR spellid1 IN(55285, 59828) OR spellid2 IN(55285, 59828) OR spellid3 IN(55285, 59828);
INSERT INTO spelldifficulty_dbc VALUES (55285, 55285, 59828, 0, 0);

-- Impaling Charge (54956, 59827)
DELETE FROM spelldifficulty_dbc WHERE id IN(54956, 59827) OR spellid0 IN(54956, 59827) OR spellid1 IN(54956, 59827) OR spellid2 IN(54956, 59827) OR spellid3 IN(54956, 59827);
INSERT INTO spelldifficulty_dbc VALUES (54956, 54956, 59827, 0, 0);


UPDATE creature SET spawntimesecs=86400 WHERE map=556 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Sethekk Guard (18323, 20692)
DELETE FROM creature_text WHERE entry=18323;
INSERT INTO creature_text VALUES (18323, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Guard');
INSERT INTO creature_text VALUES (18323, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Guard');
INSERT INTO creature_text VALUES (18323, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Guard');
INSERT INTO creature_text VALUES (18323, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Guard');
INSERT INTO creature_text VALUES (18323, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Guard');
UPDATE creature_template SET pickpocketloot=18323, AIName='SmartAI', ScriptName='' WHERE entry=18323;
UPDATE creature_template SET pickpocketloot=18323, AIName='', ScriptName='' WHERE entry=20692;
DELETE FROM smart_scripts WHERE entryorguid=18323 AND source_type=0;
INSERT INTO smart_scripts VALUES (18323, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Guard - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18323, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 10000, 13000, 11, 33967, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Guard - In Combat - Cast Thunderclap');

-- Sethekk Initiate (18318, 20693)
DELETE FROM creature_text WHERE entry=18318;
INSERT INTO creature_text VALUES (18318, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Initiate');
INSERT INTO creature_text VALUES (18318, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Initiate');
INSERT INTO creature_text VALUES (18318, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Initiate');
INSERT INTO creature_text VALUES (18318, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Initiate');
INSERT INTO creature_text VALUES (18318, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Initiate');
UPDATE creature_template SET pickpocketloot=18318, AIName='SmartAI', ScriptName='' WHERE entry=18318;
UPDATE creature_template SET pickpocketloot=18318, AIName='', ScriptName='' WHERE entry=20693;
DELETE FROM smart_scripts WHERE entryorguid=18318 AND source_type=0;
INSERT INTO smart_scripts VALUES (18318, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18318, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 5000, 7000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - In Combat - Cast Sunder Armor');
INSERT INTO smart_scripts VALUES (18318, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 12000, 18000, 11, 33961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - In Combat - Cast Spell Reflection');
INSERT INTO smart_scripts VALUES (18318, 0, 3, 0, 14, 0, 5, 1, 10000, 20, 0, 0, 11, 20223, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Initiate - In Combat - Cast Magic Reflection');

-- Avian Darkhawk (19429, 20686)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19429;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20686;
DELETE FROM smart_scripts WHERE entryorguid=19429 AND source_type=0;
INSERT INTO smart_scripts VALUES (19429, 0, 0, 0, 9, 0, 100, 2, 8, 25, 5000, 7000, 11, 38059, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - At Range 8 to 25 - Cast Sonic Charge');
INSERT INTO smart_scripts VALUES (19429, 0, 1, 0, 9, 0, 100, 4, 8, 25, 5000, 7000, 11, 39197, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - At Range 8 to 25 - Cast Sonic Charge');
INSERT INTO smart_scripts VALUES (19429, 0, 2, 0, 0, 0, 100, 2, 4000, 5000, 8000, 10000, 11, 32901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - In Combat - Cast Carnivorous Bite');
INSERT INTO smart_scripts VALUES (19429, 0, 3, 0, 0, 0, 100, 4, 4000, 5000, 8000, 10000, 11, 39198, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Darkhawk - In Combat - Cast Carnivorous Bite');

-- Time-Lost Controller (18327, 20691)
DELETE FROM creature_text WHERE entry=18327;
INSERT INTO creature_text VALUES (18327, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Controller');
INSERT INTO creature_text VALUES (18327, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Controller');
INSERT INTO creature_text VALUES (18327, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Controller');
INSERT INTO creature_text VALUES (18327, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Controller');
INSERT INTO creature_text VALUES (18327, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Controller');
UPDATE creature_template SET pickpocketloot=18327, AIName='SmartAI', ScriptName='' WHERE entry=18327;
UPDATE creature_template SET pickpocketloot=18327, AIName='', ScriptName='' WHERE entry=20691;
DELETE FROM smart_scripts WHERE entryorguid=18327 AND source_type=0;
INSERT INTO smart_scripts VALUES (18327, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18327, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 10000, 12000, 11, 35013, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - In Combat - Cast Shrink');
INSERT INTO smart_scripts VALUES (18327, 0, 2, 0, 0, 0, 100, 1, 5000, 7000, 0, 0, 11, 32764, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Controller - In Combat - Cast Summon Charming Totem');

-- Charming Totem (20343, 20687)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20343;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20687;
DELETE FROM smart_scripts WHERE entryorguid=20343 AND source_type=0;
INSERT INTO smart_scripts VALUES (20343, 0, 0, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 11, 35120, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Charming Totem - In Combat - Cast Charm');

-- Sethekk Oracle (18328, 20694)
DELETE FROM creature_text WHERE entry=18328;
INSERT INTO creature_text VALUES (18328, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Oracle');
INSERT INTO creature_text VALUES (18328, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Oracle');
INSERT INTO creature_text VALUES (18328, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Oracle');
INSERT INTO creature_text VALUES (18328, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Oracle');
INSERT INTO creature_text VALUES (18328, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Oracle');
UPDATE creature_template SET pickpocketloot=18328, AIName='SmartAI', ScriptName='' WHERE entry=18328;
UPDATE creature_template SET pickpocketloot=18328, AIName='', ScriptName='' WHERE entry=20694;
DELETE FROM smart_scripts WHERE entryorguid=18328 AND source_type=0;
INSERT INTO smart_scripts VALUES (18328, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18328, 0, 1, 0, 0, 0, 100, 1, 4000, 7000, 0, 0, 11, 32129, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast Faerie Fire');
INSERT INTO smart_scripts VALUES (18328, 0, 2, 0, 0, 0, 100, 2, 5000, 7000, 10000, 12000, 11, 32690, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast Arcane Lightning');
INSERT INTO smart_scripts VALUES (18328, 0, 3, 0, 0, 0, 100, 4, 5000, 7000, 10000, 12000, 11, 38146, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Oracle - In Combat - Cast Arcane Lightning');

-- Sethekk Ravenguard (18322, 20696)
DELETE FROM creature_text WHERE entry=18322;
INSERT INTO creature_text VALUES (18322, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Ravenguard');
INSERT INTO creature_text VALUES (18322, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Ravenguard');
INSERT INTO creature_text VALUES (18322, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Ravenguard');
INSERT INTO creature_text VALUES (18322, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Ravenguard');
INSERT INTO creature_text VALUES (18322, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Ravenguard');
UPDATE creature_template SET pickpocketloot=18322, AIName='SmartAI', ScriptName='' WHERE entry=18322;
UPDATE creature_template SET pickpocketloot=18322, AIName='', ScriptName='' WHERE entry=20696;
DELETE FROM smart_scripts WHERE entryorguid=18322 AND source_type=0;
INSERT INTO smart_scripts VALUES (18322, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18322, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 10000, 18000, 11, 32651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast Howling Screech');
INSERT INTO smart_scripts VALUES (18322, 0, 2, 0, 0, 0, 100, 2, 2000, 6000, 10000, 18000, 11, 33964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast Bloodthirst');
INSERT INTO smart_scripts VALUES (18322, 0, 3, 0, 0, 0, 100, 4, 2000, 6000, 10000, 18000, 11, 40423, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - In Combat - Cast Bloodthirst');
INSERT INTO smart_scripts VALUES (18322, 0, 4, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Ravenguard - HP 20% - Cast Frenzy');

-- Cobalt Serpent (19428, 20688)
UPDATE creature_template SET skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=19428;
UPDATE creature_template SET skinloot=70063, AIName='', ScriptName='' WHERE entry=20688;
DELETE FROM smart_scripts WHERE entryorguid=19428 AND source_type=0;
INSERT INTO smart_scripts VALUES (19428, 0, 0, 0, 0, 0, 100, 2, 5000, 7000, 8000, 11000, 11, 38193, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast Lightning Breath');
INSERT INTO smart_scripts VALUES (19428, 0, 1, 0, 0, 0, 100, 4, 5000, 7000, 8000, 11000, 11, 38133, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast Lightning Breath');
INSERT INTO smart_scripts VALUES (19428, 0, 2, 0, 0, 0, 100, 2, 1000, 3000, 8000, 11000, 11, 38238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (19428, 0, 3, 0, 0, 0, 100, 4, 1000, 3000, 8000, 11000, 11, 17503, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (19428, 0, 4, 0, 0, 0, 100, 0, 9000, 9000, 15000, 22000, 11, 38110, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cobalt Serpent - In Combat - Cast Wing Buffet');

-- Time-Lost Scryer (18319, 20697)
DELETE FROM creature_text WHERE entry=18319;
INSERT INTO creature_text VALUES (18319, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Scryer');
INSERT INTO creature_text VALUES (18319, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Scryer');
INSERT INTO creature_text VALUES (18319, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Scryer');
INSERT INTO creature_text VALUES (18319, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Scryer');
INSERT INTO creature_text VALUES (18319, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Scryer');
UPDATE creature_template SET pickpocketloot=18319, AIName='SmartAI', ScriptName='' WHERE entry=18319;
UPDATE creature_template SET pickpocketloot=18319, AIName='', ScriptName='' WHERE entry=20697;
DELETE FROM smart_scripts WHERE entryorguid=18319 AND source_type=0;
INSERT INTO smart_scripts VALUES (18319, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18319, 0, 1, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 17843, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - HP Friendly - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (18319, 0, 2, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 17138, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - HP Friendly - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (18319, 0, 3, 0, 16, 0, 100, 2, 12160, 40, 7000, 10000, 11, 12160, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - Missing Buff - Cast Rejuvenation');
INSERT INTO smart_scripts VALUES (18319, 0, 4, 0, 16, 0, 100, 4, 15981, 40, 7000, 10000, 11, 15981, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - Missing Buff - Cast Rejuvenation');
INSERT INTO smart_scripts VALUES (18319, 0, 5, 0, 1, 0, 100, 0, 500, 500, 1200000, 1200000, 11, 32689, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - Out of Combat - Cast Arcane Destruction');
INSERT INTO smart_scripts VALUES (18319, 0, 6, 0, 0, 0, 100, 2, 3000, 4000, 9000, 12000, 11, 33988, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - In Combat - Cast Arcane Missiles');
INSERT INTO smart_scripts VALUES (18319, 0, 7, 0, 0, 0, 100, 4, 3000, 4000, 9000, 12000, 11, 22272, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Time-Lost Scryer - In Combat - Cast Arcane Missiles');

-- Sethekk Talon Lord (18321, 20701)
DELETE FROM creature_text WHERE entry=18321;
INSERT INTO creature_text VALUES (18321, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Talon Lord');
INSERT INTO creature_text VALUES (18321, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Talon Lord');
INSERT INTO creature_text VALUES (18321, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Talon Lord');
INSERT INTO creature_text VALUES (18321, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Talon Lord');
INSERT INTO creature_text VALUES (18321, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Talon Lord');
UPDATE creature_template SET pickpocketloot=18321, AIName='SmartAI', ScriptName='' WHERE entry=18321;
UPDATE creature_template SET pickpocketloot=18321, AIName='', ScriptName='' WHERE entry=20701;
DELETE FROM smart_scripts WHERE entryorguid=18321 AND source_type=0;
INSERT INTO smart_scripts VALUES (18321, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18321, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 32674, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - On Aggro - Cast Avengers Shield');
INSERT INTO smart_scripts VALUES (18321, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 10000, 15000, 11, 32654, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - In Combat - Cast Talon of Justice');

-- Sethekk Prophet (18325, 20695)
DELETE FROM creature_text WHERE entry=18325;
INSERT INTO creature_text VALUES (18325, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Prophet');
INSERT INTO creature_text VALUES (18325, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Prophet');
INSERT INTO creature_text VALUES (18325, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Prophet');
INSERT INTO creature_text VALUES (18325, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Prophet');
INSERT INTO creature_text VALUES (18325, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Prophet');
UPDATE creature_template SET pickpocketloot=18325, AIName='SmartAI', ScriptName='' WHERE entry=18325;
UPDATE creature_template SET pickpocketloot=18325, AIName='', ScriptName='' WHERE entry=20695;
DELETE FROM smart_scripts WHERE entryorguid=18325 AND source_type=0;
INSERT INTO smart_scripts VALUES (18325, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18325, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 8000, 12000, 11, 27641, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - In Combat - Cast Fear');

-- Avian Warhawk (21904, 21990)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21904;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21990;
DELETE FROM smart_scripts WHERE entryorguid=21904 AND source_type=0;
INSERT INTO smart_scripts VALUES (21904, 0, 0, 0, 9, 0, 100, 2, 8, 25, 5000, 7000, 11, 38059, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - At Range 8 to 25 - Cast Sonic Charge');
INSERT INTO smart_scripts VALUES (21904, 0, 1, 0, 9, 0, 100, 4, 8, 25, 5000, 7000, 11, 39197, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - At Range 8 to 25 - Cast Sonic Charge');
INSERT INTO smart_scripts VALUES (21904, 0, 2, 0, 0, 0, 100, 2, 4000, 5000, 8000, 10000, 11, 32901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast Carnivorous Bite');
INSERT INTO smart_scripts VALUES (21904, 0, 3, 0, 0, 0, 100, 4, 4000, 5000, 8000, 10000, 11, 39198, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast Carnivorous Bite');
INSERT INTO smart_scripts VALUES (21904, 0, 4, 0, 0, 0, 100, 0, 7000, 9000, 11000, 13000, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Warhawk - In Combat - Cast Swoop');

-- Avian Ripper (21891, 21989)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21891;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21989;
DELETE FROM smart_scripts WHERE entryorguid=21891 AND source_type=0;
INSERT INTO smart_scripts VALUES (21891, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 7000, 10000, 11, 38056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avian Ripper - In Combat - Cast Flesh Rip');

-- Time-Lost Shadowmage (18320, 20698)
DELETE FROM creature_text WHERE entry=18320;
INSERT INTO creature_text VALUES (18320, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Shadowmage');
INSERT INTO creature_text VALUES (18320, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Shadowmage');
INSERT INTO creature_text VALUES (18320, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Shadowmage');
INSERT INTO creature_text VALUES (18320, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Shadowmage');
INSERT INTO creature_text VALUES (18320, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Time-Lost Shadowmage');
UPDATE creature_template SET pickpocketloot=18320, AIName='SmartAI', ScriptName='' WHERE entry=18320;
UPDATE creature_template SET pickpocketloot=18320, AIName='', ScriptName='' WHERE entry=20698;
DELETE FROM smart_scripts WHERE entryorguid=18320 AND source_type=0;
INSERT INTO smart_scripts VALUES (18320, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18320, 0, 1, 0, 0, 0, 100, 2, 4000, 7000, 25000, 25000, 11, 32682, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast Curse of the Dark Talon');
INSERT INTO smart_scripts VALUES (18320, 0, 2, 0, 0, 0, 100, 4, 4000, 7000, 25000, 25000, 11, 38149, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time-Lost Shadowmage - In Combat - Cast Curse of the Dark Talon');

-- Sethekk Shaman (18326, 20699)
DELETE FROM creature_text WHERE entry=18326;
INSERT INTO creature_text VALUES (18326, 0, 0, "Arak-ha!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Shaman');
INSERT INTO creature_text VALUES (18326, 0, 1, "Darkfire -- avenge us!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Shaman');
INSERT INTO creature_text VALUES (18326, 0, 2, "In Terokk's name!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Shaman');
INSERT INTO creature_text VALUES (18326, 0, 3, "Protect the Veil!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Shaman');
INSERT INTO creature_text VALUES (18326, 0, 4, "Ssssekk-sara Rith-nealaak!", 12, 0, 100, 0, 0, 0, 0, 'Sethekk Shaman');
UPDATE creature_template SET pickpocketloot=18326, AIName='SmartAI', ScriptName='' WHERE entry=18326;
UPDATE creature_template SET pickpocketloot=18326, AIName='', ScriptName='' WHERE entry=20699;
DELETE FROM smart_scripts WHERE entryorguid=18326 AND source_type=0;
INSERT INTO smart_scripts VALUES (18326, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18326, 0, 1, 0, 13, 0, 100, 2, 7000, 7000, 0, 0, 11, 15501, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - At target cast - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (18326, 0, 2, 0, 13, 0, 100, 4, 7000, 7000, 0, 0, 11, 22885, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - At target cast - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (18326, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 32663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Shaman - On Aggro - Cast Summon Dark Vortex');

-- Dark Vortex (18701, 20689)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18701;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20689;
DELETE FROM smart_scripts WHERE entryorguid=18701 AND source_type=0;
INSERT INTO smart_scripts VALUES (18701, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3500, 3500, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dark Vortex - In Combat - Cast Shadowbolt');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Darkweaver Syth (18472, 20690)
UPDATE creature_template SET dmgschool=5, pickpocketloot=18472, AIName='SmartAI', ScriptName='' WHERE entry=18472;
UPDATE creature_template SET dmgschool=5, pickpocketloot=18472, AIName='', ScriptName='' WHERE entry=20690;
DELETE FROM smart_scripts WHERE entryorguid=18472 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1847200 AND source_type=9;
INSERT INTO smart_scripts VALUES (18472, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (18472, 0, 1, 0, 5, 0, 100, 0, 3000, 3000, 1, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - On Aggro - Say Line 2');
INSERT INTO smart_scripts VALUES (18472, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - On Aggro - Say Line 3');
INSERT INTO smart_scripts VALUES (18472, 0, 3, 0, 0, 0, 100, 2, 2000, 2000, 10000, 15000, 11, 15039, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 4, 0, 0, 0, 100, 2, 4000, 4000, 10000, 15000, 11, 33534, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Arcane Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 5, 0, 0, 0, 100, 2, 6000, 6000, 10000, 15000, 11, 12548, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 6, 0, 0, 0, 100, 2, 8000, 8000, 10000, 15000, 11, 33620, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 7, 0, 0, 0, 100, 4, 2000, 2000, 10000, 15000, 11, 15616, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 8, 0, 0, 0, 100, 4, 4000, 4000, 10000, 15000, 11, 33534, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Arcane Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 9, 0, 0, 0, 100, 4, 6000, 6000, 10000, 15000, 11, 21401, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 10, 0, 0, 0, 100, 4, 8000, 8000, 10000, 15000, 11, 38136, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (18472, 0, 11, 0, 0, 0, 100, 2, 15000, 15000, 25000, 25000, 11, 15659, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (18472, 0, 12, 0, 0, 0, 100, 4, 15000, 15000, 25000, 25000, 11, 15305, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (18472, 0, 13, 0, 2, 0, 100, 1, 0, 90, 0, 0, 80, 1847200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - 90% HP - Call Script');
INSERT INTO smart_scripts VALUES (18472, 0, 14, 0, 2, 0, 100, 1, 0, 50, 0, 0, 80, 1847200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - 50% HP - Call Script');
INSERT INTO smart_scripts VALUES (18472, 0, 15, 0, 2, 0, 100, 1, 0, 10, 0, 0, 80, 1847200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - 10% HP - Call Script');
INSERT INTO smart_scripts VALUES (1847200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (1847200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 33537, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - Script9 - Cast Summon Syth Elemental');
INSERT INTO smart_scripts VALUES (1847200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 33538, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - Script9 - Cast Summon Syth Elemental');
INSERT INTO smart_scripts VALUES (1847200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 33539, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - Script9 - Cast Summon Syth Elemental');
INSERT INTO smart_scripts VALUES (1847200, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 33540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweaver Syth - Script9 - Cast Summon Syth Elemental');
-- Syth Fire Elemental (19203, 20703)
REPLACE INTO creature_template_addon VALUES (19203, 0, 0, 0, 1, 0, '34305');
REPLACE INTO creature_template_addon VALUES (20703, 0, 0, 0, 1, 0, '34305');
UPDATE creature_template SET dmgschool=2, AIName='SmartAI', ScriptName='' WHERE entry=19203;
UPDATE creature_template SET dmgschool=2, AIName='', ScriptName='' WHERE entry=20703;
DELETE FROM smart_scripts WHERE entryorguid=19203 AND source_type=0;
INSERT INTO smart_scripts VALUES (19203, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 4000, 5000, 11, 33526, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (19203, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 4000, 5000, 11, 38141, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - In Combat - Cast Flame Buffet');
INSERT INTO smart_scripts VALUES (19203, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental- On Evade - Despawn');
INSERT INTO smart_scripts VALUES (19203, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Syth Fire Elemental - Out of Combat - Attack Start');
-- Syth Frost Elemental (19204, 20704)
REPLACE INTO creature_template_addon VALUES (19204, 0, 0, 0, 1, 0, '34306');
REPLACE INTO creature_template_addon VALUES (20704, 0, 0, 0, 1, 0, '34306');
UPDATE creature_template SET dmgschool=4, AIName='SmartAI', ScriptName='' WHERE entry=19204;
UPDATE creature_template SET dmgschool=4, AIName='', ScriptName='' WHERE entry=20704;
DELETE FROM smart_scripts WHERE entryorguid=19204 AND source_type=0;
INSERT INTO smart_scripts VALUES (19204, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 4000, 5000, 11, 33528, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - In Combat - Cast Frost Buffet');
INSERT INTO smart_scripts VALUES (19204, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 4000, 5000, 11, 38142, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - In Combat - Cast Frost Buffet');
INSERT INTO smart_scripts VALUES (19204, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental- On Evade - Despawn');
INSERT INTO smart_scripts VALUES (19204, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Syth Frost Elemental - Out of Combat - Attack Start');
-- Syth Arcane Elemental (19205, 20702)
REPLACE INTO creature_template_addon VALUES (19205, 0, 0, 0, 1, 0, '34304');
REPLACE INTO creature_template_addon VALUES (20702, 0, 0, 0, 1, 0, '34304');
UPDATE creature_template SET dmgschool=6, AIName='SmartAI', ScriptName='' WHERE entry=19205;
UPDATE creature_template SET dmgschool=6, AIName='', ScriptName='' WHERE entry=20702;
DELETE FROM smart_scripts WHERE entryorguid=19205 AND source_type=0;
INSERT INTO smart_scripts VALUES (19205, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 4000, 5000, 11, 33527, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - In Combat - Cast Arcane Buffet');
INSERT INTO smart_scripts VALUES (19205, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 4000, 5000, 11, 38138, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - In Combat - Cast Arcane Buffet');
INSERT INTO smart_scripts VALUES (19205, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental- On Evade - Despawn');
INSERT INTO smart_scripts VALUES (19205, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Syth Arcane Elemental - Out of Combat - Attack Start');
-- Syth Shadow Elemental (19206, 20705)
REPLACE INTO creature_template_addon VALUES (19206, 0, 0, 0, 1, 0, '34309');
REPLACE INTO creature_template_addon VALUES (20705, 0, 0, 0, 1, 0, '34309');
UPDATE creature_template SET dmgschool=5, AIName='SmartAI', ScriptName='' WHERE entry=19206;
UPDATE creature_template SET dmgschool=5, AIName='', ScriptName='' WHERE entry=20705;
DELETE FROM smart_scripts WHERE entryorguid=19206 AND source_type=0;
INSERT INTO smart_scripts VALUES (19206, 0, 0, 0, 0, 0, 100, 2, 1000, 2000, 4000, 5000, 11, 33529, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - In Combat - Cast Shadow Buffet');
INSERT INTO smart_scripts VALUES (19206, 0, 1, 0, 0, 0, 100, 4, 1000, 2000, 4000, 5000, 11, 38143, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - In Combat - Cast Shadow Buffet');
INSERT INTO smart_scripts VALUES (19206, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental- On Evade - Despawn');
INSERT INTO smart_scripts VALUES (19206, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Syth Shadow Elemental - Out of Combat - Attack Start');

-- Talon King Ikiss (18473, 20706)
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=18473, AIName='', ScriptName='boss_talon_king_ikiss' WHERE entry=18473;
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=18473, AIName='', ScriptName='' WHERE entry=20706;
DELETE FROM smart_scripts WHERE entryorguid=18473 AND source_type=0;

-- Anzu (23035)
DELETE FROM creature_text WHERE entry=23035;
INSERT INTO creature_text VALUES (23035, 0, 0, "No! How can this be?", 14, 0, 100, 0, 0, 0, 0, 'Anzu');
INSERT INTO creature_text VALUES (23035, 1, 0, "Pain will be the price for you insolence! You cannot stop me from claiming the Emerald Dream as my own!", 14, 0, 100, 0, 0, 0, 0, 'Anzu');
INSERT INTO creature_text VALUES (23035, 2, 0, "Awaken, my children and assist your master!", 14, 0, 100, 0, 0, 0, 0, 'Anzu');
UPDATE creature_template SET AIName='', ScriptName='boss_anzu' WHERE entry=23035;
DELETE FROM smart_scripts WHERE entryorguid=23035 AND source_type=0;

-- Brood of Anzu (23132)
UPDATE creature_template SET InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=23132;
DELETE FROM smart_scripts WHERE entryorguid=23132 AND source_type=0;
INSERT INTO smart_scripts VALUES (23132, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 10000, 15000, 11, 31273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Brood of Anzu - In Combat - Cast Screech');

-- Invis Raven God Portal (23046)
REPLACE INTO creature_template_addon VALUES (23046, 0, 0, 0, 1, 0, '39952');
UPDATE creature_template SET modelid1=19595, modelid2=0, unit_flags=33554432, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23046;
DELETE FROM smart_scripts WHERE entryorguid=23046 AND source_type=0;

-- Invis Raven God Target (23057)
UPDATE creature_template SET modelid1=21072, modelid2=0, unit_flags=33554432, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23057;
DELETE FROM smart_scripts WHERE entryorguid=23057 AND source_type=0;

-- Invis Raven God Caster (23058)
UPDATE creature_template SET modelid1=19595, modelid2=0, unit_flags=33554432, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23058;
DELETE FROM smart_scripts WHERE entryorguid=23058 AND source_type=0;
DELETE FROM creature WHERE id=23058;
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -74.4073, 288.107, 32.4191, 3.2267, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -79.0159, 282.795, 32.8515, 3.85895, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -86.7819, 275.897, 32.9223, 2.26459, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -95.3458, 280.89, 30.5549, 1.25535, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -98.7111, 287.001, 32.7008, 1.19252, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -97.1148, 293.73, 35.1206, 0.552423, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -89.1839, 295.683, 33.9356, 0.0340604, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 23058, 556, 2, 1, 0, 0, -80.5207, 296.352, 40.3085, 4.93495, 300, 0, 0, 42, 0, 0, 0, 0, 0);

-- The Voice of the Raven God (21851)
UPDATE creature_template SET speed_walk=0.6, speed_run=0.3, InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=21851;
DELETE FROM smart_scripts WHERE entryorguid=21851 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2185100 AND source_type=9;
INSERT INTO smart_scripts VALUES (21851, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 60, 1, 25, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - On Update - Set Fly');
INSERT INTO smart_scripts VALUES (21851, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2185100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - On Update - Start Script');
INSERT INTO smart_scripts VALUES (2185100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 50, 185590, 60, 0, 0, 0, 0, 8, 0, 0, 0, -87.61, 287.84, 31.0, 4.4, 'The Voice of the Raven God - Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (2185100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 185595, 60, 0, 0, 0, 0, 8, 0, 0, 0, -87.61, 287.84, 31.0, 4.4, 'The Voice of the Raven God - Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (2185100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 23046, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -87.61, 287.84, 28.0, 4.4, 'The Voice of the Raven God - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (2185100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 32566, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Cast Purple Banish State');
INSERT INTO smart_scripts VALUES (2185100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 39978, 0, 11, 23058, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Cross Cast');
INSERT INTO smart_scripts VALUES (2185100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -87.61, 287.84, 35.0, 4.4, 'The Voice of the Raven God - Script9 - Move To Position');
INSERT INTO smart_scripts VALUES (2185100, 9, 6, 0, 0, 0, 100, 0, 24000, 24000, 0, 0, 11, 39983, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Cast Camera Shake');
INSERT INTO smart_scripts VALUES (2185100, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 11, 39983, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Cast Camera Shake');
INSERT INTO smart_scripts VALUES (2185100, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 11, 39990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Cast Red Lightning');
INSERT INTO smart_scripts VALUES (2185100, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 23035, 8, 0, 0, 0, 0, 8, 0, 0, 0, -87.61, 287.84, 26.5, 2.33, 'The Voice of the Raven God - Summon Creature');
INSERT INTO smart_scripts VALUES (2185100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 23046, 50, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Despawn Creature');
INSERT INTO smart_scripts VALUES (2185100, 9, 11, 0, 0, 0, 100, 0, 200, 200, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 185554, 50, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Despawn GO');
INSERT INTO smart_scripts VALUES (2185100, 9, 12, 0, 0, 0, 100, 0, 200, 200, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 185590, 50, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Despawn GO');
INSERT INTO smart_scripts VALUES (2185100, 9, 13, 0, 0, 0, 100, 0, 200, 200, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 185595, 50, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Despawn GO');
INSERT INTO smart_scripts VALUES (2185100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Voice of the Raven God - Despawn Self');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39978;
INSERT INTO conditions VALUES(13, 1, 39978, 0, 0, 31, 0, 3, 21851, 0, 0, 0, 0, '', 'Requires Voice of the Raven God');

-- The Raven's Claw (185554)
UPDATE gameobject_template SET data3=60000 WHERE entry=185554;
DELETE FROM event_scripts WHERE id=14797;
INSERT INTO event_scripts VALUES (14797, 0, 10, 21851, 300000, 0, -88.02, 288.18, 75.2, 6.0);


-- -------------------------------------------
--                MISC
-- -------------------------------------------


UPDATE creature SET spawntimesecs=86400 WHERE map=543 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Bonechewer Hungerer (17259, 18053)
DELETE FROM creature_text WHERE entry=17259;
INSERT INTO creature_text VALUES (17259, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
INSERT INTO creature_text VALUES (17259, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Hungerer');
UPDATE creature_template SET pickpocketloot=17259, AIName='SmartAI', ScriptName='' WHERE entry=17259;
UPDATE creature_template SET pickpocketloot=17259, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18053;
DELETE FROM smart_scripts WHERE entryorguid=17259 AND source_type=0;
INSERT INTO smart_scripts VALUES(17259, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17259, 0, 1, 0, 0, 0, 100, 0, 1200, 9500, 19500, 25300, 11, 16244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast Demoralizing Shout');
INSERT INTO smart_scripts VALUES(17259, 0, 2, 0, 0, 0, 100, 0, 1900, 8800, 9300, 14700, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES(17259, 0, 3, 0, 0, 0, 100, 0, 1900, 4000, 5000, 8000, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Hungerer - In Combat - Cast Strike');

-- Bonechewer Ravener (17264, 18054)
DELETE FROM creature_text WHERE entry=17264;
INSERT INTO creature_text VALUES (17264, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
INSERT INTO creature_text VALUES (17264, 1, 0, "You there! Keep a close watch on these ramparts, intruders could approach at any time!", 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Ravener');
UPDATE creature_template SET pickpocketloot=17264, AIName='SmartAI', ScriptName='' WHERE entry=17264;
UPDATE creature_template SET pickpocketloot=17264, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18054;
DELETE FROM smart_scripts WHERE entryorguid=17264 AND source_type=0;
INSERT INTO smart_scripts VALUES(17264, 0, 0, 0, 1, 0, 100, 0, 10000, 80000, 120000, 180000, 1, 1, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ravener - Out of Combat - Say Text');
INSERT INTO smart_scripts VALUES(17264, 0, 1, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ravener - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17264, 0, 2, 0, 0, 0, 100, 0, 1200, 9500, 13500, 19300, 11, 30621, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ravener - In Combat - Cast Kidney Shot');
INSERT INTO smart_scripts VALUES(17264, 0, 3, 0, 0, 0, 100, 0, 1900, 8800, 9300, 14700, 11, 26141, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ravener - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES(17264, 0, 4, 0, 52, 0, 100, 0, 1, 17264, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 17271, 50, 0, 0, 0, 0, 0, 'Bonechewer Ravener - On Text Over - Say Text Target');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17264;
INSERT INTO conditions VALUES(22, 1, 17264, 0, 0, 29, 1, 17271, 20, 0, 0, 0, 0, '', 'Run action if npc nearby');

-- Bonechewer Destroyer (17271, 18052)
DELETE FROM creature_text WHERE entry=17271;
INSERT INTO creature_text VALUES (17271, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Destroyer');
INSERT INTO creature_text VALUES (17271, 1, 0, "Yes sir! I will not fail the Fel Horde!", 14, 0, 100, 66, 0, 0, 0, 'Bonechewer Destroyer');
UPDATE creature_template SET pickpocketloot=17271, AIName='SmartAI', ScriptName='' WHERE entry=17271;
UPDATE creature_template SET pickpocketloot=17271, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18052;
DELETE FROM smart_scripts WHERE entryorguid=17271 AND source_type=0;
INSERT INTO smart_scripts VALUES(17271, 0, 0, 0, 0, 0, 100, 0, 1900, 11000, 14000, 19700, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES(17271, 0, 1, 0, 0, 0, 100, 0, 1200, 9500, 13500, 19300, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES(17271, 0, 2, 0, 0, 0, 100, 0, 1900, 8800, 9300, 14700, 11, 26141, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Destroyer - In Combat - Cast Hamstring');

-- Bleeding Hollow Darkcaster (17269, 18049)
DELETE FROM creature_text WHERE entry=17269;
INSERT INTO creature_text VALUES (17269, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
INSERT INTO creature_text VALUES (17269, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster');
UPDATE creature_template SET spell1=36808, spell2=15241, spell3=0, pickpocketloot=17269, AIName='SmartAI', ScriptName='' WHERE entry=17269;
UPDATE creature_template SET spell1=36808, spell2=36807, spell3=0, pickpocketloot=17269, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18049;
DELETE FROM smart_scripts WHERE entryorguid=17269 AND source_type=0;
INSERT INTO smart_scripts VALUES(17269, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17269, 0, 1, 0, 0, 0, 100, 2, 100, 1000, 2000, 2000, 11, 15241, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES(17269, 0, 2, 0, 0, 0, 100, 4, 100, 1000, 2000, 2000, 11, 36807, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES(17269, 0, 3, 0, 0, 0, 100, 2, 7000, 12000, 19000, 25000, 11, 31598, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES(17269, 0, 4, 0, 0, 0, 100, 4, 7000, 12000, 19000, 25000, 11, 36808, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Darkcaster - In Combat - Cast Rain of Fire');

-- Bleeding Hollow Archer (17270, 18048)
DELETE FROM creature_text WHERE entry=17270;
INSERT INTO creature_text VALUES (17270, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
INSERT INTO creature_text VALUES (17270, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Archer');
UPDATE creature_template SET pickpocketloot=17270, AIName='SmartAI', ScriptName='' WHERE entry=17270;
UPDATE creature_template SET pickpocketloot=17270, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18048;
DELETE FROM smart_scripts WHERE entryorguid=17270 AND source_type=0;
INSERT INTO smart_scripts VALUES(17270, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Archer - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17270, 0, 1, 0, 0, 0, 100, 0, 100, 10000, 10000, 20000, 11, 30614, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Archer - In Combat - Cast Aimed Shot');
INSERT INTO smart_scripts VALUES(17270, 0, 2, 0, 0, 0, 100, 2, 4000, 9000, 9000, 15000, 11, 18651, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Archer - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES(17270, 0, 3, 0, 0, 0, 100, 4, 4000, 9000, 9000, 15000, 11, 31942, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Archer - In Combat - Cast Multi-Shot');

-- Shattered Hand Warhound (17280, 18059)
DELETE FROM creature_text WHERE entry=17280;
UPDATE creature_template SET skinloot=70062, AIName='SmartAI', ScriptName='' WHERE entry=17280;
UPDATE creature_template SET skinloot=70062, AIName='', ScriptName='' WHERE entry=18059;
DELETE FROM smart_scripts WHERE entryorguid=17280 AND source_type=0;
INSERT INTO smart_scripts VALUES(17280, 0, 0, 0, 0, 0, 100, 0, 100, 10000, 10000, 20000, 11, 30636, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - In Combat - Cast Furious Howl');
INSERT INTO smart_scripts VALUES(17280, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 9000, 15000, 11, 30639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - In Combat - Cast Carnivorous Bite');
INSERT INTO smart_scripts VALUES(17280, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Warhound - Is Summoned By - Set In Combat With Zone');

-- Bonechewer Beastmaster (17455, 18051)
DELETE FROM creature_text WHERE entry=17455;
INSERT INTO creature_text VALUES (17455, 0, 0, "Intruders! Hold them off until I can release the warhounds!", 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Beastmaster');
INSERT INTO creature_text VALUES (17455, 1, 0, "You're too late, now feel the wrath of my warhounds!", 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Beastmaster');
UPDATE creature_template SET pickpocketloot=17455, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=17455;
UPDATE creature_template SET pickpocketloot=17455, mechanic_immune_mask=650854271, AIName='', ScriptName='' WHERE entry=18051;
DELETE FROM smart_scripts WHERE entryorguid=17455 AND source_type=0;
INSERT INTO smart_scripts VALUES(17455, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Beastmaster - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17455, 0, 1, 0, 0, 0, 100, 0, 0, 0, 120000, 120000, 11, 30635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Beastmaster - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES(17455, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 9000, 15000, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Beastmaster - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES(17455, 0, 3, 4, 0, 0, 100, 1, 20000, 20000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Beastmaster - In Combat - Say Text');
INSERT INTO smart_scripts VALUES(17455, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -1225.66, 1440.08, 68.60, 1.88, 'Bonechewer Beastmaster - In Combat - Summon Creature');
INSERT INTO smart_scripts VALUES(17455, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -1218.56, 1439.61, 68.60, 2.77, 'Bonechewer Beastmaster - In Combat - Summon Creature');
INSERT INTO smart_scripts VALUES(17455, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 17280, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -1211.26, 1440.11, 68.60, 2.77, 'Bonechewer Beastmaster - In Combat - Summon Creature');

-- Bleeding Hollow Scryer (17478, 18050)
DELETE FROM creature_text WHERE entry=17478;
INSERT INTO creature_text VALUES (17478, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
INSERT INTO creature_text VALUES (17478, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bleeding Hollow Scryer');
UPDATE creature_template SET pickpocketloot=17478, AIName='SmartAI', ScriptName='' WHERE entry=17478;
UPDATE creature_template SET pickpocketloot=17478, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18050;
DELETE FROM smart_scripts WHERE entryorguid=17478 AND source_type=0;
INSERT INTO smart_scripts VALUES(17478, 0, 0, 0, 11, 0, 100, 7, 0, 0, 0, 0, 11, 31059, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - On Respawn - Cast Hellfire Channeling');
INSERT INTO smart_scripts VALUES(17478, 0, 1, 0, 21, 0, 100, 7, 1000, 1000, 1000, 1000, 11, 31059, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - On Reached Home - Cast Hellfire Channeling');
INSERT INTO smart_scripts VALUES(17478, 0, 2, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17478, 0, 3, 0, 0, 0, 100, 2, 100, 1000, 2000, 2000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(17478, 0, 4, 0, 0, 0, 100, 4, 100, 1000, 2000, 2000, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES(17478, 0, 5, 0, 0, 0, 100, 0, 3000, 9000, 10000, 13000, 11, 30615, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES(17478, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 30659, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bleeding Hollow Scryer - On Death - Cast Fel Infusion');

-- SPELL Fel Infusion (30659)
DELETE FROM conditions WHERE SourceEntry IN(30659) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 7, 30659, 0, 0, 31, 0, 3, 17281, 0, 0, 0, 0, '', 'Target Bonechewer Ripper');

-- Bonechewer Ripper (17281, 18055)
DELETE FROM creature_text WHERE entry=17281;
INSERT INTO creature_text VALUES (17281, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
INSERT INTO creature_text VALUES (17281, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Ripper');
UPDATE creature_template SET pickpocketloot=17281, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=17281;
UPDATE creature_template SET pickpocketloot=17281, mechanic_immune_mask=650854271, AIName='', ScriptName='' WHERE entry=18055;
DELETE FROM smart_scripts WHERE entryorguid=17281 AND source_type=0;
INSERT INTO smart_scripts VALUES(17281, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17281, 0, 1, 0, 0, 0, 100, 0, 0, 0, 10000, 20000, 11, 18501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - In Combat - Cast Enrage');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Watchkeeper Gargolmar (17306, 18436)
DELETE FROM creature_text WHERE entry=17306;
INSERT INTO creature_text VALUES (17306, 0, 0, 'Do you smell that? Fresh meat has somehow breached our citadel. Be wary of any intruders.', 14, 0, 100, 0, 0, 0, 0, 'gargolmar SAY_TAUNT');
INSERT INTO creature_text VALUES (17306, 1, 0, 'Heal me! QUICKLY!', 14, 0, 100, 0, 0, 10329, 0, 'gargolmar SAY_HEAL');
INSERT INTO creature_text VALUES (17306, 2, 0, 'Back off, pup!', 14, 0, 100, 0, 0, 10330, 0, 'gargolmar SAY_SURGE');
INSERT INTO creature_text VALUES (17306, 3, 0, 'What have we here...?', 14, 0, 100, 0, 0, 10331, 0, 'gargolmar SAY_AGGRO_1');
INSERT INTO creature_text VALUES (17306, 3, 1, 'Heh... this may hurt a little.', 14, 0, 100, 0, 0, 10332, 0, 'gargolmar SAY_AGGRO_2');
INSERT INTO creature_text VALUES (17306, 3, 2, 'I''m gonna enjoy this.', 14, 0, 100, 0, 0, 10333, 0, 'gargolmar SAY_AGGRO_3');
INSERT INTO creature_text VALUES (17306, 4, 0, 'Say farewell!', 14, 0, 100, 0, 0, 10334, 0, 'gargolmar SAY_KILL_1');
INSERT INTO creature_text VALUES (17306, 4, 1, 'Much too easy...', 14, 0, 100, 0, 0, 10335, 0, 'gargolmar SAY_KILL_2');
INSERT INTO creature_text VALUES (17306, 5, 0, 'Hahah.. <cough> ..argh!', 14, 0, 100, 0, 0, 10336, 0, 'gargolmar SAY_DIE');
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, pickpocketloot=17306, dmg_multiplier=9, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_watchkeeper_gargolmar' WHERE entry=17306;
UPDATE creature_template SET speed_walk=1, speed_run=1.14286, pickpocketloot=17306, dmg_multiplier=16, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=18436;

-- Hellfire Watcher (17309, 18058)
DELETE FROM creature_text WHERE entry=17309;
UPDATE creature_template SET pickpocketloot=17309, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17309;
UPDATE creature_template SET pickpocketloot=17309, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18058;
DELETE FROM smart_scripts WHERE entryorguid=17309 AND source_type=0;
INSERT INTO smart_scripts VALUES(17309, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 7000, 10000, 11, 14032, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES(17309, 0, 1, 0, 0, 1, 100, 0, 0, 3000, 10000, 15000, 11, 8362, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Renew');
INSERT INTO smart_scripts VALUES(17309, 0, 2, 0, 0, 1, 100, 2, 0, 3000, 3000, 3000, 11, 12039, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Heal');
INSERT INTO smart_scripts VALUES(17309, 0, 3, 0, 0, 1, 100, 4, 0, 3000, 3000, 3000, 11, 30643, 0, 0, 0, 0, 0, 19, 17306, 40, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Heal');
INSERT INTO smart_scripts VALUES(17309, 0, 4, 0, 38, 0, 100, 0, 17309, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Set Event Phase');

-- Omor the Unscarred (17308, 18433)
DELETE FROM creature_text WHERE entry=17308;
INSERT INTO creature_text VALUES (17308, 0, 0, 'You dare stand against me?!', 14, 0, 100, 0, 0, 10280, 0, 'omor SAY_AGGRO_1');
INSERT INTO creature_text VALUES (17308, 0, 1, 'I will not be defeated!', 14, 0, 100, 0, 0, 10279, 0, 'omor SAY_AGGRO_2');
INSERT INTO creature_text VALUES (17308, 0, 2, 'Your insolence will be your death.', 14, 0, 100, 0, 0, 10281, 0, 'omor SAY_AGGRO_3');
INSERT INTO creature_text VALUES (17308, 1, 0, 'Achor-she-ki! Feast my pet! Eat your fill!', 14, 0, 100, 0, 0, 10277, 0, 'omor SAY_SUMMON');
INSERT INTO creature_text VALUES (17308, 2, 0, 'A-Kreesh!', 14, 0, 100, 0, 0, 10278, 0, 'omor SAY_CURSE');
INSERT INTO creature_text VALUES (17308, 3, 0, 'Die, weakling!', 14, 0, 100, 0, 0, 10282, 0, 'omor SAY_KILL_1');
INSERT INTO creature_text VALUES (17308, 4, 0, 'It is... not over.', 14, 0, 100, 0, 0, 10284, 0, 'omor SAY_DIE');
INSERT INTO creature_text VALUES (17308, 5, 0, 'I am victorious!', 14, 0, 100, 0, 0, 10283, 0, 'omor SAY_WIPE');
UPDATE creature_template SET speed_walk=2, speed_run=1.42857, pickpocketloot=0, dmg_multiplier=9, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_omor_the_unscarred' WHERE entry=17308;
UPDATE creature_template SET speed_walk=2, speed_run=1.42857, pickpocketloot=0, dmg_multiplier=16, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=18433;

-- Fiendish Hound (17540, 18056)
DELETE FROM creature_text WHERE entry=17540;
UPDATE creature_template SET pickpocketloot=0, rank=0, dmg_multiplier=2, baseattacktime=1300, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17540;
UPDATE creature_template SET pickpocketloot=0, rank=0, dmg_multiplier=4, baseattacktime=1300, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=18056;
DELETE FROM smart_scripts WHERE entryorguid=17540 AND source_type=0;
INSERT INTO smart_scripts VALUES(17540, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 7000, 10000, 11, 35748, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Drain Life');
INSERT INTO smart_scripts VALUES(17540, 0, 1, 0, 0, 0, 100, 4, 5000, 6000, 10000, 15000, 11, 15785, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Hellfire Watcher - In Combat - Cast Mana Burn');

-- Vazruden the Herald (17307, 18435)
DELETE FROM creature_text WHERE entry=17307;
INSERT INTO creature_text VALUES (17307, 0, 0, 'You have faced many challenges, pity they were all in vain. Soon your people will kneel to my lord!', 14, 0, 100, 0, 0, 10292, 0, 'vazruden the herald SAY_INTRO');
UPDATE creature_template SET speed_walk=4, speed_run=2.5, unit_flags=2, lootid=0, pickpocketloot=0, InhabitType=4, AIName='', ScriptName='boss_vazruden_the_herald' WHERE entry=17307;
UPDATE creature_template SET speed_walk=4, speed_run=2.5, unit_flags=2, lootid=0, pickpocketloot=0, InhabitType=4, AIName='', ScriptName='' WHERE entry=18435;

-- Vazruden (17537, 18434)
DELETE FROM creature_text WHERE entry=17537;
INSERT INTO creature_text VALUES (17537, 0, 0, 'Is there no one left to test me?', 14, 0, 100, 0, 0, 10293, 0, 'vazruden SAY_WIPE');
INSERT INTO creature_text VALUES (17537, 1, 0, 'Your time is running out!', 14, 0, 100, 0, 0, 10294, 0, 'vazruden SAY_AGGRO_1');
INSERT INTO creature_text VALUES (17537, 1, 1, 'You are nothing, I answer a higher call!', 14, 0, 100, 0, 0, 10295, 0, 'vazruden SAY_AGGRO_2');
INSERT INTO creature_text VALUES (17537, 1, 2, 'The Dark Lord laughs at you!', 14, 0, 100, 0, 0, 10296, 0, 'vazruden SAY_AGGRO_3');
INSERT INTO creature_text VALUES (17537, 2, 0, 'It is over. Finished!', 14, 0, 100, 0, 0, 10297, 0, 'vazruden SAY_KILL_1');
INSERT INTO creature_text VALUES (17537, 2, 1, 'Your days are done!', 14, 0, 100, 0, 0, 10298, 0, 'vazruden SAY_KILL_2');
INSERT INTO creature_text VALUES (17537, 3, 0, 'My lord will be the end you all...', 14, 0, 100, 0, 0, 10299, 0, 'vazruden SAY_DIE');
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, dmg_multiplier=9, baseattacktime=1300, lootid=17537, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_vazruden' WHERE entry=17537;
UPDATE creature_template SET speed_walk=1, speed_run=1.42857, dmg_multiplier=16, baseattacktime=1300, lootid=17537, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=18434;

-- Nazan (17536, 18432)
DELETE FROM creature_text WHERE entry=17536;
INSERT INTO creature_text VALUES (17536, 0, 0, '%s descends from the sky.', 41, 0, 100, 0, 0, 0, 0, 'nazan EMOTE');
UPDATE creature_template SET pickpocketloot=0, skinloot=70065, InhabitType=5, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_nazan' WHERE entry=17536;
UPDATE creature_template SET pickpocketloot=0, skinloot=70065, InhabitType=5, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=18432;

-- Hellfire Sentry (17517, 18057)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=17517);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=17517);
DELETE FROM creature WHERE id=17517;
DELETE FROM creature_text WHERE entry=17517;
UPDATE creature_template SET pickpocketloot=17517, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17517;
UPDATE creature_template SET pickpocketloot=17517, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18057;
DELETE FROM smart_scripts WHERE entryorguid=17517 AND source_type=0;
INSERT INTO smart_scripts VALUES(17517, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 10000, 15000, 11, 30621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Sentry - In Combat - Cast Kidney Shot');

-- GO Liquid Fire (181890, 182533)
UPDATE gameobject_template SET data2=6 WHERE entry IN(181890, 182533);

-- GO Reinforced Fel Iron Chest (185168, 185169)
UPDATE gameobject_template SET flags=6553616 WHERE entry IN(185168, 185169);
UPDATE gameobject SET spawntimesecs=86400 WHERE id IN(185168, 185169);

-- SPELL Fireball (33793, 33794)
-- SPELL Cone of Fire (30926, 36921)
DELETE FROM spell_script_names WHERE spell_id IN(33793, 33794, 30926, 36921);
INSERT INTO spell_script_names VALUES(33793, 'spell_vazruden_fireball');
INSERT INTO spell_script_names VALUES(33794, 'spell_vazruden_fireball');
INSERT INTO spell_script_names VALUES(30926, 'spell_vazruden_fireball'); -- same script
INSERT INTO spell_script_names VALUES(36921, 'spell_vazruden_fireball'); -- same script

-- SPELL Call Nazan (30693)
DELETE FROM conditions WHERE SourceEntry IN(30693) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 30693, 0, 0, 31, 0, 3, 17536, 0, 0, 0, 0, '', 'Target Nazan');
DELETE FROM spell_script_names WHERE spell_id IN(30693);
INSERT INTO spell_script_names VALUES(30693, 'spell_vazruden_call_nazan');


-- -------------------------------------------
--                MISC
-- -------------------------------------------
DELETE FROM creature_formations WHERE leaderGUID IN(202628, 202629, 202630, 202692);
INSERT INTO creature_formations VALUES (202628, 202628, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (202628, 202680, 3, 90, 2, 3, 7);
INSERT INTO creature_formations VALUES (202628, 202682, 3, 90, 2, 3, 7);
INSERT INTO creature_formations VALUES (202629, 202629, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (202629, 202681, 3, 100, 2, 1, 6);
INSERT INTO creature_formations VALUES (202629, 202684, 3, 260, 2, 1, 6);
INSERT INTO creature_formations VALUES (202630, 202630, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (202630, 202683, 3, 100, 2, 0, 0);
INSERT INTO creature_formations VALUES (202630, 202685, 3, 260, 2, 0, 0);
INSERT INTO creature_formations VALUES (202692, 202692, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (202692, 202695, 4, 100, 2, 9, 17);
INSERT INTO creature_formations VALUES (202692, 202696, 4, 260, 2, 9, 17);


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Mortal Wound (30641, 36814)
DELETE FROM spelldifficulty_dbc WHERE id IN(30641, 36814) OR spellid0 IN(30641, 36814) OR spellid1 IN(30641, 36814) OR spellid2 IN(30641, 36814) OR spellid3 IN(30641, 36814);
INSERT INTO spelldifficulty_dbc VALUES (30641, 30641, 36814, 0, 0);

-- Shadow Bolt (30686, 39297)
DELETE FROM spelldifficulty_dbc WHERE id IN(30686, 39297) OR spellid0 IN(30686, 39297) OR spellid1 IN(30686, 39297) OR spellid2 IN(30686, 39297) OR spellid3 IN(30686, 39297);
INSERT INTO spelldifficulty_dbc VALUES (30686, 30686, 39297, 0, 0);

-- Treacherous Aura (30695, 37566)
DELETE FROM spelldifficulty_dbc WHERE id IN(30695, 37566) OR spellid0 IN(30695, 37566) OR spellid1 IN(30695, 37566) OR spellid2 IN(30695, 37566) OR spellid3 IN(30695, 37566);
INSERT INTO spelldifficulty_dbc VALUES (30695, 30695, 37566, 0, 0);

-- Fireball (33793, 33794)
DELETE FROM spelldifficulty_dbc WHERE id IN(33793, 33794) OR spellid0 IN(33793, 33794) OR spellid1 IN(33793, 33794) OR spellid2 IN(33793, 33794) OR spellid3 IN(33793, 33794);
INSERT INTO spelldifficulty_dbc VALUES (33793, 33793, 33794, 0, 0);

-- Summon Liquid Fire (31706, 30928)
DELETE FROM spelldifficulty_dbc WHERE id IN(31706, 30928) OR spellid0 IN(31706, 30928) OR spellid1 IN(31706, 30928) OR spellid2 IN(31706, 30928) OR spellid3 IN(31706, 30928);
INSERT INTO spelldifficulty_dbc VALUES (31706, 31706, 30928, 0, 0);

-- Cone of Fire (30926, 36921)
DELETE FROM spelldifficulty_dbc WHERE id IN(30926, 36921) OR spellid0 IN(30926, 36921) OR spellid1 IN(30926, 36921) OR spellid2 IN(30926, 36921) OR spellid3 IN(30926, 36921);
INSERT INTO spelldifficulty_dbc VALUES (30926, 30926, 36921, 0, 0);


UPDATE creature SET spawntimesecs=86400 WHERE map=545 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Coilfang Warrior (17802, 20626)
UPDATE creature_template SET pickpocketloot=17802, AIName='SmartAI', ScriptName='' WHERE entry=17802;
UPDATE creature_template SET pickpocketloot=17802, AIName='', ScriptName='' WHERE entry=20626;
DELETE FROM smart_scripts WHERE entryorguid=17802 AND source_type=0;
INSERT INTO smart_scripts VALUES (17802, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Warrior - On Aggro - Cast Spell Defensive Stance');
INSERT INTO smart_scripts VALUES (17802, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 120000, 120000, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Warrior - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (17802, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 12000, 16000, 11, 35105, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Warrior - In Combat - Cast Mortal Blow');

-- Coilfang Siren (17801, 20623)
DELETE FROM creature_text WHERE entry=17801;
INSERT INTO creature_text VALUES (17801, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Siren');
INSERT INTO creature_text VALUES (17801, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Siren');
INSERT INTO creature_text VALUES (17801, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Siren');
INSERT INTO creature_text VALUES (17801, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Siren');
INSERT INTO creature_text VALUES (17801, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Siren');
UPDATE creature_template SET pickpocketloot=17801, AIName='SmartAI', ScriptName='' WHERE entry=17801;
UPDATE creature_template SET pickpocketloot=17801, AIName='', ScriptName='' WHERE entry=20623;
DELETE FROM smart_scripts WHERE entryorguid=17801 AND source_type=0;
INSERT INTO smart_scripts VALUES (17801, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17801, 0, 1, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 15234, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17801, 0, 2, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 37664, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (17801, 0, 3, 0, 0, 0, 100, 2, 6000, 9000, 14000, 16000, 11, 35106, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast Arcane Flare');
INSERT INTO smart_scripts VALUES (17801, 0, 4, 0, 0, 0, 100, 4, 6000, 9000, 14000, 16000, 11, 37856, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast Arcane Flare');
INSERT INTO smart_scripts VALUES (17801, 0, 5, 0, 0, 0, 100, 0, 10000, 14000, 18000, 18000, 11, 38660, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Coilfang Siren - In Combat - Cast Fear');

-- Coilfang Engineer (17721, 20620)
DELETE FROM creature_text WHERE entry=17721;
INSERT INTO creature_text VALUES (17721, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Engineer');
INSERT INTO creature_text VALUES (17721, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Engineer');
INSERT INTO creature_text VALUES (17721, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Engineer');
INSERT INTO creature_text VALUES (17721, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Engineer');
INSERT INTO creature_text VALUES (17721, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Engineer');
UPDATE creature_template SET pickpocketloot=17721, AIName='SmartAI', ScriptName='' WHERE entry=17721;
UPDATE creature_template SET pickpocketloot=17721, AIName='', ScriptName='' WHERE entry=20620;
DELETE FROM smart_scripts WHERE entryorguid=17721 AND source_type=0;
INSERT INTO smart_scripts VALUES (17721, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17721, 0, 1, 0, 0, 0, 100, 2, 6000, 8000, 9000, 13000, 11, 40331, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (17721, 0, 2, 0, 0, 0, 100, 4, 6000, 8000, 9000, 13000, 11, 40332, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (17721, 0, 3, 0, 0, 0, 100, 0, 4000, 7000, 6000, 7000, 11, 6533, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Coilfang Engineer - In Combat - Cast Net');

-- Coilfang Oracle (17803, 20622)
DELETE FROM creature_text WHERE entry=17803;
INSERT INTO creature_text VALUES (17803, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Oracle');
INSERT INTO creature_text VALUES (17803, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Oracle');
INSERT INTO creature_text VALUES (17803, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Oracle');
INSERT INTO creature_text VALUES (17803, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Oracle');
INSERT INTO creature_text VALUES (17803, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Oracle');
UPDATE creature_template SET pickpocketloot=17803, AIName='SmartAI', ScriptName='' WHERE entry=17803;
UPDATE creature_template SET pickpocketloot=17803, AIName='', ScriptName='' WHERE entry=20622;
DELETE FROM smart_scripts WHERE entryorguid=17803 AND source_type=0;
INSERT INTO smart_scripts VALUES (17803, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17803, 0, 1, 0, 0, 0, 100, 2, 5000, 8000, 13000, 15000, 11, 22582, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (17803, 0, 2, 0, 0, 0, 100, 4, 5000, 8000, 13000, 15000, 11, 37865, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (17803, 0, 3, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 31730, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (17803, 0, 4, 0, 14, 0, 100, 4, 2000, 40, 7000, 10000, 11, 22883, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (17803, 0, 5, 0, 0, 0, 100, 0, 9000, 12000, 14000, 17000, 11, 8281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Oracle - In Combat - Cast Sonic Burst');

-- Bog Overlord (21694, 21914)
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=21694;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=21914;
DELETE FROM smart_scripts WHERE entryorguid=21694 AND source_type=0;
INSERT INTO smart_scripts VALUES (21694, 0, 0, 0, 1, 0, 100, 3, 500, 500, 0, 0, 11, 37266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Out of Combat - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES (21694, 0, 1, 0, 1, 0, 100, 5, 500, 500, 0, 0, 11, 37863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Out of Combat - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES (21694, 0, 2, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 34158, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - Out of Combat - Cast Fungal Decay');
INSERT INTO smart_scripts VALUES (21694, 0, 3, 0, 0, 0, 100, 2, 3000, 4000, 5000, 7000, 11, 37272, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast Poison Bolt');
INSERT INTO smart_scripts VALUES (21694, 0, 4, 0, 0, 0, 100, 4, 3000, 4000, 5000, 7000, 11, 37862, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast Poison Bolt');
INSERT INTO smart_scripts VALUES (21694, 0, 5, 0, 0, 0, 100, 0, 7000, 10000, 12000, 15000, 11, 40340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (21694, 0, 6, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Overlord - HP 20% - Cast Enrage');

-- Tidal Surger (21695, 21917)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21695;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21917;
DELETE FROM smart_scripts WHERE entryorguid=21695 AND source_type=0;
INSERT INTO smart_scripts VALUES (21695, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 14000, 17000, 11, 37250, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidal Surger - In Combat - Cast Water Spout');
INSERT INTO smart_scripts VALUES (21695, 0, 1, 0, 0, 0, 100, 0, 9000, 14000, 12000, 15000, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidal Surger - In Combat - Cast Frost Nova');

-- Steam Surger (21696, 21916)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21696;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21916;
DELETE FROM smart_scripts WHERE entryorguid=21696 AND source_type=0;
INSERT INTO smart_scripts VALUES (21696, 0, 0, 0, 0, 0, 100, 2, 3000, 7000, 11000, 14000, 11, 37252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Steam Surger - In Combat - Cast Water Bolt');
INSERT INTO smart_scripts VALUES (21696, 0, 1, 0, 0, 0, 100, 4, 3000, 7000, 11000, 14000, 11, 39412, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Steam Surger - In Combat - Cast Water Bolt');

-- Coilfang Water Elemental (17917, 20627)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17917;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20627;
DELETE FROM smart_scripts WHERE entryorguid=17917 AND source_type=0;
INSERT INTO smart_scripts VALUES (17917, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 7000, 12000, 11, 34449, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Water Elemental - In Combat - Cast Water Bolt Volley');
INSERT INTO smart_scripts VALUES (17917, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 7000, 12000, 11, 37924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Water Elemental - In Combat - Cast Water Bolt Volley');

-- Coilfang Myrmidon (17800, 20621)
DELETE FROM creature_text WHERE entry=17800;
INSERT INTO creature_text VALUES (17800, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Myrmidon');
INSERT INTO creature_text VALUES (17800, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Myrmidon');
INSERT INTO creature_text VALUES (17800, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Myrmidon');
INSERT INTO creature_text VALUES (17800, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Myrmidon');
INSERT INTO creature_text VALUES (17800, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Myrmidon');
UPDATE creature_template SET pickpocketloot=17800, AIName='SmartAI', ScriptName='' WHERE entry=17800;
UPDATE creature_template SET pickpocketloot=17800, AIName='', ScriptName='' WHERE entry=20621;
DELETE FROM smart_scripts WHERE entryorguid=17800 AND source_type=0;
INSERT INTO smart_scripts VALUES (17800, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17800, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (17800, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 11, 7160, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Myrmidon - On Target HP 20% - Cast Execute');

-- Coilfang Sorceress (17722, 20625)
DELETE FROM creature_text WHERE entry=17722;
INSERT INTO creature_text VALUES (17722, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Sorceress');
INSERT INTO creature_text VALUES (17722, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Sorceress');
INSERT INTO creature_text VALUES (17722, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Sorceress');
INSERT INTO creature_text VALUES (17722, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Sorceress');
INSERT INTO creature_text VALUES (17722, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Sorceress');
UPDATE creature_template SET pickpocketloot=17722, AIName='SmartAI', ScriptName='' WHERE entry=17722;
UPDATE creature_template SET pickpocketloot=17722, AIName='', ScriptName='' WHERE entry=20625;
DELETE FROM smart_scripts WHERE entryorguid=17722 AND source_type=0;
INSERT INTO smart_scripts VALUES (17722, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17722, 0, 1, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (17722, 0, 2, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 37930, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (17722, 0, 3, 0, 0, 0, 100, 2, 6000, 9000, 14000, 16000, 11, 15063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (17722, 0, 4, 0, 0, 0, 100, 4, 6000, 9000, 14000, 16000, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (17722, 0, 5, 0, 0, 0, 100, 2, 18000, 24000, 28000, 28000, 11, 39416, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (17722, 0, 6, 0, 0, 0, 100, 4, 18000, 24000, 28000, 28000, 11, 31581, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilfang Sorceress - In Combat - Cast Blizzard');

-- Coilfang Slavemaster (17805, 20624)
DELETE FROM creature_text WHERE entry=17805;
INSERT INTO creature_text VALUES (17805, 0, 0, "Get back to work you!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 0, 1, "Hurry up with it already! The longer you take, the more of a hurtin' I'm putting on you!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 0, 2, "This is terrible..... my arms grow tired from beating on you lazy peons!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 0, 3, "Too soon! You are slacking off too soon!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 0, 4, "Wake up! Now get up and back to work!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 0, 5, "What is this?! Didn't mommy and daddy teach you anything?!", 14, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 1, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 1, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 1, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 1, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
INSERT INTO creature_text VALUES (17805, 1, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Coilfang Slavemaster');
UPDATE creature_template SET pickpocketloot=17805, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17805;
UPDATE creature_template SET pickpocketloot=17805, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20624;
DELETE FROM smart_scripts WHERE entryorguid=17805 AND source_type=0;
INSERT INTO smart_scripts VALUES (17805, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavemaster - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (17805, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 12000, 15000, 11, 10987, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavemaster - In Combat - Cast Geyser');
INSERT INTO smart_scripts VALUES (17805, 0, 2, 0, 0, 0, 100, 0, 4100, 7100, 11000, 15000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavemaster - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (17805, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 17799, 15, 1, 0, 0, 0, 0, 'Coilfang Slavemaster - On Aggro - Set Data 2 2');
INSERT INTO smart_scripts VALUES (17805, 0, 4, 5, 1, 0, 100, 0, 5000, 25000, 20000, 40000, 11, 6754, 0, 0, 0, 0, 0, 19, 17799, 5, 0, 0, 0, 0, 0, 'Coilfang Slavemaster - Out Of Combat - Cast Slap!');
INSERT INTO smart_scripts VALUES (17805, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Slavemaster - Out Of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (17805, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 17799, 15, 1, 0, 0, 0, 0, 'Coilfang Slavemaster - On Death - Set Data 1 1');

-- Dreghood Slave (17799, 20628)
DELETE FROM creature_text WHERE entry=17799;
INSERT INTO creature_text VALUES (17799, 0, 0, "Free at last!", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 1, "Will the pain ever end?", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 2, "We have waited forever for this day to come!", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 3, "The pain is finally over.", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 4, "How can we ever repay you for this?", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 5, "I spit on the corpse of these filthy naga.", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
INSERT INTO creature_text VALUES (17799, 0, 6, "Thank you!", 14, 0, 100, 0, 0, 0, 0, 'Dreghood Slave');
UPDATE creature_template SET pickpocketloot=17799, AIName='SmartAI', ScriptName='' WHERE entry=17799;
UPDATE creature_template SET pickpocketloot=17799, AIName='', ScriptName='' WHERE entry=20628;
DELETE FROM smart_scripts WHERE entryorguid=17799 AND source_type=0;
INSERT INTO smart_scripts VALUES (17799, 0, 0, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreghood Slave - HP 20% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (17799, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -139, -312, -7.3, 0, 'Dreghood Slave - On Data Set - Move Point');
INSERT INTO smart_scripts VALUES (17799, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreghood Slave - On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (17799, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreghood Slave - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (17799, 0, 4, 0, 38, 0, 100, 0, 2, 2, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Dreghood Slave - On Data Set - Attack Start');

-- Coilfang Leper (21338, 21915)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21338;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21915;
DELETE FROM smart_scripts WHERE entryorguid=21338 AND source_type=0;
INSERT INTO smart_scripts VALUES (21338, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 31, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - Out of Combat - Random Phase Range');
INSERT INTO smart_scripts VALUES (21338, 0, 1, 0, 14, 1, 100, 2, 1000, 40, 5000, 7000, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - On Friendly HP - Cast Heal');
INSERT INTO smart_scripts VALUES (21338, 0, 2, 0, 14, 1, 100, 4, 2000, 40, 5000, 7000, 11, 15586, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - On Friendly HP - Cast Heal');
INSERT INTO smart_scripts VALUES (21338, 0, 3, 0, 0, 2, 100, 0, 4000, 6000, 7000, 8000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (21338, 0, 4, 0, 0, 2, 100, 0, 3000, 7000, 10000, 15000, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Sunder Armor');
INSERT INTO smart_scripts VALUES (21338, 0, 5, 0, 0, 2, 100, 0, 9000, 14000, 12000, 15000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (21338, 0, 6, 0, 0, 4, 100, 2, 4000, 6000, 9000, 10000, 11, 13339, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (21338, 0, 7, 0, 0, 4, 100, 4, 4000, 6000, 9000, 10000, 11, 14145, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (21338, 0, 8, 0, 0, 4, 100, 2, 0, 0, 3000, 3000, 11, 9613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (21338, 0, 9, 0, 0, 4, 100, 4, 0, 0, 3000, 3000, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Leper - In Combat - Cast Shadow Bolt');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Hydromancer Thespia (17797, 20629)
UPDATE creature_template SET pickpocketloot=17797, AIName='', ScriptName='boss_hydromancer_thespia' WHERE entry=17797;
UPDATE creature_template SET pickpocketloot=17797, AIName='', ScriptName='' WHERE entry=20629;
DELETE FROM smart_scripts WHERE entryorguid=17797 AND source_type=0;

-- Mekgineer Steamrigger (17796, 20630)
UPDATE creature_template SET pickpocketloot=17796, AIName='', ScriptName='boss_mekgineer_steamrigger' WHERE entry=17796;
UPDATE creature_template SET pickpocketloot=17796, AIName='', ScriptName='' WHERE entry=20630;
DELETE FROM smart_scripts WHERE entryorguid=17796 AND source_type=0;
-- Steamrigger Mechanic (17951, 20632)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=17951);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=17951);
DELETE FROM creature WHERE id=17951;
UPDATE creature_template SET AIName='', ScriptName='npc_steamrigger_mechanic' WHERE entry=17951;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20632;
DELETE FROM smart_scripts WHERE entryorguid=17951 AND source_type=0;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND sourceEntry IN(31532, 37936);
INSERT INTO conditions VALUES(13, 1, 31532, 0, 0, 31, 0, 3, 17796, 0, 0, 0, 0, "", "Mekgineer Steamrigger");
INSERT INTO conditions VALUES(13, 1, 37936, 0, 0, 31, 0, 3, 17796, 0, 0, 0, 0, "", "Mekgineer Steamrigger");

-- Warlord Kalithresh (17798, 20633)
UPDATE creature_template SET pickpocketloot=17798, AIName='', ScriptName='boss_warlord_kalithresh' WHERE entry=17798;
UPDATE creature_template SET pickpocketloot=17798, AIName='', ScriptName='' WHERE entry=20633;
DELETE FROM smart_scripts WHERE entryorguid=17798 AND source_type=0;
-- Naga Distiller (17954, 20631)
UPDATE creature_template SET AIName='', ScriptName='npc_naga_distiller' WHERE entry=17954;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20631;
DELETE FROM smart_scripts WHERE entryorguid=17954 AND source_type=0;


-- -------------------------------------------
--                MISC
-- -------------------------------------------
-- Main Chambers Access Panel (184125)
-- Main Chambers Access Panel (184126)
UPDATE gameobject_template SET ScriptName='go_main_chambers_access_panel' WHERE entry IN(184125, 184126);

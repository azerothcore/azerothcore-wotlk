
UPDATE creature SET spawntimesecs=86400 WHERE map=557 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Ethereal Scavenger (18309, 20258)
DELETE FROM creature_text WHERE entry=18309;
INSERT INTO creature_text VALUES (18309, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Scavenger');
INSERT INTO creature_text VALUES (18309, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Scavenger');
INSERT INTO creature_text VALUES (18309, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Scavenger');
INSERT INTO creature_text VALUES (18309, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Scavenger');
UPDATE creature_template SET pickpocketloot=18309, AIName='SmartAI', ScriptName='' WHERE entry=18309;
UPDATE creature_template SET pickpocketloot=18309, AIName='', ScriptName='' WHERE entry=20258;
DELETE FROM smart_scripts WHERE entryorguid=18309 AND source_type=0;
INSERT INTO smart_scripts VALUES (18309, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Scavenger - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18309, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 8000, 12000, 11, 34920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Scavenger - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (18309, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 11900, 14000, 11, 33865, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Scavenger - In Combat - Cast Singe');
INSERT INTO smart_scripts VALUES (18309, 0, 3, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 33871, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Scavenger - On Target Cast - Cast Shield Bash');

-- Ethereal Crypt Raider (18311, 20255)
DELETE FROM creature_text WHERE entry=18311;
INSERT INTO creature_text VALUES (18311, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Crypt Raider');
INSERT INTO creature_text VALUES (18311, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Crypt Raider');
INSERT INTO creature_text VALUES (18311, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Crypt Raider');
INSERT INTO creature_text VALUES (18311, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Crypt Raider');
UPDATE creature_template SET pickpocketloot=18311, AIName='SmartAI', ScriptName='' WHERE entry=18311;
UPDATE creature_template SET pickpocketloot=18311, AIName='', ScriptName='' WHERE entry=20255;
DELETE FROM smart_scripts WHERE entryorguid=18311 AND source_type=0;
INSERT INTO smart_scripts VALUES (18311, 0, 0, 1, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Crypt Raider - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18311, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Crypt Raider - On Aggro - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (18311, 0, 2, 0, 0, 0, 100, 0, 5000, 8000, 12900, 15000, 11, 32315, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Crypt Raider - In Combat - Cast Soul Strike');
INSERT INTO smart_scripts VALUES (18311, 0, 3, 0, 2, 1, 100, 0, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Crypt Raider - At HP 30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (18311, 0, 4, 0, 9, 0, 100, 0, 8, 25, 15000, 15000, 11, 22911, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Crypt Raider - At Range 8 to 25 - Cast Charge');

-- Arcane Fiend (18429, 20252)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18429;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20252;
DELETE FROM smart_scripts WHERE entryorguid=18429 AND source_type=0;
INSERT INTO smart_scripts VALUES (18429, 0, 0, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 15122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcane Fiend - On Target Cast - Cast Counterspell');
INSERT INTO smart_scripts VALUES (18429, 0, 1, 0, 0, 0, 100, 2, 1300, 3700, 4800, 6500, 11, 15253, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Fiend - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (18429, 0, 2, 0, 0, 0, 100, 4, 1300, 3700, 4800, 6500, 11, 33860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Fiend - In Combat - Cast Arcane Explosion');

-- Ethereal Sorcerer (18313, 20259)
DELETE FROM creature_text WHERE entry=18313;
INSERT INTO creature_text VALUES (18313, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Sorcerer');
INSERT INTO creature_text VALUES (18313, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Sorcerer');
INSERT INTO creature_text VALUES (18313, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Sorcerer');
INSERT INTO creature_text VALUES (18313, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Sorcerer');
UPDATE creature_template SET pickpocketloot=18313, AIName='SmartAI', ScriptName='' WHERE entry=18313;
UPDATE creature_template SET pickpocketloot=18313, AIName='', ScriptName='' WHERE entry=20259;
DELETE FROM smart_scripts WHERE entryorguid=18313 AND source_type=0;
INSERT INTO smart_scripts VALUES (18313, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18313, 0, 2, 0, 0, 0, 100, 2, 0, 0, 10500, 10500, 11, 15790, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18313, 0, 3, 0, 0, 0, 100, 4, 0, 0, 10500, 10500, 11, 22272, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18313, 0, 4, 0, 0, 0, 100, 0, 5000, 8000, 10000, 15000, 11, 25603, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Slow');
INSERT INTO smart_scripts VALUES (18313, 0, 5, 6, 0, 0, 100, 0, 14000, 20000, 23000, 23000, 11, 32349, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Summon Arcane Fiend');
INSERT INTO smart_scripts VALUES (18313, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32353, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Sorcerer - In Combat - Cast Summon Arcane Fiend');

-- Ethereal Priest (18317, 20257)
DELETE FROM creature_text WHERE entry=18317;
INSERT INTO creature_text VALUES (18317, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Priest');
INSERT INTO creature_text VALUES (18317, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Priest');
INSERT INTO creature_text VALUES (18317, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Priest');
INSERT INTO creature_text VALUES (18317, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Priest');
UPDATE creature_template SET pickpocketloot=18317, AIName='SmartAI', ScriptName='' WHERE entry=18317;
UPDATE creature_template SET pickpocketloot=18317, AIName='', ScriptName='' WHERE entry=20257;
DELETE FROM smart_scripts WHERE entryorguid=18317 AND source_type=0;
INSERT INTO smart_scripts VALUES (18317, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18317, 0, 1, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 34945, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18317, 0, 2, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 22883, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18317, 0, 3, 0, 0, 0, 100, 2, 6700, 7900, 16000, 18000, 11, 34944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (18317, 0, 4, 0, 0, 0, 100, 4, 6700, 7900, 16000, 18000, 11, 37669, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (18317, 0, 5, 0, 16, 0, 100, 2, 17139, 40, 7000, 10000, 11, 17139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - Missing Buff - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (18317, 0, 6, 0, 16, 0, 100, 4, 35944, 40, 7000, 10000, 11, 35944, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Priest - Missing Buff - Cast Power Word: Shield');

-- Mana Leech (19306, 20263)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19306;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20263;
DELETE FROM smart_scripts WHERE entryorguid=19306 AND source_type=0;
INSERT INTO smart_scripts VALUES (19306, 0, 0, 0, 0, 0, 100, 0, 8200, 12000, 18700, 18700, 11, 15785, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Mana Leech - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (19306, 0, 1, 0, 0, 0, 100, 0, 5000, 11000, 14800, 16500, 11, 25602, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Mana Leech - In Combat - Cast Faerie Fire');
INSERT INTO smart_scripts VALUES (19306, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 34933, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mana Leech - On Death - Cast Arcane Explosion');

-- Nexus Terror (19307, 20265)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19307;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20265;
DELETE FROM smart_scripts WHERE entryorguid=19307 AND source_type=0;
INSERT INTO smart_scripts VALUES (19307, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 16000, 25000, 11, 34922, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Nexus Terror - In Combat - Cast Shadow Embrace');
INSERT INTO smart_scripts VALUES (19307, 0, 1, 0, 0, 0, 100, 0, 7000, 17000, 60000, 60000, 11, 34925, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Nexus Terror - In Combat - Cast Curse of Impotence');
INSERT INTO smart_scripts VALUES (19307, 0, 2, 0, 0, 0, 100, 0, 8000, 14000, 16000, 22000, 11, 38065, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Nexus Terror - In Combat - Cast Death Coil');
INSERT INTO smart_scripts VALUES (19307, 0, 3, 0, 0, 0, 100, 0, 14000, 20000, 25000, 30000, 11, 34322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Terror - In Combat - Cast Psychic Scream');

-- Ethereal Darkcaster (18331, 20257)
DELETE FROM creature_text WHERE entry=18331;
INSERT INTO creature_text VALUES (18331, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Darkcaster');
INSERT INTO creature_text VALUES (18331, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Darkcaster');
INSERT INTO creature_text VALUES (18331, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Darkcaster');
INSERT INTO creature_text VALUES (18331, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Darkcaster');
UPDATE creature_template SET pickpocketloot=18331, AIName='SmartAI', ScriptName='' WHERE entry=18331;
UPDATE creature_template SET pickpocketloot=18331, AIName='', ScriptName='' WHERE entry=20257;
DELETE FROM smart_scripts WHERE entryorguid=18331 AND source_type=0;
INSERT INTO smart_scripts VALUES (18331, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Darkcaster - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18331, 0, 1, 0, 0, 0, 100, 0, 2700, 5900, 9000, 12000, 11, 34942, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereal Darkcaster - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (18331, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 16592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Darkcaster - HP 50% - Cast Shadowform');
INSERT INTO smart_scripts VALUES (18331, 0, 3, 0, 0, 0, 100, 2, 3700, 7600, 6000, 6900, 11, 34931, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Ethereal Darkcaster - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (18331, 0, 4, 0, 0, 0, 100, 4, 3700, 7600, 6000, 6900, 11, 34930, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Ethereal Darkcaster - In Combat - Cast Mana Burn');

-- Nexus Stalker (18314, 20264)
DELETE FROM creature_text WHERE entry=18314;
INSERT INTO creature_text VALUES (18314, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Nexus Stalker');
INSERT INTO creature_text VALUES (18314, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Nexus Stalker');
INSERT INTO creature_text VALUES (18314, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Nexus Stalker');
INSERT INTO creature_text VALUES (18314, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Nexus Stalker');
UPDATE creature_template SET pickpocketloot=18314, AIName='SmartAI', ScriptName='' WHERE entry=18314;
UPDATE creature_template SET pickpocketloot=18314, AIName='', ScriptName='' WHERE entry=20264;
DELETE FROM smart_scripts WHERE entryorguid=18314 AND source_type=0;
INSERT INTO smart_scripts VALUES (18314, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Stalker - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18314, 0, 1, 0, 0, 0, 100, 0, 5700, 8900, 12000, 22000, 11, 34940, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nexus Stalker - In Combat - Cast Gouge');
INSERT INTO smart_scripts VALUES (18314, 0, 2, 0, 0, 0, 100, 2, 3000, 10400, 12200, 18600, 11, 33925, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Nexus Stalker - In Combat - Cast Phantom Strike');
INSERT INTO smart_scripts VALUES (18314, 0, 3, 0, 0, 0, 100, 4, 3000, 10400, 12200, 18600, 11, 39332, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Nexus Stalker - In Combat - Cast Phantom Strike');

-- Ethereal Theurgist (18315, 20261)
DELETE FROM creature_text WHERE entry=18315;
INSERT INTO creature_text VALUES (18315, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Theurgist');
INSERT INTO creature_text VALUES (18315, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Theurgist');
INSERT INTO creature_text VALUES (18315, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Theurgist');
INSERT INTO creature_text VALUES (18315, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Theurgist');
UPDATE creature_template SET pickpocketloot=18315, AIName='SmartAI', ScriptName='' WHERE entry=18315;
UPDATE creature_template SET pickpocketloot=18315, AIName='', ScriptName='' WHERE entry=20261;
DELETE FROM smart_scripts WHERE entryorguid=18315 AND source_type=0;
INSERT INTO smart_scripts VALUES (18315, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18315, 0, 1, 0, 0, 0, 100, 0, 5700, 8900, 18000, 22000, 11, 13323, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES (18315, 0, 2, 0, 0, 0, 100, 2, 0, 0, 5000, 8600, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (18315, 0, 3, 0, 0, 0, 100, 4, 0, 0, 5000, 8600, 11, 34920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (18315, 0, 4, 0, 0, 0, 100, 2, 4200, 6500, 8000, 12600, 11, 17145, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (18315, 0, 5, 0, 0, 0, 100, 4, 4200, 6500, 8000, 12600, 11, 38064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Theurgist - In Combat - Cast Blast Wave');

-- Ethereal Spellbinder (18312, 20260)
DELETE FROM creature_text WHERE entry=18312;
INSERT INTO creature_text VALUES (18312, 0, 0, "If you hear the whisper, you're dying...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Spellbinder');
INSERT INTO creature_text VALUES (18312, 0, 1, "Welcome to the Void...", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Spellbinder');
INSERT INTO creature_text VALUES (18312, 0, 2, "What have the netherwinds brought us?", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Spellbinder');
INSERT INTO creature_text VALUES (18312, 0, 3, "You're far from home, stranger.", 12, 0, 100, 0, 0, 0, 0, 'Ethereal Spellbinder');
UPDATE creature_template SET pickpocketloot=18312, AIName='SmartAI', ScriptName='' WHERE entry=18312;
UPDATE creature_template SET pickpocketloot=18312, AIName='', ScriptName='' WHERE entry=20260;
DELETE FROM smart_scripts WHERE entryorguid=18312 AND source_type=0;
INSERT INTO smart_scripts VALUES (18312, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18312, 0, 1, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 37470, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - On Target Cast - Cast Counterspell');
INSERT INTO smart_scripts VALUES (18312, 0, 2, 0, 0, 0, 100, 2, 500, 500, 7000, 8600, 11, 17883, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (18312, 0, 3, 0, 0, 0, 100, 4, 500, 500, 7000, 8600, 11, 37668, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (18312, 0, 4, 0, 0, 0, 100, 3, 15700, 16500, 0, 0, 11, 32316, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - In Combat - Cast Summon Wraith');
INSERT INTO smart_scripts VALUES (18312, 0, 5, 6, 0, 0, 100, 5, 15700, 16500, 0, 0, 11, 32316, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - In Combat - Cast Summon Wraith');
INSERT INTO smart_scripts VALUES (18312, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 32316, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Spellbinder - In Combat - Cast Summon Wraith');

-- Ethereal Wraith (18394, 20262)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18394;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20262;
DELETE FROM smart_scripts WHERE entryorguid=18394 AND source_type=0;
INSERT INTO smart_scripts VALUES (18394, 0, 0, 0, 0, 0, 100, 0, 1200, 2000, 8700, 8700, 11, 34934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Wraith - In Combat - Cast Shadow Bolt Volley');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Pandemonius (18341, 20267)
DELETE FROM creature_text WHERE entry=18341;
INSERT INTO creature_text VALUES (18341, 0, 0, 'I will feed on your soul.', 14, 0, 100, 0, 0, 10561, 0, 'pandemonius SAY_AGGRO_1');
INSERT INTO creature_text VALUES (18341, 0, 1, 'So... full of life!', 14, 0, 100, 0, 0, 10562, 0, 'pandemonius SAY_AGGRO_2');
INSERT INTO creature_text VALUES (18341, 0, 2, 'Do not... resist.', 14, 0, 100, 0, 0, 10563, 0, 'pandemonius SAY_AGGRO_3');
INSERT INTO creature_text VALUES (18341, 1, 0, 'Yes! I am... empowered!', 14, 0, 100, 0, 0, 10564, 0, 'pandemonius SAY_KILL_1');
INSERT INTO creature_text VALUES (18341, 1, 1, 'More... I must have more!', 14, 0, 100, 0, 0, 10565, 0, 'pandemonius SAY_KILL_2');
INSERT INTO creature_text VALUES (18341, 2, 0, 'To the void... once... more..', 14, 0, 100, 0, 0, 10566, 0, 'pandemonius SAY_DEATH');
INSERT INTO creature_text VALUES (18341, 3, 0, '%s shifts into the void...', 41, 0, 100, 0, 0, 0, 0, 'pandemonius EMOTE_DARK_SHELL');
UPDATE creature_template SET dmgschool=5, AIName='SmartAI', ScriptName='' WHERE entry=18341;
UPDATE creature_template SET dmgschool=5, AIName='', ScriptName='' WHERE entry=20267;
DELETE FROM smart_scripts WHERE entryorguid=18341 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1834100 AND source_type=9;
DELETE FROM smart_scripts WHERE entryorguid=1834101 AND source_type=9;
INSERT INTO smart_scripts VALUES (18341, 0, 0, 0, 0, 0, 100, 2, 6000, 6000, 20000, 20000, 80, 1834100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - In Combat - Start Script');
INSERT INTO smart_scripts VALUES (18341, 0, 1, 0, 0, 0, 100, 4, 6000, 6000, 20000, 20000, 80, 1834101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - In Combat - Start Script');
INSERT INTO smart_scripts VALUES (18341, 0, 2, 7, 0, 0, 100, 2, 16000, 16000, 20000, 20000, 11, 32358, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - In Combat - Cast Dark Shell');
INSERT INTO smart_scripts VALUES (18341, 0, 3, 7, 0, 0, 100, 4, 16000, 16000, 20000, 20000, 11, 38759, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - In Combat - Cast Dark Shell');
INSERT INTO smart_scripts VALUES (18341, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18341, 0, 5, 0, 5, 0, 100, 0, 3000, 3000, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (18341, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (18341, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - In Combat Linked - Say Line 3');
INSERT INTO smart_scripts VALUES (1834100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 32325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 32325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834100, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 32325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834100, 9, 5, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 32325, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 38760, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834101, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 38760, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834101, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 38760, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834101, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 38760, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
INSERT INTO smart_scripts VALUES (1834101, 9, 5, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 38760, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Pandemonius - Script9 - Cast Void Blast');
-- Tavarok (18343, 20268)
UPDATE creature_template SET skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=18343;
UPDATE creature_template SET skinloot=70063, AIName='', ScriptName='' WHERE entry=20268;
DELETE FROM smart_scripts WHERE entryorguid=18343 AND source_type=0;
INSERT INTO smart_scripts VALUES (18343, 0, 0, 0, 0, 0, 100, 0, 10000, 14200, 20000, 31000, 11, 33919, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tavarok - In Combat - Cast Earthquake');
INSERT INTO smart_scripts VALUES (18343, 0, 1, 0, 0, 0, 100, 0, 12000, 22000, 15000, 22000, 11, 32361, 0, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 0, 'Tavarok - In Combat - Cast Crystal Prison');
INSERT INTO smart_scripts VALUES (18343, 0, 2, 0, 0, 0, 100, 2, 5900, 5900, 8000, 12000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tavarok - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (18343, 0, 3, 0, 0, 0, 100, 4, 5900, 5900, 8000, 12000, 11, 38761, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tavarok - In Combat - Cast Arcing Smash');

-- Yor <Void Hound of Shaffar> (22930)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=22930;
DELETE FROM smart_scripts WHERE entryorguid=22930 AND source_type=0;
INSERT INTO smart_scripts VALUES (22930, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 6000, 9000, 11, 38361, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Yor - In Combat - Cast Double Breath");

-- Nexus-Prince Shaffar (18344, 20266)
UPDATE creature_template SET pickpocketloot=18344, AIName='', ScriptName='boss_nexusprince_shaffar' WHERE entry=18344;
UPDATE creature_template SET pickpocketloot=18344, AIName='', ScriptName='' WHERE entry=20266;
DELETE FROM smart_scripts WHERE entryorguid=18344 AND source_type=0;
-- Ethereal Beacon (18431, 20254)
UPDATE creature_template SET speed_walk=4, speed_run=1.42857, AIName='SmartAI', ScriptName='' WHERE entry=18431;
UPDATE creature_template SET speed_walk=4, speed_run=1.42857, AIName='', ScriptName='' WHERE entry=20254;
DELETE FROM smart_scripts WHERE entryorguid=18431 AND source_type=0;
INSERT INTO smart_scripts VALUES (18431, 0, 0, 2, 0, 0, 100, 3, 20000, 20000, 0, 0, 11, 32372, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Beacon - Update - Cast Summon Ethereal Apprentice');
INSERT INTO smart_scripts VALUES (18431, 0, 1, 2, 0, 0, 100, 5, 10000, 10000, 0, 0, 11, 32372, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Beacon - Update - Cast Summon Ethereal Apprentice');
INSERT INTO smart_scripts VALUES (18431, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Beacon - Update Linked - Despawn');
INSERT INTO smart_scripts VALUES (18431, 0, 3, 0, 0, 0, 100, 0, 500, 500, 2000, 3000, 11, 15254, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Beacon - In Combat - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (18431, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Beacon - On Aggro - Call For Help');
-- Ethereal Apprentice (18430, 20253)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18430;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20253;
DELETE FROM smart_scripts WHERE entryorguid=18430 AND source_type=0;
INSERT INTO smart_scripts VALUES (18430, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 5000, 5000, 11, 32369, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Apprentice - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18430, 0, 1, 0, 0, 0, 100, 0, 3500, 3500, 5000, 5000, 11, 32370, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Apprentice - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (18430, 0, 2, 3, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Ethereal Apprentice - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (18430, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Apprentice - On Reset - Disable Melee');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Quest Someone Else's Hard Work Pays Off (10218)
DELETE FROM creature_text WHERE entry IN(19671, 19666);
INSERT INTO creature_text VALUES (19671, 0, 0, 'This should''t take very long. Just watch my back as I empty these nether collectors.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 1, 0, 'Fantastic! Let''s move on, shall we?', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 2, 0, 'Looking at these energy levels, Shaffar was set to make a killing!', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 3, 0, 'That should do it...', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 4, 0, 'Hrm, now where is the next collector?', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 5, 0, 'Ah, there it is. Follow me, fleshling.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 6, 0, 'There can''t be too many more of these collectors. Just keep me safe as I do my job.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 7, 0, 'What do we have here? I thought you said the area was secure? This is now the third attack? If we make it out of here, I will definitely be deducting this from your reward. Now don''t just stand there, destroy them so I can get to that collector.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 8, 0, 'We''re close to the exit. I''ll let you rest for about thirty seconds, but then we''re out of here.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 9, 0, 'Are you ready to go?', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 10, 0, 'Ok break time is OVER. Let''s go!', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 11, 0, 'Oh really? And what might that be?', 12, 0, 100, 1, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 12, 0, 'He was right, you know. I''ll have to take that tag-line for my own... It''s not like he''ll have a use for it anymore!', 12, 0, 100, 1, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 13, 0, 'Thanks and good luck!', 12, 0, 100, 1, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 20, 0, '%s checks to make sure his body is intact.', 16, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 21, 0, 'You made it! Well done, $r. Now if you''ll excuse me, I have to get the rest of our crew inside.', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 22, 0, '%s expertly manipulates the control panel.', 16, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19671, 23, 0, 'Let''s not waste any time! Take anything that isn''t nailed down to the floor and teleport directly to Stormspire! Chop chop!', 12, 0, 100, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen');
INSERT INTO creature_text VALUES (19666, 0, 0, 'Bravo! Bravo! Good show… I couldn''t convince you to work for me, could I? No, I suppose the needless slaughter of my employees might negatively impact your employment application.', 14, 0, 100, 0, 0, 0, 0, 'Shadow Lord Xiraxis');
INSERT INTO creature_text VALUES (19666, 1, 0, 'Your plan was a good one, Sha''heen, and you would have gotten away with it if not for one thing...', 12, 0, 100, 1, 0, 0, 0, 'Shadow Lord Xiraxis');
INSERT INTO creature_text VALUES (19666, 2, 0, 'Never underestimate the other ethereal''s greed!', 12, 0, 100, 15, 0, 0, 0, 'Shadow Lord Xiraxis');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=183877;
DELETE FROM smart_scripts WHERE entryorguid=183877 AND source_type=1;
INSERT INTO smart_scripts VALUES (183877, 1, 0, 0, 62, 0, 100, 1, 8023, 0, 0, 0, 12, 19671, 8, 0, 0, 0, 0, 8, 0, 0, 0, -351.345, -69.7118, -0.875432, 4.34587, 'Ethereal Transporter Control Panel - On Gossip Option 0 Selected - Summon Cryo-Engineer Sha heen');
INSERT INTO smart_scripts VALUES (183877, 1, 1, 0, 62, 0, 100, 0, 8023, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereal Transporter Control Panel - On Gossip Option 0 Selected - Close Gossip');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(19671, 19672, 19666);
DELETE FROM smart_scripts WHERE entryorguid IN(19671, 19672, 19666) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(19671*100, 19671*100+1, 19671*100+2, 19671*100+3, 19671*100+4, 19671*100+5, 19671*100+6, 19671*100+7) AND source_type=9;
INSERT INTO smart_scripts VALUES (19671, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On AI Init - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 1, 0, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - Just Summoned - Store Target');
INSERT INTO smart_scripts VALUES (19671, 0, 2, 0, 19, 0, 100, 0, 10218, 0, 0, 0, 53, 0, 19671, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (19671, 0, 3, 4, 40, 0, 100, 0, 1, 0, 0, 0, 54, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Say Line 0');
INSERT INTO smart_scripts VALUES (19671, 0, 5, 6, 40, 0, 100, 0, 3, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 7, 8, 40, 0, 100, 0, 15, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 9, 10, 40, 0, 100, 0, 28, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 11, 12, 40, 0, 100, 0, 37, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100+4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 13, 14, 40, 0, 100, 0, 52, 0, 0, 0, 12, 19307, 4, 120000, 0, 0, 0, 8, 0, 0, 0, -20.72, -227.29, 0.532, 3.14, 'Cryo-Engineer Sha''heen - On WP Reached - Summon Nexus Terror');
INSERT INTO smart_scripts VALUES (19671, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 19307, 4, 120000, 0, 0, 0, 8, 0, 0, 0, -15.28, -218.56, 0.40, 3.17, 'Cryo-Engineer Sha''heen - On WP Reached - Summon Nexus Terror');
INSERT INTO smart_scripts VALUES (19671, 0, 15, 16, 40, 0, 100, 0, 66, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Say Line 7');
INSERT INTO smart_scripts VALUES (19671, 0, 17, 18, 40, 0, 100, 0, 73, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (19671, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 19671*100+5, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 19, 0, 40, 0, 100, 0, 93, 0, 0, 0, 80, 19671*100+6, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 20, 0, 38, 0, 100, 0, 2, 2, 0, 0, 80, 19671*100+7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Data Set - Run Script');
INSERT INTO smart_scripts VALUES (19671, 0, 21, 0, 0, 0, 100, 0, 0, 1000, 3500, 4500, 11, 13901, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - In Combat - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (19671, 0, 22, 0, 0, 0, 100, 0, 7000, 10000, 13500, 24500, 11, 22938, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (19671*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Npc Flags');
INSERT INTO smart_scripts VALUES (19671*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Walk');
INSERT INTO smart_scripts VALUES (19671*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 20');
INSERT INTO smart_scripts VALUES (19671*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 21, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 21');
INSERT INTO smart_scripts VALUES (19671*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -354.75, -65.60, -0.96, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (19671*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 22, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 22');
INSERT INTO smart_scripts VALUES (19671*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 19672, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -351.345, -69.7118, -0.875432, 4.34587, 'Cryo-Engineer Sha''heen - On Script - Summon Consortium Laborer');
INSERT INTO smart_scripts VALUES (19671*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, -378.07, -48.00, -0.96, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (19671*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 19672, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -351.345, -69.7118, -0.875432, 4.34587, 'Cryo-Engineer Sha''heen - On Script - Summon Consortium Laborer');
INSERT INTO smart_scripts VALUES (19671*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, -378.56, -97.69, -0.96, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (19671*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 19672, 4, 60000, 0, 0, 0, 8, 0, 0, 0, -351.345, -69.7118, -0.875432, 4.34587, 'Cryo-Engineer Sha''heen - On Script - Summon Consortium Laborer');
INSERT INTO smart_scripts VALUES (19671*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, -386.85, -76.48, -0.958, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (19671*100, 9, 12, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 23, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 23');
INSERT INTO smart_scripts VALUES (19671*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Npc Flags');
INSERT INTO smart_scripts VALUES (19671*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Passive');
INSERT INTO smart_scripts VALUES (19671*100+1, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Defensive');
INSERT INTO smart_scripts VALUES (19671*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 2');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Passive');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18315, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -369.96, -137.83, -0.957, 4.7, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Theurgist');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18312, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -374.96, -137.83, -0.957, 4.7, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Spellbinder');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18315, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -369.96, -193.83, -0.957, 1.57, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Theurgist');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18312, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -374.96, -193.83, -0.957, 1.57, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Spellbinder');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 7, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Defensive');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+2, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 3');
INSERT INTO smart_scripts VALUES (19671*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 4');
INSERT INTO smart_scripts VALUES (19671*100+3, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 5');
INSERT INTO smart_scripts VALUES (19671*100+3, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.8, 'Cryo-Engineer Sha''heen - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 6');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Passive');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18311, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -288.02, -184.01, -1.28, 0.0, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Crypt Raider');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18313, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -287.41, -187.46, -0.93, 0.0, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Sorcerer');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18311, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -234.94, -199.88, -0.95, 2.00, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Crypt Raider');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 18313, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -232.64, -194.52, -0.95, 1.94, 'Cryo-Engineer Sha''heen - On Script - Summon Ethereal Sorcerer');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 7, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Defensive');
INSERT INTO smart_scripts VALUES (19671*100+4, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Passive');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set React Defensive');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Emote State');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 8');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 8, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 6, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 9');
INSERT INTO smart_scripts VALUES (19671*100+5, 9, 7, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 10');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 19666, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -67.82, -21.77, -0.954, 4.67, 'Cryo-Engineer Sha''heen - On Script - Summon Shadow Lord Xiraxis');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 130, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, -67.05, -74.83, -0.81, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position Target');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 1 Target');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 11');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 2 Target');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (19671*100+6, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Attack Start');
INSERT INTO smart_scripts VALUES (19671*100+7, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 12');
INSERT INTO smart_scripts VALUES (19671*100+7, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Say Line 13');
INSERT INTO smart_scripts VALUES (19671*100+7, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 15, 10218, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Area Explored Or Event Happens');
INSERT INTO smart_scripts VALUES (19671*100+7, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, -67.82, -21.77, -0.954, 0, 'Cryo-Engineer Sha''heen - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (19671*100+7, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cryo-Engineer Sha''heen - On Script - Despawn');
INSERT INTO smart_scripts VALUES (19672, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - Is Summoned - Set Event Phase');
INSERT INTO smart_scripts VALUES (19672, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - Is Summoned - No Event Phase Reset');
INSERT INTO smart_scripts VALUES (19672, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - Is Summoned - Set Emote State');
INSERT INTO smart_scripts VALUES (19672, 0, 3, 4, 60, 1, 100, 257, 13000, 25000, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - On Update - Set Emote State');
INSERT INTO smart_scripts VALUES (19672, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - On Update - Evade');
INSERT INTO smart_scripts VALUES (19672, 0, 5, 6, 21, 1, 100, 0, 0, 0, 0, 0, 11, 34442, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - Just Reached Home - Cast Despawn Consortium Laborer');
INSERT INTO smart_scripts VALUES (19672, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Consortium Laborer - Just Reached Home - Despawn');
INSERT INTO smart_scripts VALUES (19666, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Xiraxis - Is Summoned - Set Unit Flags');
INSERT INTO smart_scripts VALUES (19666, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Xiraxis - On Data Set - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (19666, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Lord Xiraxis - On Data Set - Set Faction');
INSERT INTO smart_scripts VALUES (19666, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Shadow Lord Xiraxis - On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES (19666, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 19671, 100, 0, 0, 0, 0, 0, 'Shadow Lord Xiraxis - On Death - Set Data');
DELETE FROM waypoints WHERE entry=19671;
INSERT INTO waypoints VALUES (19671, 1, -351.789, -69.8332, -0.960246, 'Cryo-Engineer Sha''heen'),(19671, 2, -366.06, -71.81, -0.958, 'Cryo-Engineer Sha''heen'),(19671, 3, -370.07, -72.54, 0.55, 'Cryo-Engineer Sha''heen'),(19671, 4, -362.02, -71.05, -0.958, 'Cryo-Engineer Sha''heen'),(19671, 5, -372.478, -93.9698, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 6, -372.956, -102.076, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 7, -373.017, -113.626, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 8, -372.988, -125.175, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 9, -372.931, -139.675, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 10, -373.605, -151.226, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 11, -377.447, -154.805, -0.958742, 'Cryo-Engineer Sha''heen'),(19671, 12, -380.818, -159.285, -0.954232, 'Cryo-Engineer Sha''heen'),(19671, 13, -381.165, -164.186, -0.957979, 'Cryo-Engineer Sha''heen'),(19671, 14, -379.066, -164.216, -0.113683, 'Cryo-Engineer Sha''heen'),(19671, 15, -375.111, -164.235, 0.715806, 'Cryo-Engineer Sha''heen'),(19671, 16, -379.775, -164.71, -0.165154, 'Cryo-Engineer Sha''heen'),(19671, 17, -382.273, -165.565, -0.958753, 'Cryo-Engineer Sha''heen'),(19671, 18, -379.523, -174.58, -0.958753, 'Cryo-Engineer Sha''heen'),(19671, 19, -375.329, -184.594, -0.97348, 'Cryo-Engineer Sha''heen'),(19671, 20, -373.631, -193.17, -0.962749, 'Cryo-Engineer Sha''heen'),(19671, 21, -373.4, -200.517, -0.959759, 'Cryo-Engineer Sha''heen'),(19671, 22, -373.059, -211.368, -0.959759, 'Cryo-Engineer Sha''heen'),(19671, 23, -372.674, -223.626, -0.958623, 'Cryo-Engineer Sha''heen'),(19671, 24, -362.175, -223.75, -0.958623, 'Cryo-Engineer Sha''heen'),(19671, 25, -346.425, -223.679, -0.958623, 'Cryo-Engineer Sha''heen'),(19671, 26, -334.183, -223.583, -0.958623, 'Cryo-Engineer Sha''heen'),(19671, 27, -322.276, -223.677, -0.958344, 'Cryo-Engineer Sha''heen'),(19671, 28, -312.918, -220.998, -0.94947, 'Cryo-Engineer Sha''heen'),(19671, 29, -307.607, -213.182, -0.933042, 'Cryo-Engineer Sha''heen'),(19671, 30, -301.831, -202.365, -0.97953, 'Cryo-Engineer Sha''heen'),(19671, 31, -294.812, -194.082, -0.94909, 'Cryo-Engineer Sha''heen'),(19671, 32, -291.029, -189.044, -1.00723, 'Cryo-Engineer Sha''heen'),(19671, 33, -284.51, -180.362, -1.33409, 'Cryo-Engineer Sha''heen'),(19671, 34, -280.377, -173.049, -1.8534, 'Cryo-Engineer Sha''heen'),(19671, 35, -273.836, -161.477, -2.48206, 'Cryo-Engineer Sha''heen'),(19671, 36, -267.396, -159.877, -1.79642, 'Cryo-Engineer Sha''heen'),(19671, 37, -260.544, -158.374, -1.17304, 'Cryo-Engineer Sha''heen'),(19671, 38, -260.4, -160.827, -1.15989, 'Cryo-Engineer Sha''heen'),(19671, 39, -254.832, -161.486, -0.953236, 'Cryo-Engineer Sha''heen'),(19671, 40, -246.845, -162.432, -0.953236, 'Cryo-Engineer Sha''heen'),(19671, 41, -242.399, -164.477, -0.867038, 'Cryo-Engineer Sha''heen'),(19671, 42, -240.562, -169.012, -0.953709, 'Cryo-Engineer Sha''heen'),(19671, 43, -238.44, -173.021, -0.953709, 'Cryo-Engineer Sha''heen'),(19671, 44, -234.175, -181.075, -0.953709, 'Cryo-Engineer Sha''heen'),(19671, 45, -228.82, -190.903, -0.953759, 'Cryo-Engineer Sha''heen'),(19671, 46, -222.477, -197.448, -0.398852, 'Cryo-Engineer Sha''heen'),(19671, 47, -217.363, -202.727, 0.287965, 'Cryo-Engineer Sha''heen'),(19671, 48, -212.248, -208.005, 0.713021, 'Cryo-Engineer Sha''heen'),(19671, 49, -205.189, -215.289, 0.20156, 'Cryo-Engineer Sha''heen'),(19671, 50, -198.861, -221.819, -0.729239, 'Cryo-Engineer Sha''heen'),(19671, 51, -191.275, -223.174, -0.955504, 'Cryo-Engineer Sha''heen'),(19671, 52, -179.389, -223.268, -0.955504, 'Cryo-Engineer Sha''heen'),(19671, 53, -174.475, -223.287, -0.955504, 'Cryo-Engineer Sha''heen'),(19671, 54, -166.411, -223.319, -0.955504, 'Cryo-Engineer Sha''heen'),(19671, 55, -155.911, -223.271, -0.947958, 'Cryo-Engineer Sha''heen'),(19671, 56, -147.87, -223.209, -0.756992, 'Cryo-Engineer Sha''heen'),(19671, 57, -138.064, -223.132, 0.0706656, 'Cryo-Engineer Sha''heen'),(19671, 58, -132.457, -223.066, 0.889542, 'Cryo-Engineer Sha''heen'),(19671, 59, -125.465, -222.984, 1.3118, 'Cryo-Engineer Sha''heen'),(19671, 60, -120.551, -222.945, 0.271436, 'Cryo-Engineer Sha''heen'),(19671, 61, -111.458, -222.903, 0.22694, 'Cryo-Engineer Sha''heen'),(19671, 62, -101.672, -222.865, -0.578372, 'Cryo-Engineer Sha''heen'),(19671, 63, -94.6789, -222.838, -0.67855, 'Cryo-Engineer Sha''heen'),(19671, 64, -85.2324, -222.578, -0.392579, 'Cryo-Engineer Sha''heen'),(19671, 65, -74.0211, -222.339, -0.169972, 'Cryo-Engineer Sha''heen'),(19671, 66, -69.8212, -222.307, -0.225875, 'Cryo-Engineer Sha''heen'),(19671, 67, -59.7134, -222.863, 0.121823, 'Cryo-Engineer Sha''heen'),(19671, 68, -48.1808, -223.498, -0.118748, 'Cryo-Engineer Sha''heen'),(19671, 69, -37.6942, -224.026, -0.370049, 'Cryo-Engineer Sha''heen'),(19671, 70, -26.4821, -224.059, 0.183233, 'Cryo-Engineer Sha''heen'),(19671, 71, -17.0706, -223.207, 0.688721, 'Cryo-Engineer Sha''heen'),(19671, 72, -14.0612, -222.818, 1.01445, 'Cryo-Engineer Sha''heen'),(19671, 73, -17.9018, -222.954, 0.620031, 'Cryo-Engineer Sha''heen'),(19671, 74, -28.0595, -223.313, 0.0938897, 'Cryo-Engineer Sha''heen'),(19671, 75, -38.0775, -221.726, -0.303824, 'Cryo-Engineer Sha''heen'),(19671, 76, -48.0824, -220.058, -0.0237211, 'Cryo-Engineer Sha''heen'),(19671, 77, -59.6136, -217.254, 0.17109, 'Cryo-Engineer Sha''heen'),(19671, 78, -68.7573, -211.4, -0.272352, 'Cryo-Engineer Sha''heen'),(19671, 79, -67.9993, -203.035, -0.507698, 'Cryo-Engineer Sha''heen'),(19671, 80, -67.8879, -199.887, -0.644729, 'Cryo-Engineer Sha''heen'),(19671, 81, -67.7765, -196.739, -1.96199, 'Cryo-Engineer Sha''heen'),(19671, 82, -67.5291, -189.75, -1.91727, 'Cryo-Engineer Sha''heen'),(19671, 83, -67.2564, -182.048, -1.49876, 'Cryo-Engineer Sha''heen'),(19671, 84, -67.2302, -173.313, -0.975207, 'Cryo-Engineer Sha''heen'),(19671, 85, -67.2919, -168.063, -0.955841, 'Cryo-Engineer Sha''heen'),(19671, 86, -67.4233, -156.871, -0.955752, 'Cryo-Engineer Sha''heen'),(19671, 87, -67.5877, -142.865, -0.955752, 'Cryo-Engineer Sha''heen'),(19671, 88, -67.476, -131.316, -1.1366, 'Cryo-Engineer Sha''heen'),(19671, 89, -67.4755, -120.102, -1.32219, 'Cryo-Engineer Sha''heen'),(19671, 90, -67.5068, -112.059, -0.653647, 'Cryo-Engineer Sha''heen'),(19671, 91, -67.2435, -105.785, -1.65685, 'Cryo-Engineer Sha''heen'),(19671, 92, -66.9464, -97.3905, -1.20982, 'Cryo-Engineer Sha''heen'),(19671, 93, -66.5686, -88.659, -1.2151, 'Cryo-Engineer Sha''heen');


UPDATE creature SET spawntimesecs=86400 WHERE map=552 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Arcatraz Warder (20859, 21587)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=20859);
REPLACE INTO creature_template_addon VALUES (20859, 0, 0, 0, 4098, 376, '');
REPLACE INTO creature_template_addon VALUES (21587, 0, 0, 0, 4098, 376, '');
UPDATE creature_template SET pickpocketloot=20859, AIName='SmartAI', ScriptName='' WHERE entry=20859;
UPDATE creature_template SET pickpocketloot=20859, AIName='', ScriptName='' WHERE entry=21587;
DELETE FROM smart_scripts WHERE entryorguid=20859 AND source_type=0;
INSERT INTO smart_scripts VALUES (20859, 0, 0, 0, 1, 0, 100, 0, 10000, 18000, 5000, 5000, 11, 36327, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - Out of Combat - Cast Spell Shoot Arcane Explosion Arrow');
INSERT INTO smart_scripts VALUES (20859, 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 3000, 3000, 11, 35012, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - In Combat - Cast Spell Shoot');
INSERT INTO smart_scripts VALUES (20859, 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 3000, 3000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - In Combat - Cast Spell Shoot');
INSERT INTO smart_scripts VALUES (20859, 0, 3, 0, 0, 0, 100, 2, 5000, 8000, 6000, 6000, 11, 36609, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - In Combat - Cast Spell Arcane Shoot');
INSERT INTO smart_scripts VALUES (20859, 0, 4, 0, 0, 0, 100, 4, 5000, 8000, 6000, 6000, 11, 38807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - In Combat - Cast Spell Arcane Shoot');
INSERT INTO smart_scripts VALUES (20859, 0, 5, 0, 9, 0, 100, 0, 0, 5, 10000, 10000, 11, 35963, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Warder - Within Range 0-5yd - Cast Spell Improved Wing Clip');
-- SPELL Shoot Arcane Explosion Arrow (36327)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36327;
INSERT INTO conditions VALUES(13, 1, 36327, 0, 0, 31, 0, 3, 21186, 0, 0, 0, 0, '', 'Targets Arcane Warder Target');	
INSERT INTO conditions VALUES(13, 1, 36327, 0, 1, 31, 0, 3, 20864, 0, 0, 0, 0, '', 'Targets Protean Nightmare');	
INSERT INTO conditions VALUES(13, 1, 36327, 0, 2, 31, 0, 3, 20865, 0, 0, 0, 0, '', 'Targets Protean Horror');	 

-- Arcatraz Defender (20857, 21585)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=20857);
REPLACE INTO creature_template_addon VALUES (20857, 0, 0, 0, 4098, 333, '36637');
REPLACE INTO creature_template_addon VALUES (21585, 0, 0, 0, 4098, 333, '36637');
UPDATE creature_template SET pickpocketloot=20857, AIName='SmartAI', ScriptName='' WHERE entry=20857;
UPDATE creature_template SET pickpocketloot=20857, AIName='', ScriptName='' WHERE entry=21585;
DELETE FROM smart_scripts WHERE entryorguid IN(-79399, 20857) AND source_type=0;
INSERT INTO smart_scripts VALUES (-79399, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 20000, 20000, 12, 20864, 4, 20000, 0, 0, 0, 8, 0, 0, 0, 188.07, -0.65, -10.10, 3.14, 'Arcatraz Defender - Out of Combat - Summon Protean Nightmare');
INSERT INTO smart_scripts VALUES (-79399, 0, 1, 0, 60, 0, 100, 0, 8000, 8000, 3000, 3000, 12, 20865, 4, 20000, 0, 0, 0, 8, 0, 0, 0, 188.07, -0.65, -10.10, 3.14, 'Arcatraz Defender - Out of Combat - Summon Protean Horror');
INSERT INTO smart_scripts VALUES (-79399, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 100.87, 0.74, -10.21, 0, 'Arcatraz Defender - Just Summoned - Move To Pos Target');

-- Protean Nightmare (20864, 21608)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20864;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21608;
DELETE FROM smart_scripts WHERE entryorguid=20864 AND source_type=0;
INSERT INTO smart_scripts VALUES (20864, 0, 0, 0, 0, 0, 100, 2, 2000, 2000, 20000, 20000, 11, 36617, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast Spell Gaping Maw');
INSERT INTO smart_scripts VALUES (20864, 0, 1, 0, 0, 0, 100, 4, 2000, 2000, 20000, 20000, 11, 38810, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast Spell Gaping Maw');
INSERT INTO smart_scripts VALUES (20864, 0, 2, 0, 0, 0, 100, 2, 8000, 8000, 20000, 20000, 11, 36619, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast Spell Infectious Poison');
INSERT INTO smart_scripts VALUES (20864, 0, 3, 0, 0, 0, 100, 4, 8000, 8000, 20000, 20000, 11, 38811, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast Spell Infectious Poison');
INSERT INTO smart_scripts VALUES (20864, 0, 4, 0, 0, 0, 100, 0, 12000, 12000, 30000, 30000, 11, 36622, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - In Combat - Cast Spell Incubation');
INSERT INTO smart_scripts VALUES (20864, 0, 5, 0, 8, 0, 50, 0, 36327, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protean Nightmare - On Spell Hit - Kill Self');

-- Protean Horror (20865, 21607)
DELETE FROM linked_respawn WHERE guid IN(79427, 79432, 79434, 79444, 79445, 79454, 79484, 79459);
DELETE FROM creature_addon WHERE guid IN(79427, 79432, 79434, 79444, 79445, 79454, 79484, 79459);
DELETE FROM creature WHERE guid IN(79427, 79432, 79434, 79444, 79445, 79454, 79484, 79459) AND id IN(20864, 20865); -- DELETE UNNEDED SPAWNS
INSERT INTO creature VALUES (79454, 20864, 552, 3, 1, 0, 0, 191.54, 7.59, -13.10, 3.22, 7200, 8, 0, 46676, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (79444, 20865, 552, 3, 1, 0, 0, 191.54, 7.59, -10.10, 3.22, 7200, 0, 0, 46676, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (79445, 20865, 552, 3, 1, 0, 0, 191.54, 7.59, -7.10, 3.22, 7200, 0, 0, 46676, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20865;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21607;
DELETE FROM smart_scripts WHERE entryorguid=20865 AND source_type=0;
INSERT INTO smart_scripts VALUES (20865, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 7000, 7000, 11, 36612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - In Combat - Cast Spell Toothy Bite');
INSERT INTO smart_scripts VALUES (20865, 0, 1, 0, 8, 0, 50, 0, 36327, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Protean Horror - On Spell Hit - Kill Self');

-- Protean Spawn (21395, 21609)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21395;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21609;
DELETE FROM smart_scripts WHERE entryorguid=21395 AND source_type=0;
INSERT INTO smart_scripts VALUES (21395, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 10000, 10000, 11, 36796, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Protean Spawn - In Combat - Cast Spell Acidic Bite');
INSERT INTO smart_scripts VALUES (21395, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 'Protean Spawn - On Rest - Attack Start');

-- Warder Corpse (21304, 21623)
REPLACE INTO creature_template_addon VALUES (21304, 0, 0, 0, 1, 0, '31261');
REPLACE INTO creature_template_addon VALUES (21623, 0, 0, 0, 1, 0, '31261');
UPDATE creature_template SET unit_flags=768+6, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=21304;
UPDATE creature_template SET unit_flags=768+6, flags_extra=0, AIName='', ScriptName='' WHERE entry=21623;
DELETE FROM smart_scripts WHERE entryorguid=21304 AND source_type=0;
INSERT INTO smart_scripts VALUES (21304, 0, 0, 1, 10, 0, 100, 257, 0, 7, 60000, 60000, 11, 36599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - Out of Combat LoS - Cast Spell Bloody Explosion');
INSERT INTO smart_scripts VALUES (21304, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - Out of Combat LoS - Cast Spell Corpse Burst');
INSERT INTO smart_scripts VALUES (21304, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - Out of Combat LoS - Despawn');
INSERT INTO smart_scripts VALUES (21304, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - Out of Combat - Set React State');

-- Defender Corpse (21303, 21592)
REPLACE INTO creature_template_addon VALUES (21303, 0, 0, 0, 1, 0, '31261');
REPLACE INTO creature_template_addon VALUES (21592, 0, 0, 0, 1, 0, '31261');
UPDATE creature_template SET unit_flags=768+6, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=21303;
UPDATE creature_template SET unit_flags=768+6, flags_extra=0, AIName='', ScriptName='' WHERE entry=21592;
DELETE FROM smart_scripts WHERE entryorguid=21303 AND source_type=0;
INSERT INTO smart_scripts VALUES (21303, 0, 0, 1, 10, 0, 100, 257, 0, 7, 60000, 60000, 11, 36599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - Out of Combat LoS - Cast Spell Bloody Explosion');
INSERT INTO smart_scripts VALUES (21303, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - Out of Combat LoS - Cast Spell Corpse Burst');
INSERT INTO smart_scripts VALUES (21303, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - Out of Combat LoS - Despawn');
INSERT INTO smart_scripts VALUES (21303, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - Out of Combat - Set React State');

-- Soul Devourer (20866, 21614)
UPDATE creature_template SET skinloot=70162, AIName='SmartAI', ScriptName='' WHERE entry=20866;
UPDATE creature_template SET skinloot=70162, AIName='', ScriptName='' WHERE entry=21614;
DELETE FROM smart_scripts WHERE entryorguid=20866 AND source_type=0;
INSERT INTO smart_scripts VALUES (20866, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 33958, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - Between 0-30% Health - Cast Spell Enrage');
INSERT INTO smart_scripts VALUES (20866, 0, 1, 0, 0, 0, 100, 2, 7000, 10000, 20000, 23000, 11, 36654, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - In Combat - Cast Fel Breath');
INSERT INTO smart_scripts VALUES (20866, 0, 2, 0, 0, 0, 100, 4, 7000, 10000, 20000, 23000, 11, 38813, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - In Combat - Cast Fel Breath');
INSERT INTO smart_scripts VALUES (20866, 0, 3, 0, 0, 0, 100, 1, 15000, 17000, 0, 0, 11, 36644, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Soul Devourer - In Combat - Cast Sightless Eye');

-- Sightless Eye (21346, 21612)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21346;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21612;
DELETE FROM smart_scripts WHERE entryorguid=21346 AND source_type=0;
INSERT INTO smart_scripts VALUES (21346, 0, 0, 0, 0, 0, 100, 2, 2000, 4000, 8000, 8000, 11, 36646, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sightless Eye - In Combat - Cast Spell Sightless Touch');
INSERT INTO smart_scripts VALUES (21346, 0, 1, 0, 0, 0, 100, 4, 2000, 4000, 8000, 8000, 11, 38815, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sightless Eye - In Combat - Cast Spell Sightless Touch');
INSERT INTO smart_scripts VALUES (21346, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, 'Sightless Eye - On Reset - Attack Start');

-- Death Watcher (20867, 21591)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20867;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21591;
DELETE FROM smart_scripts WHERE entryorguid=20867 AND source_type=0;
INSERT INTO smart_scripts VALUES (20867, 0, 0, 0, 2, 0, 100, 3, 0, 50, 0, 0, 11, 36657, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast Spell Death Count');
INSERT INTO smart_scripts VALUES (20867, 0, 1, 0, 2, 0, 100, 5, 0, 50, 0, 0, 11, 38818, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - Between 0-50% Health - Cast Spell Death Count');
INSERT INTO smart_scripts VALUES (20867, 0, 2, 0, 0, 0, 100, 2, 7000, 10000, 20000, 23000, 11, 36655, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast Spell Drain Life');
INSERT INTO smart_scripts VALUES (20867, 0, 3, 0, 0, 0, 100, 4, 7000, 10000, 20000, 23000, 11, 38817, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast Spell Drain Life');
INSERT INTO smart_scripts VALUES (20867, 0, 4, 0, 0, 0, 100, 2, 1000, 3000, 10000, 13000, 11, 36664, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast Spell Tentacle Cleave');
INSERT INTO smart_scripts VALUES (20867, 0, 5, 0, 0, 0, 100, 4, 1000, 3000, 10000, 13000, 11, 38816, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death Watcher - In Combat - Cast Spell Tentacle Cleave');
INSERT INTO smart_scripts VALUES (20867, 0, 6, 0, 6, 0, 100, 2, 0, 0, 0, 0, 28, 36657, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove Aura Death Count');
INSERT INTO smart_scripts VALUES (20867, 0, 7, 0, 6, 0, 100, 4, 0, 0, 0, 0, 28, 38818, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Death Watcher - On Death - Remove Aura Death Count');

-- Arcatraz Sentinel (20869, 21586)
REPLACE INTO creature_template_addon VALUES (20869, 0, 0, 0, 0, 0, '36716');
REPLACE INTO creature_template_addon VALUES (21586, 0, 0, 0, 0, 0, '38828');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20869;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21586;
DELETE FROM smart_scripts WHERE entryorguid=20869 AND source_type=0;
INSERT INTO smart_scripts VALUES (20869, 0, 0, 0, 2, 0, 100, 3, 0, 20, 0, 0, 11, 36719, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - Between 0-50% Health - Cast Spell Explode');
INSERT INTO smart_scripts VALUES (20869, 0, 1, 0, 2, 0, 100, 5, 0, 20, 0, 0, 11, 38830, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - Between 0-50% Health - Cast Spell Explode');

-- Negaton Screamer (20875, 21604)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20875;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21604;
DELETE FROM smart_scripts WHERE entryorguid=20875 AND source_type=0;
INSERT INTO smart_scripts VALUES (20875, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 31, 1, 6, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Reset - Random Event Phase Range');
INSERT INTO smart_scripts VALUES (20875, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Arcane');
INSERT INTO smart_scripts VALUES (20875, 0, 2, 0, 0, 1, 100, 2, 3000, 8000, 10000, 10000, 11, 36738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Arcane Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 3, 0, 0, 1, 100, 4, 3000, 8000, 10000, 10000, 11, 38835, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Arcane Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 4, 0, 4, 2, 100, 1, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Fire');
INSERT INTO smart_scripts VALUES (20875, 0, 5, 0, 0, 2, 100, 2, 3000, 8000, 10000, 10000, 11, 36742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Fireball Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 6, 0, 0, 2, 100, 4, 3000, 8000, 10000, 10000, 11, 38836, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Fireball Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 7, 0, 4, 4, 100, 1, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Frost');
INSERT INTO smart_scripts VALUES (20875, 0, 8, 0, 0, 4, 100, 2, 3000, 8000, 10000, 10000, 11, 36741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Frostbolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 9, 0, 0, 4, 100, 4, 3000, 8000, 10000, 10000, 11, 38837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Frostbolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 10, 0, 4, 8, 100, 1, 0, 0, 0, 0, 11, 34336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Holy');
INSERT INTO smart_scripts VALUES (20875, 0, 11, 0, 0, 8, 100, 2, 3000, 8000, 10000, 10000, 11, 36743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Holy Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 12, 0, 0, 8, 100, 4, 3000, 8000, 10000, 10000, 11, 38838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Holy Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 13, 0, 4, 16, 100, 1, 0, 0, 0, 0, 11, 34335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Nature');
INSERT INTO smart_scripts VALUES (20875, 0, 14, 0, 0, 16, 100, 2, 3000, 8000, 10000, 10000, 11, 36740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Lightning Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 15, 0, 0, 16, 100, 4, 3000, 8000, 10000, 10000, 11, 38839, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Lightning Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 16, 0, 4, 32, 100, 1, 0, 0, 0, 0, 11, 34338, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - On Aggro - Cast Spell Damage Reduction Shadow');
INSERT INTO smart_scripts VALUES (20875, 0, 17, 0, 0, 32, 100, 2, 3000, 8000, 10000, 10000, 11, 36736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 18, 0, 0, 32, 100, 4, 3000, 8000, 10000, 10000, 11, 38840, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (20875, 0, 19, 0, 0, 0, 100, 0, 20000, 20000, 30000, 30000, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Screamer - In Combat - Cast Spell Psychic Scream');

-- Negaton Warp-Master (20873, 21605)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20873;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21605;
DELETE FROM smart_scripts WHERE entryorguid=20873 AND source_type=0;
INSERT INTO smart_scripts VALUES (20873, 0, 0, 0, 0, 0, 100, 0, 2000, 8000, 6000, 8000, 11, 36813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Negaton Warp-Master - In Combat - Cast Spell Summon Negaton Field');

-- Negaton Field (21414, 21603)
REPLACE INTO creature_template_addon VALUES (21414, 0, 0, 0, 0, 0, '36728');
REPLACE INTO creature_template_addon VALUES (21603, 0, 0, 0, 0, 0, '38833');
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=21414;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21603;
DELETE FROM smart_scripts WHERE entryorguid=21414 AND source_type=0;

-- Eredar Deathbringer (20880, 21594)
REPLACE INTO creature_template_addon VALUES (20880, 0, 0, 0, 4097, 0, '36788 27987');
REPLACE INTO creature_template_addon VALUES (21594, 0, 0, 0, 4097, 0, '38847 38844');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20880;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21594;
DELETE FROM smart_scripts WHERE entryorguid=20880 AND source_type=0;
INSERT INTO smart_scripts VALUES (20880, 0, 0, 0, 0, 0, 100, 2, 3000, 7000, 10000, 10000, 11, 36787, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Deathbringer - In Combat - Cast Spell Forceful Cleave');
INSERT INTO smart_scripts VALUES (20880, 0, 1, 0, 0, 0, 100, 4, 3000, 7000, 10000, 10000, 11, 38846, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Deathbringer - In Combat - Cast Spell Forceful Cleave');

-- Eredar Soul-Eater (20879, 21595)
UPDATE creature_template SET pickpocketloot=20879, AIName='SmartAI', ScriptName='' WHERE entry=20879;
UPDATE creature_template SET pickpocketloot=20879, AIName='', ScriptName='' WHERE entry=21595;
DELETE FROM smart_scripts WHERE entryorguid=20879 AND source_type=0;
INSERT INTO smart_scripts VALUES (20879, 0, 0, 0, 0, 0, 100, 0, 15000, 20000, 40000, 40000, 11, 36784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast Spell Entropic Aura');
INSERT INTO smart_scripts VALUES (20879, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 20000, 20000, 11, 36778, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast Spell Soul Steal');
INSERT INTO smart_scripts VALUES (20879, 0, 2, 0, 0, 0, 100, 2, 3000, 7000, 20000, 20000, 11, 36786, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast Spell Soul Chill');
INSERT INTO smart_scripts VALUES (20879, 0, 3, 0, 0, 0, 100, 4, 3000, 7000, 20000, 20000, 11, 38843, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Eredar Soul-Eater - In Combat - Cast Spell Soul Chill');
-- SPELL Soul Steal (36778)
DELETE FROM spell_script_names WHERE spell_id IN(36778);
INSERT INTO spell_script_names VALUES(36778, 'spell_arcatraz_soul_steal');

-- Unbound Devastator (20881, 21619)
UPDATE creature_template SET pickpocketloot=20881, AIName='SmartAI', ScriptName='' WHERE entry=20881;
UPDATE creature_template SET pickpocketloot=20881, AIName='', ScriptName='' WHERE entry=21619;
DELETE FROM smart_scripts WHERE entryorguid=20881 AND source_type=0;
INSERT INTO smart_scripts VALUES (20881, 0, 0, 0, 0, 0, 100, 2, 4000, 5000, 15000, 15000, 11, 36887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast Spell Deafening Roar');
INSERT INTO smart_scripts VALUES (20881, 0, 1, 0, 0, 0, 100, 4, 4000, 5000, 15000, 15000, 11, 38850, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast Spell Deafening Roar');
INSERT INTO smart_scripts VALUES (20881, 0, 2, 0, 0, 0, 100, 2, 9000, 10000, 15000, 15000, 11, 36891, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast Spell Devastate');
INSERT INTO smart_scripts VALUES (20881, 0, 3, 0, 0, 0, 100, 4, 9000, 10000, 15000, 15000, 11, 38849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unbound Devastator - In Combat - Cast Spell Devastate');

-- Spiteful Temptress (20883, 21615)
UPDATE creature_template SET pickpocketloot=20883, AIName='SmartAI', ScriptName='' WHERE entry=20883;
UPDATE creature_template SET pickpocketloot=20883, AIName='', ScriptName='' WHERE entry=21615;
DELETE FROM smart_scripts WHERE entryorguid=20883 AND source_type=0;
INSERT INTO smart_scripts VALUES (20883, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 20000, 20000, 11, 36886, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast Spell Spiteful Fury');
INSERT INTO smart_scripts VALUES (20883, 0, 1, 0, 0, 0, 100, 0, 14000, 15000, 25000, 25000, 11, 36866, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast Spell Domination');
INSERT INTO smart_scripts VALUES (20883, 0, 2, 0, 0, 0, 100, 2, 1000, 2000, 4000, 4000, 11, 36868, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast Spell Shadow Bolt');
INSERT INTO smart_scripts VALUES (20883, 0, 3, 0, 0, 0, 100, 4, 1000, 2000, 4000, 4000, 11, 38892, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Temptress - In Combat - Cast Spell Shadow Bolt');

-- Skulking Witch (20882, 21613)
REPLACE INTO creature_template_addon VALUES (20882, 0, 0, 0, 4097, 0, '16380');
REPLACE INTO creature_template_addon VALUES (21613, 0, 0, 0, 4097, 0, '16380');
UPDATE creature_template SET pickpocketloot=20882, AIName='SmartAI', ScriptName='' WHERE entry=20882;
UPDATE creature_template SET pickpocketloot=20882, AIName='', ScriptName='' WHERE entry=21613;
DELETE FROM smart_scripts WHERE entryorguid=20882 AND source_type=0;
INSERT INTO smart_scripts VALUES (20882, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 20000, 20000, 11, 36862, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Spell Gouge');
INSERT INTO smart_scripts VALUES (20882, 0, 1, 0, 0, 0, 100, 2, 1000, 2000, 16000, 16000, 11, 36863, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Spell Chastise');
INSERT INTO smart_scripts VALUES (20882, 0, 2, 0, 0, 0, 100, 4, 1000, 2000, 16000, 16000, 11, 38851, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Spell Chastise');
INSERT INTO smart_scripts VALUES (20882, 0, 3, 0, 0, 0, 100, 2, 8000, 9000, 16000, 16000, 11, 36864, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Spell Lash of Pain');
INSERT INTO smart_scripts VALUES (20882, 0, 4, 0, 0, 0, 100, 4, 8000, 9000, 16000, 16000, 11, 38852, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skulking Witch - In Combat - Cast Spell Lash of Pain');

-- Ethereum Slayer (20896, 21596)
UPDATE creature_template SET pickpocketloot=20896, AIName='SmartAI', ScriptName='' WHERE entry=20896;
UPDATE creature_template SET pickpocketloot=20896, AIName='', ScriptName='' WHERE entry=21596;
DELETE FROM smart_scripts WHERE entryorguid=20896 AND source_type=0;
INSERT INTO smart_scripts VALUES (20896, 0, 0, 0, 0, 0, 100, 0, 8000, 15000, 40000, 40000, 11, 15087, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast Spell Evasion');
INSERT INTO smart_scripts VALUES (20896, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 20000, 20000, 11, 36839, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast Spell Impairing Poison');
INSERT INTO smart_scripts VALUES (20896, 0, 2, 0, 0, 0, 100, 2, 3000, 3000, 6000, 6000, 11, 36838, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast Spell Slaying Strike');
INSERT INTO smart_scripts VALUES (20896, 0, 3, 0, 0, 0, 100, 4, 3000, 3000, 6000, 6000, 11, 38894, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Slayer - In Combat - Cast Spell Slaying Strike');

-- Ethereum Wave-Caster (20897, 21597)
UPDATE creature_template SET pickpocketloot=20897, AIName='SmartAI', ScriptName='' WHERE entry=20897;
UPDATE creature_template SET pickpocketloot=20897, AIName='', ScriptName='' WHERE entry=21597;
DELETE FROM smart_scripts WHERE entryorguid=20897 AND source_type=0;
INSERT INTO smart_scripts VALUES (20897, 0, 0, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 32693, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - Between 0-50% Health - Cast Spell Arcane Haste');
INSERT INTO smart_scripts VALUES (20897, 0, 1, 0, 13, 0, 100, 0, 20000, 25000, 0, 0, 11, 38897, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - Target Casting - Cast Spell Sonic Boom');
INSERT INTO smart_scripts VALUES (20897, 0, 2, 0, 0, 0, 100, 2, 10000, 12000, 20000, 25000, 11, 36840, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - In Combat - Cast Spell Polymorph');
INSERT INTO smart_scripts VALUES (20897, 0, 3, 0, 0, 0, 100, 4, 10000, 12000, 20000, 25000, 11, 38896, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Wave-Caster - In Combat - Cast Spell Polymorph');

-- Ethereum Life-Binder (21702, 22346)
UPDATE creature_template SET pickpocketloot=21702, AIName='SmartAI', ScriptName='' WHERE entry=21702;
UPDATE creature_template SET pickpocketloot=21702, AIName='', ScriptName='' WHERE entry=22346;
DELETE FROM smart_scripts WHERE entryorguid=21702 AND source_type=0;
INSERT INTO smart_scripts VALUES (21702, 0, 0, 0, 0, 0, 100, 2, 2000, 4000, 15000, 20000, 11, 37480, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast Spell Bind');
INSERT INTO smart_scripts VALUES (21702, 0, 1, 0, 0, 0, 100, 4, 2000, 4000, 15000, 20000, 11, 38900, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast Spell Bind');
INSERT INTO smart_scripts VALUES (21702, 0, 2, 0, 0, 0, 100, 2, 7000, 9000, 17000, 20000, 11, 15654, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast Spell Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (21702, 0, 3, 0, 0, 0, 100, 4, 7000, 9000, 17000, 20000, 11, 34941, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - In Combat - Cast Spell Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (21702, 0, 4, 0, 14, 0, 100, 2, 1000, 40, 15000, 20000, 11, 37479, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - On Friendly Health - Cast Spell Shadow Mend');
INSERT INTO smart_scripts VALUES (21702, 0, 5, 0, 14, 0, 100, 4, 1000, 40, 15000, 20000, 11, 38899, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ethereum Life-Binder - On Friendly Health - Cast Spell Shadow Mend');

-- Sargeron Hellcaller (20902, 21611)
UPDATE creature_template SET pickpocketloot=20902, AIName='SmartAI', ScriptName='' WHERE entry=20902;
UPDATE creature_template SET pickpocketloot=20902, AIName='', ScriptName='' WHERE entry=21611;
DELETE FROM smart_scripts WHERE entryorguid=20902 AND source_type=0;
INSERT INTO smart_scripts VALUES (20902, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 30000, 40000, 11, 36831, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast Spell Curse of the Elements');
INSERT INTO smart_scripts VALUES (20902, 0, 1, 0, 0, 0, 100, 2, 7000, 9000, 17000, 20000, 11, 36829, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast Spell Hell Rain');
INSERT INTO smart_scripts VALUES (20902, 0, 2, 0, 0, 0, 100, 4, 7000, 9000, 17000, 20000, 11, 38917, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast Spell Hell Rain');
INSERT INTO smart_scripts VALUES (20902, 0, 3, 0, 0, 0, 100, 2, 1000, 1000, 4000, 4000, 11, 36832, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast Spell Incinerate');
INSERT INTO smart_scripts VALUES (20902, 0, 4, 0, 0, 0, 100, 4, 1000, 1000, 4000, 4000, 11, 38918, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Hellcaller - In Combat - Cast Spell Incinerate');

-- Sargeron Archer (20901, 21610)
REPLACE INTO creature_template_addon VALUES (20901, 0, 0, 0, 4098, 0, '');
REPLACE INTO creature_template_addon VALUES (21610, 0, 0, 0, 4098, 0, '');
UPDATE creature_template SET pickpocketloot=20901, AIName='SmartAI', ScriptName='' WHERE entry=20901;
UPDATE creature_template SET pickpocketloot=20901, AIName='', ScriptName='' WHERE entry=21610;
DELETE FROM smart_scripts WHERE entryorguid=20901 AND source_type=0;
INSERT INTO smart_scripts VALUES (20901, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 31, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - On Reset - Set Random Event Phase Range');
INSERT INTO smart_scripts VALUES (20901, 0, 1, 0, 9, 0, 100, 2, 5, 30, 3000, 3000, 11, 21610, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Shoot');
INSERT INTO smart_scripts VALUES (20901, 0, 2, 0, 9, 0, 100, 4, 5, 30, 3000, 3000, 11, 38940, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Shoot');
INSERT INTO smart_scripts VALUES (20901, 0, 3, 0, 0, 1, 100, 2, 4000, 4000, 9000, 9000, 11, 35964, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Frost Arrow');
INSERT INTO smart_scripts VALUES (20901, 0, 4, 0, 0, 1, 100, 4, 4000, 4000, 9000, 9000, 11, 38942, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Frost Arrow');
INSERT INTO smart_scripts VALUES (20901, 0, 5, 0, 0, 2, 100, 2, 4000, 4000, 9000, 9000, 11, 35932, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Immolation Arrow');
INSERT INTO smart_scripts VALUES (20901, 0, 6, 0, 0, 2, 100, 4, 4000, 4000, 9000, 9000, 11, 38943, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Immolation Arrow');
INSERT INTO smart_scripts VALUES (20901, 0, 7, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 36828, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Rapid Fire');
INSERT INTO smart_scripts VALUES (20901, 0, 8, 0, 0, 0, 100, 2, 20000, 20000, 30000, 30000, 11, 36984, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Serpent Sting');
INSERT INTO smart_scripts VALUES (20901, 0, 9, 0, 0, 0, 100, 4, 20000, 20000, 30000, 30000, 11, 38914, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Serpent Sting');
INSERT INTO smart_scripts VALUES (20901, 0, 10, 0, 0, 0, 100, 2, 10000, 10000, 30000, 30000, 11, 36827, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Hooked Net');
INSERT INTO smart_scripts VALUES (20901, 0, 11, 0, 0, 0, 100, 4, 10000, 10000, 30000, 30000, 11, 38912, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sargeron Archer - In Combat - Cast Spell Hooked Net');

-- Gargantuan Abyssal (20898, 21598)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20898;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21598;
DELETE FROM smart_scripts WHERE entryorguid=20898 AND source_type=0;
INSERT INTO smart_scripts VALUES (20898, 0, 0, 0, 0, 0, 100, 2, 3000, 10000, 20000, 20000, 11, 36837, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast Spell Meteor');
INSERT INTO smart_scripts VALUES (20898, 0, 1, 0, 0, 0, 100, 4, 3000, 10000, 20000, 20000, 11, 38903, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast Spell Meteor');
INSERT INTO smart_scripts VALUES (20898, 0, 2, 0, 0, 0, 100, 3, 2000, 5000, 0, 0, 11, 38855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast Spell Fire Shield');
INSERT INTO smart_scripts VALUES (20898, 0, 3, 0, 0, 0, 100, 5, 2000, 5000, 0, 0, 11, 38901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gargantuan Abyssal - In Combat - Cast Spell Fire Shield');

-- Unchained Doombringer (20900, 21621)
UPDATE creature_template SET pickpocketloot=20900, AIName='SmartAI', ScriptName='' WHERE entry=20900;
UPDATE creature_template SET pickpocketloot=20900, AIName='', ScriptName='' WHERE entry=21621;
DELETE FROM smart_scripts WHERE entryorguid=20900 AND source_type=0;
INSERT INTO smart_scripts VALUES (20900, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 36833, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast Spell Berserker Charge');
INSERT INTO smart_scripts VALUES (20900, 0, 1, 0, 0, 0, 100, 0, 4000, 10000, 60000, 60000, 11, 36836, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast Spell Agonizing Armor');
INSERT INTO smart_scripts VALUES (20900, 0, 2, 0, 0, 0, 100, 3, 10000, 15000, 25000, 30000, 11, 36835, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast Spell War Stomp');
INSERT INTO smart_scripts VALUES (20900, 0, 3, 0, 0, 0, 100, 5, 10000, 15000, 25000, 30000, 11, 38911, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unchained Doombringer - In Combat - Cast Spell War Stomp');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Zereketh the Unbound (20870, 21626)
DELETE FROM creature_text WHERE entry=20870;
INSERT INTO creature_text VALUES (20870, 0, 0, 'Life energy to... consume.', 14, 0, 100, 0, 0, 11250, 0, 'Zereketh The Unbound - Aggro Say');
INSERT INTO creature_text VALUES (20870, 1, 0, 'This vessel... is empty.', 14, 0, 100, 0, 0, 11251, 0, 'Zereketh The Unbound - Player Death Say');
INSERT INTO creature_text VALUES (20870, 1, 1, 'No...more...life.', 14, 0, 100, 0, 0, 11252, 0, 'Zereketh The Unbound - Player Death Say');
INSERT INTO creature_text VALUES (20870, 2, 0, 'The shadow... will engulf you.', 14, 0, 100, 0, 0, 11253, 0, 'Zereketh The Unbound - Cast Shadow Nova Say');
INSERT INTO creature_text VALUES (20870, 2, 1, 'Darkness...consumes...all.', 14, 0, 100, 0, 0, 11254, 0, 'Zereketh The Unbound - Cast Shadow Nova Say');
INSERT INTO creature_text VALUES (20870, 3, 0, 'The void...beckons.', 14, 0, 100, 0, 0, 11255, 0, 'Zereketh The Unbound - On Death Say');
UPDATE creature_template SET speed_run=1.71429, AIName='', ScriptName='boss_zereketh_the_unbound' WHERE entry=20870;
UPDATE creature_template SET speed_run=1.71429, AIName='', ScriptName='' WHERE entry=21626;

-- Unbound Void Zone (21101, 21620)
REPLACE INTO creature_template_addon VALUES (21101, 0, 0, 0, 0, 0, '36120');
REPLACE INTO creature_template_addon VALUES (21620, 0, 0, 0, 0, 0, '39003');
UPDATE creature_template SET faction=16, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=21101;
UPDATE creature_template SET faction=16, flags_extra=2, AIName='', ScriptName='' WHERE entry=21620;

-- Dalliah the Doomsayer (20885, 21590)
DELETE FROM creature_text WHERE entry=20885;
INSERT INTO creature_text VALUES (20885, 0, 0, 'Don''t worry about me; kill that worthless dullard instead!', 14, 0, 100, 1, 0, 11085, 0, 'Dalliah the Doomsayer - Aggro Soccothrates First');
INSERT INTO creature_text VALUES (20885, 1, 0, 'It is unwise to anger me.', 14, 0, 100, 0, 0, 11086, 0, 'Dalliah the Doomsayer - Aggro');
INSERT INTO creature_text VALUES (20885, 2, 0, 'Completely ineffective. Just like someone else I know.', 14, 0, 100, 0, 0, 11087, 0, 'Dalliah the Doomsayer - Kill');
INSERT INTO creature_text VALUES (20885, 2, 1, 'You chose the wrong opponent.', 14, 0, 100, 0, 0, 11088, 0, 'Dalliah the Doomsayer - Kill');
INSERT INTO creature_text VALUES (20885, 3, 0, 'Reap the Whirlwind!', 14, 0, 100, 0, 0, 11089, 0, 'Dalliah the Doomsayer - Cast Whirlwind');
INSERT INTO creature_text VALUES (20885, 3, 1, 'I''ll cut you to pieces!', 14, 0, 100, 0, 0, 11090, 0, 'Dalliah the Doomsayer - Cast Whirlwind');
INSERT INTO creature_text VALUES (20885, 4, 0, 'Ahh... That is much better.', 14, 0, 100, 0, 0, 11091, 0, 'Dalliah the Doomsayer - Cast Heal');
INSERT INTO creature_text VALUES (20885, 4, 1, 'Ahh... Just what I needed.', 14, 0, 100, 0, 0, 11092, 0, 'Dalliah the Doomsayer - Cast Heal');
INSERT INTO creature_text VALUES (20885, 5, 0, 'Now I''m really... angry...', 14, 0, 100, 0, 0, 11093, 0, 'Dalliah the Doomsayer - Death');
INSERT INTO creature_text VALUES (20885, 6, 0, 'More than you can handle, scryer?', 14, 0, 100, 1, 0, 11094, 0, 'Dalliah the Doomsayer - Soccothrates at 25%');
INSERT INTO creature_text VALUES (20885, 6, 1, 'I suppose I''ll end up fighting them all myself.', 14, 0, 100, 1, 0, 11095, 0, 'Dalliah the Doomsayer - Soccothrates at 25%');
INSERT INTO creature_text VALUES (20885, 6, 2, 'I''ve grown used to cleaning up your messes.', 14, 0, 100, 1, 0, 11096, 0, 'Dalliah the Doomsayer - Soccothrates at 25%');
INSERT INTO creature_text VALUES (20885, 7, 0, 'Congratulations. I''ve wanted to do that for years.', 14, 0, 100, 66, 0, 11097, 0, 'Dalliah the Doomsayer - Soccothratess dies');
INSERT INTO creature_text VALUES (20885, 8, 0, 'Why would I call on you?', 14, 0, 100, 396, 0, 0, 0, 'Dalliah the Doomsayer - Conversation with Soccothrates part 1');
INSERT INTO creature_text VALUES (20885, 9, 0, 'When I need someone to prance around like an overstuffed peacock, I''ll call on you.', 14, 0, 100, 396, 0, 0, 0, 'Dalliah the Doomsayer - Conversation with Soccothrates part 2');
INSERT INTO creature_text VALUES (20885, 10, 0, 'What would you know about commitment, sheet-sah?', 14, 0, 100, 396, 0, 0, 0, 'Dalliah the Doomsayer - Conversation with Soccothrates part 3');
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=20885, AIName='', ScriptName='boss_dalliah_the_doomsayer' WHERE entry=20885;
UPDATE creature_template SET speed_run=1.42857, pickpocketloot=20885, AIName='', ScriptName='' WHERE entry=21590;

-- SPELL Curse of the Doomsayer (36174)
-- SPELL Curse of the Doomsayer (39011)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(36174, 39011);
INSERT INTO conditions VALUES(13, 1, 36174, 0, 0, 31, 0, 3, 20885, 0, 0, 0, 0, '', 'Target Dalliah the Doomsayer');
INSERT INTO conditions VALUES(13, 1, 39011, 0, 0, 31, 0, 3, 20885, 0, 0, 0, 0, '', 'Target Dalliah the Doomsayer');

-- Wrath-Scryer Soccothrates (20886, 21624)
DELETE FROM creature_text WHERE entry=20886;
INSERT INTO creature_text VALUES (20886, 0, 0, 'Have you come to kill Dalliah? Can I watch?', 14, 0, 100, 1, 0, 11237, 0, 'Wrath-Scryer Soccothrates - Aggro Dalliah First');
INSERT INTO creature_text VALUES (20886, 1, 0, 'At last, a target for my frustrations!', 14, 0, 100, 0, 0, 11238, 0, 'Wrath-Scryer Soccothrates - Aggro');
INSERT INTO creature_text VALUES (20886, 2, 0, 'Yes, that was quite satisfying.', 14, 0, 100, 0, 0, 11239, 0, 'Wrath-Scryer Soccothrates - Kill');
INSERT INTO creature_text VALUES (20886, 3, 0, 'On guard!', 14, 0, 100, 0, 0, 11241, 0, 'Wrath-Scryer Soccothrates - Knock Away');
INSERT INTO creature_text VALUES (20886, 3, 1, 'Defend yourself, for all the good it will do...', 14, 0, 100, 0, 0, 11242, 0, 'Wrath-Scryer Soccothrates - Knock Away');
INSERT INTO creature_text VALUES (20886, 4, 0, 'Knew this was... the only way out.', 14, 0, 100, 0, 0, 11243, 0, 'Wrath-Scryer Soccothrates - Death');
INSERT INTO creature_text VALUES (20886, 5, 0, 'Having problems, Dalliah? How nice.', 14, 0, 100, 1, 0, 11244, 0, 'Wrath-Scryer Soccothrates - Dalliah at 25%');
INSERT INTO creature_text VALUES (20886, 5, 1, 'This may be the end of you Dalliah, what a shame that would be.', 14, 0, 100, 1, 0, 11245, 0, 'Wrath-Scryer Soccothrates - Dalliah at 25%');
INSERT INTO creature_text VALUES (20886, 5, 2, 'I suggest a new strategy, you draw the attackers while I gather reinforcements. Hahaha!', 14, 0, 100, 1, 0, 11246, 0, 'Wrath-Scryer Soccothrates - Dalliah at 25%');
INSERT INTO creature_text VALUES (20886, 6, 0, 'Finally! Well done!', 14, 0, 100, 66, 0, 11247, 0, 'Wrath-Scryer Soccothrates - Dalliah dies');
INSERT INTO creature_text VALUES (20886, 7, 0, 'Did you call on me?', 14, 0, 100, 397, 0, 11236, 0, 'Wrath-Scryer Soccothrates - Conversation with Dalliah part 1');
INSERT INTO creature_text VALUES (20886, 8, 0, 'To do your heavy lifting, most likely.', 14, 0, 100, 396, 0, 0, 0, 'Wrath-Scryer Soccothrates - Conversation with Dalliah part 2');
INSERT INTO creature_text VALUES (20886, 9, 0, 'Then I''ll commit myself to ignoring you.', 14, 0, 100, 396, 0, 0, 0, 'Wrath-Scryer Soccothrates - Conversation with Dalliah part 3');
INSERT INTO creature_text VALUES (20886, 10, 0, 'You''re the one who should be-- Wait, we have company...', 14, 0, 100, 396, 0, 0, 0, 'Wrath-Scryer Soccothrates - Conversation with Dalliah part 4');
UPDATE creature_template SET speed_run=1.42857, AIName='', ScriptName='boss_wrath_scryer_soccothrates' WHERE entry=20886;
UPDATE creature_template SET speed_run=1.42857, AIName='', ScriptName='' WHERE entry=21624;

-- SPELL Charge (35754)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=35754;
INSERT INTO conditions VALUES(13, 7, 35754, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target All Players');

-- Warden Mellichar (20904, 21622)
DELETE FROM creature_text WHERE entry=20904;
INSERT INTO creature_text VALUES (20904, 0, 0, 'I knew the prince would be angry but, I... I have not been myself. I had to let them out! The great one speaks to me, you see. Wait--outsiders. Kael''thas did not send you! Good... I''ll just tell the prince you released the prisoners!', 14, 0, 100, 1, 0, 11222, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 1, 0, 'The naaru kept some of the most dangerous beings in existence here in these cells. Let me introduce you to another...', 14, 0, 100, 1, 0, 11223, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 2, 0, 'Yes, yes... another! Your will is mine!', 14, 0, 100, 0, 0, 11224, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 3, 0, 'Behold another terrifying creature of incomprehensible power!', 14, 0, 100, 0, 0, 11225, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 4, 0, 'What is this? A lowly gnome? I will do better, O great one.', 14, 0, 100, 0, 0, 11226, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 5, 0, 'Anarchy! Bedlam! Oh, you are so wise! Yes, I see it now, of course!', 14, 0, 100, 0, 0, 11227, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 6, 0, 'One final cell remains. Yes, O great one, right away!', 14, 0, 100, 0, 0, 11228, 0, 'Warden Mellichar');
INSERT INTO creature_text VALUES (20904, 7, 0, 'Welcome, O great one. I am your humble servant.', 14, 0, 100, 0, 0, 11229, 0, 'Warden Mellichar');
UPDATE creature_template SET speed_run=0.857143, AIName='', ScriptName='npc_warden_mellichar' WHERE entry=20904;
UPDATE creature_template SET speed_run=0.857143, AIName='', ScriptName='' WHERE entry=21622;

-- SPELL Mind Rend (36859)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (36859);
INSERT INTO conditions VALUES(13, 1, 36859, 0, 0, 31, 0, 3, 20904, 0, 0, 0, 0, '', 'Target Warden Mellichar');
-- SPELL Channel (36852)
-- SPELL Channel (36854)
-- SPELL Channel (36856)
-- SPELL Channel (36857)
-- SPELL Channel (36858)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (36852, 36854, 36856, 36857, 36858);
INSERT INTO conditions VALUES(13, 1, 36852, 0, 0, 31, 0, 3, 21440, 0, 0, 0, 0, '', 'Target Tempest Keep Prison Boss Pod Target');
INSERT INTO conditions VALUES(13, 1, 36854, 0, 0, 31, 0, 3, 21437, 0, 0, 0, 0, '', 'Target Tempest Keep Prison Beta Pod Target');
INSERT INTO conditions VALUES(13, 1, 36856, 0, 0, 31, 0, 3, 21438, 0, 0, 0, 0, '', 'Target Tempest Keep Prison Gamma Pod Target');
INSERT INTO conditions VALUES(13, 1, 36857, 0, 0, 31, 0, 3, 21439, 0, 0, 0, 0, '', 'Target Tempest Keep Prison Delta Pod Target');
INSERT INTO conditions VALUES(13, 1, 36858, 0, 0, 31, 0, 3, 21436, 0, 0, 0, 0, '', 'Target Tempest Keep Prison Alpha Pod Target');
-- Tempest Keep Prison Alpha Pod Target (21436)
-- Tempest Keep Prison Beta Pod Target (21437)
-- Tempest Keep Prison Gamma Pod Target (21438)
-- Tempest Keep Prison Delta Pod Target (21439)
-- Tempest Keep Prison Boss Pod Target (21440)
UPDATE creature SET position_x=477.348, position_y=-151.661, position_z=55.786 WHERE id=21436;
UPDATE creature SET position_x=414.231, position_y=-151.940, position_z=54.970 WHERE id=21437; 
UPDATE creature_template SET InhabitType=4 WHERE entry IN(21436, 21437, 21438, 21439, 21440);

-- Blazing Trickster (20905, 21589)
DELETE FROM creature_text WHERE entry=20905;
INSERT INTO creature_text VALUES (20905, 0, 0, 'I''m gonna cook ya, an'' then I''m gonna eat ya!', 14, 0, 100, 0, 0, 0, 0, 'Blazing Trickster');
INSERT INTO creature_text VALUES (20905, 1, 0, 'I hope you all... die in pain!', 14, 0, 100, 0, 0, 0, 0, 'Blazing Trickster');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20905;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21589;
DELETE FROM smart_scripts WHERE entryorguid=20905 AND source_type=0;
INSERT INTO smart_scripts VALUES (20905, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Respawn - Talk');
INSERT INTO smart_scripts VALUES (20905, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20905, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20905, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 5, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20905, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 5, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20905, 0, 5, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 36905, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - In Combat - Cast Firebolt');
INSERT INTO smart_scripts VALUES (20905, 0, 6, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 39022, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - In Combat - Cast Firebolt');
INSERT INTO smart_scripts VALUES (20905, 0, 7, 0, 0, 0, 100, 0, 1000, 1000, 20000, 20000, 11, 36907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - In Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (20905, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blazing Trickster - On Just Died - Talk');

-- Phase-Hunter (20906, 21606)
UPDATE creature_template SET skinloot=70162, AIName='SmartAI', ScriptName='' WHERE entry=20906;
UPDATE creature_template SET skinloot=70162, AIName='', ScriptName='' WHERE entry=21606;
DELETE FROM smart_scripts WHERE entryorguid=20906 AND source_type=0;
INSERT INTO smart_scripts VALUES (20906, 0, 1, 2, 60, 0, 100, 257, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20906, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20906, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 5, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20906, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 5, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20906, 0, 5, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 36909, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - In Combat - Cast Back Attack');
INSERT INTO smart_scripts VALUES (20906, 0, 6, 0, 0, 0, 100, 0, 8000, 8000, 20000, 20000, 11, 36910, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - In Combat - Cast Phase Burst');
INSERT INTO smart_scripts VALUES (20906, 0, 7, 0, 0, 0, 100, 0, 3000, 3000, 15000, 15000, 11, 36908, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Phase-Hunter - In Combat - Cast Warp');

-- Akkiris Lightning-Waker (20908, 21617)
DELETE FROM creature_text WHERE entry=20908;
INSERT INTO creature_text VALUES (20908, 0, 0, 'You dare imprison me? You will die!', 14, 0, 100, 0, 0, 0, 0, 'Akkiris Lightning-Waker');
INSERT INTO creature_text VALUES (20908, 1, 0, 'You are... nothing!', 14, 0, 100, 0, 0, 0, 0, 'Akkiris Lightning-Waker');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20908;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21617;
DELETE FROM smart_scripts WHERE entryorguid=20908 AND source_type=0;
INSERT INTO smart_scripts VALUES (20908, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Respawn - Talk');
INSERT INTO smart_scripts VALUES (20908, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20908, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20908, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 7, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20908, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20908, 0, 5, 0, 0, 0, 100, 2, 7000, 8000, 19000, 19000, 11, 36915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - In Combat - Cast Lightning Discharge');
INSERT INTO smart_scripts VALUES (20908, 0, 6, 0, 0, 0, 100, 4, 7000, 8000, 19000, 19000, 11, 39028, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - In Combat - Cast Lightning Discharge');
INSERT INTO smart_scripts VALUES (20908, 0, 7, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 36914, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - In Combat - Cast Lightning-Wakers Curse');
INSERT INTO smart_scripts VALUES (20908, 0, 8, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 19714, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - In Combat - Cast Magic Grounding');
INSERT INTO smart_scripts VALUES (20908, 0, 9, 0, 13, 0, 100, 0, 15000, 15000, 0, 0, 11, 32691, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - In Combat - Cast Spell Shock');
INSERT INTO smart_scripts VALUES (20908, 0, 10, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Akkiris Lightning-Waker - On Just Died - Talk');

-- Sulfuron Magma-Thrower (20909, 21616)
DELETE FROM creature_text WHERE entry=20909;
INSERT INTO creature_text VALUES (20909, 0, 0, 'You shall be consumed by flame!', 14, 0, 100, 0, 0, 0, 0, 'Sulfuron Magma-Thrower');
INSERT INTO creature_text VALUES (20909, 1, 0, 'S-s-o-o... cold.', 14, 0, 100, 0, 0, 0, 0, 'Sulfuron Magma-Thrower');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20909;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21616;
DELETE FROM smart_scripts WHERE entryorguid=20909 AND source_type=0;
INSERT INTO smart_scripts VALUES (20909, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Respawn - Talk');
INSERT INTO smart_scripts VALUES (20909, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20909, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20909, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 7, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20909, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20909, 0, 5, 0, 0, 0, 100, 2, 7000, 8000, 24000, 24000, 11, 19717, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (20909, 0, 6, 0, 0, 0, 100, 4, 7000, 8000, 24000, 24000, 11, 39024, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (20909, 0, 7, 0, 0, 0, 100, 2, 1000, 1000, 5000, 5000, 11, 36986, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (20909, 0, 8, 0, 0, 0, 100, 4, 1000, 1000, 5000, 5000, 11, 39025, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (20909, 0, 9, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 19714, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Magic Grounding');
INSERT INTO smart_scripts VALUES (20909, 0, 10, 0, 0, 0, 100, 0, 2000, 5000, 30000, 30000, 11, 36917, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - In Combat - Cast Spell Magma-Throwers Curse');
INSERT INTO smart_scripts VALUES (20909, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sulfuron Magma-Thrower - On Just Died - Talk');

-- Twilight Drakonaar (20910, 21618)
DELETE FROM creature_text WHERE entry=20910;
INSERT INTO creature_text VALUES (20910, 0, 0, 'Pathetic, inferior mortals!', 14, 0, 100, 0, 0, 0, 0, 'Twilight Drakonaar');
INSERT INTO creature_text VALUES (20910, 1, 0, 'The black dragonflight will conquer all!', 14, 0, 100, 0, 0, 0, 0, 'Twilight Drakonaar');
UPDATE creature_template SET resistance2=140, resistance3=140, resistance4=140, resistance5=140, resistance6=140, AIName='SmartAI', ScriptName='' WHERE entry=20910;
UPDATE creature_template SET resistance2=140, resistance3=140, resistance4=140, resistance5=140, resistance6=140, AIName='', ScriptName='' WHERE entry=21618;
DELETE FROM smart_scripts WHERE entryorguid=20910 AND source_type=0;
INSERT INTO smart_scripts VALUES (20910, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Respawn - Talk');
INSERT INTO smart_scripts VALUES (20910, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20910, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20910, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 8, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20910, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 8, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20910, 0, 5, 0, 0, 0, 100, 2, 3000, 3000, 35000, 35000, 11, 22560, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Black');
INSERT INTO smart_scripts VALUES (20910, 0, 6, 0, 0, 0, 100, 4, 3000, 3000, 35000, 35000, 11, 39033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Black');
INSERT INTO smart_scripts VALUES (20910, 0, 7, 0, 0, 0, 100, 2, 10000, 10000, 35000, 35000, 11, 22559, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Blue');
INSERT INTO smart_scripts VALUES (20910, 0, 8, 0, 0, 0, 100, 4, 10000, 10000, 35000, 35000, 11, 39037, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Blue');
INSERT INTO smart_scripts VALUES (20910, 0, 9, 0, 0, 0, 100, 2, 17000, 17000, 35000, 35000, 11, 22642, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Bronze');
INSERT INTO smart_scripts VALUES (20910, 0, 10, 0, 0, 0, 100, 4, 17000, 17000, 35000, 35000, 11, 39036, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Bronze');
INSERT INTO smart_scripts VALUES (20910, 0, 11, 0, 0, 0, 100, 2, 24000, 24000, 35000, 35000, 11, 22558, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Red');
INSERT INTO smart_scripts VALUES (20910, 0, 12, 0, 0, 0, 100, 4, 24000, 24000, 35000, 35000, 11, 39034, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Red');
INSERT INTO smart_scripts VALUES (20910, 0, 13, 0, 0, 0, 100, 0, 31000, 31000, 35000, 35000, 11, 22561, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - In Combat - Cast Brood Power: Green');
INSERT INTO smart_scripts VALUES (20910, 0, 14, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Drakonaar - On Just Died - Talk');

-- Blackwing Drakonaar (20911, 21588)
DELETE FROM creature_text WHERE entry=20911;
INSERT INTO creature_text VALUES (20911, 0, 0, 'Pathetic, inferior mortals!', 14, 0, 100, 0, 0, 0, 0, 'Blackwing Drakonaar');
INSERT INTO creature_text VALUES (20911, 1, 0, 'The dragonflight will... devour you.', 14, 0, 100, 0, 0, 0, 0, 'Blackwing Drakonaar');
UPDATE creature_template SET resistance2=1000, AIName='SmartAI', ScriptName='' WHERE entry=20911;
UPDATE creature_template SET resistance2=1000, AIName='', ScriptName='' WHERE entry=21588;
DELETE FROM smart_scripts WHERE entryorguid=20911 AND source_type=0;
INSERT INTO smart_scripts VALUES (20911, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Respawn - Talk');
INSERT INTO smart_scripts VALUES (20911, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35517, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Respawn - Cast Spell Teleport Visual');
INSERT INTO smart_scripts VALUES (20911, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Respawn - Set in Combat With Zone');
INSERT INTO smart_scripts VALUES (20911, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 8, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Just Died - Set Instance Data');
INSERT INTO smart_scripts VALUES (20911, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 34, 8, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Evade - Set Instance Data');
INSERT INTO smart_scripts VALUES (20911, 0, 5, 0, 0, 0, 100, 0, 9000, 9000, 20000, 20000, 11, 39038, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (20911, 0, 6, 0, 0, 0, 100, 0, 3000, 3000, 20000, 20000, 11, 39033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - In Combat - Cast Brood Power: Black');
INSERT INTO smart_scripts VALUES (20911, 0, 7, 0, 0, 0, 100, 0, 6000, 6000, 7000, 7000, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (20911, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackwing Drakonaar - On Just Died - Talk');

-- Millhouse Manastorm (20977, 21602)
DELETE FROM creature_text WHERE entry=20977;
INSERT INTO creature_text VALUES (20977, 0, 0, 'Where in Bonzo''s Brass Buttons am I? And who are-- yaaghh, that''s one mother of a headache!', 14, 0, 100, 0, 0, 11171, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 1, 0, '"Lowly"? I don''t care who you are, friend: no one refers to the mighty Millhouse Manastorm as "lowly"!', 14, 0, 100, 0, 0, 11172, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 2, 0, 'I just need to get some things ready first. You guys go ahead and get started. I need to summon up some water....', 14, 0, 100, 0, 0, 11173, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 3, 0, 'Fantastic! Next, some protective spells. Yeah, now we''re cookin''!', 14, 0, 100, 0, 0, 11174, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 4, 0, 'And of course I''ll need some mana. You guys are gonna love this; just wait....', 14, 0, 100, 0, 0, 11175, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 5, 0, 'Aaalllriiiight!! Who ordered up an extra large can of whoop-ass?', 14, 0, 100, 0, 0, 11176, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 6, 0, 'I didn''t even break a sweat on that one.', 14, 0, 100, 0, 0, 11177, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 6, 1, 'You guys, feel free to jump in anytime.', 14, 0, 100, 0, 0, 11178, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 7, 0, 'I''m gonna light you up, sweet cheeks!', 14, 0, 100, 0, 0, 11179, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 8, 0, 'Ice, ice, baby!', 14, 0, 100, 0, 0, 11180, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 9, 0, 'Heal me! Oh, for the love of all that is holy, HEAL me! I''m dying!', 14, 0, 100, 0, 0, 11181, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 10, 0, 'You''ll be hearing from my lawyer...', 14, 0, 100, 0, 0, 11182, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 11, 0, 'Who''s bad? Who''s bad? That''s right: we bad!', 14, 0, 100, 0, 0, 11183, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 12, 0, 'I have no idea what goes on here, but I will gladly join your fight against this impudent imbecile!', 14, 0, 100, 0, 0, 0, 0, 'Millhouse Manastorm');
INSERT INTO creature_text VALUES (20977, 13, 0, 'Prepare to defend yourself, cretin!', 14, 0, 100, 0, 0, 0, 0, 'Millhouse Manastorm');
UPDATE creature_template SET unit_flags=4160, AIName='', ScriptName='npc_millhouse_manastorm' WHERE entry=20977;
UPDATE creature_template SET unit_flags=4160, AIName='', ScriptName='' WHERE entry=21602;

-- Harbinger Skyriss (20912, 21601)
DELETE FROM creature_text WHERE entry=20912;
INSERT INTO creature_text VALUES (20912, 0, 0, 'It is a small matter to control the mind of the weak... for I bear allegiance to powers untouched by time, unmoved by fate. No force on this world or beyond harbors the strength to bend our knee... not even the mighty Legion!', 14, 0, 100, 0, 0, 11122, 0, 'skyriss SAY_INTRO');
INSERT INTO creature_text VALUES (20912, 1, 0, 'Bear witness to the agent of your demise!', 14, 0, 100, 0, 0, 11123, 0, 'skyriss SAY_AGGRO');
INSERT INTO creature_text VALUES (20912, 2, 0, 'Your fate is written!', 14, 0, 100, 0, 0, 11124, 0, 'skyriss SAY_KILL_1');
INSERT INTO creature_text VALUES (20912, 2, 1, 'The chaos I have sown here is but a taste...', 14, 0, 100, 0, 0, 11125, 0, 'skyriss SAY_KILL_2');
INSERT INTO creature_text VALUES (20912, 3, 0, 'You will do my bidding, weakling.', 14, 0, 100, 0, 0, 11127, 0, 'skyriss SAY_MIND_1');
INSERT INTO creature_text VALUES (20912, 3, 1, 'Your will is no longer your own.', 14, 0, 100, 0, 0, 11128, 0, 'skyriss SAY_MIND_2');
INSERT INTO creature_text VALUES (20912, 4, 0, 'Flee in terror!', 14, 0, 100, 0, 0, 11129, 0, 'skyriss SAY_FEAR_1');
INSERT INTO creature_text VALUES (20912, 4, 1, 'I will show you horrors undreamed of!', 14, 0, 100, 0, 0, 11130, 0, 'skyriss SAY_FEAR_2');
INSERT INTO creature_text VALUES (20912, 5, 0, 'We span the universe, as countless as the stars!', 14, 0, 100, 0, 0, 11131, 0, 'skyriss SAY_IMAGE');
INSERT INTO creature_text VALUES (20912, 6, 0, 'I am merely one of... infinite multitudes.', 14, 0, 100, 0, 0, 11126, 0, 'skyriss SAY_DEATH');
UPDATE creature_template SET Health_mod=25, AIName='', ScriptName='boss_harbinger_skyriss' WHERE entry=20912;
UPDATE creature_template SET Health_mod=33, AIName='', ScriptName='' WHERE entry=21601;

-- Harbinger Skyriss Illusion (21466, 21600)
-- Harbinger Skyriss Illusion (21467, 21599)
DELETE FROM creature_text WHERE entry IN(21466, 21467);
INSERT INTO creature_text VALUES (21466, 0, 0, 'I will show you horrors undreamed of.', 14, 0, 100, 0, 0, 0, 0, 'Harbinger Skyriss Illusion');
INSERT INTO creature_text VALUES (21466, 0, 1, 'We span the universe, as countless as the stars!', 14, 0, 100, 0, 0, 0, 0, 'Harbinger Skyriss Illusion');
INSERT INTO creature_text VALUES (21467, 0, 0, 'I am merely one of... infinite multitudes.', 14, 0, 100, 0, 0, 0, 0, 'Harbinger Skyriss Illusion');
UPDATE creature_template SET unit_flags=64, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry IN(21466, 21467);
UPDATE creature_template SET unit_flags=64, flags_extra=0, AIName='', ScriptName='' WHERE entry IN(21599, 21600);
DELETE FROM smart_scripts WHERE entryorguid IN(21466, 21467) AND source_type=0;
INSERT INTO smart_scripts VALUES (21466, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (21466, 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 8000, 8000, 11, 36929, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - In Combat - Cast Spell Mind Rend');
INSERT INTO smart_scripts VALUES (21466, 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 8000, 8000, 11, 39021, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - In Combat - Cast Spell Mind Rend');
INSERT INTO smart_scripts VALUES (21467, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (21467, 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 8000, 8000, 11, 36929, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - In Combat - Cast Spell Mind Rend');
INSERT INTO smart_scripts VALUES (21467, 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 8000, 8000, 11, 39021, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Harbinger Skyriss Illusion - In Combat - Cast Spell Mind Rend');

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(79444, 79445);
DELETE FROM creature_formations WHERE leaderGUID IN(79444, 79445, 79454) OR memberGUID IN(79444, 79445, 79454);
INSERT INTO creature_formations VALUES (79454, 79454, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (79454, 79444, 3, 150, 4, 0, 0);
INSERT INTO creature_formations VALUES (79454, 79445, 3, 210, 4, 0, 0);

UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(79455, 79453);
DELETE FROM creature_formations WHERE leaderGUID IN(79455, 79453, 79452) OR memberGUID IN(79455, 79453, 79452);
INSERT INTO creature_formations VALUES (79452, 79452, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (79452, 79455, 3, 150, 4, 0, 0);
INSERT INTO creature_formations VALUES (79452, 79453, 3, 210, 4, 0, 0);

-- Protean Horrors before first boss
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(79456, 79457);
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=79458;
REPLACE creature_addon VALUES(79458, 7945800, 0, 0, 4096, 0, '');
DELETE FROM creature_formations WHERE leaderGUID IN(79456, 79457, 79458) OR memberGUID IN(79456, 79457, 79458);
INSERT INTO creature_formations VALUES (79458, 79458, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (79458, 79456, 3, 150, 2, 0, 0);
INSERT INTO creature_formations VALUES (79458, 79457, 3, 210, 2, 0, 0);
DELETE FROM waypoint_data WHERE id=79458*100;
INSERT INTO waypoint_data VALUES (7945800, 1, 206.419, -22.3892, -10.0924, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 2, 214.975, -16.9564, -10.089, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 3, 217.471, -15.0823, -10.099, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 4, 224.972, -9.45057, -9.00677, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 5, 221.899, -0.588189, -8.10582, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 6, 213.671, 10.7383, -7.46839, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 7, 205.142, 17.4866, -7.59846, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 8, 195.271, 22.66, -8.72581, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 9, 186.278, 14.6512, -10.1065, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7945800, 10, 204.97, -15.045, -10.101, 0, 0, 0, 0, 100, 0);

-- Protean Horrors near first boss
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(79478, 79479, 79480);
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=79485;
REPLACE creature_addon VALUES(79485, 7948500, 0, 0, 4096, 0, '');
DELETE FROM creature_formations WHERE leaderGUID IN(79485, 79478, 79479, 79480) OR memberGUID IN(79485, 79478, 79479, 79480);
INSERT INTO creature_formations VALUES (79485, 79485, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (79485, 79478, 3, 140, 3, 0, 0);
INSERT INTO creature_formations VALUES (79485, 79479, 3, 220, 3, 0, 0);
INSERT INTO creature_formations VALUES (79485, 79480, 3, 180, 4, 0, 0);
DELETE FROM waypoint_data WHERE id=79485*100;
INSERT INTO waypoint_data VALUES (7948500, 1, 238.949, -159.686, -10.1059, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 2, 237.804, -167.725, -10.1059, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 3, 235.821, -181.654, -10.1087, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 4, 239.31, -186.301, -10.107, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 5, 247.464, -195.761, -10.1064, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 6, 257.96, -196.05, -10.1064, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 7, 266.969, -185.333, -10.1064, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 8, 275.212, -175.528, -10.1064, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 9, 274.423, -157.236, -10.1103, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 10, 278.598, -138.883, -10.1209, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 11, 263.713, -129.68, -10.1225, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 12, 243.985, -122.82, -10.1225, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 13, 223.963, -127.594, -10.1181, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7948500, 14, 227.708, -143.468, -10.1134, 0, 0, 0, 0, 100, 0);

-- Ethereums Before last boss
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(79566, 79567, 79568);
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid=79569;
REPLACE creature_addon VALUES(79569, 7956900, 0, 0, 4097, 0, '');
DELETE FROM creature_formations WHERE leaderGUID IN(79569, 79566, 79567, 79568) OR memberGUID IN(79569, 79566, 79567, 79568);
INSERT INTO creature_formations VALUES (79569, 79569, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (79569, 79566, 3, 140, 3, 0, 0);
INSERT INTO creature_formations VALUES (79569, 79567, 3, 220, 3, 0, 0);
INSERT INTO creature_formations VALUES (79569, 79568, 3, 180, 4, 0, 0);
DELETE FROM waypoint_data WHERE id=79569*100;
INSERT INTO waypoint_data VALUES (7956900, 1, 442.154, 44.9552, 50.0684, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 2, 432.991, 42.9212, 49.1086, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 3, 426.314, 38.8788, 48.2006, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 4, 428.019, 27.3846, 48.224, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 5, 438.451, 16.4478, 48.2118, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 6, 448.698, 5.18606, 48.219, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 7, 458.915, 2.47699, 48.2209, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 8, 462.54, 4.21776, 48.2, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 9, 467.248, 12.2498, 49.2816, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 10, 465.174, 23.4286, 50.3315, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (7956900, 11, 458.997, 38.0154, 50.845, 0, 0, 0, 0, 100, 0);









-- -------------------------------------------
--                MISC
-- -------------------------------------------




-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Seed of Corruption (36123, 39367)
DELETE FROM spelldifficulty_dbc WHERE id IN(36123, 39367) OR spellid0 IN(36123, 39367) OR spellid1 IN(36123, 39367) OR spellid2 IN(36123, 39367) OR spellid3 IN(36123, 39367);
INSERT INTO spelldifficulty_dbc VALUES (36123, 36123, 39367, 0, 0);

-- Shadow Nova (36127, 39005)
DELETE FROM spelldifficulty_dbc WHERE id IN(36127, 39005) OR spellid0 IN(36127, 39005) OR spellid1 IN(36127, 39005) OR spellid2 IN(36127, 39005) OR spellid3 IN(36127, 39005);
INSERT INTO spelldifficulty_dbc VALUES (36127, 36127, 39005, 0, 0);

-- Fel Immolation (36051, 39007)
DELETE FROM spelldifficulty_dbc WHERE id IN(36051, 39007) OR spellid0 IN(36051, 39007) OR spellid1 IN(36051, 39007) OR spellid2 IN(36051, 39007) OR spellid3 IN(36051, 39007);
INSERT INTO spelldifficulty_dbc VALUES (36051, 36051, 39007, 0, 0);

-- Felfire Shock (35759, 39006)
DELETE FROM spelldifficulty_dbc WHERE id IN(35759, 39006) OR spellid0 IN(35759, 39006) OR spellid1 IN(35759, 39006) OR spellid2 IN(35759, 39006) OR spellid3 IN(35759, 39006);
INSERT INTO spelldifficulty_dbc VALUES (35759, 35759, 39006, 0, 0);

-- Gift of the Doomsayer (36173, 39009)
DELETE FROM spelldifficulty_dbc WHERE id IN(36173, 39009) OR spellid0 IN(36173, 39009) OR spellid1 IN(36173, 39009) OR spellid2 IN(36173, 39009) OR spellid3 IN(36173, 39009);
INSERT INTO spelldifficulty_dbc VALUES (36173, 36173, 39009, 0, 0);

-- Heal (36144, 39013)
DELETE FROM spelldifficulty_dbc WHERE id IN(36144, 39013) OR spellid0 IN(36144, 39013) OR spellid1 IN(36144, 39013) OR spellid2 IN(36144, 39013) OR spellid3 IN(36144, 39013);
INSERT INTO spelldifficulty_dbc VALUES (36144, 36144, 39013, 0, 0);

-- Mind Rend (36924, 39017)
DELETE FROM spelldifficulty_dbc WHERE id IN(36924, 39017) OR spellid0 IN(36924, 39017) OR spellid1 IN(36924, 39017) OR spellid2 IN(36924, 39017) OR spellid3 IN(36924, 39017);
INSERT INTO spelldifficulty_dbc VALUES (36924, 36924, 39017, 0, 0);

-- Domination (37162, 39019)
DELETE FROM spelldifficulty_dbc WHERE id IN(37162, 39019) OR spellid0 IN(37162, 39019) OR spellid1 IN(37162, 39019) OR spellid2 IN(37162, 39019) OR spellid3 IN(37162, 39019);
INSERT INTO spelldifficulty_dbc VALUES (37162, 37162, 39019, 0, 0);

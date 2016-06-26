
UPDATE creature SET spawntimesecs=86400 WHERE map=329 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=329 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Skeletal Guardian (10390)
UPDATE creature SET spawndist=8, MovementType=1 WHERE guid IN(53097, 53242, 53192, 53241, 53191, 53098) AND id IN(10390, 10391);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10390;
DELETE FROM smart_scripts WHERE entryorguid=10390 AND source_type=0;
INSERT INTO smart_scripts VALUES (10390, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 31, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - On Update - Set Event Phase');
INSERT INTO smart_scripts VALUES (10390, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - On Update - Disable Event Phase Reset');
INSERT INTO smart_scripts VALUES (10390, 0, 2, 0, 1, 1, 100, 0, 1000, 5000, 600000, 600000, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - Out of Combat - Cast Demon Armor');
INSERT INTO smart_scripts VALUES (10390, 0, 3, 0, 0, 1, 100, 0, 0, 1000, 3000, 4500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10390, 0, 4, 0, 0, 2, 100, 0, 5000, 11000, 17000, 24500, 11, 8364, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (10390, 0, 5, 0, 0, 2, 100, 0, 0, 1000, 3000, 4500, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast Frost Bolt');
INSERT INTO smart_scripts VALUES (10390, 0, 6, 0, 0, 4, 100, 0, 4000, 11000, 13000, 24500, 11, 11975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (10390, 0, 7, 0, 0, 4, 100, 0, 0, 1000, 2000, 3500, 11, 37361, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Guardian - In Combat - Cast Arcane Bolt');

-- Skeletal Berserker (10391)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10391;
DELETE FROM smart_scripts WHERE entryorguid=10391 AND source_type=0;
INSERT INTO smart_scripts VALUES (10391, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 6000, 10000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Berserker - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10391, 0, 1, 0, 0, 0, 100, 0, 4000, 11000, 10000, 20000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Berserker - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (10391, 0, 2, 0, 0, 0, 100, 0, 1000, 6000, 9000, 18000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Berserker - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10391, 0, 3, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Berserker - Victim Casting - Cast Pummel');
INSERT INTO smart_scripts VALUES (10391, 0, 4, 0, 1, 0, 100, 257, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Berserker - On Reset - Cast Dual Wield');

-- Ravaged Cadaver (10381)
DELETE FROM creature_text WHERE entry=10381;
INSERT INTO creature_text VALUES (10381, 0, 0, '%s collapses but the broken body rises again!', 16, 0, 100, 0, 0, 0, 0, 'Ravaged Cadaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10381;
DELETE FROM smart_scripts WHERE entryorguid=10381 AND source_type=0;
INSERT INTO smart_scripts VALUES (10381, 0, 0, 0, 0, 0, 100, 0, 1000, 8000, 5000, 9000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Cadaver - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10381, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Cadaver - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (10381, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16324, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ravaged Cadaver - On Death - Cast Summon Broken Cadaver');

-- Broken Cadaver (10383)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=10383);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=10383);
DELETE FROM creature WHERE id=10383;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10383;
DELETE FROM smart_scripts WHERE entryorguid=10383 AND source_type=0;
INSERT INTO smart_scripts VALUES (10383, 0, 0, 0, 60, 0, 100, 1, 5000, 5000, 0, 0, 11, 16141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Broken Cadaver - On Update - Cast Exploding Cadaver');

-- Mangled Cadaver (10382)
DELETE FROM creature_text WHERE entry=10382;
INSERT INTO creature_text VALUES (10382, 0, 0, '%s collapses but the broken body rises again!', 16, 0, 100, 0, 0, 0, 0, 'Mangled Cadaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10382;
DELETE FROM smart_scripts WHERE entryorguid=10382 AND source_type=0;
INSERT INTO smart_scripts VALUES (10382, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16142, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mangled Cadaver - On Reset - Cast Cadaver Worms');
INSERT INTO smart_scripts VALUES (10382, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mangled Cadaver - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (10382, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16324, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mangled Cadaver - On Death - Cast Summon Broken Cadaver');

-- Spectral Citizen (10384)
DELETE FROM creature_text WHERE entry=10384;
INSERT INTO creature_text VALUES (10384, 0, 0, '%s returns the rude gesture to $N', 16, 0, 100, 14, 0, 0, 0, 'Spectral Citizen');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10384;
DELETE FROM smart_scripts WHERE entryorguid=10384 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(10384*100+0, 10384*100+1, 10384*100+2, 10384*100+3, 10384*100+4, 10384*100+5) AND source_type=9;
INSERT INTO smart_scripts VALUES (10384, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Reset - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384, 0, 1, 2, 22, 1, 100, 0, 17, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Bow - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 3, 4, 22, 1, 100, 0, 34, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Dance - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 5, 6, 22, 1, 100, 0, 58, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Kiss - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 7, 8, 22, 1, 100, 0, 101, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Wave - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 9, 10, 22, 1, 100, 0, 77, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Rude - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 11, 12, 22, 1, 100, 0, 77, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received Rude - Store Target');
INSERT INTO smart_scripts VALUES (10384, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10384*100+5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10384, 0, 13, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384, 0, 14, 0, 0, 0, 100, 0, 7000, 14000, 30000, 40000, 11, 16336, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - In Combat - Cast Haunting Phantoms');
INSERT INTO smart_scripts VALUES (10384, 0, 15, 0, 0, 0, 100, 0, 4000, 19000, 19000, 31000, 11, 16333, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - In Combat - Cast Debilitating Touch');
INSERT INTO smart_scripts VALUES (10384, 0, 16, 17, 8, 0, 100, 257, 17372, 0, 0, 0, 11, 17408, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Spell Hit - Cast Summon Freed Soul');
INSERT INTO smart_scripts VALUES (10384, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (10384, 0, 18, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16331, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - On Reset - Cast Incorporeal Defense');
INSERT INTO smart_scripts VALUES (10384*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+0, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Play Emote Bow');
INSERT INTO smart_scripts VALUES (10384*100+0, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 147, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Stop Motion');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 94, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Play Emote Dance');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+1, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Play Emote None');
INSERT INTO smart_scripts VALUES (10384*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+2, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Play Emote Shy');
INSERT INTO smart_scripts VALUES (10384*100+2, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+3, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Play Emote Wave');
INSERT INTO smart_scripts VALUES (10384*100+3, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+4, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (10384*100+4, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10384*100+5, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 6754, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Cast Slap!');
INSERT INTO smart_scripts VALUES (10384*100+5, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Citizen - Script9 - Set Event Phase');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=10384;
INSERT INTO conditions VALUES(22, 10, 10384, 0, 0, 35, 1, 0, 5, 3, 0, 0, 0, '', 'Run action if distance to invoker >= 5');
INSERT INTO conditions VALUES(22, 12, 10384, 0, 0, 35, 1, 0, 5, 3, 1, 0, 0, '', 'Run action if distance to invoker not >= 5');

-- Ghostly Citizen (10385)
DELETE FROM creature_text WHERE entry=10385;
INSERT INTO creature_text VALUES (10385, 0, 0, '%s returns the rude gesture to $N', 16, 0, 100, 14, 0, 0, 0, 'Ghostly Citizen');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10385;
DELETE FROM smart_scripts WHERE entryorguid=10385 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(10385*100+0, 10385*100+1, 10385*100+2, 10385*100+3, 10385*100+4, 10385*100+5) AND source_type=9;
INSERT INTO smart_scripts VALUES (10385, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Reset - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385, 0, 1, 2, 22, 1, 100, 0, 17, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Bow - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 3, 4, 22, 1, 100, 0, 34, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Dance - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 5, 6, 22, 1, 100, 0, 58, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Kiss - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 7, 8, 22, 1, 100, 0, 101, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Wave - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 9, 10, 22, 1, 100, 0, 77, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Rude - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 11, 12, 22, 1, 100, 0, 77, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received Rude - Store Target');
INSERT INTO smart_scripts VALUES (10385, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 10385*100+5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Emote Received - Run Script');
INSERT INTO smart_scripts VALUES (10385, 0, 13, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385, 0, 14, 0, 0, 0, 100, 0, 7000, 14000, 30000, 40000, 11, 16336, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - In Combat - Cast Haunting Phantoms');
INSERT INTO smart_scripts VALUES (10385, 0, 15, 0, 0, 0, 100, 0, 4000, 19000, 19000, 31000, 11, 7068, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - In Combat - Cast Veil of Shadow');
INSERT INTO smart_scripts VALUES (10385, 0, 16, 17, 8, 0, 100, 257, 17372, 0, 0, 0, 11, 17408, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Spell Hit - Cast Summon Freed Soul');
INSERT INTO smart_scripts VALUES (10385, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (10385, 0, 18, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16331, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - On Reset - Cast Incorporeal Defense');
INSERT INTO smart_scripts VALUES (10385*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+0, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Play Emote Bow');
INSERT INTO smart_scripts VALUES (10385*100+0, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 147, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Stop Motion');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 94, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Play Emote Dance');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+1, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Play Emote None');
INSERT INTO smart_scripts VALUES (10385*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+2, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Play Emote Shy');
INSERT INTO smart_scripts VALUES (10385*100+2, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+3, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Play Emote Wave');
INSERT INTO smart_scripts VALUES (10385*100+3, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+4, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (10385*100+4, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (10385*100+5, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 6754, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Cast Slap!');
INSERT INTO smart_scripts VALUES (10385*100+5, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostly Citizen - Script9 - Set Event Phase');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=10385;
INSERT INTO conditions VALUES(22, 10, 10385, 0, 0, 35, 1, 0, 5, 3, 0, 0, 0, '', 'Run action if distance to invoker >= 5');
INSERT INTO conditions VALUES(22, 12, 10385, 0, 0, 35, 1, 0, 5, 3, 1, 0, 0, '', 'Run action if distance to invoker not >= 5');

-- SPELL Egan's Blaster (17368)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=17368;
INSERT INTO conditions VALUES(17, 0, 17368, 0, 0, 31, 1, 3, 10384, 0, 0, 0, 0, '', 'Require Spectral Citizen');
INSERT INTO conditions VALUES(17, 0, 17368, 0, 1, 31, 1, 3, 10385, 0, 0, 0, 0, '', 'Require Ghostly Citizen');
INSERT INTO conditions VALUES(17, 0, 17368, 0, 2, 31, 1, 3, 11122, 0, 0, 0, 0, '', 'Require Restless Soul');

-- SPELL Egan's Blaster Effect (17372)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=17372;

-- Restless Soul (11122)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11122);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11122);
DELETE FROM creature WHERE id=11122;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11122;
DELETE FROM smart_scripts WHERE entryorguid=11122 AND source_type=0;
INSERT INTO smart_scripts VALUES (11122, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 89, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Update - Move Random');
INSERT INTO smart_scripts VALUES (11122, 0, 1, 2, 8, 0, 100, 257, 17372, 0, 0, 0, 11, 17370, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Cast Soul Freed');
INSERT INTO smart_scripts VALUES (11122, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 36, 11136, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Update Entry');
INSERT INTO smart_scripts VALUES (11122, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 29, 3, 180, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Follow');
INSERT INTO smart_scripts VALUES (11122, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (11122, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (11122, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 11122, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Restless Soul - On Spell Hit - Kill Credit');

-- Freed Soul (11136)
DELETE FROM creature_text WHERE entry=11136;
INSERT INTO creature_text VALUES (11136, 0, 0, 'Thank you, $N. My torment is now at an end.', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
INSERT INTO creature_text VALUES (11136, 0, 1, 'FREE!!!', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
INSERT INTO creature_text VALUES (11136, 0, 2, 'The curse ends!', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
INSERT INTO creature_text VALUES (11136, 0, 3, 'Praise be to Egan!', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
INSERT INTO creature_text VALUES (11136, 0, 4, 'May Kel''Thuzad one day feel our vengeance.', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
INSERT INTO creature_text VALUES (11136, 0, 5, 'Rivendare must be destroyed!', 12, 0, 100, 0, 0, 0, 0, 'Freed Soul');
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11136);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11136);
DELETE FROM creature WHERE id=11136;

-- Plague Ghoul (10405)
DELETE FROM creature_text WHERE entry=10405;
INSERT INTO creature_text VALUES (10405, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Plague Ghoul');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10405;
DELETE FROM smart_scripts WHERE entryorguid=10405 AND source_type=0;
INSERT INTO smart_scripts VALUES (10405, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 20000, 30000, 11, 16458, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Ghoul - In Combat - Cast Ghoul Plague');
INSERT INTO smart_scripts VALUES (10405, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 8000, 13000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plague Ghoul - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10405, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Ghoul - Between Health 0-30% - Say Line 0');
INSERT INTO smart_scripts VALUES (10405, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plague Ghoul - Between Health 0-30% - Cast Enrage');

-- Stratholme Courier (11082)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11082;
DELETE FROM smart_scripts WHERE entryorguid=11082 AND source_type=0;
INSERT INTO smart_scripts VALUES (11082, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16331, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stratholme Courier - On Reset - Cast Incorporeal Defense');
INSERT INTO smart_scripts VALUES (11082, 0, 1, 0, 13, 0, 100, 0, 8000, 10000, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stratholme Courier - Victim Casting - Cast Pummel');
INSERT INTO smart_scripts VALUES (11082, 0, 2, 0, 0, 0, 100, 0, 3000, 8000, 11000, 17000, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stratholme Courier - In Combat - Cast Snap Kick');

-- Patchwork Horror (10414)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10414;
DELETE FROM smart_scripts WHERE entryorguid=10414 AND source_type=0;
INSERT INTO smart_scripts VALUES (10414, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16345, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patchwork Horror - On Reset - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES (10414, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3417, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Patchwork Horror - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (10414, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 12000, 20000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Patchwork Horror - In Combat - Cast Knock Away');

-- Crimson Conjuror (10419)
DELETE FROM creature_text WHERE entry=10419;
INSERT INTO creature_text VALUES (10419, 0, 0, 'Move to the stairs and defend!', 14, 7, 100, 0, 0, 0, 0, 'Crimson Conjuror');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10419;
DELETE FROM smart_scripts WHERE entryorguid IN(10419, -54079) AND source_type=0;
INSERT INTO smart_scripts VALUES (10419, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (10419, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 12000, 25800, 11, 12674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (10419, 0, 2, 0, 0, 0, 100, 0, 0, 12000, 40000, 60000, 11, 17162, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Summon Water Elemental');
INSERT INTO smart_scripts VALUES (10419, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54079, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (-54079, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 12000, 25800, 11, 12674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (-54079, 0, 2, 0, 0, 0, 100, 0, 0, 12000, 40000, 60000, 11, 17162, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - In Combat - Cast Summon Water Elemental');
INSERT INTO smart_scripts VALUES (-54079, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54079, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (-54079, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Conjuror - On Death - Call For Help');

-- Summoned Water Elemental (10955)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10955;
DELETE FROM smart_scripts WHERE entryorguid=10955 AND source_type=0;
INSERT INTO smart_scripts VALUES (10955, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Summoned Water Elemental - Out of Combat - Attack Start');

-- Crimson Guardsman (10418)
DELETE FROM creature_text WHERE entry=10418;
INSERT INTO creature_text VALUES (10418, 0, 0, 'Move back and hold the line!  We cannot fail or all will be lost!', 14, 7, 100, 0, 0, 0, 0, 'Crimson Guardsman');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10418;
DELETE FROM smart_scripts WHERE entryorguid IN(10418, -54069) AND source_type=0;
INSERT INTO smart_scripts VALUES (10418, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 15749, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Within Range 8-25yd - Cast Shield Charge');
INSERT INTO smart_scripts VALUES (10418, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 12000, 25800, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (10418, 0, 2, 0, 13, 0, 100, 0, 10000, 12000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (10418, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54069, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 15749, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Within Range 8-25yd - Cast Shield Charge');
INSERT INTO smart_scripts VALUES (-54069, 0, 1, 0, 0, 0, 100, 0, 4000, 15000, 12000, 25800, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (-54069, 0, 2, 0, 13, 0, 100, 0, 10000, 12000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (-54069, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54069, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (-54069, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Guardsman - On Death - Call For Help');

-- Crimson Gallant (10424)
DELETE FROM creature_text WHERE entry=10424;
INSERT INTO creature_text VALUES (10424, 0, 0, 'They have broken into the Hall of Lights!  We must stop the intruders!', 14, 7, 100, 0, 0, 0, 0, 'Crimson Gallant');
INSERT INTO creature_text VALUES (10424, 1, 0, 'The Scourge have broken through in all wings!  May the light defeat these foul creatures!  We shall fight to the last!', 14, 7, 100, 0, 0, 0, 0, 'Crimson Gallant');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10424;
DELETE FROM smart_scripts WHERE entryorguid IN(10424, -54219, -54204) AND source_type=0;
INSERT INTO smart_scripts VALUES (10424, 0, 0, 0, 1, 0, 100, 1, 0, 5000, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Out of Combat - Cast Retribution Aura');
INSERT INTO smart_scripts VALUES (10424, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 13800, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (10424, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 12000, 18000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (10424, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54219, 0, 0, 0, 1, 0, 100, 1, 0, 5000, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Out of Combat - Cast Retribution Aura');
INSERT INTO smart_scripts VALUES (-54219, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 13800, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (-54219, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 12000, 18000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (-54219, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54219, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (-54219, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - On Death - Call For Help');
INSERT INTO smart_scripts VALUES (-54204, 0, 0, 0, 1, 0, 100, 1, 0, 5000, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Out of Combat - Cast Retribution Aura');
INSERT INTO smart_scripts VALUES (-54204, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 13800, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (-54204, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 12000, 18000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (-54204, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-54204, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (-54204, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Gallant - On Death - Call For Help');

-- Crimson Initiate (10420)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10420;
DELETE FROM smart_scripts WHERE entryorguid=10420 AND source_type=0;
INSERT INTO smart_scripts VALUES (10420, 0, 0, 0, 14, 0, 100, 0, 3000, 30, 3000, 4000, 11, 17138, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crimson Initiate - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (10420, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 13800, 11, 17194, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Initiate - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (10420, 0, 2, 0, 14, 0, 100, 0, 2000, 30, 9000, 9000, 11, 8362, 32, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crimson Initiate - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (10420, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Initiate - Between 0-15% Health - Flee For Assist');

-- Crimson Inquisitor (10426)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10426;
DELETE FROM smart_scripts WHERE entryorguid=10426 AND source_type=0;
INSERT INTO smart_scripts VALUES (10426, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 8000, 11000, 11, 15785, 0, 0, 0, 0, 0, 5, 20, 0, 1, 0, 0, 0, 0, 'Crimson Inquisitor - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (10426, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 5000, 8000, 11, 17165, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Inquisitor - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (10426, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 15000, 21000, 11, 17146, 32, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Crimson Inquisitor - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (10426, 0, 3, 0, 1, 0, 100, 0, 2000, 7000, 300000, 300000, 11, 17151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Inquisitor - Out of Combat - Cast Shadow Barrier');
INSERT INTO smart_scripts VALUES (10426, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Inquisitor - Between 0-15% Health - Flee For Assist');

-- Crimson Monk (11043)
DELETE FROM creature_text WHERE entry=11043;
INSERT INTO creature_text VALUES (11043, 0, 0, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Crimson Monk');
INSERT INTO creature_text VALUES (11043, 0, 1, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Crimson Monk');
INSERT INTO creature_text VALUES (11043, 0, 2, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Crimson Monk');
INSERT INTO creature_text VALUES (11043, 0, 3, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Crimson Monk');
INSERT INTO creature_text VALUES (11043, 1, 0, 'This will not be the end of the Scarlet Crusade! You will not break our line!', 14, 7, 100, 0, 0, 0, 0, 'Crimson Monk');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11043;
DELETE FROM smart_scripts WHERE entryorguid IN(11043, -52144) AND source_type=0;
INSERT INTO smart_scripts VALUES (11043, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 674, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (11043, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (11043, 0, 2, 0, 13, 0, 100, 0, 8000, 13000, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Victim Casting - Cast Kick');
INSERT INTO smart_scripts VALUES (11043, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (11043, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (-52144, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 674, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (-52144, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (-52144, 0, 2, 0, 13, 0, 100, 0, 8000, 13000, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Victim Casting - Cast Kick');
INSERT INTO smart_scripts VALUES (-52144, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (-52144, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (-52144, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Monk - On Death - Say Line 1');

-- Crimson Sorcerer (10422)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10422;
DELETE FROM smart_scripts WHERE entryorguid=10422 AND source_type=0;
INSERT INTO smart_scripts VALUES (10422, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 31, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - On Update - Set Event Phase');
INSERT INTO smart_scripts VALUES (10422, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - On Update - Disable Event Phase Reset');
INSERT INTO smart_scripts VALUES (10422, 0, 2, 0, 1, 1, 100, 0, 1000, 5000, 600000, 600000, 11, 17150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - Out of Combat - Cast Arcane Might');
INSERT INTO smart_scripts VALUES (10422, 0, 3, 0, 0, 1, 100, 0, 0, 1000, 3000, 4500, 11, 15230, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - In Combat - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (10422, 0, 4, 0, 0, 1, 100, 0, 4000, 11000, 15000, 24500, 11, 13323, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES (10422, 0, 5, 0, 1, 2, 100, 0, 0, 5000, 600000, 600000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (10422, 0, 6, 0, 0, 2, 100, 0, 0, 1000, 3000, 4500, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - In Combat - Cast Frost Bolt');
INSERT INTO smart_scripts VALUES (10422, 0, 7, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Sorcerer - Between 0-15% Health - Flee For Assist');

-- Crimson Battle Mage (10425)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10425;
DELETE FROM smart_scripts WHERE entryorguid=10425 AND source_type=0;
INSERT INTO smart_scripts VALUES (10425, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 8000, 11000, 11, 15253, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Battle Mage - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (10425, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 11000, 15000, 11, 17145, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Battle Mage - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (10425, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 11000, 15000, 11, 15732, 32, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Crimson Battle Mage - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (10425, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Battle Mage - Between 0-15% Health - Flee For Assist');

-- Crimson Defender (10421)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10421;
DELETE FROM smart_scripts WHERE entryorguid=10421 AND source_type=0;
INSERT INTO smart_scripts VALUES (10421, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 120000, 120000, 11, 8258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Defender - In Combat - Cast Devotion Aura');
INSERT INTO smart_scripts VALUES (10421, 0, 1, 0, 14, 0, 100, 0, 3000, 30, 10000, 12000, 11, 15493, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crimson Defender - Friendly Missing Health - Cast Holy Light');
INSERT INTO smart_scripts VALUES (10421, 0, 2, 0, 0, 0, 100, 0, 1000, 12000, 18000, 24000, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Defender - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (10421, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 13874, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Defender - Between 0-30% Health - Cast Divine Shield');
INSERT INTO smart_scripts VALUES (10421, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Defender - Between 0-15% Health - Flee For Assist');

-- Crimson Priest (10423)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10423;
DELETE FROM smart_scripts WHERE entryorguid=10423 AND source_type=0;
INSERT INTO smart_scripts VALUES (10423, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 5000, 11, 15238, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Priest - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (10423, 0, 1, 0, 14, 0, 100, 0, 2000, 30, 7000, 8000, 11, 15586, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crimson Priest - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (10423, 0, 2, 0, 0, 0, 100, 0, 1000, 12000, 18000, 24000, 11, 17142, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Priest - In Combat - Cast Holy Fire');
INSERT INTO smart_scripts VALUES (10423, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 17139, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Priest - Between 0-30% Health - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (10423, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Priest - Between 0-15% Health - Flee For Assist');

-- Wailing Banshee (10464)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10464;
DELETE FROM smart_scripts WHERE entryorguid=10464 AND source_type=0;
INSERT INTO smart_scripts VALUES (10464, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 30000, 30000, 11, 19645, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wailing Banshee - In Combat - Cast Anti-Magic Shield');
INSERT INTO smart_scripts VALUES (10464, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 18000, 24000, 11, 17105, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Wailing Banshee - In Combat - Cast Banshee Curse');

-- Crypt Beast (10413)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10413;
DELETE FROM smart_scripts WHERE entryorguid=10413 AND source_type=0;
INSERT INTO smart_scripts VALUES (10413, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16428, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crypt Beast - On Reset - Cast Virulent Poison Proc');
INSERT INTO smart_scripts VALUES (10413, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 18000, 24000, 11, 4962, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Crypt Beast - In Combat - Cast Encasing Webs');

-- Crypt Crawler (10412)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10412;
DELETE FROM smart_scripts WHERE entryorguid=10412 AND source_type=0;
INSERT INTO smart_scripts VALUES (10412, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 18000, 24000, 11, 15471, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 0, 'Crypt Crawler - In Combat - Cast Enveloping Web');

-- Rockwing Gargoyle (10408)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10408;
DELETE FROM smart_scripts WHERE entryorguid=10408 AND source_type=0;
INSERT INTO smart_scripts VALUES (10408, 0, 0, 0, 0, 0, 100, 0, 1000, 12000, 18000, 24000, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rockwing Gargoyle - In Combat - Cast Sunder Armor');

-- Fleshflayer Ghoul (10407)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10407;
DELETE FROM smart_scripts WHERE entryorguid=10407 AND source_type=0;
INSERT INTO smart_scripts VALUES (10407, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fleshflayer Ghoul - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (10407, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 15000, 20000, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fleshflayer Ghoul - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (10407, 0, 2, 0, 1, 0, 100, 0, 3000, 7000, 8000, 12000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fleshflayer Ghoul - Out of Combat - Play Emote 1');

-- Ghoul Ravener (10406)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10406;
DELETE FROM smart_scripts WHERE entryorguid=10406 AND source_type=0;
INSERT INTO smart_scripts VALUES (10406, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 5000, 7000, 11, 16172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Ravener - In Combat - Cast Head Crack');
INSERT INTO smart_scripts VALUES (10406, 0, 1, 0, 0, 0, 100, 0, 7000, 7000, 8000, 8000, 11, 16553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Ravener - In Combat - Cast Ravenous Claw');
INSERT INTO smart_scripts VALUES (10406, 0, 2, 0, 1, 0, 100, 0, 3000, 6000, 8000, 12000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Ravener - Out of Combat - Play Emote 1');

-- Shrieking Banshee (10463)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10463;
DELETE FROM smart_scripts WHERE entryorguid=10463 AND source_type=0;
INSERT INTO smart_scripts VALUES (10463, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2200, 3200, 11, 16868, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shrieking Banshee - In Combat - Cast Banshee Wail');
INSERT INTO smart_scripts VALUES (10463, 0, 1, 0, 0, 0, 100, 0, 3000, 14000, 18000, 24000, 11, 3589, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shrieking Banshee - In Combat - Cast Deafening Screech');

-- Thuzadin Necromancer (10400)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10400;
DELETE FROM smart_scripts WHERE entryorguid=10400 AND source_type=0;
INSERT INTO smart_scripts VALUES (10400, 0, 0, 0, 1, 0, 100, 1, 6000, 6000, 0, 0, 11, 12420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Necromancer - Out of Combat - Cast Summon Skeletal Servant');
INSERT INTO smart_scripts VALUES (10400, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 60000, 60000, 11, 16431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Necromancer - In Combat - Cast Bone Armor');
INSERT INTO smart_scripts VALUES (10400, 0, 2, 0, 0, 0, 100, 0, 3000, 14000, 22000, 34000, 11, 16430, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Thuzadin Necromancer - In Combat - Cast Soul Tap');

-- Thuzadin Shadowcaster (10398)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10398;
DELETE FROM smart_scripts WHERE entryorguid=10398 AND source_type=0;
INSERT INTO smart_scripts VALUES (10398, 0, 0, 0, 1, 0, 100, 0, 6000, 6000, 0, 0, 11, 12380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Shadowcaster - Out of Combat - Cast Shadow Channeling');
INSERT INTO smart_scripts VALUES (10398, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10398, 0, 2, 0, 0, 0, 100, 0, 3000, 14000, 22000, 34000, 11, 11443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Shadowcaster - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (10398, 0, 3, 0, 0, 0, 100, 0, 3000, 14000, 22000, 34000, 11, 16429, 32, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Thuzadin Shadowcaster - In Combat - Cast Piercing Shadow');

-- Skeletal Servant (8477)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=8477);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8477);
DELETE FROM creature WHERE id=8477;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=8477;
DELETE FROM smart_scripts WHERE entryorguid=8477 AND source_type=0;

-- Venom Belcher (10417)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10417;
DELETE FROM smart_scripts WHERE entryorguid=10417 AND source_type=0;
INSERT INTO smart_scripts VALUES (10417, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Venom Belcher - On Reset - Cast Slowing Poison');
INSERT INTO smart_scripts VALUES (10417, 0, 1, 0, 0, 0, 100, 0, 3000, 11000, 12000, 19500, 11, 16866, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venom Belcher - In Combat - Cast Venom Pit');

-- Bile Spewer (10416)
DELETE FROM creature_text WHERE entry=10416;
INSERT INTO creature_text VALUES (10416, 0, 0, '%s bleches out a disgusting Bile Slime!', 16, 0, 100, 0, 0, 0, 0, 'Bile Spewer');
INSERT INTO creature_text VALUES (10416, 1, 0, '%s explodes and releases several Bile Slimes!', 16, 0, 100, 0, 0, 0, 0, 'Bile Spewer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10416;
DELETE FROM smart_scripts WHERE entryorguid=10416 AND source_type=0;
INSERT INTO smart_scripts VALUES (10416, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8876, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (10416, 0, 1, 2, 0, 0, 100, 0, 7000, 18000, 30000, 40000, 11, 16809, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - In Combat - Cast Spawn Bile Slime');
INSERT INTO smart_scripts VALUES (10416, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - In Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (10416, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 16865, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - On Death - Cast Spawn Bile Slimes');
INSERT INTO smart_scripts VALUES (10416, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - On Death - Say Line 1');

-- Bile Slime (10697)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10697;
DELETE FROM smart_scripts WHERE entryorguid=10697 AND source_type=0;
INSERT INTO smart_scripts VALUES (10697, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Bile Slime - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (10697, 0, 1, 0, 1, 0, 100, 1, 20000, 20000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bile Slime - Out of Combat - Despawn');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Hearthsinger Forresten (10558)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10558;
DELETE FROM smart_scripts WHERE entryorguid=10558 AND source_type=0;
INSERT INTO smart_scripts VALUES (10558, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16331, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hearthsinger Forresten - On Reset - Cast Incorporeal Defense');
INSERT INTO smart_scripts VALUES (10558, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hearthsinger Forresten - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (10558, 0, 2, 0, 0, 0, 100, 0, 3000, 8000, 11000, 17000, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hearthsinger Forresten - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES (10558, 0, 3, 0, 0, 0, 100, 0, 6000, 14000, 17000, 25000, 11, 16244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hearthsinger Forresten - In Combat - Cast Demoralizing Shout');
INSERT INTO smart_scripts VALUES (10558, 0, 4, 0, 0, 0, 100, 0, 3000, 13000, 16000, 22000, 11, 16798, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Hearthsinger Forresten - In Combat - Cast Enchanting Lullaby');

-- Skul (10393)
DELETE FROM creature WHERE id=10393;
INSERT INTO creature VALUES (247225, 10393, 329, 1, 1, 0, 0, 3481.68, -3318.06, 130.78, 0, 86400, 0, 0, 13065, 10922, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10393;
DELETE FROM smart_scripts WHERE entryorguid=10393 AND source_type=0;
INSERT INTO smart_scripts VALUES (10393, 0, 0, 0, 37, 0, 80, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skul - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (10393, 0, 1, 0, 1, 0, 100, 0, 1000, 7000, 600000, 600000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skul - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (10393, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 16799, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skul - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (10393, 0, 3, 0, 0, 0, 100, 0, 4000, 9000, 10000, 17500, 11, 15499, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skul - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (10393, 0, 4, 0, 0, 0, 100, 0, 10000, 20000, 20000, 40000, 11, 8364, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Skul - In Combat - Cast Blizzard');

-- Stonespine (10809)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10809;
DELETE FROM smart_scripts WHERE entryorguid=10809 AND source_type=0;
INSERT INTO smart_scripts VALUES (10809, 0, 0, 0, 37, 0, 50, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stonespine - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (10809, 0, 1, 0, 0, 0, 100, 0, 3000, 9000, 12000, 19000, 11, 14331, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Stonespine - In Combat - Cast Vicious Rend');

-- The Unforgiven (10516)
DELETE FROM creature WHERE id=10516;
INSERT INTO creature VALUES (247226, 10516, 329, 1, 1, 0, 0, 3706.78, -3412.97, 132.05, 2.08, 86400, 0, 0, 11136, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10516;
DELETE FROM smart_scripts WHERE entryorguid=10516 AND source_type=0;
INSERT INTO smart_scripts VALUES (10516, 0, 0, 0, 37, 0, 80, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Unforgiven - On AI Init - Set Invisible');
INSERT INTO smart_scripts VALUES (10516, 0, 1, 2, 4, 0, 100, 257, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Unforgiven - On Aggro - Set Visible');
INSERT INTO smart_scripts VALUES (10516, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 12, 10387, 8, 0, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 'The Unforgiven - On Aggro - Summon Creature');
INSERT INTO smart_scripts VALUES (10516, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 12, 10387, 8, 0, 0, 0, 0, 1, 0, 0, 0, -3, 0, 0, 0, 'The Unforgiven - On Aggro - Summon Creature');
INSERT INTO smart_scripts VALUES (10516, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 10387, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, -3, 0, 0, 'The Unforgiven - On Aggro - Summon Creature');
INSERT INTO smart_scripts VALUES (10516, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 10387, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3, 0, 0, 'The Unforgiven - On Aggro - Summon Creature');
INSERT INTO smart_scripts VALUES (10516, 0, 6, 0, 0, 0, 100, 0, 4000, 9000, 8000, 15000, 11, 14907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Unforgiven - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (10516, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16331, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Unforgiven - On Reset - Cast Incorporeal Defense');

-- Vengeful Phantom (10387)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10387;
DELETE FROM smart_scripts WHERE entryorguid=10387 AND source_type=0;
INSERT INTO smart_scripts VALUES (10387, 0, 0, 0, 0, 0, 100, 0, 3000, 12000, 11000, 17000, 11, 15089, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vengeful Phantom - In Combat - Cast Frost Shock');

-- Timmy the Cruel (10808)
DELETE FROM creature_text WHERE entry=10808;
INSERT INTO creature_text VALUES (10808, 0, 0, 'TIMMY!', 14, 0, 100, 0, 0, 0, 0, 'Timmy the Cruel');
DELETE FROM creature WHERE id=10808;
INSERT INTO creature VALUES (247227, 10808, 329, 1, 1, 0, 0, 3651.62, -3190.08, 126.96, 0.0, 300, 0, 0, 22968, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10808;
DELETE FROM smart_scripts WHERE entryorguid=10808 AND source_type=0;
INSERT INTO smart_scripts VALUES (10808, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 9000, 14000, 11, 17470, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - In Combat - Cast Ravenous Claw');
INSERT INTO smart_scripts VALUES (10808, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - Between Health 0-30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (10808, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (10808, 0, 3, 4, 25, 0, 100, 257, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Reset - Set Invisible');
INSERT INTO smart_scripts VALUES (10808, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Reset - Set Faction');
INSERT INTO smart_scripts VALUES (10808, 0, 5, 6, 60, 0, 100, 257, 5000, 5000, 5000, 5000, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Update - Set Visible');
INSERT INTO smart_scripts VALUES (10808, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Update - Set Faction');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=10808;
INSERT INTO conditions VALUES(22, 6, 10808, 0, 0, 29, 1, 10418, 40, 0, 1, 0, 0, '', 'Run action if no npcs in range');
INSERT INTO conditions VALUES(22, 6, 10808, 0, 0, 29, 1, 10424, 40, 0, 1, 0, 0, '', 'Run action if no npcs in range');
INSERT INTO conditions VALUES(22, 6, 10808, 0, 0, 29, 1, 10419, 40, 0, 1, 0, 0, '', 'Run action if no npcs in range');

-- Malor the Zealous (11032)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11032;
DELETE FROM smart_scripts WHERE entryorguid=11032 AND source_type=0;
INSERT INTO smart_scripts VALUES (11032, 0, 0, 0, 0, 0, 100, 0, 3000, 12000, 11000, 17000, 11, 12734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malor the Zealous - In Combat - Cast Ground Smash');
INSERT INTO smart_scripts VALUES (11032, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 22000, 37000, 11, 16172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Malor the Zealous - In Combat - Cast Head Crack');
INSERT INTO smart_scripts VALUES (11032, 0, 2, 0, 2, 0, 100, 0, 0, 70, 10000, 10000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malor the Zealous - Between Health 0-50% - Cast Holy Light');
INSERT INTO smart_scripts VALUES (11032, 0, 3, 0, 2, 0, 100, 1, 0, 10, 0, 0, 11, 10310, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malor the Zealous - Between Health 0-10% - Cast Lay on Hands');

-- Cannon Master Willey (10997)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10997;
DELETE FROM smart_scripts WHERE entryorguid=10997 AND source_type=0;
INSERT INTO smart_scripts VALUES (10997, 0, 0, 0, 0, 0, 100, 0, 3000, 12000, 11000, 17000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (10997, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 12000, 18000, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - In Combat - Cast Pummel');
INSERT INTO smart_scripts VALUES (10997, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 20000, 20000, 11, 17279, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - In Combat - Cast Summon Crimson Rifleman');
INSERT INTO smart_scripts VALUES (10997, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 11, 17279, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - On Death - Cast Summon Crimson Rifleman');
INSERT INTO smart_scripts VALUES (10997, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17279, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - On Death - Cast Summon Crimson Rifleman');
INSERT INTO smart_scripts VALUES (10997, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17279, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cannon Master Willey - On Death - Cast Summon Crimson Rifleman');
INSERT INTO smart_scripts VALUES (10997, 0, 6, 0, 21, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 15, 176215, 50, 0, 0, 0, 0, 0, 'Cannon Master Willey - On Reached Home - Respawn Target');

-- SPELL Summon Crimson Rifleman (17279)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=17279;
INSERT INTO conditions VALUES(13, 1, 17279, 0, 0, 31, 0, 3, 14646, 0, 0, 0, 0, '', 'Target Stratholme Trigger');

-- Stratholme Trigger (14646)
DELETE FROM creature WHERE id=14646;
INSERT INTO creature VALUES (52146, 14646, 329, 1, 1, 11686, 0, 3492.34, -3065.4, 135.646, 4.72984, 86400, 0, 0, 57, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247228, 14646, 329, 1, 1, 11686, 0, 3532.44, -2966.68, 125.1, 0, 86400, 0, 0, 57, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=14646;

-- Crimson Rifleman (11054)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11054;
DELETE FROM smart_scripts WHERE entryorguid=11054 AND source_type=0;
INSERT INTO smart_scripts VALUES (11054, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 17353, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Crimson Rifleman - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (11054, 0, 1, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Crimson Rifleman - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (11054, 0, 2, 0, 1, 0, 100, 1, 20000, 20000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Rifleman - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (11054, 0, 3, 0, 8, 0, 100, 0, 17278, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crimson Rifleman - On Spell Hit - Die');

-- GO Cannonball (176211)
DELETE FROM gameobject WHERE id=176211;

-- GO Scarlet Cannon (176216)
-- GO Scarlet Cannon (176217)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(176216, 176217);
DELETE FROM smart_scripts WHERE entryorguid IN(176216, 176217) AND source_type=1;
INSERT INTO smart_scripts VALUES (176216, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176216, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Send Gameobject Custom Anim');
INSERT INTO smart_scripts VALUES (176216, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Store Target');
INSERT INTO smart_scripts VALUES (176216, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 86, 17278, 2, 12, 1, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Timed Event - Cast Cannon Fire');
INSERT INTO smart_scripts VALUES (176217, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 500, 500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176217, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Send Gameobject Custom Anim');
INSERT INTO smart_scripts VALUES (176217, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Gossip Hello - Store Target');
INSERT INTO smart_scripts VALUES (176217, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 86, 17278, 2, 12, 1, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Scarlet Cannon - On Timed Event - Cast Cannon Fire');

-- SPELL Cannon Fire (17278)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=17278;
INSERT INTO conditions VALUES (13, 1, 17278, 0, 0, 31, 0, 3, 11054, 0, 0, 0, 0, '', 'Target Crimson Rifleman');
DELETE FROM spell_target_position WHERE id=17278;
INSERT INTO spell_target_position VALUES (17278, 0, 329, 3534.3, -2966.74, 125.001, 0.279253);

-- Archivist Galford (10811)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10811;
DELETE FROM smart_scripts WHERE entryorguid=10811 AND source_type=0;
INSERT INTO smart_scripts VALUES (10811, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 15000, 20000, 11, 17293, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Archivist Galford - In Combat - Cast Burning Winds');
INSERT INTO smart_scripts VALUES (10811, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 12000, 11, 17366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Archivist Galford - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (10811, 0, 2, 0, 0, 0, 100, 0, 5000, 15000, 15000, 25000, 11, 17274, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Archivist Galford - In Combat - Cast Pyroblast');

-- Grand Crusader Dathrohan (10812)
UPDATE creature_template SET unit_class=2 WHERE entry=10813;
DELETE FROM creature_text WHERE entry IN(10812, 10813);
INSERT INTO creature_text VALUES (10812, 0, 0, 'Today you have unmade what took me years to create! For this you shall all die by my hand!', 14, 0, 100, 0, 0, 0, 0, 'Grand Crusader Dathrohan');
INSERT INTO creature_text VALUES (10813, 1, 0, 'You fools think you can defeat me so easily? Face the true might of the Nathrezim!', 14, 0, 100, 0, 0, 0, 0, 'Grand Crusader Dathrohan');
INSERT INTO creature_text VALUES (10813, 2, 0, 'Damn you mortals! All my plans of revenge, all my hate...I will be avenged...', 12, 0, 100, 0, 0, 0, 0, 'Grand Crusader Dathrohan');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10812;
DELETE FROM smart_scripts WHERE entryorguid=10812 AND source_type=0;
INSERT INTO smart_scripts VALUES (10812, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (10812, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (10812, 0, 2, 0, 0, 1, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (10812, 0, 3, 0, 0, 1, 100, 0, 7000, 15000, 15000, 23000, 11, 17286, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Crusader''s Hammer');
INSERT INTO smart_scripts VALUES (10812, 0, 4, 0, 0, 1, 100, 0, 2000, 7000, 10000, 20000, 11, 17284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (10812, 0, 5, 6, 2, 1, 100, 1, 0, 40, 0, 0, 11, 17288, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - Between 0-40% Health - Cast Balnazzar Transform');
INSERT INTO smart_scripts VALUES (10812, 0, 6, 0, 61, 0, 100, 0, 0, 40, 0, 0, 67, 1, 1500, 1500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - Between 0-40% Health - Create Timed Event');
INSERT INTO smart_scripts VALUES (10812, 0, 7, 8, 59, 1, 100, 0, 1, 0, 0, 0, 36, 10813, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Timed Event - Update Entry');
INSERT INTO smart_scripts VALUES (10812, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Timed Event - Set Event Phase');
INSERT INTO smart_scripts VALUES (10812, 0, 9, 0, 0, 2, 100, 1, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (10812, 0, 10, 0, 0, 2, 100, 0, 2000, 7000, 10000, 20000, 11, 17399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (10812, 0, 11, 0, 0, 2, 100, 0, 9000, 11000, 10000, 15000, 11, 17287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (10812, 0, 12, 0, 0, 2, 100, 0, 14000, 14000, 20000, 25000, 11, 13704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES (10812, 0, 13, 0, 0, 2, 100, 0, 11000, 11000, 20000, 25000, 11, 12098, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Sleep');
INSERT INTO smart_scripts VALUES (10812, 0, 14, 0, 0, 2, 100, 0, 20000, 20000, 20000, 25000, 11, 15690, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - In Combat - Cast Mind Control');
INSERT INTO smart_scripts VALUES (10812, 0, 15, 16, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Death - Say Line 2');
INSERT INTO smart_scripts VALUES (10812, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - On Death - Summon Creature Group');
INSERT INTO smart_scripts VALUES (10812, 0, 17, 0, 1, 0, 100, 1, 0, 0, 0, 0, 36, 10812, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Crusader Dathrohan - Out of Combat - Update Entry');
DELETE FROM creature_summon_groups WHERE summonerId=10813;
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3452.98, -3081.97, 135.003, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3455.45, -3075.42, 135.003, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3461.92, -3078.1, 135.003, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3460.88, -3071.18, 135.003, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3467.8, -3070.84, 135.003, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3491.83, -3084.56, 134.998, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3486.02, -3084.36, 134.998, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3493.92, -3077.44, 134.998, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3502.07, -3076.63, 134.998, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3497.39, -3073.18, 134.998, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3551.78, -3068.75, 134.997, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3559.72, -3066.74, 134.997, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3557.01, -3071.87, 134.997, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3551.59, -3074.17, 134.997, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3562.87, -3062.38, 134.997, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3607.56, -3104.59, 134.123, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3602.96, -3109.86, 134.123, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3598.81, -3102.8, 134.121, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3607.83, -3100.25, 134.121, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3618.24, -3099.54, 134.121, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3648.91, -3102.72, 134.116, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3643.22, -3106.79, 134.116, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3651.39, -3106.24, 134.116, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10391, 3653.96, -3099.73, 134.116, 0, 8, 0);
INSERT INTO creature_summon_groups VALUES (10813, 0, 1, 10390, 3658.92, -3093.21, 134.116, 0, 8, 0);

-- Magistrate Barthilas (10435)
DELETE FROM creature_text WHERE entry=10435;
INSERT INTO creature_text VALUES (10435, 0, 0, 'Intruders at the Service Gate! Lord Rivendare must be warned!', 14, 0, 100, 0, 0, 0, 0, 'Magistrate Barthilas');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10435;
DELETE FROM smart_scripts WHERE entryorguid=10435 AND source_type=0;
INSERT INTO smart_scripts VALUES (10435, 0, 0, 0, 38, 0, 100, 257, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (10435, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 16792, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Reset - Cast Furious Anger');
INSERT INTO smart_scripts VALUES (10435, 0, 2, 0, 0, 0, 100, 0, 6000, 10000, 12000, 21000, 11, 10887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Crowd Pummel');
INSERT INTO smart_scripts VALUES (10435, 0, 3, 0, 0, 0, 100, 0, 11000, 12000, 15000, 15000, 11, 14099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Might Blow');
INSERT INTO smart_scripts VALUES (10435, 0, 4, 0, 0, 0, 100, 0, 4000, 4000, 12000, 15000, 11, 16793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Drain Blow');
INSERT INTO smart_scripts VALUES (10435, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Death - Cast Transformation');
INSERT INTO smart_scripts VALUES (10435, 0, 6, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On AI Init - Cast Transformation');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=10435;
INSERT INTO conditions VALUES(22, 7, 10435, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Run action if npc is dead');

-- Nerub'enkan (10437)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10437;
DELETE FROM smart_scripts WHERE entryorguid=10437 AND source_type=0;
INSERT INTO smart_scripts VALUES (10437, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 12000, 21000, 11, 4962, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Nerub''enkan - In Combat - Cast Encasing Webs');
INSERT INTO smart_scripts VALUES (10437, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 15000, 15000, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerub''enkan - In Combat - Cast Pierce Armor');
INSERT INTO smart_scripts VALUES (10437, 0, 2, 0, 0, 0, 100, 0, 4000, 4000, 12000, 15000, 11, 31602, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nerub''enkan - In Combat - Cast Crypt Scarabs');
INSERT INTO smart_scripts VALUES (10437, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 17235, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''enkan - In Combat - Cast Raide Undead Scarab');
INSERT INTO smart_scripts VALUES (10437, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 2, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nerub''enkan - On Death - Set Instance Data 2 to 1');

-- Baroness Anastari (10436)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10436;
DELETE FROM smart_scripts WHERE entryorguid=10436 AND source_type=0;
INSERT INTO smart_scripts VALUES (10436, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 3500, 11, 16868, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baroness Anastari - In Combat - Cast Banshee Wail');
INSERT INTO smart_scripts VALUES (10436, 0, 1, 0, 0, 0, 100, 0, 10000, 30000, 120000, 120000, 11, 17244, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Baroness Anastari - In Combat - Cast Possess');
INSERT INTO smart_scripts VALUES (10436, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 20000, 21000, 11, 18327, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baroness Anastari - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (10436, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 16867, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baroness Anastari - In Combat - Cast Banshee Curse');
INSERT INTO smart_scripts VALUES (10436, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baroness Anastari - On Death - Set Instance Data 1 to 1');

-- Maleki the Pallid (10438)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10438;
DELETE FROM smart_scripts WHERE entryorguid=10438 AND source_type=0;
INSERT INTO smart_scripts VALUES (10438, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2900, 3700, 11, 17503, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maleki the Pallid - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (10438, 0, 1, 0, 0, 0, 100, 0, 10000, 20000, 20000, 30000, 11, 16869, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Maleki the Pallid - In Combat - Cast Ice Tomb');
INSERT INTO smart_scripts VALUES (10438, 0, 2, 0, 0, 0, 100, 0, 5000, 11000, 20000, 21000, 11, 17238, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Maleki the Pallid - In Combat - Cast Drain Life');
INSERT INTO smart_scripts VALUES (10438, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 16867, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maleki the Pallid - In Combat - Cast Banshee Curse');
INSERT INTO smart_scripts VALUES (10438, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 3, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maleki the Pallid - On Death - Set Instance Data 3 to 1');

-- Undead Scarab (10876)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10876;
DELETE FROM smart_scripts WHERE entryorguid=10876 AND source_type=0;
INSERT INTO smart_scripts VALUES (10876, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 13299, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Undead Scarab - On Reset - Cast Poison Proc');
INSERT INTO smart_scripts VALUES (10876, 0, 1, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Undead Scarab - Out of Combat - Attack Start');

-- Thuzadin Acolyte (10399)
DELETE FROM creature_text WHERE entry=10399;
INSERT INTO creature_text VALUES (10399, 0, 0, 'An Ash''ari Crystal has been toppled! Restore the ziggurat before the Slaughterhouse is vulnerable!', 14, 0, 100, 0, 0, 0, 3, 'Thuzadin Acolyte');
INSERT INTO creature_text VALUES (10399, 0, 1, 'An Ash''ari Crystal has fallen! Stay true to the Lich King, my brethren, and attempt to resummon it.', 14, 0, 100, 0, 0, 0, 3, 'Thuzadin Acolyte');
INSERT INTO creature_text VALUES (10399, 0, 2, 'One of the Ash''ari Crystals has been destroyed! Slay the intruders!', 14, 0, 100, 0, 0, 0, 3, 'Thuzadin Acolyte');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10399;
DELETE FROM smart_scripts WHERE entryorguid=10399 AND source_type=0;
INSERT INTO smart_scripts VALUES (10399, 0, 0, 0, 1, 0, 100, 1, 8000, 8000, 0, 0, 11, 30742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - Out of Combat - Cast Shadow Channeling');
INSERT INTO smart_scripts VALUES (10399, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 3000, 4500, 11, 11660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10399, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - On Death - Say Line');
INSERT INTO smart_scripts VALUES (10399, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 10415, 200, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - On Death - Set Data');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=10399;
INSERT INTO conditions VALUES(22, 3, 10399, 0, 0, 29, 1, 10399, 50, 0, 1, 0, 0, '', 'Run action if no npcs in range');

-- Ash'ari Crystal (10415)
UPDATE creature_template SET unit_flags=33554432|2|4|256|512, AIName='SmartAI', ScriptName='' WHERE entry=10415;
DELETE FROM smart_scripts WHERE entryorguid IN(10415, -53955, -53963, -53968) AND source_type=0;
INSERT INTO smart_scripts VALUES (-53955, 0, 0, 1, 38, 0, 100, 257, 2, 2, 0, 0, 34, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ash''ari Crystal - On Data Set - Set Instance Data 1 to 2');
INSERT INTO smart_scripts VALUES (-53955, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - On Data Set - Die');
INSERT INTO smart_scripts VALUES (-53963, 0, 0, 1, 38, 0, 100, 257, 2, 2, 0, 0, 34, 3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ash''ari Crystal - On Data Set - Set Instance Data 3 to 2');
INSERT INTO smart_scripts VALUES (-53963, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - On Data Set - Die');
INSERT INTO smart_scripts VALUES (-53968, 0, 0, 1, 38, 0, 100, 257, 2, 2, 0, 0, 34, 2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ash''ari Crystal - On Data Set - Set Instance Data 2 to 2');
INSERT INTO smart_scripts VALUES (-53968, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - On Data Set - Die');

-- Ramstein the Gorger (10439)
DELETE FROM creature_text WHERE entry=10439;
INSERT INTO creature_text VALUES (10439, 0, 0, 'Ramstein hunger for flesh!', 14, 0, 100, 0, 0, 0, 3, 'Ramstein the Gorger');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10439;
DELETE FROM smart_scripts WHERE entryorguid=10439 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=10439*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (10439, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 80, 10439*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - On Reset - Run Script');
INSERT INTO smart_scripts VALUES (10439, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 15088, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - On Reset - Cast Flurry');
INSERT INTO smart_scripts VALUES (10439, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 10000, 15000, 11, 17307, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - In Combat - Cast Knockout');
INSERT INTO smart_scripts VALUES (10439, 0, 3, 0, 0, 0, 100, 0, 10000, 12000, 12000, 12000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (10439*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4032.63, -3399.67, 115.58, 4.67, 'Ramstein the Gorger - Script9 - Set Home Position');
INSERT INTO smart_scripts VALUES (10439*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Set Unit Flags');
INSERT INTO smart_scripts VALUES (10439*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 175405, 100, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Set Gameobject State');
INSERT INTO smart_scripts VALUES (10439*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4032.63, -3399.67, 115.58, 0, 'Ramstein the Gorger - Script9 - Move To Position');
INSERT INTO smart_scripts VALUES (10439*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Say Line 0');
INSERT INTO smart_scripts VALUES (10439*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 175405, 100, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Set Gameobject State');
INSERT INTO smart_scripts VALUES (10439*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (10439*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 70, 0, 0, 0, 0, 0, 0, 'Ramstein the Gorger - Script9 - Attack Start');

-- Mindless Undead (11030)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11030;
DELETE FROM smart_scripts WHERE entryorguid=11030 AND source_type=0;
INSERT INTO smart_scripts VALUES (11030, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 3000, 49, 0, 0, 0, 0, 0, 0, 21, 150, 0, 0, 0, 0, 0, 0, 'Mindless Undead - Out of Combat - Attack Start');

-- Black Guard Sentry (10394)
DELETE FROM creature_text WHERE entry=10394;
INSERT INTO creature_text VALUES (10394, 0, 0, 'Who dares disturb our master?', 14, 0, 100, 0, 0, 0, 3, 'Black Guard Sentry');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10394;
DELETE FROM smart_scripts WHERE entryorguid=10394 AND source_type=0;
INSERT INTO smart_scripts VALUES (10394, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 7000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Black Guard Sentry - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10394, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 10000, 12000, 11, 17439, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Black Guard Sentry - In Combat - Cast Shadow Shock');

-- Baron Rivendare (10440)
DELETE FROM creature_text WHERE entry=10440;
INSERT INTO creature_text VALUES (10440, 0, 0, 'Intruders!  More pawns of the Argent Dawn, no doubt.  I already count one of their number among my prisoners.  Withdraw from my domain before she is executed!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 1, 0, 'The Ash''ari Crystals have been destroyed! The Slaughterhouse is vulnerable!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 2, 0, 'You''re still here? Your foolishness is amusing! The Argent Dawn wench needn''t suffer in vain. Leave at once and she shall be spared!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 3, 0, 'I shall take great pleasure in taking this poor wretch''s life! It''s not too late, she needn''t suffer in vain. Turn back and her death shall be merciful!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 4, 0, 'May this prisoner''s death serve as a warning. None shall defy the Scourge and live!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 5, 0, 'So you see fit to toy with the Lich King''s creations? Ramstein, be sure to give the intruders a proper greeting.', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 6, 0, 'Time to take matters into my own hands. Come. Enter my domain and challenge the might of the Scourge!', 14, 0, 100, 0, 0, 0, 3, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 7, 0, '%s raises an undead servant back to life!', 16, 0, 100, 0, 0, 0, 0, 'Baron Rivendare');
INSERT INTO creature_text VALUES (10440, 8, 0, '%s attempts to cast Death Pact on the servants!', 16, 0, 100, 0, 0, 0, 0, 'Baron Rivendare');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10440;
DELETE FROM smart_scripts WHERE entryorguid=10440 AND source_type=0;
INSERT INTO smart_scripts VALUES (10440, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 7000, 11000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10440, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 9000, 11, 17393, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10440, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 9000, 15000, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (10440, 0, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 11, 17467, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Unholy Aura');
INSERT INTO smart_scripts VALUES (10440, 0, 4, 5, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 17473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Say Line 7');
INSERT INTO smart_scripts VALUES (10440, 0, 6, 0, 0, 0, 100, 0, 22000, 22000, 20000, 20000, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Say Line 8');
INSERT INTO smart_scripts VALUES (10440, 0, 7, 8, 0, 0, 100, 0, 11000, 11000, 20000, 20000, 11, 17475, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17476, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17477, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17478, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17479, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17480, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Rivendare - In Combat - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (10440, 0, 13, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 16031, 100, 0, 0, 0, 0, 0, 'Baron Rivendare - On Death - Set Data');

-- SPELL Raise Dead (17475)
-- SPELL Raise Dead (17476)
-- SPELL Raise Dead (17477)
-- SPELL Raise Dead (17478)
-- SPELL Raise Dead (17479)
-- SPELL Raise Dead (17480)
DELETE FROM spell_target_position WHERE id IN(17475, 17476, 17477, 17478, 17479, 17480);
INSERT INTO spell_target_position VALUES (17475, 0, 329, 4052.2, -3365.07, 116.184, 3.14);
INSERT INTO spell_target_position VALUES (17476, 0, 329, 4056.52, -3351.05, 116.674, 3.14);
INSERT INTO spell_target_position VALUES (17477, 0, 329, 4052.31, -3337.36, 116.416, 3.14);
INSERT INTO spell_target_position VALUES (17478, 0, 329, 4014.47, -3338.68, 116.123, 0.0);
INSERT INTO spell_target_position VALUES (17479, 0, 329, 4009.09, -3352.86, 116.683, 0.0);
INSERT INTO spell_target_position VALUES (17480, 0, 329, 4012.79, -3365.66, 116.294, 0.0);

-- SPELL Death Pact (17471)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=17471;
INSERT INTO conditions VALUES(13, 1, 17471, 0, 0, 31, 0, 3, 11197, 0, 0, 0, 0, '', 'Target Mindless Skeleton');

-- Mindless Skeleton (11197)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11197;
DELETE FROM smart_scripts WHERE entryorguid=11197 AND source_type=0;
INSERT INTO smart_scripts VALUES (11197, 0, 0, 0, 1, 0, 100, 0, 0, 0, 3000, 3000, 49, 0, 0, 0, 0, 0, 0, 21, 150, 0, 0, 0, 0, 0, 0, 'Mindless Skeleton - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (11197, 0, 1, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mindless Skeleton - Out of Combat - Despawn');
INSERT INTO smart_scripts VALUES (11197, 0, 2, 0, 8, 0, 100, 1, 17471, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mindless Skeleton - On Spell Hit - Die');

-- Ysida Harmon (16031)
DELETE FROM creature WHERE id=16031;
INSERT INTO creature VALUES (247229, 16031, 329, 1, 1, 0, 0, 4044.05, -3334.55, 115.54, 4.12, 86400, 0, 0, 6104, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=16031;
INSERT INTO creature_text VALUES (16031, 0, 0, 'Don''t worry about me! Slay this dreadful beast and cleanse this world of his foul taint!', 14, 0, 100, 0, 0, 0, 3, 'Ysida Harmon');
INSERT INTO creature_text VALUES (16031, 1, 0, 'You did it... you''ve slain Baron Rivendare! The Argent Dawn shall hear of your valiant deeds!', 12, 0, 100, 0, 0, 0, 3, 'Ysida Harmon');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=16031;
DELETE FROM smart_scripts WHERE entryorguid=16031 AND source_type=0;
INSERT INTO smart_scripts VALUES (16031, 0, 0, 0, 38, 0, 100, 257, 1, 1, 0, 0, 67, 1, 7000, 7000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES (16031, 0, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Timed Event - Say Line 0');
INSERT INTO smart_scripts VALUES (16031, 0, 2, 3, 38, 0, 100, 257, 2, 2, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 181071, 50, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Set Gameobject State');
INSERT INTO smart_scripts VALUES (16031, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4041.38, -3340.82, 115.06, 0, 'Ysida Harmon - On Data Set - Move To Position');
INSERT INTO smart_scripts VALUES (16031, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (16031, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 33, 16031, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Killed Monster Credit');
INSERT INTO smart_scripts VALUES (16031, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 15, 8945, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Area Explored Or Event Happens');
INSERT INTO smart_scripts VALUES (16031, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 41, 120000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (16031, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 176424, 200, 0, 0, 0, 0, 0, 'Ysida Harmon - On Data Set - Set Gameobject State');
INSERT INTO smart_scripts VALUES (16031, 0, 9, 0, 25, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ysida Harmon - On Reset - Set Walk');

-- GO Ysida's Cage (181071)
-- GO Ysida's Cagebase (181072)
DELETE FROM gameobject WHERE id IN(181071, 181072);
INSERT INTO gameobject VALUES (NULL, 181071, 329, 1, 1, 4044.34, -3334.22, 115.06, 2.74016, 0, 0, 0, 1, 180, 255, 1, 0);
INSERT INTO gameobject VALUES (NULL, 181072, 329, 1, 1, 4044.34, -3334.23, 115.06, 1.16937, 0, 0, 0, 1, 180, 100, 1, 0);


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Premium Siabi Tobacco (176248)
DELETE FROM event_scripts WHERE id=5225;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176248;
DELETE FROM smart_scripts WHERE entryorguid=176248 AND source_type=1;
INSERT INTO smart_scripts VALUES (176248, 1, 0, 0, 70, 0, 100, 257, 2, 0, 0, 0, 67, 1, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Premium Siabi Tobacco - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176248, 1, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11058, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 3487.05, -3289.75, 131.79, 4.69, 'Premium Siabi Tobacco - On Timed Event - Summon Creature');

-- Fras Siabi (11058)
DELETE FROM creature_text WHERE entry=11058;
INSERT INTO creature_text VALUES (11058, 0, 0, 'Looking for these???? You''ll never have em!', 12, 0, 100, 0, 0, 0, 0, 'Fras Siabi');
INSERT INTO creature_text VALUES (11058, 0, 1, 'I''m going to wear your skin as a smoking jacket! The stogies? You''ll have to pry them from my cold dead... er... RAWR!!!!', 12, 0, 100, 0, 0, 0, 0, 'Fras Siabi');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11058;
DELETE FROM smart_scripts WHERE entryorguid=11058 AND source_type=0;
INSERT INTO smart_scripts VALUES (11058, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (11058, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 9000, 9000, 11, 7964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi - In Combat - Cast Smoke Bomb');
INSERT INTO smart_scripts VALUES (11058, 0, 2, 0, 0, 0, 100, 0, 7000, 15000, 30000, 30000, 11, 17294, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi - In Combat - Cast Flame Breath');
INSERT INTO smart_scripts VALUES (11058, 0, 3, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Fras Siabi - Out of Combat - Attack Start');

-- GO Fras Siabi's Postbox (176353)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176353;
DELETE FROM smart_scripts WHERE entryorguid=176353 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176353*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176353, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176353*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi''s Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176353, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi''s Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176353, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3493, -3300.28, 130.47, 0.07, 'Fras Siabi''s Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176353*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fras Siabi''s Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176353*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3493, -3300.28, 130.47, 0.07, 'Fras Siabi''s Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176353*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'Fras Siabi''s Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176353*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3503.16, -3294.9, 131.09, 4.28, 'Fras Siabi''s Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176353*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3496.26, -3295.4, 130.98, 5.34, 'Fras Siabi''s Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176353;
INSERT INTO conditions VALUES(22, 3, 176353, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- GO Market Row Postbox (176346)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176346;
DELETE FROM smart_scripts WHERE entryorguid=176346 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176346*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176346, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176346*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Market Row Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176346, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Market Row Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176346, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3675.35, -3395.92, 132.86, 5.83, 'Market Row Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176346*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Market Row Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176346*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3675.35, -3395.92, 132.86, 5.83, 'Market Row Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176346*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'Market Row Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176346*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3679.93, -3408.58, 133.18, 1.04, 'Market Row Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176346*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3687.89, -3410.59, 133.04, 1.64, 'Market Row Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176346;
INSERT INTO conditions VALUES(22, 3, 176346, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- GO Elders' Square Postbox (176351)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176351;
DELETE FROM smart_scripts WHERE entryorguid=176351 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176351*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176351, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176351*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elders'' Square Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176351, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Elders'' Square Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176351, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3659.46, -3634.96, 138.33, 1.28, 'Elders'' Square Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176351*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Elders'' Square Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176351*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3659.46, -3634.96, 138.33, 1.28, 'Elders'' Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176351*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'Elders'' Square Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176351*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3656.25, -3635.08, 138.36, 1.02, 'Elders'' Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176351*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3661.24, -3621, 138.4, 3.58, 'Elders'' Square Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176351;
INSERT INTO conditions VALUES(22, 3, 176351, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- GO Festival Lane Postbox (176350)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176350;
DELETE FROM smart_scripts WHERE entryorguid=176350 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176350*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176350, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176350*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Festival Lane Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176350, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Festival Lane Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176350, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3651.67, -3477.88, 138.05, 5.59, 'Festival Lane Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176350*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Festival Lane Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176350*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3651.67, -3477.88, 138.05, 5.59, 'Festival Lane Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176350*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'Festival Lane Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176350*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3657.14, -3475.36, 138.7, 4.91, 'Festival Lane Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176350*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3669.61, -3478.49, 137.49, 3.39, 'Festival Lane Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176350;
INSERT INTO conditions VALUES(22, 3, 176350, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- GO King's Square Postbox (176352)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176352;
DELETE FROM smart_scripts WHERE entryorguid=176352 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176352*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176352, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176352*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King''s Square Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176352, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'King''s Square Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176352, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3568.5, -3356.91, 131.06, 2.07, 'King''s Square Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176352*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'King''s Square Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176352*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3568.5, -3356.91, 131.06, 2.07, 'King''s Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176352*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'King''s Square Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176352*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3570.91, -3351.01, 130.57, 2.71, 'King''s Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176352*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3562.79, -3353.38, 130.78, 0.81, 'King''s Square Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176352;
INSERT INTO conditions VALUES(22, 3, 176352, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- GO Crusaders' Square Postbox (176349)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176349;
DELETE FROM smart_scripts WHERE entryorguid=176349 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=176349*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (176349, 1, 0, 1, 70, 0, 100, 257, 2, 0, 0, 0, 80, 176349*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusaders'' Square Postbox - On Gameobject State Changed - Run Script');
INSERT INTO smart_scripts VALUES (176349, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 8000, 8000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusaders'' Square Postbox - On Gameobject State Changed - Create Timed Event');
INSERT INTO smart_scripts VALUES (176349, 1, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 12, 11143, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3664.55, -3176.47, 126.42, 2.2, 'Crusaders'' Square Postbox - On Timed Event - Summon Mallow');
INSERT INTO smart_scripts VALUES (176349*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 34, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crusaders'' Square Postbox - On Script - Set Instance Data 5 to 0');
INSERT INTO smart_scripts VALUES (176349*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3664.55, -3176.47, 126.42, 2.2, 'Crusaders'' Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176349*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 19, 11142, 50, 0, 0, 0, 0, 0, 'Crusaders'' Square Postbox - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (176349*100, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3656.82, -3160.63, 129.03, 4.84, 'Crusaders'' Square Postbox - On Script - Summon Creature Undead Postman');
INSERT INTO smart_scripts VALUES (176349*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 11142, 1, 300000, 0, 1, 0, 8, 0, 0, 0, 3644.62, -3168.25, 128.52, 5.93, 'Crusaders'' Square Postbox - On Script - Summon Creature Undead Postman');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176349;
INSERT INTO conditions VALUES(22, 3, 176349, 1, 0, 13, 1, 5, 3, 0, 0, 0, 0, '', 'Run action if GetData(5) == 3');

-- Undead Postman (11142)
DELETE FROM creature_text WHERE entry=11142;
INSERT INTO creature_text VALUES (11142, 0, 0, 'No tampering with the mail!', 12, 0, 100, 0, 0, 0, 0, 'Undead Postman');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11142;
DELETE FROM smart_scripts WHERE entryorguid=11142 AND source_type=0;
INSERT INTO smart_scripts VALUES (11142, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Undead Postman - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (11142, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 20000, 30000, 11, 5137, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Undead Postman - In Combat - Cast Call of the Grave');
INSERT INTO smart_scripts VALUES (11142, 0, 2, 0, 0, 0, 100, 0, 2000, 9000, 11000, 19000, 11, 7713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Undead Postman - In Combat - Cast Wailing Dead');

-- Postmaster Malown (11143)
DELETE FROM creature_text WHERE entry=11143;
INSERT INTO creature_text VALUES (11143, 0, 0, 'Prepare to be Malowned!', 12, 0, 100, 0, 0, 0, 0, 'Postmaster Malown');
INSERT INTO creature_text VALUES (11143, 1, 0, 'You''ve been MALOWNED!', 12, 0, 100, 0, 0, 0, 0, 'Postmaster Malown');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11143;
DELETE FROM smart_scripts WHERE entryorguid=11143 AND source_type=0;
INSERT INTO smart_scripts VALUES (11143, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (11143, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (11143, 0, 2, 0, 5, 0, 100, 0, 5000, 5000, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (11143, 0, 3, 0, 0, 0, 100, 0, 0, 6000, 20000, 30000, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (11143, 0, 4, 0, 0, 0, 100, 0, 5000, 5000, 40000, 40000, 11, 13338, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - In Combat - Cast Curse of Tongues');
INSERT INTO smart_scripts VALUES (11143, 0, 5, 0, 0, 0, 100, 0, 25000, 25000, 40000, 40000, 11, 12741, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (11143, 0, 6, 0, 0, 0, 100, 0, 0, 6000, 10000, 15000, 11, 12542, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Postmaster Malown - In Combat - Cast Fear');

-- GO Supply Crate (176304)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176304;
DELETE FROM smart_scripts WHERE entryorguid=176304 AND source_type=1;
INSERT INTO smart_scripts VALUES (176304, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176304, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16369, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Cast Bugs');
INSERT INTO smart_scripts VALUES (176304, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (176304, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Timed Event - Set Loot State');

-- GO Supply Crate (176307)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176307;
DELETE FROM smart_scripts WHERE entryorguid=176307 AND source_type=1;
INSERT INTO smart_scripts VALUES (176307, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176307, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16370, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Cast Maggots');
INSERT INTO smart_scripts VALUES (176307, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (176307, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Timed Event - Set Loot State');

-- GO Supply Crate (176308)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176308;
DELETE FROM smart_scripts WHERE entryorguid=176308 AND source_type=1;
INSERT INTO smart_scripts VALUES (176308, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176308, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16371, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Cast Rats');
INSERT INTO smart_scripts VALUES (176308, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (176308, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Timed Event - Set Loot State');

-- GO Supply Crate (176309)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176309;
DELETE FROM smart_scripts WHERE entryorguid=176309 AND source_type=1;
INSERT INTO smart_scripts VALUES (176309, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES (176309, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16432, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Cast Plague Mist');
INSERT INTO smart_scripts VALUES (176309, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (176309, 1, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Supply Crate - On Timed Event - Set Loot State');

-- Plagued Insect (10461)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10461;
DELETE FROM smart_scripts WHERE entryorguid=10461 AND source_type=0;
INSERT INTO smart_scripts VALUES (10461, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Plagued Insect - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (10461, 0, 1, 0, 0, 0, 100, 0, 0, 9000, 10000, 30000, 11, 16460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plagued Insect - In Combat - Cast Festering Bite');

-- Plagued Maggot (10536)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10536;
DELETE FROM smart_scripts WHERE entryorguid=10536 AND source_type=0;
INSERT INTO smart_scripts VALUES (10536, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Plagued Maggot - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (10536, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 20000, 30000, 11, 16449, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plagued Maggot - In Combat - Cast Maggot Slime');

-- Plagued Rat (10441)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10441;
DELETE FROM smart_scripts WHERE entryorguid=10441 AND source_type=0;
INSERT INTO smart_scripts VALUES (10441, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Plagued Rat - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (10441, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 20000, 30000, 11, 16448, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plagued Rat - In Combat - Cast Black Rot');

-- GO Malor's Strongbox (5122)
UPDATE gameobject_template SET flags=16, data8=0, AIName='SmartGameObjectAI', ScriptName=''  WHERE entry=176112;
REPLACE INTO gameobject_loot_template VALUES (13580, 12845, 100, 1, 0, 1, 1);
DELETE FROM smart_scripts WHERE entryorguid=176112 AND source_type=1;
INSERT INTO smart_scripts VALUES (176112, 1, 0, 0, 60, 0, 100, 257, 0, 0, 5000, 5000, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malor''s Strongbox - On Update - Set Gameobject Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=176112;
INSERT INTO conditions VALUES(22, 1, 176112, 1, 0, 29, 1, 11032, 50, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- GO Scarlet Archive (176245)
UPDATE gameobject_template SET data3=60000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176245;
DELETE FROM smart_scripts WHERE entryorguid=176245 AND source_type=1;
INSERT INTO smart_scripts VALUES (176245, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3452.85, -3104.82, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (176245, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3454.96, -3106.90, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (176245, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3459.30, -3108.70, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (176245, 1, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3462.52, -3105.03, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (176245, 1, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3459.64, -3100.89, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject');

-- GO Service Entrance Gate (175368)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=175368;
DELETE FROM smart_scripts WHERE entryorguid=175368 AND source_type=1;
INSERT INTO smart_scripts VALUES (175368, 1, 0, 0, 64, 0, 100, 0, 1, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 10435, 100, 0, 0, 0, 0, 0, 'Service Entrance Gate - On Gossip Hello - Set Data');

-- GO Gauntlet Gate (175357)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=175357;
DELETE FROM smart_scripts WHERE entryorguid=175357 AND source_type=1;
INSERT INTO smart_scripts VALUES (175357, 1, 0, 0, 64, 0, 100, 257, 1, 0, 0, 0, 34, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gauntlet Gate - On Gossip Hello - Set Instance Data 0 to 1');

-- [PH] Invis Paladin Quest Credit  (17915)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=17915);
DELETE FROM creature WHERE id=17915;
DELETE FROM event_scripts WHERE id=11206;
INSERT INTO event_scripts VALUES (11206, 0, 10, 17915, 3000000, 1, 3678, -3639, 140, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50455, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50456, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50457, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50459, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50460, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50461, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50462, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50463, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50464, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50465, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50466, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50467, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50468, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50469, 1200, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50470, 900, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50471, 900, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES (11206, 1, 9, 50472, 900, 0, 0, 0, 0, 0);
UPDATE creature_template SET flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=17915;
DELETE FROM smart_scripts WHERE entryorguid=17915 AND source_type=0;
INSERT INTO smart_scripts VALUES (17915, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 19, 10917, 50, 0, 0, 0, 0, 0, 'Invis Paladin Quest Credit - On Update - Remove Bytes0');
INSERT INTO smart_scripts VALUES (17915, 0, 1, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 10917, 50, 0, 0, 0, 0, 0, 'Invis Paladin Quest Credit - On Update - Set Orientation');
INSERT INTO smart_scripts VALUES (17915, 0, 2, 0, 60, 0, 100, 257, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 10917, 50, 0, 0, 0, 0, 0, 'Invis Paladin Quest Credit - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (17915, 0, 3, 0, 60, 0, 100, 257, 5000, 5000, 0, 0, 2, 14, 0, 0, 0, 0, 0, 19, 10917, 50, 0, 0, 0, 0, 0, 'Invis Paladin Quest Credit - On Update - Set Faction');
INSERT INTO smart_scripts VALUES (17915, 0, 4, 0, 60, 0, 100, 257, 20000, 20000, 0, 0, 12, 17910, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3668.67, -3615.04, 137.77, 4.54, 'Invis Paladin Quest Credit - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (17915, 0, 5, 0, 60, 0, 100, 257, 25000, 25000, 0, 0, 12, 17914, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3664.94, -3614.78, 137.49, 5.08, 'Invis Paladin Quest Credit - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (17915, 0, 6, 0, 60, 0, 100, 257, 30000, 30000, 0, 0, 12, 17913, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3661.42, -3616.55, 137.46, 5.35, 'Invis Paladin Quest Credit - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (17915, 0, 7, 0, 60, 0, 100, 257, 35000, 35000, 0, 0, 12, 17912, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3657.86, -3618.3, 137.4, 5.7, 'Invis Paladin Quest Credit - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (17915, 0, 8, 0, 60, 0, 100, 257, 40000, 40000, 0, 0, 12, 17911, 8, 0, 0, 0, 0, 8, 0, 0, 0, 3657.63, -3621.24, 137.74, 5.97, 'Invis Paladin Quest Credit - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (17915, 0, 9, 0, 77, 0, 100, 257, 1, 5, 0, 0, 33, 17915, 0, 0, 0, 0, 0, 18, 150, 0, 0, 0, 0, 0, 0, 'Invis Paladin Quest Credit - On Counter Set - Kill Credit');

-- Aurius (10917)
DELETE FROM creature_text WHERE entry=10917;
INSERT INTO creature_text VALUES (10917, 0, 0, 'Fool! Do you know what you''ve done? This is sacred ground!', 12, 0, 100, 0, 0, 0, 0, 'Aurius');

-- Gregor the Justiciar <Order of the Silver Hand> (17910)
DELETE FROM creature_text WHERE entry=17910;
INSERT INTO creature_text VALUES (17910, 0, 0, 'Who dares disturb the sanctity of the Alonsus Chapel?', 14, 0, 100, 0, 0, 0, 3, 'Gregor the Justiciar');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17910;
DELETE FROM smart_scripts WHERE entryorguid=17910 AND source_type=0;
INSERT INTO smart_scripts VALUES (17910, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Gregor the Justiciar - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (17910, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 15000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gregor the Justiciar - In Combat - Cast Holy Light');
INSERT INTO smart_scripts VALUES (17910, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gregor the Justiciar - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (17910, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 17915, 150, 0, 0, 0, 0, 0, 'Gregor the Justiciar - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (17910, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gregor the Justiciar - On Reset - Say Line 0');

-- Cathela the Seeker <Order of the Silver Hand> (17911)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17911;
DELETE FROM smart_scripts WHERE entryorguid=17911 AND source_type=0;
INSERT INTO smart_scripts VALUES (17911, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Cathela the Seeker - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (17911, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 15000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cathela the Seeker - In Combat - Cast Holy Light');
INSERT INTO smart_scripts VALUES (17911, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cathela the Seeker - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (17911, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 17915, 150, 0, 0, 0, 0, 0, 'Cathela the Seeker - On Death - Set Counter');

-- Nemas the Arbiter <Order of the Silver Hand> (17912)
DELETE FROM creature_text WHERE entry=17912;
INSERT INTO creature_text VALUES (17912, 0, 0, 'There is no other way, blasphemer. Prepare to meet your fate.', 14, 0, 100, 0, 0, 0, 3, 'Nemas the Arbiter');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17912;
DELETE FROM smart_scripts WHERE entryorguid=17912 AND source_type=0;
INSERT INTO smart_scripts VALUES (17912, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Nemas the Arbiter - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (17912, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 15000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nemas the Arbiter - In Combat - Cast Holy Light');
INSERT INTO smart_scripts VALUES (17912, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nemas the Arbiter - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (17912, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 17915, 150, 0, 0, 0, 0, 0, 'Nemas the Arbiter - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (17912, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nemas the Arbiter - On Reset - Say Line 0');

-- Aelmar the Vanquisher  <Order of the Silver Hand> (17913)
DELETE FROM creature_text WHERE entry=17913;
INSERT INTO creature_text VALUES (17913, 0, 0, 'False paladin, show yourself! Prepare to taste the wrath of the Light''s true servants!', 14, 0, 100, 0, 0, 0, 3, 'Aelmar the Vanquisher');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17913;
DELETE FROM smart_scripts WHERE entryorguid=17913 AND source_type=0;
INSERT INTO smart_scripts VALUES (17913, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Aelmar the Vanquisher  - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (17913, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 15000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aelmar the Vanquisher  - In Combat - Cast Holy Light');
INSERT INTO smart_scripts VALUES (17913, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aelmar the Vanquisher  - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (17913, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 17915, 150, 0, 0, 0, 0, 0, 'Aelmar the Vanquisher  - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (17913, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aelmar the Vanquisher - On Reset - Say Line 0');

-- Vicar Hieronymus <Order of the Silver Hand> (17914)
DELETE FROM creature_text WHERE entry=17914;
INSERT INTO creature_text VALUES (17914, 0, 0, 'What you have done is abominable! Atone for your crimes against the Light!', 14, 0, 100, 0, 0, 0, 3, 'Vicar Hieronymus');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17914;
DELETE FROM smart_scripts WHERE entryorguid=17914 AND source_type=0;
INSERT INTO smart_scripts VALUES (17914, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Vicar Hieronymus - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (17914, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 15000, 15000, 11, 15493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vicar Hieronymus - In Combat - Cast Holy Light');
INSERT INTO smart_scripts VALUES (17914, 0, 2, 0, 0, 0, 100, 0, 2000, 7000, 10000, 20000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vicar Hieronymus - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (17914, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 17915, 150, 0, 0, 0, 0, 0, 'Vicar Hieronymus - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (17914, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vicar Hieronymus - On Reset - Say Line 0');


UPDATE creature SET spawntimesecs=86400 WHERE map=47 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=47 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Razorfen Handler (4530)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4530;
DELETE FROM smart_scripts WHERE entryorguid=4530 AND source_type=0;
INSERT INTO smart_scripts VALUES (4530, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Handler - Out of Combat - Cast Summon Tamed Battleboar');
INSERT INTO smart_scripts VALUES (4530, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Handler - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (4530, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Handler - Between 0-15% Health - Flee For Assist');

-- Tamed Battleboar (4535)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=4535);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=4535);
DELETE FROM creature WHERE id=4535;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4535;
DELETE FROM smart_scripts WHERE entryorguid=4535 AND source_type=0;

-- Razorfen Quilguard (4436)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4436;
DELETE FROM smart_scripts WHERE entryorguid=4436 AND source_type=0;
INSERT INTO smart_scripts VALUES (4436, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Quilguard - On Aggro - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (4436, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 12000, 20000, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Quilguard - In Combat - Cast Thunderclap');
INSERT INTO smart_scripts VALUES (4436, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Quilguard - Between 0-15% Health - Flee For Assist');

-- Razorfen Geomancer (4520)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4520;
DELETE FROM smart_scripts WHERE entryorguid=4520 AND source_type=0;
INSERT INTO smart_scripts VALUES (4520, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8270, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Geomancer - Out of Combat - Cast Summon Earth Rumbler');
INSERT INTO smart_scripts VALUES (4520, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 3000, 3500, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Geomancer - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (4520, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Geomancer - Between 0-15% Health - Flee For Assist');

-- Stone Rumbler (4528)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=4528);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=4528);
DELETE FROM creature WHERE id=4528;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4528;
DELETE FROM smart_scripts WHERE entryorguid=4528 AND source_type=0;

-- Razorfen Warrior (4435)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4435;
DELETE FROM smart_scripts WHERE entryorguid=4435 AND source_type=0;
INSERT INTO smart_scripts VALUES (4435, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 30000, 70000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Warrior - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (4435, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Warrior - Between 0-15% Health - Flee For Assist');

-- Razorfen Defender (4442)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4442;
DELETE FROM smart_scripts WHERE entryorguid=4442 AND source_type=0;
INSERT INTO smart_scripts VALUES (4442, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 120000, 120000, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Defender - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4442, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 12000, 20000, 11, 3248, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Defender - In Combat - Cast Improved Blocking');
INSERT INTO smart_scripts VALUES (4442, 0, 2, 0, 13, 0, 100, 0, 8000, 8000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Defender - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (4442, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Defender - Between 0-15% Health - Flee For Assist');

-- Death's Head Adept (4516)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4516;
DELETE FROM smart_scripts WHERE entryorguid=4516 AND source_type=0;
INSERT INTO smart_scripts VALUES (4516, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3000, 3500, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Adept - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (4516, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 14000, 21000, 11, 113, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Death''s Head Adept - In Combat - Cast Chains of Ice');
INSERT INTO smart_scripts VALUES (4516, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Adept - Between 0-15% Health - Flee For Assist');

-- Razorfen Groundshaker (4523)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4523;
DELETE FROM smart_scripts WHERE entryorguid=4523 AND source_type=0;
INSERT INTO smart_scripts VALUES (4523, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 12000, 11, 6524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Groundshaker - In Combat - Cast Ground Tremor');
INSERT INTO smart_scripts VALUES (4523, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 8000, 8000, 11, 8046, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Groundshaker - In Combat - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (4523, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Groundshaker - Between 0-15% Health - Flee For Assist');

-- Razorfen Earthbreaker (4525)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4525;
DELETE FROM smart_scripts WHERE entryorguid=4525 AND source_type=0;
INSERT INTO smart_scripts VALUES (4525, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 20000, 32000, 11, 8272, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Razorfen Earthbreaker - In Combat - Cast Mind Tremor');
INSERT INTO smart_scripts VALUES (4525, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 8000, 8000, 11, 8046, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Earthbreaker - In Combat - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (4525, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Earthbreaker - Between 0-15% Health - Flee For Assist');

-- Razorfen Dustweaver (4522)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4522;
DELETE FROM smart_scripts WHERE entryorguid=4522 AND source_type=0;
INSERT INTO smart_scripts VALUES (4522, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8271, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Dustweaver - Out of Combat - Cast Summon Wind Howler');
INSERT INTO smart_scripts VALUES (4522, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 15000, 25000, 11, 6728, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Razorfen Dustweaver - In Combat - Cast Enveloping Winds');
INSERT INTO smart_scripts VALUES (4522, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Dustweaver - Between 0-15% Health - Flee For Assist');

-- Wind Howler (4526)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=4526);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=4526);
DELETE FROM creature WHERE id=4526;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4526;
DELETE FROM smart_scripts WHERE entryorguid=4526 AND source_type=0;

-- Razorfen Beast Trainer (4531)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4531;
DELETE FROM smart_scripts WHERE entryorguid=4531 AND source_type=0;
INSERT INTO smart_scripts VALUES (4531, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beast Trainer - Out of Combat - Cast Summon Tamed Battleboar');
INSERT INTO smart_scripts VALUES (4531, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beast Trainer - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (4531, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 9000, 12000, 11, 6984, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Razorfen Beast Trainer - In Combat - Cast Frost Shot');
INSERT INTO smart_scripts VALUES (4531, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beast Trainer - Between 0-15% Health - Flee For Assist');

-- Razorfen Beastmaster (4532)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4532;
DELETE FROM smart_scripts WHERE entryorguid=4532 AND source_type=0;
INSERT INTO smart_scripts VALUES (4532, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8276, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beastmaster - Out of Combat - Cast Summon Tamed Hyena');
INSERT INTO smart_scripts VALUES (4532, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beastmaster - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (4532, 0, 2, 0, 0, 0, 100, 0, 4000, 6000, 12000, 21000, 11, 8275, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Razorfen Beastmaster - In Combat - Cast Poisoned Shot');
INSERT INTO smart_scripts VALUES (4532, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beastmaster - Between 0-15% Health - Flee For Assist');

-- Tamed Hyena (4534)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=4534);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=4534);
DELETE FROM creature WHERE id=4534;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4534;
DELETE FROM smart_scripts WHERE entryorguid=4534 AND source_type=0;

-- Death's Head Seer (4519)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4519;
DELETE FROM smart_scripts WHERE entryorguid=4519 AND source_type=0;
INSERT INTO smart_scripts VALUES (4519, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 4971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Seer - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (4519, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 8264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Seer - In Combat - Cast Lava Spout Totem');
INSERT INTO smart_scripts VALUES (4519, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Seer - Between 0-15% Health - Flee For Assist');

-- Quilguard Champion (4623)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4623;
DELETE FROM smart_scripts WHERE entryorguid=4623 AND source_type=0;
INSERT INTO smart_scripts VALUES (4623, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 120000, 120000, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4623, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 120000, 120000, 11, 8258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - In Combat - Cast Devotion Aura');
INSERT INTO smart_scripts VALUES (4623, 0, 2, 0, 0, 0, 100, 0, 6000, 6000, 10000, 15000, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - Victim Casting - Cast Sunder Armor');
INSERT INTO smart_scripts VALUES (4623, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - Between 0-15% Health - Flee For Assist');

-- Razorfen Totemic (4440)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4440;
DELETE FROM smart_scripts WHERE entryorguid=4440 AND source_type=0;
INSERT INTO smart_scripts VALUES (4440, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 4971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Totemic - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (4440, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 30000, 30000, 11, 8376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Totemic - In Combat - Cast Earthgrab Totem');
INSERT INTO smart_scripts VALUES (4440, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Totemic - Between 0-15% Health - Flee For Assist');

-- Earthgrab Totem (6066)
UPDATE creature_template SET unit_flags=unit_flags|4|131072, spell1=8377, AIName='SmartAI', ScriptName='' WHERE entry=6066;
DELETE FROM smart_scripts WHERE entryorguid=6066 AND source_type=0;
INSERT INTO smart_scripts VALUES (6066, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthgrab Totem - On AI Init - Set React State');
INSERT INTO smart_scripts VALUES (6066, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 15000, 15000, 11, 8377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthgrab Totem - In Combat - Cast Earthgrab');

-- Death's Head Sage (4518)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4518;
DELETE FROM smart_scripts WHERE entryorguid=4518 AND source_type=0;
INSERT INTO smart_scripts VALUES (4518, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 4971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Sage - In Combat - Cast Healing Ward');
INSERT INTO smart_scripts VALUES (4518, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 30000, 31000, 11, 8262, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Sage - In Combat - Cast Elemental Protection Totem');
INSERT INTO smart_scripts VALUES (4518, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Sage - Between 0-15% Health - Flee For Assist');

-- Razorfen Spearhide (4438)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4438;
DELETE FROM smart_scripts WHERE entryorguid=4438 AND source_type=0;
INSERT INTO smart_scripts VALUES (4438, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 8148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Spearhide - In Combat - Cast Thorns Aura');
INSERT INTO smart_scripts VALUES (4438, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 10000, 17000, 11, 8259, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Spearhide - In Combat - Cast Whirling Barrage');
INSERT INTO smart_scripts VALUES (4438, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Spearhide - Between 0-15% Health - Flee For Assist');

-- Razorfen Stalker (6035)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6035;
DELETE FROM smart_scripts WHERE entryorguid=6035 AND source_type=0;
INSERT INTO smart_scripts VALUES (6035, 0, 0, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Stalker - Behind Target - Cast Backstab');

-- Kraul Bat (4538)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4538;
DELETE FROM smart_scripts WHERE entryorguid=4538 AND source_type=0;
INSERT INTO smart_scripts VALUES (4538, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 7000, 13000, 11, 12553, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Kraul Bat - In Combat - Cast Shock');

-- Greater Kraul Bat (4539)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4539;
DELETE FROM smart_scripts WHERE entryorguid=4539 AND source_type=0;
INSERT INTO smart_scripts VALUES (4539, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 16000, 24000, 11, 8281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Kraul Bat - In Combat - Cast Sonic Burst');

-- Raging Agam'ar (4514)
DELETE FROM creature_text WHERE entry=4514;
INSERT INTO creature_text VALUES (4514, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Raging Agam''ar');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4514;
DELETE FROM smart_scripts WHERE entryorguid=4514 AND source_type=0;
INSERT INTO smart_scripts VALUES (4514, 0, 0, 1, 2, 0, 100, 1, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raging Agam''ar - Between Health 0-40% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (4514, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Raging Agam''ar - Between Health 0-40% - Say Line 0');

-- Agam'ar (4511)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4511;
DELETE FROM smart_scripts WHERE entryorguid=4511 AND source_type=0;
INSERT INTO smart_scripts VALUES (4511, 0, 0, 0, 0, 0, 100, 0, 0, 0, 10000, 15000, 11, 6268, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Agam''ar - In Combat - Cast Rushing Charge');

-- Rotting Agam'ar (4512)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4512;
DELETE FROM smart_scripts WHERE entryorguid=4512 AND source_type=0;
INSERT INTO smart_scripts VALUES (4512, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 30000, 35000, 11, 8267, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rotting Agam''ar - In Combat - Cast Cursed Blood');

-- Blood of Agamaggan (4541)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4541;
DELETE FROM smart_scripts WHERE entryorguid=4541 AND source_type=0;
INSERT INTO smart_scripts VALUES (4541, 0, 0, 0, 0, 0, 100, 0, 2000, 7000, 20000, 35000, 11, 8282, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Blood of Agamaggan - In Combat - Cast Curse of Blood');

-- Razorfen Warden (4437)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4437;
DELETE FROM smart_scripts WHERE entryorguid=4437 AND source_type=0;
INSERT INTO smart_scripts VALUES (4437, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 7000, 15000, 11, 6533, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Razorfen Warden - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (4437, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Warden - Between 0-15% Health - Flee For Assist');

-- Death's Head Priest (4517)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4517;
DELETE FROM smart_scripts WHERE entryorguid=4517 AND source_type=0;
INSERT INTO smart_scripts VALUES (4517, 0, 0, 0, 14, 0, 100, 0, 600, 40, 5000, 7000, 11, 6063, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Priest - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4517, 0, 1, 0, 16, 0, 100, 0, 1245, 30, 5000, 10000, 11, 1245, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Priest - Friendly Missing Buff - Cast Power Word: Fortitude');
INSERT INTO smart_scripts VALUES (4517, 0, 2, 0, 0, 0, 100, 0, 0, 2000, 4000, 5000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Priest - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (4517, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Priest - Between 0-15% Health - Flee For Assist');

-- Ward Guardian (4427)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4427;
DELETE FROM smart_scripts WHERE entryorguid=4427 AND source_type=0;
INSERT INTO smart_scripts VALUES (4427, 0, 0, 0, 0, 0, 100, 0, 200, 1000, 3500, 4000, 11, 8400, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ward Guardian - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4427, 0, 1, 0, 14, 1, 100, 0, 600, 40, 5000, 7000, 11, 959, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ward Guardian - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (4427, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ward Guardian - Between 0-15% Health - Flee For Assist');

-- Death's Head Acolyte (4515)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4515;
DELETE FROM smart_scripts WHERE entryorguid=4515 AND source_type=0;
INSERT INTO smart_scripts VALUES (4515, 0, 0, 0, 14, 0, 100, 0, 300, 40, 10000, 10000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Acolyte - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (4515, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 14000, 21000, 11, 15785, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Death''s Head Acolyte - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (4515, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Acolyte - Between 0-15% Health - Flee For Assist');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Aggem Thorncurse <Death's Head Prophet> (4424)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4424;
DELETE FROM smart_scripts WHERE entryorguid=4424 AND source_type=0;
INSERT INTO smart_scripts VALUES (4424, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 8286, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aggem Thorncurse - In Combat - Cast Summon Boar Spirit');

-- Boar Spirit (6021)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=6021);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=6021);
DELETE FROM creature WHERE id=6021;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=6021;
DELETE FROM smart_scripts WHERE entryorguid=6021 AND source_type=0;

-- Death Speaker Jargba <Death's Head Captain> (4428)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4428;
DELETE FROM smart_scripts WHERE entryorguid=4428 AND source_type=0;
INSERT INTO smart_scripts VALUES (4428, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 3500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death Speaker Jargba - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (4428, 0, 1, 0, 0, 0, 100, 0, 5000, 12000, 30000, 30000, 11, 14515, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Death Speaker Jargba - In Combat - Cast Dominate Mind');

-- Roogug (6168)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6168;
DELETE FROM smart_scripts WHERE entryorguid=6168 AND source_type=0;
INSERT INTO smart_scripts VALUES (6168, 0, 0, 0, 0, 0, 100, 0, 0, 500, 3000, 3000, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Roogug - In Combat - Cast Lightning Bolt');

-- Overlord Ramtusk (4420)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4420;
DELETE FROM smart_scripts WHERE entryorguid=4420 AND source_type=0;
INSERT INTO smart_scripts VALUES (4420, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Ramtusk - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (4420, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Ramtusk - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (4420, 0, 2, 0, 0, 0, 100, 0, 4000, 4000, 10000, 15000, 11, 15548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Ramtusk - In Combat - Cast Thunderclap');

-- Earthcaller Halmgar (4842)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4842;
DELETE FROM smart_scripts WHERE entryorguid=4842 AND source_type=0;
INSERT INTO smart_scripts VALUES (4842, 0, 0, 0, 37, 0, 70, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthcaller Halmgar - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (4842, 0, 1, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8270, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthcaller Halmgar - Out of Combat - Cast Summon Earth Rumbler');
INSERT INTO smart_scripts VALUES (4842, 0, 2, 0, 0, 0, 100, 0, 0, 0, 3000, 3500, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Earthcaller Halmgar - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (4842, 0, 3, 0, 0, 0, 100, 0, 0, 2000, 50000, 60000, 11, 2484, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthcaller Halmgar - In Combat - Cast Earthbind Totem');
INSERT INTO smart_scripts VALUES (4842, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthcaller Halmgar - Between 0-15% Health - Flee For Assist');

-- Blind Hunter (4425)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4425;
DELETE FROM smart_scripts WHERE entryorguid=4425 AND source_type=0;
INSERT INTO smart_scripts VALUES (4425, 0, 0, 0, 37, 0, 70, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blind Hunter - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (4425, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 6000, 9000, 11, 12553, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Blind Hunter - In Combat - Cast Shock');

-- Death's Head Ward Keeper (4625)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4625;
DELETE FROM smart_scripts WHERE entryorguid=4625 AND source_type=0;
INSERT INTO smart_scripts VALUES (4625, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 7083, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Ward Keeper - Out of Combat - Cast Quillboar Channeling');

-- GO ward (21099)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=21099;
DELETE FROM smart_scripts WHERE entryorguid=21099 AND source_type=1;
INSERT INTO smart_scripts VALUES (21099, 1, 0, 1, 60, 0, 100, 257, 5000, 5000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'ward - On Update - Set GO State');
INSERT INTO smart_scripts VALUES (21099, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 4422, 100, 0, 0, 0, 0, 0, 'ward - On Update - Set Data');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=21099;
INSERT INTO conditions VALUES (22, 1, 21099, 1, 0, 29, 1, 4625, 50, 0, 1, 0, 0, '', 'Requires no creatures in range to run event');

-- Agathelos the Raging (4422)
DELETE FROM creature_text WHERE entry=4422;
INSERT INTO creature_text VALUES (4422, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 0, 'Agathelos the Raging');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4422;
DELETE FROM smart_scripts WHERE entryorguid=4422 AND source_type=0;
INSERT INTO smart_scripts VALUES (4422, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2070.26, 2003.44, 64.0, 0, 'Agathelos the Raging - On Data Set - Move Point');
INSERT INTO smart_scripts VALUES (4422, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 14000, 14000, 11, 8285, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - In Combat - Cast Rampage');
INSERT INTO smart_scripts VALUES (4422, 0, 2, 0, 0, 0, 100, 0, 2000, 8000, 7000, 9000, 11, 8555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - In Combat - Cast Left For Dead');
INSERT INTO smart_scripts VALUES (4422, 0, 3, 4, 2, 0, 100, 1, 0, 25, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - Between 0-25% Health - Cast Enrage');
INSERT INTO smart_scripts VALUES (4422, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - Between 0-25% Health - Say Line 0');

-- Charlga Razorflank <The Crone> (4421)
DELETE FROM creature_text WHERE entry=4421;
INSERT INTO creature_text VALUES (4421, 0, 0, 'Troublesome whelps. I''ll teach you to interfere!', 14, 0, 100, 0, 0, 5813, 0, 'Charlga Razorflank');
INSERT INTO creature_text VALUES (4421, 1, 0, 'Who''s next?', 14, 0, 100, 0, 0, 5814, 0, 'Charlga Razorflank');
INSERT INTO creature_text VALUES (4421, 2, 0, 'You outsiders will pay for encroaching on our land!', 14, 0, 100, 0, 0, 5815, 0, 'Charlga Razorflank');
INSERT INTO creature_text VALUES (4421, 2, 1, 'Bah! My power rules here!', 14, 0, 100, 0, 0, 5816, 0, 'Charlga Razorflank');
INSERT INTO creature_text VALUES (4421, 3, 0, 'Our new allies will avenge us!', 14, 0, 100, 0, 0, 5818, 0, 'Charlga Razorflank');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4421;
DELETE FROM smart_scripts WHERE entryorguid=4421 AND source_type=0;
INSERT INTO smart_scripts VALUES (4421, 0, 0, 0, 0, 0, 100, 0, 0, 4000, 3000, 8000, 11, 8292, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - In Combat - Cast Chain Bolt');
INSERT INTO smart_scripts VALUES (4421, 0, 1, 0, 0, 0, 100, 0, 9000, 12000, 15000, 20000, 11, 8361, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - In Combat - Cast Purity');
INSERT INTO smart_scripts VALUES (4421, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 15000, 20000, 11, 6077, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - In Combat - Cast Renew');
INSERT INTO smart_scripts VALUES (4421, 0, 3, 0, 3, 0, 100, 1, 0, 10, 90000, 90000, 11, 8358, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - Between 0-10% Mana - Cast Mana Spike');
INSERT INTO smart_scripts VALUES (4421, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4421, 0, 5, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (4421, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - On Death - Say Line 3');
INSERT INTO smart_scripts VALUES (4421, 0, 7, 0, 0, 0, 100, 0, 11000, 15000, 21000, 30000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - In Combat - Say Line 2');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Blueleaf Tuber (20920)
UPDATE gameobject_template SET faction=0 WHERE entry=20920;

-- Willix the Importer (4508)
DELETE FROM creature_text WHERE entry=4508;
INSERT INTO creature_text VALUES (4508, 0, 0, 'Phew! Finally, out here. However, it will not become easy. Detain your eyes after annoyance.', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_READY');
INSERT INTO creature_text VALUES (4508, 1, 0, 'There on top resides Charlga Razorflank. The damned old Crone.', 12, 0, 100, 25, 0, 0, 0, 'willix SAY_POINT');
INSERT INTO creature_text VALUES (4508, 2, 0, 'Help! Get this Raging Agam''ar from me!', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_AGGRO1');
INSERT INTO creature_text VALUES (4508, 3, 0, 'In this ditch there are Blueleaf Tuber! As if the gold waited only to be dug out, I say it you!', 12, 0, 100, 1, 0, 0, 0, 'willix SAY_BLUELEAF');
INSERT INTO creature_text VALUES (4508, 4, 0, 'Danger is behind every corner.', 12, 0, 100, 1, 0, 0, 0, 'willix SAY_DANGER');
INSERT INTO creature_text VALUES (4508, 5, 0, 'I do not understand how these disgusting animals can live at such a place.... puh as this stinks!', 12, 0, 100, 1, 0, 0, 0, 'willix SAY_BAD');
INSERT INTO creature_text VALUES (4508, 6, 0, 'I think, I see a way how we come out of this damned thorn tangle.', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_THINK');
INSERT INTO creature_text VALUES (4508, 7, 0, 'I am glad that we are out again from this damned ditch. However, up here it is not much better!', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_SOON');
INSERT INTO creature_text VALUES (4508, 8, 0, 'Finally! I am glad that I come, finally out here.', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_FINALY');
INSERT INTO creature_text VALUES (4508, 9, 0, 'I will rather rest a moment and come again to breath, before I return to Ratchet.', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_WIN');
INSERT INTO creature_text VALUES (4508, 10, 0, 'Many thanks for your help.', 12, 0, 100, 0, 0, 0, 0, 'willix SAY_END');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4508;
DELETE FROM smart_scripts WHERE entryorguid=4508 AND source_type=0;
INSERT INTO smart_scripts VALUES (4508, 0, 0, 1, 19, 0, 100, 0, 1144, 0, 0, 0, 53, 0, 4508, 0, 1144, 60000, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (4508, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On Quest Accept - Say Line 0');
INSERT INTO smart_scripts VALUES (4508, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On Quest Accept - Set Faction');
INSERT INTO smart_scripts VALUES (4508, 0, 3, 0, 40, 0, 100, 0, 1, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (4508, 0, 4, 5, 40, 0, 100, 0, 3, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (4508, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 1');
INSERT INTO smart_scripts VALUES (4508, 0, 6, 0, 40, 0, 100, 0, 5, 0, 0, 0, 12, 4514, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 2153.52, 1864.72, 56.11, 4.60, 'Willix the Importer - On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (4508, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 3');
INSERT INTO smart_scripts VALUES (4508, 0, 8, 0, 40, 0, 100, 0, 11, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 4');
INSERT INTO smart_scripts VALUES (4508, 0, 9, 0, 40, 0, 100, 0, 13, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 5');
INSERT INTO smart_scripts VALUES (4508, 0, 10, 0, 40, 0, 100, 0, 15, 0, 0, 0, 12, 4514, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 2106.74, 1720.99, 54.40, 3.8, 'Willix the Importer - On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (4508, 0, 11, 0, 40, 0, 100, 0, 26, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (4508, 0, 12, 0, 40, 0, 100, 0, 33, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 7');
INSERT INTO smart_scripts VALUES (4508, 0, 13, 0, 40, 0, 100, 0, 40, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 8');
INSERT INTO smart_scripts VALUES (4508, 0, 14, 0, 40, 0, 100, 0, 44, 0, 0, 0, 12, 4514, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 1949.05, 1575.01, 80.41, 1.28, 'Willix the Importer - On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (4508, 0, 15, 16, 40, 0, 100, 0, 47, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Say Line 9');
INSERT INTO smart_scripts VALUES (4508, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 50000, 50000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Reached - Create Timed Event');
INSERT INTO smart_scripts VALUES (4508, 0, 17, 0, 59, 0, 100, 0, 1, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On Timed Event - Say Line 10');
INSERT INTO smart_scripts VALUES (4508, 0, 18, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On Aggro - Say Line 2');
INSERT INTO smart_scripts VALUES (4508, 0, 19, 0, 56, 0, 100, 0, 26, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Willix the Importer - On WP Resume - Say Line 6');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=4508;
INSERT INTO conditions VALUES (22, 19, 4508, 0, 0, 31, 0, 3, 4514, 0, 0, 0, 0, '', 'Raging agamar must invoke event');
DELETE FROM script_waypoint WHERE entry=4508;
DELETE FROM waypoints WHERE entry=4508;
INSERT INTO waypoints VALUES (4508, 1, 2194.38, 1791.65, 65.48, 'Willix the Importer'),(4508, 2, 2188.56, 1805.87, 64.45, 'Willix the Importer'),(4508, 3, 2187, 1843.49, 59.33, 'Willix the Importer'),(4508, 4, 2163.27, 1851.67, 56.73, 'Willix the Importer'),(4508, 5, 2137.66, 1843.98, 48.08, 'Willix the Importer'),(4508, 6, 2140.22, 1845.02, 48.32, 'Willix the Importer'),(4508, 7, 2131.5, 1804.29, 46.85, 'Willix the Importer'),(4508, 8, 2096.18, 1789.03, 51.13, 'Willix the Importer'),(4508, 9, 2074.46, 1780.09, 55.64, 'Willix the Importer'),(4508, 10, 2055.12, 1768.67, 58.46, 'Willix the Importer'),(4508, 11, 2037.83, 1748.62, 60.27, 'Willix the Importer'),
(4508, 12, 2037.51, 1728.94, 60.85, 'Willix the Importer'),(4508, 13, 2044.7, 1711.71, 59.71, 'Willix the Importer'),(4508, 14, 2067.66, 1701.84, 57.77, 'Willix the Importer'),(4508, 15, 2078.91, 1704.54, 56.77, 'Willix the Importer'),(4508, 16, 2097.65, 1715.24, 54.74, 'Willix the Importer'),(4508, 17, 2106.44, 1720.98, 54.41, 'Willix the Importer'),(4508, 18, 2123.96, 1732.56, 52.27, 'Willix the Importer'),(4508, 19, 2153.82, 1728.73, 51.92, 'Willix the Importer'),(4508, 20, 2163.49, 1706.33, 54.42, 'Willix the Importer'),(4508, 21, 2158.75, 1695.98, 55.7, 'Willix the Importer'),
(4508, 22, 2142.6, 1680.72, 58.24, 'Willix the Importer'),(4508, 23, 2118.31, 1671.54, 59.21, 'Willix the Importer'),(4508, 24, 2086.02, 1672.04, 61.24, 'Willix the Importer'),(4508, 25, 2068.81, 1658.93, 61.24, 'Willix the Importer'),(4508, 26, 2062.82, 1633.31, 64.35, 'Willix the Importer'),(4508, 27, 2063.05, 1589.16, 63.26, 'Willix the Importer'),(4508, 28, 2063.67, 1577.22, 65.89, 'Willix the Importer'),(4508, 29, 2057.94, 1560.68, 68.4, 'Willix the Importer'),(4508, 30, 2052.56, 1548.05, 73.35, 'Willix the Importer'),(4508, 31, 2045.22, 1543.4, 76.65, 'Willix the Importer'),(4508, 32, 2034.35, 1543.01, 79.7, 'Willix the Importer'),
(4508, 33, 2029.95, 1542.94, 80.79, 'Willix the Importer'),(4508, 34, 2021.34, 1538.67, 80.8, 'Willix the Importer'),(4508, 35, 2012.45, 1549.48, 79.93, 'Willix the Importer'),(4508, 36, 2008.05, 1554.92, 80.44, 'Willix the Importer'),(4508, 37, 2006.54, 1562.72, 81.11, 'Willix the Importer'),(4508, 38, 2003.8, 1576.43, 81.57, 'Willix the Importer'),(4508, 39, 2000.57, 1590.06, 80.62, 'Willix the Importer'),(4508, 40, 1998.96, 1596.87, 80.22, 'Willix the Importer'),(4508, 41, 1991.19, 1600.82, 79.39, 'Willix the Importer'),(4508, 42, 1980.71, 1601.44, 79.77, 'Willix the Importer'),(4508, 43, 1967.22, 1600.18, 80.62, 'Willix the Importer'),
(4508, 44, 1956.43, 1596.97, 81.75, 'Willix the Importer'),(4508, 45, 1954.87, 1592.02, 82.18, 'Willix the Importer'),(4508, 46, 1948.35, 1571.35, 80.96, 'Willix the Importer'),(4508, 47, 1947.02, 1566.42, 81.8, 'Willix the Importer');

-- Quest Willix the Importer (1144)
UPDATE quest_template SET SpecialFlags=2 WHERE Id=1144;

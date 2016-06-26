
UPDATE creature SET spawntimesecs=86400 WHERE map=129 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=129 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Withered Spearhide (7332)
DELETE FROM creature_text WHERE entry=7332;
INSERT INTO creature_text VALUES (7332, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Withered Spearhide');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7332;
DELETE FROM smart_scripts WHERE entryorguid=7332 AND source_type=0;
INSERT INTO smart_scripts VALUES (7332, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Withered Spearhide - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (7332, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 12000, 20000, 11, 11397, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Withered Spearhide - In Combat - Cast Diseased Shot');
INSERT INTO smart_scripts VALUES (7332, 0, 2, 3, 2, 0, 100, 1, 0, 25, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Spearhide - In Combat - Between Health 0-25% - Cast Enrage');
INSERT INTO smart_scripts VALUES (7332, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Spearhide - Between Health 0-25% - Say Line 0');

-- Withered Warrior (7327)
DELETE FROM creature_text WHERE entry=7327;
INSERT INTO creature_text VALUES (7327, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Withered Warrior');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7327;
DELETE FROM smart_scripts WHERE entryorguid=7327 AND source_type=0;
INSERT INTO smart_scripts VALUES (7327, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6268, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Warrior - In Combat - Cast Rushing Charge');
INSERT INTO smart_scripts VALUES (7327, 0, 1, 2, 2, 0, 100, 1, 0, 25, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Warrior - In Combat - Between Health 0-25% - Cast Enrage');
INSERT INTO smart_scripts VALUES (7327, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Warrior - Between Health 0-25% - Say Line 0');

-- Death's Head Geomancer (7335)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7335;
DELETE FROM smart_scripts WHERE entryorguid=7335 AND source_type=0;
INSERT INTO smart_scripts VALUES (7335, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Geomancer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (7335, 0, 1, 0, 0, 0, 100, 0, 4000, 13000, 18000, 29000, 11, 6725, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Death''s Head Geomancer - In Combat - Cast Flame Spike');
INSERT INTO smart_scripts VALUES (7335, 0, 2, 0, 0, 0, 100, 0, 2000, 16000, 12000, 25000, 11, 11436, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Death''s Head Geomancer - In Combat - Cast Slow');
INSERT INTO smart_scripts VALUES (7335, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Geomancer - Between 0-15% Health - Flee For Assist');

-- Withered Battle Boar (7333)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7333;
DELETE FROM smart_scripts WHERE entryorguid=7333 AND source_type=0;

-- Withered Quilguard (7329)
DELETE FROM creature_text WHERE entry=7329;
INSERT INTO creature_text VALUES (7329, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Withered Quilguard');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7329;
DELETE FROM smart_scripts WHERE entryorguid=7329 AND source_type=0;
INSERT INTO smart_scripts VALUES (7329, 0, 0, 1, 2, 0, 100, 1, 0, 25, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Quilguard - In Combat - Between Health 0-25% - Cast Enrage');
INSERT INTO smart_scripts VALUES (7329, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Quilguard - Between Health 0-25% - Say Line 0');

-- Withered Reaver (7328)
DELETE FROM creature_text WHERE entry=7328;
INSERT INTO creature_text VALUES (7328, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Withered Reaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7328;
DELETE FROM smart_scripts WHERE entryorguid=7328 AND source_type=0;
INSERT INTO smart_scripts VALUES (7328, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 6000, 11000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Withered Reaver - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (7328, 0, 1, 2, 2, 0, 100, 1, 0, 25, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Reaver - In Combat - Between Health 0-25% - Cast Enrage');
INSERT INTO smart_scripts VALUES (7328, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Withered Reaver - Between Health 0-25% - Say Line 0');

-- Death's Head Necromancer (7337)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7337;
DELETE FROM smart_scripts WHERE entryorguid=7337 AND source_type=0;
INSERT INTO smart_scripts VALUES (7337, 0, 0, 0, 0, 0, 100, 0, 4000, 15000, 30000, 35000, 11, 11445, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Necromancer - In Combat - Cast Bone Armor');
INSERT INTO smart_scripts VALUES (7337, 0, 1, 0, 0, 0, 100, 0, 4000, 13000, 18000, 29000, 11, 11443, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Death''s Head Necromancer - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (7337, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Necromancer - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (7337, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death''s Head Necromancer - Between 0-15% Health - Flee For Assist');

-- Battle Boar Horror (7334)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7334;
DELETE FROM smart_scripts WHERE entryorguid=7334 AND source_type=0;

-- Splinterbone Skeleton (7343)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7343;
DELETE FROM smart_scripts WHERE entryorguid=7343 AND source_type=0;

-- Thorn Eater Ghoul (7348)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7348;
DELETE FROM smart_scripts WHERE entryorguid=7348 AND source_type=0;
INSERT INTO smart_scripts VALUES (7348, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12539, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thorn Eater Ghoul - On Reset - Cast Ghoul Rot');
INSERT INTO smart_scripts VALUES (7348, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 12538, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thorn Eater Ghoul - In Combat - Cast Ravenous Claw');

-- Frozen Soul (7352)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7352;
DELETE FROM smart_scripts WHERE entryorguid=7352 AND source_type=0;
INSERT INTO smart_scripts VALUES (7352, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12529, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frozen Soul - On Reset - Cast Chilling Touch');
INSERT INTO smart_scripts VALUES (7352, 0, 1, 0, 0, 0, 100, 0, 3000, 13000, 15000, 31000, 11, 12528, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frozen Soul - In Combat - Cast Silence');

-- Splinterbone Warrior (7344)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7344;
DELETE FROM smart_scripts WHERE entryorguid=7344 AND source_type=0;
INSERT INTO smart_scripts VALUES (7344, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 10000, 20000, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Splinterbone Warrior - In Combat - Cast Sunder Armor');

-- Skeletal Frostweaver (7341)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7341;
DELETE FROM smart_scripts WHERE entryorguid=7341 AND source_type=0;
INSERT INTO smart_scripts VALUES (7341, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Frostweaver - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (7341, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 20000, 30000, 11, 8427, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Skeletal Frostweaver - In Combat - Cast Blizzard');

-- Boneflayer Ghoul (7347)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7347;
DELETE FROM smart_scripts WHERE entryorguid=7347 AND source_type=0;
INSERT INTO smart_scripts VALUES (7347, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12539, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Boneflayer Ghoul - On Reset - Cast Ghoul Rot');
INSERT INTO smart_scripts VALUES (7347, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 7000, 11000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Boneflayer Ghoul - In Combat - Cast Cleave');

-- Splinterbone Centurion (7346)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7346;
DELETE FROM smart_scripts WHERE entryorguid=7346 AND source_type=0;
INSERT INTO smart_scripts VALUES (7346, 0, 0, 0, 0, 0, 100, 0, 0, 11000, 13000, 23000, 11, 8078, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Splinterbone Centurion - In Combat - Cast Thunder Clap');

-- Skeletal Summoner (7342)
DELETE FROM creature_text WHERE entry=7342;
INSERT INTO creature_text VALUES (7342, 0, 0, '%s begins to summon in reinforcements!', 16, 0, 100, 0, 0, 0, 0, 'Skeletal Summoner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7342;
DELETE FROM smart_scripts WHERE entryorguid=7342 AND source_type=0;
INSERT INTO smart_scripts VALUES (7342, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Summoner - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (7342, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 20000, 30000, 11, 11980, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Skeletal Summoner - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (7342, 0, 2, 3, 0, 0, 100, 0, 10000, 15000, 40000, 40000, 11, 12258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Summoner - In Combat - Cast Summon Shadowcaster');
INSERT INTO smart_scripts VALUES (7342, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Summoner - In Combat - Say Line 0');

-- Skeletal Shadowcaster (7340)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7340;
DELETE FROM smart_scripts WHERE entryorguid=7340 AND source_type=0;
INSERT INTO smart_scripts VALUES (7340, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (7340, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 20000, 30000, 11, 12248, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Skeletal Shadowcaster - In Combat - Cast Amplify Damage');

-- Splinterbone Captain (7345)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7345;
DELETE FROM smart_scripts WHERE entryorguid=7345 AND source_type=0;
INSERT INTO smart_scripts VALUES (7345, 0, 0, 0, 0, 0, 100, 0, 0, 8000, 9000, 17000, 11, 12461, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Splinterbone Captain - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (7345, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 50000, 70000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Splinterbone Captain - In Combat - Cast Battle Shout');

-- Freezing Spirit (7353)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7353;
DELETE FROM smart_scripts WHERE entryorguid=7353 AND source_type=0;
INSERT INTO smart_scripts VALUES (7353, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12529, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Freezing Spirit - On Reset - Cast Chilling Touch');
INSERT INTO smart_scripts VALUES (7353, 0, 1, 0, 0, 0, 100, 0, 3000, 13000, 15000, 31000, 11, 15532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Freezing Spirit - In Combat - Cast Frost Nova');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Mordresh Fire Eye (7357)
DELETE FROM creature_text WHERE entry=7357;
INSERT INTO creature_text VALUES (7357, 0, 0, 'We will enslave the quilboar!', 12, 0, 100, 1, 0, 5819, 0, 'Mordresh Fire Eye - SAY_OOC_1');
INSERT INTO creature_text VALUES (7357, 1, 0, 'We will spread across this barren land!', 12, 0, 100, 1, 0, 5820, 0, 'Mordresh Fire Eye - SAY_OOC_2');
INSERT INTO creature_text VALUES (7357, 2, 0, 'Soon, the Scourge will rule the world!', 12, 0, 100, 22, 0, 5821, 0, 'Mordresh Fire Eye - SAY_OOC_3');
INSERT INTO creature_text VALUES (7357, 3, 0, 'Slay them, my brethren! For the Scourge!', 14, 0, 100, 0, 0, 5822, 0, 'Mordresh Fire Eye - SAY_AGGRO');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7357;
DELETE FROM smart_scripts WHERE entryorguid=7357 AND source_type=0;
INSERT INTO smart_scripts VALUES (7357, 0, 0, 0, 1, 0, 100, 0, 5000, 5000, 36000, 36000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - Out of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (7357, 0, 1, 0, 1, 0, 100, 0, 13000, 13000, 36000, 36000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - Out of Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (7357, 0, 2, 0, 1, 0, 100, 0, 17000, 17000, 36000, 36000, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - Out of Combat - Play Emote');
INSERT INTO smart_scripts VALUES (7357, 0, 3, 0, 1, 0, 100, 0, 22000, 22000, 36000, 36000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - Out of Combat - Say Line 2');
INSERT INTO smart_scripts VALUES (7357, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - On Aggro - Say Line 3');
INSERT INTO smart_scripts VALUES (7357, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (7357, 0, 6, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 12466, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (7357, 0, 7, 0, 9, 0, 100, 0, 0, 9, 10000, 16000, 11, 12470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mordresh Fire Eye - Within Range 0-9yd - Cast Fire Nova');

-- Glutton (8567)
DELETE FROM creature_text WHERE entry=8567;
INSERT INTO creature_text VALUES (8567, 0, 0, 'Me smell stench of the living!', 14, 0, 100, 0, 0, 5823, 0, 'Glutton - SAY_AGGRO');
INSERT INTO creature_text VALUES (8567, 1, 0, 'Me feast on you all!', 14, 0, 100, 0, 0, 5824, 0, 'Glutton - SAY_SLAY');
INSERT INTO creature_text VALUES (8567, 2, 0, '%s is getting really hungry!', 16, 0, 100, 0, 0, 0, 0, 'Glutton - EMOTE_50%');
INSERT INTO creature_text VALUES (8567, 3, 0, '%s is VERY HUNGRY!', 16, 0, 100, 0, 0, 0, 0, 'Glutton - EMOTE 20%');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8567;
DELETE FROM smart_scripts WHERE entryorguid=8567 AND source_type=0;
INSERT INTO smart_scripts VALUES (8567, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12627, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - On Reset - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES (8567, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (8567, 0, 2, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (8567, 0, 3, 0, 2, 0, 100, 1, 30, 50, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - Health Between 30-50% - Say Line 2');
INSERT INTO smart_scripts VALUES (8567, 0, 4, 5, 2, 0, 100, 1, 0, 20, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - Health Between 0-20% - Say Line 3');
INSERT INTO smart_scripts VALUES (8567, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12795, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Glutton - Health Between 0-20% - Cast Frenzy');

-- Amnennar the Coldbringer (7358)
DELETE FROM creature_text WHERE entry=7358;
INSERT INTO creature_text VALUES (7358, 0, 0, 'You''ll never leave this place alive.', 14, 0, 100, 0, 0, 5825, 0, 'amnennar SAY_AGGRO');
INSERT INTO creature_text VALUES (7358, 1, 0, 'To me, my servants!', 14, 0, 100, 0, 0, 5828, 0, 'amnennar SAY_SUMMON60');
INSERT INTO creature_text VALUES (7358, 2, 0, 'Come, spirits - attend your master!', 14, 0, 100, 0, 0, 5829, 0, 'amnennar SAY_SUMMON30');
INSERT INTO creature_text VALUES (7358, 3, 0, 'I am the hand of the Lich King!', 14, 0, 100, 0, 0, 5827, 0, 'amnennar SAY_HP');
INSERT INTO creature_text VALUES (7358, 4, 0, 'Too easy.', 12, 0, 100, 0, 0, 5826, 0, 'amnennar SAY_KILL');
INSERT INTO creature_text VALUES (7358, 5, 0, '%s begins to summon wraiths out of the freezing cold air!', 16, 0, 100, 0, 0, 0, 0, 'amnennar SAY_SUMMON_EMOTE');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7358;
DELETE FROM smart_scripts WHERE entryorguid=7358 AND source_type=0;
INSERT INTO smart_scripts VALUES (7358, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12556, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - On Reset - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (7358, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (7358, 0, 2, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - On Kill - Say Line 4');
INSERT INTO smart_scripts VALUES (7358, 0, 3, 0, 0, 0, 100, 0, 8000, 10000, 10000, 16000, 11, 13009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - In Combat - Cast Amnennar''s Wrath');
INSERT INTO smart_scripts VALUES (7358, 0, 4, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 15530, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (7358, 0, 5, 0, 0, 0, 100, 0, 6000, 10000, 13000, 21000, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (7358, 0, 6, 0, 2, 0, 100, 1, 0, 70, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-70% - Say Line 3');
INSERT INTO smart_scripts VALUES (7358, 0, 7, 8, 2, 0, 100, 1, 0, 55, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-55% - Say Line 5');
INSERT INTO smart_scripts VALUES (7358, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-55% - Say Line 1');
INSERT INTO smart_scripts VALUES (7358, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-55% - Cast Summon Frost Spectres');
INSERT INTO smart_scripts VALUES (7358, 0, 10, 11, 2, 0, 100, 1, 0, 30, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-30% - Say Line 5');
INSERT INTO smart_scripts VALUES (7358, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-30% - Say Line 1');
INSERT INTO smart_scripts VALUES (7358, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amnennar the Coldbringer - Health Between 0-30% - Cast Summon Frost Spectres');

-- Frost Spectre (8585)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8585;
DELETE FROM smart_scripts WHERE entryorguid=8585 AND source_type=0;
INSERT INTO smart_scripts VALUES (8585, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Frost Spectre - On Reset - Attack Start');

-- Plaguemaw the Rotting (7356)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7356;
DELETE FROM smart_scripts WHERE entryorguid=7356 AND source_type=0;
INSERT INTO smart_scripts VALUES (7356, 0, 0, 0, 0, 0, 100, 2, 8000, 12000, 15000, 23000, 11, 12946, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Plaguemaw the Rotting - In Combat - Cast Putrid Stench');

-- Ragglesnout (7354)
DELETE FROM creature WHERE id=7354;
INSERT INTO creature VALUES (247108, 7354, 129, 1, 1, 0, 0, 2364.75, 904.524, 28.7671, 0.304753, 86400, 5, 0, 7760, 2861, 1, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7354;
DELETE FROM smart_scripts WHERE entryorguid=7354 AND source_type=0;
INSERT INTO smart_scripts VALUES (7354, 0, 0, 0, 37, 0, 70, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ragglesnout - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (7354, 0, 1, 0, 0, 0, 100, 2, 0, 0, 3000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragglesnout - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (7354, 0, 2, 0, 0, 0, 100, 2, 3000, 5000, 20000, 25000, 11, 11639, 1, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ragglesnout - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (7354, 0, 3, 0, 0, 0, 100, 2, 9000, 13000, 15000, 20000, 11, 7645, 1, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Ragglesnout - In Combat - Cast Dominate Mind');
INSERT INTO smart_scripts VALUES (7354, 0, 4, 0, 2, 0, 100, 0, 0, 40, 12000, 16000, 11, 12039, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 'Ragglesnout - Between 0-40% Health - Cast Heal');



-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Gong (148917)
UPDATE gameobject SET animprogress=0 WHERE id=148917;
UPDATE gameobject_template SET data11=0, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=148917;
DELETE FROM smart_scripts WHERE entryorguid=148917 AND source_type=1;
INSERT INTO smart_scripts VALUES (148917, 1, 0, 3, 64, 0, 100, 0, 1, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (148917, 1, 1, 3, 64, 0, 100, 0, 1, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (148917, 1, 2, 3, 64, 0, 100, 0, 1, 0, 0, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (148917, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Gossip Hello - Set GO Flags');
INSERT INTO smart_scripts VALUES (148917, 1, 5, 7, 77, 0, 100, 0, 1, 10, 0, 0, 34, 148917, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Counter Set - Set Instance Data');
INSERT INTO smart_scripts VALUES (148917, 1, 6, 7, 77, 0, 100, 0, 2, 4, 0, 0, 34, 148917, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Counter Set - Set Instance Data');
INSERT INTO smart_scripts VALUES (148917, 1, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gong - On Counter Set - Set GO Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=148917;
INSERT INTO conditions VALUES (22, 1, 148917, 1, 0, 13, 1, 148917, 0, 0, 0, 0, 0, '', 'Run Event if GetData(148917) == 0');
INSERT INTO conditions VALUES (22, 2, 148917, 1, 0, 13, 1, 148917, 1, 0, 0, 0, 0, '', 'Run Event if GetData(148917) == 1');
INSERT INTO conditions VALUES (22, 3, 148917, 1, 0, 13, 1, 148917, 2, 0, 0, 0, 0, '', 'Run Event if GetData(148917) == 2');
DELETE FROM creature_summon_groups WHERE summonerId=148917;
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2487.339, 805.9111, 43.08361, 2.844887, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2485.405, 804.1145, 43.68511, 3.054326, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2488.431, 801.2809, 42.70374, 4.29351, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2489.914, 804.7949, 43.25175, 1.658063, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2541.246, 907.0941, 46.64201, 2.024582, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2544.701, 907.6331, 46.38007, 1.605703, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2541.49,  911.1756, 46.26493, 4.817109, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2544.693, 912.8887, 46.39912, 2.129302, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2524.036, 834.4852, 48.37031, 0.8028514, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 1, 7349, 2527.017, 829.9793, 48.06498, 0.6981317, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 2, 7351, 2542.818, 904.9359, 46.80911, 4.642576, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 2, 7351, 2543.287, 911.2448, 46.32785, 0.6806784, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 2, 7351, 2489.083, 806.5914, 43.21102, 3.682645, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 2, 7351, 2486.828, 802.8737, 43.19883, 2.9147, 8, 0);
INSERT INTO creature_summon_groups VALUES (148917, 1, 3, 7355, 2487.939, 804.2224, 43.10735, 1.692969, 8, 0);

-- Tomb Fiend (7349)
REPLACE INTO creature_template_addon VALUES (7349, 0, 0, 0, 4097, 0, '3616');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7349;
DELETE FROM smart_scripts WHERE entryorguid=7349 AND source_type=0;
INSERT INTO smart_scripts VALUES (7349, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tomb Fiend - On Reset - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (7349, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 148917, 200, 0, 0, 0, 0, 0, 'Tomb Fiend - On Death - Set Counter');

-- Tomb Reaver (7351)
REPLACE INTO creature_template_addon VALUES (7351, 0, 0, 0, 4097, 0, '3616');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7351;
DELETE FROM smart_scripts WHERE entryorguid=7351 AND source_type=0;
INSERT INTO smart_scripts VALUES (7351, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tomb Reaver - On Reset - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (7351, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 16000, 35000, 11, 745, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Tomb Reaver - In Combat - Cast Web');
INSERT INTO smart_scripts VALUES (7351, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 2, 1, 0, 0, 0, 0, 20, 148917, 200, 0, 0, 0, 0, 0, 'Tomb Reaver - On Death - Set Counter');

-- Tuten'kash (7355)
REPLACE INTO creature_template_addon VALUES (7355, 0, 0, 0, 4097, 0, '12254 8876');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7355;
DELETE FROM smart_scripts WHERE entryorguid=7355 AND source_type=0;
INSERT INTO smart_scripts VALUES (7355, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2515.71, 854.81, 47.68, 0, 'Tuten''kash - On Reset - Move Point');
INSERT INTO smart_scripts VALUES (7355, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 30000, 45000, 11, 12255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tuten''kash - In Combat - Cast Curse of Tuten''kash');
INSERT INTO smart_scripts VALUES (7355, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 20000, 20000, 11, 12252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tuten''kash - In Combat - Cast Web Spray');
INSERT INTO smart_scripts VALUES (7355, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 148917, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tuten''kash - On Death - Set Instance Data');

-- Henry Stern (8696)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8696;
DELETE FROM smart_scripts WHERE entryorguid=8696 AND source_type=0;
INSERT INTO smart_scripts VALUES (8696, 0, 0, 0, 62, 0, 100, 0, 1443, 2, 0, 0, 85, 13029, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Henry Stern - On Gossip Select - Cast Spell Goldthorn Tea');
INSERT INTO smart_scripts VALUES (8696, 0, 1, 0, 62, 0, 100, 0, 1443, 3, 0, 0, 85, 13030, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Henry Stern - On Gossip Select - Cast Spell Major Trolls Blood Potion');
INSERT INTO smart_scripts VALUES (8696, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Henry Stern - On Data Set 1 1 - Set Phase 2');
INSERT INTO smart_scripts VALUES (8696, 0, 3, 0, 1, 2, 100, 1, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Henry Stern - OOC (Phase 2) - Say (No Repeat)');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1443;
INSERT INTO conditions VALUES (15, 1443, 0, 0, 0, 7, 0, 185, 1, 0, 0, 0, 0, '', 'Show gossip option only if player has cooking');
INSERT INTO conditions VALUES (15, 1443, 0, 0, 0, 7, 0, 185, 180, 0, 1, 0, 0, '', 'Show Gossip only if player does not have at least 180 skill in cooking');
INSERT INTO conditions VALUES (15, 1443, 0, 0, 0, 25, 0, 13028, 0, 0, 1, 0, 0, '', 'Show gossip option only if player does not already know goldthorn tea recipe');
INSERT INTO conditions VALUES (15, 1443, 1, 0, 0, 7, 0, 171, 1, 0, 0, 0, 0, '', 'Show gossip option only if player has Alchemy');
INSERT INTO conditions VALUES (15, 1443, 1, 0, 0, 7, 0, 171, 175, 0, 1, 0, 0, '', 'Show gossip only if player does not have at least 175 skill in Alchemy');
INSERT INTO conditions VALUES (15, 1443, 1, 0, 0, 25, 0, 3451, 0, 0, 1, 0, 0, '', 'Show gossip option only if player does not already know Major Trolls Blood Elixir');
INSERT INTO conditions VALUES (15, 1443, 2, 0, 0, 7, 0, 185, 180, 0, 0, 0, 0, '', 'Show Gossip only if player has at least 180 skill in cooking');
INSERT INTO conditions VALUES (15, 1443, 2, 0, 0, 25, 0, 13028, 0, 0, 1, 0, 0, '', 'Show gossip option only if player does not already know goldthorn tea recipe');
INSERT INTO conditions VALUES (15, 1443, 3, 0, 0, 7, 0, 171, 175, 0, 0, 0, 0, '', 'Show gossip only if player has at least 175 skill in Alchemy');
INSERT INTO conditions VALUES (15, 1443, 3, 0, 0, 25, 0, 3451, 0, 0, 1, 0, 0, '', 'Show gossip option only if player does not already know Major Trolls Blood Elixir');

-- GO Holding Pen (157818)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=157818;
DELETE FROM smart_scripts WHERE entryorguid=157818 AND source_type=1;
INSERT INTO smart_scripts VALUES (157818, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Holding Pen - On State Changed - Store target');
INSERT INTO smart_scripts VALUES (157818, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 8696, 0, 0, 0, 0, 0, 0, 'Holding Pen - On State Changed - Send targetlist to Henry Stern');
INSERT INTO smart_scripts VALUES (157818, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 8696, 0, 0, 0, 0, 0, 0, 'Holding Pen - On State Changed - Set data 1 1 on Henry Stern');

-- Sah'rhee (8767)
UPDATE creature_template SET gossip_menu_id=1490 WHERE entry=8767;
DELETE FROM gossip_menu WHERE entry=1490;
INSERT INTO gossip_menu VALUES (1490, 2155);

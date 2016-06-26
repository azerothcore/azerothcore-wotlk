
UPDATE creature SET spawntimesecs=86400 WHERE map=389 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Earthborer (11320)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11320;
DELETE FROM smart_scripts WHERE entryorguid=11320 AND source_type=0;
INSERT INTO smart_scripts VALUES (11320, 0, 0, 0, 0, 0, 100, 0, 1000, 4000, 3000, 5000, 11, 18070, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Earthborer - In Combat - Cast Earthborer Acid');

-- Molten Elemental (11321)
REPLACE INTO creature_template_addon VALUES (11321, 0, 0, 0, 4097, 0, '18268 7942');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=11321;

-- Ragefire Trogg (11318)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11318;
DELETE FROM smart_scripts WHERE entryorguid=11318 AND source_type=0;
INSERT INTO smart_scripts VALUES (11318, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 4000, 8000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Trogg - In Combat - Cast Strike');

-- Ragefire Shaman (11319)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11319;
DELETE FROM smart_scripts WHERE entryorguid=11319 AND source_type=0;
INSERT INTO smart_scripts VALUES (11319, 0, 0, 0, 0, 0, 100, 0, 0, 500, 3000, 3800, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Shaman - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (11319, 0, 1, 0, 14, 0, 100, 0, 300, 40, 10000, 20000, 11, 11986, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Shaman - On Friendly Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (11319, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ragefire Shaman - Between 0-15% Health - Flee For Assist');

-- Searing Blade Cultist (11322)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11322;
DELETE FROM smart_scripts WHERE entryorguid=11322 AND source_type=0;
INSERT INTO smart_scripts VALUES (11322, 0, 0, 0, 0, 0, 100, 0, 1000, 8000, 15000, 20000, 11, 18266, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Searing Blade Cultist - In Combat - Cast Curse of Agony');

-- Searing Blade Enforcer (11323)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11323;
DELETE FROM smart_scripts WHERE entryorguid=11323 AND source_type=0;
INSERT INTO smart_scripts VALUES (11323, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 8242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Blade Enforcer - In Combat - Cast Shield Slam');

-- Searing Blade Warlock (11324)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11324;
DELETE FROM smart_scripts WHERE entryorguid=11324 AND source_type=0;
INSERT INTO smart_scripts VALUES (11324, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 12746, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Searing Blade Warlock - Out of Combat - Cast Summon Voidwalker');
INSERT INTO smart_scripts VALUES (11324, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 20791, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Searing Blade Warlock - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (11324, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Searing Blade Warlock - Between 0-15% Health - Flee For Assist');

-- Voidwalker Minion (8996)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=8996;
DELETE FROM smart_scripts WHERE entryorguid=8996 AND source_type=0;
INSERT INTO smart_scripts VALUES (8996, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 4000, 6000, 11, 33914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Voidwalker Minion - In Combat - Cast Shadowstrike');




-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Oggleflint <Ragefire Chieftain> (11517)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11517;
DELETE FROM smart_scripts WHERE entryorguid=11517 AND source_type=0;
INSERT INTO smart_scripts VALUES (11517, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 8000, 13000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oggleflint - In Combat - Cast Cleave');

-- Taragaman the Hungerer (11520)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11520;
DELETE FROM smart_scripts WHERE entryorguid=11520 AND source_type=0;
INSERT INTO smart_scripts VALUES (11520, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 10000, 10000, 11, 18072, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Taragaman the Hungerer - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (11520, 0, 1, 0, 0, 0, 100, 0, 7000, 12000, 10000, 20000, 11, 11970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Taragaman the Hungerer - In Combat - Cast Fire Nova');

-- Jergosh the Invoker (11518)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11518;
DELETE FROM smart_scripts WHERE entryorguid=11518 AND source_type=0;
INSERT INTO smart_scripts VALUES (11518, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 30000, 30000, 11, 18267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jergosh the Invoker - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (11518, 0, 1, 0, 0, 0, 100, 0, 3000, 3000, 10000, 20000, 11, 20800, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jergosh the Invoker - In Combat - Cast Immolate');

-- Bazzalan (11519)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11519;
DELETE FROM smart_scripts WHERE entryorguid=11519 AND source_type=0;
INSERT INTO smart_scripts VALUES (11519, 0, 0, 0, 0, 0, 50, 0, 2000, 2000, 2000, 2000, 11, 2818, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bazzalan - In Combat - Cast Deadly Poison');
INSERT INTO smart_scripts VALUES (11519, 0, 1, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bazzalan - In Combat - Cast Sinister Strike');

-- Zelemar the Wrathful (17830)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=17830;
DELETE FROM smart_scripts WHERE entryorguid=17830 AND source_type=0;



-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Blood Filled Orb (182024)
UPDATE gameobject SET spawntimesecs=86400 WHERE id=182024;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=182024;
DELETE FROM smart_scripts WHERE entryorguid=182024 AND source_type=1;
INSERT INTO smart_scripts VALUES (182024, 1, 0, 0, 64, 0, 100, 0, 1, 0, 0, 0, 12, 17830, 8, 0, 1, 0, 0, 8, 0, 0, 0, -369.746, 166.759, -21.50, 5.235, 'Blood Filled Orb - On Gossip Hello - Summon Creature');



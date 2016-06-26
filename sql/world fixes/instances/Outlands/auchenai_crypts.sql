
UPDATE creature SET spawntimesecs=86400 WHERE map=558 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Auchenai Soulpriest (18493, 20301)
DELETE FROM creature_text WHERE entry=18493;
INSERT INTO creature_text VALUES (18493, 0, 0, "Shhh! The spirits are sleeping!", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Soulpriest');
INSERT INTO creature_text VALUES (18493, 0, 1, "You have chosen death.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Soulpriest');
INSERT INTO creature_text VALUES (18493, 0, 2, "You will pay for this violation.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Soulpriest');
INSERT INTO creature_text VALUES (18493, 0, 3, "You will rest with the honored dead.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Soulpriest');
UPDATE creature_template SET pickpocketloot=18493, AIName='SmartAI', ScriptName='' WHERE entry=18493;
UPDATE creature_template SET pickpocketloot=18493, AIName='', ScriptName='' WHERE entry=20301;
DELETE FROM smart_scripts WHERE entryorguid=18493 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(1849300, 1849301, 1849302, 1849303, 1849304) AND source_type=9;
INSERT INTO smart_scripts VALUES (18493, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18493, 0, 1, 0, 0, 0, 100, 2, 1000, 1000, 6000, 9000, 11, 32860, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18493, 0, 2, 0, 0, 0, 100, 4, 1000, 1000, 6000, 9000, 11, 38378, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18493, 0, 3, 0, 0, 0, 100, 0, 12000, 15000, 25000, 25000, 11, 32859, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Cast Falter');
INSERT INTO smart_scripts VALUES (18493, 0, 4, 0, 0, 0, 100, 2, 5000, 6000, 50000, 50000, 11, 32858, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Cast Touch of the Forgotten');
INSERT INTO smart_scripts VALUES (18493, 0, 5, 0, 0, 0, 100, 4, 5000, 6000, 50000, 50000, 11, 38377, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Cast Touch of the Forgotten');
INSERT INTO smart_scripts VALUES (18493, 0, 6, 0, 0, 0, 100, 1, 5000, 11000, 0, 0, 88, 1849300, 1849304, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - In Combat - Call Random Script');
INSERT INTO smart_scripts VALUES (1849300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - Script9 - Cast Summon Phantasmal Possessor');
INSERT INTO smart_scripts VALUES (1849301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - Script9 - Cast Summon Unliving Cleric');
INSERT INTO smart_scripts VALUES (1849302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - Script9 - Cast Summon Unliving Soldier');
INSERT INTO smart_scripts VALUES (1849303, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32856, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - Script9 - Cast Summon Unliving Stalker');
INSERT INTO smart_scripts VALUES (1849304, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32854, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Soulpriest - Script9 - Cast Summon Unliving Sorcerer');

-- Auchenai Vindicator (18495, 20302)
DELETE FROM creature_text WHERE entry=18495;
INSERT INTO creature_text VALUES (18495, 0, 0, "Shhh! The spirits are sleeping!", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Vindicator');
INSERT INTO creature_text VALUES (18495, 0, 1, "You have chosen death.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Vindicator');
INSERT INTO creature_text VALUES (18495, 0, 2, "You will pay for this violation.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Vindicator');
INSERT INTO creature_text VALUES (18495, 0, 3, "You will rest with the honored dead.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Vindicator');
UPDATE creature_template SET pickpocketloot=18495, AIName='SmartAI', ScriptName='' WHERE entry=18495;
UPDATE creature_template SET pickpocketloot=18495, AIName='', ScriptName='' WHERE entry=20302;
DELETE FROM smart_scripts WHERE entryorguid=18495 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(1849500, 1849501, 1849502, 1849503, 1849504) AND source_type=9;
INSERT INTO smart_scripts VALUES (18495, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18495, 0, 1, 0, 0, 0, 100, 2, 1000, 1000, 6000, 9000, 11, 17439, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (18495, 0, 2, 0, 0, 0, 100, 4, 1000, 1000, 6000, 9000, 11, 17289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (18495, 0, 3, 0, 0, 0, 100, 2, 40000, 40000, 40000, 40000, 11, 32861, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - In Combat - Cast Shadowguard');
INSERT INTO smart_scripts VALUES (18495, 0, 4, 0, 0, 0, 100, 4, 40000, 40000, 40000, 40000, 11, 38379, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - In Combat - Cast Shadowguard');
INSERT INTO smart_scripts VALUES (18495, 0, 5, 0, 1, 0, 100, 2, 0, 0, 600000, 600000, 11, 32861, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Out of Combat - Cast Shadowguard');
INSERT INTO smart_scripts VALUES (18495, 0, 6, 0, 1, 0, 100, 4, 0, 0, 600000, 600000, 11, 38379, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Out of Combat - Cast Shadowguard');
INSERT INTO smart_scripts VALUES (18495, 0, 7, 0, 0, 0, 100, 1, 5000, 11000, 0, 0, 88, 1849500, 1849504, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - In Combat - Call Random Script');
INSERT INTO smart_scripts VALUES (1849500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Script9 - Cast Summon Phantasmal Possessor');
INSERT INTO smart_scripts VALUES (1849501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Script9 - Cast Summon Unliving Cleric');
INSERT INTO smart_scripts VALUES (1849502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Script9 - Cast Summon Unliving Soldier');
INSERT INTO smart_scripts VALUES (1849503, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32856, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Script9 - Cast Summon Unliving Stalker');
INSERT INTO smart_scripts VALUES (1849504, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32854, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Vindicator - Script9 - Cast Summon Unliving Sorcerer');

-- Auchenai Monk (18497, 20299)
DELETE FROM creature_text WHERE entry=18497;
INSERT INTO creature_text VALUES (18497, 0, 0, "Shhh! The spirits are sleeping!", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Monk');
INSERT INTO creature_text VALUES (18497, 0, 1, "You have chosen death.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Monk');
INSERT INTO creature_text VALUES (18497, 0, 2, "You will pay for this violation.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Monk');
INSERT INTO creature_text VALUES (18497, 0, 3, "You will rest with the honored dead.", 12, 0, 100, 0, 0, 0, 0, 'Auchenai Monk');
UPDATE creature_template SET pickpocketloot=18497, AIName='SmartAI', ScriptName='' WHERE entry=18497;
UPDATE creature_template SET pickpocketloot=18497, AIName='', ScriptName='' WHERE entry=20299;
DELETE FROM smart_scripts WHERE entryorguid=18497 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(1849700, 1849701, 1849702, 1849703, 1849704) AND source_type=9;
INSERT INTO smart_scripts VALUES (18497, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18497, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 6000, 9000, 11, 37321, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - In Combat - Cast Overpower');
INSERT INTO smart_scripts VALUES (18497, 0, 2, 0, 0, 0, 100, 0, 11000, 11000, 16000, 19000, 11, 32849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - In Combat - Cast Cyclone Strike');
INSERT INTO smart_scripts VALUES (18497, 0, 3, 0, 13, 0, 100, 0, 15000, 15000, 0, 0, 11, 32846, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - On Target Cast - Cast Counter Kick');
INSERT INTO smart_scripts VALUES (18497, 0, 4, 0, 1, 0, 100, 0, 0, 0, 120000, 120000, 11, 38168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Out of Combat - Cast Spiritual Sight');
INSERT INTO smart_scripts VALUES (18497, 0, 5, 0, 0, 0, 100, 1, 5000, 11000, 0, 0, 88, 1849700, 1849704, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - In Combat - Call Random Script');
INSERT INTO smart_scripts VALUES (1849700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Script9 - Cast Summon Phantasmal Possessor');
INSERT INTO smart_scripts VALUES (1849701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Script9 - Cast Summon Unliving Cleric');
INSERT INTO smart_scripts VALUES (1849702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Script9 - Cast Summon Unliving Soldier');
INSERT INTO smart_scripts VALUES (1849703, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32856, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Script9 - Cast Summon Unliving Stalker');
INSERT INTO smart_scripts VALUES (1849704, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 32854, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Monk - Script9 - Cast Summon Unliving Sorcerer');

-- Unliving Cleric (18500, 20320)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18500;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20320;
DELETE FROM smart_scripts WHERE entryorguid=18500 AND source_type=0;
INSERT INTO smart_scripts VALUES (18500, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18500, 0, 1, 0, 14, 0, 100, 2, 1000, 40, 7000, 10000, 11, 33324, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18500, 0, 2, 0, 14, 0, 100, 4, 1000, 40, 7000, 10000, 11, 22883, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - HP Friendly - Cast Heal');
INSERT INTO smart_scripts VALUES (18500, 0, 3, 0, 16, 0, 100, 2, 25058, 40, 7000, 10000, 11, 25058, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (18500, 0, 4, 0, 16, 0, 100, 4, 38210, 40, 7000, 10000, 11, 38210, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - Missing Buff - Cast Renew');
INSERT INTO smart_scripts VALUES (18500, 0, 5, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (18500, 0, 6, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Unliving Cleric - Out of Combat - Attack Start');

-- Unliving Soldier (18498, 20321)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18498;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20321;
DELETE FROM smart_scripts WHERE entryorguid=18498 AND source_type=0;
INSERT INTO smart_scripts VALUES (18498, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 32828, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Soldier - On Update - Cast Protection Aura');
INSERT INTO smart_scripts VALUES (18498, 0, 1, 0, 13, 0, 100, 0, 10000, 15000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Unliving Soldier - On Target Cast - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (18498, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Soldier - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (18498, 0, 3, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Unliving Soldier - Out of Combat - Attack Start');

-- Unliving Sorcerer (18499, 20322)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18499;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20322;
DELETE FROM smart_scripts WHERE entryorguid=18499 AND source_type=0;
INSERT INTO smart_scripts VALUES (18499, 0, 0, 0, 0, 0, 100, 2, 0, 0, 4000, 4000, 11, 12466, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18499, 0, 1, 0, 0, 0, 100, 4, 0, 0, 4000, 4000, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (18499, 0, 2, 0, 0, 0, 100, 2, 8000, 8000, 13000, 13000, 11, 15043, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (18499, 0, 3, 0, 0, 0, 100, 4, 8000, 8000, 13000, 13000, 11, 15530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (18499, 0, 4, 0, 0, 0, 100, 2, 10000, 10000, 15000, 15000, 11, 15744, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (18499, 0, 5, 0, 0, 0, 100, 4, 10000, 10000, 15000, 15000, 11, 22424, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (18499, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (18499, 0, 7, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Unliving Sorcerer - Out of Combat - Attack Start');

-- Unliving Stalker (18501, 20323)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18501;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20323;
DELETE FROM smart_scripts WHERE entryorguid=18501 AND source_type=0;
INSERT INTO smart_scripts VALUES (18501, 0, 0, 8, 9, 0, 100, 2, 5, 30, 3000, 3000, 11, 15547, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (18501, 0, 1, 8, 9, 0, 100, 4, 5, 30, 3000, 3000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (18501, 0, 2, 0, 0, 0, 100, 2, 5000, 8000, 13000, 13000, 11, 31975, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Serpent Sting');
INSERT INTO smart_scripts VALUES (18501, 0, 3, 0, 0, 0, 100, 4, 5000, 8000, 13000, 13000, 11, 35511, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Serpent Sting');
INSERT INTO smart_scripts VALUES (18501, 0, 4, 0, 0, 0, 100, 0, 10000, 10000, 15000, 15000, 11, 37551, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Viper Sting');
INSERT INTO smart_scripts VALUES (18501, 0, 5, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 32829, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - In Combat - Cast Spirit Vengeance');
INSERT INTO smart_scripts VALUES (18501, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (18501, 0, 7, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Unliving Stalker - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (18501, 0, 9, 0, 9, 0, 100, 0, 0, 5, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Unliving Stalker - Within 0-5 Range - Set Sheath Melee (No Repeat) (Dungeon)");
INSERT INTO smart_scripts VALUES (18501, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Unliving Stalker - Within 5-30 Range - Set Sheath Ranged (Normal Dungeon)");

-- Phantasmal Possessor (18503, 20309)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18503;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20309;
DELETE FROM smart_scripts WHERE entryorguid=18503 AND source_type=0;
INSERT INTO smart_scripts VALUES (18503, 0, 0, 0, 0, 0, 100, 0, 6000, 9000, 16000, 25000, 11, 33401, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Phantasmal Possessor - In Combat - Cast Possess');
INSERT INTO smart_scripts VALUES (18503, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phantasmal Possessor - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (18503, 0, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Phantasmal Possessor - Out of Combat - Attack Start');
DELETE FROM spell_script_names WHERE spell_id IN(33401, 32830);
INSERT INTO spell_script_names VALUES (33401, 'spell_auchenai_possess');
INSERT INTO spell_script_names VALUES (32830, 'spell_auchenai_possess');

-- Angered Skeleton (18524, 20298)
UPDATE creature_template SET pickpocketloot=18524, AIName='SmartAI', ScriptName='' WHERE entry=18524;
UPDATE creature_template SET pickpocketloot=18524, AIName='', ScriptName='' WHERE entry=20298;
DELETE FROM smart_scripts WHERE entryorguid=18524 AND source_type=0;
INSERT INTO smart_scripts VALUES (18524, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 32885, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angered Skeleton - Out of Combat - Cast Infuriate');

-- Raging Skeleton (18521, 20315)
UPDATE creature_template SET pickpocketloot=18521, AIName='SmartAI', ScriptName='' WHERE entry=18521;
UPDATE creature_template SET pickpocketloot=18521, AIName='', ScriptName='' WHERE entry=20315;
DELETE FROM smart_scripts WHERE entryorguid=18521 AND source_type=0;

-- Auchenai Necromancer (18702, 20300)
DELETE FROM creature_text WHERE entry=18702;
INSERT INTO creature_text VALUES (18702, 0, 0, "How dare you come here?", 14, 0, 100, 0, 0, 0, 0, 'Auchenai Necromancer');
INSERT INTO creature_text VALUES (18702, 0, 1, "Outsiders are forbidden!", 14, 0, 100, 0, 0, 0, 0, 'Auchenai Necromancer');
INSERT INTO creature_text VALUES (18702, 0, 2, "This is sacred ground!", 14, 0, 100, 0, 0, 0, 0, 'Auchenai Necromancer');
UPDATE creature_template SET pickpocketloot=18702, AIName='SmartAI', ScriptName='' WHERE entry=18702;
UPDATE creature_template SET pickpocketloot=18702, AIName='', ScriptName='' WHERE entry=20300;
DELETE FROM smart_scripts WHERE entryorguid=18702 AND source_type=0;
INSERT INTO smart_scripts VALUES (18702, 0, 0, 0, 4, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Necromancer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18702, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 16000, 19000, 11, 35839, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Necromancer - In Combat - Cast Drain Soul');
INSERT INTO smart_scripts VALUES (18702, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 33325, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Auchenai Necromancer - HP 50% - Cast Shadow Mend');
INSERT INTO smart_scripts VALUES (18702, 0, 3, 0, 0, 0, 100, 2, 10000, 10000, 26000, 26000, 11, 32863, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Auchenai Necromancer - In Combat - Cast Seed of Corruption');
INSERT INTO smart_scripts VALUES (18702, 0, 4, 0, 0, 0, 100, 4, 10000, 10000, 26000, 26000, 11, 38252, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Auchenai Necromancer - In Combat - Cast Seed of Corruption');

-- Reanimated Bones (18700, 20317)
UPDATE creature_template SET pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=18700;
UPDATE creature_template SET pickpocketloot=0, AIName='', ScriptName='' WHERE entry=20317;
DELETE FROM smart_scripts WHERE entryorguid=18700 AND source_type=0;
INSERT INTO smart_scripts VALUES (18700, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 8000, 11, 13584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Bones - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (18700, 0, 1, 0, 0, 0, 100, 0, 1000, 4000, 9000, 12000, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Bones - In Combat - Cast Sunder Armor');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Shirrak the Dead Watcher (18371, 20318)
DELETE FROM creature_text WHERE entry=18371;
INSERT INTO creature_text VALUES (18371, 0, 0, '%s focuses on $n!', 41, 0, 100, 0, 0, 0, 0, 'Shirrak the Dead Watcher - Emote Focus');
UPDATE creature_template SET AIName='', ScriptName='boss_shirrak_the_dead_watcher' WHERE entry=18371;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20318;
DELETE FROM smart_scripts WHERE entryorguid=18371 AND source_type=0;
-- Focus Fire (18374, 20308)
UPDATE creature_template SET modelid1=1126, modelid2=0, minlevel=66, maxlevel=66, faction=16, AIName='NullCreatureAI', ScriptName='' WHERE entry=18374;
UPDATE creature_template SET modelid1=1126, modelid2=0, minlevel=72, maxlevel=72, faction=16, AIName='', ScriptName='' WHERE entry=20308;
DELETE FROM smart_scripts WHERE entryorguid=18374 AND source_type=0;

-- Exarch Maladaar (18373, 20306)
UPDATE creature_template SET speed_walk=1.6, speed_run=1.71429, pickpocketloot=18373, AIName='', ScriptName='boss_exarch_maladaar' WHERE entry=18373;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.71429, pickpocketloot=18373, AIName='', ScriptName='' WHERE entry=20306;
DELETE FROM smart_scripts WHERE entryorguid=18373 AND source_type=0;
-- Stolen Soul (18441, 20305)
UPDATE creature_template SET faction=16, AIName='', ScriptName='npc_stolen_soul' WHERE entry=18441;
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=20305;
DELETE FROM smart_scripts WHERE entryorguid=18441 AND source_type=0;
-- Avatar of the Martyred (18478, 20303)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18478;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20303;
DELETE FROM smart_scripts WHERE entryorguid=18478 AND source_type=0;
INSERT INTO smart_scripts VALUES (18478, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 8000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (18478, 0, 1, 0, 0, 0, 100, 0, 1000, 4000, 9000, 12000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast Sunder Armor');


-- -------------------------------------------
--                MISC
-- -------------------------------------------


UPDATE creature SET spawntimesecs=86400 WHERE map=48 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=48 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Murkshallow Snapclaw (4815)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4815;
DELETE FROM smart_scripts WHERE entryorguid=4815 AND source_type=0;
INSERT INTO smart_scripts VALUES (4815, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 20000, 27000, 11, 8379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkshallow Snapclaw - In Combat - Cast Disarm');

-- Skittering Crustacean (4821)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4821;
DELETE FROM smart_scripts WHERE entryorguid=4821 AND source_type=0;
INSERT INTO smart_scripts VALUES (4821, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skittering Crustacean - Between 0-15% Health - Flee For Assist');

-- Snapping Crustacean (4822)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4822;
DELETE FROM smart_scripts WHERE entryorguid=4822 AND source_type=0;

-- Blindlight Murloc (4818)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4818;
DELETE FROM smart_scripts WHERE entryorguid=4818 AND source_type=0;
INSERT INTO smart_scripts VALUES (4818, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Murloc - On Aggro - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4818, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 8000, 11000, 11, 7405, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Murloc - In Combat - Cast Sunder Armor');

-- Blackfathom Myrmidon (4807)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4807;
DELETE FROM smart_scripts WHERE entryorguid=4807 AND source_type=0;
INSERT INTO smart_scripts VALUES (4807, 0, 0, 0, 0, 0, 100, 0, 5000, 15000, 20000, 27000, 11, 8379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Myrmidon - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (4807, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Myrmidon - Between 0-15% Health - Flee For Assist');

-- Blackfathom Sea Witch (4805)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4805;
DELETE FROM smart_scripts WHERE entryorguid=4805 AND source_type=0;
INSERT INTO smart_scripts VALUES (4805, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 12544, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Sea Witch - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (4805, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 15000, 22000, 11, 122, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Sea Witch - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (4805, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 25000, 25000, 11, 15044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Sea Witch - In Combat - Cast Frost Ward');
INSERT INTO smart_scripts VALUES (4805, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blackfathom Sea Witch - Between 0-15% Health - Flee For Assist');

-- Aku'mai Fisher (4824)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4824;
DELETE FROM smart_scripts WHERE entryorguid=4824 AND source_type=0;

-- Fallenroot Shadowstalker (4798)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4798;
DELETE FROM smart_scripts WHERE entryorguid=4798 AND source_type=0;
INSERT INTO smart_scripts VALUES (4798, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 5916, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Shadowstalker - Out of Combat - Cast Shadowstalker Stealth');
INSERT INTO smart_scripts VALUES (4798, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 30000, 30000, 11, 6205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Shadowstalker - In Combat - Cast Curse of Weakness');

-- Fallenroot Hellcaller (4799)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4799;
DELETE FROM smart_scripts WHERE entryorguid=4799 AND source_type=0;
INSERT INTO smart_scripts VALUES (4799, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Hellcaller - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (4799, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 10000, 18000, 11, 8129, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Fallenroot Hellcaller - In Combat - Cast Mana Burn');

-- Blindlight Muckdweller (4819)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4819;
DELETE FROM smart_scripts WHERE entryorguid=4819 AND source_type=0;
INSERT INTO smart_scripts VALUES (4819, 0, 0, 0, 0, 0, 100, 0, 3000, 9000, 10000, 18000, 11, 8382, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Blindlight Muckdweller - In Combat - Cast Leech Poison');

-- Blindlight Oracle (4820)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4820;
DELETE FROM smart_scripts WHERE entryorguid=4820 AND source_type=0;
INSERT INTO smart_scripts VALUES (4820, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 9532, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Oracle - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (4820, 0, 1, 0, 14, 0, 100, 0, 500, 40, 10000, 18000, 11, 6063, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Oracle - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4820, 0, 2, 0, 14, 0, 100, 0, 300, 40, 10000, 18000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Oracle - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (4820, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Oracle - Between 0-15% Health - Flee For Assist');

-- Twilight Loreseeker (4812)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4812;
DELETE FROM smart_scripts WHERE entryorguid=4812 AND source_type=0;
INSERT INTO smart_scripts VALUES (4812, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 25000, 35000, 11, 8365, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Loreseeker - In Combat - Cast Enlarge');
INSERT INTO smart_scripts VALUES (4812, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 15000, 21000, 11, 18972, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Twilight Loreseeker - In Combat - Cast Slow');
INSERT INTO smart_scripts VALUES (4812, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Loreseeker - Between 0-15% Health - Flee For Assist');

-- Twilight Aquamancer (4811)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4811;
DELETE FROM smart_scripts WHERE entryorguid=4811 AND source_type=0;
INSERT INTO smart_scripts VALUES (4811, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8372, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Aquamancer - Out of Combat - Cast Summon Aqua Guardian');
INSERT INTO smart_scripts VALUES (4811, 0, 1, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Aquamancer - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (4811, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Aquamancer - Between 0-15% Health - Flee For Assist');

-- Aqua Guardian (6047)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6047;
DELETE FROM smart_scripts WHERE entryorguid=6047 AND source_type=0;
INSERT INTO smart_scripts VALUES (6047, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 15000, 22000, 11, 865, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aqua Guardian - In Combat - Cast Frost Nova');

-- Twilight Reaver (4810)
DELETE FROM creature_text WHERE entry=4810;
INSERT INTO creature_text VALUES (4810, 0, 0, 'Aku''mai demands more sacrifices, now you must die!', 12, 0, 100, 0, 0, 0, 0, 'Twilight Reaver');
INSERT INTO creature_text VALUES (4810, 0, 1, 'The Old Gods will be restored. You will not be allowed to interfere!', 12, 0, 100, 0, 0, 0, 0, 'Twilight Reaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4810;
DELETE FROM smart_scripts WHERE entryorguid=4810 AND source_type=0;
INSERT INTO smart_scripts VALUES (4810, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Reaver - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4810, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 5000, 11000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Reaver - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (4810, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Reaver - Between 0-15% Health - Flee For Assist');

-- Twilight Acolyte (4809)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4809;
DELETE FROM smart_scripts WHERE entryorguid=4809 AND source_type=0;
INSERT INTO smart_scripts VALUES (4809, 0, 0, 0, 14, 0, 100, 0, 400, 40, 4000, 4000, 11, 2055, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Twilight Acolyte - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4809, 0, 1, 0, 14, 0, 100, 0, 300, 40, 7000, 7000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Twilight Acolyte - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (4809, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Acolyte - Between 0-15% Health - Flee For Assist');

-- Deep Pool Threshfin (4827)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4827;
DELETE FROM smart_scripts WHERE entryorguid=4827 AND source_type=0;
INSERT INTO smart_scripts VALUES (4827, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 12000, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deep Pool Threshfin - In Combat - Cast Tendon Rip');

-- Twilight Shadowmage (4813)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4813;
DELETE FROM smart_scripts WHERE entryorguid=4813 AND source_type=0;
INSERT INTO smart_scripts VALUES (4813, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 12746, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowmage - Out of Combat - Cast Summon Voidwalker');
INSERT INTO smart_scripts VALUES (4813, 0, 1, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowmage - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (4813, 0, 2, 0, 0, 0, 100, 0, 5000, 15000, 30000, 35000, 11, 7645, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Twilight Shadowmage - In Combat - Cast Dominate Mind');
INSERT INTO smart_scripts VALUES (4813, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowmage - Between 0-15% Health - Flee For Assist');

-- Twilight Elementalist (4814)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4814;
DELETE FROM smart_scripts WHERE entryorguid=4814 AND source_type=0;
INSERT INTO smart_scripts VALUES (4814, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 9000, 12000, 11, 13728, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Twilight Elementalist - In Combat - Cast Earth Shock');
INSERT INTO smart_scripts VALUES (4814, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 13000, 17000, 11, 15039, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Twilight Elementalist - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (4814, 0, 2, 0, 0, 0, 100, 0, 1000, 2500, 11000, 15000, 11, 12548, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Elementalist - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (4814, 0, 3, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 11824, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Elementalist - In Combat - Cast Shock');






-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Ghamoo-ra (4887)
UPDATE creature_template SET Armor_mod=20, AIName='SmartAI', ScriptName='' WHERE entry=4887;
DELETE FROM smart_scripts WHERE entryorguid=4887 AND source_type=0;
INSERT INTO smart_scripts VALUES (4887, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghamoo-ra - In Combat - Cast Trample');

-- Lady Sarevess (4831)
DELETE FROM creature_text WHERE entry=4831;
INSERT INTO creature_text VALUES (4831, 0, 0, 'You should not be here! Ssslay them!', 14, 0, 100, 0, 0, 5799, 0, 'Lady Sarevess');
INSERT INTO creature_text VALUES (4831, 1, 0, 'Hearty Kill!', 14, 0, 100, 0, 0, 5801, 0, 'Lady Sarevess');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4831;
DELETE FROM smart_scripts WHERE entryorguid=4831 AND source_type=0;
INSERT INTO smart_scripts VALUES (4831, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4831, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - On Just Died - Say Line 1');
INSERT INTO smart_scripts VALUES (4831, 0, 2, 0, 0, 0, 100, 0, 0, 0, 2000, 3000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (4831, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 9000, 15000, 11, 8435, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - In Combat - Cast Forked Lightning');
INSERT INTO smart_scripts VALUES (4831, 0, 4, 0, 0, 0, 100, 0, 6000, 8500, 15000, 27000, 11, 865, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (4831, 0, 5, 0, 0, 0, 100, 0, 7000, 9000, 9000, 13000, 11, 246, 32, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Lady Sarevess - In Combat - Cast Slow');

-- Gelihast (6243)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6243;
DELETE FROM smart_scripts WHERE entryorguid=6243 AND source_type=0;
INSERT INTO smart_scripts VALUES (6243, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 5000, 9000, 11, 6533, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Gelihast - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (6243, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 34, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gelihast - On Just Died - Set Instance Data 0 to 3');
INSERT INTO smart_scripts VALUES (6243, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 14, 32610, 103015, 0, 0, 0, 0, 0, 'Gelihast - On Just Died - Remove Gameobject Flags');

-- Lorgus Jett (12902)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12902;
DELETE FROM smart_scripts WHERE entryorguid=12902 AND source_type=0;
INSERT INTO smart_scripts VALUES (12902, 0, 0, 0, 37, 0, 60, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lorgus Jett - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (12902, 0, 1, 0, 1, 0, 100, 0, 1000, 1000, 300000, 300000, 11, 12550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lorgus Jett - Out of Combat - Cast Lightning Shield');
INSERT INTO smart_scripts VALUES (12902, 0, 2, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 12167, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lorgus Jett - In Combat - Cast Lightning Bolt');

-- Baron Aquanis (12876)
DELETE FROM creature_text WHERE entry=12876;
INSERT INTO creature_text VALUES (12876, 0, 0, '%s emerges to protect the Fathom Stone!', 16, 0, 100, 0, 0, 0, 0, 'Baron Aquanis');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=12876;
DELETE FROM smart_scripts WHERE entryorguid=12876 AND source_type=0;
INSERT INTO smart_scripts VALUES (12876, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Aquanis - On AI Init - Say Line 0');
INSERT INTO smart_scripts VALUES (12876, 0, 1, 0, 0, 0, 100, 0, 500, 1000, 3000, 3500, 11, 15043, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Baron Aquanis - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (12876, 0, 2, 0, 0, 0, 100, 0, 5000, 11000, 16000, 23500, 11, 14907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Baron Aquanis - In Combat - Cast Frost Nova');

-- Old Serra'kis (4830)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4830;
DELETE FROM smart_scripts WHERE entryorguid=4830 AND source_type=0;

-- Twilight Lord Kelris (4832)
DELETE FROM creature_text WHERE entry=4832;
INSERT INTO creature_text VALUES (4832, 0, 0, 'Who dares disturb my meditation?', 14, 0, 100, 0, 0, 5802, 0, 'lord kelriss SAY_AGRRO');
INSERT INTO creature_text VALUES (4832, 1, 0, 'Sleep...', 14, 0, 100, 0, 0, 5804, 0, 'lord kelriss SAY_SLEEP');
INSERT INTO creature_text VALUES (4832, 2, 0, 'Just...Dust...', 14, 0, 100, 0, 0, 5803, 0, 'lord kelriss SAY_DEATH');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4832;
DELETE FROM smart_scripts WHERE entryorguid=4832 AND source_type=0;
INSERT INTO smart_scripts VALUES (4832, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4832, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - On Just Died - Say Line 2');
INSERT INTO smart_scripts VALUES (4832, 0, 2, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - Out of Combat - Cast Blackfathom Channeling');
INSERT INTO smart_scripts VALUES (4832, 0, 3, 0, 0, 0, 100, 0, 5000, 11000, 16000, 23500, 11, 8399, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - In Combat - Cast Sleep');
INSERT INTO smart_scripts VALUES (4832, 0, 4, 0, 31, 0, 100, 0, 8399, 0, 5000, 5000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - Spell Hit Target - Say Line 1');
INSERT INTO smart_scripts VALUES (4832, 0, 5, 0, 0, 0, 100, 0, 1000, 4000, 5000, 8000, 11, 15587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - In Combat - Cast Mind Blast');

-- Aku'mai (4829)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4829;
DELETE FROM smart_scripts WHERE entryorguid=4829 AND source_type=0;
INSERT INTO smart_scripts VALUES (4829, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 20000, 33500, 11, 3815, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai - In Combat - Cast Poison Cloud');
INSERT INTO smart_scripts VALUES (4829, 0, 1, 0, 0, 0, 100, 0, 5000, 11000, 16000, 23500, 11, 3490, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai - In Combat - Cast Frenzied Rage');
INSERT INTO smart_scripts VALUES (4829, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 34, 5, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai - On Just Died - Set Instance Data 5 to 3');
INSERT INTO smart_scripts VALUES (4829, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 14, 32935, 103016, 0, 0, 0, 0, 0, 'Gelihast - On Just Died - Remove Gameobject Flags');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Argent Guard Thaelrid (4787)
UPDATE creature_template SET unit_flags = unit_flags|768 WHERE entry=4787;

-- GO Shrine of Gelihast (103015)
UPDATE gameobject SET animprogress=0 WHERE Id=103015;
UPDATE gameobject_template SET flags=16, AIName='', ScriptName='' WHERE entry=103015;

-- Quest Baron Aquanis (6922)
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=177964;
DELETE FROM smart_scripts WHERE entryorguid=177964 AND source_type=1;
INSERT INTO smart_scripts VALUES(177964, 1, 0, 0, 70, 0, 100, 0, 3, 0, 0, 0, 12, 12876, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -776, -73.8, -45, 2.08, "On Just Deactivated - Summon Creature");

-- GO Fire of Aku'mai (21118)
-- GO Fire of Aku'mai (21119)
-- GO Fire of Aku'mai (21120)
-- GO Fire of Aku'mai (21121)
DELETE FROM creature_summon_groups WHERE summonerId IN(21118, 21119, 21120, 21121) AND summonerType=1;
INSERT INTO creature_summon_groups VALUES (21118, 1, 1, 4825, -775.431, -153.853, -25.871, 3.207, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21118, 1, 1, 4825, -775.404, -174.132, -25.871, 3.185, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21118, 1, 1, 4825, -862.430, -154.937, -25.871, 0.060, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21118, 1, 1, 4825, -862.193, -174.251, -25.871, 6.182, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21119, 1, 1, 4977, -775.431, -153.853, -25.871, 3.207, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21119, 1, 1, 4977, -775.404, -174.132, -25.871, 3.185, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21119, 1, 1, 4977, -862.430, -154.937, -25.871, 0.060, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21119, 1, 1, 4977, -862.193, -174.251, -25.871, 6.182, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21120, 1, 1, 4823, -775.431, -153.853, -25.871, 3.207, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21120, 1, 1, 4823, -775.404, -174.132, -25.871, 3.185, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21120, 1, 1, 4823, -862.430, -154.937, -25.871, 0.060, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21120, 1, 1, 4823, -862.193, -174.251, -25.871, 6.182, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21121, 1, 1, 4978, -775.404, -174.132, -25.871, 3.185, 4, 60000);
INSERT INTO creature_summon_groups VALUES (21121, 1, 1, 4978, -862.430, -154.937, -25.871, 0.060, 4, 60000);
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(21118, 21119, 21120, 21121);
DELETE FROM smart_scripts WHERE entryorguid IN(21118, 21119, 21120, 21121) AND source_type=1;
INSERT INTO smart_scripts VALUES (21118, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Set Instance Data 1 to 3');
INSERT INTO smart_scripts VALUES (21118, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (21119, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 2, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Set Instance Data 2 to 3');
INSERT INTO smart_scripts VALUES (21119, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (21120, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Set Instance Data 3 to 3');
INSERT INTO smart_scripts VALUES (21120, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Summon Creature Group');
INSERT INTO smart_scripts VALUES (21121, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 34, 4, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Set Instance Data 4 to 3');
INSERT INTO smart_scripts VALUES (21121, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 'Fire of Aku''mai - On Gossip Hello - Summon Creature Group');

-- Aku'mai Snapjaw (4825)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4825;
DELETE FROM smart_scripts WHERE entryorguid=4825 AND source_type=0;
INSERT INTO smart_scripts VALUES (4825, 0, 0, 0, 0, 0, 100, 0, 1900, 7000, 11000, 18000, 11, 8391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai Snapjaw - In Combat - Cast Ravage');
INSERT INTO smart_scripts VALUES (4825, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai Snapjaw - Is Summoned - Set In Combat With Zone');

-- Murkshallow Softshell (4977)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4977;
DELETE FROM smart_scripts WHERE entryorguid=4977 AND source_type=0;
INSERT INTO smart_scripts VALUES (4977, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murkshallow Softshell - Is Summoned - Set In Combat With Zone');

-- Barbed Crustacean (4823)
REPLACE INTO creature_template_addon VALUES (4823, 0, 0, 0, 4097, 0, '9464');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4823;
DELETE FROM smart_scripts WHERE entryorguid=4823 AND source_type=0;
INSERT INTO smart_scripts VALUES (4823, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Barbed Crustacean - Is Summoned - Set In Combat With Zone');

-- Aku'mai Servant (4978)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4978;
DELETE FROM smart_scripts WHERE entryorguid=4978 AND source_type=0;
INSERT INTO smart_scripts VALUES (4978, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 17000, 11, 15043, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai Servant - In Combat - Cast Frostbolt Volley');
INSERT INTO smart_scripts VALUES (4978, 0, 1, 0, 0, 0, 100, 0, 5000, 11000, 16000, 23500, 11, 865, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai Servant - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (4978, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aku''mai Servant - Is Summoned - Set In Combat With Zone');

-- Morridune (6729)
DELETE FROM creature_text WHERE entry=6729;
INSERT INTO creature_text VALUES (6729, 0, 0, 'Aku''mai is dead! At last, I can leave this wretched place.', 14, 0, 100, 0, 0, 0, 0, 'morridune SAY_MORRIDUNE_1');
INSERT INTO creature_text VALUES (6729, 1, 0, 'Speak with me to hear my tale.', 12, 0, 100, 0, 0, 0, 0, 'morridune SAY_MORRIDUNE_2');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6729;
DELETE FROM smart_scripts WHERE entryorguid=6729 AND source_type=0;
INSERT INTO smart_scripts VALUES (6729, 0, 0, 1, 25, 0, 100, 257, 0, 0, 0, 0, 53, 0, 6729, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Morridune - On Reset - Start WP');
INSERT INTO smart_scripts VALUES (6729, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Morridune - On Reset - Say Line 0');
INSERT INTO smart_scripts VALUES (6729, 0, 2, 3, 40, 0, 100, 0, 4, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Morridune - On WP Reached - Say Line 1');
INSERT INTO smart_scripts VALUES (6729, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.50, 'Morridune - On WP Reached - Set Orientation');
INSERT INTO smart_scripts VALUES (6729, 0, 4, 5, 62, 0, 100, 0, 321, 0, 0, 0, 11, 9268, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Morridune - On Gossip Select - Cast Teleport to Darnassus - Event');
INSERT INTO smart_scripts VALUES (6729, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Morridune - On Gossip Select - Close Gossip');
DELETE FROM script_waypoint WHERE entry=6729;
DELETE FROM waypoints WHERE entry=6729;
INSERT INTO waypoints VALUES (6729, 1, -861.803, -460.36, -33.8918, 'Morridune');
INSERT INTO waypoints VALUES (6729, 2, -856.168, -464.425, -33.9223, 'Morridune');
INSERT INTO waypoints VALUES (6729, 3, -849.964, -469.231, -34.0381, 'Morridune');
INSERT INTO waypoints VALUES (6729, 4, -839.838, -473.654, -34.0535, 'Morridune');

-- SPELL Teleport to Darnassus - Event (9268)
DELETE FROM spell_target_position WHERE id=9268;
INSERT INTO spell_target_position VALUES (9268, 0, 1, 8786.36, 967.445, 30.197, 3.39632);

-- GO Altar of the Deeps (103016)
UPDATE gameobject SET animprogress=0 WHERE Id=103016;
UPDATE gameobject_template SET flags=16, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=103016;
DELETE FROM smart_scripts WHERE entryorguid=103016 AND source_type=1;
INSERT INTO smart_scripts VALUES (103016, 1, 0, 0, 64, 0, 100, 257, 0, 0, 0, 0, 12, 6729, 8, 0, 0, 0, 0, 8, 0, 0, 0, -863.895, -458.899, -33.891, 5.637, 'Altar of the Deeps - On Gossip Hello - Summon Creature');

-- GO Shrine of Gelihast (94039), trap trigger
DELETE FROM gameobject WHERE id=94039;
INSERT INTO gameobject VALUES (NULL, 94039, 48, 1, 1, -413.324, 43.6505, -47.9681, 3.14159, 0, 0, 1, 0, 86400, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 94039, 48, 1, 1, -839.619, -477.904, -33.7343, 3.14159, 0, 0, 1, 0, 86400, 100, 1, 0);

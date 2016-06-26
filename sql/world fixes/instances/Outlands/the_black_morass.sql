
UPDATE creature SET spawntimesecs=86400 WHERE map=269 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Sable Jaguar (18982, 22173)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=18982);
REPLACE INTO creature_template_addon VALUES (18982, 0, 0, 0, 0, 0, '22766 18950');
REPLACE INTO creature_template_addon VALUES (22173, 0, 0, 0, 0, 0, '22766 18950');
UPDATE creature_template SET baseattacktime=1000, skinloot=70065, AIName='', ScriptName='' WHERE entry=18982;
UPDATE creature_template SET baseattacktime=1000, skinloot=70065, AIName='', ScriptName='' WHERE entry=22173;
DELETE FROM smart_scripts WHERE entryorguid=18982 AND source_type=0;

-- Blackfang Tarantula (18983, 22162)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=18983);
REPLACE INTO creature_template_addon VALUES (18983, 0, 0, 0, 0, 0, '34365');
REPLACE INTO creature_template_addon VALUES (22162, 0, 0, 0, 0, 0, '34365');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18983;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=22162;
DELETE FROM smart_scripts WHERE entryorguid=18983 AND source_type=0;

-- Darkwater Crocolisk (17952, 22163)
UPDATE creature_template SET skinloot=17952, AIName='SmartAI', ScriptName='' WHERE entry=17952;
UPDATE creature_template SET skinloot=17952, AIName='', ScriptName='' WHERE entry=22163;
DELETE FROM smart_scripts WHERE entryorguid=17952 AND source_type=0;
INSERT INTO smart_scripts VALUES(17952, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 5000, 7000, 11, 34370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkwater Crocolisk - In Combat - Cast Spell Jagged Tooth Snap');

-- Rift Lord (17839, 20744)
DELETE FROM creature_text WHERE entry=17839;
INSERT INTO creature_text VALUES (17839, 0, 0, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 0, 1, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 0, 2, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 1, 1, 'Victory or death!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 1, 2, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 2, 0, 'No! The rift...', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 2, 1, 'You will accomplish nothing!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (17839, 2, 2, 'You will never defeat us all!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
UPDATE creature_template SET faction=1720, minlevel=70, maxlevel=70, lootid=17839, difficulty_entry_1=20744, skinloot=70065, mechanic_immune_mask=2048, AIName='SmartAI', ScriptName='' WHERE entry=17839;
UPDATE creature_template SET faction=1720, minlevel=71, maxlevel=71, lootid=17839, skinloot=70065, dmg_multiplier=13, mechanic_immune_mask=2048, AIName='', ScriptName='' WHERE entry=20744;
DELETE FROM smart_scripts WHERE entryorguid=17839 AND source_type=0;
INSERT INTO smart_scripts VALUES(17839, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Respawn - Talk');
INSERT INTO smart_scripts VALUES(17839, 0, 1, 0, 4, 0, 50, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Aggro - Talk');
INSERT INTO smart_scripts VALUES(17839, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Death - Talk');
INSERT INTO smart_scripts VALUES(17839, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - Health Between 0-20% - Cast Spell Frenzy');
INSERT INTO smart_scripts VALUES(17839, 0, 4, 0, 0, 0, 100, 0, 6000, 9000, 15000, 17000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Hamstring');
INSERT INTO smart_scripts VALUES(17839, 0, 5, 0, 0, 0, 100, 0, 3000, 3000, 15000, 17000, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Knockdown');
INSERT INTO smart_scripts VALUES(17839, 0, 6, 0, 0, 0, 100, 2, 0, 0, 10000, 10000, 11, 35054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Mortal Strike');
INSERT INTO smart_scripts VALUES(17839, 0, 7, 0, 0, 0, 100, 4, 0, 0, 10000, 10000, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Mortal Strike');

-- Rift Lord (21140, 22172)
DELETE FROM creature_text WHERE entry=21140;
INSERT INTO creature_text VALUES (21140, 0, 0, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 0, 1, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 0, 2, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 1, 1, 'Victory or death!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 1, 2, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 2, 0, 'No! The rift...', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 2, 1, 'You will accomplish nothing!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
INSERT INTO creature_text VALUES (21140, 2, 2, 'You will never defeat us all!', 14, 0, 100, 0, 0, 0, 0, 'Rift Lord');
UPDATE creature_template SET KillCredit1=17839, difficulty_entry_1=22172, baseattacktime=1449, minlevel=70, maxlevel=70, faction=1720, unit_flags=0, lootid=17839, skinloot=70065, mingold=2880, maxgold=3766, mechanic_immune_mask=2048, AIName='SmartAI', ScriptName='' WHERE entry=21140;
UPDATE creature_template SET faction=1720, minlevel=71, maxlevel=71, KillCredit1=17839, lootid=17839, skinloot=70065, mechanic_immune_mask=2048, AIName='', ScriptName='' WHERE entry=22172;
DELETE FROM smart_scripts WHERE entryorguid=21140 AND source_type=0;
INSERT INTO smart_scripts VALUES(21140, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Respawn - Talk');
INSERT INTO smart_scripts VALUES(21140, 0, 1, 0, 4, 0, 50, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Aggro - Talk');
INSERT INTO smart_scripts VALUES(21140, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Death - Talk');
INSERT INTO smart_scripts VALUES(21140, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - Health Between 0-20% - Cast Spell Frenzy');
INSERT INTO smart_scripts VALUES(21140, 0, 4, 0, 0, 0, 100, 0, 4000, 4000, 5000, 7000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Sunder Armor');
INSERT INTO smart_scripts VALUES(21140, 0, 5, 0, 0, 0, 100, 2, 1000, 1000, 10000, 10000, 11, 36214, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Thunderclap');
INSERT INTO smart_scripts VALUES(21140, 0, 6, 0, 0, 0, 100, 4, 1000, 1000, 10000, 10000, 11, 38537, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast Spell Thunderclap');

-- Rift Keeper (21104, 22170)
DELETE FROM creature_text WHERE entry=21104;
INSERT INTO creature_text VALUES (21104, 0, 0, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 0, 1, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 0, 2, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 1, 1, 'Victory or death!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 1, 2, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 2, 0, 'No! The rift...', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 2, 1, 'You will accomplish nothing!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21104, 2, 2, 'You will never defeat us all!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
UPDATE creature_template SET faction=1720, minlevel=70, maxlevel=70, lootid=21104, difficulty_entry_1=22170, skinloot=70065, mechanic_immune_mask=2048, AIName='SmartAI', ScriptName='' WHERE entry=21104;
UPDATE creature_template SET faction=1720, minlevel=71, maxlevel=71, baseattacktime=1449, dmg_multiplier=13, lootid=21104, skinloot=70065, mechanic_immune_mask=2048, AIName='', ScriptName='' WHERE entry=22170;
DELETE FROM smart_scripts WHERE entryorguid=21104 AND source_type=0;
INSERT INTO smart_scripts VALUES(21104, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Respawn - Talk');
INSERT INTO smart_scripts VALUES(21104, 0, 1, 0, 4, 0, 50, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Aggro - Talk');
INSERT INTO smart_scripts VALUES(21104, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Death - Talk');
INSERT INTO smart_scripts VALUES(21104, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Health Between 0-20% - Cast Spell Frenzy');
INSERT INTO smart_scripts VALUES(21104, 0, 4, 0, 0, 0, 100, 0, 6000, 9000, 20000, 25000, 11, 36276, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Curse of Vulnerability');
INSERT INTO smart_scripts VALUES(21104, 0, 5, 0, 0, 0, 100, 0, 4000, 4000, 15000, 17000, 11, 12542, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Fear');
INSERT INTO smart_scripts VALUES(21104, 0, 6, 0, 0, 0, 100, 2, 1000, 1000, 6000, 6000, 11, 36275, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES(21104, 0, 7, 0, 0, 0, 100, 4, 1000, 1000, 6000, 6000, 11, 38533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Shadow Bolt Volley');

-- Rift Keeper (21148, 22171)
DELETE FROM creature_text WHERE entry=21148;
INSERT INTO creature_text VALUES (21148, 0, 0, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 0, 1, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 0, 2, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 1, 1, 'Victory or death!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 1, 2, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 2, 0, 'No! The rift...', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 2, 1, 'You will accomplish nothing!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
INSERT INTO creature_text VALUES (21148, 2, 2, 'You will never defeat us all!', 14, 0, 100, 0, 0, 0, 0, 'Rift Keeper');
UPDATE creature_template SET KillCredit1=21104, baseattacktime=1449, minlevel=70, maxlevel=70, faction=1720, unit_flags=0, lootid=21104, difficulty_entry_1=22171, skinloot=70065, mechanic_immune_mask=2048, mingold=2285, maxgold=2989, AIName='SmartAI', ScriptName='' WHERE entry=21148;
UPDATE creature_template SET KillCredit1=21104, minlevel=71, maxlevel=71, faction=1720, baseattacktime=1449, dmg_multiplier=13, lootid=21104, skinloot=70065, mechanic_immune_mask=2048, AIName='', ScriptName='' WHERE entry=22171;
DELETE FROM smart_scripts WHERE entryorguid=21148 AND source_type=0;
INSERT INTO smart_scripts VALUES(21148, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Respawn - Talk');
INSERT INTO smart_scripts VALUES(21148, 0, 1, 0, 4, 0, 50, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Aggro - Talk');
INSERT INTO smart_scripts VALUES(21148, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Death - Talk');
INSERT INTO smart_scripts VALUES(21148, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Health Between 0-20% - Cast Spell Frenzy');
INSERT INTO smart_scripts VALUES(21148, 0, 4, 0, 0, 0, 100, 0, 4000, 4000, 15000, 17000, 11, 13323, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Polymorph');
INSERT INTO smart_scripts VALUES(21148, 0, 5, 0, 0, 0, 100, 2, 1000, 1000, 7000, 7000, 11, 36279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Frostbolt');
INSERT INTO smart_scripts VALUES(21148, 0, 6, 0, 0, 0, 100, 4, 1000, 1000, 7000, 7000, 11, 38534, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Frostbolt');
INSERT INTO smart_scripts VALUES(21148, 0, 7, 0, 0, 0, 100, 2, 3500, 3500, 7000, 7000, 11, 36277, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Pyroblast');
INSERT INTO smart_scripts VALUES(21148, 0, 8, 0, 0, 0, 100, 4, 3500, 3500, 7000, 7000, 11, 38535, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast Spell Pyroblast');
INSERT INTO smart_scripts VALUES(21148, 0, 9, 0, 9, 0, 100, 2, 0, 9, 15000, 15000, 11, 36278, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Within Range 0-9yd - Cast Spell Blast Wave');
INSERT INTO smart_scripts VALUES(21148, 0, 10, 0, 9, 0, 100, 4, 0, 9, 15000, 15000, 11, 38536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Within Range 0-9yd - Cast Spell Blast Wave');

-- Infinite Assassin (17835, 22164)
DELETE FROM creature_text WHERE entry=17835;
INSERT INTO creature_text VALUES (17835, 0, 0, 'More will take my place.', 12, 0, 100, 0, 0, 0, 0, 'Infinite Assassin');
INSERT INTO creature_text VALUES (17835, 0, 1, 'We will not be stopped!', 12, 0, 100, 0, 0, 0, 0, 'Infinite Assassin');
INSERT INTO creature_text VALUES (17835, 0, 2, 'Your efforts... are in vain.', 12, 0, 100, 0, 0, 0, 0, 'Infinite Assassin');
UPDATE creature_template SET faction=1720, AIName='SmartAI', ScriptName='' WHERE entry=17835;
UPDATE creature_template SET faction=1720, AIName='', ScriptName='' WHERE entry=22164;
DELETE FROM smart_scripts WHERE entryorguid=17835 AND source_type=0;
INSERT INTO smart_scripts VALUES(17835, 0, 0, 0, 6, 0, 50, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Assassin - On Death - Talk');
INSERT INTO smart_scripts VALUES(17835, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 15000, 17000, 11, 30832, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Assassin - In Combat - Cast Spell Kidney Shot');
INSERT INTO smart_scripts VALUES(17835, 0, 2, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Assassin - Behind Target - Cast Spell Backstab');
INSERT INTO smart_scripts VALUES(17835, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31326, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Assassin - On Reset - Cast Spell Corrupt Medivh');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17835;
INSERT INTO conditions VALUES(22, 4, 17835, 0, 0, 29, 1, 15608, 20, 0, 0, 0, 0, '', 'Requires Medivh in 20yd');

-- Infinite Chronomancer (17892, 20741)
DELETE FROM creature_text WHERE entry=17892;
INSERT INTO creature_text VALUES (17892, 0, 0, 'We are not finished!', 12, 0, 100, 0, 0, 0, 0, 'Infinite Chronomancer');
UPDATE creature_template SET faction=1720, AIName='SmartAI', ScriptName='' WHERE entry=17892;
UPDATE creature_template SET faction=1720, AIName='', ScriptName='' WHERE entry=20741;
DELETE FROM smart_scripts WHERE entryorguid=17892 AND source_type=0;
INSERT INTO smart_scripts VALUES(17892, 0, 0, 0, 6, 0, 50, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - On Death - Talk');
INSERT INTO smart_scripts VALUES(17892, 0, 1, 0, 0, 0, 100, 2, 0, 0, 1500, 1500, 11, 15124, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - In Combat - Cast Spell Arcane Bolt');
INSERT INTO smart_scripts VALUES(17892, 0, 2, 0, 0, 0, 100, 4, 0, 0, 1500, 1500, 11, 15230, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - In Combat - Cast Spell Arcane Bolt');
INSERT INTO smart_scripts VALUES(17892, 0, 3, 0, 9, 0, 100, 2, 0, 9, 10000, 10000, 11, 33860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - Within Range 0-9yd - Cast Spell Arcane Explosion');
INSERT INTO smart_scripts VALUES(17892, 0, 4, 0, 9, 0, 100, 4, 0, 9, 10000, 10000, 11, 33623, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - Within Range 0-9yd - Cast Spell Arcane Explosion');
INSERT INTO smart_scripts VALUES(17892, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31326, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Chronomancer - On Reset - Cast Spell Corrupt Medivh');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17892;
INSERT INTO conditions VALUES(22, 6, 17892, 0, 0, 29, 1, 15608, 20, 0, 0, 0, 0, '', 'Requires Medivh in 20yd');

-- Infinite Executioner (18994, 22166)
DELETE FROM creature_text WHERE entry=18994;
INSERT INTO creature_text VALUES (18994, 0, 0, 'More will take my place.', 12, 0, 100, 0, 0, 0, 0, 'Infinite Executioner');
INSERT INTO creature_text VALUES (18994, 0, 1, 'We will not be stopped!', 12, 0, 100, 0, 0, 0, 0, 'Infinite Executioner');
INSERT INTO creature_text VALUES (18994, 0, 2, 'Your efforts... are in vain.', 12, 0, 100, 0, 0, 0, 0, 'Infinite Executioner');
UPDATE creature_template SET faction=1720, AIName='SmartAI', ScriptName='' WHERE entry=18994;
UPDATE creature_template SET faction=1720, rank=0, dmg_multiplier=1, AIName='', ScriptName='' WHERE entry=22166;
DELETE FROM smart_scripts WHERE entryorguid=18994 AND source_type=0;
INSERT INTO smart_scripts VALUES(18994, 0, 0, 0, 6, 0, 50, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Executioner - On Death - Talk');
INSERT INTO smart_scripts VALUES(18994, 0, 1, 0, 0, 0, 100, 2, 0, 0, 5000, 5000, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Executioner - In Combat - Cast Spell Strike');
INSERT INTO smart_scripts VALUES(18994, 0, 2, 0, 0, 0, 100, 4, 0, 0, 5000, 5000, 11, 34920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Infinite Executioner - In Combat - Cast Spell Strike');
INSERT INTO smart_scripts VALUES(18994, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31326, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Executioner - On Reset - Cast Spell Corrupt Medivh');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=18994;
INSERT INTO conditions VALUES(22, 4, 18994, 0, 0, 29, 1, 15608, 20, 0, 0, 0, 0, '', 'Requires Medivh in 20yd');

-- Infinite Vanquisher (18995, 22168)
DELETE FROM creature_text WHERE entry=18995;
INSERT INTO creature_text VALUES (18995, 0, 0, 'We are not finished!', 12, 0, 100, 0, 0, 0, 0, 'Infinite Vanquisher');
UPDATE creature_template SET faction=1720, AIName='SmartAI', ScriptName='' WHERE entry=18995;
UPDATE creature_template SET faction=1720, AIName='', ScriptName='' WHERE entry=22168;
DELETE FROM smart_scripts WHERE entryorguid=18995 AND source_type=0;
INSERT INTO smart_scripts VALUES(18995, 0, 0, 0, 6, 0, 50, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - On Death - Talk');
INSERT INTO smart_scripts VALUES(18995, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2000, 2000, 11, 15241, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - In Combat - Cast Spell Scorch');
INSERT INTO smart_scripts VALUES(18995, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2000, 2000, 11, 36807, 64, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - In Combat - Cast Spell Scorch');
INSERT INTO smart_scripts VALUES(18995, 0, 3, 0, 9, 0, 100, 2, 6000, 7000, 10000, 10000, 11, 13341, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - In Combat - Cast Spell Fire Blast');
INSERT INTO smart_scripts VALUES(18995, 0, 4, 0, 9, 0, 100, 4, 6000, 7000, 10000, 10000, 11, 38526, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - In Combat - Cast Spell Fire Blast');
INSERT INTO smart_scripts VALUES(18995, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31326, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Vanquisher - On Reset - Cast Spell Corrupt Medivh');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=18995;
INSERT INTO conditions VALUES(22, 6, 18995, 0, 0, 29, 1, 15608, 20, 0, 0, 0, 0, '', 'Requires Medivh in 20yd');

-- Infinite Whelp (21818, 22169)
UPDATE creature_template SET faction=1720, AIName='SmartAI', ScriptName='' WHERE entry=21818;
UPDATE creature_template SET faction=1720, AIName='', ScriptName='' WHERE entry=22169;
DELETE FROM smart_scripts WHERE entryorguid=21818 AND source_type=0;
INSERT INTO smart_scripts VALUES(21818, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 31326, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Infinite Whelp - On Reset - Cast Spell Corrupt Medivh');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=21818;
INSERT INTO conditions VALUES(22, 1, 21818, 0, 0, 29, 1, 15608, 20, 0, 0, 0, 0, '', 'Requires Medivh in 20yd');

-- SPELL Corrupt Medivh (31326)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (31326);
INSERT INTO conditions VALUES(13, 1, 31326, 0, 0, 31, 0, 3, 15608, 0, 0, 0, 0, '', 'Target Medivh');
DELETE FROM spell_script_names WHERE spell_id IN(31326);
INSERT INTO spell_script_names VALUES(31326, 'spell_black_morass_corrupt_medivh');

-- SPELL Corrupt Medivh (37853)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (37853);
INSERT INTO conditions VALUES(13, 1, 37853, 0, 0, 31, 0, 3, 15608, 0, 0, 0, 0, '', 'Target Medivh');
DELETE FROM spell_script_names WHERE spell_id IN(37853);
INSERT INTO spell_script_names VALUES(37853, 'spell_black_morass_corrupt_medivh');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- SPELL Banish Dragon Helper (31550)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (31550);
INSERT INTO conditions VALUES(13, 1, 31550, 0, 0, 31, 0, 3, 17918, 0, 0, 0, 0, '', 'Target Time Keeper');

-- Chrono Lord Deja (17879, 20738)
DELETE FROM creature_text WHERE entry=17879;
INSERT INTO creature_text VALUES (17879, 0, 0, 'Why do you aid the Magus? Just think of how many lives could be saved if the portal is never opened, if the resulting wars could be erased...', 14, 0, 100, 0, 0, 10412, 0, 'chrono lord deja SAY_ENTER');
INSERT INTO creature_text VALUES (17879, 1, 0, 'If you will not cease this foolish quest, then you will die!', 14, 0, 100, 0, 0, 10414, 0, 'chrono lord deja SAY_AGGRO');
INSERT INTO creature_text VALUES (17879, 2, 0, 'You have outstayed your welcome, Timekeeper. Begone!', 14, 0, 100, 0, 0, 10413, 0, 'chrono lord deja SAY_BANISH');
INSERT INTO creature_text VALUES (17879, 3, 0, 'I told you it was a fool''s quest!', 14, 0, 100, 0, 0, 10415, 0, 'chrono lord deja SAY_SLAY1');
INSERT INTO creature_text VALUES (17879, 3, 1, 'Leaving so soon?', 14, 0, 100, 0, 0, 10416, 0, 'chrono lord deja SAY_SLAY2');
INSERT INTO creature_text VALUES (17879, 4, 0, 'Time ... is on our side.', 14, 0, 100, 0, 0, 10417, 0, 'chrono lord deja SAY_DEATH');
UPDATE creature_template SET skinloot=70066, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_chrono_lord_deja' WHERE entry=17879;
UPDATE creature_template SET skinloot=70066, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=20738;

-- Infinite Chrono-Lord (21697, 21712)
UPDATE creature_template SET baseattacktime=1400, faction=168, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_chrono_lord_deja' WHERE entry=21697;
UPDATE creature_template SET baseattacktime=1400, faction=168, minlevel=73, maxlevel=73, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=21712;
DELETE FROM smart_scripts WHERE entryorguid=21697 AND source_type=0;

-- Temporus (17880, 20745)
DELETE FROM creature_text WHERE entry=17880;
INSERT INTO creature_text VALUES (17880, 0, 0, 'Why do you persist? Surely you can see the futility of it all. It is not too late! You may still leave with your lives...', 14, 0, 100, 0, 0, 10442, 0, 'temporus SAY_ENTER');
INSERT INTO creature_text VALUES (17880, 1, 0, 'So be it ... you have been warned.', 14, 0, 100, 0, 0, 10444, 0, 'temporus SAY_AGGRO');
INSERT INTO creature_text VALUES (17880, 2, 0, 'Time... sands of time is run out for you.', 14, 0, 100, 0, 0, 10443, 0, 'temporus SAY_BANISH');
INSERT INTO creature_text VALUES (17880, 3, 0, 'You should have left when you had the chance.', 14, 0, 100, 0, 0, 10445, 0, 'temporus SAY_SLAY1');
INSERT INTO creature_text VALUES (17880, 3, 1, 'Your days are done.', 14, 0, 100, 0, 0, 10446, 0, 'temporus SAY_SLAY2');
INSERT INTO creature_text VALUES (17880, 4, 0, 'My death means ... little.', 14, 0, 100, 0, 0, 10447, 0, 'temporus SAY_DEATH');
UPDATE creature_template SET skinloot=70066, mechanic_immune_mask=650854271, flags_extra=256|0x200000, AIName='', ScriptName='boss_temporus' WHERE entry=17880;
UPDATE creature_template SET skinloot=70066, mechanic_immune_mask=650854271, flags_extra=257|0x200000, AIName='', ScriptName='' WHERE entry=20745;

-- Infinite Timereaver (21698, 22167)
UPDATE creature_template SET baseattacktime=1400, faction=168, mechanic_immune_mask=650854271, flags_extra=256|0x200000, AIName='', ScriptName='boss_temporus' WHERE entry=21698;
UPDATE creature_template SET baseattacktime=1400, faction=168, minlevel=73, maxlevel=73, mechanic_immune_mask=650854271, flags_extra=257|0x200000, AIName='', ScriptName='' WHERE entry=22167;
DELETE FROM smart_scripts WHERE entryorguid=21698 AND source_type=0;

-- Aeonus (17881, 20737)
DELETE FROM creature_text WHERE entry=17881;
INSERT INTO creature_text VALUES (17881, 0, 0, 'The time has come to shatter this clockwork universe forever! Let us no longer be slaves of the hourglass! I warn you: those who do not embrace the greater path shall become victims of its passing!', 14, 0, 100, 0, 0, 10400, 0, 'aeonus SAY_ENTER');
INSERT INTO creature_text VALUES (17881, 1, 0, 'Let us see what fate lays in store...', 14, 0, 100, 0, 0, 10402, 0, 'aeonus SAY_AGGRO');
INSERT INTO creature_text VALUES (17881, 2, 0, 'Your time is up, slave of the past!', 14, 0, 100, 0, 0, 10401, 0, 'aeonus SAY_BANISH');
INSERT INTO creature_text VALUES (17881, 3, 0, 'One less obstacle in our way!', 14, 0, 100, 0, 0, 10403, 0, 'aeonus SAY_SLAY1');
INSERT INTO creature_text VALUES (17881, 3, 1, 'No one can stop us! No one!', 14, 0, 100, 0, 0, 10404, 0, 'aeonus SAY_SLAY2');
INSERT INTO creature_text VALUES (17881, 4, 0, 'It is only a matter...of time.', 14, 0, 100, 0, 0, 10405, 0, 'aeonus SAY_DEATH');
INSERT INTO creature_text VALUES (17881, 5, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'aeonus EMOTE_FRENZY');
UPDATE creature_template SET speed_run=1.71429, skinloot=70066, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_aeonus' WHERE entry=17881;
UPDATE creature_template SET speed_run=1.71429, skinloot=70066, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=20737;


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Time Keeper (17918, 20746)
DELETE FROM creature_text WHERE entry=17918;
INSERT INTO creature_text VALUES (17918, 0, 0, 'We must use this time wisely!', 12, 0, 100, 0, 0, 0, 0, 'Time Keeper');
INSERT INTO creature_text VALUES (17918, 1, 0, 'Continue the fight! Do not falter!', 14, 0, 100, 0, 0, 0, 0, 'Time Keeper');
INSERT INTO creature_text VALUES (17918, 1, 1, 'Carry on! Victory at all costs!', 14, 0, 100, 0, 0, 0, 0, 'Time Keeper');
UPDATE creature_template SET faction=1718, AIName='SmartAI', ScriptName='' WHERE entry=17918;
UPDATE creature_template SET faction=1718, AIName='', ScriptName='' WHERE entry=20746;
DELETE FROM smart_scripts WHERE entryorguid=17918 AND source_type=0;
INSERT INTO smart_scripts VALUES(17918, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 15000, 15000, 11, 31478, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Time Keeper - In Combat - Cast Spell Sand Breath');
INSERT INTO smart_scripts VALUES(17918, 0, 1, 0, 8, 0, 100, 0, 31550, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time Keeper - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES(17918, 0, 2, 3, 11, 0, 100, 0, 31550, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time Keeper - On Respawn - Despawn');
INSERT INTO smart_scripts VALUES(17918, 0, 3, 0, 61, 0, 100, 0, 31550, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time Keeper - On Respawn - Talk');
INSERT INTO smart_scripts VALUES(17918, 0, 4, 0, 60, 0, 100, 1, 29000, 29000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time Keeper - On Update - Talk');

-- Sa'at (20201)
DELETE FROM gossip_menu WHERE entry=8088;
INSERT INTO gossip_menu VALUES (8088, 10000),(8088, 10001),(8088, 10002);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=8088;
INSERT INTO conditions VALUES(14, 8088, 10002, 0, 0, 2, 0, 24289, 1, 0, 0, 0, 0, '', 'Requires Item');
INSERT INTO conditions VALUES(14, 8088, 10002, 0, 1, 14, 0, 10297, 0, 0, 0, 0, 0, '', 'Requires No Quest Status');
INSERT INTO conditions VALUES(14, 8088, 10000, 0, 0, 2, 0, 24289, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(14, 8088, 10000, 0, 0, 14, 0, 10297, 0, 0, 1, 0, 0, '', 'Requires Quest Status');
INSERT INTO conditions VALUES(14, 8088, 10000, 0, 0, 8, 0, 10297, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(14, 8088, 10001, 0, 0, 2, 0, 24289, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(14, 8088, 10001, 0, 0, 8, 0, 10297, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
DELETE FROM gossip_menu_option WHERE menu_id=8088;
INSERT INTO gossip_menu_option VALUES (8088, 0, 0, 'Sa''at, I have lost the chrono-beacon and require another!', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8088, 1, 0, 'I requires a chrono-beacon, Sa''at.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8088;
INSERT INTO conditions VALUES(15, 8088, 0, 0, 0, 2, 0, 24289, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(15, 8088, 0, 0, 0, 14, 0, 10297, 0, 0, 1, 0, 0, '', 'Requires Quest Status');
INSERT INTO conditions VALUES(15, 8088, 0, 0, 0, 8, 0, 10297, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 8088, 0, 0, 0, 13, 0, 14, 0, 0, 0, 0, 0, '', 'Requires Instance Data');
INSERT INTO conditions VALUES(15, 8088, 1, 0, 0, 2, 0, 24289, 1, 0, 1, 0, 0, '', 'Requires No Item');
INSERT INTO conditions VALUES(15, 8088, 1, 0, 0, 8, 0, 10297, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 8088, 1, 0, 0, 13, 0, 14, 0, 0, 0, 0, 0, '', 'Requires Instance Data');
DELETE FROM creature_text WHERE entry=20201;
INSERT INTO creature_text VALUES (20201, 0, 0, 'Do not go any further, mortal. You are ill-prepared to face the forces of the Infinite Dragonflight. Come, let me help you.', 12, 0, 100, 1, 0, 0, 0, 'Sa''at');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20201;
DELETE FROM smart_scripts WHERE entryorguid=20201 AND source_type=0;
INSERT INTO smart_scripts VALUES(20201, 0, 0, 0, 10, 0, 100, 257, 1, 15, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sa''at - Out of Combat LoS - Talk');
INSERT INTO smart_scripts VALUES(20201, 0, 1, 3, 62, 0, 100, 0, 8088, 0, 0, 0, 11, 34975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sa''at - On Gossip Select - Cast Spell');
INSERT INTO smart_scripts VALUES(20201, 0, 2, 3, 62, 0, 100, 0, 8088, 1, 0, 0, 11, 34975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sa''at - On Gossip Select - Cast Spell');
INSERT INTO smart_scripts VALUES(20201, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sa''at - On Gossip Select - Close Gossip');

-- Medivh (15608)
DELETE FROM creature_text WHERE entry=15608;
INSERT INTO creature_text VALUES (15608, 0, 0, 'The shield is nearly gone! All that I have worked for is in danger!', 14, 0, 100, 0, 0, 10439, 0, 'medivh SAY_WEAK25');
INSERT INTO creature_text VALUES (15608, 1, 0, 'My powers must be concentrated on the portal! I do not have time to hold the shield!', 14, 0, 100, 0, 0, 10438, 0, 'medivh SAY_WEAK50');
INSERT INTO creature_text VALUES (15608, 2, 0, 'Champions! My shield grows weak!', 14, 0, 100, 0, 0, 10437, 0, 'medivh SAY_WEAK75');
INSERT INTO creature_text VALUES (15608, 3, 0, 'The time has come! Gul''dan, order your warlocks to double their efforts! Moments from now the gateway will open and your Horde will be released upon this ripe, unsuspecting world!', 14, 0, 100, 0, 0, 10435, 0, 'medivh SAY_ENTER');
INSERT INTO creature_text VALUES (15608, 4, 0, 'What is this? Champions, coming to my aid? I sense the hand of the dark one in this. Truly this sacred event bears his blessing?', 14, 0, 100, 0, 0, 10436, 0, 'medivh SAY_INTRO');
INSERT INTO creature_text VALUES (15608, 5, 0, 'No! Damn this feeble, mortal coil!', 14, 0, 100, 0, 0, 10441, 0, 'medivh SAY_DEATH');
INSERT INTO creature_text VALUES (15608, 6, 0, 'I am grateful for your aid, champions. Now, Gul''dan''s Horde will sweep across this world like a locust swarm, and all my designs, all my carefully-laid plans will at last fall into place.', 14, 0, 100, 0, 0, 10440, 0, 'medivh SAY_WIN');
INSERT INTO creature_text VALUES (15608, 7, 0, 'Orcs of the Horde! This portal is the gateway to your new destiny! Azeroth lies before you, ripe for the taking!', 14, 0, 100, 1, 0, 0, 0, 'medivh SAY_ORCS_ENTER');

-- Dark Portal Black Crystal Invisible Stalker (18553)
UPDATE creature_template SET speed_run=1.5, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=18553;

-- Dark Portal Beam Invisible Stalker (18555)
REPLACE INTO creature_template_addon VALUES (18555, 0, 0, 0, 0, 0, '32570');
DELETE FROM creature WHERE id=18555;
INSERT INTO creature VALUES (NULL, 18555, 269, 3, 1, 0, 0, -2023.59, 7121.72, 22.6638, 3.07084, 86400, 0, 0, 0, 0, 0, 0, 0, 0);
UPDATE creature_template SET scale=1.35, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=18555;

-- Dark Portal Emitter Invisible Stalker (18582)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=18582;

-- Time Rift (17838)
UPDATE creature_template SET unit_flags=33554434, AIName='', ScriptName='npc_time_rift' WHERE entry=17838;

-- Shadow Council Enforcer (17023)
DELETE FROM creature_text WHERE entry=17023;
INSERT INTO creature_text VALUES (17023, 0, 0, 'Gul''dan speaks the truth! We should return at once to tell our brothers of the news! Retreat back through the portal!', 14, 0, 100, 5, 0, 0, 0, 'Shadow Council Enforcer');
UPDATE creature_template SET unit_flags=768, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=17023;


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------
-- Arcane Blast (31457, 38538)
DELETE FROM spelldifficulty_dbc WHERE id IN(31457, 38538) OR spellid0 IN(31457, 38538) OR spellid1 IN(31457, 38538) OR spellid2 IN(31457, 38538) OR spellid3 IN(31457, 38538);
INSERT INTO spelldifficulty_dbc VALUES (31457, 31457, 38538, 0, 0);

-- Arcane Discharge (31472, 38539)
DELETE FROM spelldifficulty_dbc WHERE id IN(31472, 38539) OR spellid0 IN(31472, 38539) OR spellid1 IN(31472, 38539) OR spellid2 IN(31472, 38539) OR spellid3 IN(31472, 38539);
INSERT INTO spelldifficulty_dbc VALUES (31472, 31472, 38539, 0, 0);

-- Wing Buffet (31475, 38593)
DELETE FROM spelldifficulty_dbc WHERE id IN(31475, 38593) OR spellid0 IN(31475, 38593) OR spellid1 IN(31475, 38593) OR spellid2 IN(31475, 38593) OR spellid3 IN(31475, 38593);
INSERT INTO spelldifficulty_dbc VALUES (31475, 31475, 38593, 0, 0);

-- Sand Breath (31473, 39049)
DELETE FROM spelldifficulty_dbc WHERE id IN(31473, 39049) OR spellid0 IN(31473, 39049) OR spellid1 IN(31473, 39049) OR spellid2 IN(31473, 39049) OR spellid3 IN(31473, 39049);
INSERT INTO spelldifficulty_dbc VALUES (31473, 31473, 39049, 0, 0);

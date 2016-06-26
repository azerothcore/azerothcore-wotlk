
UPDATE creature SET spawntimesecs=86400 WHERE map=556 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Underbat (17724, 20185)
UPDATE creature_template SET skinloot=70065, AIName='SmartAI', ScriptName='' WHERE entry=17724;
UPDATE creature_template SET skinloot=70065, AIName='', ScriptName='' WHERE entry=20185;
DELETE FROM smart_scripts WHERE entryorguid=17724 AND source_type=0;
INSERT INTO smart_scripts VALUES (17724, 0, 0, 0, 0, 0, 100, 2, 2200, 6900, 5700, 9700, 11, 34171, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbat - In Combat - Cast Tentacle Lash');
INSERT INTO smart_scripts VALUES (17724, 0, 1, 0, 0, 0, 100, 4, 2200, 6900, 5700, 9700, 11, 37956, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbat - In Combat - Cast Tentacle Lash');

-- Underbog Lurker (17725, 20188)
DELETE FROM creature_text WHERE entry=17725;
INSERT INTO creature_text VALUES (17725, 0, 0, "%s grows in size upon seeing $N!", 16, 0, 100, 0, 0, 0, 0, 'Underbog Lurker');
INSERT INTO creature_text VALUES (17725, 1, 0, "Underbog Lurker's strength fades.", 16, 0, 100, 0, 0, 0, 0, 'Underbog Lurker');
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=17725;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=20188;
DELETE FROM smart_scripts WHERE entryorguid=17725 AND source_type=0;
INSERT INTO smart_scripts VALUES (17725, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lurker - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17725, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 34161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lurker - On Aggro - Cast Wild Growth');
INSERT INTO smart_scripts VALUES (17725, 0, 2, 3, 0, 0, 100, 1, 6000, 13900, 0, 0, 28, 34161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lurker - In Combat - Remove Wild Growth');
INSERT INTO smart_scripts VALUES (17725, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lurker - In Combat - Say Line 1');

-- Underbog Lord (17734, 20187)
REPLACE INTO creature_template_addon VALUES (17734, 0, 0, 0, 0, 0, '21737');
REPLACE INTO creature_template_addon VALUES (20187, 0, 0, 0, 0, 0, '21737');
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=17734;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=20187;
DELETE FROM smart_scripts WHERE entryorguid=17734 AND source_type=0;
INSERT INTO smart_scripts VALUES (17734, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 32066, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Out Of Combat - Cast Fungal Decay');
INSERT INTO smart_scripts VALUES (17734, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 40318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - In Combat - Cast Growth');
INSERT INTO smart_scripts VALUES (17734, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - HP 30% - Cast Enrage');

-- Underbog Shambler (17871, 20190)
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=17871;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=20190;
DELETE FROM smart_scripts WHERE entryorguid=17871 AND source_type=0;
INSERT INTO smart_scripts VALUES (17871, 0, 0, 0, 0, 0, 100, 2, 2300, 7700, 12000, 14000, 11, 32329, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - In Combat - Cast Itchy Spores');
INSERT INTO smart_scripts VALUES (17871, 0, 1, 0, 0, 0, 100, 4, 2300, 7700, 12000, 14000, 11, 37965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - In Combat - Cast Itchy Spores');
INSERT INTO smart_scripts VALUES (17871, 0, 2, 0, 2, 0, 100, 3, 0, 75, 0, 0, 11, 34163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - HP 75% - Cast Fungal Regrowth');
INSERT INTO smart_scripts VALUES (17871, 0, 3, 0, 2, 0, 100, 5, 0, 75, 0, 0, 11, 37967, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - HP 75% - Cast Fungal Regrowth');
INSERT INTO smart_scripts VALUES (17871, 0, 4, 0, 0, 0, 100, 0, 1200, 8700, 16000, 22000, 11, 31427, 0, 0, 0, 0, 0, 21, 5, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - In Combat - Cast Allergies');
DELETE FROM spell_script_names WHERE spell_id=31427;
INSERT INTO spell_script_names VALUES (31427, 'spell_gen_allergies');

-- Wrathfin Sentry (17727, 20192)
DELETE FROM creature_text WHERE entry=17727;
INSERT INTO creature_text VALUES (17727, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Sentry');
INSERT INTO creature_text VALUES (17727, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Sentry');
INSERT INTO creature_text VALUES (17727, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Sentry');
INSERT INTO creature_text VALUES (17727, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Sentry');
INSERT INTO creature_text VALUES (17727, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Sentry');
UPDATE creature_template SET pickpocketloot=17727, AIName='SmartAI', ScriptName='' WHERE entry=17727;
UPDATE creature_template SET pickpocketloot=17727, AIName='', ScriptName='' WHERE entry=20192;
DELETE FROM smart_scripts WHERE entryorguid=17727 AND source_type=0;
INSERT INTO smart_scripts VALUES (17727, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17727, 0, 1, 0, 0, 0, 100, 0, 6000, 7000, 8000, 10000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (17727, 0, 2, 0, 0, 0, 100, 0, 12000, 15000, 15900, 17000, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (17727, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - Out of Combat - Cast Detection');

-- Wrathfin Myrmidon (17726, 20191)
DELETE FROM creature_text WHERE entry=17726;
INSERT INTO creature_text VALUES (17726, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Myrmidon');
INSERT INTO creature_text VALUES (17726, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Myrmidon');
INSERT INTO creature_text VALUES (17726, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Myrmidon');
INSERT INTO creature_text VALUES (17726, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Myrmidon');
INSERT INTO creature_text VALUES (17726, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Myrmidon');
UPDATE creature_template SET pickpocketloot=17726, AIName='SmartAI', ScriptName='' WHERE entry=17726;
UPDATE creature_template SET pickpocketloot=17726, AIName='', ScriptName='' WHERE entry=20191;
DELETE FROM smart_scripts WHERE entryorguid=17726 AND source_type=0;
INSERT INTO smart_scripts VALUES (17726, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Myrmidon - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17726, 0, 1, 0, 0, 0, 100, 2, 4700, 8000, 8900, 16000, 11, 31410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Myrmidon - In Combat - Cast Coral Cut');
INSERT INTO smart_scripts VALUES (17726, 0, 2, 0, 0, 0, 100, 4, 4700, 8000, 8900, 16000, 11, 37973, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Myrmidon - In Combat - Cast Coral Cut');

-- Wrathfin Warrior (17735, 20193)
DELETE FROM creature_text WHERE entry=17735;
INSERT INTO creature_text VALUES (17735, 0, 0, "By Nazjatar's Depths!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Warrior');
INSERT INTO creature_text VALUES (17735, 0, 1, "Die, warmblood!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Warrior');
INSERT INTO creature_text VALUES (17735, 0, 2, "For the Master!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Warrior');
INSERT INTO creature_text VALUES (17735, 0, 3, "Illidan reigns!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Warrior');
INSERT INTO creature_text VALUES (17735, 0, 4, "My blood is like venom!", 12, 0, 100, 0, 0, 0, 0, 'Wrathfin Warrior');
UPDATE creature_template SET pickpocketloot=17735, AIName='SmartAI', ScriptName='' WHERE entry=17735;
UPDATE creature_template SET pickpocketloot=17735, AIName='', ScriptName='' WHERE entry=20193;
DELETE FROM smart_scripts WHERE entryorguid=17735 AND source_type=0;
INSERT INTO smart_scripts VALUES (17735, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17735, 0, 1, 0, 0, 0, 100, 0, 4700, 8000, 8900, 13000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (17735, 0, 2, 0, 0, 0, 100, 0, 1200, 14000, 15000, 19000, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (17735, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - HP 30% - Cast Enrage');

-- Murkblood Spearman (17729, 20180)
UPDATE creature_template SET pickpocketloot=17729, AIName='SmartAI', ScriptName='' WHERE entry=17729;
UPDATE creature_template SET pickpocketloot=17729, AIName='', ScriptName='' WHERE entry=20180;
DELETE FROM smart_scripts WHERE entryorguid=17729 AND source_type=0;
INSERT INTO smart_scripts VALUES (17729, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2000, 3000, 11, 22887, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (17729, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 11, 40317, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (17729, 0, 3, 0, 0, 0, 100, 2, 8000, 13000, 8000, 13000, 11, 31407, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast Viper Sting');
INSERT INTO smart_scripts VALUES (17729, 0, 4, 0, 0, 0, 100, 4, 8000, 13000, 8000, 13000, 11, 39413, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast Viper Sting');
INSERT INTO smart_scripts VALUES (17729, 0, 5, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - HP 30% - Cast Enrage');

-- Murkblood Tribesman (17728, 20181)
UPDATE creature_template SET pickpocketloot=17728, AIName='SmartAI', ScriptName='' WHERE entry=17728;
UPDATE creature_template SET pickpocketloot=17728, AIName='', ScriptName='' WHERE entry=20181;
DELETE FROM smart_scripts WHERE entryorguid=17728 AND source_type=0;
INSERT INTO smart_scripts VALUES (17728, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 8000, 13000, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Tribesman - In Combat - Cast Viper Sting');
INSERT INTO smart_scripts VALUES (17728, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Tribesman - HP 30% - Cast Enrage');

-- Murkblood Oracle (17771, 20179)
UPDATE creature_template SET pickpocketloot=17771, AIName='SmartAI', ScriptName='' WHERE entry=17771;
UPDATE creature_template SET pickpocketloot=17771, AIName='', ScriptName='' WHERE entry=20179;
DELETE FROM smart_scripts WHERE entryorguid=17771 AND source_type=0;
INSERT INTO smart_scripts VALUES (17771, 0, 1, 2, 0, 0, 100, 1, 0, 0, 0, 0, 11, 34880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - Out Of Combat - Cast Elemental Armor');
INSERT INTO smart_scripts VALUES (17771, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 31, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - Out Of Combat - Random Phase');
INSERT INTO smart_scripts VALUES (17771, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 12000, 15000, 11, 12248, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Amplify Damage');
INSERT INTO smart_scripts VALUES (17771, 0, 4, 0, 0, 1, 100, 2, 8000, 13000, 8000, 13000, 11, 31405, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (17771, 0, 5, 0, 0, 1, 100, 4, 8000, 13000, 8000, 13000, 11, 37113, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (17771, 0, 6, 0, 0, 1, 100, 2, 0, 0, 4000, 4000, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (17771, 0, 7, 0, 0, 1, 100, 4, 0, 0, 4000, 4000, 11, 15232, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (17771, 0, 8, 0, 0, 2, 100, 2, 8000, 13000, 8000, 13000, 11, 15241, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (17771, 0, 9, 0, 0, 2, 100, 4, 8000, 13000, 8000, 13000, 11, 36807, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (17771, 0, 10, 0, 0, 2, 100, 2, 0, 0, 4000, 4000, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast FireBall');
INSERT INTO smart_scripts VALUES (17771, 0, 11, 0, 0, 2, 100, 4, 0, 0, 4000, 4000, 11, 15228, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast Fireball');

-- Fen Ray (17731, 20173)
UPDATE creature_template SET skinloot=70065, AIName='SmartAI', ScriptName='' WHERE entry=17731;
UPDATE creature_template SET skinloot=70065, AIName='', ScriptName='' WHERE entry=20173;
DELETE FROM smart_scripts WHERE entryorguid=17731 AND source_type=0;
INSERT INTO smart_scripts VALUES (17731, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 16000, 22000, 11, 34984, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fen Ray - In Combat - Cast Psychic Horror');

-- Underbog Frenzy (20465, 21943)
UPDATE creature_template SET unit_flags=32832, AIName='SmartAI', ScriptName='' WHERE entry=20465;
UPDATE creature_template SET unit_flags=32832, AIName='', ScriptName='' WHERE entry=21943;
DELETE FROM smart_scripts WHERE entryorguid=20465 AND source_type=0;
INSERT INTO smart_scripts VALUES (20465, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 8000, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbog Frenzy - In Combat - Cast Pierce Armor');

-- Bog Giant (17723, 20164)
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=17723;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=20164;
DELETE FROM smart_scripts WHERE entryorguid=17723 AND source_type=0;
INSERT INTO smart_scripts VALUES (17723, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 32066, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - Out Of Combat - Cast Fungal Decay');
INSERT INTO smart_scripts VALUES (17723, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 40318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - In Combat - Cast Growth');
INSERT INTO smart_scripts VALUES (17723, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 17000, 20000, 11, 15550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (17723, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - HP 30% - Cast Enrage');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Hungarfen (17770, 20169)
UPDATE creature_template SET skinloot=80001, AIName='SmartAI', ScriptName='' WHERE entry=17770;
UPDATE creature_template SET skinloot=80001, AIName='', ScriptName='' WHERE entry=20169;
DELETE FROM smart_scripts WHERE entryorguid=17770 AND source_type=0;
INSERT INTO smart_scripts VALUES (17770, 0, 0, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 31673, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungarfen - At 20% HP - Cast Foul Spores');
INSERT INTO smart_scripts VALUES (17770, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 12, 17990, 3, 22000, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Hungarfen - In Combat - Summon Mushroom');
INSERT INTO smart_scripts VALUES (17770, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 10000, 17500, 11, 38739, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Hungarfen - In Combat - Cast Acid Geyser');
INSERT INTO smart_scripts VALUES (17770, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 34874, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungarfen - On Death - Cast Despawn Mushrooms');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=34874;
INSERT INTO conditions VALUES(13, 1, 34874, 0, 0, 31, 0, 3, 17990, 0, 0, 0, 0, '', 'Target Underbog Mushroom');
-- Underbog Mushroom (17990, 20189)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=17990;
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=20189;
DELETE FROM smart_scripts WHERE entryorguid=17990 AND source_type=0;
INSERT INTO smart_scripts VALUES (17990, 0, 0, 1, 25, 0, 100, 1, 0, 0, 0, 0, 11, 34168, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Reset - Cast Spore Cloud');
INSERT INTO smart_scripts VALUES (17990, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 31690, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Reset - Cast Putrid Mushroom');
INSERT INTO smart_scripts VALUES (17990, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Reset - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (17990, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Reset - Disable Melee Attack');
INSERT INTO smart_scripts VALUES (17990, 0, 4, 0, 60, 0, 100, 0, 0, 0, 3000, 3000, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Update - Cast Grow');
INSERT INTO smart_scripts VALUES (17990, 0, 5, 0, 60, 0, 100, 1, 20000, 20000, 0, 0, 28, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Update - Remove AUra Grow');
INSERT INTO smart_scripts VALUES (17990, 0, 6, 0, 8, 0, 100, 0, 34874, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Mushroom - On Spell Hit - Despawn');

-- Ghaz'an (18105, 20168)
UPDATE creature_template SET skinloot=70063, AIName='SmartAI', ScriptName='' WHERE entry=18105;
UPDATE creature_template SET skinloot=70063, AIName='', ScriptName='' WHERE entry=20168;
DELETE FROM smart_scripts WHERE entryorguid=18105 AND source_type=0;
INSERT INTO smart_scripts VALUES (18105, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 7000, 9000, 11, 34268, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghazan - In Combat - Cast Acid Breath');
INSERT INTO smart_scripts VALUES (18105, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 7000, 9000, 11, 34290, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ghazan - In Combat - Cast Acid Spit');
INSERT INTO smart_scripts VALUES (18105, 0, 2, 0, 0, 0, 100, 2, 5900, 5900, 11000, 11000, 11, 34267, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghazan - In Combat - Cast Tail Sweep');
INSERT INTO smart_scripts VALUES (18105, 0, 3, 0, 0, 0, 100, 4, 10000, 10000, 11000, 11000, 11, 38737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghazan - In Combat - Cast Tail Sweep');
INSERT INTO smart_scripts VALUES (18105, 0, 4, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 15716, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghazan - At 20% HP - Cast Enrage');

-- Swamplord Musel'ek (17826, 20183)
DELETE FROM creature_text WHERE entry=17826;
INSERT INTO creature_text VALUES (17826, 0, 0, "Beast! Obey me! Kill them at once!", 14, 0, 100, 0, 0, 10383, 0, "Swamplord Musel'ek bear");
INSERT INTO creature_text VALUES (17826, 1, 0, "We fight to the death!", 14, 0, 100, 0, 0, 10384, 0, "Swamplord Musel'ek Aggro");
INSERT INTO creature_text VALUES (17826, 1, 1, "I will end this quickly...", 14, 0, 100, 0, 0, 10385, 0, "Swamplord Musel'ek Aggro");
INSERT INTO creature_text VALUES (17826, 1, 2, "Acalah pek ecta!", 14, 0, 100, 0, 0, 10386, 0, "Swamplord Musel'ek Aggro");
INSERT INTO creature_text VALUES (17826, 2, 0, "Krypta!", 14, 0, 100, 0, 0, 10387, 0, "Swamplord Musel'ek Slay");
INSERT INTO creature_text VALUES (17826, 2, 1, "It is finished.", 14, 0, 100, 0, 0, 10388, 0, "Swamplord Musel'ek Slay");
INSERT INTO creature_text VALUES (17826, 3, 0, "Well... done...", 14, 0, 100, 0, 0, 10389, 0, "Swamplord Musel'ek Death");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17826;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20183;
DELETE FROM smart_scripts WHERE entryorguid=17826 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1782600 AND source_type=9;
INSERT INTO smart_scripts VALUES (17826, 0, 1, 0, 0, 0, 100, 0, 35000, 38000, 30000, 40000, 11, 18813, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Knock Away");
INSERT INTO smart_scripts VALUES (17826, 0, 2, 0, 0, 0, 100, 0, 500, 1000, 2300, 3900, 11, 22907, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Knock Away");
INSERT INTO smart_scripts VALUES (17826, 0, 3, 0, 0, 0, 100, 0, 4000, 8000, 12000, 16000, 11, 31615, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Hunter's Mark");
INSERT INTO smart_scripts VALUES (17826, 0, 4, 0, 0, 0, 100, 0, 4000, 8000, 12000, 16000, 11, 31946, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Throw Freezing Trap");
INSERT INTO smart_scripts VALUES (17826, 0, 5, 6, 0, 0, 100, 0, 12500, 21500, 20000, 30000, 11, 31623, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Aimed Shot");
INSERT INTO smart_scripts VALUES (17826, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Set ranged weapon");
INSERT INTO smart_scripts VALUES (17826, 0, 7, 8, 0, 0, 100, 0, 12500, 21500, 20000, 30000, 11, 34974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Cast Multi-Shot");
INSERT INTO smart_scripts VALUES (17826, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Combat - Set ranged weapon");
INSERT INTO smart_scripts VALUES (17826, 0, 9, 14, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On Aggro - Say 1");
INSERT INTO smart_scripts VALUES (17826, 0, 10, 0, 5, 0, 100, 0, 5000, 5000, 1, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On Kill - Say 2");
INSERT INTO smart_scripts VALUES (17826, 0, 11, 12, 6, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On Death - Say 3");
INSERT INTO smart_scripts VALUES (17826, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 17827, 100, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On Death - Set Data on Claw");
INSERT INTO smart_scripts VALUES (17826, 0, 13, 0, 38, 0, 100, 0, 0, 1, 0, 0, 80, 1782600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On dataset - Start Script");
INSERT INTO smart_scripts VALUES (17826, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 17827, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On Aggro - Set Data on Claw");
INSERT INTO smart_scripts VALUES (1782600, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 70, 0, 0, 0, 0, 0, 0, 19, 17827, 100, 1, 0, 0, 0, 0, "Swamplord Musel'ek - Script9 - Respawn dead claw");
INSERT INTO smart_scripts VALUES (1782600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - Script9 - Say 0");
-- Claw <Swamplord Musel'ek's Pet> (17827, 20165)
UPDATE creature_template SET gossip_menu_id=7525, AIName='SmartAI', ScriptName='' WHERE entry=17827;
UPDATE creature_template SET gossip_menu_id=7525, AIName='', ScriptName='' WHERE entry=20165;
DELETE FROM smart_scripts WHERE entryorguid=17827 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1782700 AND source_type=9;
INSERT INTO smart_scripts VALUES (17827, 0, 0, 0, 0, 0, 100, 0, 7400, 7400, 20000, 20000, 11, 39435, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Claw - Combat - Cast Feral Charge");
INSERT INTO smart_scripts VALUES (17827, 0, 1, 0, 0, 0, 100, 0, 2400, 2400, 10600, 21200, 11, 31429, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Combat - Cast Echoing Roar");
INSERT INTO smart_scripts VALUES (17827, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 30500, 30500, 11, 34971, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Combat - Cast Frenzy");
INSERT INTO smart_scripts VALUES (17827, 0, 3, 0, 0, 0, 100, 0, 5300, 5300, 11100, 21500, 11, 34298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Claw - Combat - Cast Maul");
INSERT INTO smart_scripts VALUES (17827, 0, 4, 0, 2, 1, 100, 1, 0, 20, 0, 0, 80, 1782700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - HP@20% - Run Script");
INSERT INTO smart_scripts VALUES (17827, 0, 5, 0, 64, 0, 100, 0, 0, 0, 0, 0, 33, 17894, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Claw - On Gossip Hello - Give Kill Credit");
INSERT INTO smart_scripts VALUES (17827, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 17826, 100, 0, 0, 0, 0, 0, "Claw - On Death - Set Data on Swamplord Musel'ek");
INSERT INTO smart_scripts VALUES (17827, 0, 7, 0, 38, 0, 100, 0, 0, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On dataset - Set Phase 1");
INSERT INTO smart_scripts VALUES (17827, 0, 8, 0, 38, 0, 100, 0, 3, 3, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, "Swamplord Musel'ek - On dataset - Attack Start");
INSERT INTO smart_scripts VALUES (1782700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Remove all auras");
INSERT INTO smart_scripts VALUES (1782700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set Run on");
INSERT INTO smart_scripts VALUES (1782700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 289.255, -129.7, 29.821, 2.49582, "Claw - Script - move to");
INSERT INTO smart_scripts VALUES (1782700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 1660, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set faction");
INSERT INTO smart_scripts VALUES (1782700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 525072, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set unitflags");
INSERT INTO smart_scripts VALUES (1782700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 3, 0, 2289, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set displayid");
INSERT INTO smart_scripts VALUES (1782700, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set npcflags");
INSERT INTO smart_scripts VALUES (1782700, 9, 7, 0, 0, 0, 100, 0, 4000, 4000, 4000, 4000, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 290.532, -125.352, 29.6971, 1.82491, "Claw - Script - move to");
INSERT INTO smart_scripts VALUES (1782700, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 3, 17894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set entry");
INSERT INTO smart_scripts VALUES (1782700, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 557824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set unitflags");
INSERT INTO smart_scripts VALUES (1782700, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set bytes1");
INSERT INTO smart_scripts VALUES (1782700, 9, 11, 0, 0, 0, 100, 0, 500, 500, 500, 500, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Claw - Script - Set npcflags");

-- The Black Stalker (17882, 20184)
UPDATE creature_template SET AIName='', ScriptName='boss_the_black_stalker' WHERE entry=17882;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20184;
DELETE FROM smart_scripts WHERE entryorguid=17882 AND source_type=0;

-- Spore Strider (22299, 22300)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=22299;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=22300;
DELETE FROM smart_scripts WHERE entryorguid=22299 AND source_type=0;
INSERT INTO smart_scripts VALUES (22299, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5000, 6000, 11, 20824, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spore Strider - In Combat - Cast Lightning Bolt');

-- -------------------------------------------
--                MISC
-- -------------------------------------------

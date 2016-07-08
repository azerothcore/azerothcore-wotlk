
UPDATE creature SET spawntimesecs=7*86400 WHERE map=550 AND spawntimesecs>0;
DELETE FROM disables WHERE sourceType=2 AND entry=550;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Star Scryer (20034)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20034;
DELETE FROM smart_scripts WHERE entryorguid=20034 AND source_type=0;
INSERT INTO smart_scripts VALUES (20034, 0, 0, 0, 9, 0, 100, 0, 0, 5, 12500, 15000, 11, 37126, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Star Scryer - Within Range 0-5yd - Cast Acrance Blast');
INSERT INTO smart_scripts VALUES (20034, 0, 1, 0, 0, 0, 100, 0, 2000, 12000, 15000, 20000, 11, 37124, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Star Scryer - In Combat - Cast Starfall');
INSERT INTO smart_scripts VALUES (20034, 0, 2, 0, 0, 0, 100, 0, 16000, 16000, 25000, 30000, 11, 37122, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Star Scryer - In Combat - Cast Domination');

-- Astromancer (20033)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20033;
DELETE FROM smart_scripts WHERE entryorguid=20033 AND source_type=0;
INSERT INTO smart_scripts VALUES (20033, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 35915, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - On Aggro - Cast Molten Armor');
INSERT INTO smart_scripts VALUES (20033, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 10000, 10000, 11, 37109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - In Combat - Cast Fireball Volley');
INSERT INTO smart_scripts VALUES (20033, 0, 2, 0, 0, 0, 100, 0, 1000, 2000, 6000, 9000, 11, 37110, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Astromancer - In Combat - Cast Fire last');

-- Bloodwarder Vindicator (20032)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20032;
DELETE FROM smart_scripts WHERE entryorguid=20032 AND source_type=0;
INSERT INTO smart_scripts VALUES (20032, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 39078, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - In Combat - Cast Cleanse');
INSERT INTO smart_scripts VALUES (20032, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 15000, 20000, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (20032, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 11, 37251, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - Target Health Pct 0-20% - Cast Hammer of Wrath');
INSERT INTO smart_scripts VALUES (20032, 0, 3, 0, 14, 0, 100, 0, 10000, 40, 5000, 8000, 11, 37249, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Vindicator - Friendly Missing Health - Cast Flash of Light');

-- Bloodwarder Legionnaire (20031)
DELETE FROM creature_text WHERE entry=20031;
INSERT INTO creature_text VALUES (20031, 0, 0, 'First squad is ready for battle!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 1, 'Our blades and spells are at the ready!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 2, 'Our defenses stand ready!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 3, 'Second squad is ready to fight!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 4, 'The enemy will not get past us!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 5, 'Third squad reporting in!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 6, 'We stand ready to defend the Eye!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
INSERT INTO creature_text VALUES (20031, 0, 7, 'We will show our enemies no quarter!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Legionnaire');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20031;
DELETE FROM smart_scripts WHERE entryorguid=20031 AND source_type=0;
INSERT INTO smart_scripts VALUES (20031, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 15000, 20000, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast Bloodthirst');
INSERT INTO smart_scripts VALUES (20031, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 7000, 9000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (20031, 0, 2, 0, 0, 0, 100, 0, 8000, 8000, 12000, 15000, 11, 33500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (20031, 0, 3, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Legionnaire - On Aggro - Talk');

-- Bloodwarder Squire (20036)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20036;
DELETE FROM smart_scripts WHERE entryorguid=20036 AND source_type=0;
INSERT INTO smart_scripts VALUES (20036, 0, 0, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 39078, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - In Combat - Cast Cleanse');
INSERT INTO smart_scripts VALUES (20036, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 15000, 20000, 11, 39077, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (20036, 0, 2, 0, 12, 0, 100, 0, 0, 20, 10000, 10000, 11, 37255, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - Target Health Pct 0-20% - Cast Hammer of Wrath');
INSERT INTO smart_scripts VALUES (20036, 0, 3, 0, 14, 0, 100, 0, 10000, 40, 5000, 8000, 11, 37254, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Squire - Friendly Missing Health - Cast Flash of Light');

-- Bloodwarder Marshal (20035)
DELETE FROM creature_text WHERE entry=20035;
INSERT INTO creature_text VALUES (20035, 0, 0, 'As you were!', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Marshal');
INSERT INTO creature_text VALUES (20035, 0, 1, 'Excellent work.', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Marshal');
INSERT INTO creature_text VALUES (20035, 0, 2, 'Stand vigilant.', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Marshal');
INSERT INTO creature_text VALUES (20035, 0, 3, 'Very well.', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Marshal');
INSERT INTO creature_text VALUES (20035, 0, 4, 'Your conduct makes me proud.', 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Marshal');
UPDATE creature_template SET dmg_multiplier=30, AIName='SmartAI', ScriptName='' WHERE entry=20035;
DELETE FROM smart_scripts WHERE entryorguid=20035 AND source_type=0;
INSERT INTO smart_scripts VALUES (20035, 0, 0, 0, 1, 0, 100, 0, 4000, 16000, 35000, 50000, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - Out of Combat - Talk');
INSERT INTO smart_scripts VALUES (20035, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 15000, 21000, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast Bloodthirst');
INSERT INTO smart_scripts VALUES (20035, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 12000, 15000, 11, 34996, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (20035, 0, 3, 0, 0, 0, 100, 0, 8000, 10000, 16000, 20000, 11, 36132, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Marshal - In Combat - Cast Whirlwind');

-- Tempest Falconer (20037)
DELETE FROM creature WHERE id=20037;
REPLACE INTO creature VALUES (12483, 20037, 550, 1, 1, 0, 1, 355.432, -40.396, -2.38948, 0.55, 10800, 0, 0, 100520, 16155, 0, 0, 0, 0);
REPLACE INTO creature VALUES (12476, 20037, 550, 1, 1, 0, 1, 298.818, 31.3542, -2.38937, 3.94531, 10800, 0, 0, 100520, 16155, 0, 0, 0, 0);
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20037;
DELETE FROM smart_scripts WHERE entryorguid=20037 AND source_type=0;
INSERT INTO smart_scripts VALUES (20037, 0, 0, 0, 1, 0, 100, 0, 0, 0, 600000, 600000, 11, 37318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - Out of Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (20037, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 3000, 3000, 11, 39079, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (20037, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 14000, 19000, 11, 37154, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - In Combat - Cast Immolation Arrow');
INSERT INTO smart_scripts VALUES (20037, 0, 3, 0, 9, 0, 100, 0, 0, 10, 15000, 19000, 11, 37317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest Falconer - Within Range 0-10yd - Cast Knockback');

-- Phoenix-Hawk Hatchling (20038)
UPDATE creature_template SET dmg_multiplier=15, AIName='SmartAI', ScriptName='' WHERE entry=20038;
DELETE FROM smart_scripts WHERE entryorguid=20038 AND source_type=0;
INSERT INTO smart_scripts VALUES (20038, 0, 0, 0, 0, 0, 100, 0, 1000, 15000, 20000, 30000, 11, 37160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk Hatchling - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (20038, 0, 1, 0, 0, 0, 100, 0, 1000, 15000, 5000, 15000, 11, 37319, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk Hatchling - In Combat - Cast Wing Buffet');

-- Phoenix-Hawk (20039)
UPDATE creature_template SET speed_walk=2, dmg_multiplier=30, AIName='SmartAI', ScriptName='' WHERE entry=20039;
DELETE FROM smart_scripts WHERE entryorguid=20039 AND source_type=0;
INSERT INTO smart_scripts VALUES (20039, 0, 0, 0, 9, 0, 100, 0, 5, 40, 10000, 10000, 11, 37156, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk - Within Range 5-40yd - Cast Dive');
INSERT INTO smart_scripts VALUES (20039, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 12000, 18000, 11, 37159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix-Hawk - In Combat - Cast Mana Burn');

-- Crystalcore Devastator (20040)
DELETE FROM creature_text WHERE entry=20040;
INSERT INTO creature_text VALUES (20040, 0, 0, 'This unit is currently performing within normal parameters.', 12, 0, 100, 0, 0, 0, 0, 'Crystalcore Devastator');
INSERT INTO creature_text VALUES (20040, 0, 1, 'This unit is ready to serve.', 12, 0, 100, 0, 0, 0, 0, 'Crystalcore Devastator');
UPDATE creature_template SET dmg_multiplier=25, AIName='SmartAI', ScriptName='' WHERE entry=20040;
DELETE FROM smart_scripts WHERE entryorguid=20040 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20040*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20040, 0, 0, 0, 0, 0, 100, 0, 7000, 8000, 15000, 18000, 11, 37102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (20040, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 15000, 18000, 11, 35035, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast Countercharge');
INSERT INTO smart_scripts VALUES (20040, 0, 2, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 35039, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Victim Casting - Cast Countercharge');
INSERT INTO smart_scripts VALUES (20040, 0, 3, 4, 8, 0, 100, 0, 34946, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spell Hit - Store Target');
INSERT INTO smart_scripts VALUES (20040, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20040*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spell Hit - Start Script');
INSERT INTO smart_scripts VALUES (20040*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Script9 - Cast Powered Down');
INSERT INTO smart_scripts VALUES (20040*100, 9, 1, 0, 0, 0, 100, 0, 7000, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20040*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Script9 - Talk');
INSERT INTO smart_scripts VALUES (20040*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - Script9 - Remove All Auras');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=20040;
INSERT INTO conditions VALUES(22, 3, 20040, 0, 0, 1, 1, 35035, 0, 0, 0, 0, 0, '', 'Allow action if baseobject has aura');

-- SPELL Countercharge (35035)
DELETE FROM spell_script_names WHERE spell_id IN(35035);
INSERT INTO spell_script_names VALUES(35035, 'spell_the_eye_countercharge');

-- Crystalcore Sentinel (20041)
DELETE FROM creature_text WHERE entry=20041;
INSERT INTO creature_text VALUES (20041, 0, 0, 'This unit is currently performing within normal parameters.', 12, 0, 100, 0, 0, 0, 0, 'Crystalcore Sentinel');
INSERT INTO creature_text VALUES (20041, 0, 1, 'This unit is ready to serve.', 12, 0, 100, 0, 0, 0, 0, 'Crystalcore Sentinel');
UPDATE creature_template SET dmg_multiplier=25, AIName='SmartAI', ScriptName='' WHERE entry=20041;
DELETE FROM smart_scripts WHERE entryorguid=20041 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20041*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20041, 0, 0, 0, 0, 0, 100, 0, 14000, 15000, 23000, 25000, 11, 37106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - In Combat - Cast Charged Arcane Explosion');
INSERT INTO smart_scripts VALUES (20041, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 20000, 21000, 11, 37104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - In Combat - Cast Overcharge');
INSERT INTO smart_scripts VALUES (20041, 0, 2, 3, 8, 0, 100, 0, 34946, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - On Spell Hit - Store Target');
INSERT INTO smart_scripts VALUES (20041, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20041*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - On Spell Hit - Start Script');
INSERT INTO smart_scripts VALUES (20041*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - Script9 - Cast Powered Down');
INSERT INTO smart_scripts VALUES (20041*100, 9, 1, 0, 0, 0, 100, 0, 7000, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20041*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - Script9 - Talk');
INSERT INTO smart_scripts VALUES (20041*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Sentinel - Script9 - Remove All Auras');

-- Crystalcore Mechanic (20052)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20052;
DELETE FROM smart_scripts WHERE entryorguid=20052 AND source_type=0;
INSERT INTO smart_scripts VALUES (20052, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 12000, 14000, 11, 37123, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - In Combat - Cast Saw Blade');
INSERT INTO smart_scripts VALUES (20052, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 24000, 24000, 11, 37121, 0, 0, 0, 0, 0, 19, 20041, 40, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - In Combat - Cast Recharge');
INSERT INTO smart_scripts VALUES (20052, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 24000, 24000, 11, 37121, 0, 0, 0, 0, 0, 19, 20040, 40, 0, 0, 0, 0, 0, 'Crystalcore Mechanic - In Combat - Cast Recharge');

-- Tempest-Smith (20042)
DELETE FROM creature_text WHERE entry=20042;
INSERT INTO creature_text VALUES (20042, 0, 0, 'Golem. Command. Operational status report.', 12, 0, 100, 0, 0, 0, 0, 'Tempest-Smith');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20042;
DELETE FROM smart_scripts WHERE entryorguid=20042 AND source_type=0;
INSERT INTO smart_scripts VALUES (20042, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 12000, 14000, 11, 37120, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Fragmentation Bomb');
INSERT INTO smart_scripts VALUES (20042, 0, 1, 0, 0, 0, 100, 0, 9000, 10000, 12000, 14000, 11, 37118, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Shell Shock');
INSERT INTO smart_scripts VALUES (20042, 0, 2, 0, 0, 0, 100, 0, 11000, 11000, 24000, 24000, 11, 37112, 0, 0, 0, 0, 0, 19, 20041, 40, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Power Up');
INSERT INTO smart_scripts VALUES (20042, 0, 3, 0, 0, 0, 100, 0, 11000, 11000, 24000, 24000, 11, 37112, 0, 0, 0, 0, 0, 19, 20040, 40, 0, 0, 0, 0, 0, 'Tempest-Smith - In Combat - Cast Power Up');
INSERT INTO smart_scripts VALUES (20042, 0, 4, 0, 1, 0, 100, 0, 1000, 30000, 60000, 90000, 11, 34946, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Smith - Out of Combat - Cast Golem Repair');

-- SPELL Golem Repair (34946)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=34946;
INSERT INTO conditions VALUES(13, 1, 34946, 0, 0, 31, 0, 3, 20040, 0, 0, 0, 0, '', 'Target Crystalcore Devastator');
INSERT INTO conditions VALUES(13, 1, 34946, 0, 0, 38, 0, 100, 0, 0, 0, 0, 0, '', 'Target 100% HP unit');
INSERT INTO conditions VALUES(13, 1, 34946, 0, 1, 31, 0, 3, 20041, 0, 0, 0, 0, '', 'Target Crystalcore Sentinel');
INSERT INTO conditions VALUES(13, 1, 34946, 0, 1, 38, 0, 100, 0, 0, 0, 0, 0, '', 'Target 100% HP unit');

-- Novice Astromancer (20044)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20044;
DELETE FROM smart_scripts WHERE entryorguid=20044 AND source_type=0;
INSERT INTO smart_scripts VALUES (20044, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 11, 37111, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (20044, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 20000, 27000, 11, 37279, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (20044, 0, 2, 0, 0, 0, 100, 0, 15000, 16000, 15000, 24000, 11, 38728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (20044, 0, 3, 0, 0, 0, 100, 1, 0, 3000, 0, 0, 11, 37282, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Novice Astromancer - In Combat - Cast Fire Shield');

-- Apprentice Star Scryer (20043)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20043;
DELETE FROM smart_scripts WHERE entryorguid=20043 AND source_type=0;
INSERT INTO smart_scripts VALUES (20043, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 11, 37133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Buffet');
INSERT INTO smart_scripts VALUES (20043, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 20000, 27000, 11, 37132, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Shock');
INSERT INTO smart_scripts VALUES (20043, 0, 2, 0, 0, 0, 100, 0, 15000, 16000, 15000, 24000, 11, 38725, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (20043, 0, 3, 0, 0, 0, 100, 0, 10000, 13000, 17000, 20000, 11, 37129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Star Scryer - In Combat - Cast Arcane Volley');

-- Astromancer Lord (20046)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=20046;
DELETE FROM smart_scripts WHERE entryorguid=20046 AND source_type=0;
INSERT INTO smart_scripts VALUES (20046, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5500, 7500, 11, 37110, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (20046, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 17000, 11, 37289, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Dragons Breath');
INSERT INTO smart_scripts VALUES (20046, 0, 2, 0, 0, 0, 100, 0, 15000, 16000, 15000, 24000, 11, 37109, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Volley');
INSERT INTO smart_scripts VALUES (20046, 0, 3, 0, 0, 0, 100, 1, 0, 1000, 0, 0, 11, 38732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Astromancer Lord - In Combat - Cast Fire Shield');




-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Al'ar <Phoenix God> (19514)
REPLACE INTO creature_addon VALUES (12479, 0, 0, 0, 0, 0, '');
REPLACE INTO creature_model_info VALUES (18945, 4, 12, 2, 0);
UPDATE creature SET MovementType=0 WHERE id=19514;
UPDATE creature_template SET speed_walk=2.2, speed_run=2.2, dmg_multiplier=60, InhabitType=7, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_alar' WHERE entry=19514;

-- Ember of Al'ar (19551)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=19551);
DELETE FROM creature WHERE id=19551;
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=650852223, AIName='SmartAI', ScriptName='' WHERE entry=19551;
DELETE FROM smart_scripts WHERE entryorguid=19551 AND source_type=0;
INSERT INTO smart_scripts VALUES (19551, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 35177, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - Just Summoned - Cast Birth Dummy Cast');
INSERT INTO smart_scripts VALUES (19551, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (19551, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 34133, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Death - Cast Ember Blast');
INSERT INTO smart_scripts VALUES (19551, 0, 3, 4, 60, 0, 100, 0, 3000, 3000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Update - Set React Aggressive');
INSERT INTO smart_scripts VALUES (19551, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ember of Alar - On Update - Set In Combat With Zone');

-- Flame Patch (20602)
REPLACE INTO creature_template_addon VALUES (20602, 0, 0, 0, 0, 0, '35380');
UPDATE creature_template SET faction=16, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=20602;

-- SPELL Flame Quills (34229) + triggers (34269 - 34289, 34314 - 34316)
DELETE FROM spell_script_names WHERE spell_id IN(34229);
INSERT INTO spell_script_names VALUES(34229, 'spell_alar_flame_quills');
DELETE FROM spell_target_position WHERE id BETWEEN 34269 AND 34289 OR id IN(34314, 34315, 34316);
INSERT INTO spell_target_position VALUES (34269, 0, 550, 415.538, 10.5271, 20.1795, 0),(34270, 0, 550, 392.704, 33.6896, 20.1828, 0),(34271, 0, 550, 394.817, -35.7356, 20.1807, 0),(34272, 0, 550, 383.254, 65.1727, 20.1782, 0),(34273, 0, 550, 363.792, 75.4196, 19.2907, 0),(34274, 0, 550, 383.119, -66.9331, 20.1752, 0),(34275, 0, 550, 364.07, -77.5918, 19.5518, 0),(34276, 0, 550, 337.978, -73.602, 19.3235, 0),
(34277, 0, 550, 321.835, -82.7296, 20.1795, 0),(34278, 0, 550, 321.532, 80.7612, 20.138, 0),(34279, 0, 550, 302.347, 74.3392, 20.1794, 0),(34280, 0, 550, 282.911, 64.658, 20.1628, 0),(34281, 0, 550, 282.573, -66.0651, 20.1795, 0),(34282, 0, 550, 267.168, -50.4046, 20.1795, 0),(34283, 0, 550, 257.48, -32.9647, 20.1777, 0),(34284, 0, 550, 241.201, -19.8896, 22.5116, 0),(34285, 0, 550, 239.617, -3.65668, 26.7391, 0),(34286, 0, 550, 239.572, 13.9054, 24.6453, 0),
(34287, 0, 550, 257.151, 31.279, 20.1789, 0),(34288, 0, 550, 298.684, 88.8664, 20.1794, 0),(34289, 0, 550, 415.644, -11.547, 20.1795, 0),(34314, 0, 550, 398.069, -77.7113, 20.1794, 0),(34315, 0, 550, 290, -91.1916, 20.1795, 0),(34316, 0, 550, 424.985, -0.668383, 20.1794, 0);

-- SPELL Ember Blast (34133)
DELETE FROM spell_script_names WHERE spell_id IN(34133);
INSERT INTO spell_script_names VALUES(34133, 'spell_alar_ember_blast');

-- SPELL Ember Blast (34341)
DELETE FROM spell_script_names WHERE spell_id IN(34341);
INSERT INTO spell_script_names VALUES(34341, 'spell_alar_ember_blast_death');

-- SPELL Dive Bomb (35367)
DELETE FROM spell_script_names WHERE spell_id IN(35367);
INSERT INTO spell_script_names VALUES(35367, 'spell_alar_dive_bomb');

-- Void Reaver (19516)
DELETE FROM creature_text WHERE entry=19516;
INSERT INTO creature_text VALUES (19516, 0, 0, 'Alert, you are marked for extermination!', 14, 0, 100, 0, 0, 11213, 0, 'voidreaver SAY_AGGRO');
INSERT INTO creature_text VALUES (19516, 1, 0, 'Extermination, successful.', 14, 0, 100, 0, 0, 11215, 0, 'voidreaver SAY_SLAY1');
INSERT INTO creature_text VALUES (19516, 1, 1, 'Imbecile life form, no longer functional.', 14, 0, 100, 0, 0, 11216, 0, 'voidreaver SAY_SLAY2');
INSERT INTO creature_text VALUES (19516, 1, 2, 'Threat neutralized.', 14, 0, 100, 0, 0, 11217, 0, 'voidreaver SAY_SLAY3');
INSERT INTO creature_text VALUES (19516, 2, 0, 'Systems... shutting... down...', 14, 0, 100, 0, 0, 11214, 0, 'voidreaver SAY_DEATH');
INSERT INTO creature_text VALUES (19516, 3, 0, 'Alternative measure commencing...', 14, 0, 100, 0, 0, 11218, 0, 'voidreaver SAY_POUNDING1');
INSERT INTO creature_text VALUES (19516, 3, 1, 'Calculating force parameters...', 14, 0, 100, 0, 0, 11219, 0, 'voidreaver SAY_POUNDING2');
REPLACE INTO creature_model_info VALUES (18951, 3, 9, 2, 0);
UPDATE creature_template SET speed_walk=1.2, speed_run=1.2, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=257|0x200000, AIName='', ScriptName='boss_void_reaver' WHERE entry=19516;

-- High Astromancer Solarian (18805)
DELETE FROM creature_text WHERE entry=18805;
INSERT INTO creature_text VALUES (18805, 0, 0, 'Tal anu''men no Sin''dorei!', 14, 0, 100, 0, 0, 11134, 0, 'solarian SAY_AGGRO');
INSERT INTO creature_text VALUES (18805, 1, 0, 'Ha ha ha! You are hopelessly outmatched!', 14, 0, 100, 0, 0, 11139, 0, 'solarian SAY_SUMMON1');
INSERT INTO creature_text VALUES (18805, 2, 0, 'I will crush your delusions of grandeur!', 14, 0, 100, 0, 0, 11140, 0, 'solarian SAY_SUMMON2');
INSERT INTO creature_text VALUES (18805, 3, 0, 'Your soul belongs to the Abyss!', 14, 0, 100, 0, 0, 11136, 0, 'solarian SAY_KILL1');
INSERT INTO creature_text VALUES (18805, 3, 1, 'By the blood of the Highborne!', 14, 0, 100, 0, 0, 11137, 0, 'solarian SAY_KILL2');
INSERT INTO creature_text VALUES (18805, 3, 2, 'For the Sunwell!', 14, 0, 100, 0, 0, 11138, 0, 'solarian SAY_KILL3');
INSERT INTO creature_text VALUES (18805, 4, 0, 'The warmth of the sun... awaits.', 14, 0, 100, 0, 0, 11135, 0, 'solarian SAY_DEATH');
INSERT INTO creature_text VALUES (18805, 5, 0, 'Enough of this! Now I call upon the fury of the cosmos itself.', 14, 0, 100, 0, 0, 0, 0, 'solarian SAY_VOIDA');
INSERT INTO creature_text VALUES (18805, 6, 0, 'I become ONE... with the VOID!', 14, 0, 100, 0, 0, 0, 0, 'solarian SAY_VOIDB');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_high_astromancer_solarian' WHERE entry=18805;

-- Astromancer Solarian Spotlight (18928)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=18928);
DELETE FROM creature WHERE id=18928;
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=18928;
REPLACE INTO creature_template_addon VALUES (18928, 0, 0, 0, 0, 0, '25824');

-- Solarium Agent (18925)
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=18925;

-- Solarium Priest (18806)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=18806;
DELETE FROM smart_scripts WHERE entryorguid=18806 AND source_type=0;
INSERT INTO smart_scripts VALUES (18806, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2800, 3000, 11, 25054, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Solarium Priest - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (18806, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 7000, 10000, 11, 33387, 0, 0, 0, 0, 0, 19, 18805, 60, 0, 0, 0, 0, 0, 'Solarium Priest - In Combat - Cast Greater Heal');
INSERT INTO smart_scripts VALUES (18806, 0, 2, 0, 0, 0, 100, 0, 9000, 16000, 15000, 16000, 11, 33390, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Solarium Priest - In Combat - Cast Arcane Torrent');

-- SPELL Wrath of the Astromancer (42783)
DELETE FROM spell_script_names WHERE spell_id IN(42783);
INSERT INTO spell_script_names VALUES(42783, 'spell_astromancer_wrath_of_the_astromancer');

-- SPELL Solarian Transform (39117)
DELETE FROM spell_script_names WHERE spell_id IN(39117);
INSERT INTO spell_script_names VALUES(39117, 'spell_astromancer_solarian_transform');

-- Kael'thas Sunstrider (19622)
DELETE FROM creature_text WHERE entry=19622;
INSERT INTO creature_text VALUES (19622, 0, 0, 'Energy. Power. My people are addicted to it... a dependence made manifest after the Sunwell was destroyed. Welcome... to the future. A pity you are too late to stop it. No one can stop me now! Selama ashal''anore!', 14, 0, 100, 0, 0, 11256, 0, 'kaelthas SAY_INTRO');
INSERT INTO creature_text VALUES (19622, 1, 0, 'Capernian will see to it that your stay here is a short one.', 14, 0, 100, 0, 0, 11257, 0, 'kaelthas SAY_INTRO_CAPERNIAN');
INSERT INTO creature_text VALUES (19622, 2, 0, 'Well done, you have proven worthy to test your skills against my master engineer, Telonicus.', 14, 0, 100, 0, 0, 11258, 0, 'kaelthas SAY_INTRO_TELONICUS');
INSERT INTO creature_text VALUES (19622, 3, 0, 'Let us see how your nerves hold up against the Darkener, Thaladred.', 14, 0, 100, 0, 0, 11259, 0, 'kaelthas SAY_INTRO_THALADRED');
INSERT INTO creature_text VALUES (19622, 4, 0, 'You have persevered against some of my best advisors... but none can withstand the might of the Blood Hammer. Behold, Lord Sanguinar!', 14, 0, 100, 0, 0, 11260, 0, 'kaelthas SAY_INTRO_SANGUINAR');
INSERT INTO creature_text VALUES (19622, 5, 0, 'As you see, I have many weapons in my arsenal...', 14, 0, 100, 0, 0, 11261, 0, 'kaelthas SAY_PHASE2_WEAPON');
INSERT INTO creature_text VALUES (19622, 6, 0, 'Perhaps I underestimated you. It would be unfair to make you fight all four advisors at once, but... fair treatment was never shown to my people. I''m just returning the favor.', 14, 0, 100, 0, 0, 11262, 0, 'kaelthas SAY_PHASE3_ADVANCE');
INSERT INTO creature_text VALUES (19622, 7, 0, 'Alas, sometimes one must take matters into one''s own hands. Balamore shanal!', 14, 0, 100, 0, 0, 11263, 0, 'kaelthas SAY_PHASE4_INTRO2');
INSERT INTO creature_text VALUES (19622, 8, 0, 'I have not come this far to be stopped! The future I have planned will not be jeopardized! Now you will taste true power!', 14, 0, 100, 0, 0, 11273, 0, 'kaelthas SAY_PHASE5_NUTS');
INSERT INTO creature_text VALUES (19622, 9, 0, 'You will not prevail.', 14, 0, 100, 0, 0, 11270, 0, 'kaelthas SAY_SLAY1');
INSERT INTO creature_text VALUES (19622, 9, 1, 'You gambled...and lost.', 14, 0, 100, 0, 0, 11271, 0, 'kaelthas SAY_SLAY2');
INSERT INTO creature_text VALUES (19622, 9, 2, 'This was Child''s play.', 14, 0, 100, 0, 0, 11272, 0, 'kaelthas SAY_SLAY3');
INSERT INTO creature_text VALUES (19622, 10, 0, 'Obey me.', 14, 0, 100, 0, 0, 11268, 0, 'kaelthas SAY_MINDCONTROL1');
INSERT INTO creature_text VALUES (19622, 10, 1, 'Bow to my will.', 14, 0, 100, 0, 0, 11269, 0, 'kaelthas SAY_MINDCONTROL2');
INSERT INTO creature_text VALUES (19622, 11, 0, 'Let us see how you fare when your world is turned upside down.', 14, 0, 100, 0, 0, 11264, 0, 'kaelthas SAY_GRAVITYLAPSE1');
INSERT INTO creature_text VALUES (19622, 11, 1, 'Having trouble staying grounded?', 14, 0, 100, 0, 0, 11265, 0, 'kaelthas SAY_GRAVITYLAPSE2');
INSERT INTO creature_text VALUES (19622, 12, 0, 'Anara''nel belore!', 14, 0, 100, 0, 0, 11267, 0, 'kaelthas SAY_SUMMON_PHOENIX1');
INSERT INTO creature_text VALUES (19622, 12, 1, 'By the power of the sun!', 14, 0, 100, 0, 0, 11266, 0, 'kaelthas SAY_SUMMON_PHOENIX2');
INSERT INTO creature_text VALUES (19622, 13, 0, 'For...Quel...thalas!', 14, 0, 100, 0, 0, 11274, 0, 'kaelthas SAY_DEATH');
INSERT INTO creature_text VALUES (19622, 14, 0, '%s begins to cast Pyroblast!', 41, 0, 100, 0, 0, 0, 0, 'kaelthas SAY_PYROBLAST');
REPLACE INTO creature_model_info VALUES (20023, 2, 1.5, 0, 0);
UPDATE creature_template SET unit_flags=2, faction=16, speed_walk=1.2, speed_run=1.2, dmg_multiplier=70, mechanic_immune_mask=617299839, flags_extra=1|0x200100, AIName='', ScriptName='boss_kaelthas' WHERE entry=19622;

-- Thaladred the Darkener (20064)
DELETE FROM creature_text WHERE entry=20064;
INSERT INTO creature_text VALUES (20064, 0, 0, 'Prepare yourselves!', 14, 0, 100, 0, 0, 11203, 0, 'thaladred SAY_THALADRED_AGGRO');
INSERT INTO creature_text VALUES (20064, 1, 0, 'Forgive me, my prince! I have... failed.', 14, 0, 100, 0, 0, 11204, 0, 'thaladred SAY_THALADRED_DEATH');
INSERT INTO creature_text VALUES (20064, 2, 0, '%s sets his gaze on $N!', 16, 0, 100, 0, 0, 0, 0, 'thaladred EMOTE_THALADRED_GAZE');
UPDATE creature_template SET faction=16, speed_walk=1.1, speed_run=1.2, unit_flags=2, dmg_multiplier=30, mechanic_immune_mask=650854271, flags_extra=0x200100, AIName='SmartAI', ScriptName='' WHERE entry=20064;
DELETE FROM smart_scripts WHERE entryorguid=20064 AND source_type=0;
INSERT INTO smart_scripts VALUES (20064, 0, 0, 1, 0, 0, 100, 0, 100, 100, 10000, 10000, 64, 1, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Store Target');
INSERT INTO smart_scripts VALUES (20064, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Modify Threat PCT All');
INSERT INTO smart_scripts VALUES (20064, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Attack Start');
INSERT INTO smart_scripts VALUES (20064, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Talk');
INSERT INTO smart_scripts VALUES (20064, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 138, 10000000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Modify Threat');
INSERT INTO smart_scripts VALUES (20064, 0, 5, 0, 0, 0, 100, 0, 4000, 6000, 9000, 12000, 11, 36966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Cast Psychic Blow');
INSERT INTO smart_scripts VALUES (20064, 0, 6, 0, 0, 0, 100, 0, 3000, 4000, 8000, 10000, 11, 36965, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (20064, 0, 7, 0, 13, 0, 100, 0, 15000, 15000, 0, 0, 11, 30225, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - Victim Casting - Cast Silence');
INSERT INTO smart_scripts VALUES (20064, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Death - Talk');
INSERT INTO smart_scripts VALUES (20064, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Death - Cast Spell');
INSERT INTO smart_scripts VALUES (20064, 0, 10, 0, 25, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thaladred the Darkener - On Reset - Set Run false');

-- Lord Sanguinar (20060)
DELETE FROM creature_text WHERE entry=20060;
INSERT INTO creature_text VALUES (20060, 0, 0, 'Blood for blood!', 14, 0, 100, 0, 0, 11152, 0, 'sanguinar SAY_SANGUINAR_AGGRO');
INSERT INTO creature_text VALUES (20060, 1, 0, 'NO! I ...will... not...', 14, 0, 100, 0, 0, 11153, 0, 'sanguinar SAY_SANGUINAR_DEATH');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2, dmg_multiplier=30, mechanic_immune_mask=650854271, flags_extra=0x200100, AIName='SmartAI', ScriptName='' WHERE entry=20060;
REPLACE INTO creature_template_addon VALUES (20060, 0, 0, 0, 4097, 0, '12787');
DELETE FROM smart_scripts WHERE entryorguid=20060 AND source_type=0;
INSERT INTO smart_scripts VALUES (20060, 0, 0, 0, 0, 0, 100, 0, 0, 0, 15000, 15000, 11, 44863, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - In Combat - Cast Bellowing Roar');
INSERT INTO smart_scripts VALUES (20060, 0, 1, 2, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - On Death - Talk');
INSERT INTO smart_scripts VALUES (20060, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Sanguinar - On Death - Cast Spell');

-- Grand Astromancer Capernian (20062)
DELETE FROM creature_text WHERE entry=20062;
INSERT INTO creature_text VALUES (20062, 0, 0, 'The sin''dore reign supreme!', 14, 0, 100, 0, 0, 11117, 0, 'capernian SAY_CAPERNIAN_AGGRO');
INSERT INTO creature_text VALUES (20062, 1, 0, 'This is not over!', 14, 0, 100, 0, 0, 11118, 0, 'capernian SAY_CAPERNIAN_DEATH');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2, dmg_multiplier=30, mechanic_immune_mask=650854271, flags_extra=0x200100, AIName='SmartAI', ScriptName='' WHERE entry=20062;
DELETE FROM smart_scripts WHERE entryorguid=20062 AND source_type=0;
INSERT INTO smart_scripts VALUES (20062, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2500, 2500, 11, 36971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (20062, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 18500, 20500, 11, 37018, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Conflagration');
INSERT INTO smart_scripts VALUES (20062, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 6000, 6000, 11, 36970, 0, 0, 0, 0, 0, 5, 8, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - In Combat - Cast Arcane Burst');
INSERT INTO smart_scripts VALUES (20062, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - On Death - Talk');
INSERT INTO smart_scripts VALUES (20062, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Astromancer Capernian - On Death - Cast Spell');

-- Master Engineer Telonicus (20063)
DELETE FROM creature_text WHERE entry=20063;
INSERT INTO creature_text VALUES (20063, 0, 0, 'Anar''alah belore!', 14, 0, 100, 0, 0, 11157, 0, 'telonicus SAY_TELONICUS_AGGRO');
INSERT INTO creature_text VALUES (20063, 1, 0, 'More perils... await', 14, 0, 100, 0, 0, 11158, 0, 'telonicus SAY_TELONICUS_DEATH');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2, dmg_multiplier=30, mechanic_immune_mask=650854271, flags_extra=0x200100, AIName='SmartAI', ScriptName='' WHERE entry=20063;
DELETE FROM smart_scripts WHERE entryorguid=20063 AND source_type=0;
INSERT INTO smart_scripts VALUES (20063, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 37036, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (20063, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 20000, 20000, 11, 37027, 0, 0, 0, 0, 0, 5, 100, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - In Combat - Cast Remote Toy');
INSERT INTO smart_scripts VALUES (20063, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - On Death - Talk');
INSERT INTO smart_scripts VALUES (20063, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 36709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Master Engineer Telonicus - On Death - Cast Spell');

-- Staff of Disintegration (21274)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21274;
DELETE FROM smart_scripts WHERE entryorguid=21274 AND source_type=0;
INSERT INTO smart_scripts VALUES (21274, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2200, 2200, 11, 36990, 64, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Bolt');
INSERT INTO smart_scripts VALUES (21274, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 36989, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Staff of Disintegration - In Combat - Cast Frost Nova');

-- Cosmic Infuser (21270)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21270;
DELETE FROM smart_scripts WHERE entryorguid=21270 AND source_type=0;
INSERT INTO smart_scripts VALUES (21270, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 9000, 11, 36985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (21270, 0, 1, 0, 14, 0, 100, 0, 30000, 40, 10000, 10000, 11, 36983, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cosmic Infuser - Friendly Missing HP - Cast Heal');

-- Warp Slicer (21272)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21272;
DELETE FROM smart_scripts WHERE entryorguid=21272 AND source_type=0;
INSERT INTO smart_scripts VALUES (21272, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 6000, 8000, 11, 36991, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warp Slicer - In Combat - Cast Rend');

-- Devastation (21269)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21269;
DELETE FROM smart_scripts WHERE entryorguid=21269 AND source_type=0;
INSERT INTO smart_scripts VALUES (21269, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 11, 36981, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Devastation - In Combat - Cast Whirlwind');

-- Phaseshift Bulwark (21273)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21273;
DELETE FROM smart_scripts WHERE entryorguid=21273 AND source_type=0;
INSERT INTO smart_scripts VALUES (21273, 0, 0, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 36988, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Phaseshift Bulwark - Victim Casting - Cast Shield Bash');

-- Infinity Blades (21271)
REPLACE INTO creature_template_addon VALUES (21271, 0, 0, 0, 4097, 0, '12787');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='', ScriptName='' WHERE entry=21271;
DELETE FROM smart_scripts WHERE entryorguid=21271 AND source_type=0;

-- Netherstrand Longbow (21268)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=2|33554432, dmg_multiplier=20, mechanic_immune_mask=100859909, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21268;
DELETE FROM smart_scripts WHERE entryorguid=21268 AND source_type=0;
INSERT INTO smart_scripts VALUES (21268, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 36980, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Shot');
INSERT INTO smart_scripts VALUES (21268, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 12000, 15000, 11, 36979, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Netherstrand Longbow - In Combat - Cast Multi-Shot');

-- Phoenix (21362)
REPLACE INTO creature_template_addon VALUES (21362, 0, 0, 0, 4097, 0, '');
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=4+131072+2+33554432, dmg_multiplier=30, mechanic_immune_mask=650854271, flags_extra=0x200100, AIName='SmartAI', ScriptName='' WHERE entry=21362;
DELETE FROM smart_scripts WHERE entryorguid=21362 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(21362*100, 21362*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (21362, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 80, 21362*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - AI Init - Script9');
INSERT INTO smart_scripts VALUES (21362, 0, 2, 3, 2, 0, 100, 0, 0, 0, 18000, 18000, 11, 34341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Cast Ember Blast');
INSERT INTO smart_scripts VALUES (21362, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21364, 6, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Summon Creature');
INSERT INTO smart_scripts VALUES (21362, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Set React State');
INSERT INTO smart_scripts VALUES (21362, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Move To Point');
INSERT INTO smart_scripts VALUES (21362, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 2+33554432+131072+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between HP 0% - Set Unit Flags');
INSERT INTO smart_scripts VALUES (21362, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 21362*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Data Set - Script9');
INSERT INTO smart_scripts VALUES (21362*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Set Invincibility HP Level');
INSERT INTO smart_scripts VALUES (21362*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 41587, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Cast Rebirth');
INSERT INTO smart_scripts VALUES (21362*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 19, 2+33554432+131072+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (21362*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21362*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (21362*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36720, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Cast Burn');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Modify threat all PCT');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 40535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Cast Healing Potion');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 35369, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Cast Rebirth');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 19, 2+33554432+131072+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Set React State');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21362*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 36720, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Script9 - Cast Burn');

-- Phoenix Egg (21364)
UPDATE creature_template SET faction=16, speed_walk=1.2, speed_run=1.2, unit_flags=4+131072, dmg_multiplier=1, mechanic_immune_mask=650854271, flags_extra=0x200102, AIName='SmartAI', ScriptName='' WHERE entry=21364;
DELETE FROM smart_scripts WHERE entryorguid=21364 AND source_type=0;
INSERT INTO smart_scripts VALUES (21364, 0, 0, 1, 60, 0, 100, 0, 15000, 15000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Set Data');
INSERT INTO smart_scripts VALUES (21364, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Despawn');
INSERT INTO smart_scripts VALUES (21364, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Death - Despawn Target');
INSERT INTO smart_scripts VALUES (21364, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - Is Summoned - Store Target');

-- Flame Strike Trigger (Kael) (21369)
REPLACE INTO creature_template_addon VALUES (21369, 0, 0, 0, 4097, 0, '36730');
UPDATE creature_template SET modelid2=15294, faction=16, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=21369;

-- Nether Vapor (21002)
REPLACE INTO creature_template_addon VALUES (21002, 0, 0, 0, 4097, 0, '35858 35879');
UPDATE creature_template SET modelid2=19988, faction=16, flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=21002;

-- SPELL Kael Phase Two (36709)
DELETE FROM spell_script_names WHERE spell_id IN(36709);
INSERT INTO spell_script_names VALUES(36709, 'spell_kaelthas_kael_phase_two');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36709;
INSERT INTO conditions VALUES(13, 1, 36709, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target Kael''thas');

-- SPELL Remote Toy (37027)
DELETE FROM spell_script_names WHERE spell_id IN(37027);
INSERT INTO spell_script_names VALUES(37027, 'spell_kaelthas_remote_toy');

-- SPELL Summon Weapons (36976)
DELETE FROM spell_script_names WHERE spell_id IN(36976);
INSERT INTO spell_script_names VALUES(36976, 'spell_kaelthas_summon_weapons');

-- SPELL Summon Weapon A-G (36958, 36959, 36960, 36961, 36962, 36963, 36964)
DELETE FROM spell_target_position WHERE id IN(36958, 36959, 36960, 36961, 36962, 36963, 36964);
INSERT INTO spell_target_position VALUES (36958, 0, 550, 794.5, 16.73, 48.72, 4.74);
INSERT INTO spell_target_position VALUES (36959, 0, 550, 785.54, 14.88, 48.72, 5.17);
INSERT INTO spell_target_position VALUES (36960, 0, 550, 780.41, 9.44, 48.72, 5.68);
INSERT INTO spell_target_position VALUES (36961, 0, 550, 778.43, -0.72, 48.72, 6.26);
INSERT INTO spell_target_position VALUES (36962, 0, 550, 779.43, -9.06, 48.72, 0.42);
INSERT INTO spell_target_position VALUES (36963, 0, 550, 785.32, -16.17, 48.72, 1.04);
INSERT INTO spell_target_position VALUES (36964, 0, 550, 793.36, -17.96, 48.72, 1.42);

-- SPELL Resurrection (36450)
DELETE FROM spell_script_names WHERE spell_id IN(36450);
INSERT INTO spell_script_names VALUES(36450, 'spell_kaelthas_resurrection');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36450;
INSERT INTO conditions VALUES(13, 3, 36450, 0, 0, 31, 0, 3, 20064, 0, 0, 0, 0, '', 'Target Thaladred the Darkener');
INSERT INTO conditions VALUES(13, 3, 36450, 0, 1, 31, 0, 3, 20060, 0, 0, 0, 0, '', 'Target Lord Sanguinar');
INSERT INTO conditions VALUES(13, 3, 36450, 0, 2, 31, 0, 3, 20062, 0, 0, 0, 0, '', 'Target Grand Astromancer Capernian');
INSERT INTO conditions VALUES(13, 3, 36450, 0, 3, 31, 0, 3, 20063, 0, 0, 0, 0, '', 'Target Master Engineer Telonicus');

-- SPELL Mind Control (36797)
DELETE FROM spell_script_names WHERE spell_id IN(36797);
INSERT INTO spell_script_names VALUES(36797, 'spell_kaelthas_mind_control');

-- SPELL Burn (36720)
DELETE FROM spell_script_names WHERE spell_id IN(36720);
INSERT INTO spell_script_names VALUES(36720, 'spell_kaelthas_burn');

-- SPELL Flame Strike (36730)
DELETE FROM spell_script_names WHERE spell_id IN(36730);
INSERT INTO spell_script_names VALUES(36730, 'spell_kaelthas_flame_strike');

-- GO Tempest Bridge Window (184069)
-- GO Doodad_Kael_Explode_FX_Right01 (184596)
-- GO Doodad_Kael_Explode_FX_Left01 (184597)
UPDATE gameobject_template SET flags=16 WHERE entry IN(184069, 184596, 184597);

-- SPELL Netherbeam (36089)
-- SPELL Netherbeam (36090)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(36089, 36090);
INSERT INTO conditions VALUES(13, 1, 36089, 0, 0, 31, 0, 3, 19622, 0, 0, 0, 0, '', 'Target Kael''thas');
INSERT INTO conditions VALUES(13, 1, 36090, 0, 0, 31, 0, 3, 19622, 0, 0, 0, 0, '', 'Target Kael''thas');

-- SPELL Pure Nether Beam (36196, 36197, 36198, 36201, 36290, 36291)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(36196, 36197, 36198, 36201, 36290, 36291);
INSERT INTO conditions VALUES(13, 1, 36196, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target Kael''thas');
INSERT INTO conditions VALUES(13, 1, 36197, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target Kael''thas');
INSERT INTO conditions VALUES(13, 1, 36198, 0, 0, 31, 0, 3, 19871, 0, 0, 0, 0, '', 'Target Kael''thas');
INSERT INTO conditions VALUES(13, 1, 36201, 0, 0, 31, 0, 3, 12999, 0, 0, 0, 0, '', 'Target Players');
INSERT INTO conditions VALUES(13, 1, 36290, 0, 0, 31, 0, 3, 12999, 0, 0, 0, 0, '', 'Target Players');
INSERT INTO conditions VALUES(13, 1, 36291, 0, 0, 31, 0, 3, 12999, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Gravity Lapse (35941)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(35941, 35941);
INSERT INTO conditions VALUES(13, 1, 35941, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
DELETE FROM spell_script_names WHERE spell_id IN(35941);
INSERT INTO spell_script_names VALUES(35941, 'spell_kaelthas_gravity_lapse');

-- SPELL Nether Beam (35869)
DELETE FROM spell_script_names WHERE spell_id IN(35869);
INSERT INTO spell_script_names VALUES(35869, 'spell_kaelthas_nether_beam');

-- SPELL Summon Nether Vapor (35865)
DELETE FROM spell_script_names WHERE spell_id IN(35865);
INSERT INTO spell_script_names VALUES(35865, 'spell_kaelthas_summon_nether_vapor');




-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Bloodwarder Marshal Formation / Pathing
UPDATE creature SET MovementType=2 WHERE guid=12456;
REPLACE INTO creature_addon VALUES (12456, 124560, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=124560;
INSERT INTO waypoint_data VALUES (124560, 1, 231.674, -1.0176, -2.42825, 0, 0, 0, 0, 100, 0),(124560, 2, 220.054, -1.02029, -2.42825, 0, 0, 0, 0, 100, 0),(124560, 3, 209.484, -1.03715, -2.42825, 0, 0, 0, 0, 100, 0),(124560, 4, 194.364, -1.06126, -2.42825, 0, 0, 0, 0, 100, 0),(124560, 5, 182.674, -1.0799, -2.42825, 0, 0, 0, 0, 100, 0),(124560, 6, 171.054, -1.09843, -2.42969, 0, 0, 0, 0, 100, 0),(124560, 7, 156.984, -1.12087, -2.42969, 0, 0, 0, 0, 100, 0),
(124560, 8, 142.984, -1.14319, -2.42969, 0, 0, 0, 0, 100, 0),(124560, 9, 132.484, -1.15993, -2.42547, 0, 0, 0, 0, 100, 0),(124560, 10, 118.554, -1.18215, -2.33264, 0, 0, 0, 0, 100, 0),(124560, 11, 101.124, -1.20994, -2.35086, 0, 0, 0, 0, 100, 0),(124560, 12, 87.1944, -1.23216, -2.42793, 0, 0, 0, 0, 100, 0),(124560, 13, 98.5164, -1.2141, -2.36929, 0, 0, 0, 0, 100, 0),(124560, 14, 115.918, -1.18635, -2.31932, 0, 0, 0, 0, 100, 0),(124560, 15, 138.868, -1.14976, -2.42812, 0, 0, 0, 0, 100, 0),(124560, 16, 161.368, -1.11388, -2.42812, 0, 0, 0, 0, 100, 0),
(124560, 17, 181.618, -1.08158, -2.42987, 0, 0, 0, 0, 100, 0),(124560, 18, 197.368, -1.05647, -2.42967, 0, 0, 0, 0, 100, 0),(124560, 19, 215.368, -1.02777, -2.42967, 0, 0, 0, 0, 100, 0),(124560, 20, 228.868, -1.0624, -2.42967, 0, 0, 0, 0, 100, 0),(124560, 21, 242.368, -0.984711, -2.42967, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=12456;
INSERT INTO creature_formations VALUES (12456, 12456, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (12456, 12443, 3, 120, 0, 12, 21);
INSERT INTO creature_formations VALUES (12456, 12444, 3, 240, 0, 12, 21);

-- Tempest Falconer Formation / Pathing
REPLACE INTO creature VALUES (12483, 20037, 550, 1, 1, 0, 0, 324.438, 7.37906, -2.38948, 3.30942, 7*86400, 0, 0, 48902, 0, 0, 0, 0, 0);
UPDATE creature SET MovementType=2 WHERE guid=12483;
REPLACE INTO creature_addon VALUES (12483, 124830, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=124830;
INSERT INTO waypoint_data VALUES (124830, 1, 355.433, -40.3966, -2.38679, 0, 0, 0, 0, 100, 0),(124830, 2, 367.573, -31.281, -2.38679, 0, 0, 0, 0, 100, 0),(124830, 3, 375.288, -18.8722, -2.38679, 0, 0, 0, 0, 100, 0),(124830, 4, 380.193, -1.93714, -2.38847, 0, 0, 0, 0, 100, 0),(124830, 5, 374.46, 16.5978, -2.3882, 0, 0, 0, 0, 100, 0),(124830, 6, 362.524, 30.9802, -2.3882, 0, 0, 0, 0, 100, 0),(124830, 7, 345.979, 41.2091, -2.38708, 0, 0, 0, 0, 100, 0),(124830, 8, 328.046, 40.9909, -2.38866, 0, 0, 0, 0, 100, 0),
(124830, 9, 309.474, 37.2396, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 10, 297.587, 27.2975, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 11, 289.16, 12.6616, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 12, 287.161, -5.97517, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 13, 292.829, -21.2683, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 14, 299.824, -30.9877, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 15, 316.904, -40.8267, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 16, 335.094, -44.8391, -2.38866, 0, 0, 0, 0, 100, 0),(124830, 17, 355.664, -40.6112, -2.38785, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=12483;
INSERT INTO creature_formations VALUES (12483, 12483, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (12483, 12435, 4, 210, 0, 0, 0);
INSERT INTO creature_formations VALUES (12483, 12436, 4, 150, 0, 0, 0);
INSERT INTO creature_formations VALUES (12483, 12437, 8, 195, 0, 0, 0);
INSERT INTO creature_formations VALUES (12483, 12438, 8, 165, 0, 0, 0);
UPDATE creature SET MovementType=2 WHERE guid=12476;
REPLACE INTO creature_addon VALUES (12476, 124760, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=124760;
INSERT INTO waypoint_data VALUES (124760, 1, 290.572, 21.3123, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 2, 286.117, 6.67528, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 3, 285.586, -10.5067, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 4, 293.105, -20.508, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 5, 305.316, -32.166, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 6, 315.637, -40.409, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 7, 334.164, -42.8684, -2.38943, 0, 0, 0, 0, 100, 0),(124760, 8, 355.854, -37.186, -2.38714, 0, 0, 0, 0, 100, 0),(124760, 9, 370.927, -26.1697, -2.38714, 0, 0, 0, 0, 100, 0),(124760, 10, 379.364, -8.16873, -2.38714, 0, 0, 0, 0, 100, 0),
(124760, 11, 378.575, 8.41853, -2.38795, 0, 0, 0, 0, 100, 0),(124760, 12, 371.72, 22.5639, -2.38795, 0, 0, 0, 0, 100, 0),(124760, 13, 357.912, 36.7687, -2.38795, 0, 0, 0, 0, 100, 0),(124760, 14, 344.114, 39.4392, -2.38795, 0, 0, 0, 0, 100, 0),(124760, 15, 327.06, 41.3647, -2.3895, 0, 0, 0, 0, 100, 0),(124760, 16, 312.619, 38.1243, -2.3895, 0, 0, 0, 0, 100, 0),(124760, 17, 297.673, 31.0487, -2.3895, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=12476;
INSERT INTO creature_formations VALUES (12476, 12476, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (12476, 12439, 4, 210, 0, 0, 0);
INSERT INTO creature_formations VALUES (12476, 12440, 4, 150, 0, 0, 0);
INSERT INTO creature_formations VALUES (12476, 12441, 8, 195, 0, 0, 0);
INSERT INTO creature_formations VALUES (12476, 12442, 8, 165, 0, 0, 0);

-- Phoenix-Hawk Pathing
UPDATE creature SET MovementType=2 WHERE guid IN(12433, 12434, 12475);
REPLACE INTO creature_addon VALUES (12433, 124330, 0, 0, 4097, 0, '');
REPLACE INTO creature_addon VALUES (12434, 124340, 0, 0, 4097, 0, '');
REPLACE INTO creature_addon VALUES (12475, 124750, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id IN(124330, 124340, 124750);
INSERT INTO waypoint_data VALUES (124330, 1, 375.744, -89.0387, 20.1793, 0, 0, 0, 0, 100, 0),(124330, 2, 351.401, -91.0883, 20.212, 0, 0, 0, 0, 100, 0),(124330, 3, 329.359, -92.9441, 20.2297, 0, 0, 0, 0, 100, 0),(124330, 4, 310.794, -91.5025, 20.1794, 0, 0, 0, 0, 100, 0),(124330, 5, 288.671, -84.1593, 20.1794, 0, 0, 0, 0, 100, 0),(124330, 6, 267.854, -67.2645, 20.1794, 0, 0, 0, 0, 100, 0),(124330, 7, 256.306, -48.3167, 20.1794, 0, 0, 0, 0, 100, 0),(124330, 8, 243.743, -26.0456, 20.329, 0, 0, 0, 0, 100, 0),(124330, 9, 240.415, -10.0984, 26.0137, 0, 0, 0, 0, 100, 0),(124330, 10, 237.554, 11.6335, 25.7084, 0, 0, 0, 0, 100, 0),(124330, 11, 240.587, 25.301, 20.2776, 0, 0, 0, 0, 100, 0),(124330, 12, 247.561, 43.8428, 20.1797, 0, 0, 0, 0, 100, 0),(124330, 13, 264.216, 63.4031, 20.1797, 0, 0, 0, 0, 100, 0),(124330, 14, 283.958, 77.9118, 20.1797, 0, 0, 0, 0, 100, 0),(124330, 15, 301.684, 86.911, 20.1797, 0, 0, 0, 0, 100, 0),(124330, 16, 325.586, 92.2921, 20.1797, 0, 0, 0, 0, 100, 0),(124330, 17, 353.577, 91.5653, 20.1933, 0, 0, 0, 0, 100, 0),
(124330, 18, 376.707, 83.2779, 20.1466, 0, 0, 0, 0, 100, 0),(124330, 19, 395.842, 64.4991, 20.1776, 0, 0, 0, 0, 100, 0),(124330, 20, 412.844, 43.6798, 20.1776, 0, 0, 0, 0, 100, 0),(124330, 21, 423.943, 19.1982, 20.1776, 0, 0, 0, 0, 100, 0),(124330, 22, 424.486, -12.2971, 20.1776, 0, 0, 0, 0, 100, 0),(124330, 23, 422.711, -33.2219, 20.1777, 0, 0, 0, 0, 100, 0),(124330, 24, 410.798, -50.5157, 20.1778, 0, 0, 0, 0, 100, 0),(124330, 25, 394.238, -75.9856, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 1, 397.077, -71.6497, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 2, 407.951, -53.6846, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 3, 421.657, -30.6482, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 4, 425.474, -13.7099, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 5, 424.901, 11.9539, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 6, 418.519, 26.9631, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 7, 408.017, 50.4035, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 8, 397.653, 67.1073, 20.1778, 0, 0, 0, 0, 100, 0),(124340, 9, 376.544, 81.1029, 20.105, 0, 0, 0, 0, 100, 0),(124340, 10, 354.101, 87.078, 20.0874, 0, 0, 0, 0, 100, 0),
(124340, 11, 329.844, 89.5663, 20.2621, 0, 0, 0, 0, 100, 0),(124340, 12, 304.338, 88.2366, 20.1794, 0, 0, 0, 0, 100, 0),(124340, 13, 282.119, 77.938, 20.1794, 0, 0, 0, 0, 100, 0),(124340, 14, 261.292, 61.0618, 20.1794, 0, 0, 0, 0, 100, 0),(124340, 15, 248.548, 42.8967, 20.1794, 0, 0, 0, 0, 100, 0),(124340, 16, 242.581, 26.4456, 20.1589, 0, 0, 0, 0, 100, 0),(124340, 17, 239.079, 14.1236, 24.59, 0, 0, 0, 0, 100, 0),(124340, 18, 238.254, -5.66918, 26.537, 0, 0, 0, 0, 100, 0),(124340, 19, 238.776, -13.7724, 25.4823, 0, 0, 0, 0, 100, 0),(124340, 20, 241.815, -25.0577, 20.6318, 0, 0, 0, 0, 100, 0),(124340, 21, 248.789, -41.1078, 20.1784, 0, 0, 0, 0, 100, 0),(124340, 22, 258.606, -60.9465, 20.1784, 0, 0, 0, 0, 100, 0),(124340, 23, 280.29, -85.2324, 20.1784, 0, 0, 0, 0, 100, 0),(124340, 24, 304.241, -90.3737, 20.1784, 0, 0, 0, 0, 100, 0),(124340, 25, 330.97, -93.1226, 20.2533, 0, 0, 0, 0, 100, 0),(124340, 26, 354.158, -90.7628, 20.1309, 0, 0, 0, 0, 100, 0),(124340, 27, 376.787, -85.3285, 20.1588, 0, 0, 0, 0, 100, 0),
(124750, 1, 388.627, 73.6111, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 2, 407.395, 51.3424, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 3, 419.066, 32.4776, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 4, 424.935, 11.1505, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 5, 422.394, -20.1766, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 6, 413.085, -40.2425, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 7, 402.274, -63.5469, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 8, 385.068, -79.3761, 20.1793, 0, 0, 0, 0, 100, 0),(124750, 9, 367.953, -89.3523, 19.9569, 0, 0, 0, 0, 100, 0),(124750, 10, 344.781, -91.9465, 20.2514, 0, 0, 0, 0, 100, 0),(124750, 11, 314.415, -91.0388, 20.1794, 0, 0, 0, 0, 100, 0),(124750, 12, 290.13, -82.6592, 20.1794, 0, 0, 0, 0, 100, 0),(124750, 13, 267.324, -66.4146, 20.1794, 0, 0, 0, 0, 100, 0),(124750, 14, 252.461, -51.4802, 20.1794, 0, 0, 0, 0, 100, 0),(124750, 15, 244.143, -32.2368, 20.1757, 0, 0, 0, 0, 100, 0),
(124750, 16, 242.105, -21.865, 21.5538, 0, 0, 0, 0, 100, 0),(124750, 17, 240.082, -11.5619, 25.8459, 0, 0, 0, 0, 100, 0),(124750, 18, 238.462, 0.0154152, 27.0397, 0, 0, 0, 0, 100, 0),(124750, 19, 239.855, 11.5516, 25.6569, 0, 0, 0, 0, 100, 0),(124750, 20, 242.567, 22.9227, 20.7825, 0, 0, 0, 0, 100, 0),(124750, 21, 249.232, 45.3327, 20.1796, 0, 0, 0, 0, 100, 0),(124750, 22, 264.528, 63.0147, 20.1796, 0, 0, 0, 0, 100, 0),(124750, 23, 284.923, 78.6354, 20.1796, 0, 0, 0, 0, 100, 0),(124750, 24, 303.248, 86.3433, 20.1796, 0, 0, 0, 0, 100, 0),(124750, 25, 325.989, 91.4631, 20.1796, 0, 0, 0, 0, 100, 0),(124750, 26, 350.459, 90.2504, 20.246, 0, 0, 0, 0, 100, 0),(124750, 27, 367.87, 88.4934, 19.9763, 0, 0, 0, 0, 100, 0);

-- Astromancer Lord Formation / Pathing
UPDATE creature SET MovementType=2 WHERE guid=12467;
REPLACE INTO creature_addon VALUES (12467, 124670, 0, 0, 4097, 0, '');
DELETE FROM waypoint_data WHERE id=124670;
INSERT INTO waypoint_data VALUES (124670, 1, 516.057, -152.413, 20.2417, 0, 0, 0, 0, 100, 0),(124670, 2, 512.773, -142.44, 20.2402, 0, 0, 0, 0, 100, 0),(124670, 3, 507.112, -129.636, 20.26, 0, 0, 0, 0, 100, 0),(124670, 4, 502.259, -119.001, 20.2902, 0, 0, 0, 0, 100, 0),(124670, 5, 497.817, -112.12, 20.2902, 0, 0, 0, 0, 100, 0),(124670, 6, 489.244, -99.5808, 20.2902, 0, 0, 0, 0, 100, 0),(124670, 7, 478.816, -87.042, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 8, 483.708, -93.6105, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 9, 490.021, -102.088, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 10, 499.053, -114.214, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 11, 506.682, -124.505, 20.2718, 0, 0, 0, 0, 100, 0),(124670, 12, 510.766, -136.719, 20.2431, 0, 0, 0, 0, 100, 0),
(124670, 13, 515.768, -155.887, 20.2387, 0, 0, 0, 0, 100, 0),(124670, 14, 520.161, -172.827, 20.2565, 0, 0, 0, 0, 100, 0),(124670, 15, 520.01, -185.636, 20.2891, 0, 0, 0, 0, 100, 0),(124670, 16, 518.597, -201.955, 20.2891, 0, 0, 0, 0, 100, 0),(124670, 17, 515.974, -215.707, 20.2891, 0, 0, 0, 0, 100, 0),(124670, 18, 512.43, -228.09, 20.2696, 0, 0, 0, 0, 100, 0),(124670, 19, 515.633, -215.614, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 20, 519.114, -202.054, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 21, 520.602, -186.937, 20.2899, 0, 0, 0, 0, 100, 0),(124670, 22, 522.045, -171.816, 20.2546, 0, 0, 0, 0, 100, 0),
(124670, 23, 518.085, -160.817, 20.2414, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE leaderGUID=12467;
INSERT INTO creature_formations VALUES (12467, 12467, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (12467, 12431, 3, 120, 0, 7, 18);
INSERT INTO creature_formations VALUES (12467, 12432, 3, 240, 0, 7, 18);


UPDATE creature SET spawntimesecs=86400 WHERE map=90 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=90 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Irradiated Pillager (6329)
DELETE FROM creature_text WHERE entry=6329;
INSERT INTO creature_text VALUES (6329, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Irradiated Pillager');
INSERT INTO creature_text VALUES (6329, 1, 0, '%s blood sprays into the air!', 16, 0, 100, 0, 0, 0, 0, 'Irradiated Pillager');
REPLACE INTO creature_template_addon VALUES (6329, 0, 0, 0, 4097, 0, '9769');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6329;
DELETE FROM smart_scripts WHERE entryorguid=6329 AND source_type=0;
INSERT INTO smart_scripts VALUES (6329, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 3000, 4000, 11, 9771, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Pillager - In Combat - Cast Radiation Bolt');
INSERT INTO smart_scripts VALUES (6329, 0, 1, 2, 2, 0, 100, 1, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Pillager - Between Health 0-40% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (6329, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Pillager - Between Health 0-40% - Say Line 0');
INSERT INTO smart_scripts VALUES (6329, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Pillager - On Just Died - Say Line 1');
INSERT INTO smart_scripts VALUES (6329, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 9798, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Pillager - On Just Died - Cast Radiation');

-- SPELL Radiation Bolt (9771)
DELETE FROM spell_script_names WHERE spell_id IN(9771);
INSERT INTO spell_script_names VALUES(9771, "spell_gnomeregan_radiation_bolt");

-- Caverndeep Ambusher (6207)
DELETE FROM creature_text WHERE entry=6207;
INSERT INTO creature_text VALUES (6207, 0, 0, '%s is splashed by the blood and becomes irradiated!', 16, 0, 100, 0, 0, 0, 0, 'Caverndeep Ambusher');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6207;
DELETE FROM smart_scripts WHERE entryorguid=6207 AND source_type=0;
INSERT INTO smart_scripts VALUES (6207, 0, 0, 0, 67, 0, 100, 0, 5000, 5000, 0, 0, 11, 2590, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Ambusher - Is Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (6207, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Ambusher - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (6207, 0, 2, 0, 8, 0, 100, 0, 9798, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Ambusher - On Spell Hit - Say Line 1');

-- Caverndeep Burrower (6206)
DELETE FROM creature_text WHERE entry=6206;
INSERT INTO creature_text VALUES (6206, 0, 0, '%s is splashed by the blood and becomes irradiated!', 16, 0, 100, 0, 0, 0, 0, 'Caverndeep Burrower');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6206;
DELETE FROM smart_scripts WHERE entryorguid=6206 AND source_type=0;
INSERT INTO smart_scripts VALUES (6206, 0, 0, 0, 0, 0, 100, 0, 1000, 8000, 8000, 15000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Burrower - In Combat - Cast Sunder Armor');
INSERT INTO smart_scripts VALUES (6206, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Burrower - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (6206, 0, 2, 0, 8, 0, 100, 0, 9798, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Burrower - On Spell Hit - Say Line 1');

-- Caverndeep Reaver (6211)
DELETE FROM creature_text WHERE entry=6211;
INSERT INTO creature_text VALUES (6211, 0, 0, '%s is splashed by the blood and becomes irradiated!', 16, 0, 100, 0, 0, 0, 0, 'Caverndeep Reaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6211;
DELETE FROM smart_scripts WHERE entryorguid=6211 AND source_type=0;
INSERT INTO smart_scripts VALUES (6211, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 7366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Reaver - On Aggro - Cast Berserker Stance');
INSERT INTO smart_scripts VALUES (6211, 0, 1, 0, 0, 0, 100, 0, 1000, 8000, 6000, 12000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Reaver - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (6211, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Reaver - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (6211, 0, 3, 0, 8, 0, 100, 0, 9798, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caverndeep Reaver - On Spell Hit - Say Line 1');

-- Tink Sprocketwhistle <Engineering Supplies> (9676)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=9676;
DELETE FROM smart_scripts WHERE entryorguid=9676 AND source_type=0;
INSERT INTO smart_scripts VALUES (9676, 0, 0, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tink Sprocketwhistle - Between 0-15% Health - Flee For Assist');

-- Holdout Technician (6407)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6407;
DELETE FROM smart_scripts WHERE entryorguid=6407 AND source_type=0;
INSERT INTO smart_scripts VALUES (6407, 0, 0, 0, 0, 0, 100, 0, 500, 1000, 2000, 2500, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Holdout Technician - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (6407, 0, 1, 0, 0, 0, 100, 0, 5000, 12000, 9000, 18000, 11, 8858, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Holdout Technician - In Combat - Cast Bomb');
INSERT INTO smart_scripts VALUES (6407, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Technician - Between 0-15% Health - Flee For Assist');

-- Holdout Warrior (6391)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6391;
DELETE FROM smart_scripts WHERE entryorguid=6391 AND source_type=0;
INSERT INTO smart_scripts VALUES (6391, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 6000, 10500, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Holdout Warrior - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (6391, 0, 1, 0, 13, 0, 100, 0, 10000, 12000, 0, 0, 11, 12555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Holdout Warrior - Victim Casting - Cast Pummel');
INSERT INTO smart_scripts VALUES (6391, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Warrior - Between 0-15% Health - Flee For Assist');

-- Holdout Medic (6392)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6392;
DELETE FROM smart_scripts WHERE entryorguid=6392 AND source_type=0;
INSERT INTO smart_scripts VALUES (6392, 0, 0, 0, 14, 0, 100, 0, 600, 40, 4000, 6000, 11, 22167, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Medic - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (6392, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 22168, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Medic - On Aggro - Cast Renew');
INSERT INTO smart_scripts VALUES (6392, 0, 2, 0, 1, 0, 100, 0, 5000, 5000, 8000, 10000, 11, 22167, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Medic - Out of Combat - Cast Heal');
INSERT INTO smart_scripts VALUES (6392, 0, 3, 0, 1, 0, 100, 0, 4000, 10000, 15000, 20000, 11, 22168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Medic - Out of Combat - Cast Renew');
INSERT INTO smart_scripts VALUES (6392, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Holdout Medic - Between 0-15% Health - Flee For Assist');

-- Irradiated Slime (6218)
REPLACE INTO creature_template_addon VALUES (6218, 0, 0, 0, 4097, 0, '9460');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6218;
DELETE FROM smart_scripts WHERE entryorguid=6218 AND source_type=0;
INSERT INTO smart_scripts VALUES (6218, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 14000, 21000, 11, 10341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Irradiated Slime - In Combat - Cast Radiation Cloud');

-- Irradiated Horror (6220)
REPLACE INTO creature_template_addon VALUES (6220, 0, 0, 0, 4097, 0, '9460');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6220;
DELETE FROM smart_scripts WHERE entryorguid=6220 AND source_type=0;
INSERT INTO smart_scripts VALUES (6220, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 14000, 21000, 11, 8211, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Irradiated Horror - In Combat - Cast Chain Burn');

-- Corrosive Lurker (6219)
REPLACE INTO creature_template_addon VALUES (6219, 0, 0, 0, 4097, 0, '9460');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6219;
DELETE FROM smart_scripts WHERE entryorguid=6219 AND source_type=0;
INSERT INTO smart_scripts VALUES (6219, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 14000, 21000, 11, 10341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrosive Lurker - In Combat - Cast Radiation Cloud');

-- Mobile Alert System (7849)
REPLACE INTO creature_addon VALUES (30140, 0, 0, 0, 4097, 0, '8279');
REPLACE INTO creature_addon VALUES (30141, 0, 0, 0, 4097, 0, '8279');
REPLACE INTO creature_addon VALUES (30142, 0, 0, 0, 4097, 0, '8279');
REPLACE INTO creature_addon VALUES (30143, 301430, 0, 0, 0, 0, '8279');
REPLACE INTO creature_addon VALUES (30144, 0, 0, 0, 4097, 0, '8279');
DELETE FROM creature_text WHERE entry=7849;
INSERT INTO creature_text VALUES (7849, 0, 0, 'Warning! Warning! Intruder alert! Intruder alert!', 14, 0, 100, 0, 0, 0, 0, 'Mobile Alert System');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7849;
DELETE FROM smart_scripts WHERE entryorguid=7849 AND source_type=0;
INSERT INTO smart_scripts VALUES (7849, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Alert System - On Reset - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (7849, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Alert System - In Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (7849, 0, 2, 0, 0, 0, 100, 1, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Alert System - In Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (7849, 0, 3, 4, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mobile Alert System - In Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (7849, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 7603, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 'Mobile Alert System - In Combat - Summon Creature');
INSERT INTO smart_scripts VALUES (7849, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 6223, 4, 30000, 0, 0, 0, 1, 0, 0, 0, -5, 0, 0, 0, 'Mobile Alert System - In Combat - Summon Creature');

-- Mechanized Sentry (6233)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=6233;
DELETE FROM smart_scripts WHERE entryorguid=6233 AND source_type=0;

-- Leprous Defender (6223)
DELETE FROM creature_text WHERE entry=6223;
INSERT INTO creature_text VALUES (6223, 0, 0, 'A foul trogg if ever I saw one. Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Defender');
INSERT INTO creature_text VALUES (6223, 0, 1, 'No gnome will be left behind.', 12, 0, 100, 0, 0, 0, 0, 'Leprous Defender');
INSERT INTO creature_text VALUES (6223, 0, 2, 'The troggs...they never stop coming. Die trogg! Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Defender');
INSERT INTO creature_text VALUES (6223, 0, 3, 'This sickness clouds my vision, but I know you must be a trogg. Die foul invader!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Defender');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6223;
DELETE FROM smart_scripts WHERE entryorguid=6223 AND source_type=0;
INSERT INTO smart_scripts VALUES (6223, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leprous Defender - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (6223, 0, 1, 0, 0, 0, 100, 0, 500, 1000, 2000, 2500, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leprous Defender - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (6223, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 9000, 18000, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leprous Defender - In Combat - Cast Multi-Shot');

-- Leprous Assistant (7603)
DELETE FROM creature_text WHERE entry=7603;
INSERT INTO creature_text VALUES (7603, 0, 0, 'A foul trogg if ever I saw one. Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Assistant');
INSERT INTO creature_text VALUES (7603, 0, 1, 'No gnome will be left behind.', 12, 0, 100, 0, 0, 0, 0, 'Leprous Assistant');
INSERT INTO creature_text VALUES (7603, 0, 2, 'The troggs...they never stop coming. Die trogg! Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Assistant');
INSERT INTO creature_text VALUES (7603, 0, 3, 'This sickness clouds my vision, but I know you must be a trogg. Die foul invader!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Assistant');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7603;
DELETE FROM smart_scripts WHERE entryorguid=7603 AND source_type=0;
INSERT INTO smart_scripts VALUES (7603, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leprous Assistant - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (7603, 0, 1, 0, 0, 0, 100, 0, 5000, 12000, 9000, 18000, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leprous Assistant - In Combat - Cast Net');

-- Leprous Technician (6222)
DELETE FROM creature_text WHERE entry=6222;
INSERT INTO creature_text VALUES (6222, 0, 0, 'A foul trogg if ever I saw one. Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Technician');
INSERT INTO creature_text VALUES (6222, 0, 1, 'No gnome will be left behind.', 12, 0, 100, 0, 0, 0, 0, 'Leprous Technician');
INSERT INTO creature_text VALUES (6222, 0, 2, 'The troggs...they never stop coming. Die trogg! Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Technician');
INSERT INTO creature_text VALUES (6222, 0, 3, 'This sickness clouds my vision, but I know you must be a trogg. Die foul invader!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Technician');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6222;
DELETE FROM smart_scripts WHERE entryorguid=6222 AND source_type=0;
INSERT INTO smart_scripts VALUES (6222, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leprous Technician - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (6222, 0, 1, 0, 0, 0, 100, 0, 5000, 12000, 9000, 18000, 11, 12024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leprous Technician - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (6222, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 9000, 18000, 11, 13398, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Leprous Technician - In Combat - Cast Throw Wrench');

-- Mechano-Flamewalker (6226)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6226;
DELETE FROM smart_scripts WHERE entryorguid=6226 AND source_type=0;
INSERT INTO smart_scripts VALUES (6226, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 8000, 14000, 11, 11306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechano-Flamewalker - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (6226, 0, 1, 0, 0, 0, 100, 0, 9000, 9000, 11000, 18000, 11, 10733, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechano-Flamewalker - In Combat - Cast Flame Spray');

-- Mechano-Frostwalker (6227)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6227;
DELETE FROM smart_scripts WHERE entryorguid=6227 AND source_type=0;
INSERT INTO smart_scripts VALUES (6227, 0, 0, 1, 0, 0, 100, 0, 4000, 11000, 24000, 24000, 11, 11264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechano-Frostwalker - In Combat - Cast Ice Blast');
INSERT INTO smart_scripts VALUES (6227, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 10737, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechano-Frostwalker - In Combat - Cast Hail Storm');

-- Leprous Machinesmith (6224)
DELETE FROM creature_text WHERE entry=6224;
INSERT INTO creature_text VALUES (6224, 0, 0, 'A foul trogg if ever I saw one. Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Machinesmith');
INSERT INTO creature_text VALUES (6224, 0, 1, 'No gnome will be left behind.', 12, 0, 100, 0, 0, 0, 0, 'Leprous Machinesmith');
INSERT INTO creature_text VALUES (6224, 0, 2, 'The troggs...they never stop coming. Die trogg! Die!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Machinesmith');
INSERT INTO creature_text VALUES (6224, 0, 3, 'This sickness clouds my vision, but I know you must be a trogg. Die foul invader!', 12, 0, 100, 0, 0, 0, 0, 'Leprous Machinesmith');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6224;
DELETE FROM smart_scripts WHERE entryorguid=6224 AND source_type=0;
INSERT INTO smart_scripts VALUES (6224, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leprous Machinesmith - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (6224, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 20000, 25000, 11, 10732, 0, 0, 0, 0, 0, 19, 6224, 50, 0, 0, 0, 0, 0, 'Leprous Machinesmith - In Combat - Cast Supercharge');
INSERT INTO smart_scripts VALUES (6224, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 4000, 6000, 11, 13398, 64, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Leprous Machinesmith - In Combat - Cast Throw Wrench');
INSERT INTO smart_scripts VALUES (6224, 0, 3, 0, 2, 0, 100, 1, 0, 90, 0, 0, 11, 10348, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leprous Machinesmith - Between 0-90% Health - Cast Tune Up');

-- Mechano-Tank (6225)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6225;
DELETE FROM smart_scripts WHERE entryorguid=6225 AND source_type=0;
INSERT INTO smart_scripts VALUES (6225, 0, 0, 0, 9, 0, 100, 0, 5, 30, 500, 500, 11, 10346, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechano-Frostwalker - Within Range 5-30 - Cast Machine Gun');

-- Peacekeeper Security Suit (6225)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6225;
DELETE FROM smart_scripts WHERE entryorguid=6225 AND source_type=0;
INSERT INTO smart_scripts VALUES (6225, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 8000, 9000, 11, 10346, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Peacekeeper Security Suit - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (6225, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 20000, 20000, 11, 10730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Peacekeeper Security Suit - In Combat - Cast Pacify');

-- Dark Iron Agent (6212)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6212;
DELETE FROM smart_scripts WHERE entryorguid=6212 AND source_type=0;
INSERT INTO smart_scripts VALUES (6212, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 15000, 15000, 11, 11802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dark Iron Agent - In Combat - Cast Dark Iron Land Mine');

-- Mechanized Guardian (6234)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6234;
DELETE FROM smart_scripts WHERE entryorguid=6234 AND source_type=0;
INSERT INTO smart_scripts VALUES (6234, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 15000, 15000, 11, 11825, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanized Guardian - In Combat - Cast Electrified Net');

-- Arcane Nullifier X-21 (6232)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6232;
DELETE FROM smart_scripts WHERE entryorguid=6232 AND source_type=0;
INSERT INTO smart_scripts VALUES (6232, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 20000, 20000, 11, 10831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Nullifier X-21 - In Combat - Cast Reflection Field');
INSERT INTO smart_scripts VALUES (6232, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 15000, 15000, 11, 10832, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Nullifier X-21 - In Combat - Cast Mass Nullify');





-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Viscous Fallout (7079)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=7079);
REPLACE INTO creature_template_addon VALUES (7079, 0, 0, 0, 4097, 0, '7940 9460');
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|1024, AIName='SmartAI', ScriptName='' WHERE entry=7079;
DELETE FROM smart_scripts WHERE entryorguid=7079 AND source_type=0;
INSERT INTO smart_scripts VALUES (7079, 0, 0, 0, 0, 0, 100, 0, 4000, 12000, 16000, 21000, 11, 21687, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Viscous Fallout - In Combat - Cast Toxic Volley');

-- Electrocutioner 6000 (6235)
DELETE FROM creature_text WHERE entry=6235;
INSERT INTO creature_text VALUES (6235, 0, 0, 'Electric justice!', 14, 0, 100, 0, 0, 5811, 0, 'Electrocutioner 6000');
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|1024, AIName='SmartAI', ScriptName='' WHERE entry=6235;
DELETE FROM smart_scripts WHERE entryorguid=6235 AND source_type=0;
INSERT INTO smart_scripts VALUES (6235, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Electrocutioner 6000 - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (6235, 0, 1, 0, 0, 0, 100, 0, 17000, 17000, 21000, 21000, 11, 11084, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Electrocutioner 6000 - In Combat - Cast Shock');
INSERT INTO smart_scripts VALUES (6235, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 21000, 21000, 11, 11082, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Electrocutioner 6000 - In Combat - Cast Megavolt');
INSERT INTO smart_scripts VALUES (6235, 0, 3, 0, 0, 0, 100, 0, 3000, 3000, 21000, 21000, 11, 11085, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Electrocutioner 6000 - In Combat - Cast Chain Bolt');

-- Crowd Pummeler 9-60 (6229)
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|1024, AIName='SmartAI', ScriptName='' WHERE entry=6229;
DELETE FROM smart_scripts WHERE entryorguid=6229 AND source_type=0;
INSERT INTO smart_scripts VALUES (6229, 0, 1, 0, 0, 0, 100, 0, 11000, 11000, 14000, 17000, 11, 10887, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crowd Pummeler 9-60 - In Combat - Cast Crowd Pummel');
INSERT INTO smart_scripts VALUES (6229, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 15000, 15000, 11, 5568, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crowd Pummeler 9-60 - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (6229, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 12000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crowd Pummeler 9-60 - In Combat - Cast Arcing Smash');

-- Mekgineer Thermaplugg (7800)
DELETE FROM creature_text WHERE entry=7800;
INSERT INTO creature_text VALUES (7800, 0, 0, 'Usurpers! Gnomeregan is mine!', 14, 0, 100, 0, 0, 5807, 0, 'Mekgineer Thermaplugg');
INSERT INTO creature_text VALUES (7800, 1, 0, 'My machines are the future! They''ll destroy you all!', 14, 0, 100, 0, 0, 5808, 0, 'Mekgineer Thermaplugg');
INSERT INTO creature_text VALUES (7800, 1, 1, 'Explosions! MORE explosions! I''ve got to have more explosions!', 14, 0, 100, 0, 0, 5809, 0, 'Mekgineer Thermaplugg');
INSERT INTO creature_text VALUES (7800, 2, 0, '...and stay dead! He got served!', 14, 0, 100, 0, 0, 5810, 0, 'Mekgineer Thermaplugg');
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|1024, flags_extra=flags_extra|256, AIName='SmartAI', ScriptName='' WHERE entry=7800;
DELETE FROM smart_scripts WHERE entryorguid=7800 AND source_type=0;
INSERT INTO smart_scripts VALUES (7800, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (7800, 0, 1, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - On Kill - Say Line 2');
INSERT INTO smart_scripts VALUES (7800, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 20000, 35000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - In Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (7800, 0, 3, 0, 0, 0, 100, 0, 3000, 3000, 13000, 14000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (7800, 0, 4, 6, 25, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 15, 0, 150, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - On Reset - Set Data');
INSERT INTO smart_scripts VALUES (7800, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 15, 0, 150, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - On Death - Set Data');
INSERT INTO smart_scripts VALUES (7800, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 7915, 150, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - Linked - Despawn Walking Bombs');
INSERT INTO smart_scripts VALUES (7800, 0, 7, 0, 0, 0, 100, 0, 10000, 10000, 20000, 20000, 11, 11511, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mekgineer Thermaplugg - In Combat - Cast Activate Bomb A');

-- Walking Bomb (7915)
REPLACE INTO creature_template_addon VALUES (7915, 0, 0, 0, 4096, 0, '');
UPDATE creature_template SET mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=7915;
DELETE FROM smart_scripts WHERE entryorguid=7915 AND source_type=0;
INSERT INTO smart_scripts VALUES (7915, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 144, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Walking Bomb - On Update - Move Fall');
INSERT INTO smart_scripts VALUES (7915, 0, 1, 2, 60, 0, 100, 1, 1500, 1500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Walking Bomb - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (7915, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 138, 1000000, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Walking Bomb - On Update - Add Threat');
INSERT INTO smart_scripts VALUES (7915, 0, 3, 0, 9, 0, 100, 0, 0, 5, 0, 0, 11, 11504, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Walking Bomb - Within Range 0-5yd - Cast Walking Bomb Effect');

-- SPELL Activate Bomb A (11511)
DELETE FROM spell_target_position WHERE id IN(11511);
INSERT INTO spell_target_position VALUES (11511, 0, 90, -531.14, 670.136, -310.0, 0.0);
DELETE FROM spell_linked_spell WHERE spell_trigger=11511;
INSERT INTO spell_linked_spell VALUES (11511, 11518, 0, 'Activate Bomb trigger');

-- SPELL Activate Bomb (11518)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=11518;
INSERT INTO conditions VALUES (13, 2, 11518, 0, 0, 31, 0, 5, 142208, 0, 0, 0, 0, '', 'Target Gnome Face 04');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 0, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 04 not in phase 2');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 1, 31, 0, 5, 142209, 0, 0, 0, 0, '', 'Target Gnome Face 03');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 1, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 03 not in phase 2');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 2, 31, 0, 5, 142210, 0, 0, 0, 0, '', 'Target Gnome Face 02');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 2, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 02 not in phase 2');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 3, 31, 0, 5, 142211, 0, 0, 0, 0, '', 'Target Gnome Face 01');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 3, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 01 not in phase 2');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 4, 31, 0, 5, 142212, 0, 0, 0, 0, '', 'Target Gnome Face 06');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 4, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 06 not in phase 2');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 5, 31, 0, 5, 142213, 0, 0, 0, 0, '', 'Target Gnome Face 05');
INSERT INTO conditions VALUES (13, 2, 11518, 0, 5, 26, 0, 2, 0, 0, 1, 0, 0, '', 'Target Gnome Face 05 not in phase 2');

-- GO Gnome Face 04 (142208)
-- GO Gnome Face 03 (142209)
-- GO Gnome Face 02 (142210)
-- GO Gnome Face 01 (142211)
-- GO Gnome Face 06 (142212)
-- GO Gnome Face 05 (142213)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(142208, 142209, 142210, 142211, 142212, 142213);
DELETE FROM smart_scripts WHERE entryorguid IN(142208, 142209, 142210, 142211, 142212, 142213) AND source_type=1;
INSERT INTO smart_scripts VALUES (142208, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 04 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142208, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 04 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142208, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 04 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142208, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 04 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142208, 1, 4, 0, 60, 0, 100, 0, 8500, 8500, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -501.87, 655.21, -315.75, 2.62, 'Gnome Face 04 - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (142209, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 03 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142209, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 03 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142209, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 03 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142209, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 03 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142209, 1, 4, 0, 60, 0, 100, 0, 7000, 7000, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -501.40, 683.53, -315.77, 3.55, 'Gnome Face 03 - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (142210, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 02 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142210, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 02 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142210, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 02 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142210, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 02 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142210, 1, 4, 0, 60, 0, 100, 0, 5500, 5500, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -522.94, 701.96, -315.95, 4.48, 'Gnome Face 02 - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (142211, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 01 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142211, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 01 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142211, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 01 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142211, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 01 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142211, 1, 4, 0, 60, 0, 100, 0, 4000, 4000, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -550.36, 695.84, -316.64, 5.29, 'Gnome Face 01 - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (142212, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 06 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142212, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 06 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142212, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 06 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142212, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 06 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142212, 1, 4, 0, 60, 0, 100, 0, 2500, 2500, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -552.53, 645.29, -314.61, 1.00, 'Gnome Face 06 - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (142213, 1, 0, 1, 8, 0, 100, 0, 11518, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 05 - On Spell Hit - Set GO State');
INSERT INTO smart_scripts VALUES (142213, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 05 - On Spell Hit - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142213, 1, 2, 3, 38, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 05 - On Data Set - Set GO State');
INSERT INTO smart_scripts VALUES (142213, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gnome Face 05 - On Data Set - Set Phase Mask');
INSERT INTO smart_scripts VALUES (142213, 1, 4, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 12, 7915, 4, 10000, 0, 0, 0, 8, 0, 0, 0, -524.90, 638.13, -315.07, 1.79, 'Gnome Face 05 - On Update - Summon Creature');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(142208, 142209, 142210, 142211, 142212, 142213);
INSERT INTO conditions VALUES (22, 5, 142208, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');
INSERT INTO conditions VALUES (22, 5, 142209, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');
INSERT INTO conditions VALUES (22, 5, 142210, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');
INSERT INTO conditions VALUES (22, 5, 142211, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');
INSERT INTO conditions VALUES (22, 5, 142212, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');
INSERT INTO conditions VALUES (22, 5, 142213, 1, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Must be in phase 2 to run event');

-- GO Button (142214)
-- GO Button (142215)
-- GO Button (142216)
-- GO Button (142217)
-- GO Button (142218)
-- GO Button (142219)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(142214, 142215, 142216, 142217, 142218, 142219);
DELETE FROM smart_scripts WHERE entryorguid IN(142214, 142215, 142216, 142217, 142218, 142219) AND source_type=1;
INSERT INTO smart_scripts VALUES (142214, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142211, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (142215, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142210, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (142216, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142209, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (142217, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142208, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (142218, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142213, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (142219, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 20, 142212, 0, 0, 0, 0, 0, 0, 'Button - On Gossip Hello - Set Data');



-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Dark Iron Land Mine (8035)
DELETE FROM creature_text WHERE entry=8035;
INSERT INTO creature_text VALUES (8035, 0, 0, '%s will be armed in 10 seconds!', 16, 0, 100, 0, 0, 0, 0, 'Dark Iron Land Mine');
INSERT INTO creature_text VALUES (8035, 1, 0, '%s will be armed in 5 seconds!', 16, 0, 100, 0, 0, 5871, 0, 'Dark Iron Land Mine');
INSERT INTO creature_text VALUES (8035, 2, 0, '%s is now armed!', 16, 0, 100, 0, 0, 0, 0, 'Dark Iron Land Mine');
UPDATE creature_template SET unit_flags = unit_flags|4|131072, AIName='SmartAI', ScriptName='' WHERE entry=8035;
DELETE FROM smart_scripts WHERE entryorguid=8035 AND source_type=0;
INSERT INTO smart_scripts VALUES (8035, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - On Update - Say Line 0");
INSERT INTO smart_scripts VALUES (8035, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 11816, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - On Update - Cast Land Mine Arming");
INSERT INTO smart_scripts VALUES (8035, 0, 2, 0, 60, 0, 100, 257, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - On Update - Say Line 1");
INSERT INTO smart_scripts VALUES (8035, 0, 3, 4, 60, 0, 100, 257, 10000, 10000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - On Update - Say Line 2");
INSERT INTO smart_scripts VALUES (8035, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 28, 11816, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - On Update - Remove Aura Land Mine Arming");
INSERT INTO smart_scripts VALUES (8035, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - Out of Combat - Set Event Phase");
INSERT INTO smart_scripts VALUES (8035, 0, 6, 7, 9, 1, 100, 0, 0, 6, 0, 0, 11, 4043, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - Within 0-6 Range - Cast Spell");
INSERT INTO smart_scripts VALUES (8035, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dark Iron Land Mine - Within 0-6 Range - Despawn");

-- QUEST A Fine Mess (2904)
UPDATE creature_template SET AIName='', ScriptName='npc_kernobee' WHERE entry=7850;

-- Alarm-a-bomb 2600 (7897)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=7897;

-- Techbot (6231)
DELETE FROM creature_text WHERE entry=6231;
INSERT INTO creature_text VALUES (6231, 0, 0, 'There is no COW level!... really! I repeat: there is no COW level. Well, maby there is...', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 1, 'You are welcome, have a nice day.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 2, 'Please be patient, we will call your name when it is your turn. We are helping people in the order they appear to us on the screen.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 3, 'People think I like corndogs, but actually, they give me indigestion !!!', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 4, 'Techbot is sensitive and those words hurt my ears. :[ Please be nice to me. I just want to help.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 5, 'I am a BOT. I have tons of information. To find out what I know whisper me.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 6, 'When the rep is talking to you, he will start each line with your name. If you don''t see your name, he''s not speaking to you.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 7, 'Remember, if you harass the rep or spam the channel, your account may be kicked, banned or worse.', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
INSERT INTO creature_text VALUES (6231, 0, 8, 'If you have been muted, or have questions about the Muting/UnMuting process, please visit...zzzzttt!!', 12, 0, 100, 0, 0, 0, 0, 'Techbot');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6231;
DELETE FROM smart_scripts WHERE entryorguid=6231 AND source_type=0;
INSERT INTO smart_scripts VALUES (6231, 0, 0, 0, 1, 0, 100, 0, 1000, 5000, 30000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Techbot - Out of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (6231, 0, 1, 0, 0, 0, 100, 0, 15000, 18000, 19000, 38000, 11, 10852, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Techbot - In Combat - Cast Battle Net');
INSERT INTO smart_scripts VALUES (6231, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 15000, 28000, 11, 10855, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Techbot - In Combat - Cast Lag');
INSERT INTO smart_scripts VALUES (6231, 0, 3, 0, 0, 0, 100, 0, 5000, 12000, 15000, 28000, 11, 10858, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Techbot - In Combat - Cast Summon Dupe Bug');

-- Blastmaster Emi Shortfuse (7998)
DELETE FROM creature_text WHERE entry=7998;
INSERT INTO creature_text VALUES (7998, 0, 0, 'With your help, I can evaluate these tunnels.', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_0');
INSERT INTO creature_text VALUES (7998, 1, 0, 'Let''s see if we can find out where these Troggs are coming from... and put a stop to the invasion!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_1');
INSERT INTO creature_text VALUES (7998, 2, 0, 'Such devastation... what horrible mess...', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_2');
INSERT INTO creature_text VALUES (7998, 3, 0, 'It''s quiet here...', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_3');
INSERT INTO creature_text VALUES (7998, 4, 0, '...too quiet.', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_4');
INSERT INTO creature_text VALUES (7998, 5, 0, 'Look! Over there at the tunnel wall!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_5');
INSERT INTO creature_text VALUES (7998, 6, 0, 'Trogg incrusion! Defend me while I blast the hole closed!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_6');
INSERT INTO creature_text VALUES (7998, 7, 0, 'I don''t think one charge is going to cut it. Keep fending them off!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_7');
INSERT INTO creature_text VALUES (7998, 8, 0, 'The charges are set. Get back before they blow!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_8');
INSERT INTO creature_text VALUES (7998, 9, 0, 'Incoming blast in 10 seconds!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_9');
INSERT INTO creature_text VALUES (7998, 10, 0, 'Incoming blast in 5 seconds. Clear the tunnel!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_10');
INSERT INTO creature_text VALUES (7998, 11, 0, 'FIRE IN THE HOLE!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_11');
INSERT INTO creature_text VALUES (7998, 12, 0, 'Well done! Without your help I would have never been able to thwart that wave of troggs.', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_12');
INSERT INTO creature_text VALUES (7998, 13, 0, 'Did you hear something?', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_13');
INSERT INTO creature_text VALUES (7998, 14, 0, 'I heard something over there.', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_14');
INSERT INTO creature_text VALUES (7998, 15, 0, 'More troggs! Ward them off as I prepare the explosives!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_15');
INSERT INTO creature_text VALUES (7998, 16, 0, 'The final charge is set. Stand back!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_16');
INSERT INTO creature_text VALUES (7998, 17, 0, '10 seconds to blast! Stand back!!!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_17');
INSERT INTO creature_text VALUES (7998, 18, 0, '5 seconds until detonation!!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_18');
INSERT INTO creature_text VALUES (7998, 19, 0, 'FIRE IN THE HOLE!', 14, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_19');
INSERT INTO creature_text VALUES (7998, 20, 0, 'Superb! Because of your help, my people stand a chance of re-taking our belowed city. Three cheers to you!', 12, 0, 100, 0, 0, 0, 0, 'SAY_BLASTMASTER_20');
UPDATE creature_template SET faction=42, Health_mod=2, AIName='SmartAI', ScriptName='' WHERE entry=7998;
DELETE FROM script_waypoint WHERE entry=7998;
DELETE FROM waypoints WHERE entry=7998;
INSERT INTO waypoints VALUES (7998, 1, -511.065, -134.51, -152.493, 'Blastmaster Emi Shortfuse'),(7998, 2, -511.862, -131.76, -152.932, 'Blastmaster Emi Shortfuse'),(7998, 3, -513.319, -126.733, -156.095, 'Blastmaster Emi Shortfuse'),(7998, 4, -515.969, -118.962, -156.109, 'Blastmaster Emi Shortfuse'),(7998, 5, -518.983, -111.608, -155.923, 'Blastmaster Emi Shortfuse'),(7998, 6, -522.392, -101.145, -155.228, 'Blastmaster Emi Shortfuse'),(7998, 7, -523.941, -96.9487, -154.823, 'Blastmaster Emi Shortfuse'),(7998, 8, -531.938, -104.249, -156.031, 'Blastmaster Emi Shortfuse'),(7998, 9, -533.141, -105.332, -156.017, 'Blastmaster Emi Shortfuse'),(7998, 10, -541.3, -96.7414, -155.895, 'Blastmaster Emi Shortfuse'),
(7998, 11, -517.556, -106.826, -155.149, 'Blastmaster Emi Shortfuse'),(7998, 12, -508.757, -103.227, -151.742, 'Blastmaster Emi Shortfuse'),(7998, 13, -512.396, -86.3113, -151.642, 'Blastmaster Emi Shortfuse'),(7998, 14, -520.928, -117.679, -156.119, 'Blastmaster Emi Shortfuse'),(7998, 15, -521.717, -119.564, -156.114, 'Blastmaster Emi Shortfuse');
DELETE FROM smart_scripts WHERE entryorguid=7998 AND source_type=0;
INSERT INTO smart_scripts VALUES (7998, 0, 0, 1, 62, 0, 100, 0, 1080, 0, 0, 0, 53, 0, 7998, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Gossip Select - Start WP');
INSERT INTO smart_scripts VALUES (7998, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Gossip Select - Say Line 0');
INSERT INTO smart_scripts VALUES (7998, 0, 2, 0, 40, 0, 100, 0, 1, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 3, 0, 52, 0, 100, 0, 0, 7998, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 1');
INSERT INTO smart_scripts VALUES (7998, 0, 4, 5, 40, 0, 100, 0, 4, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Say Line 2');
INSERT INTO smart_scripts VALUES (7998, 0, 6, 7, 40, 0, 100, 0, 7, 0, 0, 0, 54, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Say Line 3');
INSERT INTO smart_scripts VALUES (7998, 0, 8, 0, 52, 0, 100, 0, 3, 7998, 0, 0, 1, 4, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 4');
INSERT INTO smart_scripts VALUES (7998, 0, 9, 10, 52, 0, 100, 0, 4, 7998, 0, 0, 1, 5, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 5');
INSERT INTO smart_scripts VALUES (7998, 0, 10, 100, 61, 0, 100, 0, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 3.59, 'Blastmaster Emi Shortfuse - On Text Over - Set Orientation');
INSERT INTO smart_scripts VALUES (7998, 0, 11, 12, 52, 0, 100, 0, 5, 7998, 0, 0, 107, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7998, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 6');
INSERT INTO smart_scripts VALUES (7998, 0, 13, 14, 40, 0, 100, 0, 9, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Play Emote');
INSERT INTO smart_scripts VALUES (7998, 0, 15, 16, 56, 0, 100, 0, 9, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Say Line 7');
INSERT INTO smart_scripts VALUES (7998, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183410, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 15, 183410, 30, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Set GameObject Flags');
INSERT INTO smart_scripts VALUES (7998, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7998, 0, 19, 20, 40, 0, 100, 0, 10, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Play Emote');
INSERT INTO smart_scripts VALUES (7998, 0, 21, 22, 56, 0, 100, 0, 10, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Say Line 8');
INSERT INTO smart_scripts VALUES (7998, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183410, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 15, 183410, 30, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Set GameObject Flags');
INSERT INTO smart_scripts VALUES (7998, 0, 24, 25, 40, 0, 100, 0, 11, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 25, 26, 61, 0, 100, 0, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.985, 'Blastmaster Emi Shortfuse - On WP Reached - Set Orientation');
INSERT INTO smart_scripts VALUES (7998, 0, 26, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 9, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Say Line 9');
INSERT INTO smart_scripts VALUES (7998, 0, 27, 0, 52, 0, 100, 0, 9, 7998, 0, 0, 1, 10, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 10');
INSERT INTO smart_scripts VALUES (7998, 0, 28, 29, 52, 0, 100, 0, 10, 7998, 0, 0, 1, 11, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 11');
INSERT INTO smart_scripts VALUES (7998, 0, 29, 30, 61, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 146086, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Set GO State');
INSERT INTO smart_scripts VALUES (7998, 0, 30, 31, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183410, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Despawn GO');
INSERT INTO smart_scripts VALUES (7998, 0, 31, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12158, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Cast Explosion');
INSERT INTO smart_scripts VALUES (7998, 0, 32, 0, 52, 0, 100, 0, 11, 7998, 0, 0, 1, 12, 9000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 12');
INSERT INTO smart_scripts VALUES (7998, 0, 33, 0, 52, 0, 100, 0, 12, 7998, 0, 0, 1, 13, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 13');
INSERT INTO smart_scripts VALUES (7998, 0, 35, 36, 52, 0, 100, 0, 13, 7998, 0, 0, 1, 14, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 14');
INSERT INTO smart_scripts VALUES (7998, 0, 36, 101, 61, 0, 100, 0, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.135, 'Blastmaster Emi Shortfuse - On Text Over - Set Orientation');
INSERT INTO smart_scripts VALUES (7998, 0, 37, 38, 52, 0, 100, 0, 14, 7998, 0, 0, 107, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7998, 0, 38, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 15');
INSERT INTO smart_scripts VALUES (7998, 0, 40, 41, 40, 0, 100, 0, 12, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 41, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Play Emote');
INSERT INTO smart_scripts VALUES (7998, 0, 42, 43, 56, 0, 100, 0, 12, 0, 0, 0, 50, 183410, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 43, 44, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 15, 183410, 30, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Set GameObject Flags');
INSERT INTO smart_scripts VALUES (7998, 0, 44, 0, 61, 0, 100, 0, 0, 0, 0, 0, 107, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7998, 0, 45, 46, 40, 0, 100, 0, 13, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 46, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Play Emote');
INSERT INTO smart_scripts VALUES (7998, 0, 47, 48, 56, 0, 100, 0, 13, 0, 0, 0, 1, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Say Line 16');
INSERT INTO smart_scripts VALUES (7998, 0, 48, 49, 61, 0, 100, 0, 0, 0, 0, 0, 50, 183410, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 49, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 15, 183410, 30, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Resumed - Set GameObject Flags');
INSERT INTO smart_scripts VALUES (7998, 0, 50, 51, 40, 0, 100, 0, 14, 0, 0, 0, 54, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (7998, 0, 51, 52, 61, 0, 100, 0, 0, 0, 0, 0, 107, 4, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Summon Creature Group');
INSERT INTO smart_scripts VALUES (7998, 0, 52, 70, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Set Event Phase');
INSERT INTO smart_scripts VALUES (7998, 0, 70, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 1, 0, 0, 0, 0, 0, 19, 7361, 100, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On WP Reached - Attack Start');
INSERT INTO smart_scripts VALUES (7998, 0, 53, 0, 7, 1, 100, 0, 0, 0, 0, 0, 1, 17, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Evade - Say Line 17');
INSERT INTO smart_scripts VALUES (7998, 0, 54, 0, 52, 0, 100, 0, 17, 7998, 0, 0, 1, 18, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 18');
INSERT INTO smart_scripts VALUES (7998, 0, 55, 56, 52, 0, 100, 0, 18, 7998, 0, 0, 1, 19, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 19');
INSERT INTO smart_scripts VALUES (7998, 0, 56, 57, 61, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 146085, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Set GO State');
INSERT INTO smart_scripts VALUES (7998, 0, 57, 58, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 15, 183410, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Despawn GO');
INSERT INTO smart_scripts VALUES (7998, 0, 58, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 12159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Cast Explosion');
INSERT INTO smart_scripts VALUES (7998, 0, 59, 0, 52, 0, 100, 0, 19, 7998, 0, 0, 1, 20, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Say Line 20');
INSERT INTO smart_scripts VALUES (7998, 0, 60, 61, 52, 0, 100, 0, 20, 7998, 0, 0, 11, 11542, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Cast Red Streaks Firework');
INSERT INTO smart_scripts VALUES (7998, 0, 61, 63, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Despawn');
INSERT INTO smart_scripts VALUES (7998, 0, 63, 64, 61, 0, 100, 0, 0, 0, 0, 0, 50, 103820, 0, 0, 0, 0, 0, 8, 0, 0, 0, -511.3304, -139.9622, -152.4761, 0.750490, 'Blastmaster Emi Shortfuse - On Text Over - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 64, 65, 61, 0, 100, 0, 0, 0, 0, 0, 50, 103820, 0, 0, 0, 0, 0, 8, 0, 0, 0, -510.6754, -139.4371, -152.6167, 3.33359, 'Blastmaster Emi Shortfuse - On Text Over - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 65, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 103820, 0, 0, 0, 0, 0, 8, 0, 0, 0, -511.8976, -139.3562, -152.4785, 3.961899, 'Blastmaster Emi Shortfuse - On Text Over - Summon GameObject');
INSERT INTO smart_scripts VALUES (7998, 0, 100, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 146086, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Set GO State');
INSERT INTO smart_scripts VALUES (7998, 0, 101, 0, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 146085, 50, 0, 0, 0, 0, 0, 'Blastmaster Emi Shortfuse - On Text Over - Set GO State');
DELETE FROM creature_summon_groups WHERE summonerId=7998;
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -557.630, -114.514, -152.209, 0.641, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -555.263, -113.802, -152.737, 0.311, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -552.154, -112.476, -153.349, 0.621, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -548.692, -111.089, -154.090, 0.621, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -546.905, -108.340, -154.877, 0.729, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -547.736, -105.154, -155.176, 0.372, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -547.274, -114.109, -153.952, 0.735, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -552.534, -110.012, -153.577, 0.747, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -550.708, -116.436, -153.103, 0.679, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 1, 6207, -554.030, -115.983, -152.635, 0.695, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 2, 6207, -557.630, -114.514, -152.209, 0.641, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 2, 6207, -555.263, -113.802, -152.737, 0.311, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 2, 6207, -552.154, -112.476, -153.349, 0.621, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 2, 6207, -548.692, -111.089, -154.090, 0.621, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 3, 6207, -494.595, -87.516, -149.116, 3.344, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 3, 6207, -493.349, -90.845, -148.882, 3.717, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 3, 6207, -491.995, -87.619, -148.197, 3.230, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 3, 6207, -490.732, -90.739, -148.091, 3.230, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 3, 6207, -490.554, -89.114, -148.055, 3.230, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 4, 7361, -495.240, -90.808, -149.493, 3.238, 4, 60000);
INSERT INTO creature_summon_groups VALUES (7998, 0, 4, 6215, -494.195, -89.553, -149.131, 3.254, 4, 60000);

-- SPELL Explosion (12158)
-- SPELL Explosion (12159)
DELETE FROM spell_target_position WHERE id IN(12158, 12159);
INSERT INTO spell_target_position VALUES (12158, 0, 90, -563.86, -118.22, -150.95, 0.0);
INSERT INTO spell_target_position VALUES (12159, 0, 90, -479.82, -86.88, -146.42, 0.0);

-- Grubbis (7361)
DELETE FROM creature_text WHERE entry=7361;
INSERT INTO creature_text VALUES (7361, 0, 0, 'We come from below! You can never stop us!', 14, 0, 100, 0, 0, 0, 0, 'SAY_GRUBBIS');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7361;
DELETE FROM smart_scripts WHERE entryorguid=7361 AND source_type=0;
INSERT INTO smart_scripts VALUES (7361, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Grubbis - On Aggro - Say Line 0");

-- Chomper (6215)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=6215;
DELETE FROM smart_scripts WHERE entryorguid=6215 AND source_type=0;

-- GO Matrix Punchograph 3005-A (142345)
DELETE FROM gossip_menu_option WHERE menu_id=1045;
INSERT INTO gossip_menu_option VALUES (1045, 0, 0, 'Acquire Higher Level Access Card', 1, 1, 1044, 0, 0, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=142345;
DELETE FROM smart_scripts WHERE entryorguid=142345 AND source_type=1;
INSERT INTO smart_scripts VALUES (142345, 1, 0, 0, 62, 0, 100, 0, 1045, 0, 0, 0, 85, 11512, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-A - On Gossip Hello - Invoker Cast Create Yellow Punch Card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1045;
INSERT INTO conditions VALUES (14, 1045, 1643, 0, 0, 2, 0, 9279, 1, 0, 1, 0, 0, '', 'Display text if player does not have white card');
INSERT INTO conditions VALUES (14, 1045, 1753, 0, 0, 2, 0, 9279, 1, 0, 0, 0, 0, '', 'Display text if player has white card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1045;
INSERT INTO conditions VALUES (15, 1045, 0, 0, 0, 2, 0, 9279, 1, 0, 0, 0, 0, '', 'Display option if player has white card');

-- GO Matrix Punchograph 3005-B (142475)
DELETE FROM gossip_menu WHERE entry=1047;
INSERT INTO gossip_menu VALUES (1047, 1647),(1047, 1754),(1047, 1655);
DELETE FROM gossip_menu WHERE entry=1051;
INSERT INTO gossip_menu VALUES (1051, 1656),(1051, 1657);
DELETE FROM gossip_menu_option WHERE menu_id=1047;
INSERT INTO gossip_menu_option VALUES (1047, 0, 0, 'Acquire Higher Level Access Card', 1, 1, 1046, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (1047, 1, 0, 'Access: Minor Recombobulator', 1, 1, 1051, 0, 0, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=142475;
DELETE FROM smart_scripts WHERE entryorguid=142475 AND source_type=1;
INSERT INTO smart_scripts VALUES (142475, 1, 0, 0, 62, 0, 100, 0, 1047, 0, 0, 0, 85, 11525, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-B - On Gossip Hello - Invoker Cast Create Blue Punch Card');
INSERT INTO smart_scripts VALUES (142475, 1, 1, 0, 62, 0, 100, 0, 1047, 1, 0, 0, 85, 4011, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-B - On Gossip Hello - Invoker Cast Minor Recombobulator');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1047;
INSERT INTO conditions VALUES (14, 1047, 1647, 0, 0, 2, 0, 9280, 1, 0, 1, 0, 0, '', 'Display text if player does not have yellow card');
INSERT INTO conditions VALUES (14, 1047, 1754, 0, 0, 2, 0, 9280, 1, 0, 0, 0, 0, '', 'Display text if player has yellow card');
INSERT INTO conditions VALUES (14, 1047, 1754, 0, 0, 2, 0, 9327, 1, 0, 1, 0, 0, '', 'Display text if player does not have delta card');
INSERT INTO conditions VALUES (14, 1047, 1655, 0, 0, 2, 0, 9280, 1, 0, 0, 0, 0, '', 'Display text if player has yellow card');
INSERT INTO conditions VALUES (14, 1047, 1655, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Display text if player has delta card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1047;
INSERT INTO conditions VALUES (15, 1047, 0, 0, 0, 2, 0, 9280, 1, 0, 0, 0, 0, '', 'Display option if player has yellow card');
INSERT INTO conditions VALUES (15, 1047, 1, 0, 0, 2, 0, 9280, 1, 0, 0, 0, 0, '', 'Display option if player has yellow card');
INSERT INTO conditions VALUES (15, 1047, 1, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Display option if player has delta card');
INSERT INTO conditions VALUES (15, 1047, 1, 0, 0, 25, 0, 3952, 0, 0, 1, 0, 0, '', 'Display option if player has no minor recombobulator spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1051;
INSERT INTO conditions VALUES (14, 1051, 1656, 0, 0, 7, 0, 202, 140, 0, 1, 0, 0, '', 'Display text if player skill in engineering is not higher than 140');
INSERT INTO conditions VALUES (14, 1051, 1657, 0, 0, 7, 0, 202, 140, 0, 0, 0, 0, '', 'Display text if player skill in engineering is higher or at 140');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=142475;
INSERT INTO conditions VALUES (22, 2, 142475, 1, 0, 7, 0, 202, 140, 0, 0, 0, 0, '', 'run action if invoker skill in engineering is higher or at 140');

-- GO Matrix Punchograph 3005-C (142476)
DELETE FROM gossip_menu_option WHERE menu_id=1049;
INSERT INTO gossip_menu_option VALUES (1049, 0, 0, 'Acquire Higher Level Access Card', 1, 1, 1048, 0, 0, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=142476;
DELETE FROM smart_scripts WHERE entryorguid=142476 AND source_type=1;
INSERT INTO smart_scripts VALUES (142476, 1, 0, 0, 62, 0, 100, 0, 1049, 0, 0, 0, 85, 11528, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-C - On Gossip Hello - Invoker Cast Create Red Punch Card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1049;
INSERT INTO conditions VALUES (14, 1049, 1649, 0, 0, 2, 0, 9282, 1, 0, 1, 0, 0, '', 'Display text if player does not have blue card');
INSERT INTO conditions VALUES (14, 1049, 1755, 0, 0, 2, 0, 9282, 1, 0, 0, 0, 0, '', 'Display text if player has blue card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1049;
INSERT INTO conditions VALUES (15, 1049, 0, 0, 0, 2, 0, 9282, 1, 0, 0, 0, 0, '', 'Display option if player has blue card');

-- GO Matrix Punchograph 3005-D (142696)
DELETE FROM gossip_menu WHERE entry=1050;
INSERT INTO gossip_menu VALUES (1050, 1651),(1050, 1756),(1050, 1655);
DELETE FROM gossip_menu WHERE entry=1054;
INSERT INTO gossip_menu VALUES (1054, 1656),(1054, 1657);
DELETE FROM gossip_menu_option WHERE menu_id=1050;
INSERT INTO gossip_menu_option VALUES (1050, 0, 0, 'Acquire high level data card.', 1, 1, 1052, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (1050, 1, 0, 'Use engineering to access hidden schematics!', 1, 1, 1054, 0, 0, 0, '');
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=142696;
DELETE FROM smart_scripts WHERE entryorguid=142696 AND source_type=1;
INSERT INTO smart_scripts VALUES (142696, 1, 0, 0, 62, 0, 100, 0, 1050, 0, 0, 0, 85, 11545, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-D - On Gossip Hello - Invoker Cast Create Prismatic Punch Card');
INSERT INTO smart_scripts VALUES (142696, 1, 1, 0, 62, 0, 100, 0, 1050, 1, 0, 0, 85, 11595, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Matrix Punchograph 3005-D - On Gossip Hello - Invoker Cast Discombobulator Ray');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1050;
INSERT INTO conditions VALUES (14, 1050, 1651, 0, 0, 2, 0, 9281, 1, 0, 1, 0, 0, '', 'Display text if player does not have red card');
INSERT INTO conditions VALUES (14, 1050, 1756, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display text if player has red card');
INSERT INTO conditions VALUES (14, 1050, 1756, 0, 0, 2, 0, 9327, 1, 0, 1, 0, 0, '', 'Display text if player does not have delta card');
INSERT INTO conditions VALUES (14, 1050, 1655, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display text if player has red card');
INSERT INTO conditions VALUES (14, 1050, 1655, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Display text if player has delta card');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1050;
INSERT INTO conditions VALUES (15, 1050, 0, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display option if player has red card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display option if player has red card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Display option if player has delta card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 25, 0, 3959, 0, 0, 1, 0, 0, '', 'Display option if player has no Discombobulator Ray spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=1054;
INSERT INTO conditions VALUES (14, 1054, 1656, 0, 0, 7, 0, 202, 160, 0, 1, 0, 0, '', 'Display text if player skill in engineering is not higher than 160');
INSERT INTO conditions VALUES (14, 1054, 1657, 0, 0, 7, 0, 202, 160, 0, 0, 0, 0, '', 'Display text if player skill in engineering is higher or at 160');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=142696;
INSERT INTO conditions VALUES (22, 2, 142696, 1, 0, 7, 0, 202, 160, 0, 0, 0, 0, '', 'run action if invoker skill in engineering is higher or at 160');

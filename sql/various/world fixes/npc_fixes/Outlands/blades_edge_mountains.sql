
-- Skyguard Khatie (23335)
DELETE FROM creature_text WHERE entry=23335;
REPLACE INTO creature_text VALUES (23335, 0, 0, "Huh? What? I'm a little busy here, friend!$B$BOf course, if you're here to help, I've got all the time in the world.", 12, 0, 100, 1, 0, 0, 0, 'Skyguard Khatie Neutral');
REPLACE INTO creature_text VALUES (23335, 1, 0, "Hey there, $c!$B$B<Khatie looks at you slyly.>$B$BAnytime you want to wrangle us up some more aether rays, you make sure to come and see me!", 12, 0, 100, 1, 0, 0, 0, 'Skyguard Khatie Friendly');
REPLACE INTO creature_text VALUES (23335, 2, 0, "You know, $n, it's such an honor to work with you!$B$BWhen you're not busy wrangling, maybe we could $g go out some place for dinner? : get together for a girl's night?;$B$BOh, did I mention that we can now get you to our base in the Skethyl Mountains real quick?  If you want, speak with Skyguard Handler Irena about that.", 12, 0, 100, 1, 0, 0, 0, 'Skyguard Khatie Honored');
REPLACE INTO creature_text VALUES (23335, 3, 0, "So, you've been around a lot, but we seem to keep missing each other for getting together after work.$B$BIs it me?$B$B<Khatie purposely cheers up.>$B$BAnyway, I just wanted to say that I... we really appreciate everything that you've been doing for the Skyguard!", 12, 0, 100, 6, 0, 0, 0, 'Skyguard Khatie Revered');
REPLACE INTO creature_text VALUES (23335, 4, 0, "I hope you don't think I'm a stalker, or anything like that, $n.$B$BI mean, I know that you're real famous within the Skyguard now, and well... I'm sure that you wouldn't want to hang out with a lowly peon like me.$B$BBut, if you ever want to get together to just hang out, or even wrangle some more rays, drop by anytime!  I'll be here.$B$BI miss you...", 12, 0, 100, 1, 0, 0, 0, 'Skyguard Khatie Exalted');
REPLACE INTO creature VALUES (44255, 23335, 530, 1, 1, 0, 1, 2547.77, 7330.44, 373.423, 3.81759, 60, 0, 0, 6986, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=23335;
DELETE FROM smart_scripts WHERE entryorguid=23335 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(23335*100+0, 23335*100+1, 23335*100+2, 23335*100+3 ,23335*100+4) AND source_type=9;
INSERT INTO smart_scripts VALUES (23335, 0, 0, 0, 20, 0, 100, 0, 11065, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 23343, 15, 0, 0, 0, 0, 0, 'Skyguard Khatie - On Quest Reward Wrangle More Aether Rays! - Despawn Target');
INSERT INTO smart_scripts VALUES (23335, 0, 1, 0, 20, 0, 100, 0, 11066, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 23343, 15, 0, 0, 0, 0, 0, 'Skyguard Khatie - On Quest Reward Wrangle More Aether Rays! - Despawn Target');
INSERT INTO smart_scripts VALUES (23335, 0, 2, 7, 10, 0, 100, 0, 1, 20, 5000, 5000, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Store Target');
INSERT INTO smart_scripts VALUES (23335, 0, 3, 8, 10, 0, 100, 0, 1, 20, 5000, 5000, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Store Target');
INSERT INTO smart_scripts VALUES (23335, 0, 4, 9, 10, 0, 100, 0, 1, 20, 5000, 5000, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Store Target');
INSERT INTO smart_scripts VALUES (23335, 0, 5, 10, 10, 0, 100, 0, 1, 20, 5000, 5000, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Store Target');
INSERT INTO smart_scripts VALUES (23335, 0, 6, 11, 10, 0, 100, 0, 1, 20, 5000, 5000, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Store Target');
INSERT INTO smart_scripts VALUES (23335, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23335*100+0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Start Script');
INSERT INTO smart_scripts VALUES (23335, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23335*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Start Script');
INSERT INTO smart_scripts VALUES (23335, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23335*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Start Script');
INSERT INTO smart_scripts VALUES (23335, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23335*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Start Script');
INSERT INTO smart_scripts VALUES (23335, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23335*100+4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - On OOC Los - Start Script');
INSERT INTO smart_scripts VALUES (23335*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+0, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Talk Neutral');
INSERT INTO smart_scripts VALUES (23335*100+0, 9, 2, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Talk Friendly');
INSERT INTO smart_scripts VALUES (23335*100+1, 9, 2, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Talk Honored');
INSERT INTO smart_scripts VALUES (23335*100+2, 9, 2, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Talk Revered');
INSERT INTO smart_scripts VALUES (23335*100+3, 9, 2, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23335*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Talk Exalted');
INSERT INTO smart_scripts VALUES (23335*100+4, 9, 2, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Khatie - Script9 - Set Phase Mask');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=23335;
INSERT INTO conditions VALUES (22, 3, 23335, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');
INSERT INTO conditions VALUES (22, 3, 23335, 0, 0, 34, 1, 0, 8, 0, 0, 0, 0, '', 'Run Action if invoker is neutral to me');
INSERT INTO conditions VALUES (22, 3, 23335, 0, 0, 26, 1, 2, 0, 0, 1, 0, 0, '', 'Run Action if me is not in phase 2');
INSERT INTO conditions VALUES (22, 4, 23335, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');
INSERT INTO conditions VALUES (22, 4, 23335, 0, 0, 34, 1, 0, 16, 0, 0, 0, 0, '', 'Run Action if invoker is friendly to me');
INSERT INTO conditions VALUES (22, 4, 23335, 0, 0, 26, 1, 2, 0, 0, 1, 0, 0, '', 'Run Action if me is not in phase 2');
INSERT INTO conditions VALUES (22, 5, 23335, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');
INSERT INTO conditions VALUES (22, 5, 23335, 0, 0, 34, 1, 0, 32, 0, 0, 0, 0, '', 'Run Action if invoker is honored to me');
INSERT INTO conditions VALUES (22, 5, 23335, 0, 0, 26, 1, 2, 0, 0, 1, 0, 0, '', 'Run Action if me is not in phase 2');
INSERT INTO conditions VALUES (22, 6, 23335, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');
INSERT INTO conditions VALUES (22, 6, 23335, 0, 0, 34, 1, 0, 64, 0, 0, 0, 0, '', 'Run Action if invoker is revered to me');
INSERT INTO conditions VALUES (22, 6, 23335, 0, 0, 26, 1, 2, 0, 0, 1, 0, 0, '', 'Run Action if me is not in phase 2');
INSERT INTO conditions VALUES (22, 7, 23335, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is a player');
INSERT INTO conditions VALUES (22, 7, 23335, 0, 0, 34, 1, 0, 128, 0, 0, 0, 0, '', 'Run Action if invoker is exalted to me');
INSERT INTO conditions VALUES (22, 7, 23335, 0, 0, 26, 1, 2, 0, 0, 1, 0, 0, '', 'Run Action if me is not in phase 2');

-- Vekh <Leader of the Vekh'nir> (22305)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=22305;
DELETE FROM smart_scripts WHERE entryorguid=22305 AND source_type=0;
INSERT INTO smart_scripts VALUES (22305, 0, 0, 0, 14, 0, 100, 0, 2000, 30, 7000, 9000, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Vekh - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (22305, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 8000, 13800, 11, 37582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vekh - In Combat - Cast Whirlwind');

-- Dreadwing (21032)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21032;
DELETE FROM smart_scripts WHERE entryorguid=21032 AND source_type=0;
INSERT INTO smart_scripts VALUES (21032, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 14000, 20000, 11, 36631, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreadwing - In Combat - Cast Netherbreath');
INSERT INTO smart_scripts VALUES (21032, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 11000, 16800, 11, 36513, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dreadwing - In Combat - Cast Intangible Presence');

-- Orb Collecting Totem (22333)
UPDATE creature_template SET faction=35, type=11, unit_flags=4 WHERE entry=22333;

-- Maggoc <Son of Gruul> (20600)
DELETE FROM creature_text WHERE entry=20600;
INSERT INTO creature_text VALUES (20600, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Maggoc');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20600;
DELETE FROM smart_scripts WHERE entryorguid=20600 AND source_type=0;
INSERT INTO smart_scripts VALUES (20600, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 25000, 11, 38770, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - In Combat - Cast Mortal Wound');
INSERT INTO smart_scripts VALUES (20600, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 12000, 18000, 11, 38777, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Maggoc - In Combat - Cast Rock Rumble');
INSERT INTO smart_scripts VALUES (20600, 0, 2, 0, 9, 0, 100, 0, 5, 30, 8000, 13000, 11, 42139, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - Within Range 5-30yd - Cast Boulder');
INSERT INTO smart_scripts VALUES (20600, 0, 3, 4, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - Between Health 0-30% - Say Line 0');
INSERT INTO smart_scripts VALUES (20600, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 40743, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - Between Health 0-30% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (20600, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 39891, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - On Death - Cast Maggoc: Summon Maggoc''s Treasure Chest');

-- Draaca Longtail (22396)
DELETE FROM creature_text WHERE entry=22396;
INSERT INTO creature_text VALUES (22396, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Draaca Longtail');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=22396;
DELETE FROM smart_scripts WHERE entryorguid=22396 AND source_type=0;
INSERT INTO smart_scripts VALUES (22396, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 8000, 14000, 11, 32009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Draaca Longtail - In Combat - Cast Cutdown');
INSERT INTO smart_scripts VALUES (22396, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Draaca Longtail - Between Health 0-30% - Say Line 0');
INSERT INTO smart_scripts VALUES (22396, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 8599, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Draaca Longtail - Between Health 0-30% - Cast Frenzy');

-- Maxnar the Ashmaw <Wyrmcult Patriarch> (21389)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21389;
DELETE FROM smart_scripts WHERE entryorguid=21389 AND source_type=0;
INSERT INTO smart_scripts VALUES (21389, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 15000, 25000, 11, 37638, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maxnar the Ashmaw - In Combat - Cast Flame Breath');
INSERT INTO smart_scripts VALUES (21389, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 12000, 18000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maxnar the Ashmaw - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (21389, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 12000, 18000, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maxnar the Ashmaw - In Combat - Cast Mortal Strike');

-- Greater Crust Burster (21380)
UPDATE creature_template SET flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21380;
DELETE FROM smart_scripts WHERE entryorguid=21380 AND source_type=0;
INSERT INTO smart_scripts VALUES (21380, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Reset - Set Unit Flag');
INSERT INTO smart_scripts VALUES (21380, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 19, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Reset - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (21380, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 29147, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Reset - Cast Tunnel Bore Passive');
INSERT INTO smart_scripts VALUES (21380, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Reset - Set Bytes0');
INSERT INTO smart_scripts VALUES (21380, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Aggro - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (21380, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 18, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Aggro - Set Unit Flag');
INSERT INTO smart_scripts VALUES (21380, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 28, 29147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Aggro - Remove Aura Tunnel Bore Passive');
INSERT INTO smart_scripts VALUES (21380, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 147, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - On Aggro - Stop Motion');
INSERT INTO smart_scripts VALUES (21380, 0, 8, 0, 0, 0, 100, 1, 100, 100, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - In Combat - Remove Bytes0');
INSERT INTO smart_scripts VALUES (21380, 0, 9, 0, 0, 0, 100, 0, 1000, 6000, 8000, 11000, 11, 32738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - In Combat - Cast Bore');
INSERT INTO smart_scripts VALUES (21380, 0, 10, 0, 9, 0, 100, 0, 4, 50, 2000, 3500, 11, 31747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Crust Burster - Within Range 5-50yd - Cast Poison');

-- Razaani Raider (20601)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20601;
DELETE FROM smart_scripts WHERE entryorguid=20601 AND source_type=0;
INSERT INTO smart_scripts VALUES (20601, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 12000, 18000, 11, 35922, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razaani Raider - In Combat - Cast Energy Flare');
INSERT INTO smart_scripts VALUES (20601, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 11000, 25000, 11, 32920, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razaani Raider - In Combat - Cast Warp');
INSERT INTO smart_scripts VALUES (20601, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 35737, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razaani Raider - On Death - Cast Summon Deadsoul Orb');

-- Razaani Nexus Stalker (20609)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20609;
DELETE FROM smart_scripts WHERE entryorguid=20609 AND source_type=0;
INSERT INTO smart_scripts VALUES (20609, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 12000, 28000, 11, 36513, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razaani Nexus Stalker - In Combat - Cast Intangible Presence');
INSERT INTO smart_scripts VALUES (20609, 0, 1, 0, 0, 0, 100, 0, 3000, 11000, 11000, 25000, 11, 11975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razaani Nexus Stalker - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (20609, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 35737, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razaani Nexus Stalker - On Death - Cast Summon Deadsoul Orb');

-- Razaani Spell-Thief (20614)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20614;
DELETE FROM smart_scripts WHERE entryorguid=20614 AND source_type=0;
INSERT INTO smart_scripts VALUES (20614, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 8000, 15000, 11, 36508, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razaani Spell-Thief - In Combat - Cast Energy Surge');
INSERT INTO smart_scripts VALUES (20614, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 35737, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razaani Spell-Thief - On Death - Cast Summon Deadsoul Orb');

-- Blade's Edge - Deadsoul Orb (20845)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=20845);
DELETE FROM creature WHERE id=20845;
UPDATE creature_template SET speed_run=0.3, AIName='SmartAI', ScriptName='' WHERE entry=20845;
DELETE FROM smart_scripts WHERE entryorguid=20845 AND source_type=0;
INSERT INTO smart_scripts VALUES (20845, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 11, 33345, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - On Update - Cast Yellow Banish State');
INSERT INTO smart_scripts VALUES (20845, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 19, 20851, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - On Update - Move To Orb Flight 1');
INSERT INTO smart_scripts VALUES (20845, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 67, 1, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (20845, 0, 3, 0, 34, 0, 100, 0, 8, 2, 0, 0, 67, 2, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (20845, 0, 4, 0, 34, 0, 100, 0, 8, 3, 0, 0, 67, 3, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (20845, 0, 5, 0, 34, 0, 100, 0, 8, 4, 0, 0, 67, 4, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (20845, 0, 6, 0, 34, 0, 100, 0, 8, 5, 0, 0, 67, 5, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Create Timed Event');
INSERT INTO smart_scripts VALUES (20845, 0, 7, 8, 34, 0, 100, 0, 8, 6, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 72910, 20666, 1, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Set Counter');
INSERT INTO smart_scripts VALUES (20845, 0, 8, 15, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (20845, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Despawn');
INSERT INTO smart_scripts VALUES (20845, 0, 9, 0, 59, 0, 100, 0, 1, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 19, 20852, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Move To Orb Flight 2');
INSERT INTO smart_scripts VALUES (20845, 0, 10, 0, 59, 0, 100, 0, 2, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 19, 20853, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Move To Orb Flight 3');
INSERT INTO smart_scripts VALUES (20845, 0, 11, 0, 59, 0, 100, 0, 3, 0, 0, 0, 69, 4, 0, 0, 0, 0, 0, 19, 20855, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Move To Orb Flight 4');
INSERT INTO smart_scripts VALUES (20845, 0, 12, 0, 59, 0, 100, 0, 4, 0, 0, 0, 69, 5, 0, 0, 0, 0, 0, 19, 20856, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Move To Orb Flight 5');
INSERT INTO smart_scripts VALUES (20845, 0, 13, 14, 59, 0, 100, 0, 5, 0, 0, 0, 11, 36666, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Cast Speed Up');
INSERT INTO smart_scripts VALUES (20845, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 6, 0, 0, 0, 0, 0, 10, 72910, 20666, 1, 0, 0, 0, 0, 'Blade''s Edge - Deadsoul Orb - Movement Inform - Move To Orb Trigger 1');

-- Blade's Edge - Orb Trigger 01 (20666)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20666;
DELETE FROM smart_scripts WHERE entryorguid=20666 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20666*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20666, 0, 0, 0, 77, 0, 100, 0, 1, 1, 0, 0, 11, 35709, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Counter Set - Cast White Banish State');
INSERT INTO smart_scripts VALUES (20666, 0, 1, 0, 77, 0, 100, 0, 1, 10, 0, 0, 80, 20666*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Counter Set - Run Script');
INSERT INTO smart_scripts VALUES (20666*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Set Active');
INSERT INTO smart_scripts VALUES (20666*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 6, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 35960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Multi Gold Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 7, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 86, 36000, 0, 10, 73835, 21025, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Purple Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 8, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 86, 36000, 0, 10, 73835, 21025, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Purple Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 9, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 86, 36000, 0, 10, 73835, 21025, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Purple Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 10, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 86, 36000, 0, 10, 73835, 21025, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Cast Purple Beam');
INSERT INTO smart_scripts VALUES (20666*100, 9, 11, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 35709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Remove Aura White Banish State');
INSERT INTO smart_scripts VALUES (20666*100, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 21057, 8, 0, 0, 0, 0, 8, 0, 0, 0, 2815.03, 5242.67, 264.46, 5.23, 'Blade''s Edge - Orb Trigger 01 - On Script - Summon Nexus Prince Razaan');
INSERT INTO smart_scripts VALUES (20666*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Reset Counter');
INSERT INTO smart_scripts VALUES (20666*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Orb Trigger 01 - On Script - Set Active off');

-- Target Blade''s Edge - Orb Trigger 01 (20666)
UPDATE creature SET id=21053 WHERE id=20666 AND guid<>72910;
UPDATE creature SET position_x=2817.25, position_y=5247.839, position_z=270.56 WHERE guid=73960 AND id IN(20666, 21053);
UPDATE creature SET position_x=2810.02, position_y=5242.95, position_z=267.122 WHERE guid=72917 AND id IN(20666, 21053);

-- Target Blade''s Edge - Orb Trigger 03 (21053)
UPDATE creature_template SET scale=0.3 WHERE entry=21053;

-- SPELL Blade's Edge Multi Gold Beam (35960)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=35960;
INSERT INTO conditions VALUES (13, 1, 35960, 0, 0, 31, 0, 3, 21053, 0, 0, 0, 0, '', 'Target Blade''s Edge - Orb Trigger 03');

-- SPELL Blade's Edge Purple Beam (02) (36000)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36000;
INSERT INTO conditions VALUES (13, 1, 36000, 0, 0, 31, 0, 3, 21053, 0, 0, 0, 0, '', 'Target Blade''s Edge - Orb Trigger 03');

-- Nexus-Prince Razaan (21057)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21057);
DELETE FROM creature WHERE id=21057;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21057;
DELETE FROM smart_scripts WHERE entryorguid=21057 AND source_type=0;
INSERT INTO smart_scripts VALUES (21057, 0, 0, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Razaan - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (21057, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 34808, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Razaan - On Update - Cast Arcane Explosion Effect');
INSERT INTO smart_scripts VALUES (21057, 0, 2, 0, 0, 0, 100, 0, 4000, 11000, 14000, 25000, 11, 35924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Razaan - In Combat - Cast Energy Flux');
INSERT INTO smart_scripts VALUES (21057, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 37957, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus-Prince Razaan - On Death - Cast Gnome Mercy: Summon Collection of Souls Chest');

-- Overseer Theredis (20416)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20416;
DELETE FROM smart_scripts WHERE entryorguid=20416 AND source_type=0;
INSERT INTO smart_scripts VALUES (20416, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 15000, 25000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Theredis - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (20416, 0, 1, 0, 0, 0, 100, 0, 8000, 15000, 15000, 25000, 11, 35871, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Theredis - In Combat - Cast Spellbreaker');

-- Apexis Guardian (22275)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=22275;
DELETE FROM smart_scripts WHERE entryorguid=22275 AND source_type=0;
INSERT INTO smart_scripts VALUES (22275, 0, 0, 0, 0, 0, 100, 0, 6000, 12000, 15000, 25000, 11, 40846, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Apexis Guardian - In Combat - Cast Crystal Prison');
DELETE FROM spell_script_names WHERE spell_id IN(40846, -40846, 40898, -40898);
DELETE FROM spell_scripts WHERE id IN(40846, -40846, 40898, -40898);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(40846, -40846, 40898, -40898) OR spell_effect IN(40846, -40846, 40898, -40898);
INSERT INTO spell_script_names VALUES(40846, 'spell_npc22275_crystal_prison');

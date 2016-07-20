
UPDATE creature SET spawntimesecs=7*86400 WHERE map=564 AND spawntimesecs>0;
DELETE FROM disables WHERE sourceType=2 AND entry=564;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Coilskar Harpooner (22874)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22874;
DELETE FROM smart_scripts WHERE entryorguid=22874 AND source_type=0;
INSERT INTO smart_scripts VALUES (22874, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 2500, 3000, 11, 40083, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Harpooner - In Combat - Cast Spear Throw');
INSERT INTO smart_scripts VALUES (22874, 0, 1, 0, 0, 0, 100, 0, 2000, 12000, 30000, 48000, 11, 40084, 0, 0, 0, 0, 0, 5, 70, 0, 0, 0, 0, 0, 0, 'Coilskar Harpooner - In Combat - Cast Harpooner''s Mark');
INSERT INTO smart_scripts VALUES (22874, 0, 2, 0, 0, 0, 100, 0, 6000, 12000, 20000, 20000, 11, 40082, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilskar Harpooner - In Combat - Cast Hooked Net');

-- SPELL Harpooner's Mark (40084)
DELETE FROM spell_script_names WHERE spell_id=40084;
INSERT INTO spell_script_names VALUES(40084, 'spell_black_template_harpooners_mark');

-- Dragon Turtle (22885)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=22885;
DELETE FROM smart_scripts WHERE entryorguid=22885 AND source_type=0;
INSERT INTO smart_scripts VALUES (22885, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 8500, 13000, 11, 40086, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragon Turtle - In Combat - Cast Water Spit');
INSERT INTO smart_scripts VALUES (22885, 0, 1, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 40087, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragon Turtle - In Combat - Cast Shell Shield');

-- Coilskar General (22873)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22873;
DELETE FROM smart_scripts WHERE entryorguid=22873 AND source_type=0;
INSERT INTO smart_scripts VALUES (22873, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 15000, 20000, 11, 40080, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar General - In Combat - Cast Booming Voice');
INSERT INTO smart_scripts VALUES (22873, 0, 1, 0, 15, 0, 100, 0, 100, 15000, 15000, 0, 11, 40081, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilskar General - Friendly CC - Cast Free Friend');

-- SPELL Free Friend (40081)
DELETE FROM spell_script_names WHERE spell_id=40081;
INSERT INTO spell_script_names VALUES(40081, 'spell_black_template_free_friend');

-- Aqueous Spawn (22883)
UPDATE creature_template SET dmg_multiplier=15, AIName='SmartAI', ScriptName='' WHERE entry=22883;
DELETE FROM smart_scripts WHERE entryorguid=22883 AND source_type=0;
INSERT INTO smart_scripts VALUES (22883, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 6500, 8000, 11, 40102, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Aqueous Spawn - In Combat - Cast Sludge Nova');
INSERT INTO smart_scripts VALUES (22883, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 40106, 0, 0, 0, 0, 0, 19, 22878, 20, 0, 0, 0, 0, 0, 'Aqueous Spawn - In Combat - Cast Merge');

-- SPELL Merge (40106)
-- SPELL Infusion (40105)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(40105, 40106);
INSERT INTO conditions VALUES(13, 1, 40106, 0, 0, 31, 0, 3, 22878, 0, 0, 0, 0, '', 'Target Aqueous Lord');
INSERT INTO conditions VALUES(13, 3, 40105, 0, 0, 31, 0, 3, 22878, 0, 0, 0, 0, '', 'Target Aqueous Lord');

-- Coilskar Wrangler (22877)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22877;
DELETE FROM smart_scripts WHERE entryorguid=22877 AND source_type=0;
INSERT INTO smart_scripts VALUES (22877, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 6000, 9000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Wrangler - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (22877, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 12000, 15000, 11, 40066, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilskar Wrangler - In Combat - Cast Lightning Prod');
INSERT INTO smart_scripts VALUES (22877, 0, 2, 0, 0, 0, 100, 0, 2000, 12000, 20000, 20000, 11, 40076, 0, 0, 0, 0, 0, 19, 22884, 30, 0, 0, 0, 0, 0, 'Coilskar Wrangler - In Combat - Cast Electric Spur');
INSERT INTO smart_scripts VALUES (22877, 0, 3, 0, 1, 0, 100, 0, 2000, 2000, 20000, 20000, 49, 0, 0, 0, 0, 0, 0, 19, 22884, 10, 0, 0, 0, 0, 0, 'Coilskar Wrangler - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (22877, 0, 4, 0, 37, 0, 100, 257, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Wrangler - AI Init - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (22877, 0, 5, 0, 32, 0, 100, 1, 0, 100000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Wrangler - On Damage Taken - Set HP Invincibility');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=22877;
INSERT INTO conditions VALUES(22, 6, 22877, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player');

-- SPELL Electric Spur (40076)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40076;
INSERT INTO conditions VALUES(13, 3, 40076, 0, 0, 31, 0, 3, 22884, 0, 0, 0, 0, '', 'Target Leviathan');
INSERT INTO conditions VALUES(13, 3, 40076, 0, 0, 1, 0, 40776, 0, 0, 1, 0, 0, '', 'Requires No Aura');

-- Leviathan (22884)
UPDATE creature_template SET faction=1834, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22884;
DELETE FROM smart_scripts WHERE entryorguid=22884 AND source_type=0;
INSERT INTO smart_scripts VALUES (22884, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 14000, 18000, 11, 40079, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Leviathan - In Combat - Cast Debilitating Spray');
INSERT INTO smart_scripts VALUES (22884, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 17000, 18000, 11, 40078, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Leviathan - In Combat - Cast Poison Spit');
INSERT INTO smart_scripts VALUES (22884, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 8000, 10000, 11, 40077, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Leviathan - In Combat - Cast Tail Sweep');
INSERT INTO smart_scripts VALUES (22884, 0, 3, 0, 37, 0, 100, 257, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leviathan - AI Init - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (22884, 0, 4, 0, 32, 0, 100, 1, 0, 100000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leviathan - On Damage Taken - Set HP Invincibility');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=22884;
INSERT INTO conditions VALUES(22, 5, 22884, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player');

-- Coilskar Sea-Caller (22875)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22875;
DELETE FROM smart_scripts WHERE entryorguid=22875 AND source_type=0;
INSERT INTO smart_scripts VALUES (22875, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 8000, 10000, 11, 40088, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Sea-Caller - In Combat - Cast Forked Lightning');
INSERT INTO smart_scripts VALUES (22875, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 17000, 28000, 11, 40090, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Coilskar Sea-Caller - In Combat - Cast Hurricane');
INSERT INTO smart_scripts VALUES (22875, 0, 2, 0, 0, 0, 100, 0, 11000, 12000, 11000, 18000, 11, 40091, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Coilskar Sea-Caller - In Combat - Cast Summon Geyser');

-- Coilskar Geyser (23080)
UPDATE creature_template SET unit_flags=4|131072, AIName='SmartAI', ScriptName='' WHERE entry=23080;
DELETE FROM smart_scripts WHERE entryorguid=23080 AND source_type=0;
INSERT INTO smart_scripts VALUES (23080, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 40089, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Geyser - In Combat - Cast Geyser');

-- Aqueous Lord (22878)
UPDATE creature_template SET dmg_multiplier=30, dmgschool=3, mechanic_immune_mask=545472511, AIName='SmartAI', ScriptName='' WHERE entry=22878;
DELETE FROM smart_scripts WHERE entryorguid=22878 AND source_type=0;
INSERT INTO smart_scripts VALUES (22878, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 15000, 17000, 11, 40100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast Crashing Wave');
INSERT INTO smart_scripts VALUES (22878, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 10000, 15000, 11, 40099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast Vile Slime');

-- Coilskar Soothsayer (22876)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22876;
DELETE FROM smart_scripts WHERE entryorguid=22876 AND source_type=0;
INSERT INTO smart_scripts VALUES (22876, 0, 0, 0, 14, 0, 100, 0, 40000, 40, 10000, 15000, 11, 40097, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Soothsayer - Friendly Missing Health - Cast Restoration');
INSERT INTO smart_scripts VALUES (22876, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 10000, 10000, 11, 40096, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilskar Soothsayer - In Combat - Cast Holy Nova');

-- Bonechewer Worker (22963)
DELETE FROM creature_text WHERE entry=22963;
INSERT INTO creature_text VALUES (22963, 0, 0, 'Gakarah ma!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Worker');
INSERT INTO creature_text VALUES (22963, 0, 1, 'Lok narash!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Worker');
INSERT INTO creature_text VALUES (22963, 0, 2, 'Lok''tar Illadari!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Worker');
INSERT INTO creature_text VALUES (22963, 0, 3, 'The blood is our power!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Worker');
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=22963;
DELETE FROM smart_scripts WHERE entryorguid=22963 AND source_type=0;
INSERT INTO smart_scripts VALUES (22963, 0, 0, 0, 0, 0, 100, 1, 5000, 15000, 0, 0, 11, 40844, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bonechewer Worker - In Combat - Cast Throw Pick');
INSERT INTO smart_scripts VALUES (22963, 0, 1, 0, 8, 0, 100, 0, 40851, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Worker - On Spell Hit - Talk');

-- Bonechewer Taskmaster (23028)
DELETE FROM creature_text WHERE entry=23028;
INSERT INTO creature_text VALUES (23028, 0, 0, 'I''ve seen female Gnomes hit harder than you!', 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Taskmaster');
INSERT INTO creature_text VALUES (23028, 0, 1, 'If you don''t start throwing some real punches, you''ll be cleaning the drake stalls for a year!', 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Taskmaster');
INSERT INTO creature_text VALUES (23028, 0, 2, 'Stop your slacking and fight like a true fel orc!', 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Taskmaster');
INSERT INTO creature_text VALUES (23028, 0, 3, 'You call that an offense? I''ve seen more offensive tallstriders!', 14, 0, 100, 0, 0, 0, 0, 'Bonechewer Taskmaster');
INSERT INTO creature_text VALUES (23028, 1, 0, 'Gakarah ma!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Taskmaster');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23028;
DELETE FROM smart_scripts WHERE entryorguid=23028 AND source_type=0;
INSERT INTO smart_scripts VALUES (23028, 0, 0, 1, 0, 0, 100, 0, 5000, 15000, 14000, 14000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - In Combat - Talk');
INSERT INTO smart_scripts VALUES (23028, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - In Combat - Create Timed Event');
INSERT INTO smart_scripts VALUES (23028, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - Between HP 0-30% - Talk');
INSERT INTO smart_scripts VALUES (23028, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 40845, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - Between HP 0-30% - Cast Fury');
INSERT INTO smart_scripts VALUES (23028, 0, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 40851, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - On Timed Event - Cast Disgruntled');

-- SPELL Disgruntled (40851)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40851;
INSERT INTO conditions VALUES(13, 7, 40851, 0, 0, 31, 0, 3, 22963, 0, 0, 0, 0, '', 'Target Bonechewer Worker');
DELETE FROM spell_script_names WHERE spell_id=40851;
INSERT INTO spell_script_names VALUES(40851, 'spell_gen_select_target_count_7_1');

-- Dragonmaw Wyrmcaller (22960)
DELETE FROM creature_text WHERE entry=22960;
INSERT INTO creature_text VALUES (22960, 0, 0, 'Scout the area and report anything you see!', 14, 0, 100, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22960;
DELETE FROM smart_scripts WHERE entryorguid=22960 AND source_type=0;
INSERT INTO smart_scripts VALUES (22960, 0, 0, 0, 13, 0, 100, 0, 10000, 20000, 0, 0, 11, 40895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - Victim Casting - Cast Jab');
INSERT INTO smart_scripts VALUES (22960, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 10000, 10000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (22960, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 20000, 20000, 11, 49026, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - In Combat - Cast Fixate');
INSERT INTO smart_scripts VALUES (22960, 0, 3, 5, 1, 0, 40, 0, 10000, 50000, 30000, 100000, 45, 1, 1, 0, 0, 0, 0, 19, 23030, 20, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - Out of Combat - Set Data');
INSERT INTO smart_scripts VALUES (22960, 0, 4, 5, 1, 0, 40, 0, 10000, 50000, 30000, 100000, 45, 1, 1, 0, 0, 0, 0, 19, 23330, 20, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - Out of Combat - Set Data');
INSERT INTO smart_scripts VALUES (22960, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wyrmcaller - Out of Combat - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=22960;
INSERT INTO conditions VALUES(22, 4, 22960, 0, 0, 29, 1, 23030, 18, 0, 0, 0, 0, '', 'Run action if npc nearby');
INSERT INTO conditions VALUES(22, 5, 22960, 0, 0, 29, 1, 23330, 18, 0, 0, 0, 0, '', 'Run action if npc nearby');

-- Dragonmaw Sky Stalker (23030)
UPDATE creature SET spawndist=50 WHERE id=23030 AND spawndist>0;
DELETE FROM creature_text WHERE entry=23030;
INSERT INTO creature_text VALUES (23030, 0, 0, 'Permission to buzz the tower!', 14, 0, 100, 0, 0, 0, 0, 'Dragonmaw Sky Stalker');
INSERT INTO creature_text VALUES (23030, 0, 1, 'Dragonriders mount up!', 14, 0, 100, 0, 0, 0, 0, 'Dragonmaw Sky Stalker');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23030;
DELETE FROM smart_scripts WHERE entryorguid=23030 AND source_type=0;
INSERT INTO smart_scripts VALUES (23030, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 53, 1, 23030, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - On Data Set - Start WP');
INSERT INTO smart_scripts VALUES (23030, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - On Data Set - Talk');
INSERT INTO smart_scripts VALUES (23030, 0, 2, 3, 58, 0, 100, 0, 1, 1, 0, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - On WP Ended - Set Home Position');
INSERT INTO smart_scripts VALUES (23030, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - On WP Ended - Enter Evade');
INSERT INTO smart_scripts VALUES (23030, 0, 4, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 40873, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (23030, 0, 5, 0, 0, 0, 100, 0, 4000, 9000, 8000, 13000, 11, 40872, 0, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 0, 'Dragonmaw Sky Stalker - In Combat - Cast Immolation Arrow');
DELETE FROM waypoints WHERE entry=23030;
INSERT INTO waypoints VALUES (23030, 1, 706.318, 875.647, 93.6386, 'Dragonmaw Sky Stalker'),(23030, 2, 728.807, 902.189, 97.3182, 'Dragonmaw Sky Stalker'),(23030, 3, 768.054, 931.133, 100.247, 'Dragonmaw Sky Stalker'),(23030, 4, 790.704, 920.723, 101.633, 'Dragonmaw Sky Stalker'),(23030, 5, 799.62, 898.133, 104.047, 'Dragonmaw Sky Stalker'),(23030, 6, 803.013, 860.275, 109.296, 'Dragonmaw Sky Stalker'),(23030, 7, 794.411, 793.525, 115.436, 'Dragonmaw Sky Stalker'),(23030, 8, 791.446, 758.66, 115.64, 'Dragonmaw Sky Stalker'),(23030, 9, 773.516, 708.709, 116.359, 'Dragonmaw Sky Stalker'),(23030, 10, 743.357, 690.984, 115.951, 'Dragonmaw Sky Stalker'),(23030, 11, 737.599, 690.243, 115.881, 'Dragonmaw Sky Stalker'),
(23030, 12, 675.973, 691.612, 115.606, 'Dragonmaw Sky Stalker'),(23030, 13, 634.253, 705.726, 114.521, 'Dragonmaw Sky Stalker'),(23030, 14, 611.134, 735.934, 112.619, 'Dragonmaw Sky Stalker'),(23030, 15, 601.262, 764.521, 111.237, 'Dragonmaw Sky Stalker'),(23030, 16, 599.923, 802.768, 108.17, 'Dragonmaw Sky Stalker'),(23030, 17, 609.462, 841.943, 104.524, 'Dragonmaw Sky Stalker'),(23030, 18, 609.768, 855.905, 103.636, 'Dragonmaw Sky Stalker'),(23030, 19, 612.719, 916.945, 99.8388, 'Dragonmaw Sky Stalker'),(23030, 20, 641.327, 935.371, 96.849, 'Dragonmaw Sky Stalker'),(23030, 21, 664.531, 935.643, 96.1041, 'Dragonmaw Sky Stalker'),(23030, 22, 693.135, 914.144, 95.5393, 'Dragonmaw Sky Stalker'),(23030, 23, 700.394, 878.148, 94.6207, 'Dragonmaw Sky Stalker');

-- Dragonmaw Wind Reaver (23330)
UPDATE creature SET spawndist=50 WHERE id=23330 AND spawndist>0;
DELETE FROM creature_text WHERE entry=23330;
INSERT INTO creature_text VALUES (23330, 0, 0, 'Permission to buzz the tower!', 14, 0, 100, 0, 0, 0, 0, 'Dragonmaw Wind Reaver');
INSERT INTO creature_text VALUES (23330, 0, 1, 'Dragonriders mount up!', 14, 0, 100, 0, 0, 0, 0, 'Dragonmaw Wind Reaver');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23330;
DELETE FROM smart_scripts WHERE entryorguid=23330 AND source_type=0;
INSERT INTO smart_scripts VALUES (23330, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 53, 1, 23330, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - On Data Set - Start WP');
INSERT INTO smart_scripts VALUES (23330, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - On Data Set - Talk');
INSERT INTO smart_scripts VALUES (23330, 0, 2, 3, 58, 0, 100, 0, 1, 1, 0, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - On WP Ended - Set Home Position');
INSERT INTO smart_scripts VALUES (23330, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - On WP Ended - Enter Evade');
INSERT INTO smart_scripts VALUES (23330, 0, 4, 0, 0, 0, 100, 0, 0, 1000, 2500, 2500, 11, 40877, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (23330, 0, 5, 0, 0, 0, 100, 0, 4000, 4000, 15000, 15000, 11, 40875, 0, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - In Combat - Cast Freeze');
INSERT INTO smart_scripts VALUES (23330, 0, 6, 0, 0, 0, 100, 0, 10000, 10000, 15000, 15000, 11, 40876, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Dragonmaw Wind Reaver - In Combat - Cast Doom Bolt');
DELETE FROM waypoints WHERE entry=23330;
INSERT INTO waypoints VALUES (23330, 1, 706.318, 875.647, 93.6386, 'Dragonmaw Wind Reaver'),(23330, 2, 728.807, 902.189, 97.3182, 'Dragonmaw Wind Reaver'),(23330, 3, 768.054, 931.133, 100.247, 'Dragonmaw Wind Reaver'),(23330, 4, 790.704, 920.723, 101.633, 'Dragonmaw Wind Reaver'),(23330, 5, 799.62, 898.133, 104.047, 'Dragonmaw Wind Reaver'),(23330, 6, 803.013, 860.275, 109.296, 'Dragonmaw Wind Reaver'),(23330, 7, 794.411, 793.525, 115.436, 'Dragonmaw Wind Reaver'),(23330, 8, 791.446, 758.66, 115.64, 'Dragonmaw Wind Reaver'),(23330, 9, 773.516, 708.709, 116.359, 'Dragonmaw Wind Reaver'),(23330, 10, 743.357, 690.984, 115.951, 'Dragonmaw Wind Reaver'),(23330, 11, 737.599, 690.243, 115.881, 'Dragonmaw Wind Reaver'),
(23330, 12, 675.973, 691.612, 115.606, 'Dragonmaw Wind Reaver'),(23330, 13, 634.253, 705.726, 114.521, 'Dragonmaw Wind Reaver'),(23330, 14, 611.134, 735.934, 112.619, 'Dragonmaw Wind Reaver'),(23330, 15, 601.262, 764.521, 111.237, 'Dragonmaw Wind Reaver'),(23330, 16, 599.923, 802.768, 108.17, 'Dragonmaw Wind Reaver'),(23330, 17, 609.462, 841.943, 104.524, 'Dragonmaw Wind Reaver'),(23330, 18, 609.768, 855.905, 103.636, 'Dragonmaw Wind Reaver'),(23330, 19, 612.719, 916.945, 99.8388, 'Dragonmaw Wind Reaver'),(23330, 20, 641.327, 935.371, 96.849, 'Dragonmaw Wind Reaver'),(23330, 21, 664.531, 935.643, 96.1041, 'Dragonmaw Wind Reaver'),(23330, 22, 693.135, 914.144, 95.5393, 'Dragonmaw Wind Reaver'),(23330, 23, 700.394, 878.148, 94.6207, 'Dragonmaw Wind Reaver');

-- Illidari Fearbringer (22954)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22954;
DELETE FROM smart_scripts WHERE entryorguid=22954 AND source_type=0;
INSERT INTO smart_scripts VALUES (22954, 0, 0, 0, 0, 0, 100, 0, 10000, 20000, 10000, 20000, 11, 40938, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Fearbringer - In Combat - Cast Illidari Flames');
INSERT INTO smart_scripts VALUES (22954, 0, 1, 0, 0, 0, 100, 0, 0, 8000, 15000, 25000, 11, 40936, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Fearbringer - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (22954, 0, 2, 0, 0, 0, 100, 0, 4000, 9000, 20000, 30000, 11, 40946, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Illidari Fearbringer - In Combat - Cast Rain of Chaos');

-- Illidari Centurion (23337)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23337;
DELETE FROM smart_scripts WHERE entryorguid=23337 AND source_type=0;
INSERT INTO smart_scripts VALUES (23337, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 7000, 10000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Centurion - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (23337, 0, 1, 0, 0, 0, 100, 0, 0, 8000, 15000, 25000, 11, 41168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Centurion - In Combat - Cast Sonic Strike');

-- Illidari Heartseeker (23339)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23339;
DELETE FROM smart_scripts WHERE entryorguid=23339 AND source_type=0;
INSERT INTO smart_scripts VALUES (23339, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 41169, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Heartseeker - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (23339, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 15000, 25000, 11, 41171, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Illidari Heartseeker - In Combat - Cast Skeleton Shot');
INSERT INTO smart_scripts VALUES (23339, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 25000, 35000, 11, 41173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Heartseeker - In Combat - Cast Rapid Shot');
INSERT INTO smart_scripts VALUES (23339, 0, 3, 0, 0, 0, 100, 0, 0, 10000, 30000, 30000, 11, 41170, 0, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 0, 'Illidari Heartseeker - In Combat - Cast Curse of the Bleakheart');

-- SPELL Curse of the Bleakheart (41170)
DELETE FROM spell_script_names WHERE spell_id=41170;
INSERT INTO spell_script_names VALUES(41170, 'spell_black_temple_curse_of_the_bleakheart');

-- SPELL Skeleton Shot (41171)
DELETE FROM spell_script_names WHERE spell_id=41171;
INSERT INTO spell_script_names VALUES(41171, 'spell_black_temple_skeleton_shot');

-- Fallen Ally (23389)
UPDATE creature_template SET faction=1813, dmg_multiplier=10, AIName='', ScriptName='' WHERE entry=23389;
DELETE FROM smart_scripts WHERE entryorguid=23389 AND source_type=0;

-- Illidari Defiler (22853)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22853;
DELETE FROM smart_scripts WHERE entryorguid=22853 AND source_type=0;
INSERT INTO smart_scripts VALUES (22853, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 20000, 30000, 11, 39674, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Illidari Defiler - In Combat - Cast Banish');
INSERT INTO smart_scripts VALUES (22853, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 15000, 25000, 11, 39672, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Defiler - In Combat - Cast Curse of Agony');
INSERT INTO smart_scripts VALUES (22853, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 12000, 20000, 11, 39670, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Illidari Defiler - In Combat - Cast Fel Immolation');
INSERT INTO smart_scripts VALUES (22853, 0, 3, 0, 0, 0, 100, 0, 0, 10000, 15000, 25000, 11, 39671, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Illidari Defiler - In Combat - Cast Rain of Chaos');

-- SPELL Curse of Agony (39672)
DELETE FROM spell_script_names WHERE spell_id=39672;
INSERT INTO spell_script_names VALUES(39672, 'spell_gen_select_target_count_15_1');

-- Illidari Boneslicer (22869)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22869;
DELETE FROM smart_scripts WHERE entryorguid=22869 AND source_type=0;
INSERT INTO smart_scripts VALUES (22869, 0, 0, 0, 0, 0, 100, 0, 0, 4000, 2000, 10000, 11, 39665, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Boneslicer - In Combat - Cast Wound Poison');
INSERT INTO smart_scripts VALUES (22869, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 15000, 25000, 11, 24698, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Boneslicer - In Combat - Cast Gouge');
INSERT INTO smart_scripts VALUES (22869, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 12000, 20000, 11, 41176, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Illidari Boneslicer - In Combat - Cast Shadowstep');
INSERT INTO smart_scripts VALUES (22869, 0, 3, 0, 0, 0, 100, 0, 12000, 20000, 25000, 30000, 11, 39666, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Boneslicer - In Combat - Cast Cloak of Shadows');

-- Illidari Nightlord (22855)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22855;
DELETE FROM smart_scripts WHERE entryorguid=22855 AND source_type=0;
INSERT INTO smart_scripts VALUES (22855, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 20000, 40000, 11, 39645, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Nightlord - In Combat - Cast Shadow Inferno');
INSERT INTO smart_scripts VALUES (22855, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 25000, 35000, 11, 39647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Nightlord - In Combat - Cast Curse of Mending');
INSERT INTO smart_scripts VALUES (22855, 0, 2, 0, 0, 0, 100, 0, 8000, 15000, 25000, 30000, 11, 41150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Nightlord - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (22855, 0, 3, 0, 0, 0, 100, 0, 12000, 20000, 30000, 30000, 11, 41159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Nightlord - In Combat - Cast Summon Shadowfiends');

-- SPELL Shadow Inferno (39645)
DELETE FROM spell_script_names WHERE spell_id=39645;
INSERT INTO spell_script_names VALUES(39645, 'spell_black_temple_shadow_inferno');

-- Greater Shadowfiend (22929)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22929);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22929);
DELETE FROM creature WHERE id=22929;
UPDATE creature_template SET dmg_multiplier=10, AIName='', ScriptName='' WHERE entry=22929;
DELETE FROM smart_scripts WHERE entryorguid=22929 AND source_type=0;

-- Ashtongue Stormcaller (22846)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22846;
DELETE FROM smart_scripts WHERE entryorguid=22846 AND source_type=0;
INSERT INTO smart_scripts VALUES (22846, 0, 0, 0, 0, 0, 100, 0, 0, 4000, 6000, 12000, 11, 41183, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Stormcaller - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (22846, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 41184, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Stormcaller - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (22846, 0, 2, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 11, 41151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Stormcaller - In Combat - Cast Lightning Shield');
INSERT INTO smart_scripts VALUES (22846, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 39534, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Stormcaller - On Reset - Cast Summon Storm Fury');

-- Storm Fury (22848)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22848);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22848);
DELETE FROM creature WHERE id=22848;
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=22848;
DELETE FROM smart_scripts WHERE entryorguid=22848 AND source_type=0;
INSERT INTO smart_scripts VALUES (22848, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 30000, 30000, 11, 39582, 0, 0, 0, 0, 0, 5, 50, 0, 0, 0, 0, 0, 0, 'Storm Fury - In Combat - Cast Storm Blink');
INSERT INTO smart_scripts VALUES (22848, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 30000, 30000, 11, 39581, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Storm Fury - In Combat - Cast Storm Blink');
INSERT INTO smart_scripts VALUES (22848, 0, 2, 0, 0, 0, 100, 0, 17000, 17000, 30000, 30000, 28, 39580, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Storm Fury - In Combat - Remove Aura Lightning Cloud');

-- Ashtongue Primalist (22847)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22847;
DELETE FROM smart_scripts WHERE entryorguid=22847 AND source_type=0;
INSERT INTO smart_scripts VALUES (22847, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 12000, 15000, 11, 41187, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Primalist - In Combat - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES (22847, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 41188, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Primalist - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (22847, 0, 2, 0, 9, 0, 100, 0, 0, 5, 15000, 15000, 11, 39584, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Primalist - Withing Range 0-5yd - Cast Sweeping Wing Clip');
INSERT INTO smart_scripts VALUES (22847, 0, 3, 0, 0, 0, 100, 0, 0, 10000, 15000, 20000, 11, 41186, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ashtongue Primalist - In Combat - Cast Wyvern Sting');
INSERT INTO smart_scripts VALUES (22847, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 39535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Primalist - On Reset - Cast Summon Feral Spirit');

-- SPELL Wyvern Sting (41186)
DELETE FROM spell_script_names WHERE spell_id=41186;
INSERT INTO spell_script_names VALUES(41186, 'spell_black_temple_wyvern_sting');

-- SPELL Rapid Shot (41172)
DELETE FROM spell_script_names WHERE spell_id=41172;
INSERT INTO spell_script_names VALUES(41172, 'spell_gen_select_target_count_24_1');

-- Ashtongue Feral Spirit (22849)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22849);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22849);
DELETE FROM creature WHERE id=22849;
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=22849;
DELETE FROM smart_scripts WHERE entryorguid=22849 AND source_type=0;
INSERT INTO smart_scripts VALUES (22849, 0, 0, 0, 0, 0, 100, 0, 8000, 8000, 30000, 30000, 11, 39575, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Feral Spirit - In Combat - Cast Charge Rage');
INSERT INTO smart_scripts VALUES (22849, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 30000, 30000, 11, 39578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Feral Spirit - In Combat - Cast Spirit Bond');

-- SPELL Charge Rage (39575)
DELETE FROM spell_script_names WHERE spell_id=39575;
INSERT INTO spell_script_names VALUES(39575, 'spell_black_temple_charge_rage');

-- Ashtongue Mystic (22845)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22845;
DELETE FROM smart_scripts WHERE entryorguid=22845 AND source_type=0;
INSERT INTO smart_scripts VALUES (22845, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 39589, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Cyclone Totem');
INSERT INTO smart_scripts VALUES (22845, 0, 1, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 39588, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Searing Totem');
INSERT INTO smart_scripts VALUES (22845, 0, 2, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 39586, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Summon Windfury Totem');
INSERT INTO smart_scripts VALUES (22845, 0, 3, 0, 0, 0, 100, 0, 4000, 4000, 24000, 24000, 11, 41115, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (22845, 0, 4, 0, 0, 0, 100, 0, 16000, 16000, 24000, 24000, 11, 41116, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (22845, 0, 5, 0, 0, 0, 100, 0, 10000, 15000, 15000, 30000, 11, 41114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Chain Heal');
INSERT INTO smart_scripts VALUES (22845, 0, 6, 0, 0, 0, 100, 0, 0, 25000, 30000, 50000, 11, 41185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Mystic - In Combat - Cast Bloodlust');

-- Ashtongue Searing Totem (22896)
UPDATE creature_template SET faction=1813, spell1=39593, AIName='', ScriptName='' WHERE entry=22896;
DELETE FROM smart_scripts WHERE entryorguid=22896 AND source_type=0;

-- Cyclone Totem (22894)
UPDATE creature_template SET faction=1813, spell1=39594, AIName='', ScriptName='' WHERE entry=22894;
DELETE FROM smart_scripts WHERE entryorguid=22894 AND source_type=0;

-- Ashtongue Battlelord (22844)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22844;
DELETE FROM smart_scripts WHERE entryorguid=22844 AND source_type=0;
INSERT INTO smart_scripts VALUES (22844, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 8000, 12000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (22844, 0, 1, 0, 9, 0, 100, 0, 0, 10, 20000, 20000, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Withing Range 0-10yd - Cast Concussion Blow');
INSERT INTO smart_scripts VALUES (22844, 0, 2, 0, 9, 0, 100, 0, 10, 40, 20000, 20000, 11, 41182, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Withing Range 10-40yd - Cast Concussive Throw');
INSERT INTO smart_scripts VALUES (22844, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Between HP 0-20% - Cast Frenzy');

-- Shadowmoon Houndmaster (23018)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=23018);
REPLACE INTO creature_template_addon VALUES (23018, 0, 21241, 0, 4097, 0, '');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23018;
DELETE FROM smart_scripts WHERE entryorguid=23018 AND source_type=0;
INSERT INTO smart_scripts VALUES (23018, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 39906, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Houndmaster - On Aggro - Cast Summon Riding Warhound');
INSERT INTO smart_scripts VALUES (23018, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 41093, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Houndmaster - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (23018, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 20000, 25000, 11, 41084, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Shadowmoon Houndmaster - In Combat - Cast Silencing Shot');
INSERT INTO smart_scripts VALUES (23018, 0, 3, 0, 0, 0, 100, 0, 9000, 12000, 20000, 25000, 11, 41091, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Shadowmoon Houndmaster - In Combat - Cast Volley');
INSERT INTO smart_scripts VALUES (23018, 0, 4, 0, 0, 0, 100, 0, 1000, 2000, 20000, 20000, 11, 41085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Houndmaster - In Combat - Cast Freezing Trap');
INSERT INTO smart_scripts VALUES (23018, 0, 5, 0, 9, 0, 100, 0, 0, 5, 10000, 15000, 11, 32908, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Withing Range 0-5yd - Cast Wing Clip');

-- Shadowmoon Riding Hound (23083)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=23083;
DELETE FROM smart_scripts WHERE entryorguid=23083 AND source_type=0;
INSERT INTO smart_scripts VALUES (23083, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 8000, 12000, 11, 41092, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Riding Hound - In Combat - Cast Carnivorous Bite');
INSERT INTO smart_scripts VALUES (23083, 0, 1, 0, 0, 0, 100, 0, 0, 0, 20000, 25000, 11, 25821, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Shadowmoon Riding Hound - In Combat - Cast Charge');
INSERT INTO smart_scripts VALUES (23083, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Riding Hound - Between HP 0-20% - Cast Enrage');
INSERT INTO smart_scripts VALUES (23083, 0, 3, 0, 7, 0, 100, 1, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Riding Hound - On Evade - Despawn');

-- Shadowmoon Champion (22880)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22880;
DELETE FROM smart_scripts WHERE entryorguid=22880 AND source_type=0;
INSERT INTO smart_scripts VALUES (22880, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 8000, 12000, 11, 41063, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Champion - In Combat - Cast Chaotic Light');
INSERT INTO smart_scripts VALUES (22880, 0, 1, 0, 0, 0, 100, 0, 14000, 18000, 30000, 35000, 11, 41053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Champion - In Combat - Cast Whirling Blade');

-- Whirling Blade (23369)
UPDATE creature_template SET faction=1813, unit_flags=33554432, dmg_multiplier=10, flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=23369; 
DELETE FROM smart_scripts WHERE entryorguid=23369 AND source_type=0;
INSERT INTO smart_scripts VALUES (23369, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirling Blade - On Reset - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (23369, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 8000, 8000, 11, 41058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Whirling Blade - In Combat - Cast Whirlwind');

-- Shadowmoon Reaver (22879)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22879;
DELETE FROM smart_scripts WHERE entryorguid=22879 AND source_type=0;
INSERT INTO smart_scripts VALUES (22879, 0, 0, 0, 0, 0, 100, 0, 2000, 10000, 30000, 40000, 11, 41034, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Reaver - In Combat - Cast Spell Absorption');
INSERT INTO smart_scripts VALUES (22879, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 10000, 15000, 11, 41047, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Reaver - In Combat - Cast Shadow Resonance');

-- SPELL Spell Absorption (41034)
REPLACE INTO spell_proc_event VALUES (41034, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id=41034;
INSERT INTO spell_script_names VALUES(41034, 'spell_black_temple_spell_absorption');

-- Shadowmoon War Hound (22946)
UPDATE creature_template SET dmg_multiplier=10, AIName='', ScriptName='' WHERE entry=22946;
DELETE FROM smart_scripts WHERE entryorguid=22946 AND source_type=0;

-- Shadowmoon Grunt (23147)
UPDATE creature_template SET dmg_multiplier=10, AIName='', ScriptName='' WHERE entry=23147;
DELETE FROM smart_scripts WHERE entryorguid=23147 AND source_type=0;

-- Shadowmoon Blood Mage (22945)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22945;
DELETE FROM smart_scripts WHERE entryorguid=22945 AND source_type=0;
INSERT INTO smart_scripts VALUES (22945, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 3000, 3000, 11, 41072, 64, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Shadowmoon Blood Mage - In Combat - Cast Bloodbolt');
INSERT INTO smart_scripts VALUES (22945, 0, 1, 0, 0, 0, 100, 0, 0, 6000, 10000, 15000, 11, 41068, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Blood Mage - In Combat - Cast Blood Siphon');
INSERT INTO smart_scripts VALUES (22945, 0, 2, 0, 1, 0, 100, 0, 1000, 1000, 10000, 10000, 11, 40094, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Blood Mage - Out of Combat - Cast Summon Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=22945;
INSERT INTO conditions VALUES(22, 3, 22945, 0, 0, 29, 1, 22953, 15, 0, 0, 0, 0, '', 'Requires Wrathbone Flyer in 10yd');

-- SPELL Bloodbolt (41072)
DELETE FROM spell_script_names WHERE spell_id=41072;
INSERT INTO spell_script_names VALUES(41072, 'spell_black_temple_bloodbolt');

-- Shadowmoon Deathshaper (22882)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22882;
DELETE FROM smart_scripts WHERE entryorguid=22882 AND source_type=0;
INSERT INTO smart_scripts VALUES (22882, 0, 0, 0, 1, 0, 100, 0, 500, 1000, 600000, 600000, 11, 13787, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Deathshaper - Out of Combat - Cast Demon Armor');
INSERT INTO smart_scripts VALUES (22882, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 41069, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Deathshaper - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (22882, 0, 2, 0, 0, 0, 100, 0, 0, 6000, 12000, 20000, 11, 41070, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Shadowmoon Deathshaper - In Combat - Cast Death Coil');
INSERT INTO smart_scripts VALUES (22882, 0, 3, 0, 1, 0, 100, 0, 1000, 1000, 10000, 10000, 11, 40094, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Deathshaper - Out of Combat - Cast Summon Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=22882;
INSERT INTO conditions VALUES(22, 4, 22882, 0, 0, 29, 1, 22953, 15, 0, 0, 0, 0, '', 'Requires Wrathbone Flyer in 10yd');

-- SPELL Summon Channel (40094)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40094;
INSERT INTO conditions VALUES(13, 1, 40094, 0, 0, 31, 0, 3, 22953, 0, 0, 0, 0, '', 'Target Wrathbone Flayer');

-- Wrathbone Flayer (22953)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22953;
DELETE FROM smart_scripts WHERE entryorguid=22953 AND source_type=0;
INSERT INTO smart_scripts VALUES (22953, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 6000, 9000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Flayer - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (22953, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 10000, 15000, 11, 39544, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wrathbone Flayer - In Combat - Cast Ignored');

-- Shadowmoon Weapon Master (23049)
DELETE FROM creature_equip_template WHERE entry=23049;
INSERT INTO creature_equip_template VALUES (23049, 1, 32614, 0, 0, 18019);
INSERT INTO creature_equip_template VALUES (23049, 2, 32887, 32885, 0, 18019);
DELETE FROM creature_text WHERE entry=23049;
INSERT INTO creature_text VALUES (23049, 0, 0, 'Battle Stance! Prepare for an offensive rush!', 14, 0, 100, 0, 0, 0, 0, 'Shadowmoon Weapon Master');
INSERT INTO creature_text VALUES (23049, 1, 0, 'Berserker Stance! Attack them recklessly!', 14, 0, 100, 0, 0, 0, 0, 'Shadowmoon Weapon Master');
INSERT INTO creature_text VALUES (23049, 2, 0, 'Defensive Stance! Shield yourself against their blows and strike back!', 14, 0, 100, 0, 0, 0, 0, 'Shadowmoon Weapon Master');
UPDATE creature_template SET dmg_multiplier=35, AIName='SmartAI', ScriptName='' WHERE entry=23049;
DELETE FROM smart_scripts WHERE entryorguid=23049 AND source_type=0;
INSERT INTO smart_scripts VALUES (23049, 0, 0, 1, 0, 0, 100, 0, 0, 0, 60000, 60000, 11, 41099, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (23049, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Battle Aura');
INSERT INTO smart_scripts VALUES (23049, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 139, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Load Equipment');
INSERT INTO smart_scripts VALUES (23049, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Talk');
INSERT INTO smart_scripts VALUES (23049, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Set Event Phase');
INSERT INTO smart_scripts VALUES (23049, 0, 5, 6, 0, 0, 100, 0, 20000, 20000, 60000, 60000, 11, 41101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (23049, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Defensive Aura');
INSERT INTO smart_scripts VALUES (23049, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 139, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Load Equipment');
INSERT INTO smart_scripts VALUES (23049, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Talk');
INSERT INTO smart_scripts VALUES (23049, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Set Event Phase');
INSERT INTO smart_scripts VALUES (23049, 0, 10, 11, 0, 0, 100, 0, 40000, 40000, 60000, 60000, 11, 41100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Berserker Stance');
INSERT INTO smart_scripts VALUES (23049, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Berserker Aura');
INSERT INTO smart_scripts VALUES (23049, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 139, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Load Equipment');
INSERT INTO smart_scripts VALUES (23049, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Talk');
INSERT INTO smart_scripts VALUES (23049, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Set Event Phase');
INSERT INTO smart_scripts VALUES (23049, 0, 15, 0, 0, 0, 100, 0, 4000, 8000, 14000, 20000, 11, 18813, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (23049, 0, 16, 0, 0, 1, 100, 0, 2000, 4000, 10000, 20000, 11, 41103, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Mutilate');
INSERT INTO smart_scripts VALUES (23049, 0, 17, 0, 0, 2, 100, 0, 2000, 4000, 10000, 20000, 11, 41104, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Shield Wall');
INSERT INTO smart_scripts VALUES (23049, 0, 18, 0, 0, 4, 100, 0, 2000, 4000, 10000, 20000, 11, 41097, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (23049, 0, 19, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - On Aggro - Call For Help');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41099, -41099, 41100, -41100, 41101, -41101);
INSERT INTO spell_linked_spell VALUES (41101, -41099, 2, 'Defensive Stance - Remove Battle Stance');
INSERT INTO spell_linked_spell VALUES (41101, -41106, 2, 'Defensive Stance - Remove Battle Stance');
INSERT INTO spell_linked_spell VALUES (41100, -41101, 2, 'Berserker Stance - Remove Defensive Stance');
INSERT INTO spell_linked_spell VALUES (41100, -41105, 2, 'Berserker Stance - Remove Defensive Stance');
INSERT INTO spell_linked_spell VALUES (41099, -41100, 2, 'Battle Stance - Remove Berserker Stance');
INSERT INTO spell_linked_spell VALUES (41099, -41107, 2, 'Battle Stance - Remove Berserker Stance');

-- Shadowmoon Soldier (23047)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=23047;
DELETE FROM smart_scripts WHERE entryorguid=23047 AND source_type=0;
INSERT INTO smart_scripts VALUES (23047, 0, 0, 0, 0, 0, 100, 0, 0, 5000, 5000, 10000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Soldier - In Combat - Cast Strike');

-- Hand of Gorefiend (23172)
UPDATE creature_template SET dmg_multiplier=20, flags_extra=256, AIName='SmartAI', ScriptName='' WHERE entry=23172;
DELETE FROM smart_scripts WHERE entryorguid=23172 AND source_type=0;
INSERT INTO smart_scripts VALUES (23172, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 38166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Gorefiend - Between Health 0-30% - Cast Enrage');

-- Mutant War Hound (23232)
REPLACE INTO creature_template_addon VALUES (23232, 0, 0, 0, 4097, 0, '41290');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23232;
DELETE FROM smart_scripts WHERE entryorguid=23232 AND source_type=0;
INSERT INTO smart_scripts VALUES (23232, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 15000, 25000, 11, 41193, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mutant War Hound - In Combat - Cast Cloud of Disease');

-- Bonechewer Behemoth (23196)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23196;
DELETE FROM smart_scripts WHERE entryorguid=23196 AND source_type=0;
INSERT INTO smart_scripts VALUES (23196, 0, 0, 0, 9, 0, 100, 0, 5, 30, 8000, 8000, 11, 41272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - Withing Range 5-30yd - Cast Behemoth Charge');
INSERT INTO smart_scripts VALUES (23196, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 19000, 29000, 11, 41274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - In Combat - Cast Fel Stomp');
INSERT INTO smart_scripts VALUES (23196, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 19000, 29000, 11, 41277, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - In Combat - Cast Fiery Comet');
INSERT INTO smart_scripts VALUES (23196, 0, 3, 0, 0, 0, 100, 0, 17000, 20000, 15000, 30000, 11, 41276, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - In Combat - Cast Meteor');
INSERT INTO smart_scripts VALUES (23196, 0, 4, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - Between Health 0-30% - Cast Frenzy');

-- Bonechewer Blade Fury (23235)
DELETE FROM creature_text WHERE entry=23235;
INSERT INTO creature_text VALUES (23235, 0, 0, 'How long must we wait?', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blade Fury');
INSERT INTO creature_text VALUES (23235, 0, 1, 'I must feed!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blade Fury');
INSERT INTO creature_text VALUES (23235, 0, 2, 'One day, we will rule this dark temple.', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blade Fury');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23235;
DELETE FROM smart_scripts WHERE entryorguid=23235 AND source_type=0;
INSERT INTO smart_scripts VALUES (23235, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 19000, 29000, 11, 41194, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blade Fury - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (23235, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blade Fury - On Aggro - Talk');

-- Bonechewer Blood Prophet (23237)
DELETE FROM creature_text WHERE entry=23237;
INSERT INTO creature_text VALUES (23237, 0, 0, 'How long must we wait?', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blood Prophet');
INSERT INTO creature_text VALUES (23237, 0, 1, 'I must feed!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blood Prophet');
INSERT INTO creature_text VALUES (23237, 0, 2, 'One day, we will rule this dark temple.', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Blood Prophet');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23237;
DELETE FROM smart_scripts WHERE entryorguid=23237 AND source_type=0;
INSERT INTO smart_scripts VALUES (23237, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2000, 3000, 11, 41229, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - In Combat - Cast Bloodbolt');
INSERT INTO smart_scripts VALUES (23237, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 19000, 29000, 11, 41238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - In Combat - Cast Blood Drain');
INSERT INTO smart_scripts VALUES (23237, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 19000, 29000, 11, 41230, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - In Combat - Cast Prophecy of Blood');
INSERT INTO smart_scripts VALUES (23237, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - Between Health 0-20% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (23237, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - On Aggro - Talk');

-- Bonechewer Shield Disciple (23236)
DELETE FROM creature_text WHERE entry=23236;
INSERT INTO creature_text VALUES (23236, 0, 0, 'How long must we wait?', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Shield Disciple');
INSERT INTO creature_text VALUES (23236, 0, 1, 'I must feed!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Shield Disciple');
INSERT INTO creature_text VALUES (23236, 0, 2, 'One day, we will rule this dark temple.', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Shield Disciple');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23236;
DELETE FROM smart_scripts WHERE entryorguid=23236 AND source_type=0;
INSERT INTO smart_scripts VALUES (23236, 0, 0, 0, 9, 0, 100, 0, 5, 45, 10000, 10000, 11, 41214, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Shield Disciple - Within Range 5-45yd - Cast Throw Shield');
INSERT INTO smart_scripts VALUES (23236, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 30000, 40000, 11, 41196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Shield Disciple - In Combat - Cast Shield Wall');
INSERT INTO smart_scripts VALUES (23236, 0, 2, 0, 13, 0, 100, 0, 12000, 15000, 0, 0, 11, 41197, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Shield Disciple - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (23236, 0, 3, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Shield Disciple - On Aggro - Talk');

-- Angered Soul Fragment (23398)
UPDATE creature SET spawntimesecs=10 WHERE id=23398;
UPDATE creature_template SET dmg_multiplier=5, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=23398; 
DELETE FROM smart_scripts WHERE entryorguid=23398 AND source_type=0;
INSERT INTO smart_scripts VALUES (23398, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 15000, 25000, 11, 41986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Angered Soul Fragment - In Combat - Cast Anger');

-- Hungering Soul Fragment (23401)
UPDATE creature SET spawntimesecs=10 WHERE id=23401;
REPLACE INTO creature_template_addon VALUES (23401, 0, 0, 0, 4097, 0, '41248');
UPDATE creature_template SET dmg_multiplier=20, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=23401;
DELETE FROM smart_scripts WHERE entryorguid=23401 AND source_type=0;

-- SPELL Consuming Strikes (41248)
DELETE FROM spell_script_names WHERE spell_id=41248;
INSERT INTO spell_script_names VALUES(41248, 'spell_black_temple_consuming_strikes');

-- Suffering Soul Fragment (23399)
UPDATE creature SET spawntimesecs=10 WHERE id=23399;
UPDATE creature_template SET dmg_multiplier=20, flags_extra=64, AIName='SmartAI', ScriptName='' WHERE entry=23399;
DELETE FROM smart_scripts WHERE entryorguid=23399 AND source_type=0;
INSERT INTO smart_scripts VALUES (23399, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 6000, 9000, 11, 41245, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Suffering Soul Fragment - In Combat - Cast Soul Blast');

-- Bonechewer Spectator (23223)
DELETE FROM creature_text WHERE entry=23223;
INSERT INTO creature_text VALUES (23223, 0, 0, 'Kill him!', 12, 0, 100, 0, 0, 0, 0, 'Bonechewer Spectator');
UPDATE creature_template SET faction=14, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23223;
DELETE FROM smart_scripts WHERE entryorguid=23223 AND source_type=0;
INSERT INTO smart_scripts VALUES (23223, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 36140, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (23223, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 31, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - On Aggro - Event Phase Random Range');
INSERT INTO smart_scripts VALUES (23223, 0, 2, 0, 0, 1, 100, 0, 0, 3000, 8000, 10000, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (23223, 0, 3, 0, 0, 2, 100, 0, 0, 3000, 8000, 10000, 11, 25646, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - In Combat - Cast Mortal Wound');
INSERT INTO smart_scripts VALUES (23223, 0, 4, 0, 0, 4, 100, 0, 0, 3000, 8000, 10000, 11, 13444, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - In Combat - Cast Sunder Armor');
INSERT INTO smart_scripts VALUES (23223, 0, 5, 0, 0, 8, 100, 0, 0, 3000, 8000, 10000, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (23223, 0, 6, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Spectator - Between Health 0-20% - Cast Frenzy');

-- Bonechewer Brawler (23222)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23222;
DELETE FROM smart_scripts WHERE entryorguid=23222 AND source_type=0;
INSERT INTO smart_scripts VALUES (23222, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 12000, 19000, 11, 41254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Cast Enrage');
INSERT INTO smart_scripts VALUES (23222, 0, 1, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - Between Health 0-20% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (23222, 0, 2, 3, 1, 0, 100, 1, 10000, 10000, 0, 0, 2, 1834, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - Out of Combat - Set Faction');
INSERT INTO smart_scripts VALUES (23222, 0, 3, 4, 61, 0, 100, 1, 10000, 10000, 0, 0, 11, 43370, 0, 0, 0, 0, 0, 19, 23239, 10, 0, 0, 0, 0, 0, 'Bonechewer Brawler - Out of Combat - Cast Taunt');
INSERT INTO smart_scripts VALUES (23222, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - Out of Combat - Set Event Phase');
INSERT INTO smart_scripts VALUES (23222, 0, 5, 0, 0, 1, 100, 0, 1000, 10000, 10000, 20000, 5, 4, 0, 0, 0, 0, 0, 11, 23223, 20, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Emote Target');
INSERT INTO smart_scripts VALUES (23222, 0, 6, 0, 0, 1, 100, 0, 1000, 20000, 20000, 30000, 1, 0, 0, 0, 0, 0, 0, 19, 23223, 20, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Talk Target');
INSERT INTO smart_scripts VALUES (23222, 0, 7, 8, 0, 1, 100, 0, 40000, 40000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Evade');
INSERT INTO smart_scripts VALUES (23222, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 19, 23239, 10, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Evade');
INSERT INTO smart_scripts VALUES (23222, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 1813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - In Combat - Evade');
INSERT INTO smart_scripts VALUES (23222, 0, 10, 0, 32, 0, 100, 1, 0, 100000, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Brawler - On Damage Taken - Set Event Phase');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=23222;
INSERT INTO conditions VALUES(22, 11, 23222, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player');

-- Bonechewer Combatant (23239)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23239;
DELETE FROM smart_scripts WHERE entryorguid=23239 AND source_type=0;
INSERT INTO smart_scripts VALUES (23239, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 41251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Combatant - In Combat - Cast Combat Rage');
INSERT INTO smart_scripts VALUES (23239, 0, 1, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Combatant - Between Health 0-20% - Cast Frenzy');

-- Temple Concubine (22939)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22939;
DELETE FROM smart_scripts WHERE entryorguid=22939 AND source_type=0;
INSERT INTO smart_scripts VALUES (22939, 0, 0, 0, 0, 0, 100, 0, 6000, 15000, 18000, 25000, 11, 41338, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Temple Concubine - In Combat - Cast Love Tap');
INSERT INTO smart_scripts VALUES (22939, 0, 1, 0, 0, 0, 100, 0, 0, 10000, 15000, 20000, 11, 41334, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Temple Concubine - In Combat - Cast Polymorph');

-- Charming Courtesan (22955)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22955;
DELETE FROM smart_scripts WHERE entryorguid=22955 AND source_type=0;
INSERT INTO smart_scripts VALUES (22955, 0, 0, 0, 0, 0, 30, 0, 6000, 15000, 50000, 60000, 11, 13810, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charming Courtesan - In Combat - Cast Frost Trap Aura');
INSERT INTO smart_scripts VALUES (22955, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 35000, 40000, 11, 41345, 0, 0, 0, 0, 0, 6, 50, 0, 0, 0, 0, 0, 0, 'Charming Courtesan - In Combat - Cast Infatuation');
INSERT INTO smart_scripts VALUES (22955, 0, 2, 0, 0, 0, 100, 0, 0, 10000, 15000, 20000, 11, 41346, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Charming Courtesan - In Combat - Cast Poisonous Throw');

-- Sister of Pain (22956)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22956;
DELETE FROM smart_scripts WHERE entryorguid=22956 AND source_type=0;
INSERT INTO smart_scripts VALUES (22956, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 15000, 11, 41353, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pain - In Combat - Cast Lash of Pain');
INSERT INTO smart_scripts VALUES (22956, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 10000, 15000, 11, 41355, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sister of Pain - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (22956, 0, 2, 0, 0, 0, 100, 0, 0, 20000, 30000, 40000, 11, 41371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pain - In Combat - Cast Shell of Pain');
INSERT INTO smart_scripts VALUES (22956, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 41363, 0, 0, 0, 0, 0, 19, 22964, 30, 0, 0, 0, 0, 0, 'Sister of Pain - In Combat - Cast Shared Bonds');
INSERT INTO smart_scripts VALUES (22956, 0, 4, 0, 2, 0, 100, 1, 0, 20, 0, 0, 11, 41369, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pain - Between Health 0-20% - Cast Painful Rage');

-- Sister of Pleasure (22964)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22964;
DELETE FROM smart_scripts WHERE entryorguid=22964 AND source_type=0;
INSERT INTO smart_scripts VALUES (22964, 0, 0, 0, 14, 0, 100, 0, 40000, 40, 7000, 10000, 11, 41378, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pleasure - Friendly Missing Health - Cast Greater Heal');
INSERT INTO smart_scripts VALUES (22964, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 10000, 15000, 11, 41380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pleasure - In Combat - Cast Holy Nova');
INSERT INTO smart_scripts VALUES (22964, 0, 2, 0, 0, 0, 100, 0, 0, 20000, 30000, 40000, 11, 41381, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sister of Pleasure - In Combat - Cast Shell of Life');
INSERT INTO smart_scripts VALUES (22964, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 41363, 0, 0, 0, 0, 0, 19, 22956, 30, 0, 0, 0, 0, 0, 'Sister of Pleasure - In Combat - Cast Shared Bonds');

-- SPELL Shell of Life (41381)
REPLACE INTO spell_proc_event VALUES (41381, 0, 0, 0, 0, 0, 0, 256, 0, 0, 0);

-- Enslaved Servant (22965)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22965;
DELETE FROM smart_scripts WHERE entryorguid=22965 AND source_type=0;
INSERT INTO smart_scripts VALUES (22965, 0, 0, 0, 0, 0, 100, 0, 6000, 15000, 15000, 20000, 11, 41388, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Servant - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (22965, 0, 1, 0, 0, 0, 100, 0, 0, 15000, 15000, 30000, 11, 41389, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Servant - In Combat - Cast Kidney Shot');

-- Spellbound Attendant (22959)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22959;
DELETE FROM smart_scripts WHERE entryorguid=22959 AND source_type=0;
INSERT INTO smart_scripts VALUES (22959, 0, 0, 0, 13, 0, 100, 0, 6000, 10000, 0, 0, 11, 41395, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spellbound Attendant - Victim Casting - Cast Kick');
INSERT INTO smart_scripts VALUES (22959, 0, 1, 0, 0, 0, 100, 0, 0, 15000, 15000, 30000, 11, 41396, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Spellbound Attendant - In Combat - Cast Sleep');

-- Priestess of Delight (22962)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22962;
DELETE FROM smart_scripts WHERE entryorguid=22962 AND source_type=0;
INSERT INTO smart_scripts VALUES (22962, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 10000, 15000, 11, 41351, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Priestess of Delight - In Combat - Cast Curse of Vitality');

-- SPELL Curse of Vitality (41351)
DELETE FROM spell_script_names WHERE spell_id=41351;
INSERT INTO spell_script_names VALUES(41351, 'spell_black_temple_curse_of_vitality');

-- Priestess of Dementia (22957)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22957;
DELETE FROM smart_scripts WHERE entryorguid=22957 AND source_type=0;
INSERT INTO smart_scripts VALUES (22957, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 20000, 35000, 11, 41397, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Priestess of Dementia - In Combat - Cast Confusion');
INSERT INTO smart_scripts VALUES (22957, 0, 1, 0, 0, 0, 100, 0, 0, 20000, 40000, 55000, 11, 41404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Priestess of Dementia - In Combat - Cast Dementia');

-- SPELL Dementia (41404)
DELETE FROM spell_script_names WHERE spell_id=41404;
INSERT INTO spell_script_names VALUES(41404, 'spell_black_temple_dementia');

-- Promenade Sentinel (23394)
REPLACE INTO creature_template_addon VALUES (23394, 0, 0, 0, 4097, 0, '');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23394;
DELETE FROM smart_scripts WHERE entryorguid=23394 AND source_type=0;
INSERT INTO smart_scripts VALUES (23394, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 41359, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Promenade Sentinel - On Aggro - Cast L1 Arcane Charge');
INSERT INTO smart_scripts VALUES (23394, 0, 1, 0, 0, 0, 100, 0, 0, 10000, 15000, 20000, 11, 41348, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Promenade Sentinel - In Combat - Cast L4 Arcane Charge');
INSERT INTO smart_scripts VALUES (23394, 0, 2, 0, 0, 0, 100, 0, 0, 20000, 20000, 35000, 11, 41360, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Promenade Sentinel - In Combat - Cast L5 Arcane Charge');

-- SPELL L1 Arcane Charge (41357)
DELETE FROM spell_script_names WHERE spell_id=41357;
INSERT INTO spell_script_names VALUES(41357, 'spell_gen_select_target_count_15_1');

-- SPELL L5 Arcane Charge (41360)
DELETE FROM spell_script_names WHERE spell_id=41360;
INSERT INTO spell_script_names VALUES(41360, 'spell_gen_100pct_count_pct_from_max_hp');

-- Arcane Charge (23429)
REPLACE INTO creature_template_addon VALUES (23429, 0, 0, 0, 4097, 0, '41347');
UPDATE creature_template SET unit_flags=4|768, dmg_multiplier=20, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=23429;
DELETE FROM smart_scripts WHERE entryorguid=23429 AND source_type=0;
INSERT INTO smart_scripts VALUES (23429, 0, 0, 1, 60, 0, 100, 1, 2000, 2000, 0, 0, 11, 41349, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Charge - On Update - Cast L4 Arcane Charge');
INSERT INTO smart_scripts VALUES (23429, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcane Charge - On Update - Despawn');

-- Illidari Blood Lord (23397)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23397;
DELETE FROM smart_scripts WHERE entryorguid=23397 AND source_type=0;
INSERT INTO smart_scripts VALUES (23397, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 15000, 25000, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Blood Lord - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (23397, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 10000, 15000, 11, 41368, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Blood Lord - In Combat - Cast Judgement of Command');
INSERT INTO smart_scripts VALUES (23397, 0, 2, 0, 2, 0, 100, 1, 0, 40, 0, 0, 11, 41367, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Blood Lord - Between Health 0-40% - Cast Divine Shield');

-- Illidari Assassin (23403)
REPLACE INTO creature_template_addon VALUES (23403, 0, 0, 0, 4097, 0, '41393');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23403;
DELETE FROM smart_scripts WHERE entryorguid=23403 AND source_type=0;
INSERT INTO smart_scripts VALUES (23403, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 15000, 25000, 11, 3609, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Assassin - In Combat - Cast Paralyzing Poison');
INSERT INTO smart_scripts VALUES (23403, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 19000, 25000, 11, 39667, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Assassin - In Combat - Cast Vanish');

-- SPELL Riposte (41393)
REPLACE INTO spell_proc_event VALUES (41393, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0);

-- Illidari Archon (22964)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=22964;
DELETE FROM smart_scripts WHERE entryorguid=22964 AND source_type=0;
INSERT INTO smart_scripts VALUES (22964, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (22964, 0, 1, 0, 14, 1, 100, 0, 40000, 40, 5000, 7000, 11, 41372, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (22964, 0, 2, 0, 16, 1, 100, 0, 41373, 40, 5000, 10000, 11, 41373, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - Friendly Missing Buff - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (22964, 0, 3, 0, 0, 1, 100, 0, 0, 10000, 10000, 15000, 11, 41370, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (22964, 0, 4, 0, 0, 2, 100, 1, 0, 0, 0, 0, 11, 29406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - In Combat - Cast Shadowform');
INSERT INTO smart_scripts VALUES (22964, 0, 5, 0, 0, 2, 100, 0, 0, 3000, 3000, 3000, 11, 41374, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (22964, 0, 6, 0, 0, 2, 100, 0, 0, 10000, 10000, 15000, 11, 41375, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Archon - In Combat - Cast Shadow Word: Death');

-- Illidari Battle-mage (23402)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23402;
DELETE FROM smart_scripts WHERE entryorguid=23402 AND source_type=0;
INSERT INTO smart_scripts VALUES (23402, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Illidari Battle-mage - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (23402, 0, 1, 0, 0, 1, 100, 0, 0, 1000, 2000, 2000, 11, 41383, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Battle-mage - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (23402, 0, 2, 0, 0, 1, 100, 0, 6000, 10000, 10000, 15000, 11, 41379, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Illidari Battle-mage - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (23402, 0, 3, 0, 0, 2, 100, 0, 0, 1000, 2000, 2000, 11, 41384, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Illidari Battle-mage - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (23402, 0, 4, 0, 0, 2, 100, 0, 6000, 10000, 17000, 20000, 11, 41382, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Illidari Battle-mage - In Combat - Cast Blizzard');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- High Warlord Naj'entus (22887)
DELETE FROM creature_text WHERE entry=22887;
INSERT INTO creature_text VALUES (22887, 0, 0, 'You will die in the name of Lady Vashj!', 14, 0, 100, 0, 0, 11450, 0, 'najentus SAY_AGGRO');
INSERT INTO creature_text VALUES (22887, 1, 0, 'Stick around!', 14, 0, 100, 0, 0, 11451, 0, 'najentus SAY_NEEDLE1');
INSERT INTO creature_text VALUES (22887, 1, 1, 'I''ll deal with you later!', 14, 0, 100, 0, 0, 11452, 0, 'najentus SAY_NEEDLE2');
INSERT INTO creature_text VALUES (22887, 2, 0, 'Your success was short lived!', 14, 0, 100, 0, 0, 11455, 0, 'najentus SAY_SLAY1');
INSERT INTO creature_text VALUES (22887, 2, 1, 'Time for you to go!', 14, 0, 100, 0, 0, 11456, 0, 'najentus SAY_SLAY2');
INSERT INTO creature_text VALUES (22887, 3, 0, 'Bel''anen dal''lorei!', 14, 0, 100, 0, 0, 11453, 0, 'najentus SAY_SPECIAL1');
INSERT INTO creature_text VALUES (22887, 3, 1, 'Blood will flow!', 14, 0, 100, 0, 0, 11454, 0, 'najentus SAY_SPECIAL2');
INSERT INTO creature_text VALUES (22887, 4, 0, 'Bal''amer ch''itah!', 14, 0, 100, 0, 0, 11457, 0, 'najentus SAY_ENRAGE1');
INSERT INTO creature_text VALUES (22887, 4, 1, 'My patience has ran out! Die, DIE!', 14, 0, 100, 0, 0, 11458, 0, 'najentus SAY_ENRAGE2');
INSERT INTO creature_text VALUES (22887, 5, 0, 'Lord Illidan will... crush you.', 14, 0, 100, 0, 0, 11459, 0, 'najentus SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_najentus' WHERE entry=22887;

-- GO Naj'entus Spine (185584)
UPDATE gameobject_template SET AIName='', ScriptName='' WHERE entry=185584;

-- SPELL Needle Spine (39835)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(39835, -39835, 39992, -39992, 39968, -39968);
INSERT INTO spell_linked_spell VALUES (39835, 39968, 1, 'Needle Spine');

-- SPELL Needle Spine Targeting (39992)
DELETE FROM spell_script_names WHERE spell_id=39992;
INSERT INTO spell_script_names VALUES(39992, 'spell_najentus_needle_spine');

-- SPELL Remove Impaling Spine (39977)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39977;
INSERT INTO conditions VALUES(13, 1, 39977, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(39977, -39977);
INSERT INTO spell_linked_spell VALUES (39977, -39837, 1, 'Remove Impaling Spine');

-- SPELL Hurl Spine (39948)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=39948;
INSERT INTO conditions VALUES(17, 0, 39948, 0, 0, 31, 1, 3, 22887, 0, 0, 0, 0, '', 'Target High Warlord Naj''entus');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(39948, -39948);
DELETE FROM spell_script_names WHERE spell_id=39948;
INSERT INTO spell_script_names VALUES(39948, 'spell_najentus_hurl_spine');

-- Supremus (22898)
DELETE FROM creature_text WHERE entry=22898;
INSERT INTO creature_text VALUES (22898, 0, 0, '%s acquires a new target!', 41, 0, 100, 0, 0, 0, 0, 'supremus EMOTE_NEW_TARGET');
INSERT INTO creature_text VALUES (22898, 1, 0, '%s punches the ground in anger!', 41, 0, 100, 0, 0, 0, 0, 'supremus EMOTE_PUNCH_GROUND');
INSERT INTO creature_text VALUES (22898, 2, 0, 'The ground begins to crack open!', 41, 0, 100, 0, 0, 0, 0, 'supremus EMOTE_GROUND_CRACK');
REPLACE INTO creature_model_info VALUES (21145, 18, 18, 2, 0);
UPDATE creature_template SET speed_walk=2.4, speed_run=2.14286, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_supremus' WHERE entry=22898;

-- Supremus Punch Invis Stalker (23095)
REPLACE INTO creature_template_addon VALUES (23095, 0, 0, 0, 0, 0, '40980');
UPDATE creature_template SET faction=16, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23095;

-- Supremus Volcano (23085)
UPDATE creature_template SET unit_flags=33554438, faction=16, flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry=23085;

-- Shade of Akama (22841)
REPLACE INTO creature_template_addon VALUES (22841, 0, 0, 0, 1, 0, '40973');
UPDATE creature_template SET faction=1813, dmg_multiplier=180, mechanic_immune_mask=650854271, flags_extra=1|256|0x200000, AIName='', ScriptName='boss_shade_of_akama' WHERE entry=22841;

-- Akama (23191)
DELETE FROM creature_text WHERE entry=23191;
INSERT INTO creature_text VALUES (23191, 0, 0, 'Broken of the Ashtongue tribe, your leader speaks!', 14, 0, 100, 15, 0, 0, 0, 'Akama SAY_BROKEN_FREE_0');
INSERT INTO creature_text VALUES (23191, 1, 0, 'The Betrayer no longer holds sway over us.  His dark magic over the Ashtongue soul has been destroyed!', 14, 0, 100, 0, 0, 0, 0, 'Akama SAY_BROKEN_FREE_1');
INSERT INTO creature_text VALUES (23191, 2, 0, 'Come out from the shadows!  I''ve returned to lead you against our true enemy!  Shed your chains and raise your weapons against your Illidari masters!', 14, 0, 100, 0, 0, 0, 0, 'Akama SAY_BROKEN_FREE_2');
UPDATE creature_template SET faction=1866, speed_walk=1.2, dmg_multiplier=18, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='npc_akama_shade' WHERE entry=23191;

-- Ashtongue Channeler (23421)
UPDATE creature_template SET faction=1813, mechanic_immune_mask=650854271, AIName='NullCreatureAI', ScriptName='' WHERE entry=23421;

-- Creature Generator (Akama) (23210)
UPDATE creature_template SET faction=1813, flags_extra=130, AIName='', ScriptName='npc_creature_generator_akama' WHERE entry=23210;

-- Ashtongue Sorcerer (23215)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23215;
DELETE FROM smart_scripts WHERE entryorguid=23215 AND source_type=0;
INSERT INTO smart_scripts VALUES (23215, 0, 0, 0, 34, 0, 100, 0, 8, 0, 0, 0, 11, 40401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Sorcerer - Movement Inform - Cast Shade Soul Channel');
INSERT INTO smart_scripts VALUES (23215, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 19, 23421, 5, 1, 0, 0, 0, 0, 'Ashtongue Sorcerer - On Death - Remove Unit Flag');

-- Ashtongue Rogue (23318)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23318;
DELETE FROM smart_scripts WHERE entryorguid=23318 AND source_type=0;
INSERT INTO smart_scripts VALUES (23318, 0, 0, 0, 0, 0, 100, 0, 500, 2000, 14000, 18000, 11, 41978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Rogue - In Combat - Cast Debilitating Poison');
INSERT INTO smart_scripts VALUES (23318, 0, 1, 0, 0, 0, 100, 0, 10000, 10000, 15000, 16000, 11, 41177, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Rogue - In Combat - Cast Eviscerate');

-- Ashtongue Elementalist (23523)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23523;
DELETE FROM smart_scripts WHERE entryorguid=23523 AND source_type=0;
INSERT INTO smart_scripts VALUES (23523, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 42024, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Elementalist - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (23523, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 15000, 20000, 11, 42023, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Ashtongue Elementalist - In Combat - Cast Rain of Fire');

-- Ashtongue Spiritbinder (23524)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23524;
DELETE FROM smart_scripts WHERE entryorguid=23524 AND source_type=0;
INSERT INTO smart_scripts VALUES (23524, 0, 0, 0, 14, 0, 100, 0, 10000, 40, 9000, 12000, 11, 42027, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Spiritbinder - Friendly Missing Health - Cast Chain-Heal');
INSERT INTO smart_scripts VALUES (23524, 0, 1, 0, 14, 0, 100, 0, 5000, 40, 12000, 15000, 11, 42025, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Spiritbinder - Friendly Missing Health - Cast Spirit Mend');

-- Ashtongue Defender (23216)
UPDATE creature_template SET faction=1813, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23216;
DELETE FROM smart_scripts WHERE entryorguid=23216 AND source_type=0;
INSERT INTO smart_scripts VALUES (23216, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 14000, 18000, 11, 41178, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Defender - In Combat - Cast Debilitating Strike');
INSERT INTO smart_scripts VALUES (23216, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 7000, 9000, 11, 41975, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Defender - In Combat - Cast Heroic Strike');
INSERT INTO smart_scripts VALUES (23216, 0, 2, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 41180, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Defender - Victim Casting - Cast Shield Bash');

-- Shade of Akama Trigger (23351)
UPDATE creature_template SET faction=35, flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=23351;
DELETE FROM smart_scripts WHERE entryorguid=23351 AND source_type=0;

-- Ashtongue Broken (23319)
DELETE FROM creature_text WHERE entry=23319;
INSERT INTO creature_text VALUES (23319, 0, 0, 'Hail our leader! Hail Akama!', 14, 0, 100, 15, 0, 0, 0, 'Ashtongue Broken');
INSERT INTO creature_text VALUES (23319, 1, 0, 'Hail Akama!', 14, 0, 100, 0, 0, 0, 0, 'Ashtongue Broken');
UPDATE creature_template SET faction=1820, AIName='NullCreatureAI', ScriptName='' WHERE entry=23319;

-- SPELL Akama Soul Channel (40447)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40447;
INSERT INTO conditions VALUES(13, 2, 40447, 0, 0, 31, 0, 3, 22841, 0, 0, 0, 0, '', 'Target Shade of Akama');

-- SPELL Shade Soul Channel (40401)
-- SPELL Shade Soul Channel (40520)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(40401, 40520);
INSERT INTO conditions VALUES(13, 3, 40401, 0, 0, 31, 0, 3, 22841, 0, 0, 0, 0, '', 'Target Shade of Akama');
INSERT INTO conditions VALUES(13, 1, 40520, 0, 0, 31, 0, 3, 22841, 0, 0, 0, 0, '', 'Target Shade of Akama');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(40401, -40401, 40520, -40520);
DELETE FROM spell_script_names WHERE spell_id=40401;
INSERT INTO spell_script_names VALUES(40401, 'spell_shade_of_akama_shade_soul_channel');

-- SPELL Destructive Poison (40874)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40874;
INSERT INTO conditions VALUES(13, 1, 40874, 0, 0, 31, 0, 3, 22841, 0, 0, 0, 0, '', 'Target Shade of Akama');

-- SPELL Akama Soul Retrieve Channel (40902)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40902;
INSERT INTO conditions VALUES(13, 6, 40902, 0, 0, 31, 0, 3, 23351, 0, 0, 0, 0, '', 'Target Shade of Akama Trigger');

-- SPELL Akama Soul Expel (40855)
DELETE FROM spell_script_names WHERE spell_id IN(40854, 40855);
INSERT INTO spell_script_names VALUES(40854, 'spell_shade_of_akama_akama_soul_expel');
INSERT INTO spell_script_names VALUES(40855, 'spell_shade_of_akama_akama_soul_expel');

-- Ashtongue Broken Summons
DELETE FROM creature_summon_groups WHERE summonerId=23191 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 526.963, 402.33, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 527.058, 398.692, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 527.21, 392.884, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 527.15, 395.193, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 526.842, 406.949, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 526.781, 409.258, 112.784, 3.16779, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 516.943, 431.587, 112.784, 3.71757, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 515.036, 434.523, 112.784, 3.71757, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 513.092, 437.517, 112.784, 3.71757, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 500.08, 456.6, 112.784, 4.16916, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 497.54, 459.01, 112.784, 4.16916, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 502.57, 454.24, 112.784, 4.16916, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 516.332, 373.772, 112.784, 2.65335, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 514.263, 369.563, 112.784, 2.68476, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 512.194, 365.354, 112.784, 2.68476, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 498.368, 346.025, 112.784, 2.00539, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 496.254, 344.93, 112.784, 2.04859, 8, 0);
INSERT INTO creature_summon_groups VALUES (23191, 0, 1, 23319, 494.203, 343.868, 112.784, 2.04859, 8, 0);

-- Teron Gorefiend (22871)
DELETE FROM creature_text WHERE entry=22871;
INSERT INTO creature_text VALUES (22871, 0, 0, 'I was the first, you know. For me, the wheel of death has spun many times. <laughs> So much time has passed. I have a lot of catching up to do...', 14, 0, 100, 1, 0, 11512, 0, 'teron SAY_INTRO');
INSERT INTO creature_text VALUES (22871, 1, 0, 'Vengeance is mine!', 14, 0, 100, 0, 0, 11513, 0, 'teron SAY_AGGRO');
INSERT INTO creature_text VALUES (22871, 2, 0, 'I have use for you!', 14, 0, 100, 0, 0, 11514, 0, 'teron SAY_SLAY1');
INSERT INTO creature_text VALUES (22871, 2, 1, 'It gets worse...', 14, 0, 100, 0, 0, 11515, 0, 'teron SAY_SLAY2');
INSERT INTO creature_text VALUES (22871, 3, 0, 'Death... really isn''t so bad.', 14, 0, 100, 0, 0, 11516, 0, 'teron SAY_BLOSSOM1');
INSERT INTO creature_text VALUES (22871, 3, 1, 'I have something for you...', 14, 0, 100, 0, 0, 11519, 0, 'teron SAY_BLOSSOM2');
INSERT INTO creature_text VALUES (22871, 4, 0, 'YOU WILL SHOW THE PROPER RESPECT!', 14, 0, 100, 0, 0, 11520, 0, 'teron SAY_INCINERATE1');
INSERT INTO creature_text VALUES (22871, 4, 1, 'What are you afraid of?', 14, 0, 100, 0, 0, 11517, 0, 'teron SAY_INCINERATE2');
INSERT INTO creature_text VALUES (22871, 5, 0, 'Give in!', 14, 0, 100, 0, 0, 11518, 0, 'teron SAY_CRUSHING');
INSERT INTO creature_text VALUES (22871, 6, 0, 'The wheel...spins...again....', 14, 0, 100, 0, 0, 11521, 0, 'teron SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|256|0x200000, AIName='', ScriptName='boss_teron_gorefiend' WHERE entry=22871;

-- Doom Blossom (23123)
UPDATE creature_template SET speed_run=0.8, unit_flags=33554432|2, flags_extra=2, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=23123;
DELETE FROM smart_scripts WHERE entryorguid=23123 AND source_type=0;
INSERT INTO smart_scripts VALUES (23123, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doom Blossom - AI Init - Set React State');
INSERT INTO smart_scripts VALUES (23123, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 11, 23033, 30, 0, 0, 0, 0, 0, 'Doom Blossom - AI Init - Move Point');
INSERT INTO smart_scripts VALUES (23123, 0, 2, 3, 34, 0, 100, 0, 8, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doom Blossom - Movement Inform - Set Event Phase');
INSERT INTO smart_scripts VALUES (23123, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 18, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doom Blossom - Movement Inform - Set Unit Flag');
INSERT INTO smart_scripts VALUES (23123, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doom Blossom - Movement Inform - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (23123, 0, 5, 0, 60, 1, 100, 0, 0, 0, 2000, 2000, 11, 40185, 0, 0, 0, 0, 0, 5, 100, 1, 0, 0, 0, 0, 0, 'Doom Blossom - On Update - Cast Shadow Bolt');

-- Vengeful Spirit (23109)
UPDATE creature_template SET spell1=40325, spell2=40157, spell3=40175, spell4=40314, spell5=40322, AIName='NullCreatureAI', ScriptName='' WHERE entry=23109;

-- Shadowy Construct (23111)
REPLACE INTO creature_template_addon VALUES (23111, 0, 0, 0, 4097, 0, '');
UPDATE creature_template SET unit_flags=4, dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=23111;
DELETE FROM smart_scripts WHERE entryorguid=23111 AND source_type=0;
INSERT INTO smart_scripts VALUES (23111, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Construct - AI Init - Disable Auto Attack');
INSERT INTO smart_scripts VALUES (23111, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 40326, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Construct - AI Init - Cast Shadowy Construct');
INSERT INTO smart_scripts VALUES (23111, 0, 2, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 40327, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Construct - In Combat - Cast Atrophy');

-- SPELL Shadowy Construct (40326)
DELETE FROM spell_script_names WHERE spell_id=40326;
INSERT INTO spell_script_names VALUES(40326, 'spell_teron_gorefiend_shadowy_construct');

-- SPELL Shadow of Death (40251)
DELETE FROM spell_script_names WHERE spell_id=40251;
INSERT INTO spell_script_names VALUES(40251, 'spell_teron_gorefiend_shadow_of_death');

-- SPELL Shadow of Death Remove (41999)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41999, -41999, 40251, -40251);
INSERT INTO spell_linked_spell VALUES (41999, -40251, 2, 'Remove Shadow of Death');

-- SPELL Spiritual Vengeance (40268)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40268;
INSERT INTO conditions VALUES(13, 3, 40268, 0, 0, 31, 0, 3, 23109, 0, 0, 0, 0, '', 'Target Vengeful Spirit');
DELETE FROM spell_script_names WHERE spell_id=40268;
INSERT INTO spell_script_names VALUES(40268, 'spell_teron_gorefiend_spiritual_vengeance');

-- SPELL Spirit Lance (40157)
-- SPELL Spirit Chains (40175)
-- SPELL Spirit Volley (40314)
-- SPELL Spirit Strike (40325)
-- SPELL Spirit Shield (40322)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(40157, 40175, 40314, 40322, 40325);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(40157, 40175, 40314, 40322, 40325);
INSERT INTO conditions VALUES(17, 0, 40157, 0, 0, 31, 1, 3, 23111, 0, 0, 0, 0, '', 'Target Shadowy Construct');
INSERT INTO conditions VALUES(13, 3, 40175, 0, 0, 31, 0, 3, 23111, 0, 0, 0, 0, '', 'Target Shadowy Construct');
INSERT INTO conditions VALUES(13, 1, 40314, 0, 0, 31, 0, 3, 23111, 0, 0, 0, 0, '', 'Target Shadowy Construct');
INSERT INTO conditions VALUES(17, 0, 40325, 0, 0, 31, 1, 3, 22871, 0, 0, 0, 0, '', 'Target Teron Gorefiend');
DELETE FROM spell_script_names WHERE spell_id=40157;
INSERT INTO spell_script_names VALUES(40157, 'spell_teron_gorefiend_spirit_lance');

-- Reliquary of the Lost (22856)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22856);
DELETE FROM creature_template_addon WHERE entry=22856;
UPDATE creature_template SET unit_flags=33554752, mechanic_immune_mask=650854271, flags_extra=1, AIName='', ScriptName='boss_reliquary_of_souls' WHERE entry=22856;

-- Reliquary Combat Trigger (23417)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23417;

-- Reliquary LoS Agro Trigger (23502)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23502;

-- Enslaved Soul (23469)
REPLACE INTO creature_template_addon VALUES (23469, 0, 0, 0, 1, 0, '');
UPDATE creature_template SET mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=23469;
DELETE FROM smart_scripts WHERE entryorguid=23469 AND source_type=0;
INSERT INTO smart_scripts VALUES (23469, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - Is Summoned By - Store Target');
INSERT INTO smart_scripts VALUES (23469, 0, 1, 7, 61, 0, 100, 0, 0, 0, 0, 0, 85, 32840, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - Is Summoned By - Invoker Cast Beam (Blue)');
INSERT INTO smart_scripts VALUES (23469, 0, 2, 0, 60, 0, 100, 257, 2000, 2000, 0, 0, 28, 32840, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - On Update - Remove Aura Beam (Blue)');
INSERT INTO smart_scripts VALUES (23469, 0, 3, 0, 60, 0, 100, 257, 1500, 1500, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - On Update - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (23469, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 11, 41542, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - On Death - Cast Soul Release');
INSERT INTO smart_scripts VALUES (23469, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - On Death - Despawn');
INSERT INTO smart_scripts VALUES (23469, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 32840, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - On Death - Remove Aura Beam (Blue)');
INSERT INTO smart_scripts VALUES (23469, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enslaved Soul - Is Summoned By - Cast Enslaved Soul Passive');

-- Essence of Suffering (23418)
REPLACE INTO creature_template_addon VALUES (23418, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=23418;
INSERT INTO creature_text VALUES (23418, 0, 0, 'Pain and suffering are all that await you!', 14, 0, 100, 0, 0, 11415, 0, 'essence SUFF_SAY_FREED');
INSERT INTO creature_text VALUES (23418, 1, 0, 'Don''t leave me alone!', 14, 0, 100, 0, 0, 11416, 0, 'essence SUFF_SAY_AGGRO');
INSERT INTO creature_text VALUES (23418, 2, 0, 'Look at what you make me do!', 14, 0, 100, 0, 0, 11417, 0, 'essence SUFF_SAY_SLAY1');
INSERT INTO creature_text VALUES (23418, 2, 1, 'I didn''t ask for this!', 14, 0, 100, 0, 0, 11418, 0, 'essence SUFF_SAY_SLAY2');
INSERT INTO creature_text VALUES (23418, 3, 0, 'I don''t want to go back!', 14, 0, 100, 0, 0, 11420, 0, 'essence SUFF_SAY_RECAP');
INSERT INTO creature_text VALUES (23418, 4, 0, 'Now what do I do?', 14, 0, 100, 0, 0, 11421, 0, 'essence SUFF_SAY_AFTER');
INSERT INTO creature_text VALUES (23418, 5, 0, 'The pain is only beginning!', 14, 0, 100, 0, 0, 11419, 0, 'essence SUFF_SAY_ENRAGE');
INSERT INTO creature_text VALUES (23418, 6, 0, '%s becomes enraged!', 41, 0, 100, 0, 0, 0, 0, 'essence SUFF_EMOTE_ENRAGE');
UPDATE creature_template SET dmg_multiplier=7.5, baseattacktime=1000, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_essence_of_suffering' WHERE entry=23418;

-- Essence of Desire (23419)
REPLACE INTO creature_template_addon VALUES (23419, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=23419;
INSERT INTO creature_text VALUES (23419, 0, 0, 'You can have anything you desire... for a price.', 14, 0, 100, 0, 0, 11408, 0, 'essence DESI_SAY_FREED');
INSERT INTO creature_text VALUES (23419, 1, 0, 'Fulfilment is at hand!', 14, 0, 100, 0, 0, 11409, 0, 'essence DESI_SAY_SLAY1');
INSERT INTO creature_text VALUES (23419, 1, 1, 'Yes... you''ll stay with us now...', 14, 0, 100, 0, 0, 11410, 0, 'essence DESI_SAY_SLAY2');
INSERT INTO creature_text VALUES (23419, 1, 2, 'Your reach exceeds your grasp.', 14, 0, 100, 0, 0, 11412, 0, 'essence DESI_SAY_SLAY3');
INSERT INTO creature_text VALUES (23419, 2, 0, 'Be careful what you wish for...', 14, 0, 100, 0, 0, 11411, 0, 'essence DESI_SAY_SPEC');
INSERT INTO creature_text VALUES (23419, 3, 0, 'I''ll be waiting...', 14, 0, 100, 0, 0, 11413, 0, 'essence DESI_SAY_RECAP');
INSERT INTO creature_text VALUES (23419, 4, 0, 'I won''t be far...', 14, 0, 100, 0, 0, 11414, 0, 'essence DESI_SAY_AFTER');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_essence_of_desire' WHERE entry=23419;

-- Essence of Anger (23420)
REPLACE INTO creature_template_addon VALUES (23420, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=23420;
INSERT INTO creature_text VALUES (23420, 0, 0, 'Beware: I live!', 14, 0, 100, 0, 0, 11399, 0, 'essence ANGER_SAY_FREED');
INSERT INTO creature_text VALUES (23420, 0, 1, 'So... foolish.', 14, 0, 100, 0, 0, 11400, 0, 'essence ANGER_SAY_FREED2');
INSERT INTO creature_text VALUES (23420, 1, 0, '<maniacal cackle>', 16, 0, 100, 0, 0, 11401, 0, 'essence ANGER_SAY_SLAY1');
INSERT INTO creature_text VALUES (23420, 1, 1, 'Enough. No more.', 14, 0, 100, 0, 0, 11402, 0, 'essence ANGER_SAY_SLAY2');
INSERT INTO creature_text VALUES (23420, 2, 0, 'On your knees!', 14, 0, 100, 0, 0, 11403, 0, 'essence ANGER_SAY_SPEC');
INSERT INTO creature_text VALUES (23420, 3, 0, 'Beware, coward.', 14, 0, 100, 0, 0, 11405, 0, 'essence ANGER_SAY_RECAP');
INSERT INTO creature_text VALUES (23420, 4, 0, 'I won''t... be... ignored.', 14, 0, 100, 0, 0, 11404, 0, 'essence ANGER_SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_essence_of_anger' WHERE entry=23420;

-- SPELL Summon Enslaved Soul (41537)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41537;
INSERT INTO conditions VALUES(13, 1, 41537, 0, 0, 31, 0, 3, 23472, 0, 0, 0, 0, '', 'Target World Trigger (Large AOI)');

-- SPELL Aura of Suffering (41292)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41292, -41292, 42017, -42017);
DELETE FROM spell_script_names WHERE spell_id=41292;
INSERT INTO spell_script_names VALUES(41292, 'spell_reliquary_of_souls_aura_of_suffering');

-- SPELL Fixate (41294)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41294, -41294);
DELETE FROM spell_script_names WHERE spell_id=41294;
INSERT INTO spell_script_names VALUES(41294, 'spell_reliquary_of_souls_fixate');

-- SPELL Aura of Desire (41350)
REPLACE INTO spell_proc_event VALUES (41350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41350, -41350, 41352, -41352);
DELETE FROM spell_script_names WHERE spell_id=41350;
INSERT INTO spell_script_names VALUES(41350, 'spell_reliquary_of_souls_aura_of_desire');

-- SPELL Aura of Anger (41337)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41337, -41337);
DELETE FROM spell_script_names WHERE spell_id=41337;
INSERT INTO spell_script_names VALUES(41337, 'spell_reliquary_of_souls_aura_of_anger');

-- SPELL Spite (41376)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41376, -41376, 41377, -41377);
DELETE FROM spell_script_names WHERE spell_id=41376;
INSERT INTO spell_script_names VALUES(41376, 'spell_reliquary_of_souls_spite');

-- Gurtogg Bloodboil (22948)
REPLACE INTO creature_template_addon VALUES (22948, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=22948;
INSERT INTO creature_text VALUES (22948, 0, 0, 'Horde will... crush you.', 14, 0, 100, 0, 0, 11432, 0, 'bloodboil SOUND_AGGRO');
INSERT INTO creature_text VALUES (22948, 1, 0, 'Time to feast!', 14, 0, 100, 0, 0, 11433, 0, 'bloodboil SAY_SLAY1');
INSERT INTO creature_text VALUES (22948, 1, 1, 'More! I want more!', 14, 0, 100, 0, 0, 11434, 0, 'bloodboil SAY_SLAY2');
INSERT INTO creature_text VALUES (22948, 2, 0, 'Drink your blood! Eat your flesh!', 14, 0, 100, 0, 0, 11435, 0, 'bloodboil SAY_SPECIAL1');
INSERT INTO creature_text VALUES (22948, 2, 1, 'I hunger!', 14, 0, 100, 0, 0, 11436, 0, 'bloodboil SAY_SPECIAL2');
INSERT INTO creature_text VALUES (22948, 3, 0, '<babbling>', 14, 0, 100, 0, 0, 11437, 0, 'bloodboil SAY_ENRAGE1');
INSERT INTO creature_text VALUES (22948, 3, 1, 'I''ll rip the meat from your bones!', 14, 0, 100, 0, 0, 11438, 0, 'bloodboil SAY_ENRAGE2');
INSERT INTO creature_text VALUES (22948, 4, 0, 'Aaaahrg...', 14, 0, 100, 0, 0, 11439, 0, 'bloodboil SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_gurtogg_bloodboil' WHERE entry=22948;

-- Fel Geyser (23254)
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', ScriptName='' WHERE entry=23254;

-- SPELL Bloodboil (42005)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(42005, -42005);
DELETE FROM spell_script_names WHERE spell_id=42005;
INSERT INTO spell_script_names VALUES(42005, 'spell_gurtogg_bloodboil');

-- SPELL Eject (40486)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(40486, -40486);
DELETE FROM spell_script_names WHERE spell_id=40486;
INSERT INTO spell_script_names VALUES(40486, 'spell_gurtogg_eject');

-- SPELL Taunt Gurtogg (40603)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40603;
INSERT INTO conditions VALUES(13, 3, 40603, 0, 0, 31, 0, 3, 22948, 0, 0, 0, 0, '', 'Target Gurtogg Bloodboil');

-- Mother Shahraz (22947)
REPLACE INTO creature_template_addon VALUES (22947, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=22947;
INSERT INTO creature_text VALUES (22947, 0, 0, 'You play, you pay.', 14, 0, 100, 0, 0, 11501, 0, 'shahraz SAY_TAUNT1');
INSERT INTO creature_text VALUES (22947, 0, 1, 'I''m not impressed.', 14, 0, 100, 0, 0, 11502, 0, 'shahraz SAY_TAUNT2');
INSERT INTO creature_text VALUES (22947, 0, 2, 'Enjoying yourselves?', 14, 0, 100, 0, 0, 11503, 0, 'shahraz SAY_TAUNT3');
INSERT INTO creature_text VALUES (22947, 1, 0, 'So... business or pleasure?', 14, 0, 100, 0, 0, 11504, 0, 'shahraz SAY_AGGRO');
INSERT INTO creature_text VALUES (22947, 2, 0, 'You seem a little tense.', 14, 0, 100, 0, 0, 11505, 0, 'shahraz SAY_SPELL1');
INSERT INTO creature_text VALUES (22947, 2, 1, 'Don''t be shy.', 14, 0, 100, 0, 0, 11506, 0, 'shahraz SAY_SPELL2');
INSERT INTO creature_text VALUES (22947, 2, 2, 'I''m all... yours.', 14, 0, 100, 0, 0, 11507, 0, 'shahraz SAY_SPELL3');
INSERT INTO creature_text VALUES (22947, 3, 0, 'Easy come, easy go.', 14, 0, 100, 0, 0, 11508, 0, 'shahraz SAY_SLAY1');
INSERT INTO creature_text VALUES (22947, 3, 1, 'So much for a happy ending.', 14, 0, 100, 0, 0, 11509, 0, 'shahraz SAY_SLAY2');
INSERT INTO creature_text VALUES (22947, 4, 0, 'Stop toying with my emotions!', 14, 0, 100, 0, 0, 11510, 0, 'shahraz SAY_ENRAGE');
INSERT INTO creature_text VALUES (22947, 5, 0, 'I wasn''t... finished.', 14, 0, 100, 0, 0, 11511, 0, 'shahraz SAY_DEATH');
INSERT INTO creature_text VALUES (22947, 6, 0, '%s goes into a frenzy!', 41, 0, 100, 0, 0, 0, 0, 'shahraz SAY_EMOTE_FRENZY');
UPDATE creature_template SET dmg_multiplier=50, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_mother_shahraz' WHERE entry=22947;

-- SPELL Random Periodic (40867)
-- SPELL Sinful Periodic (40862)
-- SPELL Sinister Periodic (40863)
-- SPELL Vile Periodic (40865)
-- SPELL Wicked Periodic (40866)
DELETE FROM spell_script_names WHERE spell_id IN (40867, 40862, 40863, 40865, 40866);
INSERT INTO spell_script_names VALUES(40867, 'spell_mother_shahraz_random_periodic');
INSERT INTO spell_script_names VALUES(40862, 'spell_mother_shahraz_beam_periodic');
INSERT INTO spell_script_names VALUES(40863, 'spell_mother_shahraz_beam_periodic');
INSERT INTO spell_script_names VALUES(40865, 'spell_mother_shahraz_beam_periodic');
INSERT INTO spell_script_names VALUES(40866, 'spell_mother_shahraz_beam_periodic');

-- SPELL Random Periodic (40867)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(40867, -40867);
DELETE FROM spell_script_names WHERE spell_id=40867;
INSERT INTO spell_script_names VALUES(40867, 'spell_mother_shahraz_random_periodic');

-- SPELL Saber Lash (40816)
DELETE FROM spell_script_names WHERE spell_id=40816;
INSERT INTO spell_script_names VALUES(40816, 'spell_mother_shahraz_saber_lash');

-- SPELL Fatal Attraction (40869)
-- SPELL Fatal Attraction (40870)
-- SPELL Fatal Attraction (41001)
DELETE FROM spell_script_names WHERE spell_id IN(40869, 40870, 41001);
INSERT INTO spell_script_names VALUES(40869, 'spell_mother_shahraz_fatal_attraction');
INSERT INTO spell_script_names VALUES(40870, 'spell_mother_shahraz_fatal_attraction_dummy');
INSERT INTO spell_script_names VALUES(41001, 'spell_mother_shahraz_fatal_attraction_aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40870;
INSERT INTO conditions VALUES(13, 1, 40870, 0, 0, 1, 0, 41001, 1, 0, 0, 0, 0, '', 'Target Players With Fatal Attraction Aura');

-- The Illidari Council (23426)
UPDATE creature_template SET flags_extra=131, AIName='', ScriptName='boss_illidari_council' WHERE entry=23426;

-- Blood Elf Council Voice Trigger (23499)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23499;

-- Gathios the Shatterer (22949)
-- High Nethermancer Zerevor (22950)
-- Lady Malande (22951)
-- Veras Darkshadow (22952)
REPLACE INTO creature_template_addon VALUES (22949, 0, 0, 0, 4097, 0, '41341');
REPLACE INTO creature_template_addon VALUES (22950, 0, 0, 0, 4097, 0, '41341');
REPLACE INTO creature_template_addon VALUES (22951, 0, 0, 0, 4097, 0, '41341');
REPLACE INTO creature_template_addon VALUES (22952, 0, 0, 0, 4097, 0, '41341');
DELETE FROM creature_text WHERE entry IN(22949, 22950, 22951, 22952);
INSERT INTO creature_text VALUES (22949, 0, 0, 'I have better things to do...', 14, 0, 100, 0, 0, 11422, 0, 'council gath AGGRO');
INSERT INTO creature_text VALUES (22949, 1, 0, 'Enough games!', 14, 0, 100, 0, 0, 11428, 0, 'council gath ENRAGE');
INSERT INTO creature_text VALUES (22949, 2, 0, 'Enjoy your final moments!', 14, 0, 100, 0, 0, 11426, 0, 'council gath SPECIAL1');
INSERT INTO creature_text VALUES (22949, 2, 1, 'You are mine!', 14, 0, 100, 0, 0, 11427, 0, 'council gath SPECIAL2');
INSERT INTO creature_text VALUES (22949, 3, 0, 'Selama am''oronor!', 14, 0, 100, 0, 0, 11423, 0, 'council gath SLAY1');
INSERT INTO creature_text VALUES (22949, 3, 1, 'Well done!', 14, 0, 100, 0, 0, 11424, 0, 'council gath SLAY_SLAY2');
INSERT INTO creature_text VALUES (22949, 4, 0, 'Lord Illidan... I...', 14, 0, 100, 0, 0, 11425, 0, 'council gath DEATH');
INSERT INTO creature_text VALUES (22950, 0, 0, 'Common... such a crude language. Bandal!', 14, 0, 100, 0, 0, 11440, 0, 'council zere AGGRO');
INSERT INTO creature_text VALUES (22950, 1, 0, 'Sha''amoor sine menoor!', 14, 0, 100, 0, 0, 11446, 0, 'council zere ENRAGE');
INSERT INTO creature_text VALUES (22950, 2, 0, 'Diel fin''al', 14, 0, 100, 0, 0, 11444, 0, 'council zere SPECIAL1');
INSERT INTO creature_text VALUES (22950, 2, 1, 'Sha''amoor ara mashal?', 14, 0, 100, 0, 0, 11445, 0, 'council zere SPECIAL2');
INSERT INTO creature_text VALUES (22950, 3, 0, 'Shorel''aran.', 14, 0, 100, 0, 0, 11441, 0, 'council zere SLAY1');
INSERT INTO creature_text VALUES (22950, 3, 1, 'Belesa menoor!', 14, 0, 100, 0, 0, 11442, 0, 'council zere SLAY2');
INSERT INTO creature_text VALUES (22950, 4, 0, 'Diel ma''ahn... oreindel''o', 14, 0, 100, 0, 0, 11443, 0, 'council zere DEATH');
INSERT INTO creature_text VALUES (22951, 0, 0, 'Flee or die!', 14, 0, 100, 0, 0, 11482, 0, 'council mala AGGRO');
INSERT INTO creature_text VALUES (22951, 1, 0, 'For Quel''Thalas! For the Sunwell!', 14, 0, 100, 0, 0, 11488, 0, 'council mala ENRAGE');
INSERT INTO creature_text VALUES (22951, 2, 0, 'No second chances!', 14, 0, 100, 0, 0, 11486, 0, 'council mala SPECIAL1');
INSERT INTO creature_text VALUES (22951, 2, 1, 'I''m full of surprises!', 14, 0, 100, 0, 0, 11487, 0, 'council mala SPECIAL2');
INSERT INTO creature_text VALUES (22951, 3, 0, 'My work is done.', 14, 0, 100, 0, 0, 11483, 0, 'council mala SLAY');
INSERT INTO creature_text VALUES (22951, 3, 1, 'As it should be!', 14, 0, 100, 0, 0, 11484, 0, 'council mala SLAY2');
INSERT INTO creature_text VALUES (22951, 4, 0, 'Destiny... awaits.', 14, 0, 100, 0, 0, 11485, 0, 'council mala DEATH');
INSERT INTO creature_text VALUES (22952, 0, 0, 'You wish to test me?', 14, 0, 100, 0, 0, 11524, 0, 'council vera AGGRO');
INSERT INTO creature_text VALUES (22952, 1, 0, 'You wish to kill me? Hahaha, you first!', 14, 0, 100, 0, 0, 11530, 0, 'council vera ENRAGE');
INSERT INTO creature_text VALUES (22952, 2, 0, 'You''re not caught up for this!', 14, 0, 100, 0, 0, 11528, 0, 'council vera SPECIAL1');
INSERT INTO creature_text VALUES (22952, 2, 1, 'Anar''alah belore!', 14, 0, 100, 0, 0, 11529, 0, 'council vera SPECIAL2');
INSERT INTO creature_text VALUES (22952, 3, 0, 'Valiant effort!', 14, 0, 100, 0, 0, 11525, 0, 'council vera SLAY1');
INSERT INTO creature_text VALUES (22952, 3, 1, 'A glorious kill!', 14, 0, 100, 0, 0, 11526, 0, 'council vera SLAY2');
INSERT INTO creature_text VALUES (22952, 4, 0, 'You got lucky!', 14, 0, 100, 0, 0, 11527, 0, 'council vera DEATH');
UPDATE creature_template SET unit_flags=32832, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_gathios_the_shatterer' WHERE entry=22949;
UPDATE creature_template SET unit_flags=32832, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_high_nethermancer_zerevor' WHERE entry=22950;
UPDATE creature_template SET unit_flags=32832, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_lady_malande' WHERE entry=22951;
UPDATE creature_template SET unit_flags=32832, dmg_multiplier=40, baseattacktime=1000, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_veras_darkshadow' WHERE entry=22952;

-- Veras Vanish Effect (23451)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23451;

-- SPELL Judgement (41467)
DELETE FROM spell_script_names WHERE spell_id=41467;
INSERT INTO spell_script_names VALUES(41467, 'spell_illidari_council_judgement');

-- SPELL Seal of Command (41469)
REPLACE INTO spell_proc_event VALUES (41469, 0, 0, 0, 0, 0, 0, 0, 0, 33, 0);

-- SPELL Circle of Healing (41455)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41455;
INSERT INTO conditions VALUES(13, 1, 41455, 0, 0, 31, 0, 3, 22949, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41455, 0, 1, 31, 0, 3, 22950, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41455, 0, 2, 31, 0, 3, 22951, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41455, 0, 3, 31, 0, 3, 22952, 0, 0, 0, 0, '', 'Target Illidari Council Member');

-- SPELL Reflective Shield (41475)
DELETE FROM spell_script_names WHERE spell_id=41475;
INSERT INTO spell_script_names VALUES(41475, 'spell_illidari_council_reflective_shield');

-- SPELL Deadly Strike (41480)
DELETE FROM spell_script_names WHERE spell_id=41480;
INSERT INTO spell_script_names VALUES(41480, 'spell_illidari_council_deadly_strike');

-- SPELL Balance of Power (41341)
DELETE FROM spell_script_names WHERE spell_id=41341;
INSERT INTO spell_script_names VALUES(41341, 'spell_illidari_council_balance_of_power');

-- SPELL Empyreal Balance (41499)
DELETE FROM spell_script_names WHERE spell_id=41499;
INSERT INTO spell_script_names VALUES(41499, 'spell_illidari_council_empyreal_balance');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41499;
INSERT INTO conditions VALUES(13, 1, 41499, 0, 0, 31, 0, 3, 22949, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41499, 0, 1, 31, 0, 3, 22950, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41499, 0, 2, 31, 0, 3, 22951, 0, 0, 0, 0, '', 'Target Illidari Council Member');
INSERT INTO conditions VALUES(13, 1, 41499, 0, 3, 31, 0, 3, 22952, 0, 0, 0, 0, '', 'Target Illidari Council Member');

-- Illidan Stormrage <The Betrayer> (22917)
REPLACE INTO creature_template_addon VALUES (22917, 0, 0, 8, 4097, 0, '');
DELETE FROM creature_text WHERE entry=22917;
INSERT INTO creature_text VALUES (22917, 0, 0, 'Come, my minions. Deal with this traitor as he deserves!', 14, 0, 100, 0, 0, 11465, 0, 'Illidan SAY_ILLIDAN_MINION');
INSERT INTO creature_text VALUES (22917, 1, 0, 'Who shall be next to taste my blades?!', 14, 0, 100, 0, 0, 11473, 0, 'Illidan SAY_ILLIDAN_KILL');
INSERT INTO creature_text VALUES (22917, 1, 1, 'This is too easy!', 14, 0, 100, 0, 0, 11472, 0, 'Illidan SAY_ILLIDAN_KILL');
INSERT INTO creature_text VALUES (22917, 2, 0, 'I will not be touched by rabble such as you!', 14, 0, 100, 0, 0, 11479, 0, 'Illidan SAY_ILLIDAN_TAKEOFF');
INSERT INTO creature_text VALUES (22917, 3, 0, 'Behold the flames of Azzinoth!', 14, 0, 100, 0, 0, 11480, 0, 'Illidan SAY_ILLIDAN_SUMMONFLAMES');
INSERT INTO creature_text VALUES (22917, 4, 0, 'Stare into the eyes of the Betrayer!', 14, 0, 100, 0, 0, 11481, 0, 'Illidan SAY_ILLIDAN_EYE_BLAST');
INSERT INTO creature_text VALUES (22917, 5, 0, 'Behold the power... of the demon within!', 14, 0, 100, 0, 0, 11475, 0, 'Illidan SAY_ILLIDAN_MORPH');
INSERT INTO creature_text VALUES (22917, 6, 0, 'You''ve wasted too much time mortals, now you shall fall!', 14, 0, 100, 0, 0, 11474, 0, 'Illidan SAY_ILLIDAN_ENRAGE');
INSERT INTO creature_text VALUES (22917, 7, 0, 'I can feel your hatred.', 14, 0, 100, 0, 0, 11467, 0, 'Illidan SAY_ILLIDAN_TAUNT');
INSERT INTO creature_text VALUES (22917, 7, 1, 'Give in to your fear!', 14, 0, 100, 0, 0, 11468, 0, 'Illidan SAY_ILLIDAN_TAUNT');
INSERT INTO creature_text VALUES (22917, 7, 2, 'You know nothing of power!', 14, 0, 100, 0, 0, 11469, 0, 'Illidan SAY_ILLIDAN_TAUNT');
INSERT INTO creature_text VALUES (22917, 8, 0, 'Akama... your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.', 14, 0, 100, 1, 0, 11463, 0, 'Illidan SAY_ILLIDAN_AKAMA1');
INSERT INTO creature_text VALUES (22917, 9, 0, 'Boldly said. But I remain unconvinced.', 14, 0, 100, 1, 0, 11464, 0, 'Illidan SAY_ILLIDAN_AKAMA2');
INSERT INTO creature_text VALUES (22917, 10, 0, 'You are not prepared!', 14, 0, 100, 25, 0, 11466, 0, 'Illidan SAY_ILLIDAN_AKAMA3');
INSERT INTO creature_text VALUES (22917, 11, 0, 'Is this it, mortals? Is this all the fury you can muster?', 14, 0, 100, 396, 0, 11476, 0, 'Illidan SAY_ILLIDAN_MAIEV1');
INSERT INTO creature_text VALUES (22917, 12, 0, 'Maiev... How is this even possible?', 14, 0, 100, 396, 0, 11477, 0, 'Illidan SAY_ILLIDAN_MAIEV2');
INSERT INTO creature_text VALUES (22917, 13, 0, 'You have won... Maiev. But the huntress... is nothing without the hunt. You... are nothing... without me.', 14, 0, 100, 0, 0, 11478, 0, 'Illidan SAY_ILLIDAN_MAIEV3');
INSERT INTO creature_text VALUES (22917, 14, 0, 'Feel the hatred of ten thousand years!', 14, 0, 100, 0, 0, 11470, 0, 'Illidan SAY_ILLIDAN_FRENZY');
UPDATE creature_template SET unit_flags=768, speed_run=1.6, baseattacktime=1500, dmg_multiplier=70, mechanic_immune_mask=650854271, flags_extra=33|0x200000, AIName='', ScriptName='boss_illidan_stormrage' WHERE entry=22917;

-- Maiev Shadowsong (23197)
REPLACE INTO creature_template_addon VALUES (23197, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_text WHERE entry=23197;
INSERT INTO creature_text VALUES (23197, 0, 0, 'That is for Naisha!', 14, 0, 100, 0, 0, 11493, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT');
INSERT INTO creature_text VALUES (23197, 0, 1, 'Bleed as I have bled!', 14, 0, 100, 0, 0, 11494, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT');
INSERT INTO creature_text VALUES (23197, 0, 2, 'There shall be no prison for you this time!', 14, 0, 100, 0, 0, 11495, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT');
INSERT INTO creature_text VALUES (23197, 0, 3, 'Meet your end, demon!', 14, 0, 100, 0, 0, 11500, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT');
INSERT INTO creature_text VALUES (23197, 1, 0, 'Their fury pales before mine, Illidan. We have some unsettled business between us.', 14, 0, 100, 0, 0, 11491, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_ILLIDAN1');
INSERT INTO creature_text VALUES (23197, 2, 0, 'Ah, my long hunt is finally over. Today, Justice will be done!', 14, 0, 100, 0, 0, 11492, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_ILLIDAN2');
INSERT INTO creature_text VALUES (23197, 3, 0, 'It is finished. You are beaten.', 14, 0, 100, 0, 0, 11496, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_ILLIDAN3');
INSERT INTO creature_text VALUES (23197, 4, 0, 'He''s right. I feel nothing... I am... nothing.', 14, 0, 100, 0, 0, 11497, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_ILLIDAN4');
INSERT INTO creature_text VALUES (23197, 5, 0, 'Farewell, champions.', 14, 0, 100, 0, 0, 11498, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_ILLIDAN5');
UPDATE creature_template SET exp=1, unit_flags=0, baseattacktime=2000, dmg_multiplier=10, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=23197;
DELETE FROM smart_scripts WHERE entryorguid=23197 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=23197*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (23197, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On AI Init - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (23197, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - On Update - Talk');
INSERT INTO smart_scripts VALUES (23197, 0, 2, 0, 0, 0, 100, 0, 7000, 7000, 30000, 30000, 11, 41152, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - In Combat - Cast Throw Dagger');
INSERT INTO smart_scripts VALUES (23197, 0, 3, 0, 0, 0, 100, 0, 22000, 22000, 30000, 30000, 11, 40685, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - In Combat - Cast Shadow Strike');
INSERT INTO smart_scripts VALUES (23197, 0, 4, 5, 0, 0, 100, 0, 30000, 30000, 120000, 120000, 11, 40693, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - In Combat - Cast Cage Trap');
INSERT INTO smart_scripts VALUES (23197, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - In Combat - Talk');
INSERT INTO smart_scripts VALUES (23197, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 40694, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - In Combat - Cast Cage Trap Summon');
INSERT INTO smart_scripts VALUES (23197, 0, 7, 0, 72, 0, 100, 0, 5, 0, 0, 0, 135, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Do Action - Set Combat Dist');
INSERT INTO smart_scripts VALUES (23197, 0, 8, 0, 72, 0, 100, 0, 6, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Do Action - Set Combat Dist');
INSERT INTO smart_scripts VALUES (23197, 0, 9, 0, 2, 0, 100, 0, 0, 10, 20000, 20000, 11, 40409, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Between HP 0-10% - Cast Maiev Down');
INSERT INTO smart_scripts VALUES (23197, 0, 10, 0, 72, 0, 100, 0, 7, 0, 0, 0, 80, 23197*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Do Action - Set Script 9');
INSERT INTO smart_scripts VALUES (23197*100, 9, 0, 0, 0, 0, 100, 0, 27000, 27000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Talk');
INSERT INTO smart_scripts VALUES (23197*100, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Talk');
INSERT INTO smart_scripts VALUES (23197*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 41232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Cast Teleport Visual Only');
INSERT INTO smart_scripts VALUES (23197*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Set Visible false');
INSERT INTO smart_scripts VALUES (23197*100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 23089, 100, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (23197*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 19, 23089, 100, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (23197*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Maiev Shadowsong - Script9 - Despawn Self');

-- Flame Crash (23336)
REPLACE INTO creature_template_addon VALUES (23336, 0, 0, 0, 0, 0, '40836');
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', ScriptName='' WHERE entry=23336;

-- Parasitic Shadowfiend (23498)
REPLACE INTO creature_template_addon VALUES (23498, 0, 0, 0, 0, 0, '41913');
UPDATE creature_template SET unit_flags=0, flags_extra=256, AIName='SmartAI', ScriptName='' WHERE entry=23498;
DELETE FROM smart_scripts WHERE entryorguid=23498 AND source_type=0;
INSERT INTO smart_scripts VALUES (23498, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - On Reset - Set React State');
INSERT INTO smart_scripts VALUES (23498, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 80, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - On Reset - Attack Start');

-- Glaive Target (23448)
UPDATE creature SET phaseMask=3 WHERE id=23448 AND guid=52502;
UPDATE creature SET phaseMask=5 WHERE id=23448 AND guid=52503;
REPLACE INTO creature_template_addon VALUES (23448, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23448;

-- Illidan DB Target (23070)
UPDATE creature_template SET speed_run=0.9, unit_flags=33554432, flags_extra=130, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=23070;

-- Demon Fire (23069)
REPLACE INTO creature_template_addon VALUES (23069, 0, 0, 0, 0, 0, '40029');
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', ScriptName='' WHERE entry=23069;

-- Blaze (23259)
REPLACE INTO creature_template_addon VALUES (23259, 0, 0, 0, 0, 0, '40610');
UPDATE creature_template SET unit_flags=33554432, AIName='NullCreatureAI', ScriptName='' WHERE entry=23259;

-- Blade of Azzinoth (22996)
UPDATE creature_template SET unit_flags=768, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=22996;
DELETE FROM smart_scripts WHERE entryorguid=22996 AND source_type=0;
INSERT INTO smart_scripts VALUES (22996, 0, 0, 0, 60, 0, 100, 257, 3000, 3000, 0, 0, 11, 39855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - On Update - Cast Summon Tear of Azzinoth');
INSERT INTO smart_scripts VALUES (22996, 0, 1, 0, 17, 0, 100, 257, 0, 0, 0, 0, 11, 39857, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - Summoned Unit - Cast Tear of Azzinoth Summon Channel');
INSERT INTO smart_scripts VALUES (22996, 0, 2, 3, 72, 0, 100, 257, 2, 0, 0, 0, 11, 39873, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - Do Action - Cast Glaive Returns');
INSERT INTO smart_scripts VALUES (22996, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 3, 0, 11686, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - Do Action - Change Model');
INSERT INTO smart_scripts VALUES (22996, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - Do Action - Despawn self');
INSERT INTO smart_scripts VALUES (22996, 0, 5, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade of Azzinoth - On AI Init - Set React State');

-- Flame of Azzinoth (22997)
UPDATE creature_template SET dmgschool=2, dmg_multiplier=35, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=22997;
DELETE FROM smart_scripts WHERE entryorguid=22997 AND source_type=0;
INSERT INTO smart_scripts VALUES (22997, 0, 0, 1, 0, 0, 100, 0, 10000, 20000, 15000, 20000, 11, 40631, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - In Combat - Cast Flame Blast');
INSERT INTO smart_scripts VALUES (22997, 0, 1, 0, 61, 0, 50, 0, 0, 0, 0, 0, 86, 40637, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - In Combat - Cross Cast Blaze');
INSERT INTO smart_scripts VALUES (22997, 0, 2, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (22997, 0, 3, 4, 60, 0, 100, 257, 2000, 2000, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - On Update - Set React Aggressive');
INSERT INTO smart_scripts VALUES (22997, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - On Update - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (22997, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame of Azzinoth - On Death - Despawn');

-- Shadow Demon (23375)
REPLACE INTO creature_template_addon VALUES (23375, 0, 0, 0, 0, 0, '41079');
UPDATE creature_template SET speed_walk=0.5, speed_run=0.5, unit_flags=0, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=23375;
DELETE FROM smart_scripts WHERE entryorguid=23375 AND source_type=0;
INSERT INTO smart_scripts VALUES (23375, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Demon - On AI Init - Set React State');
INSERT INTO smart_scripts VALUES (23375, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 41081, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow Demon - On Update - Cast Find Target');
INSERT INTO smart_scripts VALUES (23375, 0, 2, 3, 31, 0, 100, 0, 41081, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Shadow Demon - Spell Hit Target - Store Target');
INSERT INTO smart_scripts VALUES (23375, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 138, 1000000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Shadow Demon - Spell Hit Target - Add threat');
INSERT INTO smart_scripts VALUES (23375, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Shadow Demon - Spell Hit Target - Move Point');
INSERT INTO smart_scripts VALUES (23375, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41083, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Shadow Demon - Spell Hit Target - Cast Spell Paralyze');
INSERT INTO smart_scripts VALUES (23375, 0, 6, 0, 60, 0, 100, 0, 500, 500, 500, 500, 11, 41082, 2, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Shadow Demon - Spell Hit Target - Cast Found Target');

-- Cage Trap Trigger (23292, 23293, 23294, 23295, 23296, 23297, 23298, 23299)
UPDATE creature_template SET faction=35, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry IN(23292, 23293, 23294, 23295, 23296, 23297, 23298, 23299);
DELETE FROM smart_scripts WHERE entryorguid IN(23292, 23293, 23294, 23295, 23296, 23297, 23298, 23299) AND source_type=0;
INSERT INTO smart_scripts VALUES (23292, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23293, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40707, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23294, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40708, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23295, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40709, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23296, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40710, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23297, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23298, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40712, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');
INSERT INTO smart_scripts VALUES (23299, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 40713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Trigger - On Reset - Cast Caged');

-- Cage Trap Disturb Trigger (23304)
UPDATE creature_template SET faction=35, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=23304;
DELETE FROM smart_scripts WHERE entryorguid=23304 AND source_type=0;
INSERT INTO smart_scripts VALUES (23304, 0, 0, 1, 38, 0, 100, 1, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Disturb Trigger - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (23304, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Disturb Trigger - On Data Set - Despawn Self');
INSERT INTO smart_scripts VALUES (23304, 0, 2, 0, 60, 1, 100, 0, 500, 500, 200, 200, 11, 40761, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cage Trap Disturb Trigger - On Update - Cast Cage Trap');

-- GO Cage Trap (185916)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=185916;
DELETE FROM smart_scripts WHERE entryorguid=185916 AND source_type=1;
INSERT INTO smart_scripts VALUES(185916, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 23304, 5, 0, 0, 0, 0, 0, "Cage Trap - On Gossip Hello - Set Data");

-- SPELL Draw Soul (40904)
DELETE FROM spell_script_names WHERE spell_id=40904;
INSERT INTO spell_script_names VALUES(40904, 'spell_illidan_draw_soul');

-- SPELL Parasitic Shadowfiend (41914, 41917)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41914, -41914, 41917, -41917);
DELETE FROM spell_script_names WHERE spell_id IN(41914, 41917);
INSERT INTO spell_script_names VALUES(41914, 'spell_illidan_parasitic_shadowfiend_trigger');
INSERT INTO spell_script_names VALUES(41917, 'spell_illidan_parasitic_shadowfiend');

-- SPELL Throw Glaive (39635, 39849)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(39635, 39849);
INSERT INTO conditions VALUES(13, 1, 39635, 0, 0, 31, 0, 3, 23448, 0, 0, 0, 0, '', 'Target Glaive Target');
INSERT INTO conditions VALUES(13, 1, 39635, 0, 0, 26, 0, 2, 0, 0, 0, 0, 0, '', 'Target In phase mask 2');
INSERT INTO conditions VALUES(13, 1, 39849, 0, 0, 31, 0, 3, 23448, 0, 0, 0, 0, '', 'Target Glaive Target');
INSERT INTO conditions VALUES(13, 1, 39849, 0, 0, 26, 0, 4, 0, 0, 0, 0, 0, '', 'Target In phase mask 4');
DELETE FROM spell_script_names WHERE spell_id IN(39635, 39849);
INSERT INTO spell_script_names VALUES(39635, 'spell_illidan_glaive_throw');
INSERT INTO spell_script_names VALUES(39849, 'spell_illidan_glaive_throw');

-- SPELL Glaive Returns (39873)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39873;
INSERT INTO conditions VALUES(13, 1, 39873, 0, 0, 31, 0, 3, 22917, 0, 0, 0, 0, '', 'Target Illidan Stormrage');

-- SPELL Eye Blast (39908)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(39908, -39908);
INSERT INTO spell_linked_spell VALUES (39908, 40017, 2, 'Illidan Stormrage - Eye blast');

-- SPELL Tear of Azzinoth Summon Channel (39857)
DELETE FROM spell_script_names WHERE spell_id=39857;
INSERT INTO spell_script_names VALUES(39857, 'spell_illidan_tear_of_azzinoth_summon_channel');

-- SPELL Shadow Prison (40647)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40647;
INSERT INTO conditions VALUES(13, 4, 40647, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
DELETE FROM spell_script_names WHERE spell_id=40647;
INSERT INTO spell_script_names VALUES(40647, 'spell_illidan_shadow_prison');

-- SPELL Demon Transform 1 (40511)
-- SPELL Demon Transform 2 (40398)
-- SPELL Demon Transform 3 (40398)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(40398, -40398, 40511, -40511, 40510, -40510);
DELETE FROM spell_script_names WHERE spell_id IN(40511, 40398, 40510);
INSERT INTO spell_script_names VALUES(40511, 'spell_illidan_demon_transform1');
INSERT INTO spell_script_names VALUES(40398, 'spell_illidan_demon_transform2');

-- SPELL Flame Burst (41126)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41126, -41126);
DELETE FROM spell_script_names WHERE spell_id=41126;
INSERT INTO spell_script_names VALUES(41126, 'spell_illidan_flame_burst');

-- SPELL Find Target (41081)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41081, -41081);
DELETE FROM spell_script_names WHERE spell_id=41081;
INSERT INTO spell_script_names VALUES(41081, 'spell_gen_select_target_count_15_1');

-- SPELL Found Target (41082)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(41082, -41082);
DELETE FROM spell_script_names WHERE spell_id=41082;
INSERT INTO spell_script_names VALUES(41082, 'spell_illidan_found_target');

-- SPELL Cage Trap (40693)
-- SPELL Caged (40704, 40707, 40708, 40709, 40710, 40711, 40712, 40713)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(40693, 40704, 40707, 40708, 40709, 40710, 40711, 40712, 40713);
INSERT INTO conditions VALUES(13, 1, 40693, 0, 0, 31, 0, 3, 23197, 0, 0, 0, 0, '', 'Target Maiev Shadowsong');
INSERT INTO conditions VALUES(13, 1, 40704, 0, 0, 31, 0, 3, 23293, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40707, 0, 0, 31, 0, 3, 23294, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40708, 0, 0, 31, 0, 3, 23295, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40709, 0, 0, 31, 0, 3, 23296, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40710, 0, 0, 31, 0, 3, 23297, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40711, 0, 0, 31, 0, 3, 23298, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40712, 0, 0, 31, 0, 3, 23299, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
INSERT INTO conditions VALUES(13, 1, 40713, 0, 0, 31, 0, 3, 23292, 0, 0, 0, 0, '', 'Target Illidan Stormrage');

-- SPELL Cage Trap (40761)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40761;
INSERT INTO conditions VALUES(13, 1, 40761, 0, 0, 31, 0, 3, 22917, 0, 0, 0, 0, '', 'Target Illidan Stormrage');
DELETE FROM spell_script_names WHERE spell_id=40761;
INSERT INTO spell_script_names VALUES(40761, 'spell_illidan_cage_trap');

-- SPELL Cage Trap (40760)
DELETE FROM spell_script_names WHERE spell_id=40760;
INSERT INTO spell_script_names VALUES(40760, 'spell_illidan_cage_trap_stun');

-- SPELL Teleport Maiev (41221)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41221;
INSERT INTO conditions VALUES(13, 3, 41221, 0, 0, 31, 0, 3, 23197, 0, 0, 0, 0, '', 'Target Maiev Shadowsong');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Akama before Illidan (23089)
DELETE FROM creature_text WHERE entry IN(23089, 23410, 23411);
INSERT INTO creature_text VALUES (23410, 0, 0, 'You are not alone, Akama.', 12, 0, 100, 0, 0, 0, 0, 'Spirit of Udalo SAY_UDALO');
INSERT INTO creature_text VALUES (23411, 0, 0, 'Your people will always be with you!', 12, 0, 100, 0, 0, 0, 0, 'Spirit of Olum SAY_OLUM');
INSERT INTO creature_text VALUES (23089, 0, 0, 'This door is all that stands between us and the Betrayer. Stand aside, friends.', 12, 0, 100, 1, 0, 0, 0, 'Akama SAY_AKAMA_DOORS');
INSERT INTO creature_text VALUES (23089, 1, 0, 'I cannot do this alone...', 12, 0, 100, 0, 0, 0, 0, 'Akama SAY_AKAMA_FAIL');
INSERT INTO creature_text VALUES (23089, 2, 0, 'Be wary friends, The Betrayer meditates in the court just beyond.', 12, 0, 100, 0, 0, 11388, 0, 'Akama SAY_AKAMA_BEWARE');
INSERT INTO creature_text VALUES (23089, 3, 0, 'I''ll deal with these mongrels. Strike now, friends! Strike at the betrayer!', 14, 0, 100, 0, 0, 11390, 0, 'Akama SAY_AKAMA_LEAVE');
INSERT INTO creature_text VALUES (23089, 4, 0, 'We''ve come to end your reign, Illidan. My people and all of Outland shall be free!', 14, 0, 100, 25, 0, 11389, 0, 'Akama SAY_AKAMA_ILLIDAN1');
INSERT INTO creature_text VALUES (23089, 5, 0, 'The time has come! The moment is at hand!', 14, 0, 100, 15, 0, 11380, 0, 'Akama SAY_AKAMA_ILLIDAN2');
INSERT INTO creature_text VALUES (23089, 6, 0, 'The Light will fill these dismal halls once again. I swear it.', 14, 0, 100, 0, 0, 11387, 0, 'Akama SAY_AKAMA_ILLIDAN3');
UPDATE creature SET position_x=652.413, position_y=305.68, position_z=271.69, orientation=0.0 WHERE id=23089;
UPDATE creature_template SET dmg_multiplier=15, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='npc_akama_illidan' WHERE entry=23089;
DELETE FROM gossip_menu WHERE entry=8713;
INSERT INTO gossip_menu VALUES (8713, 10835),(8713, 10960);
DELETE FROM gossip_menu_option WHERE menu_id=8713;
INSERT INTO gossip_menu_option VALUES (8713, 0, 0, 'I''m ready, Akama.', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8713, 1, 0, 'We''re ready to face Illidan.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=8713;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8713;
INSERT INTO conditions VALUES(14, 8713, 10960, 0, 0, 13, 0, 8, 3, 2, 1, 0, 0, '', 'If BossState of Data 8 equals NOT_STARTED');
INSERT INTO conditions VALUES(14, 8713, 10835, 0, 0, 13, 0, 8, 3, 2, 0, 0, 0, '', 'If BossState of Data 8 equals DONE');
INSERT INTO conditions VALUES(15, 8713, 0, 0, 0, 13, 0, 8, 3, 2, 1, 0, 0, '', 'If BossState of Data 8 equals NOT_STARTED');
INSERT INTO conditions VALUES(15, 8713, 1, 0, 0, 13, 0, 8, 3, 2, 0, 0, 0, '', 'If BossState of Data 8 equals DONE');
DELETE FROM script_waypoint WHERE entry=23089;
INSERT INTO script_waypoint VALUES (23089, 1, 656.989, 298.44, 271.688, 0, 'Akama, Illidan encounter'),(23089, 2, 665.184, 279.114, 271.688, 0, 'Akama, Illidan encounter'),(23089, 3, 674.245, 260.172, 271.688, 0, 'Akama, Illidan encounter'),(23089, 4, 682.958, 245.027, 271.667, 0, 'Akama, Illidan encounter'),(23089, 5, 691.47, 235.471, 271.688, 0, 'Akama, Illidan encounter'),(23089, 6, 697.803, 230.82, 271.923, 0, 'Akama, Illidan encounter'),(23089, 7, 700.379, 230.083, 272.998, 0, 'Akama, Illidan encounter'),(23089, 8, 705.817, 230.424, 275.019, 0, 'Akama, Illidan encounter'),(23089, 9, 709.684, 231.275, 276.258, 0, 'Akama, Illidan encounter'),
(23089, 10, 718.096, 235.989, 279.875, 0, 'Akama, Illidan encounter'),(23089, 11, 724.56, 241.495, 284.14, 0, 'Akama, Illidan encounter'),(23089, 12, 731.175, 249.645, 290.885, 0, 'Akama, Illidan encounter'),(23089, 13, 735.246, 255.338, 295.176, 0, 'Akama, Illidan encounter'),(23089, 14, 738.426, 260.502, 298.704, 0, 'Akama, Illidan encounter'),(23089, 15, 741.427, 266.826, 302.175, 0, 'Akama, Illidan encounter'),(23089, 16, 744.435, 274.537, 306.819, 0, 'Akama, Illidan encounter'),(23089, 17, 745.421, 277.893, 307.674, 0, 'Akama, Illidan encounter'),(23089, 18, 747.655, 288.147, 310.838, 0, 'Akama, Illidan encounter'),
(23089, 19, 748.199, 290.901, 311.853, 0, 'Akama, Illidan encounter'),(23089, 20, 755.889, 304.118, 312.18, 0, 'Akama, Illidan encounter'),(23089, 21, 769.999, 304.355, 312.292, 0, 'Akama, Illidan encounter'),(23089, 22, 779.678, 304.507, 319.692, 0, 'Akama, Illidan encounter'),(23089, 23, 796.466, 304.047, 319.76, 0, 'Akama, Illidan encounter'),(23089, 24, 795.761, 288.92, 319.97, 0, 'Akama, Illidan encounter'),(23089, 25, 795.608, 278.421, 328.551, 0, 'Akama, Illidan encounter'),(23089, 26, 795.273, 271.433, 334.264, 0, 'Akama, Illidan encounter'),(23089, 27, 794.244, 262.737, 341.376, 0, 'Akama, Illidan encounter'),
(23089, 28, 791.058, 254.048, 341.464, 0, 'Akama, Illidan encounter'),(23089, 29, 783.995, 247.466, 341.464, 0, 'Akama, Illidan encounter'),(23089, 30, 775.029, 242.006, 347.686, 0, 'Akama, Illidan encounter'),(23089, 31, 766.372, 238.074, 353.647, 0, 'Akama, Illidan encounter'),(23089, 32, 751.664, 238.933, 353.106, 0, 'Akama, Illidan encounter');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(41268, 41269, 41271);
INSERT INTO conditions VALUES(13, 1, 41268, 0, 0, 31, 0, 3, 23412, 0, 0, 0, 0, '', 'Target Illidan Door Trigger');
INSERT INTO conditions VALUES(13, 1, 41269, 0, 0, 31, 0, 3, 23412, 0, 0, 0, 0, '', 'Target Illidan Door Trigger');
INSERT INTO conditions VALUES(13, 1, 41271, 0, 0, 31, 0, 3, 23412, 0, 0, 0, 0, '', 'Target Illidan Door Trigger');
UPDATE creature_template SET scale=1, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=23412;


-- Aqueous Formation / Pathing
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(12853, 12854) AND id=22875;
DELETE FROM creature_formations WHERE leaderGUID=12869;
INSERT INTO creature_formations VALUES (12869, 12869, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (12869, 12853, 10, 270, 2, 1, 3);
INSERT INTO creature_formations VALUES (12869, 12854, 10, 90, 2, 1, 3);

UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(12851, 12852) AND id=22875;
DELETE FROM creature_formations WHERE leaderGUID=12866;
INSERT INTO creature_formations VALUES (12866, 12866, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (12866, 12852, 10, 270, 2, 1, 3);
INSERT INTO creature_formations VALUES (12866, 12851, 10, 90, 2, 1, 3);

-- Spirit of Olum (23411)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23411;
DELETE FROM smart_scripts WHERE entryorguid=23411 AND source_type=0;
INSERT INTO smart_scripts VALUES (23411, 0, 0, 0, 62, 0, 100, 0, 8750, 1, 0, 0, 85, 41566, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spirit of Olum - On Gossip Select - Invoker Cast');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8750;
INSERT INTO conditions VALUES(15, 8750, 1, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'If BossState of Data 1 equals DONE');

-- Areatrigger Before Teron Gorefiend
DELETE FROM areatrigger_scripts WHERE entry=4665;
INSERT INTO areatrigger_scripts VALUES (4665, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=4665 AND source_type=2;
INSERT INTO smart_scripts VALUES (4665, 2, 0, 0, 46, 0, 100, 1, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 12843, 22871, 0, 0, 0, 0, 0, "Area Trigger - On Trigger - Talk");

-- Dead NPCs in Hall of Anguish
DELETE FROM creature_addon WHERE guid IN(53210, 53710, 53586, 53229, 53711);
INSERT INTO creature_addon VALUES (53210, 0, 0, 0, 4097, 0, '35357');
INSERT INTO creature_addon VALUES (53710, 0, 0, 0, 4097, 0, '35357');
INSERT INTO creature_addon VALUES (53586, 0, 0, 0, 4097, 0, '35357');
INSERT INTO creature_addon VALUES (53229, 0, 0, 0, 4097, 0, '35357');
INSERT INTO creature_addon VALUES (53711, 0, 0, 0, 4097, 0, '35357');

-- Black Temple Captive (22886)
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=22886;
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=22886;

-- Promenade Sentinel path correction
DELETE FROM waypoint_data WHERE id IN (128840, 128880);
INSERT INTO waypoint_data VALUES (128840, 1, 761.185, 161.6, 218.432, 0, 0, 0, 0, 100, 0),(128840, 2, 778.767, 173.039, 218.675, 0, 0, 0, 0, 100, 0),(128840, 3, 788.668, 173.363, 212.469, 0, 0, 0, 0, 100, 0),(128840, 4, 800.007, 173.02, 204.767, 0, 0, 0, 0, 100, 0),
(128840, 5, 812.789, 149.183, 204.768, 0, 0, 0, 0, 100, 0),(128840, 6, 799.339, 126.122, 204.768, 0, 0, 0, 0, 100, 0),(128840, 7, 788.835, 125.638, 212.158, 0, 0, 0, 0, 100, 0),(128840, 8, 779.322, 125.988, 218.75, 0, 0, 0, 0, 100, 0),(128840, 9, 760.933, 144.156, 218.486, 0, 0, 0, 0, 100, 0),
(128880, 1, 548.162, 222.53, 271.903, 4.71239, 33000, 0, 0, 100, 0),(128880, 2, 548.036, 215.007, 272.212, 0, 0, 0, 0, 100, 0),(128880, 3, 548.175, 204.602, 265.163, 0, 0, 0, 0, 100, 0),(128880, 4, 548.37, 193.937, 258.796, 0, 0, 0, 0, 100, 0),(128880, 5, 548.239, 176.438, 258.71, 0, 0, 0, 0, 100, 0),
(128880, 6, 548.37, 193.937, 258.796, 0, 0, 0, 0, 100, 0),(128880, 7, 548.094, 205.504, 265.788, 0, 0, 0, 0, 100, 0),(128880, 8, 548.036, 215.007, 272.212, 0, 0, 0, 0, 100, 0);

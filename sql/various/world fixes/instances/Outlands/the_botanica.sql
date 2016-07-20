
UPDATE creature SET spawntimesecs=86400 WHERE map=553 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Tempest-Forge Peacekeeper (18405, 21578)
DELETE FROM creature_text WHERE entry=18405;
INSERT INTO creature_text VALUES (18405, 0, 0, "Protect the Botanica at all costs!", 14, 0, 100, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18405;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21578;
DELETE FROM smart_scripts WHERE entryorguid=18405 AND source_type=0;
INSERT INTO smart_scripts VALUES (18405, 0, 0, 0, 4, 0, 40, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (18405, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 11, 34785, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast Spell Arcane Volley');
INSERT INTO smart_scripts VALUES (18405, 0, 2, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 11, 34791, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast Spell Arcane Explosion');

-- Bloodwarder Protector (17993, 21548)
DELETE FROM creature_text WHERE entry=17993;
INSERT INTO creature_text VALUES (17993, 0, 0, "Help! Someone help us!", 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Protector');
INSERT INTO creature_text VALUES (17993, 1, 0, "Get out of here, there are too many of them! Escape while you can!", 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Protector');
UPDATE creature_template SET pickpocketloot=17993, AIName='SmartAI', ScriptName='' WHERE entry=17993;
UPDATE creature_template SET pickpocketloot=17993, AIName='', ScriptName='' WHERE entry=21548;
DELETE FROM smart_scripts WHERE entryorguid=17993 AND source_type=0;
INSERT INTO smart_scripts VALUES (17993, 0, 0, 0, 0, 0, 100, 1, 2000, 4000, 0, 0, 11, 34784, 0, 0, 0, 0, 0, 26, 20, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast Spell Intervene');
INSERT INTO smart_scripts VALUES (17993, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 9000, 11000, 11, 29765, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast Spell Crystal Strike');
INSERT INTO smart_scripts VALUES (17993, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 35399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast Spell Spell Reflection');
DELETE FROM creature_addon WHERE guid IN(83066, 83067); -- Replace with 2 frayers
DELETE FROM creature WHERE guid IN(83066, 83067);
INSERT INTO creature VALUES (83066, 17993, 553, 3, 1, 0, 1, -165.143, 391.979, -17.7002, 1.58384, 86400, 0, 0, 21881, 3155, 0, 0, 0, 0);
INSERT INTO creature VALUES (83067, 17993, 553, 3, 1, 0, 1, -159.188, 391.486, -17.7415, 1.61133, 86400, 0, 0, 21881, 3155, 0, 0, 0, 0);
DELETE FROM smart_scripts WHERE entryorguid IN(-83066, -83067) AND source_type=0;
INSERT INTO smart_scripts VALUES (-83066, 0, 0, 1, 10, 0, 100, 1, 0, 90, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On OOC LoS - Talk');
INSERT INTO smart_scripts VALUES (-83066, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -162.19, 471.40, -17.82, 0, 'Bloodwarder Protector - On OOC LoS - Move To Pos');
INSERT INTO smart_scripts VALUES (-83066, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2500, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On OOC LoS - Create Timed Event');
INSERT INTO smart_scripts VALUES (-83066, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Timed Event - Cast Spell Suicide');
INSERT INTO smart_scripts VALUES (-83066, 0, 4, 5, 37, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On AI Init - Set Unit Flag');
INSERT INTO smart_scripts VALUES (-83066, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 136, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On AI Init - Set Sight Distance');
INSERT INTO smart_scripts VALUES (-83067, 0, 0, 1, 10, 0, 100, 1, 0, 90, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On OOC LoS - Talk');
INSERT INTO smart_scripts VALUES (-83067, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -162.19, 471.40, -17.82, 0, 'Bloodwarder Protector - On OOC LoS - Move To Pos');
INSERT INTO smart_scripts VALUES (-83067, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 2500, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On OOC LoS - Create Timed Event');
INSERT INTO smart_scripts VALUES (-83067, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 7, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Timed Event - Cast Spell Suicide');
INSERT INTO smart_scripts VALUES (-83067, 0, 4, 5, 37, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On AI Init - Set Unit Flag');
INSERT INTO smart_scripts VALUES (-83067, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 136, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On AI Init - Set Sight Distance');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(-83066, -83067);
INSERT INTO conditions VALUES(22, 1, -83066, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Requires Player to run event');
INSERT INTO conditions VALUES(22, 1, -83067, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Requires Player to run event');

-- Bloodwarder Greenkeeper (18419, 21546)
UPDATE creature_template SET pickpocketloot=18419, AIName='SmartAI', ScriptName='' WHERE entry=18419;
UPDATE creature_template SET pickpocketloot=18419, AIName='', ScriptName='' WHERE entry=21546;
DELETE FROM smart_scripts WHERE entryorguid=18419 AND source_type=0;
INSERT INTO smart_scripts VALUES (18419, 0, 0, 0, 9, 0, 100, 0, 0, 5, 10000, 10000, 11, 34800, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - Within Range 0-5yd - Cast Impending Coma');
INSERT INTO smart_scripts VALUES (18419, 0, 1, 0, 0, 0, 100, 2, 0, 1000, 3000, 3000, 11, 34798, 64, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - In Combat - Cast Greenkeeper''s Fury');
INSERT INTO smart_scripts VALUES (18419, 0, 2, 0, 0, 0, 100, 4, 0, 1000, 3000, 3000, 11, 39121, 64, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - In Combat - Cast Greenkeeper''s Fury');
INSERT INTO smart_scripts VALUES (18419, 0, 3, 0, 13, 0, 100, 2, 15000, 15000, 0, 0, 11, 34797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - Victim Casting - Cast Nature Shock');
INSERT INTO smart_scripts VALUES (18419, 0, 4, 0, 13, 0, 100, 4, 15000, 15000, 0, 0, 11, 39120, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - Victim Casting - Cast Nature Shock');

-- Bloodwarder Mender (19633, 21547)
UPDATE creature_template SET pickpocketloot=19633, AIName='SmartAI', ScriptName='' WHERE entry=19633;
UPDATE creature_template SET pickpocketloot=19633, AIName='', ScriptName='' WHERE entry=21547;
DELETE FROM smart_scripts WHERE entryorguid=19633 AND source_type=0;
INSERT INTO smart_scripts VALUES (19633, 0, 0, 0, 60, 0, 100, 0, 0, 0, 1800000, 1800000, 11, 34809, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - On Update - Cast Holy Fury');
INSERT INTO smart_scripts VALUES (19633, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2000, 3000, 11, 17194, 64, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (19633, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 11, 17287, 64, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (19633, 0, 3, 0, 14, 0, 100, 0, 5000, 35, 6000, 6000, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - Friendly HP Missing - Cast Greater Heal');

-- Bloodwarder Falconer (17994, 21545)
DELETE FROM creature_text WHERE entry=17994;
INSERT INTO creature_text VALUES (17994, 0, 0, "Kill $N!", 14, 0, 100, 0, 0, 0, 0, 'Bloodwarder Falconer');
INSERT INTO creature_text VALUES (17994, 0, 1, "Do as I say, Fly!", 12, 0, 100, 0, 0, 0, 0, 'Bloodwarder Falconer');
UPDATE creature_template SET pickpocketloot=17994, AIName='SmartAI', ScriptName='' WHERE entry=17994;
UPDATE creature_template SET pickpocketloot=17994, AIName='', ScriptName='' WHERE entry=21545;
DELETE FROM smart_scripts WHERE entryorguid=17994 AND source_type=0;
INSERT INTO smart_scripts VALUES (17994, 0, 0, 1, 0, 0, 100, 0, 2000, 4000, 15000, 15000, 64, 1, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Store Target');
INSERT INTO smart_scripts VALUES (17994, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 34852, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Cast Spell Call of the Falcon');
INSERT INTO smart_scripts VALUES (17994, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Talk');
INSERT INTO smart_scripts VALUES (17994, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 22000, 25000, 11, 31567, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Cast Spell Deterrence');
INSERT INTO smart_scripts VALUES (17994, 0, 4, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 11, 34879, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Cast Spell Multi-Shot');
INSERT INTO smart_scripts VALUES (17994, 0, 5, 0, 2, 0, 100, 0, 0, 5, 10000, 10000, 11, 32908, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Cast Spell Wing Clip');

-- SPELL Call of the Falcon (34852)
DELETE FROM spell_script_names WHERE spell_id=34852;
INSERT INTO spell_script_names VALUES(34852, 'spell_botanica_call_of_the_falcon');

-- Bloodfalcon (18155, 21544)
DELETE FROM pickpocketing_loot_template WHERE entry=18155;
UPDATE creature_template SET pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=18155;
UPDATE creature_template SET pickpocketloot=0, AIName='', ScriptName='' WHERE entry=21544;
DELETE FROM smart_scripts WHERE entryorguid=18155 AND source_type=0;
INSERT INTO smart_scripts VALUES (18155, 0, 0, 0, 9, 0, 100, 0, 8, 25, 10000, 10000, 11, 32323, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodfalcon - Within Range 8-25yd - Cast Charge');
INSERT INTO smart_scripts VALUES (18155, 0, 1, 0, 13, 0, 100, 0, 15000, 15000, 0, 0, 11, 18144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodfalcon - Victim Casting - Cast Swoop');
INSERT INTO smart_scripts VALUES (18155, 0, 2, 0, 0, 0, 100, 0, 1000, 6000, 20000, 25000, 11, 34856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodfalcon - In Combat - Cast Bloodburn');

-- Bloodwarder Steward (18404, 21549)
UPDATE creature_template SET pickpocketloot=18404, AIName='SmartAI', ScriptName='' WHERE entry=18404;
UPDATE creature_template SET pickpocketloot=18404, AIName='', ScriptName='' WHERE entry=21549;
DELETE FROM smart_scripts WHERE entryorguid=18404 AND source_type=0;
INSERT INTO smart_scripts VALUES (18404, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 15000, 20000, 11, 34821, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Steward - In Combat - Cast Arcane Flurry');

-- Greater Frayer (19557, 21555)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19557;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21555;
DELETE FROM smart_scripts WHERE entryorguid=19557 AND source_type=0;
INSERT INTO smart_scripts VALUES (19557, 0, 0, 0, 0, 0, 100, 2, 0, 0, 6000, 10000, 11, 34644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Frayer - In Combat - Cast Lash');
INSERT INTO smart_scripts VALUES (19557, 0, 1, 0, 0, 0, 100, 4, 0, 0, 6000, 10000, 11, 39122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greater Frayer - In Combat - Cast Lash');

-- Sunseeker Researcher (18421, 21577)
UPDATE creature_template SET pickpocketloot=18421, AIName='SmartAI', ScriptName='' WHERE entry=18421;
UPDATE creature_template SET pickpocketloot=18421, AIName='', ScriptName='' WHERE entry=21577;
DELETE FROM smart_scripts WHERE entryorguid=18421 AND source_type=0;
INSERT INTO smart_scripts VALUES (18421, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 34355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Poison Shield');
INSERT INTO smart_scripts VALUES (18421, 0, 1, 0, 0, 0, 70, 0, 2000, 2000, 10000, 14000, 11, 34352, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Mind Shock');
INSERT INTO smart_scripts VALUES (18421, 0, 2, 0, 0, 0, 70, 0, 5000, 5000, 10000, 14000, 11, 34353, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (18421, 0, 3, 0, 0, 0, 70, 0, 8000, 8000, 10000, 14000, 11, 34354, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Flame Shock');

-- SPELL Poison Shield (34355)
REPLACE INTO spell_proc_event VALUES (34355, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3000);

-- Sunseeker Chemist (19486, 21572)
UPDATE creature_template SET pickpocketloot=19486, AIName='SmartAI', ScriptName='' WHERE entry=19486;
UPDATE creature_template SET pickpocketloot=19486, AIName='', ScriptName='' WHERE entry=21572;
DELETE FROM smart_scripts WHERE entryorguid=19486 AND source_type=0;
INSERT INTO smart_scripts VALUES (19486, 0, 0, 0, 0, 0, 100, 2, 2000, 4000, 12000, 16000, 11, 34359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast Fire Breath Potion');
INSERT INTO smart_scripts VALUES (19486, 0, 1, 0, 0, 0, 100, 4, 2000, 4000, 12000, 16000, 11, 39128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast Fire Breath Potion');
INSERT INTO smart_scripts VALUES (19486, 0, 2, 0, 0, 0, 100, 2, 8000, 10000, 12000, 16000, 11, 34358, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast Vial of Poison');
INSERT INTO smart_scripts VALUES (19486, 0, 3, 0, 0, 0, 100, 4, 8000, 10000, 12000, 16000, 11, 39127, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast Vial of Poison');

-- Sunseeker Botanist (18422, 21570)
UPDATE creature_template SET pickpocketloot=18422, AIName='SmartAI', ScriptName='' WHERE entry=18422;
UPDATE creature_template SET pickpocketloot=18422, AIName='', ScriptName='' WHERE entry=21570;
DELETE FROM smart_scripts WHERE entryorguid=18422 AND source_type=0;
INSERT INTO smart_scripts VALUES (18422, 0, 0, 0, 14, 0, 100, 2, 2000, 40, 12000, 16000, 11, 34361, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - Friendly Missing Health - Cast Regrowth');
INSERT INTO smart_scripts VALUES (18422, 0, 1, 0, 14, 0, 100, 4, 2000, 40, 12000, 16000, 11, 39125, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - Friendly Missing Health - Cast Regrowth');
INSERT INTO smart_scripts VALUES (18422, 0, 2, 0, 0, 0, 100, 2, 5000, 7000, 20000, 20000, 11, 34254, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - In Combat - Cast Rejuvenate Plant');
INSERT INTO smart_scripts VALUES (18422, 0, 3, 0, 0, 0, 100, 4, 5000, 7000, 20000, 20000, 11, 39126, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - In Combat - Cast Rejuvenate Plant');
INSERT INTO smart_scripts VALUES (18422, 0, 4, 0, 0, 0, 100, 0, 3000, 5000, 20000, 20000, 11, 34350, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - In Combat - Cast Nautre''s Rage');

-- SPELL Nautre's Rage (34350)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=34350;
INSERT INTO conditions VALUES(13, 7, 34350, 0, 0, 31, 0, 3, 19557, 0, 0, 0, 0, '', 'Target Greater Frayer');

-- SPELL Rejuvenate Plant (34254)
-- SPELL Rejuvenate Plant (39126)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(34254, 39126);
INSERT INTO conditions VALUES(13, 1, 34254, 0, 0, 31, 0, 3, 19557, 0, 0, 0, 0, '', 'Target Greater Frayer');
INSERT INTO conditions VALUES(13, 1, 39126, 0, 0, 31, 0, 3, 19557, 0, 0, 0, 0, '', 'Target Greater Frayer');

-- Sunseeker Geomancer (18420, 21574)
UPDATE creature_template SET pickpocketloot=18420, mechanic_immune_mask=1537, AIName='SmartAI', ScriptName='' WHERE entry=18420;
UPDATE creature_template SET pickpocketloot=18420, mechanic_immune_mask=1537, AIName='', ScriptName='' WHERE entry=21574;
DELETE FROM smart_scripts WHERE entryorguid IN(18420, -83035, -83056) AND source_type=0;
INSERT INTO smart_scripts VALUES (-83035, 0, 0, 0, 1, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 34167, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - Out of Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (-83035, 0, 1, 0, 1, 0, 100, 0, 17000, 17000, 30000, 30000, 11, 34169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (-83035, 0, 2, 0, 0, 0, 100, 1, 4000, 7000, 0, 0, 11, 35265, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (-83035, 0, 3, 0, 0, 0, 100, 0, 8000, 10000, 8000, 12000, 11, 35124, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (-83056, 0, 0, 0, 1, 0, 100, 0, 2000, 2000, 30000, 30000, 11, 34183, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - Out of Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (-83056, 0, 1, 0, 1, 0, 100, 0, 17000, 17000, 30000, 30000, 11, 34185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (-83056, 0, 2, 0, 0, 0, 100, 1, 4000, 7000, 0, 0, 11, 35265, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (-83056, 0, 3, 0, 0, 0, 100, 0, 8000, 10000, 8000, 12000, 11, 35124, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Geomancer - In Combat - Cast Arcane Explosion');

-- SPELL Blizzard (34167)
-- SPELL Blizzard (34183)
-- SPELL Rain of Fire (34169)
-- SPELL Rain of Fire (34185)
DELETE FROM spell_target_position WHERE id IN(34167, 34169, 34183, 34185);
INSERT INTO spell_target_position VALUES (34167, 0, 553, 156.0, 435.74, -6.76, 0);
INSERT INTO spell_target_position VALUES (34169, 0, 553, 156.0, 435.74, -6.76, 0);
INSERT INTO spell_target_position VALUES (34183, 0, 553, 102.1, 489.70, -6.74, 0);
INSERT INTO spell_target_position VALUES (34185, 0, 553, 102.1, 489.70, -6.74, 0);

-- Frayer (18587, 21552)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18587;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21552;
DELETE FROM smart_scripts WHERE entryorguid=18587 AND source_type=0;
INSERT INTO smart_scripts VALUES (18587, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 34201, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frayer - Out of Combat - Cast Shift Form');

-- SPELL Shift Form (34201)
DELETE FROM spell_script_names WHERE spell_id=34201;
INSERT INTO spell_script_names VALUES(34201, 'spell_botanica_shift_form');

-- Sunseeker Researcher (18421, 21577)
UPDATE creature_template SET pickpocketloot=18421, AIName='SmartAI', ScriptName='' WHERE entry=18421;
UPDATE creature_template SET pickpocketloot=18421, AIName='', ScriptName='' WHERE entry=21577;
DELETE FROM smart_scripts WHERE entryorguid=18421 AND source_type=0;
INSERT INTO smart_scripts VALUES (18421, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 34355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Poison Shield');
INSERT INTO smart_scripts VALUES (18421, 0, 1, 0, 0, 0, 70, 0, 2000, 2000, 10000, 14000, 11, 34352, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Mind Shock');
INSERT INTO smart_scripts VALUES (18421, 0, 2, 0, 0, 0, 70, 0, 5000, 5000, 10000, 14000, 11, 34353, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (18421, 0, 3, 0, 0, 0, 70, 0, 8000, 8000, 10000, 14000, 11, 34354, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Flame Shock');

-- World Trigger (Friendly + Invis Man) (18721)
UPDATE creature_template SET InhabitType=4 WHERE entry=18721;
DELETE FROM creature WHERE id=18721 AND map=553;
INSERT INTO creature VALUES (NULL, 18721, 553, 3, 1, 0, 0, -18.2439, 510.529, 1.55322, 2.2122, 300, 0, 0, 4121, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 18721, 553, 3, 1, 0, 0, 19.8099, 600.293, -7.91073, 0.162296, 300, 0, 0, 4121, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 18721, 553, 3, 1, 0, 0, -1.35389, 510.222, 1.95983, 2.80125, 300, 0, 0, 4121, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 18721, 553, 3, 1, 0, 0, -10.3133, 600.464, -7.63075, 4.69012, 300, 0, 0, 4121, 0, 0, 0, 0, 0);

-- SPELL Crystal Channel (34156)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(34156);
INSERT INTO conditions VALUES(13, 1, 34156, 0, 0, 31, 0, 3, 18721, 0, 0, 0, 0, '', 'Target World Trigger');

-- Sunseeker Channeler (19505, 21571)
UPDATE creature_template SET pickpocketloot=19505, AIName='SmartAI', ScriptName='' WHERE entry=19505;
UPDATE creature_template SET pickpocketloot=19505, AIName='', ScriptName='' WHERE entry=21571;
DELETE FROM smart_scripts WHERE entryorguid=19505 AND source_type=0;
INSERT INTO smart_scripts VALUES (19505, 0, 0, 0, 1, 0, 100, 0, 5000, 20000, 30000, 30000, 11, 34156, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Channeler - Out of Combat - Cast Crystal Channel');
INSERT INTO smart_scripts VALUES (19505, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 20000, 24000, 11, 34222, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Channeler - In Combat - Cast Sunseeker Blessing');
INSERT INTO smart_scripts VALUES (19505, 0, 2, 0, 0, 0, 100, 0, 12000, 15000, 30000, 34000, 11, 34634, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Channeler - In Combat - Cast Sunseeker Aura');
INSERT INTO smart_scripts VALUES (19505, 0, 3, 0, 0, 0, 100, 0, 2000, 10000, 15000, 24000, 11, 34637, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Channeler - In Combat - Cast Soul Channel');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=19505;
INSERT INTO conditions VALUES(22, 1, 19505, 0, 0, 29, 1, 18721, 30, 0, 0, 0, 0, '', 'Requires World Trigger in 30yd');

-- Nethervine Inciter (19511, 21563)
UPDATE creature_template SET pickpocketloot=19511, AIName='SmartAI', ScriptName='' WHERE entry=19511;
UPDATE creature_template SET pickpocketloot=19511, AIName='', ScriptName='' WHERE entry=21563;
DELETE FROM smart_scripts WHERE entryorguid=19511 AND source_type=0;
INSERT INTO smart_scripts VALUES (19511, 0, 0, 0, 1, 0, 50, 0, 5000, 20000, 30000, 30000, 11, 34156, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - Out of Combat - Cast Crystal Channel');
INSERT INTO smart_scripts VALUES (19511, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 20000, 24000, 11, 34616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast Deadly Poison');
INSERT INTO smart_scripts VALUES (19511, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 30000, 34000, 11, 34615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast Mind-numbind Poison');
INSERT INTO smart_scripts VALUES (19511, 0, 3, 0, 0, 0, 100, 0, 2000, 10000, 15000, 24000, 11, 30621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast Kidney Shot');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=19511;
INSERT INTO conditions VALUES(22, 1, 19511, 0, 0, 29, 1, 18721, 30, 0, 0, 0, 0, '', 'Requires World Trigger in 30yd');

-- Nethervine Reaper (19512, 21564)
UPDATE creature_template SET pickpocketloot=19512, AIName='SmartAI', ScriptName='' WHERE entry=19512;
UPDATE creature_template SET pickpocketloot=19512, AIName='', ScriptName='' WHERE entry=21564;
DELETE FROM smart_scripts WHERE entryorguid=19512 AND source_type=0;
INSERT INTO smart_scripts VALUES (19512, 0, 0, 0, 1, 0, 50, 0, 5000, 20000, 30000, 30000, 11, 34156, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - Out of Combat - Cast Crystal Channel');
INSERT INTO smart_scripts VALUES (19512, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 10000, 15000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - In Combat - Cast Cleave');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=19512;
INSERT INTO conditions VALUES(22, 1, 19512, 0, 0, 29, 1, 18721, 30, 0, 0, 0, 0, '', 'Requires World Trigger in 30yd');

-- Nethervine Trickster (19843, 21565)
UPDATE creature_template SET pickpocketloot=19843, AIName='SmartAI', ScriptName='' WHERE entry=19843;
UPDATE creature_template SET pickpocketloot=19843, AIName='', ScriptName='' WHERE entry=21565;
DELETE FROM smart_scripts WHERE entryorguid=19843 AND source_type=0;
INSERT INTO smart_scripts VALUES (19843, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Trickster - Ouf of Combat - Cast Stealth');
INSERT INTO smart_scripts VALUES (19843, 0, 1, 0, 67, 0, 100, 0, 6000, 6000, 0, 0, 11, 34614, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Trickster - Behind Victim - Cast Backstab');

-- Mutate Fleshlasher (19598, 21561)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19598;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21561;
DELETE FROM smart_scripts WHERE entryorguid=19598 AND source_type=0;
INSERT INTO smart_scripts VALUES (19598, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 11, 34351, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fleshlasher - In Combat - Cast Vicious Bite');

-- Mutate Fleshlasher (19598, 21561)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19598;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21561;
DELETE FROM smart_scripts WHERE entryorguid=19598 AND source_type=0;
INSERT INTO smart_scripts VALUES (19598, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 11, 34351, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fleshlasher - In Combat - Cast Vicious Bite');

-- Mutate Fleshlasher (25354)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=25354;
DELETE FROM smart_scripts WHERE entryorguid=25354 AND source_type=0;
INSERT INTO smart_scripts VALUES (25354, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 11, 34351, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fleshlasher - In Combat - Cast Vicious Bite');

-- Sunseeker Harvester (19509, 21575)
UPDATE creature_template SET pickpocketloot=19509, AIName='SmartAI', ScriptName='' WHERE entry=19509;
UPDATE creature_template SET pickpocketloot=19509, AIName='', ScriptName='' WHERE entry=21575;
DELETE FROM smart_scripts WHERE entryorguid=19509 AND source_type=0;
INSERT INTO smart_scripts VALUES (19509, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 15000, 20000, 11, 34640, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Harvester - In Combat - Cast Wilting Touch');
INSERT INTO smart_scripts VALUES (19509, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 14000, 11, 34639, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Harvester - In Combat - Cast Polymorph');

-- Sunseeker Gene-Splicer (19507, 21573)
UPDATE creature_template SET faction=16, pickpocketloot=19507, AIName='SmartAI', ScriptName='' WHERE entry=19507;
UPDATE creature_template SET faction=16, pickpocketloot=19507, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=21573;
DELETE FROM smart_scripts WHERE entryorguid=19507 AND source_type=0;
INSERT INTO smart_scripts VALUES (19507, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 15000, 20000, 11, 34642, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Gene-Splicer - In Combat - Cast Death & Decay');
INSERT INTO smart_scripts VALUES (19507, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 15000, 20000, 11, 39347, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Gene-Splicer - In Combat - Cast Death & Decay');
INSERT INTO smart_scripts VALUES (19507, 0, 2, 0, 37, 0, 100, 1, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Gene-Splicer - On AI Init - Set Stand State');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=19507;
INSERT INTO conditions VALUES(22, 3, 19507, 0, 0, 26, 1, 2, 0, 0, 0, 0, 0, '', 'Requires Phase Mask, HACK');

-- Sunseeker Herbalist (19508, 21576)
UPDATE creature_template SET pickpocketloot=19508, AIName='SmartAI', ScriptName='' WHERE entry=19508;
UPDATE creature_template SET pickpocketloot=19508, AIName='', ScriptName='' WHERE entry=21576;
DELETE FROM smart_scripts WHERE entryorguid=19508 AND source_type=0;
INSERT INTO smart_scripts VALUES (19508, 0, 0, 0, 0, 0, 50, 0, 2000, 5000, 15000, 20000, 11, 34247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Herbalist - In Combat - Cast Summon Lasher Beast');
INSERT INTO smart_scripts VALUES (19508, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 12000, 14000, 11, 22127, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Herbalist - In Combat - Cast Entangling Roots');

-- Mutate Horror (19865, 21562)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19865;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21562;
DELETE FROM smart_scripts WHERE entryorguid=19865 AND source_type=0;
INSERT INTO smart_scripts VALUES (19865, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 10000, 15000, 11, 34643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mutate Horror - In Combat - Cast Corrode Armor');

-- Mutate Fear-Shrieker (19513, 21560)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=19513;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21560;

-- Frayer Wildling (19608, 21554)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19608;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21554;
DELETE FROM smart_scripts WHERE entryorguid=19608 AND source_type=0;
INSERT INTO smart_scripts VALUES (19608, 0, 0, 0, 0, 0, 100, 2, 0, 5000, 6000, 10000, 11, 34644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frayer Wildling - In Combat - Cast Lash');
INSERT INTO smart_scripts VALUES (19608, 0, 1, 0, 0, 0, 100, 4, 0, 5000, 6000, 10000, 11, 39122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frayer Wildling - In Combat - Cast Lash');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Commander Sarannis (17976, 21551)
DELETE FROM creature_text WHERE entry=17976;
INSERT INTO creature_text VALUES (17976, 0, 0, 'Step forward! I will see that you are properly welcomed.', 14, 0, 100, 0, 0, 11071, 0, 'Commander Sarannis - On Aggro Say');
INSERT INTO creature_text VALUES (17976, 1, 0, 'Oh stop your whimpering.', 14, 0, 100, 0, 0, 11072, 0, 'Commander Sarannis - On Player Death Say');
INSERT INTO creature_text VALUES (17976, 1, 1, 'Mission accomplished.', 14, 0, 100, 0, 0, 11073, 0, 'Commander Sarannis - On Player Death Say');
INSERT INTO creature_text VALUES (17976, 2, 0, 'You are no longer dealing with some underling.', 14, 0, 100, 0, 0, 11076, 0, 'Commander Sarannis - On Cast Arcane Resonance Say');
INSERT INTO creature_text VALUES (17976, 3, 0, 'Band''or shorel''aran!', 14, 0, 100, 0, 0, 11077, 0, 'Commander Sarannis - On Cast Arcane Devastation Say');
INSERT INTO creature_text VALUES (17976, 4, 0, '%s calls for reinforcements.', 16, 0, 100, 0, 0, 0, 0, 'Commander Sarannis - On HP@50% Summon emote');
INSERT INTO creature_text VALUES (17976, 5, 0, 'Guards! Come and kill these intruders!', 14, 0, 100, 0, 0, 11078, 0, 'Commander Sarannis - On HP@50% Summon Say');
INSERT INTO creature_text VALUES (17976, 6, 0, 'I have not yet... begun to...', 14, 0, 100, 0, 0, 11079, 0, 'Commander Sarannis - On Death Say');
UPDATE creature_template SET pickpocketloot=17976, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_commander_sarannis' WHERE entry=17976;
UPDATE creature_template SET pickpocketloot=17976, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21551;

-- SPELL Summon Reinforcements (34803)
DELETE FROM spell_script_names WHERE spell_id IN(34803);
INSERT INTO spell_script_names VALUES(34803, 'spell_commander_sarannis_summon_reinforcements');

-- Summoned Bloodwarder Mender (20083, 21568)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=20083;
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=21568;
DELETE FROM smart_scripts WHERE entryorguid=20083 AND source_type=0;
INSERT INTO smart_scripts VALUES (20083, 0, 0, 0, 60, 0, 100, 0, 0, 0, 1800000, 1800000, 11, 34809, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - On Update - Cast Holy Fury');
INSERT INTO smart_scripts VALUES (20083, 0, 1, 0, 0, 0, 100, 2, 0, 0, 2000, 3000, 11, 17194, 64, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (20083, 0, 2, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 11, 17287, 64, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (20083, 0, 3, 0, 14, 0, 100, 0, 5000, 35, 10000, 10000, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - Friendly HP Missing - Cast Greater Heal');

-- Summoned Bloodwarder Reservist (20078, 21569)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=20078;
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=21569;
DELETE FROM smart_scripts WHERE entryorguid=20078 AND source_type=0;
INSERT INTO smart_scripts VALUES (20078, 0, 0, 0, 0, 0, 100, 0, 0, 0, 6000, 10000, 11, 34820, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Reservist - In Combat - Cast Arcane Strike');

-- High Botanist Freywinn (17975, 21558)
DELETE FROM creature_text WHERE entry=17975;
INSERT INTO creature_text VALUES (17975, 0, 0, 'What are you doing? These specimens are very delicate!', 14, 0, 100, 0, 0, 11144, 0, 'High Botanist Freywinn - Aggro Say');
INSERT INTO creature_text VALUES (17975, 1, 0, 'Your lifecycle is now concluded!', 14, 0, 100, 0, 0, 11145, 0, 'High Botanist Freywinn - Kill Plant as Bloodelf Say');
INSERT INTO creature_text VALUES (17975, 1, 1, 'You will feed the worms.', 14, 0, 100, 0, 0, 11146, 0, 'High Botanist Freywinn - Shapeshifting Say');
INSERT INTO creature_text VALUES (17975, 2, 0, 'Endorel aluminor!', 14, 0, 100, 0, 0, 11147, 0, 'High Botanist Freywinn - Shapeshifting Say');
INSERT INTO creature_text VALUES (17975, 3, 0, 'Nature bends to my will!', 14, 0, 100, 0, 0, 11148, 0, 'High Botanist Freywinn - Summoning Plants Say');
INSERT INTO creature_text VALUES (17975, 4, 0, 'The specimens... must be... preserved.', 14, 0, 100, 0, 0, 11149, 0, 'High Botanist Freywinn - Death Say');
INSERT INTO creature_text VALUES (17975, 5, 0, '...thorny vines...mumble...ouch!', 12, 0, 100, 0, 0, 0, 0, 'High Botanist Freywinn - OOC Random Say');
INSERT INTO creature_text VALUES (17975, 5, 1, '...mumble mumble...', 12, 0, 100, 0, 0, 0, 0, 'High Botanist Freywinn - OOC Random Say');
INSERT INTO creature_text VALUES (17975, 5, 2, '...mumble...Petals of Fire...mumble...', 12, 0, 100, 0, 0, 0, 0, 'High Botanist Freywinn - OOC Random Say');
INSERT INTO creature_text VALUES (17975, 5, 3, '...with the right mixture, perhaps...', 12, 0, 100, 0, 0, 0, 0, 'High Botanist Freywinn - OOC Random Say');
UPDATE creature_template SET pickpocketloot=17975, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_high_botanist_freywinn' WHERE entry=17975;
UPDATE creature_template SET pickpocketloot=17975, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21558;

-- White Seedling (19958, 21583)
-- Blue Seedling (19962, 21550)
-- Red Seedling (19964, 21566)
-- Green Seedling (19969, 21557)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(19958, 19962, 19964, 19969);
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry IN(21583, 21550, 21566, 21557);
DELETE FROM smart_scripts WHERE entryorguid IN(19958, 19962, 19964, 19969) AND source_type=0;
INSERT INTO smart_scripts VALUES (19958, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 6000, 6000, 11, 34752, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'White Seedling - In Combat - Cast Freezing Touch');
INSERT INTO smart_scripts VALUES (19962, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 6000, 6000, 11, 34782, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blue Seedling - In Combat - Cast Bind Feet');
INSERT INTO smart_scripts VALUES (19964, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 6000, 6000, 11, 36339, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Red Seedling - In Combat - Cast Fire Blast');
INSERT INTO smart_scripts VALUES (19969, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 6000, 6000, 11, 25812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Green Seedling - In Combat - Cast Toxic Volley');
INSERT INTO smart_scripts VALUES (19958, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 34770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'White Seedling - On AI Init - Cast Plant Spawn Effect');
INSERT INTO smart_scripts VALUES (19962, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 34770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blue Seedling - On AI Init - Cast Plant Spawn Effect');
INSERT INTO smart_scripts VALUES (19964, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 34770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Red Seedling - On AI Init - Cast Plant Spawn Effect');
INSERT INTO smart_scripts VALUES (19969, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 11, 34770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Green Seedling - On AI Init - Cast Plant Spawn Effect');

-- Frayer Protector (19953, 21553)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19953;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21553;
DELETE FROM smart_scripts WHERE entryorguid=19953 AND source_type=0;
INSERT INTO smart_scripts VALUES (19953, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 3000, 3000, 11, 34745, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Frayer Protector - In Combat - Cast Shoot Thorns');

-- Thorngrin the Tender (17978, 21581)
DELETE FROM creature_text WHERE entry=17978;
INSERT INTO creature_text VALUES (17978, 0, 0, 'What aggravation is this? You will die!', 14, 0, 100, 0, 0, 11205, 0, 'Thorngrin the Tender - Aggro Say');
INSERT INTO creature_text VALUES (17978, 1, 0, 'You seek a prize, eh? How about death?', 14, 0, 100, 0, 0, 11206, 0, 'Thorngrin the Tender - 20% Health Say');
INSERT INTO creature_text VALUES (17978, 2, 0, 'I hate to say I told you so...', 14, 0, 100, 0, 0, 11207, 0, 'Thorngrin the Tender - Player Death Say');
INSERT INTO creature_text VALUES (17978, 3, 0, 'Your life will be mine!', 14, 0, 100, 0, 0, 11208, 0, 'Thorngrin the Tender - Cast Sacrifice Say');
INSERT INTO creature_text VALUES (17978, 4, 0, 'I revel in your pain!', 14, 0, 100, 0, 0, 11209, 0, 'Thorngrin the Tender - 50% Health Say');
INSERT INTO creature_text VALUES (17978, 5, 0, 'I''ll incinerate you!', 14, 0, 100, 0, 0, 11210, 0, 'Thorngrin the Tender - Cast Hellfire Say');
INSERT INTO creature_text VALUES (17978, 5, 1, 'Scream while you burn!', 14, 0, 100, 0, 0, 11211, 0, 'Thorngrin the Tender - Cast Hellfire Say');
INSERT INTO creature_text VALUES (17978, 6, 0, 'You won''t... get far.', 14, 0, 100, 0, 0, 11212, 0, 'Thorngrin the Tender - On Death Say');
INSERT INTO creature_text VALUES (17978, 7, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 0, 'Thorngrin the Tender - On Enrage Say');
INSERT INTO creature_text VALUES (17978, 8, 0, 'Welcome my brothers! Bask in the glory of my power!', 14, 0, 100, 0, 0, 0, 0, 'Thorngrin the Tender - Intro');
UPDATE creature_template SET pickpocketloot=17978, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='thorngrin_the_tender' WHERE entry=17978;
UPDATE creature_template SET pickpocketloot=17978, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21581;

-- SPELL Sacrifice (34661)
DELETE FROM spell_target_position WHERE id=34661;
INSERT INTO spell_target_position VALUES (34661, 0, 553, 5.03811, 593.451, -15.1414, 4.68254);

-- Laj (17980, 21559)
DELETE FROM creature_text WHERE entry=17980;
INSERT INTO creature_text VALUES (17980, 0, 0, '%s emits a strange noise.', 16, 0, 100, 0, 0, 0, 0, 'laj EMOTE_SUMMON');
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_laj' WHERE entry=17980;
UPDATE creature_template SET mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21559;
DELETE FROM spell_target_position WHERE id IN(34681, 34682, 34684, 34685, 34686, 34687, 34688, 34690);
INSERT INTO spell_target_position VALUES (34681, 0, 553, -185.59, 376.67, -15.79, 1);
INSERT INTO spell_target_position VALUES (34682, 0, 553, -185.68, 406.9, -15.8, 0);
INSERT INTO spell_target_position VALUES (34684, 0, 553, -185.68, 406.9, -15.8, 0);
INSERT INTO spell_target_position VALUES (34685, 0, 553, -185.59, 376.67, -15.79, 1);
INSERT INTO spell_target_position VALUES (34686, 0, 553, -185.68, 406.9, -15.8, 0);
INSERT INTO spell_target_position VALUES (34687, 0, 553, -185.68, 406.9, -15.8, 0);
INSERT INTO spell_target_position VALUES (34688, 0, 553, -185.59, 376.67, -15.79, 1);
INSERT INTO spell_target_position VALUES (34690, 0, 553, -185.59, 376.67, -15.79, 1);

-- Thorn Lasher (19919, 21580)
UPDATE creature_template SET faction=16, unit_flags=unit_flags|131072, AIName='SmartAI', ScriptName='' WHERE entry=19919;
UPDATE creature_template SET faction=16, unit_flags=unit_flags|131072, AIName='', ScriptName='' WHERE entry=21580;
DELETE FROM smart_scripts WHERE entryorguid=19919 AND source_type=0;
INSERT INTO smart_scripts VALUES (19919, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 4000, 11, 34745, 2, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Thorn Lasher - In Combat - Cast Shot Thorns');

-- Thorn Flayer (19920, 21579)
UPDATE creature_template SET faction=16, unit_flags=unit_flags|131072, AIName='SmartAI', ScriptName='' WHERE entry=19920;
UPDATE creature_template SET faction=16, unit_flags=unit_flags|131072, AIName='', ScriptName='' WHERE entry=21579;
DELETE FROM smart_scripts WHERE entryorguid=19920 AND source_type=0;
INSERT INTO smart_scripts VALUES (19920, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 7000, 11, 35507, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Thorn Flayer - In Combat - Cast Mind Flay');

-- Warp Splinter (17977, 21582)
DELETE FROM creature_text WHERE entry=17977;
INSERT INTO creature_text VALUES (17977, 0, 0, 'Who disturbs this sanctuary?', 14, 0, 100, 0, 0, 11230, 0, 'warp SAY_AGGRO');
INSERT INTO creature_text VALUES (17977, 1, 0, 'You must die! But wait: this does not-- No, no... you must die!', 14, 0, 100, 0, 0, 11231, 0, 'warp SAY_SLAY_1');
INSERT INTO creature_text VALUES (17977, 1, 1, 'What am I doing? Why do I...', 14, 0, 100, 0, 0, 11232, 0, 'warp SAY_SLAY_2');
INSERT INTO creature_text VALUES (17977, 2, 0, 'Children, come to me!', 14, 0, 100, 0, 0, 11233, 0, 'warp SAY_SUMMON_1');
INSERT INTO creature_text VALUES (17977, 2, 1, 'Maybe this is not-- No, we fight! Come to my aid.', 14, 0, 100, 0, 0, 11234, 0, 'warp SAY_SUMMON_2');
INSERT INTO creature_text VALUES (17977, 3, 0, 'So... confused. Do not... belong here!', 14, 0, 100, 0, 0, 11235, 0, 'warp SAY_DEATH');
UPDATE creature_template SET skinloot=80002, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_warp_splinter' WHERE entry=17977;
UPDATE creature_template SET skinloot=80002, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21582;

-- SPELL Ancestral Life (34742)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=34742;
INSERT INTO conditions VALUES(13, 1, 34742, 0, 0, 31, 0, 3, 19949, 0, 0, 0, 0, '', 'Target Sapling');

-- SPELL Summon Saplings (34727, 34730, 34731, 34732, 34733, 34734, 34735, 34736, 34737, 34739)
DELETE FROM spell_target_position WHERE id IN(34727, 34730, 34731, 34732, 34733, 34734, 34735, 34736, 34737, 34739);
INSERT INTO spell_target_position VALUES (34727, 0, 553, 106.780159, 355.582581, -27.593357, 2.49);
INSERT INTO spell_target_position VALUES (34730, 0, 553, 24.301233, 427.221100, -27.060635, 5.6);
INSERT INTO spell_target_position VALUES (34731, 0, 553, 16.795492, 359.678802, -27.355425, 0.65);
INSERT INTO spell_target_position VALUES (34732, 0, 553, 53.493484, 345.381470, -26.196192, 1.32);
INSERT INTO spell_target_position VALUES (34733, 0, 553, 61.867096, 439.362732, -25.921030, 4.83);
INSERT INTO spell_target_position VALUES (34734, 0, 553, 109.861877, 423.201630, -27.356019, 3.75);
INSERT INTO spell_target_position VALUES (34735, 0, 553, 106.780159, 355.582581, -27.593357, 2.49);
INSERT INTO spell_target_position VALUES (34736, 0, 553, 24.301233, 427.221100, -27.060635, 5.6);
INSERT INTO spell_target_position VALUES (34737, 0, 553, 16.795492, 359.678802, -27.355425, 0.65);
INSERT INTO spell_target_position VALUES (34739, 0, 553, 53.493484, 345.381470, -26.196192, 1.32);

-- Sapling (19949, 21567)
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=19949;
UPDATE creature_template SET faction=16, AIName='', ScriptName='' WHERE entry=21567;
DELETE FROM smart_scripts WHERE entryorguid=19949 AND source_type=0;
INSERT INTO smart_scripts VALUES (19949, 0, 0, 0, 8, 0, 100, 0, 34742, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sapling - On Spell Hit - Die');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Corpses in Laj room, use Sunseeker Gene-Splicer with dozen of unit_flags
DELETE FROM creature WHERE map=553 AND id=19507 AND unit_flags=33948422 AND dynamicflags=40;
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -174.595, 414.99, -17.6979, 3.82617, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -179.07, 404.267, -17.6894, 4.31705, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -152.262, 373.478, -17.6895, 4.35239, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -151.989, 412.301, -17.6878, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -163.56, 402.493, -17.7171, 4.35239, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -148.417, 399.016, -17.8617, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -155.432, 384.674, -17.7944, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -158.069, 396.566, -17.7685, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -164.709, 383.895, -17.7044, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -162.013, 371.896, -17.7006, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -171.645, 373.62, -17.6957, 0.869149, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -180.265, 374.369, -17.6894, 4.31705, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -179.035, 380.227, -17.6894, 4.31705, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);
INSERT INTO creature VALUES (NULL, 19507, 553, 3, 3, 0, 0, -174.991, 389.917, -17.6883, 4.31705, 300, 0, 0, 19681, 7332, 0, 0, 33948422, 40);



-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------
-- Hellfire (34659, 39131)
DELETE FROM spelldifficulty_dbc WHERE id IN(34659, 39131) OR spellid0 IN(34659, 39131) OR spellid1 IN(34659, 39131) OR spellid2 IN(34659, 39131) OR spellid3 IN(34659, 39131);
INSERT INTO spelldifficulty_dbc VALUES (34659, 34659, 39131, 0, 0);

-- Arcane Volley (36705, 39133)
DELETE FROM spelldifficulty_dbc WHERE id IN(36705, 39133) OR spellid0 IN(36705, 39133) OR spellid1 IN(36705, 39133) OR spellid2 IN(36705, 39133) OR spellid3 IN(36705, 39133);
INSERT INTO spelldifficulty_dbc VALUES (36705, 36705, 39133, 0, 0);

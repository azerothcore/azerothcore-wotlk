
UPDATE creature SET spawntimesecs=7*86400 WHERE map=548 AND spawntimesecs>0;
DELETE FROM disables WHERE sourceType=2 AND entry=548;
-- INSERT INTO disables VALUES(2, 548, 1, '', '', 'Disable SSC');

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Underbog Colossus (21251)
UPDATE creature_template SET dmg_multiplier=25, AIName='SmartAI', ScriptName='' WHERE entry=21251;
DELETE FROM smart_scripts WHERE entryorguid=21251 AND source_type=0;
INSERT INTO smart_scripts VALUES (21251, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Aggro - Set Random Phase');
INSERT INTO smart_scripts VALUES (21251, 0, 1, 0, 0, 1, 100, 0, 2000, 12000, 15000, 20000, 11, 39031, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Enrage');
INSERT INTO smart_scripts VALUES (21251, 0, 2, 0, 0, 1, 100, 1, 0, 0, 0, 0, 11, 39014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Atrophic Blow');
INSERT INTO smart_scripts VALUES (21251, 0, 3, 0, 0, 2, 100, 0, 2000, 12000, 20000, 25000, 11, 38971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Acid Geyser');
INSERT INTO smart_scripts VALUES (21251, 0, 4, 0, 0, 2, 100, 0, 5000, 9000, 19000, 25000, 11, 39044, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Serpentshrine Parasite');
INSERT INTO smart_scripts VALUES (21251, 0, 5, 0, 0, 4, 100, 0, 2000, 12000, 20000, 25000, 11, 38976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Spore Quake');
INSERT INTO smart_scripts VALUES (21251, 0, 6, 0, 0, 4, 100, 0, 5000, 9000, 19000, 25000, 11, 39032, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Initial Infection');
INSERT INTO smart_scripts VALUES (21251, 0, 7, 0, 6, 0, 80, 0, 0, 0, 0, 0, 140, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Death - Run Random Timed Event');
INSERT INTO smart_scripts VALUES (21251, 0, 8, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 38718, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Toxic Pool');
INSERT INTO smart_scripts VALUES (21251, 0, 9, 0, 59, 0, 100, 0, 2, 0, 0, 0, 11, 38922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Colossus Lurkers');
INSERT INTO smart_scripts VALUES (21251, 0, 10, 0, 59, 0, 100, 0, 3, 0, 0, 0, 11, 38928, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Colossus Ragers');
INSERT INTO smart_scripts VALUES (21251, 0, 11, 0, 59, 0, 100, 0, 4, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Serpentshrine Mushroom');

-- SPELL Serpentshrine Parasite (39044)
DELETE FROM spell_script_names WHERE spell_id=39044;
INSERT INTO spell_script_names VALUES(39044, 'spell_serpentshrine_cavern_serpentshrine_parasite');

-- SPELL Initial Infection (39032)
-- SPELL Rampart Infection (39042)
DELETE FROM spell_script_names WHERE spell_id IN(39032, 39042);
INSERT INTO spell_script_names VALUES(39032, 'spell_serpentshrine_cavern_infection');
INSERT INTO spell_script_names VALUES(39042, 'spell_serpentshrine_cavern_infection');

-- Serpentshrine Parasite (22379)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22379);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22379);
DELETE FROM creature WHERE id=22379;
REPLACE INTO creature_template_addon VALUES (22379, 0, 0, 0, 0, 0, '39057');
UPDATE creature_template SET unit_flags=0, flags_extra=256, AIName='SmartAI', ScriptName='' WHERE entry=22379;
DELETE FROM smart_scripts WHERE entryorguid=22379 AND source_type=0;
INSERT INTO smart_scripts VALUES (22379, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Parasite - On Reset - Set React State');
INSERT INTO smart_scripts VALUES (22379, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 80, 0, 0, 0, 0, 0, 0, 'Serpentshrine Parasite - On Reset - Attack Start');

-- SPELL Serpentshrine Parasite (39053)
DELETE FROM spell_script_names WHERE spell_id=39053;
INSERT INTO spell_script_names VALUES(39053, 'spell_serpentshrine_cavern_serpentshrine_parasite_trigger');

-- GO Serpentshrine Mushroom (185199)
DELETE FROM gameobject WHERE id=185199;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=185199;
DELETE FROM smart_scripts WHERE entryorguid=185199 AND source_type=1;
INSERT INTO smart_scripts VALUES(185199, 1, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 38874, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Serpentshrine Mushroom - On Update - Cast Summon Mushoom Creature");
INSERT INTO smart_scripts VALUES(185199, 1, 1, 0, 60, 0, 100, 257, 20000, 20000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Serpentshrine Mushroom - On Update - Despawn");

-- Mushrom Spell Effect (22335)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22335);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22335);
DELETE FROM creature WHERE id=22335;
REPLACE INTO creature_template_addon VALUES (22335, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET faction=35, unit_flags=33554432, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=22335;
DELETE FROM smart_scripts WHERE entryorguid=22335 AND source_type=0;
INSERT INTO smart_scripts VALUES (22335, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 38730, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mushrom Spell Effect - On Reset - Cast Refreshing Mist');

-- Colossus Lurker (22347)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22347);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22347);
DELETE FROM creature WHERE id=22347;
UPDATE creature_template SET dmg_multiplier=18, AIName='SmartAI', ScriptName='' WHERE entry=22347;
DELETE FROM smart_scripts WHERE entryorguid=22347 AND source_type=0;
INSERT INTO smart_scripts VALUES (22347, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, 'Colossus Lurker - On Reset - Attack Start');

-- Colossus Rager (22352)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22352);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22352);
DELETE FROM creature WHERE id=22352;
UPDATE creature_template SET dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=22352;
DELETE FROM smart_scripts WHERE entryorguid=22352 AND source_type=0;
INSERT INTO smart_scripts VALUES (22352, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, 'Colossus Rager - On Reset - Attack Start');

-- Coilfang Hate-Screamer (21339)
UPDATE creature_template SET dmg_multiplier=18, AIName='SmartAI', ScriptName='' WHERE entry=21339;
DELETE FROM smart_scripts WHERE entryorguid=21339 AND source_type=0;
INSERT INTO smart_scripts VALUES (21339, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 20000, 25000, 11, 38491, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Hate-Screamer - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (21339, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 8000, 14000, 11, 38496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Hate-Screamer - In Combat - Cast Sonic Scream');

-- Coilfang Beast-Tamer (21221)
UPDATE creature_template SET dmg_multiplier=18, AIName='SmartAI', ScriptName='' WHERE entry=21221;
DELETE FROM smart_scripts WHERE entryorguid=21221 AND source_type=0;
INSERT INTO smart_scripts VALUES (21221, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 2000, 2000, 11, 38904, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (21221, 0, 1, 0, 0, 0, 100, 0, 5000, 9000, 8000, 14000, 11, 38474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (21221, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 21000, 30000, 11, 38484, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Bestial Wrath');
-- Wrong Spawns
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21221 AND position_y<-860);
DELETE FROM creature WHERE id=21221 AND position_y<-860;

-- SPELL Bestial Wrath (38484)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38484;
INSERT INTO conditions VALUES(13, 7, 38484, 0, 0, 31, 0, 3, 21246, 0, 0, 0, 0, '', 'Target Serpentshrine Sporebat');

-- Serpentshrine Sporebat (21246)
REPLACE INTO creature_template_addon VALUES (21246, 0, 0, 0, 4097, 0, '38471');
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=21246;
DELETE FROM smart_scripts WHERE entryorguid=21246 AND source_type=0;
INSERT INTO smart_scripts VALUES (21246, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 20000, 25000, 11, 39197, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Serpentshrine Sporebat - In Combat - Cast Sonic Charge');

-- Purified Water Elemental (21260)
UPDATE creature_template SET dmg_multiplier=18, AIName='', ScriptName='' WHERE entry=21260;

-- Tainted Water Elemental (21253)
UPDATE creature_template SET dmg_multiplier=18, AIName='', ScriptName='' WHERE entry=21253;

-- Coilfang Shatterer (21301)
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=21301;
DELETE FROM smart_scripts WHERE entryorguid=21301 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(SELECT -guid FROM creature WHERE id=21301 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272) AND source_type=0;
INSERT INTO smart_scripts SELECT -guid, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 10000, 15000, 11, 38591, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - In Combat - Cast Shatter Armor'FROM creature WHERE id=21301 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - On Aggro - Call For Help'FROM creature WHERE id=21301 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 34, 20, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - Just Respawned - Set Instance Data 20' FROM creature WHERE id=21301 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 21, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - On Death - Set Instance Data 21' FROM creature WHERE id=21301 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts VALUES (21301, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 10000, 15000, 11, 38591, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - In Combat - Cast Shatter Armor');
INSERT INTO smart_scripts VALUES (21301, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - On Aggro - Call For Help');

-- Coilfang Priestess (21220)
UPDATE creature_template SET dmg_multiplier=15, AIName='SmartAI', ScriptName='' WHERE entry=21220;
DELETE FROM smart_scripts WHERE entryorguid=21220 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(SELECT -guid FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272) AND source_type=0;
INSERT INTO smart_scripts SELECT -guid, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 38582, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Smite' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 1, 0, 0, 0, 100, 0, 2000, 9000, 10000, 12000, 11, 38585, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Fire' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 2, 0, 14, 0, 100, 0, 25000, 35, 5000, 8000, 11, 38580, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - Friendly Missing Health - Cast Greater Heal' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - On Aggro - Call For Help' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 34, 20, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - Just Respawned - Set Instance Data 20' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts SELECT -guid, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 21, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - On Death - Set Instance Data 21' FROM creature WHERE id=21220 AND position_x BETWEEN -114 AND 162 AND position_y BETWEEN -621 AND -272;
INSERT INTO smart_scripts VALUES (21220, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 38582, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (21220, 0, 1, 0, 0, 0, 100, 0, 2000, 9000, 10000, 12000, 11, 38585, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Fire');
INSERT INTO smart_scripts VALUES (21220, 0, 2, 0, 14, 0, 100, 0, 25000, 35, 5000, 8000, 11, 38580, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - Friendly Missing Health - Cast Greater Heal');
INSERT INTO smart_scripts VALUES (21220, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - On Aggro - Call For Help');

-- Greyheart Technician (21263)
DELETE FROM creature WHERE id=21263;
INSERT INTO creature VALUES (80274, 21263, 548, 1, 1, 0, 1, -64.9577, -451.841, 0.740188, 1.65118, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (80445, 21263, 548, 1, 1, 0, 1, -87.4899, -473.897, 0.740551, 2.77037, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (80473, 21263, 548, 1, 1, 0, 1, -34.119, -460.645, 0.741022, 0.791167, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (81029, 21263, 548, 1, 1, 0, 1, -49.0664, -513.449, 0.741579, 4.89094, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (81916, 21263, 548, 1, 1, 0, 1, 9.88017, -557.136, 0.742559, 3.27695, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (81917, 21263, 548, 1, 1, 0, 1, 59.7301, -580.275, 0.74102, 5.103, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (81944, 21263, 548, 1, 1, 0, 1, 55.0272, -525.643, 0.740886, 1.01108, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (81997, 21263, 548, 1, 1, 0, 1, 150.087, -541.063, 0.740644, 5.04017, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (82002, 21263, 548, 1, 1, 0, 1, 172.595, -502.339, 0.740698, 0.178557, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (82003, 21263, 548, 1, 1, 0, 1, 111.276, -501.506, 0.740839, 2.73111, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (82032, 21263, 548, 1, 1, 0, 1, 119.645, -376.397, 0.740561, 4.07414, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (82036, 21263, 548, 1, 1, 0, 1, 150.426, -322.979, 0.740624, 1.40771, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (82861, 21263, 548, 1, 1, 0, 1, -77.3269, -395.156, 0.74211, 3.88407, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93787, 21263, 548, 1, 1, 0, 1, 17.398, -282.57, 0.74176, 2.34155, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93789, 21263, 548, 1, 1, 0, 1, -51.02, -339.56, 0.740151, 1.47682, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93809, 21263, 548, 1, 1, 0, 1, 230.599, -438.00, -4.43, 3.66, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93811, 21263, 548, 1, 1, 0, 1, 225.325, -441.05, -4.43, 0.405, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93831, 21263, 548, 1, 1, 0, 1, 52.0541, -333.556, 0.741577, 5.07866, 604800, 0, 0, 10053, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (21263, 0, 0, 0, 4097, 173, '');
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21263;
DELETE FROM smart_scripts WHERE entryorguid=21263 AND source_type=0;
INSERT INTO smart_scripts VALUES (21263, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 10000, 15000, 11, 38995, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Technician - In Combat - Cast Hamstring');

-- Vashj'ir Honor Guard (21218)
DELETE FROM creature_text WHERE entry=21218;
INSERT INTO creature_text VALUES (21218, 0, 0, 'Enough! I have had enough of you filthy warm bloods!', 14, 0, 100, 0, 0, 0, 0, 'Vashj''ir Honor Guard');
UPDATE creature_template SET dmg_multiplier=20, AIName='SmartAI', ScriptName='' WHERE entry=21218;
DELETE FROM smart_scripts WHERE entryorguid=21218 AND source_type=0;
INSERT INTO smart_scripts VALUES (21218, 0, 0, 0, 0, 0, 100, 0, 2000, 12000, 10000, 15000, 11, 38572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vashj''ir Honor Guard - In Combat - Cast Mortal Cleave');
INSERT INTO smart_scripts VALUES (21218, 0, 1, 0, 13, 0, 100, 0, 12000, 12000, 0, 0, 11, 38576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vashj''ir Honor Guard - Victim Casting - Cast Knockback');
INSERT INTO smart_scripts VALUES (21218, 0, 2, 3, 2, 0, 100, 1, 0, 50, 0, 0, 11, 38947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vashj''ir Honor Guard - Between Health 0-50% - Cast Frenzy');
INSERT INTO smart_scripts VALUES (21218, 0, 3, 0, 61, 0, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vashj''ir Honor Guard - Between Health 0-50% - Talk');
INSERT INTO smart_scripts VALUES (21218, 0, 4, 0, 12, 0, 100, 0, 0, 20, 15000, 15000, 11, 38959, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Vashj''ir Honor Guard - Target Health 0-20% - Cast Execute');

-- Greyheart Shield-Bearer (21231)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21231;
DELETE FROM smart_scripts WHERE entryorguid=21231 AND source_type=0;
INSERT INTO smart_scripts VALUES (21231, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 10000, 15000, 11, 38631, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Shield-Bearer - In Combat - Cast Avenger''s Shield');
INSERT INTO smart_scripts VALUES (21231, 0, 1, 9, 0, 0, 100, 0, 8, 25, 10000, 15000, 11, 38630, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Shield-Bearer - In Combat - Cast Shield Charge');

-- Serpentshrine Lurker (21863)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21863;
DELETE FROM smart_scripts WHERE entryorguid=21863 AND source_type=0;
INSERT INTO smart_scripts VALUES (21863, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 10000, 15000, 11, 38650, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Lurker - In Combat - Cast Rancid Mushroom');
INSERT INTO smart_scripts VALUES (21863, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 22000, 11, 38655, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Lurker - In Combat - Cast Poison Bolt Volley');

-- SPELL Rancid Mushroom (38650)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(38650, -38650);
INSERT INTO spell_linked_spell VALUES (38650, 38651, 1, 'Rancid Mushroom (Serpentshrine Cavern)');
DELETE FROM spell_script_names WHERE spell_id IN(38650);
INSERT INTO spell_script_names VALUES(38650, 'spell_gen_select_target_count_15_1');

-- Rancid Mushroom (22250)
REPLACE INTO creature_template_addon VALUES (22250, 0, 0, 0, 0, 0, '31690');
UPDATE creature_template SET flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=22250;
DELETE FROM smart_scripts WHERE entryorguid=22250 AND source_type=0;
INSERT INTO smart_scripts VALUES (22250, 0, 0, 1, 25, 0, 100, 257, 0, 0, 0, 0, 41, 21000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - On Reset - Despawn');
INSERT INTO smart_scripts VALUES (22250, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 38652, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - On Reset - Cast Spore Cloud');

-- Greyheart Skulker (21232)
UPDATE creature_template SET dmg_multiplier=13, AIName='SmartAI', ScriptName='' WHERE entry=21232;
DELETE FROM smart_scripts WHERE entryorguid=21232 AND source_type=0;
INSERT INTO smart_scripts VALUES (21232, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Skulker - On Reset - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (21232, 0, 1, 0, 13, 0, 100, 0, 8000, 8000, 0, 0, 11, 38625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Skulker - Victim Casting - Cast Kick');

-- Greyheart Tidecaller (21229)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21229;
DELETE FROM smart_scripts WHERE entryorguid=21229 AND source_type=0;
INSERT INTO smart_scripts VALUES (21229, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 120000, 120000, 11, 39027, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Poison Shield');
INSERT INTO smart_scripts VALUES (21229, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 20000, 25000, 11, 38624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Water Elemental Totem');

-- SPELL Poison Shield (39027)
REPLACE INTO spell_proc_event VALUES (39027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3000);

-- Water Elemental Totem (22236)
UPDATE creature_template SET spell1=38622, AIName='', ScriptName='' WHERE entry=22236;

-- Serpentshrine Tidecaller (22238)
UPDATE creature_template SET dmg_multiplier=10, AIName='SmartAI', ScriptName='' WHERE entry=22238;
DELETE FROM smart_scripts WHERE entryorguid=22238 AND source_type=0;
INSERT INTO smart_scripts VALUES (22238, 0, 0, 0, 0, 0, 100, 0, 0, 6000, 12000, 12000, 11, 38623, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Tidecaller - In Combat - Cast Water Bolt Volley');
INSERT INTO smart_scripts VALUES (22238, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 20000, 25000, 11, 39035, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Tidecaller - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (22238, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Serpentshrine Tidecaller - On Reset - Attack Start');

-- Greyheart Nether-Mage (21230)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21230;
DELETE FROM smart_scripts WHERE entryorguid=21230 AND source_type=0;
INSERT INTO smart_scripts VALUES (21230, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 30, 1, 2, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - On Aggro - Set Event Phase Random');
INSERT INTO smart_scripts VALUES (21230, 0, 1, 0, 0, 1, 100, 0, 0, 3000, 2000, 3000, 11, 38641, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (21230, 0, 2, 0, 0, 1, 100, 0, 0, 3000, 60000, 60000, 11, 38648, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Fire Destruction');
INSERT INTO smart_scripts VALUES (21230, 0, 3, 0, 0, 1, 100, 0, 8000, 11000, 22000, 28000, 11, 38635, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (21230, 0, 4, 0, 0, 1, 100, 0, 19000, 19000, 22000, 28000, 11, 38636, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (21230, 0, 5, 0, 0, 2, 100, 0, 0, 3000, 2000, 3000, 11, 38645, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (21230, 0, 6, 0, 0, 2, 100, 0, 0, 3000, 60000, 60000, 11, 38649, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Frost Destruction');
INSERT INTO smart_scripts VALUES (21230, 0, 7, 0, 0, 2, 100, 0, 8000, 11000, 14000, 17000, 11, 38644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (21230, 0, 8, 0, 0, 4, 100, 0, 0, 3000, 2000, 3000, 11, 38633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Volley');
INSERT INTO smart_scripts VALUES (21230, 0, 9, 0, 0, 4, 100, 0, 0, 3000, 60000, 60000, 11, 38647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Destruction');
INSERT INTO smart_scripts VALUES (21230, 0, 10, 0, 0, 4, 100, 0, 8000, 11000, 14000, 17000, 11, 38634, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Lightning');

-- SPELL Arcane Volley (38633)
DELETE FROM spell_script_names WHERE spell_id IN(38633);
INSERT INTO spell_script_names VALUES(38633, 'spell_gen_select_target_count_15_1');

-- Tidewalker Warrior (21225)
UPDATE creature_template SET speed_run=2, dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21225;
DELETE FROM smart_scripts WHERE entryorguid=21225 AND source_type=0;
INSERT INTO smart_scripts VALUES (21225, 0, 0, 0, 0, 0, 100, 0, 4000, 9000, 18000, 25000, 11, 39070, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Bloodthirst');
INSERT INTO smart_scripts VALUES (21225, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 25000, 30000, 11, 38664, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Enrage');
INSERT INTO smart_scripts VALUES (21225, 0, 2, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 39069, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Uppercut');

-- Tidewalker Shaman (21226)
UPDATE creature_template SET speed_run=1.4, dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21226;
DELETE FROM smart_scripts WHERE entryorguid=21226 AND source_type=0;
INSERT INTO smart_scripts VALUES (21226, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 39065, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (21226, 0, 1, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 11, 39067, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Lightning Shield');
INSERT INTO smart_scripts VALUES (21226, 0, 2, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 11, 39066, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Chain Lightning');

-- Tidewalker Hydromancer (21228)
UPDATE creature_template SET speed_run=1.4, dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21228;
DELETE FROM smart_scripts WHERE entryorguid=21228 AND source_type=0;
INSERT INTO smart_scripts VALUES (21228, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2200, 11, 39064, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - In Combat - Cast FrostBolt');
INSERT INTO smart_scripts VALUES (21228, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 39062, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (21228, 0, 2, 0, 9, 0, 100, 0, 0, 10, 10000, 15000, 11, 39063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - Within Range 0-10yd - Cast Frost Nova');

-- Tidewalker Harpooner (21227)
UPDATE creature_template SET speed_run=1.4, dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21227;
DELETE FROM smart_scripts WHERE entryorguid=21227 AND source_type=0;
INSERT INTO smart_scripts VALUES (21227, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2200, 11, 39060, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Harpooner - In Combat - Cast Throw');
INSERT INTO smart_scripts VALUES (21227, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 39061, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Harpooner - In Combat - Cast Impale');
INSERT INTO smart_scripts VALUES (21227, 0, 2, 0, 9, 0, 100, 0, 0, 20, 10000, 15000, 11, 38661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Harpooner - Within Range 0-20yd - Cast Net');

-- Tidewalker Depth-Seer (21224)
UPDATE creature_template SET speed_run=1.4, dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21224;
DELETE FROM smart_scripts WHERE entryorguid=21224 AND source_type=0;
INSERT INTO smart_scripts VALUES (21224, 0, 0, 0, 14, 0, 100, 0, 8000, 40, 8000, 10000, 11, 38658, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - Friendly Missing Health - Cast Healing Touch');
INSERT INTO smart_scripts VALUES (21224, 0, 1, 0, 16, 1, 100, 0, 38657, 40, 7000, 10000, 11, 38657, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - Friendly Missing Buff - Cast Rejuvenation');
INSERT INTO smart_scripts VALUES (21224, 0, 2, 0, 0, 0, 100, 0, 8000, 15000, 25000, 35000, 11, 38659, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - In Combat - Cast Tranquility');
INSERT INTO smart_scripts VALUES (21224, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - On Aggro - Set Event Phase');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Hydross the Unstable (21216)
DELETE FROM creature_text WHERE entry=21216;
INSERT INTO creature_text VALUES (21216, 0, 0, 'I cannot allow you to interfere!', 14, 0, 100, 0, 0, 11289, 0, 'hydross SAY_AGGRO');
INSERT INTO creature_text VALUES (21216, 1, 0, 'Better, much better.', 14, 0, 100, 0, 0, 11290, 0, 'hydross SAY_SWITCH_TO_CLEAN');
INSERT INTO creature_text VALUES (21216, 2, 0, 'They have forced me to this...', 14, 0, 100, 0, 0, 11291, 0, 'hydross SAY_CLEAN_SLAY1');
INSERT INTO creature_text VALUES (21216, 2, 1, 'I have no choice.', 14, 0, 100, 0, 0, 11292, 0, 'hydross SAY_CLEAN_SLAY2');
INSERT INTO creature_text VALUES (21216, 3, 0, 'I am... released...', 14, 0, 100, 0, 0, 11293, 0, 'hydross SAY_CLEAN_DEATH');
INSERT INTO creature_text VALUES (21216, 4, 0, 'Aaghh, the poison...', 14, 0, 100, 0, 0, 11297, 0, 'hydross SAY_SWITCH_TO_CORRUPT');
INSERT INTO creature_text VALUES (21216, 5, 0, 'I will purge you from this place.', 14, 0, 100, 0, 0, 11298, 0, 'hydross SAY_CORRUPT_SLAY1');
INSERT INTO creature_text VALUES (21216, 5, 1, 'You are no better than they!', 14, 0, 100, 0, 0, 11299, 0, 'hydross SAY_CORRUPT_SLAY2');
INSERT INTO creature_text VALUES (21216, 6, 0, 'You... are the disease... not I...', 14, 0, 100, 0, 0, 11300, 0, 'hydross SAY_CORRUPT_DEATH');
UPDATE creature_template SET dmg_multiplier=15, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_hydross_the_unstable' WHERE entry=21216;

-- Hydross Beam Helper (21933)
DELETE FROM creature WHERE id=21933;
INSERT INTO creature VALUES (NULL, 21933, 548, 1, 1, 0, 0, -259.13, -356.28, 15.03, 6.04, 604800, 0, 0, 2835, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 21933, 548, 1, 1, 0, 0, -218.80, -371.34, 14.608, 2.72, 604800, 0, 0, 2835, 0, 0, 0, 33554432, 0);
UPDATE creature_template SET faction=14, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=21933;

-- Hydross Cleansing Field Helper (21934)
DELETE FROM creature WHERE id=21934;
INSERT INTO creature VALUES (NULL, 21934, 548, 1, 1, 0, 0, -239.43, -363.48, 12, 1.19093, 604800, 0, 0, 2835, 0, 0, 0, 33554432, 0);
REPLACE INTO creature_template_addon VALUES (21934, 0, 0, 0, 0, 0, '37935');
UPDATE creature_template SET faction=14, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=21934;

-- Pure Spawn of Hydross (22035)
UPDATE creature_template SET dmg_multiplier=18, AIName='', ScriptName='' WHERE entry=22035;

-- Tainted Spawn of Hydross (22036)
UPDATE creature_template SET dmg_multiplier=18, AIName='', ScriptName='' WHERE entry=22036;

-- SPELL Cleansing Field (37935)
DELETE FROM spell_script_names WHERE spell_id=37935;
INSERT INTO spell_script_names VALUES(37935, 'spell_hydross_cleansing_field_aura');

-- SPELL Cleansing Field (37934)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=37934;
INSERT INTO conditions VALUES(13, 1, 37934, 0, 0, 31, 0, 3, 21933, 0, 0, 0, 0, '', 'Target Hydross Beam Helper');
DELETE FROM spell_script_names WHERE spell_id=37934;
INSERT INTO spell_script_names VALUES(37934, 'spell_hydross_cleansing_field_command');

-- SPELL Blue Beam (38015)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38015;
INSERT INTO conditions VALUES(13, 1, 38015, 0, 0, 31, 0, 3, 21216, 0, 0, 0, 0, '', 'Target Hydross the Unstable');

-- SPELL Mark of Hydross (38215, 38216, 38217, 38218, 38231, 40584)
-- SPELL Mark of Corruption (38219, 38220, 38221, 38222, 38230, 40583)
DELETE FROM spell_ranks WHERE spell_id IN(38215, 38216, 38217, 38218, 38231, 40584, 38219, 38220, 38221, 38222, 38230, 40583);
INSERT INTO spell_ranks VALUES (38215, 38215, 1),(38215, 38216, 2),(38215, 38217, 3),(38215, 38218, 4),(38215, 38231, 5),(38215, 40584, 6);
INSERT INTO spell_ranks VALUES (38219, 38219, 1),(38219, 38220, 2),(38219, 38221, 3),(38219, 38222, 4),(38219, 38230, 5),(38219, 40583, 6);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(38215, 38216, 38217, 38218, 38231, 40584, 38219, 38220, 38221, 38222, 38230, 40583);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-38215, -38216, -38217, -38218, -38231, -40584, -38219, -38220, -38221, -38222, -38230, -40583);
DELETE FROM spell_script_names WHERE spell_id IN(38215, 38219);
INSERT INTO spell_script_names VALUES(38215, 'spell_hydross_mark_of_hydross');
INSERT INTO spell_script_names VALUES(38219, 'spell_hydross_mark_of_hydross');

-- The Lurker Below (21217)
DELETE FROM creature_text WHERE entry=21217;
INSERT INTO creature_text VALUES (21217, 0, 0, '%s takes a deep breath!', 41, 0, 100, 0, 0, 0, 0, 'The Lurker Below');
UPDATE creature_template SET dmg_multiplier=60, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_the_lurker_below' WHERE entry=21217;

-- Coilfang Ambusher (21865)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21865;
DELETE FROM smart_scripts WHERE entryorguid=21865 AND source_type=0;
INSERT INTO smart_scripts VALUES (21865, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 2000, 2000, 11, 37770, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ambusher - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (21865, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 14000, 18000, 11, 37790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ambusher - In Combat - Cast Spread Shot');

-- Coilfang Guardian (21873)
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21873;
DELETE FROM smart_scripts WHERE entryorguid=21873 AND source_type=0;
INSERT INTO smart_scripts VALUES (21873, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 9000, 12000, 11, 28168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (21873, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 14000, 18000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - In Combat - Cast Hamstring');

-- GO Strange Pool (184956)
UPDATE gameobject_template SET AIName='', ScriptName='go_strange_pool' WHERE entry=184956;

-- SPELL Spout (37430)
DELETE FROM spell_script_names WHERE spell_id IN(37430);
INSERT INTO spell_script_names VALUES(37430, 'spell_lurker_below_spout');

-- SPELL Spout (37433)
DELETE FROM spell_script_names WHERE spell_id IN(37433);
INSERT INTO spell_script_names VALUES(37433, 'spell_lurker_below_spout_cone');

-- Leotheras the Blind (21215)
DELETE FROM creature_text WHERE entry=21215;
INSERT INTO creature_text VALUES (21215, 0, 0, 'Finally, my banishment ends!', 14, 0, 100, 0, 0, 11312, 0, 'leotheras SAY_AGGRO');
INSERT INTO creature_text VALUES (21215, 1, 0, 'Be gone, trifling elf. I am in control now!', 14, 0, 100, 0, 0, 11304, 0, 'leotheras SAY_SWITCH_TO_DEMON');
INSERT INTO creature_text VALUES (21215, 2, 0, 'We all have our demons...', 14, 0, 100, 0, 0, 11305, 0, 'leotheras SAY_INNER_DEMONS');
INSERT INTO creature_text VALUES (21215, 3, 0, 'I have no equal.', 14, 0, 100, 0, 0, 11306, 0, 'leotheras SAY_DEMON_SLAY1');
INSERT INTO creature_text VALUES (21215, 3, 1, 'Perish, mortal.', 14, 0, 100, 0, 0, 11307, 0, 'leotheras SAY_DEMON_SLAY2');
INSERT INTO creature_text VALUES (21215, 3, 2, 'Yes, YES! Ahahah!', 14, 0, 100, 0, 0, 11308, 0, 'leotheras SAY_DEMON_SLAY3');
INSERT INTO creature_text VALUES (21215, 4, 0, 'Kill! KILL!', 14, 0, 100, 0, 0, 11314, 0, 'leotheras SAY_NIGHTELF_SLAY1');
INSERT INTO creature_text VALUES (21215, 4, 1, 'That''s right! Yes!', 14, 0, 100, 0, 0, 11315, 0, 'leotheras SAY_NIGHTELF_SLAY2');
INSERT INTO creature_text VALUES (21215, 4, 2, 'Who''s the master now?', 14, 0, 100, 0, 0, 11316, 0, 'leotheras SAY_NIGHTELF_SLAY3');
INSERT INTO creature_text VALUES (21215, 5, 0, 'No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can''t... contain him...', 14, 0, 100, 0, 0, 11313, 0, 'leotheras SAY_FINAL_FORM');
INSERT INTO creature_text VALUES (21215, 6, 0, 'You cannot kill me! Fools, I''ll be back! I''ll... aarghh...', 14, 0, 100, 0, 0, 11317, 0, 'leotheras SAY_DEATH');
UPDATE creature_template SET speed_walk=2, speed_run=2.4, dmg_multiplier=50, mechanic_immune_mask=650723199, flags_extra=1|256|0x200000, AIName='', ScriptName='boss_leotheras_the_blind' WHERE entry=21215;

-- Phantom Leotheras (21812)
UPDATE creature_template SET AIName='NullCreatureAI', ScriptName='' WHERE entry=21812;
DELETE FROM smart_scripts WHERE entryorguid=21812 AND source_type=0;

-- Inner Demon (21857)
REPLACE INTO creature_template_addon VALUES (21857, 0, 0, 0, 0, 0, '37716 37713');
UPDATE creature_template SET dmg_multiplier=20, AIName='', ScriptName='npc_inner_demon' WHERE entry=21857;

-- Shadow of Leotheras (21875)
DELETE FROM creature_text WHERE entry=21875;
INSERT INTO creature_text VALUES (21875, 1, 0, 'At last I am liberated. It has been too long since I have tasted true freedom!', 14, 0, 100, 0, 0, 11309, 0, 'leotheras SAY_FREE');
UPDATE creature_template SET speed_walk=2, speed_run=2.4, mechanic_immune_mask=650723199, AIName='SmartAI', ScriptName='' WHERE entry=21875;
DELETE FROM smart_scripts WHERE entryorguid=21875 AND source_type=0;
INSERT INTO smart_scripts VALUES (21875, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 37674, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Leotheras - In Combat - Cast Chaos Blast');
INSERT INTO smart_scripts VALUES (21875, 0, 1, 0, 60, 0, 100, 1, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Leotheras - On Update - Talk');

-- Greyheart Spellbinder (21806)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21806);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21806);
DELETE FROM creature WHERE id=21806;
UPDATE creature_template SET dmg_multiplier=17, AIName='SmartAI', ScriptName='' WHERE entry=21806;
DELETE FROM smart_scripts WHERE entryorguid=21806 AND source_type=0;
INSERT INTO smart_scripts VALUES (21806, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 2000, 3000, 11, 37531, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (21806, 0, 1, 0, 13, 0, 100, 0, 8000, 10000, 0, 0, 11, 39076, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - In Combat - Cast Spell Shock');
INSERT INTO smart_scripts VALUES (21806, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (21806, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 37626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - Out of Combat - Cast Green Beam');

-- SPELL Green Beam (37626)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=37626;
INSERT INTO conditions VALUES(13, 1, 37626, 0, 0, 31, 0, 3, 21215, 0, 0, 0, 0, '', 'Target Leotheras the Blind');

-- SPELL Whirlwind (37641)
DELETE FROM spell_script_names WHERE spell_id IN(37641);
INSERT INTO spell_script_names VALUES(37641, 'spell_leotheras_whirlwind');

-- SPELL Chaos Blast (37674)
DELETE FROM spell_script_names WHERE spell_id IN(37674);
INSERT INTO spell_script_names VALUES(37674, 'spell_leotheras_chaos_blast');

-- SPELL Insidious Whisper (37676)
DELETE FROM spell_script_names WHERE spell_id IN(37676);
INSERT INTO spell_script_names VALUES(37676, 'spell_leotheras_insidious_whisper');

-- SPELL Demon Link (37716)
DELETE FROM spell_script_names WHERE spell_id IN(37716);
INSERT INTO spell_script_names VALUES(37716, 'spell_leotheras_demon_link');

-- SPELL Clear Consuming Madness (37750)
DELETE FROM spell_script_names WHERE spell_id IN(37750);
INSERT INTO spell_script_names VALUES(37750, 'spell_leotheras_clear_consuming_madness');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=37750;
INSERT INTO conditions VALUES(13, 3, 37750, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
INSERT INTO conditions VALUES(13, 3, 37750, 0, 0, 1, 0, 37749, 0, 0, 0, 0, 0, '', 'Has Aura 37749 Effect 0');

-- Fathom-Lord Karathress (21214)
DELETE FROM creature_text WHERE entry=21214;
INSERT INTO creature_text VALUES (21214, 0, 0, 'Guards, attention! We have visitors...', 14, 0, 100, 0, 0, 11277, 0, 'karathress SAY_AGGRO');
INSERT INTO creature_text VALUES (21214, 1, 0, 'Your overconfidence will be your undoing! Guards, lend me your strength!', 14, 0, 100, 0, 0, 11278, 0, 'karathress SAY_GAIN_BLESSING');
INSERT INTO creature_text VALUES (21214, 2, 0, 'Go on, kill them! I''ll be the better for it!', 14, 0, 100, 0, 0, 11279, 0, 'karathress SAY_GAIN_ABILITY1');
INSERT INTO creature_text VALUES (21214, 2, 1, 'I am more powerful than ever!', 14, 0, 100, 0, 0, 11280, 0, 'karathress SAY_GAIN_ABILITY2');
INSERT INTO creature_text VALUES (21214, 2, 2, 'More knowledge, more power!', 14, 0, 100, 0, 0, 11281, 0, 'karathress SAY_GAIN_ABILITY3');
INSERT INTO creature_text VALUES (21214, 3, 0, 'Land-dwelling scum!', 14, 0, 100, 0, 0, 11282, 0, 'karathress SAY_SLAY1');
INSERT INTO creature_text VALUES (21214, 3, 1, 'Alana be''lendor!', 14, 0, 100, 0, 0, 11283, 0, 'karathress SAY_SLAY2');
INSERT INTO creature_text VALUES (21214, 3, 2, 'I am rid of you.', 14, 0, 100, 0, 0, 11284, 0, 'karathress SAY_SLAY3');
INSERT INTO creature_text VALUES (21214, 4, 0, 'Her ... excellency ... awaits!', 14, 0, 100, 0, 0, 11285, 0, 'karathress SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=50, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_fathomlord_karathress' WHERE entry=21214;

-- Fathom-Guard Caribdis (21964)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21964);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21964);
DELETE FROM creature WHERE id=21964;
UPDATE creature_template SET dmg_multiplier=30, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=21964;
DELETE FROM smart_scripts WHERE entryorguid=21964 AND source_type=0;
INSERT INTO smart_scripts VALUES (21964, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 35000, 35000, 11, 38337, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - In Combat - Cast Summon Cyclone');
INSERT INTO smart_scripts VALUES (21964, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 15000, 20000, 11, 38335, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - In Combat - Cast Water Bolt Volley');
INSERT INTO smart_scripts VALUES (21964, 0, 2, 0, 0, 0, 100, 0, 11000, 13000, 15000, 20000, 11, 38358, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - In Combat - Cast Tidal Surge');
INSERT INTO smart_scripts VALUES (21964, 0, 3, 0, 14, 0, 100, 0, 70000, 200, 15000, 15000, 11, 38330, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - Friendly Missing Health - Cast Healing Wave');
INSERT INTO smart_scripts VALUES (21964, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21964, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21964, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 38451, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Caribdis - On Death - Cast Power of Caribdis');

-- Cyclone (Karathress) (22104)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=22104);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=22104);
DELETE FROM creature WHERE id=22104;
REPLACE INTO creature_template_addon VALUES (22104, 0, 0, 0, 0, 0, '38516');
UPDATE creature_template SET speed_walk=4, unit_flags=33554432, AIName='NullCreatureAI', ScriptName='' WHERE entry=22104;
DELETE FROM smart_scripts WHERE entryorguid=22104 AND source_type=0;

-- Fathom-Guard Tidalvess (21965)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21965);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21965);
DELETE FROM creature WHERE id=21965;
REPLACE INTO creature_template_addon VALUES (21965, 0, 0, 0, 4097, 0, '38184');
UPDATE creature_template SET dmg_multiplier=30, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=21965;
DELETE FROM smart_scripts WHERE entryorguid=21965 AND source_type=0;
INSERT INTO smart_scripts VALUES (21965, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 15000, 20000, 11, 38234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (21965, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 30000, 30000, 11, 38304, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - In Combat - Cast Earthbind Totem');
INSERT INTO smart_scripts VALUES (21965, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 30000, 30000, 11, 38306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - In Combat - Cast Poison Cleansing Totem');
INSERT INTO smart_scripts VALUES (21965, 0, 3, 0, 0, 0, 100, 0, 25000, 25000, 30000, 30000, 11, 38236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - In Combat - Cast Spitfire Totem');
INSERT INTO smart_scripts VALUES (21965, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21965, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21965, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 38452, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Tidalvess - On Death - Cast Power of Tidalvess');

-- Greater Earthbind Totem (22104)
UPDATE creature_template SET spell1=6474, AIName='', ScriptName='' WHERE entry=22486;
DELETE FROM smart_scripts WHERE entryorguid=22486 AND source_type=0;

-- Greater Poison Cleansing Totem (22487)
UPDATE creature_template SET spell1=8172, AIName='', ScriptName='' WHERE entry=22487;
DELETE FROM smart_scripts WHERE entryorguid=22487 AND source_type=0;

-- Spitfire Totem (22091)
UPDATE creature_template SET unit_flags=4, spell1=8172, AIName='SmartAI', ScriptName='' WHERE entry=22091;
DELETE FROM smart_scripts WHERE entryorguid=22091 AND source_type=0;
INSERT INTO smart_scripts VALUES (22091, 0, 0, 0, 60, 0, 100, 0, 0, 0, 3000, 3000, 11, 38296, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spitfire Totem - In Combat - Cast Attack');

-- Fathom-Guard Sharkkis (21966)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21966);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21966);
DELETE FROM creature WHERE id=21966;
UPDATE creature_template SET dmg_multiplier=30, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=21966;
DELETE FROM smart_scripts WHERE entryorguid=21966 AND source_type=0;
INSERT INTO smart_scripts VALUES (21966, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 38374, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Hurl Trident');
INSERT INTO smart_scripts VALUES (21966, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 12000, 16000, 11, 29436, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Leeching Throw');
INSERT INTO smart_scripts VALUES (21966, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 20000, 20000, 11, 38366, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Multi-Toss');
INSERT INTO smart_scripts VALUES (21966, 0, 3, 0, 0, 0, 50, 1, 5000, 5000, 0, 0, 11, 38431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Summon Fathom Sporebat');
INSERT INTO smart_scripts VALUES (21966, 0, 4, 0, 0, 0, 100, 1, 6000, 6000, 0, 0, 11, 38433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Summon Fathom Lurker');
INSERT INTO smart_scripts VALUES (21966, 0, 5, 6, 0, 0, 100, 0, 20000, 25000, 35000, 40000, 11, 38373, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast The Beast Within');
INSERT INTO smart_scripts VALUES (21966, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 38371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - In Combat - Cast Bestial Wrath');
INSERT INTO smart_scripts VALUES (21966, 0, 7, 8, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21966, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (21966, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 38455, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fathom-Guard Sharkkis - On Death - Cast Power of Sharkkis');

-- Fathom Lurker (22119)
REPLACE INTO creature_template_addon VALUES (22119, 0, 0, 0, 0, 0, '21737');
UPDATE creature_template SET dmg_multiplier=15, mechanic_immune_mask=650854271, AIName='', ScriptName='' WHERE entry=22119;
DELETE FROM smart_scripts WHERE entryorguid=22119 AND source_type=0;

-- Fathom Sporebat (22120)
REPLACE INTO creature_template_addon VALUES (22120, 0, 0, 0, 0, 0, '21737');
UPDATE creature_template SET dmg_multiplier=15, mechanic_immune_mask=650854271, AIName='', ScriptName='' WHERE entry=22120;
DELETE FROM smart_scripts WHERE entryorguid=22120 AND source_type=0;

-- SPELL Cataclysmic Bolt (38441)
DELETE FROM spell_script_names WHERE spell_id IN(38441);
INSERT INTO spell_script_names VALUES(38441, 'spell_gen_50pct_count_pct_from_max_hp');

-- SPELL Blessing of the Tides (38449)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38449;
INSERT INTO conditions VALUES(13, 7, 38449, 0, 0, 31, 0, 3, 21214, 0, 0, 0, 0, '', 'Target Fathom-Lord Karathress');

-- SPELL Power of Caribdis (38451)
-- SPELL Power of Tidalvess (38452)
-- SPELL Power of Sharkkis (38455)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(38451, 38452, 38455);
INSERT INTO conditions VALUES(13, 1, 38451, 0, 0, 31, 0, 3, 21214, 0, 0, 0, 0, '', 'Target Fathom-Lord Karathress');
INSERT INTO conditions VALUES(13, 1, 38452, 0, 0, 31, 0, 3, 21214, 0, 0, 0, 0, '', 'Target Fathom-Lord Karathress');
INSERT INTO conditions VALUES(13, 1, 38455, 0, 0, 31, 0, 3, 21214, 0, 0, 0, 0, '', 'Target Fathom-Lord Karathress');
DELETE FROM spell_script_names WHERE spell_id IN(38451);
INSERT INTO spell_script_names VALUES(38451, 'spell_karathress_power_of_caribdis');

-- SPELL Tidal Surge (38358)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(38358, -38358);
INSERT INTO spell_linked_spell VALUES (38358, 38353, 1, 'Tidal Surge - Karathress - Serpentshrine Cavern');
DELETE FROM spell_script_names WHERE spell_id IN(38358);

-- SPELL Bestial Wrath (38371)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38371;
INSERT INTO conditions VALUES(13, 7, 38371, 0, 0, 31, 0, 3, 22119, 0, 0, 0, 0, '', 'Target Fathom Lurker');
INSERT INTO conditions VALUES(13, 7, 38371, 0, 0, 31, 0, 3, 22120, 0, 0, 0, 0, '', 'Target Fathom Sporebat');

-- GO Cage (185952)
DELETE FROM gameobject WHERE id=185952 AND map=542;
INSERT INTO gameobject VALUES (NULL, 185952, 548, 1, 1, 448.374, -544.713, -7.54634, 4.71681, 0, 0, 0.7, -0.7, 300, 0, 1, 0);

-- Morogrim Tidewalker (21213)
UPDATE creature SET orientation=3.14 WHERE id=21213;
DELETE FROM creature_text WHERE entry=21213;
INSERT INTO creature_text VALUES (21213, 0, 0, 'Flood of the deep, take you!', 14, 0, 100, 0, 0, 11321, 0, 'morogrim SAY_AGGRO');
INSERT INTO creature_text VALUES (21213, 1, 0, 'By the Tides, kill them at once!', 14, 0, 100, 0, 0, 11322, 0, 'morogrim SAY_SUMMON1');
INSERT INTO creature_text VALUES (21213, 1, 1, 'Destroy them my subjects!', 14, 0, 100, 0, 0, 11323, 0, 'morogrim SAY_SUMMON2');
INSERT INTO creature_text VALUES (21213, 2, 0, 'There is nowhere to hide!', 14, 0, 100, 0, 0, 11324, 0, 'morogrim SAY_SUMMON_BUBLE1');
INSERT INTO creature_text VALUES (21213, 2, 1, 'Soon it will be finished!', 14, 0, 100, 0, 0, 11325, 0, 'morogrim SAY_SUMMON_BUBLE2');
INSERT INTO creature_text VALUES (21213, 3, 0, 'It is done!', 14, 0, 100, 0, 0, 11326, 0, 'morogrim SAY_SLAY1');
INSERT INTO creature_text VALUES (21213, 3, 1, 'Strugging only makes it worse.', 14, 0, 100, 0, 0, 11327, 0, 'morogrim SAY_SLAY2');
INSERT INTO creature_text VALUES (21213, 3, 2, 'Only the strong survive.', 14, 0, 100, 0, 0, 11328, 0, 'morogrim SAY_SLAY3');
INSERT INTO creature_text VALUES (21213, 4, 0, 'Great... currents of... Ageon.', 14, 0, 100, 0, 0, 11329, 0, 'morogrim SAY_DEATH');
INSERT INTO creature_text VALUES (21213, 5, 0, '%s sends his enemies to their watery graves!', 41, 0, 100, 0, 0, 0, 0, 'morogrim EMOTE_WATERY_GRAVE');
INSERT INTO creature_text VALUES (21213, 6, 0, 'The violent earthquake has alerted nearby murlocs!', 41, 0, 100, 0, 0, 0, 0, 'morogrim EMOTE_EARTHQUAKE');
INSERT INTO creature_text VALUES (21213, 7, 0, '%s summons Watery Globules!', 41, 0, 100, 0, 0, 0, 0, 'morogrim EMOTE_WATERY_GLOBULES');
UPDATE creature_template SET dmg_multiplier=60, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_morogrim_tidewalker' WHERE entry=21213;

-- Tidewalker Lurker (21920)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21920);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21920);
DELETE FROM creature WHERE id=21920;
UPDATE creature_template SET speed_run=1.6, dmg_multiplier=17, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=21920;
DELETE FROM smart_scripts WHERE entryorguid=21920 AND source_type=0;
INSERT INTO smart_scripts VALUES (21920, 0, 0, 0, 0, 0, 100, 0, 6000, 10000, 10000, 10000, 11, 41932, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Lurker - In Combat - Cast Carnivorous Bite');

-- Water Globule (21913)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=21913);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21913);
DELETE FROM creature WHERE id=21913;
UPDATE creature_template SET speed_walk=0.5, speed_run=0.5, faction=14, unit_flags=33554432, AIName='SmartAI', ScriptName='' WHERE entry=21913;
DELETE FROM smart_scripts WHERE entryorguid=21913 AND source_type=0;
INSERT INTO smart_scripts VALUES (21913, 0, 0, 0, 0, 0, 100, 0, 0, 0, 5000, 5000, 11, 39848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Water Globule - In Combat - Cast Water Globule New Target');
INSERT INTO smart_scripts VALUES (21913, 0, 1, 0, 0, 0, 100, 0, 0, 0, 500, 500, 11, 37871, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Water Globule - In Combat - Cast Freeze');
INSERT INTO smart_scripts VALUES (21913, 0, 2, 0, 31, 0, 100, 0, 37871, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Water Globule - Spell Hit Target - Despawn');

-- SPELL Watery Grave (38028)
-- SPELL Watery Grave (37850, 38023, 38024, 38025)
DELETE FROM spell_script_names WHERE spell_id IN(38028);
INSERT INTO spell_script_names VALUES(38028, 'spell_morogrim_tidewalker_watery_grave');
DELETE FROM spell_target_position WHERE id IN(37850, 38023, 38024, 38025);
INSERT INTO spell_target_position VALUES (37850, 0, 548, 372.85, -690.84, -13.91, 3.61);
INSERT INTO spell_target_position VALUES (38023, 0, 548, 366.27, -709.4, -13.92, 3.82);
INSERT INTO spell_target_position VALUES (38024, 0, 548, 365.53, -737.12, -14, 2.88);
INSERT INTO spell_target_position VALUES (38025, 0, 548, 337.69, -732.87, -13.74, 1.06);

-- SPELL Summon Murloc (39813 - 39822)
DELETE FROM spell_target_position WHERE id IN(39813, 39814, 39815, 39816, 39817, 39818, 39819, 39820, 39821, 39822);
INSERT INTO spell_target_position VALUES (39813, 0, 548, 424.84, -732.18, -7.14, 3.13);
INSERT INTO spell_target_position VALUES (39814, 0, 548, 424.91, -728.68, -7.14, 3.13);
INSERT INTO spell_target_position VALUES (39815, 0, 548, 425.05, -724.23, -7.14, 3.13);
INSERT INTO spell_target_position VALUES (39816, 0, 548, 425.13, -719.31, -7.14, 3.13);
INSERT INTO spell_target_position VALUES (39817, 0, 548, 424.36, -715.4, -7.14, 3.13);
INSERT INTO spell_target_position VALUES (39818, 0, 548, 321.05, -714.24, -13.15, 0);
INSERT INTO spell_target_position VALUES (39819, 0, 548, 321.05, -718.73, -13.15, 0);
INSERT INTO spell_target_position VALUES (39820, 0, 548, 321.05, -724.03, -13.15, 0);
INSERT INTO spell_target_position VALUES (39821, 0, 548, 321.05, -729.37, -13.15, 0);
INSERT INTO spell_target_position VALUES (39822, 0, 548, 321.05, -734.2, -13.15, 0);

-- SPELL Summon Water Globule (37854, 37858, 37860, 37861)
DELETE FROM spell_target_position WHERE id IN(37854, 37858, 37860, 37861);
INSERT INTO spell_target_position VALUES (37854, 0, 548, 372.85, -690.84, -13.91, 3.61);
INSERT INTO spell_target_position VALUES (37858, 0, 548, 366.27, -709.4, -13.92, 3.82);
INSERT INTO spell_target_position VALUES (37860, 0, 548, 365.53, -737.12, -14, 2.88);
INSERT INTO spell_target_position VALUES (37861, 0, 548, 337.69, -732.87, -13.74, 1.06);

-- SPELL Water Globule New Target (39848)
DELETE FROM spell_script_names WHERE spell_id IN(39848);
INSERT INTO spell_script_names VALUES(39848, 'spell_morogrim_tidewalker_water_globule_new_target');

-- Lady Vashj (21212)
DELETE FROM creature_text WHERE entry=21212;
INSERT INTO creature_text VALUES (21212, 0, 0, 'Water is life. It has become a rare commodity here in Outland. A commodity that we alone shall control. We are the Highborne, and the time has come at last for us to retake our rightful place in the world!', 14, 0, 100, 0, 0, 11531, 0, 'vashj SAY_INTRO');
INSERT INTO creature_text VALUES (21212, 1, 0, 'I''ll split you from stem to stern!', 14, 0, 100, 0, 0, 11532, 0, 'vashj SAY_AGGRO1');
INSERT INTO creature_text VALUES (21212, 1, 1, 'Victory to Lord Illidan!', 14, 0, 100, 0, 0, 11533, 0, 'vashj SAY_AGGRO2');
INSERT INTO creature_text VALUES (21212, 1, 2, 'I spit on you, surface filth!', 14, 0, 100, 0, 0, 11534, 0, 'vashj SAY_AGGRO3');
INSERT INTO creature_text VALUES (21212, 1, 3, 'Death to the outsiders!', 14, 0, 100, 0, 0, 11535, 0, 'vashj SAY_AGGRO4');
INSERT INTO creature_text VALUES (21212, 2, 0, 'I did not wish to lower myself by engaging your kind, but you leave me little choice!', 14, 0, 100, 0, 0, 11538, 0, 'vashj SAY_PHASE1');
INSERT INTO creature_text VALUES (21212, 3, 0, 'The time is now! Leave none standing!', 14, 0, 100, 0, 0, 11539, 0, 'vashj SAY_PHASE2');
INSERT INTO creature_text VALUES (21212, 4, 0, 'You may want to take cover.', 14, 0, 100, 0, 0, 11540, 0, 'vashj SAY_PHASE3');
INSERT INTO creature_text VALUES (21212, 5, 0, 'Straight to the heart!', 14, 0, 100, 0, 0, 11536, 0, 'vashj SAY_BOWSHOT1');
INSERT INTO creature_text VALUES (21212, 5, 1, 'Seek your mark!', 14, 0, 100, 0, 0, 11537, 0, 'vashj SAY_BOWSHOT2');
INSERT INTO creature_text VALUES (21212, 6, 0, 'Your time ends now!', 14, 0, 100, 0, 0, 11541, 0, 'vashj SAY_SLAY1');
INSERT INTO creature_text VALUES (21212, 6, 1, 'You have failed!', 14, 0, 100, 0, 0, 11542, 0, 'vashj SAY_SLAY2');
INSERT INTO creature_text VALUES (21212, 6, 2, 'Be''lamere an''delay!', 14, 0, 100, 0, 0, 11543, 0, 'vashj SAY_SLAY3');
INSERT INTO creature_text VALUES (21212, 7, 0, 'Lord Illidan, I... I am... sorry.', 14, 0, 100, 0, 0, 11544, 0, 'vashj SAY_DEATH');
REPLACE INTO creature_template_addon VALUES (21212, 0, 0, 0, 4098, 0, '');
UPDATE creature_template SET speed_run=1.6, dmg_multiplier=60, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_lady_vashj' WHERE entry=21212;

-- Coilfang Raid Control Emote Stalker (22057)
DELETE FROM creature WHERE id=22057;
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 69.5759, -838.982, 21.1635, 6.00179, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 56.1265, -835.094, 21.0031, 6.00179, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 42.7444, -831.226, 20.8436, 6.00179, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 29.4914, -829.095, 21.5683, 0.221255, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 18.0864, -831.66, 21.2914, 0.221255, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 0.944709, -835.516, 20.8753, 0.221255, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -9.29933, -837.82, 20.6267, 0.130934, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -55.5091, -883.074, 20.6226, 1.1221, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -59.7429, -894.235, 19.922, 1.1221, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -61.9605, -905.143, 20.4343, 6.06225, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 80.2419, -844.618, 21.4215, 5.43238, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 90.2522, -855.334, 21.7127, 5.4638, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 99.8573, -865.615, 21.9921, 5.4638, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 108.018, -872.967, 21.658, 5.25566, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 112.9, -887.467, 22.4698, 5.25566, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 119.022, -943.308, 21.4458, 4.32497, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 115.17, -953.076, 22.1427, 4.33675, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 110.907, -963.885, 22.9141, 4.33675, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 105.334, -978.016, 21.0516, 4.33675, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 98.0218, -983.891, 21.6457, 3.81838, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 86.7892, -995.579, 21.4576, 3.81838, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 76.7481, -1003.65, 22.2734, 3.81838, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 65.2315, -1008.35, 21.5371, 3.36678, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 52.7449, -1011.21, 21.8111, 3.36678, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 40.2583, -1014.07, 22.085, 3.36678, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 27.7717, -1016.93, 21.7621, 3.36678, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, 10.8429, -1012.54, 21.6831, 2.85627, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -2.52387, -1008.62, 21.8745, 2.85627, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -14.983, -1005.36, 21.8261, 2.4243, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -26.2718, -995.2, 22.0379, 2.40859, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -38.4449, -984.24, 21.5365, 2.40859, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
INSERT INTO creature VALUES (NULL, 22057, 548, 1, 1, 0, 0, -51.9814, -970.032, 21.6648, 2.40859, 300, 0, 0, 30, 0, 0, 0, 33554432, 0);
UPDATE creature_template SET faction=35, InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=22057;
DELETE FROM smart_scripts WHERE entryorguid=22057 AND source_type=0;
INSERT INTO smart_scripts VALUES (22057, 0, 0, 0, 8, 0, 100, 0, 38017, 0, 0, 0, 11, 38019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Raid Control Emote Stalker - On Spell Hit - Cast Summon Wave A Mob');
INSERT INTO smart_scripts VALUES (22057, 0, 1, 0, 8, 0, 100, 0, 38248, 0, 0, 0, 11, 38247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Raid Control Emote Stalker - On Spell Hit - Cast Summon Wave B Mob');
INSERT INTO smart_scripts VALUES (22057, 0, 2, 0, 8, 0, 100, 0, 38241, 0, 0, 0, 11, 38242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Raid Control Emote Stalker - On Spell Hit - Cast Summon Wave C Mob');
INSERT INTO smart_scripts VALUES (22057, 0, 3, 0, 8, 0, 100, 0, 38140, 0, 0, 0, 11, 38244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Raid Control Emote Stalker - On Spell Hit - Cast Summon Wave D Mob');

-- Enchanted Elemental (21958)
UPDATE creature_template SET flags_extra=2, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=21958;
DELETE FROM smart_scripts WHERE entryorguid=21958 AND source_type=0;
INSERT INTO smart_scripts VALUES (21958, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Elemental - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (21958, 0, 1, 0, 34, 0, 100, 0, 14, 0, 0, 0, 11, 38044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Elemental - Movement Inform - Cast Spell');
INSERT INTO smart_scripts VALUES (21958, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Enchanted Elemental - On Aggro - Set In Combat With Zone');

-- Coilfang Elite (22055)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=22055;
DELETE FROM smart_scripts WHERE entryorguid=22055 AND source_type=0;
INSERT INTO smart_scripts VALUES (22055, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (22055, 0, 1, 0, 0, 0, 100, 0, 7000, 8000, 8000, 10000, 11, 38260, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (22055, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 8000, 10000, 11, 38262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (22055, 0, 3, 0, 34, 0, 100, 0, 8, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - Movement Inform - Set In Combat With Zone');

-- Coilfang Strider (22056)
REPLACE INTO creature_template_addon VALUES (22056, 0, 0, 0, 0, 0, '38257');
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=22056;
DELETE FROM smart_scripts WHERE entryorguid=22056 AND source_type=0;
INSERT INTO smart_scripts VALUES (22056, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - On Aggro - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (22056, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 38259, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - In Combat - Cast Mind Blast');
INSERT INTO smart_scripts VALUES (22056, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - Movement Inform - Set In Combat With Zone');

-- Tainted Elemental (22009)
UPDATE creature_template SET unit_flags=4, dmg_multiplier=20, mechanic_immune_mask=650854271, AIName='SmartAI', ScriptName='' WHERE entry=22009;
DELETE FROM smart_scripts WHERE entryorguid=22009 AND source_type=0;
INSERT INTO smart_scripts VALUES (22009, 0, 0, 0, 60, 0, 100, 1, 100, 100, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - On Reset - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (22009, 0, 1, 0, 60, 0, 100, 0, 100, 500, 2000, 2000, 11, 38253, 0, 0, 0, 0, 0, 5, 200, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - In Combat - Cast Poison Bolt');
INSERT INTO smart_scripts VALUES (22009, 0, 2, 0, 60, 0, 100, 257, 15000, 15000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - On Update - Despawn');

-- Toxic Sporebat (22140)
REPLACE INTO creature_model_info VALUES (20828, 5, 6, 2, 0);
REPLACE INTO creature_template_addon VALUES (22140, 0, 0, 0, 0, 0, '38571');
UPDATE creature_template SET InhabitType=4, mechanic_immune_mask=650854271, AIName='NullCreatureAI', ScriptName='' WHERE entry=22140;
DELETE FROM smart_scripts WHERE entryorguid=22140 AND source_type=0;

-- Spore Drop Trigger (22207)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=22207;
DELETE FROM smart_scripts WHERE entryorguid=22207 AND source_type=0;
INSERT INTO smart_scripts VALUES (22207, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 11, 38575, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spore Drop Trigger - On Reset - Cast Toxic Spores');

-- Invis KV Shield Generator (19870)
UPDATE creature_template SET flags_extra=130, AIName='', ScriptName='' WHERE entry=19870;

-- ITEM Tained Core (31088)
UPDATE item_template SET spellid_3=38132, spelltrigger_3=5, ScriptName='', flagsCustom=flagsCustom|1 WHERE entry=31088;

-- GO Shield Generator (185051, 185052, 185053, 185054)
UPDATE gameobject_template SET flags=16, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(185051, 185052, 185053, 185054);
DELETE FROM smart_scripts WHERE entryorguid IN(185051, 185052, 185053, 185054) AND source_type=1;
INSERT INTO smart_scripts VALUES(185051, 1, 0, 1, 8, 0, 100, 0, 3366, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Despawn Trigger");
INSERT INTO smart_scripts VALUES(185051, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Set GO Flags");
INSERT INTO smart_scripts VALUES(185052, 1, 0, 1, 8, 0, 100, 0, 3366, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Despawn Trigger");
INSERT INTO smart_scripts VALUES(185052, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Set GO Flags");
INSERT INTO smart_scripts VALUES(185053, 1, 0, 1, 8, 0, 100, 0, 3366, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Despawn Trigger");
INSERT INTO smart_scripts VALUES(185053, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Set GO Flags");
INSERT INTO smart_scripts VALUES(185054, 1, 0, 1, 8, 0, 100, 0, 3366, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 12999, 10, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Despawn Trigger");
INSERT INTO smart_scripts VALUES(185054, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shield Generator - On Spell Hit - Set GO Flags");
DELETE FROM gameobject WHERE id IN(185051, 185052, 185053, 185054);
INSERT INTO gameobject VALUES (47485, 185053, 548, 1, 1, 7.417, -901.109, 44, 2.29077, 0, 0, 0, 0, 7200, 0, 1, 0);
INSERT INTO gameobject VALUES (47484, 185051, 548, 1, 1, 7.81, -945.244, 44, 5.99871, 0, 0, 0, 0, 7200, 0, 1, 0);
INSERT INTO gameobject VALUES (47482, 185052, 548, 1, 1, 52.048, -901.236, 44, 3.02393, 0, 0, 0, 0, 7200, 0, 1, 0);
INSERT INTO gameobject VALUES (47483, 185054, 548, 1, 1, 52.448, -944.825, 44, 3.48714, 0, 0, 0, 0, 7200, 0, 1, 0);

-- SPELL Magic Barrier (38112)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38112;
INSERT INTO conditions VALUES(13, 1, 38112, 0, 0, 31, 0, 3, 21212, 0, 0, 0, 0, '', 'Target Lady Vashj');
DELETE FROM spell_script_names WHERE spell_id IN(38112);
INSERT INTO spell_script_names VALUES(38112, 'spell_lady_vashj_magic_barrier');

-- SPELL Wave A - 1 (38017) Enchanced
-- SPELL Summon Wave B Mob Trigger (38248) Elite
-- SPELL Summon Wave C Mob Trigger (38241) Strider
-- SPELL Summon Wave D Mob Trigger (38140) Tainted
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(38017, 38248, 38241, 38140);
INSERT INTO conditions VALUES(13, 1, 38017, 0, 0, 31, 0, 3, 22057, 0, 0, 0, 0, '', 'Target Coilfang Raid Control Emote Stalker');
INSERT INTO conditions VALUES(13, 1, 38248, 0, 0, 31, 0, 3, 22057, 0, 0, 0, 0, '', 'Target Coilfang Raid Control Emote Stalker');
INSERT INTO conditions VALUES(13, 1, 38241, 0, 0, 31, 0, 3, 22057, 0, 0, 0, 0, '', 'Target Coilfang Raid Control Emote Stalker');
INSERT INTO conditions VALUES(13, 1, 38140, 0, 0, 31, 0, 3, 22057, 0, 0, 0, 0, '', 'Target Coilfang Raid Control Emote Stalker');
DELETE FROM spell_script_names WHERE spell_id IN(38017, 38248, 38241, 38140);
INSERT INTO spell_script_names VALUES(38017, 'spell_gen_select_target_count_7_1');
INSERT INTO spell_script_names VALUES(38248, 'spell_gen_select_target_count_7_1');
INSERT INTO spell_script_names VALUES(38241, 'spell_gen_select_target_count_7_1');
INSERT INTO spell_script_names VALUES(38140, 'spell_gen_select_target_count_7_1');

-- SPELL Surge (38044)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38044;
INSERT INTO conditions VALUES(13, 3, 38044, 0, 0, 31, 0, 3, 21212, 0, 0, 0, 0, '', 'Target Lady Vashj');

-- SPELL Remove Tainted Cores (39495)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39495;
INSERT INTO conditions VALUES(13, 1, 39495, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
DELETE FROM spell_script_names WHERE spell_id IN(39495);
INSERT INTO spell_script_names VALUES(39495, 'spell_lady_vashj_remove_tainted_cores');

-- SPELL Summon Wave E Mob (38494)
DELETE FROM spell_script_names WHERE spell_id IN(38494);
INSERT INTO spell_script_names VALUES(38494, 'spell_lady_vashj_summon_sporebat');

-- SPELL Summon Wave E Mob (38489, 38490, 38492, 38493)
DELETE FROM spell_target_position WHERE id IN(38489, 38490, 38492, 38493);
INSERT INTO spell_target_position VALUES (38489, 0, 548, 29.41, -924.12, 80.0, 1.58);
INSERT INTO spell_target_position VALUES (38490, 0, 548, -7.64, -939.99, 80.74, 0.36);
INSERT INTO spell_target_position VALUES (38492, 0, 548, 19.94, -878.03, 80.00, 4.88);
INSERT INTO spell_target_position VALUES (38493, 0, 548, 29.68, -923.58, 80.00, 6.0);

-- SPELL Spore Drop Effect (38573)
DELETE FROM spell_script_names WHERE spell_id IN(38573);
INSERT INTO spell_script_names VALUES(38573, 'spell_gen_select_target_count_15_1');
INSERT INTO spell_script_names VALUES(38573, 'spell_lady_vashj_spore_drop_effect');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- SPELL Lurker Spawn Trigger (54587)
DELETE FROM event_scripts WHERE id=13891;

-- SPELL Coilfang Water (37025), custom
DELETE FROM spell_script_names WHERE spell_id=37025;
INSERT INTO spell_script_names VALUES(37025, 'spell_serpentshrine_cavern_coilfang_water');

-- Coilfang Frenzy (21508)
UPDATE creature_template SET dmg_multiplier=7, AIName='SmartAI', ScriptName='' WHERE entry=21508;
DELETE FROM smart_scripts WHERE entryorguid=21508 AND source_type=0;
INSERT INTO smart_scripts VALUES (21508, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Coilfang Frenzy - On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (21508, 0, 1, 0, 1, 0, 100, 1, 5000, 5000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Frenzy - Out of Combat - Despawn');

-- Coilfang Frenzy Corpse (21689)
DELETE FROM creature WHERE id=21689;
INSERT INTO creature VALUES (NULL, 21689, 548, 1, 1, 0, 0, 198.36, -552.511, -21.4055, 5.72656, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 214.981, -586.016, -21.4055, 4.65057, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -258.968, -445.696, -21.5395, 0.0402799, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -224.122, -439.465, -21.5395, 0.142382, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -218.912, -474.772, -21.5395, 4.59559, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -254.729, -483.352, -21.4491, 3.56672, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -270.384, -506.478, -21.4491, 4.78016, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -244.014, -521.792, -21.4491, 6.22135, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -230.673, -539.595, -21.4491, 4.76052, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -217.964, -565.057, -21.4491, 5.68729, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -212.621, -594.511, -21.4491, 4.31285, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -205.21, -619.305, -21.4491, 5.85222, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -183.344, -641.128, -21.4491, 5.11395, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -150.599, -653.76, -21.4491, 0.315159, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -122.105, -668.116, -21.4491, 5.31815, 300, 0, 0, 81000, 0, 0, 0, 0, 0),
(NULL, 21689, 548, 1, 1, 0, 0, -101.676, -678.765, -21.4491, 0.00492859, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -71.9136, -688.426, -21.4491, 5.58126, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -31.1696, -693.305, -21.4491, 0.393701, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -4.2635, -693.49, -21.4491, 6.12711, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 30.6635, -682.053, -21.4491, 0.735349, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 61.8101, -674.423, -21.4491, 6.18209, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 91.4373, -664.54, -21.4491, 0.833525, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 124.413, -646.547, -21.4491, 0.122739, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 146.153, -633.324, -21.4491, 1.24979, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 144.025, -600.631, -21.4491, 2.37683, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 111.023, -578.715, -21.4056, 2.78524, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 87.1302, -558.304, -21.4066, 2.07445, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 63.04, -535.776, -21.4051, 2.66743, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 37.4493, -531.662, -21.4055, 3.15438, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 3.29256, -536.527, -21.4055, 3.27611, 300, 0, 0, 81000, 0, 0, 0, 0, 0),
(NULL, 21689, 548, 1, 1, 0, 0, -30.4126, -532.165, -21.4055, 2.7656, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -64.5079, -511.419, -21.4055, 2.5182, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -82.6461, -486.875, -21.4055, 2.01162, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -83.8641, -457.883, -21.4055, 1.3833, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -65.5718, -422.496, -21.4055, 0.65681, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -44.0873, -419.224, -21.4055, 0.0559799, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -3.67263, -422.501, -21.4055, 0.499731, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -24.7269, -410.295, -21.4041, 2.29829, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -32.851, -380.626, -21.4041, 1.61107, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -44.2002, -354.356, -21.4055, 2.37291, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -78.4844, -332.585, -21.4055, 2.63209, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -94.3336, -313.866, -21.4048, 2.0666, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -90.5592, -281.989, -21.4058, 0.923846, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -66.0375, -265.537, -21.4058, 0.429045, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -39.0777, -242.078, -21.4058, 1.077, 300, 0, 0, 81000, 0, 0, 0, 0, 0),
(NULL, 21689, 548, 1, 1, 0, 0, -16.7655, -232.354, -21.4055, 6.17816, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 15.852, -249.363, -21.4052, 5.47916, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 23.682, -284.058, -21.4052, 4.76446, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 55.3898, -283.936, -21.4056, 0.103115, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 83.0142, -272.371, -21.4056, 0.625405, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 108.886, -274.824, -21.4056, 6.13105, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 137.654, -264.116, -21.4049, 0.723578, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 161.3, -252.422, -21.4049, 6.27634, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 185.027, -274.36, -21.4055, 5.07862, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 176.104, -301.574, -21.4055, 4.12436, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 148.24, -325.095, -21.4055, 3.66883, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 121.219, -349.36, -21.4055, 3.96729, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 108.406, -367.148, -21.4055, 3.96336, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 107.689, -403.782, -21.4055, 5.27497, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 134.583, -421.714, -21.4055, 5.97789, 300, 0, 0, 81000, 0, 0, 0, 0, 0),
(NULL, 21689, 548, 1, 1, 0, 0, 150.501, -437.545, -21.4055, 4.40317, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 134.244, -472.857, -21.4055, 4.22646, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 122.764, -500.83, -21.4055, 4.48956, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 134.278, -531.883, -21.4055, 5.52628, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 167.335, -537.232, -21.4055, 0.213059, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 186.388, -614.448, -21.4056, 3.76307, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 166.832, -647.301, -21.4056, 3.91623, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 107.691, -605.214, -21.4056, 2.36899, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, 42.3599, -586.454, -21.4845, 2.91484, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -9.91757, -566.916, -21.4845, 3.25649, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -55.166, -548.193, -21.4845, 2.51429, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -83.9361, -546.037, -21.4845, 3.37038, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -124.06, -534.828, -21.4845, 3.04443, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -159.327, -531.587, -21.4845, 3.04443, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -185.307, -502.633, -21.4845, 1.77994, 300, 0, 0, 81000, 0, 0, 0, 0, 0),
(NULL, 21689, 548, 1, 1, 0, 0, -190.502, -459.573, -21.4845, 1.52469, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -186.692, -417.738, -21.4845, 1.37154, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -160.676, -362.251, -21.4845, 1.03774, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -136.571, -325.019, -21.4845, 1.08879, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -125.636, -296.87, -21.4845, 1.33619, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -123.904, -252.683, -21.4845, 1.83885, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -132.099, -218.245, -21.4845, 1.77209, 300, 0, 0, 81000, 0, 0, 0, 0, 0),(NULL, 21689, 548, 1, 1, 0, 0, -147.005, -189.46, -21.4845, 2.32972, 300, 0, 0, 81000, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (21689, 0, 0, 7, 0, 0, '37284 35357');
UPDATE creature_template SET InhabitType=2, AIName='SmartAI', ScriptName='' WHERE entry=21689;
DELETE FROM smart_scripts WHERE entryorguid=21689 AND source_type=0;
INSERT INTO smart_scripts VALUES (21689, 0, 0, 0, 60, 0, 100, 0, 0, 0, 5000, 5000, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Frenzy - On Update - Set Visible');
INSERT INTO smart_scripts VALUES (21689, 0, 1, 0, 60, 0, 100, 0, 0, 0, 5000, 5000, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Frenzy - On Update - Set Visible');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=21689;
INSERT INTO conditions VALUES(22, 1, 21689, 0, 0, 13, 1, 1, 3, 2, 0, 0, 0, '', 'Instance Boss State of 1 is DONE');
INSERT INTO conditions VALUES(22, 1, 21689, 0, 1, 13, 1, 22, 0, 0, 1, 0, 0, '', 'Instance DATA of 22 is not 0');
INSERT INTO conditions VALUES(22, 2, 21689, 0, 0, 13, 1, 1, 3, 2, 1, 0, 0, '', 'Instance Boss State of 1 is not DONE');
INSERT INTO conditions VALUES(22, 2, 21689, 0, 0, 13, 1, 22, 0, 0, 0, 0, 0, '', 'Instance DATA of 22 is 0');

-- Running murlocs
DELETE FROM creature_formations WHERE leaderGUID IN(SELECT guid FROM creature WHERE id IN(21224, 21225, 21226, 21227, 21228));
DELETE FROM creature_formations WHERE memberGUID IN(SELECT guid FROM creature WHERE id IN(21224, 21225, 21226, 21227, 21228));
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id IN(21224, 21225, 21226, 21227, 21228));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(21224, 21225, 21226, 21227, 21228));
DELETE FROM creature WHERE id IN(21224, 21225, 21226, 21227, 21228);
INSERT INTO creature VALUES (239000, 21225, 548, 1, 1, 0, 1, 323.124, -693.561, -13.1582, 5.40896, 604800, 0, 0, 125668, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (239001, 21225, 548, 1, 1, 0, 1, 402.817, -689.056, -7.27268, 0.00149155, 604800, 0, 0, 125668, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (239002, 21225, 548, 1, 1, 0, 1, 437.805, -755.739, -7.14427, 2.58939, 604800, 0, 0, 125668, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (239003, 21225, 548, 1, 1, 0, 1, 322.69, -759.26, -13.1582, 0.225338, 604800, 0, 0, 125668, 0, 2, 0, 0, 0);
INSERT INTO creature VALUES (93895, 21226, 548, 1, 1, 0, 0, 326.268, -765.24, -13.1582, 0.233202, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93894, 21226, 548, 1, 1, 0, 0, 442.843, -756.602, -7.14468, 2.71113, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93893, 21226, 548, 1, 1, 0, 0, 315.683, -691.921, -13.1581, 6.0246, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93892, 21224, 548, 1, 1, 0, 0, 316.522, -685.735, -13.1581, 5.52901, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93891, 21224, 548, 1, 1, 0, 0, 323.797, -763.389, -13.1581, 0.722376, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93890, 21224, 548, 1, 1, 0, 0, 320.842, -682.937, -13.1582, 5.75847, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93889, 21224, 548, 1, 1, 0, 0, 442.695, -752.678, -7.1443, 2.90578, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93888, 21224, 548, 1, 1, 0, 0, 395.561, -694.343, -7.89872, 5.33659, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93887, 21227, 548, 1, 1, 0, 1, 402.643, -680.609, -7.24187, 5.96098, 604800, 0, 0, 125668, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93886, 21227, 548, 1, 1, 0, 1, 442.583, -760.415, -7.14433, 1.85335, 604800, 0, 0, 125668, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93885, 21227, 548, 1, 1, 0, 1, 316.874, -756.787, -13.1581, 0.0390811, 604800, 0, 0, 125668, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (93884, 21228, 548, 1, 1, 0, 0, 315.104, -761.948, -13.1581, 0.577081, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93883, 21228, 548, 1, 1, 0, 0, 324.026, -688.422, -13.1581, 4.92426, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93882, 21228, 548, 1, 1, 0, 0, 393.08, -682.573, -7.48923, 5.4544, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93881, 21228, 548, 1, 1, 0, 0, 398.658, -684.657, -7.59175, 4.98486, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
INSERT INTO creature VALUES (93880, 21228, 548, 1, 1, 0, 0, 441.469, -763.936, -7.14424, 2.16359, 604800, 0, 0, 100520, 48465, 0, 0, 0, 0);
DELETE FROM waypoint_data WHERE id IN(938950, 938940, 938930, 938920);
INSERT INTO waypoint_data VALUES (938920, 1, 325.779, -702.237, -13.1581, 0, 0, 1, 0, 100, 0),(938920, 2, 326.708, -715.083, -13.1581, 0, 0, 1, 0, 100, 0),(938920, 3, 328.308, -737.215, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 4, 329.823, -758.161, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 5, 341.439, -759.472, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 6, 357.815, -759.126, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 7, 368.313, -758.904, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 8, 378.811, -758.682, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 9, 385.621, -758.549, -10.4311, 0, 0, 1, 0, 100, 0),(938920, 10, 388.813, -758.507, -7.93437, 0, 0, 1, 0, 100, 0),(938920, 11, 396.933, -758.463, -7.72424, 0, 0, 1, 0, 100, 0),(938920, 12, 408.623, -758.538, -7.16668, 0, 0, 1, 0, 100, 0),(938920, 13, 423.758, -759.826, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 14, 432.585, -756.866, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 15, 432.443, -741.677, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 16, 432.742, -720.679, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 17, 433.413, -709.008, -7.14427, 0, 0, 1, 0, 100, 0),
(938920, 18, 433.557, -695.009, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 19, 429.433, -687.933, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 20, 419.165, -685.739, -7.14427, 0, 0, 1, 0, 100, 0),(938920, 21, 407.6, -687.448, -7.17091, 0, 0, 1, 0, 100, 0),(938920, 22, 394.936, -689.372, -7.87304, 0, 0, 1, 0, 100, 0),(938920, 23, 390.329, -689.723, -7.93488, 0, 0, 1, 0, 100, 0),(938920, 24, 385.722, -690.074, -11.3748, 0, 0, 1, 0, 100, 0),(938920, 25, 381.044, -690.412, -13.1581, 0, 0, 1, 0, 100, 0),(938920, 26, 364.694, -691.383, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 27, 347.289, -690.451, -13.1582, 0, 0, 1, 0, 100, 0),(938920, 28, 328.531, -690.7, -13.1582, 0, 0, 1, 0, 100, 0),(938930, 1, 401.701, -694.873, -7.39567, 0, 0, 1, 0, 100, 0),(938930, 2, 403.577, -708.683, -7.23985, 0, 0, 1, 0, 100, 0),(938930, 3, 398.937, -719.336, -8.71103, 0, 0, 1, 0, 100, 0),(938930, 4, 388.309, -724.205, -12, 0, 0, 1, 0, 100, 0),(938930, 5, 382.346, -727.871, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 6, 375.841, -738.907, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 7, 361.37, -752.538, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 8, 351.919, -739.245, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 9, 344.09, -729.017, -13.1581, 0, 0, 1, 0, 100, 0),
(938930, 10, 335.337, -716.603, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 11, 327.125, -701.149, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 12, 332.773, -692.297, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 13, 341.901, -690.468, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 14, 358.11, -688.654, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 15, 376.79, -688.038, -13.3736, 0, 0, 1, 0, 100, 0),(938930, 16, 382.597, -687.847, -13.1581, 0, 0, 1, 0, 100, 0),(938930, 17, 387.284, -687.693, -9.96531, 0, 0, 1, 0, 100, 0),(938930, 18, 389.586, -687.617, -7.83304, 0, 0, 1, 0, 100, 0),(938930, 19, 399.51, -690.825, -7.55458, 0, 0, 1, 0, 100, 0),(938940, 1, 433.085, -747.443, -7.14426, 0, 0, 1, 0, 100, 0),(938940, 2, 427.148, -734.766, -7.14426, 0, 0, 1, 0, 100, 0),(938940, 3, 419.558, -724.36, -7.14426, 0, 0, 1, 0, 100, 0),(938940, 4, 405.595, -725.369, -7.14426, 0, 0, 1, 0, 100, 0),(938940, 5, 390.792, -721.962, -11.1757, 0, 0, 1, 0, 100, 0),(938940, 6, 381.913, -716.362, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 7, 370.96, -701.217, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 8, 360.107, -694.412, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 9, 343.153, -686.546, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 10, 324.815, -689.775, -13.1582, 0, 0, 1, 0, 100, 0),
(938940, 11, 325.749, -701.428, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 12, 325.713, -716.618, -13.1582, 0, 0, 1, 0, 100, 0),(938940, 13, 325.676, -731.808, -13.8345, 0, 0, 1, 0, 100, 0),(938940, 14, 325.645, -744.618, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 15, 334.003, -757.301, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 16, 342.678, -760.681, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 17, 354.724, -756.324, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 18, 362.36, -746.039, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 19, 375.435, -732.737, -13.1581, 0, 0, 1, 0, 100, 0),(938940, 20, 383.561, -728.78, -13.1359, 0, 0, 1, 0, 100, 0),(938940, 21, 392.294, -725.553, -10.7459, 0, 0, 1, 0, 100, 0),(938940, 22, 404.906, -730.468, -7.1454, 0, 0, 1, 0, 100, 0),(938940, 23, 403.291, -750.211, -7.28829, 0, 0, 1, 0, 100, 0),(938940, 24, 404.725, -759.41, -7.1696, 0, 0, 1, 0, 100, 0),(938940, 25, 418.538, -761.688, -7.14333, 0, 0, 1, 0, 100, 0),(938940, 26, 433.496, -759.477, -7.14333, 0, 0, 1, 0, 100, 0),(938950, 1, 325.139, -751.983, -13.1582, 0, 0, 1, 0, 100, 0),(938950, 2, 328.225, -739.479, -13.1582, 0, 0, 1, 0, 100, 0),(938950, 3, 335.771, -724.94, -13.6616, 0, 0, 1, 0, 100, 0),
(938950, 4, 350.644, -713.738, -13.318, 0, 0, 1, 0, 100, 0),(938950, 5, 364.623, -703.21, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 6, 376.184, -708.344, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 7, 381.51, -721.292, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 8, 374.332, -737.252, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 9, 369.008, -748.98, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 10, 357.966, -755.474, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 11, 344.607, -759.663, -13.1581, 0, 0, 1, 0, 100, 0),(938950, 12, 328.301, -760.007, -13.1581, 0, 0, 1, 0, 100, 0);
INSERT INTO creature_addon VALUES (239000, 938920, 0, 0, 0, 0, '');
INSERT INTO creature_addon VALUES (239001, 938930, 0, 0, 0, 0, '');
INSERT INTO creature_addon VALUES (239002, 938940, 0, 0, 0, 0, '');
INSERT INTO creature_addon VALUES (239003, 938950, 0, 0, 0, 0, '');
INSERT INTO creature_formations VALUES (239000, 239000, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (239000, 93883, 2.5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239000, 93890, 2.5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239000, 93892, 5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239000, 93893, 5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239001, 239001, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (239001, 93881, 2.5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239001, 93882, 2.5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239001, 93887, 5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239001, 93888, 5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239002, 239002, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (239002, 93880, 2.5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239002, 93889, 2.5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239002, 93886, 5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239002, 93894, 5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239003, 239003, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (239003, 93884, 2.5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239003, 93885, 2.5, 220, 0, 0, 0);
INSERT INTO creature_formations VALUES (239003, 93891, 5, 140, 0, 0, 0);
INSERT INTO creature_formations VALUES (239003, 93895, 5, 220, 0, 0, 0);

-- Fixing Bridge to Lady Vashj
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=184568;
DELETE FROM smart_scripts WHERE entryorguid=184568 AND source_type=1;
INSERT INTO smart_scripts VALUES(184568, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 34, 23, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cage Trap - On Gossip Hello - Set Instance Data");
DELETE FROM gameobject WHERE id IN(184203, 184204, 184205, 184568);
INSERT INTO gameobject VALUES (NULL, 184203, 548, 1, 1, 26, -654.668, 15.5, 3.1415, 0, 0, 0.712986, -0.701178, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 184204, 548, 1, 1, 26, -654.668, 15.5, 3.1415, 0, 0, 0.712986, -0.701178, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 184205, 548, 1, 1, 26, -654.668, 15.5, 3.1415, 0, 0, 0.712986, -0.701178, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 184568, 548, 1, 1, 47.8436, -582.298, 4.2, 3.1415, 0, 0, 0.998959, 0.0456278, 300, 0, 1, 0);

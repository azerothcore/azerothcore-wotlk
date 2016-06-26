
UPDATE creature SET spawntimesecs=86400 WHERE map=554 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Tempest-Forge Patroller (19166, 21543)
DELETE FROM creature_text WHERE entry=19166;
INSERT INTO creature_text VALUES (19166, 0, 0, "Any intruders must be eliminated!", 14, 0, 100, 0, 0, 0, 0, 'Tempest-Forge Patroller');
INSERT INTO creature_text VALUES (19166, 0, 1, "Protect the Mechanar at all costs!", 14, 0, 100, 0, 0, 0, 0, 'Tempest-Forge Patroller');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19166;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21543;
DELETE FROM smart_scripts WHERE entryorguid=19166 AND source_type=0;
INSERT INTO smart_scripts VALUES (19166, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (19166, 0, 1, 0, 0, 0, 100, 2, 2000, 2000, 7000, 9000, 11, 35012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast Spell Charged Arcane Missiles');
INSERT INTO smart_scripts VALUES (19166, 0, 2, 0, 0, 0, 100, 4, 2000, 2000, 7000, 9000, 11, 38941, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast Spell Charged Arcane Missiles');
INSERT INTO smart_scripts VALUES (19166, 0, 3, 0, 0, 0, 100, 4, 6000, 6000, 14000, 16000, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Patroller - In Combat - Cast Spell Knockback');

-- Bloodwarder Physician (20990, 21523)
UPDATE creature_template SET pickpocketloot=20990, AIName='SmartAI', ScriptName='' WHERE entry=20990;
UPDATE creature_template SET pickpocketloot=20990, AIName='', ScriptName='' WHERE entry=21523;
DELETE FROM smart_scripts WHERE entryorguid=20990 AND source_type=0;
INSERT INTO smart_scripts VALUES (20990, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 10000, 10000, 11, 36333, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast Anesthetic');
INSERT INTO smart_scripts VALUES (20990, 0, 1, 0, 0, 0, 100, 2, 4000, 4000, 9000, 10000, 11, 36340, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast Holy Shock');
INSERT INTO smart_scripts VALUES (20990, 0, 2, 0, 0, 0, 100, 4, 4000, 4000, 9000, 10000, 11, 38921, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast Holy Shock');
INSERT INTO smart_scripts VALUES (20990, 0, 3, 0, 0, 0, 100, 2, 15000, 15000, 30000, 30000, 11, 36348, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast Bandage');
INSERT INTO smart_scripts VALUES (20990, 0, 4, 0, 0, 0, 100, 4, 15000, 15000, 30000, 30000, 11, 38919, 0, 0, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Physician - In Combat - Cast Bandage');

-- Bloodwarder Slayer (19167, 21524)
REPLACE INTO creature_template_addon VALUES (19167, 0, 0, 0, 4097, 0, '35188 35192');
REPLACE INTO creature_template_addon VALUES (21524, 0, 0, 0, 4097, 0, '35188 35192');
UPDATE creature_template SET pickpocketloot=19167, AIName='SmartAI', ScriptName='' WHERE entry=19167;
UPDATE creature_template SET pickpocketloot=19167, AIName='', ScriptName='' WHERE entry=21524;
DELETE FROM smart_scripts WHERE entryorguid=19167 AND source_type=0;
INSERT INTO smart_scripts VALUES (19167, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 6000, 6000, 11, 35189, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - In Combat - Cast Solar Strike');
INSERT INTO smart_scripts VALUES (19167, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 9000, 10000, 11, 13736, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Slayer - In Combat - Cast Whirlwind');

-- Bloodwarder Centurion (19510, 21522)
REPLACE INTO creature_template_addon VALUES (19510, 0, 0, 0, 4097, 0, '35184 35188 35192');
REPLACE INTO creature_template_addon VALUES (21522, 0, 0, 0, 4097, 0, '35184 35188 35192');
UPDATE creature_template SET pickpocketloot=19510, AIName='SmartAI', ScriptName='' WHERE entry=19510;
UPDATE creature_template SET pickpocketloot=19510, AIName='', ScriptName='' WHERE entry=21522;
DELETE FROM smart_scripts WHERE entryorguid=19510 AND source_type=0;
INSERT INTO smart_scripts VALUES (19510, 0, 0, 0, 13, 0, 100, 0, 7000, 7000, 0, 0, 11, 35178, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Centurion - Victim Casting - Cast Spell Shield Bash');

-- Sunseeker Netherbinder (20059, 21541)
UPDATE creature_template SET pickpocketloot=20059, AIName='SmartAI', ScriptName='' WHERE entry=20059;
UPDATE creature_template SET pickpocketloot=20059, AIName='', ScriptName='' WHERE entry=21541;
DELETE FROM smart_scripts WHERE entryorguid=20059 AND source_type=0;
INSERT INTO smart_scripts VALUES (20059, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2000, 3000, 11, 35243, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast Starfire');
INSERT INTO smart_scripts VALUES (20059, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 11, 38935, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast Starfire');
INSERT INTO smart_scripts VALUES (20059, 0, 2, 0, 9, 0, 100, 2, 0, 8, 9000, 10000, 11, 35261, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (20059, 0, 3, 0, 9, 0, 100, 4, 0, 8, 9000, 10000, 11, 38936, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast Arcane Nova');
INSERT INTO smart_scripts VALUES (20059, 0, 4, 0, 0, 0, 100, 4, 5000, 5000, 10000, 10000, 11, 17201, 0, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Netherbinder - In Combat - Cast Dispel Magic');

-- Mechanar Tinkerer (19716, 21531)
UPDATE creature_template SET pickpocketloot=19716, AIName='SmartAI', ScriptName='' WHERE entry=19716;
UPDATE creature_template SET pickpocketloot=19716, AIName='', ScriptName='' WHERE entry=21531;
DELETE FROM smart_scripts WHERE entryorguid=19716 AND source_type=0;
INSERT INTO smart_scripts VALUES (19716, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (19716, 0, 1, 0, 0, 1, 100, 2, 0, 0, 2000, 3000, 11, 35057, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - In Combat - Cast Netherbomb');
INSERT INTO smart_scripts VALUES (19716, 0, 2, 0, 0, 1, 100, 4, 0, 0, 2000, 3000, 11, 38925, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - In Combat - Cast Netherbomb');
INSERT INTO smart_scripts VALUES (19716, 0, 3, 4, 2, 1, 100, 1, 0, 40, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - Between 0-40% HP - Set Event Phase');
INSERT INTO smart_scripts VALUES (19716, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35062, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - Between 0-40% HP - Cast Maniacal Charge');
INSERT INTO smart_scripts VALUES (19716, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - Between 0-40% HP - Set Caster Distance');
INSERT INTO smart_scripts VALUES (19716, 0, 6, 0, 0, 2, 100, 1, 2000, 2000, 0, 0, 11, 35058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Tinkerer - In Combat - Cast Nether Explosion');

-- Mechanar Wrecker (19713, 21532)
UPDATE creature_template SET pickpocketloot=19713, AIName='SmartAI', ScriptName='' WHERE entry=19713;
UPDATE creature_template SET pickpocketloot=19713, AIName='', ScriptName='' WHERE entry=21532;
DELETE FROM smart_scripts WHERE entryorguid=19713 AND source_type=0;
INSERT INTO smart_scripts VALUES (19713, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 10000, 12000, 11, 35056, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Wrecker - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19713, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 10000, 12000, 11, 38923, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Wrecker - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19713, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 13000, 17000, 11, 35049, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Wrecker - In Combat - Cast Pound');

-- Mechanar Driller (19712, 21528)
UPDATE creature_template SET pickpocketloot=19712, AIName='SmartAI', ScriptName='' WHERE entry=19712;
UPDATE creature_template SET pickpocketloot=19712, AIName='', ScriptName='' WHERE entry=21528;
DELETE FROM smart_scripts WHERE entryorguid=19712 AND source_type=0;
INSERT INTO smart_scripts VALUES (19712, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 10000, 12000, 11, 35056, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Driller - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19712, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 10000, 12000, 11, 38923, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Driller - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19712, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 8000, 8000, 11, 35047, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Driller - In Combat - Cast Drill Armor');

-- Mechanar Crusher (19231, 21527)
UPDATE creature_template SET pickpocketloot=19231, AIName='SmartAI', ScriptName='' WHERE entry=19231;
UPDATE creature_template SET pickpocketloot=19231, AIName='', ScriptName='' WHERE entry=21527;
DELETE FROM smart_scripts WHERE entryorguid=19231 AND source_type=0;
INSERT INTO smart_scripts VALUES (19231, 0, 0, 0, 0, 0, 100, 2, 1000, 5000, 10000, 12000, 11, 35056, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Crusher - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19231, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 10000, 12000, 11, 38923, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Mechanar Crusher - In Combat - Cast Glob of Machine Fluid');
INSERT INTO smart_scripts VALUES (19231, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 12000, 12000, 11, 35055, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mechanar Crusher - In Combat - Cast The Claw');

-- Sunseeker Engineer (20988, 21540)
UPDATE creature_template SET pickpocketloot=20988, AIName='SmartAI', ScriptName='' WHERE entry=20988;
UPDATE creature_template SET pickpocketloot=20988, AIName='', ScriptName='' WHERE entry=21540;
DELETE FROM smart_scripts WHERE entryorguid=20988 AND source_type=0;
INSERT INTO smart_scripts VALUES (20988, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2000, 3000, 11, 36345, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast Death Ray');
INSERT INTO smart_scripts VALUES (20988, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 11, 39196, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast Death Ray');
INSERT INTO smart_scripts VALUES (20988, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 15000, 15000, 11, 36341, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - In Combat - Cast Super Shrink Ray');
INSERT INTO smart_scripts VALUES (20988, 0, 3, 0, 16, 0, 100, 0, 36346, 30, 15000, 15000, 11, 36346, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Engineer - Friendly Missing Buff - Cast Growth Ray');

-- Tempest-Forge Destroyer (19735, 21542)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19735;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21542;
DELETE FROM smart_scripts WHERE entryorguid=19735 AND source_type=0;
INSERT INTO smart_scripts VALUES (19735, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 25000, 25000, 11, 36582, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - In Combat - Cast Charged Fist');
INSERT INTO smart_scripts VALUES (19735, 0, 1, 0, 13, 0, 100, 0, 8000, 10000, 0, 0, 11, 35783, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Destroyer - Victim Casting - Cast Knockdown');

-- Sunseeker Astromage (19168, 21539)
UPDATE creature_template SET pickpocketloot=19168, AIName='SmartAI', ScriptName='' WHERE entry=19168;
UPDATE creature_template SET pickpocketloot=19168, AIName='', ScriptName='' WHERE entry=21539;
DELETE FROM smart_scripts WHERE entryorguid=19168 AND source_type=0;
INSERT INTO smart_scripts VALUES (19168, 0, 0, 0, 0, 0, 100, 3, 1000, 8000, 0, 0, 11, 35265, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (19168, 0, 1, 0, 0, 0, 100, 5, 1000, 8000, 0, 0, 11, 38933, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Fire Shield');
INSERT INTO smart_scripts VALUES (19168, 0, 2, 0, 0, 0, 100, 3, 3000, 6000, 8000, 8000, 11, 17195, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (19168, 0, 3, 0, 0, 0, 100, 5, 3000, 6000, 8000, 8000, 11, 36807, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Scorch');
INSERT INTO smart_scripts VALUES (19168, 0, 4, 0, 0, 0, 100, 3, 8000, 8000, 12000, 12000, 11, 35267, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Solarburn');
INSERT INTO smart_scripts VALUES (19168, 0, 5, 0, 0, 0, 100, 5, 8000, 8000, 12000, 12000, 11, 38930, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Sunseeker Astromage - In Combat - Cast Solarburn');



-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Gatewatcher Gyro-Kill (19218, 21525)
DELETE FROM creature_text WHERE entry=19218;
INSERT INTO creature_text VALUES (19218, 0, 0, 'I predict a painful death.', 14, 0, 100, 0, 0, 11101, 0, 'Gatewatcher Gyro-Kill - Aggro');
INSERT INTO creature_text VALUES (19218, 1, 0, 'Your strategy was flawed.', 14, 0, 100, 0, 0, 11102, 0, 'Gatewatcher Gyro-Kill - On Kill');
INSERT INTO creature_text VALUES (19218, 1, 1, 'Yes, the only logical outcome.', 14, 0, 100, 0, 0, 11103, 0, 'Gatewatcher Gyro-Kill - On Kill');
INSERT INTO creature_text VALUES (19218, 2, 0, 'Measure twice; cut once.', 14, 0, 100, 0, 0, 11104, 0, 'Gatewatcher Gyro-Kill - Sawblades');
INSERT INTO creature_text VALUES (19218, 2, 1, 'If my division is correct you should be quite dead.', 14, 0, 100, 0, 0, 11105, 0, 'Gatewatcher Gyro-Kill - Sawblades');
INSERT INTO creature_text VALUES (19218, 3, 0, 'An unforeseen... contingency.', 14, 0, 100, 0, 0, 11106, 0, 'Gatewatcher Gyro-Kill - On Death');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=19218, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_gatewatcher_gyrokill' WHERE entry=19218;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=19218, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21525;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=30436;

-- Gatewatcher Iron-Hand (19710, 21526)
DELETE FROM creature_text WHERE entry=19710;
INSERT INTO creature_text VALUES (19710, 0, 0, 'You have approximately five seconds to live.', 14, 0, 100, 0, 0, 11109, 0, 'ironhand SAY_AGGRO_1');
INSERT INTO creature_text VALUES (19710, 1, 0, 'With the precise angle and velocity...', 14, 0, 100, 0, 0, 11112, 0, 'ironhand SAY_HAMMER_1');
INSERT INTO creature_text VALUES (19710, 1, 1, 'Low tech yet quiet effective!', 14, 0, 100, 0, 0, 11113, 0, 'ironhand SAY_HAMMER_2');
INSERT INTO creature_text VALUES (19710, 2, 0, 'A foregone conclusion.', 14, 0, 100, 0, 0, 11110, 0, 'ironhand SAY_SLAY_1');
INSERT INTO creature_text VALUES (19710, 2, 1, 'The processing will continue a schedule!', 14, 0, 100, 0, 0, 11111, 0, 'ironhand SAY_SLAY_2');
INSERT INTO creature_text VALUES (19710, 3, 0, 'My calculations did not...', 14, 0, 100, 0, 0, 11114, 0, 'ironhand SAY_DEATH_1');
INSERT INTO creature_text VALUES (19710, 4, 0, '%s raises his hammer menacingly...', 41, 0, 100, 0, 0, 0, 0, 'ironhand EMOTE_HAMMER');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=19710, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_gatewatcher_iron_hand' WHERE entry=19710;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=19710, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21526;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=30437;

-- Mechano-Lord Capacitus (19219, 21533)
DELETE FROM creature_text WHERE entry=19219;
INSERT INTO creature_text VALUES (19219, 0, 0, 'You should split while you can.', 14, 0, 100, 0, 0, 11162, 0, 'Mechano-Lord Capacitus - Aggro');
INSERT INTO creature_text VALUES (19219, 1, 0, 'Go ahead, gimme your best shot. I can take it!', 14, 0, 100, 0, 0, 11166, 0, 'Mechano-Lord Capacitus - Yells');
INSERT INTO creature_text VALUES (19219, 2, 0, 'Think you can hurt me, huh? Think I''m afraid a'' you?', 14, 0, 100, 0, 0, 11165, 0, 'Mechano-Lord Capacitus - Yells');
INSERT INTO creature_text VALUES (19219, 3, 0, 'Can''t say I didn''t warn you!', 14, 0, 100, 0, 0, 11163, 0, 'Mechano-Lord Capacitus - Killing a player');
INSERT INTO creature_text VALUES (19219, 3, 1, 'Damn, I''m good!', 14, 0, 100, 0, 0, 11164, 0, 'Mechano-Lord Capacitus - Killing a player');
INSERT INTO creature_text VALUES (19219, 4, 0, 'Bully!', 14, 0, 100, 0, 0, 11167, 0, 'Mechano-Lord Capacitus - Death');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_mechano_lord_capacitus' WHERE entry=19219;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.42857, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21533;
DELETE FROM pickpocketing_loot_template WHERE entry=19219;

-- Nether Charge (20405, 21534)
REPLACE INTO creature_template_addon VALUES (20405, 0, 0, 0, 0, 0, '35150');
REPLACE INTO creature_template_addon VALUES (21534, 0, 0, 0, 0, 0, '35150');
UPDATE creature_template SET speed_walk=3.3, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=20405;
UPDATE creature_template SET speed_walk=3.3, flags_extra=130, AIName='', ScriptName='' WHERE entry=21534;
DELETE FROM smart_scripts WHERE entryorguid=20405 AND source_type=0;
INSERT INTO smart_scripts VALUES (20405, 0, 0, 0, 60, 0, 100, 1, 8500, 8500, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Update - Move Idle');
INSERT INTO smart_scripts VALUES (20405, 0, 1, 0, 60, 0, 100, 0, 8500, 8500, 2000, 2000, 11, 35151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Update - Cast Nether Charge Pulse');
INSERT INTO smart_scripts VALUES (20405, 0, 2, 0, 60, 0, 100, 257, 0, 0, 0, 0, 11, 37670, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nether Charge - On Update - Cast Nether Charge Timer');

-- SPELL Polarity Shift (39096)
DELETE FROM spell_script_names WHERE spell_id IN(39096);
INSERT INTO spell_script_names VALUES(39096, 'spell_capacitus_polarity_shift');
-- SPELL Positive Charge (39090)
-- SPELL Negative Charge (39093)
DELETE FROM spell_script_names WHERE spell_id IN(39090, 39093);
INSERT INTO spell_script_names VALUES(39090, 'spell_capacitus_polarity_charge');
INSERT INTO spell_script_names VALUES(39093, 'spell_capacitus_polarity_charge');

-- Nethermancer Sepethrea (19221, 21536)
DELETE FROM creature_text WHERE entry=19221;
INSERT INTO creature_text VALUES (19221, 0, 0, 'Don''t value your life very much, do you?', 14, 0, 100, 0, 0, 11186, 0, 'sepethrea SAY_AGGRO');
INSERT INTO creature_text VALUES (19221, 1, 0, 'I am not alone.', 14, 0, 100, 0, 0, 11191, 0, 'sepethrea SAY_SUMMON');
INSERT INTO creature_text VALUES (19221, 2, 0, 'Think you can take the heat?', 14, 0, 100, 0, 0, 11189, 0, 'sepethrea SAY_DRAGONS_BREATH_1');
INSERT INTO creature_text VALUES (19221, 2, 1, 'Anar''endal dracon!', 14, 0, 100, 0, 0, 11190, 0, 'sepethrea SAY_DRAGONS_BREATH_2');
INSERT INTO creature_text VALUES (19221, 3, 0, 'And don''t come back!', 14, 0, 100, 0, 0, 11187, 0, 'sepethrea SAY_SLAY1');
INSERT INTO creature_text VALUES (19221, 3, 1, 'En''dala finel el''dal', 14, 0, 100, 0, 0, 11188, 0, 'sepethrea SAY_SLAY2');
INSERT INTO creature_text VALUES (19221, 4, 0, 'Anu... bala belore...alon.', 14, 0, 100, 0, 0, 11192, 0, 'sepethrea SAY_DEATH');
UPDATE creature_template SET speed_walk=1.6, speed_run=1.71, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_nethermancer_sepethrea' WHERE entry=19221;
UPDATE creature_template SET speed_walk=1.6, speed_run=1.71, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21536;
DELETE FROM pickpocketing_loot_template WHERE entry=19221;

-- Raging Flames (20481, 21538);
UPDATE creature_template SET speed_run=0.6, AIName='', ScriptName='npc_ragin_flames' WHERE entry=20481;
UPDATE creature_template SET speed_run=0.8, AIName='', ScriptName='' WHERE entry=21538;

-- SPELL Inferno (35268)
-- SPELL Inferno (39346)
DELETE FROM spell_script_names WHERE spell_id IN(35268, 39346);
INSERT INTO spell_script_names VALUES(35268, 'spell_ragin_flames_inferno');
INSERT INTO spell_script_names VALUES(39346, 'spell_ragin_flames_inferno');

-- Pathaleon the Calculator (19220, 21537)
DELETE FROM creature_text WHERE entry=19220;
INSERT INTO creature_text VALUES (19220, 0, 0, 'We are on a strict timetable. You will not interfere!', 14, 0, 100, 0, 0, 11193, 0, 'pathaleon SAY_AGGRO');
INSERT INTO creature_text VALUES (19220, 1, 0, 'I''m looking for a team player...', 14, 0, 100, 0, 0, 11197, 0, 'pathaleon SAY_DOMINATION_1');
-- INSERT INTO creature_text VALUES (19220, 1, 1, 'You work for me now!', 14, 0, 100, 0, 0, 11198, 'pathaleon SAY_DOMINATION_2'); NO SOUND PLAYES AT CLIENT
INSERT INTO creature_text VALUES (19220, 2, 0, 'Time to supplement my work force.', 14, 0, 100, 0, 0, 11196, 0, 'pathaleon SAY_SUMMON');
INSERT INTO creature_text VALUES (19220, 3, 0, 'I prefeer to be hands-on...', 14, 0, 100, 0, 0, 11199, 0, 'pathaleon SAY_ENRAGE');
INSERT INTO creature_text VALUES (19220, 4, 0, 'A minor inconvenience.', 14, 0, 100, 0, 0, 11194, 0, 'pathaleon SAY_SLAY_1');
INSERT INTO creature_text VALUES (19220, 4, 1, 'Looks like you lose.', 14, 0, 100, 0, 0, 11195, 0, 'pathaleon SAY_SLAY_2');
INSERT INTO creature_text VALUES (19220, 5, 0, 'The project will... continue.', 14, 0, 100, 0, 0, 11200, 0, 'pathaleon SAY_DEATH');
INSERT INTO creature_text VALUES (19220, 6, 0, 'I have been waiting for you!', 14, 0, 100, 0, 0, 0, 0, 'pathaleon SAY_APPEAR');
UPDATE creature_template SET pickpocketloot=19220, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_pathaleon_the_calculator' WHERE entry=19220;
UPDATE creature_template SET pickpocketloot=19220, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='' WHERE entry=21537;

-- Nether Wraith (21062, 21535)
UPDATE creature_template SET minlevel=72, maxlevel=72, AIName='SmartAI', ScriptName='' WHERE entry=21062;
UPDATE creature_template SET minlevel=72, maxlevel=72, dmg_multiplier=2, AIName='', ScriptName='' WHERE entry=21539;
DELETE FROM smart_scripts WHERE entryorguid=21062 AND source_type=0;
INSERT INTO smart_scripts VALUES (21062, 0, 0, 0, 0, 0, 100, 0, 1000, 4000, 5000, 5000, 11, 20720, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Nether Wraith - In Combat - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (21062, 0, 1, 0, 0, 0, 100, 0, 20000, 20000, 20000, 20000, 11, 35058, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nether Wraith - In Combat - Cast Nether Explosion');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Cache of the Legion (184465)
UPDATE gameobject SET spawnMask=3 WHERE id=184465;

-- Add Working emote to specific npcs
REPLACE INTO creature_addon VALUES (83162, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83163, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83166, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83167, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83170, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83171, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83182, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83183, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83200, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83201, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83202, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83203, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83210, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83211, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83212, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83219, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83220, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83222, 0, 0, 0, 4097, 28, '');
REPLACE INTO creature_addon VALUES (83223, 0, 0, 0, 4097, 28, '');


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------
-- Saw Blade (35318, 39192)
DELETE FROM spelldifficulty_dbc WHERE id IN(35318, 39192) OR spellid0 IN(35318, 39192) OR spellid1 IN(35318, 39192) OR spellid2 IN(35318, 39192) OR spellid3 IN(35318, 39192);
INSERT INTO spelldifficulty_dbc VALUES (35318, 35318, 39192, 0, 0);

-- Shadow Power (35322, 39193)
DELETE FROM spelldifficulty_dbc WHERE id IN(35322, 39193) OR spellid0 IN(35322, 39193) OR spellid1 IN(35322, 39193) OR spellid2 IN(35322, 39193) OR spellid3 IN(35322, 39193);
INSERT INTO spelldifficulty_dbc VALUES (35322, 35322, 39193, 0, 0);

-- Jackhammer (35327, 39194)
DELETE FROM spelldifficulty_dbc WHERE id IN(35327, 39194) OR spellid0 IN(35327, 39194) OR spellid1 IN(35327, 39194) OR spellid2 IN(35327, 39194) OR spellid3 IN(35327, 39194);
INSERT INTO spelldifficulty_dbc VALUES (35327, 35327, 39194, 0, 0);

-- Summon Raging Flames (35275, 39084)
DELETE FROM spelldifficulty_dbc WHERE id IN(35275, 39084) OR spellid0 IN(35275, 39084) OR spellid1 IN(35275, 39084) OR spellid2 IN(35275, 39084) OR spellid3 IN(35275, 39084);
INSERT INTO spelldifficulty_dbc VALUES (35275, 35275, 39084, 0, 0);

-- Inferno (35268, 39346)
DELETE FROM spelldifficulty_dbc WHERE id IN(35268, 39346) OR spellid0 IN(35268, 39346) OR spellid1 IN(35268, 39346) OR spellid2 IN(35268, 39346) OR spellid3 IN(35268, 39346);
INSERT INTO spelldifficulty_dbc VALUES (35268, 35268, 39346, 0, 0);

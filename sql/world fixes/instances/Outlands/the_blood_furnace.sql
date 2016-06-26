
UPDATE creature SET spawntimesecs=86400 WHERE map=542 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------
DELETE FROM creature_formations WHERE leaderGUID=138150;
INSERT INTO creature_formations VALUES (138150, 138150, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138150, 138151, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138150, 138152, 0, 0, 5, 0, 0);
DELETE FROM creature_formations WHERE leaderGUID=138153;
INSERT INTO creature_formations VALUES (138153, 138153, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138153, 138154, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138153, 138155, 0, 0, 5, 0, 0);
DELETE FROM creature_formations WHERE leaderGUID=138156;
INSERT INTO creature_formations VALUES (138156, 138156, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138156, 138157, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138156, 138158, 0, 0, 5, 0, 0);
DELETE FROM creature_formations WHERE leaderGUID=138160;
INSERT INTO creature_formations VALUES (138160, 138160, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138160, 138161, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138160, 138162, 0, 0, 5, 0, 0);
DELETE FROM creature_formations WHERE leaderGUID=138163;
INSERT INTO creature_formations VALUES (138163, 138163, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138163, 138164, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138163, 138165, 0, 0, 5, 0, 0);
DELETE FROM creature_formations WHERE leaderGUID=138166;
INSERT INTO creature_formations VALUES (138166, 138166, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138166, 138167, 0, 0, 5, 0, 0);
INSERT INTO creature_formations VALUES (138166, 138168, 0, 0, 5, 0, 0);


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Laughing Skull Enforcer (17370, 18608)
DELETE FROM creature_text WHERE entry=17370;
INSERT INTO creature_text VALUES (17370, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
INSERT INTO creature_text VALUES (17370, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Enforcer');
UPDATE creature_template SET pickpocketloot=17370, AIName='SmartAI', ScriptName='' WHERE entry=17370;
UPDATE creature_template SET pickpocketloot=17370, AIName='', ScriptName='' WHERE entry=18608;
DELETE FROM smart_scripts WHERE entryorguid=17370 AND source_type=0;
INSERT INTO smart_scripts VALUES(17370, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - On Aggro - Say Text');
INSERT INTO smart_scripts VALUES(17370, 0, 1, 0, 0, 0, 100, 0, 4200, 9500, 9500, 15300, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - On Update - Cast Spell on victim');
INSERT INTO smart_scripts VALUES(17370, 0, 2, 0, 0, 0, 100, 0, 1900, 8800, 9300, 14700, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - On Update - Cast Spell on victim');

-- Shadowmoon Adept (17397, 18615)
DELETE FROM creature_text WHERE entry=17397;
INSERT INTO creature_text VALUES (17397, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
INSERT INTO creature_text VALUES (17397, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Adept');
UPDATE creature_template SET pickpocketloot=17397, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17397;
UPDATE creature_template SET pickpocketloot=17397, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18615;
DELETE FROM smart_scripts WHERE entryorguid=17397 AND source_type=0;
INSERT INTO smart_scripts VALUES (17397, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17397, 0, 1, 0, 0, 0, 100, 0, 2600, 7800, 7200, 13300, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - In Combat - Cast Thrash');
INSERT INTO smart_scripts VALUES (17397, 0, 2, 0, 0, 0, 100, 0, 5600, 12300, 9600, 11400, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - In Combat - Cast Kick');
INSERT INTO smart_scripts VALUES (17397, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - At 15% HP - Flee For Assist');
INSERT INTO smart_scripts VALUES (17397, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - On Aggro - Call for help');
INSERT INTO smart_scripts VALUES (17397, 0, 5, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 31059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - Out Of Combat - Cast Hellfire Channeling');
REPLACE INTO creature_template_addon VALUES (17397, 0, 0, 0, 4097, 0, '');
REPLACE INTO creature_template_addon VALUES (18615, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(17397, 18615));
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17397;
INSERT INTO conditions VALUES(22, 5+1, 17397, 0, 0, 29, 1, 17477, 10, 0, 0, 0, 0, '', 'Requires Npc Nearby');

-- Hellfire Imp (17477, 18606)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17477;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18606;
DELETE FROM smart_scripts WHERE entryorguid=17477 AND source_type=0;
INSERT INTO smart_scripts VALUES (17477, 0, 0, 0, 0, 0, 100, 4, 4200, 9500, 9500, 12144, 11, 16144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Update - Cast Spell on victim');
INSERT INTO smart_scripts VALUES (17477, 0, 1, 0, 0, 0, 100, 2, 1900, 5800, 5300, 7700, 11, 15242, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Update - Cast Spell on random hostile');
INSERT INTO smart_scripts VALUES (17477, 0, 2, 0, 0, 0, 100, 4, 1900, 5800, 5300, 7700, 11, 17290, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Update - Cast Spell on random hostile');
INSERT INTO smart_scripts VALUES (17477, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 39, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Aggro - Call for help');
INSERT INTO smart_scripts VALUES (17477, 0, 4, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - Out Of Combat - Cast Summon Visual');
INSERT INTO smart_scripts VALUES (17477, 0, 5, 0, 4, 0, 10, 0, 0, 0, 0, 0, 28, 30540, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - On Aggro - Remove Summon Visual');
REPLACE INTO creature_template_addon VALUES (17477, 0, 0, 0, 4097, 0, '');
REPLACE INTO creature_template_addon VALUES (18606, 0, 0, 0, 4097, 0, '');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(17477, 18606));
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=17477;
INSERT INTO conditions VALUES(22, 4+1, 17477, 0, 0, 29, 1, 17397, 10, 0, 0, 0, 0, '', 'Requires Npc Nearby');

-- Laughing Skull Rogue (17491, 18610)
DELETE FROM creature_text WHERE entry=17491;
INSERT INTO creature_text VALUES (17491, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
INSERT INTO creature_text VALUES (17491, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Rogue');
UPDATE creature_template SET pickpocketloot=17491, mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17491;
UPDATE creature_template SET pickpocketloot=17491, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18610;
DELETE FROM smart_scripts WHERE entryorguid=17491 AND source_type=0;
INSERT INTO smart_scripts VALUES (17491, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - Out Of Combat - Cast Stealth');
INSERT INTO smart_scripts VALUES (17491, 0, 1, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17491, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 28, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - On Aggro - Remove Aura Stealth');
INSERT INTO smart_scripts VALUES (17491, 0, 3, 0, 9, 0, 100, 0, 0, 5, 4300, 8700, 11, 34969, 33, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - At 0 - 5 Range - Cast Poison');
INSERT INTO smart_scripts VALUES (17491, 0, 4, 0, 0, 0, 100, 0, 1000, 5900, 15000, 20000, 11, 6434, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - In Combat - Cast Slice and Dice');
INSERT INTO smart_scripts VALUES (17491, 0, 5, 0, 0, 0, 100, 0, 4100, 7800, 12000, 15000, 11, 30832, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - In Combat - Cast Kidney Shot');

-- Shadowmoon Warlock (17371, 18619)
UPDATE creature_template SET pickpocketloot=17371, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17371;
UPDATE creature_template SET pickpocketloot=17371, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18619;
DELETE FROM smart_scripts WHERE entryorguid=17371 AND source_type=0;
INSERT INTO smart_scripts VALUES (17371, 0, 0, 0, 9, 0, 100, 2, 0, 40, 3300, 4900, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - At 0 - 40 Range - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (17371, 0, 1, 0, 9, 0, 100, 4, 0, 40, 3300, 4900, 11, 15472, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - At 0 - 40 Range - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (17371, 0, 2, 0, 0, 0, 100, 2, 1100, 7800, 14800, 30100, 11, 32197, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (17371, 0, 3, 0, 0, 0, 100, 4, 1100, 7800, 14800, 30100, 11, 37113, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (17371, 0, 4, 0, 0, 0, 100, 6, 6600, 10700, 14900, 14900, 11, 13338, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast Curse of Tongues');
INSERT INTO smart_scripts VALUES (17371, 0, 5, 0, 0, 0, 100, 6, 12000, 13700, 21900, 24900, 11, 33111, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast Fel Power');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=33111;
INSERT INTO conditions VALUES(13, 3, 33111, 0, 0, 31, 0, 3, 18894, 0, 0, 0, 0, '', "Fel Power - Target Felguard Brute");
INSERT INTO conditions VALUES(13, 3, 33111, 0, 1, 31, 0, 3, 17400, 0, 0, 0, 0, '', "Fel Power - Target Felguard Annihilator");

-- Laughing Skull Legionnaire (17626, 18609)
DELETE FROM creature_text WHERE entry=17626;
INSERT INTO creature_text VALUES (17626, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
INSERT INTO creature_text VALUES (17626, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Legionnaire');
UPDATE creature_template SET pickpocketloot=17626, mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17626;
UPDATE creature_template SET pickpocketloot=17626, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=18609;
DELETE FROM smart_scripts WHERE entryorguid=17626 AND source_type=0;
INSERT INTO smart_scripts VALUES (17626, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Legionnaire - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17626, 0, 1, 0, 0, 0, 100, 0, 2600, 7800, 7200, 13300, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Legionnaire - In Combat - Cast Uppercut');
INSERT INTO smart_scripts VALUES (17626, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Legionnaire - At 30% HP - Cast Enrage');

-- Shadowmoon Summoner (17395, 18617)
UPDATE creature_template SET pickpocketloot=17395, AIName='SmartAI', ScriptName='' WHERE entry=17395;
UPDATE creature_template SET pickpocketloot=17395, AIName='', ScriptName='' WHERE entry=18617;
DELETE FROM smart_scripts WHERE entryorguid=17395 AND source_type=0;
INSERT INTO smart_scripts VALUES (17395, 0, 0, 0, 9, 0, 100, 2, 0, 40, 2400, 3800, 11, 15242, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - At 0 - 40 Range - Cast Fireball');
INSERT INTO smart_scripts VALUES (17395, 0, 1, 0, 9, 0, 100, 4, 0, 40, 2400, 3800, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - At 0 - 40 Range - Cast Fireball');
INSERT INTO smart_scripts VALUES (17395, 0, 2, 0, 0, 0, 100, 7, 1000, 5000, 0, 0, 11, 30853, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast Summon Seductress');
INSERT INTO smart_scripts VALUES (17395, 0, 3, 0, 0, 0, 100, 7, 10500, 13000, 0, 0, 11, 30851, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast Summon Felhound Manastalker');
INSERT INTO smart_scripts VALUES (17395, 0, 4, 0, 0, 0, 100, 2, 12000, 14000, 12000, 14000, 11, 18399, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (17395, 0, 5, 0, 0, 0, 100, 4, 12000, 14000, 12000, 14000, 11, 16102, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast Flamestrike');

-- Seductress (17399, 18614)
UPDATE creature_template SET resistance5=90, AIName='SmartAI', ScriptName='' WHERE entry=17399;
UPDATE creature_template SET resistance5=90, AIName='', ScriptName='' WHERE entry=18614;
DELETE FROM smart_scripts WHERE entryorguid=17399 AND source_type=0;
INSERT INTO smart_scripts VALUES (17399, 0, 0, 0, 0, 0, 100, 6, 1000, 3000, 12800, 12800, 11, 32202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Seductress - In Combat - Cast Lash of Pain');
INSERT INTO smart_scripts VALUES (17399, 0, 1, 0, 0, 0, 100, 6, 3200, 5700, 13700, 13700, 11, 31865, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Seductress - In Combat - Cast Seduction');
INSERT INTO smart_scripts VALUES (17399, 0, 2, 0, 1, 0, 100, 1, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Seductress - Out of Combat - Attack Start');

-- Felhound Manastalker (17401, 18605)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17401;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18605;
DELETE FROM smart_scripts WHERE entryorguid=17401 AND source_type=0;
INSERT INTO smart_scripts VALUES (17401, 0, 0, 0, 0, 0, 100, 6, 1000, 2500, 11100, 11300, 11, 13321, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Felhound Manastalker - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (17401, 0, 1, 0, 0, 0, 100, 6, 3300, 8700, 12900, 12900, 11, 30849, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felhound Manastalker - In Combat - Cast Spell Lock');
INSERT INTO smart_scripts VALUES (17401, 0, 2, 0, 1, 0, 100, 1, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Felhound Manastalker - Out of Combat - Attack Start');

-- Shadowmoon Technician (17414, 18618)
DELETE FROM creature_text WHERE entry=17414;
INSERT INTO creature_text VALUES (17414, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
INSERT INTO creature_text VALUES (17414, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Technician');
UPDATE creature_template SET pickpocketloot=17414, AIName='SmartAI', ScriptName='' WHERE entry=17414;
UPDATE creature_template SET pickpocketloot=17414, AIName='', ScriptName='' WHERE entry=18609;
DELETE FROM smart_scripts WHERE entryorguid=17414 AND source_type=0;
INSERT INTO smart_scripts VALUES (17414, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17414, 0, 1, 0, 0, 0, 100, 2, 2600, 4800, 17200, 23300, 11, 30846, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast Throw Proximity Bomb');
INSERT INTO smart_scripts VALUES (17414, 0, 2, 0, 0, 0, 100, 2, 4400, 10600, 7200, 11300, 11, 40062, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast Throw Dynamite');
INSERT INTO smart_scripts VALUES (17414, 0, 3, 0, 0, 0, 100, 4, 2600, 4800, 17200, 23300, 11, 32784, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast Throw Proximity Bomb');
INSERT INTO smart_scripts VALUES (17414, 0, 4, 0, 0, 0, 100, 4, 4400, 10600, 7200, 11300, 11, 40064, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast Throw Dynamite');
INSERT INTO smart_scripts VALUES (17414, 0, 5, 0, 0, 0, 100, 0, 5400, 11600, 23000, 23000, 11, 6726, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast Throw Dynamite');

-- Laughing Skull Warden (17624, 18611)
DELETE FROM creature_text WHERE entry=17624;
INSERT INTO creature_text VALUES (17624, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
INSERT INTO creature_text VALUES (17624, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Laughing Skull Warden');
UPDATE creature_template SET pickpocketloot=17624, AIName='SmartAI', ScriptName='' WHERE entry=17624;
UPDATE creature_template SET pickpocketloot=17624, AIName='', ScriptName='' WHERE entry=18609;
DELETE FROM smart_scripts WHERE entryorguid=17624 AND source_type=0;
INSERT INTO smart_scripts VALUES (17624, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Warden - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17624, 0, 1, 0, 1, 0, 100, 0, 1000, 1000, 120000, 130000, 11, 38551, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Warden - Out Of Combat - Cast Stealth Detection');
INSERT INTO smart_scripts VALUES (17624, 0, 2, 0, 0, 0, 100, 0, 300, 1200, 15800, 15800, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Warden - In Combat - Cast Battle Shout');

-- Nascent Fel Orc (17398, 18612)
DELETE FROM creature_text WHERE entry=17398;
INSERT INTO creature_text VALUES (17398, 0, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
INSERT INTO creature_text VALUES (17398, 0, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Nascent Fel Orc');
UPDATE creature_template SET pickpocketloot=17398, AIName='SmartAI', ScriptName='' WHERE entry=17398;
UPDATE creature_template SET pickpocketloot=17398, AIName='', ScriptName='' WHERE entry=18612;
DELETE FROM smart_scripts WHERE entryorguid=17398 AND source_type=0;
INSERT INTO smart_scripts VALUES (17398, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nascent Fel Orc - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (17398, 0, 1, 0, 0, 0, 100, 0, 300, 1200, 7800, 10800, 11, 22427, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nascent Fel Orc - In Combat - Cast Concussion Blow');
INSERT INTO smart_scripts VALUES (17398, 0, 2, 0, 0, 0, 100, 0, 7000, 8200, 15800, 20800, 11, 31900, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nascent Fel Orc - In Combat - Cast Stomp');

-- Felguard Brute (18894, 21645)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18894;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=21645;
DELETE FROM smart_scripts WHERE entryorguid=18894 AND source_type=0;
INSERT INTO smart_scripts VALUES (18894, 0, 0, 0, 9, 0, 100, 6, 0, 10, 13700, 15700, 11, 18072, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Brute - At 0 - 10 Range - Cast Uppercut');
INSERT INTO smart_scripts VALUES (18894, 0, 1, 0, 0, 0, 100, 6, 4000, 8000, 10000, 15000, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Felguard Brute - In Combat - Cast Pummel');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- The Maker (17381, 18621)
UPDATE creature_template SET pickpocketloot=17381, AIName='', ScriptName='boss_the_maker' WHERE entry=17381;
UPDATE creature_template SET pickpocketloot=17381, AIName='', ScriptName='' WHERE entry=18621;
DELETE FROM smart_scripts WHERE entryorguid=17381 AND source_type=0;

-- Broggok (17380, 18601)
UPDATE creature_template SET AIName='', ScriptName='boss_broggok' WHERE entry=17380;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18601;
DELETE FROM smart_scripts WHERE entryorguid=17380 AND source_type=0;

-- Keli'dan the Breaker (17377, 18607)
UPDATE creature_template SET pickpocketloot=17377, mechanic_immune_mask=0, AIName='', ScriptName='boss_kelidan_the_breaker' WHERE entry=17377;
UPDATE creature_template SET pickpocketloot=17377, mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=18607;
DELETE FROM smart_scripts WHERE entryorguid=17377 AND source_type=0;

-- Shadowmoon Channeler (17653, 18620)
UPDATE creature_template SET AIName='', ScriptName='npc_shadowmoon_channeler' WHERE entry=17653;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=18620;
DELETE FROM smart_scripts WHERE entryorguid=17653 AND source_type=0;

-- -------------------------------------------
--                MISC
-- -------------------------------------------
-- Magtheridon (21174)
DELETE FROM creature_text WHERE entry=21174;
INSERT INTO creature_text VALUES (21174, 0, 0, "Wretched, meddling insects! Release me, and perhaps I will grant you a merciful death!", 14, 0, 100, 0, 0, 10247, 0, 'Magtheridon');
INSERT INTO creature_text VALUES (21174, 0, 1, "Vermin! Leeches! Take my blood and choke on it!", 14, 0, 100, 0, 0, 10248, 0, 'Magtheridon');
INSERT INTO creature_text VALUES (21174, 0, 2, "Illidan is an arrogant fool! I will crush him and reclaim Outland as my own!", 14, 0, 100, 0, 0, 10249, 0, 'Magtheridon');
INSERT INTO creature_text VALUES (21174, 0, 3, "Away, you mindless parasites! My blood is my own!", 14, 0, 100, 0, 0, 10250, 0, 'Magtheridon');
INSERT INTO creature_text VALUES (21174, 0, 4, "How long do you believe your pathetic sorcery can hold me?", 14, 0, 100, 0, 0, 10251, 0, 'Magtheridon');
INSERT INTO creature_text VALUES (21174, 0, 5, "My blood will be the end of you!", 14, 0, 100, 0, 0, 10252, 0, 'Magtheridon');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21174;
DELETE FROM smart_scripts WHERE entryorguid=21174 AND source_type=0;
INSERT INTO smart_scripts VALUES (21174, 0, 0, 0, 60, 0, 100, 0, 60000, 60000, 300000, 300000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magtheridon - Update - Talk 0');

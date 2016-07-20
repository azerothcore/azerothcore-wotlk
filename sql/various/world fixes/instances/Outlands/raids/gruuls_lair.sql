
UPDATE creature SET spawntimesecs=7*86400 WHERE map=565 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Lair Brute (19389)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=604057215, AIName='SmartAI', ScriptName='' WHERE entry=19389;
DELETE FROM smart_scripts WHERE entryorguid=19389 AND source_type=0;
INSERT INTO smart_scripts VALUES (19389, 0, 0, 0, 0, 0, 100, 0, 1000, 4000, 8000, 11000, 11, 39171, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lair Brute - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (19389, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 12000, 14000, 11, 39174, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lair Brute - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (19389, 0, 2, 0, 0, 0, 100, 0, 5000, 6000, 12000, 15000, 11, 24193, 0, 0, 0, 0, 0, 17, 8, 25, 0, 0, 0, 0, 0, 'Lair Brute - In Combat - Cast Charge');

-- Gronn-Priest (21350)
UPDATE creature_template SET dmg_multiplier=15, mechanic_immune_mask=604057215, AIName='SmartAI', ScriptName='' WHERE entry=21350;
DELETE FROM smart_scripts WHERE entryorguid=21350 AND source_type=0;
INSERT INTO smart_scripts VALUES (21350, 0, 0, 0, 14, 0, 100, 0, 100000, 40, 19000, 26000, 11, 36678, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gronn-Priest - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (21350, 0, 1, 0, 0, 0, 100, 0, 6000, 10000, 16000, 18000, 11, 22884, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gronn-Priest - In Combat - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES (21350, 0, 2, 0, 14, 0, 100, 0, 70000, 40, 19000, 25000, 11, 36679, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gronn-Priest - Friendly Missing Health - Cast Renew');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- High King Maulgar <Lord of the Ogres> (18831)
DELETE FROM creature_text WHERE entry=18831;
INSERT INTO creature_text VALUES (18831, 0, 0, 'Gronn are the real power in outland.', 14, 0, 100, 0, 0, 11367, 0, 'maulgar SAY_AGGRO');
INSERT INTO creature_text VALUES (18831, 1, 0, 'You will not defeat the hand of Gruul!', 14, 0, 100, 0, 0, 11368, 0, 'maulgar SAY_ENRAGE');
INSERT INTO creature_text VALUES (18831, 2, 0, 'You won''t kill next one so easy!', 14, 0, 100, 0, 0, 11369, 0, 'maulgar SAY_OGRE_DEATH1');
INSERT INTO creature_text VALUES (18831, 2, 1, 'Pah! Does not prove anything!', 14, 0, 100, 0, 0, 11370, 0, 'maulgar SAY_OGRE_DEATH2');
INSERT INTO creature_text VALUES (18831, 2, 2, 'I''m not afraid of you.', 14, 0, 100, 0, 0, 11371, 0, 'maulgar SAY_OGRE_DEATH3');
INSERT INTO creature_text VALUES (18831, 2, 3, 'Good, now you fight me!', 14, 0, 100, 0, 0, 11372, 0, 'maulgar SAY_OGRE_DEATH4');
INSERT INTO creature_text VALUES (18831, 3, 0, 'You not so tough afterall!', 14, 0, 100, 0, 0, 11373, 0, 'maulgar SAY_SLAY1');
INSERT INTO creature_text VALUES (18831, 3, 1, 'Aha-ha ha ha!', 14, 0, 100, 0, 0, 11374, 0, 'maulgar SAY_SLAY2');
INSERT INTO creature_text VALUES (18831, 3, 2, 'Mulgar is king!', 14, 0, 100, 0, 0, 11375, 0, 'maulgar SAY_SLAY3');
INSERT INTO creature_text VALUES (18831, 4, 0, 'Gruul... will crush you...', 14, 0, 100, 0, 0, 11376, 0, 'maulgar SAY_DEATH');
UPDATE creature_template SET dmg_multiplier=50, mechanic_immune_mask=650854271, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_high_king_maulgar' WHERE entry=18831;

-- Krosh Firehand (18832)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=650854267, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_krosh_firehand' WHERE entry=18832;

-- Olm the Summoner (18834)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=650854267, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_olm_the_summoner' WHERE entry=18834;

-- Kiggler the Crazed (18835)
UPDATE creature_template SET dmg_multiplier=25, mechanic_immune_mask=650854267, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_kiggler_the_crazed' WHERE entry=18835;

-- Blindeye the Seer (18836)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=604055167, flags_extra=flags_extra|0x200000, AIName='', ScriptName='boss_blindeye_the_seer' WHERE entry=18836;

-- Gruul the Dragonkiller (19044)
DELETE FROM creature_text WHERE entry=19044;
INSERT INTO creature_text VALUES (19044, 0, 0, 'Come... and die.', 14, 0, 100, 0, 0, 11355, 0, 'gruul SAY_AGGRO');
INSERT INTO creature_text VALUES (19044, 1, 0, 'Scurry', 14, 0, 100, 0, 0, 11356, 0, 'gruul SAY_SLAM1');
INSERT INTO creature_text VALUES (19044, 1, 1, 'No escape', 14, 0, 100, 0, 0, 11357, 0, 'gruul SAY_SLAM2');
INSERT INTO creature_text VALUES (19044, 2, 0, 'Stay', 14, 0, 100, 0, 0, 11358, 0, 'gruul SAY_SHATTER1');
INSERT INTO creature_text VALUES (19044, 2, 1, 'Beg... for life', 14, 0, 100, 0, 0, 11359, 0, 'gruul SAY_SHATTER2');
INSERT INTO creature_text VALUES (19044, 3, 0, 'No more', 14, 0, 100, 0, 0, 11360, 0, 'gruul SAY_SLAY1');
INSERT INTO creature_text VALUES (19044, 3, 1, 'Unworthy', 14, 0, 100, 0, 0, 11361, 0, 'gruul SAY_SLAY2');
INSERT INTO creature_text VALUES (19044, 3, 2, 'Die', 14, 0, 100, 0, 0, 11362, 0, 'gruul SAY_SLAY3');
INSERT INTO creature_text VALUES (19044, 4, 0, 'Aaargh...', 14, 0, 100, 0, 0, 11363, 0, 'gruul SAY_DEATH');
INSERT INTO creature_text VALUES (19044, 5, 0, '%s grows in size!', 16, 0, 100, 0, 0, 0, 0, 'gruul EMOTE_GROW');
UPDATE creature_template SET dmg_multiplier=35, mechanic_immune_mask=650854271, flags_extra=257|0x200000, AIName='', ScriptName='boss_gruul' WHERE entry=19044;

-- SPELL Ground Slam (33525)
DELETE FROM spell_script_names WHERE spell_id IN(33525);
INSERT INTO spell_script_names VALUES(33525, 'spell_gruul_ground_slam');

-- SPELL Ground Slam (39187)
DELETE FROM spell_script_names WHERE spell_id IN(39187);
INSERT INTO spell_script_names VALUES(39187, 'spell_gruul_ground_slam_trigger');

-- SPELL Shatter (33654)
DELETE FROM spell_script_names WHERE spell_id IN(33654);
INSERT INTO spell_script_names VALUES(33654, 'spell_gruul_shatter');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=33654;
INSERT INTO conditions VALUES(13, 1, 33654, 0, 0, 1, 0, 33652, 0, 0, 0, 0, 0, '', 'Requires Aura 33652 on target');

-- SPELL Shatter (33671)
DELETE FROM spell_script_names WHERE spell_id IN(33671);
INSERT INTO spell_script_names VALUES(33671, 'spell_gruul_shatter_effect');


UPDATE creature SET spawntimesecs=7*86400 WHERE map=544 AND spawntimesecs>0;

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Hellfire Warder (18829)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=604057215, AIName='SmartAI', ScriptName='' WHERE entry=18829;
DELETE FROM smart_scripts WHERE entryorguid=18829 AND source_type=0;
INSERT INTO smart_scripts VALUES (18829, 0, 0, 0, 0, 0, 100, 0, 1800, 16800, 18400, 21400, 11, 39175, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (18829, 0, 1, 0, 0, 0, 100, 0, 9000, 9000, 14500, 21500, 11, 34437, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Death Coil');
INSERT INTO smart_scripts VALUES (18829, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 27000, 28000, 11, 34435, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Rain of Fire');
INSERT INTO smart_scripts VALUES (18829, 0, 3, 0, 0, 0, 100, 0, 21000, 24100, 20000, 23500, 11, 34436, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Shadow Burst');
INSERT INTO smart_scripts VALUES (18829, 0, 4, 0, 0, 0, 100, 0, 14000, 17000, 17000, 29000, 11, 34439, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Unstable Affliction');
INSERT INTO smart_scripts VALUES (18829, 0, 5, 0, 0, 0, 100, 0, 1500, 7700, 15000, 20000, 11, 34441, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (18829, 0, 6, 0, 31, 0, 100, 0, 34439, 0, 0, 0, 13, 0, 100, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Warder - Spell Hit Target - Reset Threat');
INSERT INTO smart_scripts VALUES (18829, 0, 7, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 33346, 0, 0, 0, 0, 0, 19, 15384, 20, 0, 0, 0, 0, 0, 'Hellfire Warder - Out of Combat - Cast Green Beam');
INSERT INTO smart_scripts VALUES (18829, 0, 8, 0, 1, 0, 100, 1, 1500, 1500, 0, 0, 11, 33827, 0, 0, 0, 0, 0, 19, 19871, 10, 0, 0, 0, 0, 0, 'Hellfire Warder - Out of Combat - Cast Hellfire Warder Channel Visual');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=18829;
INSERT INTO conditions VALUES(22, 8, 18829, 0, 0, 29, 1, 15384, 20, 0, 0, 0, 0, '', 'Requires Old Trigger In Range');
INSERT INTO conditions VALUES(22, 9, 18829, 0, 0, 29, 1, 19871, 20, 0, 0, 0, 0, '', 'Requires Old Trigger In Range');

-- OLD World Trigger (DO NOT DELETE) (15384)
UPDATE creature SET id=19871 WHERE guid=91250 AND id=15384;

-- Hellfire Channeler (17256)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=604057215, AIName='SmartAI', ScriptName='' WHERE entry=17256;
DELETE FROM smart_scripts WHERE entryorguid=17256 AND source_type=0;
INSERT INTO smart_scripts VALUES (17256, 0, 0, 0, 0, 0, 100, 0, 1800, 16800, 18400, 21400, 11, 30510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (17256, 0, 1, 0, 14, 0, 100, 0, 70000, 30, 14500, 15000, 11, 30528, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - Friendly Missing Health - Cast Dark Mending');
INSERT INTO smart_scripts VALUES (17256, 0, 2, 0, 0, 0, 100, 0, 6000, 12000, 17000, 28000, 11, 30530, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (17256, 0, 3, 0, 0, 0, 100, 0, 10000, 30000, 20000, 40000, 11, 30511, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - In Combat - Cast Burning Abyssal');
INSERT INTO smart_scripts VALUES (17256, 0, 4, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 30207, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - Out of Combat - Cast Shadow Grasp');
INSERT INTO smart_scripts VALUES (17256, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 30531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Death - Cast Soul Transfer');
INSERT INTO smart_scripts VALUES (17256, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 34, 10, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On Aggro - Set Instance Data');
INSERT INTO smart_scripts VALUES (17256, 0, 7, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Channeler - On AI Init - Set React State');

-- SPELL Shadow Grasp (30207)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30207;
INSERT INTO conditions VALUES(13, 1, 30207, 0, 0, 31, 0, 3, 17257, 0, 0, 0, 0, '', 'Requires Magtheridon');

-- SPELL Soul Transfer (30531)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30531;
INSERT INTO conditions VALUES(13, 7, 30531, 0, 0, 31, 0, 3, 17256, 0, 0, 0, 0, '', 'Requires Hellfire Channeler');
INSERT INTO conditions VALUES(13, 7, 30531, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Requires Alive Target');

-- Burning Abyssal (17454)
UPDATE creature_template SET dmg_multiplier=20, mechanic_immune_mask=604057199, AIName='', ScriptName='' WHERE entry=17454;


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Magtheridon (17257)
DELETE FROM creature_text WHERE entry=17257;
INSERT INTO creature_text VALUES (17257, 0, 0, "Wretched, meddling insects! Release me, and perhaps I will grant you a merciful death!", 14, 0, 100, 0, 0, 10247, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 0, 1, "Vermin! Leeches! Take my blood and choke on it!", 14, 0, 100, 0, 0, 10248, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 0, 2, "Illidan is an arrogant fool! I will crush him and reclaim Outland as my own!", 14, 0, 100, 0, 0, 10249, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 0, 3, "Away, you mindless parasites! My blood is my own!", 14, 0, 100, 0, 0, 10250, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 0, 4, "How long do you believe your pathetic sorcery can hold me?", 14, 0, 100, 0, 0, 10251, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 0, 5, "My blood will be the end of you!", 14, 0, 100, 0, 0, 10252, 0, 'Magtheridon SAY_TAUNT');
INSERT INTO creature_text VALUES (17257, 1, 0, "I... am... UNLEASHED!!!", 14, 0, 100, 15, 0, 10253, 0, 'Magtheridon SAY_FREE');
INSERT INTO creature_text VALUES (17257, 2, 0, "Thank you for releasing me. Now... die!", 14, 0, 100, 0, 0, 10254, 0, 'Magtheridon SAY_AGGRO');
INSERT INTO creature_text VALUES (17257, 3, 0, "Did you think me weak? Soft? Who is the weak one now?!", 14, 0, 100, 0, 0, 10255, 0, 'Magtheridon SAY_SLAY');
INSERT INTO creature_text VALUES (17257, 4, 0, "Not again... NOT AGAIN!", 14, 0, 100, 0, 0, 10256, 0, 'Magtheridon SAY_BANISH');
INSERT INTO creature_text VALUES (17257, 5, 0, "I will not be taken so easily. Let the walls of this prison tremble... and FALL!!!", 14, 0, 100, 0, 0, 10257, 0, 'Magtheridon SAY_PHASE3');
INSERT INTO creature_text VALUES (17257, 6, 0, "The Legion... will consume you... all....", 14, 0, 100, 0, 0, 10258, 0, 'Magtheridon SAY_DEATH');
INSERT INTO creature_text VALUES (17257, 7, 0, "%s's bonds begin to weaken!", 16, 0, 100, 0, 0, 0, 0, 'Magtheridon SAY_EMOTE_BEGIN');
INSERT INTO creature_text VALUES (17257, 8, 0, "%s is nearly free of his bonds!", 16, 0, 100, 0, 0, 0, 0, 'Magtheridon SAY_EMOTE_NEARLY');
INSERT INTO creature_text VALUES (17257, 9, 0, "%s breaks free", 16, 0, 100, 0, 0, 0, 0, 'Magtheridon SAY_EMOTE_FREE');
INSERT INTO creature_text VALUES (17257, 10, 0, "%s begins to cast Blast Nova!", 41, 0, 100, 0, 0, 0, 0, 'Magtheridon SAY_EMOTE_NOVA');
UPDATE creature_template SET dmg_multiplier=60, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='boss_magtheridon' WHERE entry=17257;

-- GO Manticron Cube (181713)
UPDATE gameobject_template SET data10=30410, AIName='', ScriptName='' WHERE entry=181713;

-- SPELL Shadow Cage (30205)
DELETE FROM spell_script_names WHERE spell_id IN(30205);
INSERT INTO spell_script_names VALUES(30205, 'spell_gen_visual_dummy_stun');

-- SPELL Blaze (30541)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(30541);
DELETE FROM spell_script_names WHERE spell_id IN(30541);
INSERT INTO spell_script_names VALUES(30541, 'spell_magtheridon_blaze');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30541;
INSERT INTO conditions VALUES(13, 1, 30541, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Shadow Grasp (30166)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30166;
INSERT INTO conditions VALUES(13, 1, 30166, 0, 0, 31, 0, 3, 17257, 0, 0, 0, 0, '', 'Requires Magtheridon');

-- SPELL Shadow Grasp (30410)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30410;
INSERT INTO conditions VALUES(13, 1, 30410, 0, 0, 31, 0, 3, 17376, 0, 0, 0, 0, '', 'Requires Hellfire Raid Trigger');
DELETE FROM spell_script_names WHERE spell_id IN(30410);
INSERT INTO spell_script_names VALUES(30410, 'spell_magtheridon_shadow_grasp');

-- SPELL Quake (30657)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30657;
INSERT INTO conditions VALUES(13, 7, 30657, 0, 0, 31, 0, 3, 17474, 0, 0, 0, 0, '', 'Target Magtheridon');

-- SPELL Quake (30658)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(30658);
INSERT INTO spell_linked_spell VALUES(30658, 30571, 1, 'Magtheridon - Quake Trigger');

-- SPELL Quake (30571)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30571;
INSERT INTO conditions VALUES(13, 1, 30571, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- Target Trigger (17474)
DELETE FROM creature WHERE map=544 AND id=17474;
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, -48.9583, 13.154, -0.412463, 0.115381, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, -45.9022, -10.0254, -0.412444, 0.131089, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, -17.1508, 36.9743, -0.412406, 0.131089, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, -4.09094, 7.21651, -0.408083, 0.131089, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, 0.0997306, -31.5231, -0.409845, 2.8682, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 544, 1, 1, 0, 0, -31.908, 19.128, -0.412, 0, 86400, 0, 0, 6722, 0, 0, 0, 0, 0);

-- SPELL Camera Shake - Magtheridon (36455)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36455;
INSERT INTO conditions VALUES(13, 1, 36455, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Debris (36449)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36449;
INSERT INTO conditions VALUES(13, 3, 36449, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');

-- SPELL Debris (30632)
DELETE FROM spell_script_names WHERE spell_id IN(30632);

-- SPELL Debris (30631)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30631;
INSERT INTO conditions VALUES(13, 1, 30631, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');


UPDATE creature SET spawntimesecs=86400 WHERE map=289 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=289 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Risen Guard (10489)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10489;
DELETE FROM smart_scripts WHERE entryorguid=10489 AND source_type=0;
INSERT INTO smart_scripts VALUES (10489, 0, 0, 0, 0, 0, 100, 0, 1000, 11000, 10000, 20000, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Guard - In Combat - Cast Shield Slam');
INSERT INTO smart_scripts VALUES (10489, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 9000, 14000, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Guard - In Combat - Cast Sunder Armor');

-- Scholomance Neophyte (10470)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10470;
DELETE FROM smart_scripts WHERE entryorguid=10470 AND source_type=0;
INSERT INTO smart_scripts VALUES (10470, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Neophyte - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10470, 0, 1, 0, 0, 0, 100, 0, 1000, 11000, 19000, 24000, 11, 12542, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Scholomance Neophyte - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (10470, 0, 2, 0, 0, 0, 100, 0, 1000, 6000, 10000, 15000, 11, 17165, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Scholomance Neophyte - In Combat - Cast Mind Flay');

-- Scholomance Acolyte (10471)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10471;
DELETE FROM smart_scripts WHERE entryorguid=10471 AND source_type=0;
INSERT INTO smart_scripts VALUES (10471, 0, 0, 0, 1, 0, 100, 1, 1000, 5000, 0, 0, 11, 16592, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Acolyte - Out of Combat - Cast Shadowform');
INSERT INTO smart_scripts VALUES (10471, 0, 1, 0, 0, 0, 100, 0, 1000, 8000, 10000, 20000, 11, 17615, 0, 0, 0, 0, 0, 5, 20, 0, 1, 0, 0, 0, 0, 'Scholomance Acolyte - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (10471, 0, 2, 0, 0, 0, 100, 0, 1000, 6000, 10000, 15000, 11, 11443, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Scholomance Acolyte - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (10471, 0, 3, 0, 0, 0, 100, 0, 1000, 6000, 10000, 15000, 11, 17165, 64, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Scholomance Acolyte - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (10471, 0, 4, 0, 14, 0, 100, 0, 3000, 30, 6000, 8000, 11, 17613, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Acolyte - Friendly Missing Health - Cast Dark Mending');

-- Spectral Researcher (10499)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10499;
DELETE FROM smart_scripts WHERE entryorguid=10499 AND source_type=0;
INSERT INTO smart_scripts VALUES (10499, 0, 0, 0, 0, 0, 100, 0, 3000, 12000, 10000, 16000, 11, 17631, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Researcher - In Combat - Cast Wail of Souls');
INSERT INTO smart_scripts VALUES (10499, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 10000, 16000, 11, 17630, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Spectral Researcher - In Combat - Cast Mana Burn');

-- Blood Steward of Kirtonos (14861)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14861;
DELETE FROM smart_scripts WHERE entryorguid=14861 AND source_type=0;
INSERT INTO smart_scripts VALUES (14861, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 4086, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blood Steward of Kirtonos - Out of Combat - Cast Evasion');
INSERT INTO smart_scripts VALUES (14861, 0, 1, 0, 0, 0, 100, 0, 10000, 13000, 25000, 25000, 11, 22371, 32, 0, 0, 0, 0, 6, 20, 0, 1, 0, 0, 0, 0, 'Blood Steward of Kirtonos - In Combat - Cast Curse of Impotence');
INSERT INTO smart_scripts VALUES (14861, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 25000, 25000, 11, 12493, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Steward of Kirtonos - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (14861, 0, 3, 0, 0, 0, 100, 0, 7000, 7000, 20000, 20000, 11, 3609, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Blood Steward of Kirtonos - In Combat - Cast Paralyzing Poison');

-- Necrofiend (11551)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11551;
DELETE FROM smart_scripts WHERE entryorguid=11551 AND source_type=0;
INSERT INTO smart_scripts VALUES (11551, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 10022, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Necrofiend - On Reset - Cast Deadly Poison');
INSERT INTO smart_scripts VALUES (11551, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 13000, 20000, 11, 15474, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Necrofiend - In Combat - Cast Web Explosion');

-- Scholomance Necrolyte (10476)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10476;
DELETE FROM smart_scripts WHERE entryorguid=10476 AND source_type=0;
INSERT INTO smart_scripts VALUES (10476, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necrolyte - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (10476, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 12000, 11, 17234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necrolyte - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (10476, 0, 2, 0, 0, 0, 100, 1, 5000, 10000, 0, 0, 11, 17151, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necrolyte - In Combat - Cast Shadow Barrier');

-- Scholomance Dark Summoner (11582)
DELETE FROM creature_text WHERE entry=11582;
INSERT INTO creature_text VALUES (11582, 0, 0, 'Now this is an example of what not to summon. Look, it''s frail and brittle. One good whack from a mace will send bone shards flying.', 12, 0, 100, 0, 0, 0, 0, 'Scholomance Dark Summoner');
INSERT INTO creature_text VALUES (11582, 0, 1, 'Note the weak binding structure of this one. Be sure to finish your incantations or this is what you will end up with.', 12, 0, 100, 0, 0, 0, 0, 'Scholomance Dark Summoner');
INSERT INTO creature_text VALUES (11582, 0, 2, 'This one is slightly better than the last. However, it still suffers from the same flimsy bone structure as the others. When you summon one of these, you are on the right path.', 12, 0, 100, 0, 0, 0, 0, 'Scholomance Dark Summoner');
INSERT INTO creature_text VALUES (11582, 0, 3, 'Wow, this one is just plain useless. Let me try again.', 12, 0, 100, 0, 0, 0, 0, 'Scholomance Dark Summoner');
INSERT INTO creature_text VALUES (11582, 0, 4, 'Hmmm, this one looks like something that would be better off as a windchime. Take notes class... This is NOT what you want to summon in the heat of battle.', 12, 0, 100, 0, 0, 0, 0, 'Scholomance Dark Summoner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11582;
DELETE FROM smart_scripts WHERE entryorguid=11582 AND source_type=0;
INSERT INTO smart_scripts VALUES (11582, 0, 0, 1, 1, 0, 100, 0, 1000, 20000, 30000, 50000, 11, 16531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - Out of Combat - Cast Summon Frail Skeleton');
INSERT INTO smart_scripts VALUES (11582, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 12000, 12000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - Out of Combat - Create Timed Event');
INSERT INTO smart_scripts VALUES (11582, 0, 2, 0, 59, 0, 50, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - On Timed Event - Say Line 0');
INSERT INTO smart_scripts VALUES (11582, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - On Aggro - Remove Timed Event');
INSERT INTO smart_scripts VALUES (11582, 0, 4, 0, 0, 0, 100, 0, 2000, 5000, 5000, 7000, 11, 17618, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - In Combat - Cast Summon Risen Lackey');
INSERT INTO smart_scripts VALUES (11582, 0, 5, 0, 0, 0, 100, 0, 1000, 15000, 18000, 32000, 11, 12279, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - In Combat - Cast Curse of Blood');
INSERT INTO smart_scripts VALUES (11582, 0, 6, 0, 0, 0, 100, 0, 1000, 7000, 11000, 20000, 11, 17620, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Scholomance Dark Summoner - In Combat - Cast Drain Life');

-- Frail Skeleton (11258)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11258);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11258);
DELETE FROM creature WHERE id=11258;
UPDATE creature_template SET unit_flags=768|4|2, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=11258;
DELETE FROM smart_scripts WHERE entryorguid=11258 AND source_type=0;
INSERT INTO smart_scripts VALUES (11258, 0, 0, 0, 1, 0, 100, 1, 18000, 18000, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Frail Skeleton - On Update - Die');

-- Risen Lackey (10482)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=10482);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=10482);
DELETE FROM creature WHERE id=10482;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10482;
DELETE FROM smart_scripts WHERE entryorguid=10482 AND source_type=0;
INSERT INTO smart_scripts VALUES (10482, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Risen Lackey - Out of Combat - Attack Start');

-- Scholomance Adept (10469)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10469;
DELETE FROM smart_scripts WHERE entryorguid=10469 AND source_type=0;
INSERT INTO smart_scripts VALUES (10469, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 15043, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Adept - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (10469, 0, 1, 0, 0, 0, 100, 0, 1000, 9000, 11000, 15000, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Adept - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (10469, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 11000, 15000, 11, 15499, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Adept - In Combat - Cast Frost Shock');
INSERT INTO smart_scripts VALUES (10469, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Adept - Between 0-15% Health - Flee For Assist');

-- Scholomance Necromancer (10477)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10477;
DELETE FROM smart_scripts WHERE entryorguid=10477 AND source_type=0;
INSERT INTO smart_scripts VALUES (10477, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 5000, 9000, 11, 14887, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necromancer - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (10477, 0, 1, 0, 0, 0, 100, 0, 1000, 25000, 60000, 60000, 11, 12020, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necromancer - In Combat - Cast Call of the Graves');
INSERT INTO smart_scripts VALUES (10477, 0, 2, 0, 0, 0, 100, 0, 5000, 10000, 11000, 15000, 11, 17616, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necromancer - In Combat - Cast Corpse Explosion');
INSERT INTO smart_scripts VALUES (10477, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Necromancer - Between 0-15% Health - Flee For Assist');

-- SPELL Corpse Explosion (17616)
DELETE FROM conditions WHERE SourceEntry=17616 AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 17616, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Target Any Npc');
INSERT INTO conditions VALUES(13, 1, 17616, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Dead Unit');
INSERT INTO conditions VALUES(13, 1, 17616, 0, 0, 1, 0, 61614, 1, 0, 1, 0, 0, '', 'Not Exploded');

-- Spectral Tutor (10498)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10498;
DELETE FROM smart_scripts WHERE entryorguid=10498 AND source_type=0;
INSERT INTO smart_scripts VALUES (10498, 0, 0, 0, 0, 0, 100, 0, 3000, 13000, 15000, 31000, 11, 12528, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (10498, 0, 1, 2, 2, 0, 100, 1, 0, 40, 0, 0, 11, 17651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - Between 0-40% Health - Cast Image Projection');
INSERT INTO smart_scripts VALUES (10498, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17653, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - Between 0-40% Health - Cast Summon Spectral Projections');
INSERT INTO smart_scripts VALUES (10498, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - Between 0-40% Health - Set Event Phase');
INSERT INTO smart_scripts VALUES (10498, 0, 4, 0, 0, 1, 100, 0, 8000, 8000, 10000, 10000, 11, 17652, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - In Combat - Cast Image Projection');
INSERT INTO smart_scripts VALUES (10498, 0, 5, 0, 0, 0, 100, 0, 3000, 12000, 10000, 16000, 11, 17630, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Spectral Tutor - In Combat - Cast Mana Burn');

-- SPELL Image Projection (17652)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=17652;
INSERT INTO conditions VALUES(13, 1, 17652, 0, 0, 31, 0, 3, 11263, 0, 0, 0, 0, '', 'Target Spectral Projection');
INSERT INTO conditions VALUES(13, 1, 17652, 0, 0, 33, 0, 1, 3, 0, 0, 0, 0, '', 'Owned by caster');

-- Spectral Projection (11263)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11263);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11263);
DELETE FROM creature WHERE id=11263;
UPDATE creature_template SET Health_mod=0.5, AIName='SmartAI', ScriptName='' WHERE entry=11263;
DELETE FROM smart_scripts WHERE entryorguid=11263 AND source_type=0;
INSERT INTO smart_scripts VALUES (11263, 0, 0, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (11263, 0, 1, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Tutor - Out of Combat - Despawn');

-- Risen Protector (10487)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10487;
DELETE FROM smart_scripts WHERE entryorguid=10487 AND source_type=0;
INSERT INTO smart_scripts VALUES (10487, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 5000, 9000, 11, 17439, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Protector - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (10487, 0, 1, 0, 0, 0, 100, 0, 1000, 25000, 20000, 30000, 11, 6726, 0, 0, 0, 0, 0, 5, 20, 0, 1, 0, 0, 0, 0, 'Risen Protector - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (10487, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 11000, 20000, 11, 15654, 0, 1, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Risen Protector - In Combat - Cast Shadow Word: Pain');

-- Risen Aberration (10485)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10485;
DELETE FROM smart_scripts WHERE entryorguid=10485 AND source_type=0;
INSERT INTO smart_scripts VALUES (10485, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 10000, 20000, 11, 12021, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 'Risen Aberration - In Combat - Cast Fixate');
INSERT INTO smart_scripts VALUES (10485, 0, 1, 2, 25, 0, 100, 0, 0, 0, 0, 0, 11, 7743, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Aberration - On Reset - Cast Immunity Shadow');
INSERT INTO smart_scripts VALUES (10485, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 7940, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Aberration - On Reset - Cast Immunity Frost');
INSERT INTO smart_scripts VALUES (10485, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 7941, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Aberration - On Reset - Cast Immunity Nature');
INSERT INTO smart_scripts VALUES (10485, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 11, 7942, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Aberration - On Reset - Cast Immunity Fire');
INSERT INTO smart_scripts VALUES (10485, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 34184, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Aberration - On Reset - Cast Immunity Arcane');

-- SPELL Fixate (12021)
DELETE FROM spell_script_names WHERE spell_id IN(12021);
INSERT INTO spell_script_names VALUES(12021, 'spell_scholomance_fixate');

-- Diseased Ghoul (10495)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10495;
DELETE FROM smart_scripts WHERE entryorguid=10495 AND source_type=0;
INSERT INTO smart_scripts VALUES (10495, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12627, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Diseased Ghoul - On Reset - Cast Disease Cloud');
INSERT INTO smart_scripts VALUES (10495, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 8247, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Diseased Ghoul - On Reset - Cast Wandering Plague');
INSERT INTO smart_scripts VALUES (10495, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 17742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Diseased Ghoul - On Death - Cast Cloud of Disease');

-- Reanimated Corpse (10481)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10481;
DELETE FROM smart_scripts WHERE entryorguid=10481 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=10481*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (10481, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - On Reset - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (10481, 0, 1, 0, 0, 0, 100, 0, 3000, 10000, 15000, 25000, 11, 18270, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - In Combat - Cast Dark Plague');
INSERT INTO smart_scripts VALUES (10481, 0, 2, 0, 2, 0, 100, 257, 0, 1, 0, 0, 80, 10481*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Between 0-1% Health - Run Script');
INSERT INTO smart_scripts VALUES (10481*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 95, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Add Dynamic Flag');
INSERT INTO smart_scripts VALUES (10481*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Add Bytes0 Flag');
INSERT INTO smart_scripts VALUES (10481*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28782, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Cast Stun Self + Immune');
INSERT INTO smart_scripts VALUES (10481*100, 9, 3, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 96, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Remove Dynamic Flag');
INSERT INTO smart_scripts VALUES (10481*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Remove Bytes0 Flag');
INSERT INTO smart_scripts VALUES (10481*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 28782, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Remove Aura Stun Self + Immune');
INSERT INTO smart_scripts VALUES (10481*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 17683, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Cast Full Heal');
INSERT INTO smart_scripts VALUES (10481*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Corpse - Script9 - Set HP Invincibility');

-- Scholomance Handler (11257)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11257;
DELETE FROM smart_scripts WHERE entryorguid=11257 AND source_type=0;
INSERT INTO smart_scripts VALUES (11257, 0, 0, 0, 0, 0, 100, 0, 11000, 25000, 25000, 39000, 11, 17145, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Handler - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (11257, 0, 1, 0, 0, 0, 100, 0, 7000, 16000, 14000, 21000, 11, 15244, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Handler - In Combat - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (11257, 0, 2, 0, 0, 0, 100, 0, 4000, 12000, 11000, 15000, 11, 10833, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Handler - In Combat - Cast Arcane Blast');

-- Plagued Hatchling (10678)
UPDATE creature SET spawndist=8, MovementType=1 WHERE id=10678;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10678;
DELETE FROM smart_scripts WHERE entryorguid=10678 AND source_type=0;
INSERT INTO smart_scripts VALUES (10678, 0, 0, 0, 0, 0, 100, 0, 3000, 10000, 8000, 20000, 11, 17745, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Plagued Hatchling - In Combat - Cast Diseased Spit');

-- Risen Construct (10488)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10488;
DELETE FROM smart_scripts WHERE entryorguid=10488 AND source_type=0;
INSERT INTO smart_scripts VALUES (10488, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (10488, 0, 1, 0, 0, 0, 100, 1, 15000, 36000, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast Frenzy');
INSERT INTO smart_scripts VALUES (10488, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 8000, 13000, 11, 16169, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Construct - In Combat - Cast Arcing Smash');

-- Spectral Teacher (10500)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10500;
DELETE FROM smart_scripts WHERE entryorguid=10500 AND source_type=0;
INSERT INTO smart_scripts VALUES (10500, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 30000, 30000, 11, 17633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Teacher - In Combat - Cast Arcane Focus');
INSERT INTO smart_scripts VALUES (10500, 0, 1, 0, 0, 0, 100, 0, 11000, 22000, 20000, 30000, 11, 8994, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Spectral Teacher - In Combat - Cast Banish');
INSERT INTO smart_scripts VALUES (10500, 0, 2, 0, 0, 0, 100, 0, 3000, 12000, 10000, 16000, 11, 17630, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Spectral Teacher - In Combat - Cast Mana Burn');

-- Splintered Skeleton (10478)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=10478;
DELETE FROM smart_scripts WHERE entryorguid=10478 AND source_type=0;

-- Risen Bonewarder (10491)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10491;
DELETE FROM smart_scripts WHERE entryorguid=10491 AND source_type=0;
INSERT INTO smart_scripts VALUES (10491, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 60000, 60000, 11, 16431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Bonewarder - In Combat - Cast Bone Armor');
INSERT INTO smart_scripts VALUES (10491, 0, 1, 0, 0, 0, 100, 0, 10000, 30000, 30000, 40000, 11, 17715, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Bonewarder - In Combat - Cast Consuming Shadows');
INSERT INTO smart_scripts VALUES (10491, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 8000, 13000, 11, 17620, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Risen Bonewarder - In Combat - Cast Drain Life');

-- Risen Warrior (10486)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10486;
DELETE FROM smart_scripts WHERE entryorguid=10486 AND source_type=0;
INSERT INTO smart_scripts VALUES (10486, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 6000, 11000, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Warrior - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10486, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 20000, 30000, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Warrior - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (10486, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 11000, 17000, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Warrior - In Combat - Cast Knock Down');
INSERT INTO smart_scripts VALUES (10486, 0, 3, 0, 0, 0, 100, 0, 8000, 15000, 17000, 27000, 11, 15588, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Warrior - In Combat - Cast Thunderclap');

-- Unstable Corpse (10480)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10480;
DELETE FROM smart_scripts WHERE entryorguid=10480 AND source_type=0;
INSERT INTO smart_scripts VALUES (10480, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 17690, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Unstable Corpse - On Reset - Cast Disease Burst');

-- Scholomance Occultist (10472)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10472;
DELETE FROM smart_scripts WHERE entryorguid=10472 AND source_type=0;
INSERT INTO smart_scripts VALUES (10472, 0, 0, 0, 0, 0, 100, 0, 1000, 7000, 60000, 60000, 11, 16431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Occultist - In Combat - Cast Bone Armor');
INSERT INTO smart_scripts VALUES (10472, 0, 1, 0, 13, 0, 100, 0, 10000, 20000, 0, 0, 11, 15122, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Occultist - Victim Casting - Cast Counterspell');
INSERT INTO smart_scripts VALUES (10472, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 11000, 17000, 11, 17228, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Occultist - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (10472, 0, 3, 0, 0, 0, 100, 0, 6000, 15000, 13000, 21000, 11, 17243, 64, 0, 0, 0, 0, 5, 20, 0, 1, 0, 0, 0, 0, 'Scholomance Occultist - In Combat - Cast Drain Mana');




-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Kirtonos the Herald (10506)
DELETE FROM creature_text WHERE entry=10506;
INSERT INTO creature_text VALUES (10506, 0, 0, '%s lets out a shrill cry.', 16, 0, 100, 0, 0, 0, 0, 'Kirtonos The Herald - Emote');
UPDATE creature_template SET AIName='', ScriptName='boss_kirtonos_the_herald' WHERE entry=10506;
DELETE FROM smart_scripts WHERE entryorguid=10506 AND source_type=0;
DELETE FROM waypoint_data WHERE id=105061;
INSERT INTO waypoint_data VALUES (105061, 1, 316.709, 71.2683, 104.584, 0, 0, 1, 0, 100, 0),(105061, 2, 321.16, 72.8097, 104.668, 0, 0, 1, 0, 100, 0),(105061, 3, 332.371, 77.9899, 105.862, 0, 0, 1, 0, 100, 0),(105061, 4, 333.325, 86.6016, 106.64, 0, 0, 1, 0, 100, 0),(105061, 5, 334.126, 101.684, 106.834, 0, 0, 1, 0, 100, 0),(105061, 6, 331.046, 114.593, 106.362, 0, 0, 1, 0, 100, 0),(105061, 7, 329.544, 126.702, 106.14, 0, 0, 1, 0, 100, 0),(105061, 8, 335.247, 136.546, 105.723, 0, 0, 1, 0, 100, 0),(105061, 9, 343.21, 139.946, 107.64, 0, 0, 1, 0, 100, 0),(105061, 10, 364.329, 140.901, 109.945, 0, 0, 1, 0, 100, 0),(105061, 11, 362.676, 115.638, 110.307, 0, 0, 1, 0, 100, 0),(105061, 12, 341.79, 91.9439, 107.168, 0, 0, 1, 0, 100, 0),(105061, 13, 313.495, 93.4594, 104.057, 0, 0, 1, 0, 100, 0),(105061, 14, 306.384, 93.6168, 104.057, 0, 0, 1, 0, 100, 0);

-- Jandice Barov (10503)
DELETE FROM creature_text WHERE entry=10503;
INSERT INTO creature_text VALUES (10503, 0, 0, '%s loosens her grasp on the journal she had been clutching.', 16, 0, 100, 0, 0, 0, 0, 'Jandice Barov');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10503;
DELETE FROM smart_scripts WHERE entryorguid=10503 AND source_type=0;
INSERT INTO smart_scripts VALUES (10503, 0, 0, 0, 0, 0, 100, 0, 3000, 11000, 30000, 30000, 11, 24673, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - In Combat - Cast Curse of Blood');
INSERT INTO smart_scripts VALUES (10503, 0, 1, 0, 0, 0, 100, 0, 11000, 22000, 20000, 30000, 11, 27565, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Jandice Barov - In Combat - Cast Banish');
INSERT INTO smart_scripts VALUES (10503, 0, 2, 3, 0, 0, 100, 0, 20000, 20000, 50000, 50000, 11, 17773, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - In Combat - Cast Summon Illusions');
INSERT INTO smart_scripts VALUES (10503, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - In Combat - Set Invisible');
INSERT INTO smart_scripts VALUES (10503, 0, 4, 0, 0, 0, 100, 0, 21000, 21000, 50000, 50000, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - In Combat - Set Visible');
INSERT INTO smart_scripts VALUES (10503, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - On Death - Say Line 0');
INSERT INTO smart_scripts VALUES (10503, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 26096, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - On Death - Cast Jandice Drops Journal DND');
INSERT INTO smart_scripts VALUES (10503, 0, 7, 0, 1, 0, 100, 1, 5000, 5000, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jandice Barov - Out of Combat - Set Visible');

-- Illusion of Jandice Barov (11439)
REPLACE INTO creature_equip_template VALUES (11439, 1, 12866, 0, 0, 18019);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=11439);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11439);
DELETE FROM creature WHERE id=11439;
UPDATE creature_template SET dmg_multiplier=1.5, AIName='', ScriptName='' WHERE entry=11439;
DELETE FROM smart_scripts WHERE entryorguid=11439 AND source_type=0;

-- Rattlegore (11622)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11622;
DELETE FROM smart_scripts WHERE entryorguid=11622 AND source_type=0;
INSERT INTO smart_scripts VALUES (11622, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 15000, 25000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rattlegore - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (11622, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 18368, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Rattlegore - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (11622, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 20000, 20000, 11, 16727, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Rattlegore - In Combat - Cast War Stomp');

-- Ras Frostwhisper (10508)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10508;
DELETE FROM smart_scripts WHERE entryorguid=10508 AND source_type=0;
INSERT INTO smart_scripts VALUES (10508, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 600000, 600000, 11, 18100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ras Frostwhisper - Out of Combat - Cast Frost Armor');
INSERT INTO smart_scripts VALUES (10508, 0, 1, 0, 0, 0, 100, 0, 7000, 15000, 15000, 25000, 11, 12096, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Ras Frostwhisper - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (10508, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 7000, 12000, 11, 8398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ras Frostwhisper - In Combat - Cast Frostbolt Volley');
INSERT INTO smart_scripts VALUES (10508, 0, 3, 0, 0, 0, 100, 0, 7000, 10000, 20000, 20000, 11, 18763, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Ras Frostwhisper - In Combat - Cast Freeze');
INSERT INTO smart_scripts VALUES (10508, 0, 4, 0, 0, 0, 100, 0, 15000, 20000, 20000, 20000, 11, 18099, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ras Frostwhisper - In Combat - Cast Chill Nova');

-- Instructor Malicia (10505)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10505;
DELETE FROM smart_scripts WHERE entryorguid=10505 AND source_type=0;
INSERT INTO smart_scripts VALUES (10505, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 60000, 60000, 11, 12020, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - In Combat - Cast Call of the Grave');
INSERT INTO smart_scripts VALUES (10505, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 17000, 22000, 11, 11672, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (10505, 0, 2, 0, 14, 0, 100, 0, 5000, 40, 10000, 10000, 11, 10929, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (10505, 0, 3, 0, 14, 0, 100, 0, 5000, 40, 8000, 8000, 11, 10917, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - Friendly Missing Health - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (10505, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Instructor Malicia - On Death - Set Instance Data');

-- Doctor Theolen Krastinov (11261)
DELETE FROM creature_text WHERE entry=11261;
INSERT INTO creature_text VALUES (11261, 0, 0, 'The doctor is in!', 12, 0, 100, 0, 0, 0, 3, 'Doctor Theolen Krastinov');
INSERT INTO creature_text VALUES (11261, 1, 0, 'Time for a little open-heart surgery!', 12, 0, 100, 0, 0, 0, 3, 'Doctor Theolen Krastinov');
INSERT INTO creature_text VALUES (11261, 2, 0, 'Another successful operation!', 12, 0, 100, 0, 0, 0, 3, 'Doctor Theolen Krastinov');
INSERT INTO creature_text VALUES (11261, 3, 0, 'Donate...my body...to science...', 12, 0, 100, 0, 0, 0, 3, 'Doctor Theolen Krastinov');
INSERT INTO creature_text VALUES (11261, 4, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Doctor Theolen Krastinov');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11261;
DELETE FROM smart_scripts WHERE entryorguid=11261 AND source_type=0;
INSERT INTO smart_scripts VALUES (11261, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 10000, 13000, 11, 18103, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (11261, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 14000, 18000, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (11261, 0, 2, 3, 2, 0, 100, 1, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - Between 0-40% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (11261, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - Between 0-40% Health - Say Line 4');
INSERT INTO smart_scripts VALUES (11261, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - On Death - Set Instance Data');
INSERT INTO smart_scripts VALUES (11261, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - On Death - Say Line 3');
INSERT INTO smart_scripts VALUES (11261, 0, 6, 0, 5, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - On Kill - Say Line 2');
INSERT INTO smart_scripts VALUES (11261, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - On Aggro - Say Line 1');
INSERT INTO smart_scripts VALUES (11261, 0, 8, 0, 10, 0, 100, 257, 0, 60, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doctor Theolen Krastinov - On OOC Los - Say Line 0');

-- Lorekeeper Polkelt (10901)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10901;
DELETE FROM smart_scripts WHERE entryorguid=10901 AND source_type=0;
INSERT INTO smart_scripts VALUES (10901, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 40000, 40000, 11, 3584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast Volatile Infection');
INSERT INTO smart_scripts VALUES (10901, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 17000, 28000, 11, 16359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast Corrosive Acid Breath');
INSERT INTO smart_scripts VALUES (10901, 0, 2, 0, 0, 0, 100, 0, 11000, 22000, 30000, 30000, 11, 18151, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast Noxious Catalyst');
INSERT INTO smart_scripts VALUES (10901, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - On Death - Set Instance Data');

-- The Ravenian (10507)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10507;
DELETE FROM smart_scripts WHERE entryorguid=10507 AND source_type=0;
INSERT INTO smart_scripts VALUES (10507, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 8000, 13000, 11, 20691, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Ravenian - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10507, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 17000, 28000, 11, 15550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Ravenian - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (10507, 0, 2, 0, 0, 0, 100, 0, 11000, 22000, 10000, 20000, 11, 10101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Ravenian - In Combat - Cast Knock Away');
INSERT INTO smart_scripts VALUES (10507, 0, 3, 0, 0, 0, 100, 0, 1000, 22000, 14000, 24000, 11, 25174, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'The Ravenian - In Combat - Cast Sundering Cleave');
INSERT INTO smart_scripts VALUES (10507, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Ravenian - On Death - Set Instance Data');

-- Lord Alexei Barov (10504)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10504;
DELETE FROM smart_scripts WHERE entryorguid=10504 AND source_type=0;
INSERT INTO smart_scripts VALUES (10504, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 17467, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Alexei Barov - On Reset - Cast Unholy Aura');
INSERT INTO smart_scripts VALUES (10504, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 21000, 11, 20294, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lord Alexei Barov - In Combat - Cast Immolate');
INSERT INTO smart_scripts VALUES (10504, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 15000, 25000, 11, 17820, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Alexei Barov - In Combat - Cast Veil of Shadows');
INSERT INTO smart_scripts VALUES (10504, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lord Alexei Barov - On Death - Set Instance Data');

-- Lady Illucia Barov (10502)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10502;
DELETE FROM smart_scripts WHERE entryorguid=10502 AND source_type=0;
INSERT INTO smart_scripts VALUES (10502, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 11000, 19000, 11, 12542, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Lady Illucia Barov - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (10502, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 10000, 10000, 11, 19460, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lady Illucia Barov - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (10502, 0, 2, 0, 0, 0, 100, 0, 8000, 15000, 10000, 20000, 11, 15487, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Lady Illucia Barov - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (10502, 0, 3, 0, 0, 0, 100, 0, 1000, 10000, 14000, 24000, 11, 18266, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Lady Illucia Barov - In Combat - Cast Curse of Agony');
INSERT INTO smart_scripts VALUES (10502, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lady Illucia Barov - On Death - Set Instance Data');

-- Darkmaster Gandling (1853)
DELETE FROM creature WHERE id=1853;
INSERT INTO creature VALUES (247104, 1853, 289, 1, 1, 0, 1, 180.7712, -5.428603, 75.57024, 1.291544, 86400, 10, 0, 50300, 7458, 1, 0, 0, 0);
DELETE FROM creature_text WHERE entry=1853;
INSERT INTO creature_text VALUES (1853, 0, 0, 'School is in session!', 14, 0, 100, 0, 0, 0, 3, 'Darkmaster Gandling - Say on summon');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1853;
DELETE FROM smart_scripts WHERE entryorguid=1853 AND source_type=0;
INSERT INTO smart_scripts VALUES (1853, 0, 0, 0, 0, 0, 100, 0, 4000, 11000, 8000, 14000, 11, 15790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - In Combat - Cast Arcane Missiles');
INSERT INTO smart_scripts VALUES (1853, 0, 1, 0, 0, 0, 100, 0, 10000, 18000, 20000, 30000, 11, 18702, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - In Combat - Cast Curse of the Darkmaster');
INSERT INTO smart_scripts VALUES (1853, 0, 2, 0, 0, 0, 100, 0, 8000, 15000, 30000, 40000, 11, 12040, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (1853, 0, 3, 0, 0, 0, 100, 0, 15000, 15000, 25000, 25000, 11, 17950, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - In Combat - Cast Shadow Portal');
INSERT INTO smart_scripts VALUES (1853, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 177374, 200, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Aggro - Set Gameobject State');
INSERT INTO smart_scripts VALUES (1853, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 177374, 200, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Reset - Set Gameobject State');
INSERT INTO smart_scripts VALUES (1853, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 177374, 200, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Death - Set Gameobject State');
INSERT INTO smart_scripts VALUES (1853, 0, 8, 9, 25, 0, 100, 257, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Reset - Set Invisible');
INSERT INTO smart_scripts VALUES (1853, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Reset - Set Faction');
INSERT INTO smart_scripts VALUES (1853, 0, 10, 11, 60, 0, 100, 257, 5000, 5000, 5000, 5000, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Update - Set Visible');
INSERT INTO smart_scripts VALUES (1853, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (1853, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkmaster Gandling - On Update - Set Faction');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=1853;
INSERT INTO conditions VALUES(22, 11, 1853, 0, 0, 13, 1, 1, 6, 0, 0, 0, 0, '', 'Run action if GetData(1) == 6');

-- Risen Guardian (11598)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=11598;
DELETE FROM smart_scripts WHERE entryorguid=11598 AND source_type=0;
INSERT INTO smart_scripts VALUES (11598, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Reset - Disable Event Phase Reset');
INSERT INTO smart_scripts VALUES (11598, 0, 1, 0, 38, 0, 100, 257, 0, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 2, 0, 38, 0, 100, 257, 0, 2, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 3, 0, 38, 0, 100, 257, 0, 3, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 4, 0, 38, 0, 100, 257, 0, 4, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 5, 0, 38, 0, 100, 257, 0, 5, 0, 0, 22, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 6, 0, 38, 0, 100, 257, 0, 6, 0, 0, 22, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 7, 0, 38, 0, 100, 257, 0, 6, 0, 0, 22, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (11598, 0, 8, 0, 0, 0, 100, 0, 1000, 7000, 8000, 15000, 11, 16583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (11598, 0, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 4974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Guardian - In Combat - Cast Wither Touch');
INSERT INTO smart_scripts VALUES (11598, 0, 10, 0, 6, 1, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177376, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 11, 0, 6, 2, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177377, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 12, 0, 6, 4, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177375, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 13, 0, 6, 8, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177371, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 14, 0, 6, 16, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177373, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 15, 0, 6, 32, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177372, 100, 0, 0, 0, 0, 0, 'Risen Guardian - On Death - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 16, 0, 1, 1, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177376, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 17, 0, 1, 2, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177377, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 18, 0, 1, 4, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177375, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 19, 0, 1, 8, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177371, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 20, 0, 1, 16, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177373, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');
INSERT INTO smart_scripts VALUES (11598, 0, 21, 0, 1, 32, 100, 1, 115000, 115000, 0, 0, 63, 1, 1, 0, 0, 0, 0, 20, 177372, 100, 0, 0, 0, 0, 0, 'Risen Guardian - Out of Combat - Set Counter');

-- GO Gate (177372)
-- GO Gate (177377)
-- GO Gate (177375)
-- GO Gate (177371)
-- GO Gate (177373)
-- GO Gate (177376)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(177372, 177377, 177375, 177371, 177373, 177376);
DELETE FROM smart_scripts WHERE entryorguid IN(177372, 177377, 177375, 177371, 177373, 177376) AND source_type=1;
INSERT INTO smart_scripts VALUES (177372, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177372, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');
INSERT INTO smart_scripts VALUES (177377, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177377, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');
INSERT INTO smart_scripts VALUES (177375, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177375, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');
INSERT INTO smart_scripts VALUES (177371, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177371, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');
INSERT INTO smart_scripts VALUES (177373, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177373, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');
INSERT INTO smart_scripts VALUES (177376, 1, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Data Set - Reset Counter');
INSERT INTO smart_scripts VALUES (177376, 1, 1, 0, 77, 0, 100, 0, 1, 3, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gate - On Counter Set - Set gameobject State');

-- SPELL Shadow Portal (12021)
DELETE FROM spell_script_names WHERE spell_id IN(17950);
INSERT INTO spell_script_names VALUES(17950, 'spell_scholomance_shadow_portal');

-- SPELL Shadow Portal (17863), Hall of Secrets
DELETE FROM spell_script_names WHERE spell_id IN(17863);
INSERT INTO spell_script_names VALUES(17863, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17863;
INSERT INTO spell_target_position VALUES (17863, 0, 289, 274.877, 1.33366, 85.3117, 3.22886);

-- SPELL Shadow Portal (17939). Hall of the Damned
DELETE FROM spell_script_names WHERE spell_id IN(17939);
INSERT INTO spell_script_names VALUES(17939, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17939;
INSERT INTO spell_target_position VALUES (17939, 0, 289, 182.423, -95.8264, 85.2284, 1.58984);

-- SPELL Shadow Portal (17943). The Coven
DELETE FROM spell_script_names WHERE spell_id IN(17943);
INSERT INTO spell_script_names VALUES(17943, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17943;
INSERT INTO spell_target_position VALUES (17943, 0, 289, 83.2952, -1.70237, 85.2284, 0.0174533);

-- SPELL Shadow Portal (17944). The Shadow Vault
DELETE FROM spell_script_names WHERE spell_id IN(17944);
INSERT INTO spell_script_names VALUES(17944, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17944;
INSERT INTO spell_target_position VALUES (17944, 0, 289, 266.774, 0.886003, 75.2501, 3.07178);

-- SPELL Shadow Portal (17946). Barov Family Vault
DELETE FROM spell_script_names WHERE spell_id IN(17946);
INSERT INTO spell_script_names VALUES(17946, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17946;
INSERT INTO spell_target_position VALUES (17946, 0, 289, 179.141, -91.118, 71.5433, 1.64061);

-- SPELL Shadow Portal (17948). Vault of the Ravenian
DELETE FROM spell_script_names WHERE spell_id IN(17948);
INSERT INTO spell_script_names VALUES(17948, 'spell_scholomance_shadow_portal_rooms');
DELETE FROM spell_target_position WHERE id=17948;
INSERT INTO spell_target_position VALUES (17948, 0, 289, 103.305, -1.67752, 75.2183, 6.17846);


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- GO Brazier of the Herald (175564)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=175564;
DELETE FROM smart_scripts WHERE entryorguid=175564 AND source_type=1;
INSERT INTO smart_scripts VALUES (175564, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 12, 10506, 8, 0, 0, 0, 0, 8, 0, 0, 0, 315.028, 70.53845, 102.1496, 0.3859715, 'Brazier of the Herald - On Gossip Hello - Summon Creature');
INSERT INTO smart_scripts VALUES (175564, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 4, 557, 0, 0, 0, 0, 0, 18, 60, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Play Sound');
INSERT INTO smart_scripts VALUES (175564, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 34, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Instance Data');
INSERT INTO smart_scripts VALUES (175564, 1, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (175564, 1, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (175564, 1, 5, 6, 60, 0, 100, 0, 1000, 1000, 5000, 5000, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (175564, 1, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (175564, 1, 7, 8, 60, 0, 100, 0, 1000, 1000, 5000, 5000, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (175564, 1, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brazier of the Herald - On Gossip Hello - Set Gameobject Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=175564;
INSERT INTO conditions VALUES(22, 6, 175564, 1, 0, 13, 1, 0, 0, 0, 0, 0, 0, '', 'Run action if GetData(0) == 0');
INSERT INTO conditions VALUES(22, 8, 175564, 1, 1, 13, 1, 0, 0, 0, 1, 0, 0, '', 'Run action if GetData(0) != 0');

-- GO Journal of Jandice Barov (180794)
UPDATE npc_text SET text0_0='', text0_1='The journal of Jandice Barov is filled with rantings and ravings about the undead. Towards the end of the book is what appears to be a tailoring pattern for the creation of a bag of some sort. Your understanding of tailoring is insufficient to decipher the pattern.' WHERE ID=8120;
UPDATE npc_text SET text0_0='', text0_1='The journal of Jandice Barov is filled with rantings and ravings about the undead. Towards the end of the book is what appears to be a tailoring pattern for the creation of a felcloth bag. This bag is used by warlocks to store soul shards. Do you wish to copy the pattern into your own journal?' WHERE ID=8121;
UPDATE npc_text SET text0_0='', text0_1='The journal of Jandice Barov is filled with rantings and ravings about the undead. Towards the end of the book is what appears to be a tailoring pattern for the creation of a felcloth bag. This bag is used by warlocks to store soul shards. You already know how to create this bag.' WHERE ID=8122;
DELETE FROM gossip_menu WHERE entry=6799;
INSERT INTO gossip_menu VALUES (6799, 8120),(6799, 8121),(6799, 8122);
DELETE FROM gossip_menu_option WHERE menu_id=6799;
INSERT INTO gossip_menu_option VALUES (6799, 0, 0, '<Copy the pattern into my journal.>', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(14, 15) AND SourceGroup=6799;
INSERT INTO conditions VALUES(14, 6799, 8120, 0, 0, 7, 0, 197, 280, 0, 1, 0, 0, '', 'Show text if player does not have tailoring');
INSERT INTO conditions VALUES(14, 6799, 8121, 0, 0, 7, 0, 197, 280, 0, 0, 0, 0, '', 'Show text if player have tailoring');
INSERT INTO conditions VALUES(14, 6799, 8121, 0, 0, 25, 0, 26086, 0, 0, 1, 0, 0, '', 'Show text if player does not have spell 26086');
INSERT INTO conditions VALUES(14, 6799, 8122, 0, 0, 7, 0, 197, 280, 0, 0, 0, 0, '', 'Show text if player have tailoring');
INSERT INTO conditions VALUES(14, 6799, 8122, 0, 0, 25, 0, 26086, 0, 0, 0, 0, 0, '', 'Show text if player have spell 26086');
INSERT INTO conditions VALUES(15, 6799, 0, 0, 0, 7, 0, 197, 280, 0, 0, 0, 0, '', 'Show gossip if player have tailoring');
INSERT INTO conditions VALUES(15, 6799, 0, 0, 0, 25, 0, 26086, 0, 0, 1, 0, 0, '', 'Show gossip if player does not have spell 26086');
DELETE FROM gameobject WHERE id=180794;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=180794;
DELETE FROM smart_scripts WHERE entryorguid=180794 AND source_type=1;
INSERT INTO smart_scripts VALUES (180794, 1, 0, 1, 62, 0, 100, 0, 6799, 0, 0, 0, 85, 26095, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Journal of Jandice Barov - On Gossip Select - Invoker Cast Felcloth Bag');
INSERT INTO smart_scripts VALUES (180794, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Journal of Jandice Barov - On Gossip Select - Close Gossip');

-- GO Torch (177385)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=177385;
DELETE FROM smart_scripts WHERE entryorguid=177385 AND source_type=1;
INSERT INTO smart_scripts VALUES (177385, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 20, 175610, 200, 0, 0, 0, 0, 0, 'Torch - On Gossip Hello - Set Gameobject State');
INSERT INTO smart_scripts VALUES (177385, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 20, 176944, 200, 0, 0, 0, 0, 0, 'Torch - On Gossip Hello - Remove Gameobject Flag');

-- GO Divination Scryer (179708)
DELETE FROM event_scripts WHERE id=8436;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=179708;
DELETE FROM smart_scripts WHERE entryorguid=179708 AND source_type=1;
INSERT INTO smart_scripts VALUES (179708, 1, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Divination Scryer - On Update - Set Active');
INSERT INTO smart_scripts VALUES (179708, 1, 1, 0, 60, 0, 100, 1, 5000, 5000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 2, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 3, 0, 60, 0, 100, 1, 7000, 7000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 118.49, 179.70, 92.6, 6.1, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 4, 0, 60, 0, 100, 1, 8000, 8000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 5, 0, 60, 0, 100, 1, 9000, 9000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.32, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 6, 0, 60, 0, 100, 1, 40000, 40000, 0, 0, 12, 14518, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 144.35, 159.2, 93.07, 2.36, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 7, 0, 60, 0, 100, 1, 40000, 40000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 118.49, 179.70, 92.6, 6.1, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 8, 0, 60, 0, 100, 1, 40000, 40000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 9, 0, 60, 0, 100, 1, 40000, 40000, 0, 0, 12, 14514, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.32, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 10, 0, 60, 0, 100, 1, 80000, 80000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 11, 0, 60, 0, 100, 1, 81000, 81000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 12, 0, 60, 0, 100, 1, 82000, 82000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 160.89, 176.12, 93.09, 3.14, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 13, 0, 60, 0, 100, 1, 83000, 83000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 14, 0, 60, 0, 100, 1, 84000, 84000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.3, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 15, 0, 60, 0, 100, 1, 120000, 120000, 0, 0, 12, 14520, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 160.89, 176.12, 93.09, 3.14, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 16, 0, 60, 0, 100, 1, 120000, 120000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 118.49, 179.70, 92.6, 6.1, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 17, 0, 60, 0, 100, 1, 120000, 120000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 18, 0, 60, 0, 100, 1, 120000, 120000, 0, 0, 12, 14513, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 19, 0, 60, 0, 100, 1, 160000, 160000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 20, 0, 60, 0, 100, 1, 161000, 161000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 21, 0, 60, 0, 100, 1, 162000, 162000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.3, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 22, 0, 60, 0, 100, 1, 163000, 163000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 23, 0, 60, 0, 100, 1, 164000, 164000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 160.89, 176.12, 93.09, 3.14, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 24, 0, 60, 0, 100, 1, 210000, 210000, 0, 0, 12, 14519, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 25, 0, 60, 0, 100, 1, 210000, 210000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.3, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 26, 0, 60, 0, 100, 1, 210000, 210000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 27, 0, 60, 0, 100, 1, 210000, 210000, 0, 0, 12, 14512, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 160.89, 176.12, 93.09, 3.14, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 28, 0, 60, 0, 100, 1, 250000, 250000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 110.35, 170.97, 92.05, 0.3, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 29, 0, 60, 0, 100, 1, 251000, 251000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 160.89, 176.12, 93.09, 3.14, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 30, 0, 60, 0, 100, 1, 252000, 252000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 31, 0, 60, 0, 100, 1, 253000, 253000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 32, 0, 60, 0, 100, 1, 254000, 254000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 118.49, 179.70, 92.6, 6.1, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 33, 0, 60, 0, 100, 1, 300000, 300000, 0, 0, 12, 14521, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 34, 0, 60, 0, 100, 1, 300000, 300000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 150.32, 172.59, 93.7, 3.12, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 35, 0, 60, 0, 100, 1, 300000, 300000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 132.81, 192.16, 93.52, 5.08, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 36, 0, 60, 0, 100, 1, 300000, 300000, 0, 0, 12, 14511, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 118.49, 179.70, 92.6, 6.1, 'Divination Scryer - On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (179708, 1, 37, 0, 60, 0, 100, 1, 340000, 340000, 0, 0, 12, 14516, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 145.4, 184.14, 94.31, 4.19, 'Divination Scryer - On Update - Summon Creature');

-- Banal Spirit (14514)
DELETE FROM creature_text WHERE entry=14514;
INSERT INTO creature_text VALUES (14514, 0, 0, '%s recoils in pain as the Judgement of Wisdom washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Banal Spirit');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14514;
DELETE FROM smart_scripts WHERE entryorguid=14514 AND source_type=0;
INSERT INTO smart_scripts VALUES (14514, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 15000, 25000, 11, 8140, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Banal Spirit - In Combat - Cast Befuddlement');
INSERT INTO smart_scripts VALUES (14514, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 23262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Banal Spirit - In Combat - Cast Demoralize');
INSERT INTO smart_scripts VALUES (14514, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Banal Spirit - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14514, 0, 3, 0, 8, 0, 100, 0, 53408, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Banal Spirit - On Spell Hit - Say Line 0');

-- Aspect of Banality (14518)
DELETE FROM creature_text WHERE entry=14518;
INSERT INTO creature_text VALUES (14518, 0, 0, '%s recoils in pain as the Judgement of Wisdom washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Banality');
INSERT INTO creature_text VALUES (14518, 1, 0, '%s emerges from the darkness, drawn out by the divination scryer!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Banality');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14518;
DELETE FROM smart_scripts WHERE entryorguid=14518 AND source_type=0;
INSERT INTO smart_scripts VALUES (14518, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 15000, 25000, 11, 8140, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Aspect of Banality - In Combat - Cast Befuddlement');
INSERT INTO smart_scripts VALUES (14518, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 23262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Banality - In Combat - Cast Demoralize');
INSERT INTO smart_scripts VALUES (14518, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Aspect of Banality - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14518, 0, 3, 0, 8, 0, 100, 0, 53408, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Banality - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (14518, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Banality - On Reset - Say Line 1');

-- Malicious Spirit (14513)
DELETE FROM creature_text WHERE entry=14513;
INSERT INTO creature_text VALUES (14513, 0, 0, '%s recoils in pain as the Judgement of Justice washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Malicious Spirit');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14513;
DELETE FROM smart_scripts WHERE entryorguid=14513 AND source_type=0;
INSERT INTO smart_scripts VALUES (14513, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12867, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malicious Spirit - On Reset - Cast Deep Wounds');
INSERT INTO smart_scripts VALUES (14513, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Malicious Spirit - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (14513, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Malicious Spirit - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14513, 0, 3, 0, 8, 0, 100, 0, 53407, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Malicious Spirit - On Spell Hit - Say Line 0');

-- Aspect of Malice (14520)
DELETE FROM creature_text WHERE entry=14520;
INSERT INTO creature_text VALUES (14520, 0, 0, '%s recoils in pain as the Judgement of Justice washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Malice');
INSERT INTO creature_text VALUES (14520, 1, 0, '%s emerges from the darkness, drawn out by the divination scryer!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Malice');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14520;
DELETE FROM smart_scripts WHERE entryorguid=14520 AND source_type=0;
INSERT INTO smart_scripts VALUES (14520, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 12867, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Malice - On Reset - Cast Deep Wounds');
INSERT INTO smart_scripts VALUES (14520, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 17504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Malice - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (14520, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Aspect of Malice - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14520, 0, 3, 0, 8, 0, 100, 0, 53407, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Malice - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (14520, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Malice - On Reset - Say Line 1');

-- Corrupted Spirit (14512)
DELETE FROM creature_text WHERE entry=14512;
INSERT INTO creature_text VALUES (14512, 0, 0, '%s recoils in pain as the Judgement of Righteousness washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Corrupted Spirit');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14512;
DELETE FROM smart_scripts WHERE entryorguid=14512 AND source_type=0;
INSERT INTO smart_scripts VALUES (14512, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 6822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Spirit - On Reset - Cast Corrupted Stamina');
INSERT INTO smart_scripts VALUES (14512, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 18376, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Corrupted Spirit - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (14512, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Corrupted Spirit - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14512, 0, 3, 0, 8, 0, 100, 0, 20187, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Spirit - On Spell Hit - Say Line 0');

-- Aspect of Corruption (14519)
DELETE FROM creature_text WHERE entry=14519;
INSERT INTO creature_text VALUES (14519, 0, 0, '%s recoils in pain as the Judgement of Righteousness washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Corruption');
INSERT INTO creature_text VALUES (14519, 1, 0, '%s emerges from the darkness, drawn out by the divination scryer!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Corruption');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14519;
DELETE FROM smart_scripts WHERE entryorguid=14519 AND source_type=0;
INSERT INTO smart_scripts VALUES (14519, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 23245, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Corruption - On Reset - Cast Corrupted Stamina');
INSERT INTO smart_scripts VALUES (14519, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 14000, 22000, 11, 23268, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Aspect of Corruption - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (14519, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Aspect of Corruption - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14519, 0, 3, 0, 8, 0, 100, 0, 20187, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Corruption - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (14519, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Corruption - On Reset - Say Line 1');

-- Shadowed Spirit (14511) 
DELETE FROM creature_text WHERE entry=14511;
INSERT INTO creature_text VALUES (14511, 0, 0, '%s recoils in pain as the Judgement of Light washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Shadowed Shadowed');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14511;
DELETE FROM smart_scripts WHERE entryorguid=14511 AND source_type=0;
INSERT INTO smart_scripts VALUES (14511, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowed Spirit - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (14511, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 12000, 11, 22575, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowed Spirit - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (14511, 0, 2, 0, 0, 0, 100, 0, 5000, 15000, 30000, 30000, 11, 22417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowed Spirit - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (14511, 0, 3, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Shadowed Spirit - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14511, 0, 4, 0, 8, 0, 100, 0, 20271, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowed Spirit - On Spell Hit - Say Line 0');

-- Aspect of Shadow (14521)
DELETE FROM creature_text WHERE entry=14521;
INSERT INTO creature_text VALUES (14521, 0, 0, '%s recoils in pain as the Judgement of Light washes over it!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Shadow');
INSERT INTO creature_text VALUES (14521, 1, 0, '%s emerges from the darkness, drawn out by the divination scryer!', 16, 0, 100, 0, 0, 0, 0, 'Aspect of Shadow');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14521;
DELETE FROM smart_scripts WHERE entryorguid=14521 AND source_type=0;
INSERT INTO smart_scripts VALUES (14521, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4500, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (14521, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 8000, 12000, 11, 22575, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - In Combat - Cast Shadow Shock');
INSERT INTO smart_scripts VALUES (14521, 0, 2, 0, 0, 0, 100, 0, 5000, 15000, 30000, 30000, 11, 22417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (14521, 0, 3, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14521, 0, 4, 0, 8, 0, 100, 0, 20271, 0, 15000, 15000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - On Spell Hit - Say Line 0');
INSERT INTO smart_scripts VALUES (14521, 0, 5, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aspect of Shadow - On Reset - Say Line 1');

-- Death Knight Darkreaver (14516)
DELETE FROM creature_text WHERE entry=14516;
INSERT INTO creature_text VALUES (14516, 0, 0, 'ENOUGH - this ends now!  You fools will be added to my bone collection!', 14, 0, 100, 0, 0, 0, 3, 'Death Knight Darkreaver');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=14516;
DELETE FROM smart_scripts WHERE entryorguid=14516 AND source_type=0;
INSERT INTO smart_scripts VALUES (14516, 0, 0, 0, 0, 0, 100, 0, 4000, 10000, 10000, 15000, 11, 22644, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Darkreaver - In Combat - Cast Blood Leech');
INSERT INTO smart_scripts VALUES (14516, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 6000, 10000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Darkreaver - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (14516, 0, 2, 0, 1, 0, 100, 0, 0, 0, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Death Knight Darkreaver - Out of Combat - Attack Start');
INSERT INTO smart_scripts VALUES (14516, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 23261, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Darkreaver - On Death - Summon Darkreaver''s Fallen Charger');
INSERT INTO smart_scripts VALUES (14516, 0, 4, 0, 25, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Darkreaver - On Reset - Say Line 0');

-- GO Dawn's Gambit (176110)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176110;
DELETE FROM smart_scripts WHERE entryorguid=176110 AND source_type=1;
INSERT INTO smart_scripts VALUES (176110, 1, 0, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (176110, 1, 1, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 45, 2, 1, 0, 0, 0, 0, 19, 10433, 100, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Data');
INSERT INTO smart_scripts VALUES (176110, 1, 2, 0, 60, 0, 100, 1, 13000, 13000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 10433, 100, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Data');
INSERT INTO smart_scripts VALUES (176110, 1, 3, 0, 60, 0, 100, 1, 15000, 15000, 0, 0, 45, 2, 3, 0, 0, 0, 0, 11, 10475, 100, 1, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Data');
INSERT INTO smart_scripts VALUES (176110, 1, 4, 0, 60, 0, 100, 1, 16500, 16500, 0, 0, 45, 2, 4, 0, 0, 0, 0, 11, 10475, 100, 1, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Data');
INSERT INTO smart_scripts VALUES (176110, 1, 5, 0, 60, 0, 100, 1, 16500, 16500, 0, 0, 45, 2, 4, 0, 0, 0, 0, 19, 10432, 100, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Set Data');
INSERT INTO smart_scripts VALUES (176110, 1, 6, 0, 60, 0, 100, 1, 20000, 20000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Despawn');

-- GO Dawn's Gambit (177304)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=177304;
DELETE FROM smart_scripts WHERE entryorguid=177304 AND source_type=1;
INSERT INTO smart_scripts VALUES (177304, 1, 1, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dawn''s Gambit - On Update - Despawn');

-- Scholomance Student (10475)
UPDATE creature_template SET flags_extra=0, AIName='SmartAI', ScriptName='' WHERE entry=10475;
DELETE FROM smart_scripts WHERE entryorguid=10475 AND source_type=0;
INSERT INTO smart_scripts VALUES (10475, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 11, 10475, 5, 0, 0, 0, 0, 0, 'Scholomance Student - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (10475, 0, 1, 2, 38, 0, 100, 0, 2, 3, 0, 0, 11, 58854, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Cast Resurrection');
INSERT INTO smart_scripts VALUES (10475, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Set Bytes0 Flag');
INSERT INTO smart_scripts VALUES (10475, 0, 3, 4, 38, 0, 100, 0, 2, 4, 0, 0, 11, 18115, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Cast Viewing Room Student Transform - Effect');
INSERT INTO smart_scripts VALUES (10475, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Set Faction');
INSERT INTO smart_scripts VALUES (10475, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Remove Bytes0 Flag');
INSERT INTO smart_scripts VALUES (10475, 0, 6, 0, 38, 0, 100, 0, 3, 3, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Scholomance Student - On Data Set - Attack Start');

-- Marduk Blackpool (10433)
DELETE FROM creature_text WHERE entry=10433;
INSERT INTO creature_text VALUES (10433, 0, 0, 'Master Vectus, I sense something strange within this container...', 12, 0, 100, 0, 0, 0, 3, 'Marduk Blackpool');
INSERT INTO creature_text VALUES (10433, 1, 0, 'We are betrayed!', 12, 0, 100, 0, 0, 0, 3, 'Marduk Blackpool');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10433;
DELETE FROM smart_scripts WHERE entryorguid=10433 AND source_type=0;
INSERT INTO smart_scripts VALUES (10433, 0, 0, 0, 38, 0, 100, 0, 2, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (10433, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (10433, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17695, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - On Aggro - Cast Defiling Aura');
INSERT INTO smart_scripts VALUES (10433, 0, 3, 0, 0, 0, 100, 0, 3000, 9000, 7000, 12000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10433, 0, 4, 0, 0, 0, 100, 0, 3000, 12000, 11000, 22000, 11, 17228, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (10433, 0, 5, 0, 0, 0, 100, 0, 3000, 11000, 30000, 30000, 11, 12040, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - In Combat - Cast Shadow Shield');
INSERT INTO smart_scripts VALUES (10433, 0, 6, 7, 4, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 11, 10475, 100, 1, 0, 0, 0, 0, 'Marduk Blackpool - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (10433, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 10432, 100, 0, 0, 0, 0, 0, 'Marduk Blackpool - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (10433, 0, 8, 0, 38, 0, 100, 0, 3, 3, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Marduk Blackpool - On Data Set - Attack Start');

-- Vectus (10432)
DELETE FROM creature_text WHERE entry=10432;
INSERT INTO creature_text VALUES (10432, 0, 0, 'Take note of the delicacy of the plagued dragon''s diet. Only terrified flesh will suffice.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 1, 'Tomorrow we will begin training of our promising dragons, so don''t forget your chew toys.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 2, 'When preparing the dragon''s meal, be sure to torture the prisoner in view of the dragon. It responds well to pre-meal entertainment.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 3, 'The Lich King''s forces are building. It is imperative that our timetable supports his plans.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 4, 'Our oldest clutch of dragons are still far from maturity, but with patience and study, we are confident the dragonflight will soon be ready.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 5, 'Now if you turn to page 34 in your text, you see an illustration of a dwarf undergoing dissection...', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 6, 'From yesterday''s field trip, Marduk showed us that the dragons will tolerate the meat of recently killed humanoids, but only if they died slowly and painfully.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 0, 7, 'We await a batch of black dragon eggs from the Burning Steppes. We believe that, through their study, we will advance our knowledge dramatically.', 12, 0, 100, 0, 0, 0, 0, 'Vectus');
INSERT INTO creature_text VALUES (10432, 1, 0, 'What is this?! How dare you!', 14, 0, 100, 0, 0, 0, 3, 'Vectus');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=10432;
DELETE FROM smart_scripts WHERE entryorguid=10432 AND source_type=0;
INSERT INTO smart_scripts VALUES (10432, 0, 0, 0, 38, 0, 100, 0, 2, 4, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vectus - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (10432, 0, 1, 0, 1, 0, 100, 0, 6000, 20000, 30000, 50000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vectus - Out of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (10432, 0, 2, 0, 0, 0, 100, 0, 3000, 9000, 7000, 12000, 11, 18399, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Vectus - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (10432, 0, 3, 0, 0, 0, 100, 0, 3000, 12000, 11000, 22000, 11, 17277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vectus - In Combat - Cast Blast Wave');
INSERT INTO smart_scripts VALUES (10432, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 11, 10475, 100, 1, 0, 0, 0, 0, 'Vectus - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (10432, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 10433, 100, 0, 0, 0, 0, 0, 'Vectus - On Aggro - Set Data');
INSERT INTO smart_scripts VALUES (10432, 0, 6, 0, 38, 0, 100, 0, 3, 3, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Vectus - On Data Set - Attack Start');

-- GO Remains of Eva Sarkhoff (176544)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176544;
DELETE FROM smart_scripts WHERE entryorguid=176544 AND source_type=1;
INSERT INTO smart_scripts VALUES (176544, 1, 1, 0, 64, 0, 100, 0, 1, 0, 0, 0, 50, 178443, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remains of Eva Sarkhoff - On Gossip Hello - Summon Gameobject');

-- GO Remains of Lucien Sarkhoff (176545)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176545;
DELETE FROM smart_scripts WHERE entryorguid=176545 AND source_type=1;
INSERT INTO smart_scripts VALUES (176545, 1, 1, 0, 64, 0, 100, 0, 1, 0, 0, 0, 50, 178443, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remains of Lucien Sarkhoff - On Gossip Hello - Summon Gameobject');

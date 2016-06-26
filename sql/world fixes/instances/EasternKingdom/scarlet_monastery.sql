
UPDATE creature SET spawntimesecs=86400 WHERE map=189 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=189 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------

-- Scarlet Beastmaster with Scarlet Tracking Hound
DELETE FROM creature_addon WHERE guid IN(40070, 40060, 40054, 40079);
DELETE FROM creature_formations WHERE memberGUID IN(40070, 40068, 40059, 40060, 40053, 40054, 40078, 40079);
INSERT INTO creature_formations VALUES (40068, 40068, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (40068, 40070, 2, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (40059, 40059, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (40059, 40060, 2, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (40053, 40053, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (40053, 40054, 2, 90, 2, 0, 0);
INSERT INTO creature_formations VALUES (40078, 40078, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (40078, 40079, 2, 90, 2, 0, 0);
UPDATE creature SET spawndist=3, MovementType=1 WHERE id=4288 AND guid IN(40068, 40059, 40053, 40078);
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=4304 AND guid IN(40070, 40060, 40054, 40079);



-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- -----------------
-- Library Wing
-- -----------------
-- Scarlet Gallant (4287)
DELETE FROM creature_text WHERE entry=4287;
INSERT INTO creature_text VALUES (4287, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Gallant');
INSERT INTO creature_text VALUES (4287, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Gallant');
INSERT INTO creature_text VALUES (4287, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Gallant');
INSERT INTO creature_text VALUES (4287, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Gallant');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4287;
DELETE FROM smart_scripts WHERE entryorguid=4287 AND source_type=0;
INSERT INTO smart_scripts VALUES (4287, 0, 0, 0, 1, 0, 100, 0, 1000, 20000, 20000, 40000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Gallant - Out of Combat - Play Emote');
INSERT INTO smart_scripts VALUES (4287, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Gallant - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4287, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 8000, 14000, 11, 14517, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Gallant - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (4287, 0, 3, 0, 0, 0, 100, 0, 2000, 15000, 18000, 30000, 11, 5589, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Scarlet Gallant - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (4287, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Gallant - Between 0-15% Health - Flee For Assist');

-- Scarlet Adept (4296)
DELETE FROM creature_text WHERE entry=4296;
INSERT INTO creature_text VALUES (4296, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Adept');
INSERT INTO creature_text VALUES (4296, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Adept');
INSERT INTO creature_text VALUES (4296, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Adept');
INSERT INTO creature_text VALUES (4296, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Adept');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4296;
DELETE FROM smart_scripts WHERE entryorguid=4296 AND source_type=0;
INSERT INTO smart_scripts VALUES (4296, 0, 0, 0, 1, 0, 100, 0, 1000, 20000, 20000, 40000, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Adept - Out of Combat - Play Emote');
INSERT INTO smart_scripts VALUES (4296, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Adept - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4296, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 2500, 3500, 11, 9734, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Adept - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (4296, 0, 3, 0, 14, 0, 100, 0, 600, 40, 6000, 6000, 11, 6063, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Adept - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4296, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Adept - Between 0-15% Health - Flee For Assist');

-- Scarlet Beastmaster (4288)
DELETE FROM creature_text WHERE entry=4288;
INSERT INTO creature_text VALUES (4288, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Beastmaster');
INSERT INTO creature_text VALUES (4288, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Beastmaster');
INSERT INTO creature_text VALUES (4288, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Beastmaster');
INSERT INTO creature_text VALUES (4288, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Beastmaster');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4288;
DELETE FROM smart_scripts WHERE entryorguid=4288 AND source_type=0;
INSERT INTO smart_scripts VALUES (4288, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Beastmaster - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4288, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Beastmaster - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (4288, 0, 2, 0, 0, 0, 100, 0, 3000, 9000, 6000, 13000, 11, 7896, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Beastmaster - In Combat - Cast Exploding Shot');
INSERT INTO smart_scripts VALUES (4288, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Beastmaster - Between 0-15% Health - Flee For Assist');

-- Scarlet Tracking Hound (4304)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4304;
DELETE FROM smart_scripts WHERE entryorguid=4304 AND source_type=0;

-- Scarlet Chaplain (4299)
DELETE FROM creature_text WHERE entry=4299;
INSERT INTO creature_text VALUES (4299, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Chaplain');
INSERT INTO creature_text VALUES (4299, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Chaplain');
INSERT INTO creature_text VALUES (4299, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Chaplain');
INSERT INTO creature_text VALUES (4299, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Chaplain');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4299;
DELETE FROM smart_scripts WHERE entryorguid=4299 AND source_type=0;
INSERT INTO smart_scripts VALUES (4299, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1200000, 1200000, 11, 1006, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Out of Combat - Cast Inner Fire');
INSERT INTO smart_scripts VALUES (4299, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4299, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (4299, 0, 3, 0, 16, 1, 100, 0, 6066, 40, 8000, 8000, 11, 6066, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Friendly Missing Buff - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (4299, 0, 4, 0, 14, 0, 100, 0, 400, 40, 8000, 8000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (4299, 0, 5, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - Between 0-15% Health - Flee For Assist');

-- Scarlet Diviner (4291)
DELETE FROM creature_text WHERE entry=4291;
INSERT INTO creature_text VALUES (4291, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Diviner');
INSERT INTO creature_text VALUES (4291, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Diviner');
INSERT INTO creature_text VALUES (4291, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Diviner');
INSERT INTO creature_text VALUES (4291, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Diviner');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4291;
DELETE FROM smart_scripts WHERE entryorguid=4291 AND source_type=0;
INSERT INTO smart_scripts VALUES (4291, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Diviner - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4291, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Diviner - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4291, 0, 2, 0, 0, 0, 100, 0, 3000, 9000, 12000, 18000, 11, 11981, 0, 0, 0, 0, 0, 5, 30, 0, 1, 0, 0, 0, 0, 'Scarlet Diviner - In Combat - Cast Mana Burn');
INSERT INTO smart_scripts VALUES (4291, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Diviner - Between 0-15% Health - Flee For Assist');

-- Scarlet Monk (4540)
DELETE FROM creature_text WHERE entry=4540;
INSERT INTO creature_text VALUES (4540, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Monk');
INSERT INTO creature_text VALUES (4540, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Monk');
INSERT INTO creature_text VALUES (4540, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Monk');
INSERT INTO creature_text VALUES (4540, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Monk');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4540;
DELETE FROM smart_scripts WHERE entryorguid=4540 AND source_type=0;
INSERT INTO smart_scripts VALUES (4540, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Reset - Cast Thrash');
INSERT INTO smart_scripts VALUES (4540, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4540, 0, 2, 0, 13, 0, 100, 0, 7000, 7000, 0, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Victim Casting - Cast Kick');
INSERT INTO smart_scripts VALUES (4540, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Between 0-15% Health - Flee For Assist');

-- -----------------
-- Armory Wing
-- -----------------
-- Scarlet Soldier (4286)
DELETE FROM creature_text WHERE entry=4286;
INSERT INTO creature_text VALUES (4286, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Soldier');
INSERT INTO creature_text VALUES (4286, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Soldier');
INSERT INTO creature_text VALUES (4286, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Soldier');
INSERT INTO creature_text VALUES (4286, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Soldier');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4286;
DELETE FROM smart_scripts WHERE entryorguid=4286 AND source_type=0;
INSERT INTO smart_scripts VALUES (4286, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Soldier - On Reset - Cast Improved Blocking III');
INSERT INTO smart_scripts VALUES (4286, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Soldier - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4286, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Soldier - Between 0-15% Health - Flee For Assist');

-- Scarlet Conjuror (4297)
DELETE FROM creature_text WHERE entry=4297;
INSERT INTO creature_text VALUES (4297, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Conjuror');
INSERT INTO creature_text VALUES (4297, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Conjuror');
INSERT INTO creature_text VALUES (4297, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Conjuror');
INSERT INTO creature_text VALUES (4297, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Conjuror');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4297;
DELETE FROM smart_scripts WHERE entryorguid=4297 AND source_type=0;
INSERT INTO smart_scripts VALUES (4297, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Conjuror - Out of Combat - Cast Summon Fire Elemental');
INSERT INTO smart_scripts VALUES (4297, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Conjuror - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4297, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Conjuror - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4297, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Conjuror - Between 0-15% Health - Flee For Assist');

-- Fire Elemental (575)
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=575);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=575);
DELETE FROM creature WHERE id=575;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=575;
DELETE FROM smart_scripts WHERE entryorguid=575 AND source_type=0;

-- Scarlet Evoker (4289)
DELETE FROM creature_text WHERE entry=4289;
INSERT INTO creature_text VALUES (4289, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Evoker');
INSERT INTO creature_text VALUES (4289, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Evoker');
INSERT INTO creature_text VALUES (4289, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Evoker');
INSERT INTO creature_text VALUES (4289, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Evoker');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4289;
DELETE FROM smart_scripts WHERE entryorguid=4289 AND source_type=0;
INSERT INTO smart_scripts VALUES (4289, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Evoker - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4289, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 30000, 30000, 11, 2601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Evoker - In Combat - Cast Fire Shield III');
INSERT INTO smart_scripts VALUES (4289, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Evoker - In Combat - Cast Fireball');
INSERT INTO smart_scripts VALUES (4289, 0, 3, 0, 0, 0, 100, 0, 4000, 9000, 13000, 18000, 11, 8422, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Scarlet Evoker - In Combat - Cast Flamestrike');
INSERT INTO smart_scripts VALUES (4289, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Evoker - Between 0-15% Health - Flee For Assist');

-- Scarlet Protector (4292)
DELETE FROM creature_text WHERE entry=4292;
INSERT INTO creature_text VALUES (4292, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Protector');
INSERT INTO creature_text VALUES (4292, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Protector');
INSERT INTO creature_text VALUES (4292, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Protector');
INSERT INTO creature_text VALUES (4292, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Protector');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4292;
DELETE FROM smart_scripts WHERE entryorguid=4292 AND source_type=0;
INSERT INTO smart_scripts VALUES (4292, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Protector - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4292, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 120000, 120000, 11, 8258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Protector - In Combat - Cast Devotion Aura');
INSERT INTO smart_scripts VALUES (4292, 0, 2, 0, 14, 0, 100, 0, 400, 40, 5000, 10000, 11, 31713, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Protector - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4292, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Protector - Between 0-15% Health - Flee For Assist');

-- Scarlet Guardsman (4290)
DELETE FROM creature_text WHERE entry=4290;
INSERT INTO creature_text VALUES (4290, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Guardsman');
INSERT INTO creature_text VALUES (4290, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Guardsman');
INSERT INTO creature_text VALUES (4290, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Guardsman');
INSERT INTO creature_text VALUES (4290, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Guardsman');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4290;
DELETE FROM smart_scripts WHERE entryorguid=4290 AND source_type=0;
INSERT INTO smart_scripts VALUES (4290, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Guardsman - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4290, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 180000, 180000, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Guardsman - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4290, 0, 2, 0, 0, 0, 100, 0, 3000, 11000, 11000, 20000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Guardsman - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (4290, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Guardsman - Between 0-15% Health - Flee For Assist');

-- Scarlet Myrmidon (4295)
DELETE FROM creature_text WHERE entry=4295;
INSERT INTO creature_text VALUES (4295, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Myrmidon');
INSERT INTO creature_text VALUES (4295, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Myrmidon');
INSERT INTO creature_text VALUES (4295, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Myrmidon');
INSERT INTO creature_text VALUES (4295, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Myrmidon');
INSERT INTO creature_text VALUES (4295, 1, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Scarlet Myrmidon');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4295;
DELETE FROM smart_scripts WHERE entryorguid=4295 AND source_type=0;
INSERT INTO smart_scripts VALUES (4295, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4295, 0, 1, 2, 2, 0, 100, 1, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Between 0-40% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (4295, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Between 0-40% Health - Say Line 1');

-- Scarlet Defender (4298)
DELETE FROM creature_text WHERE entry=4298;
INSERT INTO creature_text VALUES (4298, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Defender');
INSERT INTO creature_text VALUES (4298, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Defender');
INSERT INTO creature_text VALUES (4298, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Defender');
INSERT INTO creature_text VALUES (4298, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Defender');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4298;
DELETE FROM smart_scripts WHERE entryorguid=4298 AND source_type=0;
INSERT INTO smart_scripts VALUES (4298, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - On Reset - Cast Improved Blocking III');
INSERT INTO smart_scripts VALUES (4298, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4298, 0, 2, 0, 0, 0, 100, 0, 0, 2000, 180000, 180000, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (4298, 0, 3, 0, 13, 0, 100, 0, 8000, 11000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (4298, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - Between 0-15% Health - Flee For Assist');

-- -----------------
-- Cathedral Wing
-- -----------------
-- Scarlet Sorcerer (4294)
DELETE FROM creature_text WHERE entry=4294;
INSERT INTO creature_text VALUES (4294, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Sorcerer');
INSERT INTO creature_text VALUES (4294, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Sorcerer');
INSERT INTO creature_text VALUES (4294, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Sorcerer');
INSERT INTO creature_text VALUES (4294, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Sorcerer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4294;
DELETE FROM smart_scripts WHERE entryorguid=4294 AND source_type=0;
INSERT INTO smart_scripts VALUES (4294, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4294, 0, 1, 0, 0, 0, 100, 0, 4000, 8000, 15000, 25000, 11, 6146, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Slow');
INSERT INTO smart_scripts VALUES (4294, 0, 2, 0, 0, 0, 100, 0, 0, 1000, 3000, 3500, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (4294, 0, 3, 0, 0, 0, 100, 0, 14000, 29000, 19000, 28000, 11, 9672, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - In Combat - Cast Blizzard');
INSERT INTO smart_scripts VALUES (4294, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - Between 0-15% Health - Flee For Assist');

-- Scarlet Centurion (4301)
DELETE FROM creature_text WHERE entry=4301;
INSERT INTO creature_text VALUES (4301, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Centurion');
INSERT INTO creature_text VALUES (4301, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Centurion');
INSERT INTO creature_text VALUES (4301, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Centurion');
INSERT INTO creature_text VALUES (4301, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Centurion');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4301;
DELETE FROM smart_scripts WHERE entryorguid=4301 AND source_type=0;
INSERT INTO smart_scripts VALUES (4301, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4301, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 50000, 70000, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (4301, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - Between 0-15% Health - Flee For Assist');

-- Scarlet Wizard (4300)
DELETE FROM creature_text WHERE entry=4300;
INSERT INTO creature_text VALUES (4300, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Wizard');
INSERT INTO creature_text VALUES (4300, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Wizard');
INSERT INTO creature_text VALUES (4300, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Wizard');
INSERT INTO creature_text VALUES (4300, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Wizard');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4300;
DELETE FROM smart_scripts WHERE entryorguid=4300 AND source_type=0;
INSERT INTO smart_scripts VALUES (4300, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4300, 0, 1, 0, 0, 0, 100, 0, 2000, 6000, 7000, 11000, 11, 8439, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (4300, 0, 2, 0, 0, 0, 100, 0, 1000, 5000, 30000, 30000, 11, 2601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - In Combat - Cast Fire Shield III');
INSERT INTO smart_scripts VALUES (4300, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - Between 0-15% Health - Flee For Assist');

-- Scarlet Abbot (4303)
DELETE FROM creature_text WHERE entry=4303;
INSERT INTO creature_text VALUES (4303, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Abbot');
INSERT INTO creature_text VALUES (4303, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Abbot');
INSERT INTO creature_text VALUES (4303, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Abbot');
INSERT INTO creature_text VALUES (4303, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Abbot');
INSERT INTO creature_text VALUES (4303, 1, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Scarlet Abbot');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4303;
DELETE FROM smart_scripts WHERE entryorguid=4303 AND source_type=0;
INSERT INTO smart_scripts VALUES (4303, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4303, 0, 1, 0, 14, 0, 100, 0, 400, 40, 8000, 8000, 11, 8362, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Friendly Missing Health - Cast Renew');
INSERT INTO smart_scripts VALUES (4303, 0, 2, 0, 14, 0, 100, 0, 600, 40, 4000, 8000, 11, 6064, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Friendly Missing Health - Cast Heal');
INSERT INTO smart_scripts VALUES (4303, 0, 3, 4, 2, 0, 100, 1, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Between 0-40% Health - Cast Frenzy');
INSERT INTO smart_scripts VALUES (4303, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Between 0-40% Health - Say Line 1');

-- Scarlet Champion (4302)
DELETE FROM creature_text WHERE entry=4302;
INSERT INTO creature_text VALUES (4302, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Champion');
INSERT INTO creature_text VALUES (4302, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Champion');
INSERT INTO creature_text VALUES (4302, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Champion');
INSERT INTO creature_text VALUES (4302, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Champion');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4302;
DELETE FROM smart_scripts WHERE entryorguid=4302 AND source_type=0;
INSERT INTO smart_scripts VALUES (4302, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4302, 0, 1, 0, 0, 0, 100, 0, 1000, 5000, 6000, 9000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (4302, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - Between 0-15% Health - Flee For Assist');


-- -----------------
-- Graveyard Wing
-- -----------------
-- Scarlet Torturer (4306)
DELETE FROM creature_text WHERE entry=4306;
INSERT INTO creature_text VALUES (4306, 0, 0, 'You carry the taint of the Scourge. Prepare to enter the Twisting Nether.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 0, 1, 'There is no escape for you. The Crusade shall destroy all who carry the Scourge''s taint.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 0, 2, 'The Light condemns all who harbor evil. Now you will die!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 0, 3, 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 1, 0, 'Confess and we shall set you free.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 1, 1, 'You will talk eventually. You might as well spill it now.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
INSERT INTO creature_text VALUES (4306, 1, 2, 'What? Oh no. I don''t care what you have to say. I just enjoy inflicting pain.', 12, 7, 100, 0, 0, 0, 0, 'Scarlet Torturer');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4306;
DELETE FROM smart_scripts WHERE entryorguid=4306 AND source_type=0;
INSERT INTO smart_scripts VALUES (4306, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 9276, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Torturer - On Reset - Cast Immolate');
INSERT INTO smart_scripts VALUES (4306, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Torturer - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4306, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Torturer - Between 0-15% Health - Flee For Assist');

-- Suffering Victim (6547)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6547;
DELETE FROM smart_scripts WHERE entryorguid=6547 AND source_type=0;
INSERT INTO smart_scripts VALUES (6547, 0, 0, 0, 1, 0, 100, 0, 4000, 30000, 26000, 40000, 1, 1, 0, 0, 0, 0, 0, 19, 4306, 10, 0, 0, 0, 0, 0, 'Suffering Victim - Out of Combat - Say Line 1 Target');
INSERT INTO smart_scripts VALUES (6547, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Suffering Victim - On Aggro - Remove Bytes1');
INSERT INTO smart_scripts VALUES (6547, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Suffering Victim - On Reset - Set React Defensive');

-- Unfettered Spirit (4308)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=4308;
DELETE FROM smart_scripts WHERE entryorguid=4308 AND source_type=0;

-- Haunting Phantasm (6427)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6427;
DELETE FROM smart_scripts WHERE entryorguid=6427 AND source_type=0;
INSERT INTO smart_scripts VALUES (6427, 0, 0, 0, 0, 0, 100, 0, 3000, 9000, 30000, 60000, 11, 8986, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Haunting Phantasm - In Combat - Cast Summon Illusonary Phantasm');

-- Illusionary Phantasm (6493)
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=6493;
DELETE FROM smart_scripts WHERE entryorguid=6493 AND source_type=0;

-- Anguished Dead (6426)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6426;
DELETE FROM smart_scripts WHERE entryorguid=6426 AND source_type=0;
INSERT INTO smart_scripts VALUES (6426, 0, 0, 0, 0, 0, 100, 0, 3000, 9000, 10000, 20000, 11, 7068, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Haunting Phantasm - In Combat - Cast Veil of Shadows');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Houndmaster Loksey (3974)
DELETE FROM creature_text WHERE entry=3974;
INSERT INTO creature_text VALUES (3974, 0, 0, 'Release the hounds!', 14, 7, 100, 0, 0, 5841, 0, 'Houndmaster Loksey');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3974;
DELETE FROM smart_scripts WHERE entryorguid=3974 AND source_type=0;
INSERT INTO smart_scripts VALUES (3974, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Houndmaster Loksey - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3974, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 20000, 11, 6742, 32, 1, 0, 0, 0, 11, 4304, 20, 0, 0, 0, 0, 0, 'Houndmaster Loksey - In Combat - Cast Bloodlust');

-- Arcanist Doan (6487)
DELETE FROM creature_text WHERE entry=6487;
INSERT INTO creature_text VALUES (6487, 0, 0, 'You will not defile these mysteries!', 14, 7, 100, 0, 0, 5842, 0, 'doan SAY_AGGRO');
INSERT INTO creature_text VALUES (6487, 1, 0, 'Burn in righteous fire!', 14, 7, 100, 0, 0, 5843, 0, 'doan SAY_SPECIALAE');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6487;
DELETE FROM smart_scripts WHERE entryorguid=6487 AND source_type=0;
INSERT INTO smart_scripts VALUES (6487, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (6487, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 6000, 10000, 11, 9433, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - In Combat - Cast Arcane Explosion');
INSERT INTO smart_scripts VALUES (6487, 0, 2, 0, 0, 0, 100, 0, 8000, 9000, 15000, 25000, 11, 8988, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - In Combat - Cast Silence');
INSERT INTO smart_scripts VALUES (6487, 0, 3, 0, 0, 0, 100, 0, 3000, 9000, 15000, 25000, 11, 13323, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - In Combat - Cast Polymorph');
INSERT INTO smart_scripts VALUES (6487, 0, 4, 5, 2, 0, 100, 1, 0, 50, 0, 0, 11, 9438, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - Between Health 0-50% - Cast Arcane Bubble');
INSERT INTO smart_scripts VALUES (6487, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 9435, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - Between Health 0-50% - Cast Detonation');
INSERT INTO smart_scripts VALUES (6487, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arcanist Doan - Between Health 0-50% - Say Line 1');

-- Herod <The Scarlet Champion> (3975)
DELETE FROM creature_text WHERE entry=3975;
INSERT INTO creature_text VALUES (3975, 0, 0, 'Ah, I have been waiting for a real challenge!', 14, 7, 100, 0, 0, 5830, 0, 'herod SAY_AGGRO');
INSERT INTO creature_text VALUES (3975, 1, 0, 'Blades of Light!', 14, 7, 100, 0, 0, 5832, 0, 'herod SAY_WHIRLWIND');
INSERT INTO creature_text VALUES (3975, 2, 0, 'Light, give me strength!', 14, 7, 100, 0, 0, 5833, 0, 'herod SAY_ENRAGE');
INSERT INTO creature_text VALUES (3975, 3, 0, 'Hah, is that all?', 14, 7, 100, 0, 0, 5831, 0, 'herod SAY_KILL');
INSERT INTO creature_text VALUES (3975, 4, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 0, 'herod EMOTE_ENRAGE');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3975;
DELETE FROM smart_scripts WHERE entryorguid=3975 AND source_type=0;
INSERT INTO smart_scripts VALUES (3975, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3975, 0, 1, 0, 0, 0, 100, 0, 3000, 7000, 6000, 10000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Herod - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (3975, 0, 2, 3, 0, 0, 100, 0, 15000, 15000, 30000, 40000, 11, 8989, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (3975, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - In Combat - Say Line 1');
INSERT INTO smart_scripts VALUES (3975, 0, 4, 5, 2, 0, 100, 1, 0, 50, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - Between Health 0-40% - Cast Enrage');
INSERT INTO smart_scripts VALUES (3975, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - Between Health 0-40% - Say Line 4');
INSERT INTO smart_scripts VALUES (3975, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - Between Health 0-40% - Say Line 2');
INSERT INTO smart_scripts VALUES (3975, 0, 7, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - On Kill - Say Line 3');
INSERT INTO smart_scripts VALUES (3975, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Herod - On Death - Summon Creature Group');
INSERT INTO smart_scripts VALUES (3975, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 6575, 100, 0, 0, 0, 0, 0, 'Herod - On Death - Say Line 0 Target');
DELETE FROM creature_summon_groups WHERE summonerId=3975;
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1924.62, -431.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1924.62, -430.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1922.62, -426.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1925.62, -424.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1923.62, -422.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1926.62, -420.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1925.62, -418.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1926.62, -431.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1922.62, -431.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1923.62, -430.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1926.62, -433.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1920.62, -428.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1928.62, -427.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1925.62, -430.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1924.62, -433.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1922.62, -435.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1925.62, -437.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1923.62, -440.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1922.62, -435.66, 18.1, 0.0, 4, 60000);
INSERT INTO creature_summon_groups VALUES (3975, 0, 1, 6575, 1926.62, -437.66, 18.1, 0.0, 4, 60000);

-- Scarlet Trainee (6575)
DELETE FROM script_waypoint WHERE entry=6575;
DELETE FROM creature_text WHERE entry=6575;
INSERT INTO creature_text VALUES (6575, 0, 0, 'The master has fallen! Avenge him, my brethren!', 14, 7, 100, 0, 0, 0, 0, 'Scarlet Trainee');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6575;
DELETE FROM smart_scripts WHERE entryorguid=6575 AND source_type=0;
INSERT INTO smart_scripts VALUES (6575, 0, 0, 0, 1, 0, 100, 1, 0, 8000, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Trainee - Out of Combat - Set In Combat With Zone');

-- Scarlet Commander Mograine (3976)
DELETE FROM creature_text WHERE entry=3976;
INSERT INTO creature_text VALUES (3976, 0, 0, 'Infidels! They must be purified!', 14, 7, 100, 0, 0, 5835, 0, 'mograine SAY_MO_AGGRO');
INSERT INTO creature_text VALUES (3976, 1, 0, 'Unworthy!', 14, 7, 100, 0, 0, 5836, 0, 'mograine SAY_MO_KILL');
INSERT INTO creature_text VALUES (3976, 2, 0, 'At your side, milady!', 14, 7, 100, 0, 0, 5837, 0, 'mograine SAY_MO_RESSURECTED');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3976;
DELETE FROM smart_scripts WHERE entryorguid=3976 AND source_type=0;
INSERT INTO smart_scripts VALUES (3976, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3976, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 39, 150, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Call For Help');
INSERT INTO smart_scripts VALUES (3976, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 8990, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Cast Retribution Aura');
INSERT INTO smart_scripts VALUES (3976, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Aggro - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (3976, 0, 4, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (3976, 0, 5, 0, 0, 0, 100, 0, 1000, 5000, 7000, 10000, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (3976, 0, 6, 0, 0, 0, 100, 0, 6000, 11000, 25000, 35000, 11, 5589, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (3976, 0, 7, 8, 2, 0, 100, 1, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Between Health 0-0% - Remove All Auras');
INSERT INTO smart_scripts VALUES (3976, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Between Health 0-0% - Cast Permanent Feign Death');
INSERT INTO smart_scripts VALUES (3976, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 11877, 104600, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Between Health 0-0% - Set GO State');
INSERT INTO smart_scripts VALUES (3976, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 19, 3977, 200, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Between Health 0-0% - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (3976, 0, 11, 0, 25, 0, 100, 0, 0, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 14, 11877, 104600, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reset - Set GO State');
INSERT INTO smart_scripts VALUES (3976, 0, 12, 0, 25, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 19, 3977, 200, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reset - Respawn Target');

-- High Inquisitor Whitemane (3977)
DELETE FROM creature_text WHERE entry=3977;
INSERT INTO creature_text VALUES (3977, 0, 0, 'What, Mograine has fallen? You shall pay for this treachery!', 14, 7, 100, 0, 0, 5838, 0, 'whitemane SAY_WH_INTRO');
INSERT INTO creature_text VALUES (3977, 1, 0, 'The Light has spoken!', 14, 7, 100, 0, 0, 5839, 0, 'whitemane SAY_WH_KILL');
INSERT INTO creature_text VALUES (3977, 2, 0, 'Arise, my champion!', 14, 7, 100, 0, 0, 5840, 0, 'whitemane SAY_WH_RESSURECT');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3977;
DELETE FROM smart_scripts WHERE entryorguid=3977 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3977*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3977, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3977, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Aggro - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (3977, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Aggro - Set Event Phase');
INSERT INTO smart_scripts VALUES (3977, 0, 3, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Kill - Say Line 1');
INSERT INTO smart_scripts VALUES (3977, 0, 4, 0, 0, 1, 100, 0, 1000, 3000, 2500, 4000, 11, 9481, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - In Combat - Cast Holy Smite');
INSERT INTO smart_scripts VALUES (3977, 0, 5, 0, 0, 1, 100, 0, 6000, 6000, 20000, 20000, 11, 22187, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - In Combat - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (3977, 0, 6, 0, 0, 1, 100, 0, 9000, 9000, 10000, 10000, 11, 12039, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - In Combat - Cast Heal');
INSERT INTO smart_scripts VALUES (3977, 0, 7, 8, 2, 0, 100, 1, 0, 50, 0, 0, 11, 9256, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Health Between 0-50% - Cast Deep Sleep');
INSERT INTO smart_scripts VALUES (3977, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 'High Inquisitor Whitemane - Health Between 0-50% - Set Event Phase');
INSERT INTO smart_scripts VALUES (3977, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 'High Inquisitor Whitemane - Health Between 0-50% - Disable Combat Movement');
INSERT INTO smart_scripts VALUES (3977, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 5, 0, 0, 0, 'High Inquisitor Whitemane - Health Between 0-50% - Move Point');
INSERT INTO smart_scripts VALUES (3977, 0, 11, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 3977*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Movement Inform - Start Script');
INSERT INTO smart_scripts VALUES (3977, 0, 12, 0, 25, 0, 100, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - On Reset - Respawn Target');
INSERT INTO smart_scripts VALUES (3977*100, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 9232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Cast Scarlet Resurrection');
INSERT INTO smart_scripts VALUES (3977*100, 9, 1, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Say Line 2');
INSERT INTO smart_scripts VALUES (3977*100, 9, 2, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Remove Aura Permanent Feign Death');
INSERT INTO smart_scripts VALUES (3977*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Say Line 2 Target');
INSERT INTO smart_scripts VALUES (3977*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 9257, 0, 10, 40029, 3976, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Cross Cast Lay on Hands');
INSERT INTO smart_scripts VALUES (3977*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Remove HP Invincibility');
INSERT INTO smart_scripts VALUES (3977*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 10, 40029, 3976, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Remove HP Invincibility');
INSERT INTO smart_scripts VALUES (3977*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Enable Combat Movement');
INSERT INTO smart_scripts VALUES (3977*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (3977*100, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 86, 8990, 0, 10, 40029, 3976, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Script9 - Cross Cast Retribution Aura');

-- SPELL Scarlet Resurrection (9232)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=9232;
INSERT INTO conditions VALUES (13, 3, 9232, 0, 0, 31, 0, 3, 3976, 0, 0, 0, 0, '', 'Target Scarlet Commander Mograine');

-- SPELL Lay on Hands (9257)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=9257;
INSERT INTO conditions VALUES (13, 3, 9257, 0, 0, 31, 0, 3, 3977, 0, 0, 0, 0, '', 'Target High Inquisitor Whitemane');

-- High Inquisitor Fairbanks (4542)
REPLACE INTO creature_template_addon VALUES (4542, 0, 0, 0, 4097, 0, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4542;
DELETE FROM smart_scripts WHERE entryorguid=4542 AND source_type=0;
INSERT INTO smart_scripts VALUES (4542, 0, 0, 0, 0, 0, 100, 0, 7000, 11000, 30000, 40000, 11, 8282, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Curse of Blood');
INSERT INTO smart_scripts VALUES (4542, 0, 1, 0, 0, 0, 100, 0, 6000, 11000, 15000, 20000, 11, 15090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Dispel Magic');
INSERT INTO smart_scripts VALUES (4542, 0, 2, 0, 0, 0, 100, 0, 0, 3000, 20000, 20000, 11, 11647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Power Word: Shield');
INSERT INTO smart_scripts VALUES (4542, 0, 3, 0, 0, 0, 100, 0, 10000, 15000, 20000, 20000, 11, 12039, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Heal');

-- Interrogator Vishas (3983)
DELETE FROM creature_text WHERE entry=3983;
INSERT INTO creature_text VALUES (3983, 0, 0, 'Tell me... tell me everything!', 14, 7, 100, 0, 0, 5847, 0, 'vishas SAY_AGGRO');
INSERT INTO creature_text VALUES (3983, 1, 0, 'Naughty secrets!', 14, 7, 100, 0, 0, 5849, 0, 'vishas SAY_HEALTH1');
INSERT INTO creature_text VALUES (3983, 2, 0, 'I''ll rip the secrets from your flesh!', 14, 7, 100, 0, 0, 5850, 0, 'vishas SAY_HEALTH2');
INSERT INTO creature_text VALUES (3983, 3, 0, 'Purged by pain!', 14, 7, 100, 0, 0, 5848, 0, 'vishas SAY_KILL');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3983;
DELETE FROM smart_scripts WHERE entryorguid=3983 AND source_type=0;
INSERT INTO smart_scripts VALUES (3983, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (3983, 0, 1, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - On Kill - Say Line 3');
INSERT INTO smart_scripts VALUES (3983, 0, 2, 0, 2, 0, 100, 1, 50, 70, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - Between Health 50-70% - Say Line 1');
INSERT INTO smart_scripts VALUES (3983, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - Between Health 0-30% - Say Line 2');
INSERT INTO smart_scripts VALUES (3983, 0, 4, 0, 0, 0, 100, 0, 3000, 7000, 8000, 14000, 11, 2767, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - In Combat - Cast Shadow Word: Pain');
INSERT INTO smart_scripts VALUES (3983, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3981, 100, 0, 0, 0, 0, 0, 'Interrogator Vishas - On Death - Say Line 0 Target');

-- Vorrel Sengutz (3981)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=3981;
DELETE FROM smart_scripts WHERE entryorguid=3981 AND source_type=0;
INSERT INTO smart_scripts VALUES (3981, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vorrel Sengutz - On Aggro - Remove Bytes1');
INSERT INTO smart_scripts VALUES (3981, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vorrel Sengutz - On Reset - Set React Defensive');

-- Fallen Champion (6488)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6488;
DELETE FROM smart_scripts WHERE entryorguid=6488 AND source_type=0;
INSERT INTO smart_scripts VALUES (6488, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fallen Champion - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (6488, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 6000, 14000, 11, 19642, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallen Champion - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (6488, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 6000, 8000, 11, 19644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallen Champion - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (6488, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 30000, 30000, 11, 21949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Fallen Champion - In Combat - Cast Rend');

-- Ironspine (6489)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6489;
DELETE FROM smart_scripts WHERE entryorguid=6489 AND source_type=0;
INSERT INTO smart_scripts VALUES (6489, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (6489, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 30000, 30000, 11, 702, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ironspine - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (6489, 0, 2, 0, 0, 0, 100, 0, 2000, 3000, 25000, 25000, 11, 3815, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ironspine - In Combat - Cast Poison Cloud');

-- Azshir the Sleepless (6490)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6490;
DELETE FROM smart_scripts WHERE entryorguid=6490 AND source_type=0;
INSERT INTO smart_scripts VALUES (6490, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Azshir the Sleepless - On AI Init - Despawn');
INSERT INTO smart_scripts VALUES (6490, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 70000, 70000, 11, 5137, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azshir the Sleepless - In Combat - Cast Call of the Grave');
INSERT INTO smart_scripts VALUES (6490, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 20000, 20000, 11, 7399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Azshir the Sleepless - In Combat - Cast Terrify');
INSERT INTO smart_scripts VALUES (6490, 0, 3, 0, 0, 0, 100, 0, 14000, 14000, 20000, 20000, 11, 9373, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azshir the Sleepless - In Combat - Cast Soul Siphon');

-- Bloodmage Thalnos (4543)
DELETE FROM creature_text WHERE entry=4543;
INSERT INTO creature_text VALUES (4543, 0, 0, 'We hunger for vengeance.', 14, 0, 100, 0, 0, 5844, 0, 'thalnos SAY_AGGRO');
INSERT INTO creature_text VALUES (4543, 1, 0, 'No rest, for the angry dead.', 14, 0, 100, 0, 0, 5846, 0, 'thalnos SAY_HEALTH');
INSERT INTO creature_text VALUES (4543, 2, 0, 'More... More souls.', 14, 0, 100, 0, 0, 5845, 0, 'thalnos SAY_KILL');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=4543;
DELETE FROM smart_scripts WHERE entryorguid=4543 AND source_type=0;
INSERT INTO smart_scripts VALUES (4543, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (4543, 0, 1, 0, 5, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - On Kill - Say Line 2');
INSERT INTO smart_scripts VALUES (4543, 0, 2, 0, 2, 0, 100, 1, 0, 40, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Interrogator Vishas - Between Health 0-40% - Say Line 1');
INSERT INTO smart_scripts VALUES (4543, 0, 3, 0, 0, 0, 100, 0, 0, 1100, 3000, 4000, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodmage Thalnos - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (4543, 0, 4, 0, 0, 0, 100, 0, 7000, 7000, 20000, 20000, 11, 8814, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Bloodmage Thalnos - In Combat - Cast Flame Spike');
INSERT INTO smart_scripts VALUES (4543, 0, 5, 0, 0, 0, 100, 0, 3000, 6000, 20000, 20000, 11, 8053, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Bloodmage Thalnos - In Combat - Cast Flame Shock');
INSERT INTO smart_scripts VALUES (4543, 0, 6, 0, 0, 0, 100, 0, 12000, 12000, 20000, 20000, 11, 12470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodmage Thalnos - In Combat - Cast Fire Nova');
INSERT INTO smart_scripts VALUES (4543, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 12, 14693, 8, 0, 0, 0, 0, 8, 0, 0, 0, 1797.53, 1233.85, 18.26, 1.57, 'Interrogator Vishas - On Death - Summon Creature');

-- Scorn (14693)
UPDATE creature_template SET minlevel=34, maxlevel=34, AIName='SmartAI', ScriptName='' WHERE entry=14693;
DELETE FROM smart_scripts WHERE entryorguid=14693 AND source_type=0;
INSERT INTO smart_scripts VALUES (14693, 0, 0, 0, 0, 0, 100, 0, 14000, 14000, 20000, 20000, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scorn - In Combat - Cast Frost Nova');
INSERT INTO smart_scripts VALUES (14693, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 20000, 20000, 11, 8398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scorn - In Combat - Cast Frostbolt Volley');
INSERT INTO smart_scripts VALUES (14693, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 20000, 20000, 11, 17313, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Scorn - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (14693, 0, 3, 0, 0, 0, 100, 0, 10000, 12000, 20000, 20000, 11, 28873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scorn - In Combat - Cast Lich Slap');



-- -------------------------------------------
--                MISC
-- -------------------------------------------


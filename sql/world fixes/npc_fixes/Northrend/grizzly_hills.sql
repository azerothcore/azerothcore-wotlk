
-- Seething Hate (32429)
UPDATE creature_template SET mindmg=304, maxdmg=436, attackpower=600 WHERE entry=32429;

-- Grocklar (32422)
UPDATE creature_template SET mindmg=304, maxdmg=436, attackpower=600 WHERE entry=32422;

-- Mother of Bambina (27460)
-- Bambina (27461)
UPDATE creature SET spawntimesecs=60, spawndist=0, MovementType=0 WHERE id IN(27458, 27459, 27460);
DELETE FROM creature WHERE guid=102309 AND id=27460; -- double spawn
DELETE FROM creature WHERE guid=102416 AND id=27462; -- Hunter
DELETE FROM creature_addon WHERE guid=102416;
UPDATE creature SET spawntimesecs=60, spawndist=0, MovementType=2, position_x=4455.396, position_y=-4146.787, position_z=170.427 WHERE id=27461 AND guid=102362; -- Bambina
REPLACE INTO creature_addon  VALUES (102362, 102362*10, 0, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (27462, 0, 0, 0, 4098, 0, '');
DELETE FROM waypoint_data WHERE id=102362*10;
INSERT INTO waypoint_data VALUES (102362*10, 1, 4455.396, -4146.787, 170.427, 0, 0, 0, 0, 100, 0),(102362*10, 2, 4430.5, -4100.761, 172.1093, 0, 0, 0, 0, 100, 0),(102362*10, 3, 4447.854, -4073.468, 173.5189, 0, 0, 0, 0, 100, 0),(102362*10, 4, 4468.999, -4041.916, 177.6545, 0, 0, 0, 0, 100, 0),(102362*10, 5, 4478.685, -4042.196, 177.2023, 0, 0, 0, 0, 100, 0),(102362*10, 6, 4501.111, -4051.88, 176.3756, 0, 0, 0, 0, 100, 0),(102362*10, 7, 4521.756, -4071.147, 175.8675, 0, 0, 0, 0, 100, 0),(102362*10, 8, 4533.449, -4084.051, 176.1545, 0, 0, 0, 0, 100, 0),
(102362*10, 9, 4529.71, -4107.131, 175.0442, 0, 0, 0, 0, 100, 0),(102362*10, 10, 4512, -4124.096, 172.9511, 0, 0, 0, 0, 100, 0),(102362*10, 11, 4496.324, -4129.396, 173.688, 0, 0, 0, 0, 100, 0),(102362*10, 12, 4480.502, -4143.211, 170.3232, 0, 0, 0, 0, 100, 0);
DELETE FROM creature_formations WHERE memberGUID IN(102362, 102311, 102218, 102105);
INSERT INTO creature_formations VALUES (102362, 102362, 0, 0, 2, 0, 0);
INSERT INTO creature_formations VALUES (102362, 102311, 2, 180, 2, 0, 0);
INSERT INTO creature_formations VALUES (102362, 102218, 2.5, 40, 2, 0, 0);
INSERT INTO creature_formations VALUES (102362, 102105, 2.5, 320, 2, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=27460;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=27461;
DELETE FROM smart_scripts WHERE entryorguid=27460 AND source_type=0;
INSERT INTO smart_scripts VALUES (27460, 0, 0, 1, 6, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mother of Bambina - On Death - Store Target');
INSERT INTO smart_scripts VALUES (27460, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 27461, 20, 0, 0, 0, 0, 0, 'Mother of Bambina - On Death - Send Target to Target');
INSERT INTO smart_scripts VALUES (27460, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 27461, 20, 0, 0, 0, 0, 0, 'Mother of Bambina - On Death - Set Data');
DELETE FROM smart_scripts WHERE entryorguid=27461 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(27461*100, 27461*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (27461, 0, 0, 0, 34, 0, 30, 0, 2, 11, 0, 0, 80, 27461*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Movement Inform - Start Script');
INSERT INTO smart_scripts VALUES (27461, 0, 1, 2, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Just Summoned - Store Target');
INSERT INTO smart_scripts VALUES (27461, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Just Summoned - Set React Passive');
INSERT INTO smart_scripts VALUES (27461, 0, 3, 0, 38, 0, 100, 0, 1, 0, 0, 0, 80, 27461*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Data Set - Start Script');
INSERT INTO smart_scripts VALUES (27461*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 27462, 3, 30000, 0, 0, 0, 8, 0, 0, 0, 4473.17, -4131.57, 172.5, 4.70, 'Bambina - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (27461*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Bambina - Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (27461*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 86, 48854, 2, 12, 1, 0, 0, 19, 27460, 30, 0, 0, 0, 0, 0, 'Bambina - Script9 - Cross Cast');
INSERT INTO smart_scripts VALUES (27461*100+1, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Script9 - Talk');
INSERT INTO smart_scripts VALUES (27461*100+1, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 48869, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bambina - Script9 - Cast Bambina''s Vengeance');
INSERT INTO smart_scripts VALUES (27461*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Bambina - Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (27461*100+1, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 51, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Bambina - Script9 - Kill Unit');
DELETE FROM creature_text WHERE entry IN(27461, 27462);
INSERT INTO creature_text VALUES(27461, 0, 0, "NOOOOO! Mother! We'll avenge you!", 12, 0, 100, 0, 0, 0, 0, "Bambina");
INSERT INTO creature_text VALUES(27462, 0, 0, "A skunk, rabbit, and a fawn travelling together. Now thats something you don't see every day. No matter, i'll be dining on venison tonight!", 12, 0, 100, 0, 0, 0, 0, "Westfall Brigade Hunter");

-- Charged Sentry Totem (28938)
UPDATE creature_template SET unit_flags=4, AIName='SmartAI', ScriptName='' WHERE entry=28938;
DELETE FROM smart_scripts WHERE entryorguid=28938 AND source_type=0;
INSERT INTO smart_scripts VALUES (28938, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Charged Sentry Totem - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (28938, 0, 1, 0, 60, 0, 100, 0, 2000, 2000, 3000, 3000, 11, 52705, 0, 1, 0, 0, 0, 18, 30, 0, 0, 0, 0, 0, 0, 'Charged Sentry Totem - On Update - Cast Sentry Shock');

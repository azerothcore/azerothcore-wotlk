
UPDATE creature SET spawntimesecs=86400 WHERE map=34 AND spawntimesecs>0;
UPDATE gameobject SET spawntimesecs=86400 WHERE map=34 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Defias Inmate (1708)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1708;
DELETE FROM smart_scripts WHERE entryorguid=1708 AND source_type=0;
INSERT INTO smart_scripts VALUES (1708, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Inmate - Out of Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (1708, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 15000, 20000, 11, 6547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Inmate - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (1708, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Inmate - Between 0-15% Health - Flee For Assist');

-- Defias Captive (1707)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1707;
DELETE FROM smart_scripts WHERE entryorguid=1707 AND source_type=0;
INSERT INTO smart_scripts VALUES (1707, 0, 0, 0, 67, 0, 100, 0, 7000, 7000, 0, 0, 11, 7159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Behind Target - Cast Backstab');
INSERT INTO smart_scripts VALUES (1707, 0, 1, 0, 0, 0, 100, 0, 5000, 15000, 10000, 10000, 11, 3427, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - In Combat - Cast Infected Wound');
INSERT INTO smart_scripts VALUES (1707, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Between 0-15% Health - Flee For Assist');

-- Defias Convict (1711)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1711;
DELETE FROM smart_scripts WHERE entryorguid=1711 AND source_type=0;
INSERT INTO smart_scripts VALUES (1711, 0, 0, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Convict - Out of Combat - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (1711, 0, 1, 0, 0, 0, 100, 0, 2000, 7000, 10000, 14000, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Convict - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (1711, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Convict - Between 0-15% Health - Flee For Assist');

-- Defias Insurgent (1715)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1715;
DELETE FROM smart_scripts WHERE entryorguid=1715 AND source_type=0;
INSERT INTO smart_scripts VALUES (1715, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 60000, 90000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Insurgent - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (1715, 0, 1, 0, 0, 0, 100, 0, 4000, 10000, 20000, 30000, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Insurgent - In Combat - Cast Demoralizing Shout');
INSERT INTO smart_scripts VALUES (1715, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Insurgent - Between 0-15% Health - Flee For Assist');


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Targorr the Dread (1696)
DELETE FROM creature_text WHERE entry=1696;
INSERT INTO creature_text VALUES (1696, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 0, 'Targorr the Dread');
REPLACE INTO creature_template_addon VALUES (1696, 0, 0, 0, 4097, 0, '3417');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1696;
DELETE FROM smart_scripts WHERE entryorguid=1696 AND source_type=0;
INSERT INTO smart_scripts VALUES (1696, 0, 0, 0, 0, 0, 100, 257, 1000, 1000, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Targorr the Dread - Out of Combat - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (1696, 0, 1, 2, 2, 0, 100, 3, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Targorr the Dread - Between 0-30% Health - Cast Enrage');
INSERT INTO smart_scripts VALUES (1696, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Targorr the Dread - Between 0-30% Health - Say Line 0');

-- Kam Deepfury (1666)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1666;
DELETE FROM smart_scripts WHERE entryorguid=1666 AND source_type=0;
INSERT INTO smart_scripts VALUES (1666, 0, 0, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 11, 7164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kam Deepfury - In Combat - Cast Defensive Stance');
INSERT INTO smart_scripts VALUES (1666, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 10000, 16000, 11, 8242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kam Deepfury - In Combat - Cast Shield Slam');
INSERT INTO smart_scripts VALUES (1666, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 15000, 25000, 11, 3419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kam Deepfury - In Combat - Cast Improved Blocking');

-- Hamhock (1717)
DELETE FROM creature_text WHERE entry=1717;
INSERT INTO creature_text VALUES (1717, 0, 0, 'I''ll crush you!', 12, 0, 100, 0, 0, 0, 0, 'Hamhock');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1717;
DELETE FROM smart_scripts WHERE entryorguid=1717 AND source_type=0;
INSERT INTO smart_scripts VALUES (1717, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 4000, 7000, 11, 421, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hamhock - In Combat - Cast Chain Lightning');
INSERT INTO smart_scripts VALUES (1717, 0, 1, 0, 0, 0, 100, 1, 5000, 5000, 0, 0, 11, 6742, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hamhock - In Combat - Cast Bloodlust');
INSERT INTO smart_scripts VALUES (1717, 0, 2, 0, 16, 0, 100, 0, 6742, 30, 10000, 10000, 11, 6742, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Hamhock - Friendly Missing Buff - Cast Bloodlust');
INSERT INTO smart_scripts VALUES (1717, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hamhock - On Aggro - Say Line 0');

-- Bazil Thredd (1716)
DELETE FROM creature_text WHERE entry=1716;
INSERT INTO creature_text VALUES (1716, 0, 0, 'Welcome to the Stockade!', 12, 0, 100, 0, 0, 0, 0, 'Bazil Thredd');
INSERT INTO creature_text VALUES (1716, 0, 1, 'More of the Warden''s errand boys!', 12, 0, 100, 0, 0, 0, 0, 'Bazil Thredd');
INSERT INTO creature_text VALUES (1716, 0, 2, 'Why haven''t the Stormwind guards come?', 12, 0, 100, 0, 0, 0, 0, 'Bazil Thredd');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1716;
DELETE FROM smart_scripts WHERE entryorguid=1716 AND source_type=0;
INSERT INTO smart_scripts VALUES (1716, 0, 0, 0, 1, 0, 100, 257, 1000, 1000, 0, 0, 11, 674, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bazil Thredd - In Combat - Cast Dual Wield');
INSERT INTO smart_scripts VALUES (1716, 0, 1, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bazil Thredd - In Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (1716, 0, 2, 0, 0, 0, 100, 0, 8000, 10700, 15100, 25900, 11, 7964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bazil Thredd - In Combat - Cast Smoke Bomb');
INSERT INTO smart_scripts VALUES (1716, 0, 3, 0, 0, 0, 100, 0, 1000, 3000, 30000, 30000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bazil Thredd - In Combat - Cast Battle Shout');

-- Bruegal Ironknuckle (1720)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1720;
DELETE FROM smart_scripts WHERE entryorguid=1720 AND source_type=0;
INSERT INTO smart_scripts VALUES (1720, 0, 0, 0, 37, 0, 70, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bruegal Ironknuckle - On AI Init - Despawn'); -- No more than 50% when he appears

-- Dextren Ward (1663)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1663;
DELETE FROM smart_scripts WHERE entryorguid=1663 AND source_type=0;
INSERT INTO smart_scripts VALUES (1663, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 7165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dextren Ward - Out of Combat - Cast Battle Stance');
INSERT INTO smart_scripts VALUES (1663, 0, 1, 0, 0, 0, 100, 0, 7000, 9600, 14000, 22300, 11, 19134, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dextren Ward - In Combat - Cast Frightening Shout');
INSERT INTO smart_scripts VALUES (1663, 0, 2, 0, 0, 0, 100, 0, 3000, 4000, 4000, 6000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dextren Ward - In Combat - Cast Strike');


-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Warden Thelwater (1719)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=1719;
DELETE FROM smart_scripts WHERE entryorguid=1719 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1719*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (1719, 0, 0, 0, 1, 0, 100, 0, 0, 0, 20000, 43000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warden Thelwater - Out of Combat - Say Line 0');
INSERT INTO smart_scripts VALUES (1719, 0, 1, 0, 1, 0, 100, 0, 0, 0, 1800000, 1800000, 80, 1719*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warden Thelwater - Out of Combat - Start Script');
INSERT INTO smart_scripts VALUES (1719, 0, 2, 0, 17, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, -8785.28, 829.17, 97.50, 0, 'Warden Thelwater - Just Summoned - Move To Position Target');
INSERT INTO smart_scripts VALUES (1719*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8764.12, 847.34, 87.0, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8762.78, 845.03, 87.13, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8763.56, 845.94, 87.15, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 3, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8765.72, 848.69, 87.14, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 4, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8763.56, 845.94, 87.15, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 5, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8764.12, 847.34, 87.0, 3.88, 'Warden Thelwater - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1719*100, 9, 6, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 5043, 4, 30000, 0, 0, 0, 8, 0, 0, 0, -8765.72, 848.69, 87.14, 3.88, 'Warden Thelwater - Script9 - Summon Creature');

-- Defias Rioter (5043)
REPLACE INTO creature_template_addon VALUES (5043, 0, 0, 0, 4097, 0, '');
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=5043;
DELETE FROM smart_scripts WHERE entryorguid=5043 AND source_type=0;

-- Defias Prisoner Event
-- Defias Prisoner (1706)
DELETE FROM event_scripts WHERE id=19030;
INSERT INTO event_scripts VALUES (19030, 0, 10, 1706, 6000000, 0, -8644.22, 1328.58, 5.54, 5.18);
UPDATE creature_template SET faction=290, AIName='SmartAI', ScriptName='' WHERE entry=1706;
DELETE FROM smart_scripts WHERE entryorguid=1706 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1706*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (1706, 0, 0, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 1766, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Victim Casting - Cast Kick');
INSERT INTO smart_scripts VALUES (1706, 0, 1, 0, 0, 0, 100, 0, 5000, 15000, 10000, 17000, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - In Combat - Cast Disarm');
INSERT INTO smart_scripts VALUES (1706, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Between 0-15% Health - Flee For Assist');
INSERT INTO smart_scripts VALUES (1706, 0, 3, 0, 11, 0, 100, 1, 1, 34, 0, 0, 2, 17, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - On Respawn - Set Faction 17');
INSERT INTO smart_scripts VALUES (1706, 0, 4, 0, 11, 0, 100, 1, 1, 0, 0, 0, 80, 1706*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - On Respawn - Run Script');
INSERT INTO smart_scripts VALUES (1706, 0, 5, 6, 40, 0, 100, 0, 103, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 37063, 20, 0, 0, 0, 0, 0, 'Defias Prisoner - On WP Reached - Despawn Target');
INSERT INTO smart_scripts VALUES (1706, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - On WP Reached - Despawn');
INSERT INTO smart_scripts VALUES (1706, 0, 7, 8, 17, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Just Summoned - Store Target');
INSERT INTO smart_scripts VALUES (1706, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Just Summoned - Send Target to Target');
INSERT INTO smart_scripts VALUES (1706, 0, 9, 0, 37, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - On AI Init - Store Target');
INSERT INTO smart_scripts VALUES (1706*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 37063, 8, 0, 0, 0, 0, 1, 0, 0, 0, -1, -2, 0, 0, 'Defias Prisoner - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1706*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (1706*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 37063, 8, 0, 0, 0, 0, 1, 0, 0, 0, -1, -0.75, 0, 0, 'Defias Prisoner - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1706*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (1706*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 37063, 8, 0, 0, 0, 0, 1, 0, 0, 0, -1.5, 1, 0, 0, 'Defias Prisoner - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1706*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (1706*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 37063, 8, 0, 0, 0, 0, 1, 0, 0, 0, -1.5, 1.5, 0, 0, 'Defias Prisoner - Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1706*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 4, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Set Data');
INSERT INTO smart_scripts VALUES (1706*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Set Active');
INSERT INTO smart_scripts VALUES (1706*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 139, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Load Equipment');
INSERT INTO smart_scripts VALUES (1706*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 0, 1706, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Defias Prisoner - Script9 - Start WP');
DELETE FROM waypoints WHERE entry=1706;
INSERT INTO waypoints VALUES (1706, 1, -8641.35, 1324.81, 5.233, 'Defias Prisoner'),(1706, 2, -8640.57, 1323.19, 5.25525, 'Defias Prisoner'),(1706, 3, -8631.9, 1306.63, 5.2324, 'Defias Prisoner'),(1706, 4, -8619.75, 1282.73, 5.2324, 'Defias Prisoner'),(1706, 5, -8608.1, 1259.83, 5.2324, 'Defias Prisoner'),(1706, 6, -8600.4, 1244.67, 5.70763, 'Defias Prisoner'),(1706, 7, -8592.91, 1229.94, 5.2311, 'Defias Prisoner'),(1706, 8, -8587.89, 1220.72, 5.63664, 'Defias Prisoner'),(1706, 9, -8585.38, 1215.41, 5.12153, 'Defias Prisoner'),(1706, 10, -8575.2, 1193.65, 5.69794, 'Defias Prisoner'),(1706, 11, -8574.88, 1186.66, 11.3194, 'Defias Prisoner'),(1706, 12, -8574.82, 1178.47, 17.9033, 'Defias Prisoner'),(1706, 13, -8573.39, 1175.27, 17.7088, 'Defias Prisoner'),(1706, 14, -8575.38, 1163.84, 17.7088, 'Defias Prisoner'),(1706, 15, -8575.58, 1161.6, 18.4894, 'Defias Prisoner'),(1706, 16, -8575.66, 1159.75, 17.9452, 'Defias Prisoner'),
(1706, 17, -8576.77, 1149.38, 18.0082, 'Defias Prisoner'),(1706, 18, -8578.37, 1135.47, 17.949, 'Defias Prisoner'),(1706, 19, -8581.11, 1125.33, 17.9446, 'Defias Prisoner'),(1706, 20, -8583.3, 1117.22, 17.9447, 'Defias Prisoner'),(1706, 21, -8585.34, 1111.78, 21.284, 'Defias Prisoner'),(1706, 22, -8587.77, 1105.29, 25.3006, 'Defias Prisoner'),(1706, 23, -8590.51, 1096.39, 30.0475, 'Defias Prisoner'),(1706, 24, -8590.12, 1087.09, 33.4427, 'Defias Prisoner'),(1706, 25, -8585.84, 1075.02, 36.1143, 'Defias Prisoner'),(1706, 26, -8580.91, 1068.56, 37.7707, 'Defias Prisoner'),(1706, 27, -8573.15, 1058.37, 44.4035, 'Defias Prisoner'),(1706, 28, -8563.31, 1045.45, 52.8141, 'Defias Prisoner'),(1706, 29, -8557.03, 1038.48, 57.4878, 'Defias Prisoner'),(1706, 30, -8553.93, 1036.44, 59.34, 'Defias Prisoner'),(1706, 31, -8546.93, 1036.27, 59.4142, 'Defias Prisoner'),(1706, 32, -8537.82, 1034.34, 59.6157, 'Defias Prisoner'),
(1706, 33, -8531.56, 1025.92, 59.7549, 'Defias Prisoner'),(1706, 34, -8521.24, 1015.53, 59.8643, 'Defias Prisoner'),(1706, 35, -8513.08, 1011.04, 59.6285, 'Defias Prisoner'),(1706, 36, -8505.13, 1004.29, 59.4794, 'Defias Prisoner'),(1706, 37, -8498.66, 997.183, 62.9424, 'Defias Prisoner'),(1706, 38, -8489.09, 987.094, 72.7379, 'Defias Prisoner'),(1706, 39, -8486.16, 983.431, 72.7379, 'Defias Prisoner'),(1706, 40, -8482.47, 986.317, 72.7379, 'Defias Prisoner'),(1706, 41, -8476.89, 990.667, 78.7541, 'Defias Prisoner'),(1706, 42, -8470.06, 993.107, 79.0886, 'Defias Prisoner'),(1706, 43, -8464.97, 986.427, 79.023, 'Defias Prisoner'),(1706, 44, -8470.04, 982.66, 79.0014, 'Defias Prisoner'),(1706, 45, -8477.26, 976.788, 85.2469, 'Defias Prisoner'),(1706, 46, -8483.62, 971.622, 91.8688, 'Defias Prisoner'),(1706, 47, -8487.29, 968.64, 95.8566, 'Defias Prisoner'),(1706, 48, -8498.21, 961.956, 95.9496, 'Defias Prisoner'),(1706, 49, -8512.78, 954.621, 95.85, 'Defias Prisoner'),
(1706, 50, -8522.01, 955.868, 95.8665, 'Defias Prisoner'),(1706, 51, -8536.29, 961.026, 96.0033, 'Defias Prisoner'),(1706, 52, -8547.29, 964.994, 96.4981, 'Defias Prisoner'),(1706, 53, -8555.11, 973.677, 96.2403, 'Defias Prisoner'),(1706, 54, -8563.69, 983.193, 96.351, 'Defias Prisoner'),(1706, 55, -8570.72, 990.993, 96.2609, 'Defias Prisoner'),(1706, 56, -8576.13, 987.894, 96.309, 'Defias Prisoner'),(1706, 57, -8577.95, 986.507, 97.1472, 'Defias Prisoner'),(1706, 58, -8590.71, 976.303, 97.8743, 'Defias Prisoner'),(1706, 59, -8607.21, 963.424, 99.4452, 'Defias Prisoner'),(1706, 60, -8621.38, 957.955, 99.4452, 'Defias Prisoner'),(1706, 61, -8638.03, 952.562, 99.4669, 'Defias Prisoner'),(1706, 62, -8654.67, 947.142, 100.68, 'Defias Prisoner'),(1706, 63, -8667.72, 939.37, 101.191, 'Defias Prisoner'),(1706, 64, -8685.76, 928.624, 101.247, 'Defias Prisoner'),(1706, 65, -8702.43, 917.789, 101.241, 'Defias Prisoner'),(1706, 66, -8714.44, 908.49, 101.241, 'Defias Prisoner'),
(1706, 67, -8727.33, 898.504, 100.934, 'Defias Prisoner'),(1706, 68, -8740.41, 890.905, 101.429, 'Defias Prisoner'),(1706, 69, -8752.08, 891.604, 101.898, 'Defias Prisoner'),(1706, 70, -8762.36, 893.742, 101.534, 'Defias Prisoner'),(1706, 71, -8771.17, 901.526, 100.75, 'Defias Prisoner'),(1706, 72, -8780.8, 913.277, 100.047, 'Defias Prisoner'),(1706, 73, -8792.14, 924.999, 100.402, 'Defias Prisoner'),(1706, 74, -8800.06, 935.066, 101.241, 'Defias Prisoner'),(1706, 75, -8808.02, 945.188, 101.241, 'Defias Prisoner'),(1706, 76, -8815.25, 954.374, 100.751, 'Defias Prisoner'),(1706, 77, -8819.64, 951.866, 100.791, 'Defias Prisoner'),(1706, 78, -8826.17, 946.929, 103.049, 'Defias Prisoner'),(1706, 79, -8834.62, 940.698, 105.162, 'Defias Prisoner'),(1706, 80, -8839.53, 937.589, 105.285, 'Defias Prisoner'),(1706, 81, -8845.4, 933.774, 103.745, 'Defias Prisoner'),(1706, 82, -8849.75, 931.067, 102.551, 'Defias Prisoner'),(1706, 83, -8851.53, 929.383, 102.024, 'Defias Prisoner'),
(1706, 84, -8847.38, 922.771, 101.697, 'Defias Prisoner'),(1706, 85, -8842.95, 915.887, 99.9569, 'Defias Prisoner'),(1706, 86, -8836.27, 906.291, 97.8529, 'Defias Prisoner'),(1706, 87, -8828.95, 895.775, 98.1249, 'Defias Prisoner'),(1706, 88, -8821.26, 886.969, 98.4819, 'Defias Prisoner'),(1706, 89, -8813.65, 878.104, 98.7189, 'Defias Prisoner'),(1706, 90, -8804.11, 866.37, 98.9565, 'Defias Prisoner'),(1706, 91, -8799.76, 861.024, 98.8853, 'Defias Prisoner'),(1706, 92, -8797.76, 858.557, 97.6348, 'Defias Prisoner'),(1706, 93, -8798.21, 851.501, 97.6348, 'Defias Prisoner'),(1706, 94, -8798.12, 843.382, 97.6348, 'Defias Prisoner'),(1706, 95, -8798.34, 832.884, 97.6348, 'Defias Prisoner'),(1706, 96, -8797.24, 828.395, 97.6348, 'Defias Prisoner'),(1706, 97, -8791.14, 827.631, 97.6406, 'Defias Prisoner'),(1706, 98, -8787.67, 827.162, 97.6451, 'Defias Prisoner'),(1706, 99, -8785.28, 828.929, 97.5397, 'Defias Prisoner'),(1706, 100, -8780.81, 832.646, 95.3486, 'Defias Prisoner'),(1706, 101, -8772.74, 839.364, 91.3895, 'Defias Prisoner'),
(1706, 102, -8764.67, 846.081, 87.4378, 'Defias Prisoner'),(1706, 103, -8759.14, 850.244, 84.8424, 'Defias Prisoner');

-- Stormwind City Guard (37063), unused
UPDATE creature_template SET speed_walk=1.01, AIName='SmartAI', ScriptName='' WHERE entry=37063;
DELETE FROM smart_scripts WHERE entryorguid=37063 AND source_type=0;
INSERT INTO smart_scripts VALUES (37063, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 29, 4294967294, 90, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Stormwind City Guard - On Data Set - Set Follow');
INSERT INTO smart_scripts VALUES (37063, 0, 1, 0, 38, 0, 100, 0, 2, 0, 0, 0, 29, 4294967294, 155, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Stormwind City Guard - On Data Set - Set Follow');
INSERT INTO smart_scripts VALUES (37063, 0, 2, 0, 38, 0, 100, 0, 3, 0, 0, 0, 29, 4294967294, 205, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Stormwind City Guard - On Data Set - Set Follow');
INSERT INTO smart_scripts VALUES (37063, 0, 3, 0, 38, 0, 100, 0, 4, 0, 0, 0, 29, 4294967294, 270, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Stormwind City Guard - On Data Set - Set Follow');

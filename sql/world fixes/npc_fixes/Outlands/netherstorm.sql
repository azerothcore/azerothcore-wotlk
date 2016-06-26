
-- Warden Icoshock (20770)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20770;
DELETE FROM smart_scripts WHERE entryorguid=20770 AND source_type=0;
INSERT INTO smart_scripts VALUES (20770, 0, 0, 0, 0, 0, 100, 0, 8000, 10000, 10000, 15000, 11, 36517, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Warden Icoshock - In Combat - Cast Shadowsurge');
INSERT INTO smart_scripts VALUES (20770, 0, 1, 0, 0, 0, 100, 0, 0, 0, 300000, 300000, 11, 36515, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Warden Icoshock - In Combat - Cast Shadowtouched');

-- Captain Zovax (20727)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20727;
DELETE FROM smart_scripts WHERE entryorguid=20727 AND source_type=0;
INSERT INTO smart_scripts VALUES (20727, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Zovax - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (20727, 0, 1, 0, 0, 0, 100, 0, 0, 0, 15000, 15000, 11, 33962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Zovax - In Combat - Cast Toughen');

-- Forgemaster Morug (20800)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20800;
DELETE FROM smart_scripts WHERE entryorguid=20800 AND source_type=0;
INSERT INTO smart_scripts VALUES (20800, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 11000, 11, 36228, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Forgemaster Morug - In Combat - Cast Chainsaw Blade');
INSERT INTO smart_scripts VALUES (20800, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 15000, 15000, 11, 34261, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Forgemaster Morug - In Combat - Cast Slime Spray');

-- Overmaster Grindgarr (20803)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20803;
DELETE FROM smart_scripts WHERE entryorguid=20803 AND source_type=0;
INSERT INTO smart_scripts VALUES (20803, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 16000, 21000, 11, 35238, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overmaster Grindgarr - In Combat - Cast War Stomp');
INSERT INTO smart_scripts VALUES (20803, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 15000, 15000, 11, 36487, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overmaster Grindgarr - In Combat - Cast Fel Flames');

-- Overseer Azarad (20803)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20803;
DELETE FROM smart_scripts WHERE entryorguid=20803 AND source_type=0;
INSERT INTO smart_scripts VALUES (20803, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 16000, 21000, 11, 35492, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Azarad - In Combat - Cast Exhaustion');
INSERT INTO smart_scripts VALUES (20803, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 21000, 28000, 11, 35491, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overseer Azarad - In Combat - Cast Furious Rage');

-- Overseer Athanel (20435)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20435;
DELETE FROM smart_scripts WHERE entryorguid=20435 AND source_type=0;
INSERT INTO smart_scripts VALUES (20435, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 8000, 11000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Athanel - In Combat - Cast Cleave');

-- Eye of Culuthas (20394)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20394;
DELETE FROM smart_scripts WHERE entryorguid=20394 AND source_type=0;
INSERT INTO smart_scripts VALUES (20394, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 12000, 12000, 11, 36414, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Eye of Culuthas - In Combat - Cast Focused Bursts');

-- SPELL Focused Bursts (36448)
-- SPELL Focused Bursts (36475)
DELETE FROM spell_script_names WHERE spell_id IN(36448, 36475);
INSERT INTO spell_script_names VALUES(36448, 'spell_gen_focused_bursts');
INSERT INTO spell_script_names VALUES(36475, 'spell_gen_focused_bursts');

-- Ekkorash the Inquisitor (19493)
DELETE FROM creature_text WHERE entry=19493;
INSERT INTO creature_text VALUES (19493, 0, 0, 'I told you only to summon me if that stupid elf returned! What''s this? No matter, you won''t detain me long.', 12, 0, 100, 0, 0, 0, 0, 'Ekkorash the Inquisitor');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19493;
DELETE FROM smart_scripts WHERE entryorguid=19493 AND source_type=0;
INSERT INTO smart_scripts VALUES (19493, 0, 0, 0, 0, 0, 100, 0, 3000, 7000, 14000, 20000, 11, 11980, 32, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ekkorash the Inquisitor - In Combat - Cast Curse of Weakness');
INSERT INTO smart_scripts VALUES (19493, 0, 1, 0, 0, 0, 100, 0, 9000, 11000, 18000, 23000, 11, 36040, 1, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Ekkorash the Inquisitor - In Combat - Cast Fel Flamestrike');
INSERT INTO smart_scripts VALUES (19493, 0, 2, 0, 4, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ekkorash the Inquisitor - On Aggro - Say Line 0');

-- Captain Arathyn (19635)
REPLACE INTO creature_addon VALUES (70059, 700590, 18696, 0, 4097, 0, '');
DELETE FROM waypoint_data where id=700590;
INSERT INTO waypoint_data VALUES (700590, 1, 3023.34, 3969.64, 156.656, 0, 0, 0, 0, 100, 0),(700590, 2, 3017.83, 3975.6, 157.116, 0, 0, 0, 0, 100, 0),(700590, 3, 3022.25, 3970.17, 156.716, 0, 0, 0, 0, 100, 0),(700590, 4, 3023.42, 3964.41, 156.09, 0, 0, 0, 0, 100, 0),(700590, 5, 3023.06, 3956.23, 155.351, 0, 0, 0, 0, 100, 0),(700590, 6, 3028.74, 3948.85, 154.982, 0, 0, 0, 0, 100, 0),(700590, 7, 3034.78, 3941.67, 154.75, 0, 0, 0, 0, 100, 0),(700590, 8, 3040.77, 3934.54, 152.74, 0, 0, 0, 0, 100, 0),(700590, 9, 3044.71, 3924.81, 148.97, 0, 0, 0, 0, 100, 0),(700590, 10, 3048.8, 3913.86, 146.555, 0, 0, 0, 0, 100, 0),(700590, 11, 3047, 3920.63, 147.908, 0, 0, 0, 0, 100, 0),(700590, 12, 3044.9, 3928.54, 150.046, 0, 0, 0, 0, 100, 0),(700590, 13, 3041.36, 3935.92, 153.134, 0, 0, 0, 0, 100, 0),(700590, 14, 3038.5, 3940.98, 154.542, 0, 0, 0, 0, 100, 0),(700590, 15, 3032.24, 3946.12, 154.859, 0, 0, 0, 0, 100, 0),(700590, 16, 3024.89, 3953.52, 155.136, 0, 0, 0, 0, 100, 0),(700590, 17, 3023.92, 3959.25, 155.559, 0, 0, 0, 0, 100, 0);
UPDATE creature SET MovementType=2 WHERE id=19635;

-- Azurebeak (21005)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21005;
DELETE FROM smart_scripts WHERE entryorguid=21005 AND source_type=0;
INSERT INTO smart_scripts VALUES (21005, 0, 0, 0, 0, 0, 100, 0, 9100, 9100, 11000, 14000, 11, 31273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Azurebeak - In Combat - Cast Screech');
INSERT INTO smart_scripts VALUES (21005, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Azurebeak - Out of Combat - Despawn');

-- Silroth (20801)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20801;
DELETE FROM smart_scripts WHERE entryorguid=20801 AND source_type=0;
INSERT INTO smart_scripts VALUES (20801, 0, 0, 0, 0, 0, 100, 0, 7000, 10000, 15000, 20000, 11, 36253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silroth - In Combat - Cast Chemical Flames');
INSERT INTO smart_scripts VALUES (20801, 0, 1, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 11, 36252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silroth - In Combat - Cast Felforge Flames');

-- Markaru (20775)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20775;
DELETE FROM smart_scripts WHERE entryorguid=20775 AND source_type=0;
INSERT INTO smart_scripts VALUES (20775, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 7000, 10000, 11, 36627, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Markaru - In Combat - Cast Venom Spit');

-- Agent Ya-six <The Protectorate> (20552)
DELETE FROM creature_text WHERE entry=20552;
INSERT INTO creature_text VALUES (20552, 0, 0, 'Hey! Hey you! $R! Over there!', 12, 0, 100, 0, 0, 0, 0, 'Agent Ya-six');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20552;
DELETE FROM smart_scripts WHERE entryorguid=20552 AND source_type=0;
INSERT INTO smart_scripts VALUES (20552, 0, 0, 0, 10, 0, 100, 0, 1, 30, 60000, 60000, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Agent Ya-six - Out of Combat LoS - Say Line 0');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=20552;
INSERT INTO conditions VALUES (22, 1, 20552, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run Action if invoker is player');

-- Reflection of Ya-six (20603)
DELETE FROM creature_text WHERE entry=20603;
INSERT INTO creature_text VALUES (20603, 0, 0, 'Arconus is close. I can feel him. Take the northwest passage. He should be just up and around the corner. Be ready to battle!', 12, 0, 100, 0, 0, 0, 0, 'Reflection of Ya-six');
INSERT INTO creature_text VALUES (20603, 1, 0, 'This is the wrong way. Arconus is at the other end of the mine. You''re not chickening out, are you, fleshling? I won''t follow a coward.', 12, 0, 100, 0, 0, 0, 0, 'Reflection of Ya-six');
UPDATE creature_template SET unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=20603;
DELETE FROM smart_scripts WHERE entryorguid=20603 AND source_type=0;
INSERT INTO smart_scripts VALUES (20603, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reflection of Ya-six - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (20603, 0, 1, 0, 38, 0, 100, 257, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reflection of Ya-six - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (20603, 0, 2, 3, 38, 0, 100, 257, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reflection of Ya-six - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (20603, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reflection of Ya-six - On Data Set - Despawn');

-- Ya-six Spell Generator (20608)
DELETE FROM creature WHERE id=20608;
INSERT INTO creature VALUES (247235, 20608, 530, 1, 1, 0, 0, 3909.51, 2090.34, 155.82, 0.0, 300, 0, 0, 4050, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247236, 20608, 530, 1, 1, 0, 0, 3773.56, 2078.38, 154.75, 0.0, 300, 0, 0, 4050, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20608;
DELETE FROM smart_scripts WHERE entryorguid IN(20608, -247235, -247236) AND source_type=0;
INSERT INTO smart_scripts VALUES (-247235, 0, 0, 0, 60, 0, 100, 0, 0, 0, 5000, 5000, 45, 1, 0, 0, 0, 0, 0, 11, 20603, 5, 0, 0, 0, 0, 0, 'Ya-six Spell Generator - On Update - Set Data');
INSERT INTO smart_scripts VALUES (-247236, 0, 0, 0, 60, 0, 100, 0, 0, 0, 5000, 5000, 45, 2, 0, 0, 0, 0, 0, 11, 20603, 5, 0, 0, 0, 0, 0, 'Ya-six Spell Generator - On Update - Set Data');

-- Arconus the Insatiable (20554)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20554;
DELETE FROM smart_scripts WHERE entryorguid=20554 AND source_type=0;
INSERT INTO smart_scripts VALUES (20554, 0, 0, 0, 0, 0, 100, 0, 7000, 10000, 15000, 20000, 11, 36473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arconus the Insatiable - In Combat - Cast Desecration');
INSERT INTO smart_scripts VALUES (20554, 0, 1, 0, 2, 0, 100, 0, 0, 40, 30000, 30000, 11, 36472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Arconus the Insatiable - Between Health 0-40% - Cast Consume Shadows');

-- Socrethar (20132)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20132;
DELETE FROM smart_scripts WHERE entryorguid=20132 AND source_type=0;
INSERT INTO smart_scripts VALUES (20132, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 37539, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Respawn - Cast Nether Protection');
INSERT INTO smart_scripts VALUES (20132, 0, 1, 0, 0, 0, 100, 0, 7000, 9000, 15000, 20000, 11, 28448, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (20132, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 30000, 30000, 11, 37538, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast Anti-Magic Shield');
INSERT INTO smart_scripts VALUES (20132, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 10000, 15000, 11, 37537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast Backlash');
INSERT INTO smart_scripts VALUES (20132, 0, 4, 0, 0, 0, 100, 0, 14000, 15000, 10000, 15000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast Cleave');

-- Culuthas (20138)
DELETE FROM creature_text WHERE entry=20138;
INSERT INTO creature_text VALUES (20138, 0, 0, 'You''ll never get the ata''mal crystal from me!', 12, 0, 100, 0, 0, 0, 0, 'Culuthas');
INSERT INTO creature_text VALUES (20138, 0, 1, 'I will use the power of the ata''mal crystal to crush you!', 12, 0, 100, 0, 0, 0, 0, 'Culuthas');
INSERT INTO creature_text VALUES (20138, 0, 2, 'The ata''mal crystal is mine!', 12, 0, 100, 0, 0, 0, 0, 'Culuthas');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20138;
DELETE FROM smart_scripts WHERE entryorguid=20138 AND source_type=0;
INSERT INTO smart_scripts VALUES (20138, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Culuthas - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (20138, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 37089, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Culuthas - In Combat - Cast Chain Felfire');
INSERT INTO smart_scripts VALUES (20138, 0, 2, 0, 0, 0, 100, 0, 6000, 10000, 11000, 14000, 11, 35373, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Culuthas - In Combat - Cast Shadowfury');

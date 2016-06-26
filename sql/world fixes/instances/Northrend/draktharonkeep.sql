
-- -------------------------------------------
--                TRASH
-- -------------------------------------------

-- Scourge Reanimator (26626, 31359)
DELETE FROM creature_text WHERE entry=26626;
INSERT INTO creature_text VALUES (26626, 0, 0, "Don't be so quick to escape! I have a parting gift....", 14, 0, 100, 0, 0, 0, 0, 'Scourge Reanimator');
INSERT INTO creature_text VALUES (26626, 1, 0, "Please enjoy their company, the Lich King sends his regards!", 14, 0, 100, 0, 0, 0, 0, 'Scourge Reanimator');
INSERT INTO creature_text VALUES (26626, 2, 0, "Rise my warriors and fight for your new liege!", 14, 0, 100, 0, 0, 0, 0, 'Scourge Reanimator');
UPDATE creature_template SET baseattacktime=2500, lootid=26626, pickpocketloot=26626, AIName='SmartAI', ScriptName='' WHERE entry=26626;
UPDATE creature_template SET baseattacktime=2500, lootid=26626, pickpocketloot=26626, AIName='', ScriptName='' WHERE entry=31359;
DELETE FROM smart_scripts WHERE entryorguid=26626 AND source_type=0;
INSERT INTO smart_scripts VALUES (26626, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 6000, 8000, 11, 50378, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26626, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 6000, 8000, 11, 59017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26626, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 15000, 15000, 11, 50379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (26626, 0, 3, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 11, 49805, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Unholy Frenzy');

-- Risen Drakkari Warrior (26635, 31355)
DELETE FROM creature_text WHERE entry=26635;
INSERT INTO creature_text VALUES (26635, 0, 0, "Help mon! There's too many of dem!", 14, 0, 100, 0, 0, 0, 0, 'Risen Drakkari Warrior');
INSERT INTO creature_text VALUES (26635, 1, 0, "Backup! We need backup!", 14, 0, 100, 0, 0, 0, 0, 'Risen Drakkari Warrior');
UPDATE creature_template SET baseattacktime=2000, lootid=26635, pickpocketloot=26635, AIName='SmartAI', ScriptName='' WHERE entry=26635;
UPDATE creature_template SET baseattacktime=2000, lootid=26635, pickpocketloot=26635, AIName='', ScriptName='' WHERE entry=31355;
DELETE FROM smart_scripts WHERE entryorguid=26635 AND source_type=0;
INSERT INTO smart_scripts VALUES (26635, 0, 0, 0, 0, 0, 100, 0, 1000, 3000, 5000, 9500, 11, 36093, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - In Combat - Cast Ghost Strike');
INSERT INTO smart_scripts VALUES (26635, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 7250, 10000, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - In Combat - Cast Crush Armor');
INSERT INTO smart_scripts VALUES (26635, 0, 2, 3, 54, 0, 100, 0, 0, 0, 0, 0, 11, 48624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - In Summoned By - Cast Birth Dead Visual');
INSERT INTO smart_scripts VALUES (26635, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - In Summoned By - Move Random');
INSERT INTO smart_scripts VALUES (26635, 0, 10, 0, 37, 0, 100, 257, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - AI Init - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (26635, 0, 11, 0, 32, 0, 100, 1, 0, 100000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Warrior - On Damage Taken - Set HP Invincibility');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=26635;
INSERT INTO conditions VALUES(22, 12, 26635, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player');

-- Drakkari Guardian (26620, 31339)
UPDATE creature_template SET faction=1965, unit_flags=0, dynamicflags=0, lootid=26620, pickpocketloot=26620, AIName='SmartAI', ScriptName='' WHERE entry=26620;
UPDATE creature_template SET faction=1965, unit_flags=0, dynamicflags=0, lootid=26620, pickpocketloot=26620, AIName='', ScriptName='' WHERE entry=31339;
UPDATE creature SET modelid=0, npcflag=0, unit_flags=33554432+256+512+2+4, dynamicflags=0 WHERE id=26620 AND position_z < 50.0;
UPDATE creature SET modelid=0, npcflag=0, unit_flags=0, dynamicflags=0 WHERE id=26620 AND position_z >= 50.0;
DELETE FROM smart_scripts WHERE entryorguid=26620 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(SELECT -guid FROM creature WHERE id=26620 AND position_z >= 50) AND source_type=0;
INSERT INTO smart_scripts VALUES (26620, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 7000, 12000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (26620, 0, 1, 0, 13, 0, 100, 0, 8000, 9000, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - Victim Casting - Cast Shield Bash');
INSERT INTO smart_scripts SELECT -guid, 0, 9, 0, 37, 0, 100, 0, 0, 0, 0, 0, 2, 1965, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - AI Init - Set Faction' FROM creature WHERE id=26620 AND position_z >= 50;
INSERT INTO smart_scripts SELECT -guid, 0, 10, 0, 37, 0, 100, 257, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - AI Init - Set HP Invincibility' FROM creature WHERE id=26620 AND position_z >= 50;
INSERT INTO smart_scripts SELECT -guid, 0, 11, 12, 32, 0, 100, 1, 0, 100000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - On Damage Taken - Set HP Invincibility' FROM creature WHERE id=26620 AND position_z >= 50;
INSERT INTO smart_scripts SELECT -guid, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Guardian - On Damage Taken - Set Event Phase' FROM creature WHERE id=26620 AND position_z >= 50;
INSERT INTO smart_scripts SELECT -guid, 0, 13, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26623, 5, 0, 0, 0, 0, 0, 'Drakkari Guardian - Out of Combat - Attack Start' FROM creature WHERE id=26620 AND position_z >= 50;
INSERT INTO smart_scripts SELECT -guid, 0, 14, 0, 1, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 26635, 5, 0, 0, 0, 0, 0, 'Drakkari Guardian - Out of Combat - Attack Start' FROM creature WHERE id=26620 AND position_z >= 50;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=26639;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(SELECT -guid FROM creature WHERE id=26620 AND position_z >= 50);
INSERT INTO conditions SELECT 22, 12, -guid, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player' FROM creature WHERE id=26620 AND position_z >= 50;

-- Drakkari Shaman (26639, 31345)
UPDATE creature_template SET baseattacktime=2000, lootid=26639, pickpocketloot=26639, AIName='SmartAI', ScriptName='' WHERE entry=26639;
UPDATE creature_template SET baseattacktime=2000, lootid=26639, pickpocketloot=26639, AIName='', ScriptName='' WHERE entry=31345;
DELETE FROM smart_scripts WHERE entryorguid=26639 AND source_type=0;
INSERT INTO smart_scripts VALUES (26639, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 2000, 2000, 11, 48895, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Shaman - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (26639, 0, 1, 0, 14, 0, 100, 0, 10000, 30, 7250, 10000, 11, 48894, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Shaman - Friendly Missing Health - Cast Chain Heal');

-- Scourge Brute (26623, 31357)
UPDATE creature SET id=26623, equipment_id=1, curhealth=44004, curmana=0 WHERE guid=127438 AND id=26636;
UPDATE creature_template SET baseattacktime=2000, lootid=26623, AIName='SmartAI', ScriptName='' WHERE entry=26623;
UPDATE creature_template SET baseattacktime=2000, lootid=26623, AIName='', ScriptName='' WHERE entry=31357;
DELETE FROM smart_scripts WHERE entryorguid=26623 AND source_type=0;
INSERT INTO smart_scripts VALUES (26623, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 7000, 12000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Brute - In Combat - Cast Mortal Strike');
INSERT INTO smart_scripts VALUES (26623, 0, 1, 0, 0, 0, 100, 0, 10000, 12000, 13000, 15000, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Brute - In Combat - Cast Knockdown');
INSERT INTO smart_scripts VALUES (26623, 0, 10, 0, 37, 0, 100, 257, 0, 0, 0, 0, 42, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'DScourge Brute - AI Init - Set HP Invincibility');
INSERT INTO smart_scripts VALUES (26623, 0, 11, 0, 32, 0, 100, 1, 0, 100000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Brute - On Damage Taken - Set HP Invincibility');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=26623;
INSERT INTO conditions VALUES(22, 12, 26623, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Action Invoker is a player');

-- Drakkari Commander (27431, 31338)
UPDATE creature_template SET baseattacktime=2000, lootid=27431, pickpocketloot=27431, AIName='SmartAI', ScriptName='' WHERE entry=27431;
UPDATE creature_template SET baseattacktime=2000, lootid=27431, pickpocketloot=27431, AIName='', ScriptName='' WHERE entry=31338;
DELETE FROM smart_scripts WHERE entryorguid=27431 AND source_type=0;
INSERT INTO smart_scripts VALUES (27431, 0, 0, 0, 0, 0, 100, 0, 0, 0, 30000, 30000, 11, 49724, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Commander - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (27431, 0, 1, 0, 0, 0, 100, 2, 4000, 7000, 8000, 10000, 11, 49807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Commander - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (27431, 0, 2, 0, 0, 0, 100, 4, 4000, 7000, 8000, 10000, 11, 24236, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Commander - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (27431, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Commander - Between Health 0-30% - Cast Frenzy');

-- Risen Drakkari Soulmage (26636, 31354)
UPDATE creature_template SET baseattacktime=2000, lootid=26636, pickpocketloot=26636, AIName='SmartAI', ScriptName='' WHERE entry=26636;
UPDATE creature_template SET baseattacktime=2000, lootid=26636, pickpocketloot=26636, AIName='', ScriptName='' WHERE entry=31354;
DELETE FROM smart_scripts WHERE entryorguid=26636 AND source_type=0;
INSERT INTO smart_scripts VALUES (26636, 0, 0, 0, 0, 0, 100, 2, 1000, 6000, 7000, 12000, 11, 49696, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - In Combat - Cast Shadow Blast');
INSERT INTO smart_scripts VALUES (26636, 0, 1, 0, 0, 0, 100, 4, 1000, 5000, 7000, 12000, 11, 59013, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - In Combat - Cast Shadow Blast');
INSERT INTO smart_scripts VALUES (26636, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 8900, 13500, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - In Combat - Cast Knockdown');
INSERT INTO smart_scripts VALUES (26636, 0, 3, 0, 0, 0, 50, 2, 2900, 6600, 10000, 12000, 11, 55847, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - In Combat - Cast Shadow Void');
INSERT INTO smart_scripts VALUES (26636, 0, 4, 0, 0, 0, 50, 4, 2900, 6600, 10000, 12000, 11, 59014, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - In Combat - Cast Shadow Void');
INSERT INTO smart_scripts VALUES (26636, 0, 5, 0, 2, 0, 100, 2, 0, 75, 4000, 9000, 11, 49701, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - Between 0-75% Health - Cast Blood Siphon');
INSERT INTO smart_scripts VALUES (26636, 0, 6, 0, 2, 0, 100, 4, 0, 75, 4000, 9000, 11, 59015, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Soulmage - Between 0-75% Health - Cast Blood Siphon');

-- Ghoul Tormentor (26621, 31347)
REPLACE INTO creature_template_addon VALUES (26621, 0, 0, 0, 4097, 418, '');
REPLACE INTO creature_template_addon VALUES (31347, 0, 0, 0, 4097, 418, '');
UPDATE creature_template SET baseattacktime=2000, lootid=26621, pickpocketloot=26621, AIName='SmartAI', ScriptName='' WHERE entry=26621;
UPDATE creature_template SET baseattacktime=2000, lootid=26621, pickpocketloot=26621, AIName='', ScriptName='' WHERE entry=31347;
DELETE FROM smart_scripts WHERE entryorguid=26621 AND source_type=0;
INSERT INTO smart_scripts VALUES (26621, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 9000, 11, 51917, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Tormentor - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (26621, 0, 1, 0, 0, 0, 100, 2, 6000, 9000, 9000, 12000, 11, 49678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Tormentor - In Combat - Cast Flesh Rot');
INSERT INTO smart_scripts VALUES (26621, 0, 2, 0, 0, 0, 100, 4, 6000, 9000, 9000, 12000, 11, 59007, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ghoul Tormentor - In Combat - Cast Flesh Rot');

-- Flesheating Ghoul (27871, 31346)
REPLACE INTO creature_template_addon VALUES (27871, 0, 0, 0, 4097, 418, '');
REPLACE INTO creature_template_addon VALUES (31346, 0, 0, 0, 4097, 418, '');
UPDATE creature_template SET baseattacktime=2000, lootid=27871, pickpocketloot=26621, AIName='SmartAI', ScriptName='' WHERE entry=27871;
UPDATE creature_template SET baseattacktime=2000, lootid=27871, pickpocketloot=26621, AIName='', ScriptName='' WHERE entry=31346;
DELETE FROM smart_scripts WHERE entryorguid=27871 AND source_type=0;
INSERT INTO smart_scripts VALUES (27871, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 5000, 5000, 11, 46202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Flesheating Ghoul - In Combat - Cast Pierce Armor');
INSERT INTO smart_scripts VALUES (27871, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 50933, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flesheating Ghoul - Between Health 0-30% - Cast Frenzy');

-- Wretched Belcher (26624, 31363)
REPLACE INTO creature_template_addon VALUES (26624, 0, 0, 0, 4097, 0, '16345');
REPLACE INTO creature_template_addon VALUES (31363, 0, 0, 0, 4097, 0, '16345');
UPDATE creature_template SET baseattacktime=2000, lootid=26624, pickpocketloot=26624, questItem1=42108, AIName='SmartAI', ScriptName='' WHERE entry=26624;
UPDATE creature_template SET baseattacktime=2000, lootid=26624, pickpocketloot=26624, AIName='', ScriptName='' WHERE entry=31363;
DELETE FROM smart_scripts WHERE entryorguid=26624 AND source_type=0;
INSERT INTO smart_scripts VALUES (26624, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 6000, 9000, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Belcher - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (26624, 0, 1, 0, 0, 0, 100, 2, 5000, 10000, 10000, 15000, 11, 49703, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Belcher - In Combat - Cast Bile Vomit');
INSERT INTO smart_scripts VALUES (26624, 0, 2, 0, 0, 0, 100, 4, 5000, 10000, 10000, 15000, 11, 59018, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wretched Belcher - In Combat - Cast Bile Vomit');

-- World Trigger (22515)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=22515; 

-- Darkweb Victim (27909)
UPDATE creature_template SET unit_flags=262144|131072|4, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=27909;
DELETE FROM smart_scripts WHERE entryorguid=27909 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=-127420 AND source_type=0;
INSERT INTO smart_scripts VALUES (27909, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 49960, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Victim - On Death - Cast Summon Random Drakkari');
INSERT INTO smart_scripts VALUES (-127420, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 49952, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Victim - On Death - Cast Summon Kurzel');

-- SPELL Summon Random Drakkari (49960)
DELETE FROM spell_script_names WHERE spell_id IN(49960);
INSERT INTO spell_script_names VALUES(49960, 'spell_dtk_summon_random_drakkari');

-- Darkweb Recluse (26625, 31336)
UPDATE creature_template SET baseattacktime=2000, lootid=26625, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=26625;
UPDATE creature_template SET baseattacktime=2000, lootid=26625, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=31336;
DELETE FROM smart_scripts WHERE entryorguid=26625 AND source_type=0;
INSERT INTO smart_scripts VALUES (26625, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 11000, 11, 49708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - In Combat - Cast Poison Spit');
INSERT INTO smart_scripts VALUES (26625, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 6000, 9000, 11, 49704, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - In Combat - Cast Encasing Webs');
INSERT INTO smart_scripts VALUES (26625, 0, 2, 0, 2, 0, 100, 1, 0, 30, 0, 0, 86, 48870, 2, 19, 26675, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Recluse - Between Health 0-30% - Cross Cast Summon Draknid Spiders Trigger');

-- Spider Summon Target (26675)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=26675;

-- Darkweb Hathcling (26674, 31335)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26674);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=26674);
DELETE FROM creature WHERE id=26674;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=26674;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=31335;
DELETE FROM smart_scripts WHERE entryorguid=26674 AND source_type=0;
INSERT INTO smart_scripts VALUES (26674, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkweb Hathcling - Is Summoned By - Set In Combat With Zone');

-- Drak Tharon Cocoon Bunny (27910)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=27910 AND map=600);
DELETE FROM creature WHERE id=27910 AND map=600;

-- Cosmetic Drakkari Bat [PH] (27490)
DELETE FROM creature_template_addon WHERE entry=27490;
UPDATE creature_template SET unit_flags=33554432, InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=27490;

-- Drakkari Bat (26622, 31337)
UPDATE creature_template SET baseattacktime=2000, lootid=26622, skinloot=70212, AIName='', ScriptName='' WHERE entry=26622;
UPDATE creature_template SET baseattacktime=2000, lootid=26622, skinloot=70212, AIName='', ScriptName='' WHERE entry=31337;
DELETE FROM smart_scripts WHERE entryorguid=26622 AND source_type=0;

-- Risen Drakkari Bat Rider (26638, 31351)
UPDATE creature SET spawndist=12, MovementType=1, unit_flags=2|256|512|33554432 WHERE guid IN(127445, 127446, 127447) AND id=26638;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26638);
REPLACE INTO creature_template_addon VALUES(26638, 0, 26751, 0, 1, 0, "");
REPLACE INTO creature_template_addon VALUES(31351, 0, 26751, 0, 1, 0, "");
UPDATE creature_template SET baseattacktime=2000, lootid=26638, pickpocketloot=0, type_flags=0, InhabitType=5, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=26638;
UPDATE creature_template SET baseattacktime=2000, lootid=26638, pickpocketloot=0, type_flags=0, InhabitType=5, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31351;
DELETE FROM smart_scripts WHERE entryorguid=26638 AND source_type=0;
INSERT INTO smart_scripts VALUES (26638, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 12000, 11, 16001, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Bat Rider - In Combat - Cast Impale');
INSERT INTO smart_scripts VALUES (26638, 0, 1, 0, 0, 0, 100, 2, 3000, 6000, 8000, 12000, 11, 50414, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Bat Rider - In Combat - Cast Curse of Blood');
INSERT INTO smart_scripts VALUES (26638, 0, 2, 0, 0, 0, 100, 4, 3000, 6000, 8000, 12000, 11, 59009, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Bat Rider - In Combat - Cast Curse of Blood');

-- Risen Drakkari Handler (26637, 31342)
UPDATE creature SET spawndist=0, MovementType=2 WHERE guid IN(127442, 127444) AND id=26637;
REPLACE INTO creature_addon VALUES(127442, 1274420, 6469, 0, 1, 0, '');
REPLACE INTO creature_addon VALUES(127443, 0, 6469, 0, 1, 0, '');
REPLACE INTO creature_addon VALUES(127444, 1274440, 6469, 0, 1, 0, '');
DELETE FROM creature_template_addon WHERE entry IN(26637, 31342);
UPDATE creature_template SET baseattacktime=2000, lootid=26637, pickpocketloot=26637, mechanic_immune_mask=8388624, AIName='SmartAI', ScriptName='' WHERE entry=26637;
UPDATE creature_template SET baseattacktime=2000, lootid=26637, pickpocketloot=26637, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31342;
DELETE FROM smart_scripts WHERE entryorguid=26637 AND source_type=0;
INSERT INTO smart_scripts VALUES (26637, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 11, 49712, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Handler - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (26637, 0, 1, 0, 9, 0, 100, 0, 0, 5, 8000, 12000, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Handler - Within Range 0-5yd - Cast Backhand');
INSERT INTO smart_scripts VALUES (26637, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 8000, 12000, 11, 49711, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Handler - In Combat - Cast Hooked Net');
INSERT INTO smart_scripts VALUES (26637, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 51224, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Handler - On Aggro - Cast Summon Raptor');

-- Drakkari Raptor Mount (26824, 31341)
DELETE FROM creature_loot_template WHERE entry=31341;
UPDATE creature_template SET minlevel=75, maxlevel=75, baseattacktime=2000, lootid=26824, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=26824;
UPDATE creature_template SET baseattacktime=2000, lootid=26824, pickpocketloot=0, skinloot=70205, mechanic_immune_mask=8388624, AIName='', ScriptName='' WHERE entry=31341;
DELETE FROM smart_scripts WHERE entryorguid=26824 AND source_type=0;

-- Risen Drakkari Death Knight (26830, 31352)
UPDATE creature_template SET baseattacktime=2000, lootid=26830, pickpocketloot=27533, AIName='SmartAI', ScriptName='' WHERE entry=26830;
UPDATE creature_template SET baseattacktime=2000, lootid=26830, pickpocketloot=27533, AIName='', ScriptName='' WHERE entry=31352;
DELETE FROM smart_scripts WHERE entryorguid=26830 AND source_type=0;
INSERT INTO smart_scripts VALUES (26830, 0, 1, 0, 0, 0, 100, 2, 0, 3000, 6000, 9000, 11, 49723, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Death Knight - In Combat - Cast Icy Touch');
INSERT INTO smart_scripts VALUES (26830, 0, 2, 0, 0, 0, 100, 4, 0, 3000, 6000, 9000, 11, 59011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Death Knight - In Combat - Cast Icy Touch');
INSERT INTO smart_scripts VALUES (26830, 0, 3, 0, 0, 0, 75, 2, 9000, 12000, 7000, 13500, 11, 49721, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Death Knight - In Combat - Cast Deafening Roar');
INSERT INTO smart_scripts VALUES (26830, 0, 4, 0, 0, 0, 75, 4, 9000, 12000, 7000, 13500, 11, 59010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Death Knight - In Combat - Cast Deafening Roar');
INSERT INTO smart_scripts VALUES (26830, 0, 5, 0, 0, 0, 100, 0, 4000, 8000, 8000, 12000, 11, 51240, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Risen Drakkari Death Knight - In Combat - Cast Fear');

-- Drakuru's Bunny 05 (28015)
DELETE FROM creature_addon WHERE guid IN( SELECT guid FROM creature WHERE id=28015 AND `map`=600 );
DELETE FROM creature WHERE id=28015 AND `map`=600;


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------

-- Trollgore (26630, 31362)
UPDATE creature SET position_x=-266.176, position_y=-660.147, position_z=26.511, orientation=0.0, spawndist=0, MovementType=0 WHERE id=26630;
DELETE FROM creature_text WHERE entry=26630;
INSERT INTO creature_text VALUES (26630, 0, 0, 'More grunts, more glands, more FOOD!', 14, 0, 100, 0, 0, 13181, 0, 'trollgore SAY_AGGRO');
INSERT INTO creature_text VALUES (26630, 1, 0, 'You have gone, me gonna eat you!', 14, 0, 100, 0, 0, 13185, 0, 'trollgore SAY_KILL');
INSERT INTO creature_text VALUES (26630, 2, 0, 'So hungry! Must feed!', 14, 0, 100, 0, 0, 13182, 0, 'trollgore SAY_CONSUME');
INSERT INTO creature_text VALUES (26630, 3, 0, 'Corpse go boom!', 14, 0, 100, 0, 0, 13184, 0, 'trollgore SAY_EXPLODE');
INSERT INTO creature_text VALUES (26630, 4, 0, 'Aaaargh...', 14, 0, 100, 0, 0, 13183, 0, 'trollgore SAY_DEATH');
UPDATE creature_template SET baseattacktime=1000, lootid=26630, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_trollgore' WHERE entry=26630;
UPDATE creature_template SET baseattacktime=1000, lootid=31362, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31362;

-- Drakkari Invader (27709, 27753, 27754)
DELETE FROM creature_loot_template WHERE entry IN(27709, 27753, 27754);
REPLACE INTO creature_template_addon VALUES(27709, 0, 26751, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(27753, 0, 26751, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES(27754, 0, 26751, 0, 1, 0, '');
DELETE FROM linked_respawn  WHERE guid IN(SELECT guid FROM creature WHERE id IN(27709, 27753, 27754, 27724));
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(27709, 27753, 27754, 27724));
DELETE FROM creature WHERE id IN(27709, 27753, 27754, 27724);
UPDATE creature_template SET faction=1814, unit_flags=768, lootid=0, InhabitType=5, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry IN(27709, 27753, 27754);
DELETE FROM smart_scripts WHERE entryorguid IN(27709, 27753, 27754) AND source_type=0;
INSERT INTO smart_scripts VALUES (27709, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -250, -672.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Pos');
INSERT INTO smart_scripts VALUES (27709, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Dismount');
INSERT INTO smart_scripts VALUES (27709, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (27709, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Cast Invader Taunt Trigger');
INSERT INTO smart_scripts VALUES (27753, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -254, -665.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Pos');
INSERT INTO smart_scripts VALUES (27753, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Dismount');
INSERT INTO smart_scripts VALUES (27753, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (27753, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Cast Invader Taunt Trigger');
INSERT INTO smart_scripts VALUES (27754, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -250, -658.92, 26.54, 0, 'Drakkari Invader - On Update - Move To Pos');
INSERT INTO smart_scripts VALUES (27754, 0, 1, 2, 34, 0, 100, 0, 8, 1, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Dismount');
INSERT INTO smart_scripts VALUES (27754, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (27754, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 49405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Invader - Movement Inform - Cast Invader Taunt Trigger');

-- SPELL Summon Invader A/B/C (49456, 49457, 49458)
DELETE FROM spell_target_position WHERE id IN(49456, 49457, 49458);
INSERT INTO spell_target_position VALUES (49456, 0, 600, -227.558, -672.92, 43, 3.14);
INSERT INTO spell_target_position VALUES (49457, 0, 600, -227.558, -665.92, 43, 3.14);
INSERT INTO spell_target_position VALUES (49458, 0, 600, -227.558, -658.92, 43, 3.14);

-- SPELL Invader Taunt Trigger (49405)
DELETE FROM conditions WHERE SourceEntry IN(49405) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 49405, 0, 0, 31, 0, 3, 26630, 0, 0, 0, 0, '', 'Target Trollgore');
DELETE FROM spell_script_names WHERE spell_id IN(49405);
INSERT INTO spell_script_names VALUES(49405, 'spell_trollgore_invader_taunt');

-- SPELL Consume (49380, 59803)
DELETE FROM spell_script_names WHERE spell_id IN(49380, 59803);
INSERT INTO spell_script_names VALUES(49380, 'spell_trollgore_consume');
INSERT INTO spell_script_names VALUES(59803, 'spell_trollgore_consume');

-- Corpse Explode (49555, 59807)
DELETE FROM conditions WHERE SourceEntry IN(49555, 59807) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 49555, 0, 0, 31, 0, 3, 27709, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 49555, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
INSERT INTO conditions VALUES(13, 1, 49555, 0, 1, 31, 0, 3, 27753, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 49555, 0, 1, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
INSERT INTO conditions VALUES(13, 1, 49555, 0, 2, 31, 0, 3, 27754, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 49555, 0, 2, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 0, 31, 0, 3, 27709, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 1, 31, 0, 3, 27753, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 1, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 2, 31, 0, 3, 27754, 0, 0, 0, 0, '', 'Target Drakkari Invader');
INSERT INTO conditions VALUES(13, 1, 59807, 0, 2, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Invader Dead');
DELETE FROM spell_script_names WHERE spell_id IN(49555, 59807);
INSERT INTO spell_script_names VALUES(49555, 'spell_trollgore_corpse_explode');
INSERT INTO spell_script_names VALUES(59807, 'spell_trollgore_corpse_explode');

-- Novos the Summoner (26631, 31350)
DELETE FROM creature_text WHERE entry=26631;
INSERT INTO creature_text VALUES (26631, 0, 0, 'The chill that you feel is the herald of your doom!', 14, 0, 100, 0, 0, 13173, 0, 'novos SAY_AGGRO');
INSERT INTO creature_text VALUES (26631, 1, 0, 'Such is the fate of all who oppose the Lich King.', 14, 0, 100, 0, 0, 13175, 0, 'novos SAY_KILL');
INSERT INTO creature_text VALUES (26631, 2, 0, 'Your efforts... are in vain.', 14, 0, 100, 0, 0, 13174, 0, 'novos SAY_DEATH');
INSERT INTO creature_text VALUES (26631, 3, 0, 'Bolster my defenses! Hurry, curse you!', 14, 0, 100, 0, 0, 13176, 0, 'novos SAY_NECRO_ADD');
INSERT INTO creature_text VALUES (26631, 4, 0, 'Surely you can see the futility of it all!', 14, 0, 100, 0, 0, 13177, 0, 'novos SAY_REUBBLE_1');
INSERT INTO creature_text VALUES (26631, 4, 1, 'Just give up and die already!', 14, 0, 100, 0, 0, 13178, 0, 'novos SAY_REUBBLE_2');
INSERT INTO creature_text VALUES (26631, 5, 0, '%s calls for assistance!', 41, 0, 100, 0, 0, 0, 0, 'Novos the Summoner - EMOTE_SUMMONING_ADDS');
UPDATE creature_template SET lootid=26631, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_novos' WHERE entry=26631;
UPDATE creature_template SET lootid=31350, pickpocketloot=0, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31350;

-- Crystal Channel Target (26712)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26712 AND map=600);
DELETE FROM creature WHERE id=26712 AND map=600;
INSERT INTO creature VALUES(127498, 26712, 600, 3, 3, 17188, 0, -365.477, -724.849, 32.3213, 3.92699, 3600, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(127499, 26712, 600, 3, 5, 17188, 0, -365.368, -751.128, 32.3213, 2.35619, 3600, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(127500, 26712, 600, 3, 9, 17188, 0, -392.123, -750.941, 32.3213, 0.680678, 3600, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(127501, 26712, 600, 3, 17, 17188, 0, -392.455, -724.809, 32.3213, 5.35816, 3600, 0, 0, 8982, 0, 0, 0, 0, 0);
UPDATE creature_template SET modelid1=17188, modelid2=17188, InhabitType=4, flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=26712;

-- Crystal Handler (26627, 31336)
DELETE FROM creature_loot_template WHERE entry IN(26627, 31336);
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=26627;
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=31336;
DELETE FROM smart_scripts WHERE entryorguid=26627 AND source_type=0;
INSERT INTO smart_scripts VALUES (26627, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 4000, 6000, 11, 49668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal Handler - In Combat - Cast Flash of Darkness');
INSERT INTO smart_scripts VALUES (26627, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 4000, 6000, 11, 59004, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crystal Handler - In Combat - Cast Flash of Darkness');
INSERT INTO smart_scripts VALUES (26627, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 47336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Crystal Handler - On Death - Cast Crystal Handler Death');

-- Fetid Troll Corpse (27598, 31873)
DELETE FROM creature_loot_template WHERE entry IN(27598, 31873);
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=27598;
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=31873;
DELETE FROM smart_scripts WHERE entryorguid=27598 AND source_type=0;
INSERT INTO smart_scripts VALUES (27598, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fetid Troll Corpse - On Death - Despawn');
INSERT INTO smart_scripts VALUES (27598, 0, 3, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -373.56, -770.86, 28.59, 0, 'Fetid Troll Corpse - On Update - Move Point');
INSERT INTO smart_scripts VALUES (27598, 0, 4, 5, 34, 0, 100, 0, 8, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fetid Troll Corpse - Movement Inform - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (27598, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26631, 1, 0, 0, 0, 0, 10, 127424, 26631, 0, 0, 0, 0, 0, 'Fetid Troll Corpse - Movement Inform - Set Data');

-- Risen Shadowcaster (27600, 31356)
DELETE FROM creature_loot_template WHERE entry IN(27600, 31356);
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=27600;
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=31356;
DELETE FROM smart_scripts WHERE entryorguid=27600 AND source_type=0;
INSERT INTO smart_scripts VALUES (27600, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 4000, 6000, 11, 51363, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (27600, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 4000, 6000, 11, 59016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (27600, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - On Death - Despawn');
INSERT INTO smart_scripts VALUES (27600, 0, 3, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -384.0, -770.86, 28.59, 0, 'Risen Shadowcaster - On Update - Move Point');
INSERT INTO smart_scripts VALUES (27600, 0, 4, 5, 34, 0, 100, 0, 8, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - Movement Inform - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (27600, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26631, 1, 0, 0, 0, 0, 10, 127424, 26631, 0, 0, 0, 0, 0, 'Risen Shadowcaster - Movement Inform - Set Data');

-- Hulking Corpse (27597, 31348)
DELETE FROM creature_loot_template WHERE entry IN(27597, 31348);
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='SmartAI', ScriptName='' WHERE entry=27597;
UPDATE creature_template SET baseattacktime=2000, lootid=0, pickpocketloot=0, AIName='', ScriptName='' WHERE entry=31348;
DELETE FROM smart_scripts WHERE entryorguid=27597 AND source_type=0;
INSERT INTO smart_scripts VALUES (27597, 0, 0, 0, 0, 0, 100, 2, 3000, 6000, 4000, 6000, 11, 51363, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (27597, 0, 1, 0, 0, 0, 100, 4, 3000, 6000, 4000, 6000, 11, 59016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (27597, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Risen Shadowcaster - On Death - Despawn');
INSERT INTO smart_scripts VALUES (27597, 0, 3, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, -379.31, -770.86, 28.59, 0, 'Hulking Corpse - On Update - Move Point');
INSERT INTO smart_scripts VALUES (27597, 0, 4, 5, 34, 0, 100, 0, 8, 1, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hulking Corpse - Movement Inform - Set In Combat With Zone');
INSERT INTO smart_scripts VALUES (27597, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 26631, 1, 0, 0, 0, 0, 10, 127424, 26631, 0, 0, 0, 0, 0, 'Hulking Corpse - Movement Inform - Set Data');

-- SPELL Beam Channel (52106)
DELETE FROM conditions WHERE SourceEntry IN(52106) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 52106, 0, 0, 31, 0, 3, 26631, 0, 0, 0, 0, '', 'Target Novos the Summoner');

-- SPELL Despawn Crystal Handler (51403)
DELETE FROM conditions WHERE SourceEntry IN(51403) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 51403, 0, 0, 31, 0, 3, 26712, 0, 0, 0, 0, '', 'Target Crystal Channel Target');
DELETE FROM spell_script_names WHERE spell_id IN(51403);
INSERT INTO spell_script_names VALUES(51403, 'spell_novos_despawn_crystal_handler');

-- SPELL Crystal Handler Death (47336, 55801, 55803, 55805)
DELETE FROM conditions WHERE SourceEntry IN(47336, 55801, 55803, 55805) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 47336, 0, 0, 31, 0, 3, 26712, 0, 0, 0, 0, '', 'Target Crystal Channel Target');
INSERT INTO conditions VALUES(13, 1, 47336, 0, 0, 21, 0, 32768, 0, 0, 0, 0, 0, '', 'Target HasUnitState');
DELETE FROM spell_script_names WHERE spell_id IN(47336);
INSERT INTO spell_script_names VALUES(47336, 'spell_novos_crystal_handler_death');

-- SPELL Summon Minions (59910)
DELETE FROM spell_script_names WHERE spell_id IN(59910);
INSERT INTO spell_script_names VALUES(59910, 'spell_novos_summon_minions');

-- King Dred (27483, 31349)
DELETE FROM creature_text WHERE entry=27483;
INSERT INTO creature_text VALUES (27483, 0, 0, '%s raises his claws menacingly!', 41, 0, 100, 0, 0, 0, 0, 'King Dred');
UPDATE creature_template SET lootid=27483, pickpocketloot=0, skinloot=70213, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_dred' WHERE entry=27483;
UPDATE creature_template SET lootid=31349, pickpocketloot=0, skinloot=70213, dmg_multiplier=21, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31349;

-- Drakkari Gutripper (26641, 31340)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26641);
UPDATE creature_template SET baseattacktime=2000, lootid=26641, pickpocketloot=0, skinloot=70212, AIName='SmartAI', ScriptName='' WHERE entry=26641;
UPDATE creature_template SET baseattacktime=2000, lootid=26641, pickpocketloot=0, skinloot=70212, AIName='', ScriptName='' WHERE entry=31340;
DELETE FROM smart_scripts WHERE entryorguid=26641 AND source_type=0;
INSERT INTO smart_scripts VALUES (26641, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 12000, 11, 49710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Gutripper - In Combat - Cast Gut Rip');
INSERT INTO smart_scripts VALUES (26641, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 27483, 0, 0, 0, 0, 0, 10, 127507, 27483, 0, 0, 0, 0, 0, 'Drakkari Gutripper - On Death - Set Data');

-- Drakkari Scytheclaw (26628, 31343)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=26628);
UPDATE creature_template SET baseattacktime=2000, lootid=26628, pickpocketloot=0, skinloot=70212, AIName='SmartAI', ScriptName='' WHERE entry=26628;
UPDATE creature_template SET baseattacktime=2000, lootid=26628, pickpocketloot=0, skinloot=70212, AIName='', ScriptName='' WHERE entry=31343;
DELETE FROM smart_scripts WHERE entryorguid=26628 AND source_type=0;
INSERT INTO smart_scripts VALUES (26628, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 12000, 11, 13738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Scytheclaw - In Combat - Cast Rend');
INSERT INTO smart_scripts VALUES (26628, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 27483, 0, 0, 0, 0, 0, 10, 127507, 27483, 0, 0, 0, 0, 0, 'Drakkari Scytheclaw - On Death - Set Data');

-- SPELL Grievious Bite (48920)
DELETE FROM spell_script_names WHERE spell_id IN(48920, -48920);
DELETE FROM spell_scripts WHERE id IN(48920, -48920);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(48920, -48920) OR spell_effect IN(48920, -48920);
INSERT INTO spell_script_names VALUES(48920, 'spell_dred_grievious_bite');

-- SPELL Raptor Call (59416)
DELETE FROM spell_script_names WHERE spell_id IN(59416);
INSERT INTO spell_script_names VALUES(59416, 'spell_dred_raptor_call');

-- The Prophet Tharon'ja (26632, 31360)
DELETE FROM creature_text WHERE entry=26632;
INSERT INTO creature_text VALUES (26632, 0, 0, 'Tharon''ja sees all! The work of mortals shall not end the eternal dynasty!', 14, 0, 100, 0, 0, 13862, 0, 'tharon ja SAY_AGGRO');
INSERT INTO creature_text VALUES (26632, 1, 0, 'As Tharon''ja predicted.', 14, 0, 100, 0, 0, 13863, 0, 'tharon ja SAY_KILL_1');
INSERT INTO creature_text VALUES (26632, 1, 1, 'As it was written.', 14, 0, 100, 0, 0, 13864, 0, 'tharon ja SAY_KILL_2');
INSERT INTO creature_text VALUES (26632, 2, 0, 'Your flesh serves Tharon''ja now!', 14, 0, 100, 0, 0, 13865, 0, 'tharon ja SAY_FLESH_1');
INSERT INTO creature_text VALUES (26632, 2, 1, 'Tharon''ja has a use for your mortal shell!', 14, 0, 100, 0, 0, 13866, 0, 'tharon ja SAY_FLESH_2');
INSERT INTO creature_text VALUES (26632, 3, 0, 'No! A taste... all too brief!', 14, 0, 100, 0, 0, 13867, 0, 'tharon ja SAY_SKELETON_1');
INSERT INTO creature_text VALUES (26632, 3, 1, 'Tharon''ja will have more!', 14, 0, 100, 0, 0, 13868, 0, 'tharon ja SAY_SKELETON_2');
INSERT INTO creature_text VALUES (26632, 4, 0, 'I''m... impossible! Tharon''ja is eternal! Tharon''ja... is...', 14, 0, 100, 0, 0, 13869, 0, 'tharon ja SAY_DEATH');
UPDATE creature_template SET lootid=26632, pickpocketloot=0, skinloot=0, dmg_multiplier=13, mechanic_immune_mask=650854271, flags_extra=0x200000, AIName='', ScriptName='boss_tharon_ja' WHERE entry=26632;
UPDATE creature_template SET lootid=31360, pickpocketloot=0, skinloot=0, dmg_multiplier=21, mechanic_immune_mask=650854271, flags_extra=1|0x200000, AIName='', ScriptName='' WHERE entry=31360;
DELETE FROM creature_loot_template WHERE entry=31360 AND item=43102;
INSERT INTO creature_loot_template VALUES(31360, 43102, 100, 1, 0, 1, 1);

-- SPELL Curse of Life (49527, 59972)
DELETE FROM spell_script_names WHERE spell_id IN(49527, 59972);
INSERT INTO spell_script_names VALUES(49527, 'spell_tharon_ja_curse_of_life');
INSERT INTO spell_script_names VALUES(59972, 'spell_tharon_ja_curse_of_life');

-- SPELL Dummy (49551)
DELETE FROM spell_script_names WHERE spell_id IN(49551);
INSERT INTO spell_script_names VALUES(49551, 'spell_tharon_ja_dummy');

-- SPELL Clear Gift of Tharon'ja (53242)
DELETE FROM conditions WHERE SourceEntry IN(53242) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 53242, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target Players');
DELETE FROM spell_script_names WHERE spell_id IN(53242);
INSERT INTO spell_script_names VALUES(53242, 'spell_tharon_ja_clear_gift_of_tharon_ja');





-- -------------------------------------------
--                MISC
-- -------------------------------------------

-- Scourge Reanimator (26626, 31359), starting scene
DELETE FROM creature_addon WHERE guid IN(127596, 127436, 127437);
REPLACE INTO creature VALUES (127596, 26626, 600, 3, 1, 0, 1, -515.853, -603.945, 1.025, 2.451, 86400, 0, 0, 41128, 3466, 0, 0, 2, 0);
REPLACE INTO creature VALUES (127436, 26620, 600, 3, 1, 0, 1, -523.138, -594.80, 1.05, 2.33, 86400, 0, 0, 44004, 0, 0, 0, 256+512, 0);
REPLACE INTO creature VALUES (127437, 26620, 600, 3, 1, 0, 1, -528.330, -600.26, 1.59, 2.33, 86400, 0, 0, 44004, 0, 0, 0, 256+512, 0);
DELETE FROM smart_scripts WHERE entryorguid=-127596 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2662600 AND source_type=9;
INSERT INTO smart_scripts VALUES (-127596, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - On AI Init - Set React State');
INSERT INTO smart_scripts VALUES (-127596, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 80, 2662600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - On Update - Script9');
INSERT INTO smart_scripts VALUES (2662600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 47503, 2, 10, 127436, 26620, 0, 10, 127436, 26620, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cross Cast Siphon Life Visual');
INSERT INTO smart_scripts VALUES (2662600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 47503, 2, 10, 127437, 26620, 0, 10, 127437, 26620, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cross Cast Siphon Life Visual');
INSERT INTO smart_scripts VALUES (2662600, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Talk');
INSERT INTO smart_scripts VALUES (2662600, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -532.08, -591.85, 2.50, 0, 'Scourge Reanimator - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (2662600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127436, 26620, 0, -537.57, -580.86, 1.17, 0, 'Scourge Reanimator - Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (2662600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127437, 26620, 0, -543.37, -581.11, 1.03, 0, 'Scourge Reanimator - Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (2662600, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 86, 45254, 2, 10, 127436, 26620, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cross Cast Suicide');
INSERT INTO smart_scripts VALUES (2662600, 9, 7, 0, 0, 0, 100, 0, 500, 500, 0, 0, 86, 45254, 2, 10, 127437, 26620, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cross Cast Suicide');
INSERT INTO smart_scripts VALUES (2662600, 9, 8, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Talk');
INSERT INTO smart_scripts VALUES (2662600, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 48597, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (2662600, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 11, 48605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cast Raise Dead');
INSERT INTO smart_scripts VALUES (2662600, 9, 11, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Talk');
INSERT INTO smart_scripts VALUES (2662600, 9, 12, 0, 0, 0, 100, 0, 500, 500, 0, 0, 11, 47506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Cast Teleport');
INSERT INTO smart_scripts VALUES (2662600, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - Script9 - Despawn');

-- SPELL Raise Dead (48597, 48605)
DELETE FROM conditions WHERE SourceEntry IN(48597, 48605) AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 48597, 0, 0, 31, 0, 3, 26620, 0, 0, 0, 0, '', 'Target Drakkari Guardian');
INSERT INTO conditions VALUES(13, 1, 48597, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Guardian Dead');
INSERT INTO conditions VALUES(13, 1, 48605, 0, 0, 31, 0, 3, 26620, 0, 0, 0, 0, '', 'Target Drakkari Guardian');
INSERT INTO conditions VALUES(13, 1, 48605, 0, 0, 36, 0, 0, 0, 0, 1, 0, 0, '', 'Target Drakkari Guardian Dead');
DELETE FROM spell_script_names WHERE spell_id IN(48597, 48605);
INSERT INTO spell_script_names VALUES(48597, 'spell_dtk_raise_dead');
INSERT INTO spell_script_names VALUES(48605, 'spell_dtk_raise_dead');

-- Second Stairs Event
REPLACE INTO creature_addon VALUES (127434, 0, 0, 0, 1, 333, '');
REPLACE INTO creature_addon VALUES (127425, 0, 0, 0, 1, 333, '');
REPLACE INTO creature_addon VALUES (127429, 0, 0, 0, 1, 333, '');
REPLACE INTO creature_addon VALUES (127439, 0, 0, 0, 1, 333, '');
DELETE FROM smart_scripts WHERE entryorguid=-127410 AND source_type=0;
INSERT INTO smart_scripts VALUES (-127410, 0, 0, 0, 0, 0, 100, 2, 2000, 5000, 6000, 8000, 11, 50378, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (-127410, 0, 1, 0, 0, 0, 100, 4, 2000, 5000, 6000, 8000, 11, 59017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (-127410, 0, 2, 0, 0, 0, 100, 0, 7000, 10000, 15000, 15000, 11, 50379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Cripple');
INSERT INTO smart_scripts VALUES (-127410, 0, 3, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 11, 49805, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast Unholy Frenzy');
INSERT INTO smart_scripts VALUES (-127410, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127426, 26635, 0, -314.83, -656.11, 10.38, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127435, 26635, 0, -322.44, -576.68, 11.01, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127434, 26635, 0, -359.19, -598.21, 2.48, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127425, 26635, 0, -363.97, -594.57, 2.26, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127429, 26635, 0, -362.56, -609.78, 2.47, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 130, 0, 0, 0, 0, 0, 0, 10, 127439, 26636, 0, -359.43, -604.93, 2.48, 0, 'Scourge Reanimator - Just Died - Move To Pos Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 127426, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Talk Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 127435, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Talk Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 10, 127426, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Despawn Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 10, 127426, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Set React State');
INSERT INTO smart_scripts VALUES (-127410, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 10, 127435, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Despawn Target');
INSERT INTO smart_scripts VALUES (-127410, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 10, 127435, 26635, 0, 0, 0, 0, 0, 'Scourge Reanimator - Just Died - Set React State');

-- Pathing / Formations before Dred
DELETE FROM creature_formations WHERE memberGUID IN(127444, 127456, 127457);
INSERT INTO creature_formations VALUES (127444, 127444, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (127444, 127456, 3, 90, 0, 0, 0);
INSERT INTO creature_formations VALUES (127444, 127457, 3, 270, 0, 0, 0);
DELETE FROM creature_formations WHERE memberGUID IN(127442, 127443);
INSERT INTO creature_formations VALUES (127442, 127442, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES (127442, 127443, 3, 90, 0, 0, 0);
DELETE FROM waypoint_data WHERE id=1274420;
INSERT INTO waypoint_data VALUES (1274420, 1, -506.882, -672.076, 30.2464, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (1274420, 2, -492.584, -718.797, 30.2465, 0, 0, 0, 0, 100, 0);


-- -------------------------------------------
--             ACHIEVEMENTS
-- -------------------------------------------

-- Drak'Tharon Keep (482)
DELETE FROM disables WHERE sourceType=4 AND entry IN(199,200,201,9098);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(199,200,201,9098);
INSERT INTO achievement_criteria_data VALUES(199, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(200, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(201, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(9098, 12, 0, 0, "");

-- Heroic: Drak'Tharon Keep (493)
DELETE FROM disables WHERE sourceType=4 AND entry IN(6813,6814,6815,9099);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(6813,6814,6815,9099);
INSERT INTO achievement_criteria_data VALUES(6813, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6814, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(6815, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(9099, 12, 1, 0, "");

-- Better Off Dred (2039)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7318);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7318);
INSERT INTO achievement_criteria_data VALUES(7318, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7318, 11, 0, 0, "achievement_better_off_dred");

-- Consumption Junction (2151)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7579);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7579);
INSERT INTO achievement_criteria_data VALUES(7579, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7579, 11, 0, 0, "achievement_consumption_junction");

-- Oh Novos! (2057)
DELETE FROM disables WHERE sourceType=4 AND entry IN(7361);
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7361);
INSERT INTO achievement_criteria_data VALUES(7361, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7361, 11, 0, 0, "achievement_oh_novos");


-- -------------------------------------------
--           SPELL DIFFICULTY
-- -------------------------------------------

-- Consume (49380, 59803)
DELETE FROM spelldifficulty_dbc WHERE id IN(49380, 59803) OR spellid0 IN(49380, 59803) OR spellid1 IN(49380, 59803) OR spellid2 IN(49380, 59803) OR spellid3 IN(49380, 59803);
INSERT INTO spelldifficulty_dbc VALUES (49380, 49380, 59803, 0, 0);

-- Consume (49381, 59805)
DELETE FROM spelldifficulty_dbc WHERE id IN(49381, 59805) OR spellid0 IN(49381, 59805) OR spellid1 IN(49381, 59805) OR spellid2 IN(49381, 59805) OR spellid3 IN(49381, 59805);
INSERT INTO spelldifficulty_dbc VALUES (49381, 49381, 59805, 0, 0);

-- Corpse Explode (49555, 59807)
DELETE FROM spelldifficulty_dbc WHERE id IN(49555, 59807) OR spellid0 IN(49555, 59807) OR spellid1 IN(49555, 59807) OR spellid2 IN(49555, 59807) OR spellid3 IN(49555, 59807);
INSERT INTO spelldifficulty_dbc VALUES (49555, 49555, 59807, 0, 0);

-- Corpse Explode (49618, 59809)
DELETE FROM spelldifficulty_dbc WHERE id IN(49618, 59809) OR spellid0 IN(49618, 59809) OR spellid1 IN(49618, 59809) OR spellid2 IN(49618, 59809) OR spellid3 IN(49618, 59809);
INSERT INTO spelldifficulty_dbc VALUES (49618, 49618, 59809, 0, 0);

-- Arcane Blast (49198, 59909)
DELETE FROM spelldifficulty_dbc WHERE id IN(49198, 59909) OR spellid0 IN(49198, 59909) OR spellid1 IN(49198, 59909) OR spellid2 IN(49198, 59909) OR spellid3 IN(49198, 59909);
INSERT INTO spelldifficulty_dbc VALUES (49198, 49198, 59909, 0, 0);

-- Blizzard (49034, 59854)
DELETE FROM spelldifficulty_dbc WHERE id IN(49034, 59854) OR spellid0 IN(49034, 59854) OR spellid1 IN(49034, 59854) OR spellid2 IN(49034, 59854) OR spellid3 IN(49034, 59854);
INSERT INTO spelldifficulty_dbc VALUES (49034, 49034, 59854, 0, 0);

-- Frostbolt (49037, 59855)
DELETE FROM spelldifficulty_dbc WHERE id IN(49037, 59855) OR spellid0 IN(49037, 59855) OR spellid1 IN(49037, 59855) OR spellid2 IN(49037, 59855) OR spellid3 IN(49037, 59855);
INSERT INTO spelldifficulty_dbc VALUES (49037, 49037, 59855, 0, 0);

-- Wrath of Misery (50089, 59856)
DELETE FROM spelldifficulty_dbc WHERE id IN(50089, 59856) OR spellid0 IN(50089, 59856) OR spellid1 IN(50089, 59856) OR spellid2 IN(50089, 59856) OR spellid3 IN(50089, 59856);
INSERT INTO spelldifficulty_dbc VALUES (50089, 50089, 59856, 0, 0);

-- Fearsome Roar (48849, 59422)
DELETE FROM spelldifficulty_dbc WHERE id IN(48849, 59422) OR spellid0 IN(48849, 59422) OR spellid1 IN(48849, 59422) OR spellid2 IN(48849, 59422) OR spellid3 IN(48849, 59422);
INSERT INTO spelldifficulty_dbc VALUES (48849, 48849, 59422, 0, 0);

-- Curse of Life (49527, 59972)
DELETE FROM spelldifficulty_dbc WHERE id IN(49527, 59972) OR spellid0 IN(49527, 59972) OR spellid1 IN(49527, 59972) OR spellid2 IN(49527, 59972) OR spellid3 IN(49527, 59972);
INSERT INTO spelldifficulty_dbc VALUES (49527, 49527, 59972, 0, 0);

-- Eye Beam (49544, 59965)
DELETE FROM spelldifficulty_dbc WHERE id IN(49544, 59965) OR spellid0 IN(49544, 59965) OR spellid1 IN(49544, 59965) OR spellid2 IN(49544, 59965) OR spellid3 IN(49544, 59965);
INSERT INTO spelldifficulty_dbc VALUES (49544, 49544, 59965, 0, 0);

-- Lightning Breath (49537, 59963)
DELETE FROM spelldifficulty_dbc WHERE id IN(49537, 59963) OR spellid0 IN(49537, 59963) OR spellid1 IN(49537, 59963) OR spellid2 IN(49537, 59963) OR spellid3 IN(49537, 59963);
INSERT INTO spelldifficulty_dbc VALUES (49537, 49537, 59963, 0, 0);

-- Poison Cloud (49548, 59969)
DELETE FROM spelldifficulty_dbc WHERE id IN(49548, 59969) OR spellid0 IN(49548, 59969) OR spellid1 IN(49548, 59969) OR spellid2 IN(49548, 59969) OR spellid3 IN(49548, 59969);
INSERT INTO spelldifficulty_dbc VALUES (49548, 49548, 59969, 0, 0);

-- Rain of Fire (49518, 59971)
DELETE FROM spelldifficulty_dbc WHERE id IN(49518, 59971) OR spellid0 IN(49518, 59971) OR spellid1 IN(49518, 59971) OR spellid2 IN(49518, 59971) OR spellid3 IN(49518, 59971);
INSERT INTO spelldifficulty_dbc VALUES (49518, 49518, 59971, 0, 0);

-- Shadow Volley (49528, 59973)
DELETE FROM spelldifficulty_dbc WHERE id IN(49528, 59973) OR spellid0 IN(49528, 59973) OR spellid1 IN(49528, 59973) OR spellid2 IN(49528, 59973) OR spellid3 IN(49528, 59973);
INSERT INTO spelldifficulty_dbc VALUES (49528, 49528, 59973, 0, 0);

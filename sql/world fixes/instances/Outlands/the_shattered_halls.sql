
UPDATE creature SET spawntimesecs=86400 WHERE map=540 AND spawntimesecs>0;

-- -------------------------------------------
--               FORMATIONS
-- -------------------------------------------


-- -------------------------------------------
--                TRASH
-- -------------------------------------------
-- Shattered Hand Heathen (17420, 20587)
DELETE FROM creature_text WHERE entry=17420;
INSERT INTO creature_text VALUES (17420, 0, 0, "%s becomes enraged!", 16, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
INSERT INTO creature_text VALUES (17420, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Heathen');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17420;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20587;
DELETE FROM smart_scripts WHERE entryorguid=17420 AND source_type=0;
INSERT INTO smart_scripts VALUES (17420, 0, 0, 0, 0, 0, 100, 2, 3500, 3500, 7000, 14000, 11, 30474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Heathen - In Combat - Cast 'Bloodthirst'");
INSERT INTO smart_scripts VALUES (17420, 0, 1, 0, 0, 0, 100, 4, 3500, 3500, 7000, 14000, 11, 35949, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Heathen - In Combat - Cast 'Bloodthirst'");
INSERT INTO smart_scripts VALUES (17420, 0, 2, 3, 2, 0, 100, 7, 0, 30, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Heathen - Between 0-30% Health - Cast 'Enrage'");
INSERT INTO smart_scripts VALUES (17420, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Heathen - Between 0-30% Health - Say Line 0");
INSERT INTO smart_scripts VALUES (17420, 0, 4, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Heathen - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (17420, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shattered Hand Heathen - On Death - Set Data");

-- Shattered Hand Reaver (16699, 20590)
DELETE FROM creature_text WHERE entry=16699;
INSERT INTO creature_text VALUES (16699, 0, 0, "%s becomes enraged!", 16, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
INSERT INTO creature_text VALUES (16699, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Reaver');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=16699;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20590;
DELETE FROM smart_scripts WHERE entryorguid=16699 AND source_type=0;
INSERT INTO smart_scripts VALUES (16699, 0, 0, 0, 0, 0, 100, 6, 1500, 1500, 5500, 11500, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - In Combat - Cast 'Cleave'");
INSERT INTO smart_scripts VALUES (16699, 0, 1, 0, 0, 0, 100, 6, 1500, 1500, 5500, 11500, 13, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - In Combat - Set Single Threat 100-0");
INSERT INTO smart_scripts VALUES (16699, 0, 2, 0, 0, 0, 100, 6, 500, 500, 6500, 6500, 11, 30471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - In Combat - Cast 'Uppercut'");
INSERT INTO smart_scripts VALUES (16699, 0, 3, 4, 2, 0, 100, 7, 0, 25, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - Between 0-25% Health - Cast 'Enrage'");
INSERT INTO smart_scripts VALUES (16699, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - Between 0-25% Health - Say Line 0");
INSERT INTO smart_scripts VALUES (16699, 0, 5, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Reaver - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (16699, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shattered Hand Reaver - On Death - Set Data");

-- Shattered Hand Legionnaire (16700, 20589)
DELETE FROM creature_text WHERE entry=16700;
INSERT INTO creature_text VALUES (16700, 0, 0, "%s becomes enraged!", 16, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 1, 0, "Show them no quarter! Form up!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 1, 1, "Get ready! This shouldn't take long...", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 1, 2, "Form up! Let's make quick work of them!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 1, 3, "Form ranks and make the intruders pay!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 1, 4, "Line up, and crush these fools!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 0, "Join the fight! Agrama-ka!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 1, "Next warrior, now!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 2, "Next warrior, step up!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 3, "Fighter down!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 4, "Where's my support?", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 5, "Replacement, quickly!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 6, "Look Alive!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 7, "Engage the enemy!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
INSERT INTO creature_text VALUES (16700, 2, 8, "Attack!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Legionnaire');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=16700;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20589;
DELETE FROM smart_scripts WHERE entryorguid=16700 AND source_type=0;
INSERT INTO smart_scripts VALUES (16700, 0, 0, 0, 0, 0, 100, 6, 1500, 5000, 240000, 240000, 11, 30472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - In Combat - Cast 'Aura of Discipline'");
INSERT INTO smart_scripts VALUES (16700, 0, 2, 0, 13, 0, 100, 6, 10000, 10000, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - On Victim Cast - Cast 'Pummel'");
INSERT INTO smart_scripts VALUES (16700, 0, 3, 4, 2, 0, 100, 7, 0, 25, 0, 0, 11, 30485, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - Between 0-25% Health - Cast 'Enrage'");
INSERT INTO smart_scripts VALUES (16700, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - Between 0-25% Health - Say Line 0");
INSERT INTO smart_scripts VALUES (16700, 0, 5, 0, 4, 0, 100, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (16700, 0, 6, 7, 38, 0, 100, 0, 5, 5, 0, 0, 12, 17083, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - On Data Set - Summon Creature");
INSERT INTO smart_scripts VALUES (16700, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Legionnaire - On Data Set - Say Line 2");

-- Fel Orc Convert (17083, 20567)
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17083;
UPDATE creature_template SET pickpocketloot=17083, mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20589;
DELETE FROM smart_scripts WHERE entryorguid=17083 AND source_type=0;
INSERT INTO smart_scripts VALUES (17083, 0, 0, 0, 0, 0, 100, 0, 1500, 3000, 10000, 15000, 11, 30478, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Fel Orc Convert - In Combat - Cast Hemorrhage");
INSERT INTO smart_scripts VALUES (17083, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 16807, 50, 0, 0, 0, 0, 0, "Fel Orc Convert - On Aggro - Set Data");
INSERT INTO smart_scripts VALUES (17083, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 11, 16807, 50, 0, 0, 0, 0, 0, "Fel Orc Convert - On Death - Set Data");

-- Shattered Hand Sentry (16507, 20593)
DELETE FROM creature_text WHERE entry=16507;
INSERT INTO creature_text VALUES (16507, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
INSERT INTO creature_text VALUES (16507, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Sentry');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=16507;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20593;
DELETE FROM smart_scripts WHERE entryorguid=16507 AND source_type=0;
INSERT INTO smart_scripts VALUES (16507, 0, 0, 0, 0, 0, 100, 0, 1000, 3500, 7000, 16000, 11, 31553, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sentry - In Combat - Cast 'Hamstring'");
INSERT INTO smart_scripts VALUES (16507, 0, 1, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sentry - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (16507, 0, 2, 0, 4, 0, 100, 2, 0, 0, 0, 0, 11, 22911, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sentry - On Aggro - Cast Spell Charge");
INSERT INTO smart_scripts VALUES (16507, 0, 3, 0, 4, 0, 100, 4, 0, 0, 0, 0, 11, 37511, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sentry - On Aggro - Cast Spell Charge");
INSERT INTO smart_scripts VALUES (16507, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shattered Hand Sentry - On Death - Set Data");

-- Shattered Hand Brawler (16593, 20582)
DELETE FROM creature_text WHERE entry=16593;
INSERT INTO creature_text VALUES (16593, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
INSERT INTO creature_text VALUES (16593, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Brawler');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=16593;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20582;
DELETE FROM smart_scripts WHERE entryorguid=16593 AND source_type=0;
INSERT INTO smart_scripts VALUES (16593, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 180000, 180000, 11, 36020, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Brawler - In Combat - Cast Curse of the Shattered Hand");
INSERT INTO smart_scripts VALUES (16593, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 10000, 18000, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Brawler - In Combat - Cast Thrash");
INSERT INTO smart_scripts VALUES (16593, 0, 2, 0, 13, 0, 100, 0, 10000, 10000, 0, 0, 11, 36033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Brawler - On Victim Cast - Cast Kick");
INSERT INTO smart_scripts VALUES (16593, 0, 3, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Brawler - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (16593, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shattered Hand Brawler - On Death - Set Data");

-- Shadowmoon Acolyte (16594, 20576)
DELETE FROM creature_text WHERE entry=16594;
INSERT INTO creature_text VALUES (16594, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
INSERT INTO creature_text VALUES (16594, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Acolyte');
UPDATE creature_template SET mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=16594;
UPDATE creature_template SET mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=20576;
DELETE FROM smart_scripts WHERE entryorguid=16594 AND source_type=0;
INSERT INTO smart_scripts VALUES (16594, 0, 0, 0, 11, 0, 100, 7, 0, 0, 0, 0, 79, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - On Respawn - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (16594, 0, 1, 0, 9, 0, 100, 6, 0, 5, 1, 1, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Within 0-5 Range - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (16594, 0, 2, 0, 9, 0, 20, 6, 0, 5, 2500, 2500, 11, 15587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Within 0-5 Range - Cast 'Mind Blast'");
INSERT INTO smart_scripts VALUES (16594, 0, 3, 0, 9, 0, 100, 6, 5, 30, 1, 1, 79, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Within 5-30 Range - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (16594, 0, 4, 0, 9, 0, 100, 6, 5, 30, 2500, 2500, 11, 15587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Within 5-30 Range - Cast 'Mind Blast'");
INSERT INTO smart_scripts VALUES (16594, 0, 5, 0, 0, 0, 100, 2, 5000, 5000, 25000, 25000, 11, 35944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - In Combat - Cast 'Power Word: Shield'");
INSERT INTO smart_scripts VALUES (16594, 0, 6, 0, 0, 0, 100, 4, 5000, 5000, 25000, 25000, 11, 36052, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - In Combat - Cast 'Power Word: Shield'");
INSERT INTO smart_scripts VALUES (16594, 0, 7, 0, 0, 0, 100, 7, 0, 0, 0, 0, 11, 30479, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - In Combat - Cast 'Resist Shadow'");
INSERT INTO smart_scripts VALUES (16594, 0, 8, 0, 2, 0, 100, 2, 0, 60, 7000, 7000, 11, 15585, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Between 0-60% Health - Cast 'Prayer of Healing'");
INSERT INTO smart_scripts VALUES (16594, 0, 9, 0, 2, 0, 100, 4, 0, 60, 7000, 7000, 11, 35943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Between 0-60% Health - Cast 'Prayer of Healing'");
INSERT INTO smart_scripts VALUES (16594, 0, 10, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (16594, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shadowmoon Acolyte - On Death - Set Data");

-- Shadowmoon Darkcaster (17694, 20577)
DELETE FROM creature_text WHERE entry=17694;
INSERT INTO creature_text VALUES (17694, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
INSERT INTO creature_text VALUES (17694, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shadowmoon Darkcaster');
UPDATE creature_template SET mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17694;
UPDATE creature_template SET mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=20577;
DELETE FROM smart_scripts WHERE entryorguid=17694 AND source_type=0;
INSERT INTO smart_scripts VALUES (17694, 0, 0, 0, 11, 0, 100, 7, 0, 0, 0, 0, 79, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - On Respawn - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (17694, 0, 1, 0, 9, 0, 100, 6, 0, 5, 1, 1, 79, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - Within 0-5 Range - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (17694, 0, 2, 0, 9, 0, 20, 6, 0, 5, 3000, 3000, 11, 15232, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - Within 0-5 Range - Cast 'Shadow Bolt'");
INSERT INTO smart_scripts VALUES (17694, 0, 3, 0, 9, 0, 100, 6, 5, 30, 1, 1, 79, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - Within 5-30 Range - Set Ranged Movement");
INSERT INTO smart_scripts VALUES (17694, 0, 4, 0, 9, 0, 100, 6, 5, 30, 3000, 3000, 11, 15232, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - Within 5-30 Range - Cast 'Shadow Bolt'");
INSERT INTO smart_scripts VALUES (17694, 0, 5, 0, 0, 0, 100, 0, 1000, 3000, 20000, 20000, 11, 12542, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - In Combat - Cast 'Fear'");
INSERT INTO smart_scripts VALUES (17694, 0, 6, 0, 0, 0, 100, 2, 5000, 5000, 25000, 25000, 11, 11990, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - In Combat - Cast 'Rain of Fire'");
INSERT INTO smart_scripts VALUES (17694, 0, 7, 0, 0, 0, 100, 4, 5000, 5000, 25000, 25000, 11, 33508, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - In Combat - Cast 'Rain of Fire'");
INSERT INTO smart_scripts VALUES (17694, 0, 8, 0, 4, 0, 20, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Darkcaster - On Aggro - Say Line 1");
INSERT INTO smart_scripts VALUES (17694, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shadowmoon Darkcaster - On Death - Set Data");

-- Shattered Hand Assassin (17695, 20580)
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17695;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20580;
DELETE FROM smart_scripts WHERE entryorguid=17695 AND source_type=0;
INSERT INTO smart_scripts VALUES (17695, 0, 0, 0, 1, 0, 100, 7, 1000, 1000, 0, 0, 11, 30991, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Assassin - Out of Combat - Cast Stealth");
INSERT INTO smart_scripts VALUES (17695, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 4500, 6500, 11, 30992, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Assassin - In Combat - Cast Backstab");
INSERT INTO smart_scripts VALUES (17695, 0, 2, 0, 0, 0, 100, 0, 1000, 1000, 12000, 12000, 11, 36974, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Assassin - In Combat - Cast Wound Poison");
INSERT INTO smart_scripts VALUES (17695, 0, 3, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 49, 0, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, "Shattered Hand Assassin - Out of Combat - Attack Start");
INSERT INTO smart_scripts VALUES (17695, 0, 4, 0, 1, 0, 100, 0, 2000, 2000, 8000, 8000, 11, 30980, 0, 0, 0, 0, 0, 21, 15, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - Out of Combat - Cast Spell Sap");
INSERT INTO smart_scripts VALUES (17695, 0, 5, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 30986, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shadowmoon Acolyte - On Aggro - Cast Spell Cheap Shot");
INSERT INTO smart_scripts VALUES (17695, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 16700, 20, 1, 0, 0, 0, 0, "Shadowmoon Acolyte - On Death - Set Data");

-- Shattered Hand Sharpshooter (16704, 20594)
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=16704;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20594;
DELETE FROM smart_scripts WHERE entryorguid=16704 AND source_type=0;
INSERT INTO smart_scripts VALUES (16704, 0, 0, 10, 9, 0, 100, 2, 5, 30, 2300, 5000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-30 Range - Cast 'Shoot'");
INSERT INTO smart_scripts VALUES (16704, 0, 1, 10, 9, 0, 100, 4, 5, 30, 2300, 5000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-30 Range - Cast 'Shoot'");
INSERT INTO smart_scripts VALUES (16704, 0, 2, 10, 9, 0, 100, 2, 5, 90, 6000, 9000, 11, 30481, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-90 Range - Cast 'Incendiary Shot'");
INSERT INTO smart_scripts VALUES (16704, 0, 3, 10, 9, 0, 100, 4, 5, 100, 6000, 9000, 11, 35945, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-100 Range - Cast 'Incendiary Shot'");
INSERT INTO smart_scripts VALUES (16704, 0, 4, 10, 9, 0, 100, 0, 5, 30, 10000, 14000, 11, 37551, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-30 Range - Cast 'Viper Sting'");
INSERT INTO smart_scripts VALUES (16704, 0, 5, 0, 7, 0, 100, 7, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - On Evade - Set Sheath Melee (Dungeon)");
INSERT INTO smart_scripts VALUES (16704, 0, 6, 0, 9, 0, 100, 0, 0, 5, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 0-5 Range - Set Sheath Melee (No Repeat) (Dungeon)");
INSERT INTO smart_scripts VALUES (16704, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Sharpshooter - Within 5-30 Range - Set Sheath Ranged (Normal Dungeon)");

-- Sharpshooter Guard (17622, 20578)
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17622;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20578;
DELETE FROM smart_scripts WHERE entryorguid=17622 AND source_type=0;
INSERT INTO smart_scripts VALUES (17622, 0, 0, 10, 9, 0, 100, 2, 5, 30, 2300, 5000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-30 Range - Cast 'Shoot' (Normal Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 1, 10, 9, 0, 100, 4, 5, 30, 2300, 5000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-30 Range - Cast 'Shoot' (Heroic Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 2, 10, 9, 0, 100, 2, 5, 90, 6000, 9000, 11, 30481, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-90 Range - Cast 'Incendiary Shot' (Normal Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 3, 10, 9, 0, 100, 4, 5, 100, 6000, 9000, 11, 35945, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-100 Range - Cast 'Incendiary Shot' (Heroic Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 4, 10, 9, 0, 100, 6, 5, 30, 10000, 14000, 11, 37551, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-30 Range - Cast 'Viper Sting' (Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 5, 0, 7, 0, 100, 7, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - On Evade - Set Sheath Melee (Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 6, 0, 9, 0, 100, 0, 0, 5, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 0-5 Range - Set Sheath Melee (No Repeat) (Dungeon)");
INSERT INTO smart_scripts VALUES (17622, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Sharpshooter Guard - Within 5-30 Range - Set Sheath Ranged (Normal Dungeon)");

-- Shattered Hand Houndmaster (17670, 20588)
DELETE FROM creature_text WHERE entry=17670;
INSERT INTO creature_text VALUES (17670, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
INSERT INTO creature_text VALUES (17670, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Houndmaster');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17670;
UPDATE creature_template SET mechanic_immune_mask=67601, AIName='', ScriptName='' WHERE entry=20588;
DELETE FROM smart_scripts WHERE entryorguid=17670 AND source_type=0;
INSERT INTO smart_scripts VALUES (17670, 0, 0, 10, 9, 0, 100, 2, 5, 30, 2300, 5000, 11, 15620, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 5-30 Range - Cast 'Shoot'");
INSERT INTO smart_scripts VALUES (17670, 0, 1, 10, 9, 0, 100, 4, 5, 30, 2300, 5000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 5-30 Range - Cast 'Shoot'");
INSERT INTO smart_scripts VALUES (17670, 0, 2, 10, 0, 0, 100, 2, 7000, 12000, 60000, 70000, 11, 34100, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - In Combat - Cast 'Volley'");
INSERT INTO smart_scripts VALUES (17670, 0, 3, 10, 0, 0, 100, 4, 7000, 9000, 60000, 65000, 11, 35950, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - In Combat - Cast 'Volley'");
INSERT INTO smart_scripts VALUES (17670, 0, 4, 10, 9, 0, 100, 2, 5, 30, 12000, 16000, 11, 30932, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 5-30 Range - Cast 'Impaling Bolt'");
INSERT INTO smart_scripts VALUES (17670, 0, 5, 10, 9, 0, 100, 4, 5, 30, 12000, 16000, 11, 40248, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 5-30 Range - Cast 'Impaling Bolt'");
INSERT INTO smart_scripts VALUES (17670, 0, 6, 0, 7, 0, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - On Evade - Set Sheath Melee");
INSERT INTO smart_scripts VALUES (17670, 0, 7, 0, 9, 0, 100, 0, 0, 5, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 0-5 Range - Set Sheath Melee");
INSERT INTO smart_scripts VALUES (17670, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Houndmaster - Within 5-30 Range - Set Sheath Ranged");
-- Rabid Warhound (17669, 20574)
UPDATE creature_template SET mechanic_immune_mask=512, AIName='SmartAI', ScriptName='' WHERE entry=17669;
UPDATE creature_template SET mechanic_immune_mask=512, AIName='', ScriptName='' WHERE entry=20574;
DELETE FROM smart_scripts WHERE entryorguid=17669 AND source_type=0;
INSERT INTO smart_scripts VALUES (17669, 0, 0, 0, 0, 0, 100, 6, 500, 500, 7000, 10000, 11, 30639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Rabid Warhound - In Combat - Cast 'Carnivorous Bite'");
INSERT INTO smart_scripts VALUES (17669, 0, 1, 0, 0, 0, 40, 2, 2000, 2000, 8000, 14000, 11, 30636, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Rabid Warhound - In Combat - Cast 'Furious Howl'");
INSERT INTO smart_scripts VALUES (17669, 0, 2, 0, 0, 0, 40, 4, 2000, 2000, 8000, 14000, 11, 35942, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Rabid Warhound - In Combat - Cast 'Furious Howl'");
INSERT INTO smart_scripts VALUES (17669, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8279, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Rabid Warhound - Out of Combat - Cast 'Stealth Detection'");

-- Creeping Ooze (17356, 20565)
DELETE FROM creature_onkill_reputation WHERE creature_id IN(17356, 20565);
INSERT INTO creature_onkill_reputation VALUES (20565, 946, 947, 7, 0, 4, 7, 0, 4, 1);
DELETE FROM creature WHERE id=17356;
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 127.391, 209.194, -49.043, 3.71512, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 129.599, 219.459, -48.2223, 3.71512, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 121.539, 234.76, -46.366, 3.71512, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 130.671, 249.438, -45.2001, 3.71512, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 134.63, 187.246, -47.1104, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 158.726, 168.864, -42.7899, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 134.94, 197.199, -48.3391, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 124.697, 196.671, -48.4666, 3.71512, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 172.412, 170.755, -41.8802, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 186.325, 160.14, -42.3431, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17356, 540, 3, 1, 0, 0, 195.026, 168.852, -42.3682, 5.63149, 300, 5, 0, 19607, 0, 1, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17356;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20565;
DELETE FROM smart_scripts WHERE entryorguid=17356 AND source_type=0;
INSERT INTO smart_scripts VALUES (17356, 0, 0, 0, 0, 0, 100, 0, 500, 900, 3800, 6600, 11, 30494, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Creeping Ooze - In Combat - Cast 'Sticky Ooze'");

-- Creeping Oozeling (17357, 20566)
DELETE FROM creature_onkill_reputation WHERE creature_id IN(17357, 20566);
INSERT INTO creature_onkill_reputation VALUES (20566, 946, 947, 7, 0, 4, 7, 0, 4, 1);
DELETE FROM creature WHERE id=17357;
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 119.802, 252.08, -45.2208, 1.11545, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 123.365, 241.68, -45.4701, 1.11545, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 127.73, 231.381, -46.8117, 1.11545, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 122.589, 220.882, -47.9027, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 118.016, 208.916, -49.1488, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 129.982, 204.343, -48.8409, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 129.756, 189.482, -47.7988, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 143.797, 189.415, -46.4029, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 158.378, 178.829, -43.3422, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 176.265, 165.347, -42.2052, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 180.065, 156.848, -42.3355, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 188.578, 163.364, -42.3485, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 192.378, 154.865, -42.3681, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17357, 540, 3, 1, 0, 0, 200.833, 158.645, -42.3886, 2.77656, 300, 5, 0, 3381, 0, 1, 0, 0, 0);
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=17357;
UPDATE creature_template SET AIName='', ScriptName='' WHERE entry=20566;

-- Shattered Hand Gladiator (17464, 20586)
UPDATE creature_template SET mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17464;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20586;
DELETE FROM smart_scripts WHERE entryorguid=17464 AND source_type=0;
INSERT INTO smart_scripts VALUES (17464, 0, 0, 0, 0, 2, 100, 0, 500, 500, 6000, 9000, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - In Combat - Cast 'Mortal Strike' (No Repeat) (Dungeon)");
INSERT INTO smart_scripts VALUES (17464, 0, 1, 2, 1, 0, 100, 0, 10000, 20000, 30000, 30000, 2, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - Out of Combat - Set Faction");
INSERT INTO smart_scripts VALUES (17464, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 17464, 1, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - Out of Combat - Attack Start");
INSERT INTO smart_scripts VALUES (17464, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 11, 33096, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - Out of Combat - Cast Spell");
INSERT INTO smart_scripts VALUES (17464, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - Out of Combat - Set Faction");
INSERT INTO smart_scripts VALUES (17464, 0, 5, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - In Combat - Set Event Phase");
INSERT INTO smart_scripts VALUES (17464, 0, 6, 0, 8, 1, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - On Spell Hit - Set Event Phase");
INSERT INTO smart_scripts VALUES (17464, 0, 7, 0, 2, 1, 100, 0, 0, 30, 30000, 30000, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Gladiator - On HP Check - Enter Evade Mode");

-- Shattered Hand Centurion (17465, 20583)
DELETE FROM creature_text WHERE entry=17465;
INSERT INTO creature_text VALUES (17465, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
INSERT INTO creature_text VALUES (17465, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Centurion');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17465;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20583;
DELETE FROM smart_scripts WHERE entryorguid=17465 AND source_type=0;
INSERT INTO smart_scripts VALUES (17465, 0, 0, 0, 0, 0, 100, 2, 1500, 2500, 4000, 6000, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Centurion - In Combat - Cast Sunder Armor");
INSERT INTO smart_scripts VALUES (17465, 0, 1, 0, 0, 0, 100, 4, 1500, 2500, 4000, 6000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Centurion - In Combat - Cast Sunder Armor");
INSERT INTO smart_scripts VALUES (17465, 0, 2, 0, 0, 0, 100, 2, 0, 0, 20000, 20000, 11, 30931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Centurion - In Combat - Cast Battle Shout");
INSERT INTO smart_scripts VALUES (17465, 0, 3, 0, 0, 0, 100, 4, 0, 0, 120000, 120000, 11, 31403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Centurion - In Combat - Cast Battle Shout");
INSERT INTO smart_scripts VALUES (17465, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Centurion - On Aggro - Talk");

-- Shattered Hand Champion (17671, 20584)
DELETE FROM creature_text WHERE entry=17671;
INSERT INTO creature_text VALUES (17671, 1, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 1, "Gakarah ma!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 2, "Lok narash!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 3, "Lok'tar Illadari!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 4, "The blood is our power!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 5, "This world is OURS!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
INSERT INTO creature_text VALUES (17671, 1, 6, "We are the true Horde!", 12, 0, 100, 0, 0, 0, 0, 'Shattered Hand Champion');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17671;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20584;
DELETE FROM smart_scripts WHERE entryorguid=17671 AND source_type=0;
INSERT INTO smart_scripts VALUES (17671, 0, 0, 1, 0, 0, 100, 0, 1500, 1500, 5500, 8500, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Champion - In Combat - Cast 'Concussion Blow'");
INSERT INTO smart_scripts VALUES (17671, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 13, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Champion - In Combat - Set Single Threat 100-0");
INSERT INTO smart_scripts VALUES (17671, 0, 2, 0, 0, 0, 100, 6, 500, 500, 10000, 10000, 11, 32587, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Champion - In Combat - Cast 'Shield Block'");
INSERT INTO smart_scripts VALUES (17671, 0, 3, 0, 0, 0, 100, 6, 4000, 4000, 7000, 11000, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Champion - In Combat - Cast 'Shield Bash'");
INSERT INTO smart_scripts VALUES (17671, 0, 4, 0, 4, 0, 20, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Champion - On Aggro - Talk");


-- -------------------------------------------
--            GAUNTLET EVENT
-- -------------------------------------------
DELETE FROM areatrigger_scripts WHERE entry=4575;
INSERT INTO areatrigger_scripts VALUES (4575, 'SmartTrigger');
DELETE FROM smart_scripts WHERE entryorguid=4575 AND source_type=2;
INSERT INTO smart_scripts VALUES (4575, 2, 0, 0, 46, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 34038, 20923, 0, 0, 0, 0, 0, "Area Trigger - On Trigger - Set Data");
INSERT INTO smart_scripts VALUES (4575, 2, 1, 0, 46, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 62921, 17461, 0, 0, 0, 0, 0, "Area Trigger - On Trigger - Set Data");

DELETE FROM gameobject WHERE map=540 AND id IN(177669, 181915); -- Currently spawned fire go, dont know why :o
UPDATE gameobject_template SET data2=4, data5=2 WHERE entry=181915; -- Blaze summoned by spell, no radius atm
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30952;
INSERT INTO conditions VALUES(13, 1, 30952, 0, 0, 31, 0, 3, 17474, 0, 0, 0, 0, '', 'Target Target Trigger');
DELETE FROM spell_script_names WHERE spell_id IN(30952);
INSERT INTO spell_script_names VALUES(30952, 'spell_tsh_shoot_flame_arrow');

-- Target Trigger (17474)
UPDATE creature_template SET flags_extra=130, AIName='NullCreatureAI', ScriptName='' WHERE entry=17474;
DELETE FROM creature WHERE map=540 AND id=17474;
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 470.877, 312.579, 1.91828, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 464.92, 313.789, 1.92964, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 466.862, 322.841, 1.92449, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 445.03, 315.593, 1.91125, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 436.339, 317.505, 1.90193, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 408.058, 318.889, 1.91302, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 396.447, 308.347, 1.92309, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 370.468, 320.938, 1.9186, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 330.962, 323.431, 1.91715, 2.44512, 300, 0, 0, 6722, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17474, 540, 3, 1, 0, 0, 340.01, 310.955, 1.91715, 5.85374, 300, 0, 0, 6722, 0, 0, 0, 0, 0);

-- Blood Guard Porung (20923, 20993)
DELETE FROM creature_summon_groups WHERE summonerId=20923 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 484.73, 321.79, 1.95, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 481.27, 320.42, 1.95, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 481.08, 318.12, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 480.93, 315.74, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 480.81, 313.44, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (20923, 0, 1, 17462, 480.69, 311.13, 1.94, 3.14, 4, 30000);
DELETE FROM creature_text WHERE entry=20923;
INSERT INTO creature_text VALUES (20923, 0, 0, "Archers, form ranks! On my mark!", 14, 0, 100, 0, 0, 0, 0, 'Blood Guard Porung');
INSERT INTO creature_text VALUES (20923, 1, 0, "Ready!", 14, 0, 100, 0, 0, 0, 0, 'Blood Guard Porung');
INSERT INTO creature_text VALUES (20923, 2, 0, "Aim!", 14, 0, 100, 0, 0, 0, 0, 'Blood Guard Porung');
INSERT INTO creature_text VALUES (20923, 3, 0, "Fire!", 14, 0, 100, 0, 0, 0, 0, 'Blood Guard Porung');
INSERT INTO creature_text VALUES (20923, 4, 0, "For Kargath! For Victory!", 12, 0, 100, 0, 0, 0, 0, 'Blood Guard Porung');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=20923;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20993;
DELETE FROM smart_scripts WHERE entryorguid=20923 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20923*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20923, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 80, 20923*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - On Data Set - Script9");
INSERT INTO smart_scripts VALUES (20923, 0, 1, 0, 1, 1, 100, 0, 0, 0, 10000, 10000, 86, 30952, 0, 11, 17427, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Out Of Combat - Cross Cast");
INSERT INTO smart_scripts VALUES (20923, 0, 2, 0, 1, 1, 100, 0, 0, 0, 20000, 20000, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Out Of Combat - Summon Creature Group");
INSERT INTO smart_scripts VALUES (20923, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - On Aggro - Talk");
INSERT INTO smart_scripts VALUES (20923, 0, 4, 0, 0, 0, 100, 0, 2000, 4000, 8000, 10000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - In Combat - Cast Cleave");
INSERT INTO smart_scripts VALUES (20923*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Script9 - Talk");
INSERT INTO smart_scripts VALUES (20923*100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Script9 - Talk");
INSERT INTO smart_scripts VALUES (20923*100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Script9 - Talk");
INSERT INTO smart_scripts VALUES (20923*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Script9 - Talk");
INSERT INTO smart_scripts VALUES (20923*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Blood Guard Porung - Script9 - Set Event Phase");

-- Shattered Hand Blood Guard (17461, 20581)
UPDATE creature SET spawnMask=1 WHERE id=17461;
DELETE FROM creature_summon_groups WHERE summonerId=17461 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 484.73, 321.79, 1.95, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 481.27, 320.42, 1.95, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 481.08, 318.12, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 480.93, 315.74, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 480.81, 313.44, 1.94, 3.14, 4, 30000);
INSERT INTO creature_summon_groups VALUES (17461, 0, 1, 17462, 480.69, 311.13, 1.94, 3.14, 4, 30000);
DELETE FROM creature_text WHERE entry=17461;
INSERT INTO creature_text VALUES (17461, 0, 0, "Archers, form ranks! On my mark!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Blood Guard');
INSERT INTO creature_text VALUES (17461, 1, 0, "Ready!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Blood Guard');
INSERT INTO creature_text VALUES (17461, 2, 0, "Aim!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Blood Guard');
INSERT INTO creature_text VALUES (17461, 3, 0, "Fire!", 14, 0, 100, 0, 0, 0, 0, 'Shattered Hand Blood Guard');
UPDATE creature_template SET mechanic_immune_mask=1, AIName='SmartAI', ScriptName='' WHERE entry=17461;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20581;
DELETE FROM smart_scripts WHERE entryorguid=17461 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=17461*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (17461, 0, 0, 0, 38, 0, 100, 1, 1, 1, 0, 0, 80, 17461*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - On Data Set - Script9");
INSERT INTO smart_scripts VALUES (17461, 0, 1, 0, 0, 1, 100, 0, 4000, 4000, 10000, 10000, 86, 30952, 0, 11, 17427, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Out Of Combat - Cross Cast");
INSERT INTO smart_scripts VALUES (17461, 0, 2, 0, 0, 1, 100, 0, 0, 0, 15000, 15000, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Out Of Combat - Summon Creature Group");
INSERT INTO smart_scripts VALUES (17461*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Script9 - Set Event Phase");
INSERT INTO smart_scripts VALUES (17461*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Script9 - Talk");
INSERT INTO smart_scripts VALUES (17461*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Script9 - Talk");
INSERT INTO smart_scripts VALUES (17461*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Script9 - Talk");
INSERT INTO smart_scripts VALUES (17461*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Blood Guard - Script9 - Talk");

-- Shattered Hand Archer (17427, 20579)
UPDATE creature_template SET mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17427;
UPDATE creature_template SET mechanic_immune_mask=1, AIName='', ScriptName='' WHERE entry=20579;
DELETE FROM smart_scripts WHERE entryorguid=17427 AND source_type=0;
INSERT INTO smart_scripts VALUES (17427, 0, 0, 2, 9, 0, 100, 2, 5, 30, 2300, 5000, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - Within 5-30 Range - Cast 'Shoot' (Normal Dungeon)");
INSERT INTO smart_scripts VALUES (17427, 0, 1, 2, 9, 0, 100, 4, 5, 30, 2300, 5000, 11, 22907, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - Within 5-30 Range - Cast 'Shoot' (Heroic Dungeon)");
INSERT INTO smart_scripts VALUES (17427, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - Within 5-30 Range - Set Sheath Ranged");
INSERT INTO smart_scripts VALUES (17427, 0, 3, 0, 9, 0, 100, 0, 0, 5, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - Within 0-5 Range - Set Sheath Melee (No Repeat) (Dungeon)");
INSERT INTO smart_scripts VALUES (17427, 0, 4, 2, 9, 0, 100, 6, 5, 30, 6000, 9000, 11, 30990, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - Within 5-30 Range - Cast 'Multi-Shot' (Dungeon)");
INSERT INTO smart_scripts VALUES (17427, 0, 5, 0, 7, 0, 100, 7, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Archer - On Evade - Set Sheath Melee (Dungeon)");

-- Shattered Hand Zealot (17462, 20595)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=17462);
DELETE FROM linked_respawn WHERE guid IN(SELECT guid FROM creature WHERE id=17462);
DELETE FROM creature WHERE id=17462;
UPDATE creature_template SET mechanic_immune_mask=0, AIName='SmartAI', ScriptName='' WHERE entry=17462;
UPDATE creature_template SET mechanic_immune_mask=0, AIName='', ScriptName='' WHERE entry=20595;
DELETE FROM smart_scripts WHERE entryorguid=17462 AND source_type=0;
INSERT INTO smart_scripts VALUES (17462, 0, 0, 0, 0, 0, 100, 0, 500, 4000, 7000, 10000, 11, 30989, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Zealot - In Combat - Cast 'Hamstring'");
INSERT INTO smart_scripts VALUES (17462, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 282.68, 316.85, 1.87, 0, "Shattered Hand Zealot - Just Summoned - Move To Pos");


-- -------------------------------------------
--                BOSSES
-- -------------------------------------------
-- Grand Warlock Nethekurse (16807, 20568)
UPDATE gameobject_template SET flags=2 WHERE entry IN(182539, 182540);
DELETE FROM linked_respawn WHERE guid IN(59478, 59479, 59480, 59481);
DELETE FROM creature_addon WHERE guid IN(59478, 59479, 59480, 59481);
DELETE FROM creature WHERE id=17083 AND guid IN(59478, 59479, 59480, 59481);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=30735;
INSERT INTO conditions VALUES(13, 1, 30735, 0, 0, 31, 0, 3, 17083, 0, 0, 0, 0, '', 'Target Fel Orc Convert');
DELETE FROM spell_script_names WHERE spell_id IN(30735);
INSERT INTO spell_script_names VALUES(30735, 'spell_tsh_shadow_sear');
DELETE FROM creature_text WHERE entry=16807;
INSERT INTO creature_text VALUES (16807, 0, 0, "You wish to fight us all at once? This should be amusing!", 14, 0, 100, 0, 0, 10262, 0, 'nethekurse SAY_INTRO');
INSERT INTO creature_text VALUES (16807, 1, 0, "You can have that one, I no longer need him!", 14, 0, 100, 0, 0, 10263, 0, 'nethekurse PEON_ATTACK_1');
INSERT INTO creature_text VALUES (16807, 1, 1, "Yes, beat him mercilessly! His skull is as thick as an ogre's!", 14, 0, 100, 0, 0, 10264, 0, 'nethekurse PEON_ATTACK_2');
INSERT INTO creature_text VALUES (16807, 1, 2, "Don't waste your time on that one, he's weak!", 14, 0, 100, 0, 0, 10265, 0, 'nethekurse PEON_ATTACK_3');
INSERT INTO creature_text VALUES (16807, 1, 3, "You want him? Very well, take him!", 14, 0, 100, 0, 0, 10266, 0, 'nethekurse PEON_ATTACK_4');
INSERT INTO creature_text VALUES (16807, 2, 0, "One pitiful wretch down. Go on, take another one!", 14, 0, 100, 0, 0, 10267, 0, 'nethekurse PEON_DIE_1');
INSERT INTO creature_text VALUES (16807, 2, 1, "Ah, what a waste... next!", 14, 0, 100, 0, 0, 10268, 0, 'nethekurse PEON_DIE_2');
INSERT INTO creature_text VALUES (16807, 2, 2, "I was going to kill him anyway!", 14, 0, 100, 0, 0, 10269, 0, 'nethekurse PEON_DIE_3');
INSERT INTO creature_text VALUES (16807, 2, 3, "Thank you for saving me the trouble. Now it's my turn to have some fun!", 14, 0, 100, 0, 0, 10270, 0, 'nethekurse PEON_DIE_4');
INSERT INTO creature_text VALUES (16807, 3, 0, "Beg for your pitiful life!", 14, 0, 100, 0, 0, 10259, 0, 'nethekurse SAY_TAUNT_1');
INSERT INTO creature_text VALUES (16807, 3, 1, "Run, coward, run!"   , 14, 0, 100, 0, 0, 10260, 0, 'nethekurse SAY_TAUNT_2');
INSERT INTO creature_text VALUES (16807, 3, 2, "Your pain amuses me!", 14, 0, 100, 0, 0, 10261, 0, 'nethekurse SAY_TAUNT_3');
INSERT INTO creature_text VALUES (16807, 4, 0, "I'm already bored!", 14, 0, 100, 0, 0, 10271, 0, 'nethekurse SAY_AGGRO_1');
INSERT INTO creature_text VALUES (16807, 4, 1, "Come on, show me a real fight!", 14, 0, 100, 0, 0, 10272, 0, 'nethekurse SAY_AGGRO_2');
INSERT INTO creature_text VALUES (16807, 4, 2, "I had more fun torturing the peons!", 14, 0, 100, 0, 0, 10273, 0, 'nethekurse SAY_AGGRO_3');
INSERT INTO creature_text VALUES (16807, 5, 0, "You lose.", 14, 0, 100, 0, 0, 10274, 0, 'nethekurse SAY_SLAY_1');
INSERT INTO creature_text VALUES (16807, 5, 1, "Oh, just die!", 14, 0, 100, 0, 0, 10275, 0, 'nethekurse SAY_SLAY_2');
INSERT INTO creature_text VALUES (16807, 6, 0, "What... a shame.", 14, 0, 100, 0, 0, 10276, 0, 'nethekurse SAY_DIE');
UPDATE creature_template SET mechanic_immune_mask=617562111, AIName='', ScriptName='boss_grand_warlock_nethekurse' WHERE entry=16807;
UPDATE creature_template SET pickpocketloot=16807, mechanic_immune_mask=617562111, AIName='', ScriptName='' WHERE entry=20568;

-- Lesser Shadow Fissure (17471, 20570)
REPLACE INTO creature_template_addon VALUES (17471, 0, 0, 0, 0, 0, '30497');
REPLACE INTO creature_template_addon VALUES (20570, 0, 0, 0, 0, 0, '30497');
UPDATE creature_template SET unit_flags=33554434, faction=16, AIName='NullCreatureAI', ScriptName='' WHERE entry=17471;
UPDATE creature_template SET unit_flags=33554434, faction=16, AIName='', ScriptName='' WHERE entry=20570;

-- Warbringer O'mrogg (16809, 20596)
DELETE FROM creature_text WHERE entry=16809;
INSERT INTO creature_text VALUES (16809, 0, 0, '%s enrages.', 16, 0, 100, 0, 0, 0, 0, 'omrogg EMOTE_ENRAGE');
UPDATE creature_template SET mechanic_immune_mask=617562111, flags_extra=256, AIName='', ScriptName='boss_warbringer_omrogg' WHERE entry=16809;
UPDATE creature_template SET pickpocketloot=16809, mechanic_immune_mask=617562111, flags_extra=257, AIName='', ScriptName='' WHERE entry=20596;

-- O'mrogg's Left Head (19523, 20572)
DELETE FROM creature_text WHERE entry=19523;
INSERT INTO creature_text VALUES (19523, 0, 0, "Smash!", 14, 0, 100, 0, 0, 10306, 0, 'omrogg GoCombat_1');
INSERT INTO creature_text VALUES (19523, 1, 0, "If you nice me let you live.", 14, 0, 100, 0, 0, 10308, 0, 'omrogg GoCombat_2');
INSERT INTO creature_text VALUES (19523, 2, 0, "Me hungry!", 14, 0, 100, 0, 0, 10309, 0, 'omrogg GoCombat_3');
INSERT INTO creature_text VALUES (19523, 3, 0, "You stay here. Me go kill someone else!", 14, 0, 100, 0, 0, 10303, 0, 'omrogg Threat_1');
INSERT INTO creature_text VALUES (19523, 4, 0, "Me kill someone else...", 14, 0, 100, 0, 0, 10302, 0, 'omrogg Threat_2');
INSERT INTO creature_text VALUES (19523, 5, 0, "Me not like this one...", 14, 0, 100, 0, 0, 10300, 0, 'omrogg Threat_3');
INSERT INTO creature_text VALUES (19523, 6, 0, "Me get bored...", 14, 0, 100, 0, 0, 10305, 0, 'omrogg ThreatDelay1_2');
INSERT INTO creature_text VALUES (19523, 6, 1, "Ha ha ha.", 14, 0, 100, 0, 0, 10304, 0, 'omrogg ThreatDelay2_1');
INSERT INTO creature_text VALUES (19523, 6, 2, "H'ey...", 14, 0, 100, 0, 0, 10307, 0, 'omrogg ThreatDelay2_3');
INSERT INTO creature_text VALUES (19523, 6, 3, "We kill his friend!", 14, 0, 100, 0, 0, 10301, 0, 'omrogg ThreatDelay2_4');
INSERT INTO creature_text VALUES (19523, 7, 0, "This one die easy!", 14, 0, 100, 0, 0, 10310, 0, 'omrogg Killing_1');
INSERT INTO creature_text VALUES (19523, 8, 0, "That's because I do all the hard work!", 14, 0, 100, 0, 0, 10321, 0, 'omrogg KillingDelay_2');
INSERT INTO creature_text VALUES (19523, 9, 0, 'This all...your fault!', 14, 0, 100, 0, 0, 10311, 0, 'omrogg YELL_DIE_L');
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, AIName='', ScriptName='npc_omrogg_heads' WHERE entry=19523;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, AIName='', ScriptName='' WHERE entry=20572;

-- O'mrogg's Right Head (19524, 20573)
DELETE FROM creature_text WHERE entry=19524;
INSERT INTO creature_text VALUES (19524, 0, 0, "Why don't you let me do the talking?", 14, 0, 100, 0, 0, 10317, 0, 'omrogg GoCombatDelay_1');
INSERT INTO creature_text VALUES (19524, 1, 0, "No, we will NOT let you live!", 14, 0, 100, 0, 0, 10318, 0, 'omrogg GoCombatDelay_2');
INSERT INTO creature_text VALUES (19524, 2, 0, "You always hungry. That why we so fat!", 14, 0, 100, 0, 0, 10319, 0, 'omrogg GoCombatDelay_3');
INSERT INTO creature_text VALUES (19524, 3, 0, "That's not funny!", 14, 0, 100, 0, 0, 10314, 0, 'omrogg ThreatDelay1');
INSERT INTO creature_text VALUES (19524, 4, 0, "I'm not done yet, idiot!", 14, 0, 100, 0, 0, 10313, 0, 'omrogg ThreatDelay2');
INSERT INTO creature_text VALUES (19524, 5, 0, "Hey you numbskull!", 14, 0, 100, 0, 0, 10312, 0, 'omrogg ThreatDelay31');
INSERT INTO creature_text VALUES (19524, 5, 1, "Whhy! He almost dead!", 14, 0, 100, 0, 0, 10316, 0, 'omrogg ThreatDelay32');
INSERT INTO creature_text VALUES (19524, 6, 0, "What are you doing!", 14, 0, 100, 0, 0, 10315, 0, 'omrogg Threat_2');
INSERT INTO creature_text VALUES (19524, 7, 0, "That's because I do all the hard work!", 14, 0, 100, 0, 0, 10321, 0, 'omrogg KillingDelay_1');
INSERT INTO creature_text VALUES (19524, 8, 0, "I'm tired. You kill next one!", 14, 0, 100, 0, 0, 10320, 0, 'omrogg Killing_2');
INSERT INTO creature_text VALUES (19524, 9, 0, 'I...hate...you...', 14, 0, 100, 0, 0, 10322, 0, 'omrogg YELL_DIE_R');
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, AIName='', ScriptName='npc_omrogg_heads' WHERE entry=19524;
UPDATE creature_template SET unit_flags=33554432, flags_extra=128, AIName='', ScriptName='' WHERE entry=20573;

-- Warchief Kargath Bladefist (16808, 20597)
DELETE FROM creature_text WHERE entry=16808;
INSERT INTO creature_text VALUES (16808, 0, 0, "Ours is the TRUE Horde! The only Horde!", 14, 0, 100, 0, 0, 10323, 0, 'kargath SAY_AGGRO1');
INSERT INTO creature_text VALUES (16808, 0, 1, "I'll carve the meat from your bones!", 14, 0, 100, 0, 0, 10324, 0, 'kargath SAY_AGGRO2');
INSERT INTO creature_text VALUES (16808, 0, 2, "I am called Bladefist for a reason. As you will see.", 14, 0, 100, 0, 0, 10325, 0, 'kargath SAY_AGGRO3');
INSERT INTO creature_text VALUES (16808, 1, 0, "For the real Horde!", 14, 0, 100, 0, 0, 10326, 0, 'kargath SAY_SLAY1');
INSERT INTO creature_text VALUES (16808, 1, 1, "I am the ONLY warchief!", 14, 0, 100, 0, 0, 10327, 0, 'kargath SAY_SLAY2');
INSERT INTO creature_text VALUES (16808, 2, 0, "The true Horde... will prevail.", 14, 0, 100, 0, 0, 10328, 0, 'kargath SAY_DEATH');
INSERT INTO creature_text VALUES (16808, 3, 0, "The Alliance dares to intrude this far into my fortress? Bring out the Honor Hold prisoners and call for the executioner! They'll pay with their lives for this trespass!", 14, 0, 100, 0, 0, 0, 0, 'kargath');
INSERT INTO creature_text VALUES (16808, 4, 0, "Thrall's false Horde dares to intrude this far into my fortress? Bring out the Thrallmar prisoners and call for the executioner! They'll pay with their lives for this trespass!", 14, 0, 100, 0, 0, 0, 0, 'kargath');
UPDATE creature_template SET mechanic_immune_mask=617562111, AIName='', ScriptName='boss_warchief_kargath_bladefist' WHERE entry=16808;
UPDATE creature_template SET pickpocketloot=16808, mechanic_immune_mask=617562111, AIName='', ScriptName='' WHERE entry=20597;

-- Trial of the Naaru: Mercy addition:
DELETE FROM areatrigger_scripts WHERE entry=4524;
INSERT INTO areatrigger_scripts VALUES (4524, 'at_shattered_halls_execution');

-- Rifleman Brownbeard (17289)
-- Captain Alina (17290)
-- Private Jacint (17292)
-- Korag Proudmane (17295)
-- Captain Boneshatter (17296)
-- Scout Orgarr (17297)
UPDATE creature_template SET flags_extra=2, AIName='NullCreatureAI', ScriptName='' WHERE entry IN(17289, 17290, 17292, 17295, 17296, 17297);
DELETE FROM creature WHERE id IN(17289, 17290, 17292, 17295, 17296, 17297);
INSERT INTO creature VALUES (NULL, 17289, 540, 2, 1, 0, 0, 148.565, -77.7137, 1.92007, 4.71631, 300, 0, 0, 6104, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17290, 540, 2, 1, 0, 0, 141.558, -82.6996, 1.9076, 6.22428, 300, 0, 0, 6104, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 17292, 540, 2, 1, 0, 0, 147.522, -88.6911, 1.9159, 1.4348, 300, 0, 0, 6104, 0, 0, 0, 0, 0);

-- Shattered Hand Executioner (17301, 20585)
DELETE FROM creature WHERE id=17301;
INSERT INTO creature VALUES (NULL, 17301, 540, 2, 1, 0, 1, 152.863, -83.2273, 1.93712, 6.25962, 300, 0, 0, 27351, 0, 0, 0, 0, 0);
UPDATE creature_template SET lootid=0, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=17301;
UPDATE creature_template SET flags_extra=2, AIName='', ScriptName='' WHERE entry=20585;
DELETE FROM smart_scripts WHERE entryorguid=17301 AND source_type=0;
INSERT INTO smart_scripts VALUES (17301, 0, 0, 0, 0, 0, 66, 6, 500, 500, 5000, 7000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shattered Hand Executioner - In Combat - Cast 'Cleave' (No Repeat)");
DELETE FROM creature_loot_template WHERE entry IN(17301, 20585);
INSERT INTO creature_loot_template VALUES (20585, 21884, 15, 1, 0, 2, 3);
INSERT INTO creature_loot_template VALUES (20585, 21885, 15, 1, 0, 2, 3);
INSERT INTO creature_loot_template VALUES (20585, 22451, 15, 1, 0, 2, 3);
INSERT INTO creature_loot_template VALUES (20585, 22452, 15, 1, 0, 2, 3);
INSERT INTO creature_loot_template VALUES (20585, 31716, -100, 2, 0, 1, 1);

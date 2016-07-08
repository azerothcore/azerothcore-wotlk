
-- -------------------------------------------
-- BOREAN TUNDRA
-- -------------------------------------------

-- Re-Cursed (11712)
DELETE FROM spell_scripts WHERE id=45980;
INSERT INTO spell_scripts VALUES(45980, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO spell_scripts VALUES(45980, 0, 1, 8, 25773, 0, 0, 0, 0, 0, 0);

-- Words of Power (11942)
-- Words of Power (11640)
REPLACE INTO creature_text VALUES(26076, 0, 0, "What is the meaning of this? I have not yet finished my feast!", 14, 0, 100, 0, 0, 0, 0, "Naferset yell");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=26076;
DELETE FROM smart_scripts WHERE entryorguid IN(26076) AND source_type=0;
INSERT INTO smart_scripts VALUES (26076, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Unit flag on reset');
INSERT INTO smart_scripts VALUES (26076, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Unit flag on respawn');
INSERT INTO smart_scripts VALUES (26076, 0, 2, 3, 1, 0, 100, 0, 2000, 2000, 5000, 5000, 19, 33555200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove Unit flag on OOC');
INSERT INTO smart_scripts VALUES (26076, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Yell 0 linked');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=26076;
INSERT INTO conditions VALUES(22, 3, 26076, 0, 0, 29, 1, 25378, 35, 0, 1, 0, 0, '', "SAI condition, requires no npc with entry 25378 in 30yd");

-- Emergency Protocol Section 8.2, Paragraph D (11796)
UPDATE creature_template SET flags_extra=128, AIName='SmartAI' WHERE entry IN(25845, 25846, 25847);
DELETE FROM smart_scripts WHERE entryorguid IN(25845, 25846, 25847) AND source_type=0;
INSERT INTO smart_scripts VALUES (25845, 0, 0, 1, 8, 0, 100, 0, 46171, 0, 0, 0, 33, 25845, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (25846, 0, 0, 1, 8, 0, 100, 0, 46171, 0, 0, 0, 33, 25846, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (25847, 0, 0, 1, 8, 0, 100, 0, 46171, 0, 0, 0, 33, 25847, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (25845, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 182072, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'summon go linked');
INSERT INTO smart_scripts VALUES (25846, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 182072, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'summon go linked');
INSERT INTO smart_scripts VALUES (25847, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 182072, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'summon go linked');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46171;
INSERT INTO conditions VALUES(13, 1, 46171, 0, 0, 31, 0, 3, 25845, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 46171, 0, 1, 31, 0, 3, 25846, 0, 0, 0, 0, "", "");
INSERT INTO conditions VALUES(13, 1, 46171, 0, 2, 31, 0, 3, 25847, 0, 0, 0, 0, "", "");
DELETE FROM disables WHERE sourceType=0 AND entry=46171;
INSERT INTO disables VALUES (0, 46171, 64, '', '', 'Ignore LOS on Scuttle Wrecked Flying Machine');

-- Kaw the Mammoth Destroyer (11879)
UPDATE creature SET curhealth=17964 WHERE id=25743;
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(25802, 25881);
UPDATE creature_template SET npcflag=16777216, spell1=46317, spell2=46315, spell3=46316, Health_mod=2 WHERE entry=25743;
DELETE FROM smart_scripts WHERE entryorguid=25743 AND source_type=0;
INSERT INTO smart_scripts VALUES (25743, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 46221, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Death - Cast Animal Blood');
INSERT INTO smart_scripts VALUES (25743, 0, 1, 0, 0, 0, 100, 0, 3000, 9000, 9000, 18000, 11, 46316, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - In Combat - Cast Thundering Roar');
INSERT INTO smart_scripts VALUES (25743, 0, 2, 0, 27, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Wooly Mammoth Bull - On Passenger board - Set react state passive');
UPDATE creature_template SET unit_flags=0, AIName='SmartAI' WHERE entry=25802;
DELETE FROM smart_scripts WHERE entryorguid=25802 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25802*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25802, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaw - Reset - Make self unattackable');
INSERT INTO smart_scripts VALUES (25802, 0, 1, 0, 7, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3954.9, 5478.45, 35.7016, 4.39823, 'Kaw - Reset - Make self unattackable');
INSERT INTO smart_scripts VALUES (25802*100, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaw - Timed - Yell');
INSERT INTO smart_scripts VALUES (25802*100, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kaw - Timed - Enable Running');
INSERT INTO smart_scripts VALUES (25802*100, 9, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3974.17, 5476.31, 35.602, 5.564, 'Kaw - Timed - Move to Moria');
INSERT INTO smart_scripts VALUES (25802*100, 9, 3, 0, 0, 0, 100, 1, 2500, 2500, 0, 0, 11, 46260, 2, 0, 0, 0, 0, 19, 25881, 50, 0, 0, 0, 0, 0, 'Kaw - Timed - Mount to Moria');
UPDATE creature_template SET unit_flags=0, AIName='SmartAI' WHERE entry=25881;
DELETE FROM smart_scripts WHERE entryorguid=25881 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25881*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25881, 0, 0, 0, 8, 0, 100, 1, 46315, 0, 0, 0, 80, 25881*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - On spell hit - Start Event');
INSERT INTO smart_scripts VALUES (25881, 0, 1, 0, 8, 0, 100, 1, 46317, 0, 0, 0, 80, 25881*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - On spell hit - Start Event');
INSERT INTO smart_scripts VALUES (25881, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 19, 33536, 0, 0, 0, 0, 0, 19, 25802, 30, 0, 0, 0, 0, 0, 'Moria - On death - Make Kaw attackable');
INSERT INTO smart_scripts VALUES (25881, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - Reset - Set passive');
INSERT INTO smart_scripts VALUES (25881, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - Reset - Dismount Kaw');
INSERT INTO smart_scripts VALUES (25881*100, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 11, 17683, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - Timed - Heal self');
INSERT INTO smart_scripts VALUES (25881*100, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 80, 25802*100, 2, 0, 0, 0, 0, 19, 25802, 80, 0, 0, 0, 0, 0, 'Moria - Timed - Activate Kaw script');
INSERT INTO smart_scripts VALUES (25881*100, 9, 2, 0, 0, 0, 100, 1, 5500, 5500, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - Timed - Set aggresive');
INSERT INTO smart_scripts VALUES (25881*100, 9, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 11, 17683, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Moria - Timed - Heal self');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=25743;
INSERT INTO conditions VALUES (16, 0, 25743, 0, 0, 9, 0, 11879, 0, 0, 0, 0,  0, '', 'Vehicle Wooly Mammoth Bull requires quest 11879');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=25743;
INSERT INTO conditions VALUES (18, 25743, 46260, 0, 0, 9, 0, 11879, 0, 0, 0, 0,  0, '', 'Vehicle Wooly Mammoth Bull requires quest 11879');
DELETE FROM spell_area WHERE spell=46234;
INSERT INTO spell_area VALUES (46234, 3537, 11879, 0, 0, 0, 2, 1, 8, 0);
DELETE FROM creature_text WHERE entry=25802;
INSERT INTO creature_text VALUES (25802, 0, 0, 'You challenge Kaw, destroyer of mammoths? Then face me and feel my thunder!', 14, 0, 100, 0, 0, 0, 0, 'Kaw - Event Start Yell');

-- Breaking Through (11898)
DELETE FROM areatrigger_scripts WHERE entry=5339;
INSERT INTO areatrigger_scripts VALUES(5339, 'at_last_rites');

-- Patching Up (11894)
DELETE FROM gameobject WHERE id=188086;
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 4241.54, 5153.61, 13.0754, 2.20814, 0, 0, 0.893046, 0.449965, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3649.06, 4197.95, 16.817, 0.492043, 0, 0, 0.243547, 0.969889, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3850.5, 4884.73, -4.55864, 3.9046, 0, 0, 0.928106, -0.372316, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3813.33, 4471.39, 27.4984, 5.91771, 0, 0, 0.181722, -0.98335, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3751.68, 4549.81, 10.8374, 1.13857, 0, 0, 0.53903, 0.842287, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3815.53, 4611.2, 11.6697, 0.114409, 0, 0, 0.0571733, 0.998364, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 188086, 571, 1, 1, 3855.69, 4743.49, -5.76928, 1.18255, 0, 0, 0.55742, 0.830231, 300, 0, 1, 0);

-- Karuk's Oath (11613)
UPDATE quest_template SET NextQuestId=11613, NextQuestIdChain=11613 WHERE Id IN(11662, 12141);

-- Lupus Pupus (11728)
DELETE FROM smart_scripts WHERE entryorguid=25791 AND source_type=0;
INSERT INTO smart_scripts VALUES(25791, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, 45948, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oil-stained Wolf - On Respawn - Cast Oil Coat');
INSERT INTO smart_scripts VALUES(25791, 0, 1, 2, 8, 0, 100, 0, 53326, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oil-stained Wolf becomes friendly');
INSERT INTO smart_scripts VALUES(25791, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 46, 5, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Oil-stained Wolf moves forward');
INSERT INTO smart_scripts VALUES(25791, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 50, 187981, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oil-stained Wolf poops');
INSERT INTO smart_scripts VALUES(25791, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oil-stained Wolf despawns on poop.');

-- Nedar, Lord of Rhinos... (11884)
REPLACE INTO npc_spellclick_spells VALUES(25968, 67830, 1, 0);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25801);
DELETE FROM creature WHERE id=25801;
UPDATE creature_template SET AIName='CombatAI' WHERE entry=25968;
REPLACE INTO vehicle_template_accessory VALUES(25968, 25801, 0, 0, 'Nedar, Lord of Rhinos', 6, 30000);

-- Hatching a Plan (11936)
UPDATE gameobject_template SET data3=120000 WHERE entry=188133;

-- Master and Servant (11730)
DELETE FROM spell_area WHERE spell=46023;

-- It Was The Orcs, Honest! (11670)
DELETE FROM spell_script_names WHERE spell_id=45759;
INSERT INTO spell_script_names VALUES(45759, "spell_q11670_it_was_the_orcs_honest");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=45742;
INSERT INTO conditions VALUES (17, 0, 45742, 0, 0, 31, 1, 3, 25430, 0, 0, 0, 0, '', 'Requires Magmothregar');
INSERT INTO conditions VALUES (17, 0, 45742, 0, 0, 36, 1, 0, 0, 0, 1, 0, 0, '', 'Must be dead');
DELETE FROM spell_script_names WHERE spell_id=45742;
INSERT INTO spell_script_names VALUES(45742, "spell_q11670_it_was_the_orcs_honest");
UPDATE creature_template SET AIName='SmartAI' WHERE entry=25430;
DELETE FROM smart_scripts WHERE entryorguid=25430 AND source_type=0;
INSERT INTO smart_scripts VALUES(25430, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 50413, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Cast Spell');
INSERT INTO smart_scripts VALUES(25430, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 10000, 14000, 11, 50822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On OOC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(25430, 0, 2, 3, 8, 0, 100, 0, 45742, 0, 0, 0, 33, 25581, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES(25430, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');

-- Scouting the Sinkholes (11684)
-- Scouting the Sinkholes (11713)
UPDATE creature SET position_z=-15 WHERE id IN(25664, 25665, 25666);

-- Springing the Trap (11969)
REPLACE INTO creature_template_addon VALUES(26299, 0, 0, 0, 0, 0, '58951');
REPLACE INTO creature_template_addon VALUES(33087, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(26237, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(26310, 0, 0, 50331648, 0, 0, '');
DELETE FROM creature_text WHERE entry IN(26237, 26310);
INSERT INTO creature_text VALUES(26237, 0, 0, "Stay close to me, $N. I could not bear for any harm to come to you.", 12, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 1, 0, "MALYGOS!!", 14, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 2, 0, "Come, Lord of Magic, and recover your precious consort....", 14, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 3, 0, "...what remains of her!", 14, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 4, 0, "Come, $N. Let us see the fruits of our efforts.", 12, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 5, 0, "Hurry, $N! Flee! Live to finish what we've begun here....", 12, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26237, 6, 0, "Never!", 14, 0, 100, 0, 0, 0, 0, 'Keristrasza');
INSERT INTO creature_text VALUES(26310, 0, 0, "Keristrasza! You've bested my consort... and now YOU shall take her place!", 14, 0, 100, 0, 0, 0, 0, 'Malygos');
DELETE FROM creature WHERE id=33087;
INSERT INTO creature VALUES(NULL, 33087, 571, 1, 1, 0, 0, 4061.82, 7109.99, 187.889, 3.75826, 300, 0, 0, 42, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='NullCreatureAI', InhabitType=4 WHERE entry=26310;
UPDATE creature_template SET speed_run=1, AIName='SmartAI', InhabitType=4 WHERE entry=26237;
UPDATE creature_template SET modelid1=11686, modelid2=0, AIName='SmartAI', InhabitType=4 WHERE entry=33087;
DELETE FROM smart_scripts WHERE entryorguid=33087 AND source_type=0;
INSERT INTO smart_scripts VALUES(33087, 0, 0, 0, 8, 0, 100, 0, 62272, 0, 120000, 120000, 12, 26237, 8, 0, 0, 0, 0, 8, 0, 0, 0, 4106, 7070, 201, 2.6, 'On Spell Hit - Summon Creature');
DELETE FROM smart_scripts WHERE entryorguid=26237 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(26237*100, 26237*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES(26237, 0, 0, 0, 37, 0, 100, 1, 0, 0, 0, 0, 80, 26237*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES(26237, 0, 1, 0, 37, 0, 100, 1, 0, 0, 0, 0, 80, 26237*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES(26237*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 60, 1, 100, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Fly');
INSERT INTO smart_scripts VALUES(26237*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4063.72, 7084.12, 171, 3, 'Script9 - Move Pos');
INSERT INTO smart_scripts VALUES(26237*100, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Fly false');
INSERT INTO smart_scripts VALUES(26237*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run false');
INSERT INTO smart_scripts VALUES(26237*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte Flag');
INSERT INTO smart_scripts VALUES(26237*100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 4037.97, 7083.64, 167.71, 3.2, 'Script9 - Move Pos');
INSERT INTO smart_scripts VALUES(26237*100, 9, 8, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 12, 26299, 4, 70000, 0, 0, 0, 8, 0, 0, 0, 4025.15, 7082.42, 162.54, 0.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(26237*100, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 31962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(26237*100, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 75, 39199, 0, 0, 0, 0, 0, 11, 26299, 30, 0, 0, 0, 0, 0, 'Script9 - Add Aura');
INSERT INTO smart_scripts VALUES(26237*100, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100, 9, 13, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 46853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(26237*100, 9, 14, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100, 9, 15, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 86, 46814, 2, 21, 40, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast');
INSERT INTO smart_scripts VALUES(26237*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 26299, 30, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES(26237*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Fly false');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte Flag');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 26237, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Kill Credit');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 26310, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 3860, 6586, 234, 3.8, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 26310, 100, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 75, 65137, 0, 0, 0, 0, 0, 19, 26310, 100, 0, 0, 0, 0, 0, 'Script9 - Add Aura');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 46882, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 9, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 26310, 100, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES(26237*100+1, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
DELETE FROM event_scripts WHERE id=17499;
INSERT INTO event_scripts VALUES(17499, 2, 10, 26237, 300000, 0, 3789, 6534, 175.31, 1);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(46886, 62272);
INSERT INTO conditions VALUES (13, 1, 46886, 0, 0, 31, 0, 3, 26237, 0, 0, 0, 0, '', 'Requires Keristrasza');
INSERT INTO conditions VALUES (13, 1, 62272, 0, 0, 31, 0, 3, 33087, 0, 0, 0, 0, '', 'Requires Fire Trigger');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=26237;
INSERT INTO conditions VALUES (22, 1, 26237, 0, 0, 30, 1, 194151, 70, 0, 0, 0, 0, '', 'Requires GO In Range');
INSERT INTO conditions VALUES (22, 2, 26237, 0, 0, 30, 1, 194151, 70, 0, 1, 0, 0, '', 'Requires No GO In Range');

-- Foolish Endeavors (11705)
DELETE FROM creature_text WHERE entry IN(25729, 25618, 25751);
INSERT INTO creature_text VALUES(25729, 0, 0, "This is it, $N. The start of the end of the world. And you're here to see it off...", 12, 0, 100, 0, 0, 0, 0, 'Shadowstalker Getry');
INSERT INTO creature_text VALUES(25729, 1, 0, "Let's go...", 12, 0, 100, 0, 0, 0, 0, 'Shadowstalker Getry');
INSERT INTO creature_text VALUES(25729, 2, 0, "I... I can't believe it... Saurfang... I... I am honored... honored to have fought along side you, sir.", 12, 0, 100, 1, 0, 0, 0, 'Shadowstalker Getry');
INSERT INTO creature_text VALUES(25729, 3, 0, "You should return to Warsong Hold now, friend. Hellscream will surely want to hear of what just happened here... of Saurfang...", 12, 0, 100, 1, 0, 0, 0, 'Shadowstalker Getry');
INSERT INTO creature_text VALUES(25729, 4, 0, "Farewell...", 12, 0, 100, 0, 0, 0, 0, 'Shadowstalker Getry');
INSERT INTO creature_text VALUES(25618, 0, 0, "Is this it? Is this all the mighty Horde could muster?", 12, 0, 100, 0, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 1, 0, "Pathetic.", 12, 0, 100, 11, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 2, 0, "I've never understood your type. The hero...", 12, 0, 100, 0, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 3, 0, "Why won't you just let go? Why do you fight the inevitable?", 12, 0, 100, 1, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 4, 0, "The Lich King cannot be stopped. Accept it.", 12, 0, 100, 274, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 5, 0, "This world is coming to an end. Let. It. Burn.", 12, 0, 100, 25, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 6, 0, "Take him away and prepare him for reanimation.", 12, 0, 100, 1, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 7, 0, "What's this now?", 12, 0, 100, 1, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 8, 0, "Then you are a fool.", 12, 0, 100, 1, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 9, 0, "You? A lone orc? Against me and...", 12, 0, 100, 1, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25618, 10, 0, "RISE!", 14, 0, 100, 0, 0, 0, 0, 'Varidus the Flenser');
INSERT INTO creature_text VALUES(25751, 0, 0, "I'll rip out your shriveled heart with my bare hands before any harm comes to $N, Necromancer.", 12, 0, 100, 1, 0, 0, 0, 'High Overlord Saurfang');
INSERT INTO creature_text VALUES(25751, 1, 0, "You were never alone, $N.", 12, 0, 100, 0, 0, 0, 0, 'High Overlord Saurfang');
INSERT INTO creature_text VALUES(25751, 2, 0, "This world that you seek to destroy is our home.", 12, 0, 100, 1, 0, 0, 0, 'High Overlord Saurfang');
INSERT INTO creature_text VALUES(25751, 3, 0, "We will fight you with every fiber of our being- Until we are nothing more than dust and debris. We will fight until the end.", 12, 0, 100, 5, 0, 0, 0, 'High Overlord Saurfang');
INSERT INTO creature_text VALUES(25751, 4, 0, "A fool that is about to end you, Necrolord. There will be nothing left of you for the Lich King to reanimate!", 12, 0, 100, 1, 0, 0, 0, 'High Overlord Saurfang');
INSERT INTO creature_text VALUES(25751, 5, 0, "You'll make no mention of me. Either of you!", 12, 0, 100, 1, 0, 0, 0, 'High Overlord Saurfang');
DELETE FROM creature WHERE id=25624;
INSERT INTO creature VALUES (NULL, 25624, 571, 1, 1, 0, 0, 3112.36, 6527.99, 80.8751, 3.63029, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3116.76, 6524.07, 80.8485, 6.02139, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3122.21, 6510.26, 81.0079, 2.86234, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3121, 6502.85, 81.3337, 3.22886, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3114.64, 6501.5, 81.6178, 0.349066, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3120.76, 6495.86, 81.5926, 2.49582, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3099.79, 6524.31, 81.5106, 3.36848, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3120.45, 6486.97, 81.9426, 1.90241, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3109.11, 6498.78, 81.9249, 2.63545, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3104.28, 6528.08, 81.1888, 3.42085, 100, 0, 0, 5914, 0, 0, 0, 0, 0),
(NULL, 25624, 571, 1, 1, 0, 0, 3100.57, 6532.09, 81.1655, 6.23082, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3112.07, 6511.91, 81.3951, 5.14872, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3116.98, 6515.01, 81.08, 5.89921, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3126.8, 6505.61, 81.013, 3.90954, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3103.04, 6504.89, 82.0467, 3.94444, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3098.93, 6517.5, 81.775, 3.00197, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3115.22, 6492.26, 81.9308, 5.5676, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3109.38, 6506.75, 81.6883, 6.03884, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3126.14, 6514.96, 80.6848, 1.95477, 100, 0, 0, 5914, 0, 0, 0, 0, 0),
(NULL, 25624, 571, 1, 1, 0, 0, 3126.15, 6489.57, 81.6546, 2.14675, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3129.41, 6511.59, 80.7066, 2.72271, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3116.41, 6507.34, 81.3439, 5.81195, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3102.45, 6538.24, 80.8342, 1.58825, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3096.96, 6510.87, 82.0854, 0.558505, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3126.41, 6498.18, 81.302, 6.24828, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3108.6, 6531.9, 80.8754, 5.46288, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3105.6, 6534.98, 80.8596, 0.15708, 100, 0, 0, 5914, 0, 0, 0, 0, 0),
(NULL, 25624, 571, 1, 1, 0, 0, 3122.1, 6518.81, 80.7091, 1.81514, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3104.04, 6511.73, 81.8068, 3.45575, 100, 0, 0, 5914, 0, 0, 0, 0, 0),(NULL, 25624, 571, 1, 1, 0, 0, 3104.28, 6519.58, 81.5076, 6.17846, 100, 0, 0, 5914, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25729;
DELETE FROM smart_scripts WHERE entryorguid=25729 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(25729*100, 25729*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (25729, 0, 0, 1, 19, 0, 100, 0, 11705, 0, 0, 0, 53, 0, 25729, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (25729, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (25729, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 25729, 0, 0, 0, 0, 0, 19, 25618, 150, 0, 0, 0, 0, 0, 'On Quest Accept - Set Data');
INSERT INTO smart_scripts VALUES (25729, 0, 3, 0, 40, 0, 100, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Say Text');
INSERT INTO smart_scripts VALUES (25729, 0, 4, 5, 40, 0, 100, 0, 14, 0, 0, 0, 11, 58506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (25729, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Passive');
INSERT INTO smart_scripts VALUES (25729, 0, 6, 7, 8, 0, 100, 0, 45923, 0, 0, 0, 28, 58506, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Remove Aura');
INSERT INTO smart_scripts VALUES (25729, 0, 7, 8, 61, 0, 100, 0, 45923, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Home Position');
INSERT INTO smart_scripts VALUES (25729, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 25729*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Script9');
INSERT INTO smart_scripts VALUES (25729, 0, 9, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 25729*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Set Data - Script9');
INSERT INTO smart_scripts VALUES (25729*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25729*100, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25729*100, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25729*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (25729*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (25729*100+1, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 45922, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
UPDATE creature_template SET faction=1982, unit_flags=0, AIName='SmartAI', ScriptName='' WHERE entry=25618;
DELETE FROM smart_scripts WHERE entryorguid=25618 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25618*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25618, 0, 0, 1, 38, 0, 100, 0, 25729, 0, 0, 0, 80, 25618*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES (25618, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Flag');
INSERT INTO smart_scripts VALUES (25618, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 32711, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shadow Nova');
INSERT INTO smart_scripts VALUES (25618, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 15, 11705, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'On Death - Area Explored');
INSERT INTO smart_scripts VALUES (25618, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 25729, 40, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (25618*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 45908, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (25618*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (25618*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3125, 6534, 80.1, 0, 'Script9 - Move to Pos');
INSERT INTO smart_scripts VALUES (25618*100, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4.11, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (25618*100, 9, 4, 0, 0, 0, 100, 0, 32000, 32000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.52, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (25618*100, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Position');
INSERT INTO smart_scripts VALUES (25618*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 45923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (25618*100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 25730, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 3149, 6527, 80.84, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (25618*100, 9, 10, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 11, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 13, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 15, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 16, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 17, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 18, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25618*100, 9, 19, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 19, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flags');
INSERT INTO smart_scripts VALUES (25618*100, 9, 20, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove all auras');
INSERT INTO smart_scripts VALUES (25618*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 50329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (25618*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flags');
INSERT INTO smart_scripts VALUES (25618*100, 9, 23, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25751, 30, 0, 0, 0, 0, 0, 'Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (25618*100, 9, 24, 0, 0, 0, 100, 0, 100000, 100000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25729, 100, 0, 0, 0, 0, 0, 'Script9 - Fail Check');
INSERT INTO smart_scripts VALUES (25618*100, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25751, 100, 0, 0, 0, 0, 0, 'Script9 - Fail Check');
INSERT INTO smart_scripts VALUES (25618*100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Fail Check');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=25730;
UPDATE creature_template SET minlevel=70, maxlevel=70, mindmg=509, maxdmg=600 WHERE entry=25751;
DELETE FROM smart_scripts WHERE entryorguid=25730 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25730*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25730, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 25730*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES (25730, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 11, 24573, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Mortal Strike');
INSERT INTO smart_scripts VALUES (25730, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 11000, 11000, 11, 16044, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Cleave');
INSERT INTO smart_scripts VALUES (25730, 0, 3, 0, 0, 0, 100, 0, 10000, 10000, 30000, 40000, 11, 41097, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Whirlwind');
INSERT INTO smart_scripts VALUES (25730*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (25730*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flags');
INSERT INTO smart_scripts VALUES (25730*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (25730*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3126, 6539, 80.05, 0, 'Script9 - Move to Pos');
INSERT INTO smart_scripts VALUES (25730*100, 9, 4, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.52, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (25730*100, 9, 5, 0, 0, 0, 100, 0, 24000, 24000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4.11, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (25730*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 36, 25751, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Update Entry');
INSERT INTO smart_scripts VALUES (25730*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flags');
INSERT INTO smart_scripts VALUES (25730*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 1979, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (25730*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25730*100, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25730*100, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25730*100, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25730*100, 9, 13, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (25730*100, 9, 14, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 11, 45950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (25730*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flags');
INSERT INTO smart_scripts VALUES (25730*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 45949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (25730*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Pos');
UPDATE creature_template SET minlevel=65, maxlevel=70, faction=14, unit_flags=33554688, AIName='SmartAI' WHERE entry=25624;
UPDATE creature_template SET faction=1982 WHERE entry=25625;
DELETE FROM smart_scripts WHERE entryorguid=25624 AND source_type=0;
INSERT INTO smart_scripts VALUES (25624, 0, 0, 0, 8, 0, 100, 0, 45949, 0, 0, 0, 12, 25625, 4, 30000, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Summon Creature');
DELETE FROM waypoints WHERE entry=25729;
INSERT INTO waypoints VALUES (25729, 1, 3111.1, 6580.77, 94.8496, 'Shadowstalker Getry'),(25729, 2, 3110.1, 6586.86, 91.3752, 'Shadowstalker Getry'),(25729, 3, 3113.44, 6592.44, 91.3642, 'Shadowstalker Getry'),(25729, 4, 3119.61, 6593.75, 91.3783, 'Shadowstalker Getry'),(25729, 5, 3125.42, 6589.7, 91.3783, 'Shadowstalker Getry'),(25729, 6, 3125.23, 6582.04, 88.7871, 'Shadowstalker Getry'),(25729, 7, 3118.36, 6581.91, 86.2718, 'Shadowstalker Getry'),(25729, 8, 3117.46, 6584.56, 85.5313, 'Shadowstalker Getry'),(25729, 9, 3118.02, 6589.55, 83.4635, 'Shadowstalker Getry'),(25729, 10, 3120.6, 6589.66, 82.701, 'Shadowstalker Getry'),(25729, 11, 3127.65, 6590.03, 79.6948, 'Shadowstalker Getry'),(25729, 12, 3127.04, 6587.56, 79.2347, 'Shadowstalker Getry'),
(25729, 13, 3125.78, 6583.56, 77.7368, 'Shadowstalker Getry'),(25729, 14, 3123.47, 6576.21, 78.2142, 'Shadowstalker Getry'),(25729, 15, 3122.13, 6567.54, 79.0694, 'Shadowstalker Getry'),(25729, 16, 3124.17, 6554.2, 78.9804, 'Shadowstalker Getry');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=25730;
INSERT INTO conditions VALUES (22, 1, 25730, 0, 0, 29, 1, 25618, 40, 0, 0, 0, 0, '', 'Requires NPC nearby to run action');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45923;
INSERT INTO conditions VALUES (13, 1, 45923, 0, 0, 31, 0, 3, 25729, 0, 0, 0, 0, '', 'Requires Shadowstalker Getry');
INSERT INTO conditions VALUES (13, 1, 45923, 0, 1, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Requires Players');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45949;
INSERT INTO conditions VALUES (13, 1, 45949, 0, 0, 31, 0, 3, 25624, 0, 0, 0, 0, '', 'Requires Infested Prisoner');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(45923, 45950);
INSERT INTO spell_linked_spell VALUES(45923, 45922, 1, 'Shadow Prison Add');
INSERT INTO spell_linked_spell VALUES(45950, -45922, 1, 'Shadow Prison Remove');

-- Coward Delivery... Under 30 Minutes or it's Free (11711)
DELETE FROM gameobject WHERE id=187894;
INSERT INTO gameobject VALUES (NULL, 187894, 571, 1, 1, 2945.04, 5385.66, 60.5319, 4.5464, 0, 0, 0.76329, -0.646056, 300, 0, 1, 0);
REPLACE INTO spell_target_position VALUES (45956, 0, 571, 2921.65, 5347.06, 61.282, 1.07);
REPLACE INTO creature_template_addon VALUES (25761, 0, 0, 0, 0, 0, '45957');
UPDATE creature_template SET minlevel=80, maxlevel=80, unit_flags=0 WHERE entry=25761;
DELETE FROM creature_text WHERE entry IN(25379, 25759);
INSERT INTO creature_text VALUES (25379, 0, 0, "Try to not lose this one, $N. It is important that we at least try and keep up appearances with the Alliance.", 15, 0, 100, 0, 0, 0, 0, 'Warden Nork Bloodfrenzy');
INSERT INTO creature_text VALUES (25759, 0, 0, "Thank you, $r. I will take this miserable cur from you now.", 12, 0, 100, 0, 0, 0, 0, 'Warden Nork Bloodfrenzy');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9184;
INSERT INTO conditions VALUES(15, 9184, 0, 0, 0, 9, 0, 11711, 0, 0, 0, 0, 0, '', 'Coward Delivery');
INSERT INTO conditions VALUES(15, 9184, 0, 0, 0, 1, 0, 45963, 1, 0, 1, 0, 0, '', 'Didnt get soldier recently');
DELETE FROM gossip_menu_option WHERE menu_id=9184;
INSERT INTO gossip_menu_option VALUES(9184, 0, 0, "Give me one of the Alliance Deserters.", 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=25379;
DELETE FROM smart_scripts WHERE entryorguid=25379 AND source_type=0;
INSERT INTO smart_scripts VALUES (25379, 0, 0, 1, 62, 0, 100, 0, 9184, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Talk");
INSERT INTO smart_scripts VALUES (25379, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 45975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Cast Spell");
INSERT INTO smart_scripts VALUES (25379, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=45958;
INSERT INTO conditions VALUES (17, 0, 45958, 0, 0, 1, 0, 45957, 0, 0, 0, 0, 0, '', 'Requires Alliance Deserter Aura');
DELETE FROM spell_linked_spell WHERE spell_trigger=45958;
INSERT INTO spell_linked_spell VALUES (45958, 45956, 1, 'Signal Alliance');
REPLACE INTO creature_template_addon VALUES (25759, 0, 14584, 0, 0, 0, '');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=25759;
DELETE FROM smart_scripts WHERE entryorguid=25759 AND source_type=0;
INSERT INTO smart_scripts VALUES (25759, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2937.55, 5377.94, 60.64, 0, "On Update - Move To Pos");
INSERT INTO smart_scripts VALUES (25759, 0, 1, 2, 34, 0, 100, 1, 8, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "On Movement Inform - Talk");
INSERT INTO smart_scripts VALUES (25759, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 15, 11711, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, "On Movement Inform - Area Explored");
INSERT INTO smart_scripts VALUES (25759, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 25761, 50, 0, 0, 0, 0, 0, "On Movement Inform - Despawn Target");
INSERT INTO smart_scripts VALUES (25759, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Movement Inform - Despawn");

-- Unfit for Death (11865)
UPDATE item_template SET ScriptName='' WHERE entry=35127;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(46104, 46085);
INSERT INTO conditions VALUES (17, 0, 46104, 0, 0, 31, 1, 3, 0, 0, 0, 27, 0, '', 'Requires NPC');
INSERT INTO conditions VALUES (17, 0, 46085, 0, 0, 30, 0, 187982, 2, 0, 0, 22, 0, '', 'Requires Trap Nearby');
INSERT INTO conditions VALUES (17, 0, 46085, 0, 0, 29, 0, 25835, 5, 0, 1, 22, 0, '', 'Requires No Trapper Nearby');
INSERT INTO conditions VALUES (17, 0, 46085, 0, 0, 29, 0, 25835, 5, 1, 1, 22, 0, '', 'Requires No Trapper Nearby');
UPDATE gameobject SET id=187982 WHERE id IN(187982, 187995, 187996, 187997, 187998, 187999, 188000, 188001, 188002, 188003, 188004, 188005, 188006, 188007, 188008);
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=187982;
DELETE FROM smart_scripts WHERE entryorguid=187982 AND source_type=1;
INSERT INTO smart_scripts VALUES (187982, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject');
INSERT INTO smart_scripts VALUES (187982, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data');
INSERT INTO smart_scripts VALUES (187982, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Target');
INSERT INTO smart_scripts VALUES (187982, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set - Set Gameobject State');
INSERT INTO smart_scripts VALUES (187982, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set - Create Timed Event');
INSERT INTO smart_scripts VALUES (187982, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set - Kill Credit');
INSERT INTO smart_scripts VALUES (187982, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event - Set Loot State');
UPDATE creature_template SET unit_flags=768, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=25835;
DELETE FROM smart_scripts WHERE entryorguid=25835 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=25835*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (25835, 0, 0, 1, 38, 0, 100, 1, 1, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 20, 187983, 30, 0, 1, 0, 0, 0, 'Nesingwary Trapper - On Data Set - Move To Position');
INSERT INTO smart_scripts VALUES (25835, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Data Set - Set Visible');
INSERT INTO smart_scripts VALUES (25835, 0, 2, 3, 11, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Respawn - Set Visible false');
INSERT INTO smart_scripts VALUES (25835, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Respawn - Set React Passive');
INSERT INTO smart_scripts VALUES (25835, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 80, 25835*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Movement Inform - Run Script');
INSERT INTO smart_scripts VALUES (25835*100, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 66, 0, 0, 0, 0, 0, 0, 20, 187983, 5, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Set Orientation');
INSERT INTO smart_scripts VALUES (25835*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (25835*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Set Bytes0');
INSERT INTO smart_scripts VALUES (25835*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, 187982, 5, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Set Data');
INSERT INTO smart_scripts VALUES (25835*100, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Die');
INSERT INTO smart_scripts VALUES (25835*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Script - Despawn');
DELETE FROM creature WHERE id=25835;
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3051.26, 5270.73, 60.5525, 3.11829, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3101.92, 5282.08, 59.4452, 2.97692, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3061.11, 5319.11, 59.7241, 6.15315, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3097.68, 5340.91, 55.5327, 3.1772, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3142.19, 5315.46, 53.1699, 0.172346, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3134.4, 5250.91, 59.2967, 0.0663204, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3018.35, 5334.55, 63.3825, 3.16542, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2975.63, 5331.37, 63.1262, 3.25182, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2995.56, 5290.19, 61.3343, 3.20077, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2940.88, 5295.13, 61.674, 3.1183, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2971.01, 5245.36, 58.9515, 3.08296, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2924.41, 5216.49, 59.4083, 3.19291, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 2913.67, 5262.68, 61.6815, 3.20862, 180, 0, 0, 8982, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3079.2, 5234.41, 63.5527, 2.988, 180, 0, 0, 9291, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 25835, 571, 1, 1, 0, 1, 3012.67, 5231.05, 63.7945, 3.32965, 180, 0, 0, 9291, 0, 0, 0, 0, 0);

-- Cutting Off the Source (11602)
UPDATE gameobject_template SET data3=120000 WHERE entry=187655;

-- Bring 'Em Back Alive (11690)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=25596;
INSERT INTO conditions VALUES (16, 0, 25596, 0, 0, 23, 0, 3537, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');
INSERT INTO conditions VALUES (16, 0, 25596, 0, 1, 23, 0, 4141, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');
INSERT INTO conditions VALUES (16, 0, 25596, 0, 2, 23, 0, 4144, 0, 0, 0, 0, 0, '', 'Dismount player when not in intended zone');

-- The Collapse (11706)
-- Deploy the Shake-n-Quake! (11723)
DELETE FROM event_scripts WHERE id IN (16929, 17084);
INSERT INTO event_scripts VALUES (16929, 1, 10, 25742, 60000, 0, 3505.78, 4558.70, -12.98, 4.16); -- Alluvion
INSERT INTO event_scripts VALUES (17084, 1, 10, 25794, 60000, 0, 3505.78, 4558.70, -12.98, 4.16); -- Shake-n-Quake 5000
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(25742, 25794);
DELETE FROM smart_scripts WHERE entryorguid IN(25742, 25794) AND source_type=0;
INSERT INTO smart_scripts VALUES (25742, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Set Run");
INSERT INTO smart_scripts VALUES (25742, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3496.6, 4541.05, -12.98, 0, "On Respawn - Move Point");
INSERT INTO smart_scripts VALUES (25742, 0, 2, 0, 34, 0, 100, 1, 8, 1, 0, 0, 12, 25629, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 3458.33, 4522.1, -12.99, 1.11, "MovementInform - Summon Creature");
INSERT INTO smart_scripts VALUES (25742, 0, 3, 4, 60, 0, 100, 1, 18000, 18000, 0, 0, 33, 25742, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, "On Update - Kill Credit");
INSERT INTO smart_scripts VALUES (25742, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Despawn");
INSERT INTO smart_scripts VALUES (25794, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Set Run");
INSERT INTO smart_scripts VALUES (25794, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3496.6, 4541.05, -12.98, 0, "On Respawn - Move Point");
INSERT INTO smart_scripts VALUES (25794, 0, 2, 0, 34, 0, 100, 1, 8, 1, 0, 0, 12, 25629, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 3458.33, 4522.1, -12.99, 1.11, "MovementInform - Summon Creature");
INSERT INTO smart_scripts VALUES (25794, 0, 3, 4, 60, 0, 100, 1, 18000, 18000, 0, 0, 33, 25794, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, "On Update - Kill Credit");
INSERT INTO smart_scripts VALUES (25794, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Despawn");
DELETE FROM creature_text WHERE entry=25629;
INSERT INTO creature_text VALUES (25629, 0, 0, "Feebleminded tinkerer, do you really think that your pathetic creation can stop me?", 14, 0, 100, 0, 0, 0, 0, 'Lord Kryxix');
UPDATE creature_template SET unit_flags=768, AIName='SmartAI', ScriptName='' WHERE entry=25629;
DELETE FROM smart_scripts WHERE entryorguid=25629 AND source_type=0;
INSERT INTO smart_scripts VALUES (25629, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Set Run");
INSERT INTO smart_scripts VALUES (25629, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3496.6, 4541.05, -12.98, 0, "On Respawn - Move Point");
INSERT INTO smart_scripts VALUES (25629, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Talk");
INSERT INTO smart_scripts VALUES (25629, 0, 3, 0, 34, 0, 100, 1, 8, 1, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "MovementInform - Remove Unit Flags");

-- Last Rites (12019)
DELETE FROM script_waypoint WHERE entry=26170;
DELETE FROM gossip_menu_option WHERE menu_id=9417;
INSERT INTO gossip_menu_option VALUES (9417, 0, 0, 'Let''s do this, Thassarian. It''s now or never.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9417;
INSERT INTO conditions VALUES (15, 9417, 0, 0, 0, 23, 0, 4128, 0, 0, 0, 0, 0, '', 'Requires specific area');
INSERT INTO conditions VALUES (15, 9417, 0, 0, 0, 9, 0, 12019, 0, 0, 0, 0, 0, '', 'Requires Quest active');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(25250, 25251) AND guid IN(111277, 111300));
DELETE FROM creature WHERE id IN(25250, 25251) AND guid IN(111277, 111300);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=26170;
DELETE FROM smart_scripts WHERE entryorguid=26170 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(26170*100, 26170*100+1, 26170*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (26170, 0, 0, 0, 62, 0, 100, 0, 9417, 0, 0, 0, 53, 0, 26170, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Gossip Select - Start Escort');
INSERT INTO smart_scripts VALUES (26170, 0, 1, 2, 40, 0, 100, 0, 3, 0, 0, 0, 54, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On WP Reach - Pause WP');
INSERT INTO smart_scripts VALUES (26170, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 26170*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On WP Reach - Start Script');
INSERT INTO smart_scripts VALUES (26170, 0, 3, 4, 38, 0, 100, 0, 4, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Data Set - Talk');
INSERT INTO smart_scripts VALUES (26170, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Data Set - Set Run');
INSERT INTO smart_scripts VALUES (26170, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Data Set - Resume Path');
INSERT INTO smart_scripts VALUES (26170, 0, 6, 7, 40, 0, 100, 0, 4, 0, 0, 0, 54, 600000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On WP Reach - Pause WP');
INSERT INTO smart_scripts VALUES (26170, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 26170*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On WP Reach - Start Script');
INSERT INTO smart_scripts VALUES (26170, 0, 8, 0, 38, 0, 100, 0, 6, 6, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Data Set - Resume Path');
INSERT INTO smart_scripts VALUES (26170, 0, 9, 10, 40, 0, 100, 0, 5, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.31, 'Thassarian - On WP Reach - Set Orientation');
INSERT INTO smart_scripts VALUES (26170, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 26170*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On WP Reach - Start Script');
INSERT INTO smart_scripts VALUES (26170, 0, 11, 0, 11, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Respawn - Remove Bytes1');
INSERT INTO smart_scripts VALUES (26170*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 26203, 4, 240000, 0, 0, 0, 8, 0, 0, 0, 3730.313, 3518.689, 473.324, 1.562, 'Thassarian - On Script - Summon Creature');
INSERT INTO smart_scripts VALUES (26170*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 26203, 120, 0, 0, 0, 0, 0, 'Thassarian - On Script - Store Target Image of the Lich King');
INSERT INTO smart_scripts VALUES (26170*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 25301, 4, 240000, 0, 0, 0, 8, 0, 0, 0, 3747.230, 3614.936, 473.321, 4.462, 'Thassarian - On Script - Summon Creature');
INSERT INTO smart_scripts VALUES (26170*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 2, 0, 0, 0, 0, 0, 19, 25301, 120, 0, 0, 0, 0, 0, 'Thassarian - On Script - Store Target Counselor Talbot');
INSERT INTO smart_scripts VALUES (26170*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100, 9, 5, 0, 0, 0, 100, 0, 22000, 22000, 0, 0, 36, 28189, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Update Entry');
INSERT INTO smart_scripts VALUES (26170*100, 9, 6, 0, 0, 0, 100, 0, 500, 500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Bytes1');
INSERT INTO smart_scripts VALUES (26170*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Unit Flag');
INSERT INTO smart_scripts VALUES (26170*100, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 0');
INSERT INTO smart_scripts VALUES (26170*100, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 0');
INSERT INTO smart_scripts VALUES (26170*100, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 1');
INSERT INTO smart_scripts VALUES (26170*100, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 25250, 4, 240000, 0, 0, 0, 8, 0, 0, 0, 3745.5271, 3615.655029, 473.321533, 4.447805, 'Thassarian - On Script - Summon Creature');
INSERT INTO smart_scripts VALUES (26170*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 25251, 4, 240000, 0, 0, 0, 8, 0, 0, 0, 3749.654541, 3614.959717, 473.323486, 4.524959, 'Thassarian - On Script - Summon Creature');
INSERT INTO smart_scripts VALUES (26170*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 25250, 80, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 25251, 80, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 91, 255, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Remove Bytes1');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 3, 3, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 2');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 2');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Despawn');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 3');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 5, 5, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100+1, 9, 9, 0, 0, 0, 100, 0, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Attack Start');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25250, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 0');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25250, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 1');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 19, 25250, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Remove Auras');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 19, 25250, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set bytes1');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Remove Auras');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 0');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set bytes1');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 8, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 7, 7, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Set Data');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 9, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 1');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 11, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 2');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 12, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 13, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk Target 3');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 14, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Talk');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 15, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25250, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Despawn Target');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 25251, 50, 0, 0, 0, 0, 0, 'Thassarian - On Script - Despawn Target');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 28189, 50, 1, 0, 0, 0, 0, 'Thassarian - On Script - Despawn Target');
INSERT INTO smart_scripts VALUES (26170*100+2, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On Script - Despawn');
DELETE FROM waypoints WHERE entry=26170;
INSERT INTO waypoints VALUES (26170, 1, 3700.08, 3574.54, 473.322, 'Thassarin'),(26170, 2, 3707.26, 3573.78, 477.41, 'Thassarin'),(26170, 3, 3714.32, 3572.3, 477.442, 'Thassarin'),
(26170, 4, 3727.66, 3567.63, 477.34, 'Thassarin'),(26170, 5, 3717.94, 3563.50, 477.44, 'Thassarin');
UPDATE creature_template SET faction=14, flags_extra=2 WHERE entry=28189;
UPDATE creature_template SET faction=14, unit_flags=256+512, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=26203;
DELETE FROM smart_scripts WHERE entryorguid=26203 AND source_type=0;
INSERT INTO smart_scripts VALUES (26203, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Image of the Lich King - On Respawn - Set Run False');
INSERT INTO smart_scripts VALUES (26203, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3737.374756, 3564.841309, 477.433014, 0, 'Image of the Lich King - On Respawn - Move to Pos');
INSERT INTO smart_scripts VALUES (26203, 0, 2, 3, 38, 0, 100, 1, 3, 3, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 26170, 50, 0, 0, 0, 0, 0, 'Image of the Lich King - On Data Set - Set Orientation');
INSERT INTO smart_scripts VALUES (26203, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Image of the Lich King - On Data Set - Talk');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25301;
DELETE FROM smart_scripts WHERE entryorguid=25301 AND source_type=0;
INSERT INTO smart_scripts VALUES (25301, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 145, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - Is Summoned - No Event Phase Reset');
INSERT INTO smart_scripts VALUES (25301, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - Is Summoned - Set Event Phase');
INSERT INTO smart_scripts VALUES (25301, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - Is Summoned - Set NPC Flags 0');
INSERT INTO smart_scripts VALUES (25301, 0, 3, 4, 38, 1, 100, 1, 2, 2, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Data Set - Set Run');
INSERT INTO smart_scripts VALUES (25301, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3738.000977, 3568.882080, 477.433014, 0, 'Counselor Talbot - On Data Set - Move to Pos');
INSERT INTO smart_scripts VALUES (25301, 0, 5, 0, 38, 1, 100, 1, 5, 5, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Data Set - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (25301, 0, 6, 7, 6, 1, 100, 0, 0, 0, 0, 0, 45, 6, 6, 0, 0, 0, 0, 19, 26170, 80, 0, 0, 0, 0, 0, 'Counselor Talbot - On Death - Set Data');
INSERT INTO smart_scripts VALUES (25301, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 33, 28189, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - On Death - Kill Credit');
INSERT INTO smart_scripts VALUES (25301, 0, 8, 0, 0, 1, 100, 0, 3000, 5000, 5000, 7000, 11, 15537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Counselor Talbot - In Combat - Cast Spell');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25250;
DELETE FROM smart_scripts WHERE entryorguid=25250 AND source_type=0;
INSERT INTO smart_scripts VALUES (25250, 0, 0, 1, 38, 0, 100, 1, 3, 3, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - On Data Set - Set Run');
INSERT INTO smart_scripts VALUES (25250, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3735.570068, 3572.419922, 477.441010, 0, 'General Arlos - Movement Inform - Move to Position');
INSERT INTO smart_scripts VALUES (25250, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 11, 46957, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Movement Inform - Cast Cosmetic - Stun (Permanent)');
INSERT INTO smart_scripts VALUES (25250, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'General Arlos - Is Summoned - Set NPC Flags 0');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=25251;
DELETE FROM smart_scripts WHERE entryorguid=25251 AND source_type=0;
INSERT INTO smart_scripts VALUES (25251, 0, 0, 1, 38, 0, 100, 1, 3, 3, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Data Set - Set Run');
INSERT INTO smart_scripts VALUES (25251, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3741.969971, 3571.439941, 477.441010, 0, 'Leryssa - On Data Set - Move to Pos');
INSERT INTO smart_scripts VALUES (25251, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Data Set - Set React State');
INSERT INTO smart_scripts VALUES (25251, 0, 3, 4, 34, 0, 100, 0, 8, 1, 0, 0, 11, 46957, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Movement Inform - Cast Cosmetic - Stun (Permanent)');
INSERT INTO smart_scripts VALUES (25251, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 4, 4, 0, 0, 0, 0, 19, 26170, 50, 0, 0, 0, 0, 0, 'Leryssa - Movement Inform - Set Data');
INSERT INTO smart_scripts VALUES (25251, 0, 5, 6, 38, 0, 100, 1, 7, 7, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - On Data Set - Set Run');
INSERT INTO smart_scripts VALUES (25251, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3722.114502, 3564.201660, 477.441437, 0, 'Leryssa - On Data Set - Move to Pos');
INSERT INTO smart_scripts VALUES (25251, 0, 7, 0, 34, 0, 100, 0, 8, 2, 0, 0, 90, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Movement Inform - Set Bytes1');
INSERT INTO smart_scripts VALUES (25251, 0, 8, 0, 54, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Leryssa - Is Summoned - Set NPC Flags 0');

-- Monitoring the Rift: Cleftcliff Anomaly (11576)
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid=25310 AND source_type=0;

-- Hah... You're Not So Big Now! (11653)
DELETE FROM spell_script_names WHERE spell_id=45668;
INSERT INTO spell_script_names VALUES (45668, 'spell_q11653_youre_not_so_big_now');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(25432, 25434);
INSERT INTO conditions VALUES (22, 4, 25432, 0, 0, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 0, 1, 1, 45672, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 1, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 1, 1, 1, 45673, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 2, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 2, 1, 1, 45677, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 3, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 4, 25432, 0, 3, 1, 1, 45681, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 0, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 0, 1, 1, 45672, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 1, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 1, 1, 1, 45673, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 2, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 2, 1, 1, 45677, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 3, 9, 0, 11653, 0, 0, 0, 0, 0, '', 'Requires Quest Taken');
INSERT INTO conditions VALUES (22, 1, 25434, 0, 3, 1, 1, 45681, 0, 0, 0, 0, 0, '', 'Requires Specific Aura');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(25432, 25434);
DELETE FROM smart_scripts WHERE entryorguid IN(25432, 25434) AND source_type=0;
INSERT INTO smart_scripts VALUES (25432, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 50420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Mate of Magmothregar - Between 0-30% Health - Cast 'Enrage' (No Repeat)");
INSERT INTO smart_scripts VALUES (25432, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Mate of Magmothregar - Between 0-30% Health - Say Line 0 (No Repeat)");
INSERT INTO smart_scripts VALUES (25432, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 11, 45691, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Mate of Magmothregar - On Just Died - Cast 'Hah... : Magnataur On Death 1' (No Repeat)");
INSERT INTO smart_scripts VALUES (25432, 0, 3, 0, 6, 0, 100, 1, 0, 0, 0, 0, 33, 25505, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Mate of Magmothregar - On Just Died - Kill Credit");
INSERT INTO smart_scripts VALUES (25434, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 33, 25505, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Magmoth Crusher - On Just Died - Kill Credit");

-- Oh Noes, the Tadpoles! (11560)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=25201);
DELETE FROM creature WHERE id=25201;
UPDATE gameobject_template SET AIName='', ScriptName='go_tadpole_cage' WHERE entry=187373;

-- Taken by the Scourge (11611)
UPDATE creature SET spawntimesecs=20 WHERE id=25284;

-- Drake Hunt (11919)
-- Drake Hunt (11940)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=46607;
INSERT INTO conditions VALUES (17, 0, 46607, 0, 0, 31, 1, 3, 26127, 0, 0, 0, 0, '', 'Requires Nexus Drake Hatchling');
INSERT INTO conditions VALUES (17, 0, 46607, 0, 0, 1, 1, 46620, 0, 0, 1, 0, 0, '', 'Does not have Red Dragonblood Aura');
INSERT INTO conditions VALUES (17, 0, 46607, 0, 0, 1, 1, 46675, 0, 0, 1, 0, 0, '', 'Does not have Subdued Aura');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=46704;
INSERT INTO conditions VALUES (13, 1, 46704, 0, 0, 31, 0, 3, 26127, 0, 0, 0, 0, '', 'Target Nexus Drake Hatchling');
DELETE FROM spell_script_names WHERE spell_id=46620;
INSERT INTO spell_script_names VALUES (46620, 'spell_q11919_q11940_drake_hunt');
UPDATE creature_template SET speed_walk=2, speed_run=2, AIName='SmartAI', ScriptName='' WHERE entry=26127;
DELETE FROM smart_scripts WHERE entryorguid=26127 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=26127*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (26127, 0, 0, 0, 0, 0, 100, 0, 12000, 15000, 25000, 35000, 11, 36631, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - In Combat - Cast Netherbreath');
INSERT INTO smart_scripts VALUES (26127, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 20000, 35000, 11, 36513, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - In Combat - Cast Intangible Presence');
INSERT INTO smart_scripts VALUES (26127, 0, 2, 3, 8, 0, 100, 0, 46607, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Store Target');
INSERT INTO smart_scripts VALUES (26127, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 86, 46620, 2, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Cross Cast Spell Red Dragonblood');
INSERT INTO smart_scripts VALUES (26127, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Attack Start');
INSERT INTO smart_scripts VALUES (26127, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Reset - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (26127, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Reset - Remove Bytes 1');
INSERT INTO smart_scripts VALUES (26127, 0, 7, 0, 38, 0, 100, 1, 1, 26127, 0, 0, 80, 26127*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Data Set - Start Script');
INSERT INTO smart_scripts VALUES (26127, 0, 8, 9, 8, 0, 100, 1, 46704, 0, 0, 0, 11, 46703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Cast Complete Immolation');
INSERT INTO smart_scripts VALUES (26127, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Set Bytes 1');
INSERT INTO smart_scripts VALUES (26127, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (26127*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 33, 26175, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Script9 - Killed Monster Credit');
INSERT INTO smart_scripts VALUES (26127*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 46607, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Script9 - Remove Aura');
INSERT INTO smart_scripts VALUES (26127*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3573.02, 6651.63, 195.20, 0, 'Nexus Drake Hatchling - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (26127*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 26117, 30, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Script9 - Say Line 0 Target');
INSERT INTO smart_scripts VALUES (26127*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 86, 46704, 0, 19, 26117, 30, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nexus Drake Hatchling - Script9 - Cross Cast Raelorasz Fireball');

-- Escape from the Winterfin Caverns (11570)
UPDATE gameobject_template SET data11=0 WHERE entry=187369;

-- The Plains of Nasam (11652)
UPDATE creature_template SET speed_run=2.5 WHERE entry=25334;
UPDATE creature SET curhealth=44910, curmana=15775 WHERE id=25334;

-- Abduction (11590)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=45611;
INSERT INTO conditions VALUES (17, 0, 45611, 0, 0, 31, 1, 3, 25316, 0, 0, 0, 0, '', 'Requires Beryl Sorcerer');
INSERT INTO conditions VALUES (17, 0, 45611, 0, 0, 38, 1, 25, 4, 0, 0, 0, 0, '', 'Health LEQ 25%');

-- Orabus the Helmsman (11661)
DELETE FROM creature_text WHERE entry IN(32576, 32577, 32578, 32579, 32580);
INSERT INTO creature_text VALUES (32577, 0, 0, 'Aye, captain!', 14, 0, 100, 0, 0, 0, 0, 'Kvaldir Crewman');
INSERT INTO creature_text VALUES (32578, 0, 0, 'Aye, captain!', 14, 0, 100, 0, 0, 0, 0, 'Kvaldir Crewman');
INSERT INTO creature_text VALUES (32579, 0, 0, 'Aye, captain!', 14, 0, 100, 0, 0, 0, 0, 'Kvaldir Crewman');
INSERT INTO creature_text VALUES (32580, 0, 0, 'Aye, captain!', 14, 0, 100, 0, 0, 0, 0, 'Kvaldir Crewman');
INSERT INTO creature_text VALUES (32576, 0, 0, 'The Helmsman comes for you!', 14, 0, 100, 0, 0, 0, 0, 'Orabus the Helmsman');
INSERT INTO creature_text VALUES (32576, 1, 0, 'A child has found a new toy! Crewman, take this infant''s toy away!', 14, 0, 100, 0, 0, 0, 0, 'Orabus the Helmsman');
INSERT INTO creature_text VALUES (32576, 1, 1, 'Crewman, show this ant the might of the Kvaldir!', 14, 0, 100, 0, 0, 0, 0, 'Orabus the Helmsman');
INSERT INTO creature_text VALUES (32576, 1, 2, 'Crewman, tear this land walker apart!', 14, 0, 100, 0, 0, 0, 0, 'Orabus the Helmsman');
INSERT INTO creature_text VALUES (32576, 2, 0, 'Now you face Orabus, fool!', 14, 0, 100, 0, 0, 0, 0, 'Orabus the Helmsman');
UPDATE creature_template SET faction=35, unit_flags=33554432|256|512, flags_extra=2, VehicleId=91, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=27939;
DELETE FROM npc_spellclick_spells WHERE npc_entry=27939;
INSERT INTO npc_spellclick_spells VALUES (27939, 67830, 1, 0);
DELETE FROM vehicle_template_accessory WHERE entry=27939;
INSERT INTO vehicle_template_accessory VALUES(27939, 32576, 0, 0, 'Orabus the Helmsman', 8, 0);
INSERT INTO vehicle_template_accessory VALUES(27939, 32577, 1, 0, 'Kvaldir Crewman', 8, 0);
INSERT INTO vehicle_template_accessory VALUES(27939, 32578, 2, 0, 'Kvaldir Crewman', 8, 0);
INSERT INTO vehicle_template_accessory VALUES(27939, 32579, 3, 0, 'Kvaldir Crewman', 8, 0);
INSERT INTO vehicle_template_accessory VALUES(27939, 32580, 4, 0, 'Kvaldir Crewman', 8, 0);
DELETE FROM event_scripts WHERE id=16889;
INSERT INTO event_scripts VALUES (16889, 0, 10, 27939, 900000, 0, 2946.24, 7152.2, 0, 3.3);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=45703;
INSERT INTO conditions VALUES(17, 0, 45703, 0, 0, 29, 0, 27939, 150, 0, 1, 22, 0, '', 'Require no Helsman Ship nearby');
DELETE FROM waypoints WHERE entry=27939;
INSERT INTO waypoints VALUES (27939, 1, 2946.24, 7152.2, 0, ''),(27939, 2, 2931.26, 7153.2, 0, ''),(27939, 3, 2916.46, 7152.34, 0, ''),(27939, 4, 2897.57, 7149.77, 0, ''),(27939, 5, 2878.1, 7145.18, 0, ''),(27939, 6, 2866.07, 7138.85, 0, ''),(27939, 7, 2852.79, 7128.81, 0, ''),(27939, 8, 2839.89, 7115.62, 0, ''),(27939, 9, 2828.82, 7100.94, 0, ''),(27939, 10, 2821.8, 7083.66, 0, ''),(27939, 11, 2817.54, 7067.62, 0, ''),(27939, 12, 2815.58, 7057.83, 0, '');
DELETE FROM smart_scripts WHERE entryorguid=27939 AND source_type=0;
INSERT INTO smart_scripts VALUES (27939, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On AI Init - Set Active');
INSERT INTO smart_scripts VALUES (27939, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 53, 1, 27939, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Start WP');
INSERT INTO smart_scripts VALUES (27939, 0, 2, 3, 60, 0, 100, 257, 600000, 600000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32577, 100, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (27939, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32578, 100, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (27939, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32579, 100, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (27939, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32580, 100, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (27939, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32576, 100, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Target');
INSERT INTO smart_scripts VALUES (27939, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Update - Despawn Self');
INSERT INTO smart_scripts VALUES (27939, 0, 8, 0, 40, 0, 100, 0, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 32576, 30, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On WP Reached - Talk Target');
INSERT INTO smart_scripts VALUES (27939, 0, 9, 0, 40, 0, 100, 0, 12, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 32576, 30, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On WP Reached - Set Data');
INSERT INTO smart_scripts VALUES (27939, 0, 10, 0, 38, 0, 100, 0, 3, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Helsman''s Ship - On Data Set - Despawn');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=32576;
DELETE FROM smart_scripts WHERE entryorguid=32576 AND source_type=0;
INSERT INTO smart_scripts VALUES (32576, 0, 0, 1, 38, 0, 100, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (32576, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 32577, 50, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Set Data');
INSERT INTO smart_scripts VALUES (32576, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (32576, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 32578, 50, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Set Data');
INSERT INTO smart_scripts VALUES (32576, 0, 4, 5, 38, 0, 100, 0, 1, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (32576, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 32579, 50, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Set Data');
INSERT INTO smart_scripts VALUES (32576, 0, 6, 7, 38, 0, 100, 0, 1, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Say Line 1');
INSERT INTO smart_scripts VALUES (32576, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 32580, 50, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Set Data');
INSERT INTO smart_scripts VALUES (32576, 0, 8, 0, 38, 0, 100, 0, 1, 4, 0, 0, 1, 2, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Data Set - Say Line 2');
INSERT INTO smart_scripts VALUES (32576, 0, 9, 10, 52, 0, 100, 0, 2, 32576, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2802.18, 7054.91, -0.6, 4.67, 'Orabus the Helmsman - On Text Over - Set Home Position');
INSERT INTO smart_scripts VALUES (32576, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Text Over - Exit Vehicle');
INSERT INTO smart_scripts VALUES (32576, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Text Over - Attack Start');
INSERT INTO smart_scripts VALUES (32576, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 3, 0, 0, 0, 0, 0, 19, 27939, 150, 0, 0, 0, 0, 0, 'Orabus the Helmsman - On Death - Set Data');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(32577, 32578, 32579, 32580);
DELETE FROM smart_scripts WHERE entryorguid IN(32577, 32578, 32579, 32580) AND source_type=0;
INSERT INTO smart_scripts VALUES (32577, 0, 0, 7, 38, 0, 100, 0, 2, 2, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (32577, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2802.18, 7054.91, -0.6, 4.67, 'Kvaldir Crewman - On Data Set - Set Home Position');
INSERT INTO smart_scripts VALUES (32577, 0, 1, 2, 52, 0, 100, 0, 0, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Exit Vehicle');
INSERT INTO smart_scripts VALUES (32577, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Attack Start');
INSERT INTO smart_scripts VALUES (32577, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Set Emote State');
INSERT INTO smart_scripts VALUES (32577, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 32576, 150, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Death - Set Data');
INSERT INTO smart_scripts VALUES (32577, 0, 6, 0, 60, 0, 100, 257, 0, 0, 0, 0, 17, 419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Update - Set Emote State');
INSERT INTO smart_scripts VALUES (32578, 0, 0, 7, 38, 0, 100, 0, 2, 2, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (32578, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2802.18, 7054.91, -0.6, 4.67, 'Kvaldir Crewman - On Data Set - Set Home Position');
INSERT INTO smart_scripts VALUES (32578, 0, 1, 2, 52, 0, 100, 0, 0, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Exit Vehicle');
INSERT INTO smart_scripts VALUES (32578, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Attack Start');
INSERT INTO smart_scripts VALUES (32578, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Set Emote State');
INSERT INTO smart_scripts VALUES (32578, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 32576, 150, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Death - Set Data');
INSERT INTO smart_scripts VALUES (32578, 0, 6, 0, 60, 0, 100, 257, 0, 0, 0, 0, 17, 419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Update - Set Emote State');
INSERT INTO smart_scripts VALUES (32579, 0, 0, 7, 38, 0, 100, 0, 2, 2, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (32579, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2802.18, 7054.91, -0.6, 4.67, 'Kvaldir Crewman - On Data Set - Set Home Position');
INSERT INTO smart_scripts VALUES (32579, 0, 1, 2, 52, 0, 100, 0, 0, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Exit Vehicle');
INSERT INTO smart_scripts VALUES (32579, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Attack Start');
INSERT INTO smart_scripts VALUES (32579, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Set Emote State');
INSERT INTO smart_scripts VALUES (32579, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 32576, 150, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Death - Set Data');
INSERT INTO smart_scripts VALUES (32579, 0, 6, 0, 60, 0, 100, 257, 0, 0, 0, 0, 17, 419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Update - Set Emote State');
INSERT INTO smart_scripts VALUES (32580, 0, 0, 7, 38, 0, 100, 0, 2, 2, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (32580, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2802.18, 7054.91, -0.6, 4.67, 'Kvaldir Crewman - On Data Set - Set Home Position');
INSERT INTO smart_scripts VALUES (32580, 0, 1, 2, 52, 0, 100, 0, 0, 0, 0, 0, 132, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Exit Vehicle');
INSERT INTO smart_scripts VALUES (32580, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Attack Start');
INSERT INTO smart_scripts VALUES (32580, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Text Over - Set Emote State');
INSERT INTO smart_scripts VALUES (32580, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 19, 32576, 150, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Death - Set Data');
INSERT INTO smart_scripts VALUES (32580, 0, 6, 0, 60, 0, 100, 257, 0, 0, 0, 0, 17, 419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Kvaldir Crewman - On Update - Set Emote State');

-- Help Those That Cannot Help Themselves (11876)
UPDATE item_template SET ScriptName='' WHERE entry=35228;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=46201;
INSERT INTO conditions VALUES (17, 0, 46201, 0, 0, 30, 0, 188022, 4, 0, 0, 22, 0, '', 'Requires Trap Nearby');
INSERT INTO conditions VALUES (17, 0, 46201, 0, 0, 29, 0, 25850, 5, 0, 0, 22, 0, '', 'Requires Mammoth Calf Nearby');
UPDATE gameobject SET id=188022 WHERE id IN(188022, 188024, 188025, 188026, 188027, 188030, 188031, 188032, 188033, 188034, 188035, 188036, 188038, 188039, 188040, 188041, 188042, 188043, 188044, 188028, 188029, 188037);
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=188022;
DELETE FROM smart_scripts WHERE entryorguid=188022 AND source_type=1;
INSERT INTO smart_scripts VALUES(188022, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 67, 1, 2000, 2000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(188022, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 67, 3, 200, 200, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(188022, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 33, 25850, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Gossip Hello - Kill Credit');
INSERT INTO smart_scripts VALUES(188022, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 2, 10000, 10000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(188022, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25850, 10, 0, 0, 0, 0, 0, 'Mammoth Trap - On Timed Event - Set Data');
INSERT INTO smart_scripts VALUES(188022, 1, 5, 0, 59, 0, 100, 0, 2, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Timed Event - Set Loot State');
INSERT INTO smart_scripts VALUES(188022, 1, 6, 0, 59, 0, 100, 0, 3, 0, 0, 0, 131, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mammoth Trap - On Timed Event - Set Gameobject State');
DELETE FROM creature_text WHERE entry=25850;
INSERT INTO creature_text VALUES (25850, 0, 0, '%s trumpets in approval!', 16, 0, 100, 0, 0, 0, 0, 'Trapped Mammoth Calf');
UPDATE creature_template SET unit_flags=256|512, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=25850;
DELETE FROM smart_scripts WHERE entryorguid=25850 AND source_type=0;
INSERT INTO smart_scripts VALUES (25850, 0, 0, 1, 38, 0, 100, 0, 1, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Trapped Mammoth Calf - On Data Set - Remove Bytes0');
INSERT INTO smart_scripts VALUES (25850, 0, 1, 2, 61, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Trapped Mammoth Calf - On Data Set - Say Line 0');
INSERT INTO smart_scripts VALUES (25850, 0, 2, 3, 61, 0, 100, 0, 1, 0, 0, 0, 89, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Trapped Mammoth Calf - On Data Set - Set Move Random');
INSERT INTO smart_scripts VALUES (25850, 0, 3, 0, 61, 0, 100, 0, 1, 0, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Trapped Mammoth Calf - On Data Set - Despawn');

-- We Strike! (11592)
REPLACE INTO smart_scripts VALUES (2533500, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 1, 25335, 0, 0, 0, 2, 12, 1, 0, 0, 0, 0, 0, 0, 'Longrunner Proudhoof - Script - Start WP');

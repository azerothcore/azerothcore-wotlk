
-- -------------------------------------------
-- HOWLING FJORD
-- -------------------------------------------
-- The Way to His Heart... (11472)
UPDATE quest_template SET RewardFactionValueId1=7 WHERE Id IN(11472); -- 500 rep
DELETE FROM spell_script_names WHERE spell_id IN(21014, -21014, 44454, -44454);
DELETE FROM spell_scripts WHERE id IN(21014, -21014, 44454, -44454);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(21014, -21014, 44454, -44454) OR spell_effect IN(21014, -21014, 44454, -44454);
INSERT INTO spell_scripts VALUES (21014, 0, 0, 17, 34127, 3, 0, 0, 0, 0, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=44454;
INSERT INTO conditions VALUES (17, 0, 44454, 0, 0, 31, 1, 3, 24786, 0, 0, 0, 0, '', "Tasty Reef Fish spell conditon");
INSERT INTO conditions VALUES (17, 0, 44454, 0, 1, 31, 1, 3, 24804, 0, 0, 0, 0, '', "Tasty Reef Fish spell conditon");
INSERT INTO conditions VALUES (17, 0, 44454, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', "Tasty Reef Fish spell conditon");
INSERT INTO conditions VALUES (17, 0, 44454, 0, 1, 36, 1, 0, 0, 0, 0, 0, 0, '', "Tasty Reef Fish spell conditon");
UPDATE creature_template SET AIName="SmartAI", ScriptName="" WHERE entry IN(24786);
UPDATE creature_template SET AIName="", InhabitType=7, ScriptName="npc_attracted_reef_bull" WHERE entry IN(24804);
DELETE FROM smart_scripts WHERE entryorguid IN(24786,24804) AND source_type=0;
INSERT INTO smart_scripts VALUES (24786, 0, 0, 1, 8, 0, 100, 0, 44454, 0, 0, 0, 85, 44456, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'summon attracted reef bull (player summons), link to forced despawn');
INSERT INTO smart_scripts VALUES (24786, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'forced despawn');

-- Stunning Defeat at the Ring (11300)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24216;
DELETE FROM smart_scripts WHERE entryorguid=24216 AND source_type=0;
REPLACE INTO smart_scripts VALUES (24216, 0, 0, 0, 1, 0, 100, 0, 5000, 15000, 10000, 30000, 11, 43291, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Berserker - On OOC Update - Cast Spell');
DELETE FROM conditions WHERE SourceEntry=43291 AND SourceTypeOrReferenceId=13;
INSERT INTO conditions VALUES(13, 1, 43291, 0, 0, 31, 0, 3, 24221, 0, 0, 0, 0, '', 'Target Dragonflyer Berserker Target');
DELETE FROM creature WHERE id IN(24253, 24254, 24255);
INSERT INTO creature VALUES (113775, 24253, 571, 1, 1, 0, 0, 831.667, -4729.13, -96.2364, 2.22215, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113776, 24253, 571, 1, 1, 0, 0, 768.236, -4706.83, -96.2364, 1.5737, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113812, 24253, 571, 1, 1, 0, 0, 767.984, -4716.78, -96.0611, 5.98648, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113813, 24253, 571, 1, 1, 0, 0, 829.38, -4721.4, -96.1446, 3.03, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113814, 24253, 571, 1, 1, 0, 0, 822.87, -4742.58, -96.1446, 2.46, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113815, 24253, 571, 1, 1, 0, 0, 807.48, -4695.77, -96.1446, 4.62, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113844, 24254, 571, 1, 1, 0, 0, 830.378, -4729.32, -96.2364, 3.11986, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113845, 24254, 571, 1, 1, 0, 0, 830.876, -4730.2, -96.2364, 1.10181, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113847, 24254, 571, 1, 1, 0, 0, 768.522, -4705.58, -96.2364, 6.18619, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113848, 24254, 571, 1, 1, 0, 0, 768.308, -4708.33, -96.2364, 4.74813, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113849, 24254, 571, 1, 1, 0, 0, 769.815, -4705.82, -96.2364, 0.978859, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113870, 24254, 571, 1, 1, 0, 0, 775.74, -4746.32, -96.1446, 0.76, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113871, 24254, 571, 1, 1, 0, 0, 813.44, -4697.44, -96.1446, 4.35, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113887, 24255, 571, 1, 1, 0, 0, 831.409, -4727.82, -96.2364, 2.28073, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113890, 24255, 571, 1, 1, 0, 0, 768.052, -4707.01, -96.2364, 0.659595, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
INSERT INTO creature VALUES (113900, 24255, 571, 1, 1, 0, 0, 780.11, -4750.07, -96.1446, 0.96, 1, 0, 0, 1223, 2846, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24151;
DELETE FROM smart_scripts WHERE entryorguid=24151 AND source_type=0;
INSERT INTO smart_scripts VALUES (24151, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Reset - Set NPC Flag');
INSERT INTO smart_scripts VALUES (24151, 0, 1, 2, 19, 0, 100, 0, 11300, 0, 0, 0, 12, 24213, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 838.81, -4678.06, -94.182, 4.04, 'Daegarn - On Quest Accept - Summon Creature');
INSERT INTO smart_scripts VALUES (24151, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Quest Accept - Set NPC Flag');
INSERT INTO smart_scripts VALUES (24151, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Quest Accept - Set Event Phase');
INSERT INTO smart_scripts VALUES (24151, 0, 4, 5, 60, 0, 100, 0, 600000, 600000, 600000, 600000, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Update - Set Event Phase');
INSERT INTO smart_scripts VALUES (24151, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Update - Set NPC Flag');
INSERT INTO smart_scripts VALUES (24151, 0, 6, 0, 38, 0, 100, 0, 1, 1, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Daegarn - On Data Set - Set NPC Flag');
UPDATE gameobject SET id=186641 WHERE id IN(186641, 186642, 186643, 186644, 186645, 186646, 186647);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(24253, 24254, 24255);
DELETE FROM smart_scripts WHERE entryorguid IN(24253, 24254, 24255) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(24253*100, 24253*100+1, 24253*100+2, 24253*100+3, 24253*100+4, 24253*100+5) AND source_type=9;
INSERT INTO smart_scripts VALUES (24253*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 798.32, -4729.38, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 789.1, -4726.35, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 788.04, -4716.94, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 794.88, -4711.5, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 805.42, -4717, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 807.04, -4731.29, -96.23, 0, 'Dragonflyer Prisoner - Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (24253, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Respawn - Set Unit Flag');
INSERT INTO smart_scripts VALUES (24253, 0, 1, 2, 38, 0, 100, 1, 5, 5, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 186641, 5, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Activate Gameobjec');
INSERT INTO smart_scripts VALUES (24253, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (24253, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 88, 24253*100, 24253*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Call Random Range Script');
INSERT INTO smart_scripts VALUES (24253, 0, 4, 5, 60, 1, 100, 1, 4000, 4000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (24253, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Upate - Move Random');
INSERT INTO smart_scripts VALUES (24253, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Despawn');
INSERT INTO smart_scripts VALUES (24253, 0, 7, 0, 7, 1, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (24254, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Respawn - Set Unit Flag');
INSERT INTO smart_scripts VALUES (24254, 0, 1, 2, 38, 0, 100, 1, 5, 5, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 186641, 5, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Activate Gameobjec');
INSERT INTO smart_scripts VALUES (24254, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (24254, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 88, 24253*100, 24253*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Call Random Range Script');
INSERT INTO smart_scripts VALUES (24254, 0, 4, 5, 60, 1, 100, 1, 4000, 4000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (24254, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Upate - Move Random');
INSERT INTO smart_scripts VALUES (24254, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Despawn');
INSERT INTO smart_scripts VALUES (24254, 0, 7, 0, 7, 1, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (24255, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Respawn - Set Unit Flag');
INSERT INTO smart_scripts VALUES (24255, 0, 1, 2, 38, 0, 100, 1, 5, 5, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 186641, 5, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Activate Gameobjec');
INSERT INTO smart_scripts VALUES (24255, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Set Event Phase');
INSERT INTO smart_scripts VALUES (24255, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 88, 24253*100, 24253*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Data Set - Call Random Range Script');
INSERT INTO smart_scripts VALUES (24255, 0, 4, 5, 60, 1, 100, 1, 4000, 4000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (24255, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Upate - Move Random');
INSERT INTO smart_scripts VALUES (24255, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Update - Despawn');
INSERT INTO smart_scripts VALUES (24255, 0, 7, 0, 7, 1, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dragonflyer Prisoner - On Evade - Despawn');
DELETE FROM conditions WHERE SourceEntry IN(24253, 24254, 24255) AND SourceTypeOrReferenceId=22;
INSERT INTO conditions VALUES(22, 2, 24253, 0, 0, 30, 1, 186641, 5, 0, 0, 0, 0, '', 'Target RoJ Cage');
INSERT INTO conditions VALUES(22, 2, 24254, 0, 0, 30, 1, 186641, 5, 0, 0, 0, 0, '', 'Target RoJ Cage');
INSERT INTO conditions VALUES(22, 2, 24255, 0, 0, 30, 1, 186641, 5, 0, 0, 0, 0, '', 'Target RoJ Cage');
REPLACE INTO creature_text VALUES(24213, 0, 0, "More souls for the Lich King! Come, little ones! Come!", 14, 0, 100, 0, 0, 0, 0, "Firjus the Soul Crusher");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24213;
DELETE FROM smart_scripts WHERE entryorguid=24213 AND source_type=0;
INSERT INTO smart_scripts VALUES (24213, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 796.55, -4722.46, -96.145, 0, 'Firjus the Soul Crusher - On Respawn - Move To Point');
INSERT INTO smart_scripts VALUES (24213, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - On Respawn - Set Data For All npcs in range');
INSERT INTO smart_scripts VALUES (24213, 0, 2, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24213, 0, 3, 0, 0, 0, 100, 0, 3000, 6000, 12000, 15000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (24213, 0, 4, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 43348, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Firjus the Soul Crusher - In Combat - Cast Head Crush');
INSERT INTO smart_scripts VALUES (24213, 0, 5, 0, 6, 0, 100, 1, 0, 0, 0, 0, 12, 24215, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 838.81, -4678.06, -94.182, 4.04, 'Firjus the Soul Crusher - On Just Died - Summon Creature Jlarborn the Strategist');
REPLACE INTO creature_text VALUES(24215, 0, 0, "Firjus was unworthy! Test your battle progress against a true soldier of the Lich King!", 14, 0, 100, 0, 0, 0, 0, "Jlarborn the Strategist");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24215;
DELETE FROM smart_scripts WHERE entryorguid=24215 AND source_type=0;
INSERT INTO smart_scripts VALUES (24215, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 796.55, -4722.46, -96.145, 0, 'Jlarborn the Strategist - On Respawn - Move To Point');
INSERT INTO smart_scripts VALUES (24215, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - On Respawn - Set Data For All npcs in range');
INSERT INTO smart_scripts VALUES (24215, 0, 2, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24215, 0, 3, 0, 0, 0, 100, 0, 4000, 5000, 15000, 16000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - In Combat - Cast Shield Block');
INSERT INTO smart_scripts VALUES (24215, 0, 4, 0, 0, 0, 100, 0, 7000, 8000, 18000, 19000, 11, 38233, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (24215, 0, 5, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Jlarborn the Strategist - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (24215, 0, 6, 0, 6, 0, 100, 1, 0, 0, 0, 0, 12, 24214, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 838.81, -4678.06, -94.182, 4.04, 'Jlarborn the Strategist - On Just Died - Summon Creature Yorus the Flesh Harvester');
REPLACE INTO creature_text VALUES(24214, 0, 0, "Good... More flesh for the harvest...", 14, 0, 100, 0, 0, 0, 0, "Yorus the Flesh Harvester");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24214;
DELETE FROM smart_scripts WHERE entryorguid=24214 AND source_type=0;
INSERT INTO smart_scripts VALUES (24214, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 796.55, -4722.46, -96.145, 0, 'Yorus the Flesh Harvester - On Respawn - Move To Point');
INSERT INTO smart_scripts VALUES (24214, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - On Respawn - Set Data For All npcs in range');
INSERT INTO smart_scripts VALUES (24214, 0, 2, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (24214, 0, 3, 0, 0, 0, 100, 0, 4000, 5000, 15000, 16000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - In Combat - Cast Shield Block');
INSERT INTO smart_scripts VALUES (24214, 0, 4, 0, 0, 0, 100, 0, 7000, 8000, 18000, 19000, 11, 38233, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (24214, 0, 5, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 8374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Yorus the Flesh Harvester - In Combat - Cast Arcing Smash');
INSERT INTO smart_scripts VALUES (24214, 0, 6, 0, 6, 0, 100, 1, 0, 0, 0, 0, 12, 23931, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 838.81, -4678.06, -94.182, 4.04, 'Yorus the Flesh Harvester - On Just Died - Summon Creature Oluf the Violent');
REPLACE INTO creature_text VALUES(23931, 0, 0, "The ring will overflow with the blood of the interlopers! Oluf has come!", 14, 0, 100, 0, 0, 0, 0, "Oluf the Violent");
REPLACE INTO creature_text VALUES(23931, 1, 0, "The ancient cipher falls to the ground.", 41, 0, 100, 0, 0, 0, 0, "Oluf the Violent");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23931;
DELETE FROM smart_scripts WHERE entryorguid=23931 AND source_type=0;
INSERT INTO smart_scripts VALUES (23931, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 796.55, -4722.46, -96.145, 0, 'Oluf the Violent - On Respawn - Move To Point');
INSERT INTO smart_scripts VALUES (23931, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 'Oluf the Violent - On Respawn - Set Data For All npcs in range');
INSERT INTO smart_scripts VALUES (23931, 0, 2, 1, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Aggro - Talk');
INSERT INTO smart_scripts VALUES (23931, 0, 3, 0, 0, 0, 100, 0, 3000, 6000, 12000, 15000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (23931, 0, 4, 0, 0, 0, 100, 0, 8000, 9000, 28000, 29000, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast Demoralizing Shout');
INSERT INTO smart_scripts VALUES (23931, 0, 5, 0, 0, 0, 100, 0, 7000, 7000, 21000, 21000, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (23931, 0, 6, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 11, 42870, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast Throw Dragonflayer Harpoon');
INSERT INTO smart_scripts VALUES (23931, 0, 7, 0, 0, 0, 100, 0, 10000, 10000, 10000, 10000, 11, 41057, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - In Combat - Cast Whirlwind');
INSERT INTO smart_scripts VALUES (23931, 0, 8, 9, 6, 0, 100, 1, 0, 0, 0, 0, 50, 186640, 90000, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Death - Summon Ancient Cipher');
INSERT INTO smart_scripts VALUES (23931, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Oluf the Violent - On Death - Talk');
INSERT INTO smart_scripts VALUES (23931, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 24151, 100, 0, 0, 0, 0, 0, 'Oluf the Violent - On Death - Set Data');

-- Guided by Honor (11289)
DELETE FROM smart_scripts WHERE entryorguid IN(24189) AND source_type=0 AND id=1;
INSERT INTO smart_scripts VALUES (24189, 0, 1, 0, 19, 0, 100, 0, 11289, 0, 0, 0, 15, 11289, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Ares - On target quest accepted 11289 - Complete');
UPDATE quest_template SET SpecialFlags=2 WHERE Id=11289;

-- A Carver and a Croaker (11476)
UPDATE creature_template SET npcflag=16777216, AIName="SmartAI", IconName="Pickup" WHERE entry=26503;

-- War is Hell (11270)
UPDATE creature SET spawntimesecs=60 WHERE id IN (24010,24009);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN (24009, 24010);
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid IN (24009,24010);
INSERT INTO smart_scripts VALUES(24009, 0, 0, 1, 8, 0, 100, 0, 42793, 0, 20000, 20000, 33, 24008, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alliance Corpse - On Burn Body Hit - Give Kill Credit');
INSERT INTO smart_scripts VALUES(24009, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alliance Corpse - On Burn Body Hit - Despawn after 20 secs');
INSERT INTO smart_scripts VALUES(24010, 0, 0, 1, 8, 0, 100, 0, 42793, 0, 20000, 20000, 33, 24008, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Corpse - On Burn Body Hit - Give Kill Credit');
INSERT INTO smart_scripts VALUES(24010, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Forsaken Corpse - On Burn Body Hit - Despawn after 20 secs'); 
DELETE FROM conditions WHERE SourceEntry=42793 AND SourceTypeOrReferenceId IN(13, 17);
INSERT INTO conditions VALUES(17, 0, 42793, 0, 0, 31, 1, 3, 24009, 0, 0, 0, 0, '', 'Item burning torch only targets Alliance Corpse');
INSERT INTO conditions VALUES(17, 0, 42793, 0, 1, 31, 1, 3, 24010, 0, 0, 0, 0, '', 'Item burning torch only targets Horde Corpse');
INSERT INTO conditions VALUES(13, 1, 42793, 0, 0, 31, 1, 3, 24009, 0, 0, 0, 0, '', 'Item burning torch only targets Alliance Corpse');
INSERT INTO conditions VALUES(13, 1, 42793, 0, 1, 31, 1, 3, 24010, 0, 0, 0, 0, '', 'Item burning torch only targets Horde Corpse');

-- The Cleansing (11322)
-- The Cleansing (11317)
DELETE FROM gameobject WHERE id=186649;
INSERT INTO gameobject VALUES(NULL, 186649, 571, 1, 1, 3035.8, -5092.26, 722.618, 5.31334, 0, 0, 0.46614, -0.884711, 250, 100, 1, 0);
UPDATE gameobject_template SET data10=43351, ScriptName='' WHERE entry=186649;
UPDATE creature_template SET ScriptName="npc_your_inner_turmoil" WHERE entry=27959;
DELETE FROM spell_script_names WHERE spell_id=43351;
INSERT INTO spell_script_names VALUES(43351, "spell_q11322_q11317_the_cleansing");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=50218;
INSERT INTO conditions VALUES (13, 7, 50218, 0, 0, 31, 0, 3, 27959, 0, 0, 0, 0, '', '');

-- The Fallen Sisters (11314)
DELETE FROM smart_scripts WHERE entryorguid IN (23678,2367800);
INSERT INTO smart_scripts VALUES
(23678, 0, 0, 0, 2, 0, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - On health 30% - Do text emote '),
(23678, 0, 1, 0, 0, 0, 75, 0, 2000, 3000, 2000, 2000, 11, 9739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - In Combat - Cast Wrath on victim'),
(23678, 0, 2, 3, 8, 0, 100, 0, 43340, 0, 30000, 30000, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - On Spell hit 43340 - Face invoker'),
(23678, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 33, 24117, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - On Spell hit 43340 - Give Quest credit'),
(23678, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2367800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - On Spell hit 43340 - Load script'),
(23678, 0, 5, 0, 40, 0, 100, 0, 1, 23678, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - On reach waypoint 1 - Despawn'),
(2367800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - Script 1 - Stop combat movement'),
(2367800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - Script 2 - Evade'),
(2367800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - Script 3 - Set faction 35'),
(2367800, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - Script 4 - Say text 1'),
(2367800, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 53, 1, 23678, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chill Nymph - Script 5 - Start waypoint movement');

-- Mission: Eternal Flame (11202)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42564;
INSERT INTO conditions VALUES(13, 1, 42564, 0, 0, 31, 0, 3, 23921, 0, 0, 0, 0, '', "Ever-Burning Torch target entry");
INSERT INTO conditions VALUES(13, 1, 42564, 0, 1, 31, 0, 3, 23922, 0, 0, 0, 0, '', "Ever-Burning Torch target entry");
INSERT INTO conditions VALUES(13, 1, 42564, 0, 2, 31, 0, 3, 23923, 0, 0, 0, 0, '', "Ever-Burning Torch target entry");
INSERT INTO conditions VALUES(13, 1, 42564, 0, 3, 31, 0, 3, 23924, 0, 0, 0, 0, '', "Ever-Burning Torch target entry");
UPDATE creature_template SET scale=2, flags_extra=130, AIName="SmartAI" WHERE entry IN(23921, 23922, 23923, 23924);
DELETE FROM smart_scripts WHERE entryorguid IN(23921, 23922, 23923, 23924) AND source_type=0;
INSERT INTO smart_scripts VALUES (23921, 0, 0, 1, 8, 0, 100, 0, 42564, 0, 0, 0, 33, 23921, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (23921, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked spell cast');
INSERT INTO smart_scripts VALUES (23921, 0, 2, 0, 60, 0, 100, 0, 0, 0, 20000, 20000, 28, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove aura on update');
INSERT INTO smart_scripts VALUES (23922, 0, 0, 1, 8, 0, 100, 0, 42564, 0, 0, 0, 33, 23922, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (23922, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked spell cast');
INSERT INTO smart_scripts VALUES (23922, 0, 2, 0, 60, 0, 100, 0, 0, 0, 20000, 20000, 28, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove aura on update');
INSERT INTO smart_scripts VALUES (23923, 0, 0, 1, 8, 0, 100, 0, 42564, 0, 0, 0, 33, 23923, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (23923, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked spell cast');
INSERT INTO smart_scripts VALUES (23923, 0, 2, 0, 60, 0, 100, 0, 0, 0, 20000, 20000, 28, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove aura on update');
INSERT INTO smart_scripts VALUES (23924, 0, 0, 1, 8, 0, 100, 0, 42564, 0, 0, 0, 33, 23924, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell cast');
INSERT INTO smart_scripts VALUES (23924, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked spell cast');
INSERT INTO smart_scripts VALUES (23924, 0, 2, 0, 60, 0, 100, 0, 0, 0, 20000, 20000, 28, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove aura on update');

-- Of Keys and Cages (11231)
UPDATE gameobject_template SET data2=300000 WHERE name="Gjalerbron Cage" AND type=1 AND data1=1738;

-- The Frost Wyrm and its Master (11267)
-- The Frost Wyrm and its Master (11238)
DELETE FROM gameobject WHERE id=186487;
INSERT INTO gameobject VALUES (NULL, 186487, 571, 1, 1, 2821.75, -3603.67, 245.555, 3.49556, 0, 0, 0.984379, -0.176061, 300, 0, 1, 0);
DELETE FROM event_scripts WHERE id=15578;
INSERT INTO event_scripts VALUES(15578, 0, 10, 24019, 180000, 0, 2827, -3680, 307, 1.6);
UPDATE creature_template SET AIName="SmartAI", InhabitType=7 WHERE entry=24019;
DELETE FROM smart_scripts WHERE entryorguid IN(24019) AND source_type=0;
INSERT INTO smart_scripts VALUES(24019, 0, 0, 1, 60, 0, 100, 1, 500, 500, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2823, -3620, 247, 0, "Move to pos on reset");
INSERT INTO smart_scripts VALUES(24019, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 133, 1024, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set movementflags linked");
INSERT INTO smart_scripts VALUES(24019, 0, 2, 0, 34, 0, 100, 1, 0, 0, 0, 0, 133, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set movementflags on movementinform");
INSERT INTO smart_scripts VALUES(24019, 0, 3, 0, 0, 0, 100, 0, 3000, 4000, 8000, 9000, 11, 43562, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "IC spell cast");
INSERT INTO smart_scripts VALUES(24019, 0, 4, 0, 0, 0, 100, 0, 7000, 7000, 14000, 15000, 11, 11264, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "IC spell cast");

-- Jack Likes His Drink (11466)
REPLACE INTO smart_scripts VALUES(24788, 0, 8, 9, 60, 0, 100, 1, 1000, 1000, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Remove feign death on respawn");
REPLACE INTO smart_scripts VALUES(24788, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 19, 24639, 30, 0, 0, 0, 0, 0, "Restore gossip flag on respawn");
REPLACE INTO smart_scripts VALUES(24788, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 94, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Remove dynflag");
REPLACE INTO smart_scripts VALUES(24788, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Set standstate stand");
UPDATE creature_template SET faction=35 WHERE entry=24788;

-- Drop It then Rock It! (11429)
UPDATE creature_template SET unit_flags=4|131072, AIName="SmartAI" WHERE entry=24640;
DELETE FROM smart_scripts WHERE entryorguid=24640 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=24640*100 AND source_type=9;
INSERT INTO smart_scripts VALUES(24640, 0, 0, 0, 37, 0, 100, 1, 0, 0, 0, 0, 80, 24640*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Run script");
INSERT INTO smart_scripts VALUES(24640*100, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 24015, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 1485, -5331, 195, 0, "Summon first npc");
INSERT INTO smart_scripts VALUES(24640*100, 9, 1, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 12, 24015, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 1529, -5303, 198.5, 3.5, "Summon second npc");
INSERT INTO smart_scripts VALUES(24640*100, 9, 2, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 12, 24015, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 1486, -5304, 197, 5.5, "Summon third npc");
INSERT INTO smart_scripts VALUES(24640*100, 9, 3, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 26, 11429, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, "Group event happens for owner");
INSERT INTO smart_scripts VALUES(24640*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 41, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "forced despawn");
DELETE FROM creature_text WHERE entry=24015;
INSERT INTO creature_text VALUES(24015, 0, 0, "You dare challenge Winterskorn!? I will impale you on your puny flag!", 12, 0, 100, 0, 0, 0, 0, "Winterskorn_Defender");
INSERT INTO creature_text VALUES(24015, 0, 1, "Your remains will be fed to the sharks of Daggercap.", 12, 0, 100, 0, 0, 0, 0, "Winterskorn_Defender");
INSERT INTO creature_text VALUES(24015, 0, 2, "The sacrifices now bring themselves to us? Have you no sense!?", 12, 0, 100, 0, 0, 0, 0, "Winterskorn_Defender");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=24015;
DELETE FROM smart_scripts WHERE entryorguid=24015 AND source_type=0;
INSERT INTO smart_scripts VALUES(24015, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Respawn - Talk");

-- The One That Got Away (11410)
DELETE FROM event_scripts WHERE id=16103;
INSERT INTO event_scripts VALUES(16103, 0, 10, 24500, 300000, 1, 2321.083740, -5260.119629, 221.108795, 0.248830);
UPDATE creature_template SET InhabitType=2, AIName="SmartAI" WHERE entry=24500;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=24500;
INSERT INTO smart_scripts VALUES(24500, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 5000, 8000, 11, 48287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC - Cast Powerful Bite');

-- Orfus of Kamagua (11573)
DELETE FROM creature WHERE id=25233;
INSERT INTO creature VALUES(NULL, 25233, 571, 1, 1, 0, 0, 1247.05, -3341.22, 199.881, 2.98407, 600, 0, 0, 9291, 0, 0, 0, 0, 0);

-- Eyes of the Eagle (11416)
-- Eyes of the Eagle (11417)
DELETE FROM gameobject WHERE id IN(190284, 190283, 186814, 186813);
INSERT INTO gameobject VALUES(NULL, 190284, 571, 1, 1, 1595.69, -3905.33, 79.7439, 0.610864, 0, 0, 0, 0, 5, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 190283, 571, 1, 1, 1597.4, -3903.79, 79.702, 0, 0, 0, 0, 0, 60, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 186814, 571, 1, 1, 1597.4, -3903.79, 79.702, 0, 0, 0, 0, 0, 60, 100, 1, 0);
INSERT INTO gameobject VALUES(NULL, 186813, 571, 1, 1, 1596.3, -3904.79, 79.5351, -2.67035, 0, 0, 0, 0, 5, 0, 1, 0);
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry IN(186814, 190283);
DELETE FROM smart_scripts WHERE entryorguid IN(186814, 190283) AND source_type=1;
INSERT INTO smart_scripts VALUES(186814, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 11, 24518, 200, 0, 0.0, 0.0, 0.0, 0.0, "ON egg USE notify Talonshrike");
INSERT INTO smart_scripts VALUES(190283, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 11, 24518, 200, 0, 0.0, 0.0, 0.0, 0.0, "ON egg USE notify Talonshrike");
UPDATE creature_template SET speed_run=3, AIName="SmartAI" WHERE entry=24518;
DELETE FROM smart_scripts WHERE entryorguid=24518 AND source_type=0;
INSERT INTO smart_scripts VALUES(24518, 0, 0, 1, 38, 0, 100, 0, 0, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1597.4, -3903.79, 79.702, 0.0, "ON notification fly TO nest");
INSERT INTO smart_scripts VALUES(24518, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0.0, "Remove flags linked");
INSERT INTO smart_scripts VALUES(24518, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 10000, 12000, 11, 49865, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, " USE Eye Peck");
INSERT INTO smart_scripts VALUES(24518, 0, 3, 0, 0, 0, 100, 0, 3000, 3000, 5000, 7000, 11, 32909, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, " USE Talon Strike");

-- Alpha Worg (11324)
DELETE FROM creature WHERE id=24277;
INSERT INTO creature VALUES(NULL, 24277, 571, 1, 1, 0, 0, 2725.23, -3046.39, 99.6441, 1.31682, 300, 0, 0, 13937, 0, 0, 0, 0, 0);
UPDATE creature_template SET faction=1924 WHERE entry=24277;

-- The Slumbering King (11453)
UPDATE creature_template SET faction=14 WHERE entry=24023;

-- Field Test (11307)
DELETE FROM creature_text WHERE entry IN(24198);
INSERT INTO creature_text VALUES(24198, 0, 0, "%s loses all self control and begins to attack friend or foe alike!", 16, 0, 100, 0, 0, 0, 0, "Plagued Dragonflayer Handler");
UPDATE creature_template SET exp=2, AIName="SmartAI" WHERE entry IN(23564, 24198, 24199);
DELETE FROM smart_scripts WHERE entryorguid IN(23564, 24198, 24199) AND source_type=0;
INSERT INTO smart_scripts VALUES(23564, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase on reset");
INSERT INTO smart_scripts VALUES(23564, 0, 1, 2, 8, 1, 100, 0, 43381, 0, 0, 0, 33, 24281, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "call killmostercredit on spellhit");
INSERT INTO smart_scripts VALUES(23564, 0, 2, 3, 61, 1, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "attack start linked");
INSERT INTO smart_scripts VALUES(23564, 0, 3, 4, 61, 1, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text linked");
INSERT INTO smart_scripts VALUES(23564, 0, 4, 0, 61, 1, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase linked");
INSERT INTO smart_scripts VALUES(24198, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase on reset");
INSERT INTO smart_scripts VALUES(24198, 0, 1, 2, 8, 1, 100, 0, 43381, 0, 0, 0, 33, 24281, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "call killmostercredit on spellhit");
INSERT INTO smart_scripts VALUES(24198, 0, 2, 3, 61, 1, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "attack start linked");
INSERT INTO smart_scripts VALUES(24198, 0, 3, 4, 61, 1, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text linked");
INSERT INTO smart_scripts VALUES(24198, 0, 4, 0, 61, 1, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase linked");
INSERT INTO smart_scripts VALUES(24199, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase on reset");
INSERT INTO smart_scripts VALUES(24199, 0, 1, 2, 8, 1, 100, 0, 43381, 0, 0, 0, 33, 24281, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "call killmostercredit on spellhit");
INSERT INTO smart_scripts VALUES(24199, 0, 2, 3, 61, 1, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "attack start linked");
INSERT INTO smart_scripts VALUES(24199, 0, 3, 4, 61, 1, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text linked");
INSERT INTO smart_scripts VALUES(24199, 0, 4, 0, 61, 1, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "set eventphase linked");
-- Warning: Some Assembly Required (11310), ADDITION FOR Field Test (11307)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(42168, 42166);
INSERT INTO conditions VALUES (13, 1, 42168, 0, 0, 31, 0, 3, 23575, 0, 0, 0, 0, '', 'Control Mindless abomination');
INSERT INTO conditions VALUES (13, 1, 42166, 0, 0, 31, 0, 3, 23564, 0, 0, 0, 0, '', 'Target Plagued Vrykul');
INSERT INTO conditions VALUES (13, 1, 42166, 0, 1, 31, 0, 3, 24198, 0, 0, 0, 0, '', 'Target Plagued Vrykul');
INSERT INTO conditions VALUES (13, 1, 42166, 0, 2, 31, 0, 3, 24199, 0, 0, 0, 0, '', 'Target Plagued Vrykul');
UPDATE creature_template SET spell1=61359, spell2=42166, AIName='', ScriptName='' WHERE entry=23575;
DELETE FROM smart_scripts WHERE entryorguid IN(23564, 24198, 24199) AND source_type=0 AND id IN(5, 6);
INSERT INTO smart_scripts VALUES(23564, 0, 5, 6, 8, 0, 100, 0, 42166, 0, 0, 0, 11, 43399, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell with invoker cast on spell hit");
INSERT INTO smart_scripts VALUES(23564, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked die action");
INSERT INTO smart_scripts VALUES(24198, 0, 5, 6, 8, 0, 100, 0, 42166, 0, 0, 0, 11, 43399, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell with invoker cast on spell hit");
INSERT INTO smart_scripts VALUES(24198, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked die action");
INSERT INTO smart_scripts VALUES(24199, 0, 5, 6, 8, 0, 100, 0, 42166, 0, 0, 0, 11, 43399, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Cast spell with invoker cast on spell hit");
INSERT INTO smart_scripts VALUES(24199, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked die action");
DELETE FROM spell_linked_spell WHERE spell_trigger IN(43392, 42166);
INSERT INTO spell_linked_spell VALUES(43392, 42168, 0, 'Mindless abomination control');
INSERT INTO spell_linked_spell VALUES(42166, 43401, 1, 'Mindless abomination explosion, trigger blood');
DELETE FROM spell_script_names WHERE spell_id IN(42268);
INSERT INTO spell_script_names VALUES(42268, "spell_gen_despawn_self");

-- Send Them Packing (11224)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=23977;
DELETE FROM smart_scripts WHERE entryorguid IN(23977) AND source_type=0;
INSERT INTO smart_scripts VALUES(23977, 0, 0, 1, 22, 0, 100, 0, 125, 3000, 3000, 0, 33, 23977, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "kill credit on emote");
INSERT INTO smart_scripts VALUES(23977, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "linked forcedespawn");

-- Scare the Guano Out of Them (11154)
UPDATE creature_template SET unit_flags=4|768|262144, AIName='SmartAI', flags_extra=flags_extra|128 WHERE entry=24230;
DELETE FROM smart_scripts WHERE entryorguid=24230 AND source_type=0;
INSERT INTO smart_scripts VALUES (24230, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 23959, 50, 0, 0, 0, 0, 0, "Feknut's Firecrackers Bunny - On spawn - Set data");
UPDATE creature_template SET AIName='SmartAI', InhabitType=4 WHERE entry=23959;
REPLACE INTO creature_template_addon VALUES(23959, 0, 0, 50331648, 1, 0, '');
DELETE FROM smart_scripts WHERE entryorguid=23959 AND source_type=0;
INSERT INTO smart_scripts VALUES (23959, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 19, 24230, 50, 0, 0, 0, 0, 0, "Darkclaw Bat - On data - Move to pos");
INSERT INTO smart_scripts VALUES (23959, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 62068, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Darkclaw Bat - On link - Cast spell");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=43307;
INSERT INTO conditions VALUES (13, 1, 43307, 0, 0, 31, 0, 3, 24230, 0, 0, 0, 0, '', 'Summon Darkclaw Guano targets Firecracker Bunny');
DELETE FROM spell_linked_spell WHERE spell_trigger=62068;
INSERT INTO spell_linked_spell VALUES (62068, 43307, 1, '');

-- There Exists No Honor Among Birds (11470)
REPLACE INTO creature_template_addon VALUES(24783, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET spell1=44422, spell2=44423, spell3=44424, InhabitType=5 WHERE entry=24783;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(44424, 44422);
INSERT INTO conditions VALUES (17, 0, 44424, 0, 0, 31, 1, 3, 24787, 0, 0, 0, 0, '', 'Escape, target matriarch only');
INSERT INTO conditions VALUES (17, 0, 44422, 0, 0, 30, 0, 186946, 5, 0, 0, 0, 0, '', 'Scavenge, requires egg');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(44422);
INSERT INTO conditions VALUES (13, 1, 44422, 0, 0, 31, 0, 5, 186946, 0, 0, 0, 0, '', 'Scavenge, requires egg');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=186946;
DELETE FROM smart_scripts WHERE entryorguid=186946 AND source_type=1;
INSERT INTO smart_scripts VALUES (186946, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On gossip hello - set loot state");

-- High Commander Halford Wyrmbane (12298)
-- Mission: Plague This! (11332)
DELETE FROM gossip_menu_option WHERE menu_id=9546;
INSERT INTO gossip_menu_option VALUES (9546, 0, 2, 'Where would you like to fly to?', 4, 8192, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9546, 1, 0, 'I need to Borrow a Gryphon.', 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (9546, 2, 0, 'I Need a ride to Wintergarde keep.', 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET gossip_menu_id=9546, AIName='SmartAI' WHERE entry=23859;
DELETE FROM smart_scripts WHERE entryorguid=23859 AND source_type=0;
INSERT INTO smart_scripts VALUES(23859, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 80, 2385900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Greer Orehammer - On aggro - Run Script');
INSERT INTO smart_scripts VALUES(23859, 0, 1, 2, 62, 0, 100, 0, 9546, 1, 0, 0, 56, 33634, 10, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Greer Orehammer - On Gossip Select - give player 10 Orehammer's Precision Bombs");
INSERT INTO smart_scripts VALUES(23859, 0, 2, 4, 61, 0, 100, 0, 0, 0, 0, 0, 52, 745, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Greer Orehammer - On Gossip Select - Activate Taxi");
INSERT INTO smart_scripts VALUES(23859, 0, 3, 4, 62, 0, 100, 0, 9546, 2, 0, 0, 11, 48862, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Greer Orehammer - On Gossip Select - Cast Spell');
INSERT INTO smart_scripts VALUES(23859, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Greer Orehammer - Linked - Close Gossip');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=9546;
INSERT INTO conditions VALUES (15, 9546, 1, 0, 0, 9, 0, 11332, 0, 0, 0, 0, 0, '', 'Mission Plague This is Active');
INSERT INTO conditions VALUES (15, 9546, 2, 0, 0, 28, 0, 12298, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest');
UPDATE creature_template SET flags_extra=130, AIName='SmartAI' WHERE entry=24290;
DELETE FROM smart_scripts WHERE entryorguid=24290 AND source_type=0;
INSERT INTO smart_scripts VALUES(24290, 0, 0, 0, 8, 0, 100, 0, 43404, 0, 0, 0, 33, 24290, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - kill credit');

-- It Goes to 11... (11421)
REPLACE INTO creature_text VALUES(27992, 0, 0, 'The longhouse is destroyed! Alarms can be heard in the distance.', 41, 0, 100, 0, 0, 0, 0, 'It Goes to 11...');
REPLACE INTO creature_text VALUES(27992, 1, 0, 'Direct hit on the Dockhouse! Dragonflyer Defenders have been alerted!', 41, 0, 100, 0, 0, 0, 0, 'It Goes to 11...');
REPLACE INTO creature_text VALUES(27992, 2, 0, 'The Vrykul Storage facility is up in flames! Dragonflyer Defenders have been alerted!', 41, 0, 100, 0, 0, 0, 0, 'It Goes to 11...');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=24701;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(27992, 27993));
DELETE FROM creature WHERE id IN(27992, 27993);
INSERT INTO creature VALUES(NULL, 27992, 571, 1, 1, 0, 0, 994.286, -5312, 175.674, 1.18682, 300, 0, 0, 26946, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(NULL, 27992, 571, 1, 1, 0, 0, 925.647, -5299.53, 175.687, 1.90241, 300, 0, 0, 26946, 0, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=4, spell1=43986, spell2=43997, AIName='SmartAI' WHERE entry IN(27992, 27993);
DELETE FROM smart_scripts WHERE entryorguid=27992 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=27992*100 AND source_type=9;
INSERT INTO smart_scripts VALUES(27992, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Auto Attack');
INSERT INTO smart_scripts VALUES(27992, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Combat Movement');
INSERT INTO smart_scripts VALUES(27992, 0, 2, 5, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES(27992, 0, 3, 5, 38, 0, 100, 0, 1, 2, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES(27992, 0, 4, 5, 38, 0, 100, 0, 1, 3, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES(27992, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 27992*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES(27992, 0, 6, 0, 31, 0, 100, 0, 43997, 0, 0, 0, 11, 43998, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit Target - Cast Spell');
INSERT INTO smart_scripts VALUES(27992*100, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 970, -5250, 195, 4.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(27992*100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 978, -5272, 204, 4.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(27992*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 956, -5267, 198, 4.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES(27992*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 24533, 4, 60000, 0, 1, 0, 8, 0, 0, 0, 965, -5241, 189, 4.5, 'Script9 - Summon Creature');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI' WHERE entry=24533;
REPLACE INTO creature_template_addon VALUES(24533, 0, 22657, 50331648, 1, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(24533) AND source_type=0;
INSERT INTO smart_scripts VALUES(24533, 0, 0, 0, 0, 0, 100, 0, 500, 500, 1500, 1500, 11, 44188, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES(24533, 0, 1, 0, 8, 0, 100, 0, 43997, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Spell Hit - Die');
DELETE FROM creature WHERE id=24533;
UPDATE creature_template SET flags_extra=130, AIName='SmartAI' WHERE entry IN(24538, 24646, 24647);
DELETE FROM smart_scripts WHERE entryorguid IN(24538, 24646, 24647) AND source_type=0;
INSERT INTO smart_scripts VALUES(24538, 0, 0, 1, 8, 0, 100, 0, 43990, 0, 0, 0, 33, 24538, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - kill credit');
INSERT INTO smart_scripts VALUES(24646, 0, 0, 1, 8, 0, 100, 0, 43990, 0, 0, 0, 33, 24646, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - kill credit');
INSERT INTO smart_scripts VALUES(24647, 0, 0, 1, 8, 0, 100, 0, 43990, 0, 0, 0, 33, 24647, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - kill credit');
INSERT INTO smart_scripts VALUES(24538, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Data');
INSERT INTO smart_scripts VALUES(24646, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Data');
INSERT INTO smart_scripts VALUES(24647, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Data');
INSERT INTO smart_scripts VALUES(24538, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - cast spell (fire)');
INSERT INTO smart_scripts VALUES(24646, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - cast spell (fire)');
INSERT INTO smart_scripts VALUES(24647, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 57931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - cast spell (fire)');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(43986, 43990);
INSERT INTO conditions VALUES (13, 1, 43986, 0, 0, 31, 0, 3, 24538, 0, 0, 0, 0, '', 'Target Quest Trigger');
INSERT INTO conditions VALUES (13, 1, 43986, 0, 1, 31, 0, 3, 24646, 0, 0, 0, 0, '', 'Target Quest Trigger');
INSERT INTO conditions VALUES (13, 1, 43986, 0, 2, 31, 0, 3, 24647, 0, 0, 0, 0, '', 'Target Quest Trigger');
INSERT INTO conditions VALUES (13, 1, 43990, 0, 0, 31, 0, 3, 24538, 0, 0, 0, 0, '', 'Target Quest Trigger');
INSERT INTO conditions VALUES (13, 1, 43990, 0, 1, 31, 0, 3, 24646, 0, 0, 0, 0, '', 'Target Quest Trigger');
INSERT INTO conditions VALUES (13, 1, 43990, 0, 2, 31, 0, 3, 24647, 0, 0, 0, 0, '', 'Target Quest Trigger');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(50331);
INSERT INTO conditions VALUES (13, 1, 50331, 0, 0, 31, 0, 3, 27992, 0, 0, 0, 0, '', 'Target Valkry Harpoon Gun');
INSERT INTO conditions VALUES (13, 1, 50331, 0, 1, 31, 0, 3, 27993, 0, 0, 0, 0, '', 'Target Valkry Harpoon Gun');

-- We Call Him Steelfeather (11418)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24514;
DELETE FROM smart_scripts WHERE entryorguid=24514 AND source_type=0;
INSERT INTO smart_scripts VALUES(24514, 0, 0, 1, 8, 0, 100, 0, 43969, 0, 0, 0, 19, 524288, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Evade Hack');
INSERT INTO smart_scripts VALUES(24514, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 300, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Fly');
INSERT INTO smart_scripts VALUES(24514, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Store Target');
INSERT INTO smart_scripts VALUES(24514, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 24514, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Start WP');
INSERT INTO smart_scripts VALUES(24514, 0, 4, 5, 40, 0, 100, 0, 5, 0, 0, 0, 33, 24515, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'On WP Reach - Kill Credit');
INSERT INTO smart_scripts VALUES(24514, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 28, 43969, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Aura');
INSERT INTO smart_scripts VALUES(24514, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=43969;
INSERT INTO conditions VALUES (17, 0, 43969, 0, 0, 31, 1, 3, 24514, 0, 0, 0, 0, '', 'Requires Steelfeather');
DELETE FROM waypoints WHERE entry=24514;
INSERT INTO waypoints VALUES (24514, 1, 2613, -5086.51, 398.899, 'Steelfeather'),(24514, 2, 2640.59, -5144.9, 427.292, 'Steelfeather'),(24514, 3, 2611.1, -5253.76, 419.437, 'Steelfeather'),(24514, 4, 2575.39, -5252.23, 382.764, 'Steelfeather'),(24514, 5, 2570.71, -5228.31, 376.612, 'Steelfeather');
DELETE FROM creature_text WHERE entry IN(24139, 24131);
INSERT INTO creature_text VALUES(24139, 0, 0, "Y'hear that, Jethan? You're not getting that Steelfeather trophy now that we know she's a mother.", 12, 0, 100, 0, 0, 0, 0, 'Gil Grisert');
INSERT INTO creature_text VALUES(24139, 1, 0, "Jethan!", 12, 0, 100, 0, 0, 0, 0, 'Gil Grisert');
INSERT INTO creature_text VALUES(24131, 0, 0, "Why not? Just think how much better it'll look with the hatchlings to either side --", 12, 0, 100, 0, 0, 0, 0, 'Trapper Jethan');
INSERT INTO creature_text VALUES(24131, 1, 0, "What? I'm just sayin' that's how we do things in Grizzly Hills.", 12, 0, 100, 0, 0, 0, 0, 'Trapper Jethan');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24139;
DELETE FROM smart_scripts WHERE entryorguid=24139 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=24139*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (24139, 0, 0, 0, 20, 0, 100, 0, 11418, 0, 0, 0, 80, 24139*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Rewarded - Script9');
INSERT INTO smart_scripts VALUES (24139*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script 9 - Talk');
INSERT INTO smart_scripts VALUES (24139*100, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 24131, 0, 0, 0, 0, 0, 0, 'Script 9 - Talk');
INSERT INTO smart_scripts VALUES (24139*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script 9 - Talk');
INSERT INTO smart_scripts VALUES (24139*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 24131, 0, 0, 0, 0, 0, 0, 'Script 9 - Talk');

-- I've Got a Flying Machine! (11390)
-- Steel Gate Patrol (11391)
DELETE FROM npc_spellclick_spells WHERE npc_entry=24418;
INSERT INTO npc_spellclick_spells VALUES(24418, 43768, 3, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=18 AND SourceGroup=24418;
INSERT INTO conditions VALUES (18, 24418, 43768, 0, 0, 9, 0, 11390, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11390');
INSERT INTO conditions VALUES (18, 24418, 43768, 0, 1, 9, 0, 11391, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11391');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24418;
INSERT INTO conditions VALUES(22, 3, 24418, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Run if unit is player');
INSERT INTO conditions VALUES(22, 4, 24418, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Run if unit is npc');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=16 AND SourceEntry=24418;
INSERT INTO conditions VALUES (16, 0, 24418, 0, 0, 23, 0, 3999, 0, 0, 0, 0, 0, '', 'Vehicle must be in area 3999');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=24418;
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=24418);
REPLACE INTO creature_template_addon VALUES(24418, 0, 0, 33554432, 1, 0, '');
UPDATE creature_template SET speed_run=3, spell1=43770, spell2=44009, spell3=43799, spell4=43769, AIName='SmartAI', InhabitType=4 WHERE entry=24418;
DELETE FROM smart_scripts WHERE entryorguid=24418 AND source_type=0;
INSERT INTO smart_scripts VALUES (24418, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Charmed - Set Combat Movement');
INSERT INTO smart_scripts VALUES (24418, 0, 1, 0, 29, 0, 100, 0, 0, 0, 0, 0, 60, 1, 300, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Charmed - Set Flight');
INSERT INTO smart_scripts VALUES (24418, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Removed - Despawn');
INSERT INTO smart_scripts VALUES (24418, 0, 3, 0, 28, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Passenger Removed - Set Data');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=21 AND SourceGroup=24418;
INSERT INTO conditions VALUES (21, 24418, 43770, 0, 0, 9, 0, 11390, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11390');
INSERT INTO conditions VALUES (21, 24418, 44009, 0, 0, 9, 0, 11391, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11391');
INSERT INTO conditions VALUES (21, 24418, 43799, 0, 0, 9, 0, 11391, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11391');
INSERT INTO conditions VALUES (21, 24418, 43769, 0, 0, 9, 0, 11391, 0, 0, 0, 0, 0, '', 'Show spell if player has quest 11391');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=43770;
INSERT INTO conditions VALUES (13, 1, 43770, 0, 0, 31, 0, 3, 24439, 0, 0, 0, 0, '', 'Target Sack of Relics');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=24439;
INSERT INTO conditions VALUES(22, 6, 24439, 0, 0, 29, 1, 24438, 10, 0, 0, 0, 0, '', 'Requires Npc Nearby');
UPDATE creature_template SET faction=35, unit_flags=33554432, AIName='SmartAI' WHERE entry=24439;
DELETE FROM smart_scripts WHERE entryorguid=24439 AND source_type=0;
INSERT INTO smart_scripts VALUES (24439, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Passive');
INSERT INTO smart_scripts VALUES (24439, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase');
INSERT INTO smart_scripts VALUES (24439, 0, 2, 0, 8, 1, 100, 0, 43770, 0, 0, 0, 11, 46598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
INSERT INTO smart_scripts VALUES (24439, 0, 3, 0, 23, 0, 100, 0, 46598, 1, 1000, 1000, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aura - Set Phase');
INSERT INTO smart_scripts VALUES (24439, 0, 4, 0, 8, 2, 100, 0, 43770, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Remove Vehicle Aura');
INSERT INTO smart_scripts VALUES (24439, 0, 5, 6, 8, 0, 100, 0, 43770, 0, 0, 0, 33, 24439, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (24439, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');
INSERT INTO smart_scripts VALUES (24439, 0, 7, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
UPDATE creature_template SET modelid1=11686, modelid2=0, scale=4 WHERE entry=24438;
REPLACE INTO creature_template_addon VALUES(24438, 0, 0, 0, 0, 0, '40790');
DELETE FROM creature WHERE id=24438;
INSERT INTO creature VALUES (NULL, 24438, 571, 1, 1, 0, 0, 2091.63, -3245.17, 161.225, 0.148704, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 24438, 571, 1, 1, 0, 0, 1997.35, -3256.87, 149.697, 2.88974, 300, 0, 0, 42, 0, 0, 0, 0, 0);

-- Green Eggs and Whelps (11279)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=23777;
DELETE FROM smart_scripts WHERE entryorguid=23777 AND source_type=0;
INSERT INTO smart_scripts VALUES (23777, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Combat Movement');
INSERT INTO smart_scripts VALUES (23777, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Passive');
INSERT INTO smart_scripts VALUES (23777, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase');
INSERT INTO smart_scripts VALUES (23777, 0, 3, 0, 6, 1, 100, 0, 0, 0, 0, 0, 12, 23688, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Summon');
INSERT INTO smart_scripts VALUES (23777, 0, 4, 0, 6, 2, 100, 0, 0, 0, 0, 0, 12, 24160, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Summon');
INSERT INTO smart_scripts VALUES (23777, 0, 5, 6, 8, 0, 100, 0, 46606, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Phase');
INSERT INTO smart_scripts VALUES (23777, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Die');

-- Let's Go Surfing Now  (11436)
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=24701;
REPLACE INTO creature_template_addon VALUES(27924, 0, 0, 50331648, 0, 0, '');
UPDATE creature_template SET speed_run=5, InhabitType=4, AIName='SmartAI' WHERE entry=27924;
DELETE FROM smart_scripts WHERE entryorguid=27924 AND source_type=0;
INSERT INTO smart_scripts VALUES (27924, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 60, 1, 500, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Fly');
INSERT INTO smart_scripts VALUES (27924, 0, 1, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 53, 1, 27924, 0, 11436, 1000, 0, 21, 10, 0, 0, 0, 0, 0, 0, 'On Update - Start WP');
INSERT INTO smart_scripts VALUES (27924, 0, 2, 3, 40, 0, 100, 0, 1, 0, 0, 0, 15, 11436, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Quest Complete');
INSERT INTO smart_scripts VALUES (27924, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remova All Auras');
REPLACE INTO spell_target_position VALUES(50007, 0, 571, 806.631, -5343.88, 194.0, 2.02458);
DELETE FROM waypoints WHERE entry=27924;
INSERT INTO waypoints VALUES(27924, 1, 626.36, -5030.54, 3.35296, 'Dragonflayer Harpoon');

-- To Venomspite! (12182)
DELETE FROM smart_scripts WHERE entryorguid=24155 AND source_type=0 AND id=3;
INSERT INTO smart_scripts VALUES (24155, 0, 3, 0, 19, 0, 100, 0, 12182, 0, 0, 0, 52, 837, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Activate Taxi Path');

-- Falcon Versus Hawk (11468)
DELETE FROM smart_scripts WHERE entryorguid=24747 AND source_type=0;
INSERT INTO smart_scripts VALUES (24747, 0, 0, 1, 8, 0, 100, 0, 44407, 0, 0, 0, 11, 44408, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fjord Hawk - On Spellhit - Cast spell on invoker');
INSERT INTO smart_scripts VALUES (24747, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 85, 44408, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fjord Hawk - On Spellhit - Invoker Cast');
INSERT INTO smart_scripts VALUES (24747, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fjord Hawk - On Spellhit - Despawn');

-- The Ransacked Caravan (11465)
DELETE FROM smart_scripts WHERE entryorguid=24746 AND source_type=0;
INSERT INTO smart_scripts VALUES (24746, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 85, 25281, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fjord Turkey - Cast Marker on death');
INSERT INTO smart_scripts VALUES (24746, 0, 1, 2, 8, 0, 100, 0, 44323, 0, 0, 0, 11, 44327, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fjord Turkey - On Spellhit - Cast spell on invoker');
INSERT INTO smart_scripts VALUES (24746, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fjord Turkey - On Spellhit - Set Visible false');
INSERT INTO smart_scripts VALUES (24746, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 6000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fjord Turkey - On Spellhit - Despawn');
INSERT INTO smart_scripts VALUES (24746, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fjord Turkey - On Reset - Set Visible true');

-- The Yeti Next Door (11284)
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=43209;
INSERT INTO conditions VALUES (17, 0, 43209, 0, 0, 29, 0, 24178, 10, 0, 0, 60, 0, '', 'Place Ram Meat can only be used Near npc');
INSERT INTO conditions VALUES (13, 1, 43209, 0, 0, 31, 0, 3, 24178, 0, 0, 0, 0, '', 'Target entry 24178');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24178;
DELETE FROM smart_scripts WHERE entryorguid=24178 AND source_type=0;
INSERT INTO smart_scripts VALUES (24178, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - On Aggro - Say Line 0");
INSERT INTO smart_scripts VALUES (24178, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 12000, 13000, 11, 12734, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - In Combat - Cast 'Ground Smash'");
INSERT INTO smart_scripts VALUES (24178, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - On Just Died - Despawn In 8000 ms");
INSERT INTO smart_scripts VALUES (24178, 0, 3, 0, 8, 0, 0, 0, 43209, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - On Spellhit 'Place Ram Meat' - Remove Flags Immune To Players & Immune To NPC's");
INSERT INTO smart_scripts VALUES (24178, 0, 4, 0, 8, 0, 0, 0, 43209, 0, 0, 0, 28, 6606, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - On Spellhit 'Place Ram Meat' - Remove Aura 'Self Visual - Sleep Until Cancelled  (DND)'");
INSERT INTO smart_scripts VALUES (24178, 0, 5, 0, 8, 0, 0, 0, 43209, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Shatterhorn - On Spellhit 'Place Ram Meat' - Remove Flag Standstate Sleep");

-- Absholutely... Thish Will Work! (11330)
UPDATE gameobject_template SET data0=0 WHERE entry=190192;
UPDATE gameobject SET state=1 WHERE id=190192;
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=43386;
INSERT INTO conditions VALUES (13, 1, 43386, 0, 0, 31, 0, 3, 24284, 0, 0, 0, 0, '', 'Target entry 24284');
INSERT INTO conditions VALUES (13, 1, 43386, 0, 0, 1, 0, 42871, 0, 0, 1, 0, 0, '', 'Requires no aura');
INSERT INTO conditions VALUES (13, 1, 43386, 0, 0, 1, 0, 43167, 0, 0, 1, 0, 0, '', 'Requires no aura');
DELETE FROM creature_text WHERE entry IN(23842, 24284);
INSERT INTO creature_text VALUES(24284, 0, 0, "%s clutches at his throat as he begins to gag and thrash about.", 16, 0, 100, 0, 0, 0, 0, 'vrykul prisoner');
INSERT INTO creature_text VALUES(23842, 0, 0, "Yikes.", 12, 0, 100, 0, 0, 0, 0, 'Westguard Defender');
INSERT INTO creature_text VALUES(23842, 0, 1, "This isn't going to end well.", 12, 0, 100, 0, 0, 0, 0, 'Westguard Defender');
INSERT INTO creature_text VALUES(23842, 1, 0, "That did NOT just happen!", 12, 0, 100, 0, 0, 0, 0, 'Westguard Defender');
INSERT INTO creature_text VALUES(23842, 1, 1, "Heh, cool!", 12, 0, 100, 0, 0, 0, 0, 'Westguard Defender');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24284;
DELETE FROM smart_scripts WHERE entryorguid=24284 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=24284*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (24284, 0, 0, 1, 8, 0, 100, 0, 43386, 0, 0, 0, 33, 24284, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Credit");
INSERT INTO smart_scripts VALUES (24284, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 24284*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Start Script");
INSERT INTO smart_scripts VALUES (24284*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 42871, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Cast Spell Drink");
INSERT INTO smart_scripts VALUES (24284*100, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 43401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Cast Spell Explosion");
INSERT INTO smart_scripts VALUES (24284*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 43167, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Cast Spell Spirit Particles Green");
INSERT INTO smart_scripts VALUES (24284*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Remove Byte1 flag sit");
INSERT INTO smart_scripts VALUES (24284*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 5, 53, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Play Emote Battle Roar");
INSERT INTO smart_scripts VALUES (24284*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 6, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 23842, 7, 0, 0, 0, 0, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1370.47, -3174.79, 153.58, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 8, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1366.57, -3180.71, 153.58, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 9, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1364.21, -3178.55, 153.58, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 10, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1367.49, -3180.0, 153.58, 0, "Script9 - Say text 0");
INSERT INTO smart_scripts VALUES (24284*100, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 3, 0, 11137, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Morph to model");
INSERT INTO smart_scripts VALUES (24284*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 43401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Cast Spell Explosion");
INSERT INTO smart_scripts VALUES (24284*100, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Die");
INSERT INTO smart_scripts VALUES (24284*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 11, 23842, 7, 0, 0, 0, 0, 0, "Script9 - Say text 1");
INSERT INTO smart_scripts VALUES (24284*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Despawn");

-- A Return to Resting (11568)
UPDATE creature SET MovementType=0, spawndist=0 WHERE id IN(24883, 24889, 25231, 24887);
UPDATE creature_template SET flags_extra=130 WHERE entry IN(24883, 24889, 25231, 24887);
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid IN(24874, 24875, 24876, 24877) AND source_type=0;

-- Rescuing the Rescuers (11244)
UPDATE gameobject_template SET data3=0, data5=1 WHERE entry=186565;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42968;
INSERT INTO conditions VALUES (13, 1, 42968, 0, 0, 31, 0, 3, 24077, 0, 0, 0, 0, '', 'Target entry 24077');
DELETE FROM creature_text WHERE entry=24077;
INSERT INTO creature_text VALUES(24077, 0, 0, "Don't let my death go unavenged, stranger... give ... them... hell...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
INSERT INTO creature_text VALUES(24077, 0, 1, "I'm done for... too much blood lost... Forget about me, tell Keller... People still alive inside...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
INSERT INTO creature_text VALUES(24077, 0, 2, "Not... no... Our people... Wrymskull... some live...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
INSERT INTO creature_text VALUES(24077, 0, 3, "My injuries are too great. I won't make it... Our citizenry held in cages... ritual...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
INSERT INTO creature_text VALUES(24077, 0, 4, "They left us here impaled as a warning to the others... Several still alive... prisoners of...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
INSERT INTO creature_text VALUES(24077, 0, 5, "My family must know... I... for them... always for them...", 12, 0, 100, 0, 0, 0, 0, 'Impaled Valgarde Scout');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=24077;
DELETE FROM smart_scripts WHERE entryorguid=24077 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=24077*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (24077, 0, 0, 1, 8, 0, 100, 0, 42968, 0, 0, 0, 80, 24077*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Start Script");
INSERT INTO smart_scripts VALUES (24077*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 186565, 10, 0, 0, 0, 0, 0, "Script9 - Set loot state");
INSERT INTO smart_scripts VALUES (24077*100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Remove Bytes 1");
INSERT INTO smart_scripts VALUES (24077*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Set Bytes 1");
INSERT INTO smart_scripts VALUES (24077*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Talk 0");
INSERT INTO smart_scripts VALUES (24077*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Script9 - Despawn");

-- The Shining Light (11288)
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=43203;
INSERT INTO conditions VALUES (13, 1, 43203, 0, 0, 31, 0, 3, 24177, 0, 0, 0, 0, '', 'Shinning Light can only hit Decomposing Ghouls');
INSERT INTO conditions VALUES (17, 0, 43203, 0, 0, 9, 0, 11288, 0, 0, 0, 0, 0, '', 'Shinning Light can only hit targets on the quest');
INSERT INTO conditions VALUES (17, 0, 43203, 0, 1, 28, 0, 11288, 0, 0, 0, 0, 0, '', 'Shinning Light can only hit targets on the quest');

-- Gambling Debt (11464)
DELETE FROM smart_scripts WHERE entryorguid=24539 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(2453900, 2453901) AND source_type=9;
INSERT INTO smart_scripts VALUES (24539, 0, 0, 1, 62, 0, 100, 0, 9010, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Set Faction 14");
INSERT INTO smart_scripts VALUES (24539, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Close Gossip");
INSERT INTO smart_scripts VALUES (24539, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Say Line 0");
INSERT INTO smart_scripts VALUES (24539, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Store Target");
INSERT INTO smart_scripts VALUES (24539, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Set Event Phase 1");
INSERT INTO smart_scripts VALUES (24539, 0, 5, 0, 2, 1, 100, 1, 1, 50, 60000, 60000, 80, 2453900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - Between 1-50% Health - Run Script");
INSERT INTO smart_scripts VALUES (24539, 0, 6, 0, 64, 2, 100, 0, 0, 0, 0, 0, 98, 9011, 12175, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Hello - Send Gossip");
INSERT INTO smart_scripts VALUES (24539, 0, 8, 0, 62, 2, 100, 0, 9011, 0, 0, 0, 80, 2453901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Gossip Option 0 Selected - Run Script");
INSERT INTO smart_scripts VALUES (24539, 0, 9, 0, 0, 0, 100, 0, 3000, 6000, 15000, 22000, 11, 15091, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - In Combat - Cast 'Blast Wave'");
INSERT INTO smart_scripts VALUES (24539, 0, 10, 0, 0, 0, 100, 0, 2500, 4000, 4000, 5000, 11, 50183, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - In Combat - Cast 'Scorch'");
INSERT INTO smart_scripts VALUES (2453900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Say Line 1");
INSERT INTO smart_scripts VALUES (2453900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Health Regeneration Off");
INSERT INTO smart_scripts VALUES (2453900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Home Position");
INSERT INTO smart_scripts VALUES (2453900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 1080, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Faction 1080");
INSERT INTO smart_scripts VALUES (2453900, 9, 4, 0, 0, 0, 100, 0, 300, 300, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Event Phase 2");
INSERT INTO smart_scripts VALUES (2453901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Close Gossip");
INSERT INTO smart_scripts VALUES (2453901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 56, 34115, 1, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Add Item 'Silvermoon Harry's Debt' 1 Time");
INSERT INTO smart_scripts VALUES (2453901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Health Regeneration On");
INSERT INTO smart_scripts VALUES (2453901, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Despawn In 10000 ms");
INSERT INTO smart_scripts VALUES (2453901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "'Silvermoon' Harry - On Script - Set Event Phase 0");

-- Test at Sea (11170)
DELETE FROM smart_scripts WHERE entryorguid=24120 AND source_type=0;
INSERT INTO smart_scripts VALUES (24120, 0, 0, 1, 8, 0, 100, 0, 43115, 0, 25000, 25000, 33, 24121, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "North Fleet Reservist - On Spellhit 'Plague Vial' - Cast 'North Fleet Reservist Kill Credit'");
INSERT INTO smart_scripts VALUES (24120, 0, 1, 0, 61, 0, 80, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "North Fleet Reservist - Out of Combat - Say Line 0");

-- The Ancient Armor of the Kvaldir (11567)
DELETE FROM waypoints WHERE entry=27932;
INSERT INTO waypoints VALUES (27932, 1, -175.691, -3607.79, 3.11728, 'Harrys Bomber'),(27932, 2, -206.463, -3665.6, 15.0589, 'Harrys Bomber'),(27932, 3, -239.03, -3764.17, 30.8325, 'Harrys Bomber'),(27932, 4, -265.967, -3864.41, 46.1623, 'Harrys Bomber'),(27932, 5, -288.66, -3965.76, 61.6018, 'Harrys Bomber'),(27932, 6, -331.795, -4169.33, 89.4518, 'Harrys Bomber'),(27932, 7, -360.964, -4269.67, 99.505, 'Harrys Bomber'),(27932, 8, -427.98, -4468.51, 107.407, 'Harrys Bomber'),(27932, 9, -447.289, -4539.38, 108.093, 'Harrys Bomber'),(27932, 10, -464.281, -4642.94, 106.37, 'Harrys Bomber'),(27932, 11, -470.02, -4849.05, 102.018, 'Harrys Bomber'),(27932, 12, -459.217, -4953.46, 101.422, 'Harrys Bomber'),
(27932, 13, -445.035, -5057.49, 100.982, 'Harrys Bomber'),(27932, 14, -438.343, -5162.25, 102.09, 'Harrys Bomber'),(27932, 15, -434.105, -5298.58, 105.691, 'Harrys Bomber'),(27932, 16, -419.599, -5384.9, 105.929, 'Harrys Bomber'),(27932, 17, -357.894, -5566.67, 97.4177, 'Harrys Bomber'),(27932, 18, -314.508, -5650.04, 90.5208, 'Harrys Bomber'),(27932, 19, -256.829, -5737.46, 83.3688, 'Harrys Bomber'),(27932, 20, -198.537, -5816.05, 76.8175, 'Harrys Bomber'),(27932, 21, -135.293, -5899.46, 68.626, 'Harrys Bomber'),(27932, 22, -73.1853, -5983.66, 59.8672, 'Harrys Bomber'),(27932, 23, 5.48475, -6107.25, 47.0541, 'Harrys Bomber'),(27932, 24, 46.9081, -6217.25, 32.1459, 'Harrys Bomber'),
(27932, 25, 56.1702, -6264.36, 21.6775, 'Harrys Bomber'),(27932, 26, 67.601, -6310.05, 8.39593, 'Harrys Bomber');
UPDATE creature_template SET speed_run=4, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=27932;
DELETE FROM smart_scripts WHERE entryorguid=27932 AND source_type=0;
INSERT INTO smart_scripts VALUES (27932, 0, 0, 1, 60, 0, 100, 1, 1000, 1000, 0, 0, 86, 52391, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Respawned - Cross Cast");
INSERT INTO smart_scripts VALUES (27932, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 27932, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Respawned - Start WP");
DELETE FROM waypoints WHERE entry=32682;
INSERT INTO waypoints VALUES (32682, 1, 67.601, -6310.05, 8.39593, 'Harrys Bomber'),(32682, 2, 56.1702, -6264.36, 21.6775, 'Harrys Bomber'),(32682, 3, 46.9081, -6217.25, 32.1459, 'Harrys Bomber'),(32682, 4, 5.48475, -6107.25, 47.0541, 'Harrys Bomber'),(32682, 5, -73.1853, -5983.66, 59.8672, 'Harrys Bomber'),(32682, 6, -135.293, -5899.46, 68.626, 'Harrys Bomber'),(32682, 7, -198.537, -5816.05, 76.8175, 'Harrys Bomber'),(32682, 8, -256.829, -5737.46, 83.3688, 'Harrys Bomber'),(32682, 9, -314.508, -5650.04, 90.5208, 'Harrys Bomber'),(32682, 10, -357.894, -5566.67, 97.4177, 'Harrys Bomber'),(32682, 11, -419.599, -5384.9, 105.929, 'Harrys Bomber'),
(32682, 12, -434.105, -5298.58, 105.691, 'Harrys Bomber'),(32682, 13, -438.343, -5162.25, 102.09, 'Harrys Bomber'),(32682, 14, -445.035, -5057.49, 100.982, 'Harrys Bomber'),(32682, 15, -459.217, -4953.46, 101.422, 'Harrys Bomber'),(32682, 16, -470.02, -4849.05, 102.018, 'Harrys Bomber'),(32682, 17, -464.281, -4642.94, 106.37, 'Harrys Bomber'),(32682, 18, -447.289, -4539.38, 108.093, 'Harrys Bomber'),(32682, 19, -427.98, -4468.51, 107.407, 'Harrys Bomber'),(32682, 20, -360.964, -4269.67, 99.505, 'Harrys Bomber'),(32682, 21, -331.795, -4169.33, 89.4518, 'Harrys Bomber'),(32682, 22, -288.66, -3965.76, 61.6018, 'Harrys Bomber'),(32682, 23, -265.967, -3864.41, 46.1623, 'Harrys Bomber'),(32682, 24, -239.03, -3764.17, 30.8325, 'Harrys Bomber'),
(32682, 25, -206.463, -3665.6, 15.0589, 'Harrys Bomber'),(32682, 26, -175.691, -3607.79, 3.11728, 'Harrys Bomber'),(32682, 27, -163.84, -3570.53, 6.74, 'Harrys Bomber');
UPDATE creature_template SET speed_run=4, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=32682;
DELETE FROM smart_scripts WHERE entryorguid=32682 AND source_type=0;
INSERT INTO smart_scripts VALUES (32682, 0, 0, 1, 60, 0, 100, 1, 1000, 1000, 0, 0, 86, 52391, 0, 23, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Respawned - Cross Cast");
INSERT INTO smart_scripts VALUES (32682, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 32682, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Respawned - Start WP");
DELETE FROM creature WHERE guid=106836 AND id=28277;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=28277;
DELETE FROM smart_scripts WHERE entryorguid=28277 AND source_type=0;
INSERT INTO smart_scripts VALUES (28277, 0, 0, 1, 62, 0, 100, 0, 10218, 0, 0, 0, 11, 61604, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Gossip Option 0 Selected - Cast 'Harry's Bomber'");
INSERT INTO smart_scripts VALUES (28277, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Harry's Bomber - On Gossip Option 0 Selected - Close Gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10218;
INSERT INTO conditions VALUES (15, 10218, 0, 0, 0, 28, 0, 11567, 0, 0, 0, 0, 0, '', "Harry's Bomber - Show gossip option if player has taken quest 11567");

-- The Conqueror of Skorn! (11261)
UPDATE quest_template SET NextQuestIdChain=11261 WHERE Id IN(11257, 11258, 11259);
UPDATE quest_template SET PrevQuestId=0 WHERE Id=11261;

-- Iron Rune Constructs and You: Rocket Jumping (11485)
UPDATE creature_template SET InhabitType=3 WHERE entry=24806;

-- Iron Rune Constructs and You: Collecting Data (11489)
UPDATE creature_template SET InhabitType=3 WHERE entry=24821;
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=44550;
INSERT INTO conditions VALUES (13, 1, 44550, 0, 0, 31, 0, 3, 24820, 0, 0, 0, 0, '', 'Collect Data target');

-- Iron Rune Constructs and You: The Bluff (11491)
UPDATE creature_template SET InhabitType=3 WHERE entry=24823;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceGroup=1 AND SourceEntry=24718;
INSERT INTO conditions VALUES (22, 1, 24718, 0, 0, 31, 0, 3, 24823, 0, 0, 0, 0, '', 'event require npc 24823');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=44562;
INSERT INTO conditions VALUES (13, 1, 44562, 0, 0, 31, 0, 3, 24718, 0, 0, 0, 0, '', 'Bluff target');
DELETE FROM creature_text WHERE entry=24718 AND groupid IN (1,  2);  
INSERT INTO creature_text VALUES (24718, 1, 0, "What do you think you're doing,  man? Lebronski does NOT appreciate you dragging your loose metal parts all over his rug.", 12, 7, 100, 0, 0, 0, 0, 'Lebronski');
INSERT INTO creature_text VALUES (24718, 2, 0, "Far out,  man. This bucket of bolts might make it after all...", 12, 7, 100, 0, 0, 0, 0, 'Lebronski');

-- Lightning Infused Relics (11494)
UPDATE creature_template SET InhabitType=3 WHERE entry=24825;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(44610, 44611);
INSERT INTO conditions VALUES (13, 1, 44610, 0, 0, 31, 0, 3, 24824, 0, 0, 0, 0, '', 'Collect Data target');
INSERT INTO conditions VALUES (13, 2, 44611, 0, 0, 31, 0, 3, 24824, 0, 0, 0, 0, '', 'Collect Data target');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=44610;
DELETE FROM smart_scripts WHERE entryorguid=24824 AND source_type=0;
INSERT INTO smart_scripts VALUES (24824, 0, 0, 0, 8, 0, 100, 0, 44611, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Relict - SpellHit - Despawn');

-- Adding Injury to Insult (12481)
UPDATE creature_template SET speed_run=2.2, InhabitType=3, HoverHeight=7.5 WHERE entry=24238;
DELETE FROM creature_template_addon WHERE entry=24238;
DELETE FROM smart_scripts WHERE entryorguid=24238 AND source_type=0;
INSERT INTO smart_scripts VALUES (24238, 0, 0, 0, 1, 0, 100, 0, 10000, 15000, 45000, 60000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update OOC - Say text 2');
INSERT INTO smart_scripts VALUES (24238, 0, 1, 2, 8, 0, 100, 0, 43315, 0, 0, 0, 84, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Invoker say text 0');
INSERT INTO smart_scripts VALUES (24238, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Say text 1');
INSERT INTO smart_scripts VALUES (24238, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Unmount');
INSERT INTO smart_scripts VALUES (24238, 0, 4, 6, 61, 0, 100, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Remove Hover');
INSERT INTO smart_scripts VALUES (24238, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Set Aggressive');
INSERT INTO smart_scripts VALUES (24238, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (24238, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Attack Start');
INSERT INTO smart_scripts VALUES (24238, 0, 10, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 43371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On death - Spellcast Bjorn Kill Credit');
INSERT INTO smart_scripts VALUES (24238, 0, 11, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update IC - Spellcast Mortal Strike');
INSERT INTO smart_scripts VALUES (24238, 0, 12, 0, 0, 0, 100, 0, 0, 5000, 10000, 15000, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update IC - Spellcast Crush Armor');
INSERT INTO smart_scripts VALUES (24238, 0, 13, 15, 11, 0, 100, 0, 0, 0, 0, 0, 43, 0, 22657, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spawn - Mount');
INSERT INTO smart_scripts VALUES (24238, 0, 14, 15, 7, 0, 100, 0, 0, 0, 0, 0, 43, 0, 22657, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Mount');
INSERT INTO smart_scripts VALUES (24238, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 141, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Set Hover');
INSERT INTO smart_scripts VALUES (24238, 0, 16, 18, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Set Passive');
INSERT INTO smart_scripts VALUES (24238, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Set Unit Flags');

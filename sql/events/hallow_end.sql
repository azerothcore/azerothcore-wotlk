REPLACE INTO game_event VALUES(12, "2014-10-19 00:00:00", "2020-12-31 06:00:00", 525600, 20160, 324, "Hallow's End", 0);

-- Bobbing Apple
DELETE FROM spell_linked_spell WHERE spell_trigger=24707;
INSERT INTO spell_linked_spell VALUES(24707, 24870, 2, 'Bobbing Apple');

-- Tricky Treats
DELETE FROM item_loot_template WHERE entry=37586 AND item IN(37583, 33226);
INSERT INTO item_loot_template VALUES(37586, 33226, 100, 1, 0, 2, 3);
INSERT INTO item_loot_template VALUES(37586, 37583, 100, 1, 0, 1, 2);

-- Treat Bag loot
DELETE FROM reference_loot_template WHERE entry=10020;
INSERT INTO reference_loot_template VALUES (10020, 20388, 0, 1, 1, 4, 6),(10020, 20389, 0, 1, 1, 4, 6),(10020, 20390, 0, 1, 1, 4, 6)
,(10020, 20391, 0, 1, 1, 1, 1),(10020, 20392, 0, 1, 1, 1, 1),(10020, 20397, 0, 1, 1, 1, 1),(10020, 20398, 0, 1, 1, 1, 1)
,(10020, 20399, 0, 1, 1, 1, 1),(10020, 20409, 0, 1, 1, 1, 1),(10020, 20410, 0, 1, 1, 1, 1),(10020, 20411, 0, 1, 1, 1, 1)
,(10020, 20413, 0, 1, 1, 1, 1),(10020, 20414, 0, 1, 1, 1, 1),(10020, 20561, 0, 1, 1, 1, 1),(10020, 20562, 0, 1, 1, 1, 1)
,(10020, 20563, 0, 1, 1, 1, 1),(10020, 20564, 0, 1, 1, 1, 1),(10020, 20565, 0, 1, 1, 1, 1),(10020, 20566, 0, 1, 1, 1, 1)
,(10020, 20567, 0, 1, 1, 1, 1),(10020, 20568, 0, 1, 1, 1, 1),(10020, 20569, 0, 1, 1, 1, 1),(10020, 20570, 0, 1, 1, 1, 1)
,(10020, 20571, 0, 1, 1, 1, 1),(10020, 20572, 0, 1, 1, 1, 1),(10020, 20573, 0, 1, 1, 1, 1),(10020, 20574, 0, 1, 1, 1, 1)
,(10020, 33154, 0, 1, 1, 1, 1),(10020, 37604, 0, 1, 1, 10, 10),(10020, 37606, 0, 1, 1, 1, 1),(10020, 33292, 0, 1, 1, 1, 1)
,(10020, 34001, 0, 1, 1, 1, 1),(10020, 34002, 0, 1, 1, 1, 1),(10020, 34000, 0, 1, 1, 1, 1),(10020, 34003, 0, 1, 1, 1, 1)
,(10020, 37585, 0, 1, 1, 4, 6),(10020, 37584, 0, 1, 1, 4, 6),(10020, 37583, 0, 1, 1, 4, 6),(10020, 37582, 0, 1, 1, 4, 6);

-- Spell Scripts
DELETE FROM spell_script_names WHERE spell_id IN(24720, 24750, 24751, 24930, 44436, 24717, 24718, 24719, 24724, 24733, 24737, 24741);
INSERT INTO spell_script_names VALUES(24720, "spell_hallows_end_trick"); -- we can use same spell as for innkeeper trick :)
INSERT INTO spell_script_names VALUES(24750, "spell_hallows_end_trick");
INSERT INTO spell_script_names VALUES(24751, "spell_hallows_end_trick_or_treat");
INSERT INTO spell_script_names VALUES(24930, "spell_hallows_end_candy");
INSERT INTO spell_script_names VALUES(44436, "spell_hallows_end_tricky_treat");
-- costumes
INSERT INTO spell_script_names VALUES(24717, "spell_hallows_end_pirate_costume");
INSERT INTO spell_script_names VALUES(24719, "spell_hallows_end_leper_costume");
INSERT INTO spell_script_names VALUES(24737, "spell_hallows_end_ghost_costume");
INSERT INTO spell_script_names VALUES(24718, "spell_hallows_end_ninja_costume");


-- Hallow's End Candy, spell 24924
DELETE FROM spell_linked_spell WHERE spell_trigger=-24924;
INSERT INTO spell_linked_spell VALUES(-24924, 25023, 0, "Hallow's End Candy");

-- Matrons respawn time
UPDATE creature SET spawntimesecs=30 WHERE id IN(23973, 24519);

-- Headless Horseman boss
UPDATE creature_template SET flags_extra=128, ScriptName='' WHERE entry=24034;

-- QUESTS
-- Candy Bucket, wrong quest
DELETE FROM gameobject_queststarter WHERE id IN(190079, 190035);
REPLACE INTO gameobject_queststarter VALUES(190079, 12377);
REPLACE INTO gameobject_queststarter VALUES(190035, 12345);
REPLACE INTO gameobject VALUES (37721, 190079, 1, 1, 1, 2343.53, -2565.08, 102.773, -1.8675, 0, 0, 0, 1, 180, 255, 1, 0);
REPLACE INTO gameobject VALUES (81087, 190035, 1, 1, 1, 2779.4, -434.263, 116.582, -2.70526, 0, 0, 0.803857, -0.594823, 180, 100, 1, 0);

-- Fire Brigade Practice (11360)
-- Fire Brigade Practice (11439)
-- Fire Brigade Practice (11440)
-- Fire Training (11361)
-- Fire Training (11449)
-- Fire Training (11450)
UPDATE quest_template SET PrevQuestId=11356 WHERE Id IN(11360, 11439, 11440);
UPDATE quest_template SET PrevQuestId=11357 WHERE Id IN(11361, 11449, 11450);
DELETE FROM creature_addon WHERE guid IN(select guid from creature WHERE id=23537);
DELETE FROM creature WHERE id=23537;
REPLACE INTO creature_template VALUES (23537, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Headless Horseman - Fire (DND)', '', NULL, 0, 65, 70, 0, 14, 0, 1, 1.14286, 1, 0, 248, 363, 0, 135, 1, 2000, 0, 8, 33554432, 2048, 8, 0, 0, 0, 0, 0, 233, 347, 28, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, 'npc_hallows_end_train_fire', 12340);
REPLACE INTO creature VALUES (240015, 23537, 0, 1, 1, 0, 0, -5749.33, -528.28, 401.996, 0.666303, 300, 0, 0, 2835, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240016, 23537, 0, 1, 1, 0, 0, -9328.42, 56.2903, 66.1476, 1.50281, 300, 0, 0, 2759, 7031, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240017, 23537, 1, 1, 1, 0, 0, 288.169, -4562.44, 28.5433, 3.18855, 300, 0, 0, 2467, 6443, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240018, 23537, 530, 1, 1, 0, 0, -4191.7, -12269.1, 1.27632, 1.43649, 300, 0, 0, 2552, 6588, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240019, 23537, 530, 1, 1, 0, 0, -4207.41, -12276.8, 7.19895, 2.96409, 300, 0, 0, 2835, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240020, 23537, 530, 1, 1, 0, 0, 9234.65, -6785.25, 25.4626, 1.59486, 300, 0, 0, 2835, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240021, 23537, 0, 1, 1, 0, 0, -5759.62, -528.475, 404.934, 3.81967, 300, 0, 0, 2835, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240022, 23537, 0, 1, 1, 0, 0, -5753.37, -532.95, 406.552, 4.49512, 300, 0, 0, 2552, 6588, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240023, 23537, 0, 1, 1, 0, 0, -9314.8, 52.3222, 76.3677, 6.05027, 300, 0, 0, 2684, 6882, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240024, 23537, 0, 1, 1, 0, 0, 2240.27, 487.806, 38.1347, 2.64068, 300, 0, 0, 2835, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240025, 23537, 0, 1, 1, 0, 0, 2238.2, 459.049, 39.5968, 0.445493, 300, 0, 0, 2610, 6749, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(12, 240015),(12, 240016),(12, 240017),(12, 240018),
(12, 240019),(12, 240020),(12, 240021),(12, 240022),(12, 240023),(12, 240024),(12, 240025);



-- Smash the Pumpkin (12155)
-- Smash the Pumpkin (12133)
UPDATE quest_template SET RewardItemId1=34077, RewardItemCount1=1 WHERE Id=12155 OR Id=12133;


-- Flexing for Nougat (8359)
DELETE FROM `smart_scripts` WHERE `entryorguid`=6929 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(6929,0,0,1,62,0,100,0,441,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Gryshka - On gossip option 0 select - Close gossip'),
(6929,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Gryshka - On gossip option 0 select - Player cast Trick or Treat on self'),
(6929,0,2,0,22,0,100,0,41,0,0,0,33,6929,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Gryshka - On flex emote - Give kill credit');
-- Flexing for Nougat (8356)
DELETE FROM `smart_scripts` WHERE `entryorguid`=6740 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(6740,0,0,1,62,0,100,0,342,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Allison - On gossip option 0 select - Close gossip'),
(6740,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Innkeeper Allison - On gossip option 0 select - Player cast Trick or Treat on self'),
(6740,0,2,0,22,0,100,0,41,0,0,0,33,6740,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Allison - On flex emote - Give kill credit');
-- Incoming Gundrop (8358)
UPDATE creature_template SET `AIName`= 'SmartAI' WHERE `entry`=11814;
DELETE FROM `smart_scripts` WHERE `entryorguid`=11814 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(11814,0,1,0,22,0,100,0,264,0,0,0,33,11814,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Kali Remik - On train emote - Give kill credit');
-- Incoming Gundrop (8355)
UPDATE creature_template SET `AIName`= 'SmartAI' WHERE `entry`=6826;
DELETE FROM `smart_scripts` WHERE `entryorguid`=6826 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(6826,0,1,0,22,0,100,0,264,0,0,0,33,6826,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Talvash del Kissel - On train emote - Give kill credit');
-- Dancing for Marzipan (8360)
UPDATE creature_template SET `AIName`= 'SmartAI' WHERE `entry`=6746;
DELETE FROM `smart_scripts` WHERE `entryorguid`=6746 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(6746,0,1,0,22,0,100,0,34,0,0,0,33,6746,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Pala - On dance emote - Give kill credit');
-- Dancing for Marzipan (8357)
UPDATE creature_template SET `AIName`= 'SmartAI' WHERE `entry`=6735;
DELETE FROM `smart_scripts` WHERE `entryorguid`=6735 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(6735,0,0,1,62,0,100,0,1581,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Saelienne - On gossip option 0 select - Close gossip'),
(6735,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Saelienne - On gossip option 0 select - Player cast Trick or Treat on self'),
(6735,0,2,0,22,0,100,0,34,0,0,0,33,6735,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Saelienne - On dance emote - Give kill credit');
-- Chicken Clucking for a Mint (8354)
DELETE FROM `smart_scripts` WHERE `entryorguid`=6741 and `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(6741,0,0,1,62,0,100,0,348,2,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Norman - On gossip option 2 select - Close gossip'),
(6741,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Norman - On gossip option 2 select - Player cast Trick or Treat on self'),
(6741,0,2,0,22,0,100,0,22,0,0,0,33,6741,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Norman - On chicken emote - Give kill credit');
-- Chicken Clucking for a Mint (8353)
DELETE FROM `smart_scripts` WHERE `entryorguid`=5111 and `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(5111,0,0,1,62,0,100,0,345,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Firebrew - On gossip option 0 select - Close gossip'),
(5111,0,1,0,61,0,100,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Firebrew - On gossip option 0 select - Player cast Trick or Treat on self'),
(5111,0,2,0,22,0,100,0,22,0,0,0,33,5111,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Innkeeper Firebrew - On chicken emote - Give kill credit');

-- Sergeant Hartman (15199)
DELETE FROM creature_addon WHERE guid IN(select guid from creature WHERE id=15199);
DELETE FROM creature WHERE id=15199;
REPLACE INTO creature VALUES (240192, 15199, 0, 1, 1, 0, 0, -821, -531, 14.677, 1.767, 600, 0, 0, 15260, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(12, 240192);
-- Darkcaller Yanka (15197)
DELETE FROM creature_addon WHERE guid IN(select guid from creature WHERE id=15197);
DELETE FROM creature WHERE id=15197;
INSERT INTO creature VALUES (240193, 15197, 0, 1, 1, 0, 0, 1760.69, 510.543, 35.915, 6.259, 600, 0, 0, 15260, 0, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(12, 240193);
-- Crashing the Wickerman Festival (1658)
REPLACE INTO `gameobject` VALUES (240003, 180433, 0, 1, 1, 1732.03, 506.873, 41.7939, 1.38659, 0, 0, 0.639074, 0.769145, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(12, 240003);
DELETE FROM areatrigger_involvedrelation WHERE id=3991;
INSERT INTO areatrigger_involvedrelation VALUES(3991, 1658);
-- Stinking Up Southshore (1657)
DELETE FROM event_scripts WHERE id=9417;
INSERT INTO event_scripts VALUES(9417, 0, 8, 15415, 1, 0, 0, 0, 0, 0);

-- EVENTS
-- Headless horseman attack
-- missing water barrel
REPLACE INTO gameobject VALUES(240002, 186234, 0, 1, 1, -9435.38, 62.40, 56.516, 5.818, 0, 0, 0.230221, -0.973138, 300, 0, 1, 0);
REPLACE INTO game_event_gameobject VALUES(12, 240002);

REPLACE INTO creature_template VALUES (23973, 0, 0, 0, 0, 0, 22499, 0, 0, 0, 'Masked Orphan Matron', '', NULL, 0, 12, 12, 0, 1735, 3, 1.1, 1.14286, 1, 0, 17, 22, 0, 46, 1, 2000, 0, 1, 4096, 2048, 8, 0, 0, 0, 0, 0, 11, 17, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 'npc_costumed_orphan_matron', 12340);
REPLACE INTO creature_template VALUES (24519, 0, 0, 0, 0, 0, 22504, 0, 0, 0, 'Costumed Orphan Matron', '', NULL, 0, 12, 12, 0, 1732, 3, 1.1, 1.14286, 1, 0, 17, 22, 0, 46, 1, 2000, 0, 1, 4096, 2048, 8, 0, 0, 0, 0, 0, 11, 17, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 'npc_costumed_orphan_matron', 12340);
REPLACE INTO creature_template VALUES (23686, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Headless Horseman Flame Bunny', '', NULL, 0, 70, 70, 2, 14, 0, 1, 1.14286, 1, 0, 248, 363, 0, 135, 1, 2000, 0, 8, 33554432, 2048, 8, 0, 0, 0, 0, 0, 233, 347, 28, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, 'npc_soh_fire_trigger', 12340);
REPLACE INTO creature_template VALUES (23543, 0, 0, 0, 0, 0, 22352, 0, 0, 0, 'Shade of the Horseman', '', NULL, 0, 11, 11, 0, 14, 0, 1, 1.14286, 1, 0, 15, 20, 0, 44, 1, 2000, 0, 1, 2, 2048, 8, 0, 0, 0, 0, 0, 9, 14, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 5, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 54, 1, 0, 2, 'npc_hallows_end_soh', 12340);
DELETE FROM spell_script_names WHERE spell_id IN(42074, 42132, 42079, 42339);
INSERT INTO spell_script_names VALUES(42074, "spell_hallows_end_base_fire");
INSERT INTO spell_script_names VALUES(42339, "spell_hallows_end_bucket_lands");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(42132);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(42079);
INSERT INTO conditions VALUES (17, 0, 42132, 0, 0, 31, 1, 3, 23686, 0, 0, 0, 0, '', 'Hallows End - Start fire');
INSERT INTO conditions VALUES (17, 0, 42132, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', 'Hallows End - Start fire');
INSERT INTO conditions VALUES (13, 7, 42079, 0, 0, 31, 0, 3, 23686, 0, 0, 0, 0, '', 'Hallows End - Spread fire');
INSERT INTO conditions VALUES (13, 7, 42079, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - Spread fire');
INSERT INTO conditions VALUES (13, 7, 42079, 0, 0, 1, 0, 42074, 0, 0, 1, 0, 0, '', 'Hallows End - Spread fire');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(42339);
INSERT INTO conditions VALUES (13, 1, 42339, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
INSERT INTO conditions VALUES (13, 1, 42339, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
INSERT INTO conditions VALUES (13, 1, 42339, 0, 1, 31, 0, 3, 23686, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
INSERT INTO conditions VALUES (13, 1, 42339, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
INSERT INTO conditions VALUES (13, 1, 42339, 0, 2, 31, 0, 3, 23537, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
INSERT INTO conditions VALUES (13, 1, 42339, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - Throw water bucket');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(42348);
INSERT INTO conditions VALUES (13, 3, 42348, 0, 0, 31, 0, 3, 23686, 0, 0, 0, 0, '', 'Hallows End - water splash');
INSERT INTO conditions VALUES (13, 3, 42348, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - water splash');
INSERT INTO conditions VALUES (13, 3, 42348, 0, 1, 31, 0, 3, 23537, 0, 0, 0, 0, '', 'Hallows End - water splash');
INSERT INTO conditions VALUES (13, 3, 42348, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Hallows End - water splash');
-- Goldshire
DELETE FROM waypoint_data WHERE id=235431;
INSERT INTO waypoint_data VALUES (235431, 1, -9493.13, 48.0931, 68.8011, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 2, -9472.48, 62.7176, 62.4377, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 3, -9449.23, 48.8853, 70.4465, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 4, -9449.31, 36.8767, 72.8573, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 5, -9469.2, 35.2593, 80.4789, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 6, -9476.5, 43.7763, 80.5768, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 7, -9464.59, 85.4764, 78.0436, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 8, -9452.45, 89.6347, 77.4558, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 9, -9445.35, 84.8708, 76.845, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 10, -9448.57, 73.954, 76.5538, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 11, -9474.75, 66.0551, 80.3692, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235431, 12, -9473.75, 66.0551, 80.3692, 0, 0, 0, 0, 100, 0);
-- Kharanos
DELETE FROM waypoint_data WHERE id=235432;
INSERT INTO waypoint_data VALUES (235432, 11, -5587.02, -480.673, 419.712, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 10, -5562.93, -475.101, 429.47, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 9, -5575.62, -456.575, 424.062, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 8, -5590.26, -444.914, 425.917, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 7, -5596.9, -446.581, 416.874, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 6, -5603.51, -463.393, 412.264, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 5, -5622, -463.02, 407.823, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 4, -5633.83, -470.215, 404.044, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 3, -5635.16, -480.489, 401.794, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 2, -5602.24, -492.529, 411.327, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235432, 1, -5572.09, -493.918, 413.088, 0, 0, 0, 0, 100, 0);
-- Azure Watch
DELETE FROM waypoint_data WHERE id=235433;
INSERT INTO waypoint_data VALUES (235433, 9, -4174.64, -12499, 73.4966, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 8, -4186.86, -12492.8, 60.1848, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 7, -4207.4, -12503.8, 62.9955, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 6, -4216.64, -12528.2, 63.3098, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 5, -4205.74, -12532.1, 64.5351, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 4, -4189.31, -12524.3, 67.2411, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 3, -4160.06, -12528, 49.7539, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 2, -4149.9, -12499.8, 55.3287, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235433, 1, -4158.92, -12474.5, 57.6877, 0, 0, 0, 0, 100, 0);
-- Razor Hill
DELETE FROM waypoint_data WHERE id=235434;
INSERT INTO waypoint_data VALUES (235434, 9, 325.143, -4733.62, 35.8289, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 8, 374.094, -4720.59, 30.957, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 7, 368.08, -4705.2, 32.3836, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 6, 345.85, -4713.88, 29.6655, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 5, 326.66, -4709.62, 27.1919, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 4, 309.97, -4716.32, 24.9401, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 3, 301.86, -4743.94, 20.7011, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 2, 304.91, -4765.39, 15.8638, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235434, 1, 330.012, -4760.3, 25.6922, 0, 0, 0, 0, 100, 0);
-- Brill
DELETE FROM waypoint_data WHERE id=235435;
INSERT INTO waypoint_data VALUES (235435, 10, 2241.27, 275.894, 41.3221, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 9, 2228.26, 253.414, 49.4476, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 8, 2238.28, 236.233, 55.7377, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 7, 2267.19, 239.023, 56.9931, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 6, 2269.29, 268.162, 56.6651, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 5, 2288.88, 280.746, 67.0288, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 4, 2278.97, 299.66, 52.3487, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 3, 2274.95, 305.308, 38.4187, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 2, 2241.25, 297.52, 43.7327, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 1, 2219.06, 281.009, 52.45, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 11, 2263.52, 296.479, 65.8, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235435, 12, 2258.47, 292.451, 62.7599, 0, 0, 0, 0, 100, 0);
-- Falconwing Square
DELETE FROM waypoint_data WHERE id=235436;
INSERT INTO waypoint_data VALUES (235436, 1, 9541.06, -6838.29, 21.2302, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 2, 9528.65, -6852.61, 31.3788, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 3, 9514.61, -6853.57, 31.1926, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 4, 9498.61, -6836.72, 30.143, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 5, 9485.69, -6820.25, 29.7564, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 6, 9494.28, -6802.62, 23.1539, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 7, 9515.9, -6789.68, 30.1268, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 8, 9535.82, -6795.01, 26.1349, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 9, 9531.41, -6812.67, 22.2707, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 10, 9515.89, -6826.04, 28.0319, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (235436, 11, 9508.7, -6812.54, 41.3166, 0, 0, 0, 0, 100, 0);



-- FIRE TRIGGERS
REPLACE INTO creature VALUES (240026, 23686, 0, 1, 1, 0, 0, -9459.64, 40.9507, 64.302, 4.70195, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240027, 23686, 0, 1, 1, 0, 0, -9461.98, 42.2018, 62.6981, 4.39564, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240028, 23686, 0, 1, 1, 0, 0, -9457.22, 42.1101, 63.0202, 4.39564, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240029, 23686, 1, 1, 1, 0, 0, 291.783, -4773.08, 11.7301, 5.17244, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240030, 23686, 1, 1, 1, 0, 0, 296.157, -4776.64, 20.1787, 3.2757, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240031, 23686, 1, 1, 1, 0, 0, 311.81, -4774.85, 27.6999, 4.43809, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240032, 23686, 1, 1, 1, 0, 0, 298.238, -4776.4, 27.6999, 3.69196, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240033, 23686, 1, 1, 1, 0, 0, 306.619, -4775.44, 27.6999, 3.69196, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240034, 23686, 1, 1, 1, 0, 0, 310.904, -4774.96, 27.6999, 3.69196, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240035, 23686, 1, 1, 1, 0, 0, 317.691, -4774.18, 27.6999, 5.39549, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240036, 23686, 1, 1, 1, 0, 0, 312.604, -4773.34, 23.9834, 5.41906, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240037, 23686, 1, 1, 1, 0, 0, 312.604, -4773.34, 18.3576, 5.41906, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240038, 23686, 1, 1, 1, 0, 0, 320.31, -4770.04, 14.0178, 4.63366, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240039, 23686, 1, 1, 1, 0, 0, 346.641, -4708.79, 29.6077, 2.77227, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240040, 23686, 1, 1, 1, 0, 0, 346.348, -4708.34, 17.4551, 1.87692, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240041, 23686, 1, 1, 1, 0, 0, 331.839, -4702.7, 24.0211, 2.35208, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240042, 23686, 1, 1, 1, 0, 0, 339.364, -4708.42, 21.9112, 1.39782, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240043, 23686, 1, 1, 1, 0, 0, 327.003, -4702.6, 16.3531, 1.11508, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240044, 23686, 1, 1, 1, 0, 0, 328.733, -4698.4, 30.2376, 6.02382, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240045, 23686, 1, 1, 1, 0, 0, 320.605, -4694.05, 29.9266, 2.39921, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240046, 23686, 1, 1, 1, 0, 0, 324.615, -4697.03, 26.1846, 1.57454, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240047, 23686, 1, 1, 1, 0, 0, 335.339, -4704.81, 23.8428, 1.52742, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240048, 23686, 1, 1, 1, 0, 0, 337.244, -4704.9, 26.0984, 2.08112, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240049, 23686, 1, 1, 1, 0, 0, 338.8, -4702.71, 31.3961, 2.08112, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240050, 23686, 1, 1, 1, 0, 0, 343.336, -4710.18, 28.983, 2.08505, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240051, 23686, 530, 1, 1, 0, 0, -4143.24, -12480.3, 59.1901, 3.6945, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240052, 23686, 530, 1, 1, 0, 0, -4213.76, -12522.2, 49.9588, 2.51248, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240053, 23686, 530, 1, 1, 0, 0, -4220.41, -12513.9, 55.3889, 4.21287, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240054, 23686, 530, 1, 1, 0, 0, -4218.98, -12516.4, 57.0657, 4.28355, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240055, 23686, 530, 1, 1, 0, 0, -4214.63, -12510.5, 45.8161, 4.28355, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240056, 23686, 530, 1, 1, 0, 0, -4212.18, -12516.2, 47.8073, 4.07935, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240057, 23686, 530, 1, 1, 0, 0, -4214.56, -12511.7, 50.0078, 4.07935, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240058, 23686, 530, 1, 1, 0, 0, -4217.74, -12510.1, 49.9338, 4.07935, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240059, 23686, 530, 1, 1, 0, 0, -4216.54, -12512.4, 55.5226, 3.39998, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240060, 23686, 530, 1, 1, 0, 0, -4215.28, -12517.6, 54.9709, 3.39998, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240061, 23686, 530, 1, 1, 0, 0, -4211.67, -12518.9, 45.71, 3.39998, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240062, 23686, 530, 1, 1, 0, 0, -4131.52, -12495.8, 48.5822, 2.74417, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240063, 23686, 530, 1, 1, 0, 0, -4139.22, -12494, 51.0504, 4.1736, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240064, 23686, 530, 1, 1, 0, 0, -4139.9, -12488.4, 52.8402, 0.674645, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240065, 23686, 530, 1, 1, 0, 0, -4143.31, -12491.2, 45.4552, 0.674645, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240066, 23686, 530, 1, 1, 0, 0, -4149.02, -12488.3, 46.8758, 0.729623, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240067, 23686, 530, 1, 1, 0, 0, -4150.42, -12483.7, 53.1023, 0.686426, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240068, 23686, 530, 1, 1, 0, 0, -4143.13, -12484.7, 56.3242, 0.580398, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240069, 23686, 530, 1, 1, 0, 0, -4145.57, -12481, 57.9442, 0.580398, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240070, 23686, 530, 1, 1, 0, 0, -4148.24, -12473.6, 56.7172, 0.580398, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240071, 23686, 530, 1, 1, 0, 0, -4146.32, -12476.6, 56.7172, 0.580398, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240072, 23686, 530, 1, 1, 0, 0, -4150.45, -12479.5, 50.3434, 0.580398, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240073, 23686, 530, 1, 1, 0, 0, -4151.89, -12477, 50.0254, 0.517566, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240074, 23686, 530, 1, 1, 0, 0, -4155.03, -12472.6, 52.0268, 4.12647, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240075, 23686, 0, 1, 1, 0, 0, -5574.76, -506.924, 411.857, 3.03056, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240076, 23686, 0, 1, 1, 0, 0, -5611.94, -514.303, 408.835, 5.98344, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240077, 23686, 0, 1, 1, 0, 0, -5611.25, -519.612, 413.429, 3.12459, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240078, 23686, 0, 1, 1, 0, 0, -5608.77, -513.703, 413.382, 3.12459, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240079, 23686, 0, 1, 1, 0, 0, -5604.14, -513.782, 413.307, 1.65982, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240080, 23686, 0, 1, 1, 0, 0, -5598.68, -513.39, 414.025, 5.2648, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240081, 23686, 0, 1, 1, 0, 0, -5599.48, -512.527, 408.986, 5.44544, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240082, 23686, 0, 1, 1, 0, 0, -5592.6, -508.075, 403.549, 5.63393, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240083, 23686, 0, 1, 1, 0, 0, -5591.12, -503.569, 413.127, 4.18881, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240084, 23686, 0, 1, 1, 0, 0, -5588.98, -504.686, 417.844, 4.4205, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240085, 23686, 0, 1, 1, 0, 0, -5584.89, -505.9, 418.015, 4.98991, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240086, 23686, 0, 1, 1, 0, 0, -5585.14, -501.982, 411.204, 4.52654, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240087, 23686, 0, 1, 1, 0, 0, -5579.4, -503.062, 411.204, 4.52654, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240088, 23686, 0, 1, 1, 0, 0, -5581.88, -503.502, 412.972, 4.97814, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240089, 23686, 1, 1, 1, 0, 0, 310.521, -4775.41, 20.2359, 0.12625, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240090, 23686, 1, 1, 1, 0, 0, 298.649, -4773.64, 10.7717, 4.34384, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240091, 23686, 1, 1, 1, 0, 0, 325.928, -4770.62, 17.8451, 3.38173, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240092, 23686, 1, 1, 1, 0, 0, 291.783, -4773.08, 20.9001, 5.17244, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240093, 23686, 1, 1, 1, 0, 0, 302.596, -4775.97, 14.7386, 4.20247, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240094, 23686, 0, 1, 1, 0, 0, -5568.61, -467.541, 401.123, 1.35745, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240095, 23686, 0, 1, 1, 0, 0, -5577.59, -503.351, 412.58, 5.1038, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240096, 23686, 0, 1, 1, 0, 0, -5584.31, -463.29, 402.817, 1.96613, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240097, 23686, 0, 1, 1, 0, 0, -5573.77, -461.494, 406.449, 0.874428, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240098, 23686, 0, 1, 1, 0, 0, -5573.51, -463.361, 412.5, 1.12183, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240099, 23686, 0, 1, 1, 0, 0, -5573.96, -458.593, 414.022, 0.717348, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240100, 23686, 0, 1, 1, 0, 0, -5580.72, -460.588, 414.27, 0.717348, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240101, 23686, 0, 1, 1, 0, 0, -9464.66, 32.6633, 72.6435, 2.92302, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240102, 23686, 0, 1, 1, 0, 0, 2241.12, 241.988, 51.0614, 1.28194, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240103, 23686, 0, 1, 1, 0, 0, 2248.77, 258.719, 47.5138, 6.01003, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240104, 23686, 0, 1, 1, 0, 0, 2249.51, 257.851, 37.9912, 4.54527, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240105, 23686, 0, 1, 1, 0, 0, 2250.19, 258.114, 44.602, 4.14472, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240106, 23686, 0, 1, 1, 0, 0, 2245.22, 249.155, 46.5302, 6.12785, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240107, 23686, 0, 1, 1, 0, 0, 2246.39, 256.624, 46.2303, 6.13177, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240108, 23686, 0, 1, 1, 0, 0, 2244.78, 257.333, 41.9934, 5.63305, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240109, 23686, 0, 1, 1, 0, 0, 2244.14, 253.663, 39.5669, 5.36601, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240110, 23686, 0, 1, 1, 0, 0, 2236.36, 302.109, 37.7981, 2.61319, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240111, 23686, 0, 1, 1, 0, 0, 2241.21, 239.507, 45.7771, 0.060643, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240112, 23686, 0, 1, 1, 0, 0, 2242.26, 236.977, 38.7063, 0.0213733, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240113, 23686, 0, 1, 1, 0, 0, 2243.21, 243.267, 37.1663, 6.27314, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240114, 23686, 0, 1, 1, 0, 0, 2242.27, 241.958, 44.4382, 6.03752, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240115, 23686, 0, 1, 1, 0, 0, 2237.76, 301.688, 45.2893, 3.14726, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240116, 23686, 0, 1, 1, 0, 0, 2240.28, 307.218, 41.0354, 2.34223, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240117, 23686, 0, 1, 1, 0, 0, 2243.34, 310.289, 42.5439, 2.34223, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240118, 23686, 0, 1, 1, 0, 0, 2243.65, 310.66, 36.7168, 2.26369, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240119, 23686, 0, 1, 1, 0, 0, 2237.94, 304.373, 40.9636, 1.38797, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240120, 23686, 0, 1, 1, 0, 0, 2234.32, 299.751, 38.1606, 1.58824, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240121, 23686, 530, 1, 1, 0, 0, 9505.5, -6841.49, 18.228, 4.45473, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240122, 23686, 530, 1, 1, 0, 0, 9509.24, -6842.47, 17.0566, 4.45473, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240123, 23686, 530, 1, 1, 0, 0, 9485.45, -6827.55, 16.6444, 3.39052, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240124, 23686, 530, 1, 1, 0, 0, 9488.82, -6839.38, 33.1865, 3.96386, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240125, 23686, 530, 1, 1, 0, 0, 9485.72, -6837.64, 33.1021, 5.80169, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240126, 23686, 530, 1, 1, 0, 0, 9492.07, -6842.72, 33.1321, 2.33809, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240127, 23686, 0, 1, 1, 0, 0, 2225.84, 304.266, 46.4147, 3.00196, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240128, 23686, 0, 1, 1, 0, 0, 2242, 309.015, 46.1168, 2.75849, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240129, 23686, 0, 1, 1, 0, 0, 2244.82, 311.809, 45.4475, 2.22834, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240130, 23686, 0, 1, 1, 0, 0, 2241.76, 306.656, 47.487, 1.47829, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240131, 23686, 0, 1, 1, 0, 0, 2236.71, 302.204, 45.5017, 1.47829, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240132, 23686, 0, 1, 1, 0, 0, 2234.26, 300.082, 44.2792, 1.47829, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240133, 23686, 530, 1, 1, 0, 0, 9490.71, -6839.79, 30.2413, 3.65363, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240134, 23686, 530, 1, 1, 0, 0, 9487.77, -6836.72, 29.9833, 3.65363, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240135, 23686, 530, 1, 1, 0, 0, 9487.71, -6838.23, 24.0048, 3.6929, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240136, 23686, 530, 1, 1, 0, 0, 9485, -6835.48, 21.9232, 3.79893, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240137, 23686, 530, 1, 1, 0, 0, 9485.42, -6835.9, 18.184, 3.82249, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240138, 23686, 530, 1, 1, 0, 0, 9489.2, -6839.72, 27.0619, 4.01491, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240139, 23686, 530, 1, 1, 0, 0, 9492.48, -6843.05, 27.0625, 4.01491, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240140, 23686, 530, 1, 1, 0, 0, 9493.01, -6843.59, 19.9351, 4.01491, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240141, 23686, 530, 1, 1, 0, 0, 9493.61, -6841.92, 18.2747, 4.01491, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240142, 23686, 530, 1, 1, 0, 0, 9517.58, -6851.59, 18.0884, 4.39583, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240143, 23686, 530, 1, 1, 0, 0, 9537.31, -6859.92, 26.9436, 4.77675, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240144, 23686, 530, 1, 1, 0, 0, 9527.1, -6861.42, 32.3293, 4.65108, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240145, 23686, 530, 1, 1, 0, 0, 9530.93, -6861.8, 33.3419, 5.09483, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240146, 23686, 530, 1, 1, 0, 0, 9523.08, -6861.09, 33.994, 4.18377, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240147, 23686, 530, 1, 1, 0, 0, 9522.55, -6861.44, 18.7315, 4.37619, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240148, 23686, 530, 1, 1, 0, 0, 9518.12, -6861.42, 18.7342, 4.37619, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240149, 23686, 530, 1, 1, 0, 0, 9520.42, -6861.43, 23.6705, 4.37619, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240150, 23686, 530, 1, 1, 0, 0, 9522.7, -6861.44, 28.1221, 4.71391, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240151, 23686, 530, 1, 1, 0, 0, 9529.84, -6861.48, 28.1221, 4.71391, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240152, 23686, 530, 1, 1, 0, 0, 9529.8, -6861.48, 21.5105, 4.9456, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240153, 23686, 530, 1, 1, 0, 0, 9534.08, -6861.51, 23.6283, 4.67464, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240154, 23686, 530, 1, 1, 0, 0, 9534.31, -6856.01, 19.8163, 4.56076, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240155, 23686, 0, 1, 1, 0, 0, 2229.74, 302.85, 43.9636, 1.47829, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240156, 23686, 0, 1, 1, 0, 0, -9459.58, 32.001, 72.8428, 2.58137, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240157, 23686, 0, 1, 1, 0, 0, -9456.21, 29.1498, 73.8424, 4.05007, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240158, 23686, 0, 1, 1, 0, 0, -5584.24, -463.413, 413.694, 0.744837, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240159, 23686, 0, 1, 1, 0, 0, -5586.42, -463.204, 413.173, 1.76193, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240160, 23686, 0, 1, 1, 0, 0, -9447.45, 94.5027, 68.9181, 5.28707, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240161, 23686, 0, 1, 1, 0, 0, -9452.72, 92.2579, 68.34, 2.69918, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240162, 23686, 0, 1, 1, 0, 0, -9451.72, 89.4413, 66.4258, 2.69918, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240163, 23686, 0, 1, 1, 0, 0, -9452.03, 85.3028, 66.0526, 1.46217, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240164, 23686, 0, 1, 1, 0, 0, -9454.76, 84.8473, 67.1419, 0.888833, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240165, 23686, 0, 1, 1, 0, 0, -9457.31, 81.8038, 68.5692, 0.0327492, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240166, 23686, 0, 1, 1, 0, 0, -9460.92, 87.7924, 69.1864, 0.826001, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240167, 23686, 0, 1, 1, 0, 0, -9460.53, 84.1486, 69.4261, 1.83131, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240168, 23686, 0, 1, 1, 0, 0, -9463.92, 83.2453, 67.4807, 0.181975, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240169, 23686, 0, 1, 1, 0, 0, -9464.64, 87.1281, 67.2725, 0.181975, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240170, 23686, 0, 1, 1, 0, 0, -9467.97, 86.5149, 65.9091, 0.181975, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240171, 23686, 0, 1, 1, 0, 0, -9467.35, 82.9501, 66.12, 4.74121, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240172, 23686, 0, 1, 1, 0, 0, -9461.64, 82.7853, 62.8236, 1.68601, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240173, 23686, 0, 1, 1, 0, 0, -9465.66, 82.2127, 63.5708, 1.39934, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240174, 23686, 0, 1, 1, 0, 0, -9467.38, 82.495, 60.0019, 1.43075, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240175, 23686, 0, 1, 1, 0, 0, -9464.43, 78.7046, 57.1723, 1.35221, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240176, 23686, 0, 1, 1, 0, 0, -9475.2, 30.0327, 74.3358, 6.1078, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240177, 23686, 0, 1, 1, 0, 0, -9480.12, 31.2321, 68.8904, 6.06853, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240178, 23686, 0, 1, 1, 0, 0, -9479.79, 36.6747, 68.3554, 5.96251, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240179, 23686, 0, 1, 1, 0, 0, -9476.73, 38.4616, 72.8948, 4.83153, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240180, 23686, 0, 1, 1, 0, 0, -9475.68, 43.5785, 72.9378, 4.15217, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240181, 23686, 0, 1, 1, 0, 0, -9472.14, 43.2766, 75.3386, 1.50145, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240182, 23686, 0, 1, 1, 0, 0, -9469.59, 36.15, 73.544, 4.28176, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240183, 23686, 0, 1, 1, 0, 0, -9468.08, 39.4386, 73.0729, 2.55781, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240184, 23686, 0, 1, 1, 0, 0, -9464.36, 37.7416, 70.4258, 3.0212, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240185, 23686, 0, 1, 1, 0, 0, -5584.51, -460.476, 414.328, 0.717348, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240186, 23686, 0, 1, 1, 0, 0, 2245.56, 254.684, 34.5116, 5.51917, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240187, 23686, 0, 1, 1, 0, 0, 2238.91, 249.698, 35.2978, 5.89616, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240188, 23686, 0, 1, 1, 0, 0, 2240.08, 252.486, 41.0171, 5.64091, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240189, 23686, 0, 1, 1, 0, 0, -9453.91, 32.6336, 72.2759, 5.51876, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240190, 23686, 0, 1, 1, 0, 0, -9454.65, 36.8722, 69.8408, 5.51876, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO creature VALUES (240191, 23686, 0, 1, 1, 0, 0, -9457.34, 39.4545, 68.205, 5.51091, 300, 0, 0, 7185, 7196, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(12, 240026),(12, 240027),(12, 240028),(12, 240029),(12, 240030),(12, 240031),(12, 240032),(12, 240033)
,(12, 240034),(12, 240035),(12, 240036),(12, 240037),(12, 240038),(12, 240039),(12, 240040),(12, 240041),(12, 240042),(12, 240043),(12, 240044)
,(12, 240045),(12, 240046),(12, 240047),(12, 240048),(12, 240049),(12, 240050),(12, 240051),(12, 240052),(12, 240053),(12, 240054),(12, 240055)
,(12, 240056),(12, 240057),(12, 240058),(12, 240059),(12, 240060),(12, 240061),(12, 240062),(12, 240063),(12, 240064),(12, 240065),(12, 240066)
,(12, 240067),(12, 240068),(12, 240069),(12, 240070),(12, 240071),(12, 240072),(12, 240073),(12, 240074),(12, 240075),(12, 240076),(12, 240077)
,(12, 240078),(12, 240079),(12, 240080),(12, 240081),(12, 240082),(12, 240083),(12, 240084),(12, 240085),(12, 240086),(12, 240087),(12, 240088)
,(12, 240089),(12, 240090),(12, 240091),(12, 240092),(12, 240093),(12, 240094),(12, 240095),(12, 240096),(12, 240097),(12, 240098),(12, 240099)
,(12, 240100),(12, 240101),(12, 240102),(12, 240103),(12, 240104),(12, 240105),(12, 240106),(12, 240107),(12, 240108),(12, 240109)
,(12, 240110),(12, 240111),(12, 240112),(12, 240113),(12, 240114),(12, 240115),(12, 240116),(12, 240117),(12, 240118),(12, 240119)
,(12, 240120),(12, 240121),(12, 240122),(12, 240123),(12, 240124),(12, 240125),(12, 240126),(12, 240127),(12, 240128),(12, 240129)
,(12, 240130),(12, 240131),(12, 240132),(12, 240133),(12, 240134),(12, 240135),(12, 240136),(12, 240137),(12, 240138),(12, 240139)
,(12, 240140),(12, 240141),(12, 240142),(12, 240143),(12, 240144),(12, 240145),(12, 240146),(12, 240147),(12, 240148),(12, 240149)
,(12, 240150),(12, 240151),(12, 240152),(12, 240153),(12, 240154),(12, 240155),(12, 240156),(12, 240157),(12, 240158),(12, 240159)
,(12, 240160),(12, 240161),(12, 240162),(12, 240163),(12, 240164),(12, 240165),(12, 240166),(12, 240167),(12, 240168),(12, 240169)
,(12, 240170),(12, 240171),(12, 240172),(12, 240173),(12, 240174),(12, 240175),(12, 240176),(12, 240177),(12, 240178),(12, 240179)
,(12, 240180),(12, 240181),(12, 240182),(12, 240183),(12, 240184),(12, 240185),(12, 240186),(12, 240187),(12, 240188),(12, 240189)
,(12, 240190),(12, 240191);

-- HEADLESS HORSEMAN ATTACK
UPDATE gameobject_template SET AIName="", ScriptName="go_loosely_turned_soil" WHERE entry=186314;
REPLACE INTO creature_template VALUES (23682, 0, 0, 0, 0, 0, 22351, 0, 0, 0, 'Headless Horseman', '', NULL, 0, 80, 80, 2, 14, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 256, 2048, 8, 0, 0, 0, 0, 0, 341, 506, 80, 10, 1024, 23682, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 33277, 0, 0, 0, 0, 0, 167, 1, 650854267, 0, 'boss_headless_horseman', 12340);
REPLACE INTO creature_template VALUES (23775, 0, 0, 0, 0, 0, 21908, 0, 0, 0, 'Head of the Horseman', '', NULL, 0, 80, 80, 2, 14, 0, 0.8, 0.8, 1, 1, 422, 586, 0, 642, 7.5, 2000, 0, 1, 33816576, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 88, 1, 0, 0, 'boss_headless_horseman_head', 12340);
DELETE FROM waypoint_data WHERE id=236820;
INSERT INTO waypoint_data VALUES (236820, 1, 1766.39, 1348.03, 28.2184, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 2, 1765.75, 1336.74, 34.9747, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 3, 1774.92, 1335.9, 41.6711, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 4, 1787.8, 1344.29, 43.7657, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 5, 1787.41, 1361.52, 43.8611, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 6, 1772.69, 1373.08, 41.2509, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 7, 1754.22, 1376.07, 31.1831, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 8, 1753.06, 1375.07, 29.7447, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 9, 1753.08, 1372.73, 28.2154, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 10, 1754.73, 1369.62, 25.968, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 11, 1758.17, 1367.42, 23.2298, 0, 0, 0, 0, 100, 0);
INSERT INTO waypoint_data VALUES (236820, 12, 1763.47, 1365.28, 18.3177, 0, 0, 0, 0, 100, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(43101, 42401);
INSERT INTO conditions VALUES (13, 1, 43101, 0, 0, 31, 0, 3, 23682, 0, 0, 0, 0, '', 'Headless Horseman - Damage info');
INSERT INTO conditions VALUES (13, 1, 43101, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Headless Horseman - Damage info');
INSERT INTO conditions VALUES (13, 1, 42401, 0, 0, 31, 0, 3, 23682, 0, 0, 0, 0, '', 'Headless Horseman - Return head');
INSERT INTO conditions VALUES (13, 1, 42401, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Headless Horseman - Return head');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(42405);
INSERT INTO conditions VALUES (13, 1, 42405, 0, 0, 31, 0, 3, 23775, 0, 0, 0, 0, '', 'Headless Horseman - Horseman restored');
INSERT INTO conditions VALUES (13, 1, 42405, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Headless Horseman - Horseman restored');
REPLACE INTO creature_template VALUES (23545, 0, 0, 0, 0, 0, 21822, 0, 0, 0, 'Pumpkin Fiend', '', NULL, 0, 80, 80, 1, 14, 0, 1, 1.14286, 1, 0, 252, 357, 0, 304, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 215, 320, 44, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3391, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.65, 0.5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8388624, 0, '', 12340);
REPLACE INTO creature_template VALUES (23694, 0, 0, 0, 0, 0, 24720, 0, 0, 0, 'Pulsing Pumpkin', '', NULL, 0, 80, 80, 0, 14, 0, 1, 1.14286, 1, 0, 422, 586, 0, 642, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.75, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 'boss_headless_horseman_pumpkin', 12340);

-- Loot
DELETE FROM creature_loot_template WHERE entry=23682;
INSERT INTO creature_loot_template VALUES (23682, 33277, -100, 1, 0, 1, 1);
INSERT INTO creature_loot_template VALUES (23682, 34068, 30, 1, 0, 3, 6);
INSERT INTO creature_loot_template VALUES (23682, 49121, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (23682, 49123, 0, 1, 1, 1, 1);
INSERT INTO creature_loot_template VALUES (23682, 49124, 0, 1, 1, 1, 1);
DELETE FROM item_loot_template WHERE entry=54516;
INSERT INTO item_loot_template VALUES (54516, 1, 100, 1, 0, -10020, 1);
INSERT INTO item_loot_template VALUES (54516, 49426, 100, 1, 0, 2, 2);
INSERT INTO item_loot_template VALUES (54516, 33226, 100, 1, 0, 2, 3);
INSERT INTO item_loot_template VALUES (54516, 33154, 8, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 33292, 8, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 37011, 20, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 33176, 10, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 37012, 1, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 49126, 2, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES (54516, 49128, 2, 1, 0, 1, 1);

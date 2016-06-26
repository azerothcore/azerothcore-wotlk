-- -------------------------------------------
-- OUTLANDS
-- -------------------------------------------

-- Wrangle Some Aether Rays! (11065)
-- Wrangle More Aether Rays! (11066)
DELETE FROM smart_scripts WHERE entryorguid=22181 AND source_type=0 AND id > 1;
UPDATE creature_template SET InhabitType=7, flags_extra=2, unit_flags=2, AIName="NullCreatureAI" WHERE entry=23343;
DELETE FROM smart_scripts WHERE entryorguid=23343 AND source_type=0;
DELETE FROM spell_script_names WHERE spell_id=40856;
INSERT INTO spell_script_names VALUES(40856, "spell_q11065_wrangle_some_aether_rays");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=40856;
INSERT INTO conditions VALUES (17, 0, 40856, 0, 0, 31, 1, 3, 22181, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (17, 0, 40856, 0, 0, 36, 1, 0, 0, 0, 0, 0, 0, '', '');


-- The Ring of Blood: Brokentoe (9962)
-- The Ring of Blood: The Blue Brothers (9967)
-- The Ring of Blood: Rokdar the Sundered Lord (9970)
-- The Ring of Blood: Skra'gath (9972)
-- The Ring of Blood: The Warmaul Champion (9973)
UPDATE smart_scripts SET target_type=7, action_type=26 WHERE event_type=6 AND entryorguid IN(18398, 18399, 18400, 18401, 18402);
-- The Ring of Blood: The Final Challenge (9977)
UPDATE smart_scripts SET target_type=7, action_type=26, action_param1=9977, action_param2=0 WHERE event_type=6 AND entryorguid IN(18069);

-- Quenching the Blade (10679)
UPDATE gameobject_template SET flags=4, data0=43, data1=21583, data8=10679 WHERE entry=185032;
UPDATE gameobject_loot_template SET ChanceOrQuestChance=-100 WHERE item=30876;

-- A Curse Upon Both of Your Clans! (10544)
DELETE FROM spell_script_names WHERE spell_id IN(32580);

-- Prisoner of the Bladespire (10724)
UPDATE creature_loot_template SET ChanceOrQuestChance=-20 WHERE item=31755;
UPDATE creature_template SET speed_run=2.5, InhabitType=4 WHERE entry=22268;
DELETE FROM creature_text WHERE entry=22460;
INSERT INTO creature_text VALUES (22460, 0, 0, '%s uses the key to open the cage.', 16, 0, 100, 0, 0, 0, 0, 'Spirit');
UPDATE creature_template SET InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=22460;
DELETE FROM smart_scripts WHERE entryorguid=22460 AND source_type=0;
INSERT INTO smart_scripts VALUES (22460, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3671.93, 5286.27, 20.63, 0, 'Spirit - On Update - Move To Position');
INSERT INTO smart_scripts VALUES (22460, 0, 1, 0, 34, 0, 100, 257, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.26, 'Spirit - Movement Inform - Set Orientation');
INSERT INTO smart_scripts VALUES (22460, 0, 2, 0, 60, 0, 100, 257, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spirit - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (22460, 0, 3, 0, 60, 0, 100, 257, 4000, 4000, 0, 0, 131, 0, 0, 0, 0, 0, 0, 14, 26169, 185296, 1, 0, 0, 0, 0, 'Spirit - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (22460, 0, 4, 0, 60, 0, 100, 257, 4500, 4500, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3683.23, 5289.64, 20.6, 0, 'Spirit - On Update - Move To Pos');
INSERT INTO smart_scripts VALUES (22460, 0, 5, 0, 60, 0, 100, 257, 5000, 5000, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 10, 78289, 22268, 1, 0, 0, 0, 0, 'Spirit - On Update - Move To Pos Target');
INSERT INTO smart_scripts VALUES (22460, 0, 6, 0, 60, 0, 100, 257, 5000, 5000, 0, 0, 130, 2, 0, 0, 0, 0, 0, 10, 78289, 22268, 1, 3608.52, 5362.66, 44.18, 0, 'Spirit - On Update - Move To Pos Target');
INSERT INTO smart_scripts VALUES (22460, 0, 7, 0, 60, 0, 100, 257, 7500, 7500, 0, 0, 131, 1, 0, 0, 0, 0, 0, 14, 26169, 185296, 1, 0, 0, 0, 0, 'Spirit - On Update - Set Gameobject State');
INSERT INTO smart_scripts VALUES (22460, 0, 8, 0, 60, 0, 100, 257, 8000, 8000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spirit - On Update - Despawn');

-- Banish the Demons (11026)
-- Banish More Demons (11051)
UPDATE quest_template SET RequiredMinRepValue=9000 WHERE id=11026;
UPDATE creature_template SET modelid1=11686, modelid2=0, unit_flags=33554432 WHERE entry IN(23322, 23327);
REPLACE INTO creature_template_addon VALUES(23322, 0, 0, 0, 1, 0, "40849 40857");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(40830, 40825, 40828);
INSERT INTO conditions VALUES(13, 1, 40830, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 40830, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 40825, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 40825, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 40828, 0, 0, 31, 0, 3, 23322, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 40828, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM spell_script_names WHERE spell_id IN(40825, 40828);
INSERT INTO spell_script_names VALUES(40825, "spell_q11026_a11051_banish_the_demons");
INSERT INTO spell_script_names VALUES(40828, "spell_q11026_a11051_banish_the_demons");

-- Simon game, fix linking
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-40623, -40625, -40626);
INSERT INTO spell_linked_spell VALUES(-40623, -40624, 0, "Apexis Vibrations speed remove");
INSERT INTO spell_linked_spell VALUES(-40625, -40627, 0, "Apexis Emanations speed remove");
INSERT INTO spell_linked_spell VALUES(-40626, -40628, 0, "Apexis Enlightenment speed remove");
DELETE FROM spell_area WHERE spell IN(40623, 40625, 40626);
INSERT INTO spell_area VALUES (40623, 3522, 0, 0, 0, 0, 2, 0, 0, 0);
INSERT INTO spell_area VALUES (40625, 3522, 0, 0, 0, 0, 2, 0, 0, 0);
INSERT INTO spell_area VALUES (40626, 3522, 0, 0, 0, 0, 2, 0, 0, 0);

-- Vision Guide (10525)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(36587);
INSERT INTO spell_linked_spell VALUES(36587, 36573, 1, "Vision Guide quest");
DELETE FROM spell_script_names WHERE spell_id IN(36573);
INSERT INTO spell_script_names VALUES(36573, "spell_q10525_vision_guide");

-- As the Crow Flies (9718)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(31606);
INSERT INTO spell_linked_spell VALUES(31606, 38776, 1, "As the Crow Flies quest");
DELETE FROM event_scripts WHERE id=11225;
INSERT INTO event_scripts VALUES(11225, 0, 7, 9718, 0, 0, 0, 0, 0, 0);
INSERT INTO event_scripts VALUES(11225, 0, 14, 38776, 0, 0, 0, 0, 0, 0);

-- The Soul Cannon of Reth'hedron (11089)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8725);
INSERT INTO conditions VALUES(15, 8725, 1, 0, 0, 9, 0, 11089, 0, 0, 0, 0, 0, '', 'The Soul Cannon of Reth\'hedron');
INSERT INTO conditions VALUES(15, 8725, 1, 0, 0, 29, 0, 23100, 100, 0, 1, 0, 0, '', 'The Soul Cannon of Reth\'hedron');
DELETE FROM gossip_menu_option WHERE menu_id=8725;
INSERT INTO gossip_menu_option VALUES(8725, 1, 0, "Start the ritual.", 1, 1, 0, 0, 0, 0, "");
UPDATE creature_template SET gossip_menu_id=8725, AIName="SmartAI" WHERE entry=23093;
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=23093;
INSERT INTO smart_scripts VALUES (23093, 0, 0, 1, 62, 0, 100, 0, 8725, 1, 0, 0, 11, 40134, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sarthis Gossip select Cast Summon Arcane Elemental');
INSERT INTO smart_scripts VALUES (23093, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Sarthis On Gossip Select - Close Gossip');
DELETE FROM npc_text WHERE ID=11030;
INSERT INTO npc_text VALUES ('11030', 'What is it that you want?', '', '0', '1', '0', '6', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '12340');
DELETE FROM gossip_menu WHERE entry=8725 AND text_id=11030;
INSERT INTO gossip_menu VALUES (8725,11030);
DELETE FROM event_scripts WHERE id=14860;
INSERT INTO event_scripts VALUES(14860, 0, 10, 23100, 300000, 1, -2468.7, 4700.5, 155.82, 3.0);
UPDATE creature_template SET faction=14 WHERE entry=23100;

-- Adversarial Blood (11885)
-- Adversarial Blood (11072)
-- Tokens of the Descendants (11074)
DELETE FROM creature_text WHERE entry IN(23161, 23165);
INSERT INTO creature_text VALUES (23165, 0, 0, 'You capture Karrog! Karrog smash you!', 12, 0, 100, 0, 0, 0, 0, 'Karrog');
INSERT INTO creature_text VALUES (23161, 0, 0, 'Hear the voices below the earth! They call for your blood!', 12, 0, 100, 0, 0, 0, 0, 'Darkscreecher Akkarai');
UPDATE creature_template SET faction=14, unit_flags=0, AIName='SmartAI', ScriptName='' WHERE entry IN(23205, 23165, 23161, 23162);
UPDATE creature_template SET faction=14, unit_flags=0, type_flags=1, AIName='SmartAI', ScriptName='' WHERE entry=23163;
DELETE FROM smart_scripts WHERE entryorguid IN(23205, 23165, 23161) AND source_type=0;
INSERT INTO smart_scripts VALUES (23165, 0, 0, 0, 60, 0, 100, 257, 1000, 1000, 0, 0, 18, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (23165, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 11000, 15000, 11, 40488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog - In Combat - Cast Trample');
INSERT INTO smart_scripts VALUES (23165, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 21000, 35000, 11, 40416, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Karrog - In Combat - Cast Fixated Rage');
INSERT INTO smart_scripts VALUES (23165, 0, 3, 4, 6, 0, 100, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 'Karrog - On Death - Summon Karrog Shardling');
INSERT INTO smart_scripts VALUES (23165, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, -5, 0, 0, 0, 'Karrog - On Death - Summon Karrog Shardling');
INSERT INTO smart_scripts VALUES (23165, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 23205, 4, 10000, 0, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 'Karrog - On Death - Summon Karrog Shardling');
INSERT INTO smart_scripts VALUES (23205, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 89, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog Shardling - On Update - Move Random');
INSERT INTO smart_scripts VALUES (23205, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 24240, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Karrog Shardling - On Update - Cast Spawn - Red Lightning');
INSERT INTO smart_scripts VALUES (23161, 0, 0, 0, 60, 0, 100, 257, 1000, 1000, 0, 0, 18, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - On Update - Say Line 0');
INSERT INTO smart_scripts VALUES (23161, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 2000, 3500, 11, 40429, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (23161, 0, 2, 0, 0, 0, 100, 0, 6000, 8000, 14000, 21000, 11, 40428, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (23161, 0, 3, 0, 0, 0, 100, 0, 10000, 11000, 25000, 33000, 11, 15730, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 'Darkscreecher Akkarai - In Combat - Cast Curse of Mending');

-- Teleport This! (10857)
UPDATE creature_template SET spell1=36255, spell2=8599, spell3=38920 WHERE entry=16943;
UPDATE creature_template SET spell1=33963, spell2=36251, spell3=38920 WHERE entry=20928;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38920;
INSERT INTO conditions VALUES (13, 7, 38920, 0, 0, 31, 0, 3, 22348, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 7, 38920, 0, 1, 31, 0, 3, 22350, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 7, 38920, 0, 2, 31, 0, 3, 22351, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry IN(22348, 22350, 22351);
DELETE FROM smart_scripts WHERE entryorguid IN(22348, 22350, 22351) AND source_type=0;
INSERT INTO smart_scripts VALUES (22348, 0, 0, 0, 8, 0, 100, 0, 38920, 0, 0, 0, 33, 22348, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell hit');
INSERT INTO smart_scripts VALUES (22350, 0, 0, 0, 8, 0, 100, 0, 38920, 0, 0, 0, 33, 22350, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell hit');
INSERT INTO smart_scripts VALUES (22351, 0, 0, 0, 8, 0, 100, 0, 38920, 0, 0, 0, 33, 22351, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell hit');
DELETE FROM gameobject WHERE id=185215;
INSERT INTO gameobject VALUES (NULL, 185215, 530, 1, 1, 4734.71, 3193.67, 161.48, 0.386745, 0, 0, 0.19217, 0.981362, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 185215, 530, 1, 1, 4673.28, 3126.67, 166.725, 5.42979, 0, 0, 0.413867, -0.910337, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 185215, 530, 1, 1, 4697.5, 3298.68, 178.892, 2.02823, 0, 0, 0.849013, 0.528372, 600, 0, 1, 0);

-- Terokk's Downfall (11073)
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=185928;
DELETE FROM gossip_menu_option WHERE menu_id=8687;
INSERT INTO gossip_menu_option VALUES(8687, 1, 0, "<Call forth Terokk.>", 1, 1, 0, 0, 0, 0, "");
DELETE FROM event_scripts WHERE id=15014;
INSERT INTO event_scripts VALUES(15014, 4, 10, 21838, 600000, 1, -3788, 3509, 287, 5.7);
DELETE FROM smart_scripts WHERE entryorguid=185928 AND source_type=1;
INSERT INTO smart_scripts VALUES (185928, 1, 0, 1, 62, 0, 100, 0, 8687, 1, 0, 0, 85, 41004, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Terokk summon');
INSERT INTO smart_scripts VALUES (185928, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Terokk summon - linked close gossip');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8687);
DELETE FROM creature_text WHERE entry=21838;
REPLACE INTO creature_text VALUES (21838, 0, 0, "Who calls me to this world? The stars are not yet aligned... my powers fail me! You will pay for this!", 12, 0, 100, 0, 0, 0, 0, 'Terokk');
REPLACE INTO creature_text VALUES (21838, 1, 0, "You cannot kill me, I am immortal!", 14, 0, 100, 0, 0, 0, 0, 'Terokk');
REPLACE INTO creature_text VALUES (21838, 2, 0, "%s becomes enraged as his shield shatters.", 41, 0, 100, 0, 0, 0, 0, 'Terokk');
DELETE FROM smart_scripts WHERE entryorguid=21838 AND source_type=0;
INSERT INTO smart_scripts VALUES (21838, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 11, 40721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Terokk - In Combat - Cast 'Shadow Bolt Volley'");
INSERT INTO smart_scripts VALUES (21838, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 7000, 9000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Terokk - In Combat - Cast 'Cleave'");
INSERT INTO smart_scripts VALUES (21838, 0, 2, 3, 2, 0, 100, 1, 0, 30, 120000, 120000, 11, 40733, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - Between 0-30% Health - Cast 'Divine Shield' (No Repeat)");
INSERT INTO smart_scripts VALUES (21838, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - Between 0-30% Health - Say Line 0 (No Repeat)");
INSERT INTO smart_scripts VALUES (21838, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 23377, 90, 0, 0, 0, 0, 0, "Terokk - Between 0-30% Health - Set Data");
INSERT INTO smart_scripts VALUES (21838, 0, 5, 6, 23, 0, 100, 0, 40657, 1, 600000, 600000, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - Has Aura - Talk 2");
INSERT INTO smart_scripts VALUES (21838, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 11, 28747, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - Has Aura - Cast Frenzy");
INSERT INTO smart_scripts VALUES (21838, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 40733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - Has Aura - Remove Aura Divine Shield");
INSERT INTO smart_scripts VALUES (21838, 0, 8, 0, 6, 0, 100, 1, 0, 0, 0, 0, 11, 40722, 7, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Terokk - On Just Died - Cast 'Will of the Arakkoa God' (No Repeat)");
INSERT INTO smart_scripts VALUES (21838, 0, 9, 10, 4, 0, 100, 1, 0, 0, 0, 0, 12, 23377, 3, 240000, 0, 0, 0, 8, 0, 0, 0, -3771.60, 3499.32, 317.88, 2.5, "Terokk - On Aggro - Summon Creature");
INSERT INTO smart_scripts VALUES (21838, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 23377, 90, 0, 0, 0, 0, 0, "Terokk - On Aggro - Talk Target 0");
INSERT INTO smart_scripts VALUES (21838, 0, 11, 0, 11, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - On Respawn - Talk 0");
INSERT INTO smart_scripts VALUES (21838, 0, 12, 13, 7, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - On Evade - Remove All Auras");
INSERT INTO smart_scripts VALUES (21838, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 23377, 90, 0, 0, 0, 0, 0, "Terokk - On Evade - Despawn Target");
INSERT INTO smart_scripts VALUES (21838, 0, 14, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 39579, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Terokk - On Update - Cast Shadowform");
DELETE FROM creature_text WHERE entry=23377;
REPLACE INTO creature_text VALUES (23377, 0, 0, "Enemy sighted! Fall into formation and prepare for bombing maneuvers!", 14, 0, 100, 0, 0, 0, 0, 'Skyguard Ace');
REPLACE INTO creature_text VALUES (23377, 1, 0, "Quickly! Use the flames and support ground troops. Its ancient magic should cleanse Terokk's shield.", 14, 0, 100, 0, 0, 0, 0, 'Skyguard Ace');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40657;
INSERT INTO conditions VALUES(13, 6, 40657, 0, 0, 31, 0, 3, 23277, 0, 0, 0, 0, '', 'Requires Skyguard Target');
REPLACE INTO creature_template_addon VALUES (23377, 0, 21152, 0, 1, 0, '');
REPLACE INTO creature_template_addon VALUES (23277, 0, 0, 0, 1, 0, '40656');
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='', flags_extra=128 WHERE entry=23277;
UPDATE creature_template SET faction=1856, InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=23377;
DELETE FROM smart_scripts WHERE entryorguid=23377 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=23377*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (23377, 0, 0, 0, 60, 0, 100, 0, 5000, 5000, 5000, 5000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update - Despawn");
INSERT INTO smart_scripts VALUES (23377, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Talk 1");
INSERT INTO smart_scripts VALUES (23377, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 23377*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - Start Script");
INSERT INTO smart_scripts VALUES (23377*100, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3805, 3515, 287.2, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 1, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
INSERT INTO smart_scripts VALUES (23377*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3797, 3489, 287.1, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 3, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
INSERT INTO smart_scripts VALUES (23377*100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3770, 3501, 287.1, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 5, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
INSERT INTO smart_scripts VALUES (23377*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3805, 3515, 287.2, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 7, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
INSERT INTO smart_scripts VALUES (23377*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3797, 3489, 287.1, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 9, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
INSERT INTO smart_scripts VALUES (23377*100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 23277, 3, 22000, 0, 0, 0, 8, 0, 0, 0, -3770, 3501, 287.1, 0, "Script9 - Summon Creature");
INSERT INTO smart_scripts VALUES (23377*100, 9, 11, 0, 0, 0, 100, 0, 17000, 17000, 0, 0, 11, 40657, 2, 0, 0, 0, 0, 19, 23277, 50, 0, 0, 0, 0, 0, "Script9 - Cast Spell");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=23377;
INSERT INTO conditions VALUES(22, 1, 23377, 0, 0, 29, 1, 21838, 100, 0, 1, 0, 0, '', 'Run action if no npc nearby');

-- A Necessary Distraction (10688)
-- A Necessary Distraction (10637)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(37834);
INSERT INTO conditions VALUES(17, 0, 37834, 0, 0, 31, 1, 3, 21506, 0, 0, 0, 0, '', 'Requires Azaloth');
INSERT INTO conditions VALUES(17, 0, 37834, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Requires Azaloth');
DELETE FROM spell_scripts WHERE id=37834;
INSERT INTO spell_scripts VALUES(37834, 0, 0, 14, 32567, 0, 0, 0, 0, 0, 0);
INSERT INTO spell_scripts VALUES(37834, 0, 0, 8, 21892, 0, 0, 0, 0, 0, 0);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21506);
REPLACE INTO creature_template_addon VALUES(21506, 0, 0, 0, 1, 0, "32567");

-- An Improper Burial (10913)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39189;
INSERT INTO conditions VALUES (13, 1, 39189, 0, 0, 31, 0, 3, 21846, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 39189, 0, 1, 31, 0, 3, 21859, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(21859, 21846);
DELETE FROM smart_scripts WHERE entryorguid IN(21859, 21846) AND source_type=0;
INSERT INTO smart_scripts VALUES(21859, 0, 0, 1, 8, 0, 100, 0, 39189, 0, 0, 0, 33, 21859, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Credit");
INSERT INTO smart_scripts VALUES(21859, 0, 1, 2, 61, 0, 100, 0, 39189, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Despawn");
INSERT INTO smart_scripts VALUES(21859, 0, 2, 0, 61, 0, 100, 0, 39189, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Cast Spell");
INSERT INTO smart_scripts VALUES(21846, 0, 0, 1, 8, 0, 100, 0, 39189, 0, 0, 0, 33, 21846, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Credit");
INSERT INTO smart_scripts VALUES(21846, 0, 1, 2, 61, 0, 100, 0, 39189, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Despawn");
INSERT INTO smart_scripts VALUES(21846, 0, 2, 0, 61, 0, 100, 0, 39189, 0, 0, 0, 11, 59216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Cast Spell");

-- Fire At Will! (10911)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(22474, 22500));
DELETE FROM creature WHERE id IN(22474, 22500);
UPDATE creature_template SET unit_flags=0, modelid2=0, flags_extra=0 WHERE entry IN(22474, 22500); 
UPDATE creature_template SET modelid1=15880, modelid2=0, ScriptName="npc_deahts_door_wrap_gate" WHERE entry IN(22471, 22472);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39221;
INSERT INTO conditions VALUES (13, 1, 39221, 0, 0, 31, 0, 3, 22471, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 39221, 0, 1, 31, 0, 3, 22472, 0, 0, 0, 0, '', '');

-- The Mark of the Nexus-King (10976)
UPDATE gameobject_template SET data2=180000 WHERE entry IN(185465, 185466, 185467, 184595, 185461, 185462, 185463, 185464);
UPDATE creature_template SET faction=14 WHERE entry IN(22828, 22826, 22827, 20888, 22825);

-- Matis the Cruel (9711)
DELETE FROM conditions WHERE SourceEntry=17853 AND SourceTypeOrReferenceId=22;

-- Stasis Chambers of Bash'ir (10974)
UPDATE creature_template SET faction=14 WHERE entry=22920;

-- Stasis Chambers of the Mana-Tombs (10977)
DELETE FROM gameobject WHERE id=185519;
INSERT INTO gameobject VALUES(NULL, 185519, 557, 2, 1, -107.662, -102.516, -0.420004, 0.707648, 0, 0, 0.346487, 0.938055, 300, 100, 1, 0);
UPDATE gameobject_template SET AIName="SmartGameObjectAI" WHERE entry=185519;
DELETE FROM smart_scripts WHERE entryorguid=185519 AND source_type=1;
INSERT INTO smart_scripts VALUES (185519, 1, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 26, 10977, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Summon Pax'ivi");
INSERT INTO smart_scripts VALUES (185519, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 22928, 3, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Summon Pax'ivi");

-- On Spirit's Wings (10714)
DELETE FROM creature_text WHERE entry=22160;
INSERT INTO creature_text VALUES(22160, 0, 0, "Uhh uh... you like candies?", 12, 0, 100, 0, 0, 0, 0, "Bloodmaul Taskmaster");
DELETE FROM creature_text WHERE entry=22384;
INSERT INTO creature_text VALUES(22384, 0, 0, "Candies, yummy! Me like candies.", 12, 0, 100, 0, 0, 0, 0, "Bloodmaul Soothsayer");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=22160;
DELETE FROM smart_scripts WHERE entryorguid IN(-77757) AND source_type=0;
INSERT INTO smart_scripts VALUES(-77757, 0, 0, 0, 1, 0, 100, 0, 0, 0, 12000, 15000, 1, 0, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "OOC update - say text");
INSERT INTO smart_scripts VALUES(-77757, 0, 1, 0, 52, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 22384, 10, 0, 0, 0, 0, 0, "say text");
DELETE FROM spell_script_names WHERE spell_id=38173;
INSERT INTO spell_script_names VALUES(38173, "spell_q10714_on_spirits_wings");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38173;
INSERT INTO conditions VALUES (13, 3, 38173, 0, 0, 31, 0, 3, 22160, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 3, 38173, 0, 1, 31, 0, 3, 22384, 0, 0, 0, 0, '', '');

-- Standards and Practices (9910)
DELETE FROM gameobject WHERE id=182263;
INSERT INTO gameobject VALUES (NULL, 182263, 530, 1, 1, -2532.99, 6306.90, 14.0280, 2.81871, 0, 0, 0.986996, 0.160743, 181, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 182263, 530, 1, 1, -2474.44, 6111.16, 91.7629, 3.66388, 0, 0, 0.966096, -0.258184, 181, 100, 1, 0);
INSERT INTO gameobject VALUES (NULL, 182263, 530, 1, 1, -2533.21, 6168.56, 59.9387, 3.75028, 0, 0, 0.954044, -0.299666, 181, 100, 1, 0);

-- Zuluhed the Whacked (10866)
UPDATE quest_template SET RequiredNpcOrGo1=-185156 WHERE Id=10866;
DELETE FROM spell_script_names WHERE spell_id=38790;

-- Veil Skith: Darkstone of Terokk (10839)
UPDATE gameobject SET state=0 WHERE id=185191;
UPDATE creature_template SET InhabitType=4, AIName='', ScriptName='' WHERE entry=22288;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=185191;
DELETE FROM smart_scripts WHERE entryorguid=185191 AND source_type=1;
INSERT INTO smart_scripts VALUES (185191, 1, 0, 0, 8, 0, 100, 0, 38729, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darkstone of Terokk - On Spell Hit - Set Loot State');

-- The Smallest Creatures (10720)
UPDATE gameobject_template SET ScriptName='' WHERE entry IN(185206, 185213, 185214);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38629;
INSERT INTO conditions VALUES(13, 1, 38629, 0, 0, 31, 0, 3, 22356, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 38629, 0, 1, 31, 0, 3, 22367, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 38629, 0, 2, 31, 0, 3, 22368, 0, 0, 0, 0, '', '');
DELETE FROM spell_script_names WHERE spell_id IN(38629, 38544);
INSERT INTO spell_script_names VALUES(38629, "spell_q10720_the_smallest_creature");

-- Protecting Our Own (10488)
UPDATE quest_template SET RequiredNpcOrGo1=20748 WHERE Id=10488;

-- A Dire Situation (10506)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=36310;
INSERT INTO conditions VALUES (17, 0, 36310, 0, 0, 31, 1, 3, 20058, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName="SmartAI" WHERE entry=20058;
DELETE FROM smart_scripts WHERE entryorguid=20058 AND source_type=0;
INSERT INTO smart_scripts VALUES (20058, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set phase on reset');
INSERT INTO smart_scripts VALUES (20058, 0, 1, 2, 8, 1, 100, 0, 0, 0, 0, 0, 33, 21176, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kill credit on spell hit');
INSERT INTO smart_scripts VALUES (20058, 0, 2, 3, 61, 1, 100, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Force despawn linked');
INSERT INTO smart_scripts VALUES (20058, 0, 3, 0, 61, 1, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Change phase linked');

-- To Bor'gorok Outpost, Quickly! (12486)
UPDATE quest_template SET PrevQuestId=-11598 WHERE Id=12486;

-- What the Soul Sees (10168)
DELETE FROM spell_script_names WHERE spell_id IN(34063, -34063);
DELETE FROM spell_scripts WHERE id IN(34063, -34063);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(34063, -34063) OR spell_effect IN(34063, -34063);
DELETE FROM smart_scripts WHERE entryorguid IN(18688) AND source_type=0;
UPDATE creature_template SET unit_flags=unit_flags|256, AIName="SmartAI", ScriptName="" WHERE entry=18688;
INSERT INTO smart_scripts VALUES (18688, 0, 0, 0, 8, 0, 100, 0, 34063, 0, 0, 0, 36, 19480, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'being hit by soul mirror, update entry');
INSERT INTO smart_scripts VALUES (18688, 0, 1, 0, 21, 0, 100, 0, 0, 0, 0, 0, 36, 18688, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set default entry at reset');
INSERT INTO smart_scripts VALUES (18688, 0, 2, 0, 0, 0, 100, 0, 6000, 10000, 25000, 30000, 11, 31293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'consuming shadow');

-- Dissension Amongst the Ranks... (10769)
DELETE FROM spell_script_names WHERE spell_id=38224;
INSERT INTO spell_script_names VALUES(38224, "spell_q10769_dissension_amongst_the_ranks");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=19823;
DELETE FROM smart_scripts WHERE entryorguid IN(19823) AND source_type=0;
INSERT INTO smart_scripts VALUES(19823, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 38223, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "cast spell on death");
DELETE FROM spell_script_names WHERE spell_id=38223;
INSERT INTO spell_script_names VALUES(38223, "spell_q10769_dissension_amongst_the_ranks");

-- Bloody Imp-ossible! (10924)
UPDATE creature_template SET AIName="SmartAI" WHERE entry=22484;
DELETE FROM smart_scripts WHERE entryorguid=22484 AND source_type=0;
INSERT INTO smart_scripts VALUES(22484, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, "follow owner on reset");
INSERT INTO smart_scripts VALUES(22484, 0, 1, 0, 60, 0, 100, 0, 0, 0, 10000, 10000, 29, 2, 0, 18884, 0, 0, 1, 11, 18884, 30, 2, 0, 0, 0, 0, "follow on ooc update");
INSERT INTO smart_scripts VALUES(22484, 0, 2, 3, 65, 0, 100, 0, 0, 0, 0, 0, 11, 39244, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, "cast spell on follow, only npc follow will reach this event");
INSERT INTO smart_scripts VALUES(22484, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 18884, 10, 2, 0, 0, 0, 0, "despawn targets linked");
INSERT INTO smart_scripts VALUES(22484, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, "follow owner linked");

-- The Demoniac Scryer (10838)
UPDATE creature_template SET ScriptName='' WHERE entry=22258;
DELETE FROM spell_script_names WHERE spell_id=38724;
INSERT INTO spell_script_names VALUES (38724, 'spell_q10838_demoniac_scryer_visual');

-- What Came First, the Drake or the Egg? (10609)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=184867;
DELETE FROM smart_scripts WHERE entryorguid=184867 AND source_type=1;
INSERT INTO smart_scripts VALUES(184867, 1, 0, 0, 64, 0, 100, 0, 3, 0, 0, 0, 12, 20021, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On gossip hello - summon creature");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(184867);
INSERT INTO conditions VALUES(22, 1, 184867, 1, 0, 29, 1, 20021, 30, 0, 1, 0, 0, '', 'no npc near');

-- The Air Strikes Must Continues / Distraction at the Dead Scar
UPDATE creature SET spawntimesecs=1 WHERE id IN(25030, 25031, 25033);

-- Deathblow to the Legion (10409)
-- Turning Point (10507)
UPDATE quest_template SET SpecialFlags=0, RequiredNpcOrGo1=20132, RequiredNpcOrGoCount1=1 WHERE Id IN(10409, 10507);
UPDATE creature_template SET unit_flags=32832 WHERE entry=20132;

-- The Shadow Tomb (10881)
UPDATE gameobject_template SET questItem1=31708 WHERE entry=185224;

-- Scratches (10556)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=36904;
INSERT INTO conditions VALUES (17, 0, 36904, 0, 0, 29, 0, 21468, 20, 0, 1, 22, 0, '', "");

-- Blast the Gateway (11516)
UPDATE creature SET position_z=294 WHERE guid=97064;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=22323;
DELETE FROM smart_scripts WHERE entryorguid IN(22323) AND source_type=0;
INSERT INTO smart_scripts VALUES(22323, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 44877, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on death');
REPLACE INTO creature_template_addon VALUES(24916, 0, 0, 0, 1, 0, '44880');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(24916, 24958);
DELETE FROM smart_scripts WHERE entryorguid IN(24916, 24958) AND source_type=0;
INSERT INTO smart_scripts VALUES(24916, 0, 0, 0, 8, 0, 100, 0, 44877, 0, 0, 0, 11, 44944, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on SpellHit');
INSERT INTO smart_scripts VALUES(24916, 0, 1, 2, 23, 0, 100, 0, 44944, 8, 1000, 1000, 28, 44880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Remove all auras on reset');
INSERT INTO smart_scripts VALUES(24916, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked cast spell');
INSERT INTO smart_scripts VALUES(24916, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 36, 24958, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Update entry');
INSERT INTO smart_scripts VALUES(24916, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked set phase');
INSERT INTO smart_scripts VALUES(24916, 0, 5, 0, 60, 1, 100, 0, 1000, 1000, 1000, 1000, 11, 44948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update cast spell');
INSERT INTO smart_scripts VALUES(24916, 0, 6, 7, 31, 1, 100, 1, 44948, 0, 0, 0, 11, 44947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast spell on SpellHit');
INSERT INTO smart_scripts VALUES(24916, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked force despawn');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(44877, 44948);
INSERT INTO conditions VALUES (13, 1, 44877, 0, 0, 31, 0, 3, 24916, 0, 0, 0, 0, '', 'Target Living Flare');
INSERT INTO conditions VALUES (13, 1, 44948, 0, 0, 31, 0, 3, 24959, 0, 0, 0, 0, '', 'Target Generic Quest Trigger - LAB');
DELETE FROM spell_linked_spell WHERE spell_trigger=44948;
INSERT INTO spell_linked_spell VALUES(44948, 57931, 1, 'Blast the Gateway quest');

-- Aldor Reputation
UPDATE quest_template SET RequiredMinRepValue=0 WHERE Id IN(10326, 10327, 10420, 10654, 10655);

-- On Nethery Wings (10438)
UPDATE creature_template SET RegenHealth=0 WHERE entry=20899;

-- Discovering Your Roots (11520)
-- Rediscovering Your Roots (11521)
DELETE FROM spell_script_names WHERE spell_id=44935;
INSERT INTO spell_script_names VALUES(44935, "spell_q11520_discovering_your_roots");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=44941;
INSERT INTO conditions VALUES (13, 1, 44941, 0, 0, 31, 0, 5, 187073, 0, 0, 0, 0, '', 'Target Razorthorn Dirt Mound'); 

-- To Catch A Thistlehead (10570)
DELETE FROM event_scripts WHERE id=13888;
INSERT INTO event_scripts VALUES(13888, 10, 10, 21409, 300000, 0, -4056.69, 1519.2, 92.02, 4.59);
INSERT INTO event_scripts VALUES(13888, 10, 10, 21410, 300000, 0, -4057.3, 1511.83, 90.91, 1.61);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=21409;
DELETE FROM smart_scripts WHERE entryorguid=21409 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=21409*100 AND source_type=9;
DELETE FROM creature_text WHERE entry IN(21409, 21410);
INSERT INTO creature_text VALUES(21409, 0, 0, "Zarath you must return to the Black Temple at once! I... I seem to have misplaced Lord Illidan's orders. Quickly!", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21409, 1, 0, "Zarath, I am perfectly capable of making it up this road to Eclipse Point. If we do not deliver the missive, Lord Illidan will have both of our heads! You are dismissed!", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21409, 2, 0, "Ah, sweet, sweet bloodthistle... Probably left behind by one of those filthy addicts at Eclipse Point.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21409, 3, 0, "Their loss is most definitely my gain...", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21410, 0, 0, "What is it, my lord?", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21410, 1, 0, "My lord, surely you do not expect me to leave you unattended. Lord Illidan would have my head if anything were to happen to you.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO creature_text VALUES(21410, 2, 0, "As you wish, my lord.", 12, 0, 100, 0, 0, 0, 0, '');
INSERT INTO smart_scripts VALUES(21409, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 80, 21409*100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "run timed actionlist");
INSERT INTO smart_scripts VALUES(21409*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21410, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 2, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 21410, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 21410, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 21410, 0, 0, 0, 0, 0, 0, 'despawn target');
INSERT INTO smart_scripts VALUES(21409*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'say');
INSERT INTO smart_scripts VALUES(21409*100, 9, 8, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'set faction');

-- Ruthless Cunning (9927)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=32307;
INSERT INTO conditions VALUES (13, 3, 32307, 0, 0, 31, 0, 3, 17148, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (13, 3, 32307, 0, 1, 31, 0, 3, 18658, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (13, 3, 32307, 0, 2, 31, 0, 3, 17147, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (13, 3, 32307, 0, 3, 31, 0, 3, 17146, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (13, 3, 32307, 0, 4, 31, 0, 3, 18391, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=32307;
INSERT INTO conditions VALUES (17, 0, 32307, 0, 0, 29, 0, 17148, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 1, 29, 0, 17148, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 2, 29, 0, 17148, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 3, 29, 0, 17148, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 4, 29, 0, 17148, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Kil'sorrow mobs");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 0, 30, 0, 182353, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 1, 30, 0, 182353, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 2, 30, 0, 182353, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 3, 30, 0, 182353, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");
INSERT INTO conditions VALUES (17, 0, 32307, 0, 4, 30, 0, 182353, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");

-- Returning the Favor (9931)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=32314;
INSERT INTO conditions VALUES (13, 3, 32314, 0, 0, 31, 0, 3, 17138, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Warmaul Ogres");
INSERT INTO conditions VALUES (13, 3, 32314, 0, 1, 31, 0, 3, 18064, 0, 0, 0, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Warmaul Ogres");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=32314;
INSERT INTO conditions VALUES (17, 0, 32314, 0, 0, 29, 0, 17138, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Warmaul Ogres");
INSERT INTO conditions VALUES (17, 0, 32314, 0, 1, 29, 0, 17138, 5, 1, 0, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast on Warmaul Ogres");
INSERT INTO conditions VALUES (17, 0, 32314, 0, 0, 30, 0, 182354, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");
INSERT INTO conditions VALUES (17, 0, 32314, 0, 1, 30, 0, 182354, 10, 0, 1, 12, 0, '', "Spell Place Kil'sorrow Banner can only be cast if no banner is present");

-- Subdue the Subduer (11090)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=22357;
DELETE FROM smart_scripts WHERE entryorguid=22357 AND source_type=0;
INSERT INTO smart_scripts VALUES (22357, 0, 0, 0, 0, 0, 100, 0, 7000, 8000, 30000, 30000, 11, 41281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Cripple');
INSERT INTO smart_scripts VALUES (22357, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 7000, 8000, 11, 41280, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (22357, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 15, 11090, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Area Explored or Event Happened');

-- Dragonmaw Race: The Ballad of Oldie McOld (11064)
UPDATE creature SET position_x=-5142.74, position_Y=602.02, position_z=82.942, orientation=0.15 WHERE id=22433; -- Ja'y Nosliw
UPDATE creature SET spawntimesecs=30 WHERE id=23340;
DELETE FROM creature_text WHERE entry=23340;
INSERT INTO creature_text VALUES(23340, 0, 0, 'I may be old but I can still take on a young whippersnapper like you, $N. Try not to fall behind...', 12, 0, 100, 0, 0, 0, 0, 'Murg Oldie Mackjaw');
INSERT INTO creature_text VALUES(23340, 1, 0, 'Well, you won... I guess.', 12, 0, 100, 0, 0, 0, 0, 'Murg Oldie Mackjaw');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=23340;
DELETE FROM smart_scripts WHERE entryorguid=23340 AND source_type=0;
INSERT INTO smart_scripts VALUES (23340, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23340, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23340, 0, 2, 3, 19, 0, 100, 0, 11064, 0, 0, 0, 53, 0, 23340, 0, 11064, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23340, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23340, 0, 4, 16, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
-- INSERT INTO smart_scripts VALUES (23340, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23340, 0, 6, 18, 40, 0, 100, 0, 5, 0, 0, 0, 60, 1, 250, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23340, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23340, 0, 8, 9, 40, 0, 100, 0, 38, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23340, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23340, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23340, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23340, 0, 12, 17, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23340, 0, 13, 0, 40, 0, 100, 0, 41, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23340, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11064, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23340, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40890, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23340, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23340, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23340, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23340;
INSERT INTO waypoints VALUES(23340, 1, -5094.56, 646.038, 87.2043, 'Murg "Oldie" Muckjaw'),(23340, 2, -5097.64, 660.054, 87.5581, 'Murg "Oldie" Muckjaw'),(23340, 3, -5095.23, 662.83, 87.6506, 'Murg "Oldie" Muckjaw'),(23340, 4, -5081.62, 663.375, 88.9826, 'Murg "Oldie" Muckjaw'),(23340, 5, -5026.09, 664.847, 98.0088, 'Murg "Oldie" Muckjaw'),(23340, 6, -4988.04, 667.552, 100.198, 'Murg "Oldie" Muckjaw'),(23340, 7, -4985.78, 705.424, 107.845, 'Murg "Oldie" Muckjaw'),(23340, 8, -4998.67, 747.661, 108.399, 'Murg "Oldie" Muckjaw'),(23340, 9, -5006.4, 776.745, 129.717, 'Murg "Oldie" Muckjaw'),(23340, 10, -5070.62, 786.927, 180.437, 'Murg "Oldie" Muckjaw'),(23340, 11, -5116.9, 777.487, 144.162, 'Murg "Oldie" Muckjaw'),
(23340, 12, -5183.61, 676.925, 156.482, 'Murg "Oldie" Muckjaw'),(23340, 13, -5202.66, 581.352, 112.955, 'Murg "Oldie" Muckjaw'),(23340, 14, -5212.29, 498.071, 165.252, 'Murg "Oldie" Muckjaw'),(23340, 15, -5159.92, 471.803, 166.377, 'Murg "Oldie" Muckjaw'),(23340, 16, -5098.13, 473.925, 163.864, 'Murg "Oldie" Muckjaw'),(23340, 17, -5052.66, 476.555, 156.071, 'Murg "Oldie" Muckjaw'),(23340, 18, -5020.59, 494.831, 161.309, 'Murg "Oldie" Muckjaw'),(23340, 19, -4975.82, 516.719, 127.38, 'Murg "Oldie" Muckjaw'),(23340, 20, -4940.41, 527.58, 144.494, 'Murg "Oldie" Muckjaw'),
(23340, 21, -4884.46, 496.736, 140.731, 'Murg "Oldie" Muckjaw'),(23340, 22, -4841.46, 488.188, 136.74, 'Murg "Oldie" Muckjaw'),(23340, 23, -4805.09, 508.387, 133.952, 'Murg "Oldie" Muckjaw'),(23340, 24, -4791.09, 450.373, 125.99, 'Murg "Oldie" Muckjaw'),(23340, 25, -4834.56, 416.905, 117.32, 'Murg "Oldie" Muckjaw'),(23340, 26, -4893.15, 382.526, 135.45, 'Murg "Oldie" Muckjaw'),(23340, 27, -4967.23, 399.009, 122.802, 'Murg "Oldie" Muckjaw'),(23340, 28, -4989.25, 440.067, 108.982, 'Murg "Oldie" Muckjaw'),(23340, 29, -5016.5, 476.014, 110.362, 'Murg "Oldie" Muckjaw'),(23340, 30, -4997.99, 521.923, 109.513, 'Murg "Oldie" Muckjaw'),
(23340, 31, -4953.36, 544.093, 114.784, 'Murg "Oldie" Muckjaw'),(23340, 32, -4907.47, 550.216, 119.754, 'Murg "Oldie" Muckjaw'),(23340, 33, -4876.8, 619.307, 118.276, 'Murg "Oldie" Muckjaw'),(23340, 34, -4889.19, 654.449, 113.983, 'Murg "Oldie" Muckjaw'),(23340, 35, -4920.7, 672.807, 109.915, 'Murg "Oldie" Muckjaw'),(23340, 36, -4955.09, 668.963, 105.206, 'Murg "Oldie" Muckjaw'),(23340, 37, -5023.97, 666.12, 92.4113, 'Murg "Oldie" Muckjaw'),(23340, 38, -5071.54, 665.305, 89.4341, 'Murg "Oldie" Muckjaw'),(23340, 39, -5097.64, 664.896, 87.6522, 'Murg "Oldie" Muckjaw'),
(23340, 40, -5098.6, 652.373, 87.5737, 'Murg "Oldie" Muckjaw'),(23340, 41, -5096.05, 644.517, 87.2189, 'Murg "Oldie" Muckjaw');
DELETE FROM spell_script_names WHERE spell_id=40890;
INSERT INTO spell_script_names VALUES(40890, 'spell_quest_dragonmaw_race_generic');
UPDATE creature_template SET modelid1=15435, modelid2=0, minlevel=80, maxlevel=80, unit_flags=33554432, faction=14, AIName='NullCreatureAI', InhabitType=4, flags_extra=128 WHERE entry=23356;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40905;
INSERT INTO conditions VALUES (13, 3, 40905, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 40905, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");

-- Dragonmaw Race: Trope the Filth-Belcher (11067)
UPDATE creature SET spawntimesecs=30 WHERE id=23342;
DELETE FROM creature_text WHERE entry=23342;
INSERT INTO creature_text VALUES(23342, 0, 0, 'Trope will show you how to fly like a Dragonmaw... You will show Trope how to die like a scrub.', 12, 0, 100, 0, 0, 0, 0, 'Trope the Filth-Belcher');
INSERT INTO creature_text VALUES(23342, 1, 0, "You did well. Certainly a surprise to Trope... Report back to Ja'y.", 12, 0, 100, 0, 0, 0, 0, 'Trope the Filth-Belcher');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=23342;
DELETE FROM smart_scripts WHERE entryorguid=23342 AND source_type=0;
INSERT INTO smart_scripts VALUES (23342, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23342, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23342, 0, 2, 3, 19, 0, 100, 0, 11067, 0, 0, 0, 53, 0, 23342, 0, 11067, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23342, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23342, 0, 4, 16, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
-- INSERT INTO smart_scripts VALUES (23342, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23342, 0, 6, 18, 40, 0, 100, 0, 5, 0, 0, 0, 60, 1, 270, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23342, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23342, 0, 8, 9, 40, 0, 100, 0, 38, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23342, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23342, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23342, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23342, 0, 12, 17, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23342, 0, 13, 0, 40, 0, 100, 0, 41, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23342, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11067, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23342, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23342, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23342, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23342, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23342;
INSERT INTO waypoints VALUES(23342, 1, -5094.56, 646.038, 87.1043, 'Trope the Filth-Belcher'),(23342, 2, -5097.64, 660.054, 87.5581, 'Trope the Filth-Belcher'),(23342, 3, -5095.23, 662.83, 87.8506, 'Trope the Filth-Belcher'),(23342, 4, -5081.62, 663.375, 89.3826, 'Trope the Filth-Belcher'),(23342, 5, -5026.09, 664.847, 98.0088, 'Trope the Filth-Belcher'),(23342, 6, -4988.04, 667.552, 100.198, 'Trope the Filth-Belcher'),(23342, 7, -4985.78, 705.424, 107.845, 'Trope the Filth-Belcher'),(23342, 8, -4998.67, 747.661, 108.399, 'Trope the Filth-Belcher'),(23342, 9, -5006.4, 776.745, 129.717, 'Trope the Filth-Belcher'),(23342, 10, -5070.62, 786.927, 180.437, 'Trope the Filth-Belcher'),(23342, 11, -5116.9, 777.487, 144.162, 'Trope the Filth-Belcher'),
(23342, 12, -5183.61, 676.925, 156.482, 'Trope the Filth-Belcher'),(23342, 13, -5202.66, 581.352, 112.955, 'Trope the Filth-Belcher'),(23342, 14, -5212.29, 498.071, 165.252, 'Trope the Filth-Belcher'),(23342, 15, -5159.92, 471.803, 166.377, 'Trope the Filth-Belcher'),(23342, 16, -5098.13, 473.925, 163.864, 'Trope the Filth-Belcher'),(23342, 17, -5052.66, 476.555, 156.071, 'Trope the Filth-Belcher'),(23342, 18, -5020.59, 494.831, 161.309, 'Trope the Filth-Belcher'),(23342, 19, -4975.82, 516.719, 127.38, 'Trope the Filth-Belcher'),(23342, 20, -4940.41, 527.58, 144.494, 'Trope the Filth-Belcher'),
(23342, 21, -4884.46, 496.736, 140.731, 'Trope the Filth-Belcher'),(23342, 22, -4841.46, 488.188, 136.74, 'Trope the Filth-Belcher'),(23342, 23, -4805.09, 508.387, 133.952, 'Trope the Filth-Belcher'),(23342, 24, -4791.09, 450.373, 125.99, 'Trope the Filth-Belcher'),(23342, 25, -4834.56, 416.905, 117.32, 'Trope the Filth-Belcher'),(23342, 26, -4893.15, 382.526, 135.45, 'Trope the Filth-Belcher'),(23342, 27, -4967.23, 399.009, 122.802, 'Trope the Filth-Belcher'),(23342, 28, -4989.25, 440.067, 108.982, 'Trope the Filth-Belcher'),(23342, 29, -5016.5, 476.014, 110.362, 'Trope the Filth-Belcher'),(23342, 30, -4997.99, 521.923, 109.513, 'Trope the Filth-Belcher'),
(23342, 31, -4953.36, 544.093, 114.784, 'Trope the Filth-Belcher'),(23342, 32, -4907.47, 550.216, 119.754, 'Trope the Filth-Belcher'),(23342, 33, -4876.8, 619.307, 118.276, 'Trope the Filth-Belcher'),(23342, 34, -4889.19, 654.449, 113.983, 'Trope the Filth-Belcher'),(23342, 35, -4920.7, 672.807, 109.915, 'Trope the Filth-Belcher'),(23342, 36, -4955.09, 668.963, 105.206, 'Trope the Filth-Belcher'),(23342, 37, -5023.97, 666.12, 92.4113, 'Trope the Filth-Belcher'),(23342, 38, -5071.54, 665.305, 89.4341, 'Trope the Filth-Belcher'),(23342, 39, -5097.64, 664.896, 87.6522, 'Trope the Filth-Belcher'),
(23342, 40, -5098.6, 652.373, 87.5737, 'Trope the Filth-Belcher'),(23342, 41, -5096.05, 644.517, 87.2189, 'Trope the Filth-Belcher');
DELETE FROM spell_script_names WHERE spell_id=40909;
INSERT INTO spell_script_names VALUES(40909, 'spell_quest_dragonmaw_race_generic');

-- Dragonmaw Race: Corlok the Vet (11068)
UPDATE creature SET spawntimesecs=30 WHERE id=23344;
DELETE FROM creature_text WHERE entry=23344;
INSERT INTO creature_text VALUES(23344, 0, 0, "Let's get this over with...", 12, 0, 100, 0, 0, 0, 0, 'Corlok the Vet');
INSERT INTO creature_text VALUES(23344, 1, 0, 'You put up a hell of a fight, newbie. Hell of a fight...', 12, 0, 100, 0, 0, 0, 0, 'Corlok the Vet');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=23344;
DELETE FROM smart_scripts WHERE entryorguid=23344 AND source_type=0;
INSERT INTO smart_scripts VALUES (23344, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23344, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23344, 0, 2, 3, 19, 0, 100, 0, 11068, 0, 0, 0, 53, 0, 23344, 0, 11068, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23344, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23344, 0, 4, 16, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
-- INSERT INTO smart_scripts VALUES (23344, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23344, 0, 6, 18, 40, 0, 100, 0, 5, 0, 0, 0, 60, 1, 290, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23344, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23344, 0, 8, 9, 40, 0, 100, 0, 56, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23344, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23344, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23344, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23344, 0, 12, 17, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23344, 0, 13, 0, 40, 0, 100, 0, 59, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23344, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11068, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23344, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40894, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23344, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23344, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23344, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23344;
INSERT INTO waypoints VALUES (23344, 1, -5094.66, 642.169, 86.9278, 'Corlok the Vet'),(23344, 2, -5099.02, 653.186, 87.4071, 'Corlok the Vet'),(23344, 3, -5092.6, 664.835, 88.1206, 'Corlok the Vet'),(23344, 4, -5080.97, 664.741, 89.2517, 'Corlok the Vet'),(23344, 5, -5013.39, 664.365, 96.3073, 'Corlok the Vet'),(23344, 6, -5030.49, 641.083, 120.951, 'Corlok the Vet'),(23344, 7, -5011.5, 624.658, 128.945, 'Corlok the Vet'),(23344, 8, -4976.25, 609.167, 131.847, 'Corlok the Vet'),(23344, 9, -4968.57, 593.818, 128.138, 'Corlok the Vet'),(23344, 10, -4975.71, 567.568, 122.242, 'Corlok the Vet'),(23344, 11, -4992.93, 541.658, 124.877, 'Corlok the Vet'),(23344, 12, -5018.65, 525.73, 124.381, 'Corlok the Vet'),
(23344, 13, -5062.31, 524.193, 131.825, 'Corlok the Vet'),(23344, 14, -5110.08, 515.493, 132.262, 'Corlok the Vet'),(23344, 15, -5136.43, 504.138, 124.353, 'Corlok the Vet'),(23344, 16, -5169.05, 471.514, 128.497, 'Corlok the Vet'),(23344, 17, -5215.87, 427.216, 123.842, 'Corlok the Vet'),(23344, 18, -5260.04, 381.145, 75.3805, 'Corlok the Vet'),(23344, 19, -5279.86, 351.083, 84.823, 'Corlok the Vet'),(23344, 20, -5278.54, 308.535, 81.3559, 'Corlok the Vet'),(23344, 21, -5257.15, 279.456, 77.8807, 'Corlok the Vet'),(23344, 22, -5231.97, 264.377, 75.0612, 'Corlok the Vet'),(23344, 23, -5212.85, 246.921, 75.6135, 'Corlok the Vet'),
(23344, 24, -5208.43, 225.199, 76.1251, 'Corlok the Vet'),(23344, 25, -5207.37, 176.583, 73.1752, 'Corlok the Vet'),(23344, 26, -5181.27, 72.6699, 98.6859, 'Corlok the Vet'),(23344, 27, -5122.27, 46.2645, 124.749, 'Corlok the Vet'),(23344, 28, -5058.83, 37.3311, 132.444, 'Corlok the Vet'),(23344, 29, -5020.16, 8.79054, 144.253, 'Corlok the Vet'),(23344, 30, -5009.11, -41.4904, 140.305, 'Corlok the Vet'),(23344, 31, -5039.29, -101.374, 133.709, 'Corlok the Vet'),(23344, 32, -5076.44, -110.698, 133.671, 'Corlok the Vet'),
(23344, 33, -5110.74, -107.132, 131.541, 'Corlok the Vet'),(23344, 34, -5160.48, -80.2224, 127.582, 'Corlok the Vet'),(23344, 35, -5180.68, 18.7902, 130.192, 'Corlok the Vet'),(23344, 36, -5239.71, 64.3641, 125.863, 'Corlok the Vet'),(23344, 37, -5272.64, 93.122, 102.861, 'Corlok the Vet'),(23344, 38, -5299.94, 147.154, 102.599, 'Corlok the Vet'),(23344, 39, -5284.9, 252.429, 97.7294, 'Corlok the Vet'),(23344, 40, -5232.04, 268.628, 75.8885, 'Corlok the Vet'),(23344, 41, -5200.06, 281.96, 75.8803, 'Corlok the Vet'),(23344, 42, -5179.37, 308.571, 75.2391, 'Corlok the Vet'),(23344, 43, -5174.71, 339.543, 74.8148, 'Corlok the Vet'),
(23344, 44, -5183.03, 359.88, 79.2474, 'Corlok the Vet'),(23344, 45, -5194.4, 382.73, 84.4609, 'Corlok the Vet'),(23344, 46, -5173.2, 431.042, 90.3253, 'Corlok the Vet'),(23344, 47, -5145.51, 472.726, 102.904, 'Corlok the Vet'),(23344, 48, -5100.07, 500.221, 103.275, 'Corlok the Vet'),(23344, 49, -5057.29, 508.873, 104.392, 'Corlok the Vet'),(23344, 50, -4998.65, 529.313, 111.632, 'Corlok the Vet'),(23344, 51, -4978.84, 554.876, 114.642, 'Corlok the Vet'),(23344, 52, -4956.67, 599.9, 108.723, 'Corlok the Vet'),(23344, 53, -4968.9, 647.118, 100.11, 'Corlok the Vet'),(23344, 54, -4988.58, 659.373, 98.5294, 'Corlok the Vet'),(23344, 55, -5037.48, 662.584, 92.5092, 'Corlok the Vet'),
(23344, 56, -5065.82, 664.006, 89.5423, 'Corlok the Vet'),(23344, 57, -5102.95, 662.805, 87.425, 'Corlok the Vet'),(23344, 58, -5094.39, 643.476, 87.2949, 'Corlok the Vet'),(23344, 59, -5090.01, 642.519, 86.9716, 'Corlok the Vet');
DELETE FROM spell_script_names WHERE spell_id=40894;
INSERT INTO spell_script_names VALUES(40894, 'spell_quest_dragonmaw_race_generic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40900;
INSERT INTO conditions VALUES (13, 3, 40900, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 40900, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");

-- Dragonmaw Race: Wing Commander Ichman (11069)
DELETE FROM creature_queststarter WHERE quest=11069;
INSERT INTO creature_queststarter VALUES(23345, 11069);
UPDATE creature SET spawntimesecs=30 WHERE id=23345;
DELETE FROM creature_text WHERE entry=23345;
INSERT INTO creature_text VALUES(23345, 0, 0, "I'm taking this back to the old school. I'll be the Alliance and you be Frostwolf Village. BOMBS AWAY!", 12, 0, 100, 0, 0, 0, 0, 'Wing Commander Ichman');
INSERT INTO creature_text VALUES(23345, 1, 0, 'Thank you for that... It was humbling to be served in such a manner.', 12, 0, 100, 0, 0, 0, 0, 'Wing Commander Ichman');
UPDATE creature_template SET InhabitType=5, npcflag=2, AIName='SmartAI', ScriptName='' WHERE entry=23345;
DELETE FROM smart_scripts WHERE entryorguid=23345 AND source_type=0;
INSERT INTO smart_scripts VALUES (23345, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23345, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23345, 0, 2, 3, 19, 0, 100, 0, 11069, 0, 0, 0, 53, 0, 23345, 0, 11069, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23345, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23345, 0, 4, 17, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
INSERT INTO smart_scripts VALUES (23345, 0, 5, 19, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 305, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23345, 0, 6, 0, 40, 0, 100, 0, 6, 0, 0, 0, 60, 1, 310, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23345, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23345, 0, 8, 9, 40, 0, 100, 0, 80, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23345, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23345, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23345, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23345, 0, 12, 18, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23345, 0, 13, 0, 40, 0, 100, 0, 83, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23345, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11069, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23345, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40928, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23345, 0, 16, 0, 60, 1, 100, 0, 14000, 14000, 4000, 8000, 11, 40928, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23345, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23345, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23345, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23345;
INSERT INTO waypoints VALUES (23345, 1, -5074.62, 639.673, 86.9331, 'Wing Commander Ichman'),(23345, 2, -5091.72, 640.899, 86.9896, 'Wing Commander Ichman'),(23345, 3, -5099.78, 661.451, 87.4432, 'Wing Commander Ichman'),(23345, 4, -5090.78, 664.342, 88.3554, 'Wing Commander Ichman'),(23345, 5, -5067.89, 664.518, 89.9139, 'Wing Commander Ichman'),(23345, 6, -4974.12, 662.561, 93.8796, 'Wing Commander Ichman'),(23345, 7, -4906.46, 640.801, 88.7705, 'Wing Commander Ichman'),(23345, 8, -4921.31, 579.589, 88.8252, 'Wing Commander Ichman'),(23345, 9, -4970.17, 540.006, 100.316, 'Wing Commander Ichman'),(23345, 10, -5018.59, 499.593, 97.0844, 'Wing Commander Ichman'),(23345, 11, -5001.56, 456.6, 94.0664, 'Wing Commander Ichman'),(23345, 12, -4992.14, 436.068, 96.5439, 'Wing Commander Ichman'),(23345, 13, -4979.81, 461.129, 96.0511, 'Wing Commander Ichman'),(23345, 14, -4995.22, 465.137, 96.0437, 'Wing Commander Ichman'),(23345, 15, -4979.78, 422.108, 96.2742, 'Wing Commander Ichman'),
(23345, 16, -4948.8, 384.394, 97.8985, 'Wing Commander Ichman'),(23345, 17, -4941.75, 377.289, 95.2171, 'Wing Commander Ichman'),(23345, 18, -4920.82, 377.354, 86.4916, 'Wing Commander Ichman'),(23345, 19, -4863.89, 389.621, 100.531, 'Wing Commander Ichman'),(23345, 20, -4799.8, 356.848, 100.664, 'Wing Commander Ichman'),(23345, 21, -4816.32, 307.672, 98.9476, 'Wing Commander Ichman'),(23345, 22, -4860.27, 253.41, 90.9479, 'Wing Commander Ichman'),(23345, 23, -4928.57, 234.724, 73.3838, 'Wing Commander Ichman'),(23345, 24, -4979.44, 234.729, 99.059, 'Wing Commander Ichman'),(23345, 25, -4997.64, 187.217, 108.79, 'Wing Commander Ichman'),(23345, 26, -4999.75, 133.452, 92.5512, 'Wing Commander Ichman'),(23345, 27, -5006.28, 70.9775, 92.9455, 'Wing Commander Ichman'),(23345, 28, -4984.59, 21.7855, 92.4787, 'Wing Commander Ichman'),(23345, 29, -4939.45, -1.70913, 89.5908, 'Wing Commander Ichman'),(23345, 30, -4904.5, -20.3318, 98.7926, 'Wing Commander Ichman'),
(23345, 31, -4876.37, -59.5791, 91.4677, 'Wing Commander Ichman'),(23345, 32, -4883.15, -100.723, 103.205, 'Wing Commander Ichman'),(23345, 33, -4944.32, -112.767, 137.646, 'Wing Commander Ichman'),(23345, 34, -4971.8, -78.7316, 115.101, 'Wing Commander Ichman'),(23345, 35, -4987.65, -30.5438, 91.9287, 'Wing Commander Ichman'),(23345, 36, -5001.3, 12.3534, 86.9422, 'Wing Commander Ichman'),(23345, 37, -5042.09, 46.6422, 105.125, 'Wing Commander Ichman'),(23345, 38, -5106.43, 50.7488, 83.1864, 'Wing Commander Ichman'),(23345, 39, -5154.69, 50.1247, 82.3862, 'Wing Commander Ichman'),(23345, 40, -5217.06, 23.4145, 150.396, 'Wing Commander Ichman'),(23345, 41, -5225.16, -39.4703, 174.652, 'Wing Commander Ichman'),(23345, 42, -5307.91, -25.5939, 145.381, 'Wing Commander Ichman'),(23345, 43, -5274.71, 26.4266, 172.198, 'Wing Commander Ichman'),(23345, 44, -5208.27, 57.5883, 159.623, 'Wing Commander Ichman'),(23345, 45, -5142.88, 97.5982, 149.853, 'Wing Commander Ichman'),(23345, 46, -5115.44, 118.069, 136.045, 'Wing Commander Ichman'),
(23345, 47, -5105.17, 155.088, 134.461, 'Wing Commander Ichman'),(23345, 48, -5106.37, 218.731, 147.258, 'Wing Commander Ichman'),(23345, 49, -5094.3, 280.021, 161.935, 'Wing Commander Ichman'),(23345, 50, -5084.01, 316.753, 172.277, 'Wing Commander Ichman'),(23345, 51, -5052.64, 351.108, 172.987, 'Wing Commander Ichman'),(23345, 52, -5033.05, 379.481, 174.407, 'Wing Commander Ichman'),(23345, 53, -5028.54, 413.128, 179.762, 'Wing Commander Ichman'),(23345, 54, -5017.09, 484.101, 168.921, 'Wing Commander Ichman'),(23345, 55, -5020.9, 515.958, 120.09, 'Wing Commander Ichman'),(23345, 56, -5062.5, 521.002, 97.215, 'Wing Commander Ichman'),(23345, 57, -5103.9, 494.01, 104.071, 'Wing Commander Ichman'),(23345, 58, -5151.95, 462.724, 111.081, 'Wing Commander Ichman'),(23345, 59, -5080.26, 498.915, 109.875, 'Wing Commander Ichman'),(23345, 60, -5157.65, 450.443, 106.745, 'Wing Commander Ichman'),(23345, 61, -5193.28, 400.018, 108.903, 'Wing Commander Ichman'),(23345, 62, -5189.23, 370.25, 113.73, 'Wing Commander Ichman'),(23345, 63, -5185.8, 313.755, 132.317, 'Wing Commander Ichman'),
(23345, 64, -5195.96, 278.514, 132.06, 'Wing Commander Ichman'),(23345, 65, -5224.53, 274.103, 131.872, 'Wing Commander Ichman'),(23345, 66, -5271.16, 332.176, 120.293, 'Wing Commander Ichman'),(23345, 67, -5284.09, 392.53, 121.367, 'Wing Commander Ichman'),(23345, 68, -5234.58, 426.247, 124.65, 'Wing Commander Ichman'),(23345, 69, -5204.57, 440.941, 125.71, 'Wing Commander Ichman'),(23345, 70, -5238.07, 411.06, 122.894, 'Wing Commander Ichman'),(23345, 71, -5154.52, 497.25, 110.277, 'Wing Commander Ichman'),(23345, 72, -5062.88, 505.464, 107.491, 'Wing Commander Ichman'),(23345, 73, -4998.45, 523.002, 102.513, 'Wing Commander Ichman'),(23345, 74, -5047.71, 512.549, 101.472, 'Wing Commander Ichman'),(23345, 75, -4975.4, 546.978, 98.4481, 'Wing Commander Ichman'),(23345, 76, -4940.06, 582.665, 93.8702, 'Wing Commander Ichman'),(23345, 77, -4936.29, 629.309, 91.3448, 'Wing Commander Ichman'),(23345, 78, -4986.95, 667.351, 96.8044, 'Wing Commander Ichman'),(23345, 79, -5036.81, 665.996, 92.8608, 'Wing Commander Ichman'),(23345, 80, -5079.51, 664.887, 89.0742, 'Wing Commander Ichman'),(23345, 81, -5094.95, 663.808, 87.6571, 'Wing Commander Ichman'),
(23345, 82, -5100.96, 648.648, 87.1004, 'Wing Commander Ichman'),(23345, 83, -5084.34, 638.799, 86.9905, 'Wing Commander Ichman');
DELETE FROM spell_script_names WHERE spell_id=40928;
INSERT INTO spell_script_names VALUES(40928, 'spell_quest_dragonmaw_race_generic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40929;
INSERT INTO conditions VALUES (13, 3, 40929, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 40929, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");

-- Dragonmaw Race: Wing Commander Mulverick (11070)
UPDATE creature SET spawntimesecs=30 WHERE id=23346;
DELETE FROM creature_text WHERE entry=23346;
INSERT INTO creature_text VALUES(23346, 0, 0, "You're in for a rough ride, $N. I hope you've already made funeral arrangements.", 12, 0, 100, 0, 0, 0, 0, 'Wing Commander Mulverick');
INSERT INTO creature_text VALUES(23346, 1, 0, "You're the best I've ever seen. I can't believe I'm saying this but you might have a chance against Skyshatter. And hey, if that doesn't go so well you can be my wing man...", 12, 0, 100, 0, 0, 0, 0, 'Wing Commander Mulverick');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=23346;
DELETE FROM smart_scripts WHERE entryorguid=23346 AND source_type=0;
INSERT INTO smart_scripts VALUES (23346, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23346, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23346, 0, 2, 3, 19, 0, 100, 0, 11070, 0, 0, 0, 53, 0, 23346, 0, 11070, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23346, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23346, 0, 4, 17, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
-- INSERT INTO smart_scripts VALUES (23346, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23346, 0, 6, 19, 40, 0, 100, 0, 5, 0, 0, 0, 60, 1, 310, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23346, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23346, 0, 8, 9, 40, 0, 100, 0, 137, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23346, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23346, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23346, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23346, 0, 12, 18, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23346, 0, 13, 0, 40, 0, 100, 0, 140, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23346, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11070, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23346, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40930, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23346, 0, 16, 0, 60, 1, 100, 0, 14000, 14000, 4000, 8000, 11, 40930, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23346, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23346, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23346, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23346;
INSERT INTO waypoints VALUES (23346, 1, -5073.79, 640.175, 86.9597, 'Wing Commander Mulverick'),(23346, 2, -5093.49, 642.838, 87.0724, 'Wing Commander Mulverick'),(23346, 3, -5097.66, 661.13, 87.6415, 'Wing Commander Mulverick'),(23346, 4, -5070.33, 664.518, 89.9677, 'Wing Commander Mulverick'),(23346, 5, -4980.29, 664.857, 93.3151, 'Wing Commander Mulverick'),(23346, 6, -4923.65, 661.955, 85.6817, 'Wing Commander Mulverick'),(23346, 7, -4897.38, 687.397, 85.903, 'Wing Commander Mulverick'),(23346, 8, -4894.5, 731.107, 94.2763, 'Wing Commander Mulverick'),(23346, 9, -4909.02, 768.031, 88.1273, 'Wing Commander Mulverick'),(23346, 10, -4944.72, 786.339, 89.3095, 'Wing Commander Mulverick'),(23346, 11, -4978.84, 796.752, 122.538, 'Wing Commander Mulverick'),(23346, 12, -5020.1, 794.71, 104.245, 'Wing Commander Mulverick'),(23346, 13, -5051.79, 790.186, 90.4867, 'Wing Commander Mulverick'),(23346, 14, -5094.32, 778.473, 79.7089, 'Wing Commander Mulverick'),(23346, 15, -5139.05, 763.19, 68.1027, 'Wing Commander Mulverick'),(23346, 16, -5179.04, 773.369, 61.2301, 'Wing Commander Mulverick'),(23346, 17, -5255.2, 791.07, 49.3913, 'Wing Commander Mulverick'),(23346, 18, -5276.02, 781.002, 47.2046, 'Wing Commander Mulverick'),(23346, 19, -5272.19, 763.952, 49.0412, 'Wing Commander Mulverick'),(23346, 20, -5280.86, 729.029, 52.1453, 'Wing Commander Mulverick'),(23346, 21, -5269.54, 687.2, 53.4351, 'Wing Commander Mulverick'),(23346, 22, -5260.46, 632.333, 53.8001, 'Wing Commander Mulverick'),(23346, 23, -5260.06, 607.943, 59.746, 'Wing Commander Mulverick'),(23346, 24, -5253.74, 659.762, 53.9552, 'Wing Commander Mulverick'),(23346, 25, -5270.44, 641.98, 52.628, 'Wing Commander Mulverick'),(23346, 26, -5259.89, 607.863, 56.4182, 'Wing Commander Mulverick'),(23346, 27, -5188.08, 598.437, 88.6164, 'Wing Commander Mulverick'),(23346, 28, -5176.6, 549.729, 89.9904, 'Wing Commander Mulverick'),(23346, 29, -5168.49, 522.349, 91.4781, 'Wing Commander Mulverick'),(23346, 30, -5143.6, 507.12, 92.2422, 'Wing Commander Mulverick'),(23346, 31, -5091.26, 495.271, 94.0692, 'Wing Commander Mulverick'),
(23346, 32, -4973.18, 421.727, 90.9961, 'Wing Commander Mulverick'),(23346, 33, -4965.04, 392.479, 89.3456, 'Wing Commander Mulverick'),(23346, 34, -4971.82, 354.271, 87.915, 'Wing Commander Mulverick'),(23346, 35, -4989.4, 301.984, 86.3694, 'Wing Commander Mulverick'),(23346, 36, -5014.7, 279.451, 90.6383, 'Wing Commander Mulverick'),(23346, 37, -5040.7, 225.805, 108.337, 'Wing Commander Mulverick'),(23346, 38, -5062.34, 181.557, 129.365, 'Wing Commander Mulverick'),(23346, 39, -5082.6, 168.477, 130.375, 'Wing Commander Mulverick'),(23346, 40, -5100.59, 180.857, 138.101, 'Wing Commander Mulverick'),(23346, 41, -5101.1, 229.947, 149.149, 'Wing Commander Mulverick'),(23346, 42, -5093.44, 274.454, 160.411, 'Wing Commander Mulverick'),(23346, 43, -5080.44, 309.374, 169.419, 'Wing Commander Mulverick'),(23346, 44, -5056.87, 347.893, 174.217, 'Wing Commander Mulverick'),(23346, 45, -5010.93, 365.086, 177.488, 'Wing Commander Mulverick'),(23346, 46, -4968.65, 380.724, 173.173, 'Wing Commander Mulverick'),(23346, 47, -5027.66, 364.737, 177.539, 'Wing Commander Mulverick'),(23346, 48, -4917.15, 377.454, 173.836, 'Wing Commander Mulverick'),(23346, 49, -4853.53, 360.39, 176.391, 'Wing Commander Mulverick'),(23346, 50, -4835.68, 388.264, 168.752, 'Wing Commander Mulverick'),(23346, 51, -4850.91, 422.375, 158.973, 'Wing Commander Mulverick'),(23346, 52, -4864.4, 460.468, 150.407, 'Wing Commander Mulverick'),(23346, 53, -4902.27, 500.825, 134.835, 'Wing Commander Mulverick'),(23346, 54, -4946.1, 528.796, 121.743, 'Wing Commander Mulverick'),(23346, 55, -4994.91, 527.295, 99.9505, 'Wing Commander Mulverick'),(23346, 56, -5023.6, 508.386, 119.743, 'Wing Commander Mulverick'),(23346, 57, -5055, 490.278, 169.672, 'Wing Commander Mulverick'),(23346, 58, -5106.63, 462.668, 165.688, 'Wing Commander Mulverick'),(23346, 59, -5146.6, 430.134, 159.699, 'Wing Commander Mulverick'),(23346, 60, -5167.97, 405.528, 144.235, 'Wing Commander Mulverick'),(23346, 61, -5178.58, 345.856, 127.211, 'Wing Commander Mulverick'),(23346, 62, -5188.11, 313.544, 124.417, 'Wing Commander Mulverick'),
(23346, 63, -5199.91, 282.739, 112.936, 'Wing Commander Mulverick'),(23346, 64, -5245.22, 271.312, 97.5307, 'Wing Commander Mulverick'),(23346, 65, -5270.46, 271.393, 105.523, 'Wing Commander Mulverick'),(23346, 66, -5288.75, 241.08, 101.587, 'Wing Commander Mulverick'),(23346, 67, -5313.95, 195.752, 100.433, 'Wing Commander Mulverick'),(23346, 68, -5289.44, 116.574, 101.397, 'Wing Commander Mulverick'),(23346, 69, -5260.55, 69.3146, 106.89, 'Wing Commander Mulverick'),(23346, 70, -5237.17, -12.7776, 120.017, 'Wing Commander Mulverick'),(23346, 71, -5279.93, -67.19, 109.01, 'Wing Commander Mulverick'),(23346, 72, -5349.6, -111.473, 116.548, 'Wing Commander Mulverick'),(23346, 73, -5370.63, -98.7298, 109.358, 'Wing Commander Mulverick'),(23346, 74, -5387.68, -63.1046, 111.659, 'Wing Commander Mulverick'),(23346, 75, -5379.2, 3.21685, 121.526, 'Wing Commander Mulverick'),(23346, 76, -5314.43, 32.0712, 113.405, 'Wing Commander Mulverick'),(23346, 77, -5265.13, 11.6882, 110.016, 'Wing Commander Mulverick'),(23346, 78, -5207.98, -36.7408, 103.694, 'Wing Commander Mulverick'),(23346, 79, -5165.57, -80.167, 136.178, 'Wing Commander Mulverick'),(23346, 80, -5118.2, -105.716, 122.108, 'Wing Commander Mulverick'),(23346, 81, -5061.11, -96.3049, 117.942, 'Wing Commander Mulverick'),(23346, 82, -5031.23, -66.0233, 104.849, 'Wing Commander Mulverick'),(23346, 83, -4998.87, -11.7168, 81.3507, 'Wing Commander Mulverick'),(23346, 84, -4980.24, 10.3058, 77.7177, 'Wing Commander Mulverick'),(23346, 85, -4998.29, -7.4397, 78.78, 'Wing Commander Mulverick'),(23346, 86, -4971.93, 15.0586, 76.1905, 'Wing Commander Mulverick'),(23346, 87, -4926.84, 34.6864, 66.9967, 'Wing Commander Mulverick'),(23346, 88, -4895.08, 50.6947, 60.3591, 'Wing Commander Mulverick'),(23346, 89, -4874.35, 56.7382, 2.54341, 'Wing Commander Mulverick'),(23346, 90, -4845.41, 26.3595, 16.1138, 'Wing Commander Mulverick'),(23346, 91, -4839.98, -31.9981, 26.751, 'Wing Commander Mulverick'),(23346, 92, -4866.88, -28.3181, 40.2276, 'Wing Commander Mulverick'),(23346, 93, -4851.33, -5.85707, 22.9954, 'Wing Commander Mulverick'),
(23346, 94, -4833.69, -31.3822, 25.1184, 'Wing Commander Mulverick'),(23346, 95, -4874.32, -32.4778, 69.1992, 'Wing Commander Mulverick'),(23346, 96, -4898.07, -42.3574, 89.897, 'Wing Commander Mulverick'),(23346, 97, -4913.59, -54.3562, 121.409, 'Wing Commander Mulverick'),(23346, 98, -4937.62, -54.5098, 134.404, 'Wing Commander Mulverick'),(23346, 99, -4910.76, -34.7961, 134.404, 'Wing Commander Mulverick'),(23346, 100, -4910.34, -64.4031, 134.404, 'Wing Commander Mulverick'),(23346, 101, -4940.61, -38.7189, 125.076, 'Wing Commander Mulverick'),(23346, 102, -4961.5, -28.9198, 101.354, 'Wing Commander Mulverick'),(23346, 103, -4954.74, -7.93548, 100.327, 'Wing Commander Mulverick'),(23346, 104, -4927.17, -6.05419, 100.327, 'Wing Commander Mulverick'),(23346, 105, -4928.98, -37.9751, 116.941, 'Wing Commander Mulverick'),(23346, 106, -4953.41, -22.5698, 112.888, 'Wing Commander Mulverick'),(23346, 107, -4990.22, 6.49273, 102.639, 'Wing Commander Mulverick'),(23346, 108, -4961.07, 48.5569, 99.0104, 'Wing Commander Mulverick'),(23346, 109, -4945.81, 79.1764, 101.376, 'Wing Commander Mulverick'),(23346, 110, -4929.71, 150.686, 107.66, 'Wing Commander Mulverick'),(23346, 111, -4917.87, 196.516, 105.989, 'Wing Commander Mulverick'),(23346, 112, -4898.51, 259.459, 103.408, 'Wing Commander Mulverick'),(23346, 113, -4924.06, 249.392, 102.664, 'Wing Commander Mulverick'),(23346, 114, -4897.3, 248.342, 103.752, 'Wing Commander Mulverick'),(23346, 115, -4877.38, 298.139, 108.219, 'Wing Commander Mulverick'),(23346, 116, -4862.92, 327.174, 106.609, 'Wing Commander Mulverick'),(23346, 117, -4852.86, 372.216, 102.541, 'Wing Commander Mulverick'),(23346, 118, -4856.24, 433.69, 96.3819, 'Wing Commander Mulverick'),(23346, 119, -4860.41, 479.956, 92.4403, 'Wing Commander Mulverick'),(23346, 120, -4873.13, 528.395, 98.0209, 'Wing Commander Mulverick'),(23346, 121, -4904.29, 578.768, 96.3431, 'Wing Commander Mulverick'),(23346, 122, -4950.79, 636.883, 96.0455, 'Wing Commander Mulverick'),(23346, 123, -4987.17, 659.419, 97.2334, 'Wing Commander Mulverick'),(23346, 124, -5085.9, 662.095, 98.4426, 'Wing Commander Mulverick'),
(23346, 125, -5133.23, 670.744, 108.086, 'Wing Commander Mulverick'),(23346, 126, -5135.8, 693.839, 108.492, 'Wing Commander Mulverick'),(23346, 127, -5117.04, 714.214, 108.977, 'Wing Commander Mulverick'),(23346, 128, -5090.95, 694.526, 109.547, 'Wing Commander Mulverick'),(23346, 129, -5049.35, 683.563, 107.932, 'Wing Commander Mulverick'),(23346, 130, -4974.33, 663.794, 105.02, 'Wing Commander Mulverick'),(23346, 131, -4948.23, 656.914, 104.006, 'Wing Commander Mulverick'),(23346, 132, -4942.41, 666.963, 103.57, 'Wing Commander Mulverick'),(23346, 133, -4948.29, 679.504, 103.05, 'Wing Commander Mulverick'),(23346, 134, -4971.16, 682.781, 102.063, 'Wing Commander Mulverick'),(23346, 135, -4996.74, 666.623, 90.3214, 'Wing Commander Mulverick'),(23346, 136, -5058.53, 664.951, 89.5705, 'Wing Commander Mulverick'),(23346, 137, -5087.64, 664.358, 88.4531, 'Wing Commander Mulverick'),(23346, 138, -5102.46, 655.182, 87.3748, 'Wing Commander Mulverick'),(23346, 139, -5097.11, 643.767, 87.1566, 'Wing Commander Mulverick'),(23346, 140, -5080.96, 641.855, 86.9403, 'Wing Commander Mulverick');
DELETE FROM spell_script_names WHERE spell_id=40930;
INSERT INTO spell_script_names VALUES(40930, 'spell_quest_dragonmaw_race_generic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=40931;
INSERT INTO conditions VALUES (13, 3, 40931, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 40931, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");

-- Dragonmaw Race: Captain Skyshatter (11071)
UPDATE creature_model_info SET combat_reach=10, bounding_radius=2 WHERE modelid=21426;
UPDATE creature SET spawntimesecs=30 WHERE id=23348;
DELETE FROM creature_text WHERE entry=23348;
INSERT INTO creature_text VALUES(23348, 0, 0, "I weep for you, $N. You really have no idea what you've gotten yourself into...", 12, 0, 100, 0, 0, 0, 0, 'Captain Skyshatter');
INSERT INTO creature_text VALUES(23348, 1, 0, "Prepare a funeral pyre! $N has challenged Skyshatter!", 14, 0, 100, 0, 0, 0, 0, 'Captain Skyshatter');
INSERT INTO creature_text VALUES(23348, 2, 0, "I... I am undone... The new top orc is $N!", 14, 0, 100, 0, 0, 0, 0, 'Captain Skyshatter');
UPDATE creature_template SET InhabitType=5, AIName='SmartAI', ScriptName='' WHERE entry=23348;
DELETE FROM smart_scripts WHERE entryorguid=23348 AND source_type=0;
INSERT INTO smart_scripts VALUES (23348, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set npc flag');
INSERT INTO smart_scripts VALUES (23348, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23348, 0, 2, 3, 19, 0, 100, 0, 11071, 0, 0, 0, 53, 0, 23348, 0, 11071, 5000, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (23348, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (23348, 0, 4, 19, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set npc flag');
-- INSERT INTO smart_scripts VALUES (23348, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 60, 1, 50, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23348, 0, 6, 17, 40, 0, 100, 0, 5, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23348, 0, 7, 0, 40, 0, 100, 0, 7, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23348, 0, 8, 9, 40, 0, 100, 0, 138, 0, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (23348, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Fly');
INSERT INTO smart_scripts VALUES (23348, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23348, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
INSERT INTO smart_scripts VALUES (23348, 0, 12, 20, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase Mask');
INSERT INTO smart_scripts VALUES (23348, 0, 13, 0, 40, 0, 100, 0, 142, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set npc flag');
INSERT INTO smart_scripts VALUES (23348, 0, 14, 0, 60, 1, 100, 0, 10000, 10000, 2000, 2000, 6, 11071, 0, 0, 0, 0, 0, 17, 55, 300, 0, 0, 0, 0, 0, 'On Update - Fail quest');
INSERT INTO smart_scripts VALUES (23348, 0, 15, 0, 40, 1, 100, 0, 0, 0, 0, 0, 11, 40945, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Cast Spell');
INSERT INTO smart_scripts VALUES (23348, 0, 16, 0, 60, 1, 100, 0, 14000, 14000, 200, 2000, 11, 40945, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23348, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 320, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Fly');
INSERT INTO smart_scripts VALUES (23348, 0, 18, 21, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23348, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Active');
INSERT INTO smart_scripts VALUES (23348, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Active');
INSERT INTO smart_scripts VALUES (23348, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Walk');
DELETE FROM waypoints WHERE entry=23348;
INSERT INTO waypoints VALUES (23348, 1, -5087.56, 635.584, 86.7302, 'Captain Skyshatter'),(23348, 2, -5094.97, 641.565, 86.8949, 'Captain Skyshatter'),(23348, 3, -5099.64, 657.156, 87.3064, 'Captain Skyshatter'),(23348, 4, -5082.76, 664.815, 89.2039, 'Captain Skyshatter'),(23348, 5, -4987.41, 663.473, 92.5703, 'Captain Skyshatter'),(23348, 6, -4931.48, 678.786, 93.1402, 'Captain Skyshatter'),(23348, 7, -4894.17, 675.374, 88.3474, 'Captain Skyshatter'),(23348, 8, -4883.4, 657.438, 86.213, 'Captain Skyshatter'),(23348, 9, -4884.02, 635.673, 84.0022, 'Captain Skyshatter'),(23348, 10, -4911.95, 640.443, 92.6958, 'Captain Skyshatter'),(23348, 11, -4949.11, 665.224, 92.2993, 'Captain Skyshatter'),(23348, 12, -4995.33, 667.007, 95.0879, 'Captain Skyshatter'),(23348, 13, -5042.88, 668.841, 97.9566, 'Captain Skyshatter'),(23348, 14, -5106.24, 671.284, 109.361, 'Captain Skyshatter'),(23348, 15, -5129.32, 684.316, 129.959, 'Captain Skyshatter'),(23348, 16, -5187.61, 723.587, 139.018, 'Captain Skyshatter'),(23348, 17, -5225.68, 749.399, 141.018, 'Captain Skyshatter'),(23348, 18, -5241.56, 758.859, 139.016, 'Captain Skyshatter'),(23348, 19, -5263.38, 748.202, 136.384, 'Captain Skyshatter'),(23348, 20, -5274.45, 729.379, 134.006, 'Captain Skyshatter'),(23348, 21, -5264.11, 692.833, 113.639, 'Captain Skyshatter'),(23348, 22, -5251.51, 644.216, 98.6951, 'Captain Skyshatter'),(23348, 23, -5227.54, 586.549, 73.8104, 'Captain Skyshatter'),(23348, 24, -5232.89, 617.516, 73.3168, 'Captain Skyshatter'),
(23348, 25, -5250.13, 522.731, 97.3681, 'Captain Skyshatter'),(23348, 26, -5293.25, 452.003, 87.3439, 'Captain Skyshatter'),(23348, 27, -5289.51, 475.05, 84.5183, 'Captain Skyshatter'),(23348, 28, -5296.74, 459.331, 82.4244, 'Captain Skyshatter'),(23348, 29, -5321.86, 364.547, 78.6856, 'Captain Skyshatter'),(23348, 30, -5336.85, 260.91, 64.3121, 'Captain Skyshatter'),(23348, 31, -5328.95, 229.583, 84.3653, 'Captain Skyshatter'),(23348, 32, -5307.89, 164.544, 90.1567, 'Captain Skyshatter'),(23348, 33, -5274.67, 124.229, 98.2239, 'Captain Skyshatter'),(23348, 34, -5223.08, 87.9087, 98.6199, 'Captain Skyshatter'),(23348, 35, -5189.22, 52.5833, 99.0043, 'Captain Skyshatter'),(23348, 36, -5212.18, 68.3701, 99.2231, 'Captain Skyshatter'),(23348, 37, -5193.04, 51.3872, 99.4249, 'Captain Skyshatter'),(23348, 38, -5144.63, 8.82392, 116.142, 'Captain Skyshatter'),(23348, 39, -5113.09, -13.2902, 153.451, 'Captain Skyshatter'),(23348, 40, -5106.63, -19.826, 179.961, 'Captain Skyshatter'),(23348, 41, -5081.81, -42.1419, 175.739, 'Captain Skyshatter'),(23348, 42, -5055.97, -40.2629, 173.062, 'Captain Skyshatter'),(23348, 43, -5031.35, -13.8612, 169.328, 'Captain Skyshatter'),(23348, 44, -5061.29, 13.0471, 165.268, 'Captain Skyshatter'),(23348, 45, -5103.88, 54.4085, 158.421, 'Captain Skyshatter'),(23348, 46, -5125.73, 101.755, 148.134, 'Captain Skyshatter'),(23348, 47, -5114.57, 126.204, 141.401, 'Captain Skyshatter'),(23348, 48, -5139, 134.611, 155.723, 'Captain Skyshatter'),(23348, 49, -5170.2, 145.053, 144.259, 'Captain Skyshatter'),
(23348, 50, -5194.72, 147.041, 100.983, 'Captain Skyshatter'),(23348, 51, -5210.56, 160, 87.769, 'Captain Skyshatter'),(23348, 52, -5207.29, 209.95, 82.5642, 'Captain Skyshatter'),(23348, 53, -5202.63, 252.608, 116.804, 'Captain Skyshatter'),(23348, 54, -5186.9, 303.438, 116.804, 'Captain Skyshatter'),(23348, 55, -5191.42, 355.32, 112.467, 'Captain Skyshatter'),(23348, 56, -5233.37, 395.463, 112.177, 'Captain Skyshatter'),(23348, 57, -5286.87, 437.22, 105.525, 'Captain Skyshatter'),(23348, 58, -5266.34, 478.182, 110.562, 'Captain Skyshatter'),(23348, 59, -5206.61, 503.573, 111.606, 'Captain Skyshatter'),(23348, 60, -5163.47, 534.104, 114.552, 'Captain Skyshatter'),(23348, 61, -5182.36, 515.241, 116.022, 'Captain Skyshatter'),(23348, 62, -5206.81, 518.967, 117.426, 'Captain Skyshatter'),(23348, 63, -5187.21, 521.63, 118.514, 'Captain Skyshatter'),(23348, 64, -5155.39, 545.64, 116.076, 'Captain Skyshatter'),(23348, 65, -5115.6, 583.206, 129.026, 'Captain Skyshatter'),(23348, 66, -5073.47, 649.348, 119.881, 'Captain Skyshatter'),(23348, 67, -5052.38, 670.897, 116.044, 'Captain Skyshatter'),(23348, 68, -4996.43, 662.926, 113.267, 'Captain Skyshatter'),(23348, 69, -4961.47, 656.298, 112.929, 'Captain Skyshatter'),(23348, 70, -4943.27, 612.649, 112.304, 'Captain Skyshatter'),(23348, 71, -4942.63, 576.912, 111.831, 'Captain Skyshatter'),(23348, 72, -4962.21, 556.808, 111.463, 'Captain Skyshatter'),(23348, 73, -4991.94, 532.689, 123.558, 'Captain Skyshatter'),(23348, 74, -5018.77, 500.9, 128.931, 'Captain Skyshatter'),(23348, 75, -5046, 464.881, 154.479, 'Captain Skyshatter'),
(23348, 76, -5057.32, 433.366, 183.934, 'Captain Skyshatter'),(23348, 77, -5062.08, 423.791, 206.805, 'Captain Skyshatter'),(23348, 78, -5073.28, 396.567, 212.024, 'Captain Skyshatter'),(23348, 79, -5078.93, 361.95, 212.344, 'Captain Skyshatter'),(23348, 80, -5083.38, 319.898, 223.106, 'Captain Skyshatter'),(23348, 81, -5091.54, 267.262, 219.859, 'Captain Skyshatter'),(23348, 82, -5077.74, 245.874, 217.788, 'Captain Skyshatter'),(23348, 83, -5024.21, 225.572, 176.249, 'Captain Skyshatter'),(23348, 84, -4999.13, 223.503, 164.288, 'Captain Skyshatter'),(23348, 85, -4942.19, 274.08, 168.949, 'Captain Skyshatter'),(23348, 86, -4953.87, 301.817, 153.814, 'Captain Skyshatter'),(23348, 87, -4966.83, 291.411, 163.316, 'Captain Skyshatter'),(23348, 88, -4964.36, 265.204, 163.522, 'Captain Skyshatter'),(23348, 89, -4938.63, 264.626, 164.217, 'Captain Skyshatter'),(23348, 90, -4931.72, 291.768, 150.76, 'Captain Skyshatter'),(23348, 91, -4957.72, 300.242, 162.393, 'Captain Skyshatter'),(23348, 92, -4970.39, 252.106, 159.856, 'Captain Skyshatter'),(23348, 93, -4998.35, 241.729, 158.3, 'Captain Skyshatter'),(23348, 94, -4980.71, 264.41, 156.807, 'Captain Skyshatter'),(23348, 95, -5010.4, 241.114, 149.504, 'Captain Skyshatter'),(23348, 96, -5037.11, 210.487, 150.594, 'Captain Skyshatter'),(23348, 97, -5059.4, 188.456, 168.62, 'Captain Skyshatter'),(23348, 98, -5092.59, 173.388, 162.922, 'Captain Skyshatter'),(23348, 99, -5105.72, 202.446, 164.665, 'Captain Skyshatter'),(23348, 100, -5082.91, 206.861, 166.916, 'Captain Skyshatter'),(23348, 101, -5079.08, 185.103, 161.787, 'Captain Skyshatter'),(23348, 102, -5090.4, 212.133, 167.925, 'Captain Skyshatter'),
(23348, 103, -5090.4, 212.133, 167.925, 'Captain Skyshatter'),(23348, 104, -5118.5, 223.472, 172.949, 'Captain Skyshatter'),(23348, 105, -5114.53, 185.571, 172.229, 'Captain Skyshatter'),(23348, 106, -5086.57, 177.489, 165.926, 'Captain Skyshatter'),(23348, 107, -5104.78, 204.471, 162.304, 'Captain Skyshatter'),(23348, 108, -5100.53, 240.85, 172.979, 'Captain Skyshatter'),(23348, 109, -5100.42, 211.319, 159.459, 'Captain Skyshatter'),(23348, 110, -5099.75, 238.598, 185.354, 'Captain Skyshatter'),(23348, 111, -5100.56, 184.533, 166.588, 'Captain Skyshatter'),(23348, 112, -5099.49, 223.17, 183.528, 'Captain Skyshatter'),(23348, 113, -5098.72, 251.22, 184.03, 'Captain Skyshatter'),(23348, 114, -5102.87, 221.21, 170.16, 'Captain Skyshatter'),(23348, 115, -5103.02, 176.81, 149.762, 'Captain Skyshatter'),(23348, 116, -5125.85, 178.913, 170.682, 'Captain Skyshatter'),(23348, 117, -5105.31, 221.506, 177.608, 'Captain Skyshatter'),(23348, 118, -5077.74, 257.581, 188.335, 'Captain Skyshatter'),(23348, 119, -5054.87, 298.941, 202.73, 'Captain Skyshatter'),(23348, 120, -5025.86, 320.998, 195.272, 'Captain Skyshatter'),(23348, 121, -4985.94, 354.82, 187.078, 'Captain Skyshatter'),(23348, 122, -4965.83, 393.094, 212.127, 'Captain Skyshatter'),(23348, 123, -4936.18, 440.955, 223.817, 'Captain Skyshatter'),(23348, 124, -4915.47, 486.716, 162.626, 'Captain Skyshatter'),(23348, 125, -4907.49, 506.496, 137.118, 'Captain Skyshatter'),(23348, 126, -4909.6, 542.633, 125.838, 'Captain Skyshatter'),(23348, 127, -4918.57, 610.449, 132.913, 'Captain Skyshatter'),(23348, 128, -4929.68, 650.715, 119.914, 'Captain Skyshatter'),(23348, 129, -4970.79, 659.978, 103.462, 'Captain Skyshatter'),
(23348, 130, -4997.78, 664.189, 97.2824, 'Captain Skyshatter'),(23348, 131, -4975.31, 660.466, 102.388, 'Captain Skyshatter'),(23348, 132, -4989.89, 651.918, 98.5794, 'Captain Skyshatter'),(23348, 133, -5002.25, 668.847, 93.8366, 'Captain Skyshatter'),(23348, 134, -4985.44, 684.705, 94.677, 'Captain Skyshatter'),(23348, 135, -4966.06, 661.69, 98.2438, 'Captain Skyshatter'),(23348, 136, -4989.44, 661.463, 99.1368, 'Captain Skyshatter'),(23348, 137, -5064.1, 665.918, 89.5543, 'Captain Skyshatter'),(23348, 138, -5084.8, 665.122, 88.5924, 'Captain Skyshatter'),(23348, 139, -5099, 664.576, 87.2931, 'Captain Skyshatter'),(23348, 140, -5097.66, 650.922, 87.2361, 'Captain Skyshatter'),(23348, 141, -5093.08, 642.734, 86.9699, 'Captain Skyshatter'),(23348, 142, -5082.29, 633.93, 86.6494, 'Captain Skyshatter');
DELETE FROM spell_script_names WHERE spell_id=40945;
INSERT INTO spell_script_names VALUES(40945, 'spell_quest_dragonmaw_race_generic');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41064;
INSERT INTO conditions VALUES (13, 3, 41064, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 41064, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=41284;
INSERT INTO conditions VALUES (13, 3, 41284, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', "Target Players");
INSERT INTO conditions VALUES (13, 4, 41284, 0, 0, 31, 0, 3, 23356, 0, 0, 0, 0, '', "Target Trigger");

-- Scratches (10556)
DELETE FROM event_scripts WHERE id=12890;

-- Bring Me The Egg! (10111)
UPDATE creature_template SET AIName='SmartAI', flags_extra=0 WHERE entry=19055;
DELETE FROM smart_scripts WHERE entryorguid=19055 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=1905500 AND source_type=9;
INSERT INTO smart_scripts VALUES (19055, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 53, 0, 19055, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - Start WP movement');
INSERT INTO smart_scripts VALUES (19055, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - On Spawn - Emote Text 0');
INSERT INTO smart_scripts VALUES (19055, 0, 2, 0, 40, 0, 100, 0, 3, 19055, 0, 0, 80, 1905500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - Load script 1 at WP 3');
INSERT INTO smart_scripts VALUES (19055, 0, 3, 0, 0, 0, 100, 0, 4000, 4000, 6000, 6000, 11, 30285, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - In Combat - Cast Eagle Claw');
INSERT INTO smart_scripts VALUES (19055, 0, 4, 0, 0, 0, 100, 0, 7000, 8000, 11000, 14000, 11, 32914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - In Combat - Cast Wing Buffet');
INSERT INTO smart_scripts VALUES (1905500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - Script - Set Home Position');
INSERT INTO smart_scripts VALUES (1905500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - On Script - Set Faction Aggressive');
INSERT INTO smart_scripts VALUES (1905500, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Windroc Matriarch - Script - Attack Nearest Player');

-- Test Flight: The Zephyrium Capacitorium (10557)
-- Test Flight: The Singing Ridge (10710)
-- Test Flight: Razaan's Landing (10711)
-- Test Flight: Ruuan Weald (10712)
DELETE FROM gossip_menu WHERE entry=8304;
INSERT INTO gossip_menu VALUES (8304, 10537), (8304, 10360);
DELETE FROM gossip_menu_option WHERE menu_id IN(8304, 8455);
INSERT INTO gossip_menu_option VALUES (8455, 0, 0, "Send me back to the Jagged Ridge.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8455, 1, 0, "Send me back to the Singing Ridge.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8455, 2, 0, "Send me back to Razaan's Landing.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8455, 3, 0, "Send me back to Ruuan.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8455, 4, 0, "Send me back to Raven's Wood.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 0, 0, "I'm ready for my test flight!", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 1, 0, "Take me to Singing Ridge.", 1, 1, 8454, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 2, 0, "Send me to Razaan's Landing!", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 3, 0, "Take me to Ruuan.", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 4, 0, "Send me to Raven's Wood!", 1, 1, 0, 0, 0, 0, '');
INSERT INTO gossip_menu_option VALUES (8304, 5, 0, "I want to fly to an old location!", 1, 1, 8455, 0, 0, 0, '');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=38170;
INSERT INTO conditions VALUES(17, 0, 38170, 0, 0, 1, 0, 37968, 1, 0, 0, 0, 0, '', 'Spin Nether-weather Vane, requires aura');
DELETE FROM creature_queststarter WHERE quest=10716;
DELETE FROM creature_questender WHERE quest=10716;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8303;
INSERT INTO conditions VALUES(15, 8303, 0, 0, 0, 2, 0, 30539, 1, 0, 1, 0, 0, '', 'Tally Zapnabber - Show gossip option only if player has no item 30539');
INSERT INTO conditions VALUES(15, 8303, 0, 0, 0, 2, 0, 30540, 1, 0, 1, 0, 0, '', 'Tally Zapnabber - Show gossip option only if player has no item 30540');
INSERT INTO conditions VALUES(15, 8303, 0, 0, 0, 9, 0, 10710, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10710');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(14, 15) AND SourceGroup IN(8304, 8455);
INSERT INTO conditions VALUES(14, 8304, 10537, 0, 0, 1, 0, 37108, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show different gossip if player is affected by aura 37108');
INSERT INTO conditions VALUES(15, 8304, 0, 0, 0, 9, 0, 10557, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10557');
INSERT INTO conditions VALUES(15, 8304, 1, 0, 0, 9, 0, 10710, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10710');
INSERT INTO conditions VALUES(15, 8304, 2, 0, 0, 9, 0, 10711, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10711');
INSERT INTO conditions VALUES(15, 8304, 3, 0, 0, 9, 0, 10712, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10712');
INSERT INTO conditions VALUES(15, 8304, 4, 0, 0, 9, 0, 10716, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10716');
INSERT INTO conditions VALUES(15, 8304, 5, 0, 0, 8, 0, 10557, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has taken quest 10557');
INSERT INTO conditions VALUES(15, 8304, 0, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 1, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 2, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 3, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 4, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 5, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8304, 0, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8304, 1, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8304, 2, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8304, 3, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8304, 4, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8304, 5, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8455, 0, 0, 0, 8, 0, 10557, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has completed quest 10557');
INSERT INTO conditions VALUES(15, 8455, 1, 0, 0, 8, 0, 10710, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has completed quest 10710');
INSERT INTO conditions VALUES(15, 8455, 2, 0, 0, 8, 0, 10711, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has completed quest 10711');
INSERT INTO conditions VALUES(15, 8455, 3, 0, 0, 8, 0, 10712, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has completed quest 10712');
INSERT INTO conditions VALUES(15, 8455, 4, 0, 0, 8, 0, 10716, 0, 0, 0, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player has completed quest 10716');
INSERT INTO conditions VALUES(15, 8455, 0, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8455, 1, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8455, 2, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8455, 3, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8455, 4, 0, 0, 1, 0, 37108, 0, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if player doesnt have aura 37108');
INSERT INTO conditions VALUES(15, 8455, 0, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8455, 1, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8455, 2, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8455, 3, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');
INSERT INTO conditions VALUES(15, 8455, 4, 0, 0, 29, 0, 21413, 30, 0, 1, 0, 0, '', 'Rally Zapnabber - Show gossip option only if no npc near');

UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21460;
DELETE FROM smart_scripts WHERE entryorguid=21460 AND source_type=0;
INSERT INTO smart_scripts VALUES (21460, 0, 0, 1, 62, 0, 100, 0, 8303, 0, 0, 0, 56, 30540, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (21460, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21461;
DELETE FROM smart_scripts WHERE entryorguid=21461 AND source_type=0;
INSERT INTO smart_scripts VALUES (21461, 0, 0, 1, 62, 0, 100, 0, 8304, 0, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 1, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1920.91, 5579.68, 269.23, 1.93, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 2, 3, 62, 0, 100, 0, 8454, 0, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 3, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1921.01, 5585.01, 269.23, 4.42, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 4, 5, 62, 0, 100, 0, 8304, 2, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 5, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1917.48, 5583.55, 269.23, 5.71, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 6, 7, 62, 0, 100, 0, 8304, 3, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 7, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1917.16, 5581.52, 269.23, 0.11, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 9, 10, 62, 0, 100, 0, 8455, 0, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 10, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1920.91, 5579.68, 269.23, 1.93, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 11, 12, 62, 0, 100, 0, 8455, 1, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 12, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1921.01, 5585.01, 269.23, 4.42, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 13, 14, 62, 0, 100, 0, 8455, 2, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 14, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1917.48, 5583.55, 269.23, 5.71, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 15, 16, 62, 0, 100, 0, 8455, 3, 0, 0, 85, 36860, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (21461, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 12, 21413, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 1917.16, 5581.52, 269.23, 0.11, "On Gossip Select - Summon Creature");
INSERT INTO smart_scripts VALUES (21461, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
-- shooter
REPLACE INTO creature_template_addon VALUES(21393, 0, 0, 50331648, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(21394, 0, 0, 50331648, 0, 0, '36785');
UPDATE creature_template SET modelid1=20292, modelid2=0, scale=1, InhabitType=4 WHERE entry IN(21393, 21394);
REPLACE INTO spell_target_position VALUES(36801, 2, 530, 1919.99, 5581.97, 271.30, 5.27);
UPDATE creature_template SET modelid1=15435, modelid2=0, AIName='NullCreatureAI' WHERE entry=21413;
DELETE FROM spell_script_names WHERE spell_id IN(36860, 36785);
INSERT INTO spell_script_names VALUES(36860, 'spell_quest_test_flight_charging');
INSERT INTO spell_script_names VALUES(36785, 'spell_quest_test_flight_charging');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36795;
INSERT INTO conditions VALUES (13, 1, 36795, 0, 0, 31, 0, 3, 21394, 0, 0, 0, 0, '', "Target Cannon channeler");
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-37910, -37962, -36812, -37968, -37940);
INSERT INTO spell_linked_spell VALUES(-37910, 37108, 0, 'Zephyrium Charged');
INSERT INTO spell_linked_spell VALUES(-37962, 37108, 0, 'Zephyrium Charged');
INSERT INTO spell_linked_spell VALUES(-36812, 37108, 0, 'Zephyrium Charged');
INSERT INTO spell_linked_spell VALUES(-37968, 37108, 0, 'Zephyrium Charged');
INSERT INTO spell_linked_spell VALUES(-37940, 37108, 0, 'Zephyrium Charged');

-- Escape from Skettis (11085)
UPDATE quest_template SET SpecialFlags=3 WHERE Id=11085;
DELETE FROM creature WHERE id=23383;
INSERT INTO creature VALUES (NULL, 23383, 530, 1, 1, 0, 0, -4106.62, 3029.94, 344.877, 0.827394, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
DELETE FROM creature_text WHERE entry=23383;
INSERT INTO creature_text VALUES(23383, 0, 0, "Thanks for your help. Let's get out of here!", 12, 0, 100, 0, 0, 0, 0, 'Skyguard Prisoner');
INSERT INTO creature_text VALUES(23383, 1, 0, "Let's keep moving. I don't like this place.", 12, 0, 100, 0, 0, 0, 0, 'Skyguard Prisoner');
INSERT INTO creature_text VALUES(23383, 2, 0, "Thanks again. Sergeant Doryn will be glad to hear he has one less scout to replace this week.", 12, 0, 100, 0, 0, 0, 0, 'Skyguard Prisoner');
UPDATE creature_template SET speed_run=1, AIName='SmartAI' WHERE entry=23383;
DELETE FROM smart_scripts WHERE entryorguid=23383 AND source_type=0;
INSERT INTO smart_scripts VALUES (23383, 0, 0, 1, 19, 0, 100, 0, 11085, 0, 0, 0, 53, 0, 23383, 0, 11085, 5000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (23383, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 15, 185952, 10, 0, 0, 0, 0, 0, 'On Quest Accept - Activate GO');
INSERT INTO smart_scripts VALUES (23383, 0, 2, 3, 40, 0, 100, 0, 1, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Pause Path');
INSERT INTO smart_scripts VALUES (23383, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23383, 0, 4, 0, 25, 0, 30, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Talk');
INSERT INTO smart_scripts VALUES (23383, 0, 5, 6, 40, 0, 100, 0, 22, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (23383, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Despawn');
DELETE FROM waypoints WHERE entry=23383;
INSERT INTO waypoints VALUES (23383, 1, -4108.06, 3031.46, 344.879, 'Skyguard Prisoner'),(23383, 2, -4110.58, 3034.34, 344.121, 'Skyguard Prisoner'),(23383, 3, -4116.37, 3033.79, 344.083, 'Skyguard Prisoner'),(23383, 4, -4122.83, 3027.09, 344.149, 'Skyguard Prisoner'),(23383, 5, -4126.33, 3027.21, 344.158, 'Skyguard Prisoner'),(23383, 6, -4128.94, 3026.88, 344.021, 'Skyguard Prisoner'),(23383, 7, -4135.6, 3028.52, 339.992, 'Skyguard Prisoner'),(23383, 8, -4144.75, 3030.27, 337.474, 'Skyguard Prisoner'),(23383, 9, -4157.26, 3032.66, 337.446, 'Skyguard Prisoner'),(23383, 10, -4171.01, 3035.29, 342.801, 'Skyguard Prisoner'),(23383, 11, -4172.98, 3035.67, 343.267, 'Skyguard Prisoner'),(23383, 12, -4175.09, 3039.7, 343.64, 'Skyguard Prisoner'),(23383, 13, -4176.68, 3049.94, 344.072, 'Skyguard Prisoner'),(23383, 14, -4182.15, 3056.03, 344.146, 'Skyguard Prisoner'),
(23383, 15, -4185.25, 3060.86, 344.157, 'Skyguard Prisoner'),(23383, 16, -4184.97, 3062.4, 344.152, 'Skyguard Prisoner'),(23383, 17, -4183.71, 3065.44, 342.625, 'Skyguard Prisoner'),(23383, 18, -4181.35, 3071.13, 336.977, 'Skyguard Prisoner'),(23383, 19, -4179.91, 3079.19, 329.741, 'Skyguard Prisoner'),(23383, 20, -4178.71, 3085.91, 325.563, 'Skyguard Prisoner'),(23383, 21, -4178.18, 3088.9, 324.177, 'Skyguard Prisoner'),(23383, 22, -4175.07, 3094.67, 323.426, 'Skyguard Prisoner');

-- Spirit of Ar'tor Quests
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=21318);
REPLACE INTO creature_template_addon VALUES (21318, 0, 0, 0, 4097, 0, '37497');
DELETE FROM creature WHERE id=21318;
INSERT INTO creature VALUES (69713, 21318, 530, 1, 1, 0, 0, -3800.38, 2601.1, 90.143, 5.48163, 180, 0, 0, 6986, 0, 0, 0, 0, 0);
UPDATE creature_template SET gossip_menu_id=8288, AIName='SmartAI', ScriptName='' WHERE entry=21318;

-- The Fel and the Furious (10612)
-- The Fel and the Furious (10613)
UPDATE creature_template SET faction=14 WHERE entry IN(21960, 21961);
UPDATE creature_template SET faction=14, spell1=38055, spell2=38052, spell3=38006, spell4=37920, AIName='SmartAI' WHERE entry=21949;
DELETE FROM smart_scripts WHERE entryorguid=21949 AND source_type=0;
INSERT INTO smart_scripts VALUES (21949, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Evade');
UPDATE gameobject_template SET flags=4 WHERE entry IN(184979, 185034, 185057, 185058, 185059, 185060, 185061);
DELETE FROM spell_linked_spell WHERE spell_trigger IN(38002, 38120, 38122, 38125, 38127, 38129);
INSERT INTO spell_linked_spell VALUES(38002, 38003, 0, 'Charm Deathforged Infernal');
INSERT INTO spell_linked_spell VALUES(38120, 38003, 0, 'Charm Deathforged Infernal');
INSERT INTO spell_linked_spell VALUES(38122, 38003, 0, 'Charm Deathforged Infernal');
INSERT INTO spell_linked_spell VALUES(38125, 38003, 0, 'Charm Deathforged Infernal');
INSERT INTO spell_linked_spell VALUES(38127, 38003, 0, 'Charm Deathforged Infernal');
INSERT INTO spell_linked_spell VALUES(38129, 38003, 0, 'Charm Deathforged Infernal');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=38003;
INSERT INTO conditions VALUES (13, 1, 38003, 0, 0, 31, 0, 3, 21949, 0, 0, 0, 0, '', 'Target Fel Reaver');
INSERT INTO conditions VALUES (13, 1, 38003, 0, 0, 1, 0, 38003, 0, 0, 1, 0, 0, '', 'Target Fel Reaver Not Charmed');
DELETE FROM spell_script_names WHERE spell_id=38055;
INSERT INTO spell_script_names VALUES(38055, "spell_q10612_10613_the_fel_and_the_furious");

-- Lost in Action (9738)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(7520, 7540);
UPDATE creature_template SET AIName='', ScriptName='npc_natrualist_bite' WHERE entry=17893;
DELETE FROM smart_scripts WHERE entryorguid=17893 AND source_type=0;

-- Sabotage the Warp-Gate! (10310)
DELETE FROM creature_text WHERE entry=20281;
INSERT INTO creature_text VALUES(20281, 0, 0, "Let's proceed at a brisk pace.", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 1, 0, "We'll start at that first energy pylon, straight ahead. Remember, try to keep them off of me.", 12, 0, 100, 25, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 2, 0, "I'm done with this pylon. On to the next.", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 3, 0, "Alright, pylon two down. Now for the heat manifold.", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 4, 0, "That should do it. The teleporter should blow any second now!", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 4, 1, "Ok, let's get out of here!", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 5, 0, "Thank you, $N! I couldn't have done it without you. You'll let Gahruj know?", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
INSERT INTO creature_text VALUES(20281, 6, 0, "Keep them off me!", 12, 0, 100, 0, 0, 0, 0, 'Drijya');
UPDATE creature_template SET faction=90 WHERE entry IN(20399, 20402, 20403);
UPDATE creature_template SET unit_flags=0, AIName='SmartAI' WHERE entry IN(20281, 20296);
DELETE FROM smart_scripts WHERE entryorguid IN(20296, 20281) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(20281*100, 20281*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (20281, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Flag');
INSERT INTO smart_scripts VALUES (20281, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set NPC Flag');
INSERT INTO smart_scripts VALUES (20281, 0, 2, 3, 19, 0, 100, 0, 10310, 0, 0, 0, 53, 1, 20281, 0, 10310, 5000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (20281, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Flag');
INSERT INTO smart_scripts VALUES (20281, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set NPC Flag');
INSERT INTO smart_scripts VALUES (20281, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 6, 7, 40, 0, 100, 0, 5, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20281, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 8, 9, 40, 0, 100, 0, 6, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20281, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20281*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (20281, 0, 10, 21, 56, 0, 100, 0, 6, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resume - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 11, 12, 40, 0, 100, 0, 9, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20281, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20281*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (20281, 0, 13, 21, 56, 0, 100, 0, 9, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resume - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 14, 15, 40, 0, 100, 0, 12, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (20281, 0, 15, 22, 61, 0, 100, 0, 0, 0, 0, 0, 12, 20403, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3000, 2708, 114.4, 1.1, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281, 0, 16, 21, 56, 0, 100, 0, 12, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resume - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 18, 0, 40, 0, 100, 0, 14, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20296, 100, 0, 0, 0, 0, 0, 'On WP Reached - Set Data');
INSERT INTO smart_scripts VALUES (20281, 0, 19, 0, 40, 0, 100, 0, 15, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 20, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (20281, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Remove Emote State');
INSERT INTO smart_scripts VALUES (20281, 0, 22, 0, 61, 0, 100, 0, 0, 0, 0, 0, 17, 469, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Emote State');
INSERT INTO smart_scripts VALUES (20281*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 469, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (20281*100, 9, 1, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3027, 2733, 113.7, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 2, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3034, 2738, 114.6, 0.7, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 3, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3067, 2716, 114.6, 2.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 4, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3052, 2744, 114.9, 4.7, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 5, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3027, 2733, 113.7, 0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 6, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3034, 2738, 114.6, 0.7, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 7, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3067, 2716, 114.6, 2.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100, 9, 8, 0, 0, 0, 100, 1, 500, 500, 0, 0, 12, 20399, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3052, 2744, 114.9, 4.7, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 17, 469, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Emote State');
INSERT INTO smart_scripts VALUES (20281*100+1, 9, 1, 0, 0, 0, 100, 1, 2000, 2000, 0, 0, 12, 20402, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3035, 2688, 114.7, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100+1, 9, 2, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 12, 20402, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3037, 2713, 113.72, 3.8, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20281*100+1, 9, 3, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 12, 20402, 4, 40000, 0, 1, 0, 8, 0, 0, 0, 3044, 2700, 114, 3.3, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20296, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 11, 34602, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Cast Spell');
INSERT INTO smart_scripts VALUES (20296, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 51195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Cast Spell');
DELETE FROM waypoints WHERE entry=20281;
INSERT INTO waypoints VALUES (20281, 1, 3101.25, 2800.1, 118.565, 'Drijya'),(20281, 2, 3107.59, 2793.75, 117.902, 'Drijya'),(20281, 3, 3095.54, 2771.74, 115.836, 'Drijya'),(20281, 4, 3079.12, 2756.75, 116.342, 'Drijya'),(20281, 5, 3067.32, 2751.77, 115.838, 'Drijya'),(20281, 6, 3051.47, 2729.87, 114.098, 'Drijya'),(20281, 7, 3056.46, 2723.47, 113.688, 'Drijya'),(20281, 8, 3041.73, 2711.97, 114.028, 'Drijya'),
(20281, 9, 3025.76, 2699.51, 113.591, 'Drijya'),(20281, 10, 3013.88, 2708.98, 113.785, 'Drijya'),(20281, 11, 3002, 2718.44, 113.769, 'Drijya'),(20281, 12, 3004.45, 2727.35, 114.311, 'Drijya'),(20281, 13, 2999.4, 2718.94, 113.782, 'Drijya'),
(20281, 14, 2987.64, 2701.45, 114.163, 'Drijya'),(20281, 15, 2968.07, 2672.37, 116.821, 'Drijya');

-- Nexus-King Salhadaar (10408)
REPLACE INTO creature_text VALUES(20454, 0, 0, "Prepare to enter oblivion, meddlers. You have unleashed a god!", 14, 0, 100, 0, 0, 0, 0, 'Nexus-King Salhadaar');
UPDATE creature SET position_z=113, MovementType=0, spawndist=0, spawntimesecs=300 WHERE id=20769;
UPDATE creature SET position_z=109 WHERE id=20454;
UPDATE creature_template SET modelid1=14501, modelid2=0, InhabitType=4, flags_extra=130, AIName='SmartAI' WHERE entry=20769;
UPDATE creature_template SET unit_flags=0, AIName='SmartAI' WHERE entry=20454;
UPDATE creature_template SET faction=1796, AIName='SmartAI' WHERE entry=21425;
DELETE FROM smart_scripts WHERE entryorguid IN(20454, 20769, 21425) AND source_type=0; 
INSERT INTO smart_scripts VALUES (20454, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 17, 468, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spawn - Set Emote State');
INSERT INTO smart_scripts VALUES (20454, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spawn - Set Faction');
INSERT INTO smart_scripts VALUES (20454, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 33554496, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spawn - Set Flag');
INSERT INTO smart_scripts VALUES (20454, 0, 3, 4, 60, 0, 100, 1, 10000, 10000, 5000, 5000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (20454, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Remove Emote State');
INSERT INTO smart_scripts VALUES (20454, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 35684, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (20454, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 2, 1796, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Faction');
INSERT INTO smart_scripts VALUES (20454, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 19, 33554496, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Remove Flag');
INSERT INTO smart_scripts VALUES (20454, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (20454, 0, 9, 0, 0, 0, 100, 0, 10000, 15000, 25000, 30000, 11, 36527, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Stasis');
INSERT INTO smart_scripts VALUES (20454, 0, 10, 0, 0, 0, 100, 0, 5000, 7000, 10000, 10000, 11, 36533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Gravity Flux');
INSERT INTO smart_scripts VALUES (20454, 0, 11, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 36848, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES (21425, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 15000, 15000, 11, 36533, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Gravity Flux');
INSERT INTO smart_scripts VALUES (21425, 0, 1, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (20769, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (20769, 0, 1, 0, 60, 1, 100, 1, 13000, 13000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn');
INSERT INTO smart_scripts VALUES (20769, 0, 2, 0, 60, 0, 100, 1, 3000, 3000, 0, 0, 11, 35515, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=184561;
DELETE FROM smart_scripts WHERE entryorguid=184561 AND source_type=1;
INSERT INTO smart_scripts VALUES (184561, 1, 0, 0, 60, 0, 100, 1, 14000, 14000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20769, 20, 0, 0, 0, 0, 0, 'On Update - Set Data');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=35515;
INSERT INTO conditions VALUES (13, 1, 35515, 0, 0, 31, 0, 3, 20454, 0, 0, 0, 0, '', 'Requires Nexus-King Salhadaar');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=20454;
INSERT INTO conditions VALUES (22, 4, 20454, 0, 0, 29, 1, 20769, 60, 0, 1, 0, 0, '', 'Requires no NPC in range');

-- Ending Their World (9759)
DELETE FROM creature_text WHERE entry IN(17678, 17982);
INSERT INTO creature_text VALUES(17982, 0, 0, "Cover me!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 1, 0, "I've almost got it! Just a little more time...", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 2, 0, "That'll do it! Quickly, take cover!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 3, 0, "3...", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 4, 0, "2...", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 5, 0, "1...", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 6, 0, "Don't get too excited, hero, that was the easy part. The challenge lies ahead! Let's go.", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 7, 0, "What in the Nether is that?!?!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 8, 0, "Be ready for anything, $N.", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 9, 0, "Blessed Light! She's siphoning energy right out of the Vector Coil!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 10, 0, "Cover me, we have to do this quickly. Once I blow the support on this side, it will disrupt the energy beams and she'll break out! I doubt very much that she'll be happy to see us.", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 11, 0, "Take cover and be ready for the fight of your life, $N!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 12, 0, "Holy Mother of O'Ros!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 13, 0, "I... I can't believe it's over. You did it! You've destroyed the blood elves and their leader!", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17982, 14, 0, "Get back to Blood Watch. I'll see you there...", 12, 0, 100, 0, 0, 0, 0, "Demonitiolist Legoso");
INSERT INTO creature_text VALUES(17678, 0, 0, "Petulant children, pray to your gods for you are about to meet them!", 14, 0, 100, 0, 0, 0, 0, "Sironas");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=31611;
INSERT INTO conditions VALUES (13, 1, 31611, 0, 0, 31, 0, 3, 17678, 0, 0, 0, 0, '', 'Requires Sironas');
INSERT INTO conditions VALUES (13, 1, 31611, 0, 0, 1, 0, 31612, 0, 0, 0, 0, 0, '', 'Requires Sironas Aura');
UPDATE creature SET spawndist=0, MovementType=0 WHERE id=17979;
UPDATE creature_template SET faction=1714, AIName='SmartAI' WHERE entry=17678;
UPDATE creature_template SET speed_run=1, AIName='SmartAI' WHERE entry=17982;
UPDATE creature_template SET InhabitType=4, AIName='SmartAI' WHERE entry=17979;
DELETE FROM smart_scripts WHERE entryorguid IN(17678, 17979, 17982) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(17982*100, 17982*100+1, 17982*100+2, 17982*100+3, 17982*100+4) AND source_type=9;
INSERT INTO smart_scripts VALUES (17982, 0, 0, 0, 19, 0, 100, 0, 9759, 0, 0, 0, 53, 1, 17982, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (17982, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 8000, 8000, 11, 8056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Frost Shock');
INSERT INTO smart_scripts VALUES (17982, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 11000, 11000, 11, 913, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Healing Wave');
-- INSERT INTO smart_scripts VALUES (17982, 0, 3, 0, 0, 0, 100, 0, 13000, 14000, 15000, 15000, 11, 8004, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Lesser Healing Wave');
INSERT INTO smart_scripts VALUES (17982, 0, 4, 0, 0, 0, 100, 0, 0, 0, 15000, 15000, 11, 325, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Lightning Shield');
INSERT INTO smart_scripts VALUES (17982, 0, 5, 0, 40, 0, 100, 0, 25, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 6, 7, 40, 0, 100, 0, 27, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (17982, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 17982*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (17982, 0, 8, 0, 40, 0, 100, 0, 28, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 9, 10, 40, 0, 100, 0, 31, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (17982, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 17982*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (17982, 0, 11, 12, 40, 0, 100, 0, 40, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (17982, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 13, 0, 56, 0, 100, 0, 40, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On WP Resume - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 14, 15, 40, 0, 100, 0, 43, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (17982, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 9, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 16, 0, 52, 0, 100, 0, 9, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
INSERT INTO smart_scripts VALUES (17982, 0, 17, 18, 40, 0, 100, 0, 45, 0, 0, 0, 54, 28000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (17982, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 17982*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (17982, 0, 19, 0, 40, 0, 100, 0, 49, 0, 0, 0, 80, 17982*100+3, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (17982, 0, 20, 0, 7, 1, 100, 1, 0, 0, 0, 0, 80, 17982*100+4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Script9');
INSERT INTO smart_scripts VALUES (17982*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 0');
INSERT INTO smart_scripts VALUES (17982*100, 9, 1, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100, 9, 2, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 0');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0.7, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1962.53, -10656.9, 124.125, 0.322799, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 5, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1941.75, -10663.7, 126.462, 0.0636172, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 6, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1954.96, -10660.4, 130.794, 1.08856, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 7, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1928.92, -10673.9, 124.273, 0.0636172, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 8, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1927.21, -10675.4, 134.452, 0.558418, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 9, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1941.15, -10664.8, 141.266, 0.558418, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 10, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1946.89, -10660.3, 139.935, 0.558418, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 11, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1951.09, -10655, 139.902, 0.558418, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 12, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1963.7, -10653.2, 142.875, 6.01694, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 13, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1960.48, -10663.6, 142.474, 1.06893, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 14, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1937.21, -10667.4, 131.39, 0.94719, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 15, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1946.76, -10653.3, 119.19, 1.24564, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+1, 9, 16, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+2, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 0');
INSERT INTO smart_scripts VALUES (17982*100+2, 9, 1, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+2, 9, 2, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 0');
INSERT INTO smart_scripts VALUES (17982*100+2, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 11, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1906.47, -10583.7, 186.822, 5.31794, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 5, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1917.51, -10585.8, 189.25, 4.62287, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 6, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1911.4, -10586.1, 195.387, 4.62287, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 7, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1919.15, -10587.1, 194.39, 4.62287, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 8, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1920.97, -10588.7, 202.086, 4.62287, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 9, 0, 0, 0, 100, 0, 100, 100, 0, 0, 50, 182090, 120, 0, 0, 0, 0, 8, 0, 0, 0, -1925.14, -10589.4, 184.482, 5.40826, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 10, 0, 0, 0, 100, 0, 500, 500, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 17678, 100, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
INSERT INTO smart_scripts VALUES (17982*100+3, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (17982*100+4, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+4, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 26, 9759, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Script9 - Area Explored');
INSERT INTO smart_scripts VALUES (17982*100+4, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (17982*100+4, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (17678, 0, 0, 2, 1, 0, 100, 0, 1000, 1000, 10000, 10000, 11, 31612, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On OOC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (17678, 0, 1, 2, 21, 0, 100, 0, 0, 0, 0, 0, 11, 31612, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reached Home - Cast Spell');
INSERT INTO smart_scripts VALUES (17678, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Flags');
INSERT INTO smart_scripts VALUES (17678, 0, 3, 0, 0, 0, 100, 0, 7000, 9000, 11000, 11000, 11, 12742, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Immolate');
INSERT INTO smart_scripts VALUES (17678, 0, 4, 0, 0, 0, 100, 0, 6000, 7000, 25000, 25000, 11, 8282, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Curse of Blood');
INSERT INTO smart_scripts VALUES (17678, 0, 5, 0, 0, 0, 100, 0, 4000, 4000, 15000, 15000, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Upper Cut');
INSERT INTO smart_scripts VALUES (17678, 0, 6, 7, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES (17678, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 11, 17979, 100, 0, 0, 0, 0, 0, 'On Data Set - Kill Unit');
INSERT INTO smart_scripts VALUES (17678, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Remove All Auras');
INSERT INTO smart_scripts VALUES (17678, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 75, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Add Aura');
INSERT INTO smart_scripts VALUES (17678, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 75, 47114, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Add Aura');
INSERT INTO smart_scripts VALUES (17678, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Remove Flags');
INSERT INTO smart_scripts VALUES (17678, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 17982, 100, 0, 0, 0, 0, 0, 'On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES (17979, 0, 0, 0, 60, 0, 100, 0, 2000, 2000, 15000, 15000, 11, 31611, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
DELETE FROM waypoints WHERE entry=17982;
INSERT INTO waypoints VALUES (17982, 1, -1772.7, -11074.7, 76.9523, 'Demonitiolist Lagoso'),(17982, 2, -1780.08, -11061.4, 77.1293, 'Demonitiolist Lagoso'),(17982, 3, -1789.99, -11051.5, 78.3538, 'Demonitiolist Lagoso'),(17982, 4, -1793.34, -11044.1, 77.0266, 'Demonitiolist Lagoso'),(17982, 5, -1795.92, -11037.5, 75.5467, 'Demonitiolist Lagoso'),(17982, 6, -1805.79, -11027.6, 69.3309, 'Demonitiolist Lagoso'),(17982, 7, -1819.19, -11020.5, 67.1404, 'Demonitiolist Lagoso'),(17982, 8, -1836.67, -11011.1, 67.4923, 'Demonitiolist Lagoso'),(17982, 9, -1857.23, -11000.2, 63.9639, 'Demonitiolist Lagoso'),(17982, 10, -1872.05, -10988.8, 61.4307, 'Demonitiolist Lagoso'),(17982, 11, -1892.17, -10963.1, 61.2231, 'Demonitiolist Lagoso'),(17982, 12, -1913.75, -10935.5, 61.45, 'Demonitiolist Lagoso'),(17982, 13, -1932.05, -10904.4, 62.642, 'Demonitiolist Lagoso'),(17982, 14, -1936.99, -10873.4, 65.4706, 'Demonitiolist Lagoso'),(17982, 15, -1940.16, -10846.8, 71.3138, 'Demonitiolist Lagoso'),(17982, 16, -1930.7, -10829.4, 77.834, 'Demonitiolist Lagoso'),(17982, 17, -1945.47, -10804.3, 86.0572, 'Demonitiolist Lagoso'),
(17982, 18, -1928.73, -10789.8, 90.5643, 'Demonitiolist Lagoso'),(17982, 19, -1905.51, -10778.9, 97.4486, 'Demonitiolist Lagoso'),(17982, 20, -1890.51, -10759.5, 105.225, 'Demonitiolist Lagoso'),(17982, 21, -1884.8, -10735.6, 111.172, 'Demonitiolist Lagoso'),(17982, 22, -1899.74, -10724.5, 112.127, 'Demonitiolist Lagoso'),(17982, 23, -1919.97, -10712.8, 111.345, 'Demonitiolist Lagoso'),(17982, 24, -1939.16, -10697.6, 110.981, 'Demonitiolist Lagoso'),(17982, 25, -1952.36, -10678.4, 110.464, 'Demonitiolist Lagoso'),(17982, 26, -1957.77, -10666.8, 111.074, 'Demonitiolist Lagoso'),(17982, 27, -1957.33, -10656.3, 111.246, 'Demonitiolist Lagoso'),(17982, 28, -1962.13, -10668.2, 111.589, 'Demonitiolist Lagoso'),(17982, 29, -1969.44, -10682.9, 111.712, 'Demonitiolist Lagoso'),(17982, 30, -1987.16, -10698, 115.761, 'Demonitiolist Lagoso'),(17982, 31, -1999.24, -10680.9, 118.553, 'Demonitiolist Lagoso'),(17982, 32, -2015.61, -10658.1, 124.647, 'Demonitiolist Lagoso'),(17982, 33, -2027.06, -10646.5, 132.978, 'Demonitiolist Lagoso'),(17982, 34, -2040.68, -10632, 143.522, 'Demonitiolist Lagoso'),(17982, 35, -2037.14, -10619.7, 146.068, 'Demonitiolist Lagoso'),
(17982, 36, -2025.22, -10608.5, 150.267, 'Demonitiolist Lagoso'),(17982, 37, -2011.31, -10607.3, 155.208, 'Demonitiolist Lagoso'),(17982, 38, -1992.39, -10613.1, 161.93, 'Demonitiolist Lagoso'),(17982, 39, -1974.92, -10614.2, 163.961, 'Demonitiolist Lagoso'),(17982, 40, -1960.7, -10606.2, 165.65, 'Demonitiolist Lagoso'),(17982, 41, -1955.2, -10593.3, 169.77, 'Demonitiolist Lagoso'),(17982, 42, -1947, -10583.5, 173.38, 'Demonitiolist Lagoso'),(17982, 43, -1938.43, -10573.9, 176.35, 'Demonitiolist Lagoso'),(17982, 44, -1922.12, -10574.2, 177.328, 'Demonitiolist Lagoso'),(17982, 45, -1914.39, -10582.9, 178.386, 'Demonitiolist Lagoso'),(17982, 46, -1931.81, -10567.2, 176.996, 'Demonitiolist Lagoso'),(17982, 47, -1947.93, -10560.4, 177.82, 'Demonitiolist Lagoso'),(17982, 48, -1958.11, -10562.9, 177.4, 'Demonitiolist Lagoso'),(17982, 49, -1954.48, -10560.9, 177.537, 'Demonitiolist Lagoso');

-- The Exorcism of Colonel Jules (10935)
REPLACE INTO creature_template_addon VALUES(22431, 0, 0, 0, 4097, 0, '');
REPLACE INTO creature_template_addon VALUES(22432, 0, 0, 0, 4097, 0, '');
REPLACE INTO gossip_menu_option VALUES(8539, 0, 0, "I am ready, Anchorite. Let us begin the exorcism.", 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8539;
INSERT INTO conditions VALUES (15, 8539, 0, 0, 0, 9, 0, 10935, 0, 0, 0, 0, 0, '', 'Show gossip option if player has quest 10935 taken');
DELETE FROM creature_text WHERE entry IN(22431, 22432);
INSERT INTO creature_text VALUES(22431, 0, 0, "It is time. The rite of exorcism will now commence...", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 1, 0, "Prepare yourself. Do not allow the ritual to be interrupted or we may loose our patient...", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 0, "Back, foul beings of darkness! You have no power here!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 1, "The power of light compells you! Back to your pit!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 2, "Be cleansed with Light, human! Let not the demonic corruption overwhelm you.", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 3, "The light is my guide... it is my sustenance!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 4, "I... must not... falter!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 2, 5, "In the name of the Light! It is Light that commands you! It is Light that flung you to the depths of darkness!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22431, 3, 0, "Back! I cast you back... corruptor of faith! Author of pain! Do not return, or suffer the same fate as you did here today!", 12, 0, 100, 0, 0, 0, 0, "Anchorite Barada");
INSERT INTO creature_text VALUES(22432, 0, 0, "Keep away. The fool is mine.", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 0, "No! Not yet! This soul is ours!", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 1, "Give us time... Let the man die... I am no one... I am no one... Fear the anchorite... Fear the anchorite... Barada... Barada.", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 2, "This is fruitless, draenei! You and your little helper cannot wrest control of this pathetic human. He is mine!", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 3, "I will tear your soul into morsels and slow roast them over demon fire.", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 4, "All is lost, Anchorite! Abandon what hope remains.", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
INSERT INTO creature_text VALUES(22432, 1, 5, "I see your ancestors, Anchorite! They writhe and scream in the darkness... they are with us!", 12, 0, 100, 0, 0, 0, 0, "Colonel Jules");
UPDATE creature_template SET AIName='SmartAI', flags_extra=130 WHERE entry=22505;
UPDATE creature_template SET speed_walk=0.5, speed_run=0.5, InhabitType=4, AIName='SmartAI' WHERE entry=22507;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=22431;
UPDATE creature_template SET gossip_menu_id=8554, speed_walk=0.5, speed_run=0.5, InhabitType=4, AIName='SmartAI' WHERE entry=22432;
DELETE FROM smart_scripts WHERE entryorguid IN(22431, 22432, 22505, 22507) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(22431*100, 22432*100, 22432*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (22431, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Byte 0');
INSERT INTO smart_scripts VALUES (22431, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set NPC Flags');
INSERT INTO smart_scripts VALUES (22431, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set React Passive');
INSERT INTO smart_scripts VALUES (22431, 0, 3, 4, 62, 0, 100, 0, 8539, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Store Target');
INSERT INTO smart_scripts VALUES (22431, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 22431*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Script9');
INSERT INTO smart_scripts VALUES (22431*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Regen Health');
INSERT INTO smart_scripts VALUES (22431*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 0');
INSERT INTO smart_scripts VALUES (22431*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flags');
INSERT INTO smart_scripts VALUES (22431*100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -707.68, 2747.8, 101.60, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -710.87, 2747.8, 101.6, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.57, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (22431*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (22431*100, 9, 10, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 0');
INSERT INTO smart_scripts VALUES (22431*100, 9, 11, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 39277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22431*100, 9, 12, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 13, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22431*100, 9, 14, 0, 0, 0, 100, 0, 28000, 28000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 15, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 16, 0, 0, 0, 100, 0, 40000, 40000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 17, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 18, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 19, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 20, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22431*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22431*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 50, 0, 0, 0, 0, 0, 'Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (22431*100, 9, 23, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 50, 0, 0, 0, 0, 0, 'Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (22431*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 50, 0, 0, 0, 0, 0, 'Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (22431*100, 9, 25, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 0');
INSERT INTO smart_scripts VALUES (22431*100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES (22431*100, 9, 27, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -707.68, 2747.8, 101.60, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 28, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -707.211, 2754.11, 101.675, 0, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 29, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.74, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (22431*100, 9, 30, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (22431*100, 9, 31, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES (22431*100, 9, 32, 0, 0, 0, 100, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Regen Health');
INSERT INTO smart_scripts VALUES (22432, 0, 0, 1, 60, 0, 100, 1, 500, 500, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set NPC Flags');
INSERT INTO smart_scripts VALUES (22432, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set React Passive');
INSERT INTO smart_scripts VALUES (22432, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 39283, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22432, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Fly');
INSERT INTO smart_scripts VALUES (22432, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 80, 22432*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES (22432, 0, 5, 6, 40, 0, 100, 0, 2, 0, 0, 0, 54, 70000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Pause WP');
INSERT INTO smart_scripts VALUES (22432, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Set Phase');
INSERT INTO smart_scripts VALUES (22432, 0, 7, 0, 60, 1, 100, 0, 2000, 6000, 3000, 8000, 12, 22507, 2, 60000, 0, 0, 0, 8, 0, 0, 0, -710, 2754.28, 105.3, 4.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (22432, 0, 8, 9, 64, 0, 100, 0, 0, 0, 0, 0, 33, 22432, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Kill Credit');
INSERT INTO smart_scripts VALUES (22432, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 22432*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Script9');
INSERT INTO smart_scripts VALUES (22432*100+1, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES (22432*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 1, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 2, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 53, 0, 22432, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Start WP');
-- INSERT INTO smart_scripts VALUES (22432*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 11, 39284, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 5, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 6, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 7, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 9, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 11, 39295, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 10, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 11, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 12, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 13, 0, 0, 0, 100, 0, 18000, 18000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (22432*100, 9, 14, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
INSERT INTO smart_scripts VALUES (22432*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 39295, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Auras');
INSERT INTO smart_scripts VALUES (22432*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 39284, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Auras');
INSERT INTO smart_scripts VALUES (22432*100, 9, 17, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove All Auras');
INSERT INTO smart_scripts VALUES (22432*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 39283, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (22432*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flags');
INSERT INTO smart_scripts VALUES (22507, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set React State');
INSERT INTO smart_scripts VALUES (22507, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 39303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22507, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 40, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Set Fly');
INSERT INTO smart_scripts VALUES (22507, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 22507, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Start WP');
INSERT INTO smart_scripts VALUES (22507, 0, 4, 0, 60, 0, 100, 0, 3000, 6000, 5000, 8000, 11, 39320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22507, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 39307, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell');
INSERT INTO smart_scripts VALUES (22505, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 11, 39300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22505, 0, 1, 0, 60, 0, 100, 0, 5000, 10000, 15000, 30000, 12, 22506, 2, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Summon Creature');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=39371;
INSERT INTO conditions VALUES (17, 0, 39371, 0, 0, 31, 1, 3, 22431, 0, 0, 12, 0, '', 'Requires Barada');
INSERT INTO conditions VALUES (17, 0, 39371, 0, 1, 31, 1, 3, 22507, 0, 0, 12, 0, '', 'Requires Darkness Released');
DELETE FROM spell_script_names WHERE spell_id=39371;
INSERT INTO spell_script_names VALUES(39371, "spell_q10935_the_exorcism_of_colonel_jules");
DELETE FROM waypoints WHERE entry IN(22432, 22507);
INSERT INTO waypoints VALUES (22432, 1, -709.65, 2753.99, 103.5, 'Colonel Jules'),(22432, 2, -710.557, 2753.94, 103.5, 'Colonel Jules'),(22432, 3, -711.909, 2750.3, 104.14, 'Colonel Jules'),(22432, 4, -713.904, 2746.49, 104.331, 'Colonel Jules'),(22432, 5, -711.184, 2742.27, 103.904, 'Colonel Jules'),(22432, 6, -708.22, 2742.91, 103.904, 'Colonel Jules'),(22432, 7, -708.57, 2748.6, 105.099, 'Colonel Jules'),(22432, 8, -711.74, 2752.01, 106.086, 'Colonel Jules'),(22432, 9, -714.274, 2749.76, 105.396, 'Colonel Jules'),(22432, 10, -713.429, 2744.81, 104.753, 'Colonel Jules'),(22432, 11, -709.864, 2745.16, 104.659, 'Colonel Jules'),(22432, 12, -709.463, 2751.23, 106.032, 'Colonel Jules'),(22432, 13, -713.553, 2748.7, 105.051, 'Colonel Jules'),(22432, 14, -713.526, 2746.73, 104.833, 'Colonel Jules'),(22432, 15, -711.496, 2743.84, 104.833, 'Colonel Jules'),(22432, 16, -714.383, 2746.02, 104.647, 'Colonel Jules'),
(22432, 17, -714.456, 2749.98, 104.089, 'Colonel Jules'),(22432, 18, -710.608, 2750.5, 103.973, 'Colonel Jules'),(22432, 19, -707.983, 2747.36, 104.798, 'Colonel Jules'),(22432, 20, -710.613, 2744.9, 104.477, 'Colonel Jules'),(22432, 21, -714.8, 2745.95, 104.101, 'Colonel Jules'),(22432, 22, -714.631, 2748.01, 104.43, 'Colonel Jules'),(22432, 23, -711.024, 2750.26, 103.991, 'Colonel Jules'),(22432, 24, -707.63, 2748.21, 104.214, 'Colonel Jules'),(22432, 25, -708.827, 2745.44, 104.154, 'Colonel Jules'),(22432, 26, -711.388, 2742.96, 103.953, 'Colonel Jules'),(22432, 27, -714.002, 2745.32, 103.913, 'Colonel Jules'),(22432, 28, -714.457, 2749.44, 103.033, 'Colonel Jules'),(22432, 29, -713.108, 2751.62, 103.678, 'Colonel Jules'),(22432, 30, -708.345, 2750.1, 103.533, 'Colonel Jules'),(22432, 31, -707.695, 2747.56, 103.752, 'Colonel Jules'),(22432, 32, -709.438, 2743.11, 104.164, 'Colonel Jules'),(22432, 33, -712.881, 2743.51, 105.306, 'Colonel Jules'),
(22432, 34, -713.839, 2747.58, 105.144, 'Colonel Jules'),(22432, 35, -712.62, 2751.28, 105.144, 'Colonel Jules'),(22432, 36, -709.074, 2751.49, 105.238, 'Colonel Jules'),(22432, 37, -708.597, 2747.29, 105.812, 'Colonel Jules'),(22432, 38, -712.156, 2745.36, 105.812, 'Colonel Jules'),(22432, 39, -708.514, 2743.51, 105.116, 'Colonel Jules'),(22432, 40, -707.708, 2747.04, 104.76, 'Colonel Jules'),(22432, 41, -710.911, 2751.85, 104.267, 'Colonel Jules'),
(22432, 42, -714.12, 2749.66, 103.384, 'Colonel Jules'),(22432, 43, -713.635, 2744.45, 103.595, 'Colonel Jules'),(22432, 44, -710.211, 2754.36, 102.367, 'Colonel Jules'),
(22507, 1, -711.317, 2748.46, 104.93, 'Darkness Released'),(22507, 2, -713.449, 2745.72, 105.2, 'Darkness Released'),(22507, 3, -712.575, 2743.63, 104.704, 'Darkness Released'),(22507, 4, -709.914, 2743.95, 104.46, 'Darkness Released'),(22507, 5, -708.159, 2747.59, 104.885, 'Darkness Released'),(22507, 6, -708.617, 2750.27, 105.226, 'Darkness Released');

-- The Multiphase Survey (11880)
UPDATE creature_template SET modelid1=23489, modelid2=0, AIName='SmartAI' WHERE entry=25882;
DELETE FROM smart_scripts WHERE entryorguid=25882 AND source_type=0;
INSERT INTO smart_scripts VALUES (25882, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 11, 46804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Multiphase Disturbance - On Respawn - Cast Dark Fire Shield State");
INSERT INTO smart_scripts VALUES (25882, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 46272, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Multiphase Disturbance - On Respawn - Cast Oshu'gun Cloud Invisibility");
INSERT INTO smart_scripts VALUES (25882, 0, 2, 3, 8, 0, 100, 0, 46281, 0, 0, 0, 33, 25882, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Multiphase Disturbance - On Spell Hit ''Take Multiphase Reading'' - Give Quest Credit');
INSERT INTO smart_scripts VALUES (25882, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Multiphase Disturbance - On Spell Hit - Despawn");

-- Ruse of the Ashtongue (10946)
UPDATE quest_template SET SpecialFlags=2 WHERE Id=10946;

-- The Eagle's Essence (10990)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8615;
INSERT INTO conditions VALUES(15, 8615, 0, 0, 0, 14, 0, 10990, 0, 0, 1, 0, 0, '', 'Requires first quest with whistle');
DELETE FROM gossip_menu_option WHERE menu_id=8615;
INSERT INTO gossip_menu_option VALUES(8615, 0, 0, "I've lost my Whistle.", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=22924 AND source_type=0 AND id IN(1, 2);
INSERT INTO smart_scripts VALUES (22924, 0, 1, 2, 62, 0, 100, 0, 8615, 0, 0, 0, 56, 32657, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (22924, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- Gurok the Usurper (9853)
DELETE FROM event_scripts WHERE id=11420;
INSERT INTO event_scripts VALUES (11420, 0, 10, 18182, 3000000, 0, -879.8, 8691, 252.5, 0.9);

-- A Fel Whip For Gahk (11079)
DELETE FROM spell_script_names WHERE spell_id IN(40962);
UPDATE creature_template SET faction=90, dmg_multiplier=4.7 WHERE entry IN(23353, 23354, 22281, 23355);

-- Divination: Gorefiend's Cloak (10635)
-- Divination: Gorefiend's Truncheon (10636)
UPDATE creature_template SET faction=14, AIName='SmartAI' WHERE entry IN(21784, 21815);
DELETE FROM smart_scripts WHERE entryorguid IN(21784, 21815) AND source_type=0;
INSERT INTO smart_scripts VALUES (21815, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 37497, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - On OOC Update - Cast Shadowmoon Ghost Invisibility');
INSERT INTO smart_scripts VALUES (21784, 0, 0, 0, 1, 0, 100, 1, 500, 500, 0, 0, 11, 37497, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostrider of Karabor - On OOC Update - Cast Shadowmoon Ghost Invisibility');

-- Divination: Gorefiend's Armor (10634)
UPDATE smart_scripts SET action_param1=37497 WHERE entryorguid=21801 AND id=1;

-- Unstable Mana Crystals (8463)
UPDATE gameobject_template SET data7=0 WHERE entry=180600;

-- Battle of Hillsbrad (14351)
UPDATE quest_template SET PrevQuestId=541 WHERE Id=14351;

-- The Twin Ziggurats (9176)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=28516;
INSERT INTO conditions VALUES (17, 0, 28516, 0, 0, 31, 1, 3, 16329, 0, 0, 0, 0, '', '');

-- Fel Spirits (10909)
DELETE FROM disables WHERE sourceType=0 AND entry=34368;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=39184;
INSERT INTO conditions VALUES(13, 1, 39184, 0, 0, 31, 0, 3, 16878, 0, 0, 0, 0, '', 'Requires Shattered Hand Berserker');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=22444;
DELETE FROM smart_scripts WHERE entryorguid=22444 AND source_type=0;
INSERT INTO smart_scripts VALUES (22444, 0, 0, 0, 60, 0, 100, 0, 500, 500, 6000, 6000, 11, 39184, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Relic Bunny - On Update - Cast Anchorite Contrition');
INSERT INTO smart_scripts VALUES (22444, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Relic Bunny - On Reset - Disable Melee');
INSERT INTO smart_scripts VALUES (22444, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Relic Bunny - On Reset - Disable Combat Movement');

-- Stopping the Spread (9874)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=18240);
INSERT INTO creature_addon (SELECT guid, 0, 0, 0, 4097, 383, '' FROM creature WHERE position_z < -25 AND id=18240);
UPDATE creature_template SET InhabitType=7, AIName='NullCreatureAI', ScriptName='' WHERE entry=18240;
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=32146;
INSERT INTO conditions VALUES(13, 1, 32146, 0, 0, 31, 0, 3, 18240, 0, 0, 0, 0, '', 'Requires Sunspring Villager');
DELETE FROM smart_scripts WHERE entryorguid=18240 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(SELECT -guid FROM creature WHERE id=18240) AND source_type=0;

-- Natural Remedies (10351)
DELETE FROM event_scripts WHERE id=13256;
DELETE FROM creature_text WHERE entry=21504 AND groupid IN(20, 21, 22, 23);
INSERT INTO creature_text VALUES (21504, 20, 0, "And just what do you think you are doing? You dare to interfere with my master's experiment? ", 12, 0, 100, 0, 0, 0, 0, "Pathaleon the Calculator's Image");
INSERT INTO creature_text VALUES (21504, 21, 0, "Do you like what we've done here? Perhaps we will drop these crystals from the sky all over Outland.", 12, 0, 100, 0, 0, 0, 0, "Pathaleon the Calculator's Image");
INSERT INTO creature_text VALUES (21504, 22, 0, "I grow bored with your attempt to heal the land and quell the energies summoning and driving the colossi mad. Goliathon, King of the Colossi, Prince Kael'thas and I demand that you defend the crystal!", 12, 0, 100, 0, 0, 0, 0, "Pathaleon the Calculator's Image");
INSERT INTO creature_text VALUES (21504, 23, 0, "We will meet again soon.", 12, 0, 100, 0, 0, 0, 0, "Pathaleon the Calculator's Image");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20781;
DELETE FROM smart_scripts WHERE entryorguid=20781 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=20781*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (20781, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawned - Set Phase');
INSERT INTO smart_scripts VALUES (20781, 0, 1, 2, 8, 1, 100, 0, 35413, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Phase');
INSERT INTO smart_scripts VALUES (20781, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 20781*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Start Script');
INSERT INTO smart_scripts VALUES (20781*100, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 20617, 80, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (20781*100, 9, 1, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 86, 35468, 0, 10, 72893, 20617, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast Spell Entangling Roots Visual');
INSERT INTO smart_scripts VALUES (20781*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 21504, 3, 80000, 0, 0, 0, 8, 0, 0, 0, 127.82, 4835.76, 75.92, 6.15, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20781*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 86, 34776, 2, 19, 21504, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast');
INSERT INTO smart_scripts VALUES (20781*100, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 20, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20781*100, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 86, 35471, 2, 10, 72891, 20617, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast Spell Insect Swarm');
INSERT INTO smart_scripts VALUES (20781*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 21, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20781*100, 9, 7, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 86, 32783, 2, 19, 21504, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast');
INSERT INTO smart_scripts VALUES (20781*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 22, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20781*100, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 28, 32783, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Remove Aura 32783');
INSERT INTO smart_scripts VALUES (20781*100, 9, 10, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 86, 34776, 2, 19, 21504, 50, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cross Cast');
INSERT INTO smart_scripts VALUES (20781*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 23, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (20781*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 19, 21504, 50, 0, 0, 0, 0, 0, 'Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (20781*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 19305, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 114.35, 4841.9, 76.2, 5.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (20781*100, 9, 14, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 20617, 80, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (20781*100, 9, 15, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20617;
DELETE FROM smart_scripts WHERE entryorguid=20617 AND source_type=0;
INSERT INTO smart_scripts VALUES (20617, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (20617, 0, 1, 3, 38, 0, 100, 0, 2, 2, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Phase');
INSERT INTO smart_scripts VALUES (20617, 0, 2, 0, 60, 1, 100, 0, 0, 0, 2500, 2500, 11, 35487, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (20617, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Remove all auras');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19305;
DELETE FROM smart_scripts WHERE entryorguid=19305 AND source_type=0;
INSERT INTO smart_scripts VALUES (19305, 0, 2, 0, 0, 0, 50, 0, 9000, 9000, 10000, 10000, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Goliathon - In Combat - Cast 'Trample' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 0, 0, 0, 0, 50, 0, 6000, 6000, 10000, 10000, 11, 32959, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Goliathon - In Combat - Cast 'Knock Away' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 1, 0, 0, 0, 50, 0, 8000, 8000, 10000, 10000, 11, 33688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Goliathon - In Combat - Cast 'Crystal Strike' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 3, 0, 2, 0, 100, 1, 0, 90, 0, 0, 11, 33904, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goliathon - Between 0-90% Health - Cast 'Summon Goliathon Shardling' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 4, 0, 2, 0, 100, 1, 0, 60, 0, 0, 11, 33905, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goliathon - Between 0-60% Health - Cast 'Summon Goliathon Shardling' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 5, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 33906, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goliathon - Between 0-30% Health - Cast 'Summon Goliathon Shardling' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 6, 7, 60, 0, 100, 1, 200, 200, 0, 0, 11, 34776, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Goliathon - On Update - Cast 'Teleport' (No Repeat)");
INSERT INTO smart_scripts VALUES (19305, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, "Goliathon - On Update - Attack Start");

-- Thwart the Dark Conclave (10808)
UPDATE creature SET position_z=55 WHERE id=22139;
UPDATE gameobject_template SET data1=100 WHERE entry=184750;
REPLACE INTO creature_template_addon VALUES (22137, 0, 0, 0, 4097, 0, '38457');
UPDATE creature_template SET scale=8, InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=22139;
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19305;
DELETE FROM smart_scripts WHERE entryorguid IN(22138, 22139) AND source_type=0;
INSERT INTO smart_scripts VALUES (22138, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 20000, 20000, 11, 38469, 0, 0, 0, 0, 0, 19, 22139, 0, 0, 0, 0, 0, 0, "Dark Conclave Ritualist - Out of Combat - Cast 'Dark Conclave Ritualist Channel'");
INSERT INTO smart_scripts VALUES (22139, 0, 0, 1, 8, 0, 100, 0, 38482, 0, 0, 0, 33, 22137, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Kill Credit");
INSERT INTO smart_scripts VALUES (22139, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 19, 22146, 50, 0, 0, 0, 0, 0, "On Spell Hit - Despawn");
INSERT INTO smart_scripts VALUES (22139, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 19, 22137, 50, 0, 0, 0, 0, 0, "On Spell Hit - Despawn");
INSERT INTO smart_scripts VALUES (22139, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Spell Hit - Despawn");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(38469, 38482);
INSERT INTO conditions VALUES(13, 1, 38469, 0, 0, 31, 0, 3, 22139, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 38482, 0, 0, 31, 0, 3, 22139, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=38482;
INSERT INTO conditions VALUES(17, 0, 38482, 0, 0, 29, 0, 22138, 50, 0, 1, 0, 0, '', 'No creatures in range');

-- Catch and Release (9629)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=17326;
DELETE FROM smart_scripts WHERE entryorguid=17326 AND source_type=0;
INSERT INTO smart_scripts VALUES (17326, 0, 0, 0, 8, 0, 100, 0, 30877, 0, 0, 0, 33, 17654, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, "Blacksilt Scout - On Spellhit - Give Quest Credit");

-- Help Tavara (9586)
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid=17551 AND source_type=0;

-- Building a Perimeter (10240)
UPDATE smart_scripts SET event_flags=0 WHERE entryorguid IN(19866, 19867, 19868) AND source_type=0;

-- Captain Tyralius (10422)
UPDATE creature SET spawntimesecs=170 WHERE id=20787;
UPDATE gameobject_template SET data2=180000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry=184588;
DELETE FROM smart_scripts WHERE entryorguid=184588 AND source_type=1;
INSERT INTO smart_scripts VALUES (184588, 1, 0, 1, 8, 0, 100, 0, 35707, 0, 0, 0, 33, 20787, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Kill Credit');
INSERT INTO smart_scripts VALUES (184588, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 20787, 10, 0, 0, 0, 0, 0, 'On Spell Hit - Talk');
INSERT INTO smart_scripts VALUES (184588, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 19, 20787, 10, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn Target');

-- Ethereum Secrets (10971)
UPDATE gameobject_template SET data2=180000 WHERE entry IN(184418, 184419, 184420, 184421, 184422, 184423, 184424, 184425, 184426 ,184427, 184428, 184429, 184430, 184431);
REPLACE INTO disables VALUES(0, 39456, 64, '', '', ''); -- Disable LOS
REPLACE INTO disables VALUES(0, 39457, 64, '', '', ''); -- Disable LOS
REPLACE INTO disables VALUES(0, 39460, 64, '', '', ''); -- Disable LOS
REPLACE INTO disables VALUES(0, 39474, 64, '', '', ''); -- Disable LOS
REPLACE INTO disables VALUES(0, 39475, 64, '', '', ''); -- Disable LOS
REPLACE INTO disables VALUES(0, 39476, 64, '', '', ''); -- Disable LOS

-- Becoming a Shadoweave Tailor (10833)
UPDATE creature_template SET flags_extra=130, AIName='SmartAI' WHERE entry=22395;
DELETE FROM smart_scripts WHERE entryorguid =22395 AND source_type=0;
INSERT INTO smart_scripts VALUES (22395, 0, 0, 0, 8, 0, 100, 0, 39094, 0, 0, 0, 33, 22395, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, '[PH]Altar of Shadows target - On Spell Hit - Kill Credit');

-- Fhwoor Smash! (9729)
DELETE FROM creature_text WHERE entry=17877;
INSERT INTO creature_text VALUES (17877, 0, 0, 'Fhwoor go now, $N. Get ark, come back.', 12, 0, 100, 0, 0, 0, 0, 'Fhwoor');
INSERT INTO creature_text VALUES (17877, 1, 0, 'Take moment... Get ready.', 12, 0, 100, 0, 0, 0, 0, 'Fhwoor');
INSERT INTO creature_text VALUES (17877, 2, 0, 'Uh oh...', 12, 0, 100, 0, 0, 0, 0, 'Fhwoor');
INSERT INTO creature_text VALUES (17877, 3, 0, 'Fhwoor do good!', 12, 0, 100, 0, 0, 0, 0, 'Fhwoor');
DELETE FROM waypoints WHERE entry=17877;
INSERT INTO waypoints VALUES (17877, 1, 231.403, 8479.94, 17.9319, 'Fhwoor'),(17877, 2, 215.654, 8469.71, 22.7522, 'Fhwoor'),(17877, 3, 207.395, 8459.58, 25.083, 'Fhwoor'),(17877, 4, 197.541, 8444.16, 24.9263, 'Fhwoor'),(17877, 5, 188.792, 8428.69, 22.4734, 'Fhwoor'),(17877, 6, 183.095, 8419.25, 23.4617, 'Fhwoor'),(17877, 7, 170.883, 8406.63, 21.95, 'Fhwoor'),(17877, 8, 167.028, 8394.64, 23.6626, 'Fhwoor'),(17877, 9, 168.177, 8383.75, 20.5654, 'Fhwoor'),(17877, 10, 171.686, 8359.03, 19.8141, 'Fhwoor'),(17877, 11, 177.082, 8326.46, 20.7596, 'Fhwoor'),(17877, 12, 170.066, 8301.61, 20.8413, 'Fhwoor'),(17877, 13, 174.167, 8290.19, 18.5382, 'Fhwoor'),(17877, 14, 192.921, 8262.22, 18.615, 'Fhwoor'),(17877, 15, 211.22, 8245.58, 22.2009, 'Fhwoor'),(17877, 16, 226.538, 8231.74, 20.0313, 'Fhwoor'),(17877, 17, 239.977, 8219.84, 20.8419, 'Fhwoor'),(17877, 18, 252.502, 8210.68, 18.7755, 'Fhwoor'),(17877, 19, 271.605, 8205.75, 19.6679, 'Fhwoor'),
(17877, 20, 283.234, 8202.8, 22.1166, 'Fhwoor'),(17877, 21, 318.232, 8180.02, 18.1585, 'Fhwoor'),(17877, 22, 335.458, 8177.15, 18.1603, 'Fhwoor'),(17877, 23, 352.245, 8180.53, 18.4126, 'Fhwoor'),(17877, 24, 367.487, 8185.88, 22.213, 'Fhwoor'),(17877, 25, 376.03, 8188.09, 23.8872, 'Fhwoor'),(17877, 26, 387.559, 8188.89, 21.8357, 'Fhwoor'),(17877, 27, 399.78, 8183.96, 18.2193, 'Fhwoor'),(17877, 28, 413.746, 8171.34, 18.2933, 'Fhwoor'),(17877, 29, 426.026, 8158.55, 19.1386, 'Fhwoor'),(17877, 30, 444.048, 8152.09, 23.3402, 'Fhwoor'),(17877, 31, 465.283, 8151.99, 22.213, 'Fhwoor'),(17877, 32, 482.497, 8150.01, 20.1239, 'Fhwoor'),(17877, 33, 521.832, 8154.16, 22.3108, 'Fhwoor'),(17877, 34, 558.243, 8158.7, 23.6964, 'Fhwoor'),(17877, 35, 550.27, 8161.78, 22.9976, 'Fhwoor'),(17877, 36, 533.254, 8141.06, 22.2215, 'Fhwoor'),(17877, 37, 505.911, 8135.08, 19.9296, 'Fhwoor'),(17877, 38, 473.615, 8128.02, 22.5122, 'Fhwoor'),(17877, 39, 445.697, 8128.57, 20.4449, 'Fhwoor'),
(17877, 40, 399.292, 8123.93, 18.1522, 'Fhwoor'),(17877, 41, 363.179, 8107.19, 18.4227, 'Fhwoor'),(17877, 42, 343.39, 8108.69, 17.3774, 'Fhwoor'),(17877, 43, 327.772, 8134.22, 18.3628, 'Fhwoor'),(17877, 44, 313.609, 8144.49, 21.2908, 'Fhwoor'),(17877, 45, 295.733, 8153.19, 18.3259, 'Fhwoor'),(17877, 46, 255.729, 8172.25, 17.3989, 'Fhwoor'),(17877, 47, 242.091, 8178.74, 17.9129, 'Fhwoor'),(17877, 48, 220.303, 8182.56, 19.5001, 'Fhwoor'),(17877, 49, 206, 8202.45, 22.1064, 'Fhwoor'),(17877, 50, 203.072, 8224.38, 25.2776, 'Fhwoor'),(17877, 51, 200.892, 8237.23, 24.2757, 'Fhwoor'),(17877, 52, 198.027, 8254.11, 19.9855, 'Fhwoor'),(17877, 53, 176.841, 8285.87, 18.7444, 'Fhwoor'),(17877, 54, 178.973, 8300.77, 18.6603, 'Fhwoor'),(17877, 55, 181.472, 8318.23, 21.679, 'Fhwoor'),(17877, 56, 184.381, 8335.63, 18.9092, 'Fhwoor'),(17877, 57, 176.647, 8349.99, 18.6098, 'Fhwoor'),(17877, 58, 173.367, 8370.8, 18.0483, 'Fhwoor'),(17877, 59, 185.332, 8389.98, 18.5659, 'Fhwoor'),
(17877, 60, 200.3, 8408.49, 18.8142, 'Fhwoor'),(17877, 61, 219.306, 8431.98, 20.4219, 'Fhwoor'),(17877, 62, 227.407, 8442, 22.7788, 'Fhwoor'),(17877, 63, 229.474, 8466.41, 18.564, 'Fhwoor'),(17877, 64, 236.484, 8479.62, 18.1411, 'Fhwoor'),(17877, 65, 246.831, 8482.4, 22.1621, 'Fhwoor'),(17877, 66, 231.403, 8479.94, 17.9319, 'Fhwoor');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=17877;
DELETE FROM smart_scripts WHERE entryorguid=17877 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=17877*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (17877, 0, 0, 1, 19, 0, 100, 0, 9729, 0, 0, 0, 53, 1, 17877, 0, 9729, 5000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On Quest Start - WP Start');
INSERT INTO smart_scripts VALUES (17877, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On Quest Start - Talk');
INSERT INTO smart_scripts VALUES (17877, 0, 2, 0, 40, 0, 100, 0, 1, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (17877, 0, 3, 4, 40, 0, 100, 0, 20, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (17877, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17877, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Set Walk');
INSERT INTO smart_scripts VALUES (17877, 0, 6, 0, 40, 0, 100, 0, 34, 0, 0, 0, 54, 13000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (17877, 0, 7, 8, 40, 0, 100, 0, 48, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (17877, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17877, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Set Run');
INSERT INTO smart_scripts VALUES (17877, 0, 10, 11, 40, 0, 100, 0, 65, 0, 0, 0, 54, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (17877, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Set Walk');
INSERT INTO smart_scripts VALUES (17877, 0, 12, 13, 40, 0, 100, 0, 66, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Set Orientation');
INSERT INTO smart_scripts VALUES (17877, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Set Run');
INSERT INTO smart_scripts VALUES (17877, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (17877, 0, 15, 0, 56, 0, 100, 0, 34, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 182082, 20, 0, 0, 0, 0, 0, 'Fhwoor - On WP Resumed - Set Loot State');
INSERT INTO smart_scripts VALUES (17877, 0, 16, 0, 56, 0, 100, 0, 65, 0, 0, 0, 50, 182082, 60, 0, 0, 0, 0, 8, 0, 0, 0, 252.56, 8479.38, 22.975, 0, 'Fhwoor - On WP Resumed - Summon GO');
INSERT INTO smart_scripts VALUES (17877, 0, 17, 0, 0, 0, 100, 0, 4000, 7000, 10000, 20000, 11, 31277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - In Combat - Cast Stomp');
INSERT INTO smart_scripts VALUES (17877, 0, 18, 0, 0, 0, 100, 0, 11000, 12000, 15000, 25000, 11, 31964, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fhwoor - In Combat - Cast Thundershock');

-- A Lesson Learned (10515)
UPDATE gameobject_template SET data3=60000 WHERE entry=184684;

-- A Distraction for Akama (10985)
-- A Distraction for Akama (13429)
DELETE FROM spell_script_names WHERE spell_id IN(39832);
INSERT INTO spell_script_names VALUES(39832, 'spell_q10985_light_of_the_naaru');
DELETE FROM creature_text WHERE entry IN(18528, 22861, 22863, 22864, 23152, 22989, 22990);
INSERT INTO creature_text VALUES (18528, 0, 0, "Xi'ri falls silent and a quiet tension falls over nearby Sha'tar forces as Xi'ri makes his decision.", 16, 0, 100, 0, 0, 0, 0, "Xi'ri");
INSERT INTO creature_text VALUES (18528, 1, 0, "Xi'ri begins channeling the powers of the light.", 16, 0, 100, 0, 0, 0, 0, "Xi'ri");
INSERT INTO creature_text VALUES (22864, 0, 0, "Onward, Scryers! Show Illidan's lackeys the temper of our steel!", 14, 0, 100, 0, 0, 0, 0, "Fyra Dawnstar");
INSERT INTO creature_text VALUES (22863, 0, 0, "Come closer, demon! Death awaits!", 12, 0, 100, 0, 0, 0, 0, "Seasoned Magister");
INSERT INTO creature_text VALUES (22863, 0, 1, "Illidan's lapdogs! Destroy them all!", 12, 0, 100, 0, 0, 0, 0, "Seasoned Magister");
INSERT INTO creature_text VALUES (22863, 0, 2, "I've a message for your master, scum!", 12, 0, 100, 0, 0, 0, 0, "Seasoned Magister");
INSERT INTO creature_text VALUES (22861, 0, 0, "Come closer, demon! Death awaits!", 12, 0, 100, 0, 0, 0, 0, "Lightsworn Vindicator");
INSERT INTO creature_text VALUES (22861, 0, 1, "Illidan's lapdogs! Destroy them all!", 12, 0, 100, 0, 0, 0, 0, "Lightsworn Vindicator");
INSERT INTO creature_text VALUES (22861, 0, 2, "I've a message for your master, scum!", 12, 0, 100, 0, 0, 0, 0, "Lightsworn Vindicator");
INSERT INTO creature_text VALUES (23152, 0, 0, "Pitiful wretches. You dared invade Illidan's temple? Very well, I shall make it your death bed!", 14, 0, 100, 0, 0, 0, 0, "Vagath");
INSERT INTO creature_text VALUES (23152, 1, 0, "You've sealed you fate, Akama. The Master will learn from your betrayal!", 14, 0, 100, 0, 0, 0, 0, "Vagath");
INSERT INTO creature_text VALUES (22989, 0, 0, "I've waited for this moment for years. Illidan and his lapdogs will be destroyed!", 14, 0, 100, 0, 0, 0, 0, "Maiev");
INSERT INTO creature_text VALUES (22989, 1, 0, "Maiev Shadowsong slips into the shadows discretly as Akama's attention shifts towards Vagath's last words.", 16, 0, 100, 0, 0, 0, 0, "Maiev");
INSERT INTO creature_text VALUES (22990, 0, 0, "Now is the time, Maiev! Unleash your wrath!", 14, 0, 100, 0, 0, 0, 0, "Akama");
INSERT INTO creature_text VALUES (22990, 1, 0, "Slay all who see us! Word must not get back to Illidan.", 14, 0, 100, 0, 0, 0, 0, "Akama");
INSERT INTO creature_text VALUES (22990, 2, 0, "Akama has no master, not anymore.", 14, 0, 100, 0, 0, 0, 0, "Akama");
INSERT INTO creature_text VALUES (22990, 3, 0, "Our plans are in danger already. It appears Maiev's decided to do things her own way.", 12, 0, 100, 0, 0, 0, 0, "Akama");
INSERT INTO creature_text VALUES (22990, 3, 1, "We must carry on with or without Maiev. Inside! Quickly!", 12, 0, 100, 0, 0, 0, 0, "Akama");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(8650);
INSERT INTO conditions VALUES(15, 8650, 0, 0, 0, 9, 0, 10985, 0, 0, 0, 0, 0, '', 'Requires A Distraction for Akama');
INSERT INTO conditions VALUES(15, 8650, 0, 0, 1, 9, 0, 13429, 0, 0, 0, 0, 0, '', 'Requires A Distraction for Akama');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (39831, 39832);
INSERT INTO conditions VALUES(13, 3, 39831, 0, 0, 31, 0, 3, 0, 0, 0, 0, 0, '', 'Target any NPC');
INSERT INTO conditions VALUES(13, 3, 39831, 0, 0, 31, 0, 3, 18528, 0, 1, 0, 0, '', 'Target not xiri');
INSERT INTO conditions VALUES(13, 3, 39831, 0, 0, 34, 0, 1, 248, 0, 0, 0, 0, '', 'Target Friendly Units');
INSERT INTO conditions VALUES(13, 3, 39832, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Target any Player');
DELETE FROM gossip_menu_option WHERE menu_id=8650;
INSERT INTO gossip_menu_option VALUES (8650, 0, 0, "I am ready to join your forces in battle, Xi'ri.", 1, 1, 0, 0, 0, 0, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18528;
DELETE FROM smart_scripts WHERE entryorguid=18528 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=18528*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (18528, 0, 0, 0, 62, 0, 100, 0, 8650, 0, 0, 0, 80, 18528*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - On Gossip Select - Script9');
INSERT INTO smart_scripts VALUES (18528*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Set Active');
INSERT INTO smart_scripts VALUES (18528*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Set NPC flag');
INSERT INTO smart_scripts VALUES (18528*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Talk 0');
INSERT INTO smart_scripts VALUES (18528*100, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Talk 1');
INSERT INTO smart_scripts VALUES (18528*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 39828, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (18528*100, 9, 5, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 11, 39831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (18528*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 39832, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (18528*100, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (18528*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 3, 33, 0, 0, 0, 0, 11, 0, 150, 0, 0, 0, 0, 0, 'Xiri - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (18528*100, 9, 9, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Summon Creature Group');
INSERT INTO smart_scripts VALUES (18528*100, 9, 10, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 11, 39831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (18528*100, 9, 11, 0, 0, 0, 100, 0, 80000, 80000, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Set NPC flag');
INSERT INTO smart_scripts VALUES (18528*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Xiri - Script9 - Set Active');
UPDATE creature_template SET faction=1843, AIName='SmartAI', ScriptName='' WHERE entry IN(22857, 22988, 23152);
DELETE FROM smart_scripts WHERE entryorguid IN(22857, 22988, 23152) AND source_type=0;
INSERT INTO smart_scripts VALUES (22857, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 10000, 12000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22857, 0, 1, 0, 13, 0, 100, 0, 20000, 25000, 0, 0, 11, 32009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Victim Spell Cast - Cast Spell');
INSERT INTO smart_scripts VALUES (22857, 0, 2, 0, 0, 0, 100, 0, 1000, 20000, 30000, 30000, 11, 16244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22988, 0, 0, 0, 0, 0, 100, 0, 2000, 14000, 12000, 20000, 11, 39942, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22988, 0, 1, 0, 0, 0, 100, 0, 10000, 25000, 40000, 70000, 11, 12098, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22988, 0, 2, 0, 0, 0, 100, 0, 1000, 20000, 30000, 30000, 11, 39941, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23152, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 8000, 10000, 11, 39942, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23152, 0, 1, 0, 0, 0, 100, 0, 10000, 25000, 40000, 70000, 11, 12098, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (23152, 0, 2, 0, 0, 0, 100, 0, 1000, 20000, 30000, 30000, 11, 39941, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(22861, 22863);
DELETE FROM smart_scripts WHERE entryorguid IN(22861, 22863) AND source_type=0;
INSERT INTO smart_scripts VALUES (22861, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Enter Combat - Talk');
INSERT INTO smart_scripts VALUES (22861, 0, 1, 0, 0, 0, 100, 0, 2000, 4000, 10000, 12000, 11, 33632, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22861, 0, 2, 0, 0, 0, 100, 0, 10000, 15000, 60000, 62000, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22861, 0, 3, 0, 38, 0, 100, 0, 3, 33, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 22857, 30, 0, 0, 0, 0, 0, 'On Data Set - Attack Start');
INSERT INTO smart_scripts VALUES (22863, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Enter Combat - Talk');
INSERT INTO smart_scripts VALUES (22863, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3000, 3000, 11, 9053, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22863, 0, 2, 0, 38, 0, 100, 0, 3, 33, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 22857, 30, 0, 0, 0, 0, 0, 'On Data Set - Attack Start');
UPDATE creature_template SET exp=1, scale=1, npcflag=0, faction=1858, dmg_multiplier=20, AIName='SmartAI' WHERE entry=22990;
UPDATE creature_template SET faction=1867, dmg_multiplier=20, AIName='SmartAI' WHERE entry=22989;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=21701;
DELETE FROM smart_scripts WHERE entryorguid IN(22989, 22990, 21701) AND source_type=0;
INSERT INTO smart_scripts VALUES (21701, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 46, 80, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Move Forward');
INSERT INTO smart_scripts VALUES (21701, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 29, 3, 10, 0, 0, 0, 0, 19, 22990, 50, 0, 0, 0, 0, 0, 'On Data Set - Set Follow');
INSERT INTO smart_scripts VALUES (21701, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Movement Inform - Despawn');
INSERT INTO smart_scripts VALUES (22989, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 46, 80, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Move Forward');
INSERT INTO smart_scripts VALUES (22989, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 29, 2, 2, 0, 0, 0, 0, 19, 22990, 50, 0, 0, 0, 0, 0, 'On Data Set - Set Follow');
INSERT INTO smart_scripts VALUES (22989, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Movement Inform - Despawn');
INSERT INTO smart_scripts VALUES (22989, 0, 3, 0, 0, 0, 100, 0, 4000, 6000, 10000, 15000, 11, 39954, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22990, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 53, 1, 22990, 0, 0, 1000, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - WP Start');
INSERT INTO smart_scripts VALUES (22990, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Talk');
INSERT INTO smart_scripts VALUES (22990, 0, 2, 15, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 21701, 100, 0, 0, 0, 0, 0, 'On AI Init - Set Data');
INSERT INTO smart_scripts VALUES (22990, 0, 3, 2, 40, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 22989, 30, 0, 0, 0, 0, 0, 'On WP Reached - Talk Target');
INSERT INTO smart_scripts VALUES (22990, 0, 4, 0, 40, 0, 100, 0, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (22990, 0, 5, 16, 40, 0, 100, 0, 3, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 11, 21701, 100, 0, 0, 0, 0, 0, 'On WP Reached - Set Data');
INSERT INTO smart_scripts VALUES (22990, 0, 6, 7, 40, 0, 100, 0, 7, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (22990, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 22989, 30, 0, 0, 0, 0, 0, 'On WP Reached - Talk Target');
INSERT INTO smart_scripts VALUES (22990, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 86, 34189, 2, 19, 22989, 30, 0, 19, 22989, 30, 0, 0, 0, 0, 0, 'On WP Reached - Cross Cast');
INSERT INTO smart_scripts VALUES (22990, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 22989, 30, 0, -3647.27, 316.06, 35.31, 0, 'On WP Reached - Move Target To Pos');
INSERT INTO smart_scripts VALUES (22990, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 11, 21701, 100, 0, -3647.27, 316.06, 35.31, 0, 'On WP Reached - Move Target To Pos');
INSERT INTO smart_scripts VALUES (22990, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 54, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (22990, 0, 12, 0, 56, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resumed - Talk');
INSERT INTO smart_scripts VALUES (22990, 0, 13, 14, 40, 0, 100, 0, 12, 0, 0, 0, 15, 10985, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'On WP Reached - Call Area Explored');
INSERT INTO smart_scripts VALUES (22990, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 15, 13429, 0, 0, 0, 0, 0, 18, 100, 0, 0, 0, 0, 0, 0, 'On WP Reached - Call Area Explored');
INSERT INTO smart_scripts VALUES (22990, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 22989, 100, 0, 0, 0, 0, 0, 'On AI Init - Set Data');
INSERT INTO smart_scripts VALUES (22990, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 22989, 100, 0, 0, 0, 0, 0, 'On WP Reached - Set Data');
INSERT INTO smart_scripts VALUES (22989, 0, 17, 0, 0, 0, 100, 0, 3000, 6000, 10000, 15000, 11, 39945, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (22990, 0, 18, 0, 40, 0, 100, 0, 9, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 11, 21701, 100, 0, -3647.27, 316.06, 35.31, 0, 'On WP Reached - Move Target To Pos');
DELETE FROM creature_summon_groups WHERE summonerId=18528 AND summonerType=0;
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22857, -3553.42, 562.74, 14.34, 1.54, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22857, -3566.11, 563.07, 13.65, 1.54, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3551.78, 524.12, 18.20, 1.76, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3545.93, 524.68, 18.38, 1.66, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3540.21, 525.23, 19.24, 1.66, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3581.30, 510.47, 20.80, 1.31, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3574.78, 507.94, 20.56, 1.28, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 22988, -3568.08, 505.66, 20.46, 1.24, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 1, 23152, -3571.58, 480.70, 22.70, 1.42, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 22990, -3569.58, 642.18, 3.37, 4.73, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 22989, -3553.20, 641.90, 3.70, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3562.56, 647.24, 2.16, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3566.00, 650.45, 1.50, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3569.48, 654.04, 0.84, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3573.00, 657.34, 0.31, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3559.00, 650.45, 1.50, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3555.48, 654.04, 0.84, 4.69, 3, 300000);
INSERT INTO creature_summon_groups VALUES (18528, 0, 2, 21701, -3552.00, 657.34, 0.31, 4.69, 3, 300000);
DELETE FROM waypoints WHERE entry=22990;
INSERT INTO waypoints VALUES (22990, 1, -3570.33, 620.32, 6.41, 'Akama'),(22990, 2, -3570.23, 588.86, 10.39, 'Akama'),
(22990, 3, -3572.74, 559.12, 13.55, 'Akama'),(22990, 4, -3558.79, 545.08, 15.62, 'Akama'),(22990, 5, -3562.60, 511.74, 19.23, 'Akama'),(22990, 6, -3568.41, 482.69, 22.44, 'Akama'),(22990, 7, -3569.81, 473.76, 23.32, 'Akama'),
(22990, 8, -3577.90, 425.75, 29.02, 'Akama'),(22990, 9, -3596.30, 409.57, 31.74, 'Akama'),(22990, 10, -3597.12, 369.52, 35.27, 'Akama'),(22990, 11, -3600.23, 350.08, 38.90, 'Akama'),(22990, 12, -3644.38, 316.13, 35.17, 'Akama');

-- Everything Will Be Alright (10164)
DELETE FROM creature WHERE id=19698;
INSERT INTO creature VALUES (NULL, 19698, 530, 1, 1, 0, 0, -3346.54, 5188.42, -101.05, 6.28236, 300, 0, 0, 6986, 0, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (19698, 0, 0, 8, 0, 0, '');
UPDATE creature_template SET AIName='', ScriptName='npc_greatfather_aldrimus' WHERE entry=19698;

-- Kael'thas and the Verdant Sphere (11007)
UPDATE quest_template SET RewardSpellCast=39953 WHERE Id=11007;
DELETE FROM spell_script_names WHERE spell_id=39953;
INSERT INTO spell_script_names VALUES(39953, 'spell_gen_adals_song_of_battle');
DELETE FROM disables WHERE entry IN(39953) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES(0, 39953, 64, '', '', 'Disable LOS for A''dal''s Song of Battle');

-- The Earthbinder (10349)
DELETE FROM smart_scripts WHERE entryorguid IN(19294) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(1929400, 1929401) AND source_type=9;
INSERT INTO smart_scripts VALUES (19294, 0, 0, 0, 38, 0, 100, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Data Set 1 0 - Say Line 0');
INSERT INTO smart_scripts VALUES (19294, 0, 1, 0, 20, 0, 100, 0, 10349, 0, 0, 0, 80, 1929400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Quest The Earthbinder Finished - Run Script');
INSERT INTO smart_scripts VALUES (19294, 0, 2, 0, 38, 0, 100, 0, 2, 0, 0, 0, 80, 1929401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Data Set 2 0 - Run Script');
INSERT INTO smart_scripts VALUES (19294, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Respawn - Set Npc Flags Gossip & Questgiver');
INSERT INTO smart_scripts VALUES (1929400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Set Active On');
INSERT INTO smart_scripts VALUES (1929400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Set Run Off');
INSERT INTO smart_scripts VALUES (1929400, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Set Npc Flag ');
INSERT INTO smart_scripts VALUES (1929400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Set Orientation Closest Player');
INSERT INTO smart_scripts VALUES (1929400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (1929400, 9, 5, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -286.767, 4729.43, 18.4418, 1.72788, 'Earthbinder Galandria Nightbreeze - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (1929400, 9, 6, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Play Emote 16');
INSERT INTO smart_scripts VALUES (1929400, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Play Emote 0');
INSERT INTO smart_scripts VALUES (1929400, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 184450, 60, 0, 0, 0, 0, 8, 0, 0, 0, -287.019, 4731.63, 18.217, 2.58308, 'Earthbinder Galandria Nightbreeze - On Script - Summon Gameobject Crimson Crystal Shard');
INSERT INTO smart_scripts VALUES (1929400, 9, 9, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Say Line 2');
INSERT INTO smart_scripts VALUES (1929400, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 20599, 4, 10000, 0, 1, 0, 8, 0, 0, 0, -288.19, 4733.63, 18.2982, 5.044, 'Earthbinder Galandria Nightbreeze - On Script - Summon Creature Lured Colossus');
INSERT INTO smart_scripts VALUES (1929401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -294.766, 4715.08, 28.1862, 0.20944, 'On Script - Move To Position');
INSERT INTO smart_scripts VALUES (1929401, 9, 1, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0.20944, 'On Script - Set Orientation Home Position');
INSERT INTO smart_scripts VALUES (1929401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthbinder Galandria Nightbreeze - On Script - Set Active Off');
INSERT INTO smart_scripts VALUES (1929401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Script - Set Npc Flags Gossip & Questgiver');

-- Forge Camp: Annihilated (10011)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN (33531, 33532);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN (33531, 33532);
INSERT INTO conditions VALUES(13, 1, 33531, 0, 0, 31, 0, 3, 19067, 0, 0, 0, 0, '', 'Target Forge Camp: Hate');
INSERT INTO conditions VALUES(13, 1, 33532, 0, 0, 31, 0, 3, 19210, 0, 0, 0, 0, '', 'Target Forge Camp: Fear');
INSERT INTO conditions VALUES(17, 0, 33531, 0, 0, 29, 0, 19067, 3, 0, 0, 97, 0, '', 'Requires Forge Camp: Hate in 4yd');
INSERT INTO conditions VALUES(17, 0, 33532, 0, 0, 29, 0, 19210, 3, 0, 0, 97, 0, '', 'Requires Forge Camp: Fear in 4yd');

-- The Battle for the Sun's Reach Armory (11538)
DELETE FROM smart_scripts WHERE entryorguid IN(23310) AND source_type=0;
INSERT INTO smart_scripts VALUES (23310, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 46907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Portal Alarm - On Respawn - Cast Boss Fel Portal State');
INSERT INTO smart_scripts VALUES (23310, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Portal Alarm - On Data Set 1 1 - Increment Phase');
INSERT INTO smart_scripts VALUES (23310, 0, 2, 3, 60, 4064, 100, 0, 1000, 1000, 1000, 1000, 12, 25003, 6, 60000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Portal Alarm - On Update - Summon Creature Emissary of Hate');
INSERT INTO smart_scripts VALUES (23310, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Fel Portal Alarm - Out of Combat - Set Event Phase 0');

-- Teron Gorefiend, I am... (10639)
-- Teron Gorefiend, I am... (10645)
DELETE FROM smart_scripts WHERE entryorguid=2179701 AND source_type=9;
INSERT INTO smart_scripts VALUES (2179701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Remove Aura');
INSERT INTO smart_scripts VALUES (2179701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Evade');
INSERT INTO smart_scripts VALUES (2179701, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 43, 0, 10720, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Mount');
INSERT INTO smart_scripts VALUES (2179701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Say Line 0');
INSERT INTO smart_scripts VALUES (2179701, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Say Line 1');
INSERT INTO smart_scripts VALUES (2179701, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 53, 1, 21867, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Script 2 - Start WP');

-- Creating the Pendant (10567)
DELETE FROM event_scripts WHERE id=14029;
INSERT INTO event_scripts VALUES (14029, 0, 10, 21767, 9000000, 0, 3170.83, 5345.70, 180.57, 0.0);
UPDATE creature_template SET InhabitType=7 WHERE entry=21767;
DELETE FROM smart_scripts WHERE entryorguid=21767 AND source_type=0;
INSERT INTO smart_scripts VALUES (21767, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 1, 0, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Just Summoned - Say Line 0');
INSERT INTO smart_scripts VALUES (21767, 0, 1, 0, 60, 0, 100, 257, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 3211, 5348.21, 146.53, 5.54, 'Harbinger of the Raven - On Update - Move To Position');
INSERT INTO smart_scripts VALUES (21767, 0, 2, 3, 52, 0, 100, 0, 0, 21767, 0, 0, 11, 37446, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Cast Ruuan ok Oracle Transformation');
INSERT INTO smart_scripts VALUES (21767, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 2, 954, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Set Faction');
INSERT INTO smart_scripts VALUES (21767, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Set Hostile');
INSERT INTO smart_scripts VALUES (21767, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Attack Start');
INSERT INTO smart_scripts VALUES (21767, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 144, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Move Fall');
INSERT INTO smart_scripts VALUES (21767, 0, 7, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Evade Despawn');

-- You're Fired! (10821)
UPDATE gameobject_template SET data3=120000, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(185193, 185195, 185196, 185197, 185198);
DELETE FROM smart_scripts WHERE entryorguid IN(185193, 185195, 185196, 185197, 185198) AND source_type=1;
INSERT INTO smart_scripts VALUES (185193, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 78759, 22422, 1, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Counter');
INSERT INTO smart_scripts VALUES (185193, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Gameobject Flag');
INSERT INTO smart_scripts VALUES (185195, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 78759, 22422, 1, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Counter');
INSERT INTO smart_scripts VALUES (185195, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Gameobject Flag');
INSERT INTO smart_scripts VALUES (185196, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 78759, 22422, 1, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Counter');
INSERT INTO smart_scripts VALUES (185196, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Gameobject Flag');
INSERT INTO smart_scripts VALUES (185197, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 78759, 22422, 1, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Counter');
INSERT INTO smart_scripts VALUES (185197, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Gameobject Flag');
INSERT INTO smart_scripts VALUES (185198, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 78759, 22422, 1, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Counter');
INSERT INTO smart_scripts VALUES (185198, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 104, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Legion Obelisk - On Spell Hit - Set Gameobject Flag');
UPDATE creature_template SET InhabitType=4, AIName='NullCreatureAI', ScriptName='' WHERE entry=20736;
UPDATE creature SET position_z=299 WHERE id=22422 AND guid=78759;
UPDATE creature_template SET InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=22422;
DELETE FROM smart_scripts WHERE entryorguid=22422 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=22422*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (22422, 0, 0, 0, 77, 0, 100, 0, 1, 5, 60000, 60000, 80, 22422*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - On Counter Set - Run Script');
INSERT INTO smart_scripts VALUES (22422*100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 86, 40227, 0, 10, 73126, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 86, 40227, 0, 10, 73126, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 86, 40227, 0, 10, 73129, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 86, 40227, 0, 10, 73130, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 86, 40227, 0, 10, 73133, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 19963, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 2870.55, 4814.18, 283.66, 0.34, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Cross Cast Green Beam');
INSERT INTO smart_scripts VALUES (22422*100, 9, 6, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 63, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Reset Counter');
INSERT INTO smart_scripts VALUES (22422*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 11, 20736, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Interrupt Cast');
INSERT INTO smart_scripts VALUES (22422*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 104, 6, 0, 0, 0, 0, 0, 20, 185193, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (22422*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 104, 6, 0, 0, 0, 0, 0, 20, 185195, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (22422*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 104, 6, 0, 0, 0, 0, 0, 20, 185196, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (22422*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 104, 6, 0, 0, 0, 0, 0, 20, 185197, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Set Gameobject Flags');
INSERT INTO smart_scripts VALUES (22422*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 104, 6, 0, 0, 0, 0, 0, 20, 185198, 100, 0, 0, 0, 0, 0, 'Blade''s Edge - Legion - Anger Camp - Invis Bunny - Script9 - Set Gameobject Flags');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=19963;
DELETE FROM smart_scripts WHERE entryorguid=19963 AND source_type=0;
INSERT INTO smart_scripts VALUES (19963, 0, 0, 1, 60, 0, 100, 257, 0, 0, 0, 0, 86, 35502, 0, 10, 73132, 20736, 1, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomcryer - On Update - Cross Cast Legion Teleport Target');
INSERT INTO smart_scripts VALUES (19963, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomcryer - On Update - Set Unit Flags');
INSERT INTO smart_scripts VALUES (19963, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomcryer - On Update - Set Walk');
INSERT INTO smart_scripts VALUES (19963, 0, 3, 4, 60, 0, 100, 257, 4500, 4500, 0, 0, 28, 35502, 0, 0, 0, 0, 0, 10, 73132, 20736, 1, 0, 0, 0, 0, 'Doomcryer - On Update - Remove Aura');
INSERT INTO smart_scripts VALUES (19963, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Doomcryer - On Update - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (19963, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2879.53, 4816.97, 282.80, 0, 'Doomcryer - On Update - Move To Position');
INSERT INTO smart_scripts VALUES (19963, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2879.53, 4816.97, 282.80, 0, 'Doomcryer - On Update - Set Home Position');
INSERT INTO smart_scripts VALUES (19963, 0, 7, 0, 0, 0, 100, 0, 13000, 13000, 20000, 30000, 11, 34017, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Doomcryer - In Combat - Cast Rain of Chaos');
INSERT INTO smart_scripts VALUES (19963, 0, 8, 0, 0, 0, 100, 0, 3000, 5000, 8000, 11000, 11, 37629, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Doomcryer - In Combat - Cast Melt Flesh');
INSERT INTO smart_scripts VALUES (19963, 0, 9, 0, 0, 0, 100, 0, 9000, 9000, 40000, 40000, 11, 36541, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Doomcryer - In Combat - Cast Curse of Burning Shadows');

-- The Thunderspike (10526)
DELETE FROM event_scripts WHERE id=13685;
INSERT INTO event_scripts VALUES (13685, 0, 10, 21319, 90000, 0, 1314.47, 6687.27, -18.28, 0.27);
DELETE FROM creature_text WHERE entry=21319;
INSERT INTO creature_text VALUES (21319, 0, 0, 'Puny $r cannot lift spear.  Gor lift spear!', 12, 0, 100, 0, 0, 0, 0, 'Gor Grimgut');
INSERT INTO creature_text VALUES (21319, 1, 0, 'Hah!  The Thunderspike is mine.  Die!', 12, 0, 100, 0, 0, 0, 0, 'Gor Grimgut');
UPDATE gameobject_template SET data3=5000 WHERE entry=184729;
DELETE FROM smart_scripts WHERE entryorguid=21319 AND source_type=0;
INSERT INTO smart_scripts VALUES (21319, 0, 0, 1, 37, 0, 100, 257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On AI Init - Say Line 0');
INSERT INTO smart_scripts VALUES (21319, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On AI Init - Set Unit Flags');
INSERT INTO smart_scripts VALUES (21319, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On AI Init - Set React State Passive');
INSERT INTO smart_scripts VALUES (21319, 0, 3, 4, 60, 0, 100, 257, 5000, 5000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 20, 184729, 10, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Set Orientation');
INSERT INTO smart_scripts VALUES (21319, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Say Line 1');
INSERT INTO smart_scripts VALUES (21319, 0, 5, 0, 60, 0, 100, 257, 5500, 5500, 0, 0, 71, 0, 1, 30440, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Equip');
INSERT INTO smart_scripts VALUES (21319, 0, 6, 7, 60, 0, 100, 257, 7000, 7000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (21319, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Remove Set React Aggressive');
INSERT INTO smart_scripts VALUES (21319, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Update - Attack Start');
INSERT INTO smart_scripts VALUES (21319, 0, 9, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (21319, 0, 10, 0, 0, 0, 100, 0, 3000, 5000, 7000, 10000, 75, 35492, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - In Combat - Cast Exhaustion');
INSERT INTO smart_scripts VALUES (21319, 0, 11, 0, 0, 0, 100, 0, 10000, 12000, 12000, 15000, 11, 35491, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gor Grimgut - In Combat - Cast Furious Rage');

-- Invaluable Asset Zapping (10203)
UPDATE gameobject_template SET data3=1 WHERE entry IN(183805, 183806, 183807, 183808);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=36460;
INSERT INTO conditions VALUES(13, 4, 36460, 0, 3, 31, 0, 3, 21262, 0, 0, 0, 0, '', 'Target Goblin Equipment Trigger');
UPDATE creature_template SET AIName='SmartAI', ScriptName=''WHERE entry=21262;
DELETE FROM smart_scripts WHERE entryorguid=21262 AND source_type=0;
INSERT INTO smart_scripts VALUES (21262, 0, 0, 0, 8, 0, 100, 0, 36460, 0, 0, 0, 11, 41232, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goblin Equipment Trigger - On Spell Hit - Cast Teleport Visual Only');

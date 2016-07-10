
-- -------------------------------------------
-- EK, KALIMDOR
-- -------------------------------------------
-- WANTED: Murkdeep! (4740)
UPDATE creature_template SET ScriptName="npc_murkdeep" WHERE entry=10323;
DELETE FROM creature WHERE id=10323;
INSERT INTO creature VALUES (NULL, 10323, 1, 1, 1, 0, 1, 4986, 604, -0.963996, 4.70218, 300, 0, 0, 516, 0, 0, 0, 0, 0);

-- Battle of Hillsbrad (14351)
REPLACE INTO creature_queststarter VALUES(2215, 14351);

-- Decoy! (8606)
DELETE FROM gameobject WHERE id=180659;
INSERT INTO gameobject VALUES (NULL, 180659, 1, 1, 1, 5086.19, -5116.32, 931.162, 4.78877, 0, 0, 0.679593, -0.733589, 150, 0, 1, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=25720;
INSERT INTO conditions VALUES (17, 0, 25720, 0, 0, 1, 0, 25688, 0, 0, 0, 0, 0, '', 'Requires aura 25688');
DELETE FROM event_scripts WHERE id=9527;
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=180660;
DELETE FROM smart_scripts WHERE entryorguid=180660 AND source_type=1;
INSERT INTO smart_scripts VALUES(180660, 1, 0, 0, 60, 0, 100, 1, 5000, 5000, 0, 0, 12, 15553, 3, 180000, 0, 0, 0, 8, 0, 0, 0, 5089.83, -5156.7, 948.5, 1.5, 'On Update - Summon Creature');
UPDATE creature_template SET InhabitType=4, AIName='SmartAI', ScriptName='' WHERE entry=15553;
DELETE FROM smart_scripts WHERE entryorguid=15553 AND source_type=0;
INSERT INTO smart_scripts VALUES(15553, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 133, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Movement Flags');
INSERT INTO smart_scripts VALUES(15553, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5087.90, -5076.5, 927.38, 0, 'On Respawn - Move Point');
INSERT INTO smart_scripts VALUES(15553, 0, 2, 0, 34, 0, 100, 1, 8, 1, 0, 0, 12, 15552, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 5088.32, -5074.99, 921.76, 4.73, 'MovementInform - Summon Creature');
INSERT INTO smart_scripts VALUES(15553, 0, 3, 4, 38, 0, 100, 1, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5102.7, -5005.1, 936.5, 0, 'Set Data - Move Point');
INSERT INTO smart_scripts VALUES(15553, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Data - Despawn');
DELETE FROM creature_text WHERE entry=15552;
INSERT INTO creature_text VALUES(15552, 0, 0, "No hello for your old friend, Narain? Who were you expecting?", 12, 0, 100, 0, 0, 0, 0, "Doctor Weavil");
INSERT INTO creature_text VALUES(15552, 1, 0, "%s eyes you suspiciously.", 16, 0, 100, 0, 0, 0, 0, "Doctor Weavil");
INSERT INTO creature_text VALUES(15552, 2, 0, "So... You thought you could fool me, did you? The greatest criminal mastermind Azeroth has ever known?", 12, 0, 100, 0, 0, 0, 0, "Doctor Weavil");
INSERT INTO creature_text VALUES(15552, 3, 0, "I see right through your disguise, $R. Number Two! Number Two kill!", 12, 0, 100, 0, 0, 0, 0, "Doctor Weavil");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=15552;
DELETE FROM smart_scripts WHERE entryorguid=15552 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=15552*100 AND source_type=9;
INSERT INTO smart_scripts VALUES(15552, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5086.29, -5108.8, 929.24, 0, 'On Respawn - Move Point');
INSERT INTO smart_scripts VALUES(15552, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Faction');
INSERT INTO smart_scripts VALUES(15552, 0, 2, 0, 34, 0, 100, 1, 8, 1, 0, 0, 80, 15552*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'MovementInform - Start Script');
INSERT INTO smart_scripts VALUES(15552, 0, 3, 4, 34, 0, 100, 1, 8, 2, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 15553, 30, 0, 0, 0, 0, 0, 'MovementInform - Set Data');
INSERT INTO smart_scripts VALUES(15552, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'MovementInform - Despawn');
INSERT INTO smart_scripts VALUES(15552*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.4, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES(15552*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 0');
INSERT INTO smart_scripts VALUES(15552*100, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 1');
INSERT INTO smart_scripts VALUES(15552*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 2');
INSERT INTO smart_scripts VALUES(15552*100, 9, 4, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 3');
INSERT INTO smart_scripts VALUES(15552*100, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 5087.87, -5079.19, 921.96, 0, 'Script9 - Move Point');
INSERT INTO smart_scripts VALUES(15552*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 15554, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 5101, -5085.6, 926.2, 4.1, 'Script9 - Summon Creature');
DELETE FROM creature_text WHERE entry=15554;
INSERT INTO creature_text VALUES(15554, 0, 0, "KILL!", 12, 0, 100, 0, 0, 0, 0, "Number Two");
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=15554;
DELETE FROM smart_scripts WHERE entryorguid=15554 AND source_type=0;
INSERT INTO smart_scripts VALUES(15554, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Talk 0');
INSERT INTO smart_scripts VALUES(15554, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Respawn - Attack Start');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(15552, 15553);
INSERT INTO conditions VALUES (22, 1, 15552, 0, 0, 4, 1, 618, 0, 0, 0, 0, 0, '', 'Requires Zone Winterspring');
INSERT INTO conditions VALUES (22, 1, 15553, 0, 0, 4, 1, 618, 0, 0, 0, 0, 0, '', 'Requires Zone Winterspring');

-- Heroes of Old (2702)
DELETE FROM conditions WHERE SourceGroup=840 AND SourceEntry=2;
INSERT INTO conditions VALUES (15, 840, 2, 0, 1, 14, 0, 2702, 0, 0, 1, 0, 0, '', 'Show gossip option if player has quest 2702 but not complete');
INSERT INTO conditions VALUES (15, 840, 2, 0, 1, 8, 0, 2701, 0, 0, 1, 0, 0, '', 'Show gossip option if player has quest 2702 but not complete');
INSERT INTO conditions VALUES (15, 840, 2, 0, 1, 29, 0, 7750, 40, 0, 1, 0, 0, '', 'Show gossip option if player has quest 2702 but not complete');

-- The Ancient Leaf (7632)
REPLACE INTO creature_questender VALUES(14524, 7632);
REPLACE INTO creature_questender VALUES(14525, 7632);
REPLACE INTO creature_questender VALUES(14526, 7632);
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(14524, 14525, 14526));
DELETE FROM creature WHERE id IN(14524, 14525, 14526);
INSERT INTO creature VALUES (NULL, 14524, 1, 1, 1, 0, 0, 6227.37, -1068, 378.57, 0.969, 600, 0, 0, 3331, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 14525, 1, 1, 1, 0, 0, 6265.19, -1111, 371.329, 0.54, 600, 0, 0, 3331, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 14526, 1, 1, 1, 0, 0, 6179.29, -1065, 385.375, 1.156, 600, 0, 0, 3331, 0, 0, 0, 0, 0);

-- Items of Power (1948)
UPDATE gameobject_template SET AIName='', ScriptName='go_witherbark_totem_bundle' WHERE entry=174764;

-- Suppression (7583)
UPDATE quest_template SET NextQuestIdChain=7582 WHERE Id=7581;
UPDATE quest_template SET PrevQuestId=7581, NextQuestIdChain=7583 WHERE Id=7582;
UPDATE quest_template SET PrevQuestId=7582 WHERE Id=7583;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=12396;
DELETE FROM smart_scripts WHERE entryorguid IN(12396) AND source_type=0;
INSERT INTO smart_scripts VALUES(12396, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 18000, 24000, 11, 16005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(12396, 0, 1, 0, 0, 0, 100, 0, 12000, 15000, 20000, 25000, 11, 16727, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(12396, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 25000, 32000, 11, 20812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(12396, 0, 3, 0, 0, 0, 100, 0, 7000, 14000, 17000, 22000, 11, 15090, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC spell cast');
INSERT INTO smart_scripts VALUES(12396, 0, 4, 5, 8, 0, 100, 0, 23019, 0, 0, 0, 50, 179644, 180, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "summon go on spell hit");
INSERT INTO smart_scripts VALUES(12396, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "invisible linked");
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(23015, 23019);
INSERT INTO conditions VALUES(13, 7, 23015, 0, 0, 31, 0, 3, 12396, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 23019, 0, 0, 31, 0, 3, 12396, 0, 0, 0, 0, '', '');

-- A Dip in the Moonwell (9433)
DELETE FROM gameobject WHERE id=181632;
INSERT INTO gameobject VALUES(NULL, 181632, 1, 1, 1, -4512.47, -782.202, -41.5776, 0.56852, 0, 0, 0.280447, 0.959869, 300, 0, 1, 0);

-- Hand of Iruxos (5381)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=176581;
DELETE FROM smart_scripts WHERE entryorguid=176581 AND source_type=1;
INSERT INTO smart_scripts VALUES(176581, 1, 0, 0, 70, 0, 100, 0, 3, 0, 0, 0, 12, 11876, 4, 15000, 0, 0, 0, 8, 0, 0, 0, -345, 1759, 138.37, 2.0, "On gossip hello - summon creature");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(176581);
INSERT INTO conditions VALUES(22, 1, 176581, 1, 0, 29, 1, 11876, 30, 0, 1, 0, 0, '', 'no npc near');

-- Defiling Uther's Tomb (9444)
UPDATE quest_template SET RequiredNpcOrGO1=17233 WHERE Id=9444;
DELETE FROM creature_text WHERE entry=17233;
INSERT INTO creature_text VALUES(17233, 0, 0, "Why do you do this? Did I somehow wrong you in life?", 12, 0, 100, 0, 0, 0, 0, "Defiling Uther's Tomb");
INSERT INTO creature_text VALUES(17233, 1, 0, "Ah, I see it now in your mind. This is the work of one of my former students... Mehlar Dawnblade. It is sad to know that his heart has turned so dark.", 12, 0, 100, 0, 0, 0, 0, "Defiling Uther's Tomb");
INSERT INTO creature_text VALUES(17233, 2, 0, "Return to him. Return to Mehlor and tell him that I forgive him and that I understand why he believes what he does.", 12, 0, 100, 0, 0, 0, 0, "Defiling Uther's Tomb");
INSERT INTO creature_text VALUES(17233, 3, 0, "I can only hope that he will see the Light and instead turn his energies to restoring once-beautiful Quel'Thalas.", 12, 0, 100, 0, 0, 0, 0, "Defiling Uther's Tomb");
UPDATE creature_template SET AIName="SmartAI" WHERE entry=17233;
DELETE FROM smart_scripts WHERE entryorguid=17233 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=17233*100 AND source_type=9;
INSERT INTO smart_scripts VALUES(17233, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 80, 17233*100, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "run timed actionlist linked");
INSERT INTO smart_scripts VALUES(17233*100, 9, 0, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(17233*100, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(17233*100, 9, 2, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(17233*100, 9, 3, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "say text");
INSERT INTO smart_scripts VALUES(17233*100, 9, 4, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 33, 17233, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "kill credit");
INSERT INTO smart_scripts VALUES(17233*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "force despawn");

-- Favor Amongst the Brotherhood quests
UPDATE quest_template SET RequiredMinRepValue=0 WHERE Id IN(6642, 6643, 6644, 6645, 6646);

-- Eitrigg's Wisdom (4941)
DELETE FROM gossip_menu_option WHERE menu_id BETWEEN 2901 AND 2901+7;
INSERT INTO gossip_menu_option VALUES
(2901, 0, 0, 'Hello, Eitrigg. I bring news from Blackrock Spire.', 1, 1, 2901+1, 0, 0, 0, ''),
(2901+1, 0, 0, 'There is only one Warchief, Eitrigg!', 1, 1, 2901+2, 0, 0, 0, ''),
(2901+2, 0, 0, 'What do you mean?', 1, 1, 2901+3, 0, 0, 0, ''),
(2901+3, 0, 0, 'Hearthglen? But...', 1, 1, 2901+4, 0, 0, 0, ''),
(2901+4, 0, 0, 'I will take you up on that offer, Eitrigg.', 1, 1, 2901+5, 0, 0, 0, ''),
(2901+5, 0, 0, 'Ah, so that is how they pushed the Dark Iron to the lower parts of the Spire.', 1, 1, 2901+6, 0, 0, 0, ''),
(2901+6, 0, 0, 'Perhaps there exists a way?', 1, 1, 2901+7, 0, 0, 0, ''),
(2901+7, 0, 0, 'As you wish, Eitrigg.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM gossip_menu WHERE entry BETWEEN 2901+1 AND 2901+7;
INSERT INTO gossip_menu VALUES (2901+1, 3574),(2901+2, 3575),(2901+3, 3576),(2901+4, 3577),(2901+5, 3578),(2901+6, 3579),(2901+7, 3580);
DELETE FROM conditions WHERE SourceGroup=2901;
INSERT INTO conditions VALUES(15, 2901, 0, 0, 0, 9, 0, 4941, 0, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName= 'SmartAI' WHERE entry=3144;
DELETE FROM smart_scripts WHERE entryorguid=3144 AND source_type=0;
INSERT INTO smart_scripts VALUES (3144,0,0,1,62,0,100,0,2901+7,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Eitrigg - Select As you wish, Eitrigg. - Close gossip');
INSERT INTO smart_scripts VALUES (3144,0,1,0,61,0,100,0,0,0,0,0,15,4941,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Eitrigg - on link - give credit quest(4941)');

-- Missing In Action (219)
UPDATE creature_template SET faction=11 WHERE entry=349;

-- The Defias Brotherhood (155)
UPDATE smart_scripts SET action_type=26 WHERE action_type=15 AND entryorguid=467 AND source_type=0;

-- Kroshius' Infernal Core (7603)
UPDATE gameobject SET position_x=5780.33, position_y=-964.84, position_z=412.7 WHERE id=300049;

-- When Smokey Sings, I Get Violent (6041)
UPDATE gameobject_template SET data4=0, AIName='SmartGameObjectAI' WHERE entry=177672;
DELETE FROM smart_scripts WHERE entryorguid=177672 AND source_type=1;
INSERT INTO smart_scripts VALUES (177672, 1, 0, 0, 60, 0, 100, 1, 500, 500, 0, 0, 33, 12247, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'On update - kill credit');
INSERT INTO smart_scripts VALUES (177672, 1, 1, 0, 60, 0, 100, 1, 13000, 14000, 0, 0, 11, 19237, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On update - cast spell');

-- Freed from the Hive (4265)
UPDATE smart_scripts SET event_type=60, event_flags=1 WHERE entryorguid=9546 and source_type=0 and id=0;
UPDATE smart_scripts SET target_type=21, target_param1=30 WHERE entryorguid=954600 and source_type=9 and action_type=15;

-- Investigate the Blue Recluse (1920)
-- Investigate the Alchemist Shop (1960)
DELETE FROM creature_text WHERE entry=6492;
INSERT INTO creature_text VALUES(6492, 0, 0, "%s fades into void.", 16, 0, 100, 0, 0, 0, 0, "Rift Spawn");
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(6492));
DELETE FROM creature WHERE id IN(6492);
INSERT INTO creature VALUES (NULL, 6492, 0, 1, 1, 0, 0, 1412.97, 343.782, -66.0015, 4.86227, 300, 0, 0, 386, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, 1401.55, 365.922, -66.0367, 2.66709, 300, 0, 0, 356, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, 1420.45, 355.246, -65.9999, 5.49688, 300, 0, 0, 356, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, 1418.05, 366.824, -66.0008, 0.385505, 300, 0, 0, 386, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, 1402.58, 342.868, -66.0167, 4.58503, 300, 0, 0, 356, 0, 0, 0, 0, 0),
(NULL, 6492, 0, 1, 1, 0, 0, 1406.46, 355.153, -66.0258, 5.85502, 300, 0, 0, 386, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, -9099.67, 838.26, 105.125, 5.4906, 300, 0, 0, 386, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, -9110.85, 830.738, 97.6299, 3.31741, 300, 0, 0, 356, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, -9098.44, 832.942, 97.6299, 6.13699, 300, 0, 0, 386, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, -9112.82, 840.837, 98.9648, 3.55695, 300, 0, 0, 356, 0, 0, 0, 0, 0),(NULL, 6492, 0, 1, 1, 0, 0, -9106.64, 838.22, 105.12, 3.30955, 300, 0, 0, 386, 0, 0, 0, 0, 0);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13) AND SourceEntry IN(9095);
INSERT INTO conditions VALUES(13, 1, 9095, 0, 0, 31, 0, 3, 6492, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry IN(9082);
INSERT INTO conditions VALUES(13, 1, 9082, 0, 0, 31, 0, 3, 6492, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 9082, 0, 0, 1, 0, 9032, 0, 0, 0, 0, 0, '', '');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=6492;
DELETE FROM smart_scripts WHERE entryorguid=6492 AND source_type=0;
INSERT INTO smart_scripts VALUES(6492, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 11, 9093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast spell on self on reset");
INSERT INTO smart_scripts VALUES(6492, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - Set Invincibility HP Level");
INSERT INTO smart_scripts VALUES(6492, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - Set phase mask");
INSERT INTO smart_scripts VALUES(6492, 0, 3, 4, 8, 0, 100, 0, 9095, 0, 0, 0, 28, 9093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On spell hit remove aura");
INSERT INTO smart_scripts VALUES(6492, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - Set phase mask");
INSERT INTO smart_scripts VALUES(6492, 0, 5, 6, 2, 1, 100, 0, 0, 1, 30000, 30000, 11, 9032, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On HP Update cast spell");
INSERT INTO smart_scripts VALUES(6492, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - force despawn");
INSERT INTO smart_scripts VALUES(6492, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - set phase");
INSERT INTO smart_scripts VALUES(6492, 0, 8, 0, 60, 2, 100, 0, 29000, 29000, 10000, 10000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Update say text");
INSERT INTO smart_scripts VALUES(6492, 0, 9, 10, 38, 2, 100, 0, 1, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On Data Set - remove all auras");
INSERT INTO smart_scripts VALUES(6492, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 11, 9010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - cast spell");
INSERT INTO smart_scripts VALUES(6492, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Linked - force despawn");
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=122088;
DELETE FROM smart_scripts WHERE entryorguid IN (122088) AND source_type=1;
INSERT INTO smart_scripts VALUES (122088, 1, 0, 1, 64, 0, 100, 1, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 6492, 5, 0, 0, 0, 0, 0, 'On gossip hello - Set Data');
INSERT INTO smart_scripts VALUES (122088, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Phase');
INSERT INTO smart_scripts VALUES (122088, 1, 2, 0, 60, 1, 100, 0, 2500, 2500, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Force Despawn');

-- The Grimtotem Weapon (11169)
REPLACE INTO creature_template_addon VALUES(23811, 0, 0, 0, 1, 0, '42464');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=42454;
INSERT INTO conditions VALUES (13, 1, 42454, 0, 0, 31, 0, 3, 4344, 0, 0, 0, 0, '', 'Target creature condition for spell 42454');
INSERT INTO conditions VALUES (13, 1, 42454, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target creature condition for spell 42454');
INSERT INTO conditions VALUES (13, 1, 42454, 0, 1, 31, 0, 3, 4345, 0, 0, 0, 0, '', 'Target creature condition for spell 42454');
INSERT INTO conditions VALUES (13, 1, 42454, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Target creature condition for spell 42454');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(4344, 4345);
DELETE FROM smart_scripts WHERE entryorguid IN(4344, 4345) AND source_type=0;
INSERT INTO smart_scripts VALUES (4344, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 42455, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell');
INSERT INTO smart_scripts VALUES (4345, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 42455, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(4344, 4345);
INSERT INTO conditions VALUES (22, 1, 4344, 0, 0, 1, 1, 42454, 0, 0, 0, 0, 0, '', 'Must have aura 42454 to execute smart event');
INSERT INTO conditions VALUES (22, 1, 4345, 0, 0, 1, 1, 42454, 0, 0, 0, 0, 0, '', 'Must have aura 42454 to execute smart event');

-- Ghost-o-plasm Round Up (6134)
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=177746;
DELETE FROM smart_scripts WHERE entryorguid IN (177746) AND source_type=1;
INSERT INTO smart_scripts VALUES (177746, 1, 0, 0, 60, 0, 100, 0, 3000, 3000,   35000, 35000, 12, 11560, 4, 25000, 0, 0, 0, 1, 0, 0, 0, 20, 11, 0, 0, 'On update - summon creature');
INSERT INTO smart_scripts VALUES (177746, 1, 1, 0, 60, 0, 100, 0, 10000, 10000, 35000, 35000, 12, 11560, 4, 25000, 0, 0, 0, 1, 0, 0, 0, -20, -11, 0, 0, 'On update - summon creature');
INSERT INTO smart_scripts VALUES (177746, 1, 2, 0, 60, 0, 100, 0, 17000, 17000, 35000, 35000, 12, 11560, 4, 25000, 0, 0, 0, 1, 0, 0, 0, 0, -25, 0, 0, 'On update - summon creature');
INSERT INTO smart_scripts VALUES (177746, 1, 3, 0, 60, 0, 100, 0, 24000, 24000, 35000, 35000, 12, 11560, 4, 25000, 0, 0, 0, 1, 0, 0, 0, 8, 21, 0, 0, 'On update - summon creature');
INSERT INTO smart_scripts VALUES (177746, 1, 4, 0, 60, 0, 100, 0, 31000, 31000, 35000, 35000, 12, 11560, 4, 25000, 0, 0, 0, 1, 0, 0, 0, -20, 11, 0, 0, 'On update - summon creature');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=11560;
DELETE FROM smart_scripts WHERE entryorguid IN(11560) AND source_type=0;
INSERT INTO smart_scripts VALUES (11560, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 2, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'AI Init - Set faction');
INSERT INTO smart_scripts VALUES (11560, 0, 1, 2, 25, 0, 100, 0, 0, 0, 0, 0, 11, 17327, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast spell');
INSERT INTO smart_scripts VALUES (11560, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 18146, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cast spell');
INSERT INTO smart_scripts VALUES (11560, 0, 3, 0, 60, 0, 100, 1, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 20, 177746, 40, 0, 0, 0, 0, 0, 'Linked - Move to pos');
INSERT INTO smart_scripts VALUES (11560, 0, 4, 0, 0, 0, 100, 0, 10000, 15000, 45000, 50000, 11, 18159, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - cast spell');
INSERT INTO smart_scripts VALUES (11560, 0, 5, 6, 34, 0, 100, 1, 8, 0, 0, 0, 28, 17327, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Movement Inform - remove aura');
INSERT INTO smart_scripts VALUES (11560, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 11, 18951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Cast Spell');
INSERT INTO smart_scripts VALUES (11560, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set faction');

-- A Matter of Time (4971)
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(13, 17) AND SourceEntry=16613;
INSERT INTO conditions VALUES (17, 0, 16613, 0, 0, 28, 0, 4971, 0, 0, 1, 0, 0, '', 'Cant use Temporal Displacer, if player has quest objective completed, but not yet rewarded');
INSERT INTO conditions VALUES (13, 2, 16613, 0, 0, 31, 0, 5, 175795, 0, 0, 0, 0, '', 'Target silos');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=10717;
DELETE FROM smart_scripts WHERE entryorguid=10717 AND source_type=0;
INSERT INTO smart_scripts VALUES (10717, 0, 0, 0, 60, 0, 100, 257, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 175795, 15, 0, 0, 0, 0, 0, 'Temporal Parasite - On Update - Set Loot State');

-- Examine the Vessel (7785)
DELETE FROM gossip_menu WHERE entry IN(5779, 5780, 5781, 5783);
INSERT INTO gossip_menu VALUES (5779, 6954),(5780, 6955),(5781, 6956),(5783, 6958);
DELETE FROM gossip_menu_option WHERE menu_id IN(5703, 5779, 5780, 5781, 5783);
INSERT INTO gossip_menu_option VALUES (5703, 0, 0, "<Pass the Binding of the Windseeker>.", 1, 1, 5779, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES (5779, 0, 0, "What must be done?", 1, 1, 5780, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES (5780, 0, 0, "The Firelord and all who dare stand in my way shall reel from my wrath.", 1, 1, 5781, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES (5781, 0, 0, "I shall scour the earth for this Earthshaper. What of the essence?", 1, 1, 5783, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES (5783, 0, 0, "Give me the vessel, Highlord.", 1, 1, 0, 0, 0, 0, "");
UPDATE creature_template SET gossip_menu_id=5675, AIName='SmartAI', ScriptName='' WHERE entry=14347;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(5675, 5689, 5703);
INSERT INTO conditions VALUES (15, 5703, 0, 0, 0, 2, 0, 18563, 1, 0, 0, 0, 0, '', 'Has Item 18563');
INSERT INTO conditions VALUES (15, 5703, 0, 0, 1, 2, 0, 18564, 1, 0, 0, 0, 0, '', 'Has Item 18564');
INSERT INTO conditions VALUES (15, 5675, 0, 0, 0, 2, 0, 19016, 1, 0, 1, 0, 0, '', 'Do not have Item 18564');
INSERT INTO conditions VALUES (15, 5675, 0, 0, 0, 14, 0, 7785, 0, 0, 0, 0, 0, '', 'No status for quest examine the vessel');
DELETE FROM smart_scripts WHERE entryorguid=14347 AND source_type=0;
INSERT INTO smart_scripts VALUES (14347, 0, 0, 1, 62, 0, 100, 0, 5783, 0, 0, 0, 56, 19016, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Highlord Demitrian - On Gossip Complete - Add Item Vessel of Rebirth");
INSERT INTO smart_scripts VALUES (14347, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Highlord Demitrian - On Gossip Complete - Close Gossip");
INSERT INTO smart_scripts VALUES (14347, 0, 2, 0, 20, 0, 100, 0, 7786, 0, 0, 0, 12, 14435, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -6241.77, 1717.14, 4.25042, 0.680879, "Highlord Demitrian - On Quest Thunderaan the Windseeker Finished - Summon Creature Prince Thunderaan at XYZO");

-- Long Forgotten Memories (8305)
-- A Pawn on the Eternal Board (8519)
UPDATE gameobject_template SET faction=35 WHERE entry=180633;

-- One Shot. One Kill. (5713)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11711);
DELETE FROM creature_text WHERE entry=11711;
INSERT INTO creature_text VALUES(11711, 0, 0, "Wait... did you hear that? Something approaches from the west!", 12, 0, 100, 0, 0, 0, 0, 'Sentinel Aynasha');
INSERT INTO creature_text VALUES(11711, 1, 0, "I've run out of arrows! I'm afraid if any more come you will need to take them on by yourself my friend.", 12, 0, 100, 0, 0, 0, 0, 'Sentinel Aynasha');
INSERT INTO creature_text VALUES(11711, 2, 0, "Praise Elune! I don't know if I could have survived the day without you, friend.", 12, 0, 100, 0, 0, 0, 0, 'Sentinel Aynasha');
INSERT INTO creature_text VALUES(11711, 3, 0, "My legs feels much better now, the remedy must be working. If you will excuse me, I must go report to my superiors about what has transpired here.", 12, 0, 100, 0, 0, 0, 0, 'Sentinel Aynasha');
INSERT INTO creature_text VALUES(11711, 4, 0, "Please speak with Sentinel Onaeya at Maestra's Post in Ashenvale, she will see to it that you are properly rewarded for your bravery this day.", 12, 0, 100, 0, 0, 0, 0, 'Sentinel Aynasha');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=11711;
DELETE FROM smart_scripts WHERE entryorguid=11711 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=11711*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (11711, 0, 0, 0, 19, 0, 100, 0, 5713, 0, 0, 0, 80, 11711*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start Script');
-- INSERT INTO smart_scripts VALUES (11711, 0, 1, 2, 25, 0, 100, 0, 0, 0, 0, 0, 11, 18373, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (11711, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Linked - Set Sheath');
INSERT INTO smart_scripts VALUES (11711*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 0');
INSERT INTO smart_scripts VALUES (11711*100, 9, 1, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 11713, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4369, -51, 86.68, 5.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 11713, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4374, -48, 85.2, 5.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 3, 0, 0, 0, 100, 0, 50000, 50000, 0, 0, 12, 11713, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4369, -51, 86.68, 5.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 11713, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4374, -48, 85.2, 5.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 11713, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4361, -43, 84.86, 5.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 6, 0, 0, 0, 100, 0, 40000, 40000, 0, 0, 12, 11714, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 4361, -43, 84.86, 5.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (11711*100, 9, 7, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 2');
INSERT INTO smart_scripts VALUES (11711*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 26, 5713, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Quest credit on script invoker');
INSERT INTO smart_scripts VALUES (11711*100, 9, 9, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 3');
INSERT INTO smart_scripts VALUES (11711*100, 9, 10, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk 4');

-- Bodyguard for Hire (5821)
-- Gizelton Caravan (5943)
-- Delete paths from quest givers and kodos
DELETE FROM creature_text WHERE entry=11625;
INSERT INTO creature_text VALUES(11625, 0, 0, "So sorry to leave a customer but we have places to go and people to swindle. We will be back sometime later today. Good-bye!", 12, 0, 100, 0, 0, 0, 0, 'Cork Gizelton');
INSERT INTO creature_text VALUES(11625, 1, 0, "I am looking for some bodyguards that would like to protect the Gizelton Caravan. We are stopped on the road east of Kormek's Hut, north of Kolkar Centaur Village.", 14, 0, 100, 0, 0, 0, 0, 'Cork Gizelton');
DELETE FROM creature_text WHERE entry=11626;
INSERT INTO creature_text VALUES(11626, 0, 0, "Time for the Gizleton Caravan to head on out! We'll be back soon but if you cannot wait, head north to Kormek's Hut. We open shop in about an hour", 12, 0, 100, 0, 0, 0, 0, 'Rigger Gizelton');
INSERT INTO creature_text VALUES(11626, 1, 0, "This is Rigger Gizelton asking for assistance escorting my caravan past Mannoroc Coven. I'm on the road east of Shadowprey village.", 14, 0, 100, 0, 0, 0, 0, 'Rigger Gizelton');
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(12245, 12246));
DELETE FROM creature WHERE id IN(12245, 12246);
DELETE FROM creature_addon WHERE guid IN(27289, 27290, 28714, 28728);
DELETE FROM creature WHERE id IN(11625, 11626, 11564) AND guid IN(27289, 27290, 28714, 28728);
REPLACE INTO creature VALUES(28714, 11625, 1, 1, 1, 11629, 1, -1290.56, 1230.96, 109.39, 6.27641, 300, 0, 0, 1604, 0, 0, 0, 0, 0);
UPDATE creature_template SET speed_walk=1, ScriptName='npc_cork_gizelton' WHERE entry=11625;
UPDATE creature_template SET speed_walk=1.04 WHERE entry=11564;
UPDATE creature_template SET speed_walk=1.06, AIName='SmartAI' WHERE entry=11626;
DELETE FROM smart_scripts WHERE entryorguid=11626 AND source_type=0;
INSERT INTO smart_scripts VALUES (11626, 0, 0, 0, 19, 0, 100, 0, 5943, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 11625, 50, 0, 0, 0, 0, 0, 'On Quest Accept - Set data');
DELETE FROM script_waypoint WHERE entry=11625;
INSERT INTO script_waypoint VALUES (11625, 1, -1290.31, 1231.38, 109.237, 0, 'Desolace Caravan'),(11625, 2, -1277.59, 1225.54, 108.85, 0, 'Desolace Caravan'),(11625, 3, -1264.86, 1219.71, 108.452, 0, 'Desolace Caravan'),(11625, 4, -1230.04, 1204.31, 104.374, 0, 'Desolace Caravan'),(11625, 5, -1216.17, 1206.24, 101.889, 0, 'Desolace Caravan'),(11625, 6, -1202.32, 1208.28, 99.7026, 0, 'Desolace Caravan'),(11625, 7, -1188.03, 1207.66, 97.2208, 0, 'Desolace Caravan'),(11625, 8, -1170.99, 1195.93, 94.5615, 0, 'Desolace Caravan'),(11625, 9, -1155.46, 1192.16, 92.4374, 0, 'Desolace Caravan'),(11625, 10, -1127.52, 1190.39, 89.8358, 0, 'Desolace Caravan'),(11625, 11, -1113.58, 1189.12, 89.7403, 0, 'Desolace Caravan'),(11625, 12, -1070.8, 1186.15, 89.7403, 0, 'Desolace Caravan'),(11625, 13, -1037.27, 1183.2, 89.8006, 0, 'Desolace Caravan'),(11625, 14, -995.58, 1177.92, 89.7409, 0, 'Desolace Caravan'),(11625, 15, -981.817, 1180.48, 89.8152, 0, 'Desolace Caravan'),(11625, 16, -952.606, 1181.99, 89.7313, 0, 'Desolace Caravan'),(11625, 17, -935.445, 1182.25, 91.2113, 0, 'Desolace Caravan'),(11625, 18, -921.448, 1182.53, 93.1746, 0, 'Desolace Caravan'),(11625, 19, -879.467, 1183.72, 97.6043, 0, 'Desolace Caravan'),(11625, 20, -858.976, 1184.22, 99.0322, 0, 'Desolace Caravan'),(11625, 21, -828.316, 1180.2, 99.6657, 0, 'Desolace Caravan'),
(11625, 22, -799.811, 1176, 99.3364, 0, 'Desolace Caravan'),(11625, 23, -757.106, 1191.47, 96.9164, 0, 'Desolace Caravan'),(11625, 24, -731.879, 1208.14, 92.6956, 0, 'Desolace Caravan'),(11625, 25, -719.12, 1213.91, 91.3297, 0, 'Desolace Caravan'),(11625, 26, -706.36, 1219.67, 90.2856, 0, 'Desolace Caravan'),(11625, 27, -689.935, 1228.43, 89.4426, 0, 'Desolace Caravan'),(11625, 28, -679.121, 1237.31, 89.17, 0, 'Desolace Caravan'),(11625, 29, -661.434, 1247.28, 89.17, 0, 'Desolace Caravan'),(11625, 30, -635.655, 1258.2, 89.2063, 0, 'Desolace Caravan'),(11625, 31, -614.489, 1269.64, 89.1686, 0, 'Desolace Caravan'),(11625, 32, -600.078, 1274.85, 89.1238, 0, 'Desolace Caravan'),(11625, 33, -586.268, 1277.15, 89.145, 0, 'Desolace Caravan'),(11625, 34, -546.297, 1287.15, 89.1597, 0, 'Desolace Caravan'),(11625, 35, -541.257, 1300.21, 89.1602, 0, 'Desolace Caravan'),(11625, 36, -536.026, 1313.2, 89.1314, 0, 'Desolace Caravan'),(11625, 37, -525.098, 1338.97, 89.1005, 0, 'Desolace Caravan'),(11625, 38, -518.852, 1356.12, 89.0827, 0, 'Desolace Caravan'),(11625, 39, -516.879, 1395.56, 89.0827, 0, 'Desolace Caravan'),(11625, 40, -518.905, 1436.25, 89.0696, 0, 'Desolace Caravan'),(11625, 41, -525.605, 1446.54, 88.4907, 0, 'Desolace Caravan'),(11625, 42, -543.459, 1462.9, 88.3752, 0, 'Desolace Caravan'),(11625, 43, -557.591, 1471.17, 88.9477, 0, 'Desolace Caravan'),
(11625, 44, -584.698, 1478.14, 88.3754, 0, 'Desolace Caravan'),(11625, 45, -598.459, 1480.72, 88.3754, 0, 'Desolace Caravan'),(11625, 46, -632.084, 1491.03, 88.3754, 0, 'Desolace Caravan'),(11625, 47, -644.249, 1497.95, 88.3754, 0, 'Desolace Caravan'),(11625, 48, -660.456, 1507.56, 88.3874, 0, 'Desolace Caravan'),(11625, 49, -666.507, 1504.7, 89.0746, 0, 'Desolace Caravan'),(11625, 50, -673.795, 1499.48, 90.3922, 0, 'Desolace Caravan'),(11625, 51, -692.154, 1480.43, 90.5302, 0, 'Desolace Caravan'),(11625, 52, -710.764, 1470.11, 91.3034, 0, 'Desolace Caravan'),(11625, 53, -697.048, 1484.75, 91.0929, 0, 'Desolace Caravan'),(11625, 54, -676.552, 1497.37, 90.6505, 0, 'Desolace Caravan'),(11625, 55, -665.209, 1505.76, 88.8321, 0, 'Desolace Caravan'),(11625, 56, -657.898, 1510.94, 88.3752, 0, 'Desolace Caravan'),(11625, 57, -647.387, 1501.69, 88.3752, 0, 'Desolace Caravan'),(11625, 58, -630.597, 1491.17, 88.3752, 0, 'Desolace Caravan'),(11625, 59, -603.756, 1483.26, 88.3752, 0, 'Desolace Caravan'),(11625, 60, -576.573, 1476.54, 88.3752, 0, 'Desolace Caravan'),(11625, 61, -556.868, 1470.92, 88.8685, 0, 'Desolace Caravan'),(11625, 62, -547.471, 1464.89, 88.3747, 0, 'Desolace Caravan'),(11625, 63, -529.316, 1449.97, 88.402, 0, 'Desolace Caravan'),(11625, 64, -517.699, 1433.75, 89.0816, 0, 'Desolace Caravan'),(11625, 65, -518.09, 1405.76, 89.0816, 0, 'Desolace Caravan'),(11625, 66, -518.149, 1377.76, 89.0816, 0, 'Desolace Caravan'),
(11625, 67, -521.289, 1350.76, 89.0816, 0, 'Desolace Caravan'),(11625, 68, -531.625, 1324.74, 89.1339, 0, 'Desolace Caravan'),(11625, 69, -537.391, 1311.99, 89.1594, 0, 'Desolace Caravan'),(11625, 70, -551.845, 1284.12, 89.1594, 0, 'Desolace Caravan'),(11625, 71, -578.054, 1278.57, 89.1685, 0, 'Desolace Caravan'),(11625, 72, -591.957, 1276.92, 89.1634, 0, 'Desolace Caravan'),(11625, 73, -611.806, 1271.05, 89.1694, 0, 'Desolace Caravan'),(11625, 74, -623.928, 1264.06, 89.1694, 0, 'Desolace Caravan'),(11625, 75, -653.384, 1249.74, 89.1694, 0, 'Desolace Caravan'),(11625, 76, -666.372, 1244.51, 89.1694, 0, 'Desolace Caravan'),(11625, 77, -684.6, 1232.06, 89.2134, 0, 'Desolace Caravan'),(11625, 78, -694.027, 1225.67, 89.6627, 0, 'Desolace Caravan'),(11625, 79, -706.605, 1219.58, 90.2981, 0, 'Desolace Caravan'),(11625, 80, -732.184, 1208.23, 92.7376, 0, 'Desolace Caravan'),(11625, 81, -738.514, 1204.75, 93.8662, 0, 'Desolace Caravan'),(11625, 82, -754.159, 1193.91, 96.6195, 0, 'Desolace Caravan'),(11625, 83, -766.62, 1187.59, 97.8394, 0, 'Desolace Caravan'),(11625, 84, -792.515, 1177.07, 98.8327, 0, 'Desolace Caravan'),(11625, 85, -802.533, 1175.57, 99.4435, 0, 'Desolace Caravan'),(11625, 86, -821.772, 1178.84, 99.6542, 0, 'Desolace Caravan'),(11625, 87, -835.435, 1181.9, 99.6662, 0, 'Desolace Caravan'),(11625, 88, -848.98, 1184.67, 99.5782, 0, 'Desolace Caravan'),(11625, 89, -861.251, 1185.3, 98.8033, 0, 'Desolace Caravan'),
(11625, 90, -889.179, 1183.34, 96.6117, 0, 'Desolace Caravan'),(11625, 91, -903.158, 1182.57, 95.2033, 0, 'Desolace Caravan'),(11625, 92, -931.15, 1182.17, 91.8346, 0, 'Desolace Caravan'),(11625, 93, -945.149, 1182.01, 89.8612, 0, 'Desolace Caravan'),(11625, 94, -959.149, 1181.92, 89.7397, 0, 'Desolace Caravan'),(11625, 95, -973.149, 1181.97, 89.7397, 0, 'Desolace Caravan'),(11625, 96, -1001.65, 1178.06, 89.7398, 0, 'Desolace Caravan'),(11625, 97, -1011.8, 1177.4, 89.7398, 0, 'Desolace Caravan'),(11625, 98, -1033.08, 1182.29, 89.7629, 0, 'Desolace Caravan'),(11625, 99, -1073.62, 1186.33, 89.7398, 0, 'Desolace Caravan'),(11625, 100, -1101.59, 1187.56, 89.7398, 0, 'Desolace Caravan'),(11625, 101, -1129.48, 1190.01, 89.8855, 0, 'Desolace Caravan'),(11625, 102, -1143.44, 1191.11, 91.0344, 0, 'Desolace Caravan'),(11625, 103, -1166.85, 1194.28, 93.9649, 0, 'Desolace Caravan'),(11625, 104, -1184.71, 1203.56, 96.6406, 0, 'Desolace Caravan'),(11625, 105, -1201.45, 1208.2, 99.5698, 0, 'Desolace Caravan'),(11625, 106, -1225.42, 1204.68, 103.502, 0, 'Desolace Caravan'),(11625, 107, -1235.55, 1206.75, 105.129, 0, 'Desolace Caravan'),(11625, 108, -1261.05, 1218.25, 108.207, 0, 'Desolace Caravan'),(11625, 109, -1286.64, 1229.58, 109.112, 0, 'Desolace Caravan'),(11625, 110, -1306.84, 1233.21, 109.771, 0, 'Desolace Caravan'),(11625, 111, -1331.25, 1233.54, 110.674, 0, 'Desolace Caravan'),(11625, 112, -1350.02, 1227.22, 111.201, 0, 'Desolace Caravan'),
(11625, 113, -1389.37, 1212.53, 111.587, 0, 'Desolace Caravan'),(11625, 114, -1415.8, 1202.23, 111.948, 0, 'Desolace Caravan'),(11625, 115, -1424.26, 1196.81, 112.038, 0, 'Desolace Caravan'),(11625, 116, -1449.27, 1188.13, 111.53, 0, 'Desolace Caravan'),(11625, 117, -1474.53, 1186.42, 109.366, 0, 'Desolace Caravan'),(11625, 118, -1491.78, 1189.4, 106.114, 0, 'Desolace Caravan'),(11625, 119, -1502.95, 1198.12, 101.757, 0, 'Desolace Caravan'),(11625, 120, -1512.09, 1209.44, 96.2469, 0, 'Desolace Caravan'),(11625, 121, -1520.19, 1226.67, 89.7861, 0, 'Desolace Caravan'),(11625, 122, -1522.75, 1243.63, 83.3864, 0, 'Desolace Caravan'),(11625, 123, -1520.9, 1257.51, 77.7027, 0, 'Desolace Caravan'),(11625, 124, -1518.48, 1273.17, 71.8991, 0, 'Desolace Caravan'),(11625, 125, -1516.17, 1290.94, 66.8473, 0, 'Desolace Caravan'),(11625, 126, -1514.74, 1306.19, 63.4211, 0, 'Desolace Caravan'),(11625, 127, -1511.54, 1328.73, 60.2051, 0, 'Desolace Caravan'),(11625, 128, -1505.75, 1341.47, 59.2142, 0, 'Desolace Caravan'),(11625, 129, -1494.42, 1367.08, 58.9254, 0, 'Desolace Caravan'),(11625, 130, -1485.84, 1393.02, 58.9251, 0, 'Desolace Caravan'),(11625, 131, -1485.47, 1407, 58.9469, 0, 'Desolace Caravan'),(11625, 132, -1487.57, 1434.84, 58.9347, 0, 'Desolace Caravan'),(11625, 133, -1489.45, 1448.71, 58.9302, 0, 'Desolace Caravan'),(11625, 134, -1489.77, 1469.49, 58.9251, 0, 'Desolace Caravan'),(11625, 135, -1483.8, 1482.15, 58.9251, 0, 'Desolace Caravan'),(11625, 136, -1471.32, 1507.22, 58.9251, 0, 'Desolace Caravan'),
(11625, 137, -1464.94, 1519.68, 58.9251, 0, 'Desolace Caravan'),(11625, 138, -1452.27, 1544.64, 58.9251, 0, 'Desolace Caravan'),(11625, 139, -1442.94, 1584.75, 58.9255, 0, 'Desolace Caravan'),(11625, 140, -1452.7, 1610.98, 58.9255, 0, 'Desolace Caravan'),(11625, 141, -1464.1, 1641.7, 58.9255, 0, 'Desolace Caravan'),(11625, 142, -1474.86, 1647.49, 58.9255, 0, 'Desolace Caravan'),(11625, 143, -1500.84, 1657.91, 58.9255, 0, 'Desolace Caravan'),(11625, 144, -1521.76, 1671.96, 58.9255, 0, 'Desolace Caravan'),(11625, 145, -1541.37, 1691.94, 58.9255, 0, 'Desolace Caravan'),(11625, 146, -1551.2, 1701.92, 58.9255, 0, 'Desolace Caravan'),(11625, 147, -1571.41, 1721.29, 58.9255, 0, 'Desolace Caravan'),(11625, 148, -1592.97, 1739.14, 58.9255, 0, 'Desolace Caravan'),(11625, 149, -1613.28, 1758.07, 58.9255, 0, 'Desolace Caravan'),(11625, 150, -1630.32, 1780.27, 58.9255, 0, 'Desolace Caravan'),(11625, 151, -1645.92, 1803.52, 58.9296, 0, 'Desolace Caravan'),(11625, 152, -1661.7, 1826.65, 58.9271, 0, 'Desolace Caravan'),(11625, 153, -1681.42, 1858.29, 58.9271, 0, 'Desolace Caravan'),(11625, 154, -1686.38, 1877.21, 59.2059, 0, 'Desolace Caravan'),(11625, 155, -1692.06, 1899.02, 60.7504, 0, 'Desolace Caravan'),(11625, 156, -1699.45, 1908.31, 61.1412, 0, 'Desolace Caravan'),(11625, 157, -1717, 1915.93, 60.0908, 0, 'Desolace Caravan'),(11625, 158, -1738.04, 1917.48, 59.0673, 0, 'Desolace Caravan'),(11625, 159, -1757.16, 1918.92, 58.9757, 0, 'Desolace Caravan'),(11625, 160, -1772.71, 1926.58, 59.1537, 0, 'Desolace Caravan'),
(11625, 161, -1791.81, 1939.62, 60.7298, 0, 'Desolace Caravan'),(11625, 162, -1802.7, 1951.89, 60.7237, 0, 'Desolace Caravan'),(11625, 163, -1809.79, 1963.96, 59.7477, 0, 'Desolace Caravan'),(11625, 164, -1815.2, 1976.74, 59.0006, 0, 'Desolace Caravan'),(11625, 165, -1817.51, 2008.7, 59.5336, 0, 'Desolace Caravan'),(11625, 166, -1823, 2032.7, 60.6767, 0, 'Desolace Caravan'),(11625, 167, -1821.87, 2042.21, 60.944, 0, 'Desolace Caravan'),(11625, 168, -1813.14, 2068.68, 63.0096, 0, 'Desolace Caravan'),(11625, 169, -1810.52, 2082.43, 63.114, 0, 'Desolace Caravan'),(11625, 170, -1806.9, 2095.9, 63.1144, 0, 'Desolace Caravan'),(11625, 171, -1802.03, 2111.56, 63.6862, 0, 'Desolace Caravan'),(11625, 172, -1802.03, 2111.56, 63.6862, 0, 'Desolace Caravan'),(11625, 173, -1801.53, 2141.07, 63.006, 0, 'Desolace Caravan'),(11625, 174, -1801.53, 2141.07, 63.006, 0, 'Desolace Caravan'),(11625, 175, -1802.25, 2155.05, 61.5195, 0, 'Desolace Caravan'),(11625, 176, -1803.02, 2183.03, 59.8215, 0, 'Desolace Caravan'),(11625, 177, -1808.36, 2207.2, 59.8215, 0, 'Desolace Caravan'),(11625, 178, -1822.66, 2219.86, 59.8215, 0, 'Desolace Caravan'),(11625, 179, -1836.76, 2232.87, 59.8215, 0, 'Desolace Caravan'),(11625, 180, -1843.44, 2245.11, 59.8215, 0, 'Desolace Caravan'),(11625, 181, -1844.75, 2266.9, 59.8215, 0, 'Desolace Caravan'),(11625, 182, -1846.34, 2280.81, 59.8215, 0, 'Desolace Caravan'),(11625, 183, -1849.89, 2294.13, 59.8215, 0, 'Desolace Caravan'),(11625, 184, -1864.58, 2316.31, 59.8215, 0, 'Desolace Caravan'),
(11625, 185, -1872.72, 2327.7, 59.8224, 0, 'Desolace Caravan'),(11625, 186, -1884.98, 2346.82, 59.8224, 0, 'Desolace Caravan'),(11625, 187, -1887.2, 2354.3, 59.8696, 0, 'Desolace Caravan'),(11625, 188, -1893.87, 2379.11, 59.9196, 0, 'Desolace Caravan'),(11625, 189, -1900.07, 2391.67, 59.8224, 0, 'Desolace Caravan'),(11625, 190, -1904, 2405.04, 59.8224, 0, 'Desolace Caravan'),(11625, 191, -1904, 2405.04, 59.8224, 0, 'Desolace Caravan'),(11625, 192, -1895.71, 2431.78, 59.8224, 0, 'Desolace Caravan'),(11625, 193, -1888.72, 2458.89, 59.8224, 0, 'Desolace Caravan'),(11625, 194, -1895.4, 2432.5, 59.8224, 0, 'Desolace Caravan'),(11625, 195, -1899.03, 2418.98, 59.8224, 0, 'Desolace Caravan'),(11625, 196, -1899.68, 2393.35, 59.8224, 0, 'Desolace Caravan'),(11625, 197, -1892.03, 2375.61, 59.9178, 0, 'Desolace Caravan'),(11625, 198, -1885.29, 2346.94, 59.8216, 0, 'Desolace Caravan'),(11625, 199, -1881.12, 2339.05, 59.8216, 0, 'Desolace Caravan'),(11625, 200, -1864.4, 2316.59, 59.8226, 0, 'Desolace Caravan'),(11625, 201, -1852.79, 2300.12, 59.8226, 0, 'Desolace Caravan'),(11625, 202, -1847.08, 2287.99, 59.8226, 0, 'Desolace Caravan'),(11625, 203, -1844.34, 2264.2, 59.8226, 0, 'Desolace Caravan'),(11625, 204, -1842.38, 2243.22, 59.8226, 0, 'Desolace Caravan'),(11625, 205, -1840.11, 2237.75, 59.8226, 0, 'Desolace Caravan'),(11625, 206, -1830.64, 2226.2, 59.8226, 0, 'Desolace Caravan'),(11625, 207, -1810.22, 2209.43, 59.8226, 0, 'Desolace Caravan'),(11625, 208, -1802.8, 2194.02, 59.8226, 0, 'Desolace Caravan'),
(11625, 209, -1800.41, 2180.08, 59.8226, 0, 'Desolace Caravan'),(11625, 210, -1800.26, 2166.08, 60.1822, 0, 'Desolace Caravan'),(11625, 211, -1801.62, 2148.85, 62.344, 0, 'Desolace Caravan'),(11625, 212, -1801.15, 2134.86, 63.1766, 0, 'Desolace Caravan'),(11625, 213, -1802.26, 2110.11, 63.6737, 0, 'Desolace Caravan'),(11625, 214, -1805.87, 2096.6, 63.1784, 0, 'Desolace Caravan'),(11625, 215, -1809.25, 2083.01, 63.0772, 0, 'Desolace Caravan'),(11625, 216, -1812.63, 2069.43, 63.043, 0, 'Desolace Caravan'),(11625, 217, -1816.72, 2056.04, 61.8496, 0, 'Desolace Caravan'),(11625, 218, -1822.89, 2032.23, 60.6524, 0, 'Desolace Caravan'),(11625, 219, -1822.76, 2027.39, 60.3783, 0, 'Desolace Caravan'),(11625, 220, -1815.56, 2003.46, 59.4022, 0, 'Desolace Caravan'),(11625, 221, -1814.41, 1983.18, 58.9549, 0, 'Desolace Caravan'),(11625, 222, -1811.8, 1967.01, 59.4735, 0, 'Desolace Caravan'),(11625, 223, -1803.12, 1951.78, 60.7154, 0, 'Desolace Caravan'),(11625, 224, -1793.24, 1941.87, 60.8439, 0, 'Desolace Caravan'),(11625, 225, -1775.92, 1926.82, 59.3033, 0, 'Desolace Caravan'),(11625, 226, -1759.93, 1918.92, 58.9613, 0, 'Desolace Caravan'),(11625, 227, -1751.9, 1917.2, 59.0003, 0, 'Desolace Caravan'),(11625, 228, -1737.91, 1917.04, 59.0673, 0, 'Desolace Caravan'),(11625, 229, -1712.18, 1914.85, 60.4394, 0, 'Desolace Caravan'),(11625, 230, -1701.72, 1911.02, 61.0949, 0, 'Desolace Caravan'),(11625, 231, -1694.06, 1904.03, 61.03, 0, 'Desolace Caravan'),(11625, 232, -1687.1, 1886.34, 59.7501, 0, 'Desolace Caravan'),
(11625, 233, -1684.12, 1872.66, 59.0354, 0, 'Desolace Caravan'),(11625, 234, -1673.14, 1845.28, 58.9273, 0, 'Desolace Caravan'),(11625, 235, -1657.63, 1821.97, 58.9273, 0, 'Desolace Caravan'),(11625, 236, -1649.83, 1810.34, 58.9273, 0, 'Desolace Caravan'),(11625, 237, -1634.24, 1787.08, 58.9252, 0, 'Desolace Caravan'),(11625, 238, -1626.45, 1775.45, 58.9252, 0, 'Desolace Caravan'),(11625, 239, -1605.77, 1750.66, 58.9256, 0, 'Desolace Caravan'),(11625, 240, -1594.91, 1741.83, 58.9256, 0, 'Desolace Caravan'),(11625, 241, -1573.31, 1724.02, 58.9256, 0, 'Desolace Caravan'),(11625, 242, -1553.4, 1704.35, 58.9256, 0, 'Desolace Caravan'),(11625, 243, -1543.67, 1694.29, 58.9256, 0, 'Desolace Caravan'),(11625, 244, -1523.39, 1674.99, 58.9256, 0, 'Desolace Caravan'),(11625, 245, -1505.1, 1659.98, 58.9256, 0, 'Desolace Caravan'),(11625, 246, -1489.89, 1652.47, 58.9256, 0, 'Desolace Caravan'),(11625, 247, -1460.15, 1634.27, 58.9256, 0, 'Desolace Caravan'),(11625, 248, -1453.16, 1621.35, 58.9256, 0, 'Desolace Caravan'),(11625, 249, -1446.87, 1598.31, 58.9256, 0, 'Desolace Caravan'),(11625, 250, -1440.81, 1573.28, 58.9256, 0, 'Desolace Caravan'),(11625, 251, -1445.9, 1553.99, 58.9256, 0, 'Desolace Caravan'),(11625, 252, -1451.91, 1541.35, 58.9256, 0, 'Desolace Caravan'),(11625, 253, -1458.46, 1528.97, 58.9256, 0, 'Desolace Caravan'),(11625, 254, -1471.62, 1504.26, 58.9256, 0, 'Desolace Caravan'),
(11625, 255, -1478.08, 1491.84, 58.9256, 0, 'Desolace Caravan'),(11625, 256, -1490.08, 1466.54, 58.9256, 0, 'Desolace Caravan'),(11625, 257, -1491.71, 1455.14, 58.9291, 0, 'Desolace Caravan'),(11625, 258, -1488.22, 1427.36, 58.9348, 0, 'Desolace Caravan'),(11625, 259, -1486.41, 1413.48, 58.9418, 0, 'Desolace Caravan'),(11625, 260, -1487.62, 1388.44, 58.9251, 0, 'Desolace Caravan'),(11625, 261, -1491.84, 1375.08, 58.9301, 0, 'Desolace Caravan'),(11625, 262, -1502.72, 1349.31, 58.9416, 0, 'Desolace Caravan'),(11625, 263, -1508.49, 1336.58, 59.525, 0, 'Desolace Caravan'),(11625, 264, -1511.68, 1327.41, 60.3754, 0, 'Desolace Caravan'),(11625, 265, -1514.03, 1314.22, 62.0185, 0, 'Desolace Caravan'),(11625, 266, -1514.79, 1300.27, 64.5471, 0, 'Desolace Caravan'),(11625, 267, -1516.1, 1286.34, 68.0841, 0, 'Desolace Caravan'),(11625, 268, -1518.52, 1272.55, 72.0932, 0, 'Desolace Caravan'),(11625, 269, -1523.17, 1245.16, 82.7876, 0, 'Desolace Caravan'),(11625, 270, -1522.5, 1234.75, 87.008, 0, 'Desolace Caravan'),(11625, 271, -1517.95, 1221.51, 91.5343, 0, 'Desolace Caravan'),(11625, 272, -1511.76, 1208.2, 96.7403, 0, 'Desolace Caravan'),(11625, 273, -1501.33, 1196.53, 102.475, 0, 'Desolace Caravan'),(11625, 274, -1490.76, 1188.95, 106.376, 0, 'Desolace Caravan'),(11625, 275, -1475.92, 1185.48, 109.181, 0, 'Desolace Caravan'),(11625, 276, -1452.6, 1187.95, 111.422, 0, 'Desolace Caravan'),
(11625, 277, -1433.28, 1193.58, 111.857, 0, 'Desolace Caravan'),(11625, 278, -1414.55, 1203.63, 111.886, 0, 'Desolace Caravan'),(11625, 279, -1388.31, 1213.37, 111.599, 0, 'Desolace Caravan'),(11625, 280, -1375.11, 1218.03, 111.465, 0, 'Desolace Caravan'),(11625, 281, -1348.49, 1226.69, 111.175, 0, 'Desolace Caravan'),(11625, 282, -1319.41, 1232.27, 110.201, 0, 'Desolace Caravan');
-- Ambush
UPDATE creature_template SET AIName='CombatAI' WHERE entry IN(12976, 12977, 4684);

-- Deeprun Rat Roundup (6661)
UPDATE quest_template SET RequiredNpcOrGo1=12997 WHERE Id=6661;
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(13016, 12997);
DELETE FROM smart_scripts WHERE entryorguid IN (13016, 13017, 12997) AND source_type=0;
INSERT INTO smart_scripts VALUES (12997, 0, 0, 1, 10, 0, 100, 0, 1, 8, 2000, 2000, 11, 21052, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Monty - On OOC Los - Cast Bash');
INSERT INTO smart_scripts VALUES (12997, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Monty - On Reward Quest - Talk');
INSERT INTO smart_scripts VALUES (13016, 0, 0, 1, 8, 0, 100, 0, 21050, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Deeprun Rat - On Spellhit - Follow Player');
INSERT INTO smart_scripts VALUES (13016, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 36, 13017, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deeprun Rat - On Spellhit - Update Template');
INSERT INTO smart_scripts VALUES (13016, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 33, 12997, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Deeprun Rat - On Spellhit - Quest Credit');
INSERT INTO smart_scripts VALUES (13016, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 21051, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deeprun Rat - On Spellhit - Cast Spell');
INSERT INTO smart_scripts VALUES (13016, 0, 4, 0, 8, 0, 100, 0, 21052, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deeprun Rat - On Spellhit - Die');
DELETE FROM creature_text WHERE entry=12997;
INSERT INTO creature_text VALUES (12997, 0, 0, 'Into the box me pretties! Thats it. One by one ye go.',12, 0, 100, 0, 0, 0, 0, 'Monty');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=21052;
INSERT INTO conditions VALUES (13, 1, 21052, 0, 0, 31, 0, 3, 13017, 0, 0, 0, 0, '', 'Spell Bash target rats');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=21050;
INSERT INTO conditions VALUES (17, 0, 21050, 0, 0, 31, 1, 3, 13016, 0, 0, 0, 0, '', 'target rats');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=12997;
INSERT INTO conditions VALUES (22, 1, 12997, 0, 0, 31, 0, 3, 13017, 0, 0, 0, 0, '', 'Required Friendly Rat');

-- Trek to Ashenvale (990), spawn after completing 986
REPLACE INTO smart_scripts VALUES(3693, 0, 2, 4, 20, 0, 100, 0, 994, 0, 0, 0, 12, 3694, 1, 240000, 0, 0, 0, 8, 0, 0, 0, 6439, 362, 13.95, 2.2, 'On Quest Complete - Summon Sentinel Selarin');
REPLACE INTO smart_scripts VALUES(3693, 0, 3, 4, 20, 0, 100, 0, 995, 0, 0, 0, 12, 3694, 1, 240000, 0, 0, 0, 8, 0, 0, 0, 6439, 362, 13.95, 2.2, 'On Quest Complete - Summon Sentinel Selarin');
REPLACE INTO smart_scripts VALUES(3693, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 3694, 15, 0, 0, 0, 0, 0, 'Linked - Force Despawn target');

-- King of the Foulweald (6621)
REPLACE INTO smart_scripts VALUES(3749, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'On Reset - Attack Player, conditioned');
REPLACE INTO smart_scripts VALUES(3743, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'On Reset - Attack Player, conditioned');
REPLACE INTO smart_scripts VALUES(3750, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'On Reset - Attack Player, conditioned');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=12918;
DELETE FROM creature_text WHERE entry=12918;
INSERT INTO creature_text VALUES(12918, 0, 0, "You are a little gnat to the Foulweald! Die!", 12, 0, 100, 0, 0, 0, 0, 'King of the Foulweald');
INSERT INTO creature_text VALUES(12918, 1, 0, "No! You cannot be stronger than the Foulweald! No!!", 12, 0, 100, 0, 0, 0, 0, 'King of the Foulweald');
DELETE FROM smart_scripts WHERE entryorguid IN(12918) AND source_type=0;
INSERT INTO smart_scripts VALUES(12918, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 'On Reset - Attack Player, conditioned');
INSERT INTO smart_scripts VALUES(12918, 0, 1, 0, 25, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Talk');
INSERT INTO smart_scripts VALUES(12918, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 11, 20818, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Death - Cast Spell');
INSERT INTO smart_scripts VALUES(12918, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death, Linked - Talk');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry IN(3749, 3743, 3750, 12918);
INSERT INTO conditions VALUES (22, 5, 3749, 0, 0, 30, 1, 178205, 60, 0, 0, 0, 0, '', 'Requires GO in range');
INSERT INTO conditions VALUES (22, 3, 3743, 0, 0, 30, 1, 178205, 60, 0, 0, 0, 0, '', 'Requires GO in range');
INSERT INTO conditions VALUES (22, 4, 3750, 0, 0, 30, 1, 178205, 60, 0, 0, 0, 0, '', 'Requires GO in range');
INSERT INTO conditions VALUES (22, 1, 12918, 0, 0, 30, 1, 178205, 60, 0, 0, 0, 0, '', 'Requires GO in range');

-- Gerenzo's Orders (1090)
DELETE FROM creature_text WHERE entry=4276;
INSERT INTO creature_text VALUES(4276, 0, 0, 'Watch out for the Kobolds!', 12, 0, 100, 0, 0, 0, 0, 'Piznik');
INSERT INTO creature_text VALUES(4276, 1, 0, "I'm getting close!", 12, 0, 100, 0, 0, 0, 0, 'Piznik');
INSERT INTO creature_text VALUES(4276, 2, 0, "Yay! I have found it!", 12, 0, 100, 0, 0, 0, 0, 'Piznik');
UPDATE creature_template SET faction=42, AIName='SmartAI', ScriptName='' WHERE entry=4276;
DELETE FROM smart_scripts WHERE entryorguid=4276 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=4276*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (4276, 0, 0, 0, 19, 0, 100, 0, 1090, 0, 0, 0, 80, 4276*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Script9');
INSERT INTO smart_scripts VALUES (4276*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove NPC Immune Flag');
INSERT INTO smart_scripts VALUES (4276*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove NPC Flags');
INSERT INTO smart_scripts VALUES (4276*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (4276*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 5, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 7, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 9, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (4276*100, 9, 12, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 14, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 16, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 3998, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 956.209, -260.946, -4.515244, 6.022552, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 4001, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 957.395, -258.515, -4.177891, 5.508116, 'Script9 - Summon creature');
INSERT INTO smart_scripts VALUES (4276*100, 9, 18, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (4276*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 26, 1090, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Area Explored');
INSERT INTO smart_scripts VALUES (4276*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Immune Flag');
INSERT INTO smart_scripts VALUES (4276*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flags');

-- Stave of the Ancients (7636)
UPDATE creature_template SET faction=25, npcflag=0, AIName='', ScriptName='npc_stave_of_the_ancients' WHERE entry IN(14527, 14529, 14531, 14536, 14528);
DELETE FROM smart_scripts WHERE entryorguid IN(14527, 14529, 14531, 14536, 14528) AND source_type=0;
UPDATE creature_template SET unit_class=2 WHERE entry IN(14527, 14536, 14533, 14530);

-- The Balance of Light and Shadow (7622)
DELETE FROM creature_text WHERE entry IN(14484, 14485, 14494);
INSERT INTO creature_text VALUES(14484, 0, 0, 'The Scourge are upon us! Run! Run for your lives!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14484, 0, 1, 'Please help up! The Prince has gone mad!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14484, 0, 2, 'Seek Sanctuary in Hearthglen! Its our only hope!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14485, 0, 0, 'The Scourge are upon us! Run! Run for your lives!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14485, 0, 1, 'Please help up! The Prince has gone mad!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14485, 0, 2, 'Seek Sanctuary in Hearthglen! Its our only hope!', 14, 0, 100, 0, 0, 0, 0, 'Injured Peasant');
INSERT INTO creature_text VALUES(14494, 0, 0, 'Be healed!', 14, 0, 100, 0, 0, 0, 0, 'Eris');
INSERT INTO creature_text VALUES(14494, 1, 0, 'We are saved! The peasants have escaped the Scourge!', 14, 0, 100, 0, 0, 0, 0, 'Eris');
INSERT INTO creature_text VALUES(14494, 2, 0, 'We Failed! The peasants were not saved!', 14, 0, 100, 0, 0, 0, 0, 'Eris');
REPLACE INTO npc_text VALUES(40101, "Praise the Light, one has finally answered the calling.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO npc_text VALUES(40102, "<Eris nods>$B$BThe Eye has seen so many horrors and wonders.$B$BIt displays what it feels the one looking into it is most suited to see.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO npc_text VALUES(40103, "You were. The Eye is never wrong.$B$BYou are a $c after all. A powerful $c, if the Eye showed you this horrible memory.$B$BYou have come for redemption, yet you yourself do not realize this... Do you?", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO npc_text VALUES(40104, "I know you will, $N.$B$BI myself am a priestess, though, unlike you I am long since gone from this world. My spirit, however, remains here, as do the spirits of the thousands who were brutally slain by the mad Prince, Arthas Menethil and his legion of undeath.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO npc_text VALUES(40105, "I never stated that you were here to redeem yourself, $c. You are here to redeem me and the innocents murdered while trying to escape Stratholme.$B$BMy spirit and the spirit of those lost are bound here, cursed to endlessly relive our own tragic deaths.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO npc_text VALUES(40106, "You must do what I could not: Save the peasants that were cut down while fleeing from Stratholme.$B$BThey will walk towards the light, you must ensure their survival. Should too many fall, our cursed existence shall continue - you will have failed.$B$BEvery ability, prayer and spell that you have learned will be tested. May the Light protect you, $N.", '', 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
REPLACE INTO gossip_menu VALUES(30212, 40101),(30213, 40102),(30214, 40103),(30215, 40104),(30216, 40105),(30217, 40106);
REPLACE INTO gossip_menu_option VALUES(30212, 0, 0, 'The Eye led me here, Eris.', 1, 1, 30213, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES(30213, 0, 0, 'And I was suited to see this?', 1, 1, 30214, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES(30214, 0, 0, 'I really did not know what to expect, Eris. I will use my powers to assist you if that is what is asked of me.', 1, 1, 30215, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES(30215, 0, 0, 'Those days are over, Eris.', 1, 1, 30216, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES(30216, 0, 0, 'So what can I do to help?', 1, 1, 30217, 0, 0, 0, '');
UPDATE creature_template SET faction=35, gossip_menu_id=30212, npcflag=3, ScriptName='npc_eris_hevenfire' WHERE entry=14494;
DELETE FROM creature WHERE id=14494;
INSERT INTO creature VALUES (NULL, 14494, 0, 1, 1, 0, 0, 3321.20, -2995.84, 165.49, 0.1, 600, 0, 0, 3052, 0, 0, 0, 0, 0);
UPDATE creature_template SET unit_flags=8, speed_walk=0.6, faction=35, RegenHealth=0, AIName='', ScriptName='npc_balance_of_light_and_shadow' WHERE entry IN(14484, 14485);
UPDATE creature_template SET unit_flags=6, AIName='', ScriptName='npc_balance_of_light_and_shadow' WHERE entry=14489;
REPLACE INTO creature_template_addon VALUES(14489, 0, 0, 0, 2, 0, '');
DELETE FROM smart_scripts WHERE entryorguid IN(14484, 14485) AND source_type=0;

-- Chapter I-IV (339 - 342)
UPDATE quest_template SET SpecialFlags=1 WHERE Id IN(339, 340, 341, 342);

-- Freedom for All Creatures (2969)
UPDATE creature SET spawntimesecs=60 WHERE id=7997;
UPDATE creature SET spawntimesecs=10 WHERE id=7956;
UPDATE gameobject SET state=1 WHERE map=1 AND id=143979;
UPDATE creature_template SET faction=42, AIName='SmartAI', ScriptName='' WHERE entry=7956;
DELETE FROM smart_scripts WHERE entryorguid=7956 AND source_type=0;
INSERT INTO smart_scripts VALUES (7956, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Add Unit Flag');
INSERT INTO smart_scripts VALUES (7956, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set NPC Flags');
INSERT INTO smart_scripts VALUES (7956, 0, 2, 3, 19, 0, 100, 0, 2969, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (7956, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 7956, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (7956, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 41, 6*60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Force Despawn');
INSERT INTO smart_scripts VALUES (7956, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set NPC Flags');
INSERT INTO smart_scripts VALUES (7956, 0, 6, 7, 60, 32, 100, 1, 0, 0, 0, 0, 26, 2969, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Update - Event Happens');
INSERT INTO smart_scripts VALUES (7956, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn');
INSERT INTO smart_scripts VALUES (7956, 0, 8, 0, 38, 0, 100, 0, 1, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Inc Phase');
INSERT INTO smart_scripts VALUES (7956, 0, 9, 0, 40, 0, 100, 0, 17, 0, 0, 0, 54, 240000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Pause');
INSERT INTO smart_scripts VALUES (7956, 0, 10, 0, 6, 0, 100, 0, 0, 0, 0, 0, 6, 2969, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Death - Fail Quest');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=7997;
DELETE FROM smart_scripts WHERE entryorguid=7997 AND source_type=0;
INSERT INTO smart_scripts VALUES (7997, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Faction');
INSERT INTO smart_scripts VALUES (7997, 0, 1, 2, 38, 0, 100, 0, 1, 1, 0, 0, 2, 124, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Set Faction');
INSERT INTO smart_scripts VALUES (7997, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 7997, 0, 0, 500, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - WP Start');
INSERT INTO smart_scripts VALUES (7997, 0, 3, 4, 40, 0, 100, 0, 1, 0, 0, 0, 2, 42, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Faction');
INSERT INTO smart_scripts VALUES (7997, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 7725, 10, 0, 0, 0, 0, 0, 'On WP Reach - Attack Start');
INSERT INTO smart_scripts VALUES (7997, 0, 5, 0, 40, 0, 100, 0, 4, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 7956, 100, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
DELETE FROM waypoints WHERE entry IN(7956, 7997);
INSERT INTO waypoints VALUES (7956, 1, -4483.36, 862.535, 74.6013, 'Kindal Moonweaver'),(7956, 2, -4487.18, 865.19, 79.7406, 'Kindal Moonweaver'),(7956, 3, -4488.79, 866.515, 81.6256, 'Kindal Moonweaver'),(7956, 4, -4500, 866.707, 86.8864, 'Kindal Moonweaver'),(7956, 5, -4507.84, 866.517, 86.3367, 'Kindal Moonweaver'),(7956, 6, -4515.54, 866.362, 81.4797, 'Kindal Moonweaver'),(7956, 7, -4525.59, 870.284, 71.2782, 'Kindal Moonweaver'),(7956, 8, -4532.78, 876.269, 64.7919, 'Kindal Moonweaver'),(7956, 9, -4543.71, 881.974, 57.7389, 'Kindal Moonweaver'),(7956, 10, -4557.97, 889.414, 58.1973, 'Kindal Moonweaver'),(7956, 11, -4562.43, 877.404, 60.5922, 'Kindal Moonweaver'),(7956, 12, -4559.57, 862.749, 60.3292, 'Kindal Moonweaver'),
(7956, 13, -4559.69, 848.574, 61.0174, 'Kindal Moonweaver'),(7956, 14, -4559.44, 828.904, 60.0051, 'Kindal Moonweaver'),(7956, 15, -4553.4, 817.6, 61.3187, 'Kindal Moonweaver'),(7956, 16, -4546.26, 807.014, 60.6828, 'Kindal Moonweaver'),(7956, 17, -4536.75, 802.86, 60.2268, 'Kindal Moonweaver'),(7956, 18, -4525.93, 807.485, 60.0967, 'Kindal Moonweaver'),
(7997, 1, -4532.84, 808.158, 60.024, 'Captured Sprite Darter'),(7997, 2, -4528.31, 802.922, 59.5333, 'Captured Sprite Darter'),(7997, 3, -4518.08, 800.967, 59.4521, 'Captured Sprite Darter'),(7997, 4, -4505.76, 798.409, 61.7315, 'Captured Sprite Darter');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=143979;
DELETE FROM smart_scripts WHERE entryorguid=143979 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid=143979*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (143979, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 143979*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Script9');
INSERT INTO smart_scripts VALUES (143979*100, 9, 0, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50062, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50063, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50064, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50065, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50066, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50067, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50068, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50069, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50070, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 9, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50071, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50072, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (143979*100, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 50073, 7997, 0, 0, 0, 0, 0, 'Script9 - Set Data');

-- Fragments of the Past (5247)
DELETE FROM gameobject WHERE id IN(178224, 178225);
INSERT INTO gameobject VALUES(NULL, 178224, 1, 1, 1, -4035.38, 1345.59, 159.751, 4.65349, 0, 0, 0.727621, -0.685979, 120, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 178225, 1, 1, 1, -4035.38, 1345.59, 159.751, 4.65349, 0, 0, 0.727621, -0.685979, 300, 0, 1, 0);

-- Book of the Ancients (6027)
UPDATE gameobject_template SET data2=60000, AIName='SmartGameObjectAI' WHERE entry=177673;
DELETE FROM smart_scripts WHERE entryorguid=177673 AND source_type=1;
INSERT INTO smart_scripts VALUES (177673, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 12, 12369, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 259, 2973, 1.71, 4.0, 'On Just Deactivated - Summon Creature');

-- The Challenge (9015)
REPLACE INTO gameobject_template VALUES(181074, 3, 10, 'Arena Spoils', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 57, 181074, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 1);
DELETE FROM gameobject_loot_template WHERE entry=181074;
INSERT INTO gameobject_loot_template VALUES(181074, 22305, 25, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(181074, 22317, 25, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(181074, 22318, 25, 1, 1, 1, 1);
INSERT INTO gameobject_loot_template VALUES(181074, 22330, 25, 1, 1, 1, 1);
DELETE FROM script_waypoint WHERE entry=10096;
INSERT INTO script_waypoint VALUES (10096, 0, 604.803, -191.082, -54.0586, 0, 'ring');
INSERT INTO script_waypoint VALUES (10096, 1, 604.073, -222.107, -52.7438, 0, 'first gate');
INSERT INTO script_waypoint VALUES (10096, 2, 621.4, -214.499, -52.8145, 0, 'hiding in corner');
INSERT INTO script_waypoint VALUES (10096, 3, 601.301, -198.557, -53.9503, 0, 'ring');
INSERT INTO script_waypoint VALUES (10096, 4, 631.818, -180.548, -52.6548, 0, 'second gate');
INSERT INTO script_waypoint VALUES (10096, 5, 627.39, -201.076, -52.6929, 0, 'hiding in corner');
UPDATE creature_template SET faction=54, AIName='SmartAI' WHERE entry IN(16059, 16053, 16055, 16050, 16051, 16049, 16058, 16052, 16054);
DELETE FROM smart_scripts WHERE entryorguid IN(16059, 16053, 16055, 16050, 16051, 16049, 16058, 16052, 16054) AND source_type=0;
INSERT INTO smart_scripts VALUES (16059, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 27578, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (16059, 0, 1, 0, 9, 0, 100, 0, 8, 25, 7000, 7000, 11, 27577, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'On Range - Cast Spell');
INSERT INTO smart_scripts VALUES (16059, 0, 2, 0, 0, 0, 100, 0, 12000, 14000, 25000, 27000, 11, 27584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16059, 0, 3, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 11, 27580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16059, 0, 4, 0, 0, 0, 100, 0, 9000, 9000, 17000, 17000, 11, 19134, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16059, 0, 5, 0, 0, 0, 100, 0, 6000, 6000, 37000, 37000, 11, 27579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16053, 0, 0, 0, 0, 0, 100, 0, 12000, 14000, 25000, 27000, 11, 15786, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16053, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 11, 21401, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16053, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 17000, 17000, 11, 27626, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16053, 0, 3, 0, 14, 0, 100, 0, 1, 30, 10000, 10000, 11, 27624, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Friendly HP - Cast spell');
INSERT INTO smart_scripts VALUES (16055, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 5000, 7000, 11, 27605, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16050, 0, 0, 0, 0, 0, 100, 0, 12000, 14000, 25000, 27000, 11, 27611, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16050, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 5000, 7000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16050, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 17000, 17000, 11, 27615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16051, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 8000, 8000, 11, 15241, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16051, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 15000, 17000, 11, 20827, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16049, 0, 0, 0, 0, 0, 100, 0, 12000, 14000, 25000, 27000, 11, 27611, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16049, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 5000, 7000, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16049, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 17000, 17000, 11, 27615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16058, 0, 0, 0, 0, 0, 100, 0, 12000, 14000, 25000, 27000, 11, 27618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16058, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 9000, 9000, 11, 20828, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16058, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 6000, 6000, 11, 20822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16052, 0, 0, 0, 0, 0, 100, 0, 12000, 14000, 15000, 17000, 11, 31623, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');
INSERT INTO smart_scripts VALUES (16052, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 15000, 17000, 11, 32419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast spell');

-- In Dreams (5944)
REPLACE INTO creature_questender VALUES(12126, 5944);
DELETE FROM creature_text WHERE entry IN(1840, 1842, 12126);
INSERT INTO creature_text VALUES(1842, 0, 0, "I will lead us through Hearthglen to the forest's edge. From there, you will take me to my father.", 12, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 1, 0, "Remove your disguise, lest you feel the bite of my blade when the fury has taken control.", 12, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 2, 0, "Halt.", 12, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 3, 0, "Highlord Taelan Fordring calls for his mount.", 16, 0, 100, 22, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 4, 0, "It's not much further. The main road is just up ahead.", 12, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 5, 0, "Isillien!", 14, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1842, 6, 0, "This is not your fight, stranger. Protect yourself from the attacks of the Crimson Elite. I shall battle the Grand Inquisitor.", 12, 0, 100, 0, 0, 0, 0, 'Taelan Fordring');
INSERT INTO creature_text VALUES(1840, 0, 0, "You will not make it to the forest's edge, Fordring.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 1, 0, "You disappoint me, Taelan. I had plans for you... grand plans. Alas, it was only a matter of time before your filthy bloodline would catch up with you.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 2, 0, "It is as they say; Like father, like son. You are as weak of will as Tirion... perhaps more so. I can only hope my assassins finally succeeded in ending his pitiful life.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 3, 0, "The Grand Crusader has charged me with destroying you and your newfound friends, Taelan, but know this: I do this for pleasure, not of obligation or duty.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 4, 0, "Grand Inquisitor Isillien calls for his guardsman.", 16, 0, 100, 22, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 5, 0, "The end is now, Fordring.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 6, 0, "Enough!", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 7, 0, "Grand Inquisitor Isillien laughs.", 16, 0, 100, 11, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 8, 0, "Did you really believe that you could defeat me? Your friends are soon to join you, Taelan.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 9, 0, "Tragic. The elder Fordring lives on... You are too late, old man. Retreat back to your cave, hermit, unless you wish to join your son in the Twisting Nether.", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(1840, 10, 0, "Then come, hermit!", 12, 0, 100, 0, 0, 0, 0, 'Grand Inquisitor Isillien');
INSERT INTO creature_text VALUES(12126, 0, 0, "What have you done, Isillien? You once fought with honor, for the good of our people... and now... you have murdered my boy...", 12, 0, 100, 1, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 1, 0, "May your soul burn in anguish, Isillien! Light give me strength to battle this fiend.", 12, 0, 100, 15, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 2, 0, "Face me, coward. Face the faith and strength that you once embodied.", 12, 0, 100, 25, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 3, 0, "A thousand more like him exist. Ten thousand. Should one fall, another will rise to take the seat of power.", 12, 0, 100, 0, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 4, 0, "Lord Tirion Fordring falls to one knee.", 16, 0, 100, 0, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 5, 0, "Look what they did to my boy.", 12, 0, 100, 5, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 6, 0, "Too long have I sat idle, gripped in this haze... this malaise, lamenting what could have been... what should have been.", 12, 0, 100, 0, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 7, 0, "Your death will not have been in vain, Taelan. A new Order is born on this day... an Order which will dedicate itself to extinguising the evil that plagues this world. An evil that cannot hide behind politics and pleasantries.", 12, 0, 100, 0, 0, 0, 0, 'Lord Tirion Fordring');
INSERT INTO creature_text VALUES(12126, 8, 0, "This I promise... This I vow...", 12, 0, 100, 0, 0, 0, 0, 'Lord Tirion Fordring');
UPDATE creature_template SET speed_walk=1, AIName='SmartAI', ScriptName='' WHERE entry=1842;
DELETE FROM smart_scripts WHERE entryorguid IN(1842, 1840, 12126, 12128) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(1842*100, 1842*100+1, 1840*100, 12126*100, 12126*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (1842, 0, 0, 0, 34, 0, 100, 0, 8, 0xFFFFFF, 0, 0, 43, 0, 2402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Movement Inform - Mount');
INSERT INTO smart_scripts VALUES (1842, 0, 1, 0, 19, 0, 100, 0, 5944, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (1842, 0, 2, 0, 52, 0, 100, 0, 0, 0, 0, 0, 53, 0, 1842, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - WP Start');
INSERT INTO smart_scripts VALUES (1842, 0, 3, 15, 11, 0, 100, 0, 0, 0, 0, 0, 2, 67, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Faction');
INSERT INTO smart_scripts VALUES (1842, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Cast Spell');
INSERT INTO smart_scripts VALUES (1842, 0, 5, 0, 0, 0, 100, 0, 3000, 3000, 5000, 5000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1842, 0, 6, 0, 2, 0, 100, 0, 0, 20, 120000, 120000, 11, 17233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1842, 0, 7, 8, 40, 0, 100, 0, 1, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (1842, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 42, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Faction');
INSERT INTO smart_scripts VALUES (1842, 0, 9, 10, 40, 0, 100, 0, 26, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (1842, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (1842, 0, 11, 0, 52, 0, 100, 0, 2, 0, 0, 0, 1, 3, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
INSERT INTO smart_scripts VALUES (1842, 0, 12, 0, 52, 0, 100, 0, 3, 0, 0, 0, 43, 0, 2402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Mount');
INSERT INTO smart_scripts VALUES (1842, 0, 13, 0, 40, 0, 100, 0, 74, 0, 0, 0, 80, 1842*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Script9');
INSERT INTO smart_scripts VALUES (1842, 0, 14, 0, 8, 0, 100, 0, 18969, 0, 0, 0, 80, 1842*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Script9');
INSERT INTO smart_scripts VALUES (1842, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Remove Flag');
INSERT INTO smart_scripts VALUES (1842, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Remove Byte 1');
INSERT INTO smart_scripts VALUES (1842*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1842*100, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (1842*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 1840, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 2683.64, -1926.72, 72.14, 2.0, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1842*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1842*100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1842*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Dismount');
INSERT INTO smart_scripts VALUES (1842*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Position');
INSERT INTO smart_scripts VALUES (1842*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flag');
INSERT INTO smart_scripts VALUES (1842*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
INSERT INTO smart_scripts VALUES (1842*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES (1842*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flag');
INSERT INTO smart_scripts VALUES (1842*100+1, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 1');
UPDATE creature_template SET faction=16, AIName='SmartAI', ScriptName='' WHERE entry=1840;
INSERT INTO smart_scripts VALUES (1840, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 1840*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES (1840, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 30000, 30000, 11, 11647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1840, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 8000, 9000, 11, 17287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1840, 0, 3, 0, 0, 0, 100, 0, 20000, 20000, 20000, 20000, 11, 13639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1840, 0, 4, 0, 0, 0, 100, 0, 7000, 8000, 15000, 15000, 11, 17314, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (1840*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flag');
INSERT INTO smart_scripts VALUES (1840*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2677, -1917, 68, 2.1, 'Script9 - Move To Pos');
INSERT INTO smart_scripts VALUES (1840*100, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 4, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 5, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2674, -1920, 68.41, 1.8, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1840*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2684, -1918, 69.52, 2.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1840*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2694, -1875, 66.86, 3.8, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1840*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2693, -1869, 66.87, 3.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1840*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2697, -1879, 66.8, 3.8, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (1840*100, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 12128, 100, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (1840*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 256+512+8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flag');
INSERT INTO smart_scripts VALUES (1840*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 1842, 30, 0, 0, 0, 0, 0, 'Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (1840*100, 9, 16, 0, 0, 0, 100, 0, 45000, 45000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Pos');
INSERT INTO smart_scripts VALUES (1840*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 18969, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (1840*100, 9, 19, 0, 0, 0, 100, 0, 500, 500, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES (1840*100, 9, 20, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flag');
INSERT INTO smart_scripts VALUES (1840*100, 9, 21, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 22, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (1840*100, 9, 23, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flag');
INSERT INTO smart_scripts VALUES (1840*100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (1840*100, 9, 25, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 12126, 4, 180000, 0, 0, 0, 8, 0, 0, 0, 2642.8, -1913, 71.2, 0.4, 'Script9 - Summon Creature');
DELETE FROM waypoints WHERE entry=12126;
INSERT INTO waypoints VALUES (12126, 1, 2667, -1899, 66.81, 'Taelan Fordring');
UPDATE creature_template SET unit_flags=0, faction=35, flags_extra=2, AIName='SmartAI', ScriptName='' WHERE entry=12126;
INSERT INTO smart_scripts VALUES (12126, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Flag');
INSERT INTO smart_scripts VALUES (12126, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 43, 0, 2402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Mount');
INSERT INTO smart_scripts VALUES (12126, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set Run');
INSERT INTO smart_scripts VALUES (12126, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Set NPC Flag');
INSERT INTO smart_scripts VALUES (12126, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 12126, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Start Escort');
INSERT INTO smart_scripts VALUES (12126, 0, 5, 0, 40, 0, 100, 0, 1, 0, 0, 0, 80, 12126*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On MovementInform - Script9');
INSERT INTO smart_scripts VALUES (12126, 0, 6, 0, 7, 1, 100, 0, 0, 0, 0, 0, 80, 12126*100+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Script9 out of combat');
INSERT INTO smart_scripts VALUES (12126*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Home Position');
INSERT INTO smart_scripts VALUES (12126*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Dismount');
INSERT INTO smart_scripts VALUES (12126*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 1');
INSERT INTO smart_scripts VALUES (12126*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 1');
INSERT INTO smart_scripts VALUES (12126*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (12126*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100, 9, 8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flag');
INSERT INTO smart_scripts VALUES (12126*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 42, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (12126*100, 9, 11, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (12126*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Phase');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 1');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 1');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 5, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 6, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 7, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 15, 5944, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Script9 - Area Explored');
INSERT INTO smart_scripts VALUES (12126*100+1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set NPC Flag');
UPDATE creature_template SET dmg_multiplier=2, faction=16, AIName='SmartAI', ScriptName='' WHERE entry=12128;
INSERT INTO smart_scripts VALUES (12128, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 9000, 10000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (12128, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 20000, 22000, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell');
INSERT INTO smart_scripts VALUES (12128, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2674, -1906, 66.1, 5.3, 'On Data Set - Move To Pos');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=1842;
INSERT INTO conditions VALUES (22, 1, 1842, 0, 0, 23, 1, 203, 0, 0, 1, 0, 0, '', 'Dont run action in specific area');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=18969;
INSERT INTO conditions VALUES (13, 1, 18969, 0, 0, 31, 0, 3, 1842, 0, 0, 0, 0, '', 'Target Taelan');
DELETE FROM waypoints WHERE entry=1842;
INSERT INTO waypoints VALUES (1842, 1, 2941.47, -1391.79, 167.237, 'Taelan Fordring'),(1842, 2, 2940.59, -1393.34, 166.084, 'Taelan Fordring'),(1842, 3, 2934.76, -1403.63, 165.943, 'Taelan Fordring'),(1842, 4, 2932.09, -1408.34, 165.943, 'Taelan Fordring'),(1842, 5, 2917.95, -1402.97, 165.943, 'Taelan Fordring'),(1842, 6, 2919.7, -1398.38, 165.88, 'Taelan Fordring'),(1842, 7, 2922.96, -1389.76, 160.89, 'Taelan Fordring'),(1842, 8, 2925.9, -1386.68, 160.842, 'Taelan Fordring'),(1842, 9, 2946.78, -1396.55, 160.842, 'Taelan Fordring'),(1842, 10, 2948.71, -1392.82, 160.842, 'Taelan Fordring'),(1842, 11, 2951.88, -1386.69, 155.974, 'Taelan Fordring'),(1842, 12, 2953.8, -1383.23, 155.949, 'Taelan Fordring'),(1842, 13, 2951.18, -1381.97, 155.949, 'Taelan Fordring'),(1842, 14, 2946.54, -1379.57, 152.02, 'Taelan Fordring'),(1842, 15, 2943.02, -1377.76, 152.02, 'Taelan Fordring'),(1842, 16, 2935.55, -1392.66, 152.02, 'Taelan Fordring'),(1842, 17, 2920.61, -1385.01, 152.02, 'Taelan Fordring'),
(1842, 18, 2915.23, -1395.37, 152.02, 'Taelan Fordring'),(1842, 19, 2926.44, -1401.34, 152.03, 'Taelan Fordring'),(1842, 20, 2930.45, -1403.49, 150.521, 'Taelan Fordring'),(1842, 21, 2933.64, -1405.2, 150.521, 'Taelan Fordring'),(1842, 22, 2930.83, -1412.74, 150.504, 'Taelan Fordring'),(1842, 23, 2924.04, -1426.34, 150.781, 'Taelan Fordring'),(1842, 24, 2917.27, -1439.65, 150.664, 'Taelan Fordring'),(1842, 25, 2914.56, -1445.08, 149.505, 'Taelan Fordring'),(1842, 26, 2911.01, -1452.17, 147.891, 'Taelan Fordring'),(1842, 27, 2911.49, -1460.75, 147.348, 'Taelan Fordring'),(1842, 28, 2915.27, -1471.79, 146.082, 'Taelan Fordring'),(1842, 29, 2917.16, -1477.3, 146.179, 'Taelan Fordring'),(1842, 30, 2937.93, -1475.79, 146.786, 'Taelan Fordring'),(1842, 31, 2948.62, -1483.6, 146.287, 'Taelan Fordring'),(1842, 32, 2950.48, -1502.29, 146.109, 'Taelan Fordring'),(1842, 33, 2949.29, -1521.33, 146.274, 'Taelan Fordring'),(1842, 34, 2950.6, -1538.69, 146.082, 'Taelan Fordring'),
(1842, 35, 2930.13, -1562.47, 145.785, 'Taelan Fordring'),(1842, 36, 2916.36, -1578.33, 146.147, 'Taelan Fordring'),(1842, 37, 2909.48, -1586.26, 146.515, 'Taelan Fordring'),(1842, 38, 2902.06, -1590.55, 146.557, 'Taelan Fordring'),(1842, 39, 2888.13, -1591.98, 145.702, 'Taelan Fordring'),(1842, 40, 2876.43, -1591.6, 144.335, 'Taelan Fordring'),(1842, 41, 2862.5, -1593.03, 142.511, 'Taelan Fordring'),(1842, 42, 2846.46, -1603.03, 139.023, 'Taelan Fordring'),(1842, 43, 2836.07, -1612.41, 135.225, 'Taelan Fordring'),(1842, 44, 2827.58, -1620.07, 132.012, 'Taelan Fordring'),(1842, 45, 2820.52, -1623.16, 131.22, 'Taelan Fordring'),(1842, 46, 2804.83, -1620.19, 129.717, 'Taelan Fordring'),(1842, 47, 2791.11, -1617.4, 129.693, 'Taelan Fordring'),(1842, 48, 2780.39, -1615.9, 129.044, 'Taelan Fordring'),(1842, 49, 2773.01, -1623.84, 128.074, 'Taelan Fordring'),(1842, 50, 2766.04, -1631.69, 127.927, 'Taelan Fordring'),(1842, 51, 2759.06, -1639.54, 128.336, 'Taelan Fordring'),(1842, 52, 2752.08, -1647.38, 127.494, 'Taelan Fordring'),
(1842, 53, 2745.11, -1655.23, 126.277, 'Taelan Fordring'),(1842, 54, 2738.13, -1663.08, 126.679, 'Taelan Fordring'),(1842, 55, 2732.03, -1674.53, 126.673, 'Taelan Fordring'),(1842, 56, 2725.5, -1682.87, 126.414, 'Taelan Fordring'),(1842, 57, 2717.98, -1692.7, 126.476, 'Taelan Fordring'),(1842, 58, 2713.38, -1700, 125.79, 'Taelan Fordring'),(1842, 59, 2703.08, -1714.3, 122.214, 'Taelan Fordring'),(1842, 60, 2694.95, -1729.79, 117.559, 'Taelan Fordring'),(1842, 61, 2689.65, -1745.97, 112.656, 'Taelan Fordring'),(1842, 62, 2689.05, -1763.33, 106.147, 'Taelan Fordring'),(1842, 63, 2690.09, -1774.06, 102.238, 'Taelan Fordring'),(1842, 64, 2691.45, -1786.18, 97.3156, 'Taelan Fordring'),(1842, 65, 2692.17, -1800.16, 90.1386, 'Taelan Fordring'),(1842, 66, 2692.7, -1810.65, 85.387, 'Taelan Fordring'),(1842, 67, 2697.55, -1818.24, 81.7822, 'Taelan Fordring'),(1842, 68, 2700.73, -1829.26, 76.4334, 'Taelan Fordring'),(1842, 69, 2699.39, -1845.15, 71.4784, 'Taelan Fordring'),(1842, 70, 2696.58, -1856.38, 68.2104, 'Taelan Fordring'),(1842, 71, 2694.06, -1870.35, 66.9045, 'Taelan Fordring'),(1842, 72, 2693.26, -1873.62, 66.8413, 'Taelan Fordring'),
(1842, 73, 2675.36, -1891.94, 66.1742, 'Taelan Fordring'),(1842, 74, 2669.33, -1898.11, 66.7004, 'Taelan Fordring');

-- The Summoning (1713)
REPLACE INTO smart_scripts VALUES(6176, 0, 1, 0, 40, 0, 100, 0, 7, 6176, 0, 0, 80, 617601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Bath'rah the Windwatcher - On WP 7 - Run Script");

-- The Battle of Darrowshire (5721)
REPLACE INTO gameobject VALUES(99891, 177528, 0, 1, 1, 1439.7, -3701.6, 77.1, 0, 0, 0, 0, 0, 180, 0, 1, 0);
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=177526;
DELETE FROM smart_scripts WHERE entryorguid=177526 AND source_type=1;
INSERT INTO smart_scripts VALUES (177526, 1, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 12, 10944, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1480.48, -3687.7, 79.91, 0.0, 'On Update - Summon Creature');
DELETE FROM creature_text WHERE entry IN(10937, 10938, 10944, 10946, 10948);
INSERT INTO creature_text VALUES(10937, 0, 0, "Defenders of Darrowshire! Rally! We must prevail!", 14, 0, 100, 0, 0, 0, 0, "Captain Redpath");
INSERT INTO creature_text VALUES(10937, 1, 0, "Captain Redpath has appeared at the battlefield! Protect him!", 41, 0, 100, 0, 0, 0, 0, "Captain Redpath");
INSERT INTO creature_text VALUES(10938, 0, 0, "Darrowshire! You are doomed!", 14, 0, 100, 0, 0, 0, 0, "Redpath the Corrupted");
INSERT INTO creature_text VALUES(10938, 1, 0, "Captain Joseph Redpath has been corrupted! Kill him quickly!", 41, 0, 100, 0, 0, 0, 0, "Redpath the Corrupted");
INSERT INTO creature_text VALUES(10944, 0, 0, "Do not lose hope, Darrowshire! We will not fall!", 14, 0, 100, 0, 0, 0, 0, "Davil Lightfire");
INSERT INTO creature_text VALUES(10944, 1, 0, "Horgus, your nightmare ends! Now!", 14, 0, 100, 0, 0, 0, 0, "Davil Lightfire");
INSERT INTO creature_text VALUES(10944, 2, 0, "Ah! My wounds are too severe. Defenders, fight on without me!", 12, 0, 100, 0, 0, 0, 0, "Davil Lightfire");
INSERT INTO creature_text VALUES(10946, 0, 0, "The Light burns bright in you, Davil. I will enjoy snuffing it out!", 14, 0, 100, 0, 0, 0, 0, "Horgus the Ravager");
INSERT INTO creature_text VALUES(10948, 0, 0, "Darrowshire, to arms! The Scourge approach!", 14, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
INSERT INTO creature_text VALUES(10948, 1, 0, "Help Joseph Carlin's troops defend Darrowshire!", 41, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
INSERT INTO creature_text VALUES(10948, 2, 0, "Horgus is slain! Take heart, defenders of Darrowshire!", 14, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
INSERT INTO creature_text VALUES(10948, 3, 0, "Captain Redpath is slain!", 14, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
INSERT INTO creature_text VALUES(10948, 4, 0, "The Scourge are defeated! Darrowshire is saved!", 14, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
INSERT INTO creature_text VALUES(10948, 5, 0, "Speak with Joseph Redpath in the center of Darrowshire.", 41, 0, 100, 0, 0, 0, 0, "Darrowshire Defender");
UPDATE creature_template SET faction=14 WHERE entry IN(10938, 10946, 10951, 10952, 10953, 10954);
UPDATE creature_template SET faction=42 WHERE entry IN(10937, 10944, 10945, 10948, 10949);
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(10937, 10938, 10944, 10946, 10948, 10949, 10951, 10952, 10953, 10954);
DELETE FROM smart_scripts WHERE entryorguid IN(10937, 10938, 10944, 10946, 10948, 10949, 10951, 10952, 10953, 10954) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(10944*100, 10944*100+1, 10944*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (10944, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 10944*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Script9');
INSERT INTO smart_scripts VALUES (10944, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 11, 17232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Aggro - Cast Devotion Aura');
INSERT INTO smart_scripts VALUES (10944, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 11, 17284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - In Combat - Cast Holy Strike');
INSERT INTO smart_scripts VALUES (10944, 0, 3, 0, 0, 0, 100, 0, 8000, 11000, 15000, 20000, 11, 13005, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - In Combat - Cast Hammer of Justice');
INSERT INTO smart_scripts VALUES (10944, 0, 4, 0, 38, 0, 100, 0, 1, 2, 0, 0, 80, 10944*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES (10944, 0, 5, 0, 38, 0, 100, 0, 1, 3, 0, 0, 80, 10944*100+2, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Script9');
INSERT INTO smart_scripts VALUES (10944*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Visible');
INSERT INTO smart_scripts VALUES (10944*100, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1447, -3697, 76.8, 0.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 10948, 50, 0, 0, 0, 0, 0, 'Script9 - Set Data');
INSERT INTO smart_scripts VALUES (10944*100, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1491.07, -3663.4, 81.76, 0.55, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 5, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1495, -3669, 81.44, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1499, -3686, 81.2, 0.1, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10948, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1504, -3691, 81.8, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 11, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 12, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 10949, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 14, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 10949, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1504, -3691, 81.8, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 15, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 16, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 17, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 18, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 19, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 20, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1515, -3663, 86.42, 3.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 21, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 22, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 23, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Visible');
INSERT INTO smart_scripts VALUES (10944*100, 9, 24, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (10944*100, 9, 25, 0, 0, 0, 100, 0, 500, 500, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10952, 30, 0, 0, 0, 0, 0, 'Script9 - Attack Start');
INSERT INTO smart_scripts VALUES (10944*100, 9, 26, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 27, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 28, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 29, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 30, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 31, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 32, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 33, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 34, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 35, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10953, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 36, 0, 0, 0, 100, 0, 200, 200, 0, 0, 12, 10946, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1507, -3663, 84.36, 3.9, 'Script9 - Summon Creature Horgus');
INSERT INTO smart_scripts VALUES (10944*100, 9, 37, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1515, -3663, 86.42, 3.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 38, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 39, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 40, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1490, -3667, 81.27, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100, 9, 41, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1515, -3663, 86.42, 3.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 9, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Visible');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 10, 0, 0, 0, 100, 0, 500, 500, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Evade');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10937, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1494, -3675, 80.93, 0, 'Script9 - Summon Creature Red Path');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 12, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 10954, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1536.5, -3684, 88.1, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10954, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1537, -3680, 88.4, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 15, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 10954, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1536.5, -3684, 88.1, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 16, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10954, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1537, -3680, 88.4, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 17, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 18, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 19, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 20, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 21, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 22, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1514, -3686, 84.64, 3.2, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 23, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1510, -3661, 85.7, 3.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 24, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10952, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1520.7, -3680.1, 83.88, 2.6, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 25, 0, 0, 0, 100, 0, 500, 500, 0, 0, 12, 10951, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1513, -3686, 84.22, 2.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 26, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 12, 10938, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1515.6, -3689.8, 85.65, 2.8, 'Script9 - Summon Creature Redpath the Corrupt');
INSERT INTO smart_scripts VALUES (10944*100+1, 9, 27, 0, 0, 0, 100, 0, 500, 500, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10937, 100, 0, 0, 0, 0, 0, 'Script9 - Despawn Target');
INSERT INTO smart_scripts VALUES (10944*100+2, 9, 0, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 12, 10936, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1443.25, -3702.94, 77.38, 0.5, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10944*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 10945, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 1459, -3678, 77.9, 5.9, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (10937, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 8000, 10000, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (10937, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 14000, 18000, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (10937, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 15000, 20000, 11, 9128, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - In Combat - Cast Battle Shout');
INSERT INTO smart_scripts VALUES (10937, 0, 3, 0, 37, 0, 100, 0, 1, 0, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Talk');
INSERT INTO smart_scripts VALUES (10937, 0, 4, 0, 52, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
INSERT INTO smart_scripts VALUES (10937, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10952, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10948, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 8000, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10948, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 7000, 10000, 11, 12169, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - In Combat - Cast Shield Block');
INSERT INTO smart_scripts VALUES (10948, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES (10948, 0, 3, 0, 52, 0, 100, 0, 0, 0, 0, 0, 1, 1, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk Boss Emote');
INSERT INTO smart_scripts VALUES (10948, 0, 4, 0, 52, 0, 100, 0, 1, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 1495, -3669, 81.5, 0, 'On Text Over - Move To Pos');
INSERT INTO smart_scripts VALUES (10948, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10952, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10948, 0, 6, 0, 38, 0, 100, 0, 1, 2, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES (10948, 0, 7, 0, 38, 0, 100, 0, 1, 3, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES (10948, 0, 8, 0, 52, 0, 100, 0, 3, 0, 0, 0, 1, 4, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
INSERT INTO smart_scripts VALUES (10948, 0, 9, 10, 52, 0, 100, 0, 4, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk Boss Emote');
INSERT INTO smart_scripts VALUES (10948, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10949, 100, 0, 0, 0, 0, 0, 'On Text Over - Despawn Target');
INSERT INTO smart_scripts VALUES (10948, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10948, 100, 0, 0, 0, 0, 0, 'On Text Over - Despawn Target');
INSERT INTO smart_scripts VALUES (10948, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Despawn');
INSERT INTO smart_scripts VALUES (10948, 0, 13, 0, 4, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Set Home Pos');
INSERT INTO smart_scripts VALUES (10948, 0, 14, 0, 7, 0, 100, 0, 0, 0, 0, 0, 89, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Move Random');
INSERT INTO smart_scripts VALUES (10949, 0, 0, 0, 0, 0, 100, 0, 4000, 6000, 6000, 9000, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Silver Hand Disciple - In Combat - Cast Crusader Strike');
INSERT INTO smart_scripts VALUES (10949, 0, 1, 0, 14, 0, 100, 0, 0, 40, 15000, 20000, 11, 15493, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Silver Hand Disciple - On Friendly Unit At 0 - 40% Health - Cast Holy Light');
INSERT INTO smart_scripts VALUES (10949, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10952, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10949, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 89, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Move Random');
INSERT INTO smart_scripts VALUES (10938, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 7000, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Redpath the Corrupted - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10938, 0, 1, 0, 0, 0, 100, 0, 8000, 10000, 14000, 18000, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Redpath the Corrupted - In Combat - Cast Backhand');
INSERT INTO smart_scripts VALUES (10938, 0, 2, 0, 0, 0, 100, 0, 3000, 5000, 15000, 20000, 11, 16244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Redpath the Corrupted - In Combat - Cast Demoralizing Shout');
INSERT INTO smart_scripts VALUES (10938, 0, 3, 0, 0, 0, 100, 0, 5000, 7000, 9000, 14000, 11, 12542, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Redpath the Corrupted - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (10938, 0, 4, 5, 25, 0, 100, 1, 0, 0, 0, 0, 11, 18951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (10938, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41232, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (10938, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On AI Init - Talk');
INSERT INTO smart_scripts VALUES (10938, 0, 7, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (10938, 0, 8, 9, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 10948, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (10938, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 10944, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (10946, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 11, 17467, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horgus the Ravager - On Update - Cast Unholy Aura');
INSERT INTO smart_scripts VALUES (10946, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (10946, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10944, 30, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (10946, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 18951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');
INSERT INTO smart_scripts VALUES (10946, 0, 4, 0, 0, 0, 100, 0, 3000, 5000, 6000, 8000, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Horgus the Ravager - In Combat - Cast Thrash');
INSERT INTO smart_scripts VALUES (10946, 0, 5, 0, 0, 0, 100, 0, 8000, 11000, 9000, 12000, 11, 15608, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Horgus the Ravager - In Combat - Cast Ravenous Claw');
INSERT INTO smart_scripts VALUES (10946, 0, 6, 7, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 10948, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (10946, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 10944, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (10951, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 5000, 8000, 11, 13584, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marauding Corpse - In Combat - Cast Strike');
INSERT INTO smart_scripts VALUES (10951, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10948, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10952, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 12000, 15000, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marauding Skeleton - In Combat - Cast Hamstring');
INSERT INTO smart_scripts VALUES (10952, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 15000, 18000, 11, 11972, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Marauding Skeleton - In Combat - Cast Shield Bash');
INSERT INTO smart_scripts VALUES (10952, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10948, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10953, 0, 0, 0, 0, 0, 100, 0, 8000, 11000, 9000, 12000, 11, 15608, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Servant of Horgus - In Combat - Cast Ravenous Claw');
INSERT INTO smart_scripts VALUES (10953, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10944, 30, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
INSERT INTO smart_scripts VALUES (10954, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 8000, 12000, 11, 15583, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodletter - In Combat - Cast Rupture');
INSERT INTO smart_scripts VALUES (10954, 0, 1, 0, 0, 0, 100, 0, 14000, 18000, 20000, 25000, 11, 15667, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bloodletter - In Combat - Cast Sinister Strike');
INSERT INTO smart_scripts VALUES (10954, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 10937, 50, 0, 0, 0, 0, 0, 'On Reset - Attack Start');
REPLACE INTO creature_template_addon VALUES(10936, 0, 0, 0, 0, 0, '12898');
REPLACE INTO creature_template_addon VALUES(10945, 0, 0, 0, 0, 0, '12898');
REPLACE INTO gossip_menu VALUES(30223, 4778);
UPDATE creature_template SET gossip_menu_id=30223, npcflag=1, AIName='SmartAI' WHERE entry=10936;
DELETE FROM smart_scripts WHERE entryorguid=10936 AND source_type=0;
INSERT INTO smart_scripts VALUES (10936, 0, 0, 1, 64, 0, 100, 0, 0, 0, 0, 0, 33, 10936, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Kill Credit');
INSERT INTO smart_scripts VALUES (10936, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Set Phase');
INSERT INTO smart_scripts VALUES (10936, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Despawn');
INSERT INTO smart_scripts VALUES (10936, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 11, 10945, 100, 0, 0, 0, 0, 0, 'On Gossip Hello - Despawn Target');
INSERT INTO smart_scripts VALUES (10936, 0, 4, 0, 60, 1, 100, 0, 2000, 2000, 0, 0, 5, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Play Emote');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=18987;
INSERT INTO conditions VALUES (17, 0, 18987, 0, 0, 29, 0, 10944, 100, 0, 1, 0, 0, '', 'Requires no npc in range');

-- Bodley's Unfortunate Fate (8960)
-- Bodley's Unfortunate Fate (9032)
-- The Left Piece of Lord Valthalak's Amulet (8966)
-- The Left Piece of Lord Valthalak's Amulet (8967)
-- The Left Piece of Lord Valthalak's Amulet (8968)
-- The Left Piece of Lord Valthalak's Amulet (8969)
-- Mea Culpa, Lord Valthalak (8995)
-- Return to Bodley item reward, added support
REPLACE INTO gossip_menu_option VALUES (30228, 0, 0, "I've lost my Left Piece of Lord Valthalak's Amulet.", 1, 1, 0, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES (30228, 1, 0, "I've lost my Top Piece of Lord Valthalak's Amulet.", 1, 1, 0, 0, 0, 0, '');
REPLACE INTO gossip_menu_option VALUES (30228, 2, 0, "I've lost my Right Piece of Lord Valthalak's Amulet.", 1, 1, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES(16033, 0, 0, 0, 0, 0, '27614');
UPDATE creature_template SET gossip_menu_id=30228, AIName='SmartAI' WHERE entry=16033;
DELETE FROM smart_scripts WHERE entryorguid=16033 AND source_type=0;
INSERT INTO smart_scripts VALUES (16033, 0, 0, 3, 62, 0, 100, 0, 30228, 0, 0, 0, 56, 21984, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Add Item Left');
INSERT INTO smart_scripts VALUES (16033, 0, 1, 3, 62, 0, 100, 0, 30228, 1, 0, 0, 56, 22047, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Add Item Top');
INSERT INTO smart_scripts VALUES (16033, 0, 2, 3, 62, 0, 100, 0, 30228, 2, 0, 0, 56, 22046, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Add Item Right');
INSERT INTO smart_scripts VALUES (16033, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close Gossip');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=30228;
INSERT INTO conditions VALUES(15, 30228, 0, 0, 0, 8, 0, 8966, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 0, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 0, 2, 0, 21984, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 1, 8, 0, 8967, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 1, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 1, 2, 0, 21984, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 2, 8, 0, 8968, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 2, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 2, 2, 0, 21984, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 3, 8, 0, 8969, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 3, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 0, 0, 3, 2, 0, 21984, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 1, 0, 0, 8, 0, 9015, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 1, 0, 0, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 1, 0, 0, 2, 0, 22047, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 0, 8, 0, 8989, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 0, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 0, 2, 0, 22046, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 1, 8, 0, 8990, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 1, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 1, 2, 0, 22046, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 2, 8, 0, 8991, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 2, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 2, 2, 0, 22046, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 3, 8, 0, 8992, 0, 0, 0, 0, 0, '', 'Requires Quest Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 3, 8, 0, 8995, 0, 0, 1, 0, 0, '', 'Requires Quest Not Rewarded');
INSERT INTO conditions VALUES(15, 30228, 2, 0, 3, 2, 0, 22046, 1, 0, 1, 0, 0, '', 'Requires Missing Item');
-- GO Focus
DELETE FROM gameobject WHERE id=181048;
INSERT INTO gameobject VALUES(NULL, 181048, 329, 1, 1, 3423.57, -3055.67, 136.498, 5.25036, 0, 0, 0, 0, 300, 0, 1, 0);
DELETE FROM gameobject WHERE id IN(181052, 181094, 181096);
INSERT INTO gameobject VALUES(NULL, 181052, 229, 1, 1, -23.97, -451.98, -18.64, 0, 0, 0, 0, 0, 180, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 181094, 429, 1, 1, 263.38, -452.69, -119.96, 0, 0, 0, 0, 0, 180, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 181096, 329, 1, 1, 3423.57, -3055.67, 136.498, 5.25036, 0, 0, 0, 0, 300, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 181094, 289, 1, 1, -3.82, 141.88, 83.9, 0, 0, 0, 0, 0, 180, 0, 1, 0);
INSERT INTO gameobject VALUES(NULL, 181096, 229, 1, 1, 25.92, -537.7, 110.93, 0, 0, 0, 0, 0, 180, 0, 1, 0);
-- Spell conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(27184, 27190, 27191, 27201, 27202, 27203);
INSERT INTO conditions VALUES (13, 2, 27184, 0, 0, 31, 0, 3, 16044, 0, 0, 0, 0, '', 'Target Mor Grayhoof Trigger');
INSERT INTO conditions VALUES (13, 2, 27190, 0, 0, 31, 0, 3, 16045, 0, 0, 0, 0, '', 'Target Isalien Trigger');
INSERT INTO conditions VALUES (13, 2, 27191, 0, 0, 31, 0, 3, 16046, 0, 0, 0, 0, '', 'Target Jarien and Sothos Trigger');
INSERT INTO conditions VALUES (13, 2, 27201, 0, 0, 31, 0, 3, 16047, 0, 0, 0, 0, '', 'Target Kormok Trigger');
INSERT INTO conditions VALUES (13, 2, 27202, 0, 0, 31, 0, 3, 16048, 0, 0, 0, 0, '', 'Target Lord Valthalak Trigger');
INSERT INTO conditions VALUES (13, 2, 27203, 0, 0, 31, 0, 3, 16044, 0, 0, 0, 0, '', 'Target Mor Grayhoof Trigger');
INSERT INTO conditions VALUES (13, 2, 27203, 0, 1, 31, 0, 3, 16045, 0, 0, 0, 0, '', 'Target Isalien Trigger');
INSERT INTO conditions VALUES (13, 2, 27203, 0, 2, 31, 0, 3, 16046, 0, 0, 0, 0, '', 'Target Jarien and Sothos Trigger');
INSERT INTO conditions VALUES (13, 2, 27203, 0, 3, 31, 0, 3, 16047, 0, 0, 0, 0, '', 'Target Kormok Trigger');
INSERT INTO conditions VALUES (13, 2, 27203, 0, 4, 31, 0, 3, 16048, 0, 0, 0, 0, '', 'Target Lord Valthalak Trigger');
-- Triggers
REPLACE INTO creature VALUES (45841, 16044, 229, 1, 1, 11686, 0, -15.9034, -455.282, -18.6442, 3.15971, 450, 0, 0, 4120, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (84386, 16045, 429, 1, 1, 11686, 0, 262.974, -442.555, -119.962, 4.61136, 450, 0, 0, 57, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (53937, 16046, 329, 1, 1, 11686, 0, 3423.47, -3055.73, 136.581, 1.15192, 7200, 0, 0, 57, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (48937, 16047, 289, 1, 1, 11686, 0, -24.898, 141.242, 84.0468, 0.890118, 7200, 0, 0, 57, 0, 0, 0, 0, 0);
REPLACE INTO creature VALUES (137927, 16048, 229, 1, 1, 11686, 0, 50.1154, -534.537, 111.32, 6.16101, 7200, 0, 0, 57, 0, 0, 0, 0, 0);
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(16044, 16045, 16046, 16047, 16048);
DELETE FROM smart_scripts WHERE entryorguid IN(16044, 16045, 16046, 16047, 16048) AND source_type=0;
INSERT INTO smart_scripts VALUES (16044, 0, 0, 0, 8, 0, 100, 0, 27184, 0, 0, 0, 12, 16080, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16045, 0, 0, 0, 8, 0, 100, 0, 27190, 0, 0, 0, 12, 16097, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16046, 0, 0, 0, 8, 0, 100, 0, 27191, 0, 0, 0, 12, 16101, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 3426.22, -3054.4, 136.0, 5.2, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16046, 0, 1, 0, 8, 0, 100, 0, 27191, 0, 0, 0, 12, 16102, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 3420.80, -3057.8, 136.0, 5.3, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16047, 0, 0, 0, 8, 0, 100, 0, 27201, 0, 0, 0, 12, 16118, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16048, 0, 0, 0, 8, 0, 100, 0, 27202, 0, 0, 0, 12, 16042, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16044, 0, 1, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16080, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16045, 0, 1, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16097, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16046, 0, 2, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16101, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 3426.22, -3054.4, 136.0, 5.2, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16046, 0, 3, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16102, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 3420.80, -3057.8, 136.0, 5.3, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16047, 0, 1, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16118, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
INSERT INTO smart_scripts VALUES (16048, 0, 1, 0, 8, 0, 100, 0, 27203, 0, 0, 0, 12, 16042, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Summon Creature');
-- NPCs
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(16080, 16097, 16101, 16102, 16103, 16104, 16118, 16042, 16066));
DELETE FROM creature WHERE id IN(16080, 16097, 16101, 16102, 16103, 16104, 16118, 16042, 16066);
UPDATE creature_template SET faction=14, AIName='SmartAI', ScriptName='' WHERE entry IN(16080, 16097, 16101, 16102, 16118, 16119, 16120, 16042, 16066);
UPDATE creature_template SET faction=42, AIName='SmartAI', ScriptName='' WHERE entry IN(16103, 16104);
DELETE FROM smart_scripts WHERE entryorguid IN(16080, 16097, 16101, 16102, 16103, 16104, 16118, 16119, 16120, 16042, 16066) AND source_type=0;
INSERT INTO smart_scripts VALUES (16080, 0, 0, 0, 0, 0, 100, 0, 500, 500, 25000, 25000, 11, 27532, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Rejuvenation');
INSERT INTO smart_scripts VALUES (16080, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 25000, 25000, 11, 27545, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Cat Form');
INSERT INTO smart_scripts VALUES (16080, 0, 2, 0, 0, 0, 100, 0, 4000, 4000, 25000, 25000, 11, 27556, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Rake');
INSERT INTO smart_scripts VALUES (16080, 0, 3, 0, 0, 0, 100, 0, 7000, 7000, 25000, 25000, 11, 27555, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shred');
INSERT INTO smart_scripts VALUES (16080, 0, 4, 0, 0, 0, 100, 0, 12000, 12000, 25000, 25000, 11, 27543, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Bear Form');
INSERT INTO smart_scripts VALUES (16080, 0, 5, 0, 0, 0, 100, 0, 16000, 16000, 25000, 25000, 11, 27551, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Demoralizing Roar');
INSERT INTO smart_scripts VALUES (16080, 0, 6, 0, 0, 0, 100, 0, 19000, 19000, 25000, 25000, 11, 27554, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Swipe');
INSERT INTO smart_scripts VALUES (16080, 0, 7, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16097, 0, 0, 0, 4, 0, 100, 1, 1000, 1000, 0, 0, 11, 27639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Cast Call Pet');
INSERT INTO smart_scripts VALUES (16097, 0, 1, 0, 9, 0, 100, 0, 5, 30, 2800, 3900, 11, 22907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'At 5 - 30 Range - Cast Shoot');
INSERT INTO smart_scripts VALUES (16097, 0, 2, 0, 9, 0, 100, 0, 5, 30, 7000, 12000, 11, 14443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'At 5 - 30 Range - Cast Multi-Shot');
INSERT INTO smart_scripts VALUES (16097, 0, 3, 0, 0, 0, 100, 0, 4000, 9000, 12000, 15000, 11, 12024, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'In Combat - Cast Net');
INSERT INTO smart_scripts VALUES (16097, 0, 4, 0, 0, 0, 100, 0, 20000, 30000, 20000, 30000, 11, 27636, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'In Combat - Cast Starshards');
INSERT INTO smart_scripts VALUES (16097, 0, 5, 0, 2, 0, 100, 0, 0, 80, 20000, 25000, 11, 27637, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'At 80% HP - Cast Regrowth');
INSERT INTO smart_scripts VALUES (16097, 0, 6, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16101, 0, 0, 0, 0, 0, 100, 0, 500, 500, 8000, 8000, 11, 18663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shadow Shock');
INSERT INTO smart_scripts VALUES (16101, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 20000, 20000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Mortal Strike');
INSERT INTO smart_scripts VALUES (16101, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 25000, 25000, 11, 20812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Cripple');
INSERT INTO smart_scripts VALUES (16101, 0, 3, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16101, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 16102, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (16101, 0, 5, 0, 61, 0, 100, 0, 1, 1, 0, 0, 12, 16103, 4, 3000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Summon Creature');
INSERT INTO smart_scripts VALUES (16101, 0, 6, 0, 38, 0, 100, 1, 1, 1, 0, 0, 11, 15716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Cast Spell');
INSERT INTO smart_scripts VALUES (16103, 0, 0, 0, 0, 0, 100, 0, 500, 500, 8000, 8000, 11, 18663, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shadow Shock');
INSERT INTO smart_scripts VALUES (16103, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 20000, 20000, 11, 27641, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Fear');
INSERT INTO smart_scripts VALUES (16103, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 25000, 25000, 11, 20812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Cripple');
INSERT INTO smart_scripts VALUES (16103, 0, 3, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 16102, 40, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16102, 0, 0, 0, 0, 0, 100, 0, 500, 500, 10000, 10000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Mortal Strike');
INSERT INTO smart_scripts VALUES (16102, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 20000, 20000, 11, 8242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shield Slam');
INSERT INTO smart_scripts VALUES (16102, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 25000, 25000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shield Block');
INSERT INTO smart_scripts VALUES (16102, 0, 3, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16102, 0, 4, 5, 6, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 16102, 50, 0, 0, 0, 0, 0, 'On Death - Set Data');
INSERT INTO smart_scripts VALUES (16102, 0, 5, 0, 61, 0, 100, 0, 1, 1, 0, 0, 12, 16104, 4, 3000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Death - Summon Creature');
INSERT INTO smart_scripts VALUES (16102, 0, 6, 0, 38, 0, 100, 1, 1, 1, 0, 0, 11, 15716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Cast Spell');
INSERT INTO smart_scripts VALUES (16104, 0, 0, 0, 0, 0, 100, 0, 500, 500, 10000, 10000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Mortal Strike');
INSERT INTO smart_scripts VALUES (16104, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 20000, 20000, 11, 8242, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shield Slam');
INSERT INTO smart_scripts VALUES (16104, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 25000, 25000, 11, 12169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shield Block');
INSERT INTO smart_scripts VALUES (16104, 0, 3, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 16101, 50, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16118, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 15000, 15000, 11, 21341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (16118, 0, 1, 0, 0, 0, 100, 0, 2000, 2000, 40000, 40000, 11, 16431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Boneshield Armor');
INSERT INTO smart_scripts VALUES (16118, 0, 2, 0, 0, 0, 100, 0, 10000, 10000, 12000, 12000, 11, 27687, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Summon Bone Minions');
INSERT INTO smart_scripts VALUES (16118, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 11, 27695, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'HP Update - Cast Summon Bone Mages');
INSERT INTO smart_scripts VALUES (16118, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16119, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16120, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16042, 0, 0, 0, 0, 0, 100, 0, 500, 500, 15000, 15000, 11, 27286, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Shadow Wrath');
INSERT INTO smart_scripts VALUES (16042, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 25000, 25000, 11, 27249, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'IC Update - Cast Spell Summon Assasins');
INSERT INTO smart_scripts VALUES (16042, 0, 2, 0, 2, 1, 100, 0, 0, 40, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'HP Update - Cast Spell Frenzy');
INSERT INTO smart_scripts VALUES (16042, 0, 3, 0, 2, 1, 100, 0, 0, 20, 0, 0, 11, 27382, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'HP Update - Cast Spell Shadow Bolt Volley');
INSERT INTO smart_scripts VALUES (16042, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (16066, 0, 0, 0, 60, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'On Update - Attack Start');

-- Unleash the Raptors (11147)
DELETE FROM gameobject WHERE id=186299;
INSERT INTO gameobject VALUES(NULL, 186299, 1, 1, 1, -2453.24, -3153.89, 35.8593, 1.97643, 0, 0, 0.835045, 0.550181, 180, 0, 1, 0);
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=186288;
DELETE FROM smart_scripts WHERE entryorguid=186288 AND source_type=1;
INSERT INTO smart_scripts VALUES (186288, 1, 0, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2525, -3222.92, 34.27, 0.8, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 1, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2516.18, -3225.72, 34.41, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 2, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2527, -3213.92, 34.5, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 3, 0, 60, 0, 100, 1, 6000, 6000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2530, -3219.1, 34.5, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 4, 0, 60, 0, 100, 1, 7000, 7000, 0, 0, 130, 0, 0, 0, 0, 0, 0, 11, 23741, 150, 0, -2460, -3159.4, 35.8, 1.1, 'On Update - Move To Pos Target');
INSERT INTO smart_scripts VALUES (186288, 1, 5, 0, 60, 0, 100, 1, 11000, 11000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2525, -3222.92, 34.27, 0.8, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 6, 0, 60, 0, 100, 1, 11000, 11000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2516.18, -3225.72, 34.41, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 7, 0, 60, 0, 100, 1, 11000, 11000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2527, -3213.92, 34.5, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 8, 0, 60, 0, 100, 1, 11000, 11000, 0, 0, 12, 23741, 4, 40000, 0, 0, 0, 8, 0, 0, 0, -2530, -3219.1, 34.5, 0.7, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (186288, 1, 9, 0, 60, 0, 100, 1, 12000, 12000, 0, 0, 130, 0, 0, 0, 0, 0, 0, 11, 23741, 150, 0, -2460, -3159.4, 35.8, 1.1, 'On Update - Move To Pos Target');
INSERT INTO smart_scripts VALUES (186288, 1, 10, 0, 60, 0, 100, 1, 2000, 2000, 0, 0, 33, 23727, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 'On Update - Kill Credit');

-- The Videre Elixir (3909)
REPLACE INTO creature_text VALUES(9467, 0, 0, 'Meat!', 12, 0, 100, 0, 0, 0, 0, 'Miblon Snarltooth');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=164758;
DELETE FROM smart_scripts WHERE entryorguid=164758 AND source_type=1;
INSERT INTO smart_scripts VALUES (164758, 1, 0, 0, 60, 0, 100, 1, 500, 500, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 9467, 30, 0, 0, 0, 0, 0, 'On Update - Set Data');
INSERT INTO smart_scripts VALUES (164758, 1, 1, 0, 60, 0, 100, 1, 3500, 3500, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Despawn');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=9467;
DELETE FROM smart_scripts WHERE entryorguid=9467 AND source_type=0;
INSERT INTO smart_scripts VALUES (9467, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Talk');
INSERT INTO smart_scripts VALUES (9467, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 20, 164758, 30, 0, 0, 0, 0, 0, 'On Data Set - Move To Pos');
INSERT INTO smart_scripts VALUES (9467, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Data Set - Despawn');
INSERT INTO smart_scripts VALUES (9467, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 164729, 30, 0, 0, 0, 0, 0, 'On Data Set - Set Loot State');

-- Screecher Spirits (3520)
UPDATE creature_template SET gossip_menu_id=1405, AIName='SmartAI', ScriptName='' WHERE entry=8612;
DELETE FROM smart_scripts WHERE entryorguid=8612 AND source_type=0;
INSERT INTO smart_scripts VALUES (8612, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 5308, 3, 0, 0, 0, 0, 0, 'On Reset - Despawn Target');
INSERT INTO smart_scripts VALUES (8612, 0, 1, 2, 64, 0, 100, 1, 0, 0, 0, 0, 33, 8612, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Kill Credit');
INSERT INTO smart_scripts VALUES (8612, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Despawn');

-- Ancient Spirit (4261)
UPDATE quest_template SET SpecialFlags=2 WHERE Id=4261;
DELETE FROM event_scripts WHERE id=3839;
INSERT INTO event_scripts VALUES (3839, 0, 10, 9598, 2000000, 1, 5998.7, -1208, 377.75, 0.36);
DELETE FROM creature_text WHERE entry=9598;
INSERT INTO creature_text VALUES(9598, 0, 0, "Please, help me to get through this cursed forest, $r", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 1, 0, "This creature suffers from the effects of the fel... We must end its misery.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 1, 1, "I regret that I must fight this $N", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 1, 2, "That I must fight my own kind deeply saddens me.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 1, 3, "I sense the taint of corruption upon this $N. Help me destroy it!", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 1, 4, "This $N has been driven mad from the corruption!", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 2, 0, "The corruption has not left any of the creatures of Felwood untouched, $N. Please, be on your guard.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 3, 0, "I can sense it now, $N. Ashenvale lies down this road.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 4, 0, "I feel... something strange...", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 5, 0, "$N, my form has now changed! The true strength of my spirit is returning to me now... The cursed grasp of the forest is leaving me.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
INSERT INTO creature_text VALUES(9598, 6, 0, "Thank you, $N. Now my spirit will finally be at peace.", 12, 0, 100, 0, 0, 0, 0, 'Arei');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=9598;
DELETE FROM smart_scripts WHERE entryorguid=9598 AND source_type=0;
INSERT INTO smart_scripts VALUES (9598, 0, 0, 1, 19, 0, 100, 0, 4261, 0, 0, 0, 53, 1, 9598, 0, 0, 1000, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (9598, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 3, 0, 40, 0, 100, 0, 13, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 4, 5, 40, 0, 100, 0, 34, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 6534.9, -1203.5, 436.73, 3.14, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (9598, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 6527.64, -1196.54, 435.9, 3.9, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (9598, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 7138, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 6532.7, -1216.04, 434.4, 2.4, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (9598, 0, 7, 8, 40, 0, 100, 0, 38, 0, 0, 0, 54, 20000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Stop WP');
INSERT INTO smart_scripts VALUES (9598, 0, 8, 0, 61, 0, 100, 0, 38, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Set Phase');
INSERT INTO smart_scripts VALUES (9598, 0, 9, 0, 60, 1, 100, 1, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 10, 0, 60, 1, 100, 1, 7000, 7000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 11, 0, 60, 1, 100, 1, 11000, 11000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 12, 0, 60, 1, 100, 1, 18000, 18000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (9598, 0, 13, 0, 60, 1, 100, 1, 19000, 19000, 0, 0, 15, 4261, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Update - Area Explored');
DELETE FROM waypoints WHERE entry=9598;
INSERT INTO waypoints VALUES (9598, 1, 6011.87, -1206.14, 375.561, 'Arei'),(9598, 2, 6026.35, -1210.71, 375.004, 'Arei'),(9598, 3, 6036.67, -1218.31, 375.011, 'Arei'),(9598, 4, 6045.28, -1226.18, 375.912, 'Arei'),(9598, 5, 6054.33, -1235.35, 380.134, 'Arei'),(9598, 6, 6060.08, -1241.18, 379.311, 'Arei'),(9598, 7, 6069.08, -1250.3, 377.394, 'Arei'),(9598, 8, 6079.96, -1260.89, 380.247, 'Arei'),(9598, 9, 6091.53, -1270.74, 382.514, 'Arei'),(9598, 10, 6101.28, -1279.05, 382.221, 'Arei'),(9598, 11, 6106.47, -1281.66, 379.981, 'Arei'),(9598, 12, 6114.83, -1285.91, 374.413, 'Arei'),
(9598, 13, 6119.34, -1288.86, 372.714, 'Arei'),(9598, 14, 6124.22, -1294.39, 374.877, 'Arei'),(9598, 15, 6129.57, -1298.9, 377.209, 'Arei'),(9598, 16, 6136.37, -1300.53, 377.401, 'Arei'),(9598, 17, 6154.7, -1304.1, 376.031, 'Arei'),(9598, 18, 6192.88, -1309.05, 375.798, 'Arei'),(9598, 19, 6213.68, -1311.98, 374.733, 'Arei'),(9598, 20, 6221.79, -1313.12, 374.211, 'Arei'),(9598, 21, 6234.54, -1314.92, 373.224, 'Arei'),(9598, 22, 6262.27, -1318.83, 371.715, 'Arei'),(9598, 23, 6273.99, -1311.17, 371.386, 'Arei'),(9598, 24, 6296.53, -1301.73, 373.986, 'Arei'),
(9598, 25, 6319.85, -1288.51, 374.199, 'Arei'),(9598, 26, 6351.37, -1270.72, 376.292, 'Arei'),(9598, 27, 6383.36, -1256.52, 377.835, 'Arei'),(9598, 28, 6398.86, -1244.07, 379.409, 'Arei'),(9598, 29, 6408.99, -1241.33, 381.855, 'Arei'),(9598, 30, 6429.26, -1235.84, 386.28, 'Arei'),(9598, 31, 6449.47, -1230.37, 391.948, 'Arei'),(9598, 32, 6475.28, -1223.38, 405.809, 'Arei'),(9598, 33, 6495.55, -1217.89, 417.411, 'Arei'),(9598, 34, 6518.11, -1211.77, 428.278, 'Arei'),(9598, 35, 6533.3, -1211.69, 434.861, 'Arei'),(9598, 36, 6550.8, -1211.19, 440.288, 'Arei'),(9598, 37, 6569.47, -1210.87, 442.945, 'Arei'),
(9598, 38, 6570.77, -1191.03, 441.896, 'Arei'),(9598, 39, 6561.04, -1175.07, 440.059, 'Arei'),(9598, 40, 6547.03, -1153.62, 437.264, 'Arei');

-- Rescue From Jaedenar (5203)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=11016);
UPDATE quest_template SET SpecialFlags=2 WHERE Id=5203;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=3129;
INSERT INTO conditions VALUES (14, 3129, 3865, 0, 0, 8, 0, 5202, 0, 0, 1, 0, 0, '', 'Show Text if Quest not rewarded');
INSERT INTO conditions VALUES (14, 3129, 4113, 0, 0, 8, 0, 5202, 0, 0, 0, 0, 0, '', 'Show Text if Quest rewarded');
DELETE FROM creature_text WHERE entry IN(11016, 11018, 11141);
INSERT INTO creature_text VALUES (11016, 0, 0, "I'm ready $N. Let's find my equipment and get out of here. I think I know where it is.", 12, 0, 100, 0, 0, 0, 0, "Captured Arko'narin");
INSERT INTO creature_text VALUES (11016, 1, 0, "Oh my! Look at this... all these candles. I'm sure they're used for some terrible ritual or dark summoning. We best make haste!", 12, 0, 100, 1, 0, 0, 0, "Captured Arko'narin");
INSERT INTO creature_text VALUES (11016, 2, 0, "Look! Over there!", 12, 0, 100, 25, 0, 0, 0, "Captured Arko'narin");
INSERT INTO creature_text VALUES (11016, 3, 0, "You will not stop me from escaping here!", 12, 0, 100, 0, 0, 0, 0, "Captured Arko'narin");
INSERT INTO creature_text VALUES (11018, 0, 0, "All i need now is a golden lasso.", 12, 0, 100, 0, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11018, 1, 0, "DIE, DEMON DOGS!", 12, 0, 100, 0, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11018, 2, 0, "Ah! Fresh air at last! I never thought I'd see the day...", 12, 0, 100, 4, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11018, 3, 0, "You will not stop me from escaping here!", 12, 0, 100, 0, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11018, 4, 0, "What was that?! Trey? TREY!?", 12, 0, 100, 1, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11018, 5, 0, "No! My friend... what's happened? That's all my fault...", 12, 0, 100, 20, 0, 0, 0, "Arko'narin");
INSERT INTO creature_text VALUES (11141, 0, 0, "BETRAYER!", 14, 0, 100, 0, 0, 0, 0, "Spirit of Trey Lightforge");
UPDATE creature_template SET minlevel=51, maxlevel=51, speed_walk=1.2, faction=250, gossip_menu_id=30229, AIName='SmartAI' WHERE entry=11016;
UPDATE creature_template SET minlevel=51, maxlevel=51, speed_walk=1.2, faction=250, AIName='SmartAI' WHERE entry=11018;
DELETE FROM smart_scripts WHERE entryorguid=11016 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=11016*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (11016, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Byte 0');
INSERT INTO smart_scripts VALUES (11016, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 18, 2+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Flag');
INSERT INTO smart_scripts VALUES (11016, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set NPC Flag');
INSERT INTO smart_scripts VALUES (11016, 0, 3, 4, 19, 0, 100, 0, 5203, 0, 0, 0, 53, 0, 11016, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (11016, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 131, 0, 0, 0, 0, 0, 0, 20, 176306, 10, 0, 0, 0, 0, 0, 'On Quest Accept - Set GO State');
INSERT INTO smart_scripts VALUES (11016, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Byte 0');
INSERT INTO smart_scripts VALUES (11016, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 19, 2+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Flag');
INSERT INTO smart_scripts VALUES (11016, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set NPC Flag');
INSERT INTO smart_scripts VALUES (11016, 0, 8, 9, 40, 0, 100, 0, 1, 11016, 0, 0, 54, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (11016, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Remove Byte 0');
INSERT INTO smart_scripts VALUES (11016, 0, 11, 12, 40, 0, 100, 0, 16, 11016, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (11016, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 13, 14, 40, 0, 100, 0, 36, 11016, 0, 0, 54, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (11016, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 5.32, 'On WP Reached - Set Orientation');
INSERT INTO smart_scripts VALUES (11016, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Set Run');
INSERT INTO smart_scripts VALUES (11016, 0, 17, 0, 40, 0, 100, 0, 40, 11016, 0, 0, 80, 11016*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Script9');
INSERT INTO smart_scripts VALUES (11016, 0, 20, 0, 4, 0, 33, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 21, 22, 40, 0, 100, 0, 1, 11018, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 12, 9862, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 5083.8, -493.3, 296.7, 5.1, 'On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (11016, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 12, 9862, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 5088, -491, 296.7, 5.1, 'On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (11016, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 9862, 4, 30000, 0, 1, 0, 8, 0, 0, 0, 5089, -498, 296.7, 5.1, 'On WP Reached - Summon Creature');
INSERT INTO smart_scripts VALUES (11016, 0, 30, 31, 40, 0, 100, 0, 55, 11018, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 31, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Set Phase');
INSERT INTO smart_scripts VALUES (11016, 0, 32, 0, 60, 2, 100, 1, 5000, 5000, 0, 0, 12, 11141, 4, 50000, 0, 0, 0, 8, 0, 0, 0, 4850, -399, 351.7, 0, 'On Update - Summon Creature');
INSERT INTO smart_scripts VALUES (11016, 0, 33, 0, 60, 2, 100, 1, 5100, 5100, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 11141, 50, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 34, 0, 60, 2, 100, 1, 8000, 8000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 35, 0, 60, 2, 100, 1, 10000, 10000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 11141, 50, 0, 0, 0, 0, 0, 'On Update - Attack Start');
INSERT INTO smart_scripts VALUES (11016, 0, 36, 37, 7, 2, 100, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Set Home Pos');
INSERT INTO smart_scripts VALUES (11016, 0, 37, 38, 61, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Talk');
INSERT INTO smart_scripts VALUES (11016, 0, 38, 39, 61, 0, 100, 0, 0, 0, 0, 0, 15, 5203, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'On Evade - Area Explored');
INSERT INTO smart_scripts VALUES (11016, 0, 39, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Evade - Despawn');
INSERT INTO smart_scripts VALUES (11016*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 2+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Flag');
INSERT INTO smart_scripts VALUES (11016*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Byte 0');
INSERT INTO smart_scripts VALUES (11016*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 176225, 10, 0, 0, 0, 0, 0, 'Script9 - Activate Object');
INSERT INTO smart_scripts VALUES (11016*100, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 11, 18163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (11016*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Byte 0');
INSERT INTO smart_scripts VALUES (11016*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 36, 11018, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Update Entry');
INSERT INTO smart_scripts VALUES (11016*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.1, 'Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (11016*100, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (11016*100, 9, 8, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 19, 2+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Flag');
INSERT INTO smart_scripts VALUES (11016*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 0, 11018, 0, 0, 0, 2, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Script9 - Start WP');
DELETE FROM waypoints WHERE entry IN(11016, 11018);
INSERT INTO waypoints VALUES (11016, 1, 5004.39, -440.218, 319.059, "Captured Arko'narin"),(11016, 2, 4992.55, -445.091, 317.492, "Captured Arko'narin"),(11016, 3, 4989.93, -451.582, 316.695, "Captured Arko'narin"),(11016, 4, 4988.5, -459.647, 316.344, "Captured Arko'narin"),(11016, 5, 4990.09, -467.608, 317.526, "Captured Arko'narin"),(11016, 6, 4994.75, -468.153, 318.242, "Captured Arko'narin"),(11016, 7, 5002.59, -466.031, 320.017, "Captured Arko'narin"),(11016, 8, 5012.58, -463.028, 321.489, "Captured Arko'narin"),(11016, 9, 5020.44, -461.323, 321.97, "Captured Arko'narin"),(11016, 10, 5024.96, -462.572, 321.536, "Captured Arko'narin"),(11016, 11, 5029.91, -473.162, 319.025, "Captured Arko'narin"),(11016, 12, 5029.19, -478.928, 318.429, "Captured Arko'narin"),(11016, 13, 5028.7, -487.032, 318.17, "Captured Arko'narin"),
(11016, 14, 5028.92, -497.53, 316.507, "Captured Arko'narin"),(11016, 15, 5031.79, -510.085, 314.483, "Captured Arko'narin"),(11016, 16, 5036.49, -520.788, 313.222, "Captured Arko'narin"),(11016, 17, 5050.98, -519.271, 313.222, "Captured Arko'narin"),(11016, 18, 5058.4, -522.748, 313.222, "Captured Arko'narin"),(11016, 19, 5062.73, -531.066, 313.222, "Captured Arko'narin"),(11016, 20, 5063.51, -539.149, 313.222, "Captured Arko'narin"),(11016, 21, 5059.9, -551.441, 313.222, "Captured Arko'narin"),(11016, 22, 5060.11, -556.056, 312.314, "Captured Arko'narin"),(11016, 23, 5059.06, -564.179, 309.646, "Captured Arko'narin"),(11016, 24, 5052.57, -566.791, 307.597, "Captured Arko'narin"),(11016, 25, 5044.38, -567.059, 304.523, "Captured Arko'narin"),(11016, 26, 5039.3, -560.729, 302.003, "Captured Arko'narin"),(11016, 27, 5039.43, -551.35, 298.756, "Captured Arko'narin"),
(11016, 28, 5040.66, -546.825, 297.801, "Captured Arko'narin"),(11016, 29, 5046.1, -537.843, 297.801, "Captured Arko'narin"),(11016, 30, 5054.23, -531.202, 297.801, "Captured Arko'narin"),(11016, 31, 5063.29, -523.809, 297.801, "Captured Arko'narin"),(11016, 32, 5066.8, -520.703, 297.779, "Captured Arko'narin"),(11016, 33, 5066.33, -514.842, 297.205, "Captured Arko'narin"),(11016, 34, 5063.42, -500.005, 297.307, "Captured Arko'narin"),(11016, 35, 5064.62, -493.107, 297.857, "Captured Arko'narin"),(11016, 36, 5075.4, -486.118, 298.05, "Captured Arko'narin"),(11016, 37, 5086.58, -497.992, 296.678, "Captured Arko'narin"),(11016, 38, 5095.47, -507.214, 296.678, "Captured Arko'narin"),(11016, 39, 5107.28, -525.921, 296.678, "Captured Arko'narin"),(11016, 40, 5109.28, -531.45, 296.678, "Captured Arko'narin"),
(11018, 1, 5107.29, -525.787, 296.675, "Arko'narin"),(11018, 2, 5101.14, -517.273, 296.675, "Arko'narin"),(11018, 3, 5075.65, -488.439, 297.712, "Arko'narin"),(11018, 4, 5065.03, -493.146, 297.799, "Arko'narin"),(11018, 5, 5063.51, -499.978, 297.292, "Arko'narin"),(11018, 6, 5066.99, -512.305, 297.355, "Arko'narin"),(11018, 7, 5064.28, -519.957, 297.801, "Arko'narin"),(11018, 8, 5054.35, -529.826, 297.801, "Arko'narin"),(11018, 9, 5046.94, -535.581, 297.801, "Arko'narin"),
(11018, 10, 5041.77, -547.301, 297.801, "Arko'narin"),(11018, 11, 5039.4, -555.14, 300.052, "Arko'narin"),(11018, 12, 5039.68, -562.135, 302.439, "Arko'narin"),(11018, 13, 5048.66, -567.579, 306.134, "Arko'narin"),(11018, 14, 5057.27, -564.043, 309.536, "Arko'narin"),(11018, 15, 5060.86, -555.453, 312.333, "Arko'narin"),(11018, 16, 5060.85, -547.333, 313.221, "Arko'narin"),(11018, 17, 5064.39, -532.56, 313.221, "Arko'narin"),(11018, 18, 5054.88, -520.712, 313.221, "Arko'narin"),(11018, 19, 5037.44, -519.284, 313.221, "Arko'narin"),(11018, 20, 5032.65, -511.348, 314.441, "Arko'narin"),
(11018, 21, 5030.09, -492.906, 317.256, "Arko'narin"),(11018, 22, 5027.79, -475.488, 318.842, "Arko'narin"),(11018, 23, 5026.37, -462.686, 321.424, "Arko'narin"),(11018, 24, 5013.68, -460.941, 321.755, "Arko'narin"),(11018, 25, 5002.58, -467.34, 320.059, "Arko'narin"),(11018, 26, 4993.2, -467.421, 317.871, "Arko'narin"),(11018, 27, 4987.07, -460.418, 316.287, "Arko'narin"),(11018, 28, 4988.66, -452.385, 316.502, "Arko'narin"),(11018, 29, 4994.42, -434.605, 319.039, "Arko'narin"),(11018, 30, 4994.6, -425.227, 318.711, "Arko'narin"),(11018, 31, 4985.41, -420.139, 320.193, "Arko'narin"),(11018, 32, 4974.19, -426.205, 324.132, "Arko'narin"),
(11018, 33, 4965.52, -429.775, 325.037, "Arko'narin"),(11018, 34, 4955.46, -421.852, 326.826, "Arko'narin"),(11018, 35, 4949.47, -407.892, 328.057, "Arko'narin"),(11018, 36, 4936.39, -400.308, 330.817, "Arko'narin"),(11018, 37, 4928.51, -398.061, 332.164, "Arko'narin"),(11018, 38, 4925.14, -397.1, 333.147, "Arko'narin"),(11018, 39, 4913.84, -394.113, 333.605, "Arko'narin"),(11018, 40, 4907.79, -395.824, 333.384, "Arko'narin"),(11018, 41, 4905.67, -396.371, 335.019, "Arko'narin"),(11018, 42, 4899.36, -395.377, 337.026, "Arko'narin"),(11018, 43, 4895.65, -390.903, 338.662, "Arko'narin"),(11018, 44, 4895.4, -383.908, 340.59, "Arko'narin"),
(11018, 45, 4899.76, -380.062, 342.202, "Arko'narin"),(11018, 46, 4906.25, -379.16, 344.018, "Arko'narin"),(11018, 47, 4911.07, -382.763, 345.661, "Arko'narin"),(11018, 48, 4912.74, -388.328, 347.233, "Arko'narin"),(11018, 49, 4909.21, -394.303, 349.082, "Arko'narin"),(11018, 50, 4902.74, -396.962, 350.984, "Arko'narin"),(11018, 51, 4897.54, -394.369, 351.814, "Arko'narin"),(11018, 52, 4891.74, -393.963, 351.815, "Arko'narin"),(11018, 53, 4881.32, -395.247, 351.591, "Arko'narin"),(11018, 54, 4878.31, -395.653, 349.703, "Arko'narin"),(11018, 55, 4873.66, -396.281, 349.98, "Arko'narin");

-- Gnogaine (2926)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=11513;
INSERT INTO conditions VALUES (17, 0, 11513, 0, 0, 29, 0, 6213, 6, 0, 0, 0, 0, '', 'Must be near NPC to cast');
INSERT INTO conditions VALUES (17, 0, 11513, 0, 1, 29, 0, 6329, 6, 0, 0, 0, 0, '', 'Must be near NPC to cast');

-- The Only Cure is More Green Glow (2962)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=12709;
INSERT INTO conditions VALUES (17, 0, 12709, 0, 0, 29, 0, 6218, 5, 0, 0, 0, 0, '', 'Must be near NPC to cast');
INSERT INTO conditions VALUES (17, 0, 12709, 0, 1, 29, 0, 6220, 5, 0, 0, 0, 0, '', 'Must be near NPC to cast');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=11637;
INSERT INTO conditions VALUES (13, 1, 11637, 0, 0, 31, 0, 3, 6218, 0, 0, 0, 0, '', 'Requires Entry');
INSERT INTO conditions VALUES (13, 1, 11637, 0, 1, 31, 0, 3, 6220, 0, 0, 0, 0, '', 'Requires Entry');

-- The Torch of Retribution (3454)
DELETE FROM gameobject WHERE id IN(149047, 149410);
DELETE FROM smart_scripts WHERE entryorguid=8479 AND source_type=0 AND id>4;
INSERT INTO smart_scripts VALUES(8479, 0, 5, 6, 19, 0, 100, 0, 3454, 0, 0, 0, 50, 149047, 60, 1, 0, 0, 0, 8, 0, 0, 0, -6683.73, -1194.19, 242.02, 0.212059, "On Quest Accept - Summon GO");
INSERT INTO smart_scripts VALUES(8479, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 149410, 60, 1, 0, 0, 0, 8, 0, 0, 0, -6683.73, -1194.19, 240.02, 0.447678, "On Quest Accept - Summon GO");

-- Vyletongue Corruption (7029)
-- Vyletongue Corruption (7041)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=21885;
INSERT INTO conditions VALUES (13, 1, 21885, 0, 0, 31, 0, 5, 178908, 0, 0, 0, 0, '', 'Target Vylestem Vine');
INSERT INTO conditions VALUES (13, 1, 21885, 0, 1, 31, 0, 5, 178905, 0, 0, 0, 0, '', 'Target Vylestem Vine');

-- No Mere Dreams (10965)
DELETE FROM smart_scripts WHERE entryorguid=22834 AND source_type=0 AND id>4;
UPDATE smart_scripts SET event_phase_mask=0 WHERE entryorguid=22834 AND source_type=0;

-- The Exorcism (1955)
DELETE FROM smart_scripts WHERE entryorguid=6546 AND source_type=0 AND id=5;
INSERT INTO smart_scripts VALUES (6546, 0, 5, 0, 19, 0, 100, 0, 1955, 0, 0, 0, 80, 654600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tabetha - On Quest Accept - Run Script');

-- Vent Horizon (25212)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=11211;
INSERT INTO conditions VALUES (15, 11211, 0, 0, 0, 9, 0, 25212, 0, 0, 0, 0, 0, '', 'Requires quest active');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=73082;
INSERT INTO conditions VALUES (13, 1, 73082, 0, 0, 31, 0, 3, 39420, 0, 0, 0, 0, '', 'Target Probe Credit');
UPDATE creature_template SET minlevel=40, maxlevel=40, AIName='SmartAI' WHERE entry=39396;
DELETE FROM smart_scripts WHERE entryorguid=39396 AND source_type=0;
INSERT INTO smart_scripts VALUES (39396, 0, 0, 0, 62, 0, 100, 0, 11211, 0, 0, 0, 11, 73896, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Cast Spell');
UPDATE creature_template SET scale=3, unit_flags=33554432, flags_extra=130, InhabitType=4, AIName='SmartAI' WHERE entry=39420;
DELETE FROM smart_scripts WHERE entryorguid=39420 AND source_type=0;
INSERT INTO smart_scripts VALUES (39420, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 75779, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Reset - Cast Spell');
INSERT INTO smart_scripts VALUES (39420, 0, 1, 0, 8, 0, 100, 0, 73082, 0, 0, 0, 33, 39420, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
-- INSERT INTO smart_scripts VALUES (39420, 0, 1, 0, 8, 0, 100, 0, 73082, 0, 0, 0, 11, 73906, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Cast Spell');
DELETE FROM creature WHERE id=39420;
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5019.37, 544.06, 472.711, 4.05297, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5125.03, 595.187, 459.885, 0.83284, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5158.07, 629.349, 466.213, 1.76354, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5223.95, 624.789, 455.977, 1.55938, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5347.67, 647.579, 444.626, 3.16551, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 39420, 0, 1, 1, 0, 0, -5303.11, 663.793, 448.898, 1.65362, 300, 0, 0, 42, 0, 0, 0, 0, 0);

-- Herald of War (13257)
-- Fate, Up Against Your Will (13369)
DELETE FROM creature_questender WHERE quest=13257;
INSERT INTO creature_questender VALUES (32363, 13257);
DELETE FROM spell_area WHERE area=1519 AND spell=60877;
DELETE FROM spell_area WHERE area IN(14, 1637) AND spell=60815;
INSERT INTO spell_area VALUES(60877, 1519, 13347, 13377, 0, 1101, 2, 1, 74, 11);
-- INSERT INTO spell_area VALUES(60815, 14, 13347, 13377, 0, 1101, 2, 1, 74, 11);
-- INSERT INTO spell_area VALUES(60815, 1637, 13347, 13377, 0, 1101, 2, 1, 74, 11);
-- INSERT INTO spell_area VALUES(60815, 14, 13242, 13267, 0, 690, 2, 1, 74, 11);
-- INSERT INTO spell_area VALUES(60815, 1637, 13242, 13267, 0, 690, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(60815, 14, 13347, 13370, 0, 1101, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(60815, 1637, 13347, 13370, 0, 1101, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(60815, 14, 13242, 13257, 0, 690, 2, 1, 74, 11);
INSERT INTO spell_area VALUES(60815, 1637, 13242, 13257, 0, 690, 2, 1, 74, 11);
DELETE FROM creature WHERE id=32346;
INSERT INTO creature VALUES (NULL, 32346, 0, 1, 1, 0, 1, -8443.36, 331.838, 122.663, 1.85005, 300, 0, 0, 5907158, 746240, 0, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (32346, 0, 0, 0, 1, 0, '60878');
REPLACE INTO gossip_menu_option VALUES (10189, 0, 0, 'Lady Proudmoore, I am ready to go to Orgrimmar. Please open a portal.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM creature_text WHERE entry IN(31437, 31467, 32346, 32363, 32364, 32365);
INSERT INTO creature_text VALUES (31437, 0, 0, "The Dark Lady fought as many as she could, but in the end... I hope she survived. Please help!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31437, 0, 1, "Could you spare a gold?", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31437, 0, 2, "They killed hundreds! We barely escaped with our lives! Help!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31437, 0, 3, "You must help! We're homeless!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31467, 0, 0, "The Dark Lady fought as many as she could, but in the end... I hope she survived. Please help!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31467, 0, 1, "Could you spare a gold?", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31467, 0, 2, "They killed hundreds! We barely escaped with our lives! Help!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (31467, 0, 3, "You must help! We're homeless!", 12, 0, 100, 0, 0, 0, 0, 'Forsaken Refugee');
INSERT INTO creature_text VALUES (32346, 0, 0, "Do not do anything that would incite the Horde, $N. The Warchief has agreed to see us on good faith.", 12, 0, 100, 0, 0, 16124, 0, 'Jaina Proudmoore, stormwind');
INSERT INTO creature_text VALUES (32346, 1, 0, "Let's go.", 12, 0, 100, 0, 0, 16125, 0, 'Jaina Proudmoore, stormwind');
INSERT INTO creature_text VALUES (32363, 0, 0, "Kor'kron, stand down!", 12, 0, 100, 5, 0, 16222, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 1, 0, "Jaina...", 12, 0, 100, 1, 0, 16223, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 2, 0, "Jaina, what happened at the Wrathgate. It was a betrayal from within...", 12, 0, 100, 1, 0, 16224, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 3, 0, "The Horde has lost the Undercity.", 12, 0, 100, 1, 0, 16225, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 4, 0, "We now prepare to lay siege to the city and bring in the perpetrators of the unforgivable crime to justice.", 12, 0, 100, 1, 0, 16226, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 5, 0, "If we are forced into a conflict, the Lich King will destroy our divided forces in Northrend.", 12, 0, 100, 1, 0, 16227, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 6, 0, "We will make this right, Jaina. Tell your king all that you have learned here.", 12, 0, 100, 1, 0, 16228, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32363, 7, 0, "Kor'kron, prepare transport to the Undercity.", 12, 0, 100, 1, 0, 16229, 0, 'Thrall, Phased orgrimmar');
INSERT INTO creature_text VALUES (32364, 0, 0, "Thrall, what has happened? The King is preparing for war...", 12, 0, 100, 1, 0, 16129, 0, 'Jaina Proudmoore, Phased orgrimmar');
INSERT INTO creature_text VALUES (32364, 1, 0, "I will deliver this information to King Wrynn, Thrall, but...", 12, 0, 100, 1, 0, 16130, 0, 'Jaina Proudmoore, Phased orgrimmar');
INSERT INTO creature_text VALUES (32364, 2, 0, "Bolvar was like a brother to him. In the King's absence, Bolvar kept the Alliance united. He found strength for our people in our darkest hours. He watched over Anduin, raising him as his own.", 12, 0, 100, 1, 0, 16131, 0, 'Jaina Proudmoore, Phased orgrimmar');
INSERT INTO creature_text VALUES (32364, 3, 0, "I fear that the rage will consume him, Thrall. I remain hopeful that reason will prevail, but we must prepare for the worst... for war.", 12, 0, 100, 1, 0, 16132, 0, 'Jaina Proudmoore, Phased orgrimmar');
INSERT INTO creature_text VALUES (32364, 4, 0, "Farewell, Warchief. I pray that the next time we meet it will be as allies.", 12, 0, 100, 16, 0, 16133, 0, 'Jaina Proudmoore, Phased orgrimmar');
INSERT INTO creature_text VALUES (32365, 0, 0, "Lady Proudmoore, the Warchief speaks the truth. This subterfuge was set in motion by Varimathras and Grand Apothecary Putress. It was not the Horde's doing.", 12, 0, 100, 1, 0, 16315, 0, 'Sylvanas, Phased orgrimmar');
INSERT INTO creature_text VALUES (32365, 1, 0, "As the combined Horde and Alliance forces began their assault upon the Wrathgate, an uprising broke out in the Undercity. Varimathras and hordes of his demonic brethren attacked. Hundreds of my people were slain in the coup. I barely managed to escape with my life.", 12, 0, 100, 1, 0, 16316, 0, 'Sylvanas, Phased orgrimmar');
UPDATE creature_template SET gossip_menu_id=10189, npcflag=1, AIName='SmartAI' WHERE entry=32346;
DELETE FROM smart_scripts WHERE entryorguid=32346 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=32346*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (32346, 0, 0, 0, 62, 0, 100, 0, 10189, 0, 0, 0, 80, 32346*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Script9');
INSERT INTO smart_scripts VALUES (32346*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Npc Flags');
INSERT INTO smart_scripts VALUES (32346*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32346*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 11, 60904, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Cast Spell');
INSERT INTO smart_scripts VALUES (32346*100, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32346*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 50, 193948, 20, 0, 0, 0, 0, 8, 0, 0, 0, -8445.34, 333.8, 122.162, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (32346*100, 9, 5, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Npc Flags');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=10189;
INSERT INTO conditions VALUES (15, 10189, 0, 0, 0, 28, 0, 13369, 0, 0, 0, 0, 0, '', 'Requires quest complete');
UPDATE creature_template set minlevel=83, maxlevel=83, exp=2, AIName='SmartAI' WHERE entry=32363;
UPDATE creature_template set minlevel=83, maxlevel=83, exp=2, AIName='PassiveAI' WHERE entry=32365;
UPDATE creature_template set minlevel=83, maxlevel=83, exp=2, AIName='PassiveAI' WHERE entry=32367;
UPDATE creature_template set minlevel=83, maxlevel=83, exp=2, AIName='PassiveAI' WHERE entry=32364;
DELETE FROM creature WHERE id IN(32363, 32364, 32365, 32367);
INSERT INTO creature VALUES (NULL, 32367, 1, 1, 128, 0, 1, 1909.64, -4139.34, 40.6099, 6.04237, 300, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32367, 1, 1, 128, 0, 1, 1931.32, -4136.56, 40.6125, 4.01604, 300, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32367, 1, 1, 128, 0, 1, 1931.97, -4154.32, 40.6246, 1.6245, 300, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32367, 1, 1, 128, 0, 1, 1910.9, -4154.71, 40.6308, 1.58916, 300, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32365, 1, 1, 128, 0, 1, 1920.05, -4129.93, 43.1426, 4.80472, 300, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (NULL, 32363, 1, 1, 128, 0, 1, 1920.71, -4136.74, 40.5393, 4.84791, 300, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM gameobject WHERE id=193207;
INSERT INTO gameobject VALUES (NULL, 193207, 1, 1, 128, 1921.34, -4146.44, 40.4888, 1.67552, 0, 0, 0, 0, 300, 0, 1, 0);
DELETE FROM smart_scripts WHERE entryorguid=32363 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=32363*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (32363, 0, 0, 0, 10, 0, 100, 0, 1, 100, 170000, 170000, 80, 32363*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On OOC Los - Script9');
INSERT INTO smart_scripts VALUES (32363*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 32364, 3, 140000, 0, 0, 0, 8, 0, 0, 0, 1921.34, -4146.44, 40.4888, 1.67552, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (32363*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 11, 32367, 50, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (32363*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (32363*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 19, 32365, 50, 0, 0, 0, 0, 0, 'Script9 - Set Run');
INSERT INTO smart_scripts VALUES (32363*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 130, 1, 0, 0, 0, 0, 0, 11, 32367, 50, 0, 1921.34, -4146.44, 40.4888, 1.67552, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32363*100, 9, 6, 0, 0, 0, 100, 0, 1700, 1700, 0, 0, 24, 0, 0, 0, 0, 0, 0, 11, 32367, 50, 0, 0, 0, 0, 0, 'Script9 - Enter Evade Target');
INSERT INTO smart_scripts VALUES (32363*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 9, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 1920.86, -4139.99, 40.588, 1.62, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32363*100, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 11, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 12, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 32365, 50, 0, 1918.1, -4137.15, 40.578, 4.87, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32363*100, 9, 13, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 32365, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 14, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 32365, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 15, 0, 0, 0, 100, 0, 19000, 19000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 16, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 17, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 18, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 19, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 20, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 21, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 22, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 23, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 130, 1, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 1921.34, -4146.44, 40.4888, 1.67552, 'Script9 - Move To Pos Target');
INSERT INTO smart_scripts VALUES (32363*100, 9, 24, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 32364, 50, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 25, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Talk');
INSERT INTO smart_scripts VALUES (32363*100, 9, 26, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 19, 32365, 50, 0, 0, 0, 0, 0, 'Script9 - Enter Evade Target');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=32363;
INSERT INTO conditions VALUES (22, 1, 32363, 0, 0, 28, 0, 13369, 0, 0, 0, 0, 0, '', 'Requires quest complete to run event');
INSERT INTO conditions VALUES (22, 1, 32363, 0, 1, 28, 0, 13257, 0, 0, 0, 0, 0, '', 'Requires quest complete to run event');
UPDATE creature_template SET minlevel=1, maxlevel=70, exp=2, AIName='SmartAI' WHERE entry IN(31437, 31467);
DELETE FROM smart_scripts WHERE entryorguid IN(31437, 31467) AND source_type=0;
INSERT INTO smart_scripts VALUES (31437, 0, 0, 0, 60, 0, 10, 0, 1000, 15000, 20000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
INSERT INTO smart_scripts VALUES (31467, 0, 0, 0, 60, 0, 10, 0, 1000, 15000, 20000, 60000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Update - Talk');
REPLACE INTO spell_target_position VALUES (60901, 0, 1, 1921.34, -4146.44, 40.4888, 1.67552); -- To orgrimmar
REPLACE INTO spell_target_position VALUES (60898, 0, 0, -8448.1, 341.87, 120.886, 5.36); -- To stormwind
DELETE FROM spell_script_names WHERE spell_id IN(60900, 59065);
INSERT INTO spell_script_names VALUES (60900, 'spell_q13369_fate_up_against_your_will'); -- To orgrimmar
INSERT INTO spell_script_names VALUES (59065, 'spell_q13369_fate_up_against_your_will'); -- To stormwind

-- Facing Negolash (8554)
DELETE FROM smart_scripts WHERE entryorguid=2289 AND source_type=1;
INSERT INTO smart_scripts VALUES (2289, 1, 0, 0, 20, 0, 100, 0, 619, 0, 0, 0, 12, 1494, 1, 300000, 1, 0, 0, 8, 0, 0, 0, -14621.9, 148.133, 1.720114, 0.994405, "Ruined Lifeboat - On Quest Complete - Spawn Negolash");

-- Therylune's Escape (945)
DELETE FROM smart_scripts WHERE entryorguid=3584 AND source_type=0;
INSERT INTO smart_scripts VALUES (3584, 0, 0, 1, 19, 0, 100, 0, 945, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Therylune - On Quest Accept - Say Line 0');
INSERT INTO smart_scripts VALUES (3584, 0, 1, 5, 61, 0, 100, 0, 0, 0, 0, 0, 53, 0, 3584, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 0, 0, 'Therylune - On Quest Accept - Start WP');
INSERT INTO smart_scripts VALUES (3584, 0, 2, 3, 40, 0, 100, 0, 20, 3584, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Therylune - On WP 20 - Say Line 1');
INSERT INTO smart_scripts VALUES (3584, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 15, 945, 0, 0, 0, 0, 0, 12, 0xFFFFFF, 0, 0, 0, 0, 0, 0, 'Therylune - On WP 20 - Quest Credit');
INSERT INTO smart_scripts VALUES (3584, 0, 4, 0, 40, 0, 100, 0, 21, 3584, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Therylune - On WP 21 - Forced Despawn');
INSERT INTO smart_scripts VALUES (3584, 0, 5, 7, 61, 0, 100, 0, 945, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Therylune - On Quest 'Therylune's Escape' Taken - Set Faction 250");
INSERT INTO smart_scripts VALUES (3584, 0, 6, 8, 11, 0, 100, 0, 0, 0, 0, 0, 2, 124, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Therylune - On Respawn - Set Faction 124");
INSERT INTO smart_scripts VALUES (3584, 0, 7, 9, 61, 0, 100, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Therylune - On Quest 'Therylune's Escape' Taken - Remove Flags Immune To NPC's");
INSERT INTO smart_scripts VALUES (3584, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Therylune - On Respawn - Set Flags Immune To NPC's");
INSERT INTO smart_scripts VALUES (3584, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Therylune - On Quest 'Therylune's Escape' Taken - Remove npc flag");

-- More Sparklematic Action (2953)
UPDATE creature_loot_template SET ChanceOrQuestChance=40 WHERE item=9308;

-- A Proper String (7635)
REPLACE INTO creature_loot_template VALUES (7040, 18705, -100, 1, 0, 1, 1),(7041, 18705, -100, 1, 0, 1, 1),(7042, 18705, -100, 1, 0, 1, 1),(7043, 18705, -100, 1, 0, 1, 1),(7044, 18705, -100, 1, 0, 1, 1),
(7045, 18705, -100, 1, 0, 1, 1),(7046, 18705, -100, 1, 0, 1, 1),(7047, 18705, -100, 1, 0, 1, 1),(7048, 18705, -100, 1, 0, 1, 1),(7049, 18705, -100, 1, 0, 1, 1),(8976, 18705, -100, 1, 0, 1, 1),(9461, 18705, -100, 1, 0, 1, 1),(10184, 18705, -100, 1, 0, 1, 1);

-- The Thandol Span (633)
UPDATE gameobject_template SET data3=30000 WHERE entry=2704;

-- Challenge to the Black Flight (11162), fix chain
UPDATE quest_template SET PrevQuestId=11158, NextQuestId=11159, ExclusiveGroup=-11160, NextQuestIdChain=11159 WHERE Id=11160;
UPDATE quest_template SET PrevQuestId=11158, NextQuestId=11159, ExclusiveGroup=-11160, NextQuestIdChain=11159 WHERE Id=11161;
UPDATE quest_template SET PrevQuestId=0, NextQuestId=0, ExclusiveGroup=0, NextQuestIdChain=11162 WHERE Id=11159;
UPDATE quest_template SET PrevQuestId=11159, NextQuestId=0, ExclusiveGroup=0, NextQuestIdChain=0 WHERE Id=11162;

-- Corrupted Sabers (4506)
DELETE FROM smart_scripts WHERE entryorguid=9937 AND source_type=0;
INSERT INTO smart_scripts VALUES (9937, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 36, 9936, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On spawn - Change template to corrupted one');
INSERT INTO smart_scripts VALUES (9937, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 16510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On OOC of 10 sec - Cast Corrupted Saber visual to self');
INSERT INTO smart_scripts VALUES (9937, 0, 2, 7, 61, 0, 100, 0, 0, 0, 0, 0, 3, 10042, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Linked with previous event - Morph to Corrupted Saber');
INSERT INTO smart_scripts VALUES (9937, 0, 3, 4, 62, 0, 100, 0, 55002, 1, 0, 0, 26, 4506, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Gossip Select - Award quest,since no credit');
INSERT INTO smart_scripts VALUES (9937, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Linked with previous event - Close gossip');
INSERT INTO smart_scripts VALUES (9937, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Linked with previous event - Set unseen');
INSERT INTO smart_scripts VALUES (9937, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Linked with previous event - Despawn in 1 sec');
INSERT INTO smart_scripts VALUES (9937, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Linked with previous event - Follow owner');

-- The Lord of Blackrock (7782)
-- The Lord of Blackrock (7784)
DELETE FROM creature_text WHERE entry IN(14392, 14721);
INSERT INTO creature_text VALUES (14392, 0, 0, "NEFARIAN IS SLAIN! people of Orgrimmar, bow down before the might of $N and his allies for they have laid a blow against the Black Dragonflight that is sure to stir the Aspects from their malaise! This defeat shall surely be felt by the father of the Black Flight: Deathwing reels in pain and anguish this day!", 14, 0, 100, 0, 0, 0, 0, 'Overlord Runthak');
INSERT INTO creature_text VALUES (14392, 1, 0, "Be lifted by $N accomplishment! Revel in his rallying cry!", 14, 0, 100, 0, 0, 0, 0, 'Overlord Runthak');
INSERT INTO creature_text VALUES (14721, 0, 0, "Citizens of the Alliance, the Lord of Blackrock is slain! Nefarian has been subdued by the combined might of $N and $Ghis:her; allies!", 14, 0, 100, 0, 0, 0, 0, 'Field Marshal Afrasiabi');
INSERT INTO creature_text VALUES (14721, 1, 0, "Let your spirits rise! Rally around your champion, bask in $Ghis:her; glory! Revel in the rallying cry of the dragon slayer!", 14, 0, 100, 0, 0, 0, 0, 'Field Marshal Afrasiabi');
UPDATE creature_template SET AIName='SmartAI' WHERE entry IN(14392, 14721);
DELETE FROM smart_scripts WHERE entryorguid IN(14392, 14721) AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(14392*100, 14721*100) AND source_type=9;
INSERT INTO smart_scripts VALUES (14392, 0, 0, 0, 20, 0, 100, 0, 7784, 0, 0, 0, 80, 14392*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Quest Complete - Start Script 9');
INSERT INTO smart_scripts VALUES (1439200, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (1439200, 9, 1, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (1439200, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 22888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Overlord Runthak - On Script - Cast Spell');
INSERT INTO smart_scripts VALUES (14721, 0, 0, 0, 20, 0, 100, 0, 7782, 0, 0, 0, 80, 14721*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Afrasiabi - On Quest Complete - Start Script 9');
INSERT INTO smart_scripts VALUES (1472100, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Afrasiabi - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (1472100, 9, 1, 0, 0, 0, 100, 0, 14000, 14000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Afrasiabi - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (1472100, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 11, 22888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Field Marshal Afrasiabi - On Script - Cast Spell');
DELETE FROM spell_script_names WHERE spell_id=22888;
INSERT INTO spell_script_names VALUES(22888, 'spell_gen_rallying_cry_of_the_dragonslayer');
INSERT INTO spell_script_names VALUES(22888, 'spell_gen_disabled_above_63');

-- Prayer to Elune (3377)
UPDATE creature_template SET gossip_menu_id=1285 WHERE entry=8436;

-- The Matron Protectorate (5160)
UPDATE gameobject_template SET faction=35 WHERE entry IN(176164, 176165);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(17159, 17160);
INSERT INTO conditions VALUES(17, 0, 17159, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, '', 'Requires Target to be player');
INSERT INTO conditions VALUES(17, 0, 17159, 0, 0, 2, 1, 12923, 1, 0, 0, 0, 0, '', 'Requires Target to have item');
INSERT INTO conditions VALUES(17, 0, 17160, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, '', 'Requires Target to be player');

-- Wrath of the Blue Flight (5162)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=10929;
DELETE FROM smart_scripts WHERE entryorguid=10929 AND source_type=0;
INSERT INTO smart_scripts VALUES (10929, 0, 0, 0, 19, 0, 100, 0, 5162, 0, 0, 0, 85, 17168, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Haleh - On Quest Accept - Cast Spell Halehs Will');
DELETE FROM spell_target_position WHERE id=17167;
INSERT INTO spell_target_position VALUES (17167, 0, 0, 1618.90, -2655.75, 44.37, 0.0);

-- The Tome of Valor (1651)
UPDATE creature_template SET faction=14 WHERE entry=6180;
DELETE FROM smart_scripts WHERE entryorguid=6180 AND source_type=0 AND id=2;

-- Gnomer-gooooone! (2843)
UPDATE gameobject_template SET faction=35 WHERE entry IN(142172, 142176);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry IN(11362, 11409);
INSERT INTO conditions VALUES (17, 0, 11362, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, '', 'Requires Target to be player');
INSERT INTO conditions VALUES (17, 0, 11362, 0, 0, 2, 1, 9173, 1, 0, 0, 0, 0, '', 'Requires Target to have item');
INSERT INTO conditions VALUES (17, 0, 11409, 0, 0, 31, 1, 4, 0, 0, 0, 0, 0, '', 'Requires Target to be player');

-- Relic of the Earthen Ring (14100)
-- Relic of the Earthen Ring (14111)
UPDATE quest_template SET RewardSpellCast=0 WHERE Id IN (14111, 14100);
DELETE FROM spell_linked_spell WHERE spell_trigger=66744;

-- Suntara Stones (3367)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=8284);
UPDATE creature_template SET unit_flags=4096, AIName='SmartAI', ScriptName='' WHERE entry=8284;
DELETE FROM smart_scripts WHERE entryorguid=8284 AND source_type=0;
INSERT INTO smart_scripts VALUES (8284, 0, 0, 10, 11, 0, 100, 0, 0, 0, 0, 0, 18, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spawn - Add Unit Flag');
INSERT INTO smart_scripts VALUES (8284, 0, 1, 2, 19, 0, 100, 0, 3367, 0, 0, 0, 53, 1, 8284, 0, 3367, 30000, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (8284, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256+512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Flag');
INSERT INTO smart_scripts VALUES (8284, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Remove Bytes1 stand state');
INSERT INTO smart_scripts VALUES (8284, 0, 4, 5, 40, 0, 100, 0, 36, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (8284, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 12, 5856, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -6753.4, -1790.25, 256.80, 2.81, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (8284, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 5856, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -6760.36, -1812.86, 256.69, 1.57, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (8284, 0, 7, 8, 40, 0, 100, 0, 61, 0, 0, 0, 12, 8338, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -6370.26, -1974.93, 256.79, 3.55, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (8284, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 8338, 50, 0, 0, 0, 0, 0, 'On WP Reach - Set Data');
INSERT INTO smart_scripts VALUES (8284, 0, 9, 11, 8, 0, 100, 0, 61512, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Die');
INSERT INTO smart_scripts VALUES (8284, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spawn - Add Bytes1 stand state');
INSERT INTO smart_scripts VALUES (8284, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 8284, 50, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn Target');
UPDATE creature_template SET AIName='SmartAI' WHERE entry=8338;
DELETE FROM smart_scripts WHERE entryorguid=8338 AND source_type=0;
INSERT INTO smart_scripts VALUES (8338, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 11, 61512, 0, 0, 0, 0, 0, 19, 8284, 50, 0, 0, 0, 0, 0, 'On Data Set - Cast At Dorius');
DELETE FROM waypoints WHERE entry=8284;
INSERT INTO waypoints VALUES (8284, 1, -7006.92, -1744, 234.1, 'Dorius Stonetender'),(8284, 2, -7007.75, -1732.05, 234.099, 'Dorius Stonetender'),(8284, 3, -7005.47, -1724.57, 234.099, 'Dorius Stonetender'),(8284, 4, -7001.05, -1727.62, 235.274, 'Dorius Stonetender'),(8284, 5, -6991.56, -1734.18, 239.239, 'Dorius Stonetender'),(8284, 6, -6983.94, -1734.93, 241.622, 'Dorius Stonetender'),(8284, 7, -6976.7, -1724.36, 241.667, 'Dorius Stonetender'),(8284, 8, -6974.22, -1720.38, 243.028, 'Dorius Stonetender'),(8284, 9, -6973.37, -1715.84, 243.68, 'Dorius Stonetender'),(8284, 10, -6971.87, -1711.4, 241.999, 'Dorius Stonetender'),(8284, 11, -6961.39, -1700.4, 240.744, 'Dorius Stonetender'),(8284, 12, -6956.36, -1695.64, 241.267, 'Dorius Stonetender'),(8284, 13, -6952.62, -1692.92, 242.201, 'Dorius Stonetender'),(8284, 14, -6941.59, -1686.27, 243.609, 'Dorius Stonetender'),(8284, 15, -6931.58, -1680.24, 241.976, 'Dorius Stonetender'),(8284, 16, -6925.64, -1676.66, 241.205, 'Dorius Stonetender'),(8284, 17, -6916.67, -1671.26, 243.154, 'Dorius Stonetender'),
(8284, 18, -6906.39, -1669.08, 243.1, 'Dorius Stonetender'),(8284, 19, -6895.02, -1666.73, 244.364, 'Dorius Stonetender'),(8284, 20, -6888.45, -1671.61, 243.537, 'Dorius Stonetender'),(8284, 21, -6883.87, -1675.19, 243.67, 'Dorius Stonetender'),(8284, 22, -6878.07, -1679.1, 245.459, 'Dorius Stonetender'),(8284, 23, -6866.53, -1680.46, 251.159, 'Dorius Stonetender'),(8284, 24, -6847.84, -1680.24, 251.522, 'Dorius Stonetender'),(8284, 25, -6837.27, -1680.11, 251.522, 'Dorius Stonetender'),(8284, 26, -6824.46, -1679.9, 251.531, 'Dorius Stonetender'),(8284, 27, -6809.48, -1682.39, 250.33, 'Dorius Stonetender'),(8284, 28, -6807.54, -1685.24, 251.937, 'Dorius Stonetender'),(8284, 29, -6799.99, -1697.03, 259.171, 'Dorius Stonetender'),(8284, 30, -6791.55, -1705.01, 259.55, 'Dorius Stonetender'),(8284, 31, -6783.92, -1712.23, 259.55, 'Dorius Stonetender'),(8284, 32, -6779.7, -1724.39, 259.55, 'Dorius Stonetender'),(8284, 33, -6779.37, -1740.73, 259.574, 'Dorius Stonetender'),(8284, 34, -6778.38, -1749.98, 259.551, 'Dorius Stonetender'),
(8284, 35, -6776.43, -1761.44, 257.466, 'Dorius Stonetender'),(8284, 36, -6772.3, -1785.59, 256.858, 'Dorius Stonetender'),(8284, 37, -6761.17, -1794.08, 256.763, 'Dorius Stonetender'),(8284, 38, -6748.43, -1802.23, 255.501, 'Dorius Stonetender'),(8284, 39, -6731.69, -1812.94, 253.554, 'Dorius Stonetender'),(8284, 40, -6717.92, -1815.5, 252.284, 'Dorius Stonetender'),(8284, 41, -6700.58, -1817.83, 250.448, 'Dorius Stonetender'),(8284, 42, -6685.6, -1820.35, 249.568, 'Dorius Stonetender'),(8284, 43, -6675.33, -1831.45, 248.962, 'Dorius Stonetender'),(8284, 44, -6661.43, -1848.66, 246.148, 'Dorius Stonetender'),(8284, 45, -6654.52, -1859.53, 245.18, 'Dorius Stonetender'),(8284, 46, -6641.54, -1877.53, 244.144, 'Dorius Stonetender'),(8284, 47, -6628.57, -1895.53, 244.15, 'Dorius Stonetender'),(8284, 48, -6616.58, -1909.78, 244.72, 'Dorius Stonetender'),(8284, 49, -6603.96, -1915.83, 244.205, 'Dorius Stonetender'),(8284, 50, -6592.88, -1919.32, 244.152, 'Dorius Stonetender'),(8284, 51, -6572.35, -1923.48, 244.152, 'Dorius Stonetender'),(8284, 52, -6551.56, -1931.24, 244.151, 'Dorius Stonetender'),
(8284, 53, -6528.76, -1943.08, 244.151, 'Dorius Stonetender'),(8284, 54, -6509.06, -1953.3, 244.151, 'Dorius Stonetender'),(8284, 55, -6484.21, -1966.2, 244.151, 'Dorius Stonetender'),(8284, 56, -6461.49, -1975.08, 244.267, 'Dorius Stonetender'),(8284, 57, -6444.5, -1979.29, 244.423, 'Dorius Stonetender'),(8284, 58, -6432.82, -1979.66, 245.315, 'Dorius Stonetender'),(8284, 59, -6414.18, -1981.05, 247.111, 'Dorius Stonetender'),(8284, 60, -6401.38, -1981.34, 247.193, 'Dorius Stonetender'),(8284, 61, -6388.25, -1984.19, 246.733, 'Dorius Stonetender');

-- The Ancient Leaf (7632), Vartrus the Ancient - Allow to switch between bow and staff
UPDATE creature_template SET npcflag = npcflag|1, gossip_menu_id=30201, AIName="SmartAI" WHERE entry=14524;
DELETE FROM gossip_menu_option WHERE menu_id=30201;
INSERT INTO gossip_menu_option VALUES(30201, 0, 0, "Can you transform the Rhok'delar?", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(30201, 1, 0, "Can you transform the Lok'delar?", 1, 1, 0, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid=14524 AND source_type=0;
INSERT INTO smart_scripts VALUES (14524, 0, 0, 1, 62, 0, 100, 0, 30201, 0, 0, 0, 56, 18715, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Add Item");
INSERT INTO smart_scripts VALUES (14524, 0, 1, 4, 61, 0, 100, 0, 0, 0, 0, 0, 57, 18713, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Remove Item");
INSERT INTO smart_scripts VALUES (14524, 0, 2, 3, 62, 0, 100, 0, 30201, 1, 0, 0, 56, 18713, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Invoker Cast");
INSERT INTO smart_scripts VALUES (14524, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 57, 18715, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
INSERT INTO smart_scripts VALUES (14524, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On Gossip Select - Close Gossip");
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=30201;
INSERT INTO conditions VALUES (15, 30201, 0, 0, 0, 2, 0, 18713, 1, 0, 0, 0, 0, '', 'Must have item 18713'); -- Require Bow
INSERT INTO conditions VALUES (15, 30201, 1, 0, 0, 2, 0, 18715, 1, 0, 0, 0, 0, '', 'Must have item 18715'); -- Require Staff

-- Protecting the Shipment (309)
UPDATE quest_template SET SpecialFlags=2 WHERE Id=309;
UPDATE creature_template SET speed_walk=1, speed_run=1, AIName='SmartAI', ScriptName='' WHERE entry=1379;
DELETE FROM smart_scripts WHERE entryorguid=1379 AND source_type=0;
INSERT INTO smart_scripts VALUES (1379, 0, 0, 0, 19, 0, 100, 0, 309, 0, 0, 0, 53, 1, 1379, 0, 309, 10000, 1, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - WP Start');
INSERT INTO smart_scripts VALUES (1379, 0, 1, 2, 40, 0, 100, 0, 12, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - WP Pause');
INSERT INTO smart_scripts VALUES (1379, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 12, 2149, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -5683.13, -3618.7, 312.98, 1.3, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (1379, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 12, 2149, 4, 30000, 0, 1, 0, 8, 0, 0, 0, -5661.2, -3609.89, 312.5, 2.65, 'On WP Reach - Summon Creature');
INSERT INTO smart_scripts VALUES (1379, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 19, 2149, 40, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (1379, 0, 5, 0, 40, 0, 100, 0, 24, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reach - Talk');
INSERT INTO smart_scripts VALUES (1379, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Aggro - Talk');
INSERT INTO smart_scripts VALUES (1379, 0, 7, 0, 52, 0, 100, 0, 0, 2149, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Talk');
DELETE FROM waypoints WHERE entry=1379;
INSERT INTO waypoints VALUES (1379, 1, -5759.31, -3437.9, 305.068, 'Miran'),(1379, 2, -5754.53, -3447.25, 303.322, 'Miran'),(1379, 3, -5747.61, -3460.78, 301.841, 'Miran'),(1379, 4, -5739.16, -3477.3, 301.651, 'Miran'),(1379, 5, -5730.17, -3494.88, 301.962, 'Miran'),(1379, 6, -5723.29, -3508.34, 304.204, 'Miran'),(1379, 7, -5718.41, -3517.89, 302.778, 'Miran'),(1379, 8, -5711.49, -3531.41, 304.855, 'Miran'),(1379, 9, -5703.01, -3547.99, 305.502, 'Miran'),(1379, 10, -5696.12, -3561.47, 307.576, 'Miran'),(1379, 11, -5690.29, -3572.88, 309.155, 'Miran'),(1379, 12, -5676.49, -3599.86, 312.34, 'Miran'),
(1379, 13, -5674.37, -3625.38, 311.243, 'Miran'),(1379, 14, -5675.87, -3633.44, 311.676, 'Miran'),(1379, 15, -5678.63, -3648.37, 315.188, 'Miran'),(1379, 16, -5680.54, -3658.7, 312.664, 'Miran'),(1379, 17, -5682.03, -3666.75, 314.376, 'Miran'),(1379, 18, -5684.37, -3679.35, 314.575, 'Miran'),(1379, 19, -5687.97, -3698.82, 317.591, 'Miran'),(1379, 20, -5689.9, -3709.22, 316.164, 'Miran'),(1379, 21, -5692.24, -3721.88, 316.468, 'Miran'),(1379, 22, -5694.58, -3734.49, 318.374, 'Miran'),(1379, 23, -5698.61, -3756.24, 322.457, 'Miran'),(1379, 24, -5700.1, -3764.29, 323.779, 'Miran');
DELETE FROM creature_text WHERE entry IN(1379, 2149);
INSERT INTO creature_text VALUES (2149, 0, 0, "Feel the power of the Dark Iron Dwarves!", 12, 0, 100, 0, 0, 0, 0, 'Dark Iron Raider');
INSERT INTO creature_text VALUES (1379, 0, 0, "Help! I've only one hand to defend myself with.", 12, 0, 100, 0, 0, 0, 0, 'Miran');
INSERT INTO creature_text VALUES (1379, 1, 0, "Send them on! I'm not afraid of some scrawny beasts!", 12, 0, 100, 0, 0, 0, 0, 'Miran');
INSERT INTO creature_text VALUES (1379, 2, 0, "Ah, here at last! It's going to feel so good to get rid of these barrels.", 12, 0, 100, 0, 0, 0, 0, 'Miran');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=2149;
DELETE FROM smart_scripts WHERE entryorguid=2149 AND source_type=0;
INSERT INTO smart_scripts VALUES (2149, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 1379, 30, 0, 0, 0, 0, 0, 'On Respawn - Attack Start');

-- Tree's Company (9531)
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=17318);
DELETE FROM creature WHERE id=17318;

-- Seal of Ascension (4743)
UPDATE creature_template SET spell1=0, spell2=0, spell3=0, spell4=16054, spell5=9573, spell6=8269, spell7=40504, spell8=0 WHERE entry=10321;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=16054;
INSERT INTO conditions VALUES (13, 6, 16054, 0, 0, 31, 0, 5, 175321, 0, 0, 0, 0, '', 'Target Gameobject 175321');
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=175321;
DELETE FROM smart_scripts WHERE entryorguid=175321 AND source_type=1;
INSERT INTO smart_scripts VALUES (175321, 1, 0, 0, 8, 0, 100, 0, 16054, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Despawn');

-- The Journey Has Just Begun (7493)
-- The Journey Has Just Begun (7497)
UPDATE quest_template SET PrevQuestId=24429, OfferRewardText="A dragon slayer and a seasoned leatherworker? You do not cease to astonish, hero. I am humbled.$B$BPlease accept what I am about to teach you. This knowledge will prove to be invaluable if you are to destroy what remains of the Black Dragonflight.$B$BCreate the cloak from the scales of the brood mother. It will protect you and your allies against the incendiary breath of the Lord of Blackrock... Nefarian." WHERE Id=7493;
UPDATE quest_template SET PrevQuestId=24428, OfferRewardText="A dragon slayer and a seasoned leatherworker? You do not cease to astonish, hero. I am humbled.$B$BPlease accept what I am about to teach you. This knowledge will prove to be invaluable if you are to destroy what remains of the Black Dragonflight.$B$BCreate the cloak from the scales of the brood mother. It will protect you and your allies against the incendiary breath of the Lord of Blackrock... Nefarian." WHERE Id=7497;

-- Attunement to the Core (7487)
-- Attunement to the Core (7848)
DELETE FROM smart_scripts WHERE entryorguid=14387 AND source_type=0;
INSERT INTO smart_scripts VALUES (14387, 0, 0, 1, 62, 0, 100, 0, 5750, 0, 0, 0, 85, 25139, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Lothos Riftwaker - On Gossip Option 0 Selected - Invoker Cast 'Teleport to Molten Core DND'");
INSERT INTO smart_scripts VALUES (14387, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Lothos Riftwaker - On Gossip Option 0 Selected - Close Gossip");

-- The Absent Minded Prospector (943)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=2911;
DELETE FROM smart_scripts WHERE entryorguid=2911 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=2911*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (2911, 0, 0, 0, 20, 0, 100, 0, 943, 0, 0, 0, 80, 2911*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Quest 'The Absent Minded Prospector' Finished - Run Script");
INSERT INTO smart_scripts VALUES (2911*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Set Npc Flag");
INSERT INTO smart_scripts VALUES (2911*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 3582, 3, 28000, 0, 0, 0, 8, 0, 0, 0, -3808.2, -838.99, 16.94, 3.12, "Archaeologist Flagongut - On Script - Summon Creature");
INSERT INTO smart_scripts VALUES (2911*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Set Orientation");
INSERT INTO smart_scripts VALUES (2911*100, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 0");
INSERT INTO smart_scripts VALUES (2911*100, 9, 4, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 0");
INSERT INTO smart_scripts VALUES (2911*100, 9, 5, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 1");
INSERT INTO smart_scripts VALUES (2911*100, 9, 6, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 2");
INSERT INTO smart_scripts VALUES (2911*100, 9, 7, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 3");
INSERT INTO smart_scripts VALUES (2911*100, 9, 8, 0, 0, 0, 100, 0, 7500, 7500, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 4");
INSERT INTO smart_scripts VALUES (2911*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 3582, 20, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 5");
INSERT INTO smart_scripts VALUES (2911*100, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Talk 1");
INSERT INTO smart_scripts VALUES (2911*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Set Npc Flag");
INSERT INTO smart_scripts VALUES (2911*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Flagongut - On Script - Set Orientation");
DELETE FROM creature_text WHERE entry IN(2911, 3582);
INSERT INTO creature_text VALUES (2911, 0, 0, "By the stars! A spirit has been summoned!", 12, 0, 100, 0, 0, 0, 0, 'Archaeologist Flagongut');
INSERT INTO creature_text VALUES (2911, 1, 0, "It's a mystery of the past indeed! But a key to our future!", 12, 0, 100, 0, 0, 0, 0, 'Archaeologist Flagongut');
INSERT INTO creature_text VALUES (3582, 0, 0, "Who hath summoned forth Aman?", 12, 0, 100, 0, 0, 0, 0, 'Aman');
INSERT INTO creature_text VALUES (3582, 1, 0, "Ah, I see you toil with relics of the past.", 12, 0, 100, 0, 0, 0, 0, 'Aman');
INSERT INTO creature_text VALUES (3582, 2, 0, "Be warned that even your creators are fallible.", 12, 0, 100, 0, 0, 0, 0, 'Aman');
INSERT INTO creature_text VALUES (3582, 3, 0, "Digging too deep into your past might bring an abrupt end to your future.", 12, 0, 100, 0, 0, 0, 0, 'Aman');
INSERT INTO creature_text VALUES (3582, 4, 0, "Aman dissipates before your eyes.", 16, 0, 100, 0, 0, 0, 0, 'Aman');

-- The Heart of the Mountain (4123)
UPDATE creature_template SET faction=14 WHERE entry IN(9437, 9438, 9439, 9441, 9442, 9443);
UPDATE gameobject_template SET AIName='SmartGameObjectAI' WHERE entry=174565;
DELETE FROM smart_scripts WHERE entryorguid=174565 AND source_type=1;
INSERT INTO smart_scripts VALUES (174565, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 106, 16, 0, 0, 0, 0, 0, 20, 160845, 10, 0, 0, 0, 0, 0, 'On Gossip Hello - Remove GO Flag');
UPDATE gameobject_template SET flags=0 WHERE entry IN(164820, 164821, 164822, 164823, 164824, 164825);
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=164819; -- Only this version is spawned
DELETE FROM smart_scripts WHERE entryorguid=164819 AND source_type=1;
DELETE FROM smart_scripts WHERE entryorguid IN(164819*100, 164819*100+1, 164819*100+2, 164819*100+3, 164819*100+4, 164819*100+5) AND source_type=9;
INSERT INTO smart_scripts VALUES (164819, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 88, 164819*100, 164819*100+5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Hello - Run Random Range Script');
INSERT INTO smart_scripts VALUES (164819*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164820, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9437, 8, 0, 0, 0, 0, 8, 0, 0, 0, 850.49, -176.63, -49.74, 2.08, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 845.36, -179.65, -49.74, 2.08, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 847.44, -178.48, -49.74, 2.08, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164821, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9438, 8, 0, 0, 0, 0, 8, 0, 0, 0, 837.52, -325.66, -50.65, 3.92, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 834.52, -325.66, -50.65, 3.92, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 840.52, -325.66, -50.65, 3.92, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 837.52, -328.66, -50.65, 3.92, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 837.52, -322.66, -50.65, 3.92, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9439, 8, 0, 0, 0, 0, 8, 0, 0, 0, 896.90, -358.72, -49.92, 1.54, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 893.41, -358.65, -49.92, 1.54, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+2, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 900.54, -358.80, -49.95, 1.54, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+3, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164823, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100+3, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9441, 8, 0, 0, 0, 0, 8, 0, 0, 0, 544.44, -214.84, -35.52, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+3, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 545.80, -218.07, -35.55, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+3, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 542.65, -210.58, -35.50, 0.4, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+4, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164824, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100+4, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9442, 8, 0, 0, 0, 0, 8, 0, 0, 0, 667.29, -2.75, -60.04, 1.04, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+4, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 663.29, -0.43, -60.04, 1.04, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+4, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 670.32, -4.50, -60.04, 1.04, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+5, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 50, 164825, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0.06819981, 0.073135, 0.1, 0, 'Script9 - Summon GO');
INSERT INTO smart_scripts VALUES (164819*100+5, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9443, 8, 0, 0, 0, 0, 8, 0, 0, 0, 804.25, -246.49, -43.30, 2.81, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+5, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 803.77, -248.41, -43.30, 2.81, 'Script9 - Summon Creature');
INSERT INTO smart_scripts VALUES (164819*100+5, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 9445, 8, 0, 0, 0, 0, 8, 0, 0, 0, 805.35, -243.77, -43.30, 2.81, 'Script9 - Summon Creature');

-- Precarious Predicament (4121)
UPDATE creature_template SET gossip_menu_id=30200, AIName='SmartAI' WHERE entry=9080;
DELETE FROM gossip_menu_option WHERE menu_id=30200;
INSERT INTO gossip_menu_option VALUES (30200, 0, 0, 'I need another Thorium Shackles.', 1, 1, 0, 0, 0, 0, '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=30200;
INSERT INTO conditions VALUES (15, 30200, 0, 0, 0, 14, 0, 4122, 0, 0, 1, 0, 0, '', 'First Quest Any state');
INSERT INTO conditions VALUES (15, 30200, 0, 0, 0, 2, 0, 11286, 1, 0, 1, 0, 0, '', 'No Item 11286');
INSERT INTO conditions VALUES (15, 30200, 0, 0, 0, 8, 0, 4121, 0, 0, 1, 0, 0, '', 'Second Quest not rewarded');
DELETE FROM smart_scripts WHERE entryorguid=9080 AND source_type=0;
INSERT INTO smart_scripts VALUES (9080, 0, 0, 1, 62, 0, 100, 0, 30200, 0, 0, 0, 56, 11286, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Add Item');
INSERT INTO smart_scripts VALUES (9080, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Gossip Select - Close Gossip');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=14250;
INSERT INTO conditions VALUES (13, 1, 14250, 0, 0, 31, 0, 3, 9520, 0, 0, 0, 0, '', 'Target Grark');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=9520;
DELETE FROM smart_scripts WHERE entryorguid=9520 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(9520*100, 9520*100+1) AND source_type=9;
INSERT INTO smart_scripts VALUES (9520, 0, 0, 1, 19, 0, 100, 0, 4121, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Faction Hostile');
INSERT INTO smart_scripts VALUES (9520, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Attack Start');
INSERT INTO smart_scripts VALUES (9520, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Set Event Phase');
INSERT INTO smart_scripts VALUES (9520, 0, 4, 5, 2, 1, 100, 0, 0, 30, 0, 0, 80, 9520*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP - Run Script');
INSERT INTO smart_scripts VALUES (9520, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On HP - Enter Evade');
INSERT INTO smart_scripts VALUES (9520, 0, 7, 27, 8, 2, 100, 0, 14250, 0, 0, 0, 1, 2, 4000, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 8, 0, 52, 0, 100, 0, 2, 9520, 0, 0, 53, 0, 9520, 0, 4121, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Text Over - Start WP');
INSERT INTO smart_scripts VALUES (9520, 0, 9, 0, 40, 0, 100, 0, 4, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 10, 11, 40, 0, 100, 0, 11, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (9520, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Summon Creature Group');
INSERT INTO smart_scripts VALUES (9520, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 13, 0, 56, 0, 100, 0, 11, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resumed - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 14, 15, 40, 0, 100, 0, 32, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (9520, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Summon Creature Group');
INSERT INTO smart_scripts VALUES (9520, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 17, 0, 56, 0, 100, 0, 32, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resumed - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 18, 19, 40, 0, 100, 0, 59, 0, 0, 0, 54, 40000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - WP Pause');
INSERT INTO smart_scripts VALUES (9520, 0, 19, 20, 61, 0, 100, 0, 0, 0, 0, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Summon Creature Group');
INSERT INTO smart_scripts VALUES (9520, 0, 20, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 21, 0, 56, 0, 100, 0, 59, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Resumed - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 22, 23, 40, 0, 100, 0, 69, 0, 0, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Summon Creature Group');
INSERT INTO smart_scripts VALUES (9520, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Talk');
INSERT INTO smart_scripts VALUES (9520, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 9520*100+1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On WP Reached - Run Script');
INSERT INTO smart_scripts VALUES (9520, 0, 25, 26, 11, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Remove Bytes1');
INSERT INTO smart_scripts VALUES (9520, 0, 26, 0, 61, 0, 100, 0, 0, 0, 0, 0, 94, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Set Dynflag');
INSERT INTO smart_scripts VALUES (9520, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Spell Hit - Set Event Phase');
INSERT INTO smart_scripts VALUES (9520*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (9520*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (9520*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (9520*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (9520*100, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Event Phase');
INSERT INTO smart_scripts VALUES (9520*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Faction');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 9539, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Bytes1');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 9539, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 9538, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 9539, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 37, 0, 0, 0, 0, 0, 19, 9538, 15, 0, 0, 0, 0, 0, 'Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 9539, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 7, 0, 0, 0, 100, 0, 500, 500, 0, 0, 94, 32, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Dynamic Flag');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Remove Bytes1');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Set Bytes1');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 9539, 15, 0, 0, 0, 0, 0, 'Script9 - Talk Target');
INSERT INTO smart_scripts VALUES (9520*100+1, 9, 11, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
DELETE FROM creature_summon_groups WHERE summonerId=9520;
INSERT INTO creature_summon_groups VALUES (9520, 0, 1, 7027, -7728.03, -1507.43, 132.84, 0.45, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 1, 7027, -7745.39, -1511.42, 131.82, 0.43, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 1, 7027, -7738.19, -1517.31, 132.64, 1.25, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 1, 7027, -7731.36, -1516.09, 133.15, 1.85, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 2, 7027, -8018.37, -1234.22, 135.76, 4.45, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 2, 7027, -8028.86, -1234.06, 134.50, 4.80, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 2, 7043, -8035.70, -1244.65, 133.53, 6.09, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 2, 7043, -8017.37, -1244.61, 134.45, 3.05, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 3, 7042, -7394.30, -1099.77, 278.08, 3.23, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 3, 7042, -7394.24, -1106.84, 278.08, 3.04, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 3, 7042, -7399.23, -1111.12, 278.08, 2.07, 4, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 4, 9539, -7184.77, -1078.76, 240.76, 2.87, 3, 30000);
INSERT INTO creature_summon_groups VALUES (9520, 0, 4, 9538, -7189.04, -1082.20, 240.76, 2.24, 3, 30000);
DELETE FROM waypoints WHERE entry=9520;
INSERT INTO waypoints VALUES (9520, 1, -7694.87, -1446.16, 139.788, 'Grark Lorkrub'),(9520, 2, -7693.1, -1447.1, 140.936, 'Grark Lorkrub'),(9520, 3, -7670.1, -1458.41, 140.742, 'Grark Lorkrub'),(9520, 4, -7675.08, -1464.91, 140.743, 'Grark Lorkrub'),(9520, 5, -7682.24, -1470.96, 140.732, 'Grark Lorkrub'),(9520, 6, -7695.94, -1473.56, 140.794, 'Grark Lorkrub'),(9520, 7, -7708.68, -1472.19, 140.795, 'Grark Lorkrub'),(9520, 8, -7711.3, -1470.41, 140.792, 'Grark Lorkrub'),(9520, 9, -7718.34, -1483.8, 140.127, 'Grark Lorkrub'),(9520, 10, -7726.4, -1499.25, 133.572, 'Grark Lorkrub'),(9520, 11, -7738.77, -1502.96, 131.835, 'Grark Lorkrub'),(9520, 12, -7752.84, -1497.24, 133.278, 'Grark Lorkrub'),(9520, 13, -7768.01, -1491.07, 133.465, 'Grark Lorkrub'),(9520, 14, -7788.9, -1488.91, 133.549, 'Grark Lorkrub'),(9520, 15, -7819.76, -1484.64, 133.606, 'Grark Lorkrub'),(9520, 16, -7828.02, -1480.21, 137.011, 'Grark Lorkrub'),
(9520, 17, -7839.92, -1470.88, 137.256, 'Grark Lorkrub'),(9520, 18, -7849.8, -1470.22, 141.082, 'Grark Lorkrub'),(9520, 19, -7855.2, -1476.25, 143.78, 'Grark Lorkrub'),(9520, 20, -7868.73, -1461.69, 144.758, 'Grark Lorkrub'),(9520, 21, -7888.35, -1431.28, 145.097, 'Grark Lorkrub'),(9520, 22, -7900.4, -1426.93, 150.278, 'Grark Lorkrub'),(9520, 23, -7907.22, -1425.34, 148.423, 'Grark Lorkrub'),(9520, 24, -7922.01, -1421.89, 139.826, 'Grark Lorkrub'),(9520, 25, -7939.55, -1410.33, 134.285, 'Grark Lorkrub'),(9520, 26, -7953.69, -1383.53, 133.842, 'Grark Lorkrub'),(9520, 27, -7970.54, -1358.25, 132.992, 'Grark Lorkrub'),(9520, 28, -7994.28, -1337.43, 133.873, 'Grark Lorkrub'),(9520, 29, -8003.57, -1325.42, 133.722, 'Grark Lorkrub'),(9520, 30, -8006.93, -1297.62, 132.471, 'Grark Lorkrub'),(9520, 31, -8010.01, -1272.19, 133.315, 'Grark Lorkrub'),(9520, 32, -8022.81, -1248.63, 133.66, 'Grark Lorkrub'),
(9520, 33, -8024.27, -1233.51, 135.164, 'Grark Lorkrub'),(9520, 34, -8016.06, -1199.49, 145.809, 'Grark Lorkrub'),(9520, 35, -7998.59, -1162.87, 156.517, 'Grark Lorkrub'),(9520, 36, -7971.62, -1137.03, 169.253, 'Grark Lorkrub'),(9520, 37, -7947.76, -1131.43, 179.178, 'Grark Lorkrub'),(9520, 38, -7916.3, -1132.39, 189.363, 'Grark Lorkrub'),(9520, 39, -7882.57, -1132.1, 198.428, 'Grark Lorkrub'),(9520, 40, -7846.45, -1132.55, 207.448, 'Grark Lorkrub'),(9520, 41, -7817.44, -1129.96, 213.355, 'Grark Lorkrub'),(9520, 42, -7807.09, -1128.75, 214.848, 'Grark Lorkrub'),(9520, 43, -7751.64, -1121.82, 215.085, 'Grark Lorkrub'),(9520, 44, -7743.69, -1097.45, 216.133, 'Grark Lorkrub'),(9520, 45, -7731.51, -1088.48, 217.094, 'Grark Lorkrub'),(9520, 46, -7696.8, -1084.28, 217.778, 'Grark Lorkrub'),(9520, 47, -7677.24, -1058.08, 220.442, 'Grark Lorkrub'),(9520, 48, -7651.64, -1034.11, 228.715, 'Grark Lorkrub'),
(9520, 49, -7620.58, -1020.57, 237.609, 'Grark Lorkrub'),(9520, 50, -7593.13, -1015.04, 244.696, 'Grark Lorkrub'),(9520, 51, -7564.18, -1017.93, 251.451, 'Grark Lorkrub'),(9520, 52, -7541.23, -1031.78, 256.662, 'Grark Lorkrub'),(9520, 53, -7513.8, -1051.44, 262.202, 'Grark Lorkrub'),(9520, 54, -7496.54, -1073.58, 264.806, 'Grark Lorkrub'),(9520, 55, -7476.06, -1068.61, 264.993, 'Grark Lorkrub'),(9520, 56, -7451.15, -1062.45, 268.264, 'Grark Lorkrub'),(9520, 57, -7431.29, -1061.54, 272.873, 'Grark Lorkrub'),(9520, 58, -7415.51, -1073.52, 276.363, 'Grark Lorkrub'),(9520, 59, -7408.22, -1101.78, 278.077, 'Grark Lorkrub'),(9520, 60, -7383.85, -1099.22, 278.076, 'Grark Lorkrub'),(9520, 61, -7359.44, -1101.27, 277.84, 'Grark Lorkrub'),(9520, 62, -7335.16, -1089.9, 277.07, 'Grark Lorkrub'),(9520, 63, -7310.58, -1070.2, 277.07, 'Grark Lorkrub'),
(9520, 64, -7296.4, -1064.74, 277.027, 'Grark Lorkrub'),(9520, 65, -7274.71, -1073.46, 269.059, 'Grark Lorkrub'),(9520, 66, -7263.12, -1072.97, 265.053, 'Grark Lorkrub'),(9520, 67, -7239.82, -1072.43, 251.404, 'Grark Lorkrub'),(9520, 68, -7214.73, -1071.87, 243.273, 'Grark Lorkrub'),(9520, 69, -7190.93, -1078.66, 240.987, 'Grark Lorkrub');
DELETE FROM creature_text WHERE entry IN(9520, 9539, 9538);
INSERT INTO creature_text VALUES (9520, 0, 0, "You have come to play? Then let us play!", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 1, 0, "Grark Lorkrub submits.", 16, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 2, 0, "I know the way, insect. There is no need to prod me as if I were cattle.", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 3, 0, "Surely you do not think that you will get away with this incursion. They will come for me and you shall pay for your insolence.", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 4, 0, "RUN THEM THROUGH BROTHERS!", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 5, 0, "I doubt you will be so lucky the next time you encounter my brethren.", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 6, 0, "They come for you, fool!", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 7, 0, "What do you think you accomplish from this, fool? Even now, the Blackrock armies make preparations to destroy your world.", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 8, 0, "On darkest wing they fly. Prepare to meet your end!", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 9, 0, "The worst is yet to come!", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9520, 10, 0, "Time to make your final stand, insect.", 12, 0, 100, 0, 0, 0, 0, 'Grark Lorkrub');
INSERT INTO creature_text VALUES (9539, 0, 0, "Kneel, Grark.", 12, 0, 100, 0, 0, 0, 0, 'Shadow of Lexlort');
INSERT INTO creature_text VALUES (9539, 1, 0, "Grark Lorkrub, you have been charged and found guilty of treason against the Horde. How you plead is unimportant. High Executioner Nuzrak, step forward.", 12, 0, 100, 0, 0, 0, 0, 'Shadow of Lexlort');
INSERT INTO creature_text VALUES (9539, 2, 0, "Shadow of Lexlort raises his hand and then lowers it.", 16, 0, 100, 0, 0, 0, 0, 'Shadow of Lexlort');
INSERT INTO creature_text VALUES (9539, 3, 0, "End him...", 12, 0, 100, 0, 0, 0, 0, 'Shadow of Lexlort');
INSERT INTO creature_text VALUES (9539, 4, 0, "You, soldier, report back to Kargath at once!", 12, 0, 100, 0, 0, 0, 0, 'Shadow of Lexlort');
INSERT INTO creature_text VALUES (9538, 0, 0, "High Executioner Nuzrak raises his massive axe over Grark.", 16, 0, 100, 0, 0, 0, 0, 'High Executioner Nuzrak');

-- Root Samples (866)
UPDATE gameobject_template SET questItem1=5056 WHERE entry IN(1622, 3730, 1619, 3726, 1620, 3727, 1618, 3724, 1617, 3725);
DELETE FROM gameobject_loot_template WHERE item=5056;
INSERT INTO gameobject_loot_template VALUES (1419, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (2516, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (1416, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (2513, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (1417, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (2514, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (1415, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (2512, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (1414, 5056, -100, 1, 0, 1, 1);
INSERT INTO gameobject_loot_template VALUES (2511, 5056, -100, 1, 0, 1, 1);

-- Test of Endurance (1150)
DELETE FROM event_scripts WHERE id=747;
INSERT INTO event_scripts VALUES (747, 5, 10, 4490, 900000, 1, -5589.63, -1575.89, 11.75, 6.02);

-- Path of the Conqueror
-- Path of the Protector
-- Path of the Invoker
UPDATE quest_template SET ExclusiveGroup=8747 WHERE Id IN(8747, 8752, 8757);
UPDATE quest_template SET PrevQuestId=0, SpecialFlags=1 WHERE Id IN(8764, 8765, 8766);
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(8764, 8765, 8766);
INSERT INTO conditions VALUES(19, 0, 8764, 0, 0, 2, 0, 21200, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
INSERT INTO conditions VALUES(19, 0, 8765, 0, 0, 2, 0, 21210, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
INSERT INTO conditions VALUES(19, 0, 8766, 0, 0, 2, 0, 21205, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
INSERT INTO conditions VALUES(20, 0, 8764, 0, 0, 2, 0, 21200, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
INSERT INTO conditions VALUES(20, 0, 8765, 0, 0, 2, 0, 21210, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
INSERT INTO conditions VALUES(20, 0, 8766, 0, 0, 2, 0, 21205, 1, 0, 0, 0, 0, '', 'Requires Specific Ring to see quest');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=6539;
INSERT INTO conditions VALUES(15, 6539, 1, 0, 0, 14, 0, 8753, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 1, 0, 0, 8, 0, 8752, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 1, 0, 0, 2, 0, 21201, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 2, 0, 0, 14, 0, 8754, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 2, 0, 0, 8, 0, 8753, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 2, 0, 0, 2, 0, 21202, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 3, 0, 0, 14, 0, 8755, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 3, 0, 0, 8, 0, 8754, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 3, 0, 0, 2, 0, 21203, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 4, 0, 0, 14, 0, 8756, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 4, 0, 0, 8, 0, 8755, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 4, 0, 0, 2, 0, 21204, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 13, 0, 0, 8, 0, 8756, 0, 0, 0, 0, 0, '', 'Requires Path of the Conqueror quest');
INSERT INTO conditions VALUES(15, 6539, 13, 0, 0, 2, 0, 21205, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 5, 0, 0, 14, 0, 8758, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 5, 0, 0, 8, 0, 8757, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 5, 0, 0, 2, 0, 21206, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 6, 0, 0, 14, 0, 8759, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 6, 0, 0, 8, 0, 8758, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 6, 0, 0, 2, 0, 21207, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 7, 0, 0, 14, 0, 8760, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 7, 0, 0, 8, 0, 8759, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 7, 0, 0, 2, 0, 21208, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 8, 0, 0, 14, 0, 8761, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 8, 0, 0, 8, 0, 8760, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 8, 0, 0, 2, 0, 21209, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 14, 0, 0, 8, 0, 8761, 0, 0, 0, 0, 0, '', 'Requires Path of the Invoker quest');
INSERT INTO conditions VALUES(15, 6539, 14, 0, 0, 2, 0, 21210, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 9, 0, 0, 14, 0, 8748, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 9, 0, 0, 8, 0, 8747, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 9, 0, 0, 2, 0, 21196, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 10, 0, 0, 14, 0, 8749, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 10, 0, 0, 8, 0, 8748, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 10, 0, 0, 2, 0, 21197, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 11, 0, 0, 14, 0, 8750, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 11, 0, 0, 8, 0, 8749, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 11, 0, 0, 2, 0, 21198, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 12, 0, 0, 14, 0, 8751, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 12, 0, 0, 8, 0, 8750, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 12, 0, 0, 2, 0, 21199, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 15, 0, 0, 8, 0, 8751, 0, 0, 0, 0, 0, '', 'Requires Path of the Protector quest');
INSERT INTO conditions VALUES(15, 6539, 15, 0, 0, 2, 0, 21200, 1, 1, 1, 0, 0, '', 'Requires No Appropriate Item');
INSERT INTO conditions VALUES(15, 6539, 16, 0, 0, 8, 0, 8742, 0, 0, 0, 0, 0, '', 'Requires The Might of the Kalimdor rewarded');
DELETE FROM creature_text WHERE entry=15192;
INSERT INTO creature_text VALUES (15192, 0, 0, 'A terrible and costly mistake you have made. It is not my time, mortals.', 12, 0, 100, 0, 0, 0, 0, 'Anachronos');
UPDATE creature_template SET gossip_menu_id=6539, AIName="SmartAI" WHERE entry=15192;
DELETE FROM gossip_menu_option WHERE menu_id=6539;
INSERT INTO gossip_menu_option VALUES(6539, 1, 0, "I've lost my Signet for Path of the Conqueror.", 1, 1, 0, 0, 0, 0, ""); -- return 21201, quest 8753
INSERT INTO gossip_menu_option VALUES(6539, 2, 0, "I've lost my Signet for Path of the Conqueror.", 1, 1, 0, 0, 0, 0, ""); -- return 21202, quest 8754
INSERT INTO gossip_menu_option VALUES(6539, 3, 0, "I've lost my Signet for Path of the Conqueror.", 1, 1, 0, 0, 0, 0, ""); -- return 21203, quest 8755
INSERT INTO gossip_menu_option VALUES(6539, 4, 0, "I've lost my Signet for Path of the Conqueror.", 1, 1, 0, 0, 0, 0, ""); -- return 21204, quest 8756
INSERT INTO gossip_menu_option VALUES(6539, 5, 0, "I've lost my Signet for Path of the Invoker.", 1, 1, 0, 0, 0, 0, ""); -- return 21206, quest 8758
INSERT INTO gossip_menu_option VALUES(6539, 6, 0, "I've lost my Signet for Path of the Invoker.", 1, 1, 0, 0, 0, 0, ""); -- return 21207, quest 8759
INSERT INTO gossip_menu_option VALUES(6539, 7, 0, "I've lost my Signet for Path of the Invoker.", 1, 1, 0, 0, 0, 0, ""); -- return 21208, quest 8760
INSERT INTO gossip_menu_option VALUES(6539, 8, 0, "I've lost my Signet for Path of the Invoker.", 1, 1, 0, 0, 0, 0, ""); -- return 21209, quest 8761
INSERT INTO gossip_menu_option VALUES(6539, 9, 0, "I've lost my Signet for Path of the Protector.", 1, 1, 0, 0, 0, 0, ""); -- return 21196, quest 8748
INSERT INTO gossip_menu_option VALUES(6539, 10, 0, "I've lost my Signet for Path of the Protector.", 1, 1, 0, 0, 0, 0, ""); -- return 21197, quest 8749
INSERT INTO gossip_menu_option VALUES(6539, 11, 0, "I've lost my Signet for Path of the Protector.", 1, 1, 0, 0, 0, 0, ""); -- return 21198, quest 8750
INSERT INTO gossip_menu_option VALUES(6539, 12, 0, "I've lost my Signet for Path of the Protector.", 1, 1, 0, 0, 0, 0, ""); -- return 21199, quest 8751
INSERT INTO gossip_menu_option VALUES(6539, 13, 0, "I've lost my Signet for Path of the Conqueror.", 1, 1, 0, 0, 0, 0, ""); -- return 21205, quest 8766
INSERT INTO gossip_menu_option VALUES(6539, 14, 0, "I've lost my Signet for Path of the Invoker.", 1, 1, 0, 0, 0, 0, ""); -- return 21210, quest 8765
INSERT INTO gossip_menu_option VALUES(6539, 15, 0, "I've lost my Signet for Path of the Protector.", 1, 1, 0, 0, 0, 0, ""); -- return 21200, quest 8764
INSERT INTO gossip_menu_option VALUES(6539, 16, 0, "I am ready, Anachronos. Please grant me the Scepter of the Shifting Sands.", 1, 1, 0, 0, 0, 0, ""); -- add 21175, quest 8742
DELETE FROM smart_scripts WHERE entryorguid=15192 AND source_type=0;
INSERT INTO smart_scripts VALUES (15192, 0, 0, 15, 62, 0, 100, 0, 6539, 1, 0, 0, 56, 21201, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 1, 15, 62, 0, 100, 0, 6539, 2, 0, 0, 56, 21202, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 2, 15, 62, 0, 100, 0, 6539, 3, 0, 0, 56, 21203, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 3, 15, 62, 0, 100, 0, 6539, 4, 0, 0, 56, 21204, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 4, 15, 62, 0, 100, 0, 6539, 5, 0, 0, 56, 21206, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 5, 15, 62, 0, 100, 0, 6539, 6, 0, 0, 56, 21207, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 6, 15, 62, 0, 100, 0, 6539, 7, 0, 0, 56, 21208, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 7, 15, 62, 0, 100, 0, 6539, 8, 0, 0, 56, 21209, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 8, 15, 62, 0, 100, 0, 6539, 9, 0, 0, 56, 21196, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 9, 15, 62, 0, 100, 0, 6539, 10, 0, 0, 56, 21197, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 10, 15, 62, 0, 100, 0, 6539, 11, 0, 0, 56, 21198, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 11, 15, 62, 0, 100, 0, 6539, 12, 0, 0, 56, 21199, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 12, 15, 62, 0, 100, 0, 6539, 13, 0, 0, 56, 21205, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 13, 15, 62, 0, 100, 0, 6539, 14, 0, 0, 56, 21210, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 14, 15, 62, 0, 100, 0, 6539, 15, 0, 0, 56, 21200, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (15192, 0, 16, 15, 62, 0, 100, 0, 6539, 16, 0, 0, 56, 21175, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (15192, 0, 17, 18, 2, 0, 100, 1, 0, 20, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anachronos - Between Health 0-20% - Talk");
INSERT INTO smart_scripts VALUES (15192, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anachronos - Between Health 0-20% - Despawn");

-- Argent Dawn Commission (5503, 5401, 5405)
UPDATE quest_template SET SpecialFlags=0 WHERE Id IN(5503, 5401, 5405);

-- The Glowing Fruit (930), Denalan
DELETE FROM smart_scripts WHERE entryorguid=2080 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(208000, 208001, 208002) AND source_type=9;
INSERT INTO smart_scripts VALUES (2080, 0, 0, 0, 20, 0, 100, 0, 997, 0, 0, 0, 80, 208000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Quest ''Denalan''s Earth'' Finished - Run Script');
INSERT INTO smart_scripts VALUES (2080, 0, 1, 0, 20, 0, 100, 0, 931, 0, 0, 0, 80, 208001, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Quest ''The Shimmering Frond'' Finished - Run Script');
INSERT INTO smart_scripts VALUES (2080, 0, 2, 0, 20, 0, 100, 0, 930, 0, 0, 0, 80, 208002, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Quest ''The Glowing Fruit'' Finished - Run Script');
INSERT INTO smart_scripts VALUES (2080, 0, 3, 0, 37, 0, 100, 0, 930, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On AI Init - Set React Passive');
INSERT INTO smart_scripts VALUES (208000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9507.29, 714.583, 1255.89, 2.5643, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208000, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 0');
INSERT INTO smart_scripts VALUES (208000, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Remove Npc Flag Questgiver');
INSERT INTO smart_scripts VALUES (208000, 9, 3, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Play Emote 16');
INSERT INTO smart_scripts VALUES (208000, 9, 4, 0, 0, 0, 100, 0, 9500, 9500, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Set Orientation Invoker');
INSERT INTO smart_scripts VALUES (208000, 9, 5, 0, 0, 0, 100, 0, 100, 100, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 1');
INSERT INTO smart_scripts VALUES (208000, 9, 6, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9506.87, 713.719, 1255.89, 0.645772, 'Denalan - Script - Move');
INSERT INTO smart_scripts VALUES (208000, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Add Npc Flag Questgiver');
INSERT INTO smart_scripts VALUES (208000, 9, 8, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Enter Evade');
INSERT INTO smart_scripts VALUES (208001, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9508.02, 715.749, 1255.89, 1.03055, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208001, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 2');
INSERT INTO smart_scripts VALUES (208001, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9507.66, 718.009, 1255.89, 1.80417, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208001, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9505.56, 719.088, 1256.2, 2.65632, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208001, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 3');
INSERT INTO smart_scripts VALUES (208001, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Play Emote 16');
INSERT INTO smart_scripts VALUES (208001, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9506.92, 713.766, 1255.89, 0.279253, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208001, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 70, 60, 0, 0, 0, 0, 0, 14, 67984, 7510, 0, 0, 0, 0, 0, 'Denalan - On Script - Respawn Closest Gameobject ''Sprouted Frond''');
INSERT INTO smart_scripts VALUES (208001, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 70, 60, 0, 0, 0, 0, 0, 14, 42936, 7510, 0, 0, 0, 0, 0, 'Denalan - On Script - Respawn Closest Gameobject ''Sprouted Frond''');
INSERT INTO smart_scripts VALUES (208001, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 70, 60, 0, 0, 0, 0, 0, 14, 30276, 7510, 0, 0, 0, 0, 0, 'Denalan - On Script - Respawn Closest Gameobject ''Sprouted Frond''');
INSERT INTO smart_scripts VALUES (208001, 9, 10, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Enter Evade');
INSERT INTO smart_scripts VALUES (208002, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 4');
INSERT INTO smart_scripts VALUES (208002, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 5');
INSERT INTO smart_scripts VALUES (208002, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9508.02, 715.749, 1255.89, 1.03055, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208002, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9507.66, 718.009, 1255.89, 1.80417, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208002, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9505.56, 719.088, 1256.2, 2.65632, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208002, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 6');
INSERT INTO smart_scripts VALUES (208002, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Play Emote 16');
INSERT INTO smart_scripts VALUES (208002, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9506.92, 713.766, 1255.89, 0.279253, 'Denalan - On Script - Move To Position');
INSERT INTO smart_scripts VALUES (208002, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 3569, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 9505.13, 722.011, 1255.94, 0.0244875, 'Denalan - On Script - Summon Creature ''Bogling''');
INSERT INTO smart_scripts VALUES (208002, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Say Line 7');
INSERT INTO smart_scripts VALUES (208002, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 3569, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 9504.09, 720.294, 1255.94, 1.00709, 'Denalan - On Script - Summon Creature ''Bogling''');
INSERT INTO smart_scripts VALUES (208002, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 3569, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 9504.13, 721.459, 1255.94, 6.24727, 'Denalan - On Script - Summon Creature ''Bogling''');
INSERT INTO smart_scripts VALUES (208002, 9, 12, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Denalan - On Script - Enter Evade');

-- Digging Through the Dirt (254), missing condition
DELETE FROM smart_scripts WHERE entryorguid=51708 AND source_type=1;
INSERT INTO smart_scripts VALUES (51708, 1, 0, 0, 20, 0, 100, 0, 254, 0, 0, 0, 12, 314, 1, 300000, 0, 1, 0, 8, 0, 0, 0, -10267, 52.52, 42.54, 2.5, 'Eliza''s Grave Dirt - On Quest ''Digging Through the Dirt'' Finished - Summon Creature ''Eliza');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=51708;
INSERT INTO conditions VALUES(22, 1, 51708, 1, 0, 29, 1, 314, 100, 0, 1, 0, 0, '', 'Run action if no npc nearby');
INSERT INTO conditions VALUES(22, 1, 51708, 1, 0, 29, 1, 314, 100, 1, 1, 0, 0, '', 'Run action if no npc nearby');

-- The Deathstalkers (14418)
-- The Deathstalkers (14419)
-- The Deathstalkers (14420)
-- The Deathstalkers (14421)
UPDATE quest_template SET EmoteOnComplete=1, RequestItemsText="Success to report?", OfferRewardText="Well done, $N. You've passed the first part of this test. Hopefully Andron will not have caught wind of your activities, and we will be able to convince him that you are, in fact, the messenger he is expecting." WHERE Id=14420;
UPDATE quest_template SET EmoteOnComplete=1, RequestItemsText="Hello. Something I can do for you?", OfferRewardText="Ah, yes, I've been expecting you. I have no doubt our mutual acquaintances are pleased with the information that I have provided so far?$B$BI suppose there's no point in asking you, I doubt they would burden you with this knowledge. Why place so much trust in the messenger, hm?" WHERE Id=14419;
UPDATE quest_template SET EmoteOnComplete=1, RequestItemsText="Success, $N?", OfferRewardText="Well, this is certainly more information than I suspected to get out of Andron. Give me a moment to peruse it, before I set you to your next task." WHERE Id=14421;
UPDATE quest_template SET EmoteOnComplete=1, RequestItemsText="Yes?", OfferRewardText="Hmm, this is interesting. The Deathstalkers have performed their duties admirably in ferreting this out.$B$BFrom what I understand, you also deserve commendation for your performance. I hope that this will become routine for you, $N, my Deathstalkers always have use of a good man." WHERE Id=14418;

-- For Love Eternal (963)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=3644;
DELETE FROM smart_scripts WHERE entryorguid=3644 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=3644*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (3644, 0, 0, 1, 20, 0, 100, 0, 963, 0, 0, 0, 12, 3843, 3, 48000, 0, 0, 0, 8, 0, 0, 0, 6426.01, 603.47, 9.47, 4.44, 'Cerellean Whiteclaw - On Reward Quest - Summon Creature');
INSERT INTO smart_scripts VALUES (3644, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 3644*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cerellean Whiteclaw - On Reward Quest - run script');
INSERT INTO smart_scripts VALUES (3644, 0, 2, 0, 1, 0, 100, 0, 15000, 15000, 15000, 15000, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Out Of Combat - Emote Cry");
INSERT INTO smart_scripts VALUES (3644*100, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Set Standstate Stand Up");
INSERT INTO smart_scripts VALUES (3644*100, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Emote Cry");
INSERT INTO smart_scripts VALUES (3644*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Say Line 0");
INSERT INTO smart_scripts VALUES (3644*100, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Say Line 1");
INSERT INTO smart_scripts VALUES (3644*100, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Say Line 2");
INSERT INTO smart_scripts VALUES (3644*100, 9, 5, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Set Standstate Kneel");
INSERT INTO smart_scripts VALUES (3644*100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Say Line 3");
INSERT INTO smart_scripts VALUES (3644*100, 9, 7, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cerellean Whiteclaw - Script - Say Line 4");
UPDATE creature_template SET AIName='SmartAI' WHERE entry=3843;
DELETE FROM smart_scripts WHERE entryorguid=3843 AND source_type=0;
INSERT INTO smart_scripts VALUES (3843, 0, 0, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anaya - Out Of Combat - Say Line 0");
INSERT INTO smart_scripts VALUES (3843, 0, 1, 0, 1, 0, 100, 1, 25000, 25000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anaya - Out Of Combat - Say Line 1");
INSERT INTO smart_scripts VALUES (3843, 0, 2, 0, 1, 0, 100, 1, 30000, 30000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anaya - Out Of Combat - Say Line 2");
INSERT INTO smart_scripts VALUES (3843, 0, 3, 0, 1, 0, 100, 1, 40000, 40000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anaya - Out Of Combat - Say Line 3");
INSERT INTO smart_scripts VALUES (3843, 0, 4, 0, 1, 0, 100, 1, 44000, 44000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anaya - Out Of Combat - Say Line 4");

-- Corrupted Whipper Root (4117, 4443, 4444, 4445, 4446, 4461)
DELETE FROM smart_scripts WHERE entryorguid IN(164888, 173284, 174605, 174606, 174607, 174686) AND source_type=1; 
INSERT INTO smart_scripts VALUES (164888, 1, 0, 1, 20, 0, 100, 0, 4117, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (164888, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 48881, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cleansed Whipper Root'''); 
INSERT INTO smart_scripts VALUES (173284, 1, 0, 1, 20, 0, 100, 0, 4443, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (173284, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 44882, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cozy Fire'''); 
INSERT INTO smart_scripts VALUES (174605, 1, 0, 1, 20, 0, 100, 0, 4444, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (174605, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 48883, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cleansed Whipper Root'''); 
INSERT INTO smart_scripts VALUES (174606, 1, 0, 1, 20, 0, 100, 0, 4445, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (174606, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 48884, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cleansed Whipper Root'''); 
INSERT INTO smart_scripts VALUES (174607, 1, 0, 1, 20, 0, 100, 0, 4446, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (174607, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 48885, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cleansed Whipper Root'''); 
INSERT INTO smart_scripts VALUES (174686, 1, 0, 1, 20, 0, 100, 0, 4461, 0, 0, 0, 85, 15343, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Cast Create Whipper Root Tubers'); 
INSERT INTO smart_scripts VALUES (174686, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 70, 5000, 0, 0, 0, 0, 0, 14, 48886, 0, 0, 0, 0, 0, 0, 'Corrupted Whipper Root - On Quest ''Corrupted Whipper Root'' Finished - Respawn Closest Gameobject ''Cleansed Whipper Root'''); 

-- Avenging the Fallen (7830)
UPDATE quest_template SET SpecialFlags=0 WHERE Id=7830;

-- Rise, Obsidion! (3566)
UPDATE gameobject_template SET AIName='SmartGameObjectAI', ScriptName='' WHERE entry=148498;
DELETE FROM smart_scripts WHERE entryorguid=148498 AND source_type=1;
INSERT INTO smart_scripts VALUES (148498, 1, 0, 1, 62, 0, 100, 0, 1282, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Altar of Suntara - On Gossip Select - Close gossip');
INSERT INTO smart_scripts VALUES (148498, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 12, 8391, 4, 90000, 0, 0, 0, 8, 0, 0, 0, -6460.528, -1267.63, 180.7818, 1.89, 'Altar of Suntara - Linked with previous event - spawn Lathoric the Black');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1282;
INSERT INTO conditions VALUES(15, 1282, 0, 0, 0, 29, 0, 8391, 100, 0, 1, 0, 0, '', 'Show gossip if no NPC nearby');
INSERT INTO conditions VALUES(15, 1282, 0, 0, 0, 29, 0, 8400, 100, 0, 0, 0, 0, '', 'Show gossip if NPC is nearby');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry IN(8391, 8417, 8400);
UPDATE creature_template SET speed_walk=1.3, faction=14, unit_flags=768 WHERE entry=8391;
DELETE FROM smart_scripts WHERE entryorguid IN(8391, 8417, 8400) AND source_type=0;
INSERT INTO smart_scripts VALUES (8391, 0, 0, 1, 25, 0, 100, 257, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, -6475.467285, -1242.283203, 180.190109, 3.58, 'Lathoric the Black - On Reset - Move to Altar of Suntara');
INSERT INTO smart_scripts VALUES (8391, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 12, 8421, 3, 45000, 0, 0, 0, 8, 0, 0, 0, -6481.127441, -1237.451538, 180.067535, 5.104429, 'Lathoric the Black - On Reset - Spawn Dorius');
INSERT INTO smart_scripts VALUES (8391, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Reset - Set React State Passive');
INSERT INTO smart_scripts VALUES (8391, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Reset - Set Walk');
INSERT INTO smart_scripts VALUES (8391, 0, 4, 0, 1, 0, 100, 1, 8000, 8000, 0, 0, 1, 0, 5000, 0, 0, 0, 0, 19, 8421, 100, 0, 0, 0, 0, 0, 'Lathoric the Black - OOC - Say (Dorius)');
INSERT INTO smart_scripts VALUES (8391, 0, 5, 0, 52, 0, 100, 0, 0, 8421, 0, 0, 1, 1, 5000, 0, 0, 0, 0, 19, 8421, 100, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say (Dorius)');
INSERT INTO smart_scripts VALUES (8391, 0, 6, 0, 52, 0, 100, 0, 1, 8421, 0, 0, 1, 2, 5000, 0, 0, 0, 0, 19, 8421, 100, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say (Dorius)');
INSERT INTO smart_scripts VALUES (8391, 0, 7, 0, 52, 0, 100, 0, 2, 8421, 0, 0, 1, 3, 5000, 0, 0, 0, 0, 19, 8421, 100, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say (Dorius)');
INSERT INTO smart_scripts VALUES (8391, 0, 8, 0, 52, 0, 100, 0, 3, 8421, 0, 0, 1, 4, 5000, 0, 0, 0, 0, 19, 8421, 100, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say (Dorius)');
INSERT INTO smart_scripts VALUES (8391, 0, 9, 0, 52, 0, 100, 0, 4, 8421, 0, 0, 1, 0, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say');
INSERT INTO smart_scripts VALUES (8391, 0, 10, 0, 52, 0, 100, 0, 0, 8391, 0, 0, 1, 1, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Say');
INSERT INTO smart_scripts VALUES (8391, 0, 11, 12, 52, 0, 100, 0, 1, 8391, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 5799, 8400, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Send Data to Obsidion');
INSERT INTO smart_scripts VALUES (8391, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (8391, 0, 13, 14, 61, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Set React State Aggressive');
INSERT INTO smart_scripts VALUES (8391, 0, 14, 0, 61, 0, 100, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Text Over - Attack');
INSERT INTO smart_scripts VALUES (8391, 0, 15, 0, 7, 0, 100, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lathoric the Black - On Evade - Despawn');

INSERT INTO smart_scripts VALUES (8400, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 19, 256, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 'Obsidion - On Data Set - Remove Unattackable Flags');
INSERT INTO smart_scripts VALUES (8400, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidion - Linked with Previous Event - Set Bytes_1');
INSERT INTO smart_scripts VALUES (8400, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 'Obsidion - Linked with Previous Event - Attack');
INSERT INTO smart_scripts VALUES (8400, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidion - On Evade - Despawn');
INSERT INTO smart_scripts VALUES (8400, 0, 4, 0, 9, 0, 100, 0, 0, 10, 20000, 30000, 11, 12734, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Obsidion - On Range - Cast Floor Smash');
INSERT INTO smart_scripts VALUES (8400, 0, 5, 0, 9, 0, 100, 0, 0, 5, 15000, 30000, 11, 10101, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Obsidion - On Range - Cast Knock Away');

INSERT INTO smart_scripts VALUES (8417, 0, 0, 0, 19, 0, 100, 0, 3566, 0, 0, 0, 12, 8391, 4, 90000, 0, 0, 0, 8, 0, 0, 0, -6460.528, -1267.63, 180.7818, 1.89, ' Dying Archaeologist - On Quest Accept - spawn Lathoric the Black');

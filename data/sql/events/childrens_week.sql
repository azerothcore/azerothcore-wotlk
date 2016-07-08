
REPLACE INTO game_event VALUES(10, "2014-04-28 00:01:00", "2020-12-31 06:00:00", 525600, 10080, 201, "Children's Week", 0);

-- return whistle
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(5848, 5849, 8568);
INSERT INTO conditions VALUES(15, 5848, 1, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 5849, 1, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 8568, 1, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 8568, 1, 0, 0, 16, 0, 77, 0, 0, 0, 0, 0, '', 'Requires alliance \ draenei');
INSERT INTO conditions VALUES(15, 8568, 2, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 8568, 2, 0, 0, 16, 0, 178, 0, 0, 0, 0, 0, '', 'Requires horde \ blood elf');
INSERT INTO conditions VALUES(15, 8568, 3, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 8568, 3, 0, 0, 16, 0, 1024, 0, 0, 0, 0, 0, '', 'Requires draenei');
INSERT INTO conditions VALUES(15, 8568, 4, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern''s week');
INSERT INTO conditions VALUES(15, 8568, 4, 0, 0, 16, 0, 512, 0, 0, 0, 0, 0, '', 'Requires blood elf');
DELETE FROM gossip_menu_option WHERE menu_id IN(5848, 5849, 8568);
INSERT INTO gossip_menu_option VALUES(5848, 1, 0, "I have lost my orcish orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(5849, 1, 0, "I have lost my human orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8568, 1, 0, "I have lost my human orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8568, 2, 0, "I have lost my orcish orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8568, 3, 0, "I have lost my draenei orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(8568, 4, 0, "I have lost my blood elf orphan whistle!", 1, 1, 0, 0, 0, 0, "");
UPDATE creature_template SET AIName="SmartAI", ScriptName="" WHERE entry IN(22819, 14451, 14450);
DELETE FROM smart_scripts WHERE entryorguid IN(22819, 14451, 14450) AND source_type=0;
INSERT INTO smart_scripts VALUES (14450, 0, 0, 1, 62, 0, 100, 0, 5849, 1, 0, 0, 11, 23124, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (14450, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (14451, 0, 0, 1, 62, 0, 100, 0, 5848, 1, 0, 0, 11, 23125, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (14451, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");
INSERT INTO smart_scripts VALUES (22819, 0, 0, 4, 62, 0, 100, 0, 8568, 1, 0, 0, 11, 23124, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (22819, 0, 1, 4, 62, 0, 100, 0, 8568, 2, 0, 0, 11, 23125, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (22819, 0, 2, 4, 62, 0, 100, 0, 8568, 3, 0, 0, 11, 39513, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (22819, 0, 3, 4, 62, 0, 100, 0, 8568, 4, 0, 0, 11, 39512, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (22819, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- missing npc Orphan Matron Aria (34365)
REPLACE INTO creature VALUES (245000, 34365, 571, 1, 65535, 0, 0, 5712.76, 635.632, 646.26, 5.56071, 300, 0, 0, 12600, 3994, 0, 0, 0, 0);
REPLACE INTO game_event_creature VALUES(10, 245000);
UPDATE creature_template SET AIName="SmartAI" WHERE entry=34365;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup IN(10502);
INSERT INTO conditions VALUES(15, 10502, 1, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern\'s week');
INSERT INTO conditions VALUES(15, 10502, 1, 0, 0, 14, 0, 13926, 0, 0, 1, 0, 0, '', 'Requires oracle quest');
INSERT INTO conditions VALUES(15, 10502, 2, 0, 0, 12, 0, 10, 0, 0, 0, 0, 0, '', 'Requires childern\'s week');
INSERT INTO conditions VALUES(15, 10502, 2, 0, 0, 14, 0, 13927, 0, 0, 1, 0, 0, '', 'Requires wolvar quest');
INSERT INTO conditions VALUES(15, 10502, 3, 0, 0, 9, 0, 13926, 0, 0, 1, 0, 0, '', 'Requires wolvar quest');
INSERT INTO conditions VALUES(15, 10502, 3, 0, 1, 9, 0, 13927, 0, 0, 1, 0, 0, '', 'Requires wolvar quest');
DELETE FROM gossip_menu_option WHERE menu_id IN(10502);
INSERT INTO gossip_menu_option VALUES(10502, 1, 0, "I have lost my oracle orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10502, 2, 0, "I have lost my wolvar orphan whistle!", 1, 1, 0, 0, 0, 0, "");
INSERT INTO gossip_menu_option VALUES(10502, 3, 0, "Tell me more about the orphans.", 1, 1, 10505, 0, 0, 0, "");
DELETE FROM smart_scripts WHERE entryorguid IN(34365) AND source_type=0;
INSERT INTO smart_scripts VALUES (34365, 0, 0, 3, 62, 0, 100, 0, 10502, 1, 0, 0, 11, 65359, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (34365, 0, 1, 3, 62, 0, 100, 0, 10502, 2, 0, 0, 11, 65360, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (34365, 0, 2, 3, 62, 0, 100, 0, 10502, 3, 0, 0, 33, 34365, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip select add item");
INSERT INTO smart_scripts VALUES (34365, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip linked close gossip");

-- dalaran orphan fixes
UPDATE creature_template SET gossip_menu_id=10503, AIName='SmartAI', ScriptName='' WHERE entry=33532;
UPDATE creature_template SET gossip_menu_id=10504, AIName='SmartAI', ScriptName='' WHERE entry=33533;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(65357);
INSERT INTO conditions VALUES (13, 1, 65357, 0, 0, 31, 0, 3, 33533, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 65357, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 65357, 0, 1, 31, 0, 3, 33532, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES (13, 1, 65357, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
REPLACE INTO npc_vendor VALUES(29478, 0, 46693, 0, 0, 0);
REPLACE INTO npc_vendor VALUES(29716, 0, 46693, 0, 0, 0);

-- Missing mail rewards
REPLACE INTO mail_loot_template VALUES(269, 46545, 100, 1, 0, 1, 1); -- Curious Oracle Hatchling
REPLACE INTO mail_loot_template VALUES(270, 46544, 100, 1, 0, 1, 1); -- Curious Wolvar Pup
UPDATE quest_template SET RewardMailTemplateId=269, RewardMailDelay=900 WHERE id=13959;
UPDATE quest_template SET RewardMailTemplateId=270, RewardMailDelay=900 WHERE id=13960;-- chaining-- Wolvar Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(13955, 13957, 13938);UPDATE quest_template SET prevquestid=13927, exclusivegroup=-13930 WHERE id IN (13930, 13934, 13951);UPDATE quest_template SET prevquestid=13930, exclusivegroup=-13955 WHERE id IN (13955, 13957);UPDATE quest_template SET prevquestid=13955, exclusivegroup=0 WHERE id=13938;UPDATE quest_template SET prevquestid=13938, exclusivegroup=0 WHERE id=13960;-- Oracle Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(13954, 13956, 13937);UPDATE quest_template SET prevquestid=13926, NextQuestId= exclusivegroup=-13929 WHERE id IN (13929, 13933, 13950);UPDATE quest_template SET prevquestid=13929, exclusivegroup=-13954 WHERE id IN (13954, 13956);UPDATE quest_template SET prevquestid=13954, exclusivegroup=0 WHERE id=13937;UPDATE quest_template SET prevquestid=13937, exclusivegroup=0 WHERE id=13959;-- Human Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(558, 4822, 171);UPDATE quest_template SET prevquestid=1468, exclusivegroup=-1479 WHERE id IN (1479, 1558, 1687);UPDATE quest_template SET prevquestid=1479, exclusivegroup=-558 WHERE id IN (558, 4822);UPDATE quest_template SET prevquestid=558, exclusivegroup=0 WHERE id=171;-- Orcish Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(915, 925, 5502);UPDATE quest_template SET prevquestid=172, exclusivegroup=-910 WHERE id IN (910, 911, 1800);UPDATE quest_template SET RequiredRaces=690, prevquestid=910, exclusivegroup=-915 WHERE id IN (915, 925);UPDATE quest_template SET prevquestid=915, exclusivegroup=0 WHERE id=5502;-- Draenei Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(10956, 10962, 10966);
DELETE FROM creature_queststarter WHERE quest=10968;
REPLACE INTO game_event_creature_quest VALUES (10, 17538, 10968);
UPDATE quest_template SET prevquestid=10943, exclusivegroup=-10950 WHERE id IN (10950, 10952, 10954);
UPDATE quest_template SET prevquestid=10950, exclusivegroup=-10956 WHERE id IN (10956, 10962);
UPDATE quest_template SET NextQuestIdChain=10968 WHERE id=10956;
UPDATE quest_template SET prevquestid=10956 WHERE id=10968;
UPDATE quest_template SET prevquestid=10968, exclusivegroup=0 WHERE id=10966;-- Blood Elf Orphan quest order
DELETE FROM conditions WHERE SourceTypeOrReferenceId IN(19, 20) AND SourceEntry IN(11975, 10963, 10967);UPDATE quest_template SET prevquestid=10942, exclusivegroup=-10945 WHERE id IN (10945, 10951, 10953);UPDATE quest_template SET prevquestid=10945, exclusivegroup=-11975 WHERE id IN (11975, 10963);UPDATE quest_template SET prevquestid=11975, exclusivegroup=0 WHERE id=10967;


-- Fix some receips counts
update `npc_vendor` set maxcount=0, incrtime=0 where item in(25848);
update `npc_vendor` set maxcount=1, incrtime=300 where item in(23591,23592,23590,23593,25847,23638);
update `npc_vendor` set maxcount=1, incrtime=900 where item in(23799,28282,22565,25849,22562,22563,23811);

-- Kaye Toogie (35826)
UPDATE creature_template SET npcflag=128 WHERE entry=35826;
DELETE FROM npc_vendor WHERE entry=35826;
INSERT INTO npc_vendor VALUES(35826, 0, 16054, 0, 0, 0);
INSERT INTO npc_vendor VALUES(35826, 0, 13311, 0, 0, 0);
INSERT INTO npc_vendor VALUES(35826, 0, 10609, 0, 0, 0);

-- Prospector Ryedol <Explorers' League> (2910)
DELETE FROM npc_vendor WHERE entry=2910;
INSERT INTO npc_vendor VALUES(2910, 0, 1708, 0, 0, 0);

-- Argent Squire (33238), Argent Gruntling (33239)
DELETE FROM npc_vendor WHERE entry IN(33238, 33239);
INSERT INTO npc_vendor VALUES(33238, 0, 33449, 0, 0, 0),(33238, 0, 33443, 0, 0, 0),(33238, 0, 33451, 0, 0, 0),(33238, 0, 35949, 0, 0, 0),
(33238, 0, 33452, 0, 0, 0),(33238, 0, 21835, 0, 0, 0),(33238, 0, 17030, 0, 0, 0),(33238, 0, 17020, 0, 0, 0),(33238, 0, 17036, 0, 0, 0),
(33238, 0, 28056, 0, 0, 0),(33238, 0, 29014, 0, 0, 0),(33238, 0, 35952, 0, 0, 0),(33238, 0, 37201, 0, 0, 0),(33238, 0, 22053, 0, 0, 0),
(33238, 0, 43232, 0, 0, 0),(33238, 0, 16583, 0, 0, 0),(33238, 0, 44615, 0, 0, 0),(33238, 0, 17028, 0, 0, 0),(33238, 0, 17037, 0, 0, 0),
(33238, 0, 5565, 0, 0, 0),(33238, 0, 8928, 0, 0, 0),(33238, 0, 43230, 0, 0, 0),(33238, 0, 17038, 0, 0, 0),(33238, 0, 29013, 0, 0, 0),
(33238, 0, 17034, 0, 0, 0),(33238, 0, 35953, 0, 0, 0),(33238, 0, 35951, 0, 0, 0),(33238, 0, 17032, 0, 0, 0),(33238, 0, 17031, 0, 0, 0),
(33238, 0, 17029, 0, 0, 0),(33238, 0, 33454, 0, 0, 0),(33238, 0, 35948, 0, 0, 0),(33238, 0, 35947, 0, 0, 0),(33238, 0, 44614, 0, 0, 0),
(33238, 0, 17035, 0, 0, 0),(33238, 0, 35950, 0, 0, 0),(33238, 0, 17033, 0, 0, 0),(33238, 0, 21177, 0, 0, 0),(33238, 0, 41586, 0, 0, 0),
(33238, 0, 17021, 0, 0, 0),(33238, 0, 22148, 0, 0, 0),(33238, 0, 44605, 0, 0, 0),(33238, 0, 17026, 0, 0, 0),(33238, 0, 43234, 0, 0, 0);
INSERT INTO npc_vendor VALUES(33239, 0, 33449, 0, 0, 0),(33239, 0, 33443, 0, 0, 0),(33239, 0, 33451, 0, 0, 0),(33239, 0, 35949, 0, 0, 0),
(33239, 0, 33452, 0, 0, 0),(33239, 0, 21835, 0, 0, 0),(33239, 0, 17030, 0, 0, 0),(33239, 0, 17020, 0, 0, 0),(33239, 0, 17036, 0, 0, 0),
(33239, 0, 28056, 0, 0, 0),(33239, 0, 29014, 0, 0, 0),(33239, 0, 35952, 0, 0, 0),(33239, 0, 37201, 0, 0, 0),(33239, 0, 22053, 0, 0, 0),
(33239, 0, 43232, 0, 0, 0),(33239, 0, 16583, 0, 0, 0),(33239, 0, 44615, 0, 0, 0),(33239, 0, 17028, 0, 0, 0),(33239, 0, 17037, 0, 0, 0),
(33239, 0, 5565, 0, 0, 0),(33239, 0, 8928, 0, 0, 0),(33239, 0, 43230, 0, 0, 0),(33239, 0, 17038, 0, 0, 0),(33239, 0, 29013, 0, 0, 0),
(33239, 0, 17034, 0, 0, 0),(33239, 0, 35953, 0, 0, 0),(33239, 0, 35951, 0, 0, 0),(33239, 0, 17032, 0, 0, 0),(33239, 0, 17031, 0, 0, 0),
(33239, 0, 17029, 0, 0, 0),(33239, 0, 33454, 0, 0, 0),(33239, 0, 35948, 0, 0, 0),(33239, 0, 35947, 0, 0, 0),(33239, 0, 44614, 0, 0, 0),
(33239, 0, 17035, 0, 0, 0),(33239, 0, 35950, 0, 0, 0),(33239, 0, 17033, 0, 0, 0),(33239, 0, 21177, 0, 0, 0),(33239, 0, 41586, 0, 0, 0),
(33239, 0, 17021, 0, 0, 0),(33239, 0, 22148, 0, 0, 0),(33239, 0, 44605, 0, 0, 0),(33239, 0, 17026, 0, 0, 0),(33239, 0, 43234, 0, 0, 0);

-- Lhara (14846) restock time for Arctic Fur (44128)
UPDATE npc_vendor SET incrtime=7200 WHERE item=44128 AND entry=14846; 

-- Relentless Gladiator's Tabard (49086)
DELETE FROM npc_vendor WHERE item=49086;

-- Reagent Vendors, some corrections
REPLACE INTO npc_vendor VALUES (3323, 0, 44605, 0, 0, 0),(3323, 0, 44614, 0, 0, 0),(3323, 0, 44615, 0, 0, 0);
REPLACE INTO npc_vendor VALUES (8361, 0, 44605, 0, 0, 0),(8361, 0, 44614, 0, 0, 0),(8361, 0, 44615, 0, 0, 0);
REPLACE INTO npc_vendor VALUES (16611, 0, 44605, 0, 0, 0),(16611, 0, 44614, 0, 0, 0),(16611, 0, 44615, 0, 0, 0);
REPLACE INTO npc_vendor VALUES (4562, 0, 44605, 0, 0, 0),(4562, 0, 44614, 0, 0, 0),(4562, 0, 44615, 0, 0, 0);

-- Furbolg Medicine Pouch (16768)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=23 AND SourceEntry IN(16768);
INSERT INTO conditions VALUES (23, 11555, 16768, 0, 0, 5, 0, 576, 128+64+32, 0, 0, 0, 0, '', 'Furbolg Medicine Pouch - when Timbermaw Hold honored/revered/exalted');

-- Iron Boot Flask (43499)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=23 AND SourceEntry IN(43499);
INSERT INTO conditions VALUES (23, 29744, 43499, 0, 0, 8, 0, 12870, 0, 0, 0, 0, 0, '', 'Iron Boot Flask - when rewarded quest Ancient Relic'); -- Alliance
INSERT INTO conditions VALUES (23, 30472, 43499, 0, 0, 8, 0, 12882, 0, 0, 0, 0, 0, '', 'Iron Boot Flask - when rewarded quest Ancient Relic'); -- Horde

-- Expert Cookbook (16072), Deleted in 3.1
DELETE FROM npc_vendor WHERE item=16072;

-- Expert First Aid (16084), Deleted in 3.1
DELETE FROM npc_vendor WHERE item=16084;

-- Expert Fishing (16083), Deleted in 3.1
DELETE FROM npc_vendor WHERE item=16083;

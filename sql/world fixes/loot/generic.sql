
-- Fix Hakkari items drop
DELETE FROM creature_loot_template WHERE item IN(10780,10781,10782);
UPDATE item_template SET RequiredLevel=46 WHERE entry IN(10780,10781,10782);

-- Stone Keeper's Shard (43228)
UPDATE conditions SET ConditionValue1=57940 WHERE SourceTypeOrReferenceId=1 AND SourceEntry=43228 AND ConditionValue1=58045;

-- Rhino Meat (43012)
UPDATE creature_loot_template SET ChanceOrQuestChance=50 WHERE entry=28009 AND item=43012;

-- Adolescent Whelp (740) drops Tiny Emerald Whelpling (8498)
DELETE FROM creature_loot_template WHERE entry=740 AND item=8498;
INSERT INTO creature_loot_template VALUES (740, 8498, 0.1, 1, 0, 1, 1);

-- Prospecting loot, 4 ores are wrongly assumed to work
DELETE FROM reference_loot_template WHERE entry IN(13003, 13004); -- Remove unused now references

DELETE FROM prospecting_loot_template WHERE entry=23424;
INSERT INTO prospecting_loot_template VALUES (23424, 1, 100, 1, 1, -1000, 1);
DELETE FROM reference_loot_template WHERE entry=1000;
INSERT INTO reference_loot_template VALUES (1000, 21929, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23077, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23079, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23107, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23112, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23117, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1000, 23436, 1, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (1000, 23437, 1, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (1000, 23438, 1, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (1000, 23439, 1, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (1000, 23440, 1, 1, 1, 1, 1);
INSERT INTO reference_loot_template VALUES (1000, 23441, 1, 1, 1, 1, 1);

DELETE FROM prospecting_loot_template WHERE entry=36909;
INSERT INTO prospecting_loot_template VALUES (36909, 1, 100, 1, 1, -1001, 1);
DELETE FROM reference_loot_template WHERE entry=1001;
INSERT INTO reference_loot_template VALUES (1001, 36917, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36920, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36923, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36926, 16, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36929, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36932, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36918, 1, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36921, 1, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36924, 1, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36927, 1, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36930, 1, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1001, 36933, 1, 1, 1, 1, 2);

DELETE FROM prospecting_loot_template WHERE entry=36910;
INSERT INTO prospecting_loot_template VALUES (36910, 46849, 75, 1, 0, 1, 1);
INSERT INTO prospecting_loot_template VALUES (36910, 1, 20, 1, 0, -13005, 1);
INSERT INTO prospecting_loot_template VALUES (36910, 2, 100, 1, 1, -1002, 1);
INSERT INTO prospecting_loot_template VALUES (36910, 3, 75, 1, 1, -1003, 1);
DELETE FROM reference_loot_template WHERE entry=1002;
DELETE FROM reference_loot_template WHERE entry=1003;
INSERT INTO reference_loot_template VALUES (1002, 36917, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36920, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36923, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36926, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36929, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36932, 12.5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36918, 5, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36921, 4, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36924, 4, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36927, 4, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36930, 4, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1002, 36933, 4, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36917, 0, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36920, 0, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36923, 0, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36926, 0, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36929, 0, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1003, 36932, 0, 1, 1, 1, 2);

DELETE FROM prospecting_loot_template WHERE entry=36912;
INSERT INTO prospecting_loot_template VALUES (36912, 1, 85, 1, 0, -1003, 1);
INSERT INTO prospecting_loot_template VALUES (36912, 2, 100, 1, 1, -1004, 1);
DELETE FROM reference_loot_template WHERE entry=1004;
INSERT INTO reference_loot_template VALUES (1004, 36917, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36920, 15, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36923, 14, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36926, 14, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36929, 14, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36932, 14, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36918, 3, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36921, 3, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36924, 2, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36927, 2, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36930, 2, 1, 1, 1, 2);
INSERT INTO reference_loot_template VALUES (1004, 36933, 2, 1, 1, 1, 2);

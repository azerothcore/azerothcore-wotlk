
-- Dredge Striker (11740), Fix Skinning
UPDATE creature_template SET skinloot=11740 WHERE entry=11740;
DELETE FROM skinning_loot_template WHERE entry=11740;
INSERT INTO skinning_loot_template VALUES (11740, 8170, 50, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (11740, 4304, 42, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (11740, 8171, 4, 1, 1, 1, 2);
INSERT INTO skinning_loot_template VALUES (11740, 8169, 4, 1, 1, 1, 2);

-- Dredge Crusher (11741), Fix Skinning
UPDATE creature_template SET skinloot=11741 WHERE entry=11741;
DELETE FROM skinning_loot_template WHERE entry=11741;
INSERT INTO skinning_loot_template VALUES (11741, 8170, 50, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (11741, 4304, 42, 1, 1, 1, 3);
INSERT INTO skinning_loot_template VALUES (11741, 8171, 4, 1, 1, 1, 2);
INSERT INTO skinning_loot_template VALUES (11741, 8169, 4, 1, 1, 1, 2);

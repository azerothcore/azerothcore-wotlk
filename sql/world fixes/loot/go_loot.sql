
-- Some fixes For Northrend Fishes Schools
-- Add Pygmy Suckerfish (40199)
DELETE FROM gameobject_loot_template WHERE item=40199;
INSERT INTO gameobject_loot_template VALUES (25668, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25665, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25664, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25669, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25663, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25662, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25673, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25674, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25671, 40199, 50, 1, 2, 1, 1);
INSERT INTO gameobject_loot_template VALUES (25670, 40199, 50, 1, 2, 1, 1);

-- Goldclover drop from Frozen Herb
UPDATE gameobject_loot_template SET ChanceOrQuestChance=0, groupid=1, mincountOrRef=1, maxcount=4 WHERE entry IN(25094, 25095);

-- Nether Residue from Mining (35229)
REPLACE INTO gameobject_loot_template VALUES (18359, 35229, -25, 1, 0, 1, 1); -- Fel Iron Deposit (181555)
REPLACE INTO gameobject_loot_template VALUES (18361, 35229, -25, 1, 0, 1, 1); -- Adamantite Deposit (181556)
REPLACE INTO gameobject_loot_template VALUES (18363, 35229, -25, 1, 0, 1, 1); -- Khorium Vein (181557)
REPLACE INTO gameobject_loot_template VALUES (26861, 35229, -25, 1, 0, 1, 1); -- Rich Adamantite Deposit (181569)

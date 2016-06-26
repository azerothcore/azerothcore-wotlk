
-- Champion's Purse
UPDATE item_loot_template SET ChanceOrQuestChance=100 WHERE entry=45724 and item=44990;

-- Bag of Fishing Treasures (35348)
DELETE FROM item_loot_template WHERE entry=34863 AND minCountOrRef=-11116;

-- Box of Bombs (44951)
DELETE FROM item_loot_template WHERE entry=44951;
INSERT INTO item_loot_template VALUES (44951, 41119, 100, 1, 0, 24, 40);

-- Large Rope Net (835), delete from drop
DELETE FROM creature_loot_template WHERE item=835;

-- Cracked Egg (39883)
UPDATE item_loot_template SET ChanceOrQuestChance=2 WHERE entry=39883 AND item=44707;

-- Box of Goodies (9541)
DELETE FROM item_loot_template WHERE entry=9541;
INSERT INTO item_loot_template VALUES (9541, 24041, 100, 1, 0, -24041, 1);
INSERT INTO item_loot_template VALUES (9541, 24043, 25, 1, 1, -24043, 1);
INSERT INTO item_loot_template VALUES (9541, 24045, 25, 1, 1, -24045, 1);

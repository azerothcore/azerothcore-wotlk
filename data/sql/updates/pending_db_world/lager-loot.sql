-- adjust chances in tbc reference
UPDATE `reference_loot_template` SET `Chance` = 2 WHERE `Reference` = 11114 AND `Item` = 34834; -- lager
UPDATE `reference_loot_template` SET `Chance` = 2 WHERE `Reference` = 11114 AND `Item` = 34836; -- line
-- create tbc template entries
DELETE FROM `item_loot_template` WHERE `Item` = 34834 AND `Entry` IN (33844, 33857);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33844, 34834, 0, 0.15, 0, 1, 3, 1, 1, 'Barrel of Fish - Recipe: Captain Rumsey''s Lager'),
(33857, 34834, 0, 0.1, 0, 1, 2, 1, 1, 'Crate of Meat - Recipe: Captain Rumsey''s Lager');
-- adjust tbc template chances
UPDATE `item_loot_template` SET `Chance` = 100 WHERE `Reference` = 11114 AND `Entry` IN (34863, 35348);
-- adjust wotlk template chances
UPDATE `item_loot_template` SET `Chance` = 0.6 WHERE `Entry` = 46007 AND `Item` = 34834;
UPDATE `item_loot_template` SET `Chance` = 0.8 WHERE `Entry` = 44113 AND `Item` = 34834;

-- DB update 2026_01_26_00 -> 2026_01_26_01
--
-- Remove Weather-Beaten Journal from Dark Runed Chest ref
DELETE FROM `reference_loot_template` WHERE (`Entry` = 35037) AND (`Item` IN (34109));

-- Add Weather-Beaten Journal to Bag of Fishing Treasures
SET @CHANCE := 20;
DELETE FROM `item_loot_template` WHERE (`Entry` = 35348) AND (`Item` IN (34109));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35348, 34109, 0, @CHANCE, 0, 1, 0, 1, 1, 'Weather-Beaten Journal');

-- Add Weather-Beaten Journal to Bag of Fishing Treasures
SET @CHANCE := 15;
DELETE FROM `item_loot_template` WHERE (`Entry` = 34863) AND (`Item` IN (34109));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34863, 34109, 0, @CHANCE, 0, 1, 0, 1, 1, 'Weather-Beaten Journal');

-- DB update 2025_11_30_07 -> 2025_11_30_08
SET @ITEM = 6995;
SET @ENTRY = 1055;

-- Creates a reference loot for "Corrupted Kor Gem"
DELETE FROM `reference_loot_template` WHERE `Entry` = @ENTRY AND `Item` = @ITEM;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, @ITEM, 0, 100, 1, 1, 1, 1, 1, 'Corrupted Kor Gem');

-- Deletes "Corrupted Kor Gem" from every creature's loot
DELETE FROM `creature_loot_template` WHERE `item` = @ITEM;

-- Adds reference loot for "Corrupted Kor Gem" for each creature below
DELETE FROM `creature_loot_template` WHERE `Reference` = @ENTRY AND `Entry` IN (4802, 4803, 4805);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4802, @ITEM, @ENTRY, 80, 0, 1, 0, 1, 1, 'Blackfathom Tide Priestess - Corrupted Kor Gem'),
(4803, @ITEM, @ENTRY, 80, 0, 1, 0, 1, 1, 'Blackfathom Oracle - Corrupted Kor Gem'),
(4805, @ITEM, @ENTRY, 80, 0, 1, 0, 1, 1, 'Blackfathom Sea Witch - Corrupted Kor Gem');

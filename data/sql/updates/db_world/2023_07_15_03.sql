-- DB update 2023_07_15_02 -> 2023_07_15_03
--
DELETE FROM `reference_loot_template` WHERE `Entry` IN (526791, 526792);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(526791, 21929, 0, 0, 0, 1, 1, 1, 1, 'Flame Spessarite'),
(526791, 23077, 0, 0, 0, 1, 1, 1, 1, 'Blood Garnet'),
(526791, 23107, 0, 0, 0, 1, 1, 1, 1, 'Shadow Draenite'),
(526791, 23112, 0, 0, 0, 1, 1, 1, 1, 'Golden Draenite'),
(526791, 23079, 0, 0, 0, 1, 1, 1, 1, 'Deep Peridot'),
(526791, 23117, 0, 0, 0, 1, 1, 1, 1, 'Azure Moonstone'),
(526792, 23436, 0, 0, 0, 1, 1, 1, 1, 'Living Ruby'),
(526792, 23437, 0, 0, 0, 1, 1, 1, 1, 'Talasite'),
(526792, 23438, 0, 0, 0, 1, 1, 1, 1, 'Star of Eluna'),
(526792, 23439, 0, 0, 0, 1, 1, 1, 1, 'Noble Topaz'),
(526792, 23441, 0, 0, 0, 1, 1, 1, 1, 'Dawnstone'),
(526792, 23440, 0, 0, 0, 1, 1, 1, 1, 'Nightseye');

DELETE FROM `item_loot_template` WHERE `Entry` IN (25419, 25422, 25423, 25424) AND (`Item` IN (21929, 23077, 23079, 23107, 23112, 23117, 23436, 23437, 23438, 23439, 23440, 23441, 0, 1, 2, 3, 4, 5));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25424, 0, 526791, 100, 0, 1, 0, 1, 1, 'Gem-Stuffed Envelope - Uncommon TBC Gems (ReferenceTable)'),
(25424, 1, 526791, 55, 0, 1, 1, 1, 1, 'Gem-Stuffed Envelope - Uncommon TBC Gems (ReferenceTable)'),
(25424, 2, 526791, 55, 0, 1, 2, 1, 1, 'Gem-Stuffed Envelope - Uncommon TBC Gems (ReferenceTable)'),
(25424, 3, 526792, 4, 0, 1, 0, 1, 1, 'Gem-Stuffed Envelope - Rare Gems TBC (ReferenceTable)'),
(25424, 4, 526792, 4, 0, 1, 1, 1, 1, 'Gem-Stuffed Envelope - Rare Gems TBC (ReferenceTable)'),
(25424, 5, 526792, 4, 0, 1, 2, 1, 1, 'Gem-Stuffed Envelope - Rare Gems TBC (ReferenceTable)'),
(25419, 0, 526791, 100, 0, 1, 0, 1, 1, 'Unmarked Bag of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25419, 1, 526791, 55, 0, 1, 1, 1, 1, 'Unmarked Bag of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25419, 2, 526791, 55, 0, 1, 2, 1, 1, 'Unmarked Bag of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25419, 3, 526792, 4, 0, 1, 0, 1, 1, 'Unmarked Bag of Gems - Rare TBC Gems (ReferenceTable)'),
(25419, 4, 526792, 4, 0, 1, 1, 1, 1, 'Unmarked Bag of Gems - Rare TBC Gems (ReferenceTable)'),
(25419, 5, 526792, 4, 0, 1, 2, 1, 1, 'Unmarked Bag of Gems - Rare TBC Gems (ReferenceTable)'),
(25422, 0, 526791, 100, 0, 1, 0, 1, 1, 'Bulging Sack of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25422, 1, 526791, 67, 0, 1, 1, 1, 1, 'Bulging Sack of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25422, 2, 526791, 67, 0, 1, 2, 1, 1, 'Bulging Sack of Gems - Uncommon TBC Gems (ReferenceTable)'),
(25422, 3, 526792, 22, 0, 1, 0, 1, 1, 'Bulging Sack of Gems - Rare TBC Gems (ReferenceTable)'),
(25422, 4, 526792, 22, 0, 1, 1, 1, 1, 'Bulging Sack of Gems - Rare TBC Gems (ReferenceTable)'),
(25422, 5, 526792, 22, 0, 1, 2, 1, 1, 'Bulging Sack of Gems - Rare TBC Gems (ReferenceTable)'),
(25423, 0, 526791, 100, 0, 1, 0, 1, 1, 'Bag of Premium Gems - Uncommon TBC Gems (ReferenceTable)'),
(25423, 1, 526791, 70, 0, 1, 1, 1, 1, 'Bag of Premium Gems - Uncommon TBC Gems (ReferenceTable)'),
(25423, 2, 526791, 70, 0, 1, 2, 1, 1, 'Bag of Premium Gems - Uncommon TBC Gems (ReferenceTable)'),
(25423, 3, 526792, 100, 0, 1, 0, 1, 1, 'Bag of Premium Gems - Rare TBC Gems (ReferenceTable)'),
(25423, 4, 526792, 25, 0, 1, 1, 1, 1, 'Bag of Premium Gems - Rare TBC Gems (ReferenceTable)'),
(25423, 5, 526792, 25, 0, 1, 2, 1, 1, 'Bag of Premium Gems - Rare TBC Gems (ReferenceTable)');

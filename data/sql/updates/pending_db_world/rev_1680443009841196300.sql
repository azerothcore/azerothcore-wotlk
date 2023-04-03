-- Ferra loot update
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14308) AND (`Item` IN (4500, 5759, 11414, 11415, 13000, 34003));

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 4500, 0, 0.125, 0, 1, 0, 1, 1, 'Ferra - Thorium Lockbox');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 5759, 0, 1, 0, 1, 0, 1, 1, 'Ferra - Traveler\'s Backpack');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 11414, 0, 65, 0, 1, 0, 1, 1, 'Ferra - Grizzled Mane');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 11415, 0, 27, 0, 1, 0, 1, 1, 'Ferra - Mixed Berries');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(14308, 13000, 13000, 1.5, 0, 1, 0, 1, 1, 'Ferra - (ReferenceTable)');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(14308, 34003, 34003, 5.25, 0, 1, 0, 1, 1, 'Ferra - (ReferenceTable)');

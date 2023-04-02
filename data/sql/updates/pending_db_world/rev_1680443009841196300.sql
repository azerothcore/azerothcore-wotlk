-- Ferra loot update
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14308) AND (`Item` IN (4500, 11414, 11415, 24016));

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 4500, 0, 1, 0, 1, 0, 1, 1, 'Ferra - Traveler\'s Backpack');

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(14308, 24016, 24016, 1, 0, 1, 0, 1, 1, 'Ferra - (ReferenceTable)');

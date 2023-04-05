-- DB update 2023_04_05_02 -> 2023_04_05_03
-- Ferra loot update
DELETE FROM `creature_loot_template` WHERE (`Entry` = 14308) AND (`Item` IN (4500, 5759, 7909, 7910, 8146, 11414, 11415, 24016, 24018, 24020, 24033));

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14308, 4500, 0, 0.125, 0, 1, 0, 1, 1, 'Ferra - Thorium Lockbox'),
(14308, 5759, 0, 1, 0, 1, 0, 1, 1, 'Ferra - Traveler\'s Backpack'),
(14308, 8146, 0, 5, 0, 1, 0, 1, 1, 'Ferra - Wicked Claw'),
(14308, 11414, 0, 65, 0, 1, 0, 1, 1, 'Ferra - Grizzled Mane'),
(14308, 11415, 0, 27, 0, 1, 0, 1, 1, 'Ferra - Mixed Berries'),
(14308, 7909, 0, 1, 0, 1, 2, 1, 1, 'Ferra - Aquamarine'),
(14308, 7910, 0, 0.5, 0, 1, 2, 1, 1, 'Ferra - Star Ruby'),
(14308, 24016, 24016, 2, 0, 1, 1, 1, 1, 'Ferra - (ReferenceTable)'),
(14308, 24018, 24018, 1.5, 0, 1, 1, 1, 1, 'Ferra - (ReferenceTable)'),
(14308, 24020, 24020, 1, 0, 1, 1, 1, 1, 'Ferra - (ReferenceTable)'),
(14308, 24033, 24033, 0.75, 0, 1, 1, 1, 1, 'Ferra - (ReferenceTable)');

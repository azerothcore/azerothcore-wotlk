-- DB update 2023_03_04_15 -> 2023_03_04_16
--
DELETE FROM `reference_loot_template` WHERE `Entry` IN (24740, 24741) AND `Item` IN (27925,27946,27980,27981,27985,27986,27776,27838,27875,27936,27948);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24740, 27925, 0, 0, 0, 1, 1, 1, 1, 'Ravenclaw Band'),
(24740, 27946, 0, 0, 0, 1, 1, 1, 1, 'Avian Cloak of Feathers'),
(24740, 27980, 0, 0, 0, 1, 1, 1, 1, 'Terokk\'s Nightmace'),
(24740, 27981, 0, 0, 0, 1, 1, 1, 1, 'Sethekk Oracle Cloak'),
(24740, 27985, 0, 0, 0, 1, 1, 1, 1, 'Deathforge Girdle'),
(24740, 27986, 0, 0, 0, 1, 1, 1, 1, 'Crow Wing Reaper'),

(24741, 27776, 0, 0, 0, 1, 1, 1, 1, 'Shoulderpads of Assassination'),
(24741, 27838, 0, 0, 0, 1, 1, 1, 1, 'Incanter\'s Trousers'),
(24741, 27875, 0, 0, 0, 1, 1, 1, 1, 'Hallowed Trousers'),
(24741, 27936, 0, 0, 0, 1, 1, 1, 1, 'Greaves of Desolation'),
(24741, 27948, 0, 0, 0, 1, 1, 1, 1, 'Trousers of Oblivion');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 18473) AND (`Item` IN (25006, 1, 2));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18473, 1, 24740, 100, 0, 1, 0, 1, 1, 'Talon King Ikiss (Reference Table)'),
(18473, 2, 24741, 100, 0, 1, 0, 1, 1, 'Talon King Ikiss (Reference Table)');

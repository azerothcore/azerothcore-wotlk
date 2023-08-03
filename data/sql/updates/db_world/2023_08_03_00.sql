-- DB update 2023_08_02_00 -> 2023_08_03_00
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (16152, 16457, 17521, 18168, 15691, 15687, 15688, 16524, 15689, 15690)) AND (`Item` IN (29434, 23809, 30480));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16152, 23809, 0, 8, 0, 1, 0, 1, 1, 'Attumen the Huntsman - Schematic: Stabilized Eternium Scope'),
(16152, 30480, 0, 1, 0, 1, 0, 1, 1, 'Attumen the Huntsman - Fiery Warhorse\'s Reins'),
(15687, 29434, 0, 100, 0, 1, 0, 1, 1, 'Moroes - Badge of Justice'),
(16457, 29434, 0, 100, 0, 1, 0, 1, 1, 'Maiden of Virtue - Badge of Justice'),
(17521, 29434, 0, 100, 0, 1, 0, 1, 1, 'The Big Bad Wolf - Badge of Justice'),
(18168, 29434, 0, 100, 0, 1, 0, 1, 1, 'The Crone - Badge of Justice'),
(15691, 29434, 0, 100, 0, 1, 0, 1, 1, 'The Curator - Badge of Justice'),
(15688, 29434, 0, 100, 0, 1, 0, 1, 1, 'Terestian Illhoof - Badge of Justice'),
(16524, 29434, 0, 100, 0, 1, 0, 1, 1, 'Shade of Aran - Badge of Justice'),
(15689, 29434, 0, 100, 0, 1, 0, 1, 1, 'Netherspite - Badge of Justice'),
(15690, 29434, 0, 100, 0, 1, 0, 2, 2, 'Prince Malchezaar - Badge of Justice');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 20712) AND (`Item` IN (29434));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20712, 29434, 0, 100, 0, 1, 0, 1, 1, 'Dust Covered Chest - Badge of Justice');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 12001) AND (`Item` IN (28745, 28746, 28747, 28748, 28749, 28750, 28751, 28752, 28753, 28754, 28755, 28756));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12001, 28745, 0, 0, 0, 1, 1, 1, 1, 'Mithril Chain of Heroism'),
(12001, 28746, 0, 0, 0, 1, 1, 1, 1, 'Fiend Slayer Boots'),
(12001, 28747, 0, 0, 0, 1, 1, 1, 1, 'Battlescar Boots'),
(12001, 28748, 0, 0, 0, 1, 1, 1, 1, 'Legplates of the Innocent'),
(12001, 28749, 0, 0, 0, 1, 1, 1, 1, 'King\'s Defender'),
(12001, 28750, 0, 0, 0, 1, 1, 1, 1, 'Girdle of Treachery'),
(12001, 28751, 0, 0, 0, 1, 1, 1, 1, 'Heart-Flame Leggings'),
(12001, 28752, 0, 0, 0, 1, 1, 1, 1, 'Forestlord Striders'),
(12001, 28753, 0, 0, 0, 1, 1, 1, 1, 'Ring of Recurrence'),
(12001, 28754, 0, 0, 0, 1, 1, 1, 1, 'Triptych Shield of the Ancients'),
(12001, 28755, 0, 0, 0, 1, 1, 1, 1, 'Bladed Shoulderpads of the Merciless'),
(12001, 28756, 0, 0, 0, 1, 1, 1, 1, 'Headdress of the High Potentate');

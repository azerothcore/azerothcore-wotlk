-- DB update 2026_02_20_01 -> 2026_02_20_02
-- Ornate Bronze Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4632);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4632, 1, 4632, 100, 0, 1, 0, 1, 1, 'Ornate Bronze Lockbox - Guaranteed Loot'),
(4632, 2, 4632, 25, 0, 1, 0, 1, 1, 'Ornate Bronze Lockbox - Bonus Loot 1'),
(4632, 3, 4632, 5, 0, 1, 0, 1, 1, 'Ornate Bronze Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4632);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4632, 1206, 0, 3, 0, 1, 1, 1, 1, 'Moss Agate'),
(4632, 1210, 0, 1, 0, 1, 1, 1, 1, 'Shadowgem'),
(4632, 1705, 0, 1, 0, 1, 1, 1, 1, 'Lesser Moonstone'),
(4632, 1 , 1011822, 2, 0, 1, 1, 1, 1, 'Vanilla Whites 18-22 Level Range'),
(4632, 2 , 1011923, 2, 0, 1, 1, 1, 1, 'Vanilla Whites 19-23 Level Range'),
(4632, 3 , 1012024, 2, 0, 1, 1, 1, 1, 'Vanilla Whites 20-24 Level Range'),
(4632, 4 , 1012125, 2, 0, 1, 1, 1, 1, 'Vanilla Whites 21-25 Level Range'),
(4632, 5 , 1021620, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 16-20 Level Range'),
(4632, 6 , 1021721, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 17-21 Level Range'),
(4632, 7 , 1021822, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 18-22 Level Range'),
(4632, 8 , 1021923, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 19-23 Level Range'),
(4632, 9 , 1022024, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 20-24 Level Range'),
(4632, 10, 1022125, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 21-25 Level Range'),
(4632, 11, 1022226, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 22-26 Level Range'),
(4632, 12, 1022327, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 23-27 Level Range'),
(4632, 13, 1022428, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 24-28 Level Range'),
(4632, 14, 1032023, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 20-23 Level Range'),
(4632, 15, 1032124, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 21-24 Level Range'),
(4632, 16, 1032225, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 22-25 Level Range'),
(4632, 17, 1032326, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 23-26 Level Range'),
(4632, 18, 1032427, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 24-27 Level Range'),
(4632, 19, 1081225, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 12-25 Level Range'),
(4632, 20, 1081630, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 16-30 Level Range'),
(4632, 21, 1082035, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 20-35 Level Range'),
(4632, 22, 1092130, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 10-Slot');

-- Heavy Bronze Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4633);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4633, 1, 4633, 100, 0, 1, 0, 1, 1, 'Heavy Bronze Lockbox - Guaranteed Loot'),
(4633, 2, 4633, 25, 0, 1, 0, 1, 1, 'Heavy Bronze Lockbox - Bonus Loot 1'),
(4633, 3, 4633, 5, 0, 1, 0, 1, 1, 'Heavy Bronze Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4633);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4633, 1206, 0, 1, 0, 1, 1, 1, 1, 'Moss Agate'),
(4633, 1529, 0, 1, 0, 1, 1, 1, 1, 'Jade'),
(4633, 1705, 0, 3, 0, 1, 1, 1, 1, 'Lesser Moonstone'),
(4633, 1 , 1022226, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 22-26 Level Range'),
(4633, 2 , 1022327, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 23-27 Level Range'),
(4633, 3 , 1022428, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 24-28 Level Range'),
(4633, 4 , 1022529, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 25-29 Level Range'),
(4633, 5 , 1022630, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 26-30 Level Range'),
(4633, 6 , 1022731, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 27-31 Level Range'),
(4633, 7 , 1032528, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 25-28 Level Range'),
(4633, 8 , 1032629, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 26-29 Level Range'),
(4633, 9 , 1032730, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 27-30 Level Range'),
(4633, 10, 1032831, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 28-31 Level Range'),
(4633, 11, 1032932, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 29-32 Level Range'),
(4633, 12, 1081630, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 16-30 Level Range'),
(4633, 13, 1082035, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 20-35 Level Range'),
(4633, 14, 1082640, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 26-40 Level Range'),
(4633, 15, 1092130, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 10-Slot');

-- Iron Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4634);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4634, 1, 4634, 100, 0, 1, 0, 1, 1, 'Iron Lockbox - Guaranteed Loot'),
(4634, 2, 4634, 25, 0, 1, 0, 1, 1, 'Iron Lockbox - Bonus Loot 1'),
(4634, 3, 4634, 5, 0, 1, 0, 1, 1, 'Iron Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4634);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4634, 1529, 0, 1, 0, 1, 1, 1, 1, 'Jade'),
(4634, 1705, 0, 1, 0, 1, 1, 1, 1, 'Lesser Moonstone'),
(4634, 1725, 0, 5, 0, 1, 1, 1, 1, 'Large Knapsack'),
(4634, 3864, 0, 3, 0, 1, 1, 1, 1, 'Citrine'),
(4634, 4354, 0, 0.1, 0, 1, 1, 1, 1, 'Pattern: Rich Purple Silk Shirt'),
(4634, 1 , 1022832, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 28-32 Level Range'),
(4634, 2 , 1022933, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 29-33 Level Range'),
(4634, 3 , 1023034, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 30-34 Level Range'),
(4634, 4 , 1023135, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 31-35 Level Range'),
(4634, 5 , 1023236, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 32-36 Level Range'),
(4634, 6 , 1023337, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 33-37 Level Range'),
(4634, 7 , 1033134, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 31-34 Level Range'),
(4634, 8 , 1033235, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 32-35 Level Range'),
(4634, 9 , 1033336, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 33-36 Level Range'),
(4634, 10, 1033437, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 34-37 Level Range'),
(4634, 11, 1081630, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 16-30 Level Range'),
(4634, 12, 1082640, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 26-40 Level Range'),
(4634, 13, 1083045, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 30-45 Level Range');

-- Strong Iron Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4636);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4636, 1, 4636, 100, 0, 1, 0, 1, 1, 'Strong Iron Lockbox - Guaranteed Loot'),
(4636, 2, 4636, 25, 0, 1, 0, 1, 1, 'Strong Iron Lockbox - Bonus Loot 1'),
(4636, 3, 4636, 5, 0, 1, 0, 1, 1, 'Strong Iron Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4636);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4636, 1529, 0, 1, 0, 1, 1, 1, 1, 'Jade'),
(4636, 1725, 0, 5, 0, 1, 1, 1, 1, 'Large Knapsack'),
(4636, 3864, 0, 3, 0, 1, 1, 1, 1, 'Citrine'),
(4636, 4354, 0, 0.1, 0, 1, 1, 1, 1, 'Pattern: Rich Purple Silk Shirt'),
(4636, 7909, 0, 1, 0, 1, 1, 1, 1, 'Aquamarine'),
(4636, 1 , 1023236, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 32-36 Level Range'),
(4636, 2 , 1023337, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 33-37 Level Range'),
(4636, 3 , 1023438, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 34-38 Level Range'),
(4636, 4 , 1023539, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 35-39 Level Range'),
(4636, 5 , 1023640, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 36-40 Level Range'),
(4636, 6 , 1023741, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 37-41 Level Range'),
(4636, 7 , 1023842, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 38-42 Level Range'),
(4636, 8 , 1023943, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 39-43 Level Range'),
(4636, 9 , 1033538, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 35-38 Level Range'),
(4636, 10, 1033639, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 36-39 Level Range'),
(4636, 11, 1033740, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 37-40 Level Range'),
(4636, 12, 1033841, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 38-41 Level Range'),
(4636, 13, 1033942, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 39-42 Level Range'),
(4636, 14, 1082640, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 26-40 Level Range'),
(4636, 15, 1083045, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 30-45 Level Range'),
(4636, 16, 1083650, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 36-50 Level Range');

-- Steel Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4637);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4637, 1, 4637, 100, 0, 1, 0, 1, 1, 'Steel Lockbox - Guaranteed Loot'),
(4637, 2, 4637, 25, 0, 1, 0, 1, 1, 'Steel Lockbox - Bonus Loot 1'),
(4637, 3, 4637, 5, 0, 1, 0, 1, 1, 'Steel Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4637);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4637, 3864, 0, 1, 0, 1, 1, 1, 1, 'Citrine'),
(4637, 7909, 0, 3, 0, 1, 1, 1, 1, 'Aquamarine'),
(4637, 7910, 0, 1, 0, 1, 1, 1, 1, 'Star Ruby'),
(4637, 1 , 1023741, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 37-41 Level Range'),
(4637, 2 , 1023842, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 38-42 Level Range'),
(4637, 3 , 1023943, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 39-43 Level Range'),
(4637, 4 , 1024044, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 40-44 Level Range'),
(4637, 5 , 1024145, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 41-45 Level Range'),
(4637, 6 , 1024246, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 42-46 Level Range'),
(4637, 7 , 1034043, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 40-43 Level Range'),
(4637, 8 , 1034144, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 41-44 Level Range'),
(4637, 9 , 1034245, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 42-45 Level Range'),
(4637, 10, 1083045, 3.33, 0, 1, 0, 1, 1, 'Vanilla Patterns 30-45 Level Range'),
(4637, 11, 1083650, 3.33, 0, 1, 0, 1, 1, 'Vanilla Patterns 36-50 Level Range'),
(4637, 12, 1084055, 3.33, 0, 1, 0, 1, 1, 'Vanilla Patterns 40-55 Level Range'),
(4637, 13, 1094150, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 14-Slot');

-- Reinforced Steel Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 4638);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4638, 1, 4638, 100, 0, 1, 0, 1, 1, 'Reinforced Steel Lockbox - Guaranteed Loot'),
(4638, 2, 4638, 25, 0, 1, 0, 1, 1, 'Reinforced Steel Lockbox - Bonus Loot 1'),
(4638, 3, 4638, 5, 0, 1, 0, 1, 1, 'Reinforced Steel Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 4638);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4638, 7909, 0, 2.5, 0, 1, 1, 1, 1, 'Aquamarine'),
(4638, 7910, 0, 2.5, 0, 1, 1, 1, 1, 'Star Ruby'),
(4638, 1 , 1024347, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 43-47 Level Range'),
(4638, 2 , 1024448, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 44-48 Level Range'),
(4638, 3 , 1024549, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 45-49 Level Range'),
(4638, 4 , 1024650, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 46-50 Level Range'),
(4638, 5 , 1024751, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 47-51 Level Range'),
(4638, 6 , 1024852, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 48-52 Level Range'),
(4638, 7 , 1034548, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 45-48 Level Range'),
(4638, 8 , 1034649, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 46-49 Level Range'),
(4638, 9 , 1034750, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 47-50 Level Range'),
(4638, 10, 1034851, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 48-51 Level Range'),
(4638, 11, 1034952, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 49-52 Level Range'),
(4638, 12, 1083650, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 36-50 Level Range'),
(4638, 13, 1084055, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 40-55 Level Range'),
(4638, 14, 1084660, 3.33, 0, 1, 1, 1, 1, 'Vanilla Patterns 46-60 Level Range'),
(4638, 15, 1094150, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 14-Slot');

-- Mithril Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 5758);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5758, 1, 5758, 100, 0, 1, 0, 1, 1, 'Mithril Lockbox - Guaranteed Loot'),
(5758, 2, 5758, 25, 0, 1, 0, 1, 1, 'Mithril Lockbox - Bonus Loot 1'),
(5758, 3, 5758, 5, 0, 1, 0, 1, 1, 'Mithril Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 5758);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5758, 7909, 0, 2.5, 0, 1, 1, 1, 1, 'Aquamarine'),
(5758, 7910, 0, 2.5, 0, 1, 1, 1, 1, 'Star Ruby'),
(5758, 1 , 1024650, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 46-50 Level Range'),
(5758, 2 , 1024751, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 47-51 Level Range'),
(5758, 3 , 1024852, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 48-52 Level Range'),
(5758, 4 , 1024953, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 49-53 Level Range'),
(5758, 5 , 1025054, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 50-54 Level Range'),
(5758, 6 , 1025155, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 51-55 Level Range'),
(5758, 7 , 1025256, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 52-56 Level Range'),
(5758, 8 , 1025357, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 53-57 Level Range'),
(5758, 9 , 1035053, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 50-53 Level Range'),
(5758, 10, 1035154, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 51-54 Level Range'),
(5758, 11, 1035255, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 52-55 Level Range'),
(5758, 12, 1035356, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 53-56 Level Range'),
(5758, 13, 1035457, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 54-57 Level Range'),
(5758, 14, 1084055, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 40-55 Level Range'),
(5758, 15, 1084660, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 46-60 Level Range'),
(5758, 16, 1085063, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 50-63 Level Range'),
(5758, 17, 1085663, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 56-63 Level Range'),
(5758, 18, 1095162, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 14 and 16 Slots');

-- Thorium Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 5759);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5759, 1, 5759, 100, 0, 1, 0, 1, 1, 'Thorium Lockbox - Guaranteed Loot'),
(5759, 2, 5759, 25, 0, 1, 0, 1, 1, 'Thorium Lockbox - Bonus Loot 1'),
(5759, 3, 5759, 5, 0, 1, 0, 1, 1, 'Thorium Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 5759);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5759, 7909, 0, 2.5, 0, 1, 1, 1, 1, 'Aquamarine'),
(5759, 7910, 0, 2.5, 0, 1, 1, 1, 1, 'Star Ruby'),
(5759, 1 , 1025256, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 52-56 Level Range'),
(5759, 2 , 1025357, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 53-57 Level Range'),
(5759, 3 , 1025458, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 54-58 Level Range'),
(5759, 4 , 1025559, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 55-59 Level Range'),
(5759, 5 , 1025660, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 56-60 Level Range'),
(5759, 6 , 1025761, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 57-61 Level Range'),
(5759, 7 , 1035558, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 55-58 Level Range'),
(5759, 8 , 1035659, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 56-59 Level Range'),
(5759, 9 , 1035760, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 57-60 Level Range'),
(5759, 10, 1035861, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 58-61 Level Range'),
(5759, 11, 1035963, 0.5, 0, 1, 1, 1, 1, 'Vanilla Blues 59+ Level Range'),
(5759, 12, 1084055, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 40-55 Level Range'),
(5759, 13, 1084660, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 46-60 Level Range'),
(5759, 14, 1085063, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 50-63 Level Range'),
(5759, 15, 1085663, 2.5, 0, 1, 1, 1, 1, 'Vanilla Patterns 55-63 Level Range'),
(5759, 16, 1095162, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 14 and 16 Slots');

-- Eternium Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 5760);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5760, 1, 5760, 100, 0, 1, 0, 1, 1, 'Eternium Lockbox - Guaranteed Loot'),
(5760, 2, 5760, 25, 0, 1, 0, 1, 1, 'Eternium Lockbox - Bonus Loot 1'),
(5760, 3, 5760, 5, 0, 1, 0, 1, 1, 'Eternium Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 5760);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5760, 7909, 0, 2.5, 0, 1, 1, 1, 1, 'Aquamarine'),
(5760, 7910, 0, 2.5, 0, 1, 1, 1, 1, 'Star Ruby'),
(5760, 1 , 1025862, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 58-62 Level Range'),
(5760, 2 , 1025963, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 59-63 Level Range'),
(5760, 3 , 1026063, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 60-63 Level Range'),
(5760, 4 , 1026163, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 61-63 Level Range'),
(5760, 5 , 1026263, 0, 0, 1, 1, 1, 1, 'Vanilla Greens 62-63 Level Range'),
(5760, 6 , 1035760, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 57-60 Level Range'),
(5760, 7 , 1035861, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 58-61 Level Range'),
(5760, 8 , 1035963, 1, 0, 1, 1, 1, 1, 'Vanilla Blues 59+ Level Range'),
(5760, 9 , 1085063, 5, 0, 1, 1, 1, 1, 'Vanilla Patterns 50-63 Level Range'),
(5760, 10, 1085663, 5, 0, 1, 1, 1, 1, 'Vanilla Patterns 55-63 Level Range'),
(5760, 11, 1095162, 5, 0, 1, 1, 1, 1, 'Vanilla Bags 14 and 16 Slots');

-- Khorium Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 31952);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31952, 1, 31952, 100, 0, 1, 0, 1, 1, 'Khorium Lockbox - Guaranteed Loot'),
(31952, 2, 31952, 25, 0, 1, 0, 1, 1, 'Khorium Lockbox - Bonus Loot 1'),
(31952, 3, 31952, 5, 0, 1, 0, 1, 1, 'Khorium Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 31952);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31952, 1, 1126668, 0, 0, 1, 1, 1, 1, 'TBC Greens 66-68 Level Range'),
(31952, 2, 1126769, 0, 0, 1, 1, 1, 1, 'TBC Greens 67-69 Level Range'),
(31952, 3, 1126870, 0, 0, 1, 1, 1, 1, 'TBC Greens 68-70 Level Range'),
(31952, 4, 1136568, 1, 0, 1, 1, 1, 1, 'TBC Blues 65-68 Level Range'),
(31952, 5, 1136669, 1, 0, 1, 1, 1, 1, 'TBC Blues 66-69 Level Range'),
(31952, 6, 1136770, 1, 0, 1, 1, 1, 1, 'TBC Blues 67-70 Level Range');

-- Froststeel Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 43622);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(43622, 1, 43622, 100, 0, 1, 0, 1, 1, 'Froststeel Lockbox - Guaranteed Loot'),
(43622, 2, 43622, 25, 0, 1, 0, 1, 1, 'Froststeel Lockbox - Bonus Loot 1'),
(43622, 3, 43622, 5, 0, 1, 0, 1, 1, 'Froststeel Lockbox - Bonus Loot 2');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 43622);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(43622, 1, 1227173, 0, 0, 1, 1, 1, 1, 'WotLK Greens 71-73 Level Range'),
(43622, 2, 1227274, 0, 0, 1, 1, 1, 1, 'WotLK Greens 72-74 Level Range'),
(43622, 3, 1227375, 0, 0, 1, 1, 1, 1, 'WotLK Greens 73-75 Level Range'),
(43622, 4, 1237173, 1, 0, 1, 1, 1, 1, 'WotLK Blues 71-73 Level Range'),
(43622, 5, 1237274, 1, 0, 1, 1, 1, 1, 'WotLK Blues 72-74 Level Range'),
(43622, 6, 1237375, 1, 0, 1, 1, 1, 1, 'WotLK Blues 73-75 Level Range');

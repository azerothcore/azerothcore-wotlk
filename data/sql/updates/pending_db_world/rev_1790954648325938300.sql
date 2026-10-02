--
-- Normalize the world-drop loot of 57 open-world vanilla rare elites (issue #27900) onto the
-- "Loot Normalization" World Loot (GroupId 5) and Vanilla Greens (GroupId 6) references (#24398).
-- Up to level 25, GroupId 6 also holds the Vanilla Whites windows containing the creature's level, as normal rares do.

-- Remove the legacy 24xxx world-drop reference rows
DELETE FROM `creature_loot_template` WHERE `Reference` BETWEEN 24000 AND 24999 AND `Entry` IN (
    1838, 1839, 1841, 1843, 2447, 2754, 2931, 3270, 4339, 5785, 5797, 5798, 5799, 5800, 5822, 5824, 5827, 5828, 5830,
    5831, 5841, 5842, 5851, 5859, 5864, 5915, 5916, 5930, 5931, 5932, 5934, 5937, 6584, 6646, 7104, 7137, 8199, 8200,
    8215, 8217, 8282, 8976, 10196, 10198, 10201, 10202, 10828, 11383, 13896, 14267, 14275, 14445, 14471, 14473, 14474,
    14475, 16184);

-- Remove the generic world-drop item rows (items listed in the Loot Normalization reference tables), as in #24398
DELETE FROM `creature_loot_template` WHERE `Reference` = 0 AND `QuestRequired` = 0 AND `Entry` IN (
    1838, 1839, 1841, 1843, 2447, 2754, 2931, 3270, 4339, 5785, 5797, 5798, 5799, 5800, 5822, 5824, 5827, 5828, 5830,
    5831, 5841, 5842, 5851, 5859, 5864, 5915, 5916, 5930, 5931, 5932, 5934, 5937, 6584, 6646, 7104, 7137, 8199, 8200,
    8215, 8217, 8282, 8976, 10196, 10198, 10201, 10202, 10828, 11383, 13896, 14267, 14275, 14445, 14471, 14473, 14474,
    14475, 16184)
AND `Item` IN (
    118, 774, 804, 818, 856, 857, 858, 929, 954, 955, 1180, 1181, 1206, 1210, 1478, 1529, 1705, 1711, 1712, 1725, 2290,
    2406, 2407, 2408, 2409, 2455, 2553, 2555, 2598, 2601, 2657, 2883, 3012, 3013, 3279, 3281, 3284, 3285, 3286, 3289,
    3290, 3303, 3304, 3312, 3385, 3396, 3608, 3609, 3610, 3644, 3649, 3827, 3864, 3868, 3870, 3914, 3928, 4292, 4293,
    4294, 4296, 4345, 4346, 4347, 4348, 4349, 4408, 4409, 4410, 4412, 4419, 4421, 4422, 4424, 4425, 4426, 4500, 4632,
    4633, 4634, 4637, 4638, 4669, 4672, 4675, 4680, 4681, 4686, 4687, 4692, 4693, 4698, 4700, 5573, 5574, 5575, 5576,
    5578, 5758, 5759, 5760, 5972, 5974, 6044, 6149, 6271, 6342, 6344, 6347, 6348, 6375, 6391, 6506, 6507, 6509, 6510,
    6513, 6514, 6515, 6517, 6518, 6519, 6521, 6549, 6555, 6566, 6579, 6588, 6663, 6716, 7091, 7092, 7288, 7350, 7351,
    7360, 7449, 7909, 7910, 7975, 7989, 7990, 8028, 8390, 9293, 9742, 9743, 9744, 9745, 9746, 9750, 9751, 9752, 9754,
    9755, 9758, 9759, 9760, 9761, 9762, 10300, 10305, 10306, 10307, 10308, 10309, 10310, 10312, 10316, 10320, 10405,
    10407, 10606, 11038, 11039, 11098, 11225, 12683, 12689, 12691, 12693, 12695, 13443, 13444, 13446, 13490, 13492,
    14086, 14089, 14095, 14098, 14099, 14102, 14110, 14115, 14116, 14126, 14157, 14169, 14368, 14466, 14470, 14474,
    14489, 14491, 14494, 14498, 14499, 14506, 14508, 15008, 15013, 15015, 15019, 15297, 15299, 15300, 15301, 15302,
    15313, 15473, 15476, 15480, 15481, 15482, 15483, 15484, 15490, 15496, 15505, 15731, 15743, 15746, 15755, 15757,
    15765, 16043, 16218, 16220, 16245, 16251, 19272);

-- Scarlet Interrogator
DELETE FROM `creature_loot_template` WHERE `Entry` = 1838 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1838, 1, 1000361, 0, 0, 1, 5, 1, 1, 'Scarlet Interrogator - World Loot Level 61'),
(1838, 2, 1025761, 0, 0, 1, 6, 1, 1, 'Scarlet Interrogator - Vanilla Greens 57-61 Level Range'),
(1838, 3, 1025862, 0, 0, 1, 6, 1, 1, 'Scarlet Interrogator - Vanilla Greens 58-62 Level Range'),
(1838, 4, 1025963, 0, 0, 1, 6, 1, 1, 'Scarlet Interrogator - Vanilla Greens 59-63 Level Range'),
(1838, 5, 1026063, 0, 0, 1, 6, 1, 1, 'Scarlet Interrogator - Vanilla Greens 60-63 Level Range'),
(1838, 6, 1026163, 0, 0, 1, 6, 1, 1, 'Scarlet Interrogator - Vanilla Greens 61-63 Level Range');

-- Scarlet High Clerist
DELETE FROM `creature_loot_template` WHERE `Entry` = 1839 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1839, 1, 1000363, 0, 0, 1, 5, 1, 1, 'Scarlet High Clerist - World Loot Level 63'),
(1839, 2, 1025963, 0, 0, 1, 6, 1, 1, 'Scarlet High Clerist - Vanilla Greens 59-63 Level Range'),
(1839, 3, 1026063, 0, 0, 1, 6, 1, 1, 'Scarlet High Clerist - Vanilla Greens 60-63 Level Range'),
(1839, 4, 1026163, 0, 0, 1, 6, 1, 1, 'Scarlet High Clerist - Vanilla Greens 61-63 Level Range'),
(1839, 5, 1026263, 0, 0, 1, 6, 1, 1, 'Scarlet High Clerist - Vanilla Greens 62-63 Level Range');

-- Scarlet Executioner
DELETE FROM `creature_loot_template` WHERE `Entry` = 1841 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1841, 1, 1000360, 0, 0, 1, 5, 1, 1, 'Scarlet Executioner - World Loot Level 60'),
(1841, 2, 1025660, 0, 0, 1, 6, 1, 1, 'Scarlet Executioner - Vanilla Greens 56-60 Level Range'),
(1841, 3, 1025761, 0, 0, 1, 6, 1, 1, 'Scarlet Executioner - Vanilla Greens 57-61 Level Range'),
(1841, 4, 1025862, 0, 0, 1, 6, 1, 1, 'Scarlet Executioner - Vanilla Greens 58-62 Level Range'),
(1841, 5, 1025963, 0, 0, 1, 6, 1, 1, 'Scarlet Executioner - Vanilla Greens 59-63 Level Range'),
(1841, 6, 1026063, 0, 0, 1, 6, 1, 1, 'Scarlet Executioner - Vanilla Greens 60-63 Level Range');

-- Foreman Jerris
DELETE FROM `creature_loot_template` WHERE `Entry` = 1843 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1843, 1, 1000362, 0, 0, 1, 5, 1, 1, 'Foreman Jerris - World Loot Level 62'),
(1843, 2, 1025862, 0, 0, 1, 6, 1, 1, 'Foreman Jerris - Vanilla Greens 58-62 Level Range'),
(1843, 3, 1025963, 0, 0, 1, 6, 1, 1, 'Foreman Jerris - Vanilla Greens 59-63 Level Range'),
(1843, 4, 1026063, 0, 0, 1, 6, 1, 1, 'Foreman Jerris - Vanilla Greens 60-63 Level Range'),
(1843, 5, 1026163, 0, 0, 1, 6, 1, 1, 'Foreman Jerris - Vanilla Greens 61-63 Level Range'),
(1843, 6, 1026263, 0, 0, 1, 6, 1, 1, 'Foreman Jerris - Vanilla Greens 62-63 Level Range');

-- Narillasanz
DELETE FROM `creature_loot_template` WHERE `Entry` = 2447 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2447, 1, 1000344, 0, 0, 1, 5, 1, 1, 'Narillasanz - World Loot Level 44'),
(2447, 2, 1024044, 0, 0, 1, 6, 1, 1, 'Narillasanz - Vanilla Greens 40-44 Level Range'),
(2447, 3, 1024145, 0, 0, 1, 6, 1, 1, 'Narillasanz - Vanilla Greens 41-45 Level Range'),
(2447, 4, 1024246, 0, 0, 1, 6, 1, 1, 'Narillasanz - Vanilla Greens 42-46 Level Range'),
(2447, 5, 1024347, 0, 0, 1, 6, 1, 1, 'Narillasanz - Vanilla Greens 43-47 Level Range'),
(2447, 6, 1024448, 0, 0, 1, 6, 1, 1, 'Narillasanz - Vanilla Greens 44-48 Level Range');

-- Anathemus
DELETE FROM `creature_loot_template` WHERE `Entry` = 2754 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2754, 1, 1000245, 0, 0, 1, 5, 1, 1, 'Anathemus - World Loot Level 45'),
(2754, 2, 1024145, 0, 0, 1, 6, 1, 1, 'Anathemus - Vanilla Greens 41-45 Level Range'),
(2754, 3, 1024246, 0, 0, 1, 6, 1, 1, 'Anathemus - Vanilla Greens 42-46 Level Range'),
(2754, 4, 1024347, 0, 0, 1, 6, 1, 1, 'Anathemus - Vanilla Greens 43-47 Level Range'),
(2754, 5, 1024448, 0, 0, 1, 6, 1, 1, 'Anathemus - Vanilla Greens 44-48 Level Range'),
(2754, 6, 1024549, 0, 0, 1, 6, 1, 1, 'Anathemus - Vanilla Greens 45-49 Level Range');

-- Zaricotl
DELETE FROM `creature_loot_template` WHERE `Entry` = 2931 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2931, 1, 1000255, 0, 0, 1, 5, 1, 1, 'Zaricotl - World Loot Level 55'),
(2931, 2, 1025155, 0, 0, 1, 6, 1, 1, 'Zaricotl - Vanilla Greens 51-55 Level Range'),
(2931, 3, 1025256, 0, 0, 1, 6, 1, 1, 'Zaricotl - Vanilla Greens 52-56 Level Range'),
(2931, 4, 1025357, 0, 0, 1, 6, 1, 1, 'Zaricotl - Vanilla Greens 53-57 Level Range'),
(2931, 5, 1025458, 0, 0, 1, 6, 1, 1, 'Zaricotl - Vanilla Greens 54-58 Level Range'),
(2931, 6, 1025559, 0, 0, 1, 6, 1, 1, 'Zaricotl - Vanilla Greens 55-59 Level Range');

-- Elder Mystic Razorsnout
DELETE FROM `creature_loot_template` WHERE `Entry` = 3270 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3270, 1, 1000315, 0, 0, 1, 5, 1, 1, 'Elder Mystic Razorsnout - World Loot Level 15'),
(3270, 2, 1011415, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Whites 14-15 Level Range'),
(3270, 3, 1021115, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Greens 11-15 Level Range'),
(3270, 4, 1021216, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Greens 12-16 Level Range'),
(3270, 5, 1021317, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Greens 13-17 Level Range'),
(3270, 6, 1021418, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Greens 14-18 Level Range'),
(3270, 7, 1021519, 0, 0, 1, 6, 1, 1, 'Elder Mystic Razorsnout - Vanilla Greens 15-19 Level Range');

-- Brimgore
DELETE FROM `creature_loot_template` WHERE `Entry` = 4339 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4339, 1, 1000141, 0, 0, 1, 5, 1, 1, 'Brimgore - World Loot Level 41'),
(4339, 2, 1023741, 0, 0, 1, 6, 1, 1, 'Brimgore - Vanilla Greens 37-41 Level Range'),
(4339, 3, 1023842, 0, 0, 1, 6, 1, 1, 'Brimgore - Vanilla Greens 38-42 Level Range'),
(4339, 4, 1023943, 0, 0, 1, 6, 1, 1, 'Brimgore - Vanilla Greens 39-43 Level Range'),
(4339, 5, 1024044, 0, 0, 1, 6, 1, 1, 'Brimgore - Vanilla Greens 40-44 Level Range'),
(4339, 6, 1024145, 0, 0, 1, 6, 1, 1, 'Brimgore - Vanilla Greens 41-45 Level Range');

-- Sister Hatelash
DELETE FROM `creature_loot_template` WHERE `Entry` = 5785 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5785, 1, 1000111, 0, 0, 1, 5, 1, 1, 'Sister Hatelash - World Loot Level 11'),
(5785, 2, 1011011, 0, 0, 1, 6, 1, 1, 'Sister Hatelash - Vanilla Whites 10-11 Level Range'),
(5785, 3, 1011112, 0, 0, 1, 6, 1, 1, 'Sister Hatelash - Vanilla Whites 11-12 Level Range'),
(5785, 4, 1020812, 0, 0, 1, 6, 1, 1, 'Sister Hatelash - Vanilla Greens 8-12 Level Range'),
(5785, 5, 1021014, 0, 0, 1, 6, 1, 1, 'Sister Hatelash - Vanilla Greens 10-14 Level Range'),
(5785, 6, 1021115, 0, 0, 1, 6, 1, 1, 'Sister Hatelash - Vanilla Greens 11-15 Level Range');

-- Aean Swiftriver
DELETE FROM `creature_loot_template` WHERE `Entry` = 5797 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5797, 1, 1000322, 0, 0, 1, 5, 1, 1, 'Aean Swiftriver - World Loot Level 22'),
(5797, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Whites 18-22 Level Range'),
(5797, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Whites 19-23 Level Range'),
(5797, 4, 1012024, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Whites 20-24 Level Range'),
(5797, 5, 1012125, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Whites 21-25 Level Range'),
(5797, 6, 1021822, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Greens 18-22 Level Range'),
(5797, 7, 1021923, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Greens 19-23 Level Range'),
(5797, 8, 1022024, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Greens 20-24 Level Range'),
(5797, 9, 1022125, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Greens 21-25 Level Range'),
(5797, 10, 1022226, 0, 0, 1, 6, 1, 1, 'Aean Swiftriver - Vanilla Greens 22-26 Level Range');

-- Thora Feathermoon
DELETE FROM `creature_loot_template` WHERE `Entry` = 5798 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5798, 1, 1000325, 0, 0, 1, 5, 1, 1, 'Thora Feathermoon - World Loot Level 25'),
(5798, 2, 1012125, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Whites 21-25 Level Range'),
(5798, 3, 1022125, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Greens 21-25 Level Range'),
(5798, 4, 1022226, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Greens 22-26 Level Range'),
(5798, 5, 1022327, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Greens 23-27 Level Range'),
(5798, 6, 1022428, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Greens 24-28 Level Range'),
(5798, 7, 1022529, 0, 0, 1, 6, 1, 1, 'Thora Feathermoon - Vanilla Greens 25-29 Level Range');

-- Hannah Bladeleaf
DELETE FROM `creature_loot_template` WHERE `Entry` = 5799 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5799, 1, 1000324, 0, 0, 1, 5, 1, 1, 'Hannah Bladeleaf - World Loot Level 24'),
(5799, 2, 1012024, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Whites 20-24 Level Range'),
(5799, 3, 1012125, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Whites 21-25 Level Range'),
(5799, 4, 1022024, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Greens 20-24 Level Range'),
(5799, 5, 1022125, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Greens 21-25 Level Range'),
(5799, 6, 1022226, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Greens 22-26 Level Range'),
(5799, 7, 1022327, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Greens 23-27 Level Range'),
(5799, 8, 1022428, 0, 0, 1, 6, 1, 1, 'Hannah Bladeleaf - Vanilla Greens 24-28 Level Range');

-- Marcus Bel
DELETE FROM `creature_loot_template` WHERE `Entry` = 5800 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5800, 1, 1000322, 0, 0, 1, 5, 1, 1, 'Marcus Bel - World Loot Level 22'),
(5800, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Whites 18-22 Level Range'),
(5800, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Whites 19-23 Level Range'),
(5800, 4, 1012024, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Whites 20-24 Level Range'),
(5800, 5, 1012125, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Whites 21-25 Level Range'),
(5800, 6, 1021822, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Greens 18-22 Level Range'),
(5800, 7, 1021923, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Greens 19-23 Level Range'),
(5800, 8, 1022024, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Greens 20-24 Level Range'),
(5800, 9, 1022125, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Greens 21-25 Level Range'),
(5800, 10, 1022226, 0, 0, 1, 6, 1, 1, 'Marcus Bel - Vanilla Greens 22-26 Level Range');

-- Felweaver Scornn
DELETE FROM `creature_loot_template` WHERE `Entry` = 5822 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5822, 1, 1000111, 0, 0, 1, 5, 1, 1, 'Felweaver Scornn - World Loot Level 11'),
(5822, 2, 1011011, 0, 0, 1, 6, 1, 1, 'Felweaver Scornn - Vanilla Whites 10-11 Level Range'),
(5822, 3, 1011112, 0, 0, 1, 6, 1, 1, 'Felweaver Scornn - Vanilla Whites 11-12 Level Range'),
(5822, 4, 1020812, 0, 0, 1, 6, 1, 1, 'Felweaver Scornn - Vanilla Greens 8-12 Level Range'),
(5822, 5, 1021014, 0, 0, 1, 6, 1, 1, 'Felweaver Scornn - Vanilla Greens 10-14 Level Range'),
(5822, 6, 1021115, 0, 0, 1, 6, 1, 1, 'Felweaver Scornn - Vanilla Greens 11-15 Level Range');

-- Captain Flat Tusk
DELETE FROM `creature_loot_template` WHERE `Entry` = 5824 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5824, 1, 1000111, 0, 0, 1, 5, 1, 1, 'Captain Flat Tusk - World Loot Level 11'),
(5824, 2, 1011011, 0, 0, 1, 6, 1, 1, 'Captain Flat Tusk - Vanilla Whites 10-11 Level Range'),
(5824, 3, 1011112, 0, 0, 1, 6, 1, 1, 'Captain Flat Tusk - Vanilla Whites 11-12 Level Range'),
(5824, 4, 1020812, 0, 0, 1, 6, 1, 1, 'Captain Flat Tusk - Vanilla Greens 8-12 Level Range'),
(5824, 5, 1021014, 0, 0, 1, 6, 1, 1, 'Captain Flat Tusk - Vanilla Greens 10-14 Level Range'),
(5824, 6, 1021115, 0, 0, 1, 6, 1, 1, 'Captain Flat Tusk - Vanilla Greens 11-15 Level Range');

-- Brontus
DELETE FROM `creature_loot_template` WHERE `Entry` = 5827 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5827, 1, 1000227, 0, 0, 1, 5, 1, 1, 'Brontus - World Loot Level 27'),
(5827, 2, 1022327, 0, 0, 1, 6, 1, 1, 'Brontus - Vanilla Greens 23-27 Level Range'),
(5827, 3, 1022428, 0, 0, 1, 6, 1, 1, 'Brontus - Vanilla Greens 24-28 Level Range'),
(5827, 4, 1022529, 0, 0, 1, 6, 1, 1, 'Brontus - Vanilla Greens 25-29 Level Range'),
(5827, 5, 1022630, 0, 0, 1, 6, 1, 1, 'Brontus - Vanilla Greens 26-30 Level Range'),
(5827, 6, 1022731, 0, 0, 1, 6, 1, 1, 'Brontus - Vanilla Greens 27-31 Level Range');

-- Humar the Pridelord
DELETE FROM `creature_loot_template` WHERE `Entry` = 5828 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5828, 1, 1000223, 0, 0, 1, 5, 1, 1, 'Humar the Pridelord - World Loot Level 23'),
(5828, 2, 1011923, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Whites 19-23 Level Range'),
(5828, 3, 1012024, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Whites 20-24 Level Range'),
(5828, 4, 1012125, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Whites 21-25 Level Range'),
(5828, 5, 1021923, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Greens 19-23 Level Range'),
(5828, 6, 1022024, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Greens 20-24 Level Range'),
(5828, 7, 1022125, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Greens 21-25 Level Range'),
(5828, 8, 1022226, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Greens 22-26 Level Range'),
(5828, 9, 1022327, 0, 0, 1, 6, 1, 1, 'Humar the Pridelord - Vanilla Greens 23-27 Level Range');

-- Sister Rathtalon
DELETE FROM `creature_loot_template` WHERE `Entry` = 5830 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5830, 1, 1000319, 0, 0, 1, 5, 1, 1, 'Sister Rathtalon - World Loot Level 19'),
(5830, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Whites 18-22 Level Range'),
(5830, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Whites 19-23 Level Range'),
(5830, 4, 1021519, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Greens 15-19 Level Range'),
(5830, 5, 1021620, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Greens 16-20 Level Range'),
(5830, 6, 1021721, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Greens 17-21 Level Range'),
(5830, 7, 1021822, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Greens 18-22 Level Range'),
(5830, 8, 1021923, 0, 0, 1, 6, 1, 1, 'Sister Rathtalon - Vanilla Greens 19-23 Level Range');

-- Swiftmane
DELETE FROM `creature_loot_template` WHERE `Entry` = 5831 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5831, 1, 1000221, 0, 0, 1, 5, 1, 1, 'Swiftmane - World Loot Level 21'),
(5831, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Whites 18-22 Level Range'),
(5831, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Whites 19-23 Level Range'),
(5831, 4, 1012024, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Whites 20-24 Level Range'),
(5831, 5, 1012125, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Whites 21-25 Level Range'),
(5831, 6, 1021721, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Greens 17-21 Level Range'),
(5831, 7, 1021822, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Greens 18-22 Level Range'),
(5831, 8, 1021923, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Greens 19-23 Level Range'),
(5831, 9, 1022024, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Greens 20-24 Level Range'),
(5831, 10, 1022125, 0, 0, 1, 6, 1, 1, 'Swiftmane - Vanilla Greens 21-25 Level Range');

-- Rocklance
DELETE FROM `creature_loot_template` WHERE `Entry` = 5841 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5841, 1, 1000317, 0, 0, 1, 5, 1, 1, 'Rocklance - World Loot Level 17'),
(5841, 2, 1021317, 0, 0, 1, 6, 1, 1, 'Rocklance - Vanilla Greens 13-17 Level Range'),
(5841, 3, 1021418, 0, 0, 1, 6, 1, 1, 'Rocklance - Vanilla Greens 14-18 Level Range'),
(5841, 4, 1021519, 0, 0, 1, 6, 1, 1, 'Rocklance - Vanilla Greens 15-19 Level Range'),
(5841, 5, 1021620, 0, 0, 1, 6, 1, 1, 'Rocklance - Vanilla Greens 16-20 Level Range'),
(5841, 6, 1021721, 0, 0, 1, 6, 1, 1, 'Rocklance - Vanilla Greens 17-21 Level Range');

-- Takk the Leaper
DELETE FROM `creature_loot_template` WHERE `Entry` = 5842 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5842, 1, 1000219, 0, 0, 1, 5, 1, 1, 'Takk the Leaper - World Loot Level 19'),
(5842, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Whites 18-22 Level Range'),
(5842, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Whites 19-23 Level Range'),
(5842, 4, 1021519, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Greens 15-19 Level Range'),
(5842, 5, 1021620, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Greens 16-20 Level Range'),
(5842, 6, 1021721, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Greens 17-21 Level Range'),
(5842, 7, 1021822, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Greens 18-22 Level Range'),
(5842, 8, 1021923, 0, 0, 1, 6, 1, 1, 'Takk the Leaper - Vanilla Greens 19-23 Level Range');

-- Captain Gerogg Hammertoe
DELETE FROM `creature_loot_template` WHERE `Entry` = 5851 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5851, 1, 1000327, 0, 0, 1, 5, 1, 1, 'Captain Gerogg Hammertoe - World Loot Level 27'),
(5851, 2, 1022327, 0, 0, 1, 6, 1, 1, 'Captain Gerogg Hammertoe - Vanilla Greens 23-27 Level Range'),
(5851, 3, 1022428, 0, 0, 1, 6, 1, 1, 'Captain Gerogg Hammertoe - Vanilla Greens 24-28 Level Range'),
(5851, 4, 1022529, 0, 0, 1, 6, 1, 1, 'Captain Gerogg Hammertoe - Vanilla Greens 25-29 Level Range'),
(5851, 5, 1022630, 0, 0, 1, 6, 1, 1, 'Captain Gerogg Hammertoe - Vanilla Greens 26-30 Level Range'),
(5851, 6, 1022731, 0, 0, 1, 6, 1, 1, 'Captain Gerogg Hammertoe - Vanilla Greens 27-31 Level Range');

-- Hagg Taurenbane
DELETE FROM `creature_loot_template` WHERE `Entry` = 5859 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5859, 1, 1000326, 0, 0, 1, 5, 1, 1, 'Hagg Taurenbane - World Loot Level 26'),
(5859, 2, 1022226, 0, 0, 1, 6, 1, 1, 'Hagg Taurenbane - Vanilla Greens 22-26 Level Range'),
(5859, 3, 1022327, 0, 0, 1, 6, 1, 1, 'Hagg Taurenbane - Vanilla Greens 23-27 Level Range'),
(5859, 4, 1022428, 0, 0, 1, 6, 1, 1, 'Hagg Taurenbane - Vanilla Greens 24-28 Level Range'),
(5859, 5, 1022529, 0, 0, 1, 6, 1, 1, 'Hagg Taurenbane - Vanilla Greens 25-29 Level Range'),
(5859, 6, 1022630, 0, 0, 1, 6, 1, 1, 'Hagg Taurenbane - Vanilla Greens 26-30 Level Range');

-- Swinegart Spearhide
DELETE FROM `creature_loot_template` WHERE `Entry` = 5864 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5864, 1, 1000322, 0, 0, 1, 5, 1, 1, 'Swinegart Spearhide - World Loot Level 22'),
(5864, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Whites 18-22 Level Range'),
(5864, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Whites 19-23 Level Range'),
(5864, 4, 1012024, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Whites 20-24 Level Range'),
(5864, 5, 1012125, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Whites 21-25 Level Range'),
(5864, 6, 1021822, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Greens 18-22 Level Range'),
(5864, 7, 1021923, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Greens 19-23 Level Range'),
(5864, 8, 1022024, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Greens 20-24 Level Range'),
(5864, 9, 1022125, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Greens 21-25 Level Range'),
(5864, 10, 1022226, 0, 0, 1, 6, 1, 1, 'Swinegart Spearhide - Vanilla Greens 22-26 Level Range');

-- Brother Ravenoak
DELETE FROM `creature_loot_template` WHERE `Entry` = 5915 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5915, 1, 1000129, 0, 0, 1, 5, 1, 1, 'Brother Ravenoak - World Loot Level 29'),
(5915, 2, 1022529, 0, 0, 1, 6, 1, 1, 'Brother Ravenoak - Vanilla Greens 25-29 Level Range'),
(5915, 3, 1022630, 0, 0, 1, 6, 1, 1, 'Brother Ravenoak - Vanilla Greens 26-30 Level Range'),
(5915, 4, 1022731, 0, 0, 1, 6, 1, 1, 'Brother Ravenoak - Vanilla Greens 27-31 Level Range'),
(5915, 5, 1022832, 0, 0, 1, 6, 1, 1, 'Brother Ravenoak - Vanilla Greens 28-32 Level Range'),
(5915, 6, 1022933, 0, 0, 1, 6, 1, 1, 'Brother Ravenoak - Vanilla Greens 29-33 Level Range');

-- Sentinel Amarassan
DELETE FROM `creature_loot_template` WHERE `Entry` = 5916 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5916, 1, 1000327, 0, 0, 1, 5, 1, 1, 'Sentinel Amarassan - World Loot Level 27'),
(5916, 2, 1022327, 0, 0, 1, 6, 1, 1, 'Sentinel Amarassan - Vanilla Greens 23-27 Level Range'),
(5916, 3, 1022428, 0, 0, 1, 6, 1, 1, 'Sentinel Amarassan - Vanilla Greens 24-28 Level Range'),
(5916, 4, 1022529, 0, 0, 1, 6, 1, 1, 'Sentinel Amarassan - Vanilla Greens 25-29 Level Range'),
(5916, 5, 1022630, 0, 0, 1, 6, 1, 1, 'Sentinel Amarassan - Vanilla Greens 26-30 Level Range'),
(5916, 6, 1022731, 0, 0, 1, 6, 1, 1, 'Sentinel Amarassan - Vanilla Greens 27-31 Level Range');

-- Sister Riven
DELETE FROM `creature_loot_template` WHERE `Entry` = 5930 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5930, 1, 1000328, 0, 0, 1, 5, 1, 1, 'Sister Riven - World Loot Level 28'),
(5930, 2, 1022428, 0, 0, 1, 6, 1, 1, 'Sister Riven - Vanilla Greens 24-28 Level Range'),
(5930, 3, 1022529, 0, 0, 1, 6, 1, 1, 'Sister Riven - Vanilla Greens 25-29 Level Range'),
(5930, 4, 1022630, 0, 0, 1, 6, 1, 1, 'Sister Riven - Vanilla Greens 26-30 Level Range'),
(5930, 5, 1022731, 0, 0, 1, 6, 1, 1, 'Sister Riven - Vanilla Greens 27-31 Level Range'),
(5930, 6, 1022832, 0, 0, 1, 6, 1, 1, 'Sister Riven - Vanilla Greens 28-32 Level Range');

-- Foreman Rigger
DELETE FROM `creature_loot_template` WHERE `Entry` = 5931 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5931, 1, 1000324, 0, 0, 1, 5, 1, 1, 'Foreman Rigger - World Loot Level 24'),
(5931, 2, 1012024, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Whites 20-24 Level Range'),
(5931, 3, 1012125, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Whites 21-25 Level Range'),
(5931, 4, 1022024, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Greens 20-24 Level Range'),
(5931, 5, 1022125, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Greens 21-25 Level Range'),
(5931, 6, 1022226, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Greens 22-26 Level Range'),
(5931, 7, 1022327, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Greens 23-27 Level Range'),
(5931, 8, 1022428, 0, 0, 1, 6, 1, 1, 'Foreman Rigger - Vanilla Greens 24-28 Level Range');

-- Taskmaster Whipfang
DELETE FROM `creature_loot_template` WHERE `Entry` = 5932 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5932, 1, 1000322, 0, 0, 1, 5, 1, 1, 'Taskmaster Whipfang - World Loot Level 22'),
(5932, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Whites 18-22 Level Range'),
(5932, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Whites 19-23 Level Range'),
(5932, 4, 1012024, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Whites 20-24 Level Range'),
(5932, 5, 1012125, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Whites 21-25 Level Range'),
(5932, 6, 1021822, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Greens 18-22 Level Range'),
(5932, 7, 1021923, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Greens 19-23 Level Range'),
(5932, 8, 1022024, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Greens 20-24 Level Range'),
(5932, 9, 1022125, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Greens 21-25 Level Range'),
(5932, 10, 1022226, 0, 0, 1, 6, 1, 1, 'Taskmaster Whipfang - Vanilla Greens 22-26 Level Range');

-- Heartrazor
DELETE FROM `creature_loot_template` WHERE `Entry` = 5934 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5934, 1, 1000032, 0, 0, 1, 5, 1, 1, 'Heartrazor - World Loot Level 32'),
(5934, 2, 1022832, 0, 0, 1, 6, 1, 1, 'Heartrazor - Vanilla Greens 28-32 Level Range'),
(5934, 3, 1022933, 0, 0, 1, 6, 1, 1, 'Heartrazor - Vanilla Greens 29-33 Level Range'),
(5934, 4, 1023034, 0, 0, 1, 6, 1, 1, 'Heartrazor - Vanilla Greens 30-34 Level Range'),
(5934, 5, 1023135, 0, 0, 1, 6, 1, 1, 'Heartrazor - Vanilla Greens 31-35 Level Range'),
(5934, 6, 1023236, 0, 0, 1, 6, 1, 1, 'Heartrazor - Vanilla Greens 32-36 Level Range');

-- Vile Sting
DELETE FROM `creature_loot_template` WHERE `Entry` = 5937 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5937, 1, 1000035, 0, 0, 1, 5, 1, 1, 'Vile Sting - World Loot Level 35'),
(5937, 2, 1023135, 0, 0, 1, 6, 1, 1, 'Vile Sting - Vanilla Greens 31-35 Level Range'),
(5937, 3, 1023236, 0, 0, 1, 6, 1, 1, 'Vile Sting - Vanilla Greens 32-36 Level Range'),
(5937, 4, 1023337, 0, 0, 1, 6, 1, 1, 'Vile Sting - Vanilla Greens 33-37 Level Range'),
(5937, 5, 1023438, 0, 0, 1, 6, 1, 1, 'Vile Sting - Vanilla Greens 34-38 Level Range'),
(5937, 6, 1023539, 0, 0, 1, 6, 1, 1, 'Vile Sting - Vanilla Greens 35-39 Level Range');

-- King Mosh
DELETE FROM `creature_loot_template` WHERE `Entry` = 6584 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6584, 1, 1000260, 0, 0, 1, 5, 1, 1, 'King Mosh - World Loot Level 60'),
(6584, 2, 1025660, 0, 0, 1, 6, 1, 1, 'King Mosh - Vanilla Greens 56-60 Level Range'),
(6584, 3, 1025761, 0, 0, 1, 6, 1, 1, 'King Mosh - Vanilla Greens 57-61 Level Range'),
(6584, 4, 1025862, 0, 0, 1, 6, 1, 1, 'King Mosh - Vanilla Greens 58-62 Level Range'),
(6584, 5, 1025963, 0, 0, 1, 6, 1, 1, 'King Mosh - Vanilla Greens 59-63 Level Range'),
(6584, 6, 1026063, 0, 0, 1, 6, 1, 1, 'King Mosh - Vanilla Greens 60-63 Level Range');

-- Monnos the Elder
DELETE FROM `creature_loot_template` WHERE `Entry` = 6646 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6646, 1, 1000253, 0, 0, 1, 5, 1, 1, 'Monnos the Elder - World Loot Level 53'),
(6646, 2, 1000254, 0, 0, 1, 5, 1, 1, 'Monnos the Elder - World Loot Level 54'),
(6646, 3, 1024953, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 49-53 Level Range'),
(6646, 4, 1025054, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 50-54 Level Range'),
(6646, 5, 1025155, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 51-55 Level Range'),
(6646, 6, 1025256, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 52-56 Level Range'),
(6646, 7, 1025357, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 53-57 Level Range'),
(6646, 8, 1025458, 0, 0, 1, 6, 1, 1, 'Monnos the Elder - Vanilla Greens 54-58 Level Range');

-- Dessecus
DELETE FROM `creature_loot_template` WHERE `Entry` = 7104 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7104, 1, 1000256, 0, 0, 1, 5, 1, 1, 'Dessecus - World Loot Level 56'),
(7104, 2, 1025256, 0, 0, 1, 6, 1, 1, 'Dessecus - Vanilla Greens 52-56 Level Range'),
(7104, 3, 1025357, 0, 0, 1, 6, 1, 1, 'Dessecus - Vanilla Greens 53-57 Level Range'),
(7104, 4, 1025458, 0, 0, 1, 6, 1, 1, 'Dessecus - Vanilla Greens 54-58 Level Range'),
(7104, 5, 1025559, 0, 0, 1, 6, 1, 1, 'Dessecus - Vanilla Greens 55-59 Level Range'),
(7104, 6, 1025660, 0, 0, 1, 6, 1, 1, 'Dessecus - Vanilla Greens 56-60 Level Range');

-- Immolatus
DELETE FROM `creature_loot_template` WHERE `Entry` = 7137 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7137, 1, 1000356, 0, 0, 1, 5, 1, 1, 'Immolatus - World Loot Level 56'),
(7137, 2, 1025256, 0, 0, 1, 6, 1, 1, 'Immolatus - Vanilla Greens 52-56 Level Range'),
(7137, 3, 1025357, 0, 0, 1, 6, 1, 1, 'Immolatus - Vanilla Greens 53-57 Level Range'),
(7137, 4, 1025458, 0, 0, 1, 6, 1, 1, 'Immolatus - Vanilla Greens 54-58 Level Range'),
(7137, 5, 1025559, 0, 0, 1, 6, 1, 1, 'Immolatus - Vanilla Greens 55-59 Level Range'),
(7137, 6, 1025660, 0, 0, 1, 6, 1, 1, 'Immolatus - Vanilla Greens 56-60 Level Range');

-- Warleader Krazzilak
DELETE FROM `creature_loot_template` WHERE `Entry` = 8199 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8199, 1, 1000345, 0, 0, 1, 5, 1, 1, 'Warleader Krazzilak - World Loot Level 45'),
(8199, 2, 1024145, 0, 0, 1, 6, 1, 1, 'Warleader Krazzilak - Vanilla Greens 41-45 Level Range'),
(8199, 3, 1024246, 0, 0, 1, 6, 1, 1, 'Warleader Krazzilak - Vanilla Greens 42-46 Level Range'),
(8199, 4, 1024347, 0, 0, 1, 6, 1, 1, 'Warleader Krazzilak - Vanilla Greens 43-47 Level Range'),
(8199, 5, 1024448, 0, 0, 1, 6, 1, 1, 'Warleader Krazzilak - Vanilla Greens 44-48 Level Range'),
(8199, 6, 1024549, 0, 0, 1, 6, 1, 1, 'Warleader Krazzilak - Vanilla Greens 45-49 Level Range');

-- Jin'Zallah the Sandbringer
DELETE FROM `creature_loot_template` WHERE `Entry` = 8200 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8200, 1, 1000346, 0, 0, 1, 5, 1, 1, 'Jin''Zallah the Sandbringer - World Loot Level 46'),
(8200, 2, 1024246, 0, 0, 1, 6, 1, 1, 'Jin''Zallah the Sandbringer - Vanilla Greens 42-46 Level Range'),
(8200, 3, 1024347, 0, 0, 1, 6, 1, 1, 'Jin''Zallah the Sandbringer - Vanilla Greens 43-47 Level Range'),
(8200, 4, 1024448, 0, 0, 1, 6, 1, 1, 'Jin''Zallah the Sandbringer - Vanilla Greens 44-48 Level Range'),
(8200, 5, 1024549, 0, 0, 1, 6, 1, 1, 'Jin''Zallah the Sandbringer - Vanilla Greens 45-49 Level Range'),
(8200, 6, 1024650, 0, 0, 1, 6, 1, 1, 'Jin''Zallah the Sandbringer - Vanilla Greens 46-50 Level Range');

-- Grimungous
DELETE FROM `creature_loot_template` WHERE `Entry` = 8215 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8215, 1, 1000250, 0, 0, 1, 5, 1, 1, 'Grimungous - World Loot Level 50'),
(8215, 2, 1024650, 0, 0, 1, 6, 1, 1, 'Grimungous - Vanilla Greens 46-50 Level Range'),
(8215, 3, 1024751, 0, 0, 1, 6, 1, 1, 'Grimungous - Vanilla Greens 47-51 Level Range'),
(8215, 4, 1024852, 0, 0, 1, 6, 1, 1, 'Grimungous - Vanilla Greens 48-52 Level Range'),
(8215, 5, 1024953, 0, 0, 1, 6, 1, 1, 'Grimungous - Vanilla Greens 49-53 Level Range'),
(8215, 6, 1025054, 0, 0, 1, 6, 1, 1, 'Grimungous - Vanilla Greens 50-54 Level Range');

-- Mith'rethis the Enchanter
DELETE FROM `creature_loot_template` WHERE `Entry` = 8217 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8217, 1, 1000352, 0, 0, 1, 5, 1, 1, 'Mith''rethis the Enchanter - World Loot Level 52'),
(8217, 2, 1024852, 0, 0, 1, 6, 1, 1, 'Mith''rethis the Enchanter - Vanilla Greens 48-52 Level Range'),
(8217, 3, 1024953, 0, 0, 1, 6, 1, 1, 'Mith''rethis the Enchanter - Vanilla Greens 49-53 Level Range'),
(8217, 4, 1025054, 0, 0, 1, 6, 1, 1, 'Mith''rethis the Enchanter - Vanilla Greens 50-54 Level Range'),
(8217, 5, 1025155, 0, 0, 1, 6, 1, 1, 'Mith''rethis the Enchanter - Vanilla Greens 51-55 Level Range'),
(8217, 6, 1025256, 0, 0, 1, 6, 1, 1, 'Mith''rethis the Enchanter - Vanilla Greens 52-56 Level Range');

-- Highlord Mastrogonde
DELETE FROM `creature_loot_template` WHERE `Entry` = 8282 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8282, 1, 1000351, 0, 0, 1, 5, 1, 1, 'Highlord Mastrogonde - World Loot Level 51'),
(8282, 2, 1024751, 0, 0, 1, 6, 1, 1, 'Highlord Mastrogonde - Vanilla Greens 47-51 Level Range'),
(8282, 3, 1024852, 0, 0, 1, 6, 1, 1, 'Highlord Mastrogonde - Vanilla Greens 48-52 Level Range'),
(8282, 4, 1024953, 0, 0, 1, 6, 1, 1, 'Highlord Mastrogonde - Vanilla Greens 49-53 Level Range'),
(8282, 5, 1025054, 0, 0, 1, 6, 1, 1, 'Highlord Mastrogonde - Vanilla Greens 50-54 Level Range'),
(8282, 6, 1025155, 0, 0, 1, 6, 1, 1, 'Highlord Mastrogonde - Vanilla Greens 51-55 Level Range');

-- Hematos
DELETE FROM `creature_loot_template` WHERE `Entry` = 8976 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8976, 1, 1000360, 0, 0, 1, 5, 1, 1, 'Hematos - World Loot Level 60'),
(8976, 2, 1025660, 0, 0, 1, 6, 1, 1, 'Hematos - Vanilla Greens 56-60 Level Range'),
(8976, 3, 1025761, 0, 0, 1, 6, 1, 1, 'Hematos - Vanilla Greens 57-61 Level Range'),
(8976, 4, 1025862, 0, 0, 1, 6, 1, 1, 'Hematos - Vanilla Greens 58-62 Level Range'),
(8976, 5, 1025963, 0, 0, 1, 6, 1, 1, 'Hematos - Vanilla Greens 59-63 Level Range'),
(8976, 6, 1026063, 0, 0, 1, 6, 1, 1, 'Hematos - Vanilla Greens 60-63 Level Range');

-- General Colbatann
DELETE FROM `creature_loot_template` WHERE `Entry` = 10196 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10196, 1, 1000356, 0, 0, 1, 5, 1, 1, 'General Colbatann - World Loot Level 56'),
(10196, 2, 1000357, 0, 0, 1, 5, 1, 1, 'General Colbatann - World Loot Level 57'),
(10196, 3, 1025256, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 52-56 Level Range'),
(10196, 4, 1025357, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 53-57 Level Range'),
(10196, 5, 1025458, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 54-58 Level Range'),
(10196, 6, 1025559, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 55-59 Level Range'),
(10196, 7, 1025660, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 56-60 Level Range'),
(10196, 8, 1025761, 0, 0, 1, 6, 1, 1, 'General Colbatann - Vanilla Greens 57-61 Level Range');

-- Kashoch the Reaver
DELETE FROM `creature_loot_template` WHERE `Entry` = 10198 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10198, 1, 1000260, 0, 0, 1, 5, 1, 1, 'Kashoch the Reaver - World Loot Level 60'),
(10198, 2, 1025660, 0, 0, 1, 6, 1, 1, 'Kashoch the Reaver - Vanilla Greens 56-60 Level Range'),
(10198, 3, 1025761, 0, 0, 1, 6, 1, 1, 'Kashoch the Reaver - Vanilla Greens 57-61 Level Range'),
(10198, 4, 1025862, 0, 0, 1, 6, 1, 1, 'Kashoch the Reaver - Vanilla Greens 58-62 Level Range'),
(10198, 5, 1025963, 0, 0, 1, 6, 1, 1, 'Kashoch the Reaver - Vanilla Greens 59-63 Level Range'),
(10198, 6, 1026063, 0, 0, 1, 6, 1, 1, 'Kashoch the Reaver - Vanilla Greens 60-63 Level Range');

-- Lady Hederine
DELETE FROM `creature_loot_template` WHERE `Entry` = 10201 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10201, 1, 1000361, 0, 0, 1, 5, 1, 1, 'Lady Hederine - World Loot Level 61'),
(10201, 2, 1025761, 0, 0, 1, 6, 1, 1, 'Lady Hederine - Vanilla Greens 57-61 Level Range'),
(10201, 3, 1025862, 0, 0, 1, 6, 1, 1, 'Lady Hederine - Vanilla Greens 58-62 Level Range'),
(10201, 4, 1025963, 0, 0, 1, 6, 1, 1, 'Lady Hederine - Vanilla Greens 59-63 Level Range'),
(10201, 5, 1026063, 0, 0, 1, 6, 1, 1, 'Lady Hederine - Vanilla Greens 60-63 Level Range'),
(10201, 6, 1026163, 0, 0, 1, 6, 1, 1, 'Lady Hederine - Vanilla Greens 61-63 Level Range');

-- Azurous
DELETE FROM `creature_loot_template` WHERE `Entry` = 10202 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10202, 1, 1000359, 0, 0, 1, 5, 1, 1, 'Azurous - World Loot Level 59'),
(10202, 2, 1025559, 0, 0, 1, 6, 1, 1, 'Azurous - Vanilla Greens 55-59 Level Range'),
(10202, 3, 1025660, 0, 0, 1, 6, 1, 1, 'Azurous - Vanilla Greens 56-60 Level Range'),
(10202, 4, 1025761, 0, 0, 1, 6, 1, 1, 'Azurous - Vanilla Greens 57-61 Level Range'),
(10202, 5, 1025862, 0, 0, 1, 6, 1, 1, 'Azurous - Vanilla Greens 58-62 Level Range'),
(10202, 6, 1025963, 0, 0, 1, 6, 1, 1, 'Azurous - Vanilla Greens 59-63 Level Range');

-- High General Abbendis
DELETE FROM `creature_loot_template` WHERE `Entry` = 10828 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10828, 1, 1000359, 0, 0, 1, 5, 1, 1, 'High General Abbendis - World Loot Level 59'),
(10828, 2, 1025559, 0, 0, 1, 6, 1, 1, 'High General Abbendis - Vanilla Greens 55-59 Level Range'),
(10828, 3, 1025660, 0, 0, 1, 6, 1, 1, 'High General Abbendis - Vanilla Greens 56-60 Level Range'),
(10828, 4, 1025761, 0, 0, 1, 6, 1, 1, 'High General Abbendis - Vanilla Greens 57-61 Level Range'),
(10828, 5, 1025862, 0, 0, 1, 6, 1, 1, 'High General Abbendis - Vanilla Greens 58-62 Level Range'),
(10828, 6, 1025963, 0, 0, 1, 6, 1, 1, 'High General Abbendis - Vanilla Greens 59-63 Level Range');

-- High Priestess Hai'watna
DELETE FROM `creature_loot_template` WHERE `Entry` = 11383 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11383, 1, 1000357, 0, 0, 1, 5, 1, 1, 'High Priestess Hai''watna - World Loot Level 57'),
(11383, 2, 1025357, 0, 0, 1, 6, 1, 1, 'High Priestess Hai''watna - Vanilla Greens 53-57 Level Range'),
(11383, 3, 1025458, 0, 0, 1, 6, 1, 1, 'High Priestess Hai''watna - Vanilla Greens 54-58 Level Range'),
(11383, 4, 1025559, 0, 0, 1, 6, 1, 1, 'High Priestess Hai''watna - Vanilla Greens 55-59 Level Range'),
(11383, 5, 1025660, 0, 0, 1, 6, 1, 1, 'High Priestess Hai''watna - Vanilla Greens 56-60 Level Range'),
(11383, 6, 1025761, 0, 0, 1, 6, 1, 1, 'High Priestess Hai''watna - Vanilla Greens 57-61 Level Range');

-- Scalebeard
DELETE FROM `creature_loot_template` WHERE `Entry` = 13896 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13896, 1, 1000252, 0, 0, 1, 5, 1, 1, 'Scalebeard - World Loot Level 52'),
(13896, 2, 1024852, 0, 0, 1, 6, 1, 1, 'Scalebeard - Vanilla Greens 48-52 Level Range'),
(13896, 3, 1024953, 0, 0, 1, 6, 1, 1, 'Scalebeard - Vanilla Greens 49-53 Level Range'),
(13896, 4, 1025054, 0, 0, 1, 6, 1, 1, 'Scalebeard - Vanilla Greens 50-54 Level Range'),
(13896, 5, 1025155, 0, 0, 1, 6, 1, 1, 'Scalebeard - Vanilla Greens 51-55 Level Range'),
(13896, 6, 1025256, 0, 0, 1, 6, 1, 1, 'Scalebeard - Vanilla Greens 52-56 Level Range');

-- Emogg the Crusher
DELETE FROM `creature_loot_template` WHERE `Entry` = 14267 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14267, 1, 1000319, 0, 0, 1, 5, 1, 1, 'Emogg the Crusher - World Loot Level 19'),
(14267, 2, 1011822, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Whites 18-22 Level Range'),
(14267, 3, 1011923, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Whites 19-23 Level Range'),
(14267, 4, 1021519, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Greens 15-19 Level Range'),
(14267, 5, 1021620, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Greens 16-20 Level Range'),
(14267, 6, 1021721, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Greens 17-21 Level Range'),
(14267, 7, 1021822, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Greens 18-22 Level Range'),
(14267, 8, 1021923, 0, 0, 1, 6, 1, 1, 'Emogg the Crusher - Vanilla Greens 19-23 Level Range');

-- Tamra Stormpike
DELETE FROM `creature_loot_template` WHERE `Entry` = 14275 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14275, 1, 1000328, 0, 0, 1, 5, 1, 1, 'Tamra Stormpike - World Loot Level 28'),
(14275, 2, 1022428, 0, 0, 1, 6, 1, 1, 'Tamra Stormpike - Vanilla Greens 24-28 Level Range'),
(14275, 3, 1022529, 0, 0, 1, 6, 1, 1, 'Tamra Stormpike - Vanilla Greens 25-29 Level Range'),
(14275, 4, 1022630, 0, 0, 1, 6, 1, 1, 'Tamra Stormpike - Vanilla Greens 26-30 Level Range'),
(14275, 5, 1022731, 0, 0, 1, 6, 1, 1, 'Tamra Stormpike - Vanilla Greens 27-31 Level Range'),
(14275, 6, 1022832, 0, 0, 1, 6, 1, 1, 'Tamra Stormpike - Vanilla Greens 28-32 Level Range');

-- Lord Captain Wyrmak
DELETE FROM `creature_loot_template` WHERE `Entry` = 14445 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14445, 1, 1000345, 0, 0, 1, 5, 1, 1, 'Lord Captain Wyrmak - World Loot Level 45'),
(14445, 2, 1024145, 0, 0, 1, 6, 1, 1, 'Lord Captain Wyrmak - Vanilla Greens 41-45 Level Range'),
(14445, 3, 1024246, 0, 0, 1, 6, 1, 1, 'Lord Captain Wyrmak - Vanilla Greens 42-46 Level Range'),
(14445, 4, 1024347, 0, 0, 1, 6, 1, 1, 'Lord Captain Wyrmak - Vanilla Greens 43-47 Level Range'),
(14445, 5, 1024448, 0, 0, 1, 6, 1, 1, 'Lord Captain Wyrmak - Vanilla Greens 44-48 Level Range'),
(14445, 6, 1024549, 0, 0, 1, 6, 1, 1, 'Lord Captain Wyrmak - Vanilla Greens 45-49 Level Range');

-- Setis
DELETE FROM `creature_loot_template` WHERE `Entry` = 14471 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14471, 1, 1000361, 0, 0, 1, 5, 1, 1, 'Setis - World Loot Level 61'),
(14471, 2, 1025761, 0, 0, 1, 6, 1, 1, 'Setis - Vanilla Greens 57-61 Level Range'),
(14471, 3, 1025862, 0, 0, 1, 6, 1, 1, 'Setis - Vanilla Greens 58-62 Level Range'),
(14471, 4, 1025963, 0, 0, 1, 6, 1, 1, 'Setis - Vanilla Greens 59-63 Level Range'),
(14471, 5, 1026063, 0, 0, 1, 6, 1, 1, 'Setis - Vanilla Greens 60-63 Level Range'),
(14471, 6, 1026163, 0, 0, 1, 6, 1, 1, 'Setis - Vanilla Greens 61-63 Level Range');

-- Lapress
DELETE FROM `creature_loot_template` WHERE `Entry` = 14473 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14473, 1, 1000260, 0, 0, 1, 5, 1, 1, 'Lapress - World Loot Level 60'),
(14473, 2, 1025660, 0, 0, 1, 6, 1, 1, 'Lapress - Vanilla Greens 56-60 Level Range'),
(14473, 3, 1025761, 0, 0, 1, 6, 1, 1, 'Lapress - Vanilla Greens 57-61 Level Range'),
(14473, 4, 1025862, 0, 0, 1, 6, 1, 1, 'Lapress - Vanilla Greens 58-62 Level Range'),
(14473, 5, 1025963, 0, 0, 1, 6, 1, 1, 'Lapress - Vanilla Greens 59-63 Level Range'),
(14473, 6, 1026063, 0, 0, 1, 6, 1, 1, 'Lapress - Vanilla Greens 60-63 Level Range');

-- Zora
DELETE FROM `creature_loot_template` WHERE `Entry` = 14474 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14474, 1, 1000259, 0, 0, 1, 5, 1, 1, 'Zora - World Loot Level 59'),
(14474, 2, 1025559, 0, 0, 1, 6, 1, 1, 'Zora - Vanilla Greens 55-59 Level Range'),
(14474, 3, 1025660, 0, 0, 1, 6, 1, 1, 'Zora - Vanilla Greens 56-60 Level Range'),
(14474, 4, 1025761, 0, 0, 1, 6, 1, 1, 'Zora - Vanilla Greens 57-61 Level Range'),
(14474, 5, 1025862, 0, 0, 1, 6, 1, 1, 'Zora - Vanilla Greens 58-62 Level Range'),
(14474, 6, 1025963, 0, 0, 1, 6, 1, 1, 'Zora - Vanilla Greens 59-63 Level Range');

-- Rex Ashil
DELETE FROM `creature_loot_template` WHERE `Entry` = 14475 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14475, 1, 1000257, 0, 0, 1, 5, 1, 1, 'Rex Ashil - World Loot Level 57'),
(14475, 2, 1025357, 0, 0, 1, 6, 1, 1, 'Rex Ashil - Vanilla Greens 53-57 Level Range'),
(14475, 3, 1025458, 0, 0, 1, 6, 1, 1, 'Rex Ashil - Vanilla Greens 54-58 Level Range'),
(14475, 4, 1025559, 0, 0, 1, 6, 1, 1, 'Rex Ashil - Vanilla Greens 55-59 Level Range'),
(14475, 5, 1025660, 0, 0, 1, 6, 1, 1, 'Rex Ashil - Vanilla Greens 56-60 Level Range'),
(14475, 6, 1025761, 0, 0, 1, 6, 1, 1, 'Rex Ashil - Vanilla Greens 57-61 Level Range');

-- Nerubian Overseer
DELETE FROM `creature_loot_template` WHERE `Entry` = 16184 AND `GroupId` IN (5, 6);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16184, 1, 1000360, 0, 0, 1, 5, 1, 1, 'Nerubian Overseer - World Loot Level 60'),
(16184, 2, 1025660, 0, 0, 1, 6, 1, 1, 'Nerubian Overseer - Vanilla Greens 56-60 Level Range'),
(16184, 3, 1025761, 0, 0, 1, 6, 1, 1, 'Nerubian Overseer - Vanilla Greens 57-61 Level Range'),
(16184, 4, 1025862, 0, 0, 1, 6, 1, 1, 'Nerubian Overseer - Vanilla Greens 58-62 Level Range'),
(16184, 5, 1025963, 0, 0, 1, 6, 1, 1, 'Nerubian Overseer - Vanilla Greens 59-63 Level Range'),
(16184, 6, 1026063, 0, 0, 1, 6, 1, 1, 'Nerubian Overseer - Vanilla Greens 60-63 Level Range');

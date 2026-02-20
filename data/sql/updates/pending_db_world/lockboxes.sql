-- Khorium Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 31952);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31952, 1, 1126668, 0, 0, 1, 1, 1, 1, 'TBC Greens 66-68 Level Range'),
(31952, 2, 1126769, 0, 0, 1, 1, 1, 1, 'TBC Greens 67-69 Level Range'),
(31952, 3, 1126870, 0, 0, 1, 1, 1, 1, 'TBC Greens 68-70 Level Range'),
(31952, 4, 1136568, 1, 0, 1, 1, 1, 1, 'TBC Blues 65-68 Level Range'),
(31952, 5, 1136669, 1, 0, 1, 1, 1, 1, 'TBC Blues 66-69 Level Range'),
(31952, 6, 1136770, 1, 0, 1, 1, 1, 1, 'TBC Blues 67-70 Level Range');

-- Froststeel Lockbox
DELETE FROM `item_loot_template` WHERE (`Entry` = 43622);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(43622, 1, 1227173, 0, 0, 1, 1, 1, 1, 'WotLK Greens 71-73 Level Range'),
(43622, 2, 1227274, 0, 0, 1, 1, 1, 1, 'WotLK Greens 72-74 Level Range'),
(43622, 3, 1227375, 0, 0, 1, 1, 1, 1, 'WotLK Greens 73-75 Level Range'),
(43622, 4, 1237173, 1, 0, 1, 1, 1, 1, 'WotLK Blues 71-73 Level Range'),
(43622, 5, 1237274, 1, 0, 1, 1, 1, 1, 'WotLK Blues 72-74 Level Range'),
(43622, 6, 1237375, 1, 0, 1, 1, 1, 1, 'WotLK Blues 73-75 Level Range');

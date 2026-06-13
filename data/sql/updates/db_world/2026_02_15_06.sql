-- DB update 2026_02_15_05 -> 2026_02_15_06
--
DELETE FROM `item_loot_template` WHERE (`Entry` = 44663);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(44663, 33470, 0, 100, 0, 1, 0, 20, 20, 'Abandoned Adventurer\'s Satchel - Frostweave Cloth'),
(44663, 1, 44663, 37.5, 0, 1, 1, 1, 1, 'Abandoned Adventurer\'s Satchel - One Crystallized Element'),
(44663, 2, 44663, 12.5, 0, 1, 1, 2, 2, 'Abandoned Adventurer\'s Satchel - Two Crystallized Elements');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 44663);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(44663, 37700, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Air'),
(44663, 37701, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Earth'),
(44663, 37702, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Fire'),
(44663, 37703, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Shadow'),
(44663, 37704, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Life'),
(44663, 37705, 0, 0, 0, 1, 1, 3, 5, 'Abandoned Adventurer\'s Satchel - Crystallized Water');

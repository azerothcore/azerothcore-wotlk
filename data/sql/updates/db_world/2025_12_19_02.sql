-- DB update 2025_12_19_01 -> 2025_12_19_02
--
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1608100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1608100, 35652, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normals that also drop in Heroic'),
(1608100, 35654, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normals that also drop in Heroic'),
(1608100, 35653, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normals that also drop in Heroic'),
(1608100, 37889, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic'),
(1608100, 37890, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic'),
(1608100, 37891, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1604000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1604000, 35594, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Normal'),
(1604000, 35593, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Normal'),
(1604000, 37647, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroics that also drop in Normal'),
(1604000, 37646, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroics that also drop in Normal'),
(1604000, 37648, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroics that also drop in Normal');

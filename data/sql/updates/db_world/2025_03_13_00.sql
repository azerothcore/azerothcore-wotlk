-- DB update 2025_03_11_02 -> 2025_03_13_00

DELETE FROM `reference_loot_template` WHERE (`Entry`= 34091) AND (`Item` IN (35202));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('34091', '35202', '0', '0', '0', '1', '1', '1', '1', 'Design: Amulet of Flowing Life');

DELETE FROM `reference_loot_template` WHERE (`Entry`= 34092) AND (`Item` IN (35215, 35209));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
('34092', '35215', '0', '0', '0', '1', '1', '1', '1', 'Pattern: Sun-Drenched Scale Gloves'),
('34092', '35209', '0', '0', '0', '1', '1', '1', '1', 'Plans: Hard Khorium Battlefists');

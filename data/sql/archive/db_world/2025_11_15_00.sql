-- DB update 2025_11_14_03 -> 2025_11_15_00
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 31231) AND (`Item` IN (42108));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31231, 42108, 0, 33, 1, 1, 0, 1, 1, 'Lost Shandaral Spirit - Scourge Curio');

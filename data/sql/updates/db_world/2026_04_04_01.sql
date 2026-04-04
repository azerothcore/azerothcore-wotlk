-- DB update 2026_04_04_00 -> 2026_04_04_01
--
DELETE FROM `item_loot_template` WHERE (`Entry` = 52676) AND (`Item` IN (47241));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(52676, 47241, 0, 100, 0, 1, 0, 2, 2, '');

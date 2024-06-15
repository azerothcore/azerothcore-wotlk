-- DB update 2023_12_11_03 -> 2023_12_12_00
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 21212) AND (`Item` IN (90062));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21212, 90062, 34062, 100, 0, 1, 4, 1, 2, 'Lady Vashj - (ReferenceTable)');

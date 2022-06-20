-- DB update 2022_06_18_05 -> 2022_06_18_06
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 5000);
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5000, 13172, 0, 0.0001, 1, 1, 0, 1, 1, 'Premium Siabi Tobacco - Siabi\'s Premium Tobacco');

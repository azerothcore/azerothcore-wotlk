-- DB update 2023_07_23_00 -> 2023_07_24_00
    --
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 21764) AND (`Item` IN (29434));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21764, 29434, 0, 100, 0, 1, 0, 1, 1, 'Badge of Justice');

-- DB update 2022_12_29_09 -> 2022_12_29_10
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 18134) AND (`Item` IN (24427));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18134, 24427, 0, 20, 1, 1, 0, 1, 1, 'Fen Strider - Fen Strider Tentacle');

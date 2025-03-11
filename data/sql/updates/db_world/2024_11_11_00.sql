-- DB update 2024_11_10_05 -> 2024_11_11_00
-- Humbert's set
DELETE FROM `reference_loot_template` WHERE `Item` IN (3053,4723,4724);

DELETE FROM `creature_loot_template` WHERE `Entry`=14275 AND `Item`=3053;
DELETE FROM `creature_loot_template` WHERE `Entry`=2346 AND `Item`=4723;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14275, 3053, 0, 1.5, 0, 1, 0, 1, 1, 'Tamra Stormpike - Humbert\'s Chestpiece'),
(2346, 4723, 0, 3, 0, 1, 0, 1, 1, 'Dun Garok Priest - Humbert\'s Pants');

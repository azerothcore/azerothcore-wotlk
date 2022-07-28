--
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 15412) AND (`Item` IN (15412, 20381));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15412, 15412, 0, 60, 0, 1, 1, 5, 8, ''),
(15412, 20381, 0, 40, 0, 1, 1, 3, 5, '');

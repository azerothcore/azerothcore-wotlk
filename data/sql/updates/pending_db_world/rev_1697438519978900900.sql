-- Strange Engine Part
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 19605 AND `Item` = 34469;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19605, 34469, 0, 0.5, 0, 1, 1, 1, 1, 'Strange Engine Part');

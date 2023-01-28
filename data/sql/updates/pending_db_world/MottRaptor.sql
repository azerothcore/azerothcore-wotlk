
DELETE FROM `reference_loot_template` WHERE `entry` = 45002 AND `item` in (24063, 24065);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (45002, 24063, 24063, 3, 0, 1, 1, 1, 1, '(ReferenceTable)');

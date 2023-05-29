-- DB update 2022_08_25_05 -> 2022_08_26_00
--
DELETE FROM `reference_loot_template` WHERE `Entry`=14503;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `Comment`) VALUES (14503, 21156, 0, 1, 'Scarab Bag');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 17532) AND (`Item` IN (1, 21156, 21157));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17532, 21156, 0, 100, 0, 1, 0, 1, 1, 'Scarab Coffer - Scarab Bag'),
(17532, 21157, 14001, 100, 0, 1, 0, 1, 1, 'Scarab Coffer - (ReferenceTable)');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 17533) AND (`Item` IN (1, 21157, 21159, 21156, 21158));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17533, 21157, 14503, 34, 0, 1, 0, 1, 1, 'Large Scarab Coffer - (ReferenceTable)'),
(17533, 21159, 14502, 100, 0, 1, 0, 1, 1, 'Large Scarab Coffer - (ReferenceTable)'),
(17533, 21156, 14503, 100, 0, 1, 0, 1, 1, 'Large Scarab Coffer - (ReferenceTable)'),
(17533, 21158, 14503, 34, 0, 1, 0, 1, 1, 'Large Scarab Coffer - (ReferenceTable)');

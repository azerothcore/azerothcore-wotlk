--
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 17532) AND (`Item` IN (1, 21156, 21157));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17532, 21156, 0, 100, 0, 1, 0, 1, 1, 'Scarab Coffer - Scarab Bag'),
(17532, 21157, 14001, 100, 0, 1, 0, 1, 1, 'Scarab Coffer - (ReferenceTable)');

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 17533) AND (`Item` IN (1, 21156, 21157));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17533, 21156, 0, 100, 0, 1, 0, 1, 3, 'Large Scarab Coffer - Scarab Bag'),
(17533, 21157, 14502, 100, 0, 1, 0, 1, 1, 'Large Scarab Coffer - (ReferenceTable)');

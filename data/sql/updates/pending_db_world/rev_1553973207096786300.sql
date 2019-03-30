INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553973207096786300');

DELETE FROM gameobject_loot_template WHERE Item=2835 AND Entry IN (18092, 1502, 1735, 2626);
INSERT INTO gameobject_loot_template (Entry, Item, Reference, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment) VALUES
(18092, 2835, 0, 88, 0, 1, 0, 1, 6, NULL);
(1502, 2835, 0, 80, 0, 1, 0, 1, 11, NULL);
(1735, 2835, 0, 80, 0, 1, 0, 1, 6, NULL);
(2626, 2835, 0, 80, 0, 1, 0, 1, 6, NULL);

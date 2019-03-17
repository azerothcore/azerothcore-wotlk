INSERT INTO version_db_world (`sql_rev`) VALUES ('1552859629415687000');

DELETE FROM `creature_loot_template` WHERE `Entry` = 31691 AND `Item` = 33470;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (31691, 33470, 0, 100, 0, 1, 0, 1, 7, NULL);

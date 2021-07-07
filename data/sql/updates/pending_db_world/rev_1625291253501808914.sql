INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625291253501808914');

DELETE FROM `reference_loot_template` WHERE `Entry` = 11105 AND `Item` = 13888;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11105, 13888, 0, 0, 0, 1, 1, 1, 1, 'Darkclaw Lobster');

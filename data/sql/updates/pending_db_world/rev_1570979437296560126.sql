INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570979437296560126');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10440) AND (`Item` IN (13340));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10440, 13340, 0, 8.7, 0, 1, 0, 1, 1, '');


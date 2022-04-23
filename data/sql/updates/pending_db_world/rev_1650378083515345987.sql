INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650378083515345987');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6910) AND (`Item` IN (7741));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6910, 7741, 0, 100, 0, 1, 0, 1, 1, 'Revelosh - The Shaft of Tsol');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625248286388193100');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 24060) AND (`Item` IN (2021));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 569) AND (`Item` IN (2021));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(569, 2021, 0, 1.2, 0, 1, 0, 1, 1, '');

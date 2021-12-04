INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637923012381502740');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 24016) AND (`Item` IN (18679));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14457) AND (`Item` IN (18679));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14457, 18679, 0, 40, 0, 1, 0, 1, 1, '');


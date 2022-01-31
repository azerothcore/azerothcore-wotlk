INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642904052333135300');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3281) AND (`Item` IN (4905));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3281, 4905, 0, 100, 1, 1, 0, 1, 1, 'Sarkoth - Sarkoth\'s Mangled Claw');

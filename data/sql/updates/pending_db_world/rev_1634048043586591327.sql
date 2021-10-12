INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634048043586591327');

-- Fixes disenchanting loot for Dusty Mail Boots
DELETE FROM `disenchant_loot_template` WHERE (`Entry` = 7) AND (`Item` IN (11137, 11174, 11177));
INSERT INTO `disenchant_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7, 11177, 0, 100, 0, 1, 1, 1, 1, 'Small Radiant Shard');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635586926158019590');

-- Deletes Defias Rapier from RLT 24077
DELETE FROM `reference_loot_template` WHERE `Entry` = 24077 AND `Item` = 1925;

-- Adds Defias Rapier drop to Defias Watchman
DELETE FROM `creature_loot_template` WHERE `Entry` = 1725 AND `Item` = 1925;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1725, 1925, 0, 6.6, 0, 1, 1, 1, 1, 'Defias Watchman - Defias Rapier');


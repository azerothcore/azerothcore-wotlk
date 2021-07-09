INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625658594120167247');

-- Remove Venom Web Fang from RLT 24078
DELETE FROM `reference_loot_template` WHERE `Entry` = 24078 AND `Item` = 899;

-- Add Venom Web Fang to Venom Web Spider with 1.1% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 217 AND `Item` = 899;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(217, 899, 0, 1.1, 0, 1, 1, 1, 1, 'Venom Web Spider - Venom Web Fang');


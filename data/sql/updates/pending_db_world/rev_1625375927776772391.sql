INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625375927776772391');

-- Delete Blackwater Cutlass from RLT 24078
DELETE FROM `reference_loot_template` WHERE `Entry` = 24078 AND `Item` = 1951;

-- Blackwater Cutlass added to Defias Pirate loot table with 6% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 657 AND `Item` = 1951;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(657, 1951, 0, 6, 0, 1, 1, 1, 1, 'Blackwater Cutlass');

-- Blackwater Cutlass added to Defias Squallshaper loot table with 6% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 1732 AND `Item` = 1951;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1732, 1951, 0, 6, 0, 1, 1, 1, 1, 'Blackwater Cutlass');



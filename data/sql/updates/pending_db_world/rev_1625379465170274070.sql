INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625379465170274070');

-- Removes Stonemason's Cloak from RLT 24078'
DELETE FROM `reference_loot_template` WHERE `Entry` = 24078 AND `Item` = 1930;

-- Adds Stonemason's Cloak to Defias Miner with 3% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 598 AND `Item` = 1930;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(598, 1930, 0, 3, 0, 1, 1, 1, 1, 'Defias Miner - Stonemason\'s Cloak');


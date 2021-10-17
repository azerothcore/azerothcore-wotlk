INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634045250480483175');

-- Deletes Black Metal War Axe from the RLT 24068
DELETE FROM `reference_loot_template` WHERE `Entry` = 24068 AND `Item` = 2015;

-- Adds Black Metal War Axe to Brain Eaters directly
DELETE FROM `creature_loot_template` WHERE `Entry` = 570 AND `Item` = 2015;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(570, 2015, 0, 0.9, 0, 1, 0, 1, 1, '');

-- Reduces the drop chance of Nightcrawler to not exceed 100 % overall loot chance for Brain Eaters
UPDATE `creature_loot_template` SET `Chance` = 32.28 WHERE `Entry` = 570 AND `Item` = 6530;

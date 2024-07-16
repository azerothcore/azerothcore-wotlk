-- Reference: https://www.wowhead.com/wotlk/item=22094/bloodkelp
-- Strashz Warrior (4364)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4364) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4364, 22094, 0, 25, 1, 1, 0, 1, 2, 'Strashaz Warrior - Bloodkelp');

-- Strashaz Serpent Guard (4366)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4366) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4366, 22094, 0, 25, 1, 1, 0, 1, 2, 'Strashaz Serpent Guard - Bloodkelp');

-- Strashaz Myrmidon (4368)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4368) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4368, 22094, 0, 25, 0, 1, 0, 1, 2, 'Strashaz Myrmidon - Bloodkelp');

-- Strashaz Sorceress (4370)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4370) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4370, 22094, 0, 25, 1, 1, 0, 1, 2, 'Strashaz Sorceress - Bloodkelp');

-- Strashaz Siren (4371)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 4371) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4371, 22094, 0, 25, 1, 1, 0, 1, 2, 'Strashaz Siren - Bloodkelp');

-- Tidelord Rrurgaz (16072)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 16072) AND (`Item` IN (22094));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16072, 22094, 0, 7, 0, 1, 0, 1, 2, 'Tidelord Rrurgaz - Bloodkelp');

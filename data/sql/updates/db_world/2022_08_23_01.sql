-- DB update 2022_08_23_00 -> 2022_08_23_01
-- aq20 boss reference table
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34024) AND (`Item` IN (20727, 20728, 20729, 20730, 20731, 20734, 20736));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34024, 20727, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Shadow Power'),
(34024, 20728, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Frost Power'),
(34024, 20729, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Fire Power'),
(34024, 20730, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Healing Power'),
(34024, 20731, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Superior Agility'),
(34024, 20734, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Cloak - Stealth'),
(34024, 20736, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Cloak - Dodge');

-- kurinnaxx
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15348) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15348, 34024, 34024, 100, 0, 1, 2, 1, 2, 'Kurinnaxx - (ReferenceTable)'),
(15348, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

-- rajaxx
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15341) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15341, 34024, 34024, 100, 0, 1, 3, 1, 2, 'General Rajaxx - (ReferenceTable)'),
(15341, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

-- ossirian 
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15339) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15339, 34024, 34024, 100, 0, 1, 3, 1, 2, 'Ossirian the Unscarred - (ReferenceTable)'),
(15339, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

-- buru
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15370) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15370, 34024, 34024, 100, 0, 1, 3, 1, 2, 'Buru the Gorger - (ReferenceTable)'),
(15370, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

-- moam
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15340) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15340, 34024, 34024, 100, 0, 1, 3, 1, 2, 'Moam - (ReferenceTable)'),
(15340, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

-- Ayamiss the Hunter
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15369) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15369, 34024, 34024, 100, 0, 1, 3, 1, 2, 'Ayamiss the Hunter - (ReferenceTable)'),
(15369, 190024, 34024, 1, 0, 1, 1, 1, 1, '');

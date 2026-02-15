-- DB update 2026_02_15_06 -> 2026_02_15_07
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 20169) AND (`Item` IN (12018, 43002));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20169, 12018, 12018, 100, 0, 1, 0, 1, 1, 'Hungarfen (1) - (ReferenceTable)'),
(20169, 43002, 43002, 25, 0, 1, 0, 1, 1, 'Hungarfen (1) - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17808) AND (`Item` IN (34063, 34065));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17808, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Anetheron - (ReferenceTable)'),
(17808, 34065, 34065, 100, 0, 1, 0, 2, 2, 'Anetheron - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 1911) AND (`Item` IN (2, 4303));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1911, 2, 1011212, 10, 0, 1, 0, 1, 1, 'World Drop - White World Drop - NPC Levels: 12-12'),
(1911, 4303, 0, 50, 0, 1, 1, 1, 1, 'Deeb - Cranial Thumper');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14517) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14517, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Jeklik - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 18831) AND (`Item` IN (34050));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18831, 34050, 34050, 100, 0, 1, 0, 3, 3, 'High King Maulgar - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 2749) AND (`Item` IN (24037, 24039, 24041, 24047, 24056));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2749, 24037, 24037, 1, 0, 1, 0, 1, 1, 'Siege Golem - (ReferenceTable)'),
(2749, 24039, 24039, 1, 0, 1, 0, 1, 1, 'Siege Golem - (ReferenceTable)'),
(2749, 24041, 24041, 50, 0, 1, 1, 1, 1, 'Siege Golem - (ReferenceTable)'),
(2749, 24047, 24047, 50, 0, 1, 1, 1, 1, 'Siege Golem - (ReferenceTable)'),
(2749, 24056, 24056, 1, 0, 1, 0, 1, 1, 'Siege Golem - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14507) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14507, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priest Venoxis - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10503) AND (`Item` IN (24016));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10503, 24016, 24016, 100, 0, 1, 0, 1, 1, 'Jandice Barov - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11486) AND (`Item` IN (35021));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11486, 35021, 35021, 100, 0, 1, 0, 2, 2, 'Prince Tortheldrin - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 25165) AND (`Item` IN (34081, 34085));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25165, 34081, 34081, 100, 0, 1, 0, 1, 1, 'Lady Sacrolash - (ReferenceTable 2)'),
(25165, 34085, 34085, 100, 0, 1, 0, 4, 4, 'Lady Sacrolash - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 16968) AND (`Item` IN (1));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16968, 1, 6000, 80, 0, 1, 0, 1, 1, 'Tunneler - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10439) AND (`Item` IN (24016));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10439, 24016, 24016, 100, 0, 1, 0, 1, 1, 'Ramstein the Gorger - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 24892) AND (`Item` IN (34082));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24892, 34082, 34082, 100, 0, 1, 0, 3, 3, 'Sathrovarr the Corruptor - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 25840) AND (`Item` IN (34095));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25840, 34095, 34095, 100, 0, 1, 0, 3, 3, 'Entropius - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10363) AND (`Item` IN (35025));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10363, 35025, 35025, 100, 0, 1, 0, 2, 2, 'General Drakkisath - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11382) AND (`Item` IN (34088));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11382, 34088, 34088, 100, 0, 1, 2, 2, 2, 'Bloodlord Mandokir - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11380) AND (`Item` IN (34087, 34089));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11380, 34087, 34087, 100, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - (ReferenceTable)'),
(11380, 34089, 34089, 100, 0, 1, 0, 2, 2, 'Jin\'do the Hexxer - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17842) AND (`Item` IN (34063, 34067));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17842, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Azgalor - (ReferenceTable)'),
(17842, 34067, 34067, 100, 0, 1, 0, 3, 3, 'Azgalor - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 24018) AND (`Item` IN (44003, 44004));
-- Redundant Loot
-- INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- (24018, 44003, 44003, 100, 0, 1, 0, 1, 1, 'Necro Overlord Mezhen - (ReferenceTable)'),
-- (24018, 44004, 44004, 100, 0, 1, 0, 1, 1, 'Necro Overlord Mezhen - (ReferenceTable)');

DELETE FROM `reference_loot_template` WHERE (`Entry` IN (44003, 44004));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 4830) AND (`Item` IN (24070));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4830, 24070, 24070, 5, 0, 1, 0, 1, 1, 'Old Serra\'kis - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 5837) AND (`Item` IN (2));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5837, 2, 1011515, 10, 0, 1, 0, 1, 1, 'World Drop - White World Drop - NPC Levels: 15-15');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14509) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14509, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priest Thekal - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10440) AND (`Item` IN (35028));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10440, 35028, 35028, 100, 0, 1, 0, 2, 2, 'Baron Rivendare - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14326) AND (`Item` IN (35018));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14326, 35018, 35018, 100, 0, 1, 0, 1, 1, 'Guard Mol\'dar - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14510) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14510, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14515) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14515, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Arlokk - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15114) AND (`Item` IN (34003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15114, 34003, 34003, 100, 0, 1, 0, 1, 1, 'Gahz\'ranka - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 25166) AND (`Item` IN (34081, 34085));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25166, 34081, 34081, 100, 0, 1, 0, 1, 1, 'Grand Warlock Alythess - (ReferenceTable 2)'),
(25166, 34085, 34085, 100, 0, 1, 0, 4, 4, 'Grand Warlock Alythess - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17767) AND (`Item` IN (34063, 34064));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17767, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Rage Winterchill - (ReferenceTable)'),
(17767, 34064, 34064, 100, 0, 1, 0, 2, 2, 'Rage Winterchill - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17888) AND (`Item` IN (34063, 34066));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17888, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Kaz\'rogal - (ReferenceTable)'),
(17888, 34066, 34066, 100, 0, 1, 0, 2, 2, 'Kaz\'rogal - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 24882) AND (`Item` IN (34083));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24882, 34083, 34083, 100, 0, 1, 0, 3, 3, 'Brutallus - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 25038) AND (`Item` IN (34084));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25038, 34084, 34084, 100, 0, 1, 0, 3, 3, 'Felmyst - (ReferenceTable)');

DELETE FROM `fishing_loot_template` WHERE (`Entry` = 1) AND (`Item` IN (11000, 11799));
INSERT INTO `fishing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1, 11000, 11000, 100, 0, 1, 0, 1, 1, '(ReferenceTable)'),
(1, 11799, 11799, 100, 0, 32768, 0, 1, 1, '(ReferenceTable)');

DELETE FROM `fishing_loot_template` WHERE (`Entry` = 33);
INSERT INTO `fishing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33, 11006, 11006, 100, 0, 1, 0, 1, 1, '(ReferenceTable)'),
(33, 11150, 11150, 33, 0, 1, 0, 1, 1, '(ReferenceTable)');

DELETE FROM `gameobject_loot_template` WHERE `Entry` = 16591;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16591, 12006, 12006, 100, 0, 1, 0, 2, 2, 'Knot Thimblejack\'s Cache - (ReferenceTable)'),
(16591, 18240, 0, 35, 0, 1, 0, 1, 2, 'Knot Thimblejack\'s Cache - Ogre Tannin'),
(16591, 18414, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Belt of the Archmage'),
(16591, 18415, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Felcloth Gloves'),
(16591, 18416, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Inferno Gloves'),
(16591, 18417, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Mooncloth Gloves'),
(16591, 18418, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Cloak of Warding'),
(16591, 18514, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Girdle of Insight'),
(16591, 18515, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Mongoose Boots'),
(16591, 18516, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Swift Flight Bracers'),
(16591, 18517, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Chromatic Cloak'),
(16591, 18518, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Hide of the Wild'),
(16591, 18519, 0, 2, 0, 1, 1, 1, 1, 'Knot Thimblejack\'s Cache - Pattern: Shifting Cloak');

UPDATE `gameobject_loot_template` SET `GroupId` = 0 WHERE `Entry` = 13960 AND `Item` = 1;
UPDATE `gameobject_loot_template` SET `GroupId` = 0 WHERE `Entry`=26862;

DELETE FROM `item_loot_template` WHERE (`Entry` = 33844) AND (`Item` IN (10003));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33844, 10003, 10003, 100, 0, 1, 0, 2, 2, 'Barrel of Fish - (ReferenceTable)');

DELETE FROM `item_loot_template` WHERE (`Entry` = 33857) AND (`Item` IN (10004));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33857, 10004, 10004, 100, 0, 1, 0, 2, 2, 'Crate of Meat - (ReferenceTable)');

DELETE FROM `prospecting_loot_template` WHERE (`Entry` = 23425) AND (`Item` IN (1, 2, 3));
INSERT INTO `prospecting_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23425, 1, 13001, 100, 0, 1, 0, 1, 1, '(ReferenceTable)'),
(23425, 2, 13002, 24, 0, 1, 0, 1, 1, '(ReferenceTable)'),
(23425, 3, 13001, 15, 0, 1, 0, 1, 1, '(ReferenceTable)');

DELETE FROM `prospecting_loot_template` WHERE (`Entry` = 36910) AND (`Item` IN (2, 3));
INSERT INTO `prospecting_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(36910, 2, 1002, 100, 0, 1, 0, 1, 1, '(ReferenceTable)'),
(36910, 3, 1003, 75, 0, 1, 0, 1, 1, '(ReferenceTable)');

-- AQ20 Enchanting Formulas
DELETE FROM `reference_loot_template` WHERE `Entry` = 34024 AND `Item` IN (20727,20728,20729,20730,20731,20734,20736);
DELETE FROM `reference_loot_template` WHERE `Entry` = 34026;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34026, 20727, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Shadow Power'),
(34026, 20728, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Frost Power'),
(34026, 20729, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Fire Power'),
(34026, 20730, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Healing Power'),
(34026, 20731, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Gloves - Superior Agility'),
(34026, 20734, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Cloak - Stealth'),
(34026, 20736, 0, 0, 0, 1, 1, 1, 1, 'Formula: Enchant Cloak - Dodge');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15339) AND (`Item` IN (34024, 34025, 190024, 34026));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15339, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Ossirian the Unscarred - (ReferenceTable)'),
(15339, 34025, 34025, 1.5, 0, 1, 0, 2, 2, 'Ossirian the Unscarred - (ReferenceTable)'),
(15339, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15348) AND (`Item` IN (34024, 190024, 34026));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15348, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Kurinnaxx - (ReferenceTable)'),
(15348, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15341) AND (`Item` IN (34024, 190024, 34026));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15341, 34024, 34024, 100, 0, 1, 0, 2, 2, 'General Rajaxx - (ReferenceTable)'),
(15341, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15369) AND (`Item` IN (34024, 190024, 34026));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15369, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Ayamiss the Hunter - (ReferenceTable)'),
(15369, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15370) AND (`Item` IN (34024, 190024, 34026));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15370, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Buru the Gorger - (ReferenceTable)'),
(15370, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15340) AND (`Item` IN (34024, 34026, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15340, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Moam - (ReferenceTable)'),
(15340, 34026, 34026, 1, 0, 1, 0, 1, 1, 'Enchanting Formulas');

-- Sacks of Gems (World Bosses)
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34003) AND (`Item` IN (17962, 17963, 17964, 17965, 17969));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34010);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34010, 17962, 0, 0, 0, 1, 2, 1, 1, 'Blue Sack of Gems'),
(34010, 17963, 0, 0, 0, 1, 2, 1, 1, 'Green Sack of Gems'),
(34010, 17964, 0, 0, 0, 1, 2, 1, 1, 'Gray Sack of Gems'),
(34010, 17965, 0, 0, 0, 1, 2, 1, 1, 'Yellow Sack of Gems'),
(34010, 17969, 0, 0, 0, 1, 2, 1, 1, 'Red Sack of Gems');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6109) AND (`Item` IN (34002, 34004, 190003, 34010));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6109, 34002, 34002, 100, 0, 1, 0, 3, 3, 'Azuregos - (ReferenceTable)'),
(6109, 34004, 34004, 100, 0, 1, 0, 2, 2, 'Azuregos - (ReferenceTable)'),
(6109, 34010, 34010, 100, 0, 1, 0, 2, 2, 'Sack of Gems');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14887) AND (`Item` IN (34002, 34008, 190003, 34010));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14887, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Ysondre - (ReferenceTable)'),
(14887, 34008, 34008, 100, 0, 1, 0, 2, 2, 'Ysondre - (ReferenceTable)'),
(14887, 34010, 34010, 100, 0, 1, 1, 1, 1, 'Sack of Gems');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14888) AND (`Item` IN (34002, 34005, 190003, 34010));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14888, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Lethon - (ReferenceTable)'),
(14888, 34005, 34005, 100, 0, 1, 0, 2, 2, 'Lethon - (ReferenceTable)'),
(14888, 34010, 34010, 100, 0, 1, 1, 1, 1, 'Sack of Gems');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14889) AND (`Item` IN (34002, 34006, 190003, 34010));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14889, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Emeriss - (ReferenceTable)'),
(14889, 34006, 34006, 100, 0, 1, 0, 2, 2, 'Emeriss - (ReferenceTable)'),
(14889, 34010, 34010, 100, 0, 1, 0, 1, 1, 'Sack of Gems');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14890) AND (`Item` IN (34002, 34007, 190003, 34010));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14890, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Taerar - (ReferenceTable)'),
(14890, 34007, 34007, 100, 0, 1, 0, 2, 2, 'Taerar - (ReferenceTable)'),
(14890, 34010, 34010, 100, 0, 1, 0, 1, 1, 'Sack of Gems');

-- Librams
DELETE FROM `reference_loot_template` WHERE (`Entry` = 35016) AND (`Item` IN (18332, 18333));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 35029) AND (`Item` IN (18332, 18333));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35029, 18332, 0, 100, 0, 1, 0, 1, 1, 'Libram of Rapidity'),
(35029, 18333, 0, 100, 0, 1, 0, 1, 1, 'Libram of Focus');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11490) AND (`Item` IN (35016, 91016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11490, 35016, 35016, 2, 0, 1, 0, 1, 1, 'Zevrim Thornhoof - (ReferenceTable)'),
(11490, 35029, 35029, 2, 0, 1, 0, 1, 1, 'Zevrim Thornhoof - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11492) AND (`Item` IN (35016, 35017, 91016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11492, 35017, 35017, 100, 0, 1, 0, 2, 2, 'Alzzin the Wildshaper - (ReferenceTable)'),
(11492, 91016, 35016, 2, 0, 1, 0, 1, 1, 'Alzzin the Wildshaper - (ReferenceTable)'),
(11492, 35029, 35029, 2, 0, 1, 0, 1, 1, 'Alzzin the Wildshaper - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11501) AND (`Item` IN (35019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11501, 35019, 35019, 100, 0, 1, 0, 2, 2, 'King Gordok - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 13280) AND (`Item` IN (91016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13280, 35029, 35029, 2, 0, 1, 2, 1, 1, 'Hydrospawn - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14323) AND (`Item` IN (35016, 35018));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14323, 35016, 35016, 100, 0, 1, 0, 1, 1, 'Guard Slip\'kik - (ReferenceTable)'),
(14323, 35018, 35018, 100, 0, 1, 0, 1, 1, 'Guard Slip\'kik - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14327) AND (`Item` IN (35016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14327, 35029, 35029, 2, 0, 1, 0, 1, 1, 'Lethtendris - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14349) AND (`Item` IN (35016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14349, 35029, 35029, 2, 0, 1, 2, 1, 1, 'Pimgib - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14354) AND (`Item` IN (191016, 35029));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14354, 35029, 35029, 2, 0, 1, 2, 1, 1, 'Pusillin - (ReferenceTable)');

-- Now Useless GroupIds
UPDATE `creature_loot_template` SET `GroupId` = 0 WHERE `Item` = 35016 AND `Reference` = 35016 AND `Entry` IN (
11487, -- Magister Kalendris
11488, -- Illyanna Ravenoak
11489, -- Tendris Warpwood
14321, -- Guard Fengus
14324, -- Cho'Rush the Observer
14325  -- Captain Kromcrush
);

-- Magtheridon (3 Tokens, 2 Drops)
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34039) AND (`Item` IN (29753, 29754, 29755));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34047) AND (`Item` IN (29753, 29754, 29755));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34047, 29753, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Fallen Defender'),
(34047, 29754, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Fallen Champion'),
(34047, 29755, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Fallen Hero');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17257) AND (`Item` IN (34039, 90039, 34047));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17257, 34039, 34039, 100, 0, 1, 0, 2, 2, 'Magtheridon - (ReferenceTable)'),
(17257, 34047, 34047, 100, 0, 1, 0, 3, 3, 'Magtheridon - Tokens');

-- Kalithresh: Doubled Loot. One Reference handles 2 drops
DELETE FROM `creature_loot_template` WHERE (`Entry` = 17798) AND (`Item` IN (35001, 43000));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17798, 35001, 35001, 100, 0, 1, 0, 1, 1, 'Warlord Kalithresh Table - (ReferenceTable)'),
(17798, 43000, 43000, 2, 0, 1, 0, 1, 1, 'Warlord Kalithresh - (ReferenceTable)');

-- Ditto
DELETE FROM `creature_loot_template` WHERE (`Entry` = 17881) AND (`Item` IN (35004, 43000));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17881, 35004, 35004, 100, 0, 1, 0, 1, 1, 'Aeonus - (ReferenceTable)'),
(17881, 43000, 43000, 2, 0, 1, 0, 1, 1, 'Aeonus - (ReferenceTable)');

-- Ditto
DELETE FROM `creature_loot_template` WHERE (`Entry` = 17977) AND (`Item` IN (35006));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17977, 35006, 35006, 100, 0, 1, 0, 1, 1, 'Warp Splinter High Value Table - (ReferenceTable)');

-- Solarian
DELETE FROM `reference_loot_template` WHERE (`Entry` IN (34052, 34092));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34052, 30280, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Belt of Blasting'),
(34052, 30281, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Belt of the Long Road'),
(34052, 30301, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Belt of Natural Power'),
(34052, 30302, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Belt of Deep Shadow'),
(34052, 30303, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Belt of the Black Eagle'),
(34052, 30304, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Monsoon Belt'),
(34052, 30321, 0, 0, 0, 1, 1, 1, 1, 'Plans: Belt of the Guardian'),
(34052, 30322, 0, 0, 0, 1, 1, 1, 1, 'Plans: Red Belt of Battle'),
(34092, 30305, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Boots of Natural Grace'),
(34092, 30306, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Boots of Utter Darkness'),
(34092, 30307, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Boots of the Crimson Hawk'),
(34092, 30308, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Hurricane Boots'),
(34092, 30282, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Boots of Blasting'),
(34092, 30283, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Boots of the Long Road'),
(34092, 30323, 0, 0, 0, 1, 2, 1, 1, 'Plans: Boots of the Protector'),
(34092, 30324, 0, 0, 0, 1, 2, 1, 1, 'Plans: Red Havoc Boots');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 18805) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18805, 34052, 34052, 10, 0, 1, 0, 1, 1, 'High Astromancer Solarian - (ReferenceTable)'),
(18805, 34092, 34092, 10, 0, 1, 0, 1, 1, 'High Astromancer Solarian - (ReferenceTable)');

-- Gruul
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34051) AND (`Item` IN (29765, 29766, 29767));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34097);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34097, 29765, 0, 100, 0, 1, 0, 1, 1, 'Leggings of the Fallen Hero'),
(34097, 29766, 0, 100, 0, 1, 0, 1, 1, 'Leggings of the Fallen Champion'),
(34097, 29767, 0, 100, 0, 1, 0, 1, 1, 'Leggings of the Fallen Defender');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 19044) AND (`Item` IN (190039, 34097));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19044, 34097, 34097, 100, 0, 1, 0, 3, 3, 'Gruul the Dragonkiller - Tokens');

-- Pathaleon (2 Gear Drops)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 19220) AND (`Item` IN (21907, 23572, 35005, 43000));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19220, 21907, 0, 10, 0, 1, 0, 1, 1, 'Pathaleon the Calculator - Pattern: Arcanoweave Robe'),
(19220, 23572, 0, 5, 0, 1, 0, 1, 1, 'Pathaleon the Calculator - Primal Nether'),
(19220, 35005, 35005, 100, 0, 1, 0, 1, 1, 'Pathaleon the Calculator - (ReferenceTable)'),
(19220, 43000, 43000, 2, 0, 1, 0, 1, 1, 'Pathaleon the Calculator - (ReferenceTable)');

-- Al'ar
DELETE FROM `creature_loot_template` WHERE (`Entry` = 19514) AND (`Item` IN (1, 2, 3, 34053, 34052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19514, 34053, 34053, 100, 0, 1, 0, 3, 3, 'Al\'ar - (ReferenceTable)'),
(19514, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Al\'ar - (ReferenceTable)'),
(19514, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Al\'ar - (ReferenceTable)');

-- Void Reaver
DELETE FROM `creature_loot_template` WHERE (`Entry` = 19516) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19516, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Void Reaver - (ReferenceTable)'),
(19516, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Void Reaver - (ReferenceTable)');

-- Kael'thas
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34056) AND (`Item` IN (30236, 30237, 30238));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34104);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34104, 30236, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Vanquished Champion'),
(34104, 30237, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Vanquished Defender'),
(34104, 30238, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Vanquished Hero');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 19622) AND (`Item` IN (34052, 34056, 90052, 90056, 34092, 34104));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19622, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Kael\'thas Sunstrider - (ReferenceTable)'),
(19622, 34056, 34056, 100, 0, 1, 0, 2, 2, 'Kael\'thas Sunstrider - (ReferenceTable)'),
(19622, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Kael\'thas Sunstrider - (ReferenceTable)'),
(19622, 34104, 34104, 100, 0, 1, 0, 3, 3, 'Kael\'thas Sunstrider - (ReferenceTable)');

-- Skyriss
DELETE FROM `creature_loot_template` WHERE (`Entry` = 20912) AND (`Item` IN (25004, 43000));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20912, 25004, 25004, 100, 0, 1, 0, 1, 1, 'Harbinger Skyriss - (ReferenceTable)'),
(20912, 43000, 43000, 10, 0, 1, 0, 1, 1, 'Harbinger Skyriss - (ReferenceTable)');

-- Vash'j
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34062) AND (`Item` IN (30242, 30243, 30244));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34105);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34105, 30242, 0, 0, 0, 1, 1, 1, 1, 'Helm of the Vanquished Champion'),
(34105, 30243, 0, 0, 0, 1, 1, 1, 1, 'Helm of the Vanquished Defender'),
(34105, 30244, 0, 0, 0, 1, 1, 1, 1, 'Helm of the Vanquished Hero');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 21212) AND (`Item` IN (34052, 34062, 90062, 190052, 34105, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21212, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Lady Vashj - (ReferenceTable)'),
(21212, 34062, 34062, 100, 0, 1, 0, 2, 2, 'Lady Vashj - (ReferenceTable)'),
(21212, 34105, 34105, 100, 0, 1, 0, 3, 3, 'Lady Vashj - Tokens'),
(21212, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Lady Vashj - (ReferenceTable)');

-- SSC Patterns
DELETE FROM `creature_loot_template` WHERE (`Entry` = 21213) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21213, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Morogrim Tidewalker - (ReferenceTable)'),
(21213, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Morogrim Tidewalker - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 21214) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21214, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Fathom-Lord Karathress - (ReferenceTable)'),
(21214, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Fathom-Lord Karathress - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 21215) AND (`Item` IN (34052, 190052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21215, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Leotheras the Blind - (ReferenceTable)'),
(21215, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Leotheras the Blind - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 21216) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21216, 34052, 34052, 10, 0, 1, 0, 1, 1, 'Hydross the Unstable - (ReferenceTable)'),
(21216, 34092, 34092, 10, 0, 1, 0, 1, 1, 'Hydross the Unstable - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 21217) AND (`Item` IN (34052, 90052, 34092));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21217, 34052, 34052, 10, 0, 1, 0, 1, 1, 'The Lurker Below - (ReferenceTable)'),
(21217, 34092, 34092, 10, 0, 1, 0, 1, 1, 'The Lurker Below - (ReferenceTable)');

-- Black Temple
DELETE FROM `reference_loot_template` WHERE (`Entry` IN (34069, 34116));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34069, 32736, 0, 0, 0, 1, 1, 1, 1, 'Plans: Swiftsteel Bracers'),
(34069, 32738, 0, 0, 0, 1, 1, 1, 1, 'Plans: Dawnsteel Bracers'),
(34069, 32744, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Bracers of Renewed Life'),
(34069, 32746, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Swiftstrike Bracers'),
(34069, 32748, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Bindings of Lightning Reflexes'),
(34069, 32750, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Living Earth Bindings'),
(34069, 32752, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Swiftheal Wraps'),
(34069, 32754, 0, 0, 0, 1, 1, 1, 1, 'Pattern: Bracers of Nimble Thought'),
(34116, 32739, 0, 0, 0, 1, 2, 1, 1, 'Plans: Dawnsteel Shoulders'),
(34116, 32745, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Shoulderpads of Renewed Life'),
(34116, 32747, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Swiftstrike Shoulders'),
(34116, 32749, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Shoulders of Lightning Reflexes'),
(34116, 32751, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Living Earth Shoulders'),
(34116, 32753, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Swiftheal Mantle'),
(34116, 32737, 0, 0, 0, 1, 2, 1, 1, 'Plans: Swiftsteel Shoulders'),
(34116, 32755, 0, 0, 0, 1, 2, 1, 1, 'Pattern: Mantle of Nimble Thought');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22841) AND (`Item` IN (34069, 34072, 190069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22841, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Shade of Akama - (ReferenceTable)'),
(22841, 34072, 34072, 100, 0, 1, 0, 2, 2, 'Shade of Akama - (ReferenceTable)'),
(22841, 34116, 34116, 2, 0, 1, 0, 1, 1, 'Shade of Akama - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22871) AND (`Item` IN (34069, 34073, 190069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22871, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Teron Gorefiend - (ReferenceTable)'),
(22871, 34073, 34073, 100, 0, 1, 0, 2, 2, 'Teron Gorefiend - (ReferenceTable)'),
(22871, 34116, 34116, 2, 0, 1, 0, 1, 1, 'Teron Gorefiend - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22887) AND (`Item` IN (34069, 34070, 90069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22887, 34069, 34069, 2, 0, 1, 0, 1, 1, 'High Warlord Naj\'entus - (ReferenceTable)'),
(22887, 34070, 34070, 100, 0, 1, 0, 2, 2, 'High Warlord Naj\'entus - (ReferenceTable)'),
(22887, 34116, 34116, 10, 0, 1, 0, 1, 1, 'High Warlord Naj\'entus - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22898) AND (`Item` IN (34069, 34071, 190069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22898, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Supremus - (ReferenceTable)'),
(22898, 34071, 34071, 100, 0, 1, 0, 2, 2, 'Supremus - (ReferenceTable)'),
(22898, 34116, 34116, 2, 0, 1, 0, 1, 1, 'Supremus - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22947) AND (`Item` IN (34069, 34076, 90069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22947, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Mother Shahraz - (ReferenceTable)'),
(22947, 34076, 34076, 100, 0, 1, 0, 3, 3, 'Mother Shahraz - (ReferenceTable)'),
(22947, 34116, 34116, 10, 0, 1, 0, 1, 1, 'Mother Shahraz - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22948) AND (`Item` IN (34069, 90069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22948, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Gurtogg Bloodboil - (ReferenceTable)'),
(22948, 34116, 34116, 10, 0, 1, 0, 1, 1, 'Gurtogg Bloodboil - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 23420) AND (`Item` IN (34069, 34075, 90069, 34116));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23420, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Essence of Anger - (ReferenceTable)'),
(23420, 34075, 34075, 100, 0, 1, 0, 2, 2, 'Essence of Anger - (ReferenceTable)'),
(23420, 34116, 34116, 10, 0, 1, 0, 1, 1, 'Essence of Anger - (ReferenceTable)');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 34077);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34077, 32235, 0, 0, 0, 1, 1, 1, 1, 'Cursed Vision of Sargeras'),
(34077, 32336, 0, 0, 0, 1, 1, 1, 1, 'Black Bow of the Betrayer'),
(34077, 32374, 0, 0, 0, 1, 1, 1, 1, 'Zhar\'doom, Greatstaff of the Devourer'),
(34077, 32375, 0, 0, 0, 1, 1, 1, 1, 'Bulwark of Azzinoth'),
(34077, 32471, 0, 0, 0, 1, 1, 1, 1, 'Shard of Azzinoth'),
(34077, 32483, 0, 0, 0, 1, 1, 1, 1, 'The Skull of Gul\'dan'),
(34077, 32496, 0, 0, 0, 1, 1, 1, 1, 'Memento of Tyrande'),
(34077, 32497, 0, 0, 0, 1, 1, 1, 1, 'Stormrage Signet Ring'),
(34077, 32500, 0, 0, 0, 1, 1, 1, 1, 'Crystal Spire of Karabor'),
(34077, 32521, 0, 0, 0, 1, 1, 1, 1, 'Faceplate of the Impenetrable'),
(34077, 32524, 0, 0, 0, 1, 1, 1, 1, 'Shroud of the Highborne'),
(34077, 32525, 0, 0, 0, 1, 1, 1, 1, 'Cowl of the Illidari High Lord');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 34117);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34117, 31089, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Conqueror'),
(34117, 31090, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Vanquisher'),
(34117, 31091, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Protector');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22917);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22917, 29434, 0, 100, 0, 1, 0, 2, 2, 'Illidan Stormrage - Badge of Justice'),
(22917, 32837, 0, 5, 0, 1, 0, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 32838, 0, 5, 0, 1, 0, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 34077, 34077, 100, 0, 1, 0, 2, 2, 'Illidan Stormrage - (Items)'),
(22917, 34116, 34116, 10, 0, 1, 0, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 34117, 34117, 100, 0, 1, 0, 3, 3, 'Illidan Stormrage - (Tokens)');

-- Koralon
DELETE FROM `reference_loot_template` WHERE `Entry` IN (34204, 34210, 34211);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34204, 40807, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Plate Gauntlets'),
(34204, 40808, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Scaled Gauntlets'),
(34204, 40809, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Dreadplate Gauntlets'),
(34204, 40847, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Plate Legguards'),
(34204, 40849, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Scaled Legguards'),
(34204, 40881, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Girdle of Triumph'),
(34204, 40882, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Greaves of Triumph'),
(34204, 40889, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Bracers of Triumph'),
(34204, 40927, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Ornamented Gloves'),
(34204, 40939, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Ornamented Legplates'),
(34204, 40976, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Girdle of Salvation'),
(34204, 40977, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Greaves of Salvation'),
(34204, 40983, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Bracers of Salvation'),
(34204, 41001, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Ringmail Gauntlets'),
(34204, 41007, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Mail Gauntlets'),
(34204, 41027, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Ringmail Leggings'),
(34204, 41033, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Mail Leggings'),
(34204, 41051, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Waistguard of Salvation'),
(34204, 41055, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Sabatons of Salvation'),
(34204, 41060, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Wristguards of Salvation'),
(34204, 41065, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Wristguards of Dominance'),
(34204, 41070, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Waistguard of Dominance'),
(34204, 41075, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Sabatons of Dominance'),
(34204, 41137, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Linked Gauntlets'),
(34204, 41143, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Chain Gauntlets'),
(34204, 41199, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Linked Leggings'),
(34204, 41205, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Chain Leggings'),
(34204, 41225, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Wristguards of Triumph'),
(34204, 41230, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Sabatons of Triumph'),
(34204, 41235, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Waistguard of Triumph'),
(34204, 41287, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Kodohide Gloves'),
(34204, 41293, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Wyrmhide Gloves'),
(34204, 41298, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Kodohide Legguards'),
(34204, 41304, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Wyrmhide Legguards'),
(34204, 41617, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Belt of Salvation'),
(34204, 41621, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Boots of Salvation'),
(34204, 41625, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Armwraps of Salvation'),
(34204, 41630, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Belt of Dominance'),
(34204, 41635, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Boots of Dominance'),
(34204, 41640, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Armwraps of Dominance'),
(34204, 41655, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Leather Legguards'),
(34204, 41667, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Dragonhide Legguards'),
(34204, 41767, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Leather Gloves'),
(34204, 41773, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Dragonhide Gloves'),
(34204, 41832, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Belt of Triumph'),
(34204, 41836, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Boots of Triumph'),
(34204, 41840, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Armwraps of Triumph'),
(34204, 41848, 0, 0, 0, 1, 1, 1, 1, 'Savage Gladiator\'s Mooncloth Hood'),
(34204, 41864, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Mooncloth Leggings'),
(34204, 41874, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Mooncloth Gloves'),
(34204, 41881, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cord of Salvation'),
(34204, 41885, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Slippers of Salvation'),
(34204, 41893, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cuffs of Salvation'),
(34204, 41898, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cord of Dominance'),
(34204, 41903, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Slippers of Dominance'),
(34204, 41909, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cuffs of Dominance'),
(34204, 41927, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Satin Leggings'),
(34204, 41940, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Satin Gloves'),
(34204, 41959, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Silk Trousers'),
(34204, 41971, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Silk Handguards'),
(34204, 42005, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Felweave Trousers'),
(34204, 42017, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Felweave Handguards'),
(34204, 42034, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Triumph'),
(34204, 42035, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Victory'),
(34204, 42036, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Dominance'),
(34204, 42037, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Ascendancy'),
(34204, 42038, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Subjugation'),
(34204, 42039, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Deliverance'),
(34204, 42040, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Salvation'),
(34204, 42069, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Dominance'),
(34204, 42070, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Subjugation'),
(34204, 42071, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Ascendancy'),
(34204, 42072, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Salvation'),
(34204, 42073, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Deliverance'),
(34204, 42074, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Triumph'),
(34204, 42075, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Cloak of Victory'),
(34204, 42116, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Band of Dominance'),
(34204, 42117, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Band of Triumph'),
(34204, 46373, 0, 0, 0, 1, 1, 1, 1, 'Furious Gladiator\'s Pendant of Sundering'),
(34210, 47750, 0, 0, 0, 1, 1, 1, 1, 'Khadgar\'s Leggings of Conquest'),
(34210, 47752, 0, 0, 0, 1, 1, 1, 1, 'Khadgar\'s Gauntlets of Conquest'),
(34210, 47783, 0, 0, 0, 1, 1, 1, 1, 'Kel\'Thuzad\'s Gloves of Conquest'),
(34210, 47785, 0, 0, 0, 1, 1, 1, 1, 'Kel\'Thuzad\'s Leggings of Conquest'),
(34210, 47980, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Leggings of Conquest'),
(34210, 47982, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Gloves of Conquest'),
(34210, 48072, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Handwraps of Conquest'),
(34210, 48074, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Pants of Conquest'),
(34210, 48130, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Leggings of Conquest'),
(34210, 48132, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Handguards of Conquest'),
(34210, 48160, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Trousers of Conquest'),
(34210, 48162, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Gloves of Conquest'),
(34210, 48213, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Handgrips of Conquest'),
(34210, 48215, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Legguards of Conquest'),
(34210, 48220, 0, 0, 0, 1, 1, 1, 1, 'VanCleef\'s Legplates of Conquest'),
(34210, 48222, 0, 0, 0, 1, 1, 1, 1, 'VanCleef\'s Gauntlets of Conquest'),
(34210, 48252, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Legguards of Conquest'),
(34210, 48254, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Handguards of Conquest'),
(34210, 48282, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Legguards of Conquest'),
(34210, 48284, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Handguards of Conquest'),
(34210, 48312, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Gloves of Conquest'),
(34210, 48314, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Kilt of Conquest'),
(34210, 48342, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Grips of Conquest'),
(34210, 48344, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s War-Kilt of Conquest'),
(34210, 48373, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Legplates of Conquest'),
(34210, 48375, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Gauntlets of Conquest'),
(34210, 48445, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Legguards of Conquest'),
(34210, 48449, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Handguards of Conquest'),
(34210, 48476, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Legplates of Conquest'),
(34210, 48480, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Gauntlets of Conquest'),
(34210, 48533, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Legguards of Conquest'),
(34210, 48537, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Handguards of Conquest'),
(34210, 48568, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Greaves of Conquest'),
(34210, 48574, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Gloves of Conquest'),
(34210, 48603, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Gauntlets of Conquest'),
(34210, 48605, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Legplates of Conquest'),
(34210, 48633, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Handguards of Conquest'),
(34210, 48635, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Legguards of Conquest'),
(34211, 47773, 0, 0, 0, 1, 1, 1, 1, 'Sunstrider\'s Gauntlets of Conquest'),
(34211, 47775, 0, 0, 0, 1, 1, 1, 1, 'Sunstrider\'s Leggings of Conquest'),
(34211, 47800, 0, 0, 0, 1, 1, 1, 1, 'Gul\'dan\'s Leggings of Conquest'),
(34211, 47802, 0, 0, 0, 1, 1, 1, 1, 'Gul\'dan\'s Gloves of Conquest'),
(34211, 48067, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Gloves of Conquest'),
(34211, 48069, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Leggings of Conquest'),
(34211, 48097, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Handwraps of Conquest'),
(34211, 48099, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Pants of Conquest'),
(34211, 48153, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Handguards of Conquest'),
(34211, 48155, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Leggings of Conquest'),
(34211, 48183, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Gloves of Conquest'),
(34211, 48185, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Trousers of Conquest'),
(34211, 48190, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Legguards of Conquest'),
(34211, 48192, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Handgrips of Conquest'),
(34211, 48244, 0, 0, 0, 1, 1, 1, 1, 'Garona\'s Gauntlets of Conquest'),
(34211, 48246, 0, 0, 0, 1, 1, 1, 1, 'Garona\'s Legplates of Conquest'),
(34211, 48276, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Handguards of Conquest'),
(34211, 48278, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Legguards of Conquest'),
(34211, 48296, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Handguards of Conquest'),
(34211, 48298, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Legguards of Conquest'),
(34211, 48337, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Gloves of Conquest'),
(34211, 48339, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Kilt of Conquest'),
(34211, 48367, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Grips of Conquest'),
(34211, 48369, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s War-Kilt of Conquest'),
(34211, 48387, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Gauntlets of Conquest'),
(34211, 48389, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Legplates of Conquest'),
(34211, 48457, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Handguards of Conquest'),
(34211, 48459, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Legguards of Conquest'),
(34211, 48502, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Gauntlets of Conquest'),
(34211, 48504, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Legplates of Conquest'),
(34211, 48559, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Handguards of Conquest'),
(34211, 48561, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Legguards of Conquest'),
(34211, 48596, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Greaves of Conquest'),
(34211, 48598, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Gloves of Conquest'),
(34211, 48628, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Legplates of Conquest'),
(34211, 48630, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Gauntlets of Conquest'),
(34211, 48653, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Handguards of Conquest'),
(34211, 48655, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Legguards of Conquest');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 35013);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35013, 34204, 34204, 100, 0, 1, 0, 1, 1, 'Koralon the Flame Watcher - (ReferenceTable)'),
(35013, 34210, 34210, 100, 0, 1, 0, 1, 1, 'Koralon the Flame Watcher - (ReferenceTable)'),
(35013, 34211, 34211, 100, 0, 1, 0, 1, 1, 'Koralon the Flame Watcher - (ReferenceTable)'),
(35013, 47241, 0, 100, 0, 1, 0, 2, 2, 'Koralon the Flame Watcher - Emblem of Triumph');

DELETE FROM `reference_loot_template` WHERE `Entry` IN (34205, 34212, 34213);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34205, 40810, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Plate Gauntlets'),
(34205, 40812, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Scaled Gauntlets'),
(34205, 40850, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Plate Legguards'),
(34205, 40851, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Dreadplate Legguards'),
(34205, 40852, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Scaled Legguards'),
(34205, 40883, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Girdle of Triumph'),
(34205, 40884, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Greaves of Triumph'),
(34205, 40890, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Bracers of Triumph'),
(34205, 40928, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Ornamented Gloves'),
(34205, 40940, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Ornamented Legplates'),
(34205, 40978, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Girdle of Salvation'),
(34205, 40979, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Greaves of Salvation'),
(34205, 40984, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Bracers of Salvation'),
(34205, 41002, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Ringmail Gauntlets'),
(34205, 41008, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Mail Gauntlets'),
(34205, 41028, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Ringmail Leggings'),
(34205, 41034, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Mail Leggings'),
(34205, 41052, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Waistguard of Salvation'),
(34205, 41056, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Sabatons of Salvation'),
(34205, 41061, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Wristguards of Salvation'),
(34205, 41066, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Wristguards of Dominance'),
(34205, 41071, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Waistguard of Dominance'),
(34205, 41076, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Sabatons of Dominance'),
(34205, 41138, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Linked Gauntlets'),
(34205, 41144, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Chain Gauntlets'),
(34205, 41200, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Linked Leggings'),
(34205, 41206, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Chain Leggings'),
(34205, 41226, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Wristguards of Triumph'),
(34205, 41231, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Sabatons of Triumph'),
(34205, 41236, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Waistguard of Triumph'),
(34205, 41288, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Kodohide Gloves'),
(34205, 41294, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Wyrmhide Gloves'),
(34205, 41299, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Kodohide Legguards'),
(34205, 41305, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Wyrmhide Legguards'),
(34205, 41618, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Belt of Salvation'),
(34205, 41622, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Boots of Salvation'),
(34205, 41626, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Armwraps of Salvation'),
(34205, 41631, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Belt of Dominance'),
(34205, 41636, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Boots of Dominance'),
(34205, 41641, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Armwraps of Dominance'),
(34205, 41656, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Leather Legguards'),
(34205, 41668, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Dragonhide Legguards'),
(34205, 41768, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Leather Gloves'),
(34205, 41774, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Dragonhide Gloves'),
(34205, 41833, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Belt of Triumph'),
(34205, 41837, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Boots of Triumph'),
(34205, 41841, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Armwraps of Triumph'),
(34205, 41865, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Mooncloth Leggings'),
(34205, 41875, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Mooncloth Gloves'),
(34205, 41882, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cord of Salvation'),
(34205, 41886, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Treads of Salvation'),
(34205, 41894, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cuffs of Salvation'),
(34205, 41899, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cord of Dominance'),
(34205, 41904, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Treads of Dominance'),
(34205, 41910, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cuffs of Dominance'),
(34205, 41928, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Satin Leggings'),
(34205, 41941, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Satin Gloves'),
(34205, 41960, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Silk Trousers'),
(34205, 41972, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Silk Handguards'),
(34205, 42006, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Felweave Trousers'),
(34205, 42018, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Felweave Handguards'),
(34205, 42041, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Triumph'),
(34205, 42042, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Victory'),
(34205, 42043, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Dominance'),
(34205, 42044, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Ascendancy'),
(34205, 42045, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Subjugation'),
(34205, 42046, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Deliverance'),
(34205, 42047, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Salvation'),
(34205, 42076, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Dominance'),
(34205, 42077, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Subjugation'),
(34205, 42078, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Ascendancy'),
(34205, 42079, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Salvation'),
(34205, 42080, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Deliverance'),
(34205, 42081, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Triumph'),
(34205, 42082, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Cloak of Victory'),
(34205, 42118, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Band of Ascendancy'),
(34205, 42119, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Band of Victory'),
(34205, 46374, 0, 0, 0, 1, 1, 1, 1, 'Relentless Gladiator\'s Pendant of Sundering'),
(34212, 47753, 0, 0, 0, 1, 1, 1, 1, 'Khadgar\'s Gauntlets of Triumph'),
(34212, 47755, 0, 0, 0, 1, 1, 1, 1, 'Khadgar\'s Leggings of Triumph'),
(34212, 47780, 0, 0, 0, 1, 1, 1, 1, 'Kel\'Thuzad\'s Leggings of Triumph'),
(34212, 47782, 0, 0, 0, 1, 1, 1, 1, 'Kel\'Thuzad\'s Gloves of Triumph'),
(34212, 47983, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Gloves of Triumph'),
(34212, 47985, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Leggings of Triumph'),
(34212, 48077, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Handwraps of Triumph'),
(34212, 48079, 0, 0, 0, 1, 1, 1, 1, 'Velen\'s Pants of Triumph'),
(34212, 48133, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Handguards of Triumph'),
(34212, 48135, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Leggings of Triumph'),
(34212, 48163, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Gloves of Triumph'),
(34212, 48165, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Trousers of Triumph'),
(34212, 48210, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Legguards of Triumph'),
(34212, 48212, 0, 0, 0, 1, 1, 1, 1, 'Malfurion\'s Handgrips of Triumph'),
(34212, 48224, 0, 0, 0, 1, 1, 1, 1, 'VanCleef\'s Gauntlets of Triumph'),
(34212, 48226, 0, 0, 0, 1, 1, 1, 1, 'VanCleef\'s Legplates of Triumph'),
(34212, 48256, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Handguards of Triumph'),
(34212, 48258, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Legguards of Triumph'),
(34212, 48286, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Handguards of Triumph'),
(34212, 48288, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Legguards of Triumph'),
(34212, 48317, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Gloves of Triumph'),
(34212, 48319, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Kilt of Triumph'),
(34212, 48347, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s Grips of Triumph'),
(34212, 48349, 0, 0, 0, 1, 1, 1, 1, 'Nobundo\'s War-Kilt of Triumph'),
(34212, 48377, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Gauntlets of Triumph'),
(34212, 48379, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Legplates of Triumph'),
(34212, 48446, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Legguards of Triumph'),
(34212, 48452, 0, 0, 0, 1, 1, 1, 1, 'Wrynn\'s Handguards of Triumph'),
(34212, 48482, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Gauntlets of Triumph'),
(34212, 48484, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Legplates of Triumph'),
(34212, 48539, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Handguards of Triumph'),
(34212, 48541, 0, 0, 0, 1, 1, 1, 1, 'Thassarian\'s Legguards of Triumph'),
(34212, 48576, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Gloves of Triumph'),
(34212, 48578, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Greaves of Triumph'),
(34212, 48608, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Gauntlets of Triumph'),
(34212, 48610, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Legplates of Triumph'),
(34212, 48638, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Legguards of Triumph'),
(34212, 48640, 0, 0, 0, 1, 1, 1, 1, 'Turalyon\'s Handguards of Triumph'),
(34213, 47770, 0, 0, 0, 1, 1, 1, 1, 'Sunstrider\'s Leggings of Triumph'),
(34213, 47772, 0, 0, 0, 1, 1, 1, 1, 'Sunstrider\'s Gauntlets of Triumph'),
(34213, 47803, 0, 0, 0, 1, 1, 1, 1, 'Gul\'dan\'s Gloves of Triumph'),
(34213, 47805, 0, 0, 0, 1, 1, 1, 1, 'Gul\'dan\'s Leggings of Triumph'),
(34213, 48064, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Leggings of Triumph'),
(34213, 48066, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Gloves of Triumph'),
(34213, 48094, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Pants of Triumph'),
(34213, 48096, 0, 0, 0, 1, 1, 1, 1, 'Zabra\'s Handwraps of Triumph'),
(34213, 48150, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Leggings of Triumph'),
(34213, 48152, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Handguards of Triumph'),
(34213, 48180, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Trousers of Triumph'),
(34213, 48182, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Gloves of Triumph'),
(34213, 48193, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Handgrips of Triumph'),
(34213, 48195, 0, 0, 0, 1, 1, 1, 1, 'Runetotem\'s Legguards of Triumph'),
(34213, 48239, 0, 0, 0, 1, 1, 1, 1, 'Garona\'s Legplates of Triumph'),
(34213, 48241, 0, 0, 0, 1, 1, 1, 1, 'Garona\'s Gauntlets of Triumph'),
(34213, 48271, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Legguards of Triumph'),
(34213, 48273, 0, 0, 0, 1, 1, 1, 1, 'Windrunner\'s Handguards of Triumph'),
(34213, 48301, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Handguards of Triumph'),
(34213, 48303, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Legguards of Triumph'),
(34213, 48332, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Kilt of Triumph'),
(34213, 48334, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Gloves of Triumph'),
(34213, 48362, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s War-Kilt of Triumph'),
(34213, 48364, 0, 0, 0, 1, 1, 1, 1, 'Thrall\'s Grips of Triumph'),
(34213, 48392, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Gauntlets of Triumph'),
(34213, 48394, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Legplates of Triumph'),
(34213, 48462, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Handguards of Triumph'),
(34213, 48464, 0, 0, 0, 1, 1, 1, 1, 'Hellscream\'s Legguards of Triumph'),
(34213, 48497, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Legplates of Triumph'),
(34213, 48499, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Gauntlets of Triumph'),
(34213, 48554, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Legguards of Triumph'),
(34213, 48556, 0, 0, 0, 1, 1, 1, 1, 'Koltira\'s Handguards of Triumph'),
(34213, 48591, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Greaves of Triumph'),
(34213, 48593, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Gloves of Triumph'),
(34213, 48623, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Legplates of Triumph'),
(34213, 48625, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Gauntlets of Triumph'),
(34213, 48658, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Handguards of Triumph'),
(34213, 48660, 0, 0, 0, 1, 1, 1, 1, 'Liadrin\'s Legguards of Triumph');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 35360);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35360, 34205, 34205, 100, 0, 1, 0, 2, 2, 'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360, 2, 34203, 1, 0, 1, 0, 1, 1, 'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360, 34212, 34212, 100, 0, 1, 0, 2, 2, 'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360, 34213, 34213, 100, 0, 1, 0, 2, 2, 'Koralon the Flame Watcher (1) - (ReferenceTable)'),
(35360, 47241, 0, 100, 0, 1, 0, 2, 2, 'Koralon the Flame Watcher (1) - Emblem of Triumph');

UPDATE `conditions` SET `SourceGroup` = 34212 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 34205 AND `SourceEntry` IN (47753,47755,47780,47782,47983,47985,48077,48079,48133,48135,48163,48165,48210,48212,48224,48226,48256,48258,48286,48288,48317,48319,48347,48349,48377,48379,48446,48452,48482,48484,48539,48541,48576,48578,48608,48610,48638,48640);

UPDATE `conditions` SET `SourceGroup` = 34213 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 34205 AND `SourceEntry` IN (47770,47772,47803,47805,48064,48066,48094,48096,48150,48152,48180,48182,48193,48195,48239,48241,48271,48273,48301,48303,48332,48334,48362,48364,48392,48394,48462,48464,48497,48499,48554,48556,48591,48593,48623,48625,48658,48660);

UPDATE `conditions` SET `SourceGroup` = 34210 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 34204 AND `SourceEntry` IN (47750,47752,47783,47785,47980,47982,48072,48074,48130,48132,48160,48162,48213,48215,48220,48222,48252,48254,48282,48284,48312,48314,48342,48344,48373,48375,48445,48449,48476,48480,48533,48537,48568,48574,48603,48605,48633,48635);

UPDATE `conditions` SET `SourceGroup` = 34211 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 34204 AND `SourceEntry` IN (47773,47775,47800,47802,48067,48069,48097,48099,48153,48155,48183,48185,48190,48192,48244,48246,48276,48278,48296,48298,48337,48339,48367,48369,48387,48389,48457,48459,48502,48504,48559,48561,48596,48598,48628,48630,48653,48655);

-- Worldserver fixes
DELETE FROM `creature_loot_template` WHERE (`Entry` = 29380) AND (`Item` IN (26001, 26002, 26012, 26013, 26014, 26015, 26028));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29380, 26001, 26001, 3, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26002, 26002, 3, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26012, 26012, 1, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26013, 26013, 1, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26014, 26014, 1, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26015, 26015, 1, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)'),
(29380, 26028, 26028, 0.5, 0, 1, 0, 1, 1, 'Stormforged War Golem - (ReferenceTable)');

-- Now useless
DELETE FROM `reference_loot_template` WHERE `Entry` = 1276883;
-- Rename to not mess up things in the future soont(tm)
UPDATE `reference_loot_template` SET `Entry` = 34214 WHERE `Entry` = 1276884;
UPDATE `creature_loot_template` SET `Reference` = 34214 WHERE `Entry` = 17968 AND `Item` = 34069 AND `Reference` = 1276884 AND `GroupId`=3;
-- Hacked Quest Item?
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 10) AND (`SourceGroup` = 44003) AND (`SourceEntry` = 34090) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11236) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 10) AND (`SourceGroup` = 44004) AND (`SourceEntry` = 34091) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 9) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11264) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

-- Thorium Prospecting was the only ever entry with negative References
UPDATE `prospecting_loot_template` SET `Reference` = 13001 WHERE `Entry` = 10620 AND `Item` = 1 AND `Reference` = -13001;

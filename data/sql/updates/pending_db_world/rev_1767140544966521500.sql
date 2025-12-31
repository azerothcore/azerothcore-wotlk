--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 20169) AND (`Item` IN (12018, 43002));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20169, 12018, 12018, 100, 0, 1, 0, 1, 1, 'Hungarfen (1) - (ReferenceTable)'),
(20169, 43002, 43002, 25, 0, 1, 0, 1, 1, 'Hungarfen (1) - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17808) AND (`Item` IN (34063, 34065));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17808, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Anetheron - (ReferenceTable)'),
(17808, 34065, 34065, 100, 0, 1, 0, 2, 2, 'Anetheron - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22898) AND (`Item` IN (34069, 34071, 190069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22898, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Supremus - (ReferenceTable)'),
(22898, 34071, 34071, 100, 0, 1, 0, 2, 2, 'Supremus - (ReferenceTable)'),
(22898, 190069, 34069, 2, 0, 1, 0, 1, 1, 'Supremus - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 1911) AND (`Item` IN (2, 4303));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1911, 2, 1011212, 10, 0, 1, 0, 1, 1, 'World Drop - White World Drop - NPC Levels: 12-12'),
(1911, 4303, 0, 50, 0, 1, 1, 1, 1, 'Deeb - Cranial Thumper');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14517) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14517, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Jeklik - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11492) AND (`Item` IN (35017));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11492, 35017, 35017, 100, 0, 1, 0, 2, 2, 'Alzzin the Wildshaper - (ReferenceTable)');

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

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22947) AND (`Item` IN (34076, 90069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22947, 34076, 34076, 100, 0, 1, 0, 3, 3, 'Mother Shahraz - (ReferenceTable)'),
(22947, 90069, 34069, 10, 0, 1, 3, 1, 1, 'Mother Shahraz - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22917) AND (`Item` IN (32837, 32838, 34069, 34077, 90069, 90077));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22917, 32837, 0, 5, 0, 1, 0, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 32838, 0, 5, 0, 1, 0, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 34077, 34077, 100, 0, 1, 0, 2, 2, 'Illidan Stormrage - (Items)'),
(22917, 90069, 34069, 10, 0, 1, 0, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 90077, 1276883, 100, 0, 1, 0, 3, 3, 'Illidan Stormrage - (Tokens)');

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

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14323) AND (`Item` IN (35016, 35018));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14323, 35016, 35016, 100, 0, 1, 0, 1, 1, 'Guard Slip\'kik - (ReferenceTable)'),
(14323, 35018, 35018, 100, 0, 1, 0, 1, 1, 'Guard Slip\'kik - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11380) AND (`Item` IN (34087, 34089));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11380, 34087, 34087, 100, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - (ReferenceTable)'),
(11380, 34089, 34089, 100, 0, 1, 0, 2, 2, 'Jin\'do the Hexxer - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17842) AND (`Item` IN (34063, 34067));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17842, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Azgalor - (ReferenceTable)'),
(17842, 34067, 34067, 100, 0, 1, 0, 3, 3, 'Azgalor - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 11501) AND (`Item` IN (35016, 35019));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11501, 35016, 35016, 2, 0, 1, 0, 1, 1, 'King Gordok - (ReferenceTable)'),
(11501, 35019, 35019, 100, 0, 1, 0, 2, 2, 'King Gordok - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 24018) AND (`Item` IN (44003, 44004));
-- Redundant Loot
-- INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
-- (24018, 44003, 44003, 100, 0, 1, 0, 1, 1, 'Necro Overlord Mezhen - (ReferenceTable)'),
-- (24018, 44004, 44004, 100, 0, 1, 0, 1, 1, 'Necro Overlord Mezhen - (ReferenceTable)');

DELETE FROM `reference_loot_template` WHERE (`Entry` IN (44003, 44004));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14888) AND (`Item` IN (34002, 34005, 190003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14888, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Lethon - (ReferenceTable)'),
(14888, 34005, 34005, 100, 0, 1, 0, 2, 2, 'Lethon - (ReferenceTable)'),
(14888, 190003, 34003, 100, 0, 1, 0, 1, 1, 'Lethon - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 4830) AND (`Item` IN (24070));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4830, 24070, 24070, 5, 0, 1, 0, 1, 1, 'Old Serra\'kis - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22948) AND (`Item` IN (34069, 34074, 90069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22948, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Gurtogg Bloodboil - (ReferenceTable)'),
(22948, 34074, 34074, 100, 0, 1, 0, 2, 2, 'Gurtogg Bloodboil - (ReferenceTable)'),
(22948, 90069, 34069, 10, 0, 1, 0, 1, 1, 'Gurtogg Bloodboil - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 5837) AND (`Item` IN (2));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5837, 2, 1011515, 10, 0, 1, 0, 1, 1, 'World Drop - White World Drop - NPC Levels: 15-15');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 6109) AND (`Item` IN (34002, 34004, 190003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6109, 34002, 34002, 100, 0, 1, 0, 3, 3, 'Azuregos - (ReferenceTable)'),
(6109, 34004, 34004, 100, 0, 1, 0, 2, 2, 'Azuregos - (ReferenceTable)'),
(6109, 190003, 34003, 100, 0, 1, 0, 2, 2, 'Azuregos - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14509) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14509, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priest Thekal - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14890) AND (`Item` IN (34002, 34007, 190003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14890, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Taerar - (ReferenceTable)'),
(14890, 34007, 34007, 100, 0, 1, 0, 2, 2, 'Taerar - (ReferenceTable)'),
(14890, 190003, 34003, 100, 0, 1, 0, 1, 1, 'Taerar - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 10440) AND (`Item` IN (35028));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10440, 35028, 35028, 100, 0, 1, 0, 2, 2, 'Baron Rivendare - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14326) AND (`Item` IN (35018));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14326, 35018, 35018, 100, 0, 1, 0, 1, 1, 'Guard Mol\'dar - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15340) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15340, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Moam - (ReferenceTable)'),
(15340, 190024, 34024, 1, 0, 1, 0, 1, 1, '');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14510) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14510, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14515) AND (`Item` IN (34086));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14515, 34086, 34086, 100, 0, 1, 0, 1, 1, 'High Priestess Arlokk - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14887) AND (`Item` IN (34002, 34008, 190003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14887, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Ysondre - (ReferenceTable)'),
(14887, 34008, 34008, 100, 0, 1, 0, 2, 2, 'Ysondre - (ReferenceTable)'),
(14887, 190003, 34003, 100, 0, 1, 0, 1, 1, 'Ysondre - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 14889) AND (`Item` IN (34002, 34006, 190003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14889, 34002, 34002, 100, 0, 1, 0, 2, 2, 'Emeriss - (ReferenceTable)'),
(14889, 34006, 34006, 100, 0, 1, 0, 2, 2, 'Emeriss - (ReferenceTable)'),
(14889, 190003, 34003, 100, 0, 1, 0, 1, 1, 'Emeriss - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15114) AND (`Item` IN (34003));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15114, 34003, 34003, 100, 0, 1, 0, 1, 1, 'Gahz\'ranka - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 25166) AND (`Item` IN (34081, 34085));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25166, 34081, 34081, 100, 0, 1, 0, 1, 1, 'Grand Warlock Alythess - (ReferenceTable 2)'),
(25166, 34085, 34085, 100, 0, 1, 0, 4, 4, 'Grand Warlock Alythess - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 15348) AND (`Item` IN (34024, 190024));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15348, 34024, 34024, 100, 0, 1, 0, 2, 2, 'Kurinnaxx - (ReferenceTable)'),
(15348, 190024, 34024, 1, 0, 1, 0, 1, 1, '');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17767) AND (`Item` IN (34063, 34064));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17767, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Rage Winterchill - (ReferenceTable)'),
(17767, 34064, 34064, 100, 0, 1, 0, 2, 2, 'Rage Winterchill - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 17888) AND (`Item` IN (34063, 34066));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17888, 34063, 34063, 2, 0, 1, 0, 1, 1, 'Kaz\'rogal - (ReferenceTable)'),
(17888, 34066, 34066, 100, 0, 1, 0, 2, 2, 'Kaz\'rogal - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22841) AND (`Item` IN (34069, 34072, 190069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22841, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Shade of Akama - (ReferenceTable)'),
(22841, 34072, 34072, 100, 0, 1, 0, 2, 2, 'Shade of Akama - (ReferenceTable)'),
(22841, 190069, 34069, 2, 0, 1, 0, 1, 1, 'Shade of Akama - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22871) AND (`Item` IN (34069, 34073, 190069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22871, 34069, 34069, 10, 0, 1, 0, 1, 1, 'Teron Gorefiend - (ReferenceTable)'),
(22871, 34073, 34073, 100, 0, 1, 0, 2, 2, 'Teron Gorefiend - (ReferenceTable)'),
(22871, 190069, 34069, 2, 0, 1, 0, 1, 1, 'Teron Gorefiend - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22887) AND (`Item` IN (34069, 34070, 90069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22887, 34069, 34069, 2, 0, 1, 0, 1, 1, 'High Warlord Naj\'entus - (ReferenceTable)'),
(22887, 34070, 34070, 100, 0, 1, 0, 2, 2, 'High Warlord Naj\'entus - (ReferenceTable)'),
(22887, 90069, 34069, 10, 0, 1, 0, 1, 1, 'High Warlord Naj\'entus - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 23420) AND (`Item` IN (34069, 34075, 90069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23420, 34069, 34069, 2, 0, 1, 0, 1, 1, 'Essence of Anger - (ReferenceTable)'),
(23420, 34075, 34075, 100, 0, 1, 0, 2, 2, 'Essence of Anger - (ReferenceTable)'),
(23420, 90069, 34069, 10, 0, 1, 0, 1, 1, 'Essence of Anger - (ReferenceTable)');

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

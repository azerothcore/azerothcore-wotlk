-- DB update 2022_12_14_00 -> 2022_12_16_00
-- Delete old HFP Trash loot table
DELETE FROM `creature_loot_template` WHERE `entry`=17370 AND `Comment` LIKE '%Hellfire Channeler%';
DELETE FROM `creature_loot_template` WHERE `entry`=17259 AND `Comment` LIKE '%Bonechewer Hungerer%';

SET @HELLFIRENORMAL := 17370;
SET @HELLFIREHEROIC := 18608;

DELETE FROM `creature_loot_template` WHERE `Entry`=@HELLFIREHEROIC AND `Comment` LIKE '%Hellfire Dungeons (Heroic)%';
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@HELLFIREHEROIC, 1, 24000, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 2, 24002, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 3, 24003, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 4, 24011, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 5, 24022, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 6, 24023, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 7, 24724, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - (ReferenceTable)'),
(@HELLFIREHEROIC, 5759, 0, 0.25, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - Thorium Lockbox'),
(@HELLFIREHEROIC, 5760, 0, 0.3, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - Eternium Lockbox'),
(@HELLFIREHEROIC, 8766, 0, 5, 0, 1, 0, 1, 3, 'Hellfire Dungeons (Heroic) - Morning Glory Dew'),
(@HELLFIREHEROIC, 8952, 0, 10, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Heroic) - Roasted Quail'),
(@HELLFIREHEROIC, 14047, 0, 40, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Heroic) - Runecloth'),
(@HELLFIREHEROIC, 21877, 0, 20, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Heroic) - Netherweave Cloth'),
(@HELLFIREHEROIC, 23894, 0, 100, 1, 1, 0, 1, 1, 'Hellfire Dungeons (Heroic) - Fel Orc Blood Vial');

DELETE FROM `creature_loot_template` WHERE `Entry`=@HELLFIRENORMAL AND `Comment` LIKE '%Hellfire Dungeons (Normal)%';
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@HELLFIRENORMAL, 1, 24000, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 2, 24002, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 3, 24003, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 4, 24022, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 5, 24023, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 6, 24724, 5, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - (ReferenceTable)'),
(@HELLFIRENORMAL, 5759, 0, 0.25, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - Thorium Lockbox'),
(@HELLFIRENORMAL, 5760, 0, 0.3, 0, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - Eternium Lockbox'),
(@HELLFIRENORMAL, 8766, 0, 5, 0, 1, 0, 1, 3, 'Hellfire Dungeons (Normal) - Morning Glory Dew'),
(@HELLFIRENORMAL, 8952, 0, 10, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Normal) - Roasted Quail'),
(@HELLFIRENORMAL, 14047, 0, 40, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Normal) - Runecloth'),
(@HELLFIRENORMAL, 21877, 0, 20, 0, 1, 0, 1, 4, 'Hellfire Dungeons (Normal) - Netherweave Cloth'),
(@HELLFIRENORMAL, 23894, 0, 100, 1, 1, 0, 1, 1, 'Hellfire Dungeons (Normal) - Fel Orc Blood Vial');

UPDATE `creature_template` SET `lootid`=@HELLFIRENORMAL WHERE `entry` IN (
17370, -- Laughing Skull Enforcer
17371, -- Shadowmoon Warlock
17395, -- Shadowmoon Summoner
17397, -- Shadowmoon Adept
17398, -- Nascent Fel Orc
17399, -- Seductress
17414, -- Shadowmoon Technician
17429, -- Fel Orc Neophyte
17477, -- Hellfire Imp
17491, -- Laughing Skull Rogue
17624, -- Laughing Skull Warden
17626, -- Laughing Skull Legionnaire
17653, -- Shadowmoon Channeler
18894, -- Felguard Brute
19016, -- Hellfire Familiar

17259, -- Bonechewer Hungerer
17264, -- Bonechewer Ravener
17269, -- Bleeding Hollow Darkcaster
17270, -- Bleeding Hollow Archer
17271, -- Bonechewer Destroyer
17280, -- Shattered Hand Warhound
17281, -- Bonechewer Ripper
17309, -- Hellfire Watcher
17455, -- Bonechewer Beastmaster
17478, -- Bleeding Hollow Scryer
17517  -- Hellfire Sentry
);

UPDATE `creature_template` SET `lootid`=@HELLFIREHEROIC WHERE `entry` IN (
17256, -- Hellfire Channeler
18603, -- Fel Orc Neophyte (1)
18606, -- Hellfire Imp (1)
18608, -- Laughing Skull Enforcer (1)
18609, -- Laughing Skull Legionnaire (1)
18610, -- Laughing Skull Rogue (1)
18611, -- Laughing Skull Warden (1)
18612, -- Nascent Fel Orc (1)
18614, -- Seductress (1)
18615, -- Shadowmoon Adept (1)
18617, -- Shadowmoon Summoner (1)
18618, -- Shadowmoon Technician (1)
18619, -- Shadowmoon Warlock (1)
18620, -- Shadowmoon Channeler (1)
21645, -- Felguard Brute (1)
21646, -- Hellfire Familiar (1)

18048, -- Bleeding Hollow Archer (1)
18049, -- Bleeding Hollow Darkcaster (1)
18050, -- Bleeding Hollow Scryer (1)
18051, -- Bonechewer Beastmaster (1)
18052, -- Bonechewer Destroyer (1)
18053, -- Bonechewer Hungerer (1)
18054, -- Bonechewer Ravener (1)
18055, -- Bonechewer Ripper (1)
18057, -- Hellfire Sentry (1)
18058, -- Hellfire Watcher (1)
18059  -- Shattered Hand Warhound (1)
);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (20191,20181,20192,20179,20180,20193,20177) AND `Comment` LIKE '%(Heroic)%';
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20191, 5760, 0, 0.4293, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Eternium Lockbox'),
(20191, 13444, 0, 10, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Major Mana Potion'),
(20191, 17057, 0, 30.0247, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Shiny Fish Scales'),
(20191, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Wrathfin Myrmidon (Heroic) - (ReferenceTable)'),
(20191, 24476, 0, 26.8447, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Jaggal Clam'),
(20191, 27858, 0, 4.3735, 0, 1, 0, 1, 3, 'Wrathfin Myrmidon (Heroic) - Sunspring Carp'),
(20191, 27860, 0, 0.7059, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Purified Draenic Water'),
(20191, 28399, 0, 1.3099, 0, 1, 0, 1, 1, 'Wrathfin Myrmidon (Heroic) - Filtered Draenic Water'),
(20192, 5760, 0, 0.5544, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Eternium Lockbox'),
(20192, 13926, 0, 0.0426, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Golden Pearl'),
(20192, 17057, 0, 29.9574, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Shiny Fish Scales'),
(20192, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Wrathfin Sentry (Heroic) - (ReferenceTable)'),
(20192, 24476, 0, 26.951, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Jaggal Clam'),
(20192, 27858, 0, 4.4136, 0, 1, 0, 1, 3, 'Wrathfin Sentry (Heroic) - Sunspring Carp'),
(20192, 27860, 0, 0.597, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Purified Draenic Water'),
(20192, 28399, 0, 1.3859, 0, 1, 0, 1, 1, 'Wrathfin Sentry (Heroic) - Filtered Draenic Water'),
(20181, 5760, 0, 0.399, 0, 1, 0, 1, 1, 'Murkblood Tribesman (Heroic) - Eternium Lockbox'),
(20181, 14047, 0, 11.0668, 0, 1, 0, 1, 3, 'Murkblood Tribesman (Heroic) - Runecloth'),
(20181, 21877, 0, 24.581, 0, 1, 0, 1, 3, 'Murkblood Tribesman (Heroic) - Netherweave Cloth'),
(20181, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20181, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20181, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20181, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20181, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20181, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Murkblood Tribesman (Heroic) - (ReferenceTable)'),
(20180, 5760, 0, 0.3308, 0, 1, 0, 1, 1, 'Murkblood Spearman (Heroic) - Eternium Lockbox'),
(20180, 14047, 0, 11.658, 0, 1, 0, 1, 3, 'Murkblood Spearman (Heroic) - Runecloth'),
(20180, 19264, 0, 0.0301, 0, 1, 0, 1, 1, 'Murkblood Spearman (Heroic) - Seven of Warlords'),
(20180, 19265, 0, 0.0301, 0, 1, 0, 1, 1, 'Murkblood Spearman (Heroic) - Eight of Warlords'),
(20180, 21877, 0, 26.1327, 0, 1, 0, 1, 3, 'Murkblood Spearman (Heroic) - Netherweave Cloth'),
(20180, 23077, 0, 8.3, 0, 1, 0, 1, 1, 'Murkblood Spearman (Heroic) - Blood Garnet'),
(20180, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20180, 24015, 24015, 0.1, 0, 1, 1, 1, 1, 'Murkblood Spearman (Heroic) - (ReferenceTable)'),
(20177, 5760, 0, 0.4093, 0, 1, 0, 1, 1, 'Murkblood Healer (Heroic) - Eternium Lockbox'),
(20177, 14047, 0, 12.257, 0, 1, 0, 1, 3, 'Murkblood Healer (Heroic) - Runecloth'),
(20177, 21877, 0, 25.9466, 0, 1, 0, 1, 3, 'Murkblood Healer (Heroic) - Netherweave Cloth'),
(20177, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20177, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Murkblood Healer (Heroic) - (ReferenceTable)'),
(20193, 5760, 0, 0.4097, 0, 1, 0, 1, 1, 'Wrathfin Warrior (Heroic) - Eternium Lockbox'),
(20193, 17057, 0, 30.2716, 0, 1, 0, 1, 1, 'Wrathfin Warrior (Heroic) - Shiny Fish Scales'),
(20193, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24006, 24006, 0.5, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Wrathfin Warrior (Heroic) - (ReferenceTable)'),
(20193, 24476, 0, 26.7365, 0, 1, 0, 1, 1, 'Wrathfin Warrior (Heroic) - Jaggal Clam'),
(20193, 27858, 0, 3.9447, 0, 1, 0, 1, 3, 'Wrathfin Warrior (Heroic) - Sunspring Carp'),
(20193, 27860, 0, 0.6479, 0, 1, 0, 1, 1, 'Wrathfin Warrior (Heroic) - Purified Draenic Water'),
(20193, 28399, 0, 1.4007, 0, 1, 0, 1, 1, 'Wrathfin Warrior (Heroic) - Filtered Draenic Water'),
(20179, 5760, 0, 0.2729, 0, 1, 0, 1, 1, 'Murkblood Oracle (Heroic) - Eternium Lockbox'),
(20179, 14047, 0, 11.6251, 0, 1, 0, 1, 3, 'Murkblood Oracle (Heroic) - Runecloth'),
(20179, 19272, 0, 0.0546, 0, 1, 0, 1, 1, 'Murkblood Oracle (Heroic) - Five of Elementals'),
(20179, 19281, 0, 0.0546, 0, 1, 0, 1, 1, 'Murkblood Oracle (Heroic) - Five of Portals'),
(20179, 21877, 0, 25.8289, 0, 1, 0, 1, 3, 'Murkblood Oracle (Heroic) - Netherweave Cloth'),
(20179, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)'),
(20179, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Murkblood Oracle (Heroic) - (ReferenceTable)');

DELETE FROM `creature_loot_template` WHERE `Reference` IN (24011, 24013) AND `entry` IN (
17726, -- Wrathfin Myrmidon
17727, -- Wrathfin Sentry
17728, -- Murkblood Tribesman
17729, -- Murkblood Spearman
17730, -- Murkblood Healer
17735, -- Wrathfin Warrior
17771  -- Murkblood Oracle
);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (
20191, -- Wrathfin Myrmidon (1)
20181, -- Murkblood Tribesman (1)
20192, -- Wrathfin Sentry (1)
20179, -- Murkblood Oracle (1)
20180, -- Murkblood Spearman (1)
20193, -- Wrathfin Warrior (1)
20177  -- Murkblood Healer (1)
);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (19884,19885,19886,19887,19888,19889,19890,19891,19892,19902,19903,19904,21842,21843) AND `Comment` LIKE '%(Heroic)%';
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19884, 5760, 0, 0.3975, 0, 1, 0, 1, 1, 'Bogstrok (Heroic) - Eternium Lockbox'),
(19884, 17057, 0, 27.7822, 0, 1, 0, 1, 1, 'Bogstrok (Heroic) - Shiny Fish Scales'),
(19884, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Bogstrok (Heroic) - (ReferenceTable)'),
(19884, 24476, 0, 25.308, 0, 1, 0, 1, 1, 'Bogstrok (Heroic) - Jaggal Clam'),
(19884, 25429, 0, 39.7407, 0, 1, 0, 2, 4, 'Bogstrok (Heroic) - Grime-encrusted Scale'),
(19884, 25431, 0, 9.4793, 0, 1, 0, 2, 4, 'Bogstrok (Heroic) - Ripped Fin'),
(19884, 27858, 0, 3.9298, 0, 1, 0, 1, 3, 'Bogstrok (Heroic) - Sunspring Carp'),
(19884, 27860, 0, 0.8545, 0, 1, 0, 1, 1, 'Bogstrok (Heroic) - Purified Draenic Water'),
(19884, 28399, 0, 0.9936, 0, 1, 0, 1, 1, 'Bogstrok (Heroic) - Filtered Draenic Water'),
(19892, 5760, 0, 0.2995, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Eternium Lockbox'),
(19892, 13444, 0, 5.6, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Major Mana Potion'),
(19892, 13446, 0, 5.6, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Major Healing Potion'),
(19892, 17057, 0, 29.0775, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Shiny Fish Scales'),
(19892, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Greater Bogstrok (Heroic) - (ReferenceTable)'),
(19892, 24476, 0, 27.1326, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Jaggal Clam'),
(19892, 27858, 0, 4.0562, 0, 1, 0, 1, 3, 'Greater Bogstrok (Heroic) - Sunspring Carp'),
(19892, 27860, 0, 1.0723, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Purified Draenic Water'),
(19892, 28399, 0, 0.9614, 0, 1, 0, 1, 1, 'Greater Bogstrok (Heroic) - Filtered Draenic Water'),
(19888, 5760, 0, 0.2787, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Eternium Lockbox'),
(19888, 13444, 0, 10, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Major Mana Potion'),
(19888, 17057, 0, 30.5575, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Shiny Fish Scales'),
(19888, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24092, 24092, 0.5, 0, 1, 1, 1, 1, 'Coilfang Observer (Heroic) - (ReferenceTable)'),
(19888, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Coilfang Armaments'),
(19888, 24476, 0, 26.8728, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Jaggal Clam'),
(19888, 27858, 0, 4.5122, 0, 1, 0, 1, 3, 'Coilfang Observer (Heroic) - Sunspring Carp'),
(19888, 27860, 0, 0.9233, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Purified Draenic Water'),
(19888, 28399, 0, 1.1672, 0, 1, 0, 1, 1, 'Coilfang Observer (Heroic) - Filtered Draenic Water'),
(19891, 5760, 0, 0.3228, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Eternium Lockbox'),
(19891, 13444, 0, 4.2, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Major Mana Potion'),
(19891, 13446, 0, 4.2, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Major Healing Potion'),
(19891, 17057, 0, 30.3009, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Shiny Fish Scales'),
(19891, 21929, 0, 4.2, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Flame Spessarite'),
(19891, 23077, 0, 4.2, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Blood Garnet'),
(19891, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24093, 24093, 0.5, 0, 1, 1, 1, 1, 'Coilfang Technician (Heroic) - (ReferenceTable)'),
(19891, 24476, 0, 26.8472, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Jaggal Clam'),
(19891, 27858, 0, 4.4222, 0, 1, 0, 1, 3, 'Coilfang Technician (Heroic) - Sunspring Carp'),
(19891, 27860, 0, 0.8863, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Purified Draenic Water'),
(19891, 28399, 0, 1.1238, 0, 1, 0, 1, 1, 'Coilfang Technician (Heroic) - Filtered Draenic Water'),
(19885, 5760, 0, 0.2373, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Eternium Lockbox'),
(19885, 17057, 0, 30.3552, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Shiny Fish Scales'),
(19885, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Coilfang Champion (Heroic) - (ReferenceTable)'),
(19885, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Coilfang Armaments'),
(19885, 24476, 0, 27.159, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Jaggal Clam'),
(19885, 27858, 0, 4.3359, 0, 1, 0, 1, 3, 'Coilfang Champion (Heroic) - Sunspring Carp'),
(19885, 27860, 0, 1.0319, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Purified Draenic Water'),
(19885, 28399, 0, 1.0534, 0, 1, 0, 1, 1, 'Coilfang Champion (Heroic) - Filtered Draenic Water'),
(19886, 5760, 0, 0.3168, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Eternium Lockbox'),
(19886, 17057, 0, 29.8401, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Shiny Fish Scales'),
(19886, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Coilfang Defender (Heroic) - (ReferenceTable)'),
(19886, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Coilfang Armaments'),
(19886, 24476, 0, 26.9991, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Jaggal Clam'),
(19886, 27858, 0, 4.4658, 0, 1, 0, 1, 3, 'Coilfang Defender (Heroic) - Sunspring Carp'),
(19886, 27860, 0, 1.0424, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Purified Draenic Water'),
(19886, 28399, 0, 1.1803, 0, 1, 0, 1, 1, 'Coilfang Defender (Heroic) - Filtered Draenic Water'),
(19889, 5760, 0, 0.2226, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Eternium Lockbox'),
(19889, 17057, 0, 30.5772, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Shiny Fish Scales'),
(19889, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Coilfang Slavehandler (Heroic) - (ReferenceTable)'),
(19889, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Coilfang Armaments'),
(19889, 24476, 0, 26.8167, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Jaggal Clam'),
(19889, 27858, 0, 4.3568, 0, 1, 0, 1, 3, 'Coilfang Slavehandler (Heroic) - Sunspring Carp'),
(19889, 27860, 0, 0.8984, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Purified Draenic Water'),
(19889, 28399, 0, 1.2005, 0, 1, 0, 1, 1, 'Coilfang Slavehandler (Heroic) - Filtered Draenic Water'),
(19890, 5760, 0, 0.2813, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Eternium Lockbox'),
(19890, 17057, 0, 30.0042, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Shiny Fish Scales'),
(19890, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24012, 24012, 0.5, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Coilfang Soothsayer (Heroic) - (ReferenceTable)'),
(19890, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Coilfang Armaments'),
(19890, 24476, 0, 27.5848, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Jaggal Clam'),
(19890, 27858, 0, 4.7264, 0, 1, 0, 1, 3, 'Coilfang Soothsayer (Heroic) - Sunspring Carp'),
(19890, 27860, 0, 0.7737, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Purified Draenic Water'),
(19890, 28399, 0, 0.9847, 0, 1, 0, 1, 1, 'Coilfang Soothsayer (Heroic) - Filtered Draenic Water'),
(19887, 5760, 0, 0.3032, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Eternium Lockbox'),
(19887, 17057, 0, 30.7206, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Shiny Fish Scales'),
(19887, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Coilfang Enchantress (Heroic) - (ReferenceTable)'),
(19887, 24368, 0, 6, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Coilfang Armaments'),
(19887, 24476, 0, 26.5725, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Jaggal Clam'),
(19887, 27858, 0, 4.3675, 0, 1, 0, 1, 3, 'Coilfang Enchantress (Heroic) - Sunspring Carp'),
(19887, 27860, 0, 0.8709, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Purified Draenic Water'),
(19887, 28399, 0, 1.0967, 0, 1, 0, 1, 1, 'Coilfang Enchantress (Heroic) - Filtered Draenic Water'),
(19903, 5760, 0, 0.5039, 0, 1, 0, 1, 1, 'Coilfang Collaborator (Heroic) - Eternium Lockbox'),
(19903, 8766, 0, 2.4495, 0, 1, 0, 1, 1, 'Coilfang Collaborator (Heroic) - Morning Glory Dew'),
(19903, 8952, 0, 5.2981, 0, 1, 0, 1, 1, 'Coilfang Collaborator (Heroic) - Roasted Quail'),
(19903, 14047, 0, 15.0811, 0, 1, 0, 1, 3, 'Coilfang Collaborator (Heroic) - Runecloth'),
(19903, 21877, 0, 24.1606, 0, 1, 0, 1, 3, 'Coilfang Collaborator (Heroic) - Netherweave Cloth'),
(19903, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19903, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19903, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19903, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19903, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19903, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Coilfang Collaborator (Heroic) - (ReferenceTable)'),
(19902, 5760, 0, 0.2044, 0, 1, 0, 1, 1, 'Wastewalker Slave (Heroic) - Eternium Lockbox'),
(19902, 8766, 0, 1.0222, 0, 1, 0, 1, 1, 'Wastewalker Slave (Heroic) - Morning Glory Dew'),
(19902, 8952, 0, 1.9422, 0, 1, 0, 1, 1, 'Wastewalker Slave (Heroic) - Roasted Quail'),
(19902, 14047, 0, 7.2195, 0, 1, 0, 1, 3, 'Wastewalker Slave (Heroic) - Runecloth'),
(19902, 21877, 0, 25.5942, 0, 1, 0, 1, 3, 'Wastewalker Slave (Heroic) - Netherweave Cloth'),
(19902, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 24023, 24023, 1, 0, 1, 1, 1, 1, 'Wastewalker Slave (Heroic) - (ReferenceTable)'),
(19902, 27854, 0, 0.3067, 0, 1, 0, 1, 1, 'Wastewalker Slave (Heroic) - Smoked Talbuk Venison'),
(19902, 27860, 0, 0.1533, 0, 1, 0, 1, 1, 'Wastewalker Slave (Heroic) - Purified Draenic Water'),
(19904, 5760, 0, 0.2788, 0, 1, 0, 1, 1, 'Wastewalker Worker (Heroic) - Eternium Lockbox'),
(19904, 8766, 0, 1.1075, 0, 1, 0, 1, 1, 'Wastewalker Worker (Heroic) - Morning Glory Dew'),
(19904, 8952, 0, 1.9207, 0, 1, 0, 1, 1, 'Wastewalker Worker (Heroic) - Roasted Quail'),
(19904, 14047, 0, 5.824, 0, 1, 0, 1, 3, 'Wastewalker Worker (Heroic) - Runecloth'),
(19904, 21877, 0, 24.938, 0, 1, 0, 1, 3, 'Wastewalker Worker (Heroic) - Netherweave Cloth'),
(19904, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Wastewalker Worker (Heroic) - (ReferenceTable)'),
(19904, 27854, 0, 0.2943, 0, 1, 0, 1, 1, 'Wastewalker Worker (Heroic) - Smoked Talbuk Venison'),
(19904, 27860, 0, 0.1781, 0, 1, 0, 1, 1, 'Wastewalker Worker (Heroic) - Purified Draenic Water'),
(21842, 13926, 0, 0.2625, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Golden Pearl'),
(21842, 17057, 0, 22.5722, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Shiny Fish Scales'),
(21842, 17058, 0, 19.685, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Fish Oil'),
(21842, 22787, 0, 0.2625, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Ragveil'),
(21842, 22790, 0, 0.5249, 0, 1, 0, 1, 2, 'Coilfang Scale-Healer (Heroic) - Ancient Lichen'),
(21842, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Scale-Healer (Heroic) - (ReferenceTable)'),
(21842, 24368, 0, 12, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Coilfang Armaments'),
(21842, 24476, 0, 28.6089, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Jaggal Clam'),
(21842, 24478, 0, 33.333, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Jaggal Pearl'),
(21842, 27858, 0, 2.6247, 0, 1, 0, 1, 3, 'Coilfang Scale-Healer (Heroic) - Sunspring Carp'),
(21842, 27860, 0, 2.3622, 0, 1, 0, 1, 1, 'Coilfang Scale-Healer (Heroic) - Purified Draenic Water'),
(21843, 13926, 0, 0.1629, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Golden Pearl'),
(21843, 17057, 0, 26.2215, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Shiny Fish Scales'),
(21843, 17058, 0, 18.4039, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Fish Oil'),
(21843, 22790, 0, 0.4886, 0, 1, 0, 2, 3, 'Coilfang Tempest (Heroic) - Ancient Lichen'),
(21843, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Coilfang Tempest (Heroic) - (ReferenceTable)'),
(21843, 24368, 0, 12, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Coilfang Armaments'),
(21843, 24476, 0, 27.1987, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Jaggal Clam'),
(21843, 27858, 0, 3.0945, 0, 1, 0, 1, 3, 'Coilfang Tempest (Heroic) - Sunspring Carp'),
(21843, 27860, 0, 1.4658, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Purified Draenic Water'),
(21843, 31952, 0, 0.1629, 0, 1, 0, 1, 1, 'Coilfang Tempest (Heroic) - Khorium Lockbox');

DELETE FROM `creature_loot_template` WHERE `Reference` IN (24011, 24012, 24013) AND `entry` IN (
17816, -- Bogstrok
17817, -- Greater Bogstrok
17938, -- Coilfang Observer
17940, -- Coilfang Technician
17957, -- Coilfang Champion
17958, -- Coilfang Defender
17959, -- Coilfang Slavehandler
17960, -- Coilfang Soothsayer
17961, -- Coilfang Enchantress
17962, -- Coilfang Collaborator
17963, -- Wastewalker Slave
17964, -- Wastewalker Worker
18206, -- Wastewalker Captive
21126, -- Coilfang Scale-Healer
21127  -- Coilfang Tempest
);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (
19884, -- Bogstrok
19885, -- Coilfang Champion (1)
19886, -- Coilfang Defender (1)
19887, -- Coilfang Enchantress (1)
19888, -- Coilfang Observer (1)
19889, -- Coilfang Slavehandler (1)
19890, -- Coilfang Soothsayer (1)
19891, -- Coilfang Technician (1)
19892, -- Greater Bogstrok (1)
19902, -- Wastewalker Slave (1)
19903, -- Coilfang Collaborator (1)
19904, -- Wastewalker Worker (1)
21842, -- Coilfang Scale-Healer (1)
21843  -- Coilfang Tempest (1)
);

DELETE FROM `creature_loot_template` WHERE `Entry` IN (20255,20256,20258,20259,20260,20261,20264,20265) AND `Comment` LIKE '%(Heroic)%';
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20258, 5760, 0, 0.49, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Eternium Lockbox'),
(20258, 13444, 0, 0.52, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Major Mana Potion'),
(20258, 13446, 0, 1, 0, 1, 0, 1, 3, 'Ethereal Scavenger (Heroic) - Major Healing Potion'),
(20258, 14047, 0, 12.74, 0, 1, 0, 1, 3, 'Ethereal Scavenger (Heroic) - Runecloth'),
(20258, 21877, 0, 24.02, 0, 1, 0, 1, 3, 'Ethereal Scavenger (Heroic) - Netherweave Cloth'),
(20258, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Scavenger (Heroic) - (ReferenceTable)'),
(20258, 25217, 0, 0.07, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Sundering Axe'),
(20258, 27854, 0, 4.55, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Smoked Talbuk Venison'),
(20258, 27860, 0, 0.44, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Purified Draenic Water'),
(20258, 28399, 0, 1.91, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Filtered Draenic Water'),
(20258, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Ethereum Prison Key'),
(20258, 31952, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Scavenger (Heroic) - Khorium Lockbox'),
(20255, 5760, 0, 0.47, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Eternium Lockbox'),
(20255, 13444, 0, 0.47, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Major Mana Potion'),
(20255, 13446, 0, 1.04, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Major Healing Potion'),
(20255, 14047, 0, 13.85, 0, 1, 0, 1, 3, 'Ethereal Crypt Raider (Heroic) - Runecloth'),
(20255, 21877, 0, 23.57, 0, 1, 0, 1, 3, 'Ethereal Crypt Raider (Heroic) - Netherweave Cloth'),
(20255, 23107, 0, 0.14, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Shadow Draenite'),
(20255, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 24093, 24093, 0.5, 0, 1, 1, 1, 1, 'Ethereal Crypt Raider (Heroic) - (ReferenceTable)'),
(20255, 25217, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Sundering Axe'),
(20255, 27854, 0, 4.4, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Smoked Talbuk Venison'),
(20255, 27860, 0, 0.25, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Purified Draenic Water'),
(20255, 28399, 0, 2.12, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Filtered Draenic Water'),
(20255, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Ethereum Prison Key'),
(20255, 29550, 0, 0.03, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Tome of Conjure Water IX'),
(20255, 31837, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Codex: Prayer of Shadow Protection II'),
(20255, 31952, 0, 0.05, 0, 1, 0, 1, 1, 'Ethereal Crypt Raider (Heroic) - Khorium Lockbox'),
(20260, 5760, 0, 0.16, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Eternium Lockbox'),
(20260, 13444, 0, 0.57, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Major Mana Potion'),
(20260, 13446, 0, 1.09, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Major Healing Potion'),
(20260, 14047, 0, 13.49, 0, 1, 0, 1, 3, 'Ethereal Spellbinder (Heroic) - Runecloth'),
(20260, 21877, 0, 24.39, 0, 1, 0, 1, 3, 'Ethereal Spellbinder (Heroic) - Netherweave Cloth'),
(20260, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24007, 24007, 1, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Spellbinder (Heroic) - (ReferenceTable)'),
(20260, 27854, 0, 4.67, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Smoked Talbuk Venison'),
(20260, 27860, 0, 0.32, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Purified Draenic Water'),
(20260, 28399, 0, 1.99, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Filtered Draenic Water'),
(20260, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Ethereum Prison Key'),
(20260, 31837, 0, 0.08, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Codex: Prayer of Shadow Protection II'),
(20260, 31952, 0, 0.06, 0, 1, 0, 1, 1, 'Ethereal Spellbinder (Heroic) - Khorium Lockbox'),
(20259, 5760, 0, 0.5, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Eternium Lockbox'),
(20259, 13444, 0, 0.58, 0, 1, 0, 1, 2, 'Ethereal Sorcerer (Heroic) - Major Mana Potion'),
(20259, 13446, 0, 1.06, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Major Healing Potion'),
(20259, 14047, 0, 13.77, 0, 1, 0, 1, 3, 'Ethereal Sorcerer (Heroic) - Runecloth'),
(20259, 21877, 0, 24.16, 0, 1, 0, 1, 3, 'Ethereal Sorcerer (Heroic) - Netherweave Cloth'),
(20259, 21929, 0, 0.11, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Flame Spessarite'),
(20259, 22146, 0, 0.03, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Book: Gift of the Wild III'),
(20259, 23077, 0, 0.13, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Blood Garnet'),
(20259, 23079, 0, 0.11, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Deep Peridot'),
(20259, 23107, 0, 0.13, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Shadow Draenite'),
(20259, 23117, 0, 0.11, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Azure Moonstone'),
(20259, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24007, 24007, 1, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Sorcerer (Heroic) - (ReferenceTable)'),
(20259, 27854, 0, 4.68, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Smoked Talbuk Venison'),
(20259, 27860, 0, 0.29, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Purified Draenic Water'),
(20259, 28399, 0, 1.97, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Filtered Draenic Water'),
(20259, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Ethereum Prison Key'),
(20259, 29550, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Tome of Conjure Water IX'),
(20259, 31837, 0, 0.06, 0, 1, 0, 1, 1, 'Ethereal Sorcerer (Heroic) - Codex: Prayer of Shadow Protection II'),
(20264, 21877, 0, 66.7, 0, 1, 0, 1, 3, 'Nexus Stalker (Heroic) - Netherweave Cloth'),
(20264, 22532, 0, 0.01, 0, 1, 0, 1, 1, 'Nexus Stalker (Heroic) - Formula: Enchant Bracer (Heroic) - Restore Mana Prime'),
(20264, 23615, 0, 3.94, 0, 1, 0, 1, 1, 'Nexus Stalker (Heroic) - Plans: Swiftsteel Gloves'),
(20264, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Nexus Stalker (Heroic) - (ReferenceTable)'),
(20264, 24093, 24093, 0.5, 0, 1, 1, 1, 1, 'Nexus Stalker (Heroic) - (ReferenceTable)'),
(20261, 13444, 0, 0.56, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Major Mana Potion'),
(20261, 13446, 0, 0.87, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Major Healing Potion'),
(20261, 14047, 0, 13.73, 0, 1, 0, 1, 3, 'Ethereal Theurgist (Heroic) - Runecloth'),
(20261, 19264, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Seven of Warlords'),
(20261, 21877, 0, 24.46, 0, 1, 0, 1, 3, 'Ethereal Theurgist (Heroic) - Netherweave Cloth'),
(20261, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24007, 24007, 1, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Theurgist (Heroic) - (ReferenceTable)'),
(20261, 27854, 0, 4.66, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Smoked Talbuk Venison'),
(20261, 27860, 0, 0.2, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Purified Draenic Water'),
(20261, 28399, 0, 1.8, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Filtered Draenic Water'),
(20261, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Ethereum Prison Key'),
(20261, 29549, 0, 0.06, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Codex: Prayer of Fortitude III'),
(20261, 29550, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Tome of Conjure Water IX'),
(20261, 31837, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Codex: Prayer of Shadow Protection II'),
(20261, 31952, 0, 0.12, 0, 1, 0, 1, 1, 'Ethereal Theurgist (Heroic) - Khorium Lockbox'),
(20256, 5760, 0, 0.52, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Eternium Lockbox'),
(20256, 13444, 0, 0.51, 0, 1, 0, 1, 2, 'Ethereal Darkcaster (Heroic) - Major Mana Potion'),
(20256, 13446, 0, 1.02, 0, 1, 0, 1, 3, 'Ethereal Darkcaster (Heroic) - Major Healing Potion'),
(20256, 14047, 0, 13.3, 0, 1, 0, 1, 3, 'Ethereal Darkcaster (Heroic) - Runecloth'),
(20256, 21877, 0, 23.54, 0, 1, 0, 1, 3, 'Ethereal Darkcaster (Heroic) - Netherweave Cloth'),
(20256, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24001, 24001, 5, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24007, 24007, 1, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24013, 24013, 1, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 24035, 24035, 2, 0, 1, 1, 1, 1, 'Ethereal Darkcaster (Heroic) - (ReferenceTable)'),
(20256, 27854, 0, 4.5, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Smoked Talbuk Venison'),
(20256, 27860, 0, 0.34, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Purified Draenic Water'),
(20256, 28399, 0, 1.96, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Filtered Draenic Water'),
(20256, 29460, 0, 3, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Ethereum Prison Key'),
(20256, 29549, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Codex: Prayer of Fortitude III'),
(20256, 31501, 0, 0.04, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Tome of Conjure Food VIII'),
(20256, 31837, 0, 0.09, 0, 1, 0, 1, 1, 'Ethereal Darkcaster (Heroic) - Codex: Prayer of Shadow Protection II'),
(20265, 5760, 0, 0.2555, 0, 1, 0, 1, 1, 'Nexus Terror (Heroic) - Eternium Lockbox'),
(20265, 22577, 0, 17.8397, 0, 1, 0, 1, 4, 'Nexus Terror (Heroic) - Mote of Shadow'),
(20265, 22790, 0, 0.031, 0, 1, 0, 1, 3, 'Nexus Terror (Heroic) - Ancient Lichen'),
(20265, 24000, 24000, 5, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24002, 24002, 5, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24003, 24003, 1, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24005, 24005, 1, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24008, 24008, 0.5, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24009, 24009, 1, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24011, 24011, 1, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 24012, 24012, 0.5, 0, 1, 1, 1, 1, 'Nexus Terror (Heroic) - (ReferenceTable)'),
(20265, 27854, 0, 0.3097, 0, 1, 0, 1, 1, 'Nexus Terror (Heroic) - Smoked Talbuk Venison'),
(20265, 27860, 0, 0.1084, 0, 1, 0, 1, 1, 'Nexus Terror (Heroic) - Purified Draenic Water'),
(20265, 29460, 0, 3, 0, 1, 0, 1, 1, 'Nexus Terror (Heroic) - Ethereum Prison Key');

DELETE FROM `creature_loot_template` WHERE `Reference` IN (24011, 24012, 24013) AND `entry` IN (
18309, -- Ethereal Scavenger
18311, -- Ethereal Crypt Raider
18312, -- Ethereal Spellbinder
18313, -- Ethereal Sorcerer
18314, -- Nexus Stalker
18315, -- Ethereal Theurgist
18317, -- Ethereal Priest
18331, -- Ethereal Darkcaster
19307  -- Nexus Terror
);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN (
20255, -- Ethereal Crypt Raider (1)
20256, -- Ethereal Darkcaster (1)
20258, -- Ethereal Scavenger (1)
20259, -- Ethereal Sorcerer (1)
20260, -- Ethereal Spellbinder (1)
20261, -- Ethereal Theurgist (1)
20264, -- Nexus Stalker (1)
20265  -- Nexus Terror (1)
);

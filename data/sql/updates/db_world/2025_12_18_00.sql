-- DB update 2025_12_17_03 -> 2025_12_18_00
-- Rework WotLK Dungeon Trash Rares

-- Cleanup loose items
DELETE FROM `creature_loot_template` WHERE `Item` IN (36976,36977,36978,37364,37365,37366,35580,35579,37197,37290,37196,35666,35664,35665,37624,37625,37243,35616,35615,37624,37625,35641,35640,35639,37799,37800,37801,35652,35654,35653,37889,37890,37891,35594,35593,37647,37646,37648,35681,35683,35682,37673,37672,37671,36997,37000,36999,37856,37858,37857,37070,37069,37068,37410,37587,37590,37770,37780,37117,37116,37115);

-- Create References for Normal/Heroic

-- The Oculus 578
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1578000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1578000, 36976, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Normal'),
(1578000, 36977, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Normal'),
(1578000, 36978, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1578100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1578100, 37364, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Heroic'),
(1578100, 37365, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Heroic'),
(1578100, 37366, 0, 0, 0, 1, 1, 1, 1, 'The Oculus Trash Rare Heroic');

-- Utgarde Keep 574
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1574000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1574000, 35580, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Keep Trash Rare Normal'),
(1574000, 35579, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Keep Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1574100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1574100, 37197, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Keep Trash Rare Heroic'),
(1574100, 37290, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Keep Trash Rare Heroic'),
(1574100, 37196, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Keep Trash Rare Heroic');

-- Azjol-Nerub 601
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1601000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1601000, 35666, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Normal'),
(1601000, 35664, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Normal'),
(1601000, 35665, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1601100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1601100, 37624, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Heroic'),
(1601100, 37625, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Heroic'),
(1601100, 37243, 0, 0, 0, 1, 1, 1, 1, 'Azjol-Nerub Trash Rare Heroic');

-- Ahn'Kahet 619
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1619000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1619000, 35616, 0, 0, 0, 1, 1, 1, 1, 'Ahn\'Kahet Trash Rare Normal'),
(1619000, 35615, 0, 0, 0, 1, 1, 1, 1, 'Ahn\'Kahet Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1619100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1619100, 37624, 0, 0, 0, 1, 1, 1, 1, 'Ahn\'Kahet Trash Rare Heroic'),
(1619100, 37625, 0, 0, 0, 1, 1, 1, 1, 'Ahn\'Kahet Trash Rare Heroic');

-- Drak\'Tharon Keep 600
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1600000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1600000, 35641, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Normal'),
(1600000, 35640, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Normal'),
(1600000, 35639, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1600100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1600100, 37799, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Heroic'),
(1600100, 37800, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Heroic'),
(1600100, 37801, 0, 0, 0, 1, 1, 1, 1, 'Drak\'Tharon Keep Trash Rare Heroic');

-- The Violet Hold 608
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1608000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1608000, 35652, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normal'),
(1608000, 35654, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normal'),
(1608000, 35653, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1608100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1608100, 37889, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic'),
(1608100, 37890, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic'),
(1608100, 37891, 0, 0, 0, 1, 1, 1, 1, 'Violet Hold Trash Rare Heroic');

-- Gundrak 604
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1604000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1604000, 35594, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Normal'),
(1604000, 35593, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1604100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1604100, 37647, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroic'),
(1604100, 37646, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroic'),
(1604100, 37648, 0, 0, 0, 1, 1, 1, 1, 'Gundrak Trash Rare Heroic');

-- Halls of Stone 599
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1599000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1599000, 35681, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Normal'),
(1599000, 35683, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Normal'),
(1599000, 35682, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1599100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1599100, 37673, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Heroic'),
(1599100, 37672, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Heroic'),
(1599100, 37671, 0, 0, 0, 1, 1, 1, 1, 'Halls of Stone Trash Rare Heroic');

-- Halls of Lightning 602
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1602000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1602000, 36997, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Normal'),
(1602000, 37000, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Normal'),
(1602000, 36999, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1602100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1602100, 37856, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Heroic'),
(1602100, 37858, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Heroic'),
(1602100, 37857, 0, 0, 0, 1, 1, 1, 1, 'Halls of Lightning Trash Rare Heroic');

-- Utgarde Pinnacle 575
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1575000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1575000, 37070, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Normal'),
(1575000, 37069, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Normal'),
(1575000, 37068, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Normal');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 1575100);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1575100, 37410, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Heroic'),
(1575100, 37587, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Heroic'),
(1575100, 37590, 0, 0, 0, 1, 1, 1, 1, 'Utgarde Pinnacle Trash Rare Heroic');

-- Culling of Stratholme 595
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1595000);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1595000, 37117, 0, 0, 0, 1, 1, 1, 1, 'Culling of Stratholme Trash Rare Normal/Heroic'),
(1595000, 37116, 0, 0, 0, 1, 1, 1, 1, 'Culling of Stratholme Trash Rare Normal/Heroic'),
(1595000, 37115, 0, 0, 0, 1, 1, 1, 1, 'Culling of Stratholme Trash Rare Normal/Heroic');

-- Separate Normal/Heroic Tables
-- Splitting Loot for Dragonflayer Ironhelm (1) (30747)
UPDATE `creature_template` SET `lootid` = 30747 WHERE `entry` = 30747;

-- Splitting Loot for Bloodthirsty Tundra Wolf (1) (30762)
UPDATE `creature_template` SET `lootid` = 30762 WHERE `entry` = 30762;

-- Splitting Loot for Dragonflayer Deathseeker (1) (30764)
UPDATE `creature_template` SET `lootid` = 30764 WHERE `entry` = 30764;

-- Splitting Loot for Dragonflayer Fanatic (1) (30765)
UPDATE `creature_template` SET `lootid` = 30765 WHERE `entry` = 30765;

-- Splitting Loot for Dragonflayer Seer (1) (30766)
UPDATE `creature_template` SET `lootid` = 30766 WHERE `entry` = 30766;

-- Splitting Loot for Scourge Hulk (1) (30806)
UPDATE `creature_template` SET `lootid` = 30806 WHERE `entry` = 30806;

-- Splitting Loot for Ymirjar Berserker (1) (30816)
UPDATE `creature_template` SET `lootid` = 30816 WHERE `entry` = 30816;

-- Splitting Loot for Ymirjar Dusk Shaman (1) (30817)
UPDATE `creature_template` SET `lootid` = 30817 WHERE `entry` = 30817;

-- Splitting Loot for Ymirjar Flesh Hunter (1) (30818)
UPDATE `creature_template` SET `lootid` = 30818 WHERE `entry` = 30818;

-- Splitting Loot for Ymirjar Necromancer (1) (30820)
UPDATE `creature_template` SET `lootid` = 30820 WHERE `entry` = 30820;

-- Splitting Loot for Ymirjar Savage (1) (30821)
UPDATE `creature_template` SET `lootid` = 30821 WHERE `entry` = 30821;

-- Splitting Loot for Azure Inquisitor (1) (30901)
UPDATE `creature_template` SET `lootid` = 30901 WHERE `entry` = 30901;

-- Splitting Loot for Azure Ley-Whelp (1) (30902)
UPDATE `creature_template` SET `lootid` = 30902 WHERE `entry` = 30902;

-- Splitting Loot for Azure Spellbinder (1) (30904)
UPDATE `creature_template` SET `lootid` = 30904 WHERE `entry` = 30904;

-- Splitting Loot for Centrifuge Construct (1) (30905)
UPDATE `creature_template` SET `lootid` = 30905 WHERE `entry` = 30905;

-- Splitting Loot for Phantasmal Air (1) (30906)
UPDATE `creature_template` SET `lootid` = 30906 WHERE `entry` = 30906;

-- Splitting Loot for Phantasmal Mammoth (1) (30909)
UPDATE `creature_template` SET `lootid` = 30909 WHERE `entry` = 30909;

-- Splitting Loot for Phantasmal Murloc (1) (30910)
UPDATE `creature_template` SET `lootid` = 30910 WHERE `entry` = 30910;

-- Splitting Loot for Ring-Lord Conjurer (1) (30915)
UPDATE `creature_template` SET `lootid` = 30915 WHERE `entry` = 30915;

-- Splitting Loot for Ring-Lord Sorceress (1) (30916)
UPDATE `creature_template` SET `lootid` = 30916 WHERE `entry` = 30916;

-- Splitting Loot for Drakkari Battle Rider (1) (30925)
UPDATE `creature_template` SET `lootid` = 30925 WHERE `entry` = 30925;

-- Splitting Loot for Drakkari Earthshaker (1) (30926)
UPDATE `creature_template` SET `lootid` = 30926 WHERE `entry` = 30926;

-- Splitting Loot for Drakkari Fire Weaver (1) (30927)
UPDATE `creature_template` SET `lootid` = 30927 WHERE `entry` = 30927;

-- Splitting Loot for Drakkari God Hunter (1) (30929)
UPDATE `creature_template` SET `lootid` = 30929 WHERE `entry` = 30929;

-- Splitting Loot for Drakkari Golem (1) (30930)
UPDATE `creature_template` SET `lootid` = 30930 WHERE `entry` = 30930;

-- Splitting Loot for Drakkari Inciter (1) (30931)
UPDATE `creature_template` SET `lootid` = 30931 WHERE `entry` = 30931;

-- Splitting Loot for Drakkari Lancer (1) (30932)
UPDATE `creature_template` SET `lootid` = 30932 WHERE `entry` = 30932;

-- Splitting Loot for Drakkari Medicine Man (1) (30933)
UPDATE `creature_template` SET `lootid` = 30933 WHERE `entry` = 30933;

-- Splitting Loot for Drakkari Rhino (1) (30935)
UPDATE `creature_template` SET `lootid` = 30935 WHERE `entry` = 30935;

-- Splitting Loot for Drakkari Rhino (1) (30936)
UPDATE `creature_template` SET `lootid` = 30936 WHERE `entry` = 30936;

-- Splitting Loot for Living Mojo (1) (30938)
UPDATE `creature_template` SET `lootid` = 30938 WHERE `entry` = 30938;

-- Splitting Loot for Unyielding Constrictor (1) (30942)
UPDATE `creature_template` SET `lootid` = 30942 WHERE `entry` = 30942;

-- Splitting Loot for Blistering Steamrager (1) (30964)
UPDATE `creature_template` SET `lootid` = 30964 WHERE `entry` = 30964;

-- Splitting Loot for Hardened Steel Berserker (1) (30966)
UPDATE `creature_template` SET `lootid` = 30966 WHERE `entry` = 30966;

-- Splitting Loot for Hardened Steel Reaver (1) (30967)
UPDATE `creature_template` SET `lootid` = 30967 WHERE `entry` = 30967;

-- Splitting Loot for Hardened Steel Skycaller (1) (30968)
UPDATE `creature_template` SET `lootid` = 30968 WHERE `entry` = 30968;

-- Splitting Loot for Stormforged Construct (1) (30971)
UPDATE `creature_template` SET `lootid` = 30971 WHERE `entry` = 30971;

-- Splitting Loot for Stormforged Giant (1) (30972)
UPDATE `creature_template` SET `lootid` = 30972 WHERE `entry` = 30972;

-- Splitting Loot for Stormforged Mender (1) (30974)
UPDATE `creature_template` SET `lootid` = 30974 WHERE `entry` = 30974;

-- Splitting Loot for Stormforged Runeshaper (1) (30975)
UPDATE `creature_template` SET `lootid` = 30975 WHERE `entry` = 30975;

-- Splitting Loot for Stormforged Sentinel (1) (30976)
UPDATE `creature_template` SET `lootid` = 30976 WHERE `entry` = 30976;

-- Splitting Loot for Stormforged Tactician (1) (30977)
UPDATE `creature_template` SET `lootid` = 30977 WHERE `entry` = 30977;

-- Splitting Loot for Stormfury Revenant (1) (30978)
UPDATE `creature_template` SET `lootid` = 30978 WHERE `entry` = 30978;

-- Splitting Loot for Storming Vortex (1) (30979)
UPDATE `creature_template` SET `lootid` = 30979 WHERE `entry` = 30979;

-- Splitting Loot for Titanium Siegebreaker (1) (30980)
UPDATE `creature_template` SET `lootid` = 30980 WHERE `entry` = 30980;

-- Splitting Loot for Titanium Vanguard (1) (30981)
UPDATE `creature_template` SET `lootid` = 30981 WHERE `entry` = 30981;

-- Splitting Loot for Titanium Thunderer (1) (30982)
UPDATE `creature_template` SET `lootid` = 30982 WHERE `entry` = 30982;

-- Splitting Loot for Unbound Firestorm (1) (30983)
UPDATE `creature_template` SET `lootid` = 30983 WHERE `entry` = 30983;

-- Splitting Loot for Enraging Ghoul (1) (31178)
UPDATE `creature_template` SET `lootid` = 31178 WHERE `entry` = 31178;

-- Splitting Loot for Devouring Ghoul (1) (31179)
UPDATE `creature_template` SET `lootid` = 31179 WHERE `entry` = 31179;

-- Splitting Loot for Master Necromancer (1) (31180)
UPDATE `creature_template` SET `lootid` = 31180 WHERE `entry` = 31180;

-- Splitting Loot for Dark Necromancer (1) (31184)
UPDATE `creature_template` SET `lootid` = 31184 WHERE `entry` = 31184;

-- Splitting Loot for Crypt Fiend (1) (31187)
UPDATE `creature_template` SET `lootid` = 31187 WHERE `entry` = 31187;

-- Splitting Loot for Tomb Stalker (1) (31188)
UPDATE `creature_template` SET `lootid` = 31188 WHERE `entry` = 31188;

-- Splitting Loot for Patchwork Construct (1) (31199)
UPDATE `creature_template` SET `lootid` = 31199 WHERE `entry` = 31199;

-- Splitting Loot for Bile Golem (1) (31200)
UPDATE `creature_template` SET `lootid` = 31200 WHERE `entry` = 31200;

-- Splitting Loot for Acolyte (1) (31201)
UPDATE `creature_template` SET `lootid` = 31201 WHERE `entry` = 31201;

-- Splitting Loot for Infinite Adversary (1) (31202)
UPDATE `creature_template` SET `lootid` = 31202 WHERE `entry` = 31202;

-- Splitting Loot for Infinite Agent (1) (31203)
UPDATE `creature_template` SET `lootid` = 31203 WHERE `entry` = 31203;

-- Splitting Loot for Infinite Hunter (1) (31206)
UPDATE `creature_template` SET `lootid` = 31206 WHERE `entry` = 31206;

-- Splitting Loot for Darkweb Recluse (1) (31336)
UPDATE `creature_template` SET `lootid` = 31336 WHERE `entry` = 31336;

-- Splitting Loot for Drakkari Bat (1) (31337)
UPDATE `creature_template` SET `lootid` = 31337 WHERE `entry` = 31337;

-- Splitting Loot for Drakkari Commander (1) (31338)
UPDATE `creature_template` SET `lootid` = 31338 WHERE `entry` = 31338;

-- Splitting Loot for Drakkari Guardian (1) (31339)
UPDATE `creature_template` SET `lootid` = 31339 WHERE `entry` = 31339;

-- Splitting Loot for Drakkari Gutripper (1) (31340)
UPDATE `creature_template` SET `lootid` = 31340 WHERE `entry` = 31340;

-- Splitting Loot for Risen Drakkari Handler (1) (31342)
UPDATE `creature_template` SET `lootid` = 31342 WHERE `entry` = 31342;

-- Splitting Loot for Drakkari Scytheclaw (1) (31343)
UPDATE `creature_template` SET `lootid` = 31343 WHERE `entry` = 31343;

-- Splitting Loot for Drakkari Shaman (1) (31345)
UPDATE `creature_template` SET `lootid` = 31345 WHERE `entry` = 31345;

-- Splitting Loot for Ghoul Tormentor (1) (31347)
UPDATE `creature_template` SET `lootid` = 31347 WHERE `entry` = 31347;

-- Splitting Loot for Risen Drakkari Bat Rider (1) (31351)
UPDATE `creature_template` SET `lootid` = 31351 WHERE `entry` = 31351;

-- Splitting Loot for Risen Drakkari Death Knight (1) (31352)
UPDATE `creature_template` SET `lootid` = 31352 WHERE `entry` = 31352;

-- Splitting Loot for Risen Drakkari Soulmage (1) (31354)
UPDATE `creature_template` SET `lootid` = 31354 WHERE `entry` = 31354;

-- Splitting Loot for Risen Drakkari Warrior (1) (31355)
UPDATE `creature_template` SET `lootid` = 31355 WHERE `entry` = 31355;

-- Splitting Loot for Scourge Brute (1) (31357)
UPDATE `creature_template` SET `lootid` = 31357 WHERE `entry` = 31357;

-- Splitting Loot for Scourge Reanimator (1) (31359)
UPDATE `creature_template` SET `lootid` = 31359 WHERE `entry` = 31359;

-- Splitting Loot for Wretched Belcher (1) (31363)
UPDATE `creature_template` SET `lootid` = 31363 WHERE `entry` = 31363;

-- Splitting Loot for Dark Rune Elementalist (1) (31372)
UPDATE `creature_template` SET `lootid` = 31372 WHERE `entry` = 31372;

-- Splitting Loot for Dark Rune Giant (1) (31373)
UPDATE `creature_template` SET `lootid` = 31373 WHERE `entry` = 31373;

-- Splitting Loot for Dark Rune Scholar (1) (31374)
UPDATE `creature_template` SET `lootid` = 31374 WHERE `entry` = 31374;

-- Splitting Loot for Dark Rune Shaper (1) (31375)
UPDATE `creature_template` SET `lootid` = 31375 WHERE `entry` = 31375;

-- Splitting Loot for Dark Rune Theurgist (1) (31376)
UPDATE `creature_template` SET `lootid` = 31376 WHERE `entry` = 31376;

-- Splitting Loot for Dark Rune Warrior (1) (31377)
UPDATE `creature_template` SET `lootid` = 31377 WHERE `entry` = 31377;

-- Splitting Loot for Dark Rune Worker (1) (31378)
UPDATE `creature_template` SET `lootid` = 31378 WHERE `entry` = 31378;

-- Splitting Loot for Lightning Construct (1) (31383)
UPDATE `creature_template` SET `lootid` = 31383 WHERE `entry` = 31383;

-- Splitting Loot for Raging Construct (1) (31385)
UPDATE `creature_template` SET `lootid` = 31385 WHERE `entry` = 31385;

-- Splitting Loot for Unrelenting Construct (1) (31387)
UPDATE `creature_template` SET `lootid` = 31387 WHERE `entry` = 31387;

-- Splitting Loot for Ahn'kahar Slasher (1) (31442)
UPDATE `creature_template` SET `lootid` = 31442 WHERE `entry` = 31442;

-- Splitting Loot for Ahn'kahar Spell Flinger (1) (31443)
UPDATE `creature_template` SET `lootid` = 31443 WHERE `entry` = 31443;

-- Splitting Loot for Ahn'kahar Web Winder (1) (31450)
UPDATE `creature_template` SET `lootid` = 31450 WHERE `entry` = 31450;

-- Splitting Loot for Bonegrinder (1) (31451)
UPDATE `creature_template` SET `lootid` = 31451 WHERE `entry` = 31451;

-- Splitting Loot for Deep Crawler (1) (31455)
UPDATE `creature_template` SET `lootid` = 31455 WHERE `entry` = 31455;

-- Splitting Loot for Eye of Taldaram (1) (31457)
UPDATE `creature_template` SET `lootid` = 31457 WHERE `entry` = 31457;

-- Splitting Loot for Forgotten One (1) (31459)
UPDATE `creature_template` SET `lootid` = 31459 WHERE `entry` = 31459;

-- Splitting Loot for Frostbringer (1) (31460)
UPDATE `creature_template` SET `lootid` = 31460 WHERE `entry` = 31460;

-- Splitting Loot for Plague Walker (1) (31466)
UPDATE `creature_template` SET `lootid` = 31466 WHERE `entry` = 31466;

-- Splitting Loot for Plundering Geist (1) (31468)
UPDATE `creature_template` SET `lootid` = 31468 WHERE `entry` = 31468;

-- Splitting Loot for Savage Cave Beast (1) (31470)
UPDATE `creature_template` SET `lootid` = 31470 WHERE `entry` = 31470;

-- Splitting Loot for Twilight Apostle (1) (31471)
UPDATE `creature_template` SET `lootid` = 31471 WHERE `entry` = 31471;

-- Splitting Loot for Twilight Darkcaster (1) (31472)
UPDATE `creature_template` SET `lootid` = 31472 WHERE `entry` = 31472;

-- Splitting Loot for Azure Captain (1) (31486)
UPDATE `creature_template` SET `lootid` = 31486 WHERE `entry` = 31486;

-- Splitting Loot for Azure Raider (1) (31490)
UPDATE `creature_template` SET `lootid` = 31490 WHERE `entry` = 31490;

-- Splitting Loot for Azure Sorceror (1) (31493)
UPDATE `creature_template` SET `lootid` = 31493 WHERE `entry` = 31493;

-- Splitting Loot for Portal Guardian (1) (31502)
UPDATE `creature_template` SET `lootid` = 31502 WHERE `entry` = 31502;

-- Splitting Loot for Portal Keeper (1) (31504)
UPDATE `creature_template` SET `lootid` = 31504 WHERE `entry` = 31504;

-- Splitting Loot for Anub'ar Prime Guard (1) (31604)
UPDATE `creature_template` SET `lootid` = 31604 WHERE `entry` = 31604;

-- Splitting Loot for Anub'ar Skirmisher (1) (31606)
UPDATE `creature_template` SET `lootid` = 31606 WHERE `entry` = 31606;

-- Splitting Loot for Anub'ar Warrior (1) (31608)
UPDATE `creature_template` SET `lootid` = 31608 WHERE `entry` = 31608;

-- Splitting Loot for Anub'ar Webspinner (1) (31609)
UPDATE `creature_template` SET `lootid` = 31609 WHERE `entry` = 31609;

-- Splitting Loot for Dragonflayer Bonecrusher (1) (31658)
UPDATE `creature_template` SET `lootid` = 31658 WHERE `entry` = 31658;

-- Splitting Loot for Dragonflayer Forge Master (1) (31659)
UPDATE `creature_template` SET `lootid` = 31659 WHERE `entry` = 31659;

-- Splitting Loot for Dragonflayer Heartsplitter (1) (31660)
UPDATE `creature_template` SET `lootid` = 31660 WHERE `entry` = 31660;

-- Splitting Loot for Dragonflayer Metalworker (1) (31661)
UPDATE `creature_template` SET `lootid` = 31661 WHERE `entry` = 31661;

-- Splitting Loot for Dragonflayer Overseer (1) (31662)
UPDATE `creature_template` SET `lootid` = 31662 WHERE `entry` = 31662;

-- Splitting Loot for Dragonflayer Runecaster (1) (31663)
UPDATE `creature_template` SET `lootid` = 31663 WHERE `entry` = 31663;

-- Splitting Loot for Dragonflayer Strategist (1) (31666)
UPDATE `creature_template` SET `lootid` = 31666 WHERE `entry` = 31666;

-- Splitting Loot for Dragonflayer Weaponsmith (1) (31667)
UPDATE `creature_template` SET `lootid` = 31667 WHERE `entry` = 31667;

-- Splitting Loot for Enslaved Proto-Drake (1) (31669)
UPDATE `creature_template` SET `lootid` = 31669 WHERE `entry` = 31669;

-- Splitting Loot for Proto-Drake Handler (1) (31675)
UPDATE `creature_template` SET `lootid` = 31675 WHERE `entry` = 31675;

-- Splitting Loot for Azure Stalker (1) (32192)
UPDATE `creature_template` SET `lootid` = 32192 WHERE `entry` = 32192;

-- Create separate Loot Tables for Normal/Heroic
DELETE FROM `creature_loot_template` WHERE `Entry` IN (31666, 31663, 30747, 31658, 31660, 31661, 31659, 31667, 31675, 31669, 31662, 31676, 30764, 30765, 30766, 30806, 31339, 31347, 31337, 31357, 31363, 31336, 31359, 31343, 31355, 31354, 31342, 31351, 31345, 31340, 30821, 30818, 30762, 30817, 30816, 31352, 31338, 30901, 30904, 30902, 30916, 30915, 30905, 30909, 30910, 30906, 31178, 31201, 31180, 31187, 31199, 31202, 31206, 31203, 31377, 31378, 31372, 31376, 31374, 31375, 31373, 31385, 31387, 31383, 31188, 31184, 31200, 31179, 30820, 31665, 30979, 30967, 30966, 30968, 30977, 30974, 30964, 30983, 31608, 31606, 30978, 30971, 30975, 30976, 30981, 30972, 30980, 30982, 31604, 31609, 30942, 30932, 30929, 30927, 30933, 30926, 30938, 30930, 30925, 30935, 30931, 30936, 31471, 31450, 31442, 31443, 31455, 31466, 31451, 31457, 31460, 31468, 31472, 31470, 31459, 31501, 31486, 31493, 31490, 31503, 31502, 31504, 31449, 32192);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31666, 22829, 0, 2.8, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Super Healing Potion'),
(31666, 22832, 0, 1.3, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Super Mana Potion'),
(31666, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Dragonflayer Strategist - (ReferenceTable)'),
(31666, 26040, 26040, 31.3, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - (ReferenceTable)'),
(31666, 33390, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Icy Mail Armor'),
(31666, 33438, 0, 1, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Thread-Bare Hat'),
(31666, 33444, 0, 4.5, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Pungent Seal Whey'),
(31666, 33454, 0, 8.2, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Salted Venison'),
(31666, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Titanium Lockbox'),
(31666, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Book of Glyph Mastery'),
(31663, 22829, 0, 2.2, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Super Healing Potion'),
(31663, 22832, 0, 1.6, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Super Mana Potion'),
(31663, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Dragonflayer Runecaster - (ReferenceTable)'),
(31663, 26040, 26040, 29.2, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - (ReferenceTable)'),
(31663, 33358, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Thread-Bare Cloth Belt'),
(31663, 33444, 0, 4, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Pungent Seal Whey'),
(31663, 33454, 0, 9.5, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Salted Venison'),
(31663, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Titanium Lockbox'),
(31663, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Book of Glyph Mastery'),
(30747, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Super Healing Potion'),
(30747, 22832, 0, 1.3, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Super Mana Potion'),
(30747, 26040, 26040, 32.3, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - (ReferenceTable)'),
(30747, 31952, 0, 1.7, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Khorium Lockbox'),
(30747, 33444, 0, 5.3, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Pungent Seal Whey'),
(30747, 33454, 0, 9, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Salted Venison'),
(30747, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Titanium Lockbox'),
(30747, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Book of Glyph Mastery'),
(31658, 22829, 0, 2.5, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - Super Healing Potion'),
(31658, 26040, 26040, 30.8, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - (ReferenceTable)'),
(31658, 33444, 0, 4.4, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - Pungent Seal Whey'),
(31658, 33454, 0, 9.9, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - Salted Venison'),
(31658, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - Titanium Lockbox'),
(31658, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Bonecrusher - Book of Glyph Mastery'),
(31660, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Dragonflayer Heartsplitter - (ReferenceTable)'),
(31660, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dragonflayer Heartsplitter - (ReferenceTable)'),
(31660, 26040, 26040, 29, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - (ReferenceTable)'),
(31660, 33392, 0, 1.5, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Icy Mail Boots'),
(31660, 33423, 0, 1.3, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Rime-Covered Mace'),
(31660, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Pungent Seal Whey'),
(31660, 33454, 0, 9.1, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Salted Venison'),
(31660, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Titanium Lockbox'),
(31660, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Book of Glyph Mastery'),
(31661, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Super Healing Potion'),
(31661, 22832, 0, 1.7, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Super Mana Potion'),
(31661, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Dragonflayer Metalworker - (ReferenceTable)'),
(31661, 26040, 26040, 31.6, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - (ReferenceTable)'),
(31661, 31952, 0, 1.3, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Khorium Lockbox'),
(31661, 33395, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Icy Mail Pants'),
(31661, 33444, 0, 4.4, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Pungent Seal Whey'),
(31661, 33454, 0, 8.9, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Salted Venison'),
(31661, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Titanium Lockbox'),
(31661, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Book of Glyph Mastery'),
(31659, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Super Healing Potion'),
(31659, 26040, 26040, 28.5, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - (ReferenceTable)'),
(31659, 31952, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Khorium Lockbox'),
(31659, 33444, 0, 4.6, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Pungent Seal Whey'),
(31659, 33454, 0, 9.4, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Salted Venison'),
(31659, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Titanium Lockbox'),
(31659, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Book of Glyph Mastery'),
(31667, 22829, 0, 2.6, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Super Healing Potion'),
(31667, 22832, 0, 1.5, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Super Mana Potion'),
(31667, 26040, 26040, 29.7, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - (ReferenceTable)'),
(31667, 31952, 0, 1.4, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Khorium Lockbox'),
(31667, 33444, 0, 4.4, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Pungent Seal Whey'),
(31667, 33454, 0, 9.5, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Salted Venison'),
(31667, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Titanium Lockbox'),
(31667, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Book of Glyph Mastery'),
(31675, 22829, 0, 3.1, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Super Healing Potion'),
(31675, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Proto-Drake Handler - (ReferenceTable)'),
(31675, 26003, 26003, 2, 0, 1, 1, 1, 1, 'Proto-Drake Handler - (ReferenceTable)'),
(31675, 26004, 26004, 2, 0, 1, 1, 1, 1, 'Proto-Drake Handler - (ReferenceTable)'),
(31675, 26040, 26040, 29.5, 0, 1, 0, 1, 1, 'Proto-Drake Handler - (ReferenceTable)'),
(31675, 31952, 0, 1.1, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Khorium Lockbox'),
(31675, 33430, 0, 1.5, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Abandoned Greatsword'),
(31675, 33444, 0, 4.2, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Pungent Seal Whey'),
(31675, 33454, 0, 8.2, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Salted Venison'),
(31675, 36079, 0, 1.3, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Winterfin Cowl'),
(31675, 36669, 0, 1.1, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Eccentric Dagger'),
(31675, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Titanium Lockbox'),
(31675, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Book of Glyph Mastery'),
(31669, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Enslaved Proto-Drake - (ReferenceTable)'),
(31669, 26003, 26003, 2, 0, 1, 1, 1, 1, 'Enslaved Proto-Drake - (ReferenceTable)'),
(31669, 26004, 26004, 2, 0, 1, 1, 1, 1, 'Enslaved Proto-Drake - (ReferenceTable)'),
(31669, 26005, 26005, 2, 0, 1, 1, 1, 1, 'Enslaved Proto-Drake - (ReferenceTable)'),
(31669, 33423, 0, 2.7, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Rime-Covered Mace'),
(31669, 33431, 0, 2.8, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Icesmashing Mace'),
(31669, 36073, 0, 2.7, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Daggercap Spaulders'),
(31669, 36503, 0, 2.9, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Toothless Bludgeon'),
(31669, 36558, 0, 2.7, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Curved Scratcher'),
(31669, 39532, 0, 76.5, 0, 1, 0, 2, 4, 'Enslaved Proto-Drake - Caustic Claw'),
(31669, 39533, 0, 13, 0, 1, 0, 2, 4, 'Enslaved Proto-Drake - Trenchant Fang'),
(31669, 42106, 0, 33, 1, 1, 0, 1, 1, 'Enslaved Proto-Drake - Proto Dragon Bone'),
(31669, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Titanium Lockbox'),
(31669, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Enslaved Proto-Drake - Book of Glyph Mastery'),
(31662, 22829, 0, 2.2, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Super Healing Potion'),
(31662, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Dragonflayer Overseer - (ReferenceTable)'),
(31662, 26040, 26040, 30.5, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - (ReferenceTable)'),
(31662, 31952, 0, 1.2, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Khorium Lockbox'),
(31662, 33362, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Thread-Bare Cloth Pants'),
(31662, 33394, 0, 1.8, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Icy Mail Gloves'),
(31662, 33408, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Ice-Bound Plate Gloves'),
(31662, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Pungent Seal Whey'),
(31662, 33454, 0, 9.8, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Salted Venison'),
(31662, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Titanium Lockbox'),
(31662, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Book of Glyph Mastery'),
(31676, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Proto-Drake Rider (1) - Book of Glyph Mastery'),
(30764, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dragonflayer Deathseeker - (ReferenceTable)'),
(30764, 26040, 26040, 30.3, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - (ReferenceTable)'),
(30764, 33427, 0, 1, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Frost-Encrusted Rifle'),
(30764, 33429, 0, 1, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Ice Cleaver'),
(30764, 33445, 0, 3.4, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Honeymint Tea'),
(30764, 33454, 0, 5.9, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Salted Venison'),
(30764, 39152, 0, 1, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Manual: Heavy Frostweave Bandage'),
(30764, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Titanium Lockbox'),
(30764, 43852, 0, 19, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Thick Fur Clothing Scraps'),
(30764, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Book of Glyph Mastery'),
(30765, 26040, 26040, 32.1, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - (ReferenceTable)'),
(30765, 33445, 0, 4.1, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Honeymint Tea'),
(30765, 33454, 0, 8.6, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Salted Venison'),
(30765, 39152, 0, 1.6, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Manual: Heavy Frostweave Bandage'),
(30765, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Titanium Lockbox'),
(30765, 43852, 0, 18.7, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Thick Fur Clothing Scraps'),
(30765, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Book of Glyph Mastery'),
(30766, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dragonflayer Seer - (ReferenceTable)'),
(30766, 26040, 26040, 31.9, 0, 1, 0, 1, 1, 'Dragonflayer Seer - (ReferenceTable)'),
(30766, 33424, 0, 1.1, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Cracked Iron Staff'),
(30766, 33445, 0, 4.3, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Honeymint Tea'),
(30766, 33454, 0, 6.7, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Salted Venison'),
(30766, 39152, 0, 1.3, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Manual: Heavy Frostweave Bandage'),
(30766, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Titanium Lockbox'),
(30766, 43852, 0, 15.7, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Thick Fur Clothing Scraps'),
(30766, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Book of Glyph Mastery'),
(30806, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Scourge Hulk - (ReferenceTable)'),
(30806, 26040, 26040, 28.1, 0, 1, 0, 1, 1, 'Scourge Hulk - (ReferenceTable)'),
(30806, 33426, 0, 1.1, 0, 1, 0, 1, 1, 'Scourge Hulk - Chipped Timber Axe'),
(30806, 33445, 0, 3.2, 0, 1, 0, 1, 1, 'Scourge Hulk - Honeymint Tea'),
(30806, 35947, 0, 7.3, 0, 1, 0, 1, 1, 'Scourge Hulk - Sparkling Frostcap'),
(30806, 39152, 0, 1.4, 0, 1, 0, 1, 1, 'Scourge Hulk - Manual: Heavy Frostweave Bandage'),
(30806, 42108, 0, 33, 1, 1, 0, 1, 1, 'Scourge Hulk - Scourge Curio'),
(30806, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Scourge Hulk - Titanium Lockbox'),
(30806, 43852, 0, 17.4, 0, 1, 0, 1, 1, 'Scourge Hulk - Thick Fur Clothing Scraps'),
(30806, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Scourge Hulk - Book of Glyph Mastery'),
(31339, 26040, 26040, 4.1, 0, 1, 0, 1, 1, 'Drakkari Guardian - (ReferenceTable)'),
(31339, 38303, 0, 66, 0, 1, 0, 1, 1, 'Drakkari Guardian - Enduring Mojo'),
(31339, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Guardian - Titanium Lockbox'),
(31339, 43852, 0, 1.1, 0, 1, 0, 1, 1, 'Drakkari Guardian - Thick Fur Clothing Scraps'),
(31339, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Guardian - Book of Glyph Mastery'),
(31347, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Ghoul Tormentor - (ReferenceTable)'),
(31347, 26006, 26006, 2, 0, 1, 1, 1, 1, 'Ghoul Tormentor - (ReferenceTable)'),
(31347, 26008, 26008, 2, 0, 1, 1, 1, 1, 'Ghoul Tormentor - (ReferenceTable)'),
(31347, 26040, 26040, 31.9, 0, 1, 0, 1, 1, 'Ghoul Tormentor - (ReferenceTable)'),
(31347, 33437, 0, 1.1, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Icy Mail Circlet'),
(31347, 33444, 0, 3.6, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Pungent Seal Whey'),
(31347, 33452, 0, 7.2, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Honey-Spiced Lichen'),
(31347, 36095, 0, 1, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Wildevar Cap'),
(31347, 36110, 0, 1, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Vileprey Gloves'),
(31347, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ghoul Tormentor - Scourge Curio'),
(31347, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Titanium Lockbox'),
(31347, 43852, 0, 9, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Thick Fur Clothing Scraps'),
(31347, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ghoul Tormentor - Book of Glyph Mastery'),
(31337, 33569, 0, 74, 0, 1, 0, 1, 1, 'Drakkari Bat - Barbed Fang'),
(31337, 33571, 0, 15.6, 0, 1, 0, 1, 1, 'Drakkari Bat - Rending Talon'),
(31337, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Bat - Titanium Lockbox'),
(31337, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Bat - Book of Glyph Mastery'),
(31357, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Scourge Brute - (ReferenceTable)'),
(31357, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Scourge Brute - (ReferenceTable)'),
(31357, 26011, 26011, 2, 0, 1, 1, 1, 1, 'Scourge Brute - (ReferenceTable)'),
(31357, 26040, 26040, 32.6, 0, 1, 0, 1, 1, 'Scourge Brute - (ReferenceTable)'),
(31357, 33402, 0, 2.8, 0, 1, 0, 1, 1, 'Scourge Brute - Frigid Mail Pants'),
(31357, 33444, 0, 3.8, 0, 1, 0, 1, 1, 'Scourge Brute - Pungent Seal Whey'),
(31357, 33452, 0, 6.1, 0, 1, 0, 1, 1, 'Scourge Brute - Honey-Spiced Lichen'),
(31357, 36124, 0, 2.4, 0, 1, 0, 1, 1, 'Scourge Brute - Muradin Boots'),
(31357, 36250, 0, 2.4, 0, 1, 0, 1, 1, 'Scourge Brute - Mammoth Bindings'),
(31357, 42108, 0, 33, 1, 1, 0, 1, 1, 'Scourge Brute - Scourge Curio'),
(31357, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Scourge Brute - Titanium Lockbox'),
(31357, 43852, 0, 9.5, 0, 1, 0, 1, 1, 'Scourge Brute - Thick Fur Clothing Scraps'),
(31357, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Scourge Brute - Book of Glyph Mastery'),
(31363, 26007, 26007, 2, 0, 1, 1, 1, 1, 'Wretched Belcher - (ReferenceTable)'),
(31363, 26009, 26009, 2, 0, 1, 1, 1, 1, 'Wretched Belcher - (ReferenceTable)'),
(31363, 26040, 26040, 34.8, 0, 1, 0, 1, 1, 'Wretched Belcher - (ReferenceTable)'),
(31363, 33444, 0, 4.6, 0, 1, 0, 1, 1, 'Wretched Belcher - Pungent Seal Whey'),
(31363, 33452, 0, 6.2, 0, 1, 0, 1, 1, 'Wretched Belcher - Honey-Spiced Lichen'),
(31363, 36003, 0, 1.8, 0, 1, 0, 1, 1, 'Wretched Belcher - Icemist Sash'),
(31363, 36421, 0, 1.9, 0, 1, 0, 1, 1, 'Wretched Belcher - Devotional Band'),
(31363, 43852, 0, 7.7, 0, 1, 0, 1, 1, 'Wretched Belcher - Thick Fur Clothing Scraps'),
(31363, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Wretched Belcher - Book of Glyph Mastery'),
(31336, 33629, 0, 73.6, 0, 1, 0, 2, 4, 'Darkweb Recluse - Frosty Spinneret'),
(31336, 33630, 0, 17.3, 0, 1, 0, 2, 4, 'Darkweb Recluse - Icy Fang'),
(31336, 42253, 0, 11, 0, 1, 0, 1, 1, 'Darkweb Recluse - Iceweb Spider Silk'),
(31336, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Darkweb Recluse - Book of Glyph Mastery'),
(31359, 22832, 0, 3.1, 0, 1, 0, 1, 1, 'Scourge Reanimator - Super Mana Potion'),
(31359, 26009, 26009, 2, 0, 1, 1, 1, 1, 'Scourge Reanimator - (ReferenceTable)'),
(31359, 26040, 26040, 30.4, 0, 1, 0, 1, 1, 'Scourge Reanimator - (ReferenceTable)'),
(31359, 33444, 0, 3.6, 0, 1, 0, 1, 1, 'Scourge Reanimator - Pungent Seal Whey'),
(31359, 33452, 0, 6.8, 0, 1, 0, 1, 1, 'Scourge Reanimator - Honey-Spiced Lichen'),
(31359, 36409, 0, 2.1, 0, 1, 0, 1, 1, 'Scourge Reanimator - Crushed Velvet Cloak'),
(31359, 36675, 0, 2.4, 0, 1, 0, 1, 1, 'Scourge Reanimator - Sockeye Dagger'),
(31359, 43622, 0, 1, 0, 1, 0, 1, 1, 'Scourge Reanimator - Froststeel Lockbox'),
(31359, 43852, 0, 8.6, 0, 1, 0, 1, 1, 'Scourge Reanimator - Thick Fur Clothing Scraps'),
(31359, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Scourge Reanimator - Book of Glyph Mastery'),
(31343, 29567, 0, 10.7, 0, 1, 0, 1, 1, 'Drakkari Scytheclaw - Raptor Talon'),
(31343, 29568, 0, 4.4, 0, 1, 0, 1, 1, 'Drakkari Scytheclaw - Raptor War Feather'),
(31343, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Scytheclaw - Titanium Lockbox'),
(31343, 44782, 0, 61.1, 0, 1, 0, 3, 5, 'Drakkari Scytheclaw - Bent Raptor Talon'),
(31343, 44783, 0, 13.7, 0, 1, 0, 2, 4, 'Drakkari Scytheclaw - Blood-Soaked Raptor War Feather'),
(31343, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Scytheclaw - Book of Glyph Mastery'),
(31355, 22829, 0, 2.5, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Super Healing Potion'),
(31355, 22832, 0, 1.1, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Super Mana Potion'),
(31355, 26040, 26040, 32.8, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - (ReferenceTable)'),
(31355, 33444, 0, 3.7, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Pungent Seal Whey'),
(31355, 33452, 0, 8, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Honey-Spiced Lichen'),
(31355, 42108, 0, 33, 1, 1, 0, 1, 1, 'Risen Drakkari Warrior - Scourge Curio'),
(31355, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Titanium Lockbox'),
(31355, 43852, 0, 9.4, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Thick Fur Clothing Scraps'),
(31355, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Risen Drakkari Warrior - Book of Glyph Mastery'),
(31354, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Risen Drakkari Soulmage - (ReferenceTable)'),
(31354, 26040, 26040, 28.7, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - (ReferenceTable)'),
(31354, 33372, 0, 1.9, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Fur-Lined Armor'),
(31354, 33396, 0, 1.8, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Icy Mail Shoulderpads'),
(31354, 33444, 0, 4.7, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Pungent Seal Whey'),
(31354, 33452, 0, 7.5, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Honey-Spiced Lichen'),
(31354, 42108, 0, 33, 1, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Scourge Curio'),
(31354, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Recipe: Tasty Cupcake'),
(31354, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Recipe: Last Week\'s Mammoth'),
(31354, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Recipe: Bad Clams'),
(31354, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Recipe: Haunted Herring'),
(31354, 43622, 0, 1.3, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Froststeel Lockbox'),
(31354, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Titanium Lockbox'),
(31354, 43852, 0, 11.1, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Thick Fur Clothing Scraps'),
(31354, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Risen Drakkari Soulmage - Book of Glyph Mastery'),
(31342, 26008, 26008, 2, 0, 1, 1, 1, 1, 'Risen Drakkari Handler - (ReferenceTable)'),
(31342, 26009, 26009, 2, 0, 1, 1, 1, 1, 'Risen Drakkari Handler - (ReferenceTable)'),
(31342, 26040, 26040, 30.4, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - (ReferenceTable)'),
(31342, 33444, 0, 5.2, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Pungent Seal Whey'),
(31342, 33452, 0, 7.6, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Honey-Spiced Lichen'),
(31342, 36115, 0, 1.7, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Taunka Belt'),
(31342, 36331, 0, 1.4, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Grizzlemaw Belt'),
(31342, 42108, 0, 33, 1, 1, 0, 1, 1, 'Risen Drakkari Handler - Scourge Curio'),
(31342, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Titanium Lockbox'),
(31342, 43852, 0, 9.7, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Thick Fur Clothing Scraps'),
(31342, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Risen Drakkari Handler - Book of Glyph Mastery'),
(31351, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Risen Drakkari Bat Rider - (ReferenceTable)'),
(31351, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Risen Drakkari Bat Rider - (ReferenceTable)'),
(31351, 26040, 26040, 33, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - (ReferenceTable)'),
(31351, 33439, 0, 4, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Fur-Lined Leather Helmet'),
(31351, 33444, 0, 3.1, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Pungent Seal Whey'),
(31351, 33452, 0, 6.3, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Honey-Spiced Lichen'),
(31351, 36011, 0, 4.2, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Tethys Sash'),
(31351, 37757, 0, 4, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Charlotte\'s Chastizing Pauldrons'),
(31351, 42108, 0, 33, 1, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Scourge Curio'),
(31351, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Titanium Lockbox'),
(31351, 43852, 0, 7.9, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Thick Fur Clothing Scraps'),
(31351, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Risen Drakkari Bat Rider - Book of Glyph Mastery'),
(31345, 26040, 26040, 3.8, 0, 1, 0, 1, 1, 'Drakkari Shaman - (ReferenceTable)'),
(31345, 38303, 0, 67, 0, 1, 0, 1, 1, 'Drakkari Shaman - Enduring Mojo'),
(31345, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Shaman - Titanium Lockbox'),
(31345, 43852, 0, 1.2, 0, 1, 0, 1, 1, 'Drakkari Shaman - Thick Fur Clothing Scraps'),
(31345, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Shaman - Book of Glyph Mastery'),
(31340, 26000, 26000, 6, 0, 1, 1, 1, 1, 'Drakkari Gutripper - (ReferenceTable)'),
(31340, 26040, 26040, 28.7, 0, 1, 0, 1, 1, 'Drakkari Gutripper - (ReferenceTable)'),
(31340, 33393, 0, 1.4, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Icy Mail Bracers'),
(31340, 33438, 0, 1.2, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Thread-Bare Hat'),
(31340, 33444, 0, 3.6, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Pungent Seal Whey'),
(31340, 33452, 0, 5.7, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Honey-Spiced Lichen'),
(31340, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Titanium Lockbox'),
(31340, 43852, 0, 9.1, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Thick Fur Clothing Scraps'),
(31340, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Gutripper - Book of Glyph Mastery'),
(30821, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Ymirjar Savage - (ReferenceTable)'),
(30821, 26040, 26040, 30.9, 0, 1, 0, 1, 1, 'Ymirjar Savage - (ReferenceTable)'),
(30821, 33433, 0, 1.1, 0, 1, 0, 1, 1, 'Ymirjar Savage - Frigid Mail Circlet'),
(30821, 33445, 0, 3.6, 0, 1, 0, 1, 1, 'Ymirjar Savage - Honeymint Tea'),
(30821, 35947, 0, 6.4, 0, 1, 0, 1, 1, 'Ymirjar Savage - Sparkling Frostcap'),
(30821, 39152, 0, 1.4, 0, 1, 0, 1, 1, 'Ymirjar Savage - Manual: Heavy Frostweave Bandage'),
(30821, 41989, 0, 33, 1, 1, 0, 1, 1, 'Ymirjar Savage - Vrykul Amulet'),
(30821, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ymirjar Savage - Titanium Lockbox'),
(30821, 43852, 0, 18.8, 0, 1, 0, 1, 1, 'Ymirjar Savage - Thick Fur Clothing Scraps'),
(30821, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ymirjar Savage - Book of Glyph Mastery'),
(30818, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Ymirjar Flesh Hunter - (ReferenceTable)'),
(30818, 26040, 26040, 30.1, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - (ReferenceTable)'),
(30818, 33423, 0, 1.4, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Rime-Covered Mace'),
(30818, 33431, 0, 1.4, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Icesmashing Mace'),
(30818, 33445, 0, 4.2, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Honeymint Tea'),
(30818, 35947, 0, 7.2, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Sparkling Frostcap'),
(30818, 41989, 0, 33, 1, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Vrykul Amulet'),
(30818, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Titanium Lockbox'),
(30818, 43852, 0, 20.1, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Thick Fur Clothing Scraps'),
(30818, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ymirjar Flesh Hunter - Book of Glyph Mastery'),
(30762, 33546, 0, 2.8, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Vicious Fang'),
(30762, 33549, 0, 2.7, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Thick Tail Hair'),
(30762, 39211, 0, 65.4, 0, 1, 0, 3, 5, 'Bloodthirsty Tundra Wolf - Serrated Fang'),
(30762, 39212, 0, 15, 0, 1, 0, 2, 4, 'Bloodthirsty Tundra Wolf - Indurate Claw'),
(30762, 43011, 0, 39.8, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Worg Haunch'),
(30762, 43013, 0, 2.1, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Chilled Meat'),
(30762, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Titanium Lockbox'),
(30762, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Bloodthirsty Tundra Wolf - Book of Glyph Mastery'),
(30817, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Ymirjar Dusk Shaman - (ReferenceTable)'),
(30817, 26040, 26040, 31, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - (ReferenceTable)'),
(30817, 33426, 0, 1.4, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Chipped Timber Axe'),
(30817, 33429, 0, 1.1, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Ice Cleaver'),
(30817, 33445, 0, 4.8, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Honeymint Tea'),
(30817, 35947, 0, 8.8, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Sparkling Frostcap'),
(30817, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Scourge Curio'),
(30817, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Titanium Lockbox'),
(30817, 43852, 0, 17.6, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Thick Fur Clothing Scraps'),
(30817, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ymirjar Dusk Shaman - Book of Glyph Mastery'),
(30816, 26040, 26040, 32.4, 0, 1, 0, 1, 1, 'Ymirjar Berserker - (ReferenceTable)'),
(30816, 33445, 0, 3.3, 0, 1, 0, 1, 1, 'Ymirjar Berserker - Honeymint Tea'),
(30816, 35947, 0, 7.4, 0, 1, 0, 1, 1, 'Ymirjar Berserker - Sparkling Frostcap'),
(30816, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ymirjar Berserker - Scourge Curio'),
(30816, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ymirjar Berserker - Titanium Lockbox'),
(30816, 43852, 0, 16.8, 0, 1, 0, 1, 1, 'Ymirjar Berserker - Thick Fur Clothing Scraps'),
(30816, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ymirjar Berserker - Book of Glyph Mastery'),
(31352, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Super Healing Potion'),
(31352, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Risen Drakkari Death Knight - (ReferenceTable)'),
(31352, 26040, 26040, 32.2, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - (ReferenceTable)'),
(31352, 33427, 0, 1.3, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Frost-Encrusted Rifle'),
(31352, 33431, 0, 1.2, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Icesmashing Mace'),
(31352, 33444, 0, 3.7, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Pungent Seal Whey'),
(31352, 33452, 0, 8.9, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Honey-Spiced Lichen'),
(31352, 42108, 0, 33, 1, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Scourge Curio'),
(31352, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Titanium Lockbox'),
(31352, 43852, 0, 9, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Thick Fur Clothing Scraps'),
(31352, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Risen Drakkari Death Knight - Book of Glyph Mastery'),
(31338, 26009, 26009, 2, 0, 1, 1, 1, 1, 'Drakkari Commander - (ReferenceTable)'),
(31338, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Drakkari Commander - (ReferenceTable)'),
(31338, 26040, 26040, 27.9, 0, 1, 0, 1, 1, 'Drakkari Commander - (ReferenceTable)'),
(31338, 33444, 0, 4.6, 0, 1, 0, 1, 1, 'Drakkari Commander - Pungent Seal Whey'),
(31338, 33454, 0, 6.4, 0, 1, 0, 1, 1, 'Drakkari Commander - Salted Venison'),
(31338, 36350, 0, 4.2, 0, 1, 0, 1, 1, 'Drakkari Commander - Jormungar Gauntlets'),
(31338, 36423, 0, 1, 0, 1, 0, 1, 1, 'Drakkari Commander - Posy Ring'),
(31338, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Commander - Titanium Lockbox'),
(31338, 43852, 0, 10.6, 0, 1, 0, 1, 1, 'Drakkari Commander - Thick Fur Clothing Scraps'),
(31338, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Commander - Book of Glyph Mastery'),
(30901, 26040, 26040, 30.1, 0, 1, 0, 1, 1, 'Azure Inquisitor - (ReferenceTable)'),
(30901, 33445, 0, 4.5, 0, 1, 0, 1, 1, 'Azure Inquisitor - Honeymint Tea'),
(30901, 33454, 0, 8.6, 0, 1, 0, 1, 1, 'Azure Inquisitor - Salted Venison'),
(30901, 39152, 0, 2.2, 0, 1, 0, 1, 1, 'Azure Inquisitor - Manual: Heavy Frostweave Bandage'),
(30901, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Inquisitor - Titanium Lockbox'),
(30901, 43852, 0, 15.7, 0, 1, 0, 1, 1, 'Azure Inquisitor - Thick Fur Clothing Scraps'),
(30901, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Inquisitor - Book of Glyph Mastery'),
(30904, 26040, 26040, 34.2, 0, 1, 0, 1, 1, 'Azure Spellbinder - (ReferenceTable)'),
(30904, 33445, 0, 3.3, 0, 1, 0, 1, 1, 'Azure Spellbinder - Honeymint Tea'),
(30904, 33454, 0, 8.1, 0, 1, 0, 1, 1, 'Azure Spellbinder - Salted Venison'),
(30904, 39152, 0, 1.7, 0, 1, 0, 1, 1, 'Azure Spellbinder - Manual: Heavy Frostweave Bandage'),
(30904, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Spellbinder - Titanium Lockbox'),
(30904, 43852, 0, 15.4, 0, 1, 0, 1, 1, 'Azure Spellbinder - Thick Fur Clothing Scraps'),
(30904, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Spellbinder - Book of Glyph Mastery'),
(30902, 33631, 0, 72.8, 0, 1, 0, 2, 3, 'Azure Ley-Whelp - Frosted Claw'),
(30902, 33632, 0, 16.4, 0, 1, 0, 1, 1, 'Azure Ley-Whelp - Icicle Fang'),
(30902, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Ley-Whelp - Titanium Lockbox'),
(30902, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Ley-Whelp - Book of Glyph Mastery'),
(30916, 26040, 26040, 32.7, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - (ReferenceTable)'),
(30916, 33445, 0, 5.8, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - Honeymint Tea'),
(30916, 33454, 0, 6.5, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - Salted Venison'),
(30916, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - Titanium Lockbox'),
(30916, 43852, 0, 18.3, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - Thick Fur Clothing Scraps'),
(30916, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ring-Lord Sorceress - Book of Glyph Mastery'),
(30915, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Ring-Lord Conjurer - (ReferenceTable)'),
(30915, 26040, 26040, 32.8, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - (ReferenceTable)'),
(30915, 33425, 0, 1.1, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Ice-Pitted Blade'),
(30915, 33430, 0, 1.2, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Abandoned Greatsword'),
(30915, 33445, 0, 3.7, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Honeymint Tea'),
(30915, 33454, 0, 6.7, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Salted Venison'),
(30915, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Titanium Lockbox'),
(30915, 43852, 0, 16.7, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Thick Fur Clothing Scraps'),
(30915, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ring-Lord Conjurer - Book of Glyph Mastery'),
(30905, 36816, 0, 3.7, 0, 1, 0, 1, 1, 'Centrifuge Construct - Prismatic Stone Chip'),
(30905, 39209, 0, 68.4, 0, 1, 0, 3, 5, 'Centrifuge Construct - Scintillating Stone Shard'),
(30905, 39210, 0, 16.3, 0, 1, 0, 2, 4, 'Centrifuge Construct - Shattered Stone'),
(30905, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Centrifuge Construct - Titanium Lockbox'),
(30905, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Centrifuge Construct - Book of Glyph Mastery'),
(30909, 34736, 0, 35.1, 0, 1, 0, 1, 1, 'Phantasmal Mammoth - Chunk o\' Mammoth'),
(30909, 39562, 0, 72.5, 0, 1, 0, 2, 4, 'Phantasmal Mammoth - Looped Tusk'),
(30909, 39563, 0, 12.7, 0, 1, 0, 2, 3, 'Phantasmal Mammoth - Stumpy Foot'),
(30909, 42104, 0, 33, 1, 1, 0, 1, 1, 'Phantasmal Mammoth - Northern Ivory'),
(30909, 43013, 0, 4.1, 0, 1, 0, 1, 1, 'Phantasmal Mammoth - Chilled Meat'),
(30909, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Phantasmal Mammoth - Titanium Lockbox'),
(30909, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Phantasmal Mammoth - Book of Glyph Mastery'),
(30910, 17057, 0, 29.2, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Shiny Fish Scales'),
(30910, 17058, 0, 25, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Fish Oil'),
(30910, 26014, 26014, 2, 0, 1, 1, 1, 1, 'Phantasmal Murloc - (ReferenceTable)'),
(30910, 26040, 26040, 21.8, 0, 1, 0, 1, 1, 'Phantasmal Murloc - (ReferenceTable)'),
(30910, 35951, 0, 4.2, 0, 1, 0, 1, 3, 'Phantasmal Murloc - Poached Emperor Salmon'),
(30910, 36428, 0, 1.4, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Bouquet Ring'),
(30910, 36781, 0, 14.4, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Darkwater Clam'),
(30910, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Recipe: Tasty Cupcake'),
(30910, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Recipe: Last Week\'s Mammoth'),
(30910, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Recipe: Bad Clams'),
(30910, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Recipe: Haunted Herring'),
(30910, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Titanium Lockbox'),
(30910, 43852, 0, 11.1, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Thick Fur Clothing Scraps'),
(30910, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Phantasmal Murloc - Book of Glyph Mastery'),
(30906, 37700, 0, 29.1, 0, 1, 0, 2, 4, 'Phantasmal Air - Crystallized Air'),
(30906, 39512, 0, 73.4, 0, 1, 0, 2, 4, 'Phantasmal Air - Hoary Crystals'),
(30906, 39513, 0, 16.9, 0, 1, 0, 1, 1, 'Phantasmal Air - Efflorescing Shards'),
(30906, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Phantasmal Air - Titanium Lockbox'),
(30906, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Phantasmal Air - Book of Glyph Mastery'),
(31178, 26040, 26040, 30.1, 0, 1, 0, 1, 1, 'Enraging Ghoul - (ReferenceTable)'),
(31178, 33445, 0, 4.5, 0, 1, 0, 1, 1, 'Enraging Ghoul - Honeymint Tea'),
(31178, 35947, 0, 7.5, 0, 1, 0, 1, 1, 'Enraging Ghoul - Sparkling Frostcap'),
(31178, 42108, 0, 33, 1, 1, 0, 1, 1, 'Enraging Ghoul - Scourge Curio'),
(31178, 43852, 0, 17.1, 0, 1, 0, 1, 1, 'Enraging Ghoul - Thick Fur Clothing Scraps'),
(31201, 26040, 26040, 33.1, 0, 1, 0, 1, 1, 'Acolyte - (ReferenceTable)'),
(31201, 33445, 0, 4.4, 0, 1, 0, 1, 1, 'Acolyte - Honeymint Tea'),
(31201, 33454, 0, 7.3, 0, 1, 0, 1, 1, 'Acolyte - Salted Venison'),
(31201, 43852, 0, 19.3, 0, 1, 0, 1, 1, 'Acolyte - Thick Fur Clothing Scraps'),
(31180, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Master Necromancer - (ReferenceTable)'),
(31180, 26040, 26040, 31.8, 0, 1, 0, 1, 1, 'Master Necromancer - (ReferenceTable)'),
(31180, 33422, 0, 1.1, 0, 1, 0, 1, 1, 'Master Necromancer - Shattered Bow'),
(31180, 33430, 0, 1.1, 0, 1, 0, 1, 1, 'Master Necromancer - Abandoned Greatsword'),
(31180, 33445, 0, 3.5, 0, 1, 0, 1, 1, 'Master Necromancer - Honeymint Tea'),
(31180, 33454, 0, 7.2, 0, 1, 0, 1, 1, 'Master Necromancer - Salted Venison'),
(31180, 43852, 0, 14.6, 0, 1, 0, 1, 1, 'Master Necromancer - Thick Fur Clothing Scraps'),
(31187, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Crypt Fiend - (ReferenceTable)'),
(31187, 26014, 26014, 2, 0, 1, 1, 1, 1, 'Crypt Fiend - (ReferenceTable)'),
(31187, 26040, 26040, 36.2, 0, 1, 0, 1, 1, 'Crypt Fiend - (ReferenceTable)'),
(31187, 33425, 0, 1.2, 0, 1, 0, 1, 1, 'Crypt Fiend - Ice-Pitted Blade'),
(31187, 33426, 0, 1.2, 0, 1, 0, 1, 1, 'Crypt Fiend - Chipped Timber Axe'),
(31187, 33445, 0, 3.8, 0, 1, 0, 1, 1, 'Crypt Fiend - Honeymint Tea'),
(31187, 35947, 0, 7.8, 0, 1, 0, 1, 1, 'Crypt Fiend - Sparkling Frostcap'),
(31187, 36428, 0, 1, 0, 1, 0, 1, 1, 'Crypt Fiend - Bouquet Ring'),
(31187, 42108, 0, 33, 1, 1, 0, 1, 1, 'Crypt Fiend - Scourge Curio'),
(31187, 43852, 0, 15.6, 0, 1, 0, 1, 1, 'Crypt Fiend - Thick Fur Clothing Scraps'),
(31199, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Patchwork Construct - (ReferenceTable)'),
(31199, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Patchwork Construct - (ReferenceTable)'),
(31199, 26040, 26040, 29.7, 0, 1, 0, 1, 1, 'Patchwork Construct - (ReferenceTable)'),
(31199, 33399, 0, 1.1, 0, 1, 0, 1, 1, 'Patchwork Construct - Frigid Mail Boots'),
(31199, 33426, 0, 2, 0, 1, 0, 1, 1, 'Patchwork Construct - Chipped Timber Axe'),
(31199, 33429, 0, 1.3, 0, 1, 0, 1, 1, 'Patchwork Construct - Ice Cleaver'),
(31199, 33445, 0, 5.4, 0, 1, 0, 1, 1, 'Patchwork Construct - Honeymint Tea'),
(31199, 35947, 0, 6.5, 0, 1, 0, 1, 1, 'Patchwork Construct - Sparkling Frostcap'),
(31199, 42108, 0, 33, 1, 1, 0, 1, 1, 'Patchwork Construct - Scourge Curio'),
(31199, 43852, 0, 18, 0, 1, 0, 1, 1, 'Patchwork Construct - Thick Fur Clothing Scraps'),
(31202, 26040, 26040, 30.8, 0, 1, 0, 1, 1, 'Infinite Adversary - (ReferenceTable)'),
(31202, 33445, 0, 3.2, 0, 1, 0, 1, 1, 'Infinite Adversary - Honeymint Tea'),
(31202, 33454, 0, 6.9, 0, 1, 0, 1, 1, 'Infinite Adversary - Salted Venison'),
(31202, 43852, 0, 16.9, 0, 1, 0, 1, 1, 'Infinite Adversary - Thick Fur Clothing Scraps'),
(31206, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Infinite Hunter - (ReferenceTable)'),
(31206, 26040, 26040, 31, 0, 1, 0, 1, 1, 'Infinite Hunter - (ReferenceTable)'),
(31206, 33424, 0, 1, 0, 1, 0, 1, 1, 'Infinite Hunter - Cracked Iron Staff'),
(31206, 33430, 0, 1, 0, 1, 0, 1, 1, 'Infinite Hunter - Abandoned Greatsword'),
(31206, 33445, 0, 4, 0, 1, 0, 1, 1, 'Infinite Hunter - Honeymint Tea'),
(31206, 33454, 0, 7.8, 0, 1, 0, 1, 1, 'Infinite Hunter - Salted Venison'),
(31206, 43852, 0, 15.7, 0, 1, 0, 1, 1, 'Infinite Hunter - Thick Fur Clothing Scraps'),
(31203, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Infinite Agent - (ReferenceTable)'),
(31203, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Infinite Agent - (ReferenceTable)'),
(31203, 26040, 26040, 30, 0, 1, 0, 1, 1, 'Infinite Agent - (ReferenceTable)'),
(31203, 33419, 0, 1, 0, 1, 0, 1, 1, 'Infinite Agent - Frost-Worn Plate Shoulderpads'),
(31203, 33426, 0, 1, 0, 1, 0, 1, 1, 'Infinite Agent - Chipped Timber Axe'),
(31203, 33427, 0, 1, 0, 1, 0, 1, 1, 'Infinite Agent - Frost-Encrusted Rifle'),
(31203, 33445, 0, 2.8, 0, 1, 0, 1, 1, 'Infinite Agent - Honeymint Tea'),
(31203, 33454, 0, 9.1, 0, 1, 0, 1, 1, 'Infinite Agent - Salted Venison'),
(31203, 43852, 0, 14.7, 0, 1, 0, 1, 1, 'Infinite Agent - Thick Fur Clothing Scraps'),
(31377, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Rune Warrior - (ReferenceTable)'),
(31377, 26011, 26011, 2, 0, 1, 1, 1, 1, 'Dark Rune Warrior - (ReferenceTable)'),
(31377, 26040, 26040, 26.4, 0, 1, 0, 1, 1, 'Dark Rune Warrior - (ReferenceTable)'),
(31377, 33424, 0, 1.7, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Cracked Iron Staff'),
(31377, 33445, 0, 4.5, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Honeymint Tea'),
(31377, 33454, 0, 8.1, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Salted Venison'),
(31377, 36243, 0, 1.2, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Mammoth Girdle'),
(31377, 36565, 0, 1.2, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Hero\'s Knuckles'),
(31377, 39152, 0, 1.1, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Manual: Heavy Frostweave Bandage'),
(31377, 42780, 0, 35, 0, 1, 0, 1, 3, 'Dark Rune Warrior - Relic of Ulduar'),
(31377, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Titanium Lockbox'),
(31377, 43852, 0, 13.4, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Thick Fur Clothing Scraps'),
(31377, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Book of Glyph Mastery'),
(31378, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Rune Worker - (ReferenceTable)'),
(31378, 26012, 26012, 2, 0, 1, 1, 1, 1, 'Dark Rune Worker - (ReferenceTable)'),
(31378, 26040, 26040, 32.7, 0, 1, 0, 1, 1, 'Dark Rune Worker - (ReferenceTable)'),
(31378, 33422, 0, 5.9, 0, 1, 0, 1, 1, 'Dark Rune Worker - Shattered Bow'),
(31378, 33445, 0, 3.7, 0, 1, 0, 1, 1, 'Dark Rune Worker - Honeymint Tea'),
(31378, 33454, 0, 4.9, 0, 1, 0, 1, 1, 'Dark Rune Worker - Salted Venison'),
(31378, 36678, 0, 1.2, 0, 1, 0, 1, 1, 'Dark Rune Worker - Runed Talon'),
(31378, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Worker - Relic of Ulduar'),
(31378, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Worker - Titanium Lockbox'),
(31378, 43852, 0, 13.2, 0, 1, 0, 1, 1, 'Dark Rune Worker - Thick Fur Clothing Scraps'),
(31378, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Worker - Book of Glyph Mastery'),
(31372, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Rune Elementalist - (ReferenceTable)'),
(31372, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Dark Rune Elementalist - (ReferenceTable)'),
(31372, 26040, 26040, 33.7, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - (ReferenceTable)'),
(31372, 33397, 0, 2.8, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Frigid Mail Armor'),
(31372, 33427, 0, 1.4, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Frost-Encrusted Rifle'),
(31372, 33445, 0, 3.8, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Honeymint Tea'),
(31372, 33454, 0, 6.7, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Salted Venison'),
(31372, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Elementalist - Relic of Ulduar'),
(31372, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Titanium Lockbox'),
(31372, 43852, 0, 13.6, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Thick Fur Clothing Scraps'),
(31372, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Book of Glyph Mastery'),
(31376, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Dark Rune Theurgist - (ReferenceTable)'),
(31376, 26012, 26012, 2, 0, 1, 1, 1, 1, 'Dark Rune Theurgist - (ReferenceTable)'),
(31376, 26013, 26013, 2, 0, 1, 1, 1, 1, 'Dark Rune Theurgist - (ReferenceTable)'),
(31376, 26040, 26040, 32.1, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - (ReferenceTable)'),
(31376, 33445, 0, 4.9, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Honeymint Tea'),
(31376, 33454, 0, 6.5, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Salted Venison'),
(31376, 36042, 0, 1.2, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Condor Bindings'),
(31376, 36242, 0, 1.1, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Shoveltusk Bindings'),
(31376, 36369, 0, 1.3, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Magnataur Pauldrons'),
(31376, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Theurgist - Relic of Ulduar'),
(31376, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Titanium Lockbox'),
(31376, 43852, 0, 15.4, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Thick Fur Clothing Scraps'),
(31376, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Book of Glyph Mastery'),
(31374, 24727, 24727, 1.5, 0, 1, 0, 1, 1, 'Dark Rune Scholar - (ReferenceTable)'),
(31374, 26012, 26012, 2, 0, 1, 1, 1, 1, 'Dark Rune Scholar - (ReferenceTable)'),
(31374, 26040, 26040, 31.5, 0, 1, 0, 1, 1, 'Dark Rune Scholar - (ReferenceTable)'),
(31374, 33445, 0, 3.3, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Honeymint Tea'),
(31374, 33454, 0, 3.6, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Salted Venison'),
(31374, 36030, 0, 1.3, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Oracle Gloves'),
(31374, 37091, 0, 1.3, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Scroll of Intellect VII'),
(31374, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Scholar - Relic of Ulduar'),
(31374, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Titanium Lockbox'),
(31374, 43852, 0, 19.7, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Thick Fur Clothing Scraps'),
(31374, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Scholar - Book of Glyph Mastery'),
(31375, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Rune Shaper - (ReferenceTable)'),
(31375, 26040, 26040, 32.8, 0, 1, 0, 1, 1, 'Dark Rune Shaper - (ReferenceTable)'),
(31375, 33428, 0, 1, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Dulled Shiv'),
(31375, 33445, 0, 2.2, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Honeymint Tea'),
(31375, 33454, 0, 6.5, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Salted Venison'),
(31375, 42780, 0, 38, 0, 1, 0, 1, 3, 'Dark Rune Shaper - Relic of Ulduar'),
(31375, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Titanium Lockbox'),
(31375, 43852, 0, 13, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Thick Fur Clothing Scraps'),
(31375, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Shaper - Book of Glyph Mastery'),
(31373, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Rune Giant - (ReferenceTable)'),
(31373, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Dark Rune Giant - (ReferenceTable)'),
(31373, 26040, 26040, 29.9, 0, 1, 0, 1, 1, 'Dark Rune Giant - (ReferenceTable)'),
(31373, 33417, 0, 3, 0, 1, 0, 1, 1, 'Dark Rune Giant - Frost-Worn Plate Pants'),
(31373, 33422, 0, 3.1, 0, 1, 0, 1, 1, 'Dark Rune Giant - Shattered Bow'),
(31373, 33424, 0, 3.1, 0, 1, 0, 1, 1, 'Dark Rune Giant - Cracked Iron Staff'),
(31373, 33445, 0, 2.4, 0, 1, 0, 1, 1, 'Dark Rune Giant - Honeymint Tea'),
(31373, 33454, 0, 7.4, 0, 1, 0, 1, 1, 'Dark Rune Giant - Salted Venison'),
(31373, 39152, 0, 1.1, 0, 1, 0, 1, 1, 'Dark Rune Giant - Manual: Heavy Frostweave Bandage'),
(31373, 42780, 0, 30, 0, 1, 0, 1, 3, 'Dark Rune Giant - Relic of Ulduar'),
(31373, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Dark Rune Giant - Titanium Lockbox'),
(31373, 43852, 0, 12.8, 0, 1, 0, 1, 1, 'Dark Rune Giant - Thick Fur Clothing Scraps'),
(31373, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dark Rune Giant - Book of Glyph Mastery'),
(31385, 26013, 26013, 2, 0, 1, 1, 1, 1, 'Raging Construct - (ReferenceTable)'),
(31385, 36152, 0, 2, 0, 1, 0, 1, 1, 'Raging Construct - Pygmy Pants'),
(31385, 36816, 0, 10, 0, 1, 0, 1, 1, 'Raging Construct - Prismatic Stone Chip'),
(31385, 36817, 0, 1.2, 0, 1, 0, 1, 1, 'Raging Construct - Banded Stone'),
(31385, 39209, 0, 63.2, 0, 1, 0, 3, 5, 'Raging Construct - Scintillating Stone Shard'),
(31385, 39210, 0, 14.4, 0, 1, 0, 2, 4, 'Raging Construct - Shattered Stone'),
(31385, 42780, 0, 18, 0, 1, 0, 1, 3, 'Raging Construct - Relic of Ulduar'),
(31385, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Raging Construct - Titanium Lockbox'),
(31385, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Raging Construct - Book of Glyph Mastery'),
(31387, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Unrelenting Construct - (ReferenceTable)'),
(31387, 33384, 0, 1.2, 0, 1, 0, 1, 1, 'Unrelenting Construct - Frozen Pants'),
(31387, 36816, 0, 12.7, 0, 1, 0, 1, 1, 'Unrelenting Construct - Prismatic Stone Chip'),
(31387, 36817, 0, 3.2, 0, 1, 0, 1, 1, 'Unrelenting Construct - Banded Stone'),
(31387, 39209, 0, 58.7, 0, 1, 0, 3, 5, 'Unrelenting Construct - Scintillating Stone Shard'),
(31387, 39210, 0, 13.3, 0, 1, 0, 2, 4, 'Unrelenting Construct - Shattered Stone'),
(31387, 42780, 0, 22, 0, 1, 0, 1, 3, 'Unrelenting Construct - Relic of Ulduar'),
(31387, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Unrelenting Construct - Titanium Lockbox'),
(31387, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Unrelenting Construct - Book of Glyph Mastery'),
(31383, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Lightning Construct - (ReferenceTable)'),
(31383, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Lightning Construct - (ReferenceTable)'),
(31383, 33366, 0, 1.3, 0, 1, 0, 1, 1, 'Lightning Construct - Frost-Rimed Cloth Boots'),
(31383, 33423, 0, 1.5, 0, 1, 0, 1, 1, 'Lightning Construct - Rime-Covered Mace'),
(31383, 36816, 0, 8.8, 0, 1, 0, 1, 1, 'Lightning Construct - Prismatic Stone Chip'),
(31383, 36817, 0, 1.1, 0, 1, 0, 1, 1, 'Lightning Construct - Banded Stone'),
(31383, 39209, 0, 61.7, 0, 1, 0, 3, 5, 'Lightning Construct - Scintillating Stone Shard'),
(31383, 39210, 0, 15.6, 0, 1, 0, 2, 4, 'Lightning Construct - Shattered Stone'),
(31383, 42780, 0, 19, 0, 1, 0, 1, 3, 'Lightning Construct - Relic of Ulduar'),
(31383, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Lightning Construct - Titanium Lockbox'),
(31383, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Lightning Construct - Book of Glyph Mastery'),
(31188, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Tomb Stalker - (ReferenceTable)'),
(31188, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Tomb Stalker - (ReferenceTable)'),
(31188, 26040, 26040, 30.7, 0, 1, 0, 1, 1, 'Tomb Stalker - (ReferenceTable)'),
(31188, 33416, 0, 1.1, 0, 1, 0, 1, 1, 'Tomb Stalker - Frost-Worn Plate Gloves'),
(31188, 33425, 0, 1.1, 0, 1, 0, 1, 1, 'Tomb Stalker - Ice-Pitted Blade'),
(31188, 33426, 0, 1.6, 0, 1, 0, 1, 1, 'Tomb Stalker - Chipped Timber Axe'),
(31188, 33445, 0, 3.4, 0, 1, 0, 1, 1, 'Tomb Stalker - Honeymint Tea'),
(31188, 35947, 0, 5.2, 0, 1, 0, 1, 1, 'Tomb Stalker - Sparkling Frostcap'),
(31188, 42108, 0, 33, 1, 1, 0, 1, 1, 'Tomb Stalker - Scourge Curio'),
(31188, 43852, 0, 17.5, 0, 1, 0, 1, 1, 'Tomb Stalker - Thick Fur Clothing Scraps'),
(31184, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Dark Necromancer - (ReferenceTable)'),
(31184, 26040, 26040, 33.2, 0, 1, 0, 1, 1, 'Dark Necromancer - (ReferenceTable)'),
(31184, 33427, 0, 1.3, 0, 1, 0, 1, 1, 'Dark Necromancer - Frost-Encrusted Rifle'),
(31184, 33431, 0, 2.1, 0, 1, 0, 1, 1, 'Dark Necromancer - Icesmashing Mace'),
(31184, 33445, 0, 2.9, 0, 1, 0, 1, 1, 'Dark Necromancer - Honeymint Tea'),
(31184, 33454, 0, 7.8, 0, 1, 0, 1, 1, 'Dark Necromancer - Salted Venison'),
(31184, 43852, 0, 16.6, 0, 1, 0, 1, 1, 'Dark Necromancer - Thick Fur Clothing Scraps'),
(31200, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Bile Golem - (ReferenceTable)'),
(31200, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Bile Golem - (ReferenceTable)'),
(31200, 26040, 26040, 37.5, 0, 1, 0, 1, 1, 'Bile Golem - (ReferenceTable)'),
(31200, 33424, 0, 1, 0, 1, 0, 1, 1, 'Bile Golem - Cracked Iron Staff'),
(31200, 33436, 0, 1, 0, 1, 0, 1, 1, 'Bile Golem - Frost-Rimed Cloth Hat'),
(31200, 33445, 0, 5.1, 0, 1, 0, 1, 1, 'Bile Golem - Honeymint Tea'),
(31200, 35947, 0, 7.6, 0, 1, 0, 1, 1, 'Bile Golem - Sparkling Frostcap'),
(31200, 42108, 0, 33, 1, 1, 0, 1, 1, 'Bile Golem - Scourge Curio'),
(31200, 43852, 0, 14.2, 0, 1, 0, 1, 1, 'Bile Golem - Thick Fur Clothing Scraps'),
(31179, 26040, 26040, 29.5, 0, 1, 0, 1, 1, 'Devouring Ghoul - (ReferenceTable)'),
(31179, 33445, 0, 4.1, 0, 1, 0, 1, 1, 'Devouring Ghoul - Honeymint Tea'),
(31179, 35947, 0, 6.9, 0, 1, 0, 1, 1, 'Devouring Ghoul - Sparkling Frostcap'),
(31179, 42108, 0, 33, 1, 1, 0, 1, 1, 'Devouring Ghoul - Scourge Curio'),
(31179, 43852, 0, 16.8, 0, 1, 0, 1, 1, 'Devouring Ghoul - Thick Fur Clothing Scraps'),
(30820, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Ymirjar Necromancer - (ReferenceTable)'),
(30820, 26040, 26040, 31.3, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - (ReferenceTable)'),
(30820, 33426, 0, 1.2, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Chipped Timber Axe'),
(30820, 33427, 0, 1.2, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Frost-Encrusted Rifle'),
(30820, 33429, 0, 1.7, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Ice Cleaver'),
(30820, 33445, 0, 4.2, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Honeymint Tea'),
(30820, 35947, 0, 6.3, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Sparkling Frostcap'),
(30820, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Titanium Lockbox'),
(30820, 43852, 0, 18.7, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Thick Fur Clothing Scraps'),
(30820, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Book of Glyph Mastery'),
(31665, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Dragonflayer Spiritualist (1) - Book of Glyph Mastery'),
(30979, 37700, 0, 28.1, 0, 1, 0, 2, 4, 'Storming Vortex - Crystallized Air'),
(30979, 39512, 0, 70.3, 0, 1, 0, 2, 4, 'Storming Vortex - Hoary Crystals'),
(30979, 39513, 0, 18.5, 0, 1, 0, 1, 1, 'Storming Vortex - Efflorescing Shards'),
(30979, 42780, 0, 23, 0, 1, 0, 1, 3, 'Storming Vortex - Relic of Ulduar'),
(30979, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Storming Vortex - Titanium Lockbox'),
(30979, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Storming Vortex - Book of Glyph Mastery'),
(30967, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Hardened Steel Reaver - (ReferenceTable)'),
(30967, 26040, 26040, 35.2, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - (ReferenceTable)'),
(30967, 33428, 0, 1, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Dulled Shiv'),
(30967, 33445, 0, 4.9, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Honeymint Tea'),
(30967, 33454, 0, 8.2, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Salted Venison'),
(30967, 39152, 0, 1.4, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Manual: Heavy Frostweave Bandage'),
(30967, 42780, 0, 29, 0, 1, 0, 1, 3, 'Hardened Steel Reaver - Relic of Ulduar'),
(30967, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Titanium Lockbox'),
(30967, 43852, 0, 15.5, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Thick Fur Clothing Scraps'),
(30967, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Book of Glyph Mastery'),
(30966, 26040, 26040, 33.4, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - (ReferenceTable)'),
(30966, 33445, 0, 4.2, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Honeymint Tea'),
(30966, 33454, 0, 7.8, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Salted Venison'),
(30966, 39152, 0, 1, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Manual: Heavy Frostweave Bandage'),
(30966, 42780, 0, 28, 0, 1, 0, 1, 3, 'Hardened Steel Berserker - Relic of Ulduar'),
(30966, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Titanium Lockbox'),
(30966, 43852, 0, 17.1, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Thick Fur Clothing Scraps'),
(30966, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Book of Glyph Mastery'),
(30968, 26040, 26040, 33.3, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - (ReferenceTable)'),
(30968, 33445, 0, 4.4, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Honeymint Tea'),
(30968, 33454, 0, 6.1, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Salted Venison'),
(30968, 42780, 0, 27, 0, 1, 0, 1, 3, 'Hardened Steel Skycaller - Relic of Ulduar'),
(30968, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Titanium Lockbox'),
(30968, 43852, 0, 17.2, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Thick Fur Clothing Scraps'),
(30968, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Book of Glyph Mastery'),
(30977, 26040, 26040, 33.3, 0, 1, 0, 1, 1, 'Stormforged Tactician - (ReferenceTable)'),
(30977, 33445, 0, 3.3, 0, 1, 0, 1, 1, 'Stormforged Tactician - Honeymint Tea'),
(30977, 33454, 0, 9.7, 0, 1, 0, 1, 1, 'Stormforged Tactician - Salted Venison'),
(30977, 42780, 0, 30, 0, 1, 0, 1, 3, 'Stormforged Tactician - Relic of Ulduar'),
(30977, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Tactician - Titanium Lockbox'),
(30977, 43852, 0, 18.1, 0, 1, 0, 1, 1, 'Stormforged Tactician - Thick Fur Clothing Scraps'),
(30977, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Tactician - Book of Glyph Mastery'),
(30974, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Stormforged Mender - (ReferenceTable)'),
(30974, 26040, 26040, 32.4, 0, 1, 0, 1, 1, 'Stormforged Mender - (ReferenceTable)'),
(30974, 33423, 0, 1, 0, 1, 0, 1, 1, 'Stormforged Mender - Rime-Covered Mace'),
(30974, 33445, 0, 3.5, 0, 1, 0, 1, 1, 'Stormforged Mender - Honeymint Tea'),
(30974, 33454, 0, 9, 0, 1, 0, 1, 1, 'Stormforged Mender - Salted Venison'),
(30974, 42780, 0, 30, 0, 1, 0, 1, 3, 'Stormforged Mender - Relic of Ulduar'),
(30974, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Mender - Titanium Lockbox'),
(30974, 43852, 0, 20.3, 0, 1, 0, 1, 1, 'Stormforged Mender - Thick Fur Clothing Scraps'),
(30974, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Mender - Book of Glyph Mastery'),
(30964, 37705, 0, 27.7, 0, 1, 0, 2, 4, 'Blistering Steamrager - Crystallized Water'),
(30964, 39512, 0, 71, 0, 1, 0, 2, 4, 'Blistering Steamrager - Hoary Crystals'),
(30964, 39513, 0, 17.7, 0, 1, 0, 1, 1, 'Blistering Steamrager - Efflorescing Shards'),
(30964, 42780, 0, 23, 0, 1, 0, 1, 3, 'Blistering Steamrager - Relic of Ulduar'),
(30964, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Blistering Steamrager - Titanium Lockbox'),
(30964, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Blistering Steamrager - Book of Glyph Mastery'),
(30983, 37702, 0, 26.3, 0, 1, 0, 2, 4, 'Unbound Firestorm - Crystallized Fire'),
(30983, 39512, 0, 70.4, 0, 1, 0, 2, 4, 'Unbound Firestorm - Hoary Crystals'),
(30983, 39513, 0, 16.8, 0, 1, 0, 2, 4, 'Unbound Firestorm - Efflorescing Shards'),
(30983, 42107, 0, 33, 1, 1, 0, 1, 1, 'Unbound Firestorm - Elemental Armor Scrap'),
(30983, 42780, 0, 20, 0, 1, 0, 1, 3, 'Unbound Firestorm - Relic of Ulduar'),
(30983, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Unbound Firestorm - Book of Glyph Mastery'),
(31608, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Recipe: Tasty Cupcake'),
(31608, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Recipe: Last Week\'s Mammoth'),
(31608, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Recipe: Bad Clams'),
(31608, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Recipe: Haunted Herring'),
(31608, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Titanium Lockbox'),
(31608, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Anub\'ar Warrior - Book of Glyph Mastery'),
(31606, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Recipe: Tasty Cupcake'),
(31606, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Recipe: Last Week\'s Mammoth'),
(31606, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Recipe: Bad Clams'),
(31606, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Recipe: Haunted Herring'),
(31606, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Titanium Lockbox'),
(31606, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Anub\'ar Skirmisher - Book of Glyph Mastery'),
(30978, 37700, 0, 30, 0, 1, 0, 2, 4, 'Stormfury Revenant - Crystallized Air'),
(30978, 39512, 0, 72.4, 0, 1, 0, 2, 4, 'Stormfury Revenant - Hoary Crystals'),
(30978, 39513, 0, 17.6, 0, 1, 0, 1, 1, 'Stormfury Revenant - Efflorescing Shards'),
(30978, 42107, 0, 33, 1, 1, 0, 1, 1, 'Stormfury Revenant - Elemental Armor Scrap'),
(30978, 42780, 0, 21, 0, 1, 0, 1, 3, 'Stormfury Revenant - Relic of Ulduar'),
(30978, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormfury Revenant - Titanium Lockbox'),
(30978, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormfury Revenant - Book of Glyph Mastery'),
(30971, 26040, 26040, 15.7, 0, 1, 0, 1, 1, 'Stormforged Construct - (ReferenceTable)'),
(30971, 36816, 0, 2.2, 0, 1, 0, 1, 1, 'Stormforged Construct - Prismatic Stone Chip'),
(30971, 39209, 0, 67.5, 0, 1, 0, 3, 5, 'Stormforged Construct - Scintillating Stone Shard'),
(30971, 39210, 0, 16.2, 0, 1, 0, 2, 4, 'Stormforged Construct - Shattered Stone'),
(30971, 42780, 0, 20, 0, 1, 0, 1, 3, 'Stormforged Construct - Relic of Ulduar'),
(30971, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Construct - Titanium Lockbox'),
(30971, 43852, 0, 9, 0, 1, 0, 1, 1, 'Stormforged Construct - Thick Fur Clothing Scraps'),
(30971, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Construct - Book of Glyph Mastery'),
(30975, 26040, 26040, 32.4, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - (ReferenceTable)'),
(30975, 33445, 0, 3.9, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Honeymint Tea'),
(30975, 33454, 0, 8.1, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Salted Venison'),
(30975, 42780, 0, 34, 0, 1, 0, 1, 3, 'Stormforged Runeshaper - Relic of Ulduar'),
(30975, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Titanium Lockbox'),
(30975, 43852, 0, 17.9, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Thick Fur Clothing Scraps'),
(30975, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Book of Glyph Mastery'),
(30976, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Stormforged Sentinel - (ReferenceTable)'),
(30976, 26040, 26040, 31.7, 0, 1, 0, 1, 1, 'Stormforged Sentinel - (ReferenceTable)'),
(30976, 33425, 0, 1.3, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Ice-Pitted Blade'),
(30976, 33429, 0, 1.1, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Ice Cleaver'),
(30976, 33445, 0, 2.9, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Honeymint Tea'),
(30976, 33454, 0, 7.5, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Salted Venison'),
(30976, 42780, 0, 31, 0, 1, 0, 1, 3, 'Stormforged Sentinel - Relic of Ulduar'),
(30976, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Titanium Lockbox'),
(30976, 43852, 0, 18.9, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Thick Fur Clothing Scraps'),
(30976, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Sentinel - Book of Glyph Mastery'),
(30981, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Titanium Vanguard - (ReferenceTable)'),
(30981, 26040, 26040, 31, 0, 1, 0, 1, 1, 'Titanium Vanguard - (ReferenceTable)'),
(30981, 33423, 0, 1.1, 0, 1, 0, 1, 1, 'Titanium Vanguard - Rime-Covered Mace'),
(30981, 33445, 0, 4.6, 0, 1, 0, 1, 1, 'Titanium Vanguard - Honeymint Tea'),
(30981, 33454, 0, 8.3, 0, 1, 0, 1, 1, 'Titanium Vanguard - Salted Venison'),
(30981, 42780, 0, 34, 0, 1, 0, 1, 3, 'Titanium Vanguard - Relic of Ulduar'),
(30981, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Titanium Vanguard - Titanium Lockbox'),
(30981, 43852, 0, 18.1, 0, 1, 0, 1, 1, 'Titanium Vanguard - Thick Fur Clothing Scraps'),
(30981, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Titanium Vanguard - Book of Glyph Mastery'),
(30972, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Stormforged Giant - (ReferenceTable)'),
(30972, 26040, 26040, 30.4, 0, 1, 0, 1, 1, 'Stormforged Giant - (ReferenceTable)'),
(30972, 33427, 0, 1.4, 0, 1, 0, 1, 1, 'Stormforged Giant - Frost-Encrusted Rifle'),
(30972, 33445, 0, 2.6, 0, 1, 0, 1, 1, 'Stormforged Giant - Honeymint Tea'),
(30972, 33454, 0, 7.5, 0, 1, 0, 1, 1, 'Stormforged Giant - Salted Venison'),
(30972, 42780, 0, 33, 0, 1, 0, 1, 3, 'Stormforged Giant - Relic of Ulduar'),
(30972, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Stormforged Giant - Titanium Lockbox'),
(30972, 43852, 0, 17.3, 0, 1, 0, 1, 1, 'Stormforged Giant - Thick Fur Clothing Scraps'),
(30972, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Stormforged Giant - Book of Glyph Mastery'),
(30980, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Titanium Siegebreaker - (ReferenceTable)'),
(30980, 26040, 26040, 32.2, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - (ReferenceTable)'),
(30980, 33426, 0, 1.1, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Chipped Timber Axe'),
(30980, 33445, 0, 2.8, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Honeymint Tea'),
(30980, 33454, 0, 6.8, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Salted Venison'),
(30980, 42780, 0, 34, 0, 1, 0, 1, 3, 'Titanium Siegebreaker - Relic of Ulduar'),
(30980, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Titanium Lockbox'),
(30980, 43852, 0, 16.6, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Thick Fur Clothing Scraps'),
(30980, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Titanium Siegebreaker - Book of Glyph Mastery'),
(30982, 26040, 26040, 32.4, 0, 1, 0, 1, 1, 'Titanium Thunderer - (ReferenceTable)'),
(30982, 33445, 0, 3.7, 0, 1, 0, 1, 1, 'Titanium Thunderer - Honeymint Tea'),
(30982, 33454, 0, 7.6, 0, 1, 0, 1, 1, 'Titanium Thunderer - Salted Venison'),
(30982, 42780, 0, 31, 0, 1, 0, 1, 3, 'Titanium Thunderer - Relic of Ulduar'),
(30982, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Titanium Thunderer - Titanium Lockbox'),
(30982, 43852, 0, 19.6, 0, 1, 0, 1, 1, 'Titanium Thunderer - Thick Fur Clothing Scraps'),
(30982, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Titanium Thunderer - Book of Glyph Mastery'),
(31604, 42108, 0, 33, 1, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Scourge Curio'),
(31604, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Recipe: Tasty Cupcake'),
(31604, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Recipe: Last Week\'s Mammoth'),
(31604, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Recipe: Bad Clams'),
(31604, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Recipe: Haunted Herring'),
(31604, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Titanium Lockbox'),
(31604, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Anub\'ar Prime Guard - Book of Glyph Mastery'),
(31609, 42108, 0, 33, 1, 1, 0, 1, 1, 'Anub\'ar Webspinner - Scourge Curio'),
(31609, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Anub\'ar Webspinner - Titanium Lockbox'),
(31609, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Anub\'ar Webspinner - Book of Glyph Mastery'),
(30942, 30812, 0, 1.2, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Iridescent Scale'),
(30942, 33445, 0, 1.5, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Honeymint Tea'),
(30942, 33447, 0, 1, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Runic Healing Potion'),
(30942, 33454, 0, 3.7, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Salted Venison'),
(30942, 39567, 0, 70.3, 0, 1, 0, 3, 5, 'Unyielding Constrictor - Rubicund Scale'),
(30942, 39568, 0, 17.2, 0, 1, 0, 2, 4, 'Unyielding Constrictor - Hollow Fang'),
(30942, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Titanium Lockbox'),
(30942, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Unyielding Constrictor - Book of Glyph Mastery'),
(30932, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Drakkari Lancer - (ReferenceTable)'),
(30932, 26040, 26040, 33.6, 0, 1, 0, 1, 1, 'Drakkari Lancer - (ReferenceTable)'),
(30932, 33428, 0, 1, 0, 1, 0, 1, 1, 'Drakkari Lancer - Dulled Shiv'),
(30932, 33445, 0, 4.5, 0, 1, 0, 1, 1, 'Drakkari Lancer - Honeymint Tea'),
(30932, 33454, 0, 6.9, 0, 1, 0, 1, 1, 'Drakkari Lancer - Salted Venison'),
(30932, 39152, 0, 1.5, 0, 1, 0, 1, 1, 'Drakkari Lancer - Manual: Heavy Frostweave Bandage'),
(30932, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Lancer - Titanium Lockbox'),
(30932, 43852, 0, 18.8, 0, 1, 0, 1, 1, 'Drakkari Lancer - Thick Fur Clothing Scraps'),
(30932, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Lancer - Book of Glyph Mastery'),
(30929, 26040, 26040, 33.4, 0, 1, 0, 1, 1, 'Drakkari God Hunter - (ReferenceTable)'),
(30929, 33445, 0, 3.9, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Honeymint Tea'),
(30929, 33454, 0, 7, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Salted Venison'),
(30929, 39152, 0, 1.6, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Manual: Heavy Frostweave Bandage'),
(30929, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Titanium Lockbox'),
(30929, 43852, 0, 19.8, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Thick Fur Clothing Scraps'),
(30929, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari God Hunter - Book of Glyph Mastery'),
(30927, 26040, 26040, 34.5, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - (ReferenceTable)'),
(30927, 33445, 0, 4.1, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Honeymint Tea'),
(30927, 33454, 0, 7.8, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Salted Venison'),
(30927, 39152, 0, 1.8, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Manual: Heavy Frostweave Bandage'),
(30927, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Recipe: Tasty Cupcake'),
(30927, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Recipe: Last Week\'s Mammoth'),
(30927, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Recipe: Bad Clams'),
(30927, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Recipe: Haunted Herring'),
(30927, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Titanium Lockbox'),
(30927, 43852, 0, 16.7, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Thick Fur Clothing Scraps'),
(30927, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Fire Weaver - Book of Glyph Mastery'),
(30933, 26040, 26040, 33.2, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - (ReferenceTable)'),
(30933, 33445, 0, 3.8, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Honeymint Tea'),
(30933, 33454, 0, 8.7, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Salted Venison'),
(30933, 39152, 0, 1.8, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Manual: Heavy Frostweave Bandage'),
(30933, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Recipe: Tasty Cupcake'),
(30933, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Recipe: Last Week\'s Mammoth'),
(30933, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Recipe: Bad Clams'),
(30933, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Recipe: Haunted Herring'),
(30933, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Titanium Lockbox'),
(30933, 43852, 0, 19.3, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Thick Fur Clothing Scraps'),
(30933, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Medicine Man - Book of Glyph Mastery'),
(30926, 26040, 26040, 30.5, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - (ReferenceTable)'),
(30926, 33445, 0, 4.7, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Honeymint Tea'),
(30926, 33454, 0, 7.9, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Salted Venison'),
(30926, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Titanium Lockbox'),
(30926, 43852, 0, 20, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Thick Fur Clothing Scraps'),
(30926, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Book of Glyph Mastery'),
(30938, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Living Mojo - (ReferenceTable)'),
(30938, 33430, 0, 1.2, 0, 1, 0, 1, 1, 'Living Mojo - Abandoned Greatsword'),
(30938, 33445, 0, 3.5, 0, 1, 0, 1, 1, 'Living Mojo - Honeymint Tea'),
(30938, 33454, 0, 9, 0, 1, 0, 1, 1, 'Living Mojo - Salted Venison'),
(30938, 37705, 0, 58.7, 0, 1, 0, 2, 4, 'Living Mojo - Crystallized Water'),
(30938, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Living Mojo - Titanium Lockbox'),
(30938, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Living Mojo - Book of Glyph Mastery'),
(30930, 26040, 26040, 31.9, 0, 1, 0, 1, 1, 'Drakkari Golem - (ReferenceTable)'),
(30930, 33445, 0, 3.6, 0, 1, 0, 1, 1, 'Drakkari Golem - Honeymint Tea'),
(30930, 33454, 0, 8, 0, 1, 0, 1, 1, 'Drakkari Golem - Salted Venison'),
(30930, 39152, 0, 3.3, 0, 1, 0, 1, 1, 'Drakkari Golem - Manual: Heavy Frostweave Bandage'),
(30930, 39220, 0, 3.7, 0, 1, 0, 1, 1, 'Drakkari Golem - Geodesic Fragments'),
(30930, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Golem - Titanium Lockbox'),
(30930, 43852, 0, 19.2, 0, 1, 0, 1, 1, 'Drakkari Golem - Thick Fur Clothing Scraps'),
(30930, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Golem - Book of Glyph Mastery'),
(30925, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Drakkari Battle Rider - (ReferenceTable)'),
(30925, 26040, 26040, 33.2, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - (ReferenceTable)'),
(30925, 33422, 0, 1.1, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Shattered Bow'),
(30925, 33445, 0, 4.3, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Honeymint Tea'),
(30925, 33454, 0, 7, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Salted Venison'),
(30925, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Titanium Lockbox'),
(30925, 43852, 0, 16.5, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Thick Fur Clothing Scraps'),
(30925, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Battle Rider - Book of Glyph Mastery'),
(30935, 24727, 24727, 1.5, 0, 1, 0, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30935, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30935, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30935, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30935, 26040, 26040, 23.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30935, 33412, 0, 4.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - Frost-Worn Plate Belt'),
(30935, 33427, 0, 4.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - Frost-Encrusted Rifle'),
(30935, 33445, 0, 14.3, 0, 1, 0, 1, 1, 'Drakkari Rhino - Honeymint Tea'),
(30935, 36015, 0, 4.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - Tethys Hood'),
(30935, 37093, 0, 4.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - Scroll of Stamina VII'),
(30935, 43012, 0, 57.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Rhino Meat'),
(30935, 43507, 0, 4.8, 0, 1, 0, 1, 1, 'Drakkari Rhino - Recipe: Tasty Cupcake'),
(30935, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Rhino - Titanium Lockbox'),
(30935, 43852, 0, 9.5, 0, 1, 0, 1, 1, 'Drakkari Rhino - Thick Fur Clothing Scraps'),
(30935, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Book of Glyph Mastery'),
(30931, 24727, 24727, 1.5, 0, 1, 0, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 26001, 26001, 3, 0, 1, 1, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 26002, 26002, 3, 0, 1, 1, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 26010, 26010, 1, 0, 1, 1, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 26012, 26012, 1, 0, 1, 1, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 26040, 26040, 31.8, 0, 1, 0, 1, 1, 'Drakkari Inciter - (ReferenceTable)'),
(30931, 33370, 0, 1.1, 0, 1, 0, 1, 1, 'Drakkari Inciter - Frost-Rimed Cloth Shoulderpads'),
(30931, 33426, 0, 1.4, 0, 1, 0, 1, 1, 'Drakkari Inciter - Chipped Timber Axe'),
(30931, 33427, 0, 1.1, 0, 1, 0, 1, 1, 'Drakkari Inciter - Frost-Encrusted Rifle'),
(30931, 33431, 0, 1.4, 0, 1, 0, 1, 1, 'Drakkari Inciter - Icesmashing Mace'),
(30931, 33445, 0, 3.9, 0, 1, 0, 1, 1, 'Drakkari Inciter - Honeymint Tea'),
(30931, 33454, 0, 9.6, 0, 1, 0, 1, 1, 'Drakkari Inciter - Salted Venison'),
(30931, 36015, 0, 1.4, 0, 1, 0, 1, 1, 'Drakkari Inciter - Tethys Hood'),
(30931, 36552, 0, 1.4, 0, 1, 0, 1, 1, 'Drakkari Inciter - Spiked Greatstaff'),
(30931, 37097, 0, 1.1, 0, 1, 0, 1, 1, 'Drakkari Inciter - Scroll of Spirit VII'),
(30931, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Inciter - Titanium Lockbox'),
(30931, 43852, 0, 17.5, 0, 1, 0, 1, 1, 'Drakkari Inciter - Thick Fur Clothing Scraps'),
(30931, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Inciter - Book of Glyph Mastery'),
(30936, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30936, 26002, 26002, 6, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30936, 26010, 26010, 2, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30936, 26011, 26011, 2, 0, 1, 1, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30936, 26040, 26040, 35.7, 0, 1, 0, 1, 1, 'Drakkari Rhino - (ReferenceTable)'),
(30936, 33403, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Frigid Mail Shoulderpads'),
(30936, 33427, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Frost-Encrusted Rifle'),
(30936, 33445, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Honeymint Tea'),
(30936, 33447, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Runic Healing Potion'),
(30936, 36024, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Aerie Pants'),
(30936, 36131, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Wolverine Girdle'),
(30936, 36240, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Shoveltusk Legguards'),
(30936, 36348, 0, 7.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Jormungar Sabatons'),
(30936, 43012, 0, 71.4, 0, 1, 0, 1, 1, 'Drakkari Rhino - Rhino Meat'),
(30936, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Drakkari Rhino - Titanium Lockbox'),
(30936, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Drakkari Rhino - Book of Glyph Mastery'),
(31471, 22829, 0, 2.1, 0, 1, 0, 1, 1, 'Twilight Apostle - Super Healing Potion'),
(31471, 26040, 26040, 34.8, 0, 1, 0, 1, 1, 'Twilight Apostle - (ReferenceTable)'),
(31471, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Twilight Apostle - Pungent Seal Whey'),
(31471, 33454, 0, 8.9, 0, 1, 0, 1, 1, 'Twilight Apostle - Salted Venison'),
(31471, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Twilight Apostle - Recipe: Tasty Cupcake'),
(31471, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Twilight Apostle - Recipe: Last Week\'s Mammoth'),
(31471, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Twilight Apostle - Recipe: Bad Clams'),
(31471, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Twilight Apostle - Recipe: Haunted Herring'),
(31471, 43622, 0, 1.3, 0, 1, 0, 1, 1, 'Twilight Apostle - Froststeel Lockbox'),
(31471, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Twilight Apostle - Titanium Lockbox'),
(31471, 43852, 0, 12.5, 0, 1, 0, 1, 1, 'Twilight Apostle - Thick Fur Clothing Scraps'),
(31471, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Twilight Apostle - Book of Glyph Mastery'),
(31450, 22829, 0, 2.5, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Super Healing Potion'),
(31450, 26040, 26040, 33.6, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - (ReferenceTable)'),
(31450, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Pungent Seal Whey'),
(31450, 33452, 0, 9, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Honey-Spiced Lichen'),
(31450, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Scourge Curio'),
(31450, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Titanium Lockbox'),
(31450, 43852, 0, 12, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Thick Fur Clothing Scraps'),
(31450, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Web Winder - Book of Glyph Mastery'),
(31442, 22829, 0, 2.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Super Healing Potion'),
(31442, 26040, 26040, 32.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - (ReferenceTable)'),
(31442, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Pungent Seal Whey'),
(31442, 33452, 0, 7.8, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Honey-Spiced Lichen'),
(31442, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Scourge Curio'),
(31442, 43622, 0, 1.3, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Froststeel Lockbox'),
(31442, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Titanium Lockbox'),
(31442, 43852, 0, 12.9, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Thick Fur Clothing Scraps'),
(31442, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Slasher - Book of Glyph Mastery'),
(31443, 22829, 0, 2.6, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Super Healing Potion'),
(31443, 26040, 26040, 33.5, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - (ReferenceTable)'),
(31443, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Pungent Seal Whey'),
(31443, 33452, 0, 8, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Honey-Spiced Lichen'),
(31443, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Scourge Curio'),
(31443, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Recipe: Tasty Cupcake'),
(31443, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Recipe: Last Week\'s Mammoth'),
(31443, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Recipe: Bad Clams'),
(31443, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Recipe: Haunted Herring'),
(31443, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Titanium Lockbox'),
(31443, 43852, 0, 11.4, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Thick Fur Clothing Scraps'),
(31443, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Spell Flinger - Book of Glyph Mastery'),
(31455, 33444, 0, 1.8, 0, 1, 0, 1, 1, 'Deep Crawler - Pungent Seal Whey'),
(31455, 33452, 0, 3.6, 0, 1, 0, 1, 1, 'Deep Crawler - Honey-Spiced Lichen'),
(31455, 33629, 0, 72.4, 0, 1, 0, 2, 4, 'Deep Crawler - Frosty Spinneret'),
(31455, 33630, 0, 18, 0, 1, 0, 2, 4, 'Deep Crawler - Icy Fang'),
(31455, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Deep Crawler - Titanium Lockbox'),
(31455, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Deep Crawler - Book of Glyph Mastery'),
(31466, 26040, 26040, 36.8, 0, 1, 0, 1, 1, 'Plague Walker - (ReferenceTable)'),
(31466, 33444, 0, 3.6, 0, 1, 0, 1, 1, 'Plague Walker - Pungent Seal Whey'),
(31466, 33452, 0, 8.3, 0, 1, 0, 1, 1, 'Plague Walker - Honey-Spiced Lichen'),
(31466, 42108, 0, 33, 1, 1, 0, 1, 1, 'Plague Walker - Scourge Curio'),
(31466, 43622, 0, 1.1, 0, 1, 0, 1, 1, 'Plague Walker - Froststeel Lockbox'),
(31466, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Plague Walker - Titanium Lockbox'),
(31466, 43852, 0, 11.2, 0, 1, 0, 1, 1, 'Plague Walker - Thick Fur Clothing Scraps'),
(31466, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Plague Walker - Book of Glyph Mastery'),
(31451, 26040, 26040, 34.6, 0, 1, 0, 1, 1, 'Bonegrinder - (ReferenceTable)'),
(31451, 33444, 0, 4.2, 0, 1, 0, 1, 1, 'Bonegrinder - Pungent Seal Whey'),
(31451, 33452, 0, 8.7, 0, 1, 0, 1, 1, 'Bonegrinder - Honey-Spiced Lichen'),
(31451, 42108, 0, 33, 1, 1, 0, 1, 1, 'Bonegrinder - Scourge Curio'),
(31451, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Bonegrinder - Recipe: Tasty Cupcake'),
(31451, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Bonegrinder - Recipe: Last Week\'s Mammoth'),
(31451, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Bonegrinder - Recipe: Bad Clams'),
(31451, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Bonegrinder - Recipe: Haunted Herring'),
(31451, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Bonegrinder - Titanium Lockbox'),
(31451, 43852, 0, 11.2, 0, 1, 0, 1, 1, 'Bonegrinder - Thick Fur Clothing Scraps'),
(31451, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Bonegrinder - Book of Glyph Mastery'),
(31457, 22829, 0, 1.8, 0, 1, 0, 1, 1, 'Eye of Taldaram - Super Healing Potion'),
(31457, 26040, 26040, 35.8, 0, 1, 0, 1, 1, 'Eye of Taldaram - (ReferenceTable)'),
(31457, 33444, 0, 4.1, 0, 1, 0, 1, 1, 'Eye of Taldaram - Pungent Seal Whey'),
(31457, 33452, 0, 8, 0, 1, 0, 1, 1, 'Eye of Taldaram - Honey-Spiced Lichen'),
(31457, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Eye of Taldaram - Recipe: Tasty Cupcake'),
(31457, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Eye of Taldaram - Recipe: Last Week\'s Mammoth'),
(31457, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Eye of Taldaram - Recipe: Bad Clams'),
(31457, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Eye of Taldaram - Recipe: Haunted Herring'),
(31457, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Eye of Taldaram - Titanium Lockbox'),
(31457, 43852, 0, 12.5, 0, 1, 0, 1, 1, 'Eye of Taldaram - Thick Fur Clothing Scraps'),
(31457, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Eye of Taldaram - Book of Glyph Mastery'),
(31460, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Frostbringer - Super Healing Potion'),
(31460, 26040, 26040, 33.6, 0, 1, 0, 1, 1, 'Frostbringer - (ReferenceTable)'),
(31460, 33444, 0, 4.4, 0, 1, 0, 1, 1, 'Frostbringer - Pungent Seal Whey'),
(31460, 33452, 0, 9.3, 0, 1, 0, 1, 1, 'Frostbringer - Honey-Spiced Lichen'),
(31460, 42108, 0, 33, 1, 1, 0, 1, 1, 'Frostbringer - Scourge Curio'),
(31460, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Frostbringer - Recipe: Tasty Cupcake'),
(31460, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Frostbringer - Recipe: Last Week\'s Mammoth'),
(31460, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Frostbringer - Recipe: Bad Clams'),
(31460, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Frostbringer - Recipe: Haunted Herring'),
(31460, 43622, 0, 1.1, 0, 1, 0, 1, 1, 'Frostbringer - Froststeel Lockbox'),
(31460, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Frostbringer - Titanium Lockbox'),
(31460, 43852, 0, 12.1, 0, 1, 0, 1, 1, 'Frostbringer - Thick Fur Clothing Scraps'),
(31460, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Frostbringer - Book of Glyph Mastery'),
(31468, 22829, 0, 2.3, 0, 1, 0, 1, 1, 'Plundering Geist - Super Healing Potion'),
(31468, 22832, 0, 1.3, 0, 1, 0, 1, 1, 'Plundering Geist - Super Mana Potion'),
(31468, 26040, 26040, 34.5, 0, 1, 0, 1, 1, 'Plundering Geist - (ReferenceTable)'),
(31468, 33444, 0, 4.3, 0, 1, 0, 1, 1, 'Plundering Geist - Pungent Seal Whey'),
(31468, 33452, 0, 8.2, 0, 1, 0, 1, 1, 'Plundering Geist - Honey-Spiced Lichen'),
(31468, 42108, 0, 33, 1, 1, 0, 1, 1, 'Plundering Geist - Scourge Curio'),
(31468, 43622, 0, 1, 0, 1, 0, 1, 1, 'Plundering Geist - Froststeel Lockbox'),
(31468, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Plundering Geist - Titanium Lockbox'),
(31468, 43852, 0, 12.4, 0, 1, 0, 1, 1, 'Plundering Geist - Thick Fur Clothing Scraps'),
(31468, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Plundering Geist - Book of Glyph Mastery'),
(31472, 22829, 0, 2.4, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Super Healing Potion'),
(31472, 26040, 26040, 35, 0, 1, 0, 1, 1, 'Twilight Darkcaster - (ReferenceTable)'),
(31472, 33444, 0, 5.2, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Pungent Seal Whey'),
(31472, 33454, 0, 7.9, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Salted Venison'),
(31472, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Titanium Lockbox'),
(31472, 43852, 0, 11.6, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Thick Fur Clothing Scraps'),
(31472, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Twilight Darkcaster - Book of Glyph Mastery'),
(31470, 36809, 0, 6.7, 0, 1, 0, 2, 4, 'Savage Cave Beast - Elemental Husk'),
(31470, 36810, 0, 30.3, 0, 1, 0, 2, 4, 'Savage Cave Beast - Primordial Infusion'),
(31470, 37704, 0, 6.1, 0, 1, 0, 1, 1, 'Savage Cave Beast - Crystallized Life'),
(31470, 43511, 0, 62, 1, 1, 0, 1, 2, 'Savage Cave Beast - Grotesque Fungus'),
(31470, 43512, 0, 100, 0, 1, 0, 1, 1, 'Savage Cave Beast - Ooze-covered Fungus'),
(31470, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Savage Cave Beast - Titanium Lockbox'),
(31470, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Savage Cave Beast - Book of Glyph Mastery'),
(31459, 26040, 26040, 35.8, 0, 1, 0, 1, 1, 'Forgotten One - (ReferenceTable)'),
(31459, 33444, 0, 5.4, 0, 1, 0, 1, 1, 'Forgotten One - Pungent Seal Whey'),
(31459, 33452, 0, 9, 0, 1, 0, 1, 1, 'Forgotten One - Honey-Spiced Lichen'),
(31459, 43507, 0, 0.2, 0, 1, 0, 1, 1, 'Forgotten One - Recipe: Tasty Cupcake'),
(31459, 43508, 0, 0.2, 0, 1, 0, 1, 1, 'Forgotten One - Recipe: Last Week\'s Mammoth'),
(31459, 43509, 0, 0.2, 0, 1, 0, 1, 1, 'Forgotten One - Recipe: Bad Clams'),
(31459, 43510, 0, 0.2, 0, 1, 0, 1, 1, 'Forgotten One - Recipe: Haunted Herring'),
(31459, 43622, 0, 1.1, 0, 1, 0, 1, 1, 'Forgotten One - Froststeel Lockbox'),
(31459, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Forgotten One - Titanium Lockbox'),
(31459, 43852, 0, 10.5, 0, 1, 0, 1, 1, 'Forgotten One - Thick Fur Clothing Scraps'),
(31459, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Forgotten One - Book of Glyph Mastery'),
(31501, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Portal Guardian (1) - Book of Glyph Mastery'),
(31486, 26040, 26040, 30.6, 0, 1, 0, 1, 1, 'Azure Captain - (ReferenceTable)'),
(31486, 33445, 0, 3.8, 0, 1, 0, 1, 1, 'Azure Captain - Honeymint Tea'),
(31486, 33454, 0, 7.7, 0, 1, 0, 1, 1, 'Azure Captain - Salted Venison'),
(31486, 39152, 0, 4.8, 0, 1, 0, 1, 1, 'Azure Captain - Manual: Heavy Frostweave Bandage'),
(31486, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Captain - Titanium Lockbox'),
(31486, 43852, 0, 17.6, 0, 1, 0, 1, 1, 'Azure Captain - Thick Fur Clothing Scraps'),
(31486, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Captain - Book of Glyph Mastery'),
(31493, 26040, 26040, 32.3, 0, 1, 0, 1, 1, 'Azure Sorceror - (ReferenceTable)'),
(31493, 33445, 0, 3.4, 0, 1, 0, 1, 1, 'Azure Sorceror - Honeymint Tea'),
(31493, 33447, 0, 2.4, 0, 1, 0, 1, 1, 'Azure Sorceror - Runic Healing Potion'),
(31493, 33454, 0, 7.1, 0, 1, 0, 1, 1, 'Azure Sorceror - Salted Venison'),
(31493, 39152, 0, 4.4, 0, 1, 0, 1, 1, 'Azure Sorceror - Manual: Heavy Frostweave Bandage'),
(31493, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Sorceror - Titanium Lockbox'),
(31493, 43852, 0, 16.8, 0, 1, 0, 1, 1, 'Azure Sorceror - Thick Fur Clothing Scraps'),
(31493, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Sorceror - Book of Glyph Mastery'),
(31490, 26040, 26040, 32.1, 0, 1, 0, 1, 1, 'Azure Raider - (ReferenceTable)'),
(31490, 33445, 0, 3.8, 0, 1, 0, 1, 1, 'Azure Raider - Honeymint Tea'),
(31490, 33447, 0, 2.3, 0, 1, 0, 1, 1, 'Azure Raider - Runic Healing Potion'),
(31490, 33454, 0, 7.4, 0, 1, 0, 1, 1, 'Azure Raider - Salted Venison'),
(31490, 39152, 0, 4.2, 0, 1, 0, 1, 1, 'Azure Raider - Manual: Heavy Frostweave Bandage'),
(31490, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Raider - Titanium Lockbox'),
(31490, 43852, 0, 17, 0, 1, 0, 1, 1, 'Azure Raider - Thick Fur Clothing Scraps'),
(31490, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Raider - Book of Glyph Mastery'),
(31503, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Portal Keeper (1) - Book of Glyph Mastery'),
(31502, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Portal Guardian - (ReferenceTable)'),
(31502, 26040, 26040, 33.9, 0, 1, 0, 1, 1, 'Portal Guardian - (ReferenceTable)'),
(31502, 33423, 0, 1.3, 0, 1, 0, 1, 1, 'Portal Guardian - Rime-Covered Mace'),
(31502, 33429, 0, 1.2, 0, 1, 0, 1, 1, 'Portal Guardian - Ice Cleaver'),
(31502, 33445, 0, 3.6, 0, 1, 0, 1, 1, 'Portal Guardian - Honeymint Tea'),
(31502, 33454, 0, 6.9, 0, 1, 0, 1, 1, 'Portal Guardian - Salted Venison'),
(31502, 39152, 0, 4.4, 0, 1, 0, 1, 1, 'Portal Guardian - Manual: Heavy Frostweave Bandage'),
(31502, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Portal Guardian - Titanium Lockbox'),
(31502, 43852, 0, 18.7, 0, 1, 0, 1, 1, 'Portal Guardian - Thick Fur Clothing Scraps'),
(31502, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Portal Guardian - Book of Glyph Mastery'),
(31504, 26001, 26001, 6, 0, 1, 1, 1, 1, 'Portal Keeper - (ReferenceTable)'),
(31504, 26040, 26040, 32.3, 0, 1, 0, 1, 1, 'Portal Keeper - (ReferenceTable)'),
(31504, 33428, 0, 1.1, 0, 1, 0, 1, 1, 'Portal Keeper - Dulled Shiv'),
(31504, 33431, 0, 1.1, 0, 1, 0, 1, 1, 'Portal Keeper - Icesmashing Mace'),
(31504, 33445, 0, 3.5, 0, 1, 0, 1, 1, 'Portal Keeper - Honeymint Tea'),
(31504, 33454, 0, 6.8, 0, 1, 0, 1, 1, 'Portal Keeper - Salted Venison'),
(31504, 39152, 0, 5.5, 0, 1, 0, 1, 1, 'Portal Keeper - Manual: Heavy Frostweave Bandage'),
(31504, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Portal Keeper - Titanium Lockbox'),
(31504, 43852, 0, 17.2, 0, 1, 0, 1, 1, 'Portal Keeper - Thick Fur Clothing Scraps'),
(31504, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Portal Keeper - Book of Glyph Mastery'),
(31449, 42108, 0, 33, 1, 1, 0, 1, 1, 'Ahn\'kahar Watcher (1) - Scourge Curio'),
(31449, 43494, 0, 100, 0, 1, 0, 1, 1, 'Ahn\'kahar Watcher (1) - Ahn\'kahar Watcher\'s Corpse'),
(31449, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Ahn\'kahar Watcher (1) - Book of Glyph Mastery'),
(32192, 26040, 26040, 31.7, 0, 1, 0, 1, 1, 'Azure Stalker - (ReferenceTable)'),
(32192, 33445, 0, 3.3, 0, 1, 0, 1, 1, 'Azure Stalker - Honeymint Tea'),
(32192, 33447, 0, 2.3, 0, 1, 0, 1, 1, 'Azure Stalker - Runic Healing Potion'),
(32192, 33454, 0, 7.2, 0, 1, 0, 1, 1, 'Azure Stalker - Salted Venison'),
(32192, 39152, 0, 2.8, 0, 1, 0, 1, 1, 'Azure Stalker - Manual: Heavy Frostweave Bandage'),
(32192, 43622, 0, 1.1, 0, 1, 0, 1, 1, 'Azure Stalker - Froststeel Lockbox'),
(32192, 43624, 0, 0.02, 0, 1, 0, 1, 1, 'Azure Stalker - Titanium Lockbox'),
(32192, 43852, 0, 17.2, 0, 1, 0, 1, 1, 'Azure Stalker - Thick Fur Clothing Scraps'),
(32192, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Azure Stalker - Book of Glyph Mastery');

-- Add back the Rares
-- The Oculus 578
DELETE FROM `creature_loot_template` WHERE `Reference` IN (1578000, 1578100, 1574000, 1574100, 1601000, 1601100, 1619000, 1619100, 1600000, 1600100, 1608000, 1608100, 1604000, 1604100, 1599000, 1599100, 1602000, 1602100, 1575000, 1575100, 1595000);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27649, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Murloc
(27640, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ring-Lord Conjurer
(27639, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ring-Lord Sorceress
(27642, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Mammoth
(27650, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Air
(27635, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Spellbinder
(27641, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Centrifuge Construct
(27633, 1578000, 1578000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Inquisitor
(27636, 1578000, 1578000, 1, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Ley-Whelp

(30901, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Inquisitor (1)
(30904, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Spellbinder (1)
(30902, 1578100, 1578100, 1, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Ley-Whelp (1)
(30916, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ring-Lord Sorceress (1)
(30915, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ring-Lord Conjurer (1)
(30905, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Centrifuge Construct (1)
(30909, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Mammoth (1)
(30910, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Murloc (1)
(30906, 1578100, 1578100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Phantasmal Air (1)

-- Utgarde Keep 574
(24849, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Proto-Drake Rider
(28410, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Spiritualist
(24071, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Heartsplitter
(24082, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Proto-Drake Handler
(24069, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Bonecrusher
(23960, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Runecaster
(23961, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Ironhelm
(24078, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Metalworker
(24080, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Weaponsmith
(24085, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Overseer
(24079, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Forge Master
(23956, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Strategist
(24083, 1574000, 1574000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Enslaved Proto-Drake

(31666, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Strategist (1)
(31663, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Runecaster (1)
(30747, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Ironhelm (1)
(31658, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Bonecrusher (1)
(31660, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Heartsplitter (1)
(31661, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Metalworker (1)
(31659, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Forge Master (1)
(31667, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Weaponsmith (1)
(31675, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Proto-Drake Handler (1)
(31669, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Enslaved Proto-Drake (1)
(31662, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Overseer (1)
(31676, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Proto-Drake Rider (1)
(31665, 1574100, 1574100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Spiritualist (1)

-- Azjol-Nerub 601
(28734, 1601000, 1601000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Skirmisher
(29128, 1601000, 1601000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Prime Guard
(28732, 1601000, 1601000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Warrior
(29335, 1601000, 1601000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Webspinner

(31608, 1601100, 1601100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Warrior (1)
(31606, 1601100, 1601100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Skirmisher (1)
(31604, 1601100, 1601100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Prime Guard (1)
(31609, 1601100, 1601100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Anub'ar Webspinner (1)

-- Ahn'Kahet 619
(30277, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Slasher
(30285, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Eye of Taldaram
(30276, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Web Winder
(30414, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Forgotten One
(30278, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Spell Flinger
(30286, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Frostbringer
(30179, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Twilight Apostle
(30319, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Twilight Darkcaster
(30284, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bonegrinder
(30287, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Plundering Geist
(30279, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Deep Crawler
(30283, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Plague Walker
(30329, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Savage Cave Beast
(31104, 1619000, 1619000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Watcher

(31471, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Twilight Apostle (1)
(31450, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Web Winder (1)
(31442, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Slasher (1)
(31443, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Spell Flinger (1)
(31455, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Deep Crawler (1)
(31466, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Plague Walker (1)
(31451, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bonegrinder (1)
(31457, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Eye of Taldaram (1)
(31460, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Frostbringer (1)
(31468, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Plundering Geist (1)
(31472, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Twilight Darkcaster (1)
(31470, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Savage Cave Beast (1)
(31459, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Forgotten One (1)
(31449, 1619100, 1619100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ahn'kahar Watcher (1)

-- Drak\'Tharon Keep 600
(26641, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Gutripper
(26637, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Handler
(26624, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Wretched Belcher
(26830, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Death Knight
(26620, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Guardian
(26635, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Warrior
(26621, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ghoul Tormentor
(26626, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Reanimator
(26623, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Brute
(26639, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Shaman
(26636, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Soulmage
(27431, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Commander
(26625, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Darkweb Recluse
(26638, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Bat Rider
(26628, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Scytheclaw
(26622, 1600000, 1600000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Bat

(31339, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Guardian (1)
(31347, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ghoul Tormentor (1)
(31337, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Bat (1)
(31357, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Brute (1)
(31363, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Wretched Belcher (1)
(31336, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Darkweb Recluse (1)
(31359, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Reanimator (1)
(31343, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Scytheclaw (1)
(31355, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Warrior (1)
(31354, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Soulmage (1)
(31342, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Handler (1)
(31351, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Bat Rider (1)
(31345, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Shaman (1)
(31340, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Gutripper (1)
(31352, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Risen Drakkari Death Knight (1)
(31338, 1600100, 1600100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Commander (1)

-- The Violet Hold 608
(30668, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Raider
(30666, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Captain
(30660, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Guardian
(30667, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Sorcerer
(32191, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Stalker
(30695, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Keeper
(30893, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Keeper
(30892, 1608000, 1608000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Guardian

(31501, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Guardian (1)
(31486, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Captain (1)
(31493, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Sorceror (1)
(31490, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Raider (1)
(31503, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Keeper (1)
(31502, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Guardian (1)
(31504, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Portal Keeper (1)
(32192, 1608100, 1608100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Azure Stalker (1)

-- Gundrak 604
(29819, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Lancer
(29826, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Medicine Man
(29820, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari God Hunter
(29822, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Fire Weaver
(29874, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Inciter
(29829, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Earthshaker
(29836, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Battle Rider
(29832, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Golem
(29768, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unyielding Constrictor
(29830, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Living Mojo
(29838, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Rhino
(29931, 1604000, 1604000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Rhino

(30942, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unyielding Constrictor (1)
(30932, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Lancer (1)
(30929, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari God Hunter (1)
(30927, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Fire Weaver (1)
(30933, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Medicine Man (1)
(30926, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Earthshaker (1)
(30938, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Living Mojo (1)
(30930, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Golem (1)
(30925, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Battle Rider (1)
(30935, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Rhino (1)
(30931, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Inciter (1)
(30936, 1604100, 1604100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Drakkari Rhino (1)

-- Halls of Stone 599
(27969, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Giant
(27963, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Theurgist
(27960, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Warrior
(27962, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Elementalist
(27965, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Shaper
(27961, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Worker
(27971, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unrelenting Construct
(27972, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Lightning Construct
(27970, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Raging Construct
(27964, 1599000, 1599000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Scholar

(31377, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Warrior (1)
(31378, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Worker (1)
(31372, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Elementalist (1)
(31376, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Theurgist (1)
(31374, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Scholar (1)
(31375, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Shaper (1)
(31373, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Rune Giant (1)
(31385, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Raging Construct (1)
(31387, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unrelenting Construct (1)
(31383, 1599100, 1599100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Lightning Construct (1)

-- Halls of Lightning 602
(28578, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Reaver
(28581, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Tactician
(28582, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Mender
(28579, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Berserker
(28580, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Skycaller
(28965, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Thunderer
(28836, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Runeshaper
(28838, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Vanguard
(28961, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Siegebreaker
(28547, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Storming Vortex
(28584, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unbound Firestorm
(28837, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Sentinel
(28920, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Giant
(28583, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Blistering Steamrager
(28835, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Construct
(28826, 1602000, 1602000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormfury Revenant

(30979, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Storming Vortex (1)
(30967, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Reaver (1)
(30966, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Berserker (1)
(30968, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Hardened Steel Skycaller (1)
(30977, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Tactician (1)
(30974, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Mender (1)
(30964, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Blistering Steamrager (1)
(30983, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Unbound Firestorm (1)
(30978, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormfury Revenant (1)
(30971, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Construct (1)
(30975, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Runeshaper (1)
(30976, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Sentinel (1)
(30981, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Vanguard (1)
(30972, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Stormforged Giant (1)
(30980, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Siegebreaker (1)
(30982, 1602100, 1602100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Titanium Thunderer (1)

-- Utgarde Pinnacle 575
(26670, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Flesh Hunter
(26669, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Savage
(26555, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Hulk
(26696, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Berserker
(26550, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Deathseeker
(26554, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Seer
(26694, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Dusk Shaman
(26553, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Fanatic
(28368, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Necromancer
(26672, 1575000, 1575000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bloodthirsty Tundra Wolf

(30764, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Deathseeker (1)
(30765, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Fanatic (1)
(30766, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dragonflayer Seer (1)
(30806, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Scourge Hulk (1)
(30821, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Savage (1)
(30818, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Flesh Hunter (1)
(30762, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bloodthirsty Tundra Wolf (1)
(30817, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Dusk Shaman (1)
(30816, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Berserker (1)
(30820, 1575100, 1575100, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Ymirjar Necromancer (1)

-- Culling of Stratholme 595
(27734, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Crypt Fiend
(28249, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Devouring Ghoul
(28199, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Tomb Stalker
(27732, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Master Necromancer
(28201, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bile Golem
(27743, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Hunter
(27729, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Enraging Ghoul
(27742, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Adversary
(27744, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Agent
(27736, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Patchwork Construct
(28200, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Necromancer
(27731, 1595000, 1595000, 1, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Acolyte

(31178, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Enraging Ghoul (1)
(31201, 1595000, 1595000, 1, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Acolyte (1)
(31180, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Master Necromancer (1)
(31187, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Crypt Fiend (1)
(31199, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Patchwork Construct (1)
(31202, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Adversary (1)
(31206, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Hunter (1)
(31203, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Infinite Agent (1)
(31188, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Tomb Stalker (1)
(31184, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Dark Necromancer (1)
(31200, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'), -- Bile Golem (1)
(31179, 1595000, 1595000, 3, 0, 1, 0, 1, 1, 'Dungeon Trash Rares'); -- Devouring Ghoul (1)

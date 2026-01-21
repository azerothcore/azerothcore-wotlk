-- DB update 2026_01_21_00 -> 2026_01_21_01
-- Just missing from the mob, as it should have one pair of pants for each type (cloth, leather, etc)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 18681) AND (`Item` IN (31246));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18681, 31246, 0, 0, 0, 1, 1, 1, 1, 'Coilfang Emissary - Nagahide Leggings');

-- Gruffscale Leggings: Appears to have been added in WotLK at some point, replacing an older "Boarhide Leggings" lvl 8 green. Due to that drop rates in Wowhead may be skewed towards lower than intended
DELETE FROM `creature_loot_template` WHERE (`Entry` = 6583) AND (`Item` IN (45052));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6583, 45052, 0, 100, 0, 1, 0, 1, 1, 'Gruff - Gruffscale Leggings');

-- Dustbringer: Super rare fishing loot item (novelty blue-quality drop)
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (25662,25663,25664,25665,25668,25669,25670,25671,25673,25674) AND `Item` = 44505;
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25662, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Glacial Salmon School - Dustbringer'),
(25663, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Fangtooth Herring School - Dustbringer'),
(25664, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Dragonfin Angelfish School - Dustbringer'),
(25665, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Musselback Sculpin School - Dustbringer'),
(25668, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Imperial Manta Ray School - Dustbringer'),
(25669, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Borean Man O\' War School - Dustbringer'),
(25670, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Moonglow Cuttlefish School - Dustbringer'),
(25671, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Deep Sea Monsterbelly School - Dustbringer'),
(25673, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Nettlefish School - Dustbringer'),
(25674, 44505, 0, 0.01, 0, 1, 0, 1, 1, 'Glassfin Minnow School - Dustbringer');

-- Runed Ring: Apparently these two items are rare Zul'Farrak zone BoEs, but their item level is higher than others of its type, so the only creatures that can drop them are actually the final bosses of the dungeon
-- Ensure Spellshock Leggings and Runed Ring drop from the final Zul'Farrak bosses in a separate shared loot group
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (8127, 7267)) AND (`Item` IN (9484, 862));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8127, 9484, 0, 0.25, 0, 1, 2, 1, 1, 'Antu\'Sul - Spellshock Leggings'),
(8127, 862, 0, 0.25, 0, 1, 2, 1, 1, 'Antu\'sul - Runed Ring'),
(7267, 9484, 0, 0.25, 0, 1, 2, 1, 1, 'Chief Ukorz Sandscalp - Spellshock Leggings'),
(7267, 862, 0, 0.25, 0, 1, 2, 1, 1, 'Chief Ukorz Sandscalp - Runed Ring');

-- These seem to be rare drops from Vanilla endgame dungeons. It's inconclusive if they were removed from the game at some point, and if so, why
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9237) AND (`Item` IN (13175));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9237, 13175, 0, 1, 0, 1, 0, 1, 1, 'War Master Voone - Voone\'s Twitchbow');
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9568) AND (`Item` IN (13148));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9568, 13148, 0, 1, 0, 1, 0, 1, 1, 'Overlord Wyrmthalak - Chillpike');
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10429) AND (`Item` IN (12588));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10429, 12588, 0, 1, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Bonespike Shoulder');
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1853) AND (`Item` IN (13950));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1853, 13950, 0, 1, 0, 1, 0, 1, 1, 'Darkmaster Gandling - Detention Strap');
DELETE FROM `creature_loot_template` WHERE (`Entry` = 10503) AND (`Item` IN (14543));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10503, 14543, 0, 1, 0, 1, 0, 1, 1, 'Jandice Barov - Darkshade Gloves');
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9568) AND (`Item` IN (13164));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9568, 13164, 0, 1, 0, 1, 0, 1, 1, 'Overlord Wyrmthalak - Heart of the Scale');

-- Sack of Spoils and Chest of Spoils (AQ event reward containers)
DELETE FROM `item_loot_template` WHERE (`Entry` = 20601) AND (`Item` IN (20696, 20698));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20601, 20696, 0, 5, 0, 1, 1, 1, 1, 'Sack of Spoils - Crystal Spiked Maul'),
(20601, 20698, 0, 1, 0, 1, 1, 1, 1, 'Sack of Spoils - Elemental Attuned Blade');
DELETE FROM `item_loot_template` WHERE (`Entry` = 20602) AND (`Item` IN (20722, 20721, 20720));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20602, 20722, 0, 5, 0, 1, 1, 1, 1, 'Chest of Spoils - Crystal Slugthrower'),
(20602, 20721, 0, 5, 0, 1, 1, 1, 1, 'Chest of Spoils - Band of the Cultist'),
(20602, 20720, 0, 5, 0, 1, 1, 1, 1, 'Chest of Spoils - Dark Whisper Blade');

-- Missing from Jin'do Loot Table (same ilvl as the rest)
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34089) AND (`Item` IN (19875));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34089, 19875, 0, 0, 0, 1, 1, 1, 1, 'Bloodstained Coif');

-- Rare drop from Phalanx
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9502) AND (`Item` IN (11743));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9502, 11743, 0, 2, 0, 1, 1, 1, 1, 'Phalanx - Rockfist');

-- Claimed to still drop during 3.3.3
DELETE FROM `creature_loot_template` WHERE (`Entry` = 9257) AND (`Item` IN (9214));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9257, 9214, 0, 7, 0, 1, 0, 1, 1, 'Scarshield Warlock - Grimoire of Inferno');

-- Alterac Valley Bosses
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (13256, 13419)) AND (`Item` IN (19105, 19109, 19110, 19111, 19112, 19113));
DELETE FROM `reference_loot_template` WHERE (`Entry` = 13256);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13256, 19105, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Frost Runed Headdress'),
(13256, 19109, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Deep Rooted Ring'),
(13256, 19110, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Cold Forged Blade'),
(13256, 19111, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Winteraxe Epaulets'),
(13256, 19112, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Frozen Steel Vambraces'),
(13256, 19113, 0, 0, 0, 1, 1, 1, 1, 'Alterac Valley Summon Boss - Yeti Hide Bracers');
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (13256, 13419)) AND (`Item` IN (13256));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13256, 13256, 13256, 100, 0, 1, 0, 4, 4, 'Alterac Summon Boss Loot Table'),
(13419, 13256, 13256, 100, 0, 1, 0, 4, 4, 'Alterac Summon Boss Loot Table');

-- AQ40 Trash Epic
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15312) AND (`Item` IN (21890));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15312, 21890, 0, 0.2, 0, 1, 0, 1, 1, 'Obsidian Nullifier - Gloves of the Fallen Prophet');

-- DB update 2025_03_16_01 -> 2025_03_16_02
-- Add Relic of Ulduar to loot tables Halls of Lightning
DELETE FROM `creature_loot_template` WHERE `Entry` IN (28547, 28578, 28579, 28580, 28581, 28582, 28583, 28584, 28826, 28835, 28836, 28837, 28838, 28920, 28961, 28965) AND `Item` = 42780;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28547, 42780, 0, 23, 0, 1, 0, 1, 3, 'Storming Vortex - Relic of Ulduar'),
(28578, 42780, 0, 29, 0, 1, 0, 1, 3, 'Hardened Steel Reaver - Relic of Ulduar'),
(28579, 42780, 0, 28, 0, 1, 0, 1, 3, 'Hardened Steel Berserker - Relic of Ulduar'),
(28580, 42780, 0, 27, 0, 1, 0, 1, 3, 'Hardened Steel Skycaller - Relic of Ulduar'),
(28581, 42780, 0, 30, 0, 1, 0, 1, 3, 'Stormforged Tactician - Relic of Ulduar'),
(28582, 42780, 0, 30, 0, 1, 0, 1, 3, 'Stormforged Mender - Relic of Ulduar'),
(28583, 42780, 0, 23, 0, 1, 0, 1, 3, 'Blistering Steamrager - Relic of Ulduar'),
(28584, 42780, 0, 20, 0, 1, 0, 1, 3, 'Unbound Firestorm - Relic of Ulduar'),
(28826, 42780, 0, 21, 0, 1, 0, 1, 3, 'Stormfury Revenant - Relic of Ulduar'),
(28835, 42780, 0, 20, 0, 1, 0, 1, 3, 'Stormforged Construct - Relic of Ulduar'),
(28836, 42780, 0, 34, 0, 1, 0, 1, 3, 'Stormforged Runeshaper - Relic of Ulduar'),
(28837, 42780, 0, 31, 0, 1, 0, 1, 3, 'Stormforged Sentinel - Relic of Ulduar'),
(28838, 42780, 0, 34, 0, 1, 0, 1, 3, 'Titanium Vanguard - Relic of Ulduar'),
(28920, 42780, 0, 33, 0, 1, 0, 1, 3, 'Stormforged Giant - Relic of Ulduar'),
(28961, 42780, 0, 34, 0, 1, 0, 1, 3, 'Titanium Siegebreaker - Relic of Ulduar'),
(28965, 42780, 0, 31, 0, 1, 0, 1, 3, 'Titanium Thunderer - Relic of Ulduar');

-- Private Merle (1421)
UPDATE `creature_template` SET `lootid` = 1421 WHERE (`entry` = 1421);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1421);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1421, 865, 0, 0.17, 0, 1, 0, 1, 1, 'Private Merle - Leaden Mace'),
(1421, 1707, 0, 9.58, 0, 1, 0, 1, 1, 'Private Merle - Stormwind Brie'),
(1421, 1708, 0, 4.03, 0, 1, 0, 1, 1, 'Private Merle - Sweet Nectar'),
(1421, 1710, 0, 4.71, 0, 1, 0, 1, 1, 'Private Merle - Greater Healing Potion'),
(1421, 1711, 0, 0.67, 0, 1, 0, 1, 1, 'Private Merle - Scroll of Stamina II'),
(1421, 2290, 0, 0.84, 0, 1, 0, 1, 1, 'Private Merle - Scroll of Intellect II'),
(1421, 2592, 0, 7.06, 0, 1, 0, 1, 3, 'Private Merle - Wool Cloth'),
(1421, 2725, 0, 1.51, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 1'),
(1421, 2728, 0, 1.18, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 4'),
(1421, 2730, 0, 1.01, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 6'),
(1421, 2732, 0, 1.85, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 8'),
(1421, 2734, 0, 1.51, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 10'),
(1421, 2735, 0, 1.51, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 11'),
(1421, 2738, 0, 1.01, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 14'),
(1421, 2740, 0, 2.02, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 16'),
(1421, 2742, 0, 1.85, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 18'),
(1421, 2744, 0, 0.67, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 20'),
(1421, 2745, 0, 0.67, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 21'),
(1421, 2748, 0, 1.68, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 24'),
(1421, 2749, 0, 1.85, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 25'),
(1421, 2750, 0, 0.84, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 26'),
(1421, 2751, 0, 1.01, 0, 1, 0, 1, 1, 'Private Merle - Green Hills of Stranglethorn - Page 27'),
(1421, 3778, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Taut Compound Bow'),
(1421, 3779, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Hefty War Axe'),
(1421, 3780, 0, 0.5, 0, 1, 0, 1, 1, 'Private Merle - Long-barreled Musket'),
(1421, 3784, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Metal Stave'),
(1421, 3786, 0, 0.5, 0, 1, 0, 1, 1, 'Private Merle - Shiny Dirk'),
(1421, 3792, 0, 1.01, 0, 1, 0, 1, 1, 'Private Merle - Interlaced Belt'),
(1421, 3801, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Hardened Leather Boots'),
(1421, 3804, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Hardened Leather Gloves'),
(1421, 3806, 0, 0.67, 0, 1, 0, 1, 1, 'Private Merle - Hardened Leather Shoulderpads'),
(1421, 3808, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Double Mail Belt'),
(1421, 3810, 0, 0.5, 0, 1, 0, 1, 1, 'Private Merle - Double Mail Bracers'),
(1421, 3827, 0, 1.51, 0, 1, 0, 1, 1, 'Private Merle - Mana Potion'),
(1421, 4306, 0, 53.28, 0, 1, 0, 1, 2, 'Private Merle - Silk Cloth'),
(1421, 6616, 0, 0.17, 0, 1, 0, 1, 1, 'Private Merle - Sage\'s Pants'),
(1421, 7356, 0, 0.34, 0, 1, 0, 1, 1, 'Private Merle - Elder\'s Cloak');

-- Shade of Hakkar (8440)
UPDATE `creature_template` SET `lootid` = 8440 WHERE (`entry` = 8440);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 8440);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8440, 1639, 0, 0.1, 0, 1, 0, 1, 1, 'Shade of Hakkar - Grinning Axe'),
(8440, 2100, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Precisely Calibrated Boomstick'),
(8440, 4638, 0, 0.16, 0, 1, 0, 1, 1, 'Shade of Hakkar - Reinforced Steel Lockbox'),
(8440, 6444, 0, 4.43, 0, 1, 0, 1, 1, 'Shade of Hakkar - Forked Tongue'),
(8440, 6826, 0, 6.33, 0, 1, 0, 1, 1, 'Shade of Hakkar - Brilliant Scale'),
(8440, 7520, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Gossamer Headpiece'),
(8440, 7553, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Band of the Unicorn'),
(8440, 7909, 0, 0.1, 0, 1, 0, 1, 1, 'Shade of Hakkar - Aquamarine'),
(8440, 7910, 0, 0.08, 0, 1, 0, 1, 1, 'Shade of Hakkar - Star Ruby'),
(8440, 8112, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Hibernal Pants'),
(8440, 8121, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Heraldic Gloves'),
(8440, 8130, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Myrmidon\'s Greaves'),
(8440, 8133, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Myrmidon\'s Pauldrons'),
(8440, 8255, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Serpentskin Girdle'),
(8440, 8256, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Serpentskin Boots'),
(8440, 9936, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Abjurer\'s Boots'),
(8440, 9937, 0, 0.08, 0, 1, 0, 1, 1, 'Shade of Hakkar - Abjurer\'s Bands'),
(8440, 9939, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Abjurer\'s Gloves'),
(8440, 10061, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Duskwoven Turban'),
(8440, 10062, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Duskwoven Gloves'),
(8440, 10075, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Righteous Spaulders'),
(8440, 10076, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Lord\'s Armguards'),
(8440, 10080, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Lord\'s Gauntlets'),
(8440, 10130, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Revenant Girdle'),
(8440, 10132, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Revenant Helmet'),
(8440, 10626, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Ragehammer'),
(8440, 10628, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Deathblow'),
(8440, 10629, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Mistwalker Boots'),
(8440, 10634, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Mindseye Circle'),
(8440, 10663, 0, 49.94, 0, 1, 0, 1, 1, 'Shade of Hakkar - Essence of Hakkar'),
(8440, 10838, 0, 18.73, 0, 1, 0, 1, 1, 'Shade of Hakkar - Might of Hakkar'),
(8440, 10842, 0, 35.1, 0, 1, 0, 1, 1, 'Shade of Hakkar - Windscale Sarong'),
(8440, 10843, 0, 35.35, 0, 1, 0, 1, 1, 'Shade of Hakkar - Featherskin Cape'),
(8440, 10844, 0, 17.72, 0, 1, 0, 1, 1, 'Shade of Hakkar - Spire of Hakkar'),
(8440, 10845, 0, 35.04, 0, 1, 0, 1, 1, 'Shade of Hakkar - Warrior\'s Embrace'),
(8440, 10846, 0, 36.3, 0, 1, 0, 1, 1, 'Shade of Hakkar - Bloodshot Greaves'),
(8440, 11202, 0, 0.02, 0, 1, 0, 1, 1, 'Shade of Hakkar - Formula: Enchant Shield - Stamina'),
(8440, 12013, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Desert Ring'),
(8440, 12032, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Onyx Choker'),
(8440, 12462, 0, 0.15, 0, 1, 0, 1, 1, 'Shade of Hakkar - Embrace of the Wind Serpent'),
(8440, 15216, 0, 0.07, 0, 1, 0, 1, 1, 'Shade of Hakkar - Rune Sword'),
(8440, 15245, 0, 0.07, 0, 1, 0, 1, 1, 'Shade of Hakkar - Vorpal Dagger'),
(8440, 15252, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Tusker Sword'),
(8440, 15253, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Beheading Blade'),
(8440, 15263, 0, 0.05, 0, 1, 0, 1, 1, 'Shade of Hakkar - Royal Mallet'),
(8440, 17413, 0, 0.08, 0, 1, 0, 1, 1, 'Shade of Hakkar - Codex: Prayer of Fortitude'),
(8440, 17682, 0, 0.03, 0, 1, 0, 1, 1, 'Shade of Hakkar - Book: Gift of the Wild');

-- Thane Korth'azz (16064)
UPDATE `creature_template` SET `lootid` = 16064 WHERE (`entry` = 16064);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 16064);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16064, 39393, 0, 11.65, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Claymore of Ancient Power'),
(16064, 39394, 0, 12.78, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Charmed Cierge'),
(16064, 39395, 0, 9.02, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Thane\'s Tainted Greathelm'),
(16064, 39396, 0, 10.65, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Gown of Blaumeux'),
(16064, 39397, 0, 11.15, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Pauldrons of Havoc'),
(16064, 40286, 0, 3.38, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Mantle of the Corrupted'),
(16064, 40343, 0, 2.88, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Armageddon'),
(16064, 40344, 0, 3.38, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Helm of the Grave'),
(16064, 40345, 0, 4.51, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Broken Promise'),
(16064, 40346, 0, 4.26, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Final Voyage'),
(16064, 40347, 0, 3.01, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Zeliek\'s Gauntlets'),
(16064, 40348, 0, 3.13, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Damnation'),
(16064, 40349, 0, 2.51, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Gloves of Peaceful Death'),
(16064, 40350, 0, 4.14, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Urn of Lost Memories'),
(16064, 40352, 0, 3.13, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Leggings of Voracious Shadows'),
(16064, 40610, 0, 16.92, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Chestguard of the Lost Conqueror'),
(16064, 40611, 0, 16.67, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Chestguard of the Lost Protector'),
(16064, 40612, 0, 20.8, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Chestguard of the Lost Vanquisher'),
(16064, 40625, 0, 10.4, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Breastplate of the Lost Conqueror'),
(16064, 40626, 0, 10.65, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Breastplate of the Lost Protector'),
(16064, 40627, 0, 13.16, 0, 1, 0, 1, 1, 'Thane Korth\'azz - Breastplate of the Lost Vanquisher');

-- Avatar of the Martyred (18478)
UPDATE `creature_template` SET `lootid` = 18478 WHERE (`entry` = 18478);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 18478);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18478, 21877, 0, 99.12, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Netherweave Cloth'),
(18478, 27797, 0, 16.03, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Wastewalker Shoulderpads'),
(18478, 27876, 0, 12.98, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Will of the Fallen Exarch'),
(18478, 27877, 0, 19.85, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Draenic Wildstaff'),
(18478, 27878, 0, 13.74, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Auchenai Death Shroud'),
(18478, 27937, 0, 20.61, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Sky Breaker'),
(18478, 28268, 0, 16.79, 0, 1, 0, 1, 1, 'Avatar of the Martyred - Natural Mender\'s Wraps');

-- Domesticated Felboar (21195)
UPDATE `creature_template` SET `lootid` = 21195 WHERE (`entry` = 21195);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 21195);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21195, 21887, 0, 45.45, 0, 1, 0, 1, 1, 'Domesticated Felboar - Knothide Leather'),
(21195, 25649, 0, 27.27, 0, 1, 0, 2, 2, 'Domesticated Felboar - Knothide Leather Scraps');

-- Necro Knight Guardian (16452)
UPDATE `creature_template` SET `lootid` = 16452 WHERE (`entry` = 16452);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 16452);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16452, 5760, 0, 0.62, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Eternium Lockbox'),
(16452, 7909, 0, 0.33, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Aquamarine'),
(16452, 7910, 0, 0.33, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Star Ruby'),
(16452, 8290, 0, 0.28, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Arcane Robe'),
(16452, 10137, 0, 0.19, 0, 1, 0, 1, 1, 'Necro Knight Guardian - High Councillor\'s Boots'),
(16452, 10142, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - High Councillor\'s Mantle'),
(16452, 10150, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mighty Helmet'),
(16452, 10152, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mighty Leggings'),
(16452, 10157, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mercurial Breastplate'),
(16452, 10161, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mercurial Gauntlets'),
(16452, 10162, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mercurial Legguards'),
(16452, 10163, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Mercurial Pauldrons'),
(16452, 10227, 0, 0.24, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Nightshade Leggings'),
(16452, 10252, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Master\'s Leggings'),
(16452, 10254, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Master\'s Robe'),
(16452, 10255, 0, 0.28, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Master\'s Belt'),
(16452, 10264, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Adventurer\'s Tunic'),
(16452, 10368, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Imbued Plate Armor'),
(16452, 10382, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Commander\'s Leggings'),
(16452, 10389, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Hyperion Legplates'),
(16452, 11979, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Peridot Circle'),
(16452, 12713, 0, 0.24, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Plans: Radiant Leggings'),
(16452, 12808, 0, 1.85, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Essence of Undeath'),
(16452, 14494, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Pattern: Brightcloth Pants'),
(16452, 14504, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Pattern: Runecloth Shoulders'),
(16452, 14506, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Pattern: Felcloth Robe'),
(16452, 15220, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Battlefell Sabre'),
(16452, 15257, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Shin Blade'),
(16452, 15267, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Brutehammer'),
(16452, 15273, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Death Striker'),
(16452, 15289, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Archstrike Bow'),
(16452, 15296, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Hawkeye Bow'),
(16452, 17414, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Codex: Prayer of Fortitude II'),
(16452, 22373, 0, 23.22, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Wartorn Leather Scrap'),
(16452, 22374, 0, 14.17, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Wartorn Chain Scrap'),
(16452, 22375, 0, 20.95, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Wartorn Plate Scrap'),
(16452, 22376, 0, 29.05, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Wartorn Cloth Scrap'),
(16452, 22708, 0, 0.43, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Fate of Ramaladni'),
(16452, 22890, 0, 0.24, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Tome of Frost Ward V'),
(16452, 22891, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Grimoire of Shadow Ward IV'),
(16452, 23044, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Harbinger of Doom'),
(16452, 23055, 0, 6.07, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Word of Thawing'),
(16452, 23226, 0, 0.09, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Ghoul Skin Tunic'),
(16452, 23237, 0, 0.24, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Ring of the Eternal Flame'),
(16452, 23238, 0, 0.28, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Stygian Buckler'),
(16452, 23668, 0, 0.14, 0, 1, 0, 1, 1, 'Necro Knight Guardian - Leggings of the Grand Crusader');

-- Hathyss the Wicked (22381)
UPDATE `creature_template` SET `lootid` = 22381 WHERE (`entry` = 22381);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 22381);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22381, 21877, 0, 78.12, 0, 1, 0, 1, 3, 'Hathyss the Wicked - Netherweave Cloth'),
(22381, 22829, 0, 9.38, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Super Healing Potion'),
(22381, 25301, 0, 3.12, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Shattering Dagger'),
(22381, 25303, 0, 1.56, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Amplifying Blade'),
(22381, 25397, 0, 1.56, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Eroded Axe'),
(22381, 27854, 0, 10.94, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Smoked Talbuk Venison'),
(22381, 27860, 0, 3.12, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Purified Draenic Water'),
(22381, 33459, 0, 1.56, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Scroll of Protection VI'),
(22381, 33460, 0, 1.56, 0, 1, 0, 1, 1, 'Hathyss the Wicked - Scroll of Spirit VI');

-- DB update 2026_09_28_00 -> 2026_09_28_01
-- Rounded Alexei-only weights based on observed drop frequencies.
-- https://www.wowhead.com/wotlk/npc=10504/lord-alexei-barov#drops
-- Zero-chance entries share the remaining 11.5% equally.
DELETE FROM `reference_loot_template` WHERE `Entry` = 35095;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35095, 14611, 0, 8.5, 0, 1, 1, 1, 1, 'Bloodmail Hauberk'),
(35095, 14612, 0, 0, 0, 1, 1, 1, 1, 'Bloodmail Legguards'),
(35095, 14614, 0, 0, 0, 1, 1, 1, 1, 'Bloodmail Belt'),
(35095, 14615, 0, 0, 0, 1, 1, 1, 1, 'Bloodmail Gauntlets'),
(35095, 14616, 0, 0, 0, 1, 1, 1, 1, 'Bloodmail Boots'),
(35095, 14620, 0, 0, 0, 1, 1, 1, 1, 'Deathbone Girdle'),
(35095, 14621, 0, 0, 0, 1, 1, 1, 1, 'Deathbone Sabatons'),
(35095, 14622, 0, 0, 0, 1, 1, 1, 1, 'Deathbone Gauntlets'),
(35095, 14623, 0, 0, 0, 1, 1, 1, 1, 'Deathbone Legguards'),
(35095, 14624, 0, 8.5, 0, 1, 1, 1, 1, 'Deathbone Chestplate'),
(35095, 14626, 0, 8.5, 0, 1, 1, 1, 1, 'Necropile Robe'),
(35095, 14629, 0, 0, 0, 1, 1, 1, 1, 'Necropile Cuffs'),
(35095, 14631, 0, 0, 0, 1, 1, 1, 1, 'Necropile Boots'),
(35095, 14632, 0, 0, 0, 1, 1, 1, 1, 'Necropile Leggings'),
(35095, 14633, 0, 0, 0, 1, 1, 1, 1, 'Necropile Mantle'),
(35095, 14636, 0, 0, 0, 1, 1, 1, 1, 'Cadaverous Belt'),
(35095, 14637, 0, 8.5, 0, 1, 1, 1, 1, 'Cadaverous Armor'),
(35095, 14638, 0, 0, 0, 1, 1, 1, 1, 'Cadaverous Leggings'),
(35095, 14640, 0, 0, 0, 1, 1, 1, 1, 'Cadaverous Gloves'),
(35095, 14641, 0, 0, 0, 1, 1, 1, 1, 'Cadaverous Walkers'),
(35095, 16722, 0, 5, 0, 1, 1, 1, 1, 'Lightforge Bracers'),
(35095, 18680, 0, 8.5, 0, 1, 1, 1, 1, 'Ancient Bone Bow'),
(35095, 18681, 0, 8.5, 0, 1, 1, 1, 1, 'Burial Shawl'),
(35095, 18682, 0, 8.5, 0, 1, 1, 1, 1, 'Ghoul Skin Leggings'),
(35095, 18683, 0, 8.5, 0, 1, 1, 1, 1, 'Hammer of the Vesper'),
(35095, 18684, 0, 8.5, 0, 1, 1, 1, 1, 'Dimly Opalescent Ring'),
(35095, 23200, 0, 3, 0, 1, 1, 1, 1, 'Totem of Sustaining'),
(35095, 23201, 0, 4, 0, 1, 1, 1, 1, 'Libram of Divinity');

-- One primary roll, including the bracers; incidental drops stay independent.
DELETE FROM `creature_loot_template` WHERE `Entry` = 10504 AND `Item` IN (16722, 35031, 35095) AND `GroupId` = 1;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10504, 35095, 35095, 100, 0, 1, 1, 1, 1, 'Lord Alexei Barov - Primary rare');

-- Replace individual incidental drops with the level-60 elite world-loot pool.
DELETE FROM `creature_loot_template` WHERE `Entry` = 10504 AND `Item` IN (1, 4500, 5759, 7909, 7910, 8766, 8932, 10307, 10308, 10309, 10310, 12683, 12684, 12713, 13492, 14484, 14491, 14494, 14498, 16245, 17414, 17683, 18335, 18600, 19262, 19281);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10504, 1, 1000360, 0, 0, 1, 5, 1, 1, 'Lord Alexei Barov - World Loot Level 60'),
(10504, 8766, 0, 0.863275, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Morning Glory Dew'),
(10504, 8932, 0, 1.528816, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Alterac Swiss');

-- Food/drink: 179/317 observations out of 20,735; Runecloth: 2,440, stacks of 2-4.
UPDATE `creature_loot_template` SET `Chance` = 11.767543, `MinCount` = 2, `MaxCount` = 4
WHERE `Entry` = 10504 AND `Item` = 14047 AND `Reference` = 0;

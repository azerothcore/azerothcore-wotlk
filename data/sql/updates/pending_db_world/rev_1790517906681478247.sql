-- Alexei incidental loot: observed counts / 20,735 samples, checked 2026-09-27.
-- https://www.wowhead.com/wotlk/npc=10504/lord-alexei-barov#drops
-- Independent rolls; these items do not consume the guaranteed primary rare.
DELETE FROM `creature_loot_template` WHERE `Entry` = 10504 AND `Item` IN (4500, 5759, 7909, 7910, 8766, 8932, 10307, 10308, 10309, 10310, 12683, 12684, 12713, 13492, 14484, 14491, 14494, 14498, 16245, 17414, 17683, 18335, 18600, 19262, 19281);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10504, 4500, 0, 0.057873, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Traveler\'s Backpack'), -- 12 samples
(10504, 5759, 0, 0.221847, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Thorium Lockbox'), -- 46 samples
(10504, 7909, 0, 0.178442, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Aquamarine'), -- 37 samples
(10504, 7910, 0, 0.135037, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Star Ruby'), -- 28 samples
(10504, 8766, 0, 0.863275, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Morning Glory Dew'), -- 179 samples
(10504, 8932, 0, 1.528816, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Alterac Swiss'), -- 317 samples
(10504, 10307, 0, 0.101278, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Scroll of Stamina IV'), -- 21 samples
(10504, 10308, 0, 0.033759, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Scroll of Intellect IV'), -- 7 samples
(10504, 10309, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Scroll of Agility IV'), -- 2 samples
(10504, 10310, 0, 0.028937, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Scroll of Strength IV'), -- 6 samples
(10504, 12683, 0, 0.004823, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Plans: Thorium Belt'), -- 1 sample
(10504, 12684, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Plans: Thorium Bracers'), -- 2 samples
(10504, 12713, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Plans: Radiant Leggings'), -- 2 samples
(10504, 13492, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Recipe: Purification Potion'), -- 2 samples
(10504, 14484, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Pattern: Brightcloth Cloak'), -- 2 samples
(10504, 14491, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Pattern: Runecloth Pants'), -- 2 samples
(10504, 14494, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Pattern: Brightcloth Pants'), -- 2 samples
(10504, 14498, 0, 0.014468, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Pattern: Runecloth Headband'), -- 3 samples
(10504, 16245, 0, 0.014468, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Formula: Enchant Boots - Greater Agility'), -- 3 samples
(10504, 17414, 0, 0.043405, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Codex: Prayer of Fortitude II'), -- 9 samples
(10504, 17683, 0, 0.057873, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Book: Gift of the Wild II'), -- 12 samples
(10504, 18335, 0, 0.086810, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Pristine Black Diamond'), -- 18 samples
(10504, 18600, 0, 0.014468, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Tome of Arcane Brilliance'), -- 3 samples
(10504, 19262, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Five of Warlords'), -- 2 samples
(10504, 19281, 0, 0.009646, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Five of Portals'); -- 2 samples

-- Runecloth: 2,440 samples, stacks of 2-4.
UPDATE `creature_loot_template` SET `Chance` = 11.767543, `MinCount` = 2, `MaxCount` = 4
WHERE `Entry` = 10504 AND `Item` = 14047 AND `Reference` = 0;

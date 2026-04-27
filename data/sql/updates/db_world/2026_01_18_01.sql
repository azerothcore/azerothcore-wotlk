-- DB update 2026_01_18_00 -> 2026_01_18_01
-- Add skinning loot table for creature 1933 (Sheep) to enable Ruined Leather Scraps, Wool Cloth, and Light Leather drops.
UPDATE `creature_template` SET `skinloot` = 1933 WHERE (`entry` = 1933);

DELETE FROM `skinning_loot_template` WHERE (`Entry` = 1933);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1933, 2934, 0, 55, 0, 1, 1, 1, 1, 'Ruined Leather Scraps'),
(1933, 2592, 0, 35, 0, 1, 1, 1, 1, 'Wool Cloth'),
(1933, 2318, 0, 10, 0, 1, 1, 1, 1, 'Light Leather');

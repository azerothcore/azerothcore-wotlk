INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628329351520849428');

-- Create new skinning table for 100015 for lvl 10-15 NPCs
DELETE from `skinning_loot_template` WHERE `Entry` = 100015;
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(100015, 2318, 0, 60, 0, 1, 1, 1, 2, '10-15 drops - Light Leather'),
(100015, 2934, 0, 35, 0, 1, 1, 1, 1, '10-15 drops - Ruined Leather Scraps'),
(100015,  783, 0,  5, 0, 1, 1, 1, 1, '10-15 drops - Light Hide');

-- Add level-appropriate skinning drops to various 10-16 mobs
UPDATE `creature_template` SET `skinloot` = 100015 WHERE `entry` IN (157, 454, 833, 1130, 1186, 1188, 1191, 1271, 1693, 1766, 1769, 1770, 1778, 1779, 1782, 1797, 1892, 1893, 1896, 1924, 1961, 1972, 2069, 2163, 2164, 2185, 2321, 2322, 2974, 3056, 3058, 3231, 3234, 3241, 3242, 3243, 3244, 3246, 3248, 3254, 3255, 3415, 3425, 3461, 3531, 4127, 4316, 5865, 12431, 12432, 16348, 16354, 17347, 17525, 17556);

-- Remove skinning loot from lvl 1 Parasitic Serpent and Vagash
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (1388, 14884);

-- Update Snort the Heckler to better table
UPDATE `creature_template` SET `skinloot` = 100004 WHERE `entry` = 5829;


--
-- Issue #3113: playercreateinfo_* did not use a bitmask for races and classes.
--
-- playercreateinfo_skills, playercreateinfo_cast_spell and playercreateinfo_spell_custom already
-- carry raceMask/classMask. These three did not, so a row could only ever name one race and one
-- class. Converting them finishes the job and lets one row stand for many combinations.
--
-- The condensation below is lossless: rows merge only where every other column is identical, and
-- playercreateinfo groups per race so the masks always expand back to a complete rectangle. The
-- Durotar start is why that matters - races Orc and Troll share a position across 7 classes, but
-- only 11 of those 14 pairs exist, so OR-ing both masks together would have made an orc mage
-- creatable. Expanding the new rows reproduces exactly the 62 and 283 pairs that were there before.
--
-- UPGRADE NOTE: the three tables are emptied and rewritten, so any custom rows in them are lost and
-- must be re-added using the new columns. Keeping them was not an option - a leftover row would have
-- its race read as a mask, turning "race 5" (Undead) into "races 1 and 3" (Human and Dwarf). Custom
-- SQL selecting playercreateinfo.race or .class also needs updating to raceMask/classMask.
--

ALTER TABLE `playercreateinfo`
    DROP PRIMARY KEY,
    CHANGE `race` `raceMask` int unsigned NOT NULL DEFAULT 0,
    CHANGE `class` `classMask` int unsigned NOT NULL DEFAULT 0,
    ADD PRIMARY KEY (`raceMask`, `classMask`);

ALTER TABLE `playercreateinfo_action`
    DROP PRIMARY KEY,
    DROP INDEX `playercreateinfo_race_class_index`,
    CHANGE `race` `raceMask` int unsigned NOT NULL DEFAULT 0,
    CHANGE `class` `classMask` int unsigned NOT NULL DEFAULT 0,
    ADD PRIMARY KEY (`raceMask`, `classMask`, `button`),
    ADD INDEX `playercreateinfo_race_class_index` (`raceMask`, `classMask`);

ALTER TABLE `playercreateinfo_item`
    DROP PRIMARY KEY,
    DROP INDEX `playercreateinfo_race_class_index`,
    CHANGE `race` `raceMask` int unsigned NOT NULL DEFAULT 0,
    CHANGE `class` `classMask` int unsigned NOT NULL DEFAULT 0,
    ADD PRIMARY KEY (`raceMask`, `classMask`, `itemid`),
    ADD INDEX `playercreateinfo_race_class_index` (`raceMask`, `classMask`);

DELETE FROM `playercreateinfo`;
INSERT INTO `playercreateinfo` (`raceMask`, `classMask`, `map`, `zone`, `position_x`, `position_y`,
    `position_z`, `orientation`) VALUES
    (1, 32, 609, 4298, 2355.84, -5664.77, 426.028, 3.65997),
    (1, 411, 0, 12, -8949.95, -132.493, 83.5312, 0),
    (2, 32, 609, 4298, 2358.44, -5666.9, 426.023, 3.65997),
    (2, 333, 1, 14, -618.518, -4251.67, 38.718, 0),
    (4, 31, 0, 1, -6240.32, 331.033, 382.758, 6.17716),
    (4, 32, 609, 4298, 2358.44, -5666.9, 426.023, 3.65997),
    (8, 32, 609, 4298, 2356.21, -5662.21, 426.026, 3.65997),
    (8, 1053, 1, 141, 10311.3, 832.463, 1326.41, 5.69632),
    (16, 32, 609, 4298, 2356.21, -5662.21, 426.026, 3.65997),
    (16, 409, 0, 85, 1676.71, 1678.31, 121.67, 2.70526),
    (32, 32, 609, 4298, 2358.17, -5663.21, 426.027, 3.65997),
    (32, 1093, 1, 215, -2917.58, -257.98, 52.9968, 0),
    (64, 1, 0, 1, -6240.32, 331.033, 382.758, 0),
    (64, 32, 609, 4298, 2355.05, -5661.7, 426.026, 3.65997),
    (64, 392, 0, 1, -6240, 331, 383, 0),
    (128, 32, 609, 4298, 2355.05, -5661.7, 426.026, 3.65997),
    (128, 221, 1, 14, -618.518, -4251.67, 38.718, 0),
    (512, 32, 609, 4298, 2355.84, -5664.77, 426.028, 3.65997),
    (512, 414, 530, 3431, 10349.6, -6357.29, 33.4026, 5.31605),
    (1024, 32, 609, 4298, 2358.17, -5663.21, 426.027, 3.65997),
    (1024, 215, 530, 3526, -3961.64, -13931.2, 100.615, 2.08364);

DELETE FROM `playercreateinfo_action`;
INSERT INTO `playercreateinfo_action` (`raceMask`, `classMask`, `button`, `action`, `type`) VALUES
    (1279, 1, 72, 6603, 0),
    (1279, 1, 73, 78, 0),
    (2, 1, 74, 20572, 0),
    (4, 1, 74, 20594, 0),
    (8, 1, 74, 58984, 0),
    (16, 1, 74, 20577, 0),
    (32, 1, 74, 20549, 0),
    (128, 1, 74, 2764, 0),
    (1024, 1, 74, 28880, 0),
    (4, 1, 75, 2481, 0),
    (128, 1, 75, 26297, 0),
    (1, 1, 82, 59752, 0),
    (1279, 1, 84, 6603, 0),
    (1279, 1, 96, 6603, 0),
    (1541, 2, 0, 6603, 0),
    (1541, 2, 1, 21084, 0),
    (1541, 2, 2, 635, 0),
    (4, 2, 3, 20594, 0),
    (512, 2, 3, 28730, 0),
    (1024, 2, 3, 59542, 0),
    (4, 2, 4, 2481, 0),
    (1, 2, 9, 59752, 0),
    (1710, 4, 0, 6603, 0),
    (1710, 4, 1, 2973, 0),
    (1710, 4, 2, 75, 0),
    (2, 4, 3, 20572, 0),
    (4, 4, 3, 20594, 0),
    (8, 4, 3, 58984, 0),
    (32, 4, 3, 20549, 0),
    (128, 4, 3, 26297, 0),
    (512, 4, 3, 28730, 0),
    (1024, 4, 3, 59543, 0),
    (4, 4, 4, 2481, 0),
    (735, 8, 0, 6603, 0),
    (735, 8, 1, 1752, 0),
    (735, 8, 2, 2098, 0),
    (735, 8, 3, 2764, 0),
    (2, 8, 4, 20572, 0),
    (4, 8, 4, 20594, 0),
    (8, 8, 4, 58984, 0),
    (16, 8, 4, 20577, 0),
    (128, 8, 4, 26297, 0),
    (512, 8, 4, 25046, 0),
    (4, 8, 5, 2481, 0),
    (1, 8, 10, 59752, 0),
    (1693, 16, 0, 585, 0),
    (1693, 16, 1, 2050, 0),
    (4, 16, 2, 20594, 0),
    (8, 16, 2, 58984, 0),
    (16, 16, 2, 20577, 0),
    (128, 16, 2, 26297, 0),
    (512, 16, 2, 28730, 0),
    (1024, 16, 2, 59544, 0),
    (4, 16, 3, 2481, 0),
    (1, 16, 9, 59752, 0),
    (1791, 32, 0, 6603, 0),
    (1791, 32, 1, 49576, 0),
    (1791, 32, 2, 45477, 0),
    (1791, 32, 3, 45462, 0),
    (1791, 32, 4, 45902, 0),
    (1791, 32, 5, 47541, 0),
    (512, 32, 6, 50613, 0),
    (2, 32, 10, 20572, 0),
    (4, 32, 10, 2481, 0),
    (8, 32, 10, 58984, 0),
    (16, 32, 10, 20577, 0),
    (32, 32, 10, 20549, 0),
    (64, 32, 10, 20589, 0),
    (128, 32, 10, 26297, 0),
    (1024, 32, 10, 59545, 0),
    (1, 32, 11, 59752, 0),
    (1186, 64, 0, 6603, 0),
    (1186, 64, 1, 403, 0),
    (1186, 64, 2, 331, 0),
    (2, 64, 3, 33697, 0),
    (32, 64, 3, 20549, 0),
    (128, 64, 3, 26297, 0),
    (1024, 64, 3, 59547, 0),
    (1745, 128, 0, 133, 0),
    (1745, 128, 1, 168, 0),
    (16, 128, 2, 20577, 0),
    (128, 128, 2, 26297, 0),
    (512, 128, 2, 28730, 0),
    (1024, 128, 2, 59548, 0),
    (1, 128, 9, 59752, 0),
    (595, 256, 0, 686, 0),
    (595, 256, 1, 687, 0),
    (2, 256, 2, 33702, 0),
    (16, 256, 2, 20577, 0),
    (512, 256, 2, 28730, 0),
    (1, 256, 9, 59752, 0),
    (40, 1024, 0, 5176, 0),
    (40, 1024, 1, 5185, 0),
    (8, 1024, 2, 58984, 0),
    (32, 1024, 2, 20549, 0),
    (40, 1024, 72, 6603, 0),
    (8, 1024, 74, 58984, 0),
    (32, 1024, 75, 20549, 0),
    (40, 1024, 96, 6603, 0);

DELETE FROM `playercreateinfo_item`;
INSERT INTO `playercreateinfo_item` (`raceMask`, `classMask`, `itemid`, `amount`, `Note`) VALUES
    (0, 32, 40582, -1, '[TDB PH] - unsused Scourgestone');

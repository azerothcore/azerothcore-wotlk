-- DB update 2025_01_07_01 -> 2025_01_07_02
-- loot table for item 22568 Sealed Craftsman's Writ
UPDATE `item_template` SET `flagsCustom` = `flagsCustom` | 2 WHERE `entry` BETWEEN 22600 AND 22626;

-- DB update 2023_03_04_04 -> 2023_03_04_05
-- Scarlet Enchanter - Remove OOC attack closest player
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9452 AND `source_type` = 0 AND `id` = 2;

-- Scarlet Cleric - Remove OOC attack closest player
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9449 AND `source_type` = 0 AND `id` = 3;

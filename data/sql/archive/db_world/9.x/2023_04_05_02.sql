-- DB update 2023_04_05_01 -> 2023_04_05_02
--
-- Remove Pollution from Water Barrels (gameobject 3658)
DELETE FROM `gameobject_loot_template` WHERE `Entry`=2502 AND `Item` IN (851, 852, 853, 854, 858, 1196, 1197, 1198, 2207, 2455, 4765, 4766, 4777, 4778);

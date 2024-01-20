-- DB update 2023_04_12_01 -> 2023_04_12_02
DELETE FROM `creature_loot_template` WHERE `Item` = 21855 AND `Entry` IN (17796,20630);

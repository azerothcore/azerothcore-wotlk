-- DB update 2022_11_21_10 -> 2022_11_21_11
-- Remove golden pearl drop from creature
DELETE FROM `item_loot_template` WHERE `Entry` IN (17917, 20627) AND (`Item` IN (13926));

-- Remove golden pearl drop from creature
DELETE FROM `item_loot_template` WHERE `Entry` IN (17917, 20627) AND (`Item` IN (13926));

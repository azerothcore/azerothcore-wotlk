-- Delete Nerubian Chitin, Borean Leather, and Arctic Fur from loot table from various creatures in WotLK
DELETE from `creature_loot_template` WHERE `item` = 33568;
DELETE from `creature_loot_template` WHERE `item` = 44128;
DELETE from `creature_loot_template` WHERE `item` = 38558;

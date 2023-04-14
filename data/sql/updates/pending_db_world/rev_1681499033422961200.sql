--
-- Removes Jade and Citrine (wrong level mob), Mining, and Herbing loot from Flesh Eater
DELETE FROM `creature_loot_template` WHERE `entry`=3 AND `item` IN (1529, 2453, 2770, 2775, 2835, 2838, 3369, 3864, 5504, 2772);

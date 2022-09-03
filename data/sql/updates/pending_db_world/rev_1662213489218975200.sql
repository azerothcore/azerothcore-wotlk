-- Princess Huhuran
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15509 AND `item` BETWEEN 21616 AND 21621;
-- Twin Emperors
UPDATE `creature_loot_template` SET `Chance`=5 WHERE `entry` IN (15275,15276) AND `item` IN (20726,20735);
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry` IN (15275,15276) AND `item` IN (21604,21605,21606,21607,21608,21609,21679,21597,21598,21599,21600,21601,21602);

-- Idols
UPDATE `creature_loot_template` SET `Chance`=0.4 WHERE `Item` IN (20874, 20875, 20876, 20877, 20878, 20879, 20881, 20882);

-- The Prophet Skeram
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15263 AND `reference`=34046;
-- Battleguard Sartura
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15516 AND `reference`=34047;
-- Fankriss the Unyielding
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15510 AND `reference`=34048;
-- Princess Huhuran
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry`=15509 AND `item` BETWEEN 21616 AND 21621;
-- Twin Emperors
UPDATE `creature_loot_template` SET `Chance`=5 WHERE `entry` IN (15275,15276) AND `item` IN (20726,20735);
UPDATE `creature_loot_template` SET `Chance`=0 WHERE `entry` IN (15275,15276) AND `item` IN (21604,21605,21606,21607,21608,21609,21679,21597,21598,21599,21600,21601,21602);

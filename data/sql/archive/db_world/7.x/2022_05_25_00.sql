-- DB update 2022_05_24_00 -> 2022_05_25_00
-- Insert missing Bear Flank drop rate for Rabid Shardtooth
DELETE FROM `creature_loot_template` WHERE `Entry` = 7446 AND `Item` = 35562;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `Comment`) VALUES (7446, 35562, 65, 'Rabid Shardtooth - Bear Flank');

-- Update Bears from level 47 to 60 with correct Bear Flank drop rates
UPDATE `creature_loot_template` SET `Chance` = 45 WHERE `Item` = 35562 AND `Entry` = 8957;
UPDATE `creature_loot_template` SET `Chance` = 50 WHERE `Item` = 35562 AND `Entry` IN(8956, 1815, 5274);
UPDATE `creature_loot_template` SET `Chance` = 55 WHERE `Item` = 35562 AND `Entry` IN(7444, 7443);
UPDATE `creature_loot_template` SET `Chance` = 60 WHERE `Item` = 35562 AND `Entry` = 8958;
UPDATE `creature_loot_template` SET `Chance` = 65 WHERE `Item` = 35562 AND `Entry` IN(1816, 7446, 7445);

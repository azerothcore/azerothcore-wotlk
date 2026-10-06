-- DB update 2026_10_06_02 -> 2026_10_06_03
--
UPDATE `item_template` SET `BuyCount` = 5 WHERE `entry` IN (24006, 24009);

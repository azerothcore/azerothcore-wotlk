-- DB update 2023_06_18_02 -> 2023_06_18_03
--

DELETE FROM `item_enchantment_template` WHERE `entry` = 5173 AND `ench` IN (29,33,91,197,231,927,1399,1913,1952,2067,2068,2069);

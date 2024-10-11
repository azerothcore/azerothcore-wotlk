-- DB update 2023_12_12_04 -> 2023_12_12_05
--
UPDATE `item_template` SET `FlagsExtra`=`FlagsExtra`|512 WHERE `entry` = 31088;

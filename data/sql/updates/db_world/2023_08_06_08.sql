-- DB update 2023_08_06_07 -> 2023_08_06_08
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE `entry` IN (15689, 17225);

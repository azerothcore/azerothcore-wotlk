-- DB update 2023_08_07_00 -> 2023_08_08_00
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|4|33554432 WHERE `entry` = 18168;

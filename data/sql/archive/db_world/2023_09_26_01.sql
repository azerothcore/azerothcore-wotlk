-- DB update 2023_09_26_00 -> 2023_09_26_01
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE `entry` = 15690;

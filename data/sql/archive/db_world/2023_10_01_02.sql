-- DB update 2023_10_01_01 -> 2023_10_01_02
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE `entry` = 17535;

-- DB update 2023_08_06_06 -> 2023_08_06_07
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|256|4096 WHERE `entry` = 17256;

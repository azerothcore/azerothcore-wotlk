-- DB update 2023_08_14_01 -> 2023_08_14_02
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|256|8388608 WHERE `entry` = 18829;

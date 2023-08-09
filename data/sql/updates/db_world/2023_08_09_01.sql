-- DB update 2023_08_09_00 -> 2023_08_09_01
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|8388608 WHERE `entry` = 19261;

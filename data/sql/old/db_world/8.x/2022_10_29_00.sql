-- DB update 2022_10_28_00 -> 2022_10_29_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` = 15276;

-- DB update 2023_06_17_12 -> 2023_06_18_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` IN (18732,20653);


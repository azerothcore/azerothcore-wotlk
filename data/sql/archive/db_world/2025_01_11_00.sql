-- DB update 2025_01_10_03 -> 2025_01_11_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` = 23574;

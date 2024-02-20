-- DB update 2024_02_20_02 -> 2024_02_20_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |33554432 WHERE `entry` = 20041;

-- DB update 2024_07_06_08 -> 2024_07_06_09
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` = 23394;

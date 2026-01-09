-- DB update 2024_06_22_04 -> 2024_06_22_05
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` = 23330;

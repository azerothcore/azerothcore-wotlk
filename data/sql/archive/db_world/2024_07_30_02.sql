-- DB update 2024_07_30_01 -> 2024_07_30_02
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~33554432 WHERE `entry` = 23419;

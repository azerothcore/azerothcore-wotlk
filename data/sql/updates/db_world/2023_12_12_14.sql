-- DB update 2023_12_12_13 -> 2023_12_12_14
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~33554432 WHERE `entry` = 21964;

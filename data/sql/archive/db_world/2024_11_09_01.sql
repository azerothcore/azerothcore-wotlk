-- DB update 2024_11_09_00 -> 2024_11_09_01
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` & ~(33554432 | 67108864) WHERE `entry` = 5855;

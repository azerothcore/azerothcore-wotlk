-- DB update 2024_01_23_00 -> 2024_01_29_00
-- 20033 and 20034 were 1|2048 and 20047  was 2048
UPDATE `creature_template` SET `mechanic_immune_mask` = 0 WHERE `entry` IN (20033, 20034);
UPDATE `creature_template` SET `mechanic_immune_mask` = 256|33554432 WHERE `entry` = 20047;

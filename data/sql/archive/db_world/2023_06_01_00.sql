-- DB update 2023_05_29_02 -> 2023_06_01_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432 WHERE `entry` IN (18341, 20267);

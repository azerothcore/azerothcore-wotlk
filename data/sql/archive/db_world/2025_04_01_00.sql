-- DB update 2025_03_31_03 -> 2025_04_01_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE `entry` IN (25597, 25851, 25595, 25599, 25509, 25591, 25593);

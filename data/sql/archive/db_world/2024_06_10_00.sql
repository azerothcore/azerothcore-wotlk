-- DB update 2024_06_09_02 -> 2024_06_10_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|2 WHERE `entry` = 21958;

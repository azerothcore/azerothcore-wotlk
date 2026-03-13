-- DB update 2024_02_12_02 -> 2024_02_12_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1 WHERE `entry` IN (20033, 20034);

-- DB update 2024_01_05_02 -> 2024_01_05_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |131072 WHERE `entry` = 21875;

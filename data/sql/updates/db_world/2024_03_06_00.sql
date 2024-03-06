-- DB update 2024_03_04_05 -> 2024_03_06_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 1024 WHERE `entry` = 21362;

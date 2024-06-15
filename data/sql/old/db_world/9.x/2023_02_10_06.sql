-- DB update 2023_02_10_05 -> 2023_02_10_06
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 16384 WHERE `entry` IN (17848, 17862, 18096, 20521, 20531, 20535);

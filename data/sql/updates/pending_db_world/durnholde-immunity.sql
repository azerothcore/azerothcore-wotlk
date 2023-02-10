UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 16384 WHERE `entry` IN (17848, 17862, 18096);

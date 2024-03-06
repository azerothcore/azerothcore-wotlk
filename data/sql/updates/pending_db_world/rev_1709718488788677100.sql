--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 1024 WHERE `entry` = 21362;

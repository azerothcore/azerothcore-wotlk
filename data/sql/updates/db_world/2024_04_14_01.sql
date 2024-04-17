-- DB update 2024_04_14_00 -> 2024_04_14_01
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 8 WHERE `entry` IN (17767, 17808, 17888, 17842);
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 4 WHERE `entry` IN (17767, 17808, 17888, 17842);

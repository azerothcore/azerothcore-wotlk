-- DB update 2022_12_06_42 -> 2022_12_06_43
-- 4 rows out of 128 have QuestRequired set to 1. Also increase chances to match Cmangos.
UPDATE `creature_loot_template` SET `QuestRequired`=0, `Chance`=0.5 WHERE `Item` IN (20874, 20875, 20876, 20877, 20878, 20879, 20881, 20882);
-- Increase Large Scarab Coffer pool
UPDATE `pool_template` SET `max_limit`=11 WHERE `entry`=1161 AND `description`='Large Scarab Coffers';

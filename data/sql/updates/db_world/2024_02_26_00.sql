-- DB update 2024_02_25_03 -> 2024_02_26_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~33554432 WHERE `entry` IN (21270, 21274);

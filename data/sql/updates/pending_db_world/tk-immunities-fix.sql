--
UPDATE `creature_template` SET `mechanic_immune_mask` = 0 WHERE `entry` IN (20033, 20034); -- was 1|2048
UPDATE `creature_template` SET `mechanic_immune_mask` = 256|33554432 WHERE `entry` = 20047; -- was 2048

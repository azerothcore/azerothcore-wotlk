-- DB update 2024_03_30_00 -> 2024_03_30_01
--
UPDATE `creature_template_movement` SET `Chase` = 2 WHERE `CreatureId` = 20064;
UPDATE `creature_template` SET `speed_walk` = 2 WHERE `entry` = 20064;

-- DB update 2023_06_17_11 -> 2023_06_17_12
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432 WHERE `entry`=22380;


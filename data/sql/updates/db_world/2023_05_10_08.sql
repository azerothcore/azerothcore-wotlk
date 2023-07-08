-- DB update 2023_05_10_07 -> 2023_05_10_08
--
-- Removes a unused and incorrect creature (not found in brute force)
DELETE FROM `creature_template` WHERE  `entry`=621;

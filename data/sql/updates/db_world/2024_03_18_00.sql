-- DB update 2024_03_17_00 -> 2024_03_18_00
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags`& ~33554432 & ~2 WHERE `entry` BETWEEN 21268 AND 21274;

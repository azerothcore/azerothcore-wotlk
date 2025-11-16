-- DB update 2025_11_15_03 -> 2025_11_15_04
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 256 WHERE `entry` = 24787;

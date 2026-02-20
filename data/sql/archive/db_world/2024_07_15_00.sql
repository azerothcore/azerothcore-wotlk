-- DB update 2024_07_14_04 -> 2024_07_15_00
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 4 WHERE `entry` = 23111;

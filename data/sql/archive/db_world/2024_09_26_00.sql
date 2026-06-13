-- DB update 2024_09_25_03 -> 2024_09_26_00
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432|32768|512|256 WHERE `entry` = 21812;

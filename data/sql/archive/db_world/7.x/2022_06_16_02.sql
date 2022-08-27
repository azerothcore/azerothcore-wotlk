-- DB update 2022_06_16_01 -> 2022_06_16_02
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~33554432 WHERE `entry` = 14467;

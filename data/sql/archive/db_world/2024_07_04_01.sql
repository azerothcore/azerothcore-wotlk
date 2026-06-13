-- DB update 2024_07_04_00 -> 2024_07_04_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` = 8611;

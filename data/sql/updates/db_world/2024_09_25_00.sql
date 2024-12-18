-- DB update 2024_09_24_01 -> 2024_09_25_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|512 WHERE `entry` = 22917;

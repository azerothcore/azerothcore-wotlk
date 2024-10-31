-- DB update 2024_10_31_00 -> 2024_10_31_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` = 23375;

-- DB update 2024_04_13_00 -> 2024_04_14_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |2147483648 WHERE `entry` = 19514;

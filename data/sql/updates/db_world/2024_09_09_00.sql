-- DB update 2024_09_05_00 -> 2024_09_09_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |2147483648 WHERE `entry` = 22841;

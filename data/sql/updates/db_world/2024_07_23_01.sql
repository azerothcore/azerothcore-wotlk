-- DB update 2024_07_23_00 -> 2024_07_23_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` = 22917;

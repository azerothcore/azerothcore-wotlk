-- DB update 2024_08_17_00 -> 2024_08_17_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE `entry` = 22949;

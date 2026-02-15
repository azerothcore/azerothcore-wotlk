-- DB update 2024_06_14_00 -> 2024_06_15_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE `entry` = 22878;

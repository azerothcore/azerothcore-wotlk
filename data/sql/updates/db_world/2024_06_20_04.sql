-- DB update 2024_06_20_03 -> 2024_06_20_04
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE `entry` = 23028;

-- DB update 2024_01_07_03 -> 2024_01_08_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` = 21958;

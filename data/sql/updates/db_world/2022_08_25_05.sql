-- DB update 2022_08_25_04 -> 2022_08_25_05
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` = 15555;

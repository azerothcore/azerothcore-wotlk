-- DB update 2024_06_10_01 -> 2024_06_10_02
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` IN (20040, 20041);

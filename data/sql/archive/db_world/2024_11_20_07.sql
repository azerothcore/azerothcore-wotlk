-- DB update 2024_11_20_06 -> 2024_11_20_07
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`| 256 WHERE `entry` = 23578;

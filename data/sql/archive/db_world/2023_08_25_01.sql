-- DB update 2023_08_25_00 -> 2023_08_25_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry`=17257;


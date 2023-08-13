-- DB update 2023_06_16_00 -> 2023_06_16_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry`=20654;


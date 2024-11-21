-- DB update 2023_06_11_02 -> 2023_06_16_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry`=17552;


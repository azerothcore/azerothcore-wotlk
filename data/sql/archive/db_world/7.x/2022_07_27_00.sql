-- DB update 2022_07_26_06 -> 2022_07_27_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|0x80000000 WHERE `entry` = 15339;

-- DB update 2023_06_09_00 -> 2023_06_11_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE (`entry` = 20317);

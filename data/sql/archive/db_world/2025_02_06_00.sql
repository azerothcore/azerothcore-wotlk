-- DB update 2025_02_05_01 -> 2025_02_06_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` = 24850;

-- DB update 2025_02_22_00 -> 2025_02_24_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|512|2147483648 WHERE `entry` = 25038;

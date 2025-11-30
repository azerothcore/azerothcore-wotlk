-- DB update 2025_03_02_02 -> 2025_03_03_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|536870912 WHERE `entry` = 25038;

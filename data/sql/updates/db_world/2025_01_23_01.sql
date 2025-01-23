-- DB update 2025_01_23_00 -> 2025_01_23_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (24664, 24857);

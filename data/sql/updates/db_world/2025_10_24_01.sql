-- DB update 2025_10_24_00 -> 2025_10_24_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (29306, 31368);

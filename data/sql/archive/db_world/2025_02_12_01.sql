-- DB update 2025_02_12_00 -> 2025_02_12_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (25166, 25165);

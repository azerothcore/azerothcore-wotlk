-- DB update 2024_12_11_00 -> 2024_12_12_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (23574, 23578, 24239);

-- DB update 2025_03_25_01 -> 2025_03_27_00

-- Add Hard Reset Extra Flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (25741);

-- DB update 2024_01_14_12 -> 2024_01_14_13
-- Rotface
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (36627, 38390, 38549, 38550);

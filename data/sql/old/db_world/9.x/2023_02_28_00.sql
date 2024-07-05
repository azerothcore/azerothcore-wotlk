-- DB update 2023_02_27_07 -> 2023_02_28_00
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry` IN (21073, 21097, 21116);

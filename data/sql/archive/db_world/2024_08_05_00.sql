-- DB update 2024_08_02_00 -> 2024_08_05_00
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` = 17968;

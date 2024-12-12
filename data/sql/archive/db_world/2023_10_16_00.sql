-- DB update 2023_10_15_00 -> 2023_10_16_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` = 21216;

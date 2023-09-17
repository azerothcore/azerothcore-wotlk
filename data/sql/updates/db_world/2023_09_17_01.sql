-- DB update 2023_09_17_00 -> 2023_09_17_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE (`entry` = 15689);

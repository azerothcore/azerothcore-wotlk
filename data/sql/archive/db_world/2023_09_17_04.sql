-- DB update 2023_09_17_03 -> 2023_09_17_04
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE (`entry` = 17521);

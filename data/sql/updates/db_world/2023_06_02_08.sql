-- DB update 2023_06_02_07 -> 2023_06_02_08
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE (`entry` IN (20898, 21598));

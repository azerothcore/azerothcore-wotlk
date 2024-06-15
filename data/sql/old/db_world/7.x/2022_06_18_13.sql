-- DB update 2022_06_18_12 -> 2022_06_18_13
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|4194304 WHERE (`entry` = 15163);

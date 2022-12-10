-- DB update 2022_06_16_05 -> 2022_06_16_06
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|4194304 WHERE `entry` = 15261;

-- DB update 2022_05_17_03 -> 2022_05_17_04
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` = 14834;

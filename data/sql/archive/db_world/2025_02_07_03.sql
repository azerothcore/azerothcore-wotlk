-- DB update 2025_02_07_02 -> 2025_02_07_03
-- Setting the 'CREATURE_FLAG_EXTRA_CIVILIAN' flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 2 WHERE `entry` = 27064;

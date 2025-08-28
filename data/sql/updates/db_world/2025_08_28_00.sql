-- DB update 2025_08_27_02 -> 2025_08_28_00
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 1 WHERE `entry` = 28194;

-- DB update 2024_02_12_05 -> 2024_02_13_00
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` = 29521;

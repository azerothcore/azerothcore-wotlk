-- DB update 2024_06_20_08 -> 2024_06_21_00
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 18104);
UPDATE `creature_template` SET `speed_walk` = 2.8, `speed_run` = 1 WHERE (`entry` = 18095);

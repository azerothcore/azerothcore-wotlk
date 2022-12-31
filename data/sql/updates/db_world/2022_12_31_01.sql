-- DB update 2022_12_31_00 -> 2022_12_31_01
--
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.71429 WHERE (`entry` IN (18497, 20299));

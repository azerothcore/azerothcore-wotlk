-- DB update 2023_07_18_02 -> 2023_07_19_00
--
UPDATE `spell_proc_event` SET `ppmRate` = 10 WHERE `entry` = 26480;
UPDATE `spell_proc_event` SET `procFlags` = 68 WHERE `entry` = 26480;

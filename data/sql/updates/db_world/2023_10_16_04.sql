-- DB update 2023_10_16_03 -> 2023_10_16_04
-- Shamanistic Rage PPM 10 -> 18
UPDATE `spell_proc_event` SET `ppmRate` = 18 WHERE `entry` = 30823;

-- DB update 2023_06_17_04 -> 2023_06_17_05
-- Fix Disable LOS from the Spell 26522 (Lunar Fortune) --
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=26522;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES (0, 26522, 64, '', '', 'Disable LOS for Lunar Fortune');

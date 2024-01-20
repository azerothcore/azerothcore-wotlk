-- DB update 2023_10_22_05 -> 2023_10_22_06
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4522;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4522, 'at_karazhan_side_entrance');

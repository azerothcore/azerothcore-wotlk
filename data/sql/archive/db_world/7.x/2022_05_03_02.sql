-- DB update 2022_05_03_01 -> 2022_05_03_02
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4052 AND `ScriptName` = 'at_battleguard_sartura';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4052, 'at_battleguard_sartura');

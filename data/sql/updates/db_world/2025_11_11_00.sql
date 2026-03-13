-- DB update 2025_11_10_03 -> 2025_11_11_00
--
DELETE FROM `areatrigger_scripts` WHERE `entry`=5338;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES(5338, 'at_last_rites');

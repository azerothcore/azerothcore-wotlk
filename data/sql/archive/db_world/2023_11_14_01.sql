-- DB update 2023_11_14_00 -> 2023_11_14_01
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4216;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4216, 'at_karazhan_atiesh_aran');

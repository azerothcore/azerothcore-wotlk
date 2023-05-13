-- DB update 2023_05_13_13 -> 2023_05_13_14
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4347 AND `ScriptName` = 'at_rp_nethekurse'; 
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4347, 'at_rp_nethekurse');

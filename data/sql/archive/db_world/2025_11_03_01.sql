-- DB update 2025_11_03_00 -> 2025_11_03_01

DELETE FROM `areatrigger_scripts` WHERE `entry` = 5338;

DELETE FROM `areatrigger_teleport` WHERE `ID` = 5338;
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5338, 'Naxxanar Top -> Down', 571, 3733.68, 3563.25, 290.812, 3.66519);

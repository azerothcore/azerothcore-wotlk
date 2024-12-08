-- DB update 2023_07_26_02 -> 2023_07_26_03
--
DELETE FROM `areatrigger_teleport` WHERE `ID` = 2068;
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (2068, 'Blackrock Spire - Jump Exit', 0, -7558.39, -1309.43, 248.454, 1.5708);

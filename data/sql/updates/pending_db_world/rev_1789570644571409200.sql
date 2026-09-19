DELETE FROM `areatrigger_teleport` WHERE `ID` IN (5683, 5688);
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5683, 'Halls of Reflection (Entrance from Pit of Saron)', 668, 5239.01, 1932.64, 707.695, 0.800565),
(5688, 'Pit of Saron (Entrance from Forge of Souls)', 658, 435.743, 212.413, 528.709, 6.25646);

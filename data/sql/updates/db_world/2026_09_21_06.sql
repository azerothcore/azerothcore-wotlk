-- DB update 2026_09_21_05 -> 2026_09_21_06
DELETE FROM `areatrigger_teleport` WHERE `ID` IN (5683, 5688);
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5683, 'Halls of Reflection (Entrance from Pit of Saron)', 668, 5239.46, 1932.99, 707.695, 0.785398),
(5688, 'Pit of Saron (Entrance from Forge of Souls)', 658, 432.568, 212.344, 528.709, 0);

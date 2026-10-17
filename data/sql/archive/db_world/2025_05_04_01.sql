-- DB update 2025_05_04_00 -> 2025_05_04_01
-- Embalming Slime
SET @GUID := 128103;
DELETE FROM `creature_formations` WHERE `leaderGUID` = @GUID AND `memberGUID` BETWEEN @GUID AND @GUID+15;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@GUID, @GUID+0, 0, 0, 3, 0, 0),
(@GUID, @GUID+1, 0, 0, 3, 0, 0),
(@GUID, @GUID+2, 0, 0, 3, 0, 0),
(@GUID, @GUID+3, 0, 0, 3, 0, 0),
(@GUID, @GUID+4, 0, 0, 3, 0, 0),
(@GUID, @GUID+5, 0, 0, 3, 0, 0),
(@GUID, @GUID+6, 0, 0, 3, 0, 0),
(@GUID, @GUID+7, 0, 0, 3, 0, 0),
(@GUID, @GUID+8, 0, 0, 3, 0, 0),
(@GUID, @GUID+9, 0, 0, 3, 0, 0),
(@GUID, @GUID+10, 0, 0, 3, 0, 0),
(@GUID, @GUID+11, 0, 0, 3, 0, 0),
(@GUID, @GUID+12, 0, 0, 3, 0, 0),
(@GUID, @GUID+13, 0, 0, 3, 0, 0),
(@GUID, @GUID+14, 0, 0, 3, 0, 0),
(@GUID, @GUID+15, 0, 0, 3, 0, 0);

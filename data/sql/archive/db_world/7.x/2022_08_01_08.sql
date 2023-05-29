-- DB update 2022_08_01_07 -> 2022_08_01_08

SET @GUID :=86939;
DELETE FROM `creature_formations` WHERE `memberGUID` BETWEEN @GUID+0 AND @GUID+71;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(@GUID+0, @GUID+0, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+1, 0, 0, 3, 0, 0),
(@GUID+0, @GUID+2, 0, 0, 3, 0, 0),

(@GUID+3, @GUID+3, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+4, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+5, 0, 0, 3, 0, 0),

(@GUID+6, @GUID+6, 0, 0, 3, 0, 0),
(@GUID+6, @GUID+7, 0, 0, 3, 0, 0),
(@GUID+6, @GUID+8, 0, 0, 3, 0, 0),

(@GUID+9, @GUID+9, 0, 0, 3, 0, 0),
(@GUID+9, @GUID+10, 0, 0, 3, 0, 0),
(@GUID+9, @GUID+11, 0, 0, 3, 0, 0),

(@GUID+12, @GUID+12, 0, 0, 3, 0, 0),
(@GUID+12, @GUID+13, 0, 0, 3, 0, 0),
(@GUID+12, @GUID+14, 0, 0, 3, 0, 0),

(@GUID+15, @GUID+15, 0, 0, 3, 0, 0),
(@GUID+15, @GUID+16, 0, 0, 3, 0, 0),
(@GUID+15, @GUID+17, 0, 0, 3, 0, 0),

(@GUID+18, @GUID+18, 0, 0, 3, 0, 0),
(@GUID+18, @GUID+19, 0, 0, 3, 0, 0),
(@GUID+18, @GUID+20, 0, 0, 3, 0, 0),

(@GUID+21, @GUID+21, 0, 0, 3, 0, 0),
(@GUID+21, @GUID+22, 0, 0, 3, 0, 0),
(@GUID+21, @GUID+23, 0, 0, 3, 0, 0),

(@GUID+24, @GUID+24, 0, 0, 3, 0, 0),
(@GUID+24, @GUID+25, 0, 0, 3, 0, 0),
(@GUID+24, @GUID+26, 0, 0, 3, 0, 0),
(@GUID+24, @GUID+27, 0, 0, 3, 0, 0),

(@GUID+28, @GUID+28, 0, 0, 3, 0, 0),
(@GUID+28, @GUID+29, 0, 0, 3, 0, 0),
(@GUID+28, @GUID+30, 0, 0, 3, 0, 0),
(@GUID+28, @GUID+31, 0, 0, 3, 0, 0),

(@GUID+32, @GUID+32, 0, 0, 3, 0, 0),
(@GUID+32, @GUID+33, 0, 0, 3, 0, 0),
(@GUID+32, @GUID+34, 0, 0, 3, 0, 0),
(@GUID+32, @GUID+35, 0, 0, 3, 0, 0),

(@GUID+36, @GUID+36, 0, 0, 3, 0, 0),
(@GUID+36, @GUID+37, 0, 0, 3, 0, 0),
(@GUID+36, @GUID+38, 0, 0, 3, 0, 0),
(@GUID+36, @GUID+39, 0, 0, 3, 0, 0),

(@GUID+40, @GUID+40, 0, 0, 3, 0, 0),
(@GUID+40, @GUID+41, 0, 0, 3, 0, 0),
(@GUID+40, @GUID+42, 0, 0, 3, 0, 0),
(@GUID+40, @GUID+43, 0, 0, 3, 0, 0),

(@GUID+44, @GUID+44, 0, 0, 3, 0, 0),
(@GUID+44, @GUID+45, 0, 0, 3, 0, 0),
(@GUID+44, @GUID+46, 0, 0, 3, 0, 0),
(@GUID+44, @GUID+47, 0, 0, 3, 0, 0),

(@GUID+48, @GUID+48, 0, 0, 3, 0, 0),
(@GUID+48, @GUID+49, 0, 0, 3, 0, 0),
(@GUID+48, @GUID+50, 0, 0, 3, 0, 0),
(@GUID+48, @GUID+51, 0, 0, 3, 0, 0),

(@GUID+52, @GUID+52, 0, 0, 3, 0, 0),
(@GUID+52, @GUID+53, 0, 0, 3, 0, 0),
(@GUID+52, @GUID+54, 0, 0, 3, 0, 0),
(@GUID+52, @GUID+55, 0, 0, 3, 0, 0),

(@GUID+56, @GUID+56, 0, 0, 3, 0, 0),
(@GUID+56, @GUID+57, 0, 0, 3, 0, 0),
(@GUID+56, @GUID+58, 0, 0, 3, 0, 0),
(@GUID+56, @GUID+59, 0, 0, 3, 0, 0),

(@GUID+60, @GUID+60, 0, 0, 3, 0, 0),
(@GUID+60, @GUID+61, 0, 0, 3, 0, 0),
(@GUID+60, @GUID+62, 0, 0, 3, 0, 0),
(@GUID+60, @GUID+63, 0, 0, 3, 0, 0),

(@GUID+64, @GUID+64, 0, 0, 3, 0, 0),
(@GUID+64, @GUID+65, 0, 0, 3, 0, 0),
(@GUID+64, @GUID+66, 0, 0, 3, 0, 0),
(@GUID+64, @GUID+67, 0, 0, 3, 0, 0),

(@GUID+68, @GUID+68, 0, 0, 3, 0, 0),
(@GUID+68, @GUID+69, 0, 0, 3, 0, 0),
(@GUID+68, @GUID+70, 0, 0, 3, 0, 0),
(@GUID+68, @GUID+71, 0, 0, 3, 0, 0);


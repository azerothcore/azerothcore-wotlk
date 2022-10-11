-- DB update 2022_10_06_00 -> 2022_10_06_01
--
DELETE FROM `disables` WHERE `sourceType`=7 AND `entry`=180619;
INSERT INTO `disables` VALUES
(7,180619,0,0,0,'Ignore LoS by Ossirian Crystal');

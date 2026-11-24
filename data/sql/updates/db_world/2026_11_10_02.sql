-- DB update 2026_11_10_01 -> 2026_11_10_02
--
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (64203, 64235, 64210);
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(0,64203,64,'','','XT-002: ignore LOS for Void Zone'),
(0,64235,64,'','','XT-002: ignore LOS for Void Zone (25)'),
(0,64210,64,'','','XT-002: ignore LOS for Life Spark');

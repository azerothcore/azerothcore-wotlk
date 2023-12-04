-- 21215
SET @CGUID = 153000;

DELETE FROM `creature_addon` WHERE `guid` = @CGUID+139;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(@CGUID+139, 0, 0, 8, 1, '37546');

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+139;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+139, @CGUID+139, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+140, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+141, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+142, 0, 0, 24, 0, 0);

-- 21216
SET @CGUID = 153000;

DELETE FROM `creature` WHERE `guid` = @CGUID+21;
DELETE FROM `creature` WHERE `guid` = @CGUID+20;
DELETE FROM `creature` WHERE `guid` = @CGUID+19;
INSERT INTO `creature` VALUES (@CGUID+21, 21933, 0, 0, 548, 0, 0, 1, 1, 0, -259.13, -356.28, 15.03, 6.04, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 50791, 1, '');
INSERT INTO `creature` VALUES (@CGUID+20, 21933, 0, 0, 548, 0, 0, 1, 1, 0, -218.8, -371.34, 14.608, 2.72, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 50791, 1, '');
INSERT INTO `creature` VALUES (@CGUID+19, 21934, 0, 0, 548, 0, 0, 1, 1, 0, -239.43, -363.48, 12, 1.19093, 604800, 0, 0, 1, 0, 0, 0, 0, 0, '', 50791, 1, '');

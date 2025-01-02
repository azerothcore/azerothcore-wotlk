-- DB update 2023_12_06_00 -> 2023_12_07_00
SET @CGUID = 153000;
-- 21215 Leotheras the Blind
DELETE FROM `creature_addon` WHERE `guid` = @CGUID+139;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(@CGUID+139, 0, 0, 8, 1, '37546');

DELETE FROM `creature_formations` WHERE `leaderGUID` = @CGUID+139;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+139, @CGUID+139, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+140, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+141, 0, 0, 24, 0, 0),
(@CGUID+139, @CGUID+142, 0, 0, 24, 0, 0);

-- 21216 Hydross the Unstable
UPDATE `creature` SET `position_x`= -259.13, `position_y`= -356.28, `position_z`= 15.03, `orientation`=6.04 WHERE `guid` = @CGUID+21;
UPDATE `creature` SET `position_x`= -218.8, `position_y`= -371.34, `position_z`= 14.608, `orientation`=2.72 WHERE `guid` = @CGUID+20;
UPDATE `creature` SET `position_x`= -239.43, `position_y`= -363.48, `position_z`= 12, `orientation`=1.19093 WHERE `guid` = @CGUID+19;

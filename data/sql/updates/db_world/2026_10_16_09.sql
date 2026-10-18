-- DB update 2026_10_16_08 -> 2026_10_16_09
--
SET @CGUID := 52066;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+4 AND `id` = 18855;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+5 AND @CGUID+7 AND `id` = 19421;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0, 18855, 530, 1, 1, 1, 3000.73, 4209.19, 160.967, 1.27409, 300, 0, 0, 0),
(@CGUID+1, 18855, 530, 1, 1, 1, 2986.11, 4237.62, 160.973, 0.593412, 300, 0, 0, 0),
(@CGUID+2, 18855, 530, 1, 1, 1, 2994.08, 4254.48, 160.855, 5.46288, 300, 0, 0, 0),
(@CGUID+3, 18855, 530, 1, 1, 1, 3011.37, 4254.43, 160.945, 4.64258, 300, 0, 0, 0),
(@CGUID+4, 18855, 530, 1, 1, 1, 3031.16, 4226.09, 160.862, 2.63545, 300, 0, 0, 0),
(@CGUID+5, 19421, 530, 1, 1, 0, 3007.84375, 4226.097167, 164.918395, 0.907571196556, 300, 0, 0, 0),
(@CGUID+6, 19421, 530, 1, 1, 0, 3023.403564, 4237.975097, 163.974395, 2.164208173751, 300, 0, 0, 0),
(@CGUID+7, 19421, 530, 1, 1, 0, 3001.016845, 4245.658691, 167.376296, 1.483529806137, 300, 0, 0, 0);

-- Auriaya and Sanctum Sentry: DB-based spawns and creature_formations
SET @CGUID := 137532;
SET @AURI := 137496;
SET @X := 1938.7361;
SET @Y := 42.06429;
SET @Z := 411.5189;
SET @O := 1.818165;

-- Update Auriaya's spawn to sniff position
UPDATE `creature` SET `position_x` = @X, `position_y` = @Y, `position_z` = @Z, `orientation` = @O WHERE `id` = 33515 AND `guid` = @AURI;

-- Add Sanctum Sentry spawns (10-man: 2 sentries, 25-man: 4 sentries)
DELETE FROM `creature` WHERE `id` = 34014 AND `map` = 603;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
-- 10-man sentries
(@CGUID+0, 34014, 603, 0, 0, 1, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0),
(@CGUID+1, 34014, 603, 0, 0, 1, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0),
-- 25-man sentries
(@CGUID+2, 34014, 603, 0, 0, 2, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0),
(@CGUID+3, 34014, 603, 0, 0, 2, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0),
(@CGUID+4, 34014, 603, 0, 0, 2, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0),
(@CGUID+5, 34014, 603, 0, 0, 2, 1, 0, @X, @Y, @Z, @O, 604800, 0, 0, '', 'Sanctum Sentry - follows Auriaya', 0);

-- Set creature_formations: sentries follow Auriaya
DELETE FROM `creature_formations` WHERE `leaderGUID` = 137496;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@AURI, @AURI, 0, 0, 2, 0, 0),
-- 10-man sentries
(@AURI, @CGUID+0, 7.0, 166, 519, 0, 0),
(@AURI, @CGUID+1, 7.0, 194, 519, 0, 0),
-- 25-man sentries
(@AURI, @CGUID+2, 7.0, 166, 519, 0, 0),
(@AURI, @CGUID+3, 7.0, 194, 519, 0, 0),
(@AURI, @CGUID+4, 12.0, 204, 519, 0, 0),
(@AURI, @CGUID+5, 12.0, 152, 519, 0, 0);
